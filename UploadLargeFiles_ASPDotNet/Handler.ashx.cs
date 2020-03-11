using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;

namespace UploadLargeFiles_ASPDotNet
{
    /// <summary>
    /// Summary description for Handler
    /// </summary>
    public class Handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //Check if Request is to Upload the File.
            if (context.Request.Files.Count > 0)
            {
                //Fetch the Uploaded File.
                HttpPostedFile postedFile = context.Request.Files[0];

                //Set the Folder Path.
                string folderPath = context.Server.MapPath("~/Uploads/");

                //Set the File Name.
                string fileName = Path.GetFileName(postedFile.FileName);

                //Save the File in Folder.
                postedFile.SaveAs(folderPath + fileName);

                //Send File details in a JSON Response.
                string json = new JavaScriptSerializer().Serialize(
                    new
                    {
                        name = fileName
                    });
                context.Response.StatusCode = (int)HttpStatusCode.OK;
                context.Response.ContentType = "text/json";
                context.Response.Write(json);
                context.Response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}