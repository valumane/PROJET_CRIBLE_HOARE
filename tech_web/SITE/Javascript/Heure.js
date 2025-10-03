let now = new Date();
let day = now.getDate();
let month = now.getMonth()+1;
let years = now.getFullYear();
let hours = now.getHours();
let minute = now.getMinutes();


/*affichage de l'heure*/
function displayHour() {

    let language = document.getElementsByTagName("html")[0].lang

    let dateinput = document.getElementById("date");

    let   FrDate  = day + "-" + month + "-" + years + " : " + hours + "h" + minute ;
    let OtherDate = month + "-" + day + "-" + years + " : " + hours + "h" + minute ;


    /*change l'heure en fonction de la langue*/
    if (language==='fr'){
        dateinput.value = FrDate;
        return FrDate;
    } else dateinput.value = OtherDate;
    return OtherDate;

}

/* envoie du mail avec l'heure */
function sendMail() {
    let adress = 'mailto:hello@domain.com?subject='
        + document.getElementById("date").value;

    window.location.href = adress;

    return adress;

}