Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF636C0AC
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612006; cv=pass; b=oRQaiZkzBnkGaQGeBBekcSRHPmrqUQCyvA2rHoJCSPDIw9UZ6LuByLVus9Elc6PAU39TZXoe0KxpdGXSQCDKe8Dcl8wjhrifQqESGWVD40ekj6pXdmQ1LMSuinsMBsCAjVbBAAo9riqSC5DcF9SN4YP8qP3dTpP3iyQi07RZMMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612006; c=relaxed/simple;
	bh=WML6/NVEQP2UvEXlc/GJB9zDjq4QQKHn5jCuMlwu6e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHmMQ1c5ALXGw4gA/dlUniVPHeTxIIyTNYMUUOsQRje04W2tyuOTJRq9/B8oAYbN840qwKYkryu1kbiLzsdqnG4VLpAhPU5xRVX5CmTK5C5bneG+Jl2dGIRPKan8/Y7voBeP8HPNAC2B68pNNhuTbQth137rCbj6G8/qNFo9eQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVpxFr/7; arc=pass smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVpxFr/7"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so12433955e9.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787612003; cv=none;
        d=google.com; s=arc-20260327;
        b=oTK7LVJ2Cu+ndgO3zEvl/uP59wlMMBohYU15ZJRQxvFOwWHbMTk+OKhQxu5swuxIWQ
         UusEhIoVpiJc1st2y0fjt99//JjwkXKbTBmH8sDTD03B80Cp8AuDmn1Catpf6/lP+dpn
         rq81oPl/bXWnj1XBtHoIUG/+VIa1VlrYaWp6dhQuwFhyUGGq9kHAjyfEG/DaTZjM/jPG
         NEqsAYgoY8CbYhCXkmDfiHqirRzd53TiIKFsFo2sjEwBprtw2j1rEiurOLBlKC8tUM+C
         AlXOb+blj+q0AXetbNmwtMw5Tf9KfSAK/TBhfmnflHWIxqDL/cJJZU6W0iO8DLvOZmQu
         LQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=67ASuesnpuL7XUb0K/yI1NJVKhkQTVD14LhVGIkcNnk=;
        fh=j32kraQBvGnT7sBi2cI2niS49axgMloD3RaZATMi/as=;
        b=LaFVpZfmpQMY8+1rBQsBke0VkaTq93Y0YWax/oNUT5z1Ft5uptukBg4No7SAiAfZrh
         bMtMD4hie1U+ovl7Nexynqdkb0dWyBiMRPvVSfoZbZ6Ne5EN/GrgIlngHUsIANw+U+D0
         xeNRQa2Tq5WBiIkW0OdRLAWTzYSemKNVp3MF8lfVIGtRG1nXOwT/9TMu0iWPtbb7bzdo
         LAeFumDTTgaQfmPZ1JKC0L6sXazRxroudEKqrjayDtPXh2alqkZYWZDU4dDYVi2hkEln
         XzkezhIghdlqWwNn0RC4FyrZcRxV6ZDeSzq2GpjL7tI+yGrNZuC4mKDExNkeOrYChtJ2
         tTmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612003; x=1788216803; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67ASuesnpuL7XUb0K/yI1NJVKhkQTVD14LhVGIkcNnk=;
        b=GVpxFr/756QsSPt3f6aGElE27U0FSM4oV3szN/Xyj4h0eWS7q/w2JTseEaEFKFnn04
         aut8xlJRYd5XkESx4YxVB6UIvg9JmUB3eHFSLtanPcOTQhVuSlP+7X7bjFmhFQpSEUUX
         zbn+Tp7K6fICli5Lx6VVflpU9AQTbQCAGJIin+6mk+iNz6W98qaSERHuQHZrLhBi9g+q
         TAWuirsfiL5p3oPHWrF1ursWgif/5NGVSfyA3FMmIIqAuULTcxqw+xamUX2OyIiI91Nj
         K9YKxl/ipezZ+AE9fBIkoWz5gvWdwvCFnjH1wM5dhsGRbYQ+PhjwH2P2rNTFFZhkktPm
         dULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612003; x=1788216803;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67ASuesnpuL7XUb0K/yI1NJVKhkQTVD14LhVGIkcNnk=;
        b=sku81DvEWfpJhV7bv49CIqtj/PPesVJkrahdjw3cIoKu1F21oJowu4b462AJrYm7PZ
         kms0EVM5O0bNnYlvcScTkSejTrDWUX7TaN3ekAPMwuNrtRbnBSmk4ReFEFenTFYuIgXn
         oN/dFmxsIdvrJK93WhV3EuTJ4wrWLgM7b/mO4jsujA9l5/wJULlLupzd3hvbSd2irzbB
         3OzbnX8l0q78dP8yl9Uh22QmnpOJ69U1+ozjN83Naw3FkZsj5dpxpYnr3p/1u+tqYtva
         8SoJ7oC64lRuK+n8o35nXjOVTbseTCXsCTBVH/iu/4ezLiAELNn/Ia9DoDO2SsJiA3Lb
         fECw==
