using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace newUPSIDE
{
    public partial class ExperimentAttributeConfiger : System.Web.UI.Page
    {

        
        protected void Page_Load(object sender, EventArgs e)
        {   //follow the input number add the text box
            if (ViewState["Insus.NET"] != null)
            {
                DymanicallyCreateTextBox();
            }
           
            

        }

        private void DymanicallyCreateTextBox()
        {
            ViewState["Insus.NET"] = true;
           
        }


        protected void ConfigerHeaderButton_Click(object sender, EventArgs e)
        {
            DymanicallyCreateTextBox();
        }

        
        protected void Submit_Click(object sender, EventArgs e)//add json file to server
        {         
            ArrayList ExperimentData = new ArrayList(); 
            if (ConfigerName.Text != "" && ConfigerDescription.Text != ""){
                    string newFilepath = "~/File/" + ConfigerName.Text.ToString() + ".json";
                string p = Server.MapPath(newFilepath);

                if (!File.Exists(p))
                {
                    FileStream fs1 = new FileStream(p, FileMode.Create, FileAccess.ReadWrite);
                    fs1.Close();
                }
                JObject array = new JObject();
                array.Add(new JProperty("Round", ""));
                array.Add(new JProperty("Success", ""));
                array.Add(new JProperty("OverTime", ""));
                array.Add(new JProperty("TimeUse", ""));
                array.Add(new JProperty("ImageType", ""));
                array.Add(new JProperty("ImageDetail", ""));
                
                JObject newtest = new JObject(
                    new JProperty("Experiments", new JArray(array)));

                //write the json to file 
                File.WriteAllText(p, Convert.ToString(newtest));
                if (ViewState["Insus.NET"] != null)
                {
                   
                }
                //store the josn file in related place"~/File/ConfigerExperiment.json"
                string JsonPath = Server.MapPath("~/File/ConfigerExperiment.json");
                string JsonString = File.ReadAllText(JsonPath, Encoding.UTF8);
                JObject jobject = JObject.Parse(JsonString);
                string name = ConfigerName.Text.ToString();
                Boolean judge = true;
                
                //get the input number and store them into json file
                int count = jobject["Experiments"].Count();
                for (int i = 0; i < count; i++) {
                    string Ename = jobject["Experiments"][i]["Name"].ToString();
                    if (name == Ename)
                    {
                        judge = false;
                        break;
                    }
                    else {
                        judge = true;
                    }
                }
          
                    if (judge == false)
                    {
                    Response.Write("<p >The Experiment Name Alread Exists!</p>");
                    }
                    else {
          
                    string description = ConfigerDescription.Text.ToString();
                        JObject arr = new JObject();
                        foreach (string a in ExperimentData)
                        {
                            arr.Add(new JProperty(a, ""));
                        }
                    
                        JObject newStu = new JObject(
                            new JProperty("Name", name),
                            new JProperty("Description", description),
                            new JProperty("Data", new JArray(arr))
                            );

                        jobject["Experiments"].Last.AddAfterSelf(newStu);

                        string convertString = Convert.ToString(jobject);
                        File.WriteAllText(JsonPath, convertString);
                    Response.Write("<p >Success add the new experiment file</p>");
                }
                
                
            }
            else
            {
                Response.Write("<p >Please Input Name, Description and Header!</p>");
            }

         
        }

        
    }
}