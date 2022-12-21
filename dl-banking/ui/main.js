document.onkeydown = function(event){
    if (event.key == "Escape") {
        closeUI()
    }
};

window.addEventListener("message", function(event) {
    if (event.data.open && event.data.info != undefined) {
        document.getElementById("banking-container").style.display = "block";
        document.getElementById("player-payments").innerHTML = ""

        document.getElementById("character-name").innerHTML = event.data.info.name;
        document.getElementById("character-balance").innerHTML = event.data.info.balance + "$";
        document.getElementById("current-time").innerHTML = event.data.info.time;





        if (JSON.stringify(event.data.info.payments) != "[]") {
            let payments = JSON.parse(event.data.info.payments);

            for (let index = 0; index < payments.length; index++) {
                const element = payments[index];

                let div = document.createElement("div");
                let imgsrc;
                let imgid; 

                if (parseInt(element.money) < 0) {
                    imgsrc = "./minus.png"
                    imgid = "minus"
                    div.innerHTML = element.title + " [" + element.money + "$]"
                } else {
                    imgsrc = "./plus.png"
                    imgid = "plus"
                    div.innerHTML = element.title + " [+" + element.money + "$]"

                }
                let img = document.createElement("img")
                img.src = imgsrc
               // img.id = imgid
               let time = document.createElement("div");
               time.innerHTML = element.time
               time.style.height = "30px"
               time.style.marginBottom = "-7px"
               time.style.lineHeight = "28px"
               time.style.textAlign = "center"
               time.style.textIndent = "-2px"
               time.style.color = "#7B7B7B"
               time.style.fontSize = "15px"
               time.style.textDecoration = "underline"
               // div.appendChild(img)
               document.getElementById("player-payments").appendChild(time)
               document.getElementById("player-payments").appendChild(div)
            }
    
        }


        document.getElementById("free-withdraw-icon").onclick = () => {
            let amount = parseFloat(document.getElementById("free-withdraw").value);
            document.getElementById("free-withdraw").value = ""

            fetch("https://dl-banking/withdraw",{
                method: "POST",
                body: JSON.stringify({
                    withdraw: amount
                })
            })    
        }

        document.getElementById("free-deposit-icon").onclick = () => {
            let amount = parseFloat(document.getElementById("free-deposit").value);
            document.getElementById("free-deposit").value = ""

            fetch("https://dl-banking/deposit",{
                method: "POST",
                body: JSON.stringify({
                    deposit: amount
                })
            })    


        }

        document.getElementById("withdraw-100").onclick = () => {

            fetch("https://dl-banking/withdraw",{
                method: "POST",
                body: JSON.stringify({
                    withdraw: 100
                })
            })    
        }
        document.getElementById("withdraw-500").onclick = () => {

            fetch("https://dl-banking/withdraw",{
                method: "POST",
                body: JSON.stringify({
                    withdraw: 500
                })
            })    
        }
        document.getElementById("withdraw-1000").onclick = () => {

            fetch("https://dl-banking/withdraw",{
                method: "POST",
                body: JSON.stringify({
                    withdraw: 1000
                })
            })    
        }
        document.getElementById("deposit-100").onclick = () => {

            fetch("https://dl-banking/deposit",{
                method: "POST",
                body: JSON.stringify({
                    deposit: 100
                })
            })    
        }


        document.getElementById("deposit-500").onclick = () => {

            fetch("https://dl-banking/deposit",{
                method: "POST",
                body: JSON.stringify({
                    deposit: 500
                })
            })    
        }
        document.getElementById("deposit-1000").onclick = () => {
            document.getElementById("free-deposit").value = ""

            fetch("https://dl-banking/deposit",{
                method: "POST",
                body: JSON.stringify({
                    deposit: 1000
                })
            })    
        }

        

        document.getElementById("send").onclick = () => {
            let amount = document.getElementById("const-actions-price").value
            let id = document.getElementById("const-actions-id").value
            document.getElementById("const-actions-price").value = ""
            document.getElementById("const-actions-id").value = ""

            fetch("https://dl-banking/transfer",{
                method: "POST",
                body: JSON.stringify({
                    transferAmount: amount,
                    pId: id
                })
            })    
        }



    }
    else if (event.data.update) {
        document.getElementById("character-balance").innerHTML = event.data.amount + "$";
    }
    else if (event.data.notify) {

        document.getElementById("notif-container").style.display = "block";
        document.getElementById("notif-text").textContent = event.data.notifyContent

        setTimeout(() => {
            document.getElementById("notif-container").style.display = "none";
            document.getElementById("notif-text").textContent = ""
    
        }, 2 * 1000);
    }
});




function closeUI(){

    document.getElementById("banking-container").style.display = "none"
    fetch("https://dl-banking/close",{
        method: "POST",
        body: JSON.stringify({
            
        })
    })    

}