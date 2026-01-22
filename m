Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BD36E469
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049368; cv=pass; b=StbSVX4hAp5Ylt6LiPflYtdh1IpGoItH4uOHcFEOlf2wGRRZV0B5IQq4D1FYSkCeDEpPTywatDwY34wtt8fNOKoTFxp7Y/FERnMO1CqVuIrJsZhDJUtpCs8McjjzBlrsWiEtLWPTuwEwt5DsIfxKy3a3eaJdjib3eyfPvAYGdLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049368; c=relaxed/simple;
	bh=o57sw7Eq2Ffbqvkcn4WNXFGDm5I8fi/7+2OZKFDhkk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjcvqqA6juvY2vskspQ3DNunR49HHc7h5VnrMxopMrsvr/qdBi0YpVSYRF3XUjhpx9uWWAr8Jlx/mARWXkhjJkfFVTtNVMIw4hKGu9WXdrksdETDh2QLbNElfbNLEnX23C6DsgdZIMu4/eVjC2K3+6EeeJNAQ2S6EWOkal2knFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DADGFmyr; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DADGFmyr"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014b5d8551so138081cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 18:36:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769049363; cv=none;
        d=google.com; s=arc-20240605;
        b=a2k7XhZTVFn4Pi90sB0vsXszPH0pl8ybPvMtnS1mZ5R4LvmEALPN4L2MsLigWkYErk
         X1ZeJxj1pVYJcF//e61VNPzqmyhD7d1qq1k10ke7k2uJq2OfJavZSYuciNBxsPrMUMdH
         c7X/SUN/cQ8wvkXfRw+nTZSnDxZCsBPvduUepaffJmou2GMVsB149N0wxP6jDJ2nd84s
         ylJYi4ERKspZsK7W1yYniLZqZU+7JMiehoT7db30YjEOnn2BzfielGv5pjjiOL0lOq2A
         fhmjt1gkhyVy6pjQ3ssKjrr29ZKy6PjwOixCxfJa0n4+uPXA2aET2AFGmbNpYeWVd9OA
         Xm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        fh=1HMaruK7BAiwAL5I0Gs3o+OLbn9Vby975VeZDTVE+IE=;
        b=IB9uZ0t/6f1ry3sHSBAHAqJSeyKkjGrzYnkvyzSYZyd7s4r1p4bP1SaGCLkwf1uDB1
         iDnTCBy+KSGk0ukpUup89GqowUZcWLgqPJtui/6Bp/7aUD2wYzscs0DrG2dJXOXVYn1Y
         ggKRvbYazJ8n2R0GrXXzKdoRNFlH4qGsMzjctnC8iwVRW0LG7//KdM6I9hcU7gsU06gh
         VOVlI+UPC3umUNBXc8Cq0kENtI3lbkBgdzHvM6H0WQNfNWeKCbgFVdgCCUliF+kNiQ9Q
         yPW8GudQCiXmJk3mwncKlDRt7NXsqSOuoxCJLRP/Idz7m0KLHqTqVQBMG1+c1MnCcBx6
         FEMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769049363; x=1769654163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        b=DADGFmyrWWuRiNIb/LmB8PJAMjRuyWBQOj1ZVSxf92lf+wvbRHIdhauL+QsfFd1b0F
         NRf52MMxSXg51GpYn/YTUU1OQaZb84xywTbWIRNzYmQ6ESpEm4K3rYKhUPtRj0Od+bPN
         So23WYnqbo9SKdaNvoIVV4h1P/xeeu8xU1tXBkUDdi+d5O/9Tcc7gQSUj4cnuQOf8ZWv
         ADoSZb0be7kErZs80IMubS+ASa+wIC1JWMj1hloupd+GB/Uz+0WmCqFhKvhKflt33l02
         Rg43f9lry3bvTu1/7/1kJnBkUlTf664ne57rKDRBwBm3J7W/oOWybwu3bKCzn3RZbreG
         MUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769049363; x=1769654163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1ztD/wqbKPGcB/OK5g1Xm5cGzV1LC64G0Uj3l4VYPc=;
        b=bWpB3yeH7wjVybtSxjFFfrPKb+DYUw3BIWW7EBMnNkEkGN9UNR/othEylOOtEHpz0i
         8c4vrgyp833Gu76uF+xxcU1Sa1sVcO6iinQIPTT2xnet3RqL2MYlF8vMHRzIpMM5Wdo2
         ZMUA30NtMjCpGTR7wCkG2Wto7Z3ewQ0FXaMvWeqM2CXVVWMS1xhWS8jqzXTCKv8++O/F
         xRlUc5TNtt1zbNqwcwV5u62kF73psVIyDbc9R9cGbhx3sLjVZkaL56DqPquNkyvsCKx9
         kERJcqe7GZtw8fTDQFCjLjVfGyU4bhYRkpDYyveuYT3aTyUxn7B17rzNtpTxk/kl3JoO
         IVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYMr91EwpurZuKqo5Q+ukD4h9WSEHMaW2wpVTyVpxhUQ+dv9OttH9YXEBYwoZArE41jgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmCpzZzHJd0OT9pX8Jc9zZLMxiTFl6RTdBpJxWQCknflW4MOD
	GfVlWynyjgSM3KIras3cLHGcCv93EuAKlujSlIQu7z7OBaZDJdyq6KUuAnkgw+RhsNyCcCnAnI2
	2iYEhh++nVtlpTjxTh3nKUDliK7IBaSWhqWkzyixq
