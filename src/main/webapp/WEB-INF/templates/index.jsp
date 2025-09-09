<!DOCTYPE HTML>

<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>TaskManager | Home</title>
    <meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Kode+Mono&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/js/gijgo.min.js" type="text/javascript"></script>
    <script src="../../static/js/draggable.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

    <link rel="stylesheet" href="../../static/css/bootstrap.min.css" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/gijgo@1.9.10/css/gijgo.min.css" type="text/css"/>
    <link rel="stylesheet" href="../../static/web-fonts/css/all.min.css" type="text/css"/>
    <link rel="stylesheet" href="../../static/css/main.css" type="text/css"/>
    
    <style>
    body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }

    /* Sidebar */
    .sidebar {
        height: 100vh;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #343a40; /* bg-dark */
        padding-top: 20px;
        color: #fff;
    }

    .sidebar a {
        display: block;
        padding: 12px 20px;
        text-decoration: none;
        color: #ddd;
        font-size: 16px;
    }

    .sidebar a:hover {
        background-color: #495057;
        color: #fff;
    }

    .sidebar .brand {
        font-size: 20px;
        font-weight: bold;
        padding: 15px 20px;
        border-bottom: 1px solid #495057;
        margin-bottom: 20px;
    }

    /* Content area */
    .content {
        margin-left: 250px;
        padding: 20px;
    }

    /* Search forms inside sidebar */
    .sidebar form {
        padding: 10px 20px;
    }

    .sidebar input, .sidebar button {
        width: 100%;
        margin-top: 5px;
    }
    
    .containere {
    display: flex;              /* aligne les enfants en ligne */
    justify-content: space-between; /* espace entre les deux */
    gap: 20px;                  /* espace entre les blocs */
}

.box {
    flex: 1;                    /* occupe l’espace également */

}

.left {
    width: 16%;
    
    padding: 15px;
}

.right {
    width: 82%;

    margin-left: 200px;
}
    
</style>
    
    
</head>
<body>
<div class="containere">
    <div class="sidebar box left">
    <div class="brand">
        <a href="/" style="font-family: 'Kode Mono', monospace; font-size: 22px; text-decoration: none; color: #fff;">
  TaskManager
</a>
    </div>
    <a href="createTask"><span class="fas fa-plus"></span> Add Task</a>
    <a href="tasks"><span class="far fa-list-alt"></span> All Tasks</a>
    <a href="tasksInWork"><span class="fas fa-clipboard-list"></span> Tasks in work</a>
    <a href="completedTasks"><span class="fas fa-clipboard-check"></span> Completed Tasks</a>
    <a href="statisticsComplete"><span class="fas fa-chart-bar"></span> Statistics complete</a>
    <a href="statisticsByStagesComplete"><span class="fas fa-chart-pie"></span> Statistics by stages complete</a>

</div>
 <div class="contantee box right">
 
 <nav class="navbar " style="margin-left: 25px;background-color: #343a40;">
  <div class="container" >
    <a class="navbar-brand"></a>
    <form  class="d-flex" role="search"  method="POST" action="searchTask" id="searchTasksByNameForm" style="float:right;">
       <input class="form-control" type="search" name="name" value="${task.name}" placeholder="Enter task name" >
      <button class="btn btn-primary" type="submit">Search</button>
    </form>
  </div>
