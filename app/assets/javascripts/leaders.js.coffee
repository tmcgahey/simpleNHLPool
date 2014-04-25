
$ ->
  $('#leaderTable').dataTable({
    "bPaginate": false,
    "bInfo": false,
    "bFilter": false,
    "aaSorting": [[6, "desc"]],
    "aoColumnDefs": [
      {"bSortable": false, "aTargets": [-1]}
    ]
  });

  $('#skaterTable').dataTable({
    "bPaginate": false,
    "bInfo": false,
    "bFilter": false,
    "aaSorting": [[5, "desc"]]
  });

  $('#goalieTable').dataTable({
    "bPaginate": false,
    "bInfo": false,
    "bFilter": false,
    "aaSorting": [[4, "desc"]]
  });

