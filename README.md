# epub-maker-for-reddit
Converting self posts into epub file

Prerequisite:

 `ruby > 2.4.1`

To use:

Populate _config.yaml.template_ with your own data

Change the populated _config.yaml.template_ to _config.yaml_

`bundle install`

`rake create` 

follow the prompt.


TO-DO: 

* support creating comment threads. (This requires force_load and should take longer to create)
* support NSFW tag
* add image support