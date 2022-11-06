const Pretest = [
    {question:1, imgsrc:"img/Pretest/E-2014_9-B.png",  options:{A:'X 為 OFF, Y 為 OFF', B:'X 為 OFF, Y 為 ON', C:'X 為 ON, Y 為 OFF', D:'X 為 ON, Y 為 ON'}},
    {question:2, imgsrc:"img/Pretest/D-2015_19-C.png", options:{A:'1', B:'2', C:'3', D:'沒有任何方法能保證獲勝'}}, 
    {question:3, imgsrc:"img/Pretest/E-2015_3-C.png",  options:{A:'A', B:'B', C:'C', D:'D'}},
    {question:4, imgsrc:"img/Pretest/D-2014_1-B.png",  options:{A:'4', B:'5', C:'6', D:'7'}},
    {question:5, imgsrc:"img/Pretest/E-2015_21-B.png", options:{A:'蘋可小姐、伯朗先生、格林太太', B:'伯朗先生、格林太太、蘋可小姐', C:'格林太太、蘋可小姐、伯朗先生', D:'伯朗先生、蘋可小姐、格林太太'}},
    {question:6, imgsrc:"img/Pretest/D-2015_9-D.png", options:{A:'瑟吉使用兩個火爐可以節省 10 分鐘的烹調時間', B:'瑟吉使用兩個火爐可以節省 30 分鐘的烹調時間', C:'瑟吉使用三個火爐可以節省 40 分鐘的烹調時間', D:'瑟吉使用四個火爐可以節省 50 分鐘的烹調時間'}}
];
const Test1 = [
    {question:1, imgsrc:"img/Task1/E-2014_13-C.png", options:{A:'18, 15, 12, 11, 25, 22, 31, 44, 43, 52', B:'52, 43, 44, 31, 22, 25, 11, 12, 15, 18', C:'11, 31, 12, 22, 52, 43, 44, 15, 25, 18', D:'11, 12, 15, 18, 22, 25, 31, 43, 44, 52'}, robot:"C"}, 
    {question:2, imgsrc:"img/Task1/E-2015_11-C.png", options:{A:'5', B:'10', C:'11', D:'12'}, robot:"C"},
    {question:3, imgsrc:"img/Task1/D-2014_27-D.png", options:{A:'6 車次', B:'9 車次', C:'15 車次', D:'18 車次'}, robot:"D"},
    {question:4, imgsrc:"img/Task1/D-2014_29-B.png", options:{A:'2', B:'3', C:'4', D:'5'}, robot:"A"},
    {question:5, imgsrc:"img/Task1/E-2015_4-A.png", options:{A:'4-0', B:'5-0', C:'4-1', D:'3-2'}, robot:"A"},
    {question:6, imgsrc:"img/Task1/D-2015_14-D.png", options:{A:'2', B:'3', C:'5', D:'小強不可能贏'}, robot:"B"}
];
const Test2 = [
    {question:1, imgsrc:"img/Task2/D-2014_7-B.png",  options:{A:'87', B:'85', C:'82', D:'81'}, robot:"A"}, 
    {question:2, imgsrc:"img/Task2/E-2014_15-C.png", options:{A:'9 小時', B:'10 小時', C:'11 小時', D:'12 小時'}, robot:"C"},
    {question:3, imgsrc:"img/Task2/E-2014_18-A.png", options:{A:'abbbaabbccbaaaabbc', B:'aaaaccbbaacaaccccbbaabbc', C:'caaccccaaccccccacccc', D:'acacbcbcbcbcacacbcbcccccbcbcacbcbcc'}, robot:"A"},
    {question:4, imgsrc:"img/Task2/D-2014_26-D.png", options:{A:'8 單位長', B:'9 單位長', C:'10 單位長', D:'11 單位長'}, robot:"C"},
    {question:5, imgsrc:"img/Task2/D-2015_13-B.png", options:{A:'3', B:'4', C:'5', D:'6'}, robot:"D"},
    {question:6, imgsrc:"img/Task2/E-2015_17-C.png", options:{A:'紅', B:'綠', C:'白', D:'洋紅'}, robot:"B"}
];
const questions_set = {
    "pretest":Pretest, 
    "test1":Test1, 
    "test2":Test2
};
const questions = questions_set[document.title];
const has_robot = "robot" in questions[0];

