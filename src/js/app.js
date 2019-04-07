import 'jquery'; 
import 'bootstrap'; 
import 'inputmask'; 
 
import '../sass/app.scss'; 
 
const Inputmask = require('inputmask'); 
 
$(document).ready(function() 
{ 
    Inputmask().mask(document.querySelectorAll("input"));    
 
    const QRCode = require('qrcode'); 
    const qrCanvas = document.querySelector('#qrCanvas'); 
    if (qrCanvas != null) 
    { 
        const qrURL = qrCanvas.getAttribute('data-qrURL'); 
        QRCode.toCanvas(qrCanvas, qrURL, function(error){ 
            if (error) console.error(error) 
        }) 
    } 
 
    // enable tooltips 
    $(function () { 
    $('[data-toggle="tooltip"]').tooltip() 
    }); 
}); 