Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE02428474
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932430; cv=pass; b=NlCvemv0yZhYWZF34+odBKyHAYzP5PrK4BIb3TG9kVz+CAb0XfgmpdnU+rmtibjHPD+uw6zXNXEIwhL3dUrjnBwCdCpuziPw07uu2JOeppFtAPIEmvJQ9IqZ1b1E0OU/8nuPoPmDwI3U4xEx3ffzhWkZkcciQq1ZCsQCsQXjKiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932430; c=relaxed/simple;
	bh=HFnvdC0ZeE3hFdXo9ffprw+HXKmBihiHrBrz9CIaYQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRru45nnpy7vp52pMufDXZDwYfZBsZnXlnpqiky1StWiHzyP7t+ABzzWWSk/QD3rvFhsKOAVvLLSvMAvO41pT9I8yQYZQvJbG9nyGpbDqwLbsfSCjyVnPrwvPQWaf8ohCoBKwXd59ye64sXfGyNkppstB/IYeh7X9TPryM75gE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s13ysOst; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s13ysOst"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so498a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:07:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932422; cv=none;
        d=google.com; s=arc-20240605;
        b=CQHQhMpdV0nNjnKnTCIa/Ax3TfR/K3foJlzLQqpE5gJfoPeBLTpZXV8IJie5fJ8TU8
         cDAOFWtOYoWOqOb00JMR4j3+f3LslnY/t5DfaqJ4NRjGdveO/tPCTgzbhREmtqlI+yDY
         CbYv157byR8Fb2V2yvtJ3iDZsjSgBUwIgrzuaNBByvl18GILgkO2jvTuCbrCl0jtlmcy
         8IHh2jae+mQ557OgNjc7/alwESbvMNRD6kNYuehaHN7paCZcCpnGy4UQpThyfLAopd8m
         CIO6K3SgICAVLysg/O+o6roZ32N4iU+ahvlS9Bi5tYKW6Bq/vQmsmzacVz2X5pXMUkg0
         1o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0m4EgKcvHAigyFoIen3o4lxoSu/pBeXLeIue1VEAhmI=;
        fh=C823+BM1k/OGHoxdJLa76Hw3tY1dCdIt3agWWctRiqk=;
        b=fNrCmYeKJto9QE1RkOOEBU/rRmyFWn2qcg5JjixmyIXpokz+38whj9UsmQ6Vt1POTh
         CHUhfFatGuFUYHUHnWrwLY9pzuFjNTs/pusgPvoxMZQnfDcsOeW6TceT11cHqGy9211C
         bqD/VstWXizDJSB6GKVTAAXqrPasGJ0BQeFwcunW/MHiHhk/6amNlRRZB3VKXVdEKB6p
         kMNwPB4i61rGy1R89u7KXcKjX/0mDFgtEz3N4S1eSEVAFI7kyWsqz97dts8B0J2RKUxf
         1+MNN8KW1hX8JDTJMaCWkXLPdjPUcELB6CoGsAKrr1ISXAx4CmqtNru8FgyFXLsH3G6d
         tdBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932422; x=1769537222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m4EgKcvHAigyFoIen3o4lxoSu/pBeXLeIue1VEAhmI=;
        b=s13ysOstTlDnHxV28uToVwIBI1gg4mBL28Tczvzyjnb+eeWGhORxNr8PsJNW2krvTd
         cF3PkOYyl/rYq+omxgvRhBqSYxq3JudQFs5PNA0dwLjfMZ6nwWvsn1GWS4xJw0k+DHnC
         Gi/7VnLLVFsGBNDitXq8db9Bv2rC/gfUOBJhTWZBFwuvTnnCF/3ooybUWPmNU1gmoqrv
         y0II5S6kWrFoopeLSXVu8mVJgRiDZEtw/iUGdEPVe3uIckjzL0Ag+/Hx7lvGyF4U8wFG
         ogK5aHhEKuthtNgJcjUwQbKPA3lS2HwrOMC5bc+r+VC0DphYkrlugrbnY13fbu6z1kny
         5XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932422; x=1769537222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m4EgKcvHAigyFoIen3o4lxoSu/pBeXLeIue1VEAhmI=;
        b=thUiyAyQq7jkKcRajSDiQC1+qRtz0RZY6QmfI+SxBk0VmzZmCCTsgfpzmrzVAgPQ2U
         LwtHPOA7hNOIQVfVsgxqetglSkRZqSsjxxXvV4e0lyS9flho0k8YiwY/PluigEVPU61U
         6XC/3Z2Vkwv1KD+ZfEsnmp+DgJQ2H+ZDTYGT1AJRA8hgzPPJeTCk8tnBNYjUeqarVeyl
         oLQ5Pj+t3v9HWATw6G0LErTJfOWbldF/P9jniXrec97tlv2O6FlYdHMM9mrw/rSkg2xH
         rKaK8DuU6cfFG6gsJbnpUUcET1A8qeZBRuHpB3BTUZZqxlmUgOrDE6imA1ffvrV1c6xz
         Zk5A==
