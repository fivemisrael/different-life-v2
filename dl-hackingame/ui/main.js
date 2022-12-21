
var txt = document.getElementById("loading-text");
var errAudio = document.getElementById("errorAudio");
var pressAudio = document.getElementById("pressAudio");
var fail; 
var win;

var amount;
var distance; 
var spawnNew;
var deleteCurrent;

window.addEventListener('message', function(event) {
    if (event.data.action == "open") {
        fail = false;
        win = false;
        lifeAmount = 3;

        txt.style.display = "block";

        document.getElementById("hacking-minigame").innerHTML = `<a id="amount">0/10</a> <div id="points"></div> <i id="life1" class="fas fa-times-circle"></i><i id="life2" class="fas fa-times-circle"></i><i id="life3" class="fas fa-times-circle"></i>`
        var container = document.getElementById("hacking-container");
        container.style.display = "block"
       
        amount =event.data.amount;
        distance = event.data.distance;
        spawnNew = event.data.timeToSpawnNew;
        deleteCurrent = event.data.timeToDeleteCurrent; 
        
        var amountText = document.getElementById("amount");
        amountText.textContent = "0/" + amount;

    }
    else if (event.data.action == "hide") {
        var container = document.getElementById("hacking-container");
        container.style.display = "none"
    }
});

txt.addEventListener("animationend", function() {

    
    txt.style.display = 'none';
    document.getElementById("hacking-minigame").style.display = 'block';
    drawRandomPoints();


}, false);


let succeededAmount = 0;
let lifeAmount = 3;
function drawRandomPoints() {
    fetch("https://dl-hackingame/finishLoading", {
        method: "POST", 
        body: JSON.stringify({})
    });

    let [lastTop, lastLeft] = [0,0];
    const parent = document.getElementById("points");
    console.log(amount, distance, spawnNew, deleteCurrent)
    for (let index = 0; index <= amount; index++) {
        setTimeout(() => {
            let currentPointChecked = false
            const point = document.createElement("div");
            let [randomTop, randomLeft]= [Math.random() * 80 + 10,  Math.random() * 80 + 10];
            let dis = Math.abs(randomTop - lastTop + randomLeft - lastLeft);
            if (dis < distance) {
                index--;
            }
            point.style.top = randomTop + "%";
            point.style.left = randomLeft + "%";
            point.onclick = () => {
                point.remove();
                succeededAmount++;
                currentPointChecked = true;
                var txt = document.getElementById("amount");
                txt.textContent = succeededAmount + "/" + amount
                pressAudio.play();
                if (succeededAmount == amount && !win) {
                    winHandler();
                    index = amount
                    return;
                }
            } 
            parent.appendChild(point);

            lastTop = randomTop;
            lastLeft = randomLeft;

            setTimeout(() => {
                if (!currentPointChecked && !fail && !win) {

                point.remove();

                if (lifeAmount == 0 && !fail) {
                    var txt = document.getElementById("amount");
                    txt.textContent = "0/10"
                    failHandler()
                    index = amount;
                    errAudio.play();

                    return;

                } else if (lifeAmount == 1) {
                    var lifeElem = document.getElementById("life3");
                    lifeElem.remove()
                    errAudio.play();


                } else if (lifeAmount == 2) {
                    var lifeElem = document.getElementById("life2");
                    lifeElem.remove()

                    errAudio.play();

                } else if (lifeAmount == 3) {
                    var lifeElem = document.getElementById("life1");
                    lifeElem.remove()

                    errAudio.play();

                }

                lifeAmount --;

                }
            }, deleteCurrent * 1000 + 200);

        }, spawnNew * 1000 * (index+1));

    } 
}    

function failHandler() {
    fail = true;



    var failed = document.getElementById("hacking-failed");
    failed.style.display = "block"
    document.getElementById("hacking-minigame").style.display = 'none';
    var container = document.getElementById("hacking-container");
    container.style.display = "none"
    fetch("https://dl-hackingame/finish", {
        method: "POST", 
        body: JSON.stringify({
            status: false
        })
    });

    setTimeout(() => {
        failed.style.display = "none"
    }, 1500);
}
function winHandler() {
    win = true;
    succeededAmount = 0;
    var won = document.getElementById("hacking-success");
    won.style.display = "block"
    document.getElementById("hacking-minigame").style.display = 'none';
    var container = document.getElementById("hacking-container");
    container.style.display = "none"

    fetch("https://dl-hackingame/finish", {
        method: "POST", 
        body: JSON.stringify({
            status: true
        })
    });
    setTimeout(() => {
        won.style.display = "none"
    }, 1500);

}


document.onkeydown = function(evt) { 
    if (evt.key == "Escape") {
        failHandler()
    }
}