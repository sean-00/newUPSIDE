using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace newUPSIDE
{
   

   
    public partial class WebForm2 : System.Web.UI.Page
    {
        private string round;
        int lengthRow;
        int lengthCol;
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string josnString = File.ReadAllText("C:\\Users\\lx\\source\\repos\\newUPSIDE\\newUPSIDE\\File\\ExperimentData.json", Encoding.Default);
            JObject jo = JObject.Parse(josnString);
            lengthRow = jo["Experiments"].Count();
            lengthCol = jo["Experiments"][0].Count();
            
           
           

            int row = lengthRow;    // 行数
            int col = lengthCol;    // 列数
            
            for (int i = 0; i < row; i++)

            {
                TableRow tr = new TableRow();
                
                
                ExperimentDataTable.Rows.Add(tr);
                
               
                    TableCell td1 = new TableCell();
                    TableCell td2 = new TableCell();
                    TableCell td3 = new TableCell();
                    TableCell td4 = new TableCell();
                    int k = 0;                 
                    td1.Text = jo["Experiments"][i]["Round"].ToString();
                    tr.Cells.AddAt(k, td1);
                    tr.Cells.AddAt(k + 1, td2);
                    td2.Text = jo["Experiments"][i]["Success"].ToString();
                    tr.Cells.AddAt(k + 2, td3);
                    td3.Text = jo["Experiments"][i]["OverTime"].ToString();
                    tr.Cells.AddAt(k + 3, td4);
                    td4.Text = jo["Experiments"][i]["TimeUse"].ToString();



            }
            LabelTest.Text= round;
        }

        protected void ExperimentNameSelected_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void GetJson_Click(object sender, EventArgs e)
        {
           




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