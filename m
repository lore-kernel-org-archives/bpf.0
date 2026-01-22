Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049A2F12D1
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043531; cv=pass; b=W6pZ1xFiBVnJjlOX0Ztj5YMm1D60Olsv0yvsmbtSlqfFwIUBxVIeL5w6NjvZk7yfwZ20GcbrloElZz6okWaIFFxWFnn1hwN4p2xDNmIMMB26ta0IeNjh47iEeYB0FtQO/nv43TIaA6sClW3idgpB1zwXQ5KKowSUtmYuXPpjBN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043531; c=relaxed/simple;
	bh=L1upYqSEg2R1rGPOoSBbKrDshAj7eVpBoVI5FeRyGPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhZ5nIl6FVf4v8DNiJ7ES0O+MmX9a/U2p0XnAx+gMRcFRTNHwe5swydP0kdl9B2UkiKLyL9UvyHiQfixOs4VdeHttasgTxnPsdn/ntspxYtV+MNmHwAQU2lU0qTEAiy+LtXcvOVoxxMVWiLfNSbtMtGmHDG/41N67OPBarXgWdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG5Of6Fo; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG5Of6Fo"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b5d8551so102371cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:58:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769043528; cv=none;
        d=google.com; s=arc-20240605;
        b=W17EbT+ZUkolzK2E9a3L7MlsMkJUaqNcyUZLT1UIu1rQanLmO7m2APRJkwf8Qij0EN
         cSPPbpYekmudnFIxyXxq3RBZ070XeT5M7c7+YEeaE5VlW25jbQqJqy9D3gKhMvG65J8M
         BD8Dsr9EnlbVy+u1YCS2Mmvgrq/7Pie+XcPPpayIEVh42uNFu6oXYRQOnQWB9+7Cf+7z
         xo5HRrp6h38EkuMHrqKcsBdpLwGHGchU+gjw5oez+b07eeg+UyPklCRy3MbSPWhoyCCa
         TaLyoxy+yfVCfRNy0SqobLhOvRvprbKTSQb2LlDX3JfUwfg8LXW37d6RGE74akattDPf
         ieQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        fh=F72m6EsTNBS8S+Fbg5htpuHgDZCYrNkIPbmH6/jr1NA=;
        b=eqvLg92ddoFU1oaUVR5tQIFvTUforHRJwAay7c9kAXjBZXHazXmOy2iTfjL/67Iodg
         Q38LRRXOoEIbtdOTU57/oqNPKspw2jOHhmwYP+jgbN1+N7tmTxFx7f3QKBN++PtBdwfn
         EqbNn/H82XMu+oVTEoRa6fZ5H/Ta6QiXI8g6tiV/7m09aXPqi+/5hy7XZUkoiTLY4/7E
         HfHCzFlDftLRkrz0YqinBkMZGA2AOLAAG21lslH/GuHak1gXbuAQv2Rsi1+jaDEWnXOF
         3Ep/pbmJrW3nynX1ctetdQE28B3aRXBYBRH6lp4zLL+rfxbEeoqC0a6Wc8YPHItXJ/QD
         u5jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769043528; x=1769648328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        b=TG5Of6Fotxkl6kuuHyRReSWP1sEjVQkmzbRV563mtpcZkOo7tJx/P+S/G6afvCcfe0
         C7eVkxswSeA0s3pf/qsqDzPj4XRQvosafB65dkb7SQu3p2J36OUIigeDXadEjNq4NO02
         uEJy7tOTxfVWwC9660Zd3FqljNylNTWtHvfNTJqbp3SDYbdlJkIrjZzPZy2rfYKHBD6Y
         it/ty+oVWnsNTkRpMEYTau/o5PZphl99a2g+nf1WcMtpxX8GDMgqdkRb1ZpyHK00xXXw
         fUTPikHBYgpIXePSxh4HqRai7RI8lBgSEWArqLl+HETsSCgc7XJiXwRdP3izOitWMahp
         Tkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769043528; x=1769648328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLIh79S7FhXMOMoT5i8cYC6nflwvZaP3UE034p5mOJs=;
        b=QKKIhmBjNPh21J4cbKi9xz+tXIiKsRAhQsbYBiAOeLd/3M55hob+G0cny6ep9Xhgu2
         kcXRf24FE4tuq/xvvqBGMh6cNHV/o4C1fyALlyb/0A9B4wk+tlGuVMa64s2f5P0L4Rvx
         fM8P4ZwXBp+S3oqmOaVdRvZPPe63mQxr/cNzYzKTfA3IOv1lbYcgldmBA2LDgnM6V93a
         ISHC1yvS3TLnHdUo0xbz9iHirimErL4ON0lZlKh07rImCRBwdlov2blZJSqrF3etFHeQ
         Uvb0w3rIjrwF6L7g0aGw9aLAbgscdBdqSID/4dvgZIj1GBlvEbR1kg8rDdHnoy6bcTSl
         v3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuW8KbZU3lhD78wgmwd01Gb8thChNc3e7AEdRbBUVGCEOW/SpEw4u349boRIOUSfDYXNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdBHL5b5s9smaj7YNt2oUVapm3W8gjOlpex0QwUmXqSHrLAMB
	gt8nTH7pegAF0A18tOWik7+okJncueYuHxEtf0xbeI1KcNIgOrDwPq/RP5wGeAMimw8q9ByrpS9
	zs1Db5heCgGnadKQsFMqhpphydtXdCwkdDOYVCLam
