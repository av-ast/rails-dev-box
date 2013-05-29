#encoding: utf-8

name "rails-dev-box"

description "Chef role for virtual machine setup"

run_list [
  "recipe[apt]",
  "recipe[repos]",
  "recipe[ark]",
  "recipe[locale]",
  "recipe[nfs]",
  "recipe[tmux]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]",
  "recipe[postgresql::server]",
  "recipe[postgresql::libpq]",
  "recipe[redis]",
  "recipe[x264::source]",
  "recipe[ffmpeg::source]",
  "recipe[java]",
  "recipe[elasticsearch]",
]

default_attributes(
  :locale => {
    :lang => "en_US.UTF-8",
    :language => "en_US.UTF-8",
    :lc_all => "en_US.UTF-8"
  },
  :rbenv => {
    :user_installs => [
      {
        :user => "vagrant",
        :rubies => ["1.9.3-p194"],
        :global => "1.9.3-p194",
        :gems => {
          "1.9.3-p194" => [
            { :name => "bundler" }
          ]
        }
      }
    ]
  },
  :authorization => {
    :sudo => {
      :users => ["vagrant"],
      :passwordless => true
    }
  },
  :x264 => {
    :compile_flags => [
      "--enable-static",
      "--disable-asm"
    ]
  },
  :elasticsearch => {
    :plugins => {
      "mobz/elasticsearch-head" => {},
      "lukas-vlcek/bigdesk" => {},
    }
  }
)

override_attributes(
  :postgresql => {
    :password => {
      :postgres => ''
    },
    :pg_hba => [
      {:type => "local", :db => "all", :user => "postgres", :addr => "",             :method => "trust" },
      {:type => "local", :db => "all", :user => "all",      :addr => "",             :method => "trust" },
      {:type => "host",  :db => "all", :user => "all",      :addr => "127.0.0.1/32", :method => "trust" },
      {:type => "host",  :db => "all", :user => "all",      :addr => "::1/128",      :method => "trust" },
      {:type => "host",  :db => "all", :user => "postgres", :addr => "127.0.0.1/32", :method => "trust" },
      {:type => "host",  :db => "all", :user => "vagrant",  :addr => "127.0.0.1/32", :method => "trust" }
    ]
  }
)
