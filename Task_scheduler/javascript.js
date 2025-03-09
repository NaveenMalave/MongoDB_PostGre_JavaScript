function validate_data() {
    var task = document.getElementById("task").value;
    var priority = document.getElementById("priority").value;
    var deadline = document.getElementById("deadline").value;
    const today = new Date();
    const deadlineDate = new Date(deadline);

    if (!task) {
        alert("Please Enter the task");
        return false;
    } else if (!priority) {
        alert("Please select the priority of task");
        return false;
    } else if (deadlineDate <= today) {
        alert("Please select an upcoming date for the deadline");
        return false;
    }else if (!deadline) {
        alert("Please select an upcoming date for the deadline");
        return false;
    } else {
        var data = {
            task: task,
            priority: priority,
            deadline: deadline,
            work: "mark done",
        };

        console.log(data);
        if (localStorage.getItem("task")) {
            var data_array = JSON.parse(localStorage.getItem("task"));
            data_array.push(data);
            data = JSON.stringify(data_array);
        } else {
            var data_array = new Array();
            data_array.push(data);
            data = JSON.stringify(data_array);
        }
        return data;
    }
}

function store_data() {
    var output = validate_data();
    console.log("outside condition");

    if (output != false) {
        console.log("inside condition");
        console.log(output);
        localStorage.setItem("task", output);
    }
    location.reload(true) ;
}

function display_data() {
    var datas = localStorage.getItem("task");
    var stored_data = JSON.parse(datas);
    // sorting the data
    
    // stored_data = sort_data(stored_data) ;
    var div_display = document.getElementById("display_data");
    if (stored_data) {
        var table = "";
        for (let i = 0; i < stored_data.length; i++) {
            if (stored_data[i].work == "mark done") {
                table +=
                    "<div id='display_container'><div id='display_element'>" +
                    stored_data[i].task +
                    "</div>";
                table +=
                    "<div id='display_element'> Priority: " +
                    stored_data[i].priority +
                    "</div>";
                table +=
                    "<div id='display_element'> Deadline: " +
                    stored_data[i].deadline +
                    "</div>";
                table +=
                    "<div id='display_element'><button type='submit' id='complete" +
                    i +
                    "' class='btn btn-primary task-btn'>" +
                    stored_data[i].work +
                    "</button></div></div>";
            } else {
                table +=
                    "<div id='display_container'><div id='display_element'>" +
                    stored_data[i].task +
                    "</div>";
                table +=
                    "<div id='display_element'> Priority: " +
                    stored_data[i].priority +
                    "</div>";
                table +=
                    "<div id='display_element'> Deadline: " +
                    stored_data[i].deadline +
                    "</div>";
                table +=
                    "<div id='display_element'><button type='submit' id='complete" +
                    i +
                    "' class='btn btn-success task-btn'>" +
                    stored_data[i].work +
                    "</button></div></div>";
            }
        }
        div_display.innerHTML = table;
        document.getElementById("display_data").addEventListener("click", mark);
    }
}

function mark(event) {
    if (event.target && event.target.classList.contains("task-btn")) {
        if (event.target.classList.contains("btn-primary")) {
            event.target.classList.remove("btn-primary");
            event.target.classList.add("btn-success");
            clicked_id = event.target.id;
            index = clicked_id.slice(-1);
            event.target.innerText = "Completed";

            // now change the stored data in local storage
            var datas = localStorage.getItem("task");
            var stored_data = JSON.parse(datas);
            stored_data[index].work = "Completed";

            localStorage.setItem("task", JSON.stringify(stored_data));

        } else {
            event.target.classList.remove("btn-success");
            event.target.classList.add("btn-primary");
            clicked_id = event.target.id;
            index = clicked_id.slice(-1);

            event.target.innerText = "Completed";

            var datas = localStorage.getItem("task");
            var stored_data = JSON.parse(datas);
            stored_data[index].work = "mark done";
            localStorage.setItem("task", JSON.stringify(stored_data));
        }
    }
    location.reload(true) ;
}
