$ ->
  $('#allGoaliesTable').dataTable({
    "bPaginate": false,
    "bInfo": false,
    "bFilter": true,
    "aaSorting": [[6, "desc"]]
  });