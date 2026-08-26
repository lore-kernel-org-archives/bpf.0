Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35C265606
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707560; cv=none; b=N7sfobezf4zK4OKC8XyV0qqXH12cOIB3ICXEK99ckNklnLFEqvY2HcChE+01llHSrs5Rxu5SoVtS3G+jHZCyfHbUocinXGwwlX3fUD8MN92zv4BJNH+WQnvDOoZaWEMqTazTuHA8caFZDZsFJ2arpQ4X6sMKjDKE/Df73chDCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707560; c=relaxed/simple;
	bh=sVn59ACXb8w4iDg1AHXcvkreINPcbzzNTBkIlI3ORMQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VFPd6rwnr4zpWRQQx8xRFMXOYcixsw1yMRjRKGyqrrN4edQr+/UtgfEBP++Sobluxwwv21VpRBhxceOE22AKikJ1KFrUVyLycFoFswxCu9IgwsPS7T2AUu9qM8bNWjl2QEd3hhpJjcJ/8GuOsgSdICLH2DkDjM26eqXmhMWVlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/RNPca5; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/RNPca5"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f3f52143cdso384225a34.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707558; x=1788312358; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ley2zAksbGJi0111Diaaw3UTcUYD3jHLMyKx284iLKQ=;
        b=p/RNPca54bDZDwS/HqoX2B6Z3xYErbx5UXmXwcKfwASBtntWYiSsg0rqQgfbsaG7SK
         aDNrk54gK0ARZLndK3IoAcawlMl1jWec8WuMhgDOO08mp95bEdrr80W9eG0b6s3o34Na
         1PIaLF3e3gewxjXQk5YYDkxv161HOhrq+Y0ct5/jIFf6925VPcJG0a+1/9D2WL9c6YqM
         ztfUWMBY1CpvHarkKfJ6PRA3nYzq25rFNWt+AdRCPZG8kacz22/CHARcrGd+H7fGGWbo
         Ffmciiw0OuxfGEtcGR1hnlNbCQGtGdGe7o/WRp/r6FyJ72LzN2emqlvaF/W2ZvzVf6Mj
         hzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707558; x=1788312358;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ley2zAksbGJi0111Diaaw3UTcUYD3jHLMyKx284iLKQ=;
        b=a0CVjbfruUFjRAzxfa/fdJTQQML1n9RyRgb/DPQclx7c8dUi6qBmqFuDyEB0rw9uU0
         fKHJkUqTUb1DFA/SlTxmHBF3bnSnB0RHmDCTcVU2QGvG8YQqbyMvf4PthLocb0PF88OX
         civyRaJnQj2WfHS7wEiCvCb0Hn0K1aqdwqsRFzIqR5imR5F1upV6E/8iSLxH8bBEUsDJ
         o4gEoX+KTS9hB/ljHPmO/ZUIdcV52nfC63sI01VyZeEYWOzhsyC0PVnQZHJ16zG0YYwU
         z6oB9WzR/5Xy/LFgs+LOxwQF//GplRefdbBC0MyxnzfP3WjPH5oyYSFr+wQNgl+vooG7
         ItIQ==
X-Forwarded-Encrypted: i=1; AHgh+RozpbZH9bReZwlE8xJjRmSqYfTR8OZ1wTK5K/7Zo5keMHycs7J6MWZrPb/BL8KkPtnjoS8=@vger.kernel.org
X-Gm-Message-State: AFuF++nJGdMGRiHLkJMsQkkIvsn39gIh5k7piLgN18R+kNuyjSMeIPpl
	TXHA/OpOKI+GjpvdbyQkRQDcDK4QssqFtd86SslG5xuku21o0qad3qR/x3n/CQ==
