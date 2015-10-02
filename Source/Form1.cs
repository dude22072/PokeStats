using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Threading;

namespace pokestats
{
    public class Form1 : Form
    {
        Dictionary<string, Bitmap> images;
        Dictionary<string, string> settings;
        Dictionary<string, int> expgroups;

        bool severeError;
        int W, H, divider,offset;

        bool debug = false;
        Thread background;
        System.Timers.Timer locationChanger;

        Graphics lastGraphics;

        public Form1()
        {
            ClientSize = new Size(722, 86);
            offset = 0;
            W = ClientSize.Width;
            H = ClientSize.Height;
            divider = (W - 2 * offset) / 6;

            locationChanger = new System.Timers.Timer(100);
            locationChanger.AutoReset = false;
            locationChanger.Elapsed += locationChanger_Elapsed;

            try
            {
                reloadImages();
                reloadSettings();
                loadEXPgroups();
                DoubleBuffered = true;//prevents flickering
            }
            catch(Exception e)
            {
                File.WriteAllText("error.txt","Error in booting: "+e.Message);
                Environment.Exit(0);
            }
            lastGraphics = this.CreateGraphics();
            this.Paint += update;
            background =  new Thread(workerFunction);
            background.IsBackground = true;
            background.Start();

            this.KeyUp += Form1_KeyUp;
            this.ResizeEnd +=  Form1_ResizeEnd;
        }

        void Form1_ResizeEnd(object sender, EventArgs e)
        {
            writeSettings();
        }

        void writeSettings()
        {
            string[] settingsFileContents = new string[]
                {
                    "# Lines starting with a '#' are ignored.",
                    "# I'm quite literally loading the settings as <name>=<value> so don't mess that up!",
                    "# I'm overwriting this file everytime you resize or move the window. Your settings are saved, but any additional comments are gone!",
                    "# ",
                    "# The path to the pokestats file.",
                    "textFilePath="+settings["textFilePath"],
                    "# Window title",
                    "title="+settings["title"],
                    "# X coordinate (saved automaggically!)",
                    "X="+Location.X,
                    "# Y coordinate",
                    "Y="+Location.Y
                };
            File.WriteAllLines("settings.txt", settingsFileContents);
        }

        void locationChanger_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (this.InvokeRequired)
            {
                this.Invoke(new MethodInvoker(setLocation)) ;
            }
            else
                setLocation();
        }

        void setLocation()
        {
            Location = new Point(int.Parse(settings["X"]), int.Parse(settings["Y"]));
        }

        void Form1_KeyUp(object sender, KeyEventArgs e)
        {
            
            if(e.KeyCode == Keys.F5)
            {
                reloadImages();
                reloadSettings();
            }
        }

        private void workerFunction()
        {
            while(true)
            {
                Invalidate();
                Thread.Sleep(400);
            }
        }

