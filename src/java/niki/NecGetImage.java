/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import javax.imageio.ImageIO;
import static niki.NecSaveReadImg.getFichier;
import static niki.NecSaveReadImg.pathImageNec;

/**
 *
 * @author kimai
 */
public class NecGetImage {

    public static String getImageTestPath(String folder, String globalIneza) {
        String request = "<FOLDER>" + folder + "</FOLDER> "
                + "<GLOBAL_INEZA_ID>" + globalIneza + ".txt</GLOBAL_INEZA_ID>";

        return pathImageNec + request;
    }

    public static String getImage(String xml) {

        String imageInComma = getFichier(xml);

        if (imageInComma == null) {
            return "GET FILE RETURNED NULL OBJECT ";
        } else if (imageInComma.contains("ERROR")) {
            return imageInComma;
        } else if (!imageInComma.contains(",")) {
            return "FILE FORMAT IS WRONG NOT COMMA FOUND";
        } else {
            return imageInComma;
        }

    }

    public static String buildSaveImage(String imageInComma, String folder,
            String filename) {
        String igisubizo = "";
        String[] sp = imageInComma.split(",");
        igisubizo += sp.length + " received ";

        byte[] bite = new byte[sp.length - 2];

        for (int i = 1; i < sp.length - 1; i++) {
            String ss = sp[i];
            if (ss == null || ss.equals("")) {
                continue;
            } else if (ss.contains(" ")) {
                ss = ss.replaceAll(" ", "");
            }

            bite[i - 1] = Byte.parseByte(ss);
        }
        ByteBuffer sourceImageBytes = ByteBuffer.wrap(bite);
        if (sourceImageBytes != null) {
            igisubizo += (" image nyibitseho "
                    + sourceImageBytes.array().length);
        } else {
            igisubizo += (" image not found ");
        }
        try {

            String fileTarget = NecSaveReadImg.pathImageNec + folder + "\\" + filename + ".png";
            igisubizo += fileTarget;
            File imgfile = new File(fileTarget);
            ImageIO.write(createImageFromBytes(bite), "png", imgfile);
        } catch (IOException ex) {
            igisubizo += " " + ex;
        }
        // return sourceImageBytes;
        return igisubizo;
    }

    public static BufferedImage createImageFromBytes(byte[] imageData) {
        ByteArrayInputStream bais = new ByteArrayInputStream(imageData);
        try {
            return ImageIO.read(bais);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
