Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13546EC9B
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957277; cv=pass; b=VrNQKLOnbA1G4sGpX+XQz3s0bfVA6PByuwfjfSxaw4H3lXhZK4puvEj9MmQ9F9u2cQ53kFttl1cKkd+gWM3zvxKIzD+pr1wvDIfzXw8m34hkxkjEyalhNPy1/IGkeKoClh98eRi23IgCS3NWnhRjham5ZmbD2KnKAh82lkURydU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957277; c=relaxed/simple;
	bh=nEN1DIepvzc1Fgr9k7isyGujerQNKYhNcd2jD7tCdaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8t4bFP3f5TJAYQFLeUm0xVkHOiJlGwBjZbSccyQ5Vt33lgEHZyRTwxQ8XBeh1lLjwfNRC6tUvOILK6T7jCrhghTi0+wpSLMTJbUf/mUhltfTrLJb5YKUcpTV4TB3d4jiSY3Do0cEIjuhxSkdyUqrqOA2GhCWa7vWQBytWCRRKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PExdJj7H; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PExdJj7H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a026611b2cso4505e9.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 09:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790957273; cv=none;
        d=google.com; s=arc-20260327;
        b=L+SFcqw+akD2Fa6wBLIvJ3UiE5oUfg85RiZUNi4A3uNzJHMdSUzwpWU8IdmDz7IuJC
         VuR+70KIDAHR5etv0verx+WEtclDKWMtzm8kfmc7VCje4vHGL7rtqQvw38xiRtTEuPYF
         hBRvuUzysHOgfdyzboNQH+tRg0SjPkhfGedfIiMskvajXDYskQvJELh5UWjH1zcJumZv
         NK+LAlbckD4DsYe09mQVQl2uXwV+Nfw7Ag8hTLxYLNoyMXLEf81WCswxrYv6ToBtgii2
         EFvwd8ukZDtAgry/cmOYZw0w8uYWlbqRB9c068aausAvaxb1TgMOSKPry2vJ+HURn+FL
         dnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBStq7HJ1HhU8r8netCSqoFuNNT8K/NJyM0kHcdEpJ8=;
        fh=Y1TY+E1A+K+sCx5jBlItYfqMp3rluxojzI+E/k7D/pk=;
        b=listnRL3OfHwfMkA8P7BP8/KHTI1YIjDplWAvfhb8j3VXioTNZ3ruH9ZV8xVOtlyF3
         2n6voNNP0j6MWVgssSkvzHJWuVCA9FdC+oVmMbppPBiA2lfE/5sD4HhYE+bZ3do39tj2
         vIrUnySKIYyS49xrsphxfoIVsID5QtKaT/kXt8TW9hDGMi1FPX7aiM8FHuZEAKHBBOtp
         YFGdShIzXCfK3ovsdYaQAmAPEBnTDjCFsiFZy5zVH3lDaQw82ohGLx4UGU+HbddHSsMb
         NhTF7W6JSoOMJpgJ1BJxm6b93XgC2fZwNqK8RgXGdtAbHX+oodUrfood5Eg9QsfmPdiX
         K6Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790957273; x=1791562073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBStq7HJ1HhU8r8netCSqoFuNNT8K/NJyM0kHcdEpJ8=;
        b=PExdJj7HUajqC/dePW08rpkWReBzXIiM5EWatRkCE/Ftaoe9f9w85cLKfgo4rIMr7h
         UIzqF8l16tc3zy8RTpNwluEwtIpQFRIviCSWoMKeDQ1v5Xo0fksE/tYGRB+DUqpUx5dJ
         CB4XGmnBDk2Hi41htsE6t7fRaEzEs1FD34G7P9/lQjFJrr6NdnRnSKK9Hkh+CPeKsQUU
         gOHCAnNruoj135QMOKlxSTkec1HEnSoqRI56r6D1SB2ItiR5d8Sh/MOHXo8gYiyQWv9L
         M5Zjd2+u4BTqc5uU8qNGalKn/tyD/MFkogT+VTl+gPVriBnLpkD9ZcrfVxtUbsuuxQR2
         yoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957273; x=1791562073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBStq7HJ1HhU8r8netCSqoFuNNT8K/NJyM0kHcdEpJ8=;
        b=jXVj6+XV7qrrFYO9jIc4jqqKdea74dhtVj/V2ejiLbvht3dJRlEhvF46NOPPjltjTo
         hSd50vPwP9ZpnaL7ic2D753vz1cS4vaaC2zt0gif7LQ3yoUzL1Km4TmaUf3SYX1ReRWR
         FMGZtFi9QoPIaAvzdmyH3QqZtkGgG/9H5CgJcYXwuMkF/PTTectLaPW/qQ9uez3vRYnX
         ItKo8A9Qay9GQQkCPNnppdkG1f/QcCzJm1m676mL08iFReNAP8KYfAMYig81ntdxEAtO
         fzd0YC178TkVjevbSWL/y1qHSdN/0XCOa97sRHA5/OFz9zmHlY20jGoqyTEKLGYb8jZV
         9L3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwagVIu8w1er9sfSLqfteaLG0EA4zjNx+OoSxsGXBlOy/dcO+s17n+6Jd3saDix5jVN8Ss=@vger.kernel.org