X-Gm-Gg: AZuq6aLoKdXCAd/y+4FBppZmLqOJhDja1bAyi9wkgdY73Ymqjc/rph1JCfE+nuorIh+
	qg/ERCIE+qf4Y+6DVcWu8qpYVQxdmsxxrYQ70o4+ijigxfXshlsSLZzAuPp3kgTJXDH86OVFvtE
	7vyBKZSl2xwD265cf8R17cZKFy+egKg/BB6/qG0B2DPB6DOa+YAt2Z0DKaGhJvYs5BoguV0BLKF
	/o11he6diHHkb+HoWCK8mAMQ5RfvwLK339UQ4LBeEPhyhDfelevRp/y+7/oBdJiAlOZ0A==
X-Received: by 2002:ac8:7d13:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-502ebd66753mr6535371cf.14.1769049362800; Wed, 21 Jan 2026
 18:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-21-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 18:35:51 -0800
X-Gm-Features: AZwV_Qh9DJqdsygnR2vDEt2pFl_xN2VFuNuBwsJB6lM8tVfE5ettz4wsz-RroIY
Message-ID: <CAJuCfpHg9YfkVwtfCUvLH_0HNWzUgx1ekQ-QMyYBW_Qeqt=WjA@mail.gmail.com>
Subject: Re: [PATCH v3 21/21] mm/slub: cleanup and repurpose some stat items
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

On Fri, Jan 16, 2026 at 6:41=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> A number of stat items related to cpu slabs became unused, remove them.
>
> Two of those were ALLOC_FASTPATH and FREE_FASTPATH. But instead of
> removing those, use them instead of ALLOC_PCS and FREE_PCS, since
> sheaves are the new (and only) fastpaths, Remove the recently added
> _PCS variants instead.
>
> Change where FREE_SLOWPATH is counted so that it only counts freeing of
> objects by slab users that (for whatever reason) do not go to a percpu
> sheaf, and not all (including internal) callers of __slab_free(). Thus
> flushing sheaves (counted by SHEAF_FLUSH) no longer also increments
> FREE_SLOWPATH.

nit: I think I understand what you mean but "no longer also
increments" sounds wrong. Maybe repharase as "Thus sheaf flushing
(already counted by SHEAF_FLUSH) does not affect FREE_SLOWPATH
anymore."?

