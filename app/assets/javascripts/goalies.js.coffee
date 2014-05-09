$ ->
  $('#allGoaliesTable').dataTable({
    "bPaginate": true,
    "bInfo": false,
    "bFilter": true,
    "aaSorting": [[6, "desc"]]
  });