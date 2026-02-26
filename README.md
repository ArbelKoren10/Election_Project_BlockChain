
---

# מערכת בחירות מבוזרת 2026 (Decentralized Election System)

**מגיש:** ארבל קורן 

**מהות הפרויקט:** פרויקט גמר בקורס בלוקצ'יין 

## סקירה כללית

מערכת זו היא פתרון לבחירות דיגיטליות שקופות, אמינות ובלתי ניתנות לשינוי, המבוססת על רשת ה-Ethereum. המערכת משלבת חוזים חכמים לניהול תהליך ההצבעה ויצירת תמריצים כלכליים למצביעים. 

## 🚀 תכונות עיקריות

* 
**הצבעה מבוזרת:** ניהול בחירות מאובטח ללא גורם מרכזי באמצעות Solidity. 


* 
**אימות זכאות (Merkle Tree):** שימוש בהוכחות Merkle כדי לוודא שרק כתובות מאושרות יכולות להצביע מבלי לחשוף את כל רשימת הבוחרים ב-Chain. 


* 
**מערכת תמריצים (Incentive):** כל מצביע מקבל אוטומטית 10 מטבעות BAL לאחר ביצוע ההצבעה. 


* 
**אלגוריתם "הבחירה החכמה":** מנגנון המסייע למצביעים מתלבטים למצוא את המועמד המתאים להם ביותר על סמך העדפות אישיות. 


* 
**ממשק משתמש (Frontend):** חיבור מלא ל-MetaMask, הצגת יתרת מטבעות בזמן אמת וטיימר לסיום הבחירות. 



## 🛠 טכנולוגיות

* 
**Smart Contracts:** Solidity (^0.8.19). 


* 
**Frontend:** HTML5 ו-Web3.js. 


* 
**Network:** מותאם לרשת הבדיקה Sepolia. 


* 
**Wallet:** אינטגרציה עם MetaMask. 



## 📜 פירוט החוזים החכמים

### 1. BalToken.sol (ERC20)

מטבע דיגיטלי בתקן סטנדרטי המשמש כתגמול למצביעים. 

* 
**שם המטבע:** BalToken 


* 
**סימול:** BAL 


* 
**אספקה כוללת:** 1,000,000 מטבעות (עם 18 ספרות אחרי הנקודה). 



### 2. Election.sol (Core Logic)

החוזה המרכזי המנהל את הלוגיקה של הבחירות. 

* 
**ניהול מועמדים:** האדמין יכול להוסיף מועמדים עם דירוג דעות בנושאים שונים (1-10). 


* 
**תהליך ההצבעה:** בדיקת זכאות באמצעות Merkle Root, אימות חלון זמן הצבעה ורישום הקול. 



## 🤖 אלגוריתם הבוט החכם

המערכת מחשבת "מרחק" מתמטי בין דעות הבוחר לדעות המועמד ב-3 נושאים שונים. 
הנוסחה לחישוב הציון:


$$score=\sum_{i=1}^{3}|UserOp_{i}-candOp_{i}|$$

המערכת תמליץ על המועמד עם הציון הנמוך ביותר (התאמה מקסימלית). 

## ⚠️ מגבלות ובאגים ידועים

* 
**חיסכון ב-Gas:** כרגע חישוב ה-Root וה-Proof מתבצע בתוך החוזה (On-chain) לצורך הדגמה, אך בפרודקשן מומלץ לבצע זאת Off-chain. 


* **מיון תוצאות:** המועמדים מוצגים לפי סדר הוספתם; מיון לפי פופולריות דורש טיפול בצד הלקוח. 


* 
**אבטחה:** לשימוש מבצעי חובה להשתמש בארנק MultiSig לניהול המערכת. 



## 💻 הוראות הרצה מהירות

1. בצעו Deploy לחוזה `BalToken`. 


2. בצעו Deploy לחוזה `Election` עם כתובת הטוקן שנוצרה. 


3. העבירו תקציב של מטבעות BAL לחוזה הבחירות. 


4. עדכנו את כתובות החוזים בקובץ `index.html`. 


5. הריצו את ה-Frontend באמצעות Live Server. 



---