X-Gm-Gg: AZuq6aIjsLnGgx65/r6pzY20SmC0qwJDfSSSPctfVfIqyyDSdPZLIqRj02ZYIGPQ8Vr
	XOn0ARg7iimPHJc7Ukti9jF76Cvd8OIJ9XW4CY0YfN+ab+YnBuQMVIF62GVCldfgd4su+3Xur7b
	mx+IM7e633UVb7WlPgtbfO+JN7p9hZSkxeyZ4hBJkKYfvJBM5cwFzI6y7h3AKGw7jdpuxEvn3BJ
	EH1ov9ygC9iJ7gOSPl+H9Qjz8HmQ4bd/C9GnYuB0zX5x5TMddXa73sPWpt/hmyQyEYY8o+pqa6L
	TPxZpSWGX/aPQtQYcNHdrVk=
X-Received: by 2002:a05:622a:15cb:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-502ece4dbc5mr3059331cf.17.1769043527916; Wed, 21 Jan 2026
 16:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-20-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Jan 2026 00:58:36 +0000
X-Gm-Features: AZwV_Qgalo5BT2cF8nB5P98paznJER_XoJhiYL5n6D0vsto2yVGgbP9TwAgaUBk
Message-ID: <CAJuCfpF8xYb2j57HzO_-cfaTrOd-+jyv8pr4uFV1KwaSxKvghg@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] mm/slub: remove DEACTIVATE_TO_* stat items
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:41=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The cpu slabs and their deactivations were removed, so remove the unused
> stat items. Weirdly enough the values were also used to control
> __add_partial() adding to head or tail of the list, so replace that with
> a new enum add_mode, which is cleaner.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Same question about UAPI breakage, but otherwise LGTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 7ec7049c0ca5..c12e90cb2fca 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -324,6 +324,11 @@ static void debugfs_slab_add(struct kmem_cache *);
>  static inline void debugfs_slab_add(struct kmem_cache *s) { }
>  #endif
>
> +enum add_mode {
> +       ADD_TO_HEAD,
> +       ADD_TO_TAIL,
> +};
> +
>  enum stat_item {
>         ALLOC_PCS,              /* Allocation from percpu sheaf */
>         ALLOC_FASTPATH,         /* Allocation from cpu slab */
> @@ -343,8 +348,6 @@ enum stat_item {
>         CPUSLAB_FLUSH,          /* Abandoning of the cpu slab */
>         DEACTIVATE_FULL,        /* Cpu slab was full when deactivated */
>         DEACTIVATE_EMPTY,       /* Cpu slab was empty when deactivated */
> -       DEACTIVATE_TO_HEAD,     /* Cpu slab was moved to the head of part=
ials */
> -       DEACTIVATE_TO_TAIL,     /* Cpu slab was moved to the tail of part=
ials */
>         DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects =
*/
>         DEACTIVATE_BYPASS,      /* Implicit deactivation */
>         ORDER_FALLBACK,         /* Number of times fallback was necessary=
 */
> @@ -3268,10 +3271,10 @@ static inline void slab_clear_node_partial(struct=
 slab *slab)
>   * Management of partially allocated slabs.
>   */
>  static inline void
> -__add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
> +__add_partial(struct kmem_cache_node *n, struct slab *slab, enum add_mod=
e mode)
>  {
>         n->nr_partial++;
> -       if (tail =3D=3D DEACTIVATE_TO_TAIL)
> +       if (mode =3D=3D ADD_TO_TAIL)
>                 list_add_tail(&slab->slab_list, &n->partial);
>         else
>                 list_add(&slab->slab_list, &n->partial);
> @@ -3279,10 +3282,10 @@ __add_partial(struct kmem_cache_node *n, struct s=
lab *slab, int tail)
>  }
>
>  static inline void add_partial(struct kmem_cache_node *n,
> -                               struct slab *slab, int tail)
> +                               struct slab *slab, enum add_mode mode)
>  {
>         lockdep_assert_held(&n->list_lock);
> -       __add_partial(n, slab, tail);
> +       __add_partial(n, slab, mode);
>  }
>
>  static inline void remove_partial(struct kmem_cache_node *n,
> @@ -3375,7 +3378,7 @@ static void *alloc_single_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>         if (slab->inuse =3D=3D slab->objects)
>                 add_full(s, n, slab);
>         else
> -               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               add_partial(n, slab, ADD_TO_HEAD);
>
>         inc_slabs_node(s, nid, slab->objects);
>         spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -3996,7 +3999,7 @@ static unsigned int alloc_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>                         n =3D get_node(s, slab_nid(slab));
>                         spin_lock_irqsave(&n->list_lock, flags);
>                 }
> -               add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +               add_partial(n, slab, ADD_TO_HEAD);
>                 spin_unlock_irqrestore(&n->list_lock, flags);
>         }
>
> @@ -5064,7 +5067,7 @@ static noinline void free_to_partial_list(
>                         /* was on full list */
>                         remove_full(s, n, slab);
>                         if (!slab_free) {
> -                               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +                               add_partial(n, slab, ADD_TO_TAIL);
>                                 stat(s, FREE_ADD_PARTIAL);
>                         }
>                 } else if (slab_free) {
> @@ -5184,7 +5187,7 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>          * then add it.
>          */
>         if (unlikely(was_full)) {
> -               add_partial(n, slab, DEACTIVATE_TO_TAIL);
> +               add_partial(n, slab, ADD_TO_TAIL);
>                 stat(s, FREE_ADD_PARTIAL);
>         }
>         spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -6564,7 +6567,7 @@ __refill_objects_node(struct kmem_cache *s, void **=
p, gfp_t gfp, unsigned int mi
>                                 continue;
>
>                         list_del(&slab->slab_list);
> -                       add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +                       add_partial(n, slab, ADD_TO_HEAD);
>                 }
>
>                 spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -7031,7 +7034,7 @@ static void early_kmem_cache_node_alloc(int node)
>          * No locks need to be taken here as it has just been
>          * initialized and there is no concurrent access.
>          */
> -       __add_partial(n, slab, DEACTIVATE_TO_HEAD);
> +       __add_partial(n, slab, ADD_TO_HEAD);
>  }
>
>  static void free_kmem_cache_nodes(struct kmem_cache *s)
> @@ -8719,8 +8722,6 @@ STAT_ATTR(FREE_SLAB, free_slab);
>  STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
>  STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
>  STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_TO_HEAD, deactivate_to_head);
> -STAT_ATTR(DEACTIVATE_TO_TAIL, deactivate_to_tail);
>  STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
>  STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
>  STAT_ATTR(ORDER_FALLBACK, order_fallback);
> @@ -8823,8 +8824,6 @@ static struct attribute *slab_attrs[] =3D {
>         &cpuslab_flush_attr.attr,
>         &deactivate_full_attr.attr,
>         &deactivate_empty_attr.attr,
> -       &deactivate_to_head_attr.attr,
> -       &deactivate_to_tail_attr.attr,
>         &deactivate_remote_frees_attr.attr,
>         &deactivate_bypass_attr.attr,
>         &order_fallback_attr.attr,
>
> --
> 2.52.0
>
