package com.teamproject.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import com.teamproject.domain.Member;

import lombok.extern.log4j.Log4j;

import java.security.*;

@Log4j
public class MemberUtility {
	/*public String encryptSHA256(String str) {

		String sha = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());

			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			sha = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			// e.printStackTrace();
			log.info("Encrypt Error - NoSuchAlgorithmException");
			sha = null;
		}

		return sha;
	}

	// 패스워드는 암호화 전에 사용해야함
	// 서버에서는 리턴값을 정상적이지 않은 경로라고만 반환예쩡
	public boolean memberInfocheck(Member vo, int option) {
		String idPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
		String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}";
		String phonePattern = "^[0-9]{10,11}$";
		String birthdatePattern = "^[1-2]{1}[0-9]{3}[0-1]{1}[0-9]{1}[0-3]{1}[0-9]{1}$";
		String namePattern = "^[0-9a-zA-Zㄱ-ㅎ가-힣]{1,8}$";
		boolean confirm = true;
		confirm = confirm && (vo.getEmail().length() > 6 && vo.getEmail().length() <= 40);
		confirm = confirm && (vo.getEmail().matches(idPattern));

		if (!confirm) {// 이메일 유효성에서 못통과하면 nullpoint방지를 위해서라도 내보냄
			return confirm;
		}
		confirm = confirm && (vo.getPwd().length() >= 8 && vo.getPwd().length() <= 30);// 암호 길이검사
		confirm = confirm && vo.getPwd().matches(passwordPattern);// 암호 패턴검사
		if (option == 1) { // 옵션은 1은 간단한 유효성검사(로그인)
			return confirm;
		}
		confirm = confirm && (vo.getPhone().equals("") || vo.getPhone().matches(phonePattern));// 휴대폰의 패턴검사 밎 널허용
		confirm = confirm && (vo.getBirthdate().equals("") || vo.getBirthdate().matches(birthdatePattern));// 날짜 패턴검사
		confirm = confirm && vo.getName().matches(namePattern);// 이름 패턴검사
		return confirm;
	}
*/
/**/
}
