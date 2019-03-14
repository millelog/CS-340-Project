function updateEmployees(Emp_ID){ 
	$.ajax({  
		url: '/employees/' + Emp_ID,
		type: 'PUT',
		data: $('#update-employees').serialize(),
		success: function(result){ 
			window.location.replace("./");
		} 
	})
}