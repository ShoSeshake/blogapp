$(function() {

  var search_list = $(".main-article");
  
  function appendArticle(article) {
     var html = `<a href="/articles/${article.id}">
                    <div class='main-article__list'>
                      <div class='main-article__list__title'>
                        ${article.title}
                      </div>
                      <div class='main-article__list__content'>
                        ${article.content} 
                      </div>
                      <div class='main-article__list__time'>
                        ${article.time}
                      </div>
                    </div>
                  </a>`
      search_list.append(html);
   }
  
   function appendErrMsgToHTML(msg) {
      var html = `<div class='main-article__list'>
                    <div class='main-article__list__error'>${ msg }</div>
                  </div>`
      search_list.append(html);
    }
  
    $(".side-bar__box__search").on("keyup", function() {
      var input = $(".side-bar__box__search").val();
      var href = window.location.href
      $.ajax({
        type: 'GET',
        url: href,
        data: { keyword: input },
        dataType: 'json'
      })
      .done(function(articles) {
        $(".main-article").empty();
        if (articles.length !== 0) {
          articles.forEach(function(article){
            appendArticle(article);
          });
        }
        else {
          appendErrMsgToHTML("一致する記事はありません");
        }
      })
      .fail(function() {
        alert('記事検索に失敗しました');
      })
    });
  });