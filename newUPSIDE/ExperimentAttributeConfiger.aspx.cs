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
        {
            if (ViewState["Insus.NET"] != null)
            {
                DymanicallyCreateTextBox();
            }
           
            

        }

        private void DymanicallyCreateTextBox()
        {
            ViewState["Insus.NET"] = true;
            //if (ConfigerHeaderNumber.Text != "")
            //{
            //    ConfigerHeaderButton.Enabled = false;
            //    int count = int.Parse(ConfigerHeaderNumber.Text);
            //    for (int i = 0; i < count; i++)
            //    {

            //        TextBox textbox = new TextBox();
            //        textbox.Width = 120;
            //        textbox.BorderWidth = 1;
                   
                    
            //        textbox.ID = "T" + i.ToString();
            //        PlaceHolderLoadTextBox.Controls.Add(textbox);
            //        //TableCell cell = new TableCell();
            //        // text.Width = 100;                    
            //        //ConfigerHeaderName.Cells.AddAt(i, cell);                   
            //        // cell.Controls.Add(text);
            //    }

            //}
        }


        protected void ConfigerHeaderButton_Click(object sender, EventArgs e)
        {
            DymanicallyCreateTextBox();
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
           // JObject source = new JObject();
            //source.Add("{ \"Experiments\":[]}");
            //create a new file path
           

            ArrayList ExperimentData = new ArrayList(); 
          // if (ConfigerHeaderNumber.Text != ""&&ConfigerName.Text!=""&&ConfigerDescription.Text!="") {
            if (ConfigerName.Text != "" && ConfigerDescription.Text != ""){
                    string newFilepath = "~/File/" + ConfigerName.Text.ToString() + ".json";
                string p = Server.MapPath(newFilepath);

                //found the file exist 
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
                    //foreach (Control txtobj in this.PlaceHolderLoadTextBox.Controls)
                    //{
                    //    if (txtobj is TextBox)
                    //    {
                    //        string mmk = (txtobj as TextBox).Text;
                    //        ExperimentData.Add(mmk);

                    //    }
                    //}
                }


               
                string JsonPath = Server.MapPath("~/File/ConfigerExperiment.json");
                string JsonString = File.ReadAllText(JsonPath, Encoding.UTF8);
                JObject jobject = JObject.Parse(JsonString);
                string name = ConfigerName.Text.ToString();
                Boolean judge = true;
                
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
                    //Response.Write("<script language='javascript'>alert('Please Input Name, Description and Header');</script>");
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
               // Response.Write("<script language='javascript'>alert('Please Input Name, Description and Header');</script>");
            }

         
        }

        //protected void FileUploadButton_Click(object sender, EventArgs e)
        //{
        //    if (MyFileUpload.HasFile)
        //    {

        //        string filePath = Server.MapPath("~/File/");
        //        string fileName = MyFileUpload.PostedFile.FileName;
        //        MyFileUpload.SaveAs(filePath + fileName);
        //        Response.Write("<p >Uplode Success!</p>");
        //    }
        //    else
        //    {
        //        Response.Write("<p >Choose File!</p>");
        //    }
        //}

        
    }
}