        private void update(object sender, PaintEventArgs e)
        {
            try
            {
                if (!severeError)
                {
                    Graphics gr = e.Graphics;
                    gr.FillRectangle(Brushes.Black, 0, 0, this.ClientSize.Width, this.ClientSize.Height);
                    List<string> lines = new List<string>();
                    try
                    {
                        var fs = new FileStream(settings["textFilePath"], FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
                        using (var sr = new StreamReader(fs))
                        {
                            string s = "";
                            while ((s = sr.ReadLine()) != null)
                            {
                                lines.Add(s);
                            }
                        }

                        //lines = File.ReadAllLines(settings["textFilePath"]);

                    }
                    catch (Exception f)
                    {
                        lines.Add("An error has occured: " + f.Message);
                        File.WriteAllLines("error.txt", lines);
                        gr = lastGraphics;
                        return;
                    }
                    if (lines[0] == "None")//No pokemon
                    {
                        SizeF calcSize = gr.MeasureString("No Pokémon yet!", new Font("pokemon fireleaf", 20));
                        Point p = new Point((W / 2) - (int)(calcSize.Width / 2), (H / 2) - (int)(calcSize.Height / 2));
                        gr.DrawString("No Pokémon yet!", new Font("pokemon fireleaf", 20), Brushes.White, p);
                        return;
                    }
                    if (lines[0] == "")//uhm wat?
                    {
                        gr.DrawString("File empty!", new Font("pokemon fireleaf", 1), Brushes.White, 0, 0);
                    }

                    Pokemon mon;
                    Font font1 = new Font("pokemon fireleaf", 8f);
                    Font font2 = new Font("pokemon fireleaf", 10f);
                    for (int i = 0; i < 6; i++)
                    {
                        int k = i * 9;
                        try
                        {
                            mon = new Pokemon(lines[k], lines[k + 1], lines[k + 2], lines[k + 3], lines[k + 4], lines[k + 5], lines[k + 6], lines[k + 7], lines[k + 8], lines[56 + i]);
                        }
                        catch
                        {
                            continue;
                        }
                        if (mon.name != "")
                        {
                            int xpDiff = expNeeded(mon.level, expgroups[mon.species]);
                            mon.currentEXP = mon.currentEXP - xpDiff;
                            mon.expNeeded = expNeeded(mon.level + 1, expgroups[mon.species]) - xpDiff;
                            //yes this could've been calculated when it's needed, but I prefer it this way, I really thought about doing it a different way though.

                            k = offset + (i * divider);

                            //Sprite
                            if (images.ContainsKey(mon.species))
                                gr.DrawImage(images[mon.species], new Point(k, 0));
                            else
                                gr.DrawImage(images["None"], new Point(k, 0));

                            //Name
                            gr.DrawString(mon.name, font1, Brushes.White, k + 70, 2);

                            //Level
                            gr.DrawString("Lvl: " + mon.level, font2, Brushes.White, k + 70, 14);

                            //item
                            if (mon.item)
                                gr.DrawImage(images["ITEM"], k + 113, 18);

                            //gender (doesn't work? or all pokemon are genderless)
                            if (mon.gender == 1)
                                gr.DrawImage(images["GENDERMALE"], k + 59, 49);
                            if (mon.gender == 2)
                                gr.DrawImage(images["GENDERFEMALE"], k + 59, 49);

                            //Statusses
                            gr.DrawImage(images[mon.fntStatus], k + 72, 32);
                            gr.DrawImage(images[mon.pkrsStatus], k + 93, 32);
                            gr.DrawImage(images[mon.slpStatus], k + 72, 44);
                            gr.DrawImage(images[mon.psnStatus], k + 93, 44);
                            gr.DrawImage(images[mon.brnStatus], k + 72, 56);
                            gr.DrawImage(images[mon.parStatus], k + 93, 56);
                            gr.DrawImage(images[mon.frzStatus], k + 72, 68);

                            //hpbar
                            gr.DrawImage(images["BARhpGRAY"], k, 60, 70, 9);
                            if (mon.curHP != 0)
                            {
                                double hpFract = (double)mon.curHP / (double)mon.maxHP;
                                string hpColor = "GREEN";
                                if (hpFract < 0.5)
                                    hpColor = "YELLOW";
                                if (hpFract < 0.25)
                                    hpColor = "RED";
                                gr.DrawImage(images["BARhp" + hpColor], k + 15, 60, (int)(56 * hpFract), 9);
                            }
                            gr.DrawImage(images["BAR"], k - 1, 60);

                            //xp bar
                            gr.DrawImage(images["BARexpBACK"], k + 16, 71);
                            if (mon.expNeeded != 0)
                                gr.DrawImage(images["BARexpBLUE"], k + 16, 71, (float)((double)mon.currentEXP / (double)mon.expNeeded) * 48, 4);
                            gr.DrawImage(images["BARexpFRAME"], k, 70);
                        } //end of the if
                    }//end of the forloop

                    lastGraphics = gr;
                }
            }
            catch (Exception exc)
            {
                File.Copy(settings["textFilePath"], "pokestatsSOURCEOFPROBLEM.txt");
                File.WriteAllText("error.txt", "Error occured when drawing new screen: "+exc.Message);
            }
        }

        private int expNeeded(int level, int expGroup)
        {
            double value = 0;
            double lvl = (double)level;
            switch (expGroup)
            {
                case 1: 
                    value = (5 * Math.Pow(lvl, 3)) / 4;
                    break;
                case 2:
                    value = (1.2d * Math.Pow(lvl, 3)) - 15 * Math.Pow(lvl, 2) + (100 * lvl) - 140;
                    break;
                case 3:
                    value = Math.Pow(lvl, 3);
                    break;
                case 4: 
                    value = (4 * Math.Pow(lvl, 3)) / 5; 
                    break;
                case 5:
                    if (lvl < 50)
                        value = Math.Pow(lvl, 3) * (100 - lvl) / 50;
                    else if (lvl < 68)
                        value = Math.Pow(lvl, 3) * (150 - lvl) / 100;
                    else if (lvl < 98)
                        value = Math.Pow(lvl, 3) * ((1901 - lvl) / 3) / 500;
                    else//finally
                        value = Math.Pow(lvl, 3) * (160 - lvl) / 100;
                    break;
                case 6:
                    if (lvl < 15)
                        value = Math.Pow(lvl, 3) * ((((lvl + 1) / 3) + 24) / 50);
                    else if (lvl < 36)
                        value = Math.Pow(lvl, 3) * (lvl + 14) / 50;
                    else
                        value = Math.Pow(lvl, 3) * (((lvl / 2) + 32) / 50);
                    break;
            }
            return (int)value;
        }
        void reloadSettings()
        {
            settings = new Dictionary<string, string>();
            bool exists = false;
            if(File.Exists("settings.txt"))
            {
                string[] lines = File.ReadAllLines("settings.txt");
                string[] split;
                exists = true;
                foreach(string line in lines)
                {
                    if(line.StartsWith("#") || line.Length == 0)
                    {
                        continue;
                    }
                    split = line.Split(new Char[] {'='}, 2, StringSplitOptions.None);
                    settings.Add(split[0], split[1]);
                    Invalidate();
                }
            }
            else
            {
                settings["Title"] = "Pokestats Display - Harb's Version";
                settings["textFilePath"] = "z:/pokestats.txt";
                settings["X"] = 0 + "";
                settings["Y"] = 0 + "";
                writeSettings();
            }
            try
            {
                Text = settings["title"];
                string s = settings["textFilePath"];
                locationChanger.Stop();
                locationChanger.Start();
            }
            catch
            {
                Text = "Settings borked! Fix those and restart!";
                severeError = true;
            }
            if (!exists)
                Text = "Please check the settings.txt and press F5!";
        }

        void loadEXPgroups()
        {
            expgroups = new Dictionary<string, int>();
            if(File.Exists("expGroups.txt"))
            {
                string[] split;
                string[] lines = File.ReadAllLines("expGroups.txt");
                foreach(string line in lines)
                {
                    split = line.Split(new char[] { '=' }, 2, StringSplitOptions.None);
                    expgroups.Add(split[0], int.Parse(split[1]));
                }
            }
        }

        void reloadImages()
        {
            images = new Dictionary<string, Bitmap>();
            List<string> debugString = new List<string>();
            string[] folders = { "Barfix", "nstatus", "sprites", "ssprites", "status" };
            foreach (string folder in folders)
            {
                debugString.Add("FOLDER: "+folder);
                foreach (string s in Directory.GetFiles(folder + "/"))
                {
                    addImage(getName(s), s);
                    if (debug)
                        debugString.Add(getName(s) + " :: " + s);
                }
            }
            if (debug)
                File.WriteAllLines("DEBUG.txt", debugString.ToArray());
        }

        string getName(string input)
        {
            string output = "";
            for (int i = input.Length - 1; i >= 0; i--)
            {
                if (input[i] == '/' || input[i] == '\\' )
                {
                    break;
                }
                output = input[i] + output;
            }
            int extensionLength = 0;
            for (int i = output.Length -1; i >= 0; i-- )
            {
                extensionLength++;
                if(output[i] == '.')
                    break;
            }
                return output.Substring(0,output.Length-extensionLength);
        }

        void addImage(string name, string path)
        {
            images.Add(name, new Bitmap(path));
        }

        private class Pokemon
        {
            public string species, name;
            public int curHP, maxHP, level, currentEXP, expNeeded, gender;
            public bool item;

            public string fntStatus, pkrsStatus, frzStatus, psnStatus, slpStatus, brnStatus, parStatus;


            public Pokemon(string _species, string _name, string _curHP, string _maxHP, string _curLevel, string _status, string _pokerus, string _item, string _currentExp, string _gender)
            {
                if (_species == "None" || _species == "0")
                {
                    name = "";
                    curHP = 1;
                    maxHP = 1;
                    level = -1;
                    currentEXP = 0;
                    item = false;
                    expNeeded = 0;
                    gender = 0;
                }
                else
                {
                    species = _species;
                    name = _name;
                    curHP = int.Parse(_curHP);
                    maxHP = int.Parse(_maxHP);
                    level = int.Parse(_curLevel);
                    currentEXP = int.Parse(_currentExp);
                    pkrsStatus = (_pokerus == "0") ? "nPKRS" : "PKRS";
                    fntStatus = (curHP == 0) ? "FNT" : "nFNT";
                    item = (_item == "0") ? false : true;
                    gender = int.Parse(_gender); 

                    byte rawStatus = byte.Parse(_status);
                    if ((rawStatus & (byte)64) > 0)
                        parStatus = "PAR";
                    else
                        parStatus = "nPAR";

                    if ((rawStatus & (byte)32) > 0)
                        frzStatus = "FRZ";
                    else
                        frzStatus = "nFRZ";

                    if ((rawStatus & (byte)16) > 0)
                        brnStatus = "BRN";
                    else
                        brnStatus = "nBRN";

                    if ((rawStatus & (byte)8) > 0)
                        psnStatus = "PSN";
                    else
                        psnStatus = "nPSN";

                    if ((rawStatus & (byte)7) > 0)
                        slpStatus = "SLP";
                    else
                        slpStatus = "nSLP";
                }


            }
        }

    }
}
