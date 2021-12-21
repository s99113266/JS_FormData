using System.Web;

namespace Js_FormDataTest
{
    /// <summary>
    /// PostPage1 的摘要描述
    /// </summary>
    public class PostPage1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string formInputname;
            formInputname = context.Request.Form["inputname"];
            if (!string.IsNullOrWhiteSpace(formInputname)) context.Response.Write(formInputname);
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