> This matches how ALLOC_SLOWPATH doesn't count sheaf
> refills (counted by SHEAF_REFILL).
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 77 +++++++++++++++++----------------------------------------=
------
>  1 file changed, 21 insertions(+), 56 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index c12e90cb2fca..d73ad44fa046 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -330,33 +330,19 @@ enum add_mode {
>  };
>
>  enum stat_item {
> -       ALLOC_PCS,              /* Allocation from percpu sheaf */
> -       ALLOC_FASTPATH,         /* Allocation from cpu slab */
> -       ALLOC_SLOWPATH,         /* Allocation by getting a new cpu slab *=
/
> -       FREE_PCS,               /* Free to percpu sheaf */
> +       ALLOC_FASTPATH,         /* Allocation from percpu sheaves */
> +       ALLOC_SLOWPATH,         /* Allocation from partial or new slab */
>         FREE_RCU_SHEAF,         /* Free to rcu_free sheaf */
>         FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
> -       FREE_FASTPATH,          /* Free to cpu slab */
> -       FREE_SLOWPATH,          /* Freeing not to cpu slab */
> +       FREE_FASTPATH,          /* Free to percpu sheaves */
> +       FREE_SLOWPATH,          /* Free to a slab */
>         FREE_ADD_PARTIAL,       /* Freeing moves slab to partial list */
>         FREE_REMOVE_PARTIAL,    /* Freeing removes last object */
> -       ALLOC_FROM_PARTIAL,     /* Cpu slab acquired from node partial li=
st */
> -       ALLOC_SLAB,             /* Cpu slab acquired from page allocator =
*/
> -       ALLOC_REFILL,           /* Refill cpu slab from slab freelist */
> -       ALLOC_NODE_MISMATCH,    /* Switching cpu slab */
> +       ALLOC_SLAB,             /* New slab acquired from page allocator =
*/
> +       ALLOC_NODE_MISMATCH,    /* Requested node different from cpu shea=
f */
>         FREE_SLAB,              /* Slab freed to the page allocator */
> -       CPUSLAB_FLUSH,          /* Abandoning of the cpu slab */
> -       DEACTIVATE_FULL,        /* Cpu slab was full when deactivated */
> -       DEACTIVATE_EMPTY,       /* Cpu slab was empty when deactivated */
> -       DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects =
*/
> -       DEACTIVATE_BYPASS,      /* Implicit deactivation */
>         ORDER_FALLBACK,         /* Number of times fallback was necessary=
 */
> -       CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
>         CMPXCHG_DOUBLE_FAIL,    /* Failures of slab freelist update */
> -       CPU_PARTIAL_ALLOC,      /* Used cpu partial on alloc */
> -       CPU_PARTIAL_FREE,       /* Refill cpu partial on free */
> -       CPU_PARTIAL_NODE,       /* Refill cpu partial from node partial *=
/
> -       CPU_PARTIAL_DRAIN,      /* Drain cpu partial to node partial */
>         SHEAF_FLUSH,            /* Objects flushed from a sheaf */
>         SHEAF_REFILL,           /* Objects refilled to a sheaf */
>         SHEAF_ALLOC,            /* Allocation of an empty sheaf */
> @@ -4347,8 +4333,10 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp, int node)
>          * We assume the percpu sheaves contain only local objects althou=
gh it's
>          * not completely guaranteed, so we verify later.
>          */
> -       if (unlikely(node_requested && node !=3D numa_mem_id()))
> +       if (unlikely(node_requested && node !=3D numa_mem_id())) {
> +               stat(s, ALLOC_NODE_MISMATCH);
>                 return NULL;
> +       }
>
>         if (!local_trylock(&s->cpu_sheaves->lock))
>                 return NULL;
> @@ -4371,6 +4359,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>                  */
>                 if (page_to_nid(virt_to_page(object)) !=3D node) {
>                         local_unlock(&s->cpu_sheaves->lock);
> +                       stat(s, ALLOC_NODE_MISMATCH);
>                         return NULL;
>                 }
>         }
> @@ -4379,7 +4368,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gf=
p, int node)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat(s, ALLOC_PCS);
> +       stat(s, ALLOC_FASTPATH);
>
>         return object;
>  }
> @@ -4451,7 +4440,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache =
*s, gfp_t gfp, size_t size,
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat_add(s, ALLOC_PCS, batch);
> +       stat_add(s, ALLOC_FASTPATH, batch);
>
>         allocated +=3D batch;
>
> @@ -5111,8 +5100,6 @@ static void __slab_free(struct kmem_cache *s, struc=
t slab *slab,
>         unsigned long flags;
>         bool on_node_partial;
>
> -       stat(s, FREE_SLOWPATH);

After moving the above accounting to the callers I think there are
several callers which won't account it anymore:
- free_deferred_objects
- memcg_alloc_abort_single
- slab_free_after_rcu_debug
- ___cache_free

Am I missing something or is that intentional?

> -
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>                 free_to_partial_list(s, slab, head, tail, cnt, addr);
>                 return;
> @@ -5416,7 +5403,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object=
, bool allow_spin)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat(s, FREE_PCS);
> +       stat(s, FREE_FASTPATH);
>
>         return true;
>  }
> @@ -5664,7 +5651,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, =
size_t size, void **p)
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> -       stat_add(s, FREE_PCS, batch);
> +       stat_add(s, FREE_FASTPATH, batch);
>
>         if (batch < size) {
>                 p +=3D batch;
> @@ -5686,10 +5673,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s=
, size_t size, void **p)
>          */
>  fallback:
>         __kmem_cache_free_bulk(s, size, p);
> +       stat_add(s, FREE_SLOWPATH, size);
>
>  flush_remote:
>         if (remote_nr) {
>                 __kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
> +               stat_add(s, FREE_SLOWPATH, remote_nr);
>                 if (i < size) {
>                         remote_nr =3D 0;
>                         goto next_remote_batch;
> @@ -5784,6 +5773,7 @@ void slab_free(struct kmem_cache *s, struct slab *s=
lab, void *object,
>         }
>
>         __slab_free(s, slab, object, object, 1, addr);
> +       stat(s, FREE_SLOWPATH);
>  }
>
>  #ifdef CONFIG_MEMCG
> @@ -5806,8 +5796,10 @@ void slab_free_bulk(struct kmem_cache *s, struct s=
lab *slab, void *head,
>          * With KASAN enabled slab_free_freelist_hook modifies the freeli=
st
>          * to remove objects, whose reuse must be delayed.
>          */
> -       if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
> +       if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt))) {
>                 __slab_free(s, slab, head, tail, cnt, addr);
> +               stat_add(s, FREE_SLOWPATH, cnt);
> +       }
>  }
>
>  #ifdef CONFIG_SLUB_RCU_DEBUG
> @@ -6705,6 +6697,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
>                 i =3D refill_objects(s, p, flags, size, size);
>                 if (i < size)
>                         goto error;
> +               stat_add(s, ALLOC_SLOWPATH, i);
>         }
>
>         return i;
> @@ -8704,33 +8697,19 @@ static ssize_t text##_store(struct kmem_cache *s,=
               \
