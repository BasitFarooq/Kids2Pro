<%@ WebHandler Language="C#" Class="ArticlePicture" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class ArticlePicture : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
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
                
             
                string path = "/UserData/Pictures/"
                          + String.Format("{0}{1}{2}{3}{4}{5}{6}", UserName, DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second)
                          + "_articleThumbnail.jpg";
                string fileName = ftpBaseAddress+path;
                FtpWebRequest request = (FtpWebRequest)FtpWebRequest.Create(path);

                           
                request.Method = WebRequestMethods.Ftp.UploadFile;
                request.Credentials = new NetworkCredential(username, password);
                request.UsePassive = true;
                request.UseBinary = true;
                request.KeepAlive = false;
                
              
                using (Stream destination = request.GetRequestStream())
                {
                    file.InputStream.CopyTo(destination);
                    destination.Flush();
                }


            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}