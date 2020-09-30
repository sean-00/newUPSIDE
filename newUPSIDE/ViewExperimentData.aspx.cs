using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace newUPSIDE
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ExperimentNameSelected_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void GetJson_Click(object sender, EventArgs e)
        {
            var webClient = new WebClient();
            var json = webClient.DownloadString(@"C:\Users\lx\source\repos\WebApplication7\WebApplication7\a.json");
            var experiments = JsonConvert.DeserializeObject<ExperimentsData>(json);
            foreach (var item in experiments) { 

            }
                   
 
                           
                    
        }
    }
    public class ExperimentsData
    {
        // GET: ExperimentsData
        public IList<ExperimentData> experiments { get; set; }

    }
    public class ExperimentData
    {
        // GET: ExperimentData
        public string Round { get; set; }
        public string Success { get; set; }
        public string OverTime { get; set; }
        public string TimeUse { get; set; }
        public string Description { get; set; }
    }
}