X-Gm-Message-State: AFuF++kmpQZC5VY0Z7qF45zXL4adEdaqAqLBVqYm0FJjeCBaqRyjj7bq
	UzqzCR//q/M4r8FK43KqBOQdUiCsZoF2vgMwqYu1+hG+eUVT8qTBKVWuPfd3/Y3ld2WF01pgLdj
	ojAJ8Amtrwtm4tYCQe811ntMEPgXv2qSlO0+qaDOM
X-Gm-Gg: AYBFou2lbYst6IpcB+T/fguYzFagKdKdh9hhF/gfNcuVxU77pVBmcc92yG24ZCdI0dl
	0f+7HDUMhGbfnUNNY+wakHi/5EOaWBukchNpX/6RvUozynzUYwOuxYvqubWXeXgeqjL9iGPruBJ
	RaNX6EldpDGC2VsvQorWAU8Y63/d31xl06XyyklwJ19+Bf8F6+x+dxC/sdKAYGzno8/ysDN+ChP
	ykmUp6EOvVr/jpTgbhKL8/RTwM/Li8jY1gV3SERtaGfcqYw/HnfLw/buhI6k9zKQC8efSnV582c
	UqWvuATiyQdBzSImkvdGOdNMX8Yy9qyQVUjGoDp9zAT3hfi4iKJmCNKIS/yW4VsfL6lLsk2etZ5
	sXeoH/83ZQhDwoULghk+ZVVJ2rX8K9SmCQHEfNlXUJ0FVkw==
X-Received: by 2002:a05:600c:3042:b0:4a0:1c0e:b0ce with SMTP id
 5b1f17b1804b1-4a03046231fmr638255e9.14.1790957272991; Fri, 02 Oct 2026
 09:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928150121.1712559-2-tjmercier@google.com>
 <714f119d120fb9ba4aa7e82af621edb7bc97813a760c9dd2cb5363c55b7365a9@mail.kernel.org>
 <1b41e278-f00a-4e25-a319-ba69186d92c9@gmail.com>
