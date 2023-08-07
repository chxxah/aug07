package com.peazh.rest;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.peazh.board.BoardService;
import com.peazh.login.LoginService;
import com.peazh.util.Util;

@RestController
public class ResttController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private Util util;
	
	@Autowired
	private BoardService boardService;

	// 아이디 중복검사
	@PostMapping("/checkID")
	public String checkID(@RequestParam("id") String id) {// 반드시 id 값이 들어와야 동작할 것임
		// @RequestParam : 필수로 들어오는 것 안 들어오면 에러남
		// @RequestParam("id") String id : 따옴표 안에 있는 id랑 String 뒤에 있는 id랑 같으면 따옴표 부분을
		// 빼주기도 함
		// (예시 :@RequestParam String id)
		int result = loginService.checkID(id);
		// json 객체 생성
		JSONObject json = new JSONObject();
		json.put("result", result);// result란 이름으로 result를 담음
		// System.out.println(json.toString());

		return json.toString();// 그냥 json하면 안됨 타입을 string으로 맞춰줘야 함
		// {"result":1} 이게 원래 json 형태임
	}

	// boardList2
	@GetMapping(value = "/boardList2", produces = "application/json; charset=UTF-8")
	public String boardList2(@RequestParam("pageNo") int pageNo) {
		// System.out.println("jq가 보내주는 : " + pageNo);

		// loginService.boardList2()을 받아서 list의 map타입으로 오는 것
		List<Map<String, Object>> list = loginService.boardList2((pageNo - 1) * 10);
		JSONObject json = new JSONObject();
		JSONArray arr = new JSONArray(list);
		json.put("totalCount", loginService.totalCount());
		json.put("pageNo", pageNo);
		json.put("list", arr);
		// System.out.println(json.toString());

		return json.toString();
	}

	// 자바스크립트로 만든 것
	@PostMapping("/checkID2")
	public String checkID2(@RequestParam("id") String id) {
		int result = loginService.checkID(id);
		return result + "";
	}

	// 댓글 삭제
	@PostMapping("/cdelR")
	public String cdelR(@RequestParam Map<String, Object> map, HttpSession session) {
		int result = 0;
		// 로그인 여부 검사
		if (session.getAttribute("mid") != null) {
			// 값 들어왔는지 여부 검사
			if (util.isEmpty(map.get("bno")) && util.isEmpty(map.get("cno")) && util.isNum(map.get("bno"))
					&& util.isNum(map.get("cno"))) {
				map.put("mid", session.getAttribute("mid"));
				result = boardService.cdel(map);
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}

}
