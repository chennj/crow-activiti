package net.crow.activiti.track.common.util;

import java.util.UUID;

public class PwdUtil {

	public final static String encryptWithSalt(String password){
	    String salt = UUID.randomUUID().toString();
	    String pass = DigestUtils.encryptMd5(DigestUtils.encryptMd5(password)+salt);
	    System.out.println(salt);
	    return pass;
	}
	
	public static void main (String[] args) throws Exception{
		
		System.out.println(PwdUtil.encryptWithSalt("Uskini123!"));
	}
}
