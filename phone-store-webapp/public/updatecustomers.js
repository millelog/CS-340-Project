function updateCustomers(Cust_ID){
	$.ajax({
		url: '/customers/' + Cust_ID,
		type: 'PUT',
		data: $('#update-customers').serialize(),
		success: function(result){
			window.location.replace("./");
		}
	})
}

