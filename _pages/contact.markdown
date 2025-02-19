---
layout: single
title: Kontakt
excerpt: Kde nás najdete
permalink: /contact/
---

<div class="contact-representatives-container">
  {%include contact-person.html
          name="Martina Bednář Dolečková"
          phone=site.data.contact.phone.martina
          email=site.data.contact.email.martina %}

  {%include contact-person.html
          name="Petra Dolečková"
          phone=site.data.contact.phone.petra
          email=site.data.contact.email.petra %}
</div>

## PROVOZOVNA
{%include contact-site.html
          address=site.data.contact.address.factory
          map=site.data.contact.map.factory %}

## FIREMNÍ PRODEJNA
{%include contact-site.html
          address=site.data.contact.address.store
          map=site.data.contact.map.store
          phone=site.data.contact.phone.store
          facebook=site.data.contact.facebook.store %}

---