X-Forwarded-Encrypted: i=1; AJvYcCUnhs5e7Ml74qp+N9JZCmCpm7gWSFTkhFOJk9ejTVvLTPZzEcAtYEzQI0Vgr5WSRz6/Fqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXhVZWemUcKXcuHib9vjernQdxkga5gu3j3uEtjfhgKOWUvSz
	160t3NlDZJZeHSKJv/IScVtUVrmzNSP3V2bzpE9Q8E28Y88eFoPE7bzunPBlOizbKqSCkdzGIDT
	7DQd5ressiRIad5761Uk/ASQV5625oeXexmX8magR
X-Gm-Gg: AZuq6aLya2VKr6OMo6NGT0CSfJrXf4XU6K1Wue4exJUdzcuEwTxiWWmsxBOtlDDtrrj
	u102VGKnex2hiwEl3q6ueiHoXRzOILD44RNXGS/u6PBSYramB+4meeZTzSN6rDTQly9/1MlLTba
	2kc4sqXjzYmghgQlP/8xE7Enna59Z6mTylXy+/dvmBD70yj7S8Mg3D2idUQszkcW8aJRUpp6rSv
	UkhW5nkA9ftJKd/XzNEBoEkgab2GjeZAxLwhb5NULjvrbyW+rYZCT41udZ95huPw0TRm8WBUhA/
	VKbaXVAClALHm7pXG9wBl7g=
X-Received: by 2002:a05:6402:1659:b0:658:e7a:6fa7 with SMTP id
 4fb4d7f45d1cf-6581398f92amr1073a12.4.1768932421563; Tue, 20 Jan 2026 10:07:01
 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-10-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Jan 2026 18:06:46 +0000
X-Gm-Features: AZwV_QhAI_v8nb72cx00QIZiPM3CMYUd_28UNx83-h0Ivydma0yfYiVC7xf4sY0
Message-ID: <CAJuCfpEEUs98yCiNA=QOPY6Qk7=QhSBF+gqPn5a+B+bYbQwvsQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] slab: remove cpu (partial) slabs usage from
 allocation paths
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

On Fri, Jan 16, 2026 at 2:40=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
>
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab(). In the
> latter case we reuse alloc_from_new_slab() (when we don't use
> the debug/tiny alloc_single_from_new_slab() variant).
>
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
>
> The rest of the changes is removing functions that no longer have any
> callers.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

A couple of nits, but otherwise seems fine to me.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 612 ++++++++------------------------------------------------=
------
>  1 file changed, 79 insertions(+), 533 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index dce80463f92c..698c0d940f06 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -245,7 +245,6 @@ static DEFINE_STATIC_KEY_FALSE(strict_numa);
>  struct partial_context {
>         gfp_t flags;
>         unsigned int orig_size;
> -       void *object;
>         unsigned int min_objects;
>         unsigned int max_objects;
>         struct list_head slabs;
> @@ -611,36 +610,6 @@ static inline void *get_freepointer(struct kmem_cach=
e *s, void *object)
>         return freelist_ptr_decode(s, p, ptr_addr);
>  }
>
> -static void prefetch_freepointer(const struct kmem_cache *s, void *objec=
t)
> -{
> -       prefetchw(object + s->offset);
> -}
> -
> -/*
> - * When running under KMSAN, get_freepointer_safe() may return an uninit=
ialized
> - * pointer value in the case the current thread loses the race for the n=
ext
> - * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() =
in
> - * slab_alloc_node() will fail, so the uninitialized value won't be used=
, but
> - * KMSAN will still check all arguments of cmpxchg because of imperfect
> - * handling of inline assembly.
> - * To work around this problem, we apply __no_kmsan_checks to ensure tha=
t
> - * get_freepointer_safe() returns initialized memory.
> - */
> -__no_kmsan_checks
> -static inline void *get_freepointer_safe(struct kmem_cache *s, void *obj=
ect)
> -{
> -       unsigned long freepointer_addr;
> -       freeptr_t p;
> -
> -       if (!debug_pagealloc_enabled_static())
> -               return get_freepointer(s, object);
> -
> -       object =3D kasan_reset_tag(object);
> -       freepointer_addr =3D (unsigned long)object + s->offset;
> -       copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeo=
f(p));
> -       return freelist_ptr_decode(s, p, freepointer_addr);
> -}
> -
>  static inline void set_freepointer(struct kmem_cache *s, void *object, v=
oid *fp)
>  {
>         unsigned long freeptr_addr =3D (unsigned long)object + s->offset;
> @@ -720,23 +689,11 @@ static void slub_set_cpu_partial(struct kmem_cache =
*s, unsigned int nr_objects)
>         nr_slabs =3D DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
>         s->cpu_partial_slabs =3D nr_slabs;
>  }
> -
> -static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
> -{
> -       return s->cpu_partial_slabs;
> -}
> -#else
> -#ifdef SLAB_SUPPORTS_SYSFS
> +#elif defined(SLAB_SUPPORTS_SYSFS)
>  static inline void
>  slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
>  {
>  }
> -#endif
> -
> -static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_SLUB_CPU_PARTIAL */
>
>  /*
> @@ -1077,7 +1034,7 @@ static void set_track_update(struct kmem_cache *s, =
void *object,
>         p->handle =3D handle;
>  #endif
>         p->addr =3D addr;
> -       p->cpu =3D smp_processor_id();
> +       p->cpu =3D raw_smp_processor_id();
>         p->pid =3D current->pid;
>         p->when =3D jiffies;
>  }
> @@ -3583,15 +3540,15 @@ static bool get_partial_node_bulk(struct kmem_cac=
he *s,
>  }
>
>  /*
> - * Try to allocate a partial slab from a specific node.
> + * Try to allocate object from a partial slab on a specific node.
>   */
> -static struct slab *get_partial_node(struct kmem_cache *s,
> -                                    struct kmem_cache_node *n,
> -                                    struct partial_context *pc)
> +static void *get_partial_node(struct kmem_cache *s,
> +                             struct kmem_cache_node *n,
> +                             struct partial_context *pc)

