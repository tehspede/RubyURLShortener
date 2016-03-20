$('#urlForm').submit(function(event) {
    $.ajax({
        type: "POST",
        url: "/",
        data: $("#urlForm").serialize(),
        success: function(data){
            $('#urlForm').prepend('<div class="alert alert-success"><a href="#" class="close" data-dismiss="alert"'+
                'aria-label="close">&times;</a><strong>Success!</strong> Here is your shortened URL: <a href="' + data +
                '" id="shortened">' + data + '</a></div>');
            console.log(data);
        },
        error: function(data){

        }
    });
    event.preventDefault();
});