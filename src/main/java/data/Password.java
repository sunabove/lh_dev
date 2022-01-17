package data;

import org.apache.commons.codec.digest.DigestUtils;

public class Password {

	private static final String securityKey = "stlogic";
	
	public String getEncrypt( String password ) {
		return DigestUtils.sha512Hex( securityKey + password ); 
	} 

	public static void main(String[] args) {
		
		String pass = "admin";
		
		Password password = new Password();
		
		String encrypt = password.getEncrypt( pass ) ; 

		System.out.println( encrypt );
	}

}
