---
title: GALERIE
layout: splash
permalink: /gallery/
---

<div class="gallery-image-grid">
{% for img in page.gallery %}
<div>
<a href="{{ img.image_path | relative_url }}" class="image-popup" >
<figure>
<img src="{{ img.image_path | relative_url }}" alt="Image">
<!--
<figcaption>{{ img.caption }}</figcaption>
-->
</figure>
</a>
</div>
{% endfor %}
</div>
