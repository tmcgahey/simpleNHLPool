/**
 * Created by Travis on 2014-04-20.
 */

$('#skaterList').empty();
$("<%= escape_javascript(render @pool_member.skaters) %>").appendTo("#skaterList");
