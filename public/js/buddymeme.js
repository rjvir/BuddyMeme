$(document).ready(function(){
	$('.cycle').cycle();

    $('.all-friends .friend').sort(function(a,b){return a.innerHTML.toLowerCase() > b.innerHTML.toLowerCase() ? 1 : -1;}).appendTo('.all-friends');
	jQuery.expr[':'].Contains = function(a,i,m){
		return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase())>=0;
	};

    $('.search').keyup(function(){
        var text = $('.search').val().toLowerCase();
    	if(text.length > 1){
    		$('.friends .friend').hide();
    		$('.friends').find(":Contains('"+text+"')").show();
    	}
		if(text.length < 2){
    		$('.friends .friend').show();					
    	}

    });

	//todo: dynamic text sizing and multiple rows
	//possible todo: scumbag hats
	
	//initializes a new javascript image, and sets the source to a value passed from php
    var img = new Image();
    img.src = '<?=$img?>';
    //sets the can and context variables of the canvas
    var can = document.getElementById('canvas');
    var ctx = can.getContext('2d');  

	//when the image loads, i basically draw the image object onto the canvas element, with no text on it
    img.onload = function(){    	
    	ctx.drawImage(img,0,0);
    };

	function changeFontSize(newFontSize,multiplier){
		if(fontSize == origFontSize){
			ctx.font = newFontSize+"pt Impact";
			return newFontSize;
		} else {
			return origFontSize * multiplier;
		}
	}

	//drawText adds text to the image. Unfortunately, the only way to do this is to erase the canvas completely and then redraw the entire thing with new text.
    function drawText(top, bottom){

		fitWidth = <?=$width?>;
		//draw an image with no text onto the canvas
    	ctx.drawImage(img,0,0);

		//set the font styles
    	ctx.fillStyle = "white";
    	ctx.strokeStyle = "black";
    	ctx.lineWidth = 2;
    	//we will need to dynamically alter the font size based on the character count
    	fontSize = origFontSize = 48;
    	multiplier = .75;
    	ctx.font = fontSize+"pt Impact";
   		ctx.textAlign = "center";
   		lineHeight = 1.33;
   				
   		var x = can.width/2;
   		var y = fontSize*lineHeight;
   		//width of the text to be drawn
   		width = ctx.measureText(top).width;

		var words = top.split(' ');
		var currentLine = 0;
		var idx = 1;
		while (words.length > 0 && idx <= words.length) {
        	var str = words.slice(0,idx).join(' ');
        	var w = ctx.measureText(str).width;
        	if ( w > fitWidth ) {
            	if (idx==1) {
                	idx=2;
            	}
            	fontSize = changeFontSize(fontSize*multiplier, multiplier);
            	y = fontSize*1.33;
            	ctx.fillText( words.slice(0,idx-1).join(' '), x, y + (fontSize*lineHeight*currentLine), <?=$width?> );
            	ctx.strokeWidth = fontSize/16 + "px";
            	ctx.strokeText( words.slice(0,idx-1).join(' '), x, y + (fontSize*lineHeight*currentLine), <?=$width?> );
            	currentLine++;
            	words = words.splice(idx-1);
            	idx = 1;
        	} else {
        		idx++;
        	}
    	}
    			
		if  (idx > 0) {
        	ctx.fillText( words.join(' '), x, y + (fontSize*lineHeight*currentLine), <?=$width?>);
            ctx.strokeWidth = fontSize/16 + "px";
        	ctx.strokeText( words.join(' '), x, y + (fontSize*lineHeight*currentLine), <?=$width?>);
		}

		//REPEAT THE ABOVE, BUT FOR THE BOTTOM
   		var y = <?=$height?> - fontSize*lineHeight+fontSize;
		while(ctx.measureText(bottom).width>fitWidth){
			fontSize = .9*fontSize;
			ctx.font = fontSize + "pt Impact";
		}

       	ctx.fillText( bottom, x, y, <?=$width?>);
       	ctx.strokeWidth = fontSize/16 + "px";
       	ctx.strokeText( bottom, x, y, <?=$width?>);

    }

	//after every keystroke into the form
    $('.memetext').keyup(function() {
		//get the form values
		var toptext = $('.toptext').val();
		var bottomtext = $('.bottomtext').val();

		//pass the values into the draw function
		drawText(toptext, bottomtext);
	});

	//once clicking submit
	$('#post').click(function(){
		//save canvas element to a data uri
		dataURI = can.toDataURL();
		//pass the data uri to a server to generate an image
		saveImage(dataURI);
	});


	function saveImage(dataURI){
		//create an md5 for the image title name
		md5 = Crypto.MD5(dataURI);
		//start an ajax request
		$.ajax({
			type: "POST",
			url: "saveImage.php",
			//pass the image data URI and the hash
			data: {'image': dataURI, 'hash': md5},
			success: function(data){
				//once it's successful, redirect to a facebook dialog with the image and captions prefilled
				window.location = 'https://www.facebook.com/dialog/feed?app_id=204060336365834&link=http://www.buddymeme.com/image.php/'+md5+'.png&picture=http://buddymeme.com/memes/'+md5+'.png&redirect_uri=http://www.buddymeme.com/image.php/'+md5+'.png&to=<?=$_GET['id']?>&description=Create%20Memes%20of%20your%20Facebook%20friends&caption='+$('.toptext').val()+'…&name=<?=$name?>%20Meme';
			}
		});
	}


});