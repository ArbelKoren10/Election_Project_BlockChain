// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract BalToken {
    // 1. המאפיינים של המטבע שלנו
    string public name = "BalToken";   // השם המלא
    string public symbol = "BAL";      // הקיצור (כמו $)
    uint8 public decimals = 18;        // כמה אפסים אחרי הנקודה (стандарт)
    uint256 public totalSupply;        // כמה מטבעות יש בסך הכל בעולם

    // 2. ספר החשבונות (הבנק)
    // המשתנה הזה הוא כמו טבלת אקסל שמחזיקה: כתובת ארנק -> כמה כסף יש לו
    mapping(address => uint256) public balanceOf;

    // 3. אירוע (הודעה לבלוקצ'יין)
    // בכל פעם שמישהו מעביר כסף, אנחנו "צועקים" לבלוקצ'יין שקרתה העברה
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 4. הבנאי - הפונקציה שרצה רק פעם אחת כשיוצרים את המטבע
    constructor() {
        // אנחנו מחליטים שיהיו מיליון מטבעות סך הכל
        totalSupply = 1000000 * 10 ** uint256(decimals);
        
        // נותנים את כל המטבעות למי שיצר את החוזה (לך - האדמין)
        balanceOf[msg.sender] = totalSupply;
    }

    // 5. הפונקציה להעברת כסף (הלב של המטבע)
    // הפונקציה מקבלת: למי להעביר (_to) וכמה להעביר (_value)
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // בדיקה א': האם לשולח (msg.sender) יש בכלל מספיק כסף?
        require(balanceOf[msg.sender] >= _value, "Not enough money");

        // ביצוע ההעברה (מתמטיקה פשוטה)
        balanceOf[msg.sender] -= _value; // תחסיר מהשולח
        balanceOf[_to] += _value;        // תוסיף למקבל

        // רישום האירוע ביומן של הבלוקצ'יין
        emit Transfer(msg.sender, _to, _value);

        return true; // הפעולה הצליחה
    }
}