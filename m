Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E309475
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870382; cv=pass; b=XD/swIhf3nnRhnnbXWaPr8HK5fCKq04yrqJifGpT4vnqSWKWsf9R52hg6m+TpdRC/gP+eF9Pv3fbwkc3qWoq8G1GQJ3BOIPrMhxcBcRNOPPgWh79WjhQhiT4xc5l0Kch49T5ubNIMG1bRPA3ytPgjfgFnFhJxbXkke3exauQj5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870382; c=relaxed/simple;
	bh=CglKaT8q8HTeggZFLMd5JWhtMWstH39/dJLglKYh+lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCUh5VHNQCM84IaMcznInDiyW7WUw37wOxw+pKuTpIYZLNhgVLU8JUrqEcMQCmQP97O/lUJz6XPqkGPuOMX0CgPOObsGvPL7TREVaGQ1ONMvqQr+X0t8PpRpzmTqoQylo/TJ/c2d4DD4CF0a3sfgwnbftvt7iN7+zvAI2Su0VzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0ylRXtT; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ylRXtT"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1615871f8f.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775870379; cv=none;
        d=google.com; s=arc-20240605;
        b=Ht6AqQJvpFNAL2txddVjtHtwp2xrVdt/AGQ1cYvFxLvDvS+493n5BX6glg9tbo55vo
         wqOdD+nvZdiYdptiIEgRvCAPjrSIp5VwWiRl2wj/3DZC2h+n+Fhwj/LmSjFZ448sISZL
         KTYO2mrbWayTFCwpV0UbOaG6OHZSP7H17/TqDWTnEca295zuVXdBSO7VgAxx1jUGzoU5
         YWS7ae4LxLDctAtDBVZDSGPDYkii3yA9QlVwX17mvi17DIkkvkm+E86N23bIhwqLnbF4
         db9ec7qzINZnkHpYHSfHfcbMPXdu1t4/FgcfC3Znu8iJYvWNuJhqX93pDpgZyIWxrKzT
         N4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        fh=HvpcOF6oy8R+w8FBEvlf/uslKo4ESeCb37i0kfL3o9k=;
        b=XoQymsqmQShW/qHLEYuIC/oNrOT+B/d4bAY1iIyi0LqXhWjTZNY7hgCCfTStYaM9K6
         R1HFMm9VWohHHzavKg0lHGleN63lV0oe9J/pQkMn0OVCWwNkIQV6Y8+1n7qRdfSI6pGE
         4zdlrKjvzmYhzAMpoFz4MhqfyQHnacjAE3wXKCVMls7aYTeMRqpyDhX/VPDYhaANBTTp
         HaG4RkutwPNtIJ/y0G9V9t+Ow1NhVk89EdKOEa6Xtwz4OVM0H8Zs4wD2ryHetuTP2N+3
         8damREQzoylH5CQp67SljI8F+zDkI66RVrHa8y44ttGJFIp/Ba04DhQ6QxVj0j0V+8ji
         NtRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870379; x=1776475179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        b=O0ylRXtTwC1Wt6WFz8nInMhiAN5Mzzto+uwlWOGWlJIJzfacaMfFneaac0uUjfSkBP
         B1Tv0F5EEFZNX/Lcc8fpkysdsG4ptQTCxsZ+Pb8TYZ2cyD+Uv48SB26Gi0xKse3fOfw8
         mGMpxdJm0PsjrAkGeawcH8UEYr8UH7pOuI5wIgxtVEEn+pYJMBWhEEFREfz2Ijmtn792
         D212LRgXh0niheC3HvuVMjTvg4fxQseZ1k6Vme6Pio9LTJiOruguLK1xZk0NLxaU/xs3
         2Nf+Apih/BsUCB3u1/khqw3QkFBkvf/4NyvvrrJEHKViK5ElcO3d4lk3356c8//LRKo/
         658Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870379; x=1776475179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OZKa9SGoXcu6sayigWJ7uTxhjTe7+OEh9pgBdh/JaM=;
        b=W5f+z+BLCnUhN8UNRjmdxcVIdrAb6bbFvfvcN9qc4cPZE0EfIG6JZUK62HSTtl9O1t
         9IkXGFZygYE8R4NXvlpTaB362uZO6hJkZAya3MynbnzK5TKawqbXQF67XOaau++gHOE3
         fFoNOm8v12L6sK+JjRtiZ5XcULfxvhEpAQX0oq0DhqWhVHnIRTsqgvc9tzZ33PzuV+r+
         JlqOQAgKYRc0SexxmoiO32msQabl8jDVXjGtQu1FfoMaH1xZQF+ffCAqSQuUj455V7ey
         smNHu7pOhYYTeeaiImAuNPFm6l8/dJZPfPVpyf0EG5vgdm6QnyWkOnivUk/RGtAk8CYT
         jvoA==