Naming for get_partial()/get_partial_node()/get_any_partial() made
sense when they returned a slab. Now that they return object(s) the
naming is a bit confusing. I think renaming to
get_from_partial()/get_from_partial_node()/get_from_any_partial()
would be more appropriate.

>  {
> -       struct slab *slab, *slab2, *partial =3D NULL;
> +       struct slab *slab, *slab2;
>         unsigned long flags;
> -       unsigned int partial_slabs =3D 0;
> +       void *object =3D NULL;
>
>         /*
>          * Racy check. If we mistakenly see no partial slabs then we
> @@ -3607,54 +3564,55 @@ static struct slab *get_partial_node(struct kmem_=
cache *s,
>         else if (!spin_trylock_irqsave(&n->list_lock, flags))
>                 return NULL;
>         list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +
> +               struct freelist_counters old, new;
> +
>                 if (!pfmemalloc_match(slab, pc->flags))
>                         continue;
>
>                 if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) =
{
> -                       void *object =3D alloc_single_from_partial(s, n, =
slab,
> +                       object =3D alloc_single_from_partial(s, n, slab,
>                                                         pc->orig_size);
> -                       if (object) {
> -                               partial =3D slab;
> -                               pc->object =3D object;
> +                       if (object)
>                                 break;
> -                       }
>                         continue;
>                 }
>
> -               remove_partial(n, slab);
> +               /*
> +                * get a single object from the slab. This might race aga=
inst
> +                * __slab_free(), which however has to take the list_lock=
 if
> +                * it's about to make the slab fully free.
> +                */
> +               do {
> +                       old.freelist =3D slab->freelist;
> +                       old.counters =3D slab->counters;
>
> -               if (!partial) {
> -                       partial =3D slab;
> -                       stat(s, ALLOC_FROM_PARTIAL);
> +                       new.freelist =3D get_freepointer(s, old.freelist)=
;
> +                       new.counters =3D old.counters;
> +                       new.inuse++;
>
> -                       if ((slub_get_cpu_partial(s) =3D=3D 0)) {
> -                               break;
> -                       }
> -               } else {
> -                       put_cpu_partial(s, slab, 0);
> -                       stat(s, CPU_PARTIAL_NODE);
> +               } while (!__slab_update_freelist(s, slab, &old, &new, "ge=
t_partial_node"));
>
> -                       if (++partial_slabs > slub_get_cpu_partial(s) / 2=
) {
> -                               break;
> -                       }
> -               }
> +               object =3D old.freelist;
> +               if (!new.freelist)
> +                       remove_partial(n, slab);
> +
> +               break;
>         }
>         spin_unlock_irqrestore(&n->list_lock, flags);
> -       return partial;
> +       return object;
>  }
>
>  /*
> - * Get a slab from somewhere. Search in increasing NUMA distances.
> + * Get an object from somewhere. Search in increasing NUMA distances.
>   */
> -static struct slab *get_any_partial(struct kmem_cache *s,
> -                                   struct partial_context *pc)
> +static void *get_any_partial(struct kmem_cache *s, struct partial_contex=
t *pc)
>  {
>  #ifdef CONFIG_NUMA
>         struct zonelist *zonelist;
>         struct zoneref *z;
>         struct zone *zone;
>         enum zone_type highest_zoneidx =3D gfp_zone(pc->flags);
> -       struct slab *slab;
>         unsigned int cpuset_mems_cookie;
>
>         /*
> @@ -3689,8 +3647,10 @@ static struct slab *get_any_partial(struct kmem_ca=
che *s,
>
>                         if (n && cpuset_zone_allowed(zone, pc->flags) &&
>                                         n->nr_partial > s->min_partial) {
> -                               slab =3D get_partial_node(s, n, pc);
> -                               if (slab) {
> +
> +                               void *object =3D get_partial_node(s, n, p=
c);
> +
> +                               if (object) {
>                                         /*
>                                          * Don't check read_mems_allowed_=
retry()
>                                          * here - if mems_allowed was upd=
ated in
> @@ -3698,7 +3658,7 @@ static struct slab *get_any_partial(struct kmem_cac=
he *s,
>                                          * between allocation and the cpu=
set
>                                          * update
>                                          */
> -                                       return slab;
> +                                       return object;
>                                 }
>                         }
>                 }
> @@ -3708,20 +3668,20 @@ static struct slab *get_any_partial(struct kmem_c=
ache *s,
>  }
>
>  /*
> - * Get a partial slab, lock it and return it.
> + * Get an object from a partial slab
>   */
> -static struct slab *get_partial(struct kmem_cache *s, int node,
> -                               struct partial_context *pc)
> +static void *get_partial(struct kmem_cache *s, int node,
> +                        struct partial_context *pc)
>  {
> -       struct slab *slab;
>         int searchnode =3D node;
> +       void *object;
>
>         if (node =3D=3D NUMA_NO_NODE)
>                 searchnode =3D numa_mem_id();
>
> -       slab =3D get_partial_node(s, get_node(s, searchnode), pc);
> -       if (slab || (node !=3D NUMA_NO_NODE && (pc->flags & __GFP_THISNOD=
E)))
> -               return slab;
> +       object =3D get_partial_node(s, get_node(s, searchnode), pc);
> +       if (object || (node !=3D NUMA_NO_NODE && (pc->flags & __GFP_THISN=
ODE)))
> +               return object;
>
>         return get_any_partial(s, pc);
>  }
> @@ -4281,19 +4241,6 @@ static int slub_cpu_dead(unsigned int cpu)
>         return 0;
>  }
>
> -/*
> - * Check if the objects in a per cpu structure fit numa
> - * locality expectations.
> - */
> -static inline int node_match(struct slab *slab, int node)
> -{
> -#ifdef CONFIG_NUMA
> -       if (node !=3D NUMA_NO_NODE && slab_nid(slab) !=3D node)
> -               return 0;
> -#endif
> -       return 1;
> -}
> -
>  #ifdef CONFIG_SLUB_DEBUG
>  static int count_free(struct slab *slab)
>  {
> @@ -4478,36 +4425,6 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
>                                              &old.freelist_tid, new.freel=
ist_tid);
>  }
>
> -/*
> - * Check the slab->freelist and either transfer the freelist to the
> - * per cpu freelist or deactivate the slab.
> - *
> - * The slab is still frozen if the return value is not NULL.
> - *
> - * If this function returns NULL then the slab has been unfrozen.
> - */
> -static inline void *get_freelist(struct kmem_cache *s, struct slab *slab=
)
> -{
> -       struct freelist_counters old, new;
> -
> -       lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> -
> -       do {
> -               old.freelist =3D slab->freelist;
> -               old.counters =3D slab->counters;
> -
> -               new.freelist =3D NULL;
> -               new.counters =3D old.counters;
> -
> -               new.inuse =3D old.objects;
> -               new.frozen =3D old.freelist !=3D NULL;
> -
> -
> -       } while (!__slab_update_freelist(s, slab, &old, &new, "get_freeli=
st"));
> -
> -       return old.freelist;
> -}
> -
>  /*
>   * Get the slab's freelist and do not freeze it.
>   *
> @@ -4535,29 +4452,6 @@ static inline void *get_freelist_nofreeze(struct k=
mem_cache *s, struct slab *sla
>         return old.freelist;
>  }
>
> -/*
> - * Freeze the partial slab and return the pointer to the freelist.
> - */
> -static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -       struct freelist_counters old, new;
> -
> -       do {
> -               old.freelist =3D slab->freelist;
> -               old.counters =3D slab->counters;
> -
> -               new.freelist =3D NULL;
> -               new.counters =3D old.counters;
> -               VM_BUG_ON(new.frozen);
> -
> -               new.inuse =3D old.objects;
> -               new.frozen =3D 1;
> -
> -       } while (!slab_update_freelist(s, slab, &old, &new, "freeze_slab"=
));
> -
> -       return old.freelist;
> -}
> -
>  /*
>   * If the object has been wiped upon free, make sure it's fully initiali=
zed by
>   * zeroing out freelist pointer.
> @@ -4618,170 +4512,23 @@ static unsigned int alloc_from_new_slab(struct k=
mem_cache *s, struct slab *slab,
>  }
>
>  /*
> - * Slow path. The lockless freelist is empty or we need to perform
> - * debugging duties.
> - *
> - * Processing is still very fast if new objects have been freed to the
> - * regular freelist. In that case we simply take over the regular freeli=
st
> - * as the lockless freelist and zap the regular freelist.
> - *
> - * If that is not working then we fall back to the partial lists. We tak=
e the
> - * first element of the freelist as the object to allocate now and move =
the
> - * rest of the freelist to the lockless freelist.
> - *
> - * And if we were unable to get a new slab from the partial slab lists t=
hen
> - * we need to allocate a new slab. This is the slowest path since it inv=
olves
> - * a call to the page allocator and the setup of a new slab.
> + * Slow path. We failed to allocate via percpu sheaves or they are not a=
vailable
> + * due to bootstrap or debugging enabled or SLUB_TINY.
>   *
> - * Version of __slab_alloc to use when we know that preemption is
> - * already disabled (which is the case for bulk allocation).
> + * We try to allocate from partial slab lists and fall back to allocatin=
g a new
> + * slab.
>   */
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int nod=
e,
> -                         unsigned long addr, struct kmem_cache_cpu *c, u=
nsigned int orig_size)
> +                          unsigned long addr, unsigned int orig_size)
>  {
>         bool allow_spin =3D gfpflags_allow_spinning(gfpflags);
>         void *freelist;
>         struct slab *slab;
> -       unsigned long flags;
>         struct partial_context pc;
>         bool try_thisnode =3D true;
>
>         stat(s, ALLOC_SLOWPATH);
>
> -reread_slab:
> -
> -       slab =3D READ_ONCE(c->slab);
> -       if (!slab) {
> -               /*
> -                * if the node is not online or has no normal memory, jus=
t
> -                * ignore the node constraint
> -                */
> -               if (unlikely(node !=3D NUMA_NO_NODE &&
> -                            !node_isset(node, slab_nodes)))
> -                       node =3D NUMA_NO_NODE;
> -               goto new_slab;
> -       }
> -
> -       if (unlikely(!node_match(slab, node))) {
> -               /*
> -                * same as above but node_match() being false already
> -                * implies node !=3D NUMA_NO_NODE.
> -                *
> -                * We don't strictly honor pfmemalloc and NUMA preference=
s
> -                * when !allow_spin because:
> -                *
> -                * 1. Most kmalloc() users allocate objects on the local =
node,
> -                *    so kmalloc_nolock() tries not to interfere with the=
m by
> -                *    deactivating the cpu slab.
> -                *
> -                * 2. Deactivating due to NUMA or pfmemalloc mismatch may=
 cause
> -                *    unnecessary slab allocations even when n->partial l=
ist
> -                *    is not empty.
> -                */
> -               if (!node_isset(node, slab_nodes) ||
> -                   !allow_spin) {
> -                       node =3D NUMA_NO_NODE;
> -               } else {
> -                       stat(s, ALLOC_NODE_MISMATCH);
> -                       goto deactivate_slab;
> -               }
> -       }
> -
> -       /*
> -        * By rights, we should be searching for a slab page that was
> -        * PFMEMALLOC but right now, we are losing the pfmemalloc
> -        * information when the page leaves the per-cpu allocator
> -        */
> -       if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
> -               goto deactivate_slab;
> -
> -       /* must check again c->slab in case we got preempted and it chang=
ed */
> -       local_lock_cpu_slab(s, flags);
> -
> -       if (unlikely(slab !=3D c->slab)) {
> -               local_unlock_cpu_slab(s, flags);
> -               goto reread_slab;
> -       }
> -       freelist =3D c->freelist;
> -       if (freelist)
> -               goto load_freelist;
> -
> -       freelist =3D get_freelist(s, slab);
> -
> -       if (!freelist) {
> -               c->slab =3D NULL;
> -               c->tid =3D next_tid(c->tid);
> -               local_unlock_cpu_slab(s, flags);
> -               stat(s, DEACTIVATE_BYPASS);
> -               goto new_slab;
> -       }
> -
> -       stat(s, ALLOC_REFILL);
> -
> -load_freelist:
> -
> -       lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> -
> -       /*
> -        * freelist is pointing to the list of objects to be used.
> -        * slab is pointing to the slab from which the objects are obtain=
ed.
> -        * That slab must be frozen for per cpu allocations to work.
> -        */
> -       VM_BUG_ON(!c->slab->frozen);
> -       c->freelist =3D get_freepointer(s, freelist);
> -       c->tid =3D next_tid(c->tid);
> -       local_unlock_cpu_slab(s, flags);
> -       return freelist;
> -
> -deactivate_slab:
> -
> -       local_lock_cpu_slab(s, flags);
> -       if (slab !=3D c->slab) {
> -               local_unlock_cpu_slab(s, flags);
> -               goto reread_slab;
> -       }
> -       freelist =3D c->freelist;
> -       c->slab =3D NULL;
> -       c->freelist =3D NULL;
> -       c->tid =3D next_tid(c->tid);
> -       local_unlock_cpu_slab(s, flags);
> -       deactivate_slab(s, slab, freelist);
> -
> -new_slab:
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       while (slub_percpu_partial(c)) {
> -               local_lock_cpu_slab(s, flags);
> -               if (unlikely(c->slab)) {
> -                       local_unlock_cpu_slab(s, flags);
> -                       goto reread_slab;
> -               }
> -               if (unlikely(!slub_percpu_partial(c))) {
> -                       local_unlock_cpu_slab(s, flags);
> -                       /* we were preempted and partial list got empty *=
/
> -                       goto new_objects;
> -               }
> -
> -               slab =3D slub_percpu_partial(c);
> -               slub_set_percpu_partial(c, slab);
> -
> -               if (likely(node_match(slab, node) &&
> -                          pfmemalloc_match(slab, gfpflags)) ||
> -                   !allow_spin) {
> -                       c->slab =3D slab;
> -                       freelist =3D get_freelist(s, slab);
> -                       VM_BUG_ON(!freelist);
> -                       stat(s, CPU_PARTIAL_ALLOC);
> -                       goto load_freelist;
> -               }
> -
> -               local_unlock_cpu_slab(s, flags);
> -
> -               slab->next =3D NULL;
> -               __put_partials(s, slab);
> -       }
> -#endif
> -
>  new_objects:
>
>         pc.flags =3D gfpflags;
> @@ -4806,33 +4553,11 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>         }
>
>         pc.orig_size =3D orig_size;
> -       slab =3D get_partial(s, node, &pc);
> -       if (slab) {
> -               if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) =
{
> -                       freelist =3D pc.object;
> -                       /*
> -                        * For debug caches here we had to go through
> -                        * alloc_single_from_partial() so just store the
> -                        * tracking info and return the object.
> -                        *
> -                        * Due to disabled preemption we need to disallow
> -                        * blocking. The flags are further adjusted by
> -                        * gfp_nested_mask() in stack_depot itself.
> -                        */
> -                       if (s->flags & SLAB_STORE_USER)
> -                               set_track(s, freelist, TRACK_ALLOC, addr,
> -                                         gfpflags & ~(__GFP_DIRECT_RECLA=
IM));
> -
> -                       return freelist;
> -               }
> -
> -               freelist =3D freeze_slab(s, slab);
> -               goto retry_load_slab;
> -       }
> +       freelist =3D get_partial(s, node, &pc);

I think all this cleanup results in this `freelist` variable being
used to always store a single object. Maybe rename it into `object`?

> +       if (freelist)
> +               goto success;
>
> -       slub_put_cpu_ptr(s->cpu_slab);
>         slab =3D new_slab(s, pc.flags, node);
> -       c =3D slub_get_cpu_ptr(s->cpu_slab);
>
>         if (unlikely(!slab)) {
>                 if (node !=3D NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE=
)
> @@ -4849,68 +4574,29 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>                 freelist =3D alloc_single_from_new_slab(s, slab, orig_siz=
e, gfpflags);
>
> -               if (unlikely(!freelist)) {
> -                       /* This could cause an endless loop. Fail instead=
. */
> -                       if (!allow_spin)
> -                               return NULL;
> -                       goto new_objects;
> -               }
> -
> -               if (s->flags & SLAB_STORE_USER)
> -                       set_track(s, freelist, TRACK_ALLOC, addr,
> -                                 gfpflags & ~(__GFP_DIRECT_RECLAIM));
> -
> -               return freelist;
> -       }
> -
> -       /*
> -        * No other reference to the slab yet so we can
> -        * muck around with it freely without cmpxchg
> -        */
> -       freelist =3D slab->freelist;
> -       slab->freelist =3D NULL;
> -       slab->inuse =3D slab->objects;
> -       slab->frozen =3D 1;
> -
> -       inc_slabs_node(s, slab_nid(slab), slab->objects);
> +               if (likely(freelist))
> +                       goto success;
> +       } else {
> +               alloc_from_new_slab(s, slab, &freelist, 1, allow_spin);
>
> -       if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
> -               /*
> -                * For !pfmemalloc_match() case we don't load freelist so=
 that
> -                * we don't make further mismatched allocations easier.
> -                */
> -               deactivate_slab(s, slab, get_freepointer(s, freelist));
> -               return freelist;
> +               /* we don't need to check SLAB_STORE_USER here */
> +               if (likely(freelist))
> +                       return freelist;
>         }
>
> -retry_load_slab:
> -
> -       local_lock_cpu_slab(s, flags);
> -       if (unlikely(c->slab)) {
> -               void *flush_freelist =3D c->freelist;
> -               struct slab *flush_slab =3D c->slab;
> -
> -               c->slab =3D NULL;
> -               c->freelist =3D NULL;
> -               c->tid =3D next_tid(c->tid);
> -
> -               local_unlock_cpu_slab(s, flags);
> -
> -               if (unlikely(!allow_spin)) {
> -                       /* Reentrant slub cannot take locks, defer */
> -                       defer_deactivate_slab(flush_slab, flush_freelist)=
;
> -               } else {
> -                       deactivate_slab(s, flush_slab, flush_freelist);
> -               }
> +       if (allow_spin)
> +               goto new_objects;
>
> -               stat(s, CPUSLAB_FLUSH);
> +       /* This could cause an endless loop. Fail instead. */
> +       return NULL;
>
> -               goto retry_load_slab;
> -       }
> -       c->slab =3D slab;
> +success:
> +       if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> +               set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
>
> -       goto load_freelist;
> +       return freelist;
>  }
> +
>  /*
>   * We disallow kprobes in ___slab_alloc() to prevent reentrance
>   *
> @@ -4925,87 +4611,11 @@ static void *___slab_alloc(struct kmem_cache *s, =
gfp_t gfpflags, int node,
>   */
>  NOKPROBE_SYMBOL(___slab_alloc);
>
> -/*
> - * A wrapper for ___slab_alloc() for contexts where preemption is not ye=
t
> - * disabled. Compensates for possible cpu changes by refetching the per =
cpu area
> - * pointer.
> - */
> -static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node=
,
> -                         unsigned long addr, struct kmem_cache_cpu *c, u=
nsigned int orig_size)
> -{
> -       void *p;
> -
> -#ifdef CONFIG_PREEMPT_COUNT
> -       /*
> -        * We may have been preempted and rescheduled on a different
> -        * cpu before disabling preemption. Need to reload cpu area
> -        * pointer.
> -        */
> -       c =3D slub_get_cpu_ptr(s->cpu_slab);
> -#endif
> -       if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
> -               if (local_lock_is_locked(&s->cpu_slab->lock)) {
> -                       /*
> -                        * EBUSY is an internal signal to kmalloc_nolock(=
) to
> -                        * retry a different bucket. It's not propagated
> -                        * to the caller.
> -                        */
> -                       p =3D ERR_PTR(-EBUSY);
> -                       goto out;
> -               }
> -       }
> -       p =3D ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> -out:
> -#ifdef CONFIG_PREEMPT_COUNT
> -       slub_put_cpu_ptr(s->cpu_slab);
> -#endif
> -       return p;
> -}
> -
>  static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
>                 gfp_t gfpflags, int node, unsigned long addr, size_t orig=
_size)
>  {
> -       struct kmem_cache_cpu *c;
> -       struct slab *slab;
> -       unsigned long tid;
>         void *object;
>
> -redo:
> -       /*
> -        * Must read kmem_cache cpu data via this cpu ptr. Preemption is
> -        * enabled. We may switch back and forth between cpus while
> -        * reading from one cpu area. That does not matter as long
> -        * as we end up on the original cpu again when doing the cmpxchg.
> -        *
> -        * We must guarantee that tid and kmem_cache_cpu are retrieved on=
 the
> -        * same cpu. We read first the kmem_cache_cpu pointer and use it =
to read
> -        * the tid. If we are preempted and switched to another cpu betwe=
en the
> -        * two reads, it's OK as the two are still associated with the sa=
me cpu
> -        * and cmpxchg later will validate the cpu.
> -        */
> -       c =3D raw_cpu_ptr(s->cpu_slab);
> -       tid =3D READ_ONCE(c->tid);
> -
> -       /*
> -        * Irqless object alloc/free algorithm used here depends on seque=
nce
> -        * of fetching cpu_slab's data. tid should be fetched before anyt=
hing
> -        * on c to guarantee that object and slab associated with previou=
s tid
> -        * won't be used with current tid. If we fetch tid first, object =
and
> -        * slab could be one associated with next tid and our alloc/free
> -        * request will be failed. In this case, we will retry. So, no pr=
oblem.
> -        */
> -       barrier();
> -
> -       /*
> -        * The transaction ids are globally unique per cpu and per operat=
ion on
> -        * a per cpu queue. Thus they can be guarantee that the cmpxchg_d=
ouble
> -        * occurs on the right processor and that there was no operation =
on the
> -        * linked list in between.
> -        */
> -
> -       object =3D c->freelist;
> -       slab =3D c->slab;
> -
>  #ifdef CONFIG_NUMA
>         if (static_branch_unlikely(&strict_numa) &&
>                         node =3D=3D NUMA_NO_NODE) {
> @@ -5014,47 +4624,20 @@ static __always_inline void *__slab_alloc_node(st=
ruct kmem_cache *s,
>
>                 if (mpol) {
>                         /*
> -                        * Special BIND rule support. If existing slab
> +                        * Special BIND rule support. If the local node
>                          * is in permitted set then do not redirect
>                          * to a particular node.
>                          * Otherwise we apply the memory policy to get
>                          * the node we need to allocate on.
>                          */
> -                       if (mpol->mode !=3D MPOL_BIND || !slab ||
> -                                       !node_isset(slab_nid(slab), mpol-=
>nodes))
> -
> +                       if (mpol->mode !=3D MPOL_BIND ||
> +                                       !node_isset(numa_mem_id(), mpol->=
nodes))
>                                 node =3D mempolicy_slab_node();
>                 }
>         }
>  #endif
>
> -       if (!USE_LOCKLESS_FAST_PATH() ||
> -           unlikely(!object || !slab || !node_match(slab, node))) {
> -               object =3D __slab_alloc(s, gfpflags, node, addr, c, orig_=
size);
> -       } else {
> -               void *next_object =3D get_freepointer_safe(s, object);
> -
> -               /*
> -                * The cmpxchg will only match if there was no additional
> -                * operation and if we are on the right processor.
> -                *
> -                * The cmpxchg does the following atomically (without loc=
k
> -                * semantics!)
> -                * 1. Relocate first pointer to the current per cpu area.
> -                * 2. Verify that tid and freelist have not been changed
> -                * 3. If they were not changed replace tid and freelist
> -                *
> -                * Since this is without lock semantics the protection is=
 only
> -                * against code executing on this cpu *not* from access b=
y
> -                * other cpus.
> -                */
> -               if (unlikely(!__update_cpu_freelist_fast(s, object, next_=
object, tid))) {
> -                       note_cmpxchg_failure("slab_alloc", s, tid);
> -                       goto redo;
> -               }
> -               prefetch_freepointer(s, next_object);
> -               stat(s, ALLOC_FASTPATH);
> -       }
> +       object =3D ___slab_alloc(s, gfpflags, node, addr, orig_size);
>
>         return object;
>  }
> @@ -7711,62 +7294,25 @@ static inline
>  int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t si=
ze,
>                             void **p)
>  {
> -       struct kmem_cache_cpu *c;
> -       unsigned long irqflags;
>         int i;
>
>         /*
> -        * Drain objects in the per cpu slab, while disabling local
> -        * IRQs, which protects against PREEMPT and interrupts
> -        * handlers invoking normal fastpath.
> +        * TODO: this might be more efficient (if necessary) by reusing
> +        * __refill_objects()
>          */
> -       c =3D slub_get_cpu_ptr(s->cpu_slab);
> -       local_lock_irqsave(&s->cpu_slab->lock, irqflags);
> -
>         for (i =3D 0; i < size; i++) {
> -               void *object =3D c->freelist;
>
> -               if (unlikely(!object)) {
> -                       /*
> -                        * We may have removed an object from c->freelist=
 using
> -                        * the fastpath in the previous iteration; in tha=
t case,
> -                        * c->tid has not been bumped yet.
> -                        * Since ___slab_alloc() may reenable interrupts =
while
> -                        * allocating memory, we should bump c->tid now.
> -                        */
> -                       c->tid =3D next_tid(c->tid);
> +               p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
> +                                    s->object_size);
> +               if (unlikely(!p[i]))
> +                       goto error;
>
> -                       local_unlock_irqrestore(&s->cpu_slab->lock, irqfl=
ags);
> -
> -                       /*
> -                        * Invoking slow path likely have side-effect
> -                        * of re-populating per CPU c->freelist
> -                        */
> -                       p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE,
> -                                           _RET_IP_, c, s->object_size);
> -                       if (unlikely(!p[i]))
> -                               goto error;
> -
> -                       c =3D this_cpu_ptr(s->cpu_slab);
> -                       maybe_wipe_obj_freeptr(s, p[i]);
> -
> -                       local_lock_irqsave(&s->cpu_slab->lock, irqflags);
> -
> -                       continue; /* goto for-loop */
> -               }
> -               c->freelist =3D get_freepointer(s, object);
> -               p[i] =3D object;
>                 maybe_wipe_obj_freeptr(s, p[i]);
> -               stat(s, ALLOC_FASTPATH);
>         }
> -       c->tid =3D next_tid(c->tid);
> -       local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
> -       slub_put_cpu_ptr(s->cpu_slab);
>
>         return i;
>
>  error:
> -       slub_put_cpu_ptr(s->cpu_slab);
>         __kmem_cache_free_bulk(s, i, p);
>         return 0;
>
>
> --
> 2.52.0
>
