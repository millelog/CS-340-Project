function updateStores(Store_ID){
	$.ajax({
		url: '/stores/' + Store_ID,
		type: 'PUT',
		data: $('#update-stores').serialize(),
		success: function(result){ 
			window.location.replace("./");
		}
	})

}
