$(document).ready(function(){
    var $btn = $("a");
    $btn.on("click",function(){
        alert("click!!");
        return false;
    });
});
