using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using NLua;
using System.Threading;


namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        LuaClass luaTestClass;
        public Form1()
        {
            InitializeComponent();                        
        }

        private void Form1_Load(object sender, EventArgs e)
        {
                                  
        }

        private void button13_Click(object sender, EventArgs e)
        {
            luaTestClass = new LuaClass();
            luaTestClass.init();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            luaTestClass.LuaThreadSeq = "초기화-객체생성";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string script_directory = "C:/Users/HHI/Desktop/test/testScript.lua";
            string current_script_description = "For Test";
            luaTestClass.registerScript(script_directory, current_script_description);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int status = luaTestClass.startScript();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            luaTestClass.test2();
        }
    }

    public class LuaClass // Lua Thread 객체 생성하고 관리하는 클래스
    {
        string script_directory = "";
        private string current_script_directory = "";
        string current_script_description = "";
        string lua_helper_function_directory = "\";C:/HHIAutomation/OpenBlockWeldingRobot_Server/LuaLibs/?.lua\"";
       
        public Lua LuaObject;

        private bool threadContinue;
        public Thread LuaThread;
        public Thread LuaExecutionThread;
        public LuaHelper Helper;

        public string LuaThreadSeq = "대기";
        private string LuaExecutionSeq = "대기";
        
        public LuaClass()
        {

        }
        public void test2()
        {
            Console.WriteLine(LuaObject["first"]);
        }

        /*public RobotPoseData GetRobotPoseData(string name)
        {
            RobotPoseData output = Helper.LuaToClass_RobotPoseData(LuaObject[name]);
            return output;
        }*/



        public void init()
        {
            threadContinue = true;
            LuaThread = new Thread(new ThreadStart(luathreadfunc));
            LuaExecutionThread = new Thread(new ThreadStart(luaexecutionfunc));
            LuaThread.Start();
            LuaExecutionThread.Start();

        }
        public int startScript()
        {
            if (LuaThreadSeq == "메인-스크립트실행대기")
            {
                LuaThreadSeq = "메인-스크립트실행";
                return 1;
            }
            else
            {
                Console.WriteLine("스크립트 로드부터 하셈");
                return 0;
            }
        }
        public void registerScript(string script_directory_, string description = "")
        {
            if (LuaThreadSeq == "메인-스크립트로드대기")
            {
                script_directory = script_directory_;
                current_script_description = description;
                LuaThreadSeq = "메인-스크립트로드시도";
            }
            else
            {
                Console.WriteLine("스크립트 로드부터 하셈");
            }
        }


        public void luathreadfunc()
        {
            while (threadContinue)
            {
                switch (LuaThreadSeq)
                {
                    case "대기":
                        break;
                    case "초기화-객체생성":
                        LuaExecutionSeq = "초기화-객체생성";
                        LuaThreadSeq = "초기화-객체생성대기";
                        break;
                    case "초기화-객체생성대기":
                        if (LuaExecutionSeq == "초기화-객체생성완료")
                        {
                            Console.WriteLine("객체 생성 완료!");
                            LuaThreadSeq = "초기화-라이브러리등록";
                        }
                        break;
                    case "초기화-라이브러리등록":
                        LuaExecutionSeq = "초기화-라이브러리등록";
                        LuaThreadSeq = "초기화-라이브러리등록대기";
                        break;
                    case "초기화-라이브러리등록대기":
                        if (LuaExecutionSeq == "초기화-라이브러리등록완료")
                        {
                            LuaThreadSeq = "초기화-헬퍼함수등록";
                            Console.WriteLine("라이브러리 등록 완료!");
                        }
                        break;
                    case "초기화-헬퍼함수등록":
                        LuaExecutionSeq = "초기화-헬퍼함수등록";
                        LuaThreadSeq = "초기화-헬퍼함수등록대기";
                        break;
                    case "초기화-헬퍼함수등록대기":
                        if (LuaExecutionSeq == "초기화-헬퍼함수등록완료")
                        {
                            Console.WriteLine("헬퍼 함수 등록 완료!");
                            Console.WriteLine("스크립트 로드 대기 중!");
                            LuaThreadSeq = "메인-스크립트로드대기";
                            LuaExecutionSeq = "메인-스크립트로드대기";
                        }
                        break;
                    case "메인-스크립트로드대기":
                        break;
                    case "메인-스크립트로드시도":
                        if (LuaExecutionSeq == "메인-스크립트로드대기")
                        {
                            LuaThreadSeq = "메인-스크립트등록대기";
                            LuaExecutionSeq = "메인-스크립트등록";
                        }
                        break;
                    case "메인-스크립트등록대기": 
                        if (LuaExecutionSeq == "메인-스크립트등록완료")
                        {
                            Console.WriteLine("스크립트 등록 완료!");
                            Console.WriteLine("스크립트 실행 대기 중!");
                            LuaThreadSeq = "메인-스크립트등록완료";
                        }
                        break;
                    case "메인-스크립트등록완료":
                        LuaThreadSeq = "메인-스크립트실행대기";
                        break;
                    case "메인-스크립트실행대기":
                        break;
                    case "메인-스크립트실행":
                        Console.WriteLine("스크립트 실행 시작!");
                        LuaExecutionSeq = "메인-스크립트실행";
                        LuaThreadSeq = "메인-스크립트실행중";
                        break;
                    case "메인-스크립트실행중":
                        //Console.WriteLine(Helper.getCurrentStatus());
                        if (LuaExecutionSeq == "메인-스크립트실행완료")
                        {
                            LuaThreadSeq = "메인-스크립트실행완료";
                        }
                        else if (LuaExecutionSeq == "메인-스크립트실행실패")
                        {
                            Console.WriteLine("에러발생 에러발생");
                            LuaThreadSeq = "메인-스크립트로드대기";
                            LuaExecutionSeq = "메인-스크립트로드대기";
                        }
                        break;
                    case "메인-스크립트실행완료":
                        Console.WriteLine("스크립트 실행 완료!");
                        LuaThreadSeq = "메인-스크립트로드대기";
                        break;
                    default:
                        break;
                }
                Thread.Sleep(100);
            }
        }

        public void luaexecutionfunc()
        {
            while (threadContinue)
            {
                switch (LuaExecutionSeq)
                {
                    case "대기":
                        break;
                    case "초기화-객체생성":
                        LuaObject = new Lua();
                        LuaExecutionSeq = "초기화-객체생성완료";
                        break;
                    case "초기화-객체생성완료":
                        break;
                    case "초기화-라이브러리등록":
                        string library_directory = "package.path = package.path .. " + lua_helper_function_directory;
                        LuaObject.DoString(library_directory);
                        LuaExecutionSeq = "초기화-라이브러리등록완료";
                        break;
                    case "초기화-라이브러리등록완료":
                        break;
                    case "초기화-헬퍼함수등록":
                        Helper = new LuaHelper(LuaObject);
                        LuaObject["Helper"] = Helper;
                        LuaExecutionSeq = "초기화-헬퍼함수등록완료";
                        break;
                    case "초기화-헬퍼함수등록완료":
                        break;
                    case "메인-스크립트로드대기":
                        break;
                    case "메인-스크립트등록":
                        if (System.IO.File.Exists(script_directory))
                        {
                            current_script_directory = script_directory;
                            LuaExecutionSeq = "메인-스크립트등록완료";
                        }
                        break;
                    case "메인-스크립트등록완료":
                        LuaExecutionSeq = "메인-스크립트실행대기";
                        break;
                    case "메인-스크립트실행대기":
                        break;
                    case "메인-스크립트실행":
                        try
                        {
                            LuaObject.DoFile(current_script_directory);
                            LuaExecutionSeq = "메인-스크립트실행완료";
                        }
                        catch (NLua.Exceptions.LuaScriptException ex)
                        {
                            Console.WriteLine(ex.Message);
                            LuaExecutionSeq = "메인-스크립트실행실패";
                        }
                        break;
                    case "메인-스크립트실행완료":
                        LuaExecutionSeq = "메인-스크립트로드대기";
                        break;
                    case "메인-스크립트실행실패":
                        break;
                    default:
                        break;
                }
                Thread.Sleep(100);
            }
        }
    } 

    public class LuaHelper // Lua 에서 부르는 함수들 구현해 놓는 파트
    {
        /// <summary>
        /// 상태변수, 이거 업데이트 해주고 LuaThread에서는 실행중일 때 이거 접근해서
        /// 현재 상태 알아내는 방식으로 구현할 예정
        /// </summary>
        private string current_status = "";
        public Lua LubObject_; 

        public LuaHelper(Lua LuaObj)
        {
            LubObject_ = LuaObj;
            init();
        }

        public string getCurrentStatus()
        {
            return current_status;
        }
        public void init()
        {
            
        }

        public void MOVE(LuaTable RobotPoseData, int speed)
        {
            /*int i = 0;
            while(true)
            {
                //Console.WriteLine("hello from the other script");
                current_status = "My name is " + Convert.ToString(i);
                i++;
                Thread.Sleep(50);
            }*/
        }

        public void WELD()
        {

        }

        /*private RobotPoseData LuaToClass_RobotPoseData(LuaTable input)
        {
            int PoseType_ = input["PoseType"];
            double speed_ = input["Speed"];
            double f1_ = input["f1"];
            double f2_ = input["f2"];
            double f3_ = input["f3"];
            double f4_ = input["f4"];
            double f5_ = input["f5"];
            double f6_ = input["f6"];
            RobotPoseData output = new RobotPoseData(PoseType_, speed_, f1_, f2_, f3_, f4_, f5_, f6_);
            return output;
        }*/
        
        public void ClassToLua_RobotPoseData(int input)
        {
            //LubObject_.DoString("print('hello')");
        }

    }
}

