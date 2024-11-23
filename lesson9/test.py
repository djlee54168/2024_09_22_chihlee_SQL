# 主程式
from dotenv import load_dotenv
import streamlit as st
from time import sleep
from procedure import get_data
load_dotenv()
placeholder = st.empty()
with placeholder:
    with st.spinner('下載資料中...'):
        get_data()

    st.success('下載完成',icon='✅') # 直接將圖示貼至''中
    # st.success('下載完成',icon=':material/delete:') # 來源：https://fonts.google.com/icons
    sleep(2)
placeholder.empty()