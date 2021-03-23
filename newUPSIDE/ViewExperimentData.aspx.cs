using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;





namespace newUPSIDE
{
   
 
   
    public partial class WebForm2 : System.Web.UI.Page
    {        
        int lengthRow;// the length of row
        int lengthCol;// the length of column
        ArrayList RowHead = new ArrayList();
        JObject jo = new JObject();
        protected void Page_Load(object sender, EventArgs e)
        {
        //refresh the page    
            if (!Page.IsPostBack)
            {
                //store the json to the related path
                string JsonPath = Server.MapPath("~/File/ConfigerExperiment.json");
                string JsonString = File.ReadAllText(JsonPath, Encoding.UTF8);
                JObject jobject = JObject.Parse(JsonString);
                //get the selected json file
                for (int i = 0; i < jobject["Experiments"].Count(); i++)
                {
                    ExperimentNameSelected.Items.Add(jobject["Experiments"][i]["Name"].ToString());                        
                }
 
            }
            Refresh();              // clear cache           

        }

        public static void Refresh()
        {
            Refresh(String.Empty);
        }

       //refresh the page and clear the cache
        public static void Refresh(string pre)
        {
            System.Web.Caching.Cache _cache = HttpRuntime.Cache;
            IDictionaryEnumerator CacheEnum = _cache.GetEnumerator();

            ArrayList al = new ArrayList();

            while (CacheEnum.MoveNext())
            {
                al.Add(CacheEnum.Key);
            }


            foreach (string key in al)
            {
                if (pre == string.Empty)
                {
                    _cache.Remove(key);
                }
                else
                {
                    if (key.StartsWith(pre))
                    {
                        _cache.Remove(key);
                    }
                }
            }

        }

        //
        private void Initialize(string path)
        {
            string josnString = File.ReadAllText(path, Encoding.Default);
            
            jo = JObject.Parse(josnString);
            
            string name = jo.First.First.Path;

            JToken ltest = jo.First.First.First;
            JEnumerable<JToken> ll = ltest.Children();
            
            foreach (JToken grandGrandChild in ltest)
            {
                var property = grandGrandChild as JProperty;
                if (property != null)
                {
                    string mmm = property.Name;
                    RowHead.Add(mmm);
                    // MessageBox.Show(property.Name + ":" + property.Value);
                }
            }
            int m = ll.Count();
            for (int i = 0; i < m; i++)
            {
               

            }
            
            lengthRow = jo[name].Count();
            lengthCol = jo[name][0].Count();
            int row = lengthRow;    // 行数
            int col = lengthCol;    // 列数

          

            for (int i = 0; i < col; i++)
            {
                TableCell cell = new TableCell();
                string cellValue = RowHead[i].ToString();
                cell.Text = cellValue;
                tableHeaderName.Cells.AddAt(i, cell);

            }
            for (int i = 0; i < row; i++)

            {
                TableRow tr = new TableRow();
                ExperimentDataTable.Rows.Add(tr);

                for (int j = 0; j < col;j++) {
                    TableCell cell = new TableCell();
                    string cellValue = jo[name][i][RowHead[j]].ToString();
                    cell.Text = cellValue;
                    tr.Cells.AddAt(j, cell);
                }
              
            }
        }

