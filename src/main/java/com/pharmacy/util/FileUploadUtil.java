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

    public static String saveImage(Part filePart, ServletContext context) throws IOException {
        if (filePart == null || filePart.getSize() == 0 ||
                filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
            return null;
        }

        String fileName = UUID.randomUUID().toString() + "_" + filePart.getSubmittedFileName();

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
