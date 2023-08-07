package com.peazh.board;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.peazh.util.Util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {

	// Autowired(스프링에서 제공) 말고 Resource로 연결
	@Resource(name = "boardService")
	private BoardService boardService;

	@Autowired
	private Util util;

	@GetMapping("/board")
	public String board(@RequestParam(value="pageNo", required = false, defaultValue="1") int pageNo, Model model) {
		// 서비스에서 값 가져오기 (가져오려면 연동해야 함)
		// 페이지네이션인포 -> 값 넣고 -> DB -> jsp
		PaginationInfo paginationInfo = new PaginationInfo();
		
		// 필요한 값
		paginationInfo.setCurrentPageNo(pageNo);// 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10);// 한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10);// 페이징 리스트의 사이즈
		
		//전체 글 수 가져오는 명령문장
		int totalCount = boardService.totalCount();
		paginationInfo.setTotalRecordCount(totalCount);// 전체 게시글의 수
		
		
		int firstRecordIndex = paginationInfo.getFirstRecordIndex();// 시작위치
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();// 페이지당 몇 개 보여줄지
		
		PageDTO page = new PageDTO();
		page.setFirstRecordIndex(firstRecordIndex);
		page.setRecordCountPerPage(recordCountPerPage);
		
		List<BoardDTO> list = boardService.boardList(page);
		
		model.addAttribute("list", list);
		// 페이징 관련 정보가 있는 PaginationInfo 객체를 모델에 반드시 넣어줌
		model.addAttribute("paginationInfo", paginationInfo);

		return "board";
	}
	

	// he
	// 파라미터로 들어오는 값 잡기
	@GetMapping("/detail") // model은 jsp에 값을 붙이기 위해서 넣었습니다.
	public String detail(HttpServletRequest request, Model model) {
		// String bno = request.getParameter("bno");
		int bno = util.str2Int(request.getParameter("bno"));

		// DTO로 변경하기
		BoardDTO dto = new BoardDTO();
		dto.setBno(bno);// 글 상세보기에선 mid가 없어도 됩니다.

		BoardDTO result = boardService.detail(dto);
		
		// detail에 댓글 추가하기
		// 댓글이 있을 때만 내용을 담기
		if (result.getCommentcount() > 0) {
			//데이터 베이스에 물어봐서 jsp 보내기
			
			// dto 안 만들고 list로 만들었음
			// 해당 bno의 댓글을 list에 담아서 뽑아내기
			List<Map<String, Object>> commentsList = boardService.commentsList(bno);
			// 뽑아낸 댓글을 model에 붙이기
			model.addAttribute("commentsList", commentsList);
		}
		model.addAttribute("dto", result);

		return "/detail";
	}

	@GetMapping("/write")
	public String write(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("mname") != null) {
			return "write";
		} else {
			return "redirect:/login";
		}
	}

	@PostMapping("/write")
	public String write2(HttpServletRequest request) {

		HttpSession session = request.getSession();
		if (session.getAttribute("mid") != null) {

			// 로그인 했습니다.
			// 사용자가 입력한 데이터 변수에 담기
			BoardDTO dto = new BoardDTO();
			dto.setBtitle(request.getParameter("title"));
			dto.setBcontent(request.getParameter("content"));

			// 세션에서 불러오기
			dto.setM_id((String) session.getAttribute("mid"));
			dto.setM_name((String) session.getAttribute("mname"));
			
			dto.setUuid(UUID.randomUUID().toString());
			System.out.println("================");
			System.out.println(dto.getUuid());
			System.out.println(dto.getUuid().length());
			System.out.println("================");

			// Service -> DAO -> mybatis -> DB로 보내서 저장하기
			boardService.write(dto);

			return "redirect:/board";// 다시 컨트롤러 지나가기 GET방식으로 갑니다.

		} else {
			// 로그인 안했어요. 로그인 하세요.
			return "redirect:/login";
		}

	}

	// 삭제할 때
	@GetMapping("/delete")
	// RequestParam == HttpServletRequest의 getParameter();
	public String delete(@RequestParam(value = "bno", required = true, defaultValue = "0") int bno, HttpSession session) {
		
		// 로그인 여부 확인하기
		if (session.getAttribute("mid") != null) {
			// 내 글만 삭제하기 위해서 dto 만들기
			BoardDTO dto = new BoardDTO();
			dto.setBno(bno);
			dto.setM_id((String) session.getAttribute("mid"));

			// 로그인을 하면 사용자의 정보를 같이 보내기
			boardService.delete(dto);

			return "redirect:/board";// 삭제를 완료한 후에 다시 보드로 가기
		}
		return "redirect:/login";
	}

	// 수정하는 화면 만들기
	@GetMapping("/edit")
	public ModelAndView edit(HttpServletRequest request) {

		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView();// edit.jsp로 갈거야

		// 로그인 하지 않으면 로그인 화면으로 가기
		// if문으로 만들기
		if (session.getAttribute("mid") != null) {


			// dto를 하나 만들어서 거기에 담겠습니다. = bno, mid
			BoardDTO dto = new BoardDTO();
			dto.setBno(util.str2Int(request.getParameter("bno")));

			// 내 글만 수정할 수 있도록 세션에 있는 mid도 같이 보내기
			dto.setM_id((String) session.getAttribute("mid"));

			// 데이터 베이스에 bno를 보내서 dto를 얻어오기
			BoardDTO result = boardService.detail(dto);
			
			if (result != null) {// 내 글을 수정
				// mv에 보내기
				mv.addObject("dto", result);
				mv.setViewName("edit");// 이동할 jsp명을 적어줌
				
			} else {// 다른 사람의 글이라면 null -> 경고창으로 이동
				mv.setViewName("warning");
			}
		} else {
			mv.setViewName("redirect:/login");
		}
		return mv;
	}

	@PostMapping("/edit")
	public String edit(BoardDTO dto) {
		boardService.edit(dto);

		return "redirect:detail?bno=" + dto.getBno();// 보드로 이동하게 해주세요
	}
	
	// 댓글 삭제
	@GetMapping("/cdel") //bno, cno
	public String cdel(@RequestParam Map<String, Object> map, HttpSession session) {
		// 로그인 여부 검사
		if (session.getAttribute("mid") != null) {
			// 값 들어왔는지 여부 검사
			if (util.isEmpty(map.get("bno")) && util.isEmpty(map.get("cno")) && util.isNum(map.get("bno")) && util.isNum(map.get("cno"))) {
				
				map.put("mid", session.getAttribute("mid"));
				boardService.cdel(map);
				return "redirect:/detail?bno="+map.get("bno");
			} else {
				return "redirect:/board";
			}
		} else {
			return "redirect:/login";
		}
		
	}
	
	// 댓글 수정
	@GetMapping("/cedit")
	public String cedit(@RequestParam Map<String, Object> map, HttpSession session) {
		if (session.getAttribute("mid") != null) {
			
		}
		return "";
	}

}