        protected void ExperimentNameSelected_SelectedIndexChanged(object sender, EventArgs e)
        {

            string Ename = ExperimentNameSelected.SelectedItem.Value;
            string path = Server.MapPath("~/File/ConfigerExperiment.json");
            string josnString = File.ReadAllText(path, Encoding.Default);
            jo = JObject.Parse(josnString);
            string JsonPath = Server.MapPath("Unityjson.json");
            FileInfo fi = new FileInfo(JsonPath);
            if (fi.Length == 0)
            {
              //  Response.Write("<p >The Experiment Name Alread Exists!</p>");

            }
            else {
                string JsonString = File.ReadAllText(JsonPath, Encoding.UTF8);
                int nameNumber = jo["Experiments"].Count();
                string fileName = jo["Experiments"][nameNumber - 1]["Name"].ToString();
                string pathFile = "~/File/" + fileName + ".json";
                string pathAdd = Server.MapPath(pathFile);
                string JsonString1 = File.ReadAllText(pathAdd, Encoding.UTF8);
                JObject addData = JObject.Parse(JsonString1);
                JObject jobject = JObject.Parse(JsonString);
                
                addData["Experiments"].Last.AddAfterSelf(jobject["Experiment"].Children());
                string convertString = Convert.ToString(addData);
                File.WriteAllText(pathAdd, convertString);
                
                File.WriteAllText(JsonPath, null);
            }
            
           


            
            int local = 0;
            for (int i = 0; i < jo["Experiments"].Count(); i++)
            {
                if (jo["Experiments"][i]["Name"].ToString() == Ename)
                {
                    local = i;
                    break;
                }
            }
            Label4.Text = jo["Experiments"][local]["Description"].ToString();

            string filepath;
            filepath = "~/File/" + Ename + ".json";          
            string fileUrl = Server.MapPath(filepath);
            Initialize(fileUrl);
            string josnSelectedPath = File.ReadAllText(fileUrl, Encoding.Default);
            JObject jsonSelected = new JObject();
            jsonSelected = JObject.Parse(josnSelectedPath);
            ArrayList inputArray = new ArrayList();
            int d3json = jsonSelected["Experiments"].Count();
            for (int i = 1; i < d3json; i++) {
                inputArray.Add(jsonSelected["Experiments"][i]);
            }
                      
            string fileTestBar = Server.MapPath("~/testbar.json");
            File.WriteAllText(fileTestBar, JsonConvert.SerializeObject(inputArray));

            //  FileStream fsSource = new FileStream(fileUrl, FileMode.Open);
            // FileStream fsTarget = new FileStream(fileTestBar, FileMode.OpenOrCreate);
            // byte[] sourceArr = new byte[fsSource.Length];
            //  fsSource.Read(sourceArr, 0, sourceArr.Length);
            //  fsTarget.Write(x, 0, x.Length);
            // fsSource.Close();
            // fsTarget.Close();
            //JToken ltest = jo["Experiments"][local]["Data"].First.First.First;
            //JEnumerable<JToken> ll = ltest.Children();

            //foreach (JToken grandGrandChild in ltest)
            //{
            //    var property = grandGrandChild as JProperty;
            //    if (property != null)
            //    {
            //        string mmm = property.Name;
            //        RowHead.Add(mmm);
            //        // MessageBox.Show(property.Name + ":" + property.Value);
            //    }
            //}
            //for (int i = 0; i < jo["Experiments"][local]["Data"].Count(); i++)
            //{
            //    TableCell cell = new TableCell();
            //    string cellValue = jo["Experiments"][local]["Data"][i][1].ToString();
            //    cell.Text = cellValue;
            //    tableHeaderName.Cells.AddAt(i, cell);

            //}
            //if (Ename == "ITEM2")

            //{


            //   ExperimentDataTable = new Table();
            // tableHeaderName = new TableHeaderRow();

            //}

            //else

            //{
            //    filepath = "~/File/" + "ExperimentData.json";


            //    //  ExperimentDataTable = new Table();
            //    //  tableHeaderName = new TableHeaderRow();
            //};
        }

        //protected string CsharpVoid(string strCC)
        //{
        //    strCC = "你好！" + strCC;
        //    return strCC;
        //}

        //    private void InitializeList()
        //{
        //    //List<string> list = new List<string>();
        //    //list.Add("ITEM1");
        //    //list.Add("ITEM2");
        //    //ListItem ll = new ListItem();
        //    //ExperimentNameSelected.Items.Add("ITEM1");
        //    //ExperimentNameSelected.Items.Add("ITEM2");
        //   // ExperimentNameSelected.Items.Add("ITEM3");
        //}
    }
    
   
}