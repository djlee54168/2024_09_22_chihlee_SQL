# 主程式
from dotenv import load_dotenv
import streamlit as st
from time import sleep
from procedure import get_data
load_dotenv()

@st.dialog('目前發生問題，請稍後再試')
def alert():
        st.write('連線有問題')
        st.stop()

with st.spinner('下載資料中...'):
        get_data()
alert()
st.write('顯示頁面')




    # st.success('下載完成',icon='✅') # 直接將圖示貼至''中
    # st.success('下載完成',icon=':material/delete:') # 來源：https://fonts.google.com/icons