function start() {
    start_time = window.performance.now();
    countdown_timer = setInterval(countdown, 1);
    button.addEventListener("click", click);
    show_question(index);

    document.getElementById("index_page").style.display = "none";
    document.getElementById("test_page").style.display = "";
    document.getElementById("ending_page").style.display = "none";   
}

function show_question() {
    q = questions[index];
    // [LOG] QUESTION
    content += `${window.performance.now()} QUESTION ${q["question"]} \n`;
    console.log(`${window.performance.now()} QUESTION ${q["question"]}`);

    document.getElementById("question").innerText = ` 第 ${q["question"]} 題 `;
    document.getElementById("img").src = q["imgsrc"];
    document.getElementById("label_input_14_1").innerText = q["options"]["A"];
    document.getElementById("label_input_14_2").innerText = q["options"]["B"];
    document.getElementById("label_input_14_3").innerText = q["options"]["C"];
    document.getElementById("label_input_14_4").innerText = q["options"]["D"];

    if(has_robot) {
        document.getElementById("robot").innerHTML = `<div class="row" style="margin: 10px;">
        <img src="img/robot.png" width="50" height="50">
            <div class="msg alert alert-warning" id="msg_id" role="alert"> 機器人認為答案是 ${questions[index]["options"][questions[index]["robot"]]}</div></div>`;
        
        button.classList.remove("btn-success");
        button.classList.add("btn-secondary");
        button.value = "查看機器人提示";
        document.getElementById("robot").style.display = 'none';
    } else {
        button.value = "送出答案";
    }
};

function click() {
    radio_checked = document.querySelector('input[name="radio"]:checked');
    if (radio_checked == null) {return}
    if (button.value == "查看機器人提示") {
        // [LOG] CONFIRM
        content += `${window.performance.now()} CONFIRM ${radio_checked.value} \n`
        console.log(`${window.performance.now()} CONFIRM ${radio_checked.value}`);

        button.classList.remove("btn-secondary");
        button.classList.add("btn-success");
        button.value = "送出答案";
        document.getElementById("robot").style = "";
        return 
    }
    // [LOG] SUBMIT
    content += `${window.performance.now()} SUBMIT ${radio_checked.value} \n`
    console.log(`${window.performance.now()} SUBMIT ${radio_checked.value}`);

    index += 1;
    if (index == questions.length) {return ending();}
    if (has_robot) {
        button.classList.remove("btn-success");
        button.classList.add("btn-secondary");
        button.value = "查看機器人提示";
        document.getElementById("robot").style.display = "none";
    }
    radio_checked.checked = false;
    show_question();
    return
}

function countdown() {
    count = time-(window.performance.now()-start_time);
    if (count <= 0) {
        ending();
        clearInterval(countdown_timer);
    }
    sec = (count/1000)%60;
    min = (count/1000-sec)/60;
    timer.innerText = `${min}:${sec<10?"0":""}${sec|0}`;
}

function ending() {
    // [LOG] FINISHED
    content += `${window.performance.now()} FINISHED \n`
    console.log(`${window.performance.now()} FINISHED`);
    
    // [LOG FILE] 
    logFile();

    document.getElementById("index_page").style.display = "none";
    document.getElementById("test_page").style.display = "none";
    document.getElementById("ending_page").style.display = "";
}

function logFile() {
    const blob = new Blob([content], { type: 'plain/text' });
    const fileUrl = URL.createObjectURL(blob);
    current  = new Date();
    filename = `${(current.getMonth()+1<10)?"0":""}${current.getMonth()+1}${(current.getDate()<10)?"0":""}${current.getDate()}-${(current.getHours()<10)?"0":""}${current.getHours()}${(current.getMinutes()<10)?"0":""}${current.getMinutes()}-${document.title}.txt`;

    const element = document.createElement('a');
    element.setAttribute('href', fileUrl);
    element.setAttribute('download', filename);
    element.style.display = 'none';
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
};

const time = 1200 * 1000;
let button = document.getElementById("submit");
let timer = document.getElementById("timer");
let index = 0;
let content = "";

document.getElementById("start").addEventListener("click", start);