# Envault on Heroku

## Installation Guide
#### Setup project:
Login in heroku-cli
<pre><code>~> heroku login -i
</code></pre>

Choose a location to install your own Envault server. That can be a repository github.
<pre><code>~> mkdir my-envault
~> git clone git@github.com:envault/envault.git // cloning official app
~> cd envault
~> cp `ls -A | grep -v ".git"` ../my-envault    // copy almost everything -> my-envault
~> cp .github .gitignore ../my-envault          // copy ignored files -> my-envault
~> cd ../my-envault
</code></pre>

If your directory is not a repository github, do:
<pre><code>~> git init
</code></pre>

Now, we are going to setup the installation.
<pre><code>~> touch Procfile                               // configuration file for heroku
~> echo "web: vendor/bin/heroku-php-apache2" > Procfile
~> cp .env.example .env                         // create an env
~> sed -i '/mysql/pgsql/' .env 					// replace the default database
~> sed -i "s/'default' => env('DB_CONNECTION', 'mysql')/'default' => env('DB_CONNECTION', 'pgsql')/" config/database.php
~> heroku create my-envault --region=eu         // create an application on heroku
~> php artisan key:generate
</code></pre>

If your are an error right here, on the generation of the APP_KEY, check your php version (php --version) and try this:
<pre><code>~> composer clearcache                          // clearing your composer cache
~> composer require laravel/sail:* --dev        // overwrite the composer.json
~> composer update --ignore-platform-reqs
</code></pre>
If the problems persists, [contact me](mailto:anthony.vienne@epitech.eu) or search your problem in Source part.
Go on [Heroku dashboard](https://dashboard.heroku.com/apps/), select your application, go in **Ressources**.
<img src="https://cdn.discordapp.com/attachments/664086664007909376/945537317987291146/Screenshot_from_2022-02-10_14-06-52.png" alt="alt text" title="image Title" />
In the research bar, type: **Heroku Postgres** and add it to your projet with the **Free plan**.
<img src="https://cdn.discordapp.com/attachments/664086664007909376/945537318285082624/Screenshot_from_2022-02-10_14-07-24.png" alt="alt text" title="image Title" />

Stay in the **dashboard** and go to **setting**.
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941389312514211850/Screenshot_from_2022-02-10_21-29-27.png" alt="alt text" title="image Title" />

Get in **Domains** your URL.
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941389312782659614/Screenshot_from_2022-02-10_21-32-27.png" alt="alt text" title="image Title" />

Set **basics variables** on heroku:
<pre><code>~> heroku config:add APP_DEBUG=true
~> heroku config:add APP_NAME=Envault
~> heroku config:add APP_URL=your_URL
~> heroku config:add APP_KEY=KEY_GENERATE_IN_.ENV
</code></pre>

**Value of the database**
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941414649549713418/Untitled.png" alt="alt text" title="image Title" />

Set **database variables** on heroku:
<pre><code>~> heroku config:add DATABASE_URL=connection_URL_FROM_credentials
~> heroku config:add DB_CONNEXION=pgsql
~> heroku config:add DB_DATABASE=dbname_FROM_credentials
~> heroku config:add DB_HOST=host_FROM_credentials
~> heroku config:add DB_PASSWORD=password_FROM_credentials
~> heroku config:add DB_PORT=port_FROM_credentials
~> heroku config:add DB_USERNAME=user_FROM_credentials
</code></pre>

Go on **mailgun dashboard** and click on the **link** right of the flag.
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941414647775510568/Screenshot_from_2022-02-10_22-35-30.png" alt="alt text" title="image Title" />

Add your mail in the **Email Address** and click on **select in SMTP section.**
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941414648345939978/Screenshot_from_2022-02-10_22-35-40.png" alt="alt text" title="image Title" />

Now, you can see **Mailgun Information** to add in the **Config Vars** of heroku.
<img
src="https://cdn.discordapp.com/attachments/664086664007909376/941414649096712233/Screenshot_from_2022-02-10_22-36-27.png" alt="alt text" title="image Title" />

Set in command line:
<pre><code>~> heroku config:add MAIL_USERNAME=(Username)
~> heroku config:add MAIL_PASSWORD=(Default password)
~> heroku config:add MAIL_FROM_ADDRESS=(Your Mail Address)
</code></pre>

### Push on git
<pre><code>~> git add .
~> git commit -m "Initialisation"
~> git push heroku < default-branch >       // if you do git init
				or
~> git push origin < default-branch > 		// if you clone your repository
</code></pre>

### Last command
<pre><code>~> heroku run php artisan migrate
</code></pre>

### The setup is completed!
