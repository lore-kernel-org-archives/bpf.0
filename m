Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EC47DD42
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200126; cv=pass; b=f0fPyEeW4mvtItsHIFCMpv1/8Nm3le9Ccgyo765QtM2eIMsGAmoKIIid7ueBuv5Id4nhcBx0J9tv5Kc1rJKBwO8ZTPc8PHw6Y+ZCMYZkYGazMySgGrPmwGqjEShUH+7Hn9eplmdXIipLMvrJnia1ea2OZ1P6/DiPkzcY6Ylw8eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200126; c=relaxed/simple;
	bh=q5ivT0wUQd61fCFGQxZI1dnMkjtQWORiTQEkMidUqOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAM+MXH0sIZckyG+QdunFXrSi9es0BZOCj0cfHD+Ow7TMLXf1SMSwbfUNBHfVq9Z653EWqdN36tkq341c5n6zNzgVqM1Q5gV//dV2W/CmZGUMPOoBvDqCjyyivV6kWnwakcQfjsaaN/fgYOLWTc2SAB9/XsDCaYRaQAnrEl0fWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ix1nDopC; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ix1nDopC"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d45ae011aso19082467b3.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790200121; cv=none;
        d=google.com; s=arc-20260327;
        b=IVM2BYel+zdSfPVZxt2Ysqf3SCtcdPKZYQydQxZWIwommMFJJrHgbOJ93RcYgwgab3
         LzW+K4/7tKFEzc9ALwsMUJCgP3mXxYH/Nx28meDHIkR5+NRU2NIhWFROiKwrLYycTOZE
         dncN8Tm5OxiomXk4vl9ctENTTEFtG/c4f5/mJK8A2TSJMt2uUwoaNVTtOeR8NvHMGW7d
         4UZlDajymvH4yh3gbAHxsWOqUHiUOnKrYyr8jdSm4cjrK8sRhLDqX+rSNa1Yrpa0nKez
         09bH22j2jfVS2cXtiHsJnp/MX9c3rvLz4PyV8zBXFwlZgCMiKUPKiiUa0hoBeTAAw25p
         sPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6LsnyCFOVejcsE+7NjLo2kzmY1l5LMibw4r5k6gDuY=;
        fh=q29HihNU4cjyG7H+hLc7lKiQRx2mBr0oIrH5Ay814rU=;
        b=QSR4HAohzJHncTED6XqAjCQi+MOpRWOCVRtlEVhAOmFqXZ9f4eFlPQkJMJMIbYrcIj
         Ug0kwh4BQR87K+dsPoX3ZQZw+qrJIuwbL/e04mysuJCuOXQRN4row1McMFTrnyHsnKwJ
         EZ+g/eXDOa1LkuGp9nLHC++ZpXvXEvqQRi4SriWMlYoYpG14bBXuQwA2+7Ci88FsA8sL
         VCeAOhz/BscK3kBrIaPdueQxlnoyGMiu2UqRSGOfcgRJYSUWGHb7Mwsr5EPld5C/mbK4
         mI0s/n3oAWxGemPkZm5cQQzcU2T5WZ3IxfFbV7gk61hGL2fnC/geFhoRL9Fm6CuFbL92
         Yj4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790200121; x=1790804921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6LsnyCFOVejcsE+7NjLo2kzmY1l5LMibw4r5k6gDuY=;
        b=Ix1nDopCk0GjR4nCxG3pctfH4kfkV9m6BPkvBfm/dna2cCjwg1oKyNdIBhnXSkZGvQ
         +FHNMQrUZeNktLDjl8v/FdEjgEM2p7Ypt0TgoAXwWR7hcTy4rQlMI7Dmm/CdWAg+sS38
         LG2TS/plDrQkr2QHaEkxXfXDrzLNnfxANcu6li2IAwWZU1I2UIXfNzwjrgKrF5KtVFqT
         kQQ8bFZhOhqIcj20SqUTPXHW8VWHk5H3+XBgkunPM59a4MVntMbrO1h6hZQ/xFVjrN8W
         z2vrhw/dtBt/eI8DwiSOE37eGh0fimomCNaT6XIc7gXVsiqdeEQa9XABOuMqzpKGjxM2
         mAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200121; x=1790804921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6LsnyCFOVejcsE+7NjLo2kzmY1l5LMibw4r5k6gDuY=;
        b=k8Qwoeso1yIlx1g4XcWVDabejEACThA3+ReeBbeCSSKTqYj/d6i4z/+wX8hxJXtIWY
         J/pDgiAwJwu/mzecuk4nib4pJYgkBx7HL2yxD/Dp4q8M+fXgtbJd5ecRovL5bRl1VXdy
         de3Fr5Vr5zhAyEdQptesqPMKQ0tErAAJEoFScYtlr3g20QGaxeLg7UXPK0WuSb8sxZso
         DTFwGFPrG2Q0ZLIgiXJJrl4QrdVNxfs9WKank7iLgaSxDRgBnV1dKtGqbR9QPO+0NnSH
         mH/UbUalcASFSvlvzBkBU0/7yy4mhJk/RsvSI8fRq+YN2z7m5XkZE61xccKgkc24isUv
         GmJA==