In-Reply-To: <1b41e278-f00a-4e25-a319-ba69186d92c9@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 2 Oct 2026 18:07:39 +0200
X-Gm-Features: AclHuK-StPJkxPtpdx6pksmBPmFtHcY7P6COXSJ7pVVXPbMDG4w62HB5ZrLWtWQ
Message-ID: <CABdmKX37kKrOApa+cwNrfQ6YU8fn3pkFp2TjCjagFGhXPQQszw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: htab: Split htab_elem_lru and
 htab_elem_pcpu off of htab_elem
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:31=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 9/28/26 4:46 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> index 53c99fe4f176..5db11a21ce98 100644
> >> --- a/kernel/bpf/hashtab.c
> >> +++ b/kernel/bpf/hashtab.c
> >
> > [ ... ]
> >
> >> @@ -828,8 +861,12 @@ static __always_inline void *__htab_lru_map_looku=
p_elem(struct bpf_map *map,
> >>      struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >>
> >>      if (l) {
> >> -            if (mark)
> >> -                    bpf_lru_node_set_ref(&l->lru_node);
> >> +            if (mark) {
> >> +                    struct htab_elem_lru *l_lru =3D
> >> +                            container_of(l, struct htab_elem_lru, ele=
m);
> >> +
> >> +                    bpf_lru_node_set_ref(&l_lru->lru_node);
> >> +            }
> >>              return htab_elem_value(l, map->key_size);
> >>      }
> >>
> >
> > [ ... ]
> >
> >> @@ -1310,16 +1349,19 @@ static long htab_map_update_elem(struct bpf_ma=
p *map, void *key, void *value,
> >>
> >>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_ele=
m *elem)
> >>  {
> >> +    struct htab_elem_lru *l =3D container_of(elem, struct htab_elem_l=
ru, elem);
> >> +
> >>      check_and_cancel_fields(htab, elem);
> >>      bpf_map_dec_elem_count(&htab->map);
> >> -    bpf_lru_push_free(&htab->lru, &elem->lru_node);
> >> +    bpf_lru_push_free(&htab->lru, &l->lru_node);
> >>  }
> >>
> >
> > [ ... ]
> >
> >> @@ -1500,15 +1543,18 @@ static long __htab_lru_percpu_map_update_elem(=
struct bpf_map *map, void *key,
> >>              goto err;
> >>
> >>      if (l_old) {
> >> -            bpf_lru_node_set_ref(&l_old->lru_node);
> >> +            struct htab_elem_lru *l_old_lru =3D
> >> +                    container_of(l_old, struct htab_elem_lru, elem);
> >> +
> >> +            bpf_lru_node_set_ref(&l_old_lru->lru_node);
> >>
> >>              /* per-cpu hash map can update value in-place */
> >>              pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
> >
> > [ ... ]
> >
> >> @@ -2505,7 +2551,10 @@ static void *htab_lru_percpu_map_lookup_elem(st=
ruct bpf_map *map, void *key)
> >>      struct htab_elem *l =3D __htab_map_lookup_elem(map, key);
> >>
> >>      if (l) {
> >> -            bpf_lru_node_set_ref(&l->lru_node);
> >> +            struct htab_elem_lru *l_lru =3D
> >> +                    container_of(l, struct htab_elem_lru, elem);
> >> +
> >> +            bpf_lru_node_set_ref(&l_lru->lru_node);
> >>              return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
> >>      }
> >>
> >> @@ -2521,7 +2570,10 @@ static void *htab_lru_percpu_map_lookup_percpu_=
elem(struct bpf_map *map, void *k
> >>
> >>      l =3D __htab_map_lookup_elem(map, key);
> >>      if (l) {
> >> -            bpf_lru_node_set_ref(&l->lru_node);
> >> +            struct htab_elem_lru *l_lru =3D
> >> +                    container_of(l, struct htab_elem_lru, elem);
> >> +
> >> +            bpf_lru_node_set_ref(&l_lru->lru_node);
> >>              return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), c=
pu);
> >>      }
> >>
> >
> > This isn't a bug, but would a small helper keep these call sites to one
> > line, matching the pcpu accessors this patch adds? Each site now repeat=
s
> > the same container_of(l, struct htab_elem_lru, elem) boilerplate follow=
ed
> > by bpf_lru_node_set_ref(). The patch adds htab_elem_get_ptr_to_pptr() a=
nd
> > htab_elem_set_ptr_to_pptr() for the pcpu variant, but open-codes the
> > container_of for the LRU variant at every site.
> >
>
> this sounds like a good refactoring:
>
> static inline void bpf_lru_node_set_ref(struct htab_elem *l)
> {
>         struct htab_elem_lru *l_lru =3D
>                 container_of(l, struct htab_elem_lru, elem);
>
>         if (!READ_ONCE(l_lru.lru_node->ref))
>                 WRITE_ONCE(l_lru.lru_node, 1);
> }

The htab_elem type is internal to hashtab.c, so I've added a helper
htab_elem_lru_node() which makes all the callsites Sashiko mentioned
one liners.
