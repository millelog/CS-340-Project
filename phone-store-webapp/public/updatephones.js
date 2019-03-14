function updatePhones(SKU){
	$.ajax({
	        url: '/phones/' + SKU,
	        type: 'PUT',
	        data: $('#update-phones').serialize(),
	        success: function(result){
	            window.location.replace("./");
	        }
	})
}