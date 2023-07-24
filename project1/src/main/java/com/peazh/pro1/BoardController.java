package com.peazh.pro1;

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

@Controller
public class BoardController {

	// Autowired(스프링에서 제공) 말고 Resource로 연결
	@Resource(name = "boardService")
	private BoardService boardService;

	@Autowired
	private Util util;

	@GetMapping("/board")
	public String board(Model model) {
		// 서비스에서 값 가져오기 (가져오려면 연동해야 함)
		model.addAttribute("list", boardService.boardList());

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
		model.addAttribute("dto", result);

		return "detail";
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
		if(session.getAttribute("mid") != null ) {
			
			//로그인 했습니다.
			// 사용자가 입력한 데이터 변수에 담기
			BoardDTO dto = new BoardDTO();
			dto.setBtitle(request.getParameter("title"));
			dto.setBcontent(request.getParameter("content"));
			
			// 세션에서 불러오기
			dto.setM_id((String)session.getAttribute("mid"));
			dto.setM_name((String) session.getAttribute("mname"));

			// Service -> DAO -> mybatis -> DB로 보내서 저장하기
			boardService.write(dto);

			return "redirect:board";// 다시 컨트롤러 지나가기 GET방식으로 갑니다.
			
		} else {
			// 로그인 안했어요. 로그인 하세요.
			return "redirect:/login";
		}
		
	}

	// 삭제할 때
	@GetMapping("/delete")
	// RequestParam == HttpServletRequest의 getParameter();
	public String delete(@RequestParam(value = "bno", required = true, defaultValue = "0") int bno) {

		// 내 글만 삭제하기 위해서 dto 만들기
		BoardDTO dto = new BoardDTO();
		dto.setBno(bno);

		// 로그인을 하면 사용자의 정보를 같이 보내기
		boardService.delete(dto);

		return "redirect:board";// 삭제를 완료한 후에 다시 보드로 가기
	}

	// 수정하는 화면 만들기
	@GetMapping("/edit")
	public ModelAndView edit(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView("edit");// edit.jsp로 갈거야
		
		// dto를 하나 만들어서 거기에 담겠습니다. = bno, mid
		BoardDTO dto = new BoardDTO();
		dto.setBno(util.str2Int(request.getParameter("bno")));
		
		// 내 글만 수정할 수 있도록 세션에 있는 mid도 같이 보내기
		dto.setM_id((String) session.getAttribute("mid"));
		
		// 데이터 베이스에 bno를 보내서 dto를 얻어오기
		BoardDTO result= boardService.detail(dto);

		// mv에 보내기
		mv.addObject("dto", result);

		return mv;
	}

	@PostMapping("/edit")
	public String edit(BoardDTO dto) {
		boardService.edit(dto);

		return "redirect:detail?bno=" + dto.getBno();// 보드로 이동하게 해주세요
	}

}
