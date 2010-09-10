// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function view_state_and_quarter(state,course_id) {
	location.href='/reviews/view/'+state+'/'+course_id; 
}
function load_reviews_for_student_by_quarter(student_id, course_id) {
	location.href='/students/'+student_id+'/peer_grades/'+course_id; 
}
function toggle_picker(node) {
  if(node.value == 'group') {
    $('#student_select').hide();
    $('#group_select').show();
  }
  else
  {
    $('#student_select').show();
    $('#group_select').hide();    
  }
}