X-Gm-Message-State: AFuF++m6R+gq9OpA6NYyIJA8RAGcwpDFJ206wNaYUv3arAjD5u1HeLij
	x8fRSUrf/1Rg3rIGjX0aCIP9H8hVqL5iNgcmIZlioZ9gsTpRHb5wIdF7uis/LCvd5LXL7m2OAgF
	r8jByeaxlZpI/JuieTFNltRQlJ3pt7h8=
X-Gm-Gg: AR+sD13EvPF3x0kcLcSdCs4HYR9YyQNHAZb0WvxyyWqMsXfgK1Z2xpfP4iLTIltkwu5
	QcLSKuLOH7qRtJkFFUMlIbDufP89uAAZyKg6ux6AKDhONBiew6aDAmiTM3k204blDj+ZbK1aSo3
	i9BEN14HLFloqKXWlS+yy5Qb5VXmH3wt53EaXpaFkjljDurXUACd6hLDBpOuTCnW2NfiZT5lzIv
	pDmg+mqDGkXmWYGyRr8dvcbznKyiEBwUYjNjAGDmBbX9EucmWaXNu3kZvokuTtiLgRxfTQ+cgSH
	hfHIqgvCyl1qsN85Ikl6joEVkKGpnC2mMsjm8EJMMyNqcEmiEUGIIo4GAVbuuNbAmD5WrnENQFf
	0RsFAlqUbCTyDn880ePIJp8ZhKWCLZ5+4bXHAAIKc5FSdVGHuY2kQQpcL7S71YhUkfJu3r8J0Ec
	pMo9jENmyG3ZcRmq0t5nkP
X-Received: by 2002:a05:600d:4452:20b0:499:7219:122f with SMTP id
 5b1f17b1804b1-499c19a351amr215467035e9.4.1787612002948; Mon, 24 Aug 2026
 15:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821233516.3426127-1-memxor@gmail.com> <20260821233516.3426127-12-memxor@gmail.com>
 <3bb599fb6840c650c8408054bef8cfbcba0f8878.camel@gmail.com>
In-Reply-To: <3bb599fb6840c650c8408054bef8cfbcba0f8878.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 25 Aug 2026 00:52:45 +0200
X-Gm-Features: AcwNN1XdcAe8PY82inNeGTpO1eVuVT-AXePs0tMafT2ZKWdB_K4kwbmmq_62sEI
Message-ID: <CAP01T75hU6CZ2O+1Ap01m5eZNMQUpbGBPpkTRWSDeYk3DJ5avw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 11/14] bpf: Replace arena kfunc argument flags
 with suffixes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 00:15, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Sat, 2026-08-22 at 01:35 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 7b6847200b43..6c34a0d34b3f 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
>
> ...
>
> > @@ -1082,14 +1092,20 @@ void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cn
> >       return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
> >  }
> >
> > -__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
> > +/*
> > + * A valid arena address can have zero low 32 bits, so ptr must be rebased
> > + * unconditionally instead of being treated as nullable.
> > + */
> > +__bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__arena, u32 page_cnt)
> >  {
> >       struct bpf_map *map = p__map;
> >       struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> > +     long ptr;
> >
> > -     if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
> > +     if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt)
> >               return;                                      ^^^^^^^^^^^^
>
> This is a behavioral change, as far as I understand.
> Is it intended?

Well, I guess I should have added it to the commit log, but rejecting
off=0 leaves no way to express freeing the first page.
I am not sure whether accepting the base address now would cause any
issues. We can change this to __arena__nullable to preserve current
behavior I guess.

>
> > -     arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
> > +     ptr = arena_kaddr_to_uaddr(arena, ptr__arena);
> > +     arena_free_pages(arena, ptr, page_cnt, true);
> >  }
> >
> >  void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> > index 815f342eb4b0..d76490e059f9 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> > @@ -445,6 +445,8 @@ int iter_maps1(struct bpf_iter__bpf_map *ctx)
> >
> >       if (!map)
> >               return 0;
> > +     /* Associate an arena before testing the generic map-pointer path. */
> > +     bpf_arena_reserve_pages(&arena, NULL, 0);
>
> Is this behavioral change intended?
>

I think we have this problem elsewhere, but we need to know what arena
a program is associated to (addr_space_cast e.g. gets rejected
whenever it cannot see an associated arena map for a prog, so people
add fake references).

The second bit is that programs could allocate pages for random arena
maps they got access to for other programs, but probably cannot
anymore... Earlier, that was determined using the map argument at
runtime, now the burden shifts to verifier time. If we want to the
conversion to happen it seems to be inevitable.

> >       bpf_arena_alloc_pages(map, NULL, map->max_entries, 0, 0);
> >       return 0;
> >  }
>
> ...
