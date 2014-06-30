diff --git a/Gemfile b/Gemfile
index 4d65765..1c241eb 100644
--- a/Gemfile
+++ b/Gemfile
@@ -48,3 +48,5 @@ gem 'rails_12factor', group: :production
 gem "twitter-bootstrap-rails"
 
 gem 'paperclip', github: 'thoughtbot/paperclip'
+
+gem 'tinymce-rails'
\ No newline at end of file
diff --git a/Gemfile.lock b/Gemfile.lock
index 8ae0f50..a1d84ee 100644
--- a/Gemfile.lock
+++ b/Gemfile.lock
@@ -126,6 +126,8 @@ GEM
     thor (0.19.1)
     thread_safe (0.3.4)
     tilt (1.4.1)
+    tinymce-rails (4.1.0)
+      railties (>= 3.1.1)
     treetop (1.4.15)
       polyglot
       polyglot (>= 0.3.1)
@@ -160,6 +162,7 @@ DEPENDENCIES
   sdoc (~> 0.4.0)
   spring
   sqlite3
+  tinymce-rails
   turbolinks
   twitter-bootstrap-rails
   uglifier (>= 1.3.0)
diff --git a/app/assets/javascripts/application.js b/app/assets/javascripts/application.js
index 2bc58e1..bac3154 100644
--- a/app/assets/javascripts/application.js
+++ b/app/assets/javascripts/application.js
@@ -15,4 +15,4 @@
 //= require twitter/bootstrap
 //= require turbolinks
 //= require_tree .
-//= require_tree ./tinymce
\ No newline at end of file
+//= require tinymce
\ No newline at end of file
diff --git a/app/views/articles/_form.html.erb b/app/views/articles/_form.html.erb
index 5febccd..913fffb 100644
--- a/app/views/articles/_form.html.erb
+++ b/app/views/articles/_form.html.erb
@@ -1,3 +1,4 @@
+<%= tinymce_assets %>
 <%= form_for @article , :html => { :multipart => true } do |f| %>
   <% if @article.errors.any? %>
   <div id="error_explanation">
@@ -17,7 +18,7 @@
  
   <p>
     <%= f.label :text %><br>
-    <%= f.text_area :text %>
+    <%= f.text_area :text , class: "tinymce" %>
   </p>
  
   <p>
@@ -26,4 +27,5 @@
   <p>
     <%= f.submit %>
   </p>
-<% end %>
\ No newline at end of file
+<% end %>
+<%= tinymce %>
\ No newline at end of file
diff --git a/app/views/comments/_form.html.erb b/app/views/comments/_form.html.erb
index 0d88b94..2357fdc 100644
--- a/app/views/comments/_form.html.erb
+++ b/app/views/comments/_form.html.erb
@@ -1,7 +1,7 @@
 <%= form_for([@article,@article.comments.build]) do |f| %>
 
 	<p>
-		<%= f.text_area :body %>
+		<%= f.text_area :body ,class: "tinymce" %>
 	</p>
 	<p>
 		<%= f.submit %>
diff --git a/app/views/layouts/application.html.erb b/app/views/layouts/application.html.erb
index 06b0238..fc4429a 100644
--- a/app/views/layouts/application.html.erb
+++ b/app/views/layouts/application.html.erb
@@ -5,12 +5,6 @@
   <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
   <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
   <%= csrf_meta_tags %>
-
-  <script type="text/javascript">
-    tinymce.init({
-        selector:"textarea"
-      });
-  </script>
 </head>
 <body>
 
