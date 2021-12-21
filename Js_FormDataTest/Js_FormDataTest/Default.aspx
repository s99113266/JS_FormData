<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Js_FormDataTest._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- /PostPage1.ashx 接收後返回的值-->
    <div id="form1return"></div>

    <!-- 將資料傳送到 /PostPage1.ashx -->
    <button type="button">傳送</button>

    <script>
        function getURL(files) {
            return `${location.protocol}//${location.host}/${files}`;
        }

        /*
         * [new FormData()] 
         * 建立一個新的 FormData 物件。
         * 
         * [FormData.append(欄位name, 內容)]
         * 建立欄位
         * 
         * [FormData.delete(欄位name)]
         * 刪除欄位
         * 
         * [FormData.get(欄位name)]
         * 多個同name的欄位回傳第一個找到的欄位其內容。
         * 
         * [FormData.getAll(欄位name)]
         * 回傳所有同name欄位的內容(陣列)
         * 
         * [FormData.has(欄位name)]
         * 尋找有沒有此欄位回傳bool
         * 
         * 
         * [FormData.values()]
         * 回傳所有欄位的值，可以用 for..of 取出
         * for(let i of FormData.values()){
         *     console.log(i);
         * };
         * 
         * [FormData.set(欄位name, 內容)] or [FormData.set(欄位name, 內容, file(blob對象))]
         * 跟 [FormData.append(欄位name, 內容)] 很像，但不同在於，如果有同anme的欄位將會覆蓋所以欄位的值，沒有的話將會創建
         * 
         * [FormData.keys()]
         * 找到所有的欄位並取得name
         * 
         * [FormData.entries()]
         * 一樣可以找到所有欄位，但可以同時取得name以及值
         * 
         * [FormData.keys()] 跟 [FormData.entries()]
         * 都可以使用 for..of 取出資料
         * 
         * for(let item of FormData.entries()){
         *     console.log(`name:${item[0]} / value:${item[1]}`);
         * };
         * 
         * */


        var form1 = () => {
            let divobj;
            if (window.XMLHttpRequest) {
                console.log("Ajax 環境可以正常執行");
                divobj = document.querySelector("#form1return");
            } else {
                console.log("不支持 Ajax 環境");
                return;
            }
            let xmlHttp, ajaxform;
            ajaxform = new FormData();
            ajaxform.append("inputname", "is123");
            ajaxform.append("inputname", "isok");

            xmlHttp = new XMLHttpRequest();
            xmlHttp.addEventListener("readystatechange", () => {
                switch (xmlHttp.status) {
                    case 0:
                        break;
                    case 200:
                        console.log(`狀態:${xmlHttp.status} / 狀態返回:${xmlHttp.readyState}`);
                        if (xmlHttp.readyState == 4) { divobj.innerHTML = xmlHttp.responseText; };
                        break;
                    default:
                        console.log("其他?");

                }
            });
            xmlHttp.open("POST", getURL("/PostPage1.ashx"));
            xmlHttp.send(ajaxform);
        };
        window.onload = () => {
            document.querySelectorAll("button")[0].addEventListener("click", () => {
                form1();
            });
        };

        /* 
         * HTTP 狀態碼
         * [XMLHttpRequest.status]
         * 參考: https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Status
         *
         *
         * Ajax 狀態
         * [XMLHttpRequest.readyState]
         * ---------------------------------------------------------------
         * 0	UNSENT	客戶端已被建立，但 open() 方法尚未被呼叫。
         * [UNSENT]
         * XMLHttpRequest 客戶端物件已被建立，但 open() 方法尚未被呼叫。
         * ---------------------------------------------------------------
         * 1	OPENED	open() 方法已被呼叫。
         * [OPENED]
         * open() 方法已被呼叫。於此狀態時，可以使用 setRequestHeader() 方法設定請求標頭（request headers），並可呼叫 send() 方法來發送請求。
         * ---------------------------------------------------------------
         * 2	HEADERS_RECEIVED	send() 方法已被呼叫，而且可取得 header 與狀態。
         * [HEADERS_RECEIVED]
         * send() 方法已被呼叫，並且已接收到回應標頭（response header）。
         * ---------------------------------------------------------------
         *
         * 3	LOADING	回應資料下載中，此時 responseText 會擁有部分資料。
         * [LOADING]
         * 正在接收回應內容（response's body）。如 responseType (en-US) 屬性為 "text" 或空字串，則 responseText 屬性將會在載入的過程中擁有已載入部分之回應（response）內容中的文字。
         * ---------------------------------------------------------------
         * 4	DONE	完成下載操作。
         * [DONE]
         * 請求操作已完成。這意味著資料傳輸可能已成功完成或是已失敗。
         * ---------------------------------------------------------------
         * */
    </script>

</asp:Content>