X-Forwarded-Encrypted: i=1; AJvYcCV0vz12r7IM/kQJrW/T3mNopipmCZ1e31REjsBSIhRS+M1dMKJqa5SmnYjw+/7I4cgTopE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvul8GFb/IoNJDllsdmfj2YGKPHcNljY9aFU1lvt9Qayro7td
	byRTka0ApD5w8uEwXanZXTYuAPwDC6Qp4IA7zvusirX5EssEhH2F2UC0dYeH//MrmHapSvc8Y57
	55ODUiunkAvESVljxOYjQZ8kITD6YL3w=
X-Gm-Gg: AeBDietWlzNftIPj7+0lpKXWvVUwEUE1iUhADs7vVqtLC/ucYGAzQ5jpv5tWuNa2PI0
	aAjWxn2VcOfwb0JDBup2GlxYOkfuL/yJOSIhtT2D2L/X5ZbPZQULroSApXMa6Z6NDH1G+gnNAZF
	GNWqP2IgkSs3QAAnTOolJuponrPzvJLH+Swn5DvtB4+pb7gwzyMjCQycj122OHwFplfwOVsXcom
	8F81TYZmJ5ORPaQ++9LPuEJ8HAYEfGHBHm0MkuMrz/RtXj99E/cgImJcAkECYpvki5x+E8SotlW
	RohX/0ElfmrWySQl5XsdszLsj+JzQRBIDdG64pKsc7hpXBsEUgN6HhsvR+1HNTjW9RPpcp2z0Ds
	sKWUxG5az6lSr3lLiPDq2FWvI7g==
X-Received: by 2002:a05:6000:480c:b0:439:c153:ae3d with SMTP id
 ffacd0b85a97d-43d5955c07fmr12999815f8f.6.1775870379228; Fri, 10 Apr 2026
 18:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411001711.3418264-4-ameryhung@gmail.com> <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
In-Reply-To: <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 18:19:28 -0700
X-Gm-Features: AQROBzAd9LCLDqHMq6-LCreyoFS5ypIKBHGiGpbUgkvApPh0SIvT-diMd9Ngt8I
Message-ID: <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index dced54e9265f..9e4f5c45c974 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_map=
 *smap,
> >
> >  struct bpf_local_storage_elem *
> >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void =
*value,
> > -             bool swap_uptrs, gfp_t gfp_flags);
> > +             bool swap_uptrs);
>
> [ ... ]
>
> > @@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_elem=
 *selem,
> >  int
> >  bpf_local_storage_alloc(void *owner,
> >                       struct bpf_local_storage_map *smap,
> > -                     struct bpf_local_storage_elem *first_selem,
> > -                     gfp_t gfp_flags);
> > +                     struct bpf_local_storage_elem *first_selem);
>
> bpf_selem_alloc() now takes 4 arguments and bpf_local_storage_alloc()
> takes 3, but bpf_sk_storage_clone_elem() and bpf_sk_storage_clone()
> in net/core/bpf_sk_storage.c were not updated:
>
> net/core/bpf_sk_storage.c:bpf_sk_storage_clone_elem() {
>     copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
> }
>
> net/core/bpf_sk_storage.c:bpf_sk_storage_clone() {
>     ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
> }
>
> Won't this break the build?

Nice cleanup! Pls fix the build and respin right away.
