package com.pharmacy.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import org.junit.jupiter.api.Test;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.lang.reflect.Proxy;
import static org.junit.jupiter.api.Assertions.*;

public class FileUploadUtilTest {

    @Test
    public void testSaveImageWithNullPart() throws IOException {
        String result = FileUploadUtil.saveImage(null, createMockServletContext());
        assertNull(result);
    }

    @Test
    public void testSaveImageWithInvalidExtension() throws IOException {
        Part filePart = createMockPart("malicious.jsp", "text/html", 100, new byte[100]);
        String result = FileUploadUtil.saveImage(filePart, createMockServletContext());
        assertNull(result);
    }

    @Test
    public void testSaveImageWithInvalidMimeType() throws IOException {
        Part filePart = createMockPart("image.png", "text/plain", 100, new byte[100]);
        String result = FileUploadUtil.saveImage(filePart, createMockServletContext());
        assertNull(result);
    }

    @Test
    public void testSaveImageSuccess() throws IOException {
        byte[] dummyContent = new byte[]{1, 2, 3};
        Part filePart = createMockPart("photo.jpg", "image/jpeg", dummyContent.length, dummyContent);
        ServletContext context = createMockServletContext();
        String result = FileUploadUtil.saveImage(filePart, context);
        assertNotNull(result);
        assertTrue(result.endsWith(".jpg"));
    }

    private ServletContext createMockServletContext() {
        return (ServletContext) Proxy.newProxyInstance(
            ServletContext.class.getClassLoader(),
            new Class<?>[]{ServletContext.class},
            (proxy, method, args) -> {
                if ("getRealPath".equals(method.getName())) {
                    return System.getProperty("java.io.tmpdir");
                }
                return null;
            }
        );
    }

    private Part createMockPart(String fileName, String contentType, long size, byte[] content) {
        return (Part) Proxy.newProxyInstance(
            Part.class.getClassLoader(),
            new Class<?>[]{Part.class},
            (proxy, method, args) -> {
                switch (method.getName()) {
                    case "getSubmittedFileName":
                        return fileName;
                    case "getContentType":
                        return contentType;
                    case "getSize":
                        return size;
                    case "getInputStream":
                        return new ByteArrayInputStream(content);
                    default:
                        return null;
                }
            }
        );
    }
}
