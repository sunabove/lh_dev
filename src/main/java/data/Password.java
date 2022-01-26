package data;

import org.apache.commons.codec.digest.DigestUtils;

public class Password {

	private static final String securityKey = "stlogic";
	
	public String getEncode( String password ) {
		return this.encrypt(password);
	}
	
	public String getEncrypt( String password ) {
		return this.encrypt(password);
	}
	
	public String encode( String password ) {
		return encrypt( password );
	}
	
	public String encrypt( String password ) {
		return DigestUtils.sha512Hex( securityKey + password ); 
	} 

	public static void main(String[] args) {
		
		String pass = "admin";
		
		Password password = new Password();
		
		String encrypt = password.encrypt( pass ) ; 

		System.out.println( encrypt );
	}

}
