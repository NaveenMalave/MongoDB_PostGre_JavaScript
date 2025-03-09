var users=[];

function addTask(){
    var task = document.getElementById("task").value;
    var priority = document.getElementById("priority").value;
    var date = document.getElementById("date").value;

     var obj={
        task : task,
        priority: priority,
        date: date
     }
     users.push(obj);
     console.log(users);
     localStorage.setItem("content",JSON.stringify(users));
    
       display();
   }
function display(){
    var show = JSON.parse(localStorage.getItem("content"));
    var data = "<table><tr>";
    for(let i = 0; i < show.length; i++){
        data += "<th>" + show[i].task + "</th><th>" + show[i].priority + "</th><th>" + show[i].date + "</th>";
    }
    data += "</tr></table>";
    document.getElementById("show").innerHTML = data;
}
