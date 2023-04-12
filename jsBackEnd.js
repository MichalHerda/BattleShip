//----------------------------------------------------------------------------------------------------------------------------------------------------
function setInitialShipState(shipsRepIdx, shipsList) {
    for(let i = 0; i < back.getArrayIndex(back.shipsNumber, shipsRepIdx); i++) {
        console.log("ships Repeater idx: ", shipsRepIdx)
        console.log("index : ", i)
        let shipCoo = back.getInitialShipCoo (shipsRepIdx + 2, i);
        let shipX = shipCoo.x;
        let shipY = shipCoo.y;
        console.log("ship X from function: ",shipX);
        console.log("ship Y from function: ",shipY);
        shipsList.append({shipX,shipY})
    }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------
function removeShips(kindsOfShipsList) {
    for(let i = 0; i < 5; i++) {
        for(let j = 0; j < back.getArrayIndex(back.shipsNumber, i); j++) {
            console.log("searching Item: ", kindsOfShipsList.get(i).shipsList.get(j) )

            //kindsOfShipsList.get(i).remove;
        }
    }
}
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
