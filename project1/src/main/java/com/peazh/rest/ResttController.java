package com.peazh.rest;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.peazh.login.LoginService;

@RestController
public class ResttController {

	@Autowired
	private LoginService loginService;

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

	/*
	 * boardList2 = { totalCount : 128, pageNo:1, list : [ {bno:1, btitle:....}
	 * {bno:1, btitle:....}, {bno:1, btitle:....}, {bno:1, btitle:....}, {bno:1,
	 * btitle:....} ] }
	 * 
	 * 
	 * 객체 : {키 : 값, 이름 : 값,..............}
	 * 
	 */

}
