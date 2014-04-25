$ ->
  $('#allGoaliesTable').dataTable({
    "bPaginate": false,
    "bInfo": false,
    "bFilter": true,
    "aaSorting": [[4, "desc"]]
  });