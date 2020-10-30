using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.Mvc;

namespace newUPSIDE.Controllers
{
    public class UnityController : Controller
    {
        // GET: Unity
        public void Index(String experimentData = "No data yet")
        {
            // string p = @"C:\Users\Administrator\Desktop\newUPSIDE-master\newUPSIDE\File\TestJson.json";
            string p = Server.MapPath("~/Unityjson.json");
            //write the json to file 
            System.IO.File.WriteAllText(p, experimentData);

           // System.IO.File.AppendAllText(p, experimentData);
        }
    }
}