package com.example.khu_nghi_duong_furama.util;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class CookieEncryption {
    private static final String SECRET_KEY = "MySecretKey12345"; // Khóa bí mật (nên lưu trong file cấu hình)

    public static String encrypt(String data) throws Exception {
        SecretKeySpec key = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] encrypted = cipher.doFinal(data.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }

    public static String decrypt(String encryptedData) throws Exception {
        SecretKeySpec key = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedData));
        return new String(decrypted);
    }
}