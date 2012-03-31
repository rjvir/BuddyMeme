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

});