<%@ WebHandler Language="C#" Class="UploadHandler1" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class UploadHandler1 : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        //write your handler implementation here.
        if (context.Request.Files.Count <= 0)
        {
            context.Response.Write("No file uploaded");
        }
        else
        {
            for (int i = 0; i < context.Request.Files.Count; ++i)
            {
                HttpPostedFile file = context.Request.Files[i];
                string ftpBaseAddress = "ftp://www.kids2prosports.com/";
                string username = "banwar";
                string password = "b464anwa7";
                DateTime now = new DateTime();
                string UserName = HttpContext.Current.Request.Form["asd"];
                string fileName = UserName + now.Day + now.Year + now.Month + now.Second + now.Millisecond + "_ProfilePic.jpg";
                string newpath = @"UserData/Pictures/" + fileName;
                string path = ftpBaseAddress + "/UserData/Pictures/" + fileName;
              
                FtpWebRequest request = (FtpWebRequest)FtpWebRequest.Create(path);

                //aandksolutions.k2ps.business.DataAccessManager dam = new aandksolutions.k2ps.business.DataAccessManager();
                //            dam.SetUserInfo(newpath, "Picture", HttpContext.Current.Profile.UserName);

                
                request.Method = WebRequestMethods.Ftp.UploadFile;
                request.Credentials = new NetworkCredential(username, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false;
                
                //aandksolutions.k2ps.business.DataAccessManager dam = new aandksolutions.k2ps.business.DataAccessManager();
                //dam.SetUserInfo(newpath, "Picture", UserName);
                using (Stream destination = request.GetRequestStream())
                {
                    file.InputStream.CopyTo(destination);
                    destination.Flush();
                }

                context.Response.Write("File Uploaded successfully");
                context.Response.End(); 
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}