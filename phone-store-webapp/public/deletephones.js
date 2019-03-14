function deletePhones(SKU){
	//only delete after confirmation
	if(confirm("Are you sure you want to delete?")){
		$.ajax({
			url:'/phones/'+ SKU,
			type: 'DELETE',
			success: function(result){
				window.location.reload(true);
			}
		})
	}

	
}