</nav>
 
 

    <c:choose>
        <c:when test="${mode == 'MODE_HOME'}">
       
            <div class="row justify-content-center">
               
            </div>
        </c:when>

        <c:when test="${mode == 'MODE_SHOW_STATISTICS_COMPLETE'}">
            <div class="container" id="statisticsDiv">
                <c:choose>
                    <c:when test="${countCompletedTasks == 0 && countAllTasks == 0}">
                        <h3>No created tasks</h3>
                    </c:when>
                    <c:otherwise>
                        <canvas id="myChart"></canvas>
                        <input id='countAllTasks' type='hidden' value='${countAllTasks}' />
                        <input id='countCompletedTasks' type='hidden' value='${countCompletedTasks}'/>
                        <script type="text/javascript" src="../../static/js/drawChart.js"></script>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>

        <c:when test="${mode == 'MODE_SHOW_STATISTICS_BY_STAGES_COMPLETE'}">
            <div class="container" id="statisticsDiv">
                <c:choose>
                    <c:when test="${countAllTasks == 0 && countCompletedTasks == 0 && countTasksInWork == 0}">
                        <h3>No created tasks</h3>
                    </c:when>
                    <c:otherwise>
                        <canvas id="pieChartStatisticsByStagesComplete" width="300px", height="200px"></canvas>
                        <input id='countAllTasks' type='hidden' value='${countAllTasks}' />
                        <input id='countCompletedTasks' type='hidden' value='${countCompletedTasks}'/>
                        <input id='countTasksInWork' type="hidden" value='${countTasksInWork}'/>
                        <script type="text/javascript"  src="../../static/js/drawChartByStagesComplete.js"></script>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:when>

        <c:when test="${mode == 'MODE_SHOW_ALL_TASKS'}">
            <div class="container" id="tasksDiv">
                <h3> ${tasks.size() != 0 ? "All tasks" : "No task created"} (${tasks.size()}) </h3>
                <hr>
                <div>
                    <div class="sortable row">
                      <c:forEach var="task" items="${tasks}">
                        <div class="hero-unit col-3" >
                             <div class="taskContainer">
                                <h3>${task.name}</h3>
                                <div class="taskInfo">
                                  <p class="taskDescription">${task.description}</p>
                                </div>
                                  <p class="taskDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${task.dateCreated}"/></p>
                                  <p class="taskStatus">${task.finished == false ? 'Task in work' : 'Completed'}</p>
                                  <p>
                                      <a href="makeTaskCompleted?id=${task.id}" class="btn btn-success <c:if test="${task.finished}"> disabled</c:if> btn-large col col-md"  style="background-color: #71dd8a"> Done
                                          <span class="fas fa-check"></span>
                                      </a>
                                      <a href="updateTask?id=${task.id}" class="btn btn-primary btn-large col col-md"> Update
                                          <span class="fas fa-edit"></span>
                                      </a>
                                  </p>
                              </div>
                         </div>
                      </c:forEach>
                   </div>
                <hr>
            </div>
        </c:when>

        <c:when test="${mode == 'MODE_SHOW_COMPLETED_TASKS'}">
                <div class="container" id="tasksDiv">
                    <h3>${tasks.size() != 0 ? "Completed Tasks " : "Completed Tasks not found "} (${tasks.size()})</h3>
                    <hr>
                    <div>
                        <div class="sortable row">
                            <c:forEach var="task" items="${tasks}">
                                <div class="hero-unit col-3" >
                                    <div class="taskContainer">
                                        <h3>${task.name}</h3>
                                        <div class="taskInfo">
                                            <p class="taskDescription">${task.description}</p>
                                        </div>
                                        <p class="taskDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${task.dateCreated}"/></p>
                                        <p class="taskStatus">${task.finished == false ? 'Task in work' : 'Completed'}</p>
                                        <p>
                                            <a href="deleteCompletedTask?id=${task.id}" class="completedBtn btn btn-info btn-large col col-md"  > Delete
                                                <span class="fas fa-trash-alt"></span>
                                            </a>
                                            <a href="updateTask?id=${task.id}" class="btn btn-primary btn-large col col-md"> Update
                                                <span class="fas fa-edit"></span>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr>
                    </div>
        </c:when>

         <c:when test="${mode == 'MODE_SHOW_TASKS_IN_WORK'}">
               <div class="container" id="tasksDiv">
                   <h3>${tasks.size() != 0 ? "Tasks in work" : "Task in work not found"} (${tasks.size()})</h3>
                   <hr>
                   <div>
                      <div class="sortable row">
                         <c:forEach var="task" items="${tasks}">
                              <div class="hero-unit col-3" >
                              <div class="taskContainer">
                                   <h3>${task.name}</h3>
                                     <div class="taskInfo">
                                          <p class="taskDescription">${task.description}</p>
                                          </div>
                                          <p class="taskDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${task.dateCreated}"/></p>
                                          <p class="taskStatus">${task.finished == false ? 'Task in work' : 'Completed'}</p>
                                          <p>
                                              <a href="makeTaskCompleted?id=${task.id}" class="btn btn-success btn-large col col-md"  style="background-color: #71dd8a"> Done
                                                  <span class="fas fa-check"></span>
                                              </a>
                                              <a href="updateTask?id=${task.id}" class="btn btn-primary btn-large col col-md"> Update
                                                  <span class="fas fa-edit"></span>
                                              </a>
                                            </p>
                                   </div>
                                  </div>
                              </c:forEach>
                       </div>
                       <hr>
                </div>
           </c:when>

           <c:when test="${mode == 'MODE_CREATE_TASK' || mode == 'MODE_UPDATE_TASK'}">
                 <div  class="container text-center createTaskContainer">
                  <br>
                  <h3>${mode == 'MODE_CREATE_TASK' ? 'Create Task' : 'Update Task'}</h3>
                    <form class="form-horizontal"  method="POST" action="saveTask">
                      <input type="hidden" name="id" value="${task.id}"/>
                       <div id="nameDiv" class="form-group">
                          <input type="text" class="form-control col-md-10 textField" name="name" placeholder="Enter task name" value="${task.name}"/>
                       </div>

                       <div id="descriptionDiv">
                          <input type="text" class="form-control col-md-10 textField" name="description" placeholder="Enter task description" value="${task.description}"/>
                       </div>

                       <div id="finishedDiv" class="rows">
                          <label class="control-label col-md-2">Completed?</label>
                          <br>
                          <input type="radio" class="col-sm-1" name="finished" value="true"/>
                          <div class="col-sm-1 answerDiv">Yes</div>
                          <input type="radio" class="col-sm-1 answerDiv" name="finished" value="false" checked/>
                          <div class="col-sm-1 answerDiv">No</div>
                       </div>
                       <div class="form-group">
                          <input id="submitBtn" type="submit" class="btn btn-primary" value="${mode == 'MODE_CREATE_TASK' ? 'Create' : 'Update'}"/>
                       </div>
                     </form>
                   </div>
           </c:when>
    </c:choose>
  </div>
  
  </div>
    <footer class="row-fluid text-center navbar-fixed-bottom navbar-default">
        <div class="copyrights">
            <p class="white-txt">
                <span class="fas fa-tasks fa-lg siteLabel"></span> my-task-manager.com &copy; 2018
            </p>
              <hr class="dark-line">
             <a class="link footerLink" href="/">Home</a>&nbsp
             <a class="link" href="createTask">Add task</a>&nbsp
             <a class="link" href="tasks">All Tasks </a>
             <a class="link" href="tasksInWork">Tasks in work</a>
             <a class="link" href="completedTasks">Completed Tasks</a>
             <br><br>
            <p class="text-white small">All rights reserved</p>
        </div>
    </footer>


    <script src="../../static/js/jquery-1.11.1.min.js"> </script>
    <script src="../../static/js/bootstrap.min.js"> </script>
</body>
</html>