<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="row justify-content-center">
  <div class="col-lg-12">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 fw-bold text-primary">Board Read</h6>
      </div>
      <div class="card-body">
        
        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">Bno</span>
          <input type="text" class="form-control" value="<c:out value='${board.bno}'/>" readonly>
        </div>

        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">Title</span>
          <input type="text" name="title" class="form-control" value="<c:out value='${board.title}'/>" readonly>
        </div>

        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">Content</span>
          <textarea class="form-control" name="content" rows="3" readonly><c:out value="${board.content}"/></textarea>
        </div>

        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">Writer</span>
          <input type="text" name="writer" class="form-control" value="<c:out value='${board.writer}'/>" readonly>
        </div>

        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">RegDate</span>
          <input type="text" name="regDate" class="form-control" value="<c:out value='${board.createdDate}'/>" readonly>
        </div>

        <div class="float-end">
           <c:url var="readUrl" value="/board/list">
			  <c:param name="page" value="${page}" />
			  <c:param name="size" value="${size}" />
			  <c:param name="types" value="${types}" />
			  <c:param name="keyword" value="${keyword}" />
			</c:url>
           <a href='${readUrl}'>
             <button type="button" class="btn btn-info btnList" >LIST</button>
           </a>  
          <c:if test="${!board.delFlag}">
            <a href='/board/modify/${board.bno}'>
            	<button type="button" class="btn btn-warning btnModify" >MODIFY</button>
            </a>	
          </c:if>
        </div>

      </div>
    </div>
  </div>
</div>


<div class="col-lg-12">
    <div class="card shadow mb-4">
    <div class='m-4'>
        <!--댓글 작성 폼 -->
      <form id="replyForm" class="mt-4">
        <!-- 게시글 번호 hidden 처리 -->
        <input type="hidden" name="bno" value="${board.bno}" />
      
        <div class="mb-3 input-group input-group-lg">
          <span class="input-group-text">Replyer</span>
          <input type="text" name="replyer" class="form-control" required />
        </div>
      
        <div class="mb-3 input-group">
          <span class="input-group-text">Reply Text</span>
          <textarea name="replyText" class="form-control" rows="3" required></textarea>
        </div>
      
        <div class="text-end">
          <button type="submit" class="btn btn-primary addReplyBtn">Submit Reply</button>
        </div>
			</form>
			<!-- 댓글 작성 폼 끝 -->
		</div>	
	</div>
</div>

<div class="col-lg-12">
  <div class="card shadow mb-4">
      <div class='m-4'>
        <!--댓글 목록 -->
      <ul class="list-group replyList">
        <li class="list-group-item">
          <div class="d-flex justify-content-between">
            <div>
              <strong>번호</strong> - 댓글 내용
            </div>
            <div class="text-muted small">
              작성일
            </div>
          </div>
          <div class="mt-1 text-secondary small">
            작성자
          </div>
        </li>
 	  </ul> <!-- 댓글 목록 -->

      <div aria-label="댓글 페이지 네비게이션" class="mt-4">
        <ul class="pagination justify-content-center">
          <li class="page-item disabled">
            <a class="page-link" href="#" tabindex="-1">이전</a>
          </li>
          <li class="page-item active">
            <a class="page-link" href="#">1</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">2</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">3</a>
          </li>
          <li class="page-item">
            <a class="page-link" href="#">다음</a>
          </li>
        </ul>
      </div>
      <!-- 페이징 끝 -->      
		</div>
	</div>
</div>

<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title" id="replyModalLabel">댓글 수정 / 삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">      
        <form id="replyModForm">
          <input type="hidden" name="rno" value="33">
          <div class="mb-3">
            <label for="replyText" class="form-label">댓글 내용</label>
            <input type="text" name="replyText" id="replyText" class="form-control" value="Reply Text"/>
          </div>
        </form>        
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-primary btnReplyMod">수정</button>
        <button type="button" class="btn btn-danger btnReplyDel">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>



<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">
	
//HTML에서 id가 "replyForm"인 폼(form) 요소를 찾아 변수에 저장합니다.
const replyForm = document.querySelector("#replyForm");
	
// 클래스가 "addReplyBtn"인 버튼을 찾아 클릭 이벤트 리스너를 등록합니다.
document.querySelector(".addReplyBtn").addEventListener("click", e=>{
    
    // 폼 제출 시 페이지가 새로고침되는 브라우저의 기본 동작을 막습니다.
    e.preventDefault();
    
    // 클릭 이벤트가 상위 요소로 퍼져나가는 것(버블링)을 방지합니다.
    e.stopPropagation();		
    
    // 폼(replyForm) 안에 입력된 모든 데이터를 FormData 객체로 생성합니다.
    const formData = new FormData(replyForm);
    
    // FormData의 데이터를 서버로 보내기 좋게 일반 객체(Key: Value 형태)로 변환합니다.
    // ※ 주의: 소문자 object가 아니라 대문자 Object로 써야 에러가 나지 않습니다.
    const data = Object.fromEntries(formData.entries());
    
    
    const jsonData = JSON.stringify(data);
    
    console.log("---------jsonData------------")
    console.log(data);
    console.log(jsonData)
    
    // axios 라이브러리를 사용해 "/replies" 주소로 POST 방식의 데이터 전송을 요청합니다.
    axios.post("/replies", jsonData, {
          headers: {
              // 보내는 데이터의 형식이 JSON임을 서버에 알려줍니다.
              'Content-Type': 'application/json' 
          }
    })
    // 서버 전송에 성공했을 때 실행되는 구간입니다.
    .then(res => {
          console.log("------성공 응답-------------");
          console.log(res.data); // 서버에서 보내준 결과 데이터를 콘솔에 출력합니다.
          
         // 전송이 성공했으므로 폼에 입력되어 있던 내용을 모두 비웁니다.
          replyForm.reset();
          getReplies(1, true);
    })
    // 서버 전송 중 에러가 발생했을 때 실행되는 구간입니다.
    .catch(err => {
         // 에러 메시지와 함께 서버의 응답 내용을 콘솔에 출력합니다.
        console.error("여전히 에러가 난다면 서버 코드를 확인하세요!", err.response);
    });
    
}, false); // 이벤트 캡처링 단계를 사용하지 않겠다는 의미의 기본값입니다.

