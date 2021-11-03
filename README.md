# Bordeaux Montaigne IUT

Ce template Jekyll est basé sur le template des websites.

## Installation

```
bundle install
yarn install
```

### Gem

* Jekyll picture tag
* Jekyll minifier
* Jekyll paginate
* Jekyll sitemap

jekyll_picture_tag utilise libvips : https://libvips.github.io/libvips/install.html

## Media

_media/aba5aca4-0f58-4577-960d-4b60a773fdc2.md

```
---
name: Mon image.jpg
size: 2450
width: 2300
height: 1599
ratio: 1.438
url: https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image.jpg
---
```

_pages/index.html

```
---
title: Accueil
image: aba5aca4-0f58-4577-960d-4b60a773fdc2
---
```

On l'utilise avec :

```
{% include media.html id=page.image size="1920x1080" %}
```

Cela génère :

```html
<picture>
    <source>
    <img>
</picture>
```

## Syntaxe de transformation type Shopify

```
{% img | img_url: '500x500', crop: 'left', scale: 2, format: 'webp' %}
```

- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image.jpg
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x.jpg
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x500.jpg
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x500_crop_center.jpg
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image.webp
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x.webp
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x500.webp
- https://bordeauxmontaigne.osuny.org/media/aba5aca4-0f58-4577-960d-4b60a773fdc2/mon_image_500x500_crop_center.webp

## HTML

La variable text dans le frontmatter est livrée prête à l'emploi, sur la base d'une colonne de 900 px desktop max. Les images sont des src set type Kamifusen.