>  }                                                              \
>  SLAB_ATTR(text);                                               \
>
> -STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
>  STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
>  STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
> -STAT_ATTR(FREE_PCS, free_cpu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
> -STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
>  STAT_ATTR(ALLOC_SLAB, alloc_slab);
> -STAT_ATTR(ALLOC_REFILL, alloc_refill);
>  STAT_ATTR(ALLOC_NODE_MISMATCH, alloc_node_mismatch);
>  STAT_ATTR(FREE_SLAB, free_slab);
> -STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
> -STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
> -STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
> -STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
> -STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
>  STAT_ATTR(ORDER_FALLBACK, order_fallback);
> -STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
>  STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
> -STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
> -STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
> -STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
> -STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
>  STAT_ATTR(SHEAF_FLUSH, sheaf_flush);
>  STAT_ATTR(SHEAF_REFILL, sheaf_refill);
>  STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
> @@ -8806,33 +8785,19 @@ static struct attribute *slab_attrs[] =3D {
>         &remote_node_defrag_ratio_attr.attr,
>  #endif
>  #ifdef CONFIG_SLUB_STATS
> -       &alloc_cpu_sheaf_attr.attr,
>         &alloc_fastpath_attr.attr,
>         &alloc_slowpath_attr.attr,
> -       &free_cpu_sheaf_attr.attr,
>         &free_rcu_sheaf_attr.attr,
>         &free_rcu_sheaf_fail_attr.attr,
>         &free_fastpath_attr.attr,
>         &free_slowpath_attr.attr,
>         &free_add_partial_attr.attr,
>         &free_remove_partial_attr.attr,
> -       &alloc_from_partial_attr.attr,
>         &alloc_slab_attr.attr,
> -       &alloc_refill_attr.attr,
>         &alloc_node_mismatch_attr.attr,
>         &free_slab_attr.attr,
> -       &cpuslab_flush_attr.attr,
> -       &deactivate_full_attr.attr,
> -       &deactivate_empty_attr.attr,
> -       &deactivate_remote_frees_attr.attr,
> -       &deactivate_bypass_attr.attr,
>         &order_fallback_attr.attr,
>         &cmpxchg_double_fail_attr.attr,
> -       &cmpxchg_double_cpu_fail_attr.attr,
> -       &cpu_partial_alloc_attr.attr,
> -       &cpu_partial_free_attr.attr,
> -       &cpu_partial_node_attr.attr,
> -       &cpu_partial_drain_attr.attr,
>         &sheaf_flush_attr.attr,
>         &sheaf_refill_attr.attr,
>         &sheaf_alloc_attr.attr,
>
> --
> 2.52.0
>