let currentPage = 1;
let currentSize = 10;

const bno = ${board.bno};

////localhost:8080/replies/49999/list?page=1&size=10
function getReplies(pageNum, goLast){
  
  axios.get(`/replies/\${bno}/list`, {
    params: {
      page: pageNum || currentPage,
      size: currentSize
    }
  }).then(
    res => {      
      const data = res.data;
      console.log(data);
      const {totalCount, page, size}  = data;

      if( goLast && (totalCount > (page*size)) ){
        const lastPage = Math.ceil(totalCount/size);
        getReplies(lastPage);
      }else{
        currentPage = page;
        currentSize = size;
        printReplies(data)
      }

    }
  );  
}

const replyList = document.querySelector(".replyList");

function printReplies(data){
  const {replyDTOList, page,size, prev, next, start, end, pageNums}  = data;

  let liStr = "";

  for(replyDTO of replyDTOList){
    liStr +=  `<li class="list-group-item" data-rno="\${replyDTO.rno}">
                  <div class="d-flex justify-content-between">
                    <div>
                      <strong>\${replyDTO.rno}</strong> - \${replyDTO.replyText}
                    </div>
                    <div class="text-muted small">
                      \${replyDTO.replyDate}
                    </div>
                  </div>
                  <div class="mt-1 text-secondary small">
                    \${replyDTO.replyer}
                  </div>
                </li>`

  }//end for

  replyList.innerHTML = liStr

  let paginStr = "";

  if(prev){
    paginStr += `<li class="page-item">
                    <a class="page-link" href="\${start-1}" tabindex="-1">이전</a>
                  </li>`;
  };

  for(let i of pageNums){
    paginStr += `<li class="page-item \${i===page ? 'active' : ''}">
                    <a class="page-link" href="\${i}">\${i}</a>
                  </li>`;
  };

  if(next){
    paginStr += `<li class="page-item">
                    <a class="page-link" href="\${end + 1}">다음</a>
                  </li>`
  }

  document.querySelector(".pagination").innerHTML = paginStr;
}

document.querySelector(".pagination").addEventListener("click", e => {
  e.preventDefault();
  e.stopPropagation();

  const target = e.target;

  const href = target.getAttribute("href");
  if(!href){
    return ;
  }

  console.log(href);
  getReplies(href);

}, false);

getReplies(1 , true);

const replyModal = new bootstrap.Modal(document.querySelector("#replyModal"));
const replyModForm = document.querySelector("#replyModForm");

replyList.addEventListener("click", e => {
  
  //가장 까까운 상위 li 요소를 찾는다
  const targetLi = e.target.closest("li");  
  
  /*
    data-xxx 형태의 속성은 HTML의 사용자 정의 데이타 속성
    브라우저가 의미를 해석하지 않고, js에서 꺼내 쓰라고 존재하는 값!
    예시> data-rno, data-replyer, data-reply등등...
  */

  const rno = targetLi.getAttribute("data-rno");
  
  console.log(rno);

  if(!rno){ return }

  axios.get(`/replies/\${rno}`).then(res => {
    const targetReply = res.data;

    console.log(targetReply);

    if(targetReply.delflag == false){
      replyModForm.querySelector("input[name = 'rno']").value = targetReply.rno;
      replyModForm.querySelector("input[name = 'replyText']").value = targetReply.replyText

      replyModal.show();

    }else{
      alert("삭제된 댓글은 조회할 수 없습니다.");
    }
  });

}, false);

//삭제
document.querySelector(".btnReplyDel").addEventListener("click", e => {
  e.preventDefault();
  e.stopPropagation();

  const formData = new FormData(replyModForm);

  const rno = formData.get("rno"); 

  axios.delete(`/replies/\${rno}`).then( res => {
    const data = res.data;    //{"result": "deleted"}

    alert("삭제 성공했습니다.");
  
    replyModal.hide();

    getReplies(currentPage);
  });

}, false);


//수정
document.querySelector(".btnReplyMod").addEventListener("click", e=>{
  e.preventDefault();
  e.stopPropagation();

  const formData = new FormData(replyModForm);

  const rno = formData.get("rno");

  axios.put(`/replies/\${rno}`, formData ).then(res => {
    const data = res.data;

    alert("수정이 성공했습니다.");
    replyModal.hide();
    getReplies(currentPage);
  })
  
}, false);

</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>