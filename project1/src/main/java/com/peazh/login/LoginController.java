package com.peazh.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@GetMapping("/join")
	public String join() {
		return "join";
	}

	@PostMapping("/join")
	public String join(JoinDTO joinDTO) {
		int result = loginService.join(joinDTO);
		System.out.println(result);

		if (result == 1) {
			return "redirect:/login";
		} else {
			return "redirect:/join";
		}

	}

	@PostMapping("/login")
	public String login(HttpServletRequest request) {
		LoginDTO dto = new LoginDTO();
		dto.setM_id(request.getParameter("id"));
		dto.setM_pw(request.getParameter("pw"));

		// id, pw를 보냈을 때 무엇이 오면 좋을지 생각하기
		// ex) m_name + count(*) -> count는 dto에 없으므로 만들어주기
		dto = loginService.login(dto);

		if (dto.getCount() == 1) {

			// 세션을 만들어서 로그인을 지정 시간동안 유지시키기
			HttpSession session = request.getSession();
			session.setAttribute("mname", dto.getM_name());
			session.setAttribute("mid", request.getParameter("id"));

			// 세션은 서버에 저장되고 쿠키는 클라이언트(브라우저)에 저장됨
			return "redirect:index"; // 정상적으로 로그인 했다면 인덱스로 가기
		} else {
			return "login"; // 암호, 아이디가 일치하지 않으면 다시 로그인 하기
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
//		if (session.getAttribute("mname") != null) {
//			//session.invalidate();// 세션 삭제하기
//			session.removeAttribute("mname");
//		}
//		if (session.getAttribute("mid") != null) {
//			//session.invalidate();// 세션 삭제하기
//			session.removeAttribute("mid");
//		}
//		
//		httpSession.setMaxInactiveInterval(0);// 0초동안 움직임이 없으면 연결 끊기

		session.invalidate();// 세션 초기화 = 종료 = 세션의 모든 속성 값을 제거

		return "redirect:index";
	}

	// 전체 회원 뽑기
	@GetMapping("/members")
	public ModelAndView members() {
		ModelAndView mv = new ModelAndView("members");
		List<JoinDTO> list = loginService.members();
		mv.addObject("list", list);
		return mv;
	}

}
