function getFormData(){

    var name = document.getElementById('name').value
    var email = document.getElementById('email').value
    var sub = document.getElementById('subject').value
    var mess = document.getElementById('messageForm').value


    let data = [name, email, sub, mess]
    return data
    
}

function sendEmail(){

   // alert(getFormData())

}

