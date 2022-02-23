# Script installation of Envault on Heroku

## Installation Guide
#### Setup project:
Login in heroku-cli
<pre><code>~> heroku login -i
</code></pre>

Execute the script:
<pre><code>~> sudo ./my-envault.sh
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

### The setup is completed!