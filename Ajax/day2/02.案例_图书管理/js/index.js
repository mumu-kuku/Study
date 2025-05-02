/**
 * 图书创建者的名称，用于请求图书列表时指定查询条件
 */
const creator = '木木'

/**
 * 获取并渲染图书列表
 * 1. 发送 AJAX 请求获取图书数据
 * 2. 将获取到的图书数据渲染到页面上
 */
function getBookList() {
  // 发送 Axios 请求，获取图书列表数据
  axios({
    // 请求的 API 地址
    url: 'https://hmajax.itheima.net/api/books',
    // 请求参数，指定图书创建者
    params: {
      creator
    }
  }).then(res => {
    // 测试响应数据
    // console.log(res)
    // 从响应数据中提取图书列表
    const list = res.data.data
    // 将图书列表转换为 HTML 字符串
    const htmlStr = list.map((item, index) => {
      // 从图书对象中解构出书名、作者和出版社
      const { id, bookname, author, publisher } = item
      // 为每本图书生成对应的表格行 HTML 代码
      return `<tr>
                <td>${index + 1}</td>
                <td>${bookname}</td>
                <td>${author}</td>
                <td>${publisher}</td>
                <td data-id="${id}">
                  <span class="del">删除</span>
                  <span class="edit">编辑</span>
                </td>
              </tr>`
    }).join('')
    // 将生成的 HTML 字符串插入到页面中类名为 list 的元素内
    document.querySelector('.list').innerHTML = htmlStr
  })
}

// 初始渲染
getBookList()

/**
 * 添加图书功能
 */

const addModalDom = document.querySelector('.add-modal')
const addModal = new bootstrap.Modal(addModalDom)

document.querySelector('.add-btn').addEventListener('click', () => {
  const addform = document.querySelector('.add-form')
  const addData = serialize(addform, { hash: true, empty: true })
  axios({
    url: 'https://hmajax.itheima.net/api/books',
    method: 'post',
    data: {
      ...addData,
      creator
    }
  }).then(res => {
    // console.log(res)
    getBookList()
    addform.reset()
    addModal.hide()
  })
})

/** 
 * 删除图书功能
 */

document.querySelector('.list').addEventListener('click', e => {
  if (e.target.classList.contains('del')) {
    // 测试点击对象
    // console.log(e.target)
    // 获取图书 id
    const theId = e.target.parentNode.dataset.id
    // 测试获取 id
    // console.log(theId)
    // 用 AJAX 连接服务器删除图书
    axios({
      url: `https://hmajax.itheima.net/api/books/${theId}`,
      method: 'DELETE'
    }).then(result => {
      console.log(result)
      getBookList()
    })
  }
})