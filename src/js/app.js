import 'jquery'; 
import 'bootstrap'; 
import 'inputmask'; 
 
import '../sass/app.scss'; 

import img from '../images/logo.jpg';
import img2 from '../images/get-it-from-MS.png';
import img3 from '../images/googleplay.svg';
import img4 from '../images/ios-app-store.svg';
 
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