X-Gm-Message-State: AFuF++nn/GJMgLHsCzz4fB8c2vzc979Ae54ZeSoJw4pdViukWPttHH+x
	NCuNbw1bnpTpN3P7s9idaiLm25v4Woutg8gVw3sPLnWAVGbWjRsSEEP9jzE9jcEPU8fxULU9rY/
	k4D/1NwP5NWHUduOLAhdlwDOrNcjDcvnbFaEfmWpAmw==
X-Gm-Gg: AYBFou05km3/LJGC5rwjiSLSnupcM+0WuxOeEFzkO+qKf9hQ0Yf38cjpDKDnaf7JxSo
	xXmfooUr57BpsxpYNod586M6VhqDF0M3At/exlTRb9g1kMrXJ2rrYhcX+a5uWUaul0pwVB2XK66
	IF1MiefSqKayKFuWkVFfkIQ9dak8X5Hykghd31RrlwqN5IyV4uDpdmIrzgWkj5kuo3VIwJTJo1d
	HjfbTz83kVtaR9LtyXUNFQsU4CCR8pufUXbToeannKjqUjoP//KRSGoRzUXzDZKA1UlZNkJln9h
	+ocDvqNEawwbJAvwj9UeE3c1Xd4YG2hXw6PbVkB5OqOjgfMjKSk3ELgWDYf6+jUJEOoEyBLkPpA
	nkbqRlw==
X-Received: by 2002:a05:690c:6d82:b0:845:1064:5c03 with SMTP id
 00721157ae682-8a64bc39bb2mr3624507b3.23.1790200121136; Wed, 23 Sep 2026
 14:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824082530.47553-1-emil@etsalapatis.com> <20260824082530.47553-3-emil@etsalapatis.com>
 <DKYHFTVFY5T7.1TLXUTDOWQXF7@gmail.com>
In-Reply-To: <DKYHFTVFY5T7.1TLXUTDOWQXF7@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 23 Sep 2026 21:48:29 +0000
X-Gm-Features: AclHuK9uKiHqk9W_APTNTjd8c2EgcJKGpE7jq4Fqsyq2o6TmPDI4dTzDO4yePd0
Message-ID: <CABFh=a4H9_3pkFzgyrooz8eg=8pa-f_JHK3XdLSvTfV_nVN8JA@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: Add sleepable arena page allocation path
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 1:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Aug 24, 2026 at 1:25 AM PDT, Emil Tsalapatis wrote:
> > The bpf_arena_alloc_pages() function currently only allocates pages
> > inside a spinlock critical section with IRQs off. This forces the use
> > of alloc_pages_nolock() in the BPF allocator, even when the caller is
> > a sleepable BPF function. This in turn causes allocation failures even
> > in cases where falling into the allocator slow path and possibly
> > sleeping would eventually succeed. This can be triggered consistently
> > by heavy BPF arena users like scx.
> >
> > Add a separate arena page allocation path just for sleepable callers.
> > The path preallocates the arena memory to be added to the tree before
> > taking the critical section.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  include/linux/bpf.h  |  6 ++++
> >  kernel/bpf/arena.c   | 76 +++++++++++++++++++++++++++++++++++++++++---
> >  kernel/bpf/syscall.c |  8 +----
> >  3 files changed, 79 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index ffa5626411ac..d15ed7a3879b 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -710,6 +710,12 @@ void bpf_map_free_internal_structs(struct bpf_map =
*map, void *obj);
> >  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
> >                                  struct bpf_dynptr *ptr__uninit);
> >
> > +static inline bool is_bpf_alloc_nonsleepable(void)
> > +{
> > +     return preempt_count() > 0 || irqs_disabled() ||
> > +             IS_ENABLED(CONFIG_PREEMPT_RT);
> > +}
> > +
> >  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> >  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ig=
n, u32 page_cnt, int node_id,
> >                                         u64 flags);
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index da356989786a..126ddae763f9 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -683,8 +683,73 @@ static int arena_adjust_tree(struct bpf_arena *are=
na, long uaddr, long page_cnt,
> >       return range_tree_clear(&arena->rt, *pgoff, page_cnt);
> >  }
> >
> > -static long arena_alloc_pages_internal(struct bpf_arena *arena, long p=
age_cnt,
> > -             long uaddr, long pgoff, int node_id, bool sleepable)
> > +static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long =
page_cnt,
> > +             long uaddr, long pgoff, int node_id)
> > +{
> > +     u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > +     struct apply_range_data data;
> > +     struct page **pages =3D NULL;
> > +     unsigned long flags;
> > +     u32 uaddr32;
> > +     int ret, i;
> > +
> > +     pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_AC=
COUNT);
> > +     if (!pages)
> > +             return 0;
> > +
> > +     ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages=
);
> > +     if (ret) {
> > +             kvfree(pages);
> > +             return 0;
> > +     }
> > +
> > +     data.i =3D 0;
> > +     data.pages =3D pages;
> > +     data.arena =3D arena;
> > +
>
> Why have this split?
> Always use an approach of allocating pages outside of the lock?
>

Mainly to avoid multiple kmalloc_nolock() allocations outside the lock
for the sleepable
path. That should matter for larger allocations. The two separate
paths also stay simpler
than if we had a single path (at the cost of a bit of extra
duplication). I can change to a single
code path during respin if you feel these are not worth having two
internal calls.

> Considering severity of the issue bpf tree is probably appropriate.

Will do.

>
> pw-bot: cr
