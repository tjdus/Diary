<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset="UTF-8">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>

    <!-- jquery -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- bootstrap 4 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="<c:url value='/resources/static/fullcalendar/core/index.global.js' />"></script>
    <script src="<c:url value='/resources/static/fullcalendar/daygrid/index.global.js' />"></script>
    <script>
        $(document).ready(function () {
            // 모달이 숨겨질 때 실행되는 함수
            $('#calendarModal').on('hidden.bs.modal', function () {
                // 입력 필드 초기화
                $("#calendar_content").val("");
                $("#calendar_start_date").val("");
                $("#calendar_end_date").val("");
            });
        });

        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'Asia/Seoul',
                initialView: 'dayGridMonth',
                selectable: true,
                locale: 'ko',
                headerToolbar: {
                    center: 'addEventButton' // headerToolbar에 버튼을 추가
                }, customButtons: {
                    addEventButton: { // 추가한 버튼 설정
                        text: "일정 추가",  // 버튼 내용
                        click: function () { // 버튼 클릭 시 이벤트 추가
                            $("#calendarModal").modal("show"); // modal 나타내기
                            // 삭제 버튼 숨기기
                            $("#deleteCalendar").hide();
                            $("#updateCalendar").hide();
                            $("#addCalendar").show();

                            $("#addCalendar").off("click").on("click", function () {  // modal의 추가 버튼 클릭 시
                                var content = $("#calendar_content").val();
                                var start_date = $("#calendar_start_date").val();
                                var end_date = $("#calendar_end_date").val();

                                //내용 입력 여부 확인
                                if (content == null || content == "") {
                                    alert("내용을 입력하세요.");
                                } else if (start_date == "" || end_date == "") {
                                    alert("날짜를 입력하세요.");
                                } else if (new Date(end_date) - new Date(start_date) < 0) { // date 타입으로 변경 후 확인
                                    alert("종료일이 시작일보다 먼저입니다.");
                                } else { // 정상적인 입력 시
                                    var eventData = {
                                        title: content,
                                        start: start_date,
                                        end: end_date,
                                        allDay: true
                                    };
                                    calendar.addEvent(eventData); // 캘린더에 이벤트 추가
                                    $("#calendarModal").modal("hide"); // 모달 닫기
                                }

                            });
                        }
                    }
                },
                editable: true, // false로 변경 시 draggable 작동 x
                displayEventTime: false, // 시간 표시 x
                eventClick: function(info) { // 이벤트 클릭 시
                    // 해당 이벤트의 정보를 가져옴
                    var eventId = info.event.id;
                    var eventTitle = info.event.title;
                    var eventStart = info.event.start.toISOString().slice(0,10);
                    var eventEnd = info.event.end.toISOString().slice(0,10);

                    // 모달에 이벤트 정보를 채워 넣음
                    $("#calendarModal").modal("show");
                    $("#calendar_content").val(eventTitle);
                    $("#calendar_start_date").val(eventStart);
                    $("#calendar_end_date").val(eventEnd);

                    $("#addCalendar").hide();
                    $("#deleteCalendar").show();
                    $("#updateCalendar").show();

                    $("#updateCalendar").off("click").on("click", function () {
                        var newContent = $("#calendar_content").val();
                        var newStart_date = $("#calendar_start_date").val();
                        var newEnd_date = $("#calendar_end_date").val();

                        //내용 입력 여부 확인
                        if (newContent == null || newContent == "") {
                            alert("내용을 입력하세요.");
                        } else if (newStart_date == "" || newEnd_date == "") {
                            alert("날짜를 입력하세요.");
                        } else if (new Date(newEnd_date) - new Date(newStart_date) < 0) { // date 타입으로 변경 후 확인
                            alert("종료일이 시작일보다 먼저입니다.");
                        } else { // 정상적인 입력 시
                            info.event.setProp('title', newContent);
                            info.event.setStart(newStart_date);
                            info.event.setEnd(newEnd_date);
                            $("#calendarModal").modal("hide"); // 모달 닫기
                        }
                    });
                    // 삭제 버튼 클릭 시
                    $("#deleteCalendar").off("click").on("click", function () {
                        info.event.remove(); // 이벤트 삭제
                        $("#calendarModal").modal("hide"); // 모달 닫기
                    });
                }
        });
            calendar.render();
        });

    </script>
    <style>
        #calendarBox{
            width: 70%;
            padding-left: 15%;
        }
    </style>
</head>
<body>
<div id="calendarBox">
    <div id="calendar"></div>
</div>

<!-- modal 추가 -->
<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="taskId" class="col-form-label">일정 내용</label>
                    <input type="text" class="form-control" id="calendar_content" name="calendar_content">
                    <label for="taskId" class="col-form-label">시작 날짜</label>
                    <input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
                    <label for="taskId" class="col-form-label">종료 날짜</label>
                    <input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" id="addCalendar">추가</button>
                <button type="button" class="btn btn-warning" id="updateCalendar">수정</button>
                <button type="button" class="btn btn-danger" id="deleteCalendar">삭제</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        id="sprintSettingModalClose">취소</button>
            </div>

        </div>
    </div>
</div>
</body>
</html>
