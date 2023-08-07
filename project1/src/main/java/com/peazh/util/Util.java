package com.peazh.util;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

// Controller Service Repository 
// Component = 객체

@Component
public class Util {
	// 문자열이 들어오면 숫자로 변경하기
	public int str2Int(String str) {
		//숫자로 바꿀 수 있는 경우는 숫자로, 만약 숫자로 못 바꾸는 녀석 처리
		int result = 0;
		
		try {
			result = Integer.parseInt(str);
		} catch (Exception e) {
			
			// 숫자인 것만 담을 예정
			StringBuilder sb = new StringBuilder();
			
			for (int i = 0; i < str.length(); i++) {
				
				// 숫자인지 물어보기
				if (Character.isDigit(str.charAt(i))) {
					
					// 숫자가 맞다면 re에 넣기
					sb.append(str.charAt(i));
				}
			}
			// 숫자인 string을 int로 변환해서 result에 넣기
			result = Integer.parseInt(sb.toString());
		}
		return result;
	}
	
	public String exchange(String str) {
		return str.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	
	
	public String getIp() {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();

		// 상대방 ip 가져오기
		String ip = null; // 192.168.0.0 ->HttpServletRequest가 있어야 함
		ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	// 숫자로 변환할 수 있는지 확인하기
	public boolean isNum(Object obj) {
		try {
			//String.valueOf(obj) obj의 값을 뽑아서 string으로 바꿔준다는 뜻
			Integer.parseInt(String.valueOf(obj));
			return true;//바꿀 수 있다면 내보내기
		} catch (Exception e) {
			return false;
		}
	}
	
	// 내용이 비어있는지 확인하기
	public boolean isEmpty(Object obj) {
		if (obj != null && !(obj.equals(""))) {
			return true;
		}
		return false;
	}

}
