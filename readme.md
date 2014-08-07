RailsLanguageSwitcher
=====================

RailsLanguageSwitcher adds missing feature of user-clickable language switcher to your rails app even when you are using nested resources on your models and using rails-translate-routes and friendlyID gems for better SEO and user experience

read more about gems here:

[https://github.com/pebiantara/rails-translate-routes (working fork for rails 4 and up)](https://github.com/pebiantara/rails-translate-routes)
[https://github.com/norman/friendly_id](https://github.com/norman/friendly_id)

From version 0.1.3 Kaminari pagination gem is also handled: [https://github.com/amatsuda/kaminari](https://github.com/amatsuda/kaminari)

the initial problem that forced me to think about own solution is described here:

[https://github.com/francesc/rails-translate-routes/issues/1](https://github.com/francesc/rails-translate-routes/issues/1)


Example
-------

On my page I have blog section. Blog section have categories with articles. Article coluld be in many categories. Articles have commennts. Nested resources and associations are used here. 

original url without using gems for first article inside first category should look like this:

`mypage.sk/blogs/1/posts/1`

then switching locale should be trivial - rework current url to something like this:

`mypage.sk/en/blogs/1/posts/1`

but using mentioned gems it will looks like:

`mypage.sk/clanky/testovacia-kategoria/prvy-clanok`

`mypage.sk/en/blog/test-category/first-article`

rake routes:

```
 blogs_sk         GET /clanky(.:format)                             blogs#index {:locale=>"sk"}
 blogs_en         GET /en/blog(.:format)                            blogs#index {:locale=>"en"}
 blog_posts_sk    GET /clanky/:blog_id(.:format)                    posts#index {:locale=>"sk"}
 blog_posts_en    GET /en/blog/:blog_id(.:format)                   posts#index {:locale=>"en"}
 blog_sk          GET /clanky/:blog_id(.:format)                    posts#index {:locale=>"sk"}
 blog_en          GET /en/blog/:blog_id(.:format)                   posts#index {:locale=>"en"}
 blog_post_sk     GET /clanky/:blog_id/:post_id(.:format)           posts#show {:locale=>"sk"}
 blog_post_en     GET /en/blog/:blog_id/:post_id(.:format)          posts#show {:locale=>"en"}

```

then to show translated content, url needs to be also translated, but slugs for content are generated and stored in database, not in YAML like toplevel routes. If for example article is not translated yet, It will be accessed number value.  



