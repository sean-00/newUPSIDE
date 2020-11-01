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
        
        int lengthRow;
        int lengthCol;
        ArrayList RowHead = new ArrayList();
        ArrayList ExperimentsName = new ArrayList();
        JObject jo = new JObject();
        ExperimentAttributeConfiger EAC = new ExperimentAttributeConfiger();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Initialize(Server.MapPath("~/File/ExperimentData.json"));
            // InitializeList();
           string path = Server.MapPath("~/File/ConfigerExperiment.json");
           // string txt = (string)Session["MySessionKey "];
           // ExperimentNameSelected.Items.Add(txt);
            if (!Page.IsPostBack)
            {
               // Initialize(path);
                string JsonPath = Server.MapPath("~/File/ConfigerExperiment.json");
              //  string JsonPath = "C:\\Users\\lx\\source\\repos\\newUPSIDE\\newUPSIDE\\File\\ConfigerExperiment.json";
                string JsonString = File.ReadAllText(JsonPath, Encoding.UTF8);
                JObject jobject = JObject.Parse(JsonString);
                for (int i = 0; i < jobject["Experiments"].Count(); i++)
                {
                    ExperimentNameSelected.Items.Add(jobject["Experiments"][i]["Name"].ToString());
                        //Insert(i, jobject["Experiments"][i]["Name"].ToString());
                        //   ExperimentNameSelected.Items[i].Value = i.ToString();
                }
 
            }
            Refresh();              // clear cache         
            
            //2nd  line 59-65
            IDictionaryEnumerator allCaches = HttpRuntime.Cache.GetEnumerator();

            while (allCaches.MoveNext())
            {
                Cache.Remove(allCaches.Key.ToString());
            }

        }

        // line 61-99 for clear cache
        public static void Refresh()
        {
            Refresh(String.Empty);
        }

        /// <summary>
            /// 移除指定前缀缓存
            /// </summary>
            /// <param name="pre"></param>
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

        private void Initialize(string path)
        {

            //string fileUrl = path;
            //ToDataTable(fileUrl);
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
                //string w = ll.GetEnumerator();

            }
            //string m = ltest.Children[0].name;
            lengthRow = jo[name].Count();
            lengthCol = jo[name][0].Count();
            int row = lengthRow;    // 行数
            int col = lengthCol;    // 列数

            //RowHead.Add("Round");
            //RowHead.Add("Success");
            //RowHead.Add("OverTime");
            //RowHead.Add("TimeUse");

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
               // TableCell td1 = new TableCell();
               // TableCell td2 = new TableCell();
                //TableCell td3 = new TableCell();
               // TableCell td4 = new TableCell();
               // int k = 0;
               // td1.Text = jo[name][i][RowHead[0]].ToString();
               // tr.Cells.AddAt(k, td1);
               // tr.Cells.AddAt(k + 1, td2);
               // td2.Text = jo[name][i][RowHead[1]].ToString();
               // tr.Cells.AddAt(k + 2, td3);
               // td3.Text = jo[name][i][RowHead[2]].ToString();
               // tr.Cells.AddAt(k + 3, td4);
               // td4.Text = jo[name][i][RowHead[3]].ToString();


            }
            Refresh();              // clear cache           

        }

        protected void ExperimentNameSelected_SelectedIndexChanged(object sender, EventArgs e)
        {


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
            string Ename = ExperimentNameSelected.SelectedItem.Value;
            string path = Server.MapPath("~/File/ConfigerExperiment.json");
            string josnString = File.ReadAllText(path, Encoding.Default);
            
            jo = JObject.Parse(josnString);
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
            string fileUrl = Server.MapPath(filepath);
            Initialize(fileUrl);
            string josnSelectedPath = File.ReadAllText(fileUrl, Encoding.Default);
            JObject jsonSelected = new JObject();
            jsonSelected = JObject.Parse(josnSelectedPath);

            ArrayList inputArray = new ArrayList();
            inputArray.Add(jsonSelected["Experiments"]);
            // byte[] x = (byte[])inputArray.ToArray(typeof(byte));
            string fileTestBar = Server.MapPath("~/testbar.json");
            File.WriteAllText(fileTestBar, JsonConvert.SerializeObject(jsonSelected["Experiments"]));
            //  FileStream fsSource = new FileStream(fileUrl, FileMode.Open);

            // FileStream fsTarget = new FileStream(fileTestBar, FileMode.OpenOrCreate);
            // byte[] sourceArr = new byte[fsSource.Length];
            //  fsSource.Read(sourceArr, 0, sourceArr.Length);
            //  fsTarget.Write(x, 0, x.Length);
            // fsSource.Close();
            // fsTarget.Close();
            
            Refresh();

        }

        protected string CsharpVoid(string strCC)
        {
            strCC = "你好！" + strCC;
            Refresh();              // clear cache           

            return strCC;
        }

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