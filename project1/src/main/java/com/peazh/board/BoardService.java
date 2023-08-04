package com.peazh.board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.peazh.util.Util;

// 저 괄호 안에 없으면 boardservice라는 타입을 가지는데 저렇게 적어주면
// 서비스의 이름을 지정해줌(이름 : boardSerivce) 저 이름으로 불릴거야~
@Service("boardService")
public class BoardService {

	@Inject
	@Named("boardDAO")
	private BoardDAO boardDAO;

	@Autowired
	private Util util;

	// 보드 리스트 불러오는 메서드
	public List<BoardDTO> boardList(PageDTO page) {
		return boardDAO.boardList(page);
	}

	public BoardDTO detail(BoardDTO dto2) {
		// 좋아요 수 +1하기 기능
		boardDAO.likeUp(dto2);// bno 가져가기 위해서 괄호 안에 dto2 객체를 넣음
		
		BoardDTO dto = boardDAO.detail(dto2);

		if (dto != null) {// 내 글이 아닐 때 null이 들어옴
			// 즉, null이 아닐 때 검사해주기
			// ip를 string bip에 넣기
			String bip = dto.getBip();

			// ip 주소가 있을 때만 검사하기
			if (bip != null && bip.indexOf(".") != -1) {

				// \\. 기준으로 잘라서 배열에 넣어주기
				String[] cut = bip.split("\\.");

				// 배열 1번지를 하트로 바꿔주기
				cut[1] = "❤️";

				// 배열을 string으로 바꿔서 다시 bip에 저장하기
				dto.setBip(String.join(".", cut));
			}
		}
		return dto;
	}

	// 글쓰기
	public void write(BoardDTO dto) {

		dto.setBtitle(util.exchange(dto.getBtitle()));
		dto.setBip(util.getIp());// 얻어온 ip도 저장해서 데이테 베이스로 보내기

		boardDAO.write(dto);// 실행만 시키고 결과를 받지 않습니다.
		// select를 제외한 나머지는 영향받은 행의 수(int)를 받아오기도 합니다.
	}

	public void delete(BoardDTO dto) {
		boardDAO.delete(dto);
	}

	public void edit(BoardDTO dto) {
		boardDAO.edit(dto);
	}
	
	// 페이지 전체 글 가져오기
	public int totalCount() {
		return boardDAO.totalCount();
	}

	public List<Map<String, Object>> commentsList(int bno) {
		return boardDAO.commentsList(bno);
	}

}
