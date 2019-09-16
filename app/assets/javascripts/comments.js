$(function(){
  function buildHTML(comment){
    var html = `<li class='comment-box__list__text'>
                  <a href="/users/${comment.user_id}">${comment.user_name}
                    ：
                  </a>${comment.text}
                </li>`
    return html;
  }
  // コメントフォーム
  // function buildForm(comment){
  //     var html = `<form class="new_comment" id="new_comment" action="${window.location.href}/comments" accept-charset="UTF-8" method="post">
  //                   <input name="authenticity_token" type="hidden" class="comment-form__hidden">
  //                   <div class='comment-form__box'>
  //                     <textarea class="comment-form__box__comment" placeholder="コメントを入力してください" name="comment" id="comment_comment"> </textarea>
  //                     <div class='comment-form__box__submit'>
  //                       <input type="submit" name="commit" value="投稿する" class="comment-form__box__submit__btn" />
  //                     </div>
  //                   </div>
  //                 </form>`
  //     return html;
  // }
  // $('#comment_button').click(function(data){
  //   var html = buildForm(data);
  //   $('.comment-button').remove('');
  //   $('.comment-form').append(html)
  // })
  
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href + '/comments'
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comment-box__list').append(html);
      $('form')[0].reset('');
    })
    .fail(function(){
      alert('error');
    })
  })
});