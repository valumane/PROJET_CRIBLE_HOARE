let inputQuestion = document.getElementsByTagName("input"); /* cible de l'input (plus cours) */

function afficher(nb){ /*affhichage de la qui dit que l'user a pas remplis une case*/
    let tmp = document.getElementsByClassName("hidden")[nb].style;
    tmp.display="initial"
    tmp.color="red"
    tmp.font="12pt"
}

/************************/
/* verifie les reponses */
/************************/

function checkAllTest() {   /* test si tout est bien rempli*/
    let buttonReponse = document.getElementById("reponses");

    checkResponsesQ1(); checkResponsesQ2(); checkResponsesQ3();
    if (checkResponsesQ1() === true && checkResponsesQ2() === true && checkResponsesQ3() === true) {
        buttonReponse.style.display = "initial"; /* si tout est rempli on peut afficher le bouton pour voir les reponses */
        document.getElementById("envoie").style.display="initial";
        document.getElementById("resreponse").style.display="initial";
    }

}


function checkResponsesQ1() { /*regarde si l'user a donné une reponse a la question 1*/
    let q1 = inputQuestion[0].value;
    let hide = document.getElementsByClassName("hidden")[0].style;
    
    if (q1 === "") {
        afficher(0)
        return false
    } else hide.display = "none"; return true /* si il a remplit on cache le text disant qu'il a pas rempli */
}

function checkResponsesQ2() {  /*regarde si l'user a donné une reponses a la question 2*/
    let q2 = inputQuestion[1].value;
    let hide = document.getElementsByClassName("hidden")[1].style;
    if (q2 === "") {
        afficher(1)
        return false
    } else hide.display = "none"; return true /* si il a remplit on cache le text disant qu'il a pas rempli */
}

function checkResponsesQ3() {   /*regarde si l'user a donné une reponses a la question 3*/
    let q3 = inputQuestion[2].value;
    let hide = document.getElementsByClassName("hidden")[2].style;
    if (q3 === "") {
        afficher(2)
        return false
    } else hide.display = "none"; return true  /* si il a remplit on cache le text disant qu'il a pas rempli */
}


/*reset le formulaire*/
function erase() {
    for (i = 0; i < 4; i++) { /* reset les input */
        inputQuestion[i].value = ""
    }

    for (i = 0; i < 3; i++) { /*enlève les phrases disant qu'il a pas répondu*/
        document.getElementsByClassName("hidden")[i].style.display = "none"
    }

    document.getElementById("r").style.display = "none"; /*enleve le bouton reponses*/
    document.getElementById("reponses").style.display = "none"; /*enleve les reponses*/
    document.getElementById("envoie").style.display="none"; /*enleve le bouton d'envoie*/
    document.getElementById("resreponse").style.display="none"; /*enleve le bouton de previsualisation*/
    document.getElementById("resume").style.display="none" /*enleve la previsualitation*/
}

/*bouton pour afficher les reponses*/
function ViewReponse() {
    if (checkResponsesQ1() === true && checkResponsesQ2() === true && checkResponsesQ3() === true && document.getElementById('r').style.display==="none") {
        document.getElementById("r").style.display = "initial";
    } else document.getElementById("r").style.display = "none"
}
function viewResumer() {
    if ( document.getElementById("resume").style.display ==="none"){
        document.getElementById("resume").style.display="initial"
    }else document.getElementById("resume").style.display="none"
}

function resume(){
    document.getElementById("qe1").value = document.getElementById("q1").value;
    document.getElementById("qe2").value = document.getElementById("q2").value;
    document.getElementById("qe3").value = document.getElementById("q3").value;
}