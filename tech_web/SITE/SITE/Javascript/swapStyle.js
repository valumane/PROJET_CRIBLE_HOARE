

/**********/
/* Normal */
/**********/
function OffNormal() { /* desactive le style normal*/
    document.styleSheets[1].disabled = true;
}

function OnNormal() { /* active le style normal */
    document.styleSheets[1].disabled = false;
}

/**************/
/* alternatif */
/**************/

function OffAlt() { /* desactive le style alternatif */
    document.styleSheets[0].disabled = true;
}

function OnAlt() { /* active le style alternatif */
    document.styleSheets[0].disabled = false;
}

/***************/
/* interchange */
/***************/

function swapNormToAlt() { /* change le style de normal a alternatif */
    OffNormal(); OnAlt();
}

function swapAltToNorm() { /* change le style d'alternatif a normal*/
    OffAlt(); OnNormal();
}

function swap() { /* change le style entre normal et alternatif */
    if (document.styleSheets[0].disabled === true) {
        swapNormToAlt();
    } else swapAltToNorm();
}