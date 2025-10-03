let all_img = document.getElementsByClassName("img")

/***********************/
/* affichage des images*/
/***********************/

function chargeImg(id) { /* affiche une image */
    if (all_img[id].style.display === "none") {
        all_img[id].style.display = "initial";
    } else all_img[id].style.display = "none";
}

function charge_all_img(){ /* affiche toutes les images */
    let nbr_img = document.getElementsByClassName("img").length;
    for ( let i = 0; i < nbr_img;i++){
        all_img[i].style.display = "initial";
    }
}

function uncharge_all_img(){ /*cache toute les images*/
    let nbr_img = document.getElementsByClassName("img").length;
    for ( let i = 0; i < nbr_img;i++){
        all_img[i].style.display = "none";
    }
}

function charged(){ /* regarde si il y au minimum une image de non affiché*/
    let nbr_img = document.getElementsByClassName("img").length;
    let vf = false;
    for (let i = 0 ; i < nbr_img ; i++){
        if(all_img[i].style.display === "initial"){
            vf = true
        }
    }
    return vf;
}

function chargeall(){ /* affiche / cache toute les images*/
    if(charged() === false){
        charge_all_img()
    }else uncharge_all_img()
}

/**************************************/
/* modification de la taille des images*/
/**************************************/

function size(id){ /*change individuellement la taille d'une image*/
    if(document.getElementsByClassName("img")[id].style.width === "100px"){
        document.getElementsByClassName("img")[id].style.width = "1000px"
    }else document.getElementsByClassName("img")[id].style.width = "100px"
}


function upscall_all() { /* agrandis toutes les images */
    let nbr_img = document.getElementsByClassName("img").length;
    for (let i = 0; i < nbr_img; i++) {
        all_img[i].style.width = "1000px";
    }
}

function downscall_all(){ /* diminue toute les images */
    let nbr_img = document.getElementsByClassName("img").length;
    for ( let i = 0; i < nbr_img;i++){
        all_img[i].style.width = "100px";
    }
}

function sized(){ /* regarde si il y a au minimum une image de pas agrandis*/
    let nbr_img = document.getElementsByClassName("img").length;
    let vf = false;
    for (let i = 0 ; i < nbr_img ; i++){
        if(all_img[i].style.width === "1000px"){
            vf = true
        }
    }
    return vf;
}

function sizeAll(){ /* agrandis / diminue toute les images*/
    if(sized() === false){
        upscall_all()
    }else downscall_all()
}