X-Gm-Gg: AR+sD10HO0TnCN4SGidLp5VLBkNbkC+Iq8eFWn8tiypuTI96o3L41UeX97iBI4pfFBd
	MVHYG1V/aY/j1BfDGzVUwPI66zTJq5IdhUI65WW438adoIxNd21g49/mepRfSfQMA5PZCI6qj4y
	E+0qJjaM4G98ppttitYGS1CV8Sg33pR/2mT/UuwS7SK68R1VO7kbE+U0vWT+kB16VJJsxMGjAYz
	rHe9WgplKmppp4Oy1y2bdTxqw8Fnjgdm0Fb5X0MDanOPt0zFA3J457mqO8ziMY9A8ERASsQ93i7
	ykl9+Bgqul0UtDJSQuNjIhp9SqRnwTTNW5zjRFddnZh2pEXgONKIl1hgaPycqZD4FrCPATzD3Sl
	HBm9PhZiWtQv+plUvmvmXJqsRNGYNe8hHlBxhP0gDaDenFJAdKbgkN5rWMX14QwhXy835u9oWSi
	Z1sqFvTlzkddAdiIV4TjfaEnZ8wF3Jh6YcUhr5t9E3jIXQP4KL/Np9n7u8HaqzXLijBANcesH5R
	UX6tdNwa84G92yLq1XFMIm2s5NsYwTWSCCQ/H1sKaiB3UfASKoEOw==
X-Received: by 2002:a05:6820:4c89:b0:6b1:a0cf:863a with SMTP id 006d021491bc7-6b1a0cfc68cmr2798036eaf.35.1787707558007;
        Tue, 25 Aug 2026 18:25:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm406255eaf.3.2026.08.25.18.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 18:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:25:56 -0700
Message-Id: <DKYHFTVFY5T7.1TLXUTDOWQXF7@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>
Subject: Re: [PATCH 2/3] bpf: Add sleepable arena page allocation path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260824082530.47553-1-emil@etsalapatis.com>
 <20260824082530.47553-3-emil@etsalapatis.com>
In-Reply-To: <20260824082530.47553-3-emil@etsalapatis.com>

On Mon Aug 24, 2026 at 1:25 AM PDT, Emil Tsalapatis wrote:
> The bpf_arena_alloc_pages() function currently only allocates pages
> inside a spinlock critical section with IRQs off. This forces the use
> of alloc_pages_nolock() in the BPF allocator, even when the caller is
> a sleepable BPF function. This in turn causes allocation failures even
> in cases where falling into the allocator slow path and possibly
> sleeping would eventually succeed. This can be triggered consistently
> by heavy BPF arena users like scx.
>
> Add a separate arena page allocation path just for sleepable callers.
> The path preallocates the arena memory to be added to the tree before
> taking the critical section.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  include/linux/bpf.h  |  6 ++++
>  kernel/bpf/arena.c   | 76 +++++++++++++++++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c |  8 +----
>  3 files changed, 79 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ffa5626411ac..d15ed7a3879b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -710,6 +710,12 @@ void bpf_map_free_internal_structs(struct bpf_map *m=
ap, void *obj);
>  int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
>  				   struct bpf_dynptr *ptr__uninit);
> =20
> +static inline bool is_bpf_alloc_nonsleepable(void)
> +{
> +	return preempt_count() > 0 || irqs_disabled() ||
> +		IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +
>  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>  void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign,=
 u32 page_cnt, int node_id,
>  					  u64 flags);
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index da356989786a..126ddae763f9 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -683,8 +683,73 @@ static int arena_adjust_tree(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>  	return range_tree_clear(&arena->rt, *pgoff, page_cnt);
>  }
> =20
> -static long arena_alloc_pages_internal(struct bpf_arena *arena, long pag=
e_cnt,
> -		long uaddr, long pgoff, int node_id, bool sleepable)
> +static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long pa=
ge_cnt,
> +		long uaddr, long pgoff, int node_id)
> +{
> +	u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> +	struct apply_range_data data;
> +	struct page **pages =3D NULL;
> +	unsigned long flags;
> +	u32 uaddr32;
> +	int ret, i;
> +
> +	pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUNT)=
;
> +	if (!pages)
> +		return 0;
> +
> +	ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
> +	if (ret) {
> +		kvfree(pages);
> +		return 0;
> +	}
> +
> +	data.i =3D 0;
> +	data.pages =3D pages;
> +	data.arena =3D arena;
> +

Why have this split?
Always use an approach of allocating pages outside of the lock?

Considering severity of the issue bpf tree is probably appropriate.

pw-bot: cr
