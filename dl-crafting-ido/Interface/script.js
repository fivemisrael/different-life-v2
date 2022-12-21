document.onkeydown = function(event){
    if (event.key == "Escape") {
        closeUI();
    }
};
let craftingPanelObj = document.getElementById("crafting-panel")

let categoriesNavbar = ["","","",""]
function closeUI(){
    craftingPanelObj.animate([
        { opacity: '1' },
        { opacity: '0' }
      ], {
        duration: 200,
        iterations: 1
      });

    craftingPanelObj.style.opacity = "0"
    fetch("https://dl-crafting-ido/close",{
        method: "POST",
        body: JSON.stringify({
        })
    }); 
}

window.addEventListener("message", function(event) {


    let messageInfo = event.data;
    if (messageInfo.close) {
        craftingPanelObj.animate([
            { opacity: '1' },
            { opacity: '0' }
          ], {
            duration: 200,
            iterations: 1
        });
        craftingPanelObj.style.opacity = "0"
    }
    if (messageInfo.openCrafting) {
        let parsed;
        document.getElementById("main-craft-section").style.display = "block"
        craftingPanelObj.animate([
            // keyframes
            { opacity: '0' },
            { opacity: '1' }
          ], {
            // timing options
            duration: 200,
            iterations: 1
          });
          craftingPanelObj.style.opacity = "1"
          document.getElementById("item-actions").style.opacity = "0"
        categoriesNavbar = ["", "", "", ""]
        if (JSON.stringify(messageInfo.craftableItems) != "[]") {
            parsed = JSON.parse(messageInfo.craftableItems)
            if (document.getElementById("items-navigation"))
            document.getElementById("items-navigation").remove()

            for (let index = 0; index < parsed.length; index++) {
                const element = parsed[index];
                switch (element.category) {
                    case "attachments":
                        if (messageInfo.playerMetadata == element.minimumMetadata || messageInfo.playerMetadata >= element.minimumMetadata) {
                            categoriesNavbar[0] = categoriesNavbar[0] + "<div data-id='" + index + "' class='clickable-nav-div'>"+ element.name + "</div>"
                        } else {
                            categoriesNavbar[0] = categoriesNavbar[0] + ` <div style="color: transparent;" class="locked"></div>`

                        }
                        break;
                    case "magazins":
                        if (messageInfo.playerMetadata == element.minimumMetadata || messageInfo.playerMetadata >= element.minimumMetadata) {
                            categoriesNavbar[1] = categoriesNavbar[1] + "<div data-id='" + index + "' class='clickable-nav-div'>"+ element.name + "</div>"
                        } else {
                            categoriesNavbar[1] = categoriesNavbar[1] + ` <div style="color: transparent;" class="locked"></div>`

                        }
                        break;
                    case "weapons":
                        if (messageInfo.playerMetadata == element.minimumMetadata || messageInfo.playerMetadata >= element.minimumMetadata) {
                            categoriesNavbar[2] = categoriesNavbar[2] + "<div data-id='" + index + "' class='clickable-nav-div'>"+ element.name + "</div>"
                        } else {
                            categoriesNavbar[2] = categoriesNavbar[2] + ` <div style="color: transparent;" class="locked"></div>`

                        }
                        break;
                    case "tools": 
                    if (messageInfo.playerMetadata == element.minimumMetadata || messageInfo.playerMetadata >= element.minimumMetadata) {
                        categoriesNavbar[3] = categoriesNavbar[3] + "<div data-id='" + index + "' class='clickable-nav-div'>"+ element.name + "</div>"
                        } else {
                            categoriesNavbar[3] = categoriesNavbar[3] + ` <div style="color: transparent;" class="locked"></div>`

                        }
                        break;
                    default:
                        break;
                }  

            }                    


            document.getElementById("attachments").onclick = () => {
                
                if (document.getElementById("item-actions") != undefined) {
                    document.getElementById("item-actions").remove()
                }
                if (document.getElementById("items-navigation") != undefined) {
                    document.getElementById("items-navigation").remove()
                } 

                document.getElementById("main-craft-section").style.display = "none"
                let attachmentsDiv =    document.createElement("div")
                let attachmentsNav = document.createElement("div")
                attachmentsNav.id = "items-navigation"
                attachmentsNav.innerHTML = categoriesNavbar[0]
                attachmentsDiv.appendChild(attachmentsNav);
                document.getElementById("crafting-panel").appendChild(attachmentsDiv)

                let navDivs = document.querySelectorAll(".clickable-nav-div");
                for (var i = 0; i < navDivs.length; i++) {
                    let div = navDivs[i]
                    div.onclick = () => {
                        if (document.getElementById("item-actions") != undefined) {
                            document.getElementById("item-actions").remove()
                        }        
                        let mainDiv = document.createElement("div")
                        mainDiv.id = "item-actions"
                        mainDiv.style.opacity = "1"

                        let givenFromBreak = document.createElement("div")
                        givenFromBreak.id = "item-required-tobreak"
                        givenFromBreak.innerHTML = `<h1>ITEM GIVEN:</h1>`

                        let requiredToCraft = document.createElement("div")
                        requiredToCraft.id = "item-required-tocraft"
                        requiredToCraft.innerHTML = `<h1>ITEM REQUIRED:</h1>`

                        let breakItems = document.createElement("div")
                        breakItems.id = "items"
                        let craftItems = document.createElement("div")
                        craftItems.id = "items"

                        let breakJSON = parsed[div.dataset.id].breakInto;
                        let craftJSON = parsed[div.dataset.id].craft;
                        for (let index = 0; index < breakJSON.length; index++) {
                            const element = breakJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            if (element[2]) {
                                htmlElement.innerText = element[1] + "-" + element[2] +  "x " +  element[0] + ","

                            }
                            breakItems.appendChild(htmlElement);   
                        }
                        for (let index = 0; index < craftJSON.length; index++) {
                            const element = craftJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            craftItems.appendChild(htmlElement);   
                        }

                        let craftItemButton = document.createElement("div")
                        craftItemButton.id = "action-button"
                        craftItemButton.innerText = "Craft"
                        craftItemButton.style.backgroundColor = "green"
                        
                        let breakItemButton = document.createElement("div")
                        breakItemButton.id = "action-button"
                        breakItemButton.innerText = "Break"



                        breakItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/breakItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            }); 
                        }
                        craftItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/craftItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            });                         
                        }

                        breakItems.appendChild(breakItemButton);
                        craftItems.appendChild(craftItemButton);

                        givenFromBreak.appendChild(breakItems)
                        requiredToCraft.appendChild(craftItems)
                        mainDiv.appendChild(givenFromBreak)
                        mainDiv.appendChild(requiredToCraft)
                        document.getElementById("screen").appendChild(mainDiv);
    
                    }
                }

    
    
            }
            
            document.getElementById("magazins").onclick = () => {
                

                if (document.getElementById("item-actions") != undefined) {
                    document.getElementById("item-actions").remove()
                }
                if (document.getElementById("items-navigation") != undefined) {
                    document.getElementById("items-navigation").remove()
                } 

                document.getElementById("main-craft-section").style.display = "none"
                let magazinsDiv =    document.createElement("div")
                let magazinsNav = document.createElement("div")
                magazinsNav.id = "items-navigation"

                magazinsNav.innerHTML = categoriesNavbar[1]
                
                magazinsDiv.appendChild(magazinsNav);
                document.getElementById("crafting-panel").appendChild(magazinsDiv)

                let navDivs = document.querySelectorAll(".clickable-nav-div");
                for (var i = 0; i < navDivs.length; i++) {
                    let div = navDivs[i]
                    div.onclick = () => {
                        if (document.getElementById("item-actions") != undefined) {
                            document.getElementById("item-actions").remove()
                        }        

                        let mainDiv = document.createElement("div")
                        mainDiv.id = "item-actions"
                        mainDiv.style.opacity = "1"


                        let givenFromBreak = document.createElement("div")
                        givenFromBreak.id = "item-required-tobreak"
                        givenFromBreak.innerHTML = `<h1>ITEM GIVEN:</h1>`

                        let requiredToCraft = document.createElement("div")
                        requiredToCraft.id = "item-required-tocraft"
                        requiredToCraft.innerHTML = `<h1>ITEM REQUIRED:</h1>`

                        let breakItems = document.createElement("div")
                        breakItems.id = "items"
                        let craftItems = document.createElement("div")
                        craftItems.id = "items"


                        let breakJSON = parsed[div.dataset.id].breakInto;
                        let craftJSON = parsed[div.dataset.id].craft;
                        for (let index = 0; index < breakJSON.length; index++) {
                            const element = breakJSON[index];
                            let htmlElement = document.createElement("div")

                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            if (element[2]) {
                                htmlElement.innerText = element[1] + "-" + element[2] +  "x " +  element[0] + ","

                            }
                            
                            breakItems.appendChild(htmlElement);   
                        }
                        for (let index = 0; index < craftJSON.length; index++) {
                            const element = craftJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            craftItems.appendChild(htmlElement);   
                        }

                        let craftItemButton = document.createElement("div")
                        craftItemButton.id = "action-button"
                        craftItemButton.innerText = "Craft"
                        craftItemButton.style.backgroundColor = "green"
                        
                        let breakItemButton = document.createElement("div")
                                                breakItemButton.id = "action-button"
                        breakItemButton.innerText = "Break"



                        breakItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/breakItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            }); 
                        }
                        craftItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/craftItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            });          

                        }


                        breakItems.appendChild(breakItemButton);
                        craftItems.appendChild(craftItemButton);

                        givenFromBreak.appendChild(breakItems)
                        requiredToCraft.appendChild(craftItems)
                        mainDiv.appendChild(givenFromBreak)
                        mainDiv.appendChild(requiredToCraft)
                        document.getElementById("screen").appendChild(mainDiv);
    
                    }
                }
    
            }
            
            
            document.getElementById("weapons").onclick = () => {

                

                if (document.getElementById("item-actions") != undefined) {
                    document.getElementById("item-actions").remove()
                }
                if (document.getElementById("items-navigation") != undefined) {
                    document.getElementById("items-navigation").remove()
                } 

                document.getElementById("main-craft-section").style.display = "none"
                let weaponsDiv =    document.createElement("div")
                let weaponsNav = document.createElement("div")
                weaponsNav.id = "items-navigation"
                weaponsNav.innerHTML = categoriesNavbar[2]
                weaponsDiv.appendChild(weaponsNav);
                document.getElementById("crafting-panel").appendChild(weaponsDiv)

                let navDivs = document.querySelectorAll(".clickable-nav-div");
                for (var i = 0; i < navDivs.length; i++) {
                    let div = navDivs[i]
                    div.onclick = () => {
                        if (document.getElementById("item-actions") != undefined) {
                            document.getElementById("item-actions").remove()
                        }        

                        let mainDiv = document.createElement("div")
                        mainDiv.id = "item-actions"
                        mainDiv.style.opacity = "1"


                        let givenFromBreak = document.createElement("div")
                        givenFromBreak.id = "item-required-tobreak"
                        givenFromBreak.innerHTML = `<h1>ITEM GIVEN:</h1>`

                        let requiredToCraft = document.createElement("div")
                        requiredToCraft.id = "item-required-tocraft"
                        requiredToCraft.innerHTML = `<h1>ITEM REQUIRED:</h1>`

                        let breakItems = document.createElement("div")
                        breakItems.id = "items"
                        let craftItems = document.createElement("div")
                        craftItems.id = "items"


                        
                        let breakJSON = parsed[div.dataset.id].breakInto;
                        let craftJSON = parsed[div.dataset.id].craft;
                        for (let index = 0; index < breakJSON.length; index++) {
                            const element = breakJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            if (element[2]) {
                                htmlElement.innerText = element[1] + "-" + element[2] +  "x " +  element[0] + ","

                            }

                            breakItems.appendChild(htmlElement);   
                        }
                        for (let index = 0; index < craftJSON.length; index++) {
                            const element = craftJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            craftItems.appendChild(htmlElement);   
                        }
                        if (craftJSON.length > 0) {
                            let craftItemButton = document.createElement("div")
                            craftItemButton.id = "action-button"
                            craftItemButton.innerText = "Craft"
                            craftItemButton.style.backgroundColor = "green"
                            
                            craftItems.appendChild(craftItemButton);

                            craftItemButton.onclick = () => {
                                fetch("https://dl-crafting-ido/craftItem",{
                                    method: "POST",
                                    body: JSON.stringify({
                                        id: div.dataset.id
                                    })
                                });                         
                            }
    
                        }
                        let breakItemButton = document.createElement("div")
                        breakItemButton.id = "action-button"
                        breakItemButton.innerText = "Break"

                        breakItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/breakItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            }); 
                        }


                        breakItems.appendChild(breakItemButton);

                        givenFromBreak.appendChild(breakItems)
                        requiredToCraft.appendChild(craftItems)
                        mainDiv.appendChild(givenFromBreak)
                        mainDiv.appendChild(requiredToCraft)
                        document.getElementById("screen").appendChild(mainDiv);
    
                    }
                }
    
            }

            document.getElementById("tools").onclick = () => {
                

                if (document.getElementById("item-actions") != undefined) {
                    document.getElementById("item-actions").remove()
                }
                if (document.getElementById("items-navigation") != undefined) {
                    document.getElementById("items-navigation").remove()
                } 

                document.getElementById("main-craft-section").style.display = "none"
                let toolsDiv =    document.createElement("div")
                let toolsNav = document.createElement("div")
                toolsNav.id = "items-navigation"
                toolsNav.innerHTML = categoriesNavbar[3]
                toolsDiv.appendChild(toolsNav);
                document.getElementById("crafting-panel").appendChild(toolsDiv)

                let navDivs = document.querySelectorAll(".clickable-nav-div");
                console.log(navDivs.length)
                for (var i = 0; i < navDivs.length; i++) {
                    let div = navDivs[i]
                    console.log(div)
                    div.onclick = () => {
                        if (document.getElementById("item-actions") != undefined) {
                            document.getElementById("item-actions").remove()
                        }        

                        let mainDiv = document.createElement("div")
                        mainDiv.id = "item-actions"
                        mainDiv.style.opacity = "1"


                        let givenFromBreak = document.createElement("div")
                        givenFromBreak.id = "item-required-tobreak"
                        givenFromBreak.innerHTML = `<h1>ITEM GIVEN:</h1>`

                        let requiredToCraft = document.createElement("div")
                        requiredToCraft.id = "item-required-tocraft"
                        requiredToCraft.innerHTML = `<h1>ITEM REQUIRED:</h1>`

                        let breakItems = document.createElement("div")
                        breakItems.id = "items"
                        let craftItems = document.createElement("div")
                        craftItems.id = "items"


                        let breakJSON = parsed[div.dataset.id].breakInto;
                        let craftJSON = parsed[div.dataset.id].craft;
                        for (let index = 0; index < breakJSON.length; index++) {
                            const element = breakJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            if (element[2]) {
                                htmlElement.innerText = element[1] + "-" + element[2] +  "x " +  element[0] + ","

                            }

                            breakItems.appendChild(htmlElement);   
                        }
                        for (let index = 0; index < craftJSON.length; index++) {
                            const element = craftJSON[index];
                            let htmlElement = document.createElement("div")
                            htmlElement.innerText = element[1] + "x " +  element[0] + ","
                            craftItems.appendChild(htmlElement);   
                        }

                        let craftItemButton = document.createElement("div")
                        craftItemButton.id = "action-button"
                        craftItemButton.innerText = "Craft"
                        craftItemButton.style.backgroundColor = "green"
                        
                        let breakItemButton = document.createElement("div")
                                                breakItemButton.id = "action-button"
                        breakItemButton.innerText = "Break"



                        breakItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/breakItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            }); 
                        }
                        craftItemButton.onclick = () => {
                            fetch("https://dl-crafting-ido/craftItem",{
                                method: "POST",
                                body: JSON.stringify({
                                    id: div.dataset.id
                                })
                            });                         
                        }


                        breakItems.appendChild(breakItemButton);
                        craftItems.appendChild(craftItemButton);

                        givenFromBreak.appendChild(breakItems)
                        requiredToCraft.appendChild(craftItems)
                        mainDiv.appendChild(givenFromBreak)
                        mainDiv.appendChild(requiredToCraft)
                        document.getElementById("screen").appendChild(mainDiv);
    
                    }
                }
    
            }


        }

    }
})