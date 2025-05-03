const creator = '木木'
/**
 * 模块1：信息渲染
 *  1.1 获取用户的数据
 *  1.2 回显数据到标签上
 * */
axios({
  url: 'https://hmajax.itheima.net/api/settings',
  params: {
    creator
  }
}).then(res => {
  // console.log(res)
  data = res.data.data
  // console.log(data)
  Object.keys(data).forEach(k => {
    if (k === 'avatar') {
      document.querySelector('.prew').src = data[k]
      return
    }
    else if (k === 'gender') {
      const genders = document.querySelectorAll('.gender')
      genders[data[k]].checked = true
      return
    }
    document.querySelector(`.${k}`).value = data[k]
  })

})

/** 
 * 模块2：头像设置
 *  2.1 获取选择的图片
 *  2.2 将图片上传到服务器
 *  2.3 修改头像的src
 */
document.querySelector('.upload').addEventListener('change', e => {
  const fd = new FormData()
  fd.append('avatar', e.target.files[0])
  fd.append('creator', creator)

  axios({
    url: 'https://hmajax.itheima.net/api/avatar',
    method: 'PUT',
    data: fd
  }).then(res => {
    const imgAvatar = res.data.data.avatar
    document.querySelector('.prew').src = imgAvatar
    // console.log(res)
  })
})

/** 
 * 模块3：修改信息
 *  3.1 获取input的值
 *  3.2 提交到服务器
 */
document.querySelector('.submit').addEventListener('click', () => {
  const formDom = document.querySelector('.user-form')
  const form = serialize(formDom, { hash: true, empty: true })
  // console.log(form)
  form.gender = +form.gender
  axios({
    url: 'https://hmajax.itheima.net/api/settings',
    method: 'PUT',
    data: {
      ...form,
      creator
    }
  }).then(res => {
    const toastDom = document.querySelector('.my-toast')
    const toast = new bootstrap.Toast(toastDom)
    // console.log(toast)
    toast.show()
  })
})