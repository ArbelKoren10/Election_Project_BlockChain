// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IBalToken {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract Election {
    
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        uint[3] opinions; 
    }

    address public admin;
    bool public electionStarted;
    uint public electionEndTime;
    bytes32 public merkleRoot;
    
    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    IBalToken public token;
    uint public rewardAmount;

    constructor(address _tokenAddress) {
        admin = msg.sender;
        electionStarted = false;
        token = IBalToken(_tokenAddress);
        rewardAmount = 10 * 10**18; 
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can do this");
        _;
    }

    function addCandidate(string memory _name, uint[3] memory _opinions) public onlyAdmin {
        require(!electionStarted, "Cannot add candidate after election started");
        candidates.push(Candidate(candidates.length, _name, 0, _opinions));
    }

    function setMerkleRoot(bytes32 _root) public onlyAdmin {
        merkleRoot = _root;
    }

    function startElection(uint _durationInMinutes) public onlyAdmin {
        require(!electionStarted, "Election already started");
        require(merkleRoot != 0, "Voter list (Merkle Root) not set!");
        
        electionStarted = true;
        electionEndTime = block.timestamp + (_durationInMinutes * 1 minutes);
    }

    function vote(uint _candidateId, bytes32[] memory _proof) public {
        require(electionStarted, "Election has not started");
        require(block.timestamp < electionEndTime, "Election has ended");
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_candidateId < candidates.length, "Invalid candidate");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(verify(_proof, leaf), "You are not in the voter list!");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        require(token.transfer(msg.sender, rewardAmount), "Reward transfer failed");
    }

    function verify(bytes32[] memory proof, bytes32 leaf) internal view returns (bool) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];
            if (computedHash < proofElement) {
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }
        return computedHash == merkleRoot;
    }

    function getCandidatesCount() public view returns (uint) {
        return candidates.length;
    }
    
    function getCandidate(uint _index) public view returns (uint, string memory, uint, uint[3] memory) {
        Candidate memory c = candidates[_index];
        return (c.id, c.name, c.voteCount, c.opinions);
    }

    // --- פונקציית עזר לחישוב נתונים לטסט ---
    // הפונקציה הזו תייצר עבורך את ה-Root וה-Proof שמתאימים בול לכתובת שלך!
    function getTestRootAndProof() public view returns (bytes32 root, bytes32[] memory proof) {
        // אנחנו מדמים רשימה של שני אנשים: אתה, ועוד כתובת דמיונית
        bytes32 leafUser = keccak256(abi.encodePacked(msg.sender));
        bytes32 leafDummy = keccak256(abi.encodePacked(address(0x123)));
        
        // יצירת ההוכחה (השכן שלך)
        proof = new bytes32[](1);
        proof[0] = leafDummy;

        // חישוב השורש
        if (leafUser < leafDummy) {
            root = keccak256(abi.encodePacked(leafUser, leafDummy));
        } else {
            root = keccak256(abi.encodePacked(leafDummy, leafUser));
        }
        return (root, proof);
    }
}