function updatePlans(Plan_ID){
    $.ajax({
        url: '/service_plans/' + Plan_ID,
        type: 'PUT',
        data: $('#update-plans').serialize(),
        success: function(result){
            window.location.replace("./");
        }
    })
};