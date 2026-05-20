package com.pharmacy.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class FileUploadUtil {

    private static final java.util.List<String> ALLOWED_EXTENSIONS = java.util.List.of("png", "jpg", "jpeg", "gif", "webp");

    public static String saveImage(Part filePart, ServletContext context) throws IOException {
        if (filePart == null || filePart.getSize() == 0 ||
                filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
            return null;
        }

        String originalFileName = filePart.getSubmittedFileName();
        
        // Extract and validate extension
        String extension = "";
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < originalFileName.length() - 1) {
            extension = originalFileName.substring(dotIndex + 1).toLowerCase();
        }

        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            return null; // Reject non-image extension
        }

        // Validate MIME type
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return null; // Reject if it's not declared as an image type
        }

        // Clean filename using UUID to prevent path traversal or duplicate issues
        String fileName = UUID.randomUUID().toString() + "." + extension;

        // Save to runtime deployment directory
        String runtimePath = context.getRealPath("") + File.separator + "uploads";
        saveFile(filePart, runtimePath, fileName);

        return fileName;
    }

    private static void saveFile(Part part, String dirPath, String fileName) throws IOException {
        File dir = new File(dirPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File file = new File(dir, fileName);

        try (InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
    }
}
