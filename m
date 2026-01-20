Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4993D3CED
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947949; cv=pass; b=HK4tgF7NI/Os1ADXqFPCxMyVrw+aVrTBgJ9NhJ44HyfXvPMqZnz530cEm1dKWiaOXp21CV1cRJGqXAW1tLgWOL+5x1BMBY2aBsgfd2QwBctFrsJ4I9DOR9WiB7ojqlz6UfiSbCUzNl9Gapn+H+7rM3/ELzbIBnOoEjqq3UuAp+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947949; c=relaxed/simple;
	bh=mH5UwSYcm1dzdCI34lZASyNxCkUUEC0D2hK/Rqo3xIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6m/hFPGiFsQL76uIjOsFTBDk+EpIlqxq3SL1pq/Wv2tmEv3sScoCGJV5OR+YWXnPaDfFxeZBQa6q7CBBhCxu63WQBxzZI3B1QBoMaCAlgkOYNdzLmNIRVEL7hnxi0EdUvBbJ04V2BxVBX2D0LUlfdgzNmSPKqSd9gLAVsn1Egs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZzsSqlm; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZzsSqlm"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014b5d8551so54721cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 14:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768947939; cv=none;
        d=google.com; s=arc-20240605;
        b=eWVjSCvehz7Xcs/9RYNWTv2CktS6XI2NKU4i4zo1qJSLs/K9jRUeuMT2KREyESCEmh
         KcTKMzoKkQl6NXl4QfOxzrFNxSStDpgxj2SGjdfa5vkHRpZdOP4SJI2llgQqrODlBzkJ
         5ASvpsk9kwFenoQMOKuIDSPwZl9x/bsL04eSxVjaW2eZwv8G+XWeKzKcgX1Benk1tn+f
         AwHqCBC2eD7msTDTrFyCpT8pj3Zuvpo+HFD+ZSODQ7pP+oGuac/kmPYTO79xKk35SyXK
         8zi2RkKQuPzPeKxQISuLyIbQZLwszZj6CH5zdVIVKqWSFUHOBO9fwNS6e9G/VYUQAYn/
         zJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44dOOwNB1nzUj6Js371cPSz9QaCzmdjxiuuzpRwtXwc=;
        fh=VMsp0ksrWlx5/BW3GrBXt6pAnRDODttLNtSzWfopGvg=;
        b=gqCB0hfJDDR7DNgVn3OdR/hqRL1RzahinqzYNxjVJh71UvUNehYu0gvmT4ZrWf4M7K
         PMbK54MCnj7QRZ9zz/dZxcsNlpG1/KthnfeAtHoZa0BXJssoDy1SL8dFE81r4uU+E8Np
         hCssvA2W/PJhIi5RnVrekabZbnPqSHqH7pjUmh5KjZjoQKAcZ7uYayF4gplitMpihcmT
         f0F0qQ+Lg55MFjHlZY+Qcg2VyG0dFvmxtrKEjl12vMzpCnmMxt2BOa9jPsrmwbnYYWPj
         PRmS5utbnnrTEgWvbFOiYXQ4Gky2VicxEE3BGAAmQRsvwSo/O7rXDyxLbhCol9OcoMNt
         rdOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768947939; x=1769552739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44dOOwNB1nzUj6Js371cPSz9QaCzmdjxiuuzpRwtXwc=;
        b=iZzsSqlmVktR8FSP0pg7p56deWEndE3P0VK6OKUMBfyQupZ+HdBYdVj0mDrrE/Gs7r
         dDJLv4QweKW/qJ7QaZO0WyX5o6aHglHmEssi/sejmet1HNB6wd55fIFcjMctmthjhzxw
         FjsBiguF4MTN8nlts9B1xQk/NckkbSEGiWCxZTm2u72UQmDPXXwXQn1GOwObpcyO02Pi
         lE0NWejyMJb/FLzHPoqoejEwaUaE4UBGTn8wnS7fII0MIKlfGzWHmTju4nCK4iBWXCUp
         vNc/DSVMMSqL5mrlcFITlTjgnBE93TsBBnj/Q8eNKmRxY72S549/44RzM30cM9fZViKp
         d4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768947939; x=1769552739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44dOOwNB1nzUj6Js371cPSz9QaCzmdjxiuuzpRwtXwc=;
        b=lcsvGjjccM0L8YolLo6zpB4jxgPMcEuUMzF2WJx+FLAmieGvfUrJGsbJpGMp+tDt1t
         tQhzbmaKhXIJ53Hq2nlLNDy/7zXP+wFhvM2vDTRHhFuQYGMKwht4n6RG/+1D2p9zEngY
         8naEV8JXbVI+Ohf5cVqL2vVMckoRw+G2PSWoNmnSHIuqQwVtEt3Uio5+eLB9YJl+Lp7f
         EwpDRPFHCsvrAUabZBr5k2JyP9BVONLmrKrnTuF82yYHcUXJtqzBEjvySArLQv8TsqM+
         FwxltlgGMGNcU/v6SnknuDslH2DFPsqa09FwlZG4DDDN4EfG2L7M7Bdj30a1hnvtPEZX
         YGKw==
X-Forwarded-Encrypted: i=1; AJvYcCXXVA7hD/eE08nM+mDbd7DjxtZ1CyaHtbDjP4+Htt7k1PuRxmaA3mh5jyd0IYfGbowYwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidnGAO+h35jnlMjoFQ3dRGl3faru9XxhdrAyqIoXw0lJksyIE
	TOkJ27s/wDyQcrNAC1zaR30nlVnYW3pzFpAjGU5fpaen7Ucqd0HansOU8dpp0GqhStcWLnnRUBm
	LkfHhQCaV09FZSvqT/2tjBJKZuWPKumBsJrqPElj1
X-Gm-Gg: AY/fxX7zbXFdoWzXbNEx3t0Zc2bdR1RaeUIvCajD+8OjGU6y0yc1FHu8LaYCXz/00/V
	jlJVbrN+EJD+/Qa1ye1WZrMKtgxIN20IYn7h4kfs9Lprp2VcaGDg5YbZuV4lN/vIBrcgw3OCBJX
	HIsiGZAyXPfvBN8/o+FeFfTH8uoEf8hxIse47qJFdkc0O67/IpainBpv5F0pb+Wlx72qF42KY88
	nTZrDA2HfwdWvqV7DJkDD2Gs89HH2rKU20sssousFlO76w91d9nMrQQVvey+dxC/1OdOc1h7ESi
	U95z0SafspN3dqcASuxg3iA=
X-Received: by 2002:a05:622a:1181:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-502e1ab389cmr1281971cf.17.1768947938936; Tue, 20 Jan 2026
 14:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 20 Jan 2026 22:25:27 +0000
X-Gm-Features: AZwV_QgM-BqnduoA5RFORFxa5mM3qHJ9TZZetAs0zM1kLzOUnwUT9c3G3wjCAp8
Message-ID: <CAJuCfpHaSg2O0vZhfAD+61i7Vq=T3OeQ=NXirXMd-2GCKRAgjg@mail.gmail.com>
Subject: Re: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
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
> We have removed the partial slab usage from allocation paths. Now remove
> the whole config option and associated code.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

I did? Well, if so, I missed some remaining mentions about cpu partial cach=
es:
- slub.c has several hits on "cpu partial" in the comments.
- there is one hit on "put_cpu_partial" in slub.c in the comments.

Should we also update Documentation/ABI/testing/sysfs-kernel-slab to
say that from now on cpu_partial control always reads 0?

Once addressed, please feel free to keep my Reviewed-by.

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/Kconfig |  11 ---
>  mm/slab.h  |  29 ------
>  mm/slub.c  | 321 ++++---------------------------------------------------=
------
>  3 files changed, 19 insertions(+), 342 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index bd0ea5454af8..08593674cd20 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -247,17 +247,6 @@ config SLUB_STATS
>           out which slabs are relevant to a particular load.
>           Try running: slabinfo -DA
>
> -config SLUB_CPU_PARTIAL
> -       default y
> -       depends on SMP && !SLUB_TINY
> -       bool "Enable per cpu partial caches"
> -       help
> -         Per cpu partial caches accelerate objects allocation and freein=
g
> -         that is local to a processor at the price of more indeterminism
> -         in the latency of the free. On overflow these caches will be cl=
eared
> -         which requires the taking of locks that may cause latency spike=
s.
> -         Typically one would choose no for a realtime system.
> -
>  config RANDOM_KMALLOC_CACHES
>         default n
>         depends on !SLUB_TINY
> diff --git a/mm/slab.h b/mm/slab.h
> index cb48ce5014ba..e77260720994 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -77,12 +77,6 @@ struct slab {
>                                         struct llist_node llnode;
>                                         void *flush_freelist;
>                                 };
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -                               struct {
> -                                       struct slab *next;
> -                                       int slabs;      /* Nr of slabs le=
ft */
> -                               };
> -#endif
>                         };
>                         /* Double-word boundary */
>                         struct freelist_counters;
> @@ -188,23 +182,6 @@ static inline size_t slab_size(const struct slab *sl=
ab)
>         return PAGE_SIZE << slab_order(slab);
>  }
>
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -#define slub_percpu_partial(c)                 ((c)->partial)
> -
> -#define slub_set_percpu_partial(c, p)          \
> -({                                             \
> -       slub_percpu_partial(c) =3D (p)->next;     \
> -})
> -
> -#define slub_percpu_partial_read_once(c)       READ_ONCE(slub_percpu_par=
tial(c))
> -#else
> -#define slub_percpu_partial(c)                 NULL
> -
> -#define slub_set_percpu_partial(c, p)
> -
> -#define slub_percpu_partial_read_once(c)       NULL
> -#endif // CONFIG_SLUB_CPU_PARTIAL
> -
>  /*
>   * Word size structure that can be atomically updated or read and that
>   * contains both the order and the number of objects that a slab of the
> @@ -228,12 +205,6 @@ struct kmem_cache {
>         unsigned int object_size;       /* Object size without metadata *=
/
>         struct reciprocal_value reciprocal_size;
>         unsigned int offset;            /* Free pointer offset */
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       /* Number of per cpu partial objects to keep around */
> -       unsigned int cpu_partial;
> -       /* Number of per cpu partial slabs to keep around */
> -       unsigned int cpu_partial_slabs;
> -#endif
>         unsigned int sheaf_capacity;
>         struct kmem_cache_order_objects oo;
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 698c0d940f06..6b1280f7900a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -263,15 +263,6 @@ void *fixup_red_left(struct kmem_cache *s, void *p)
>         return p;
>  }
>
> -static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
> -{
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       return !kmem_cache_debug(s);
> -#else
> -       return false;
> -#endif
> -}
> -
>  /*
>   * Issues still to be resolved:
>   *
> @@ -426,9 +417,6 @@ struct freelist_tid {
>  struct kmem_cache_cpu {
>         struct freelist_tid;
>         struct slab *slab;      /* The slab from which we are allocating =
*/
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       struct slab *partial;   /* Partially allocated slabs */
> -#endif
>         local_trylock_t lock;   /* Protects the fields above */
>  #ifdef CONFIG_SLUB_STATS
>         unsigned int stat[NR_SLUB_STAT_ITEMS];
> @@ -673,29 +661,6 @@ static inline unsigned int oo_objects(struct kmem_ca=
che_order_objects x)
>         return x.x & OO_MASK;
>  }
>
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_o=
bjects)
> -{
> -       unsigned int nr_slabs;
> -
> -       s->cpu_partial =3D nr_objects;
> -
> -       /*
> -        * We take the number of objects but actually limit the number of
> -        * slabs on the per cpu partial list, in order to limit excessive
> -        * growth of the list. For simplicity we assume that the slabs wi=
ll
> -        * be half-full.
> -        */
> -       nr_slabs =3D DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
> -       s->cpu_partial_slabs =3D nr_slabs;
> -}
> -#elif defined(SLAB_SUPPORTS_SYSFS)
> -static inline void
> -slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
> -{
> -}
> -#endif /* CONFIG_SLUB_CPU_PARTIAL */
> -
>  /*
>   * If network-based swap is enabled, slub must keep track of whether mem=
ory
>   * were allocated from pfmemalloc reserves.
> @@ -3474,12 +3439,6 @@ static void *alloc_single_from_new_slab(struct kme=
m_cache *s, struct slab *slab,
>         return object;
>  }
>
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int=
 drain);
> -#else
> -static inline void put_cpu_partial(struct kmem_cache *s, struct slab *sl=
ab,
> -                                  int drain) { }
> -#endif
>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>
>  static bool get_partial_node_bulk(struct kmem_cache *s,
> @@ -3898,131 +3857,6 @@ static void deactivate_slab(struct kmem_cache *s,=
 struct slab *slab,
>  #define local_unlock_cpu_slab(s, flags)        \
>         local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
>
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -static void __put_partials(struct kmem_cache *s, struct slab *partial_sl=
ab)
> -{
> -       struct kmem_cache_node *n =3D NULL, *n2 =3D NULL;
> -       struct slab *slab, *slab_to_discard =3D NULL;
> -       unsigned long flags =3D 0;
> -
> -       while (partial_slab) {
> -               slab =3D partial_slab;
> -               partial_slab =3D slab->next;
> -
> -               n2 =3D get_node(s, slab_nid(slab));
> -               if (n !=3D n2) {
> -                       if (n)
> -                               spin_unlock_irqrestore(&n->list_lock, fla=
gs);
> -
> -                       n =3D n2;
> -                       spin_lock_irqsave(&n->list_lock, flags);
> -               }
> -
> -               if (unlikely(!slab->inuse && n->nr_partial >=3D s->min_pa=
rtial)) {
> -                       slab->next =3D slab_to_discard;
> -                       slab_to_discard =3D slab;
> -               } else {
> -                       add_partial(n, slab, DEACTIVATE_TO_TAIL);
> -                       stat(s, FREE_ADD_PARTIAL);
> -               }
> -       }
> -
> -       if (n)
> -               spin_unlock_irqrestore(&n->list_lock, flags);
> -
> -       while (slab_to_discard) {
> -               slab =3D slab_to_discard;
> -               slab_to_discard =3D slab_to_discard->next;
> -
> -               stat(s, DEACTIVATE_EMPTY);
> -               discard_slab(s, slab);
> -               stat(s, FREE_SLAB);
> -       }
> -}
> -
> -/*
> - * Put all the cpu partial slabs to the node partial list.
> - */
> -static void put_partials(struct kmem_cache *s)
> -{
> -       struct slab *partial_slab;
> -       unsigned long flags;
> -
> -       local_lock_irqsave(&s->cpu_slab->lock, flags);
> -       partial_slab =3D this_cpu_read(s->cpu_slab->partial);
> -       this_cpu_write(s->cpu_slab->partial, NULL);
> -       local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -
> -       if (partial_slab)
> -               __put_partials(s, partial_slab);
> -}
> -
> -static void put_partials_cpu(struct kmem_cache *s,
> -                            struct kmem_cache_cpu *c)
> -{
> -       struct slab *partial_slab;
> -
> -       partial_slab =3D slub_percpu_partial(c);
> -       c->partial =3D NULL;
> -
> -       if (partial_slab)
> -               __put_partials(s, partial_slab);
> -}
> -
> -/*
> - * Put a slab into a partial slab slot if available.
> - *
> - * If we did not find a slot then simply move all the partials to the
> - * per node partial list.
> - */
> -static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int=
 drain)
> -{
> -       struct slab *oldslab;
> -       struct slab *slab_to_put =3D NULL;
> -       unsigned long flags;
> -       int slabs =3D 0;
> -
> -       local_lock_cpu_slab(s, flags);
> -
> -       oldslab =3D this_cpu_read(s->cpu_slab->partial);
> -
> -       if (oldslab) {
> -               if (drain && oldslab->slabs >=3D s->cpu_partial_slabs) {
> -                       /*
> -                        * Partial array is full. Move the existing set t=
o the
> -                        * per node partial list. Postpone the actual unf=
reezing
> -                        * outside of the critical section.
> -                        */
> -                       slab_to_put =3D oldslab;
> -                       oldslab =3D NULL;
> -               } else {
> -                       slabs =3D oldslab->slabs;
> -               }
> -       }
> -
> -       slabs++;
> -
> -       slab->slabs =3D slabs;
> -       slab->next =3D oldslab;
> -
> -       this_cpu_write(s->cpu_slab->partial, slab);
> -
> -       local_unlock_cpu_slab(s, flags);
> -
> -       if (slab_to_put) {
> -               __put_partials(s, slab_to_put);
> -               stat(s, CPU_PARTIAL_DRAIN);
> -       }
> -}
> -
> -#else  /* CONFIG_SLUB_CPU_PARTIAL */
> -
> -static inline void put_partials(struct kmem_cache *s) { }
> -static inline void put_partials_cpu(struct kmem_cache *s,
> -                                   struct kmem_cache_cpu *c) { }
> -
> -#endif /* CONFIG_SLUB_CPU_PARTIAL */
> -
>  static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cp=
u *c)
>  {
>         unsigned long flags;
> @@ -4060,8 +3894,6 @@ static inline void __flush_cpu_slab(struct kmem_cac=
he *s, int cpu)
>                 deactivate_slab(s, slab, freelist);
>                 stat(s, CPUSLAB_FLUSH);
>         }
> -
> -       put_partials_cpu(s, c);
>  }
>
>  static inline void flush_this_cpu_slab(struct kmem_cache *s)
> @@ -4070,15 +3902,13 @@ static inline void flush_this_cpu_slab(struct kme=
m_cache *s)
>
>         if (c->slab)
>                 flush_slab(s, c);
> -
> -       put_partials(s);
>  }
>
>  static bool has_cpu_slab(int cpu, struct kmem_cache *s)
>  {
>         struct kmem_cache_cpu *c =3D per_cpu_ptr(s->cpu_slab, cpu);
>
> -       return c->slab || slub_percpu_partial(c);
> +       return c->slab;
>  }
>
>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
> @@ -5646,13 +5476,6 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>                 return;
>         }
>
> -       /*
> -        * It is enough to test IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) below
> -        * instead of kmem_cache_has_cpu_partial(s), because kmem_cache_d=
ebug(s)
> -        * is the only other reason it can be false, and it is already ha=
ndled
> -        * above.
> -        */
> -
>         do {
>                 if (unlikely(n)) {
>                         spin_unlock_irqrestore(&n->list_lock, flags);
> @@ -5677,26 +5500,19 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
>                  * Unless it's frozen.
>                  */
>                 if ((!new.inuse || was_full) && !was_frozen) {
> +
> +                       n =3D get_node(s, slab_nid(slab));
>                         /*
> -                        * If slab becomes non-full and we have cpu parti=
al
> -                        * lists, we put it there unconditionally to avoi=
d
> -                        * taking the list_lock. Otherwise we need it.
> +                        * Speculatively acquire the list_lock.
> +                        * If the cmpxchg does not succeed then we may
> +                        * drop the list_lock without any processing.
> +                        *
> +                        * Otherwise the list_lock will synchronize with
> +                        * other processors updating the list of slabs.
>                          */
> -                       if (!(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_=
full)) {
> -
> -                               n =3D get_node(s, slab_nid(slab));
> -                               /*
> -                                * Speculatively acquire the list_lock.
> -                                * If the cmpxchg does not succeed then w=
e may
> -                                * drop the list_lock without any process=
ing.
> -                                *
> -                                * Otherwise the list_lock will synchroni=
ze with
> -                                * other processors updating the list of =
slabs.
> -                                */
> -                               spin_lock_irqsave(&n->list_lock, flags);
> -
> -                               on_node_partial =3D slab_test_node_partia=
l(slab);
> -                       }
> +                       spin_lock_irqsave(&n->list_lock, flags);
> +
> +                       on_node_partial =3D slab_test_node_partial(slab);
>                 }
>
>         } while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"=
));
> @@ -5709,13 +5525,6 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>                          * activity can be necessary.
>                          */
>                         stat(s, FREE_FROZEN);
> -               } else if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_ful=
l) {
> -                       /*
> -                        * If we started with a full slab then put it ont=
o the
> -                        * per cpu partial list.
> -                        */
> -                       put_cpu_partial(s, slab, 1);
> -                       stat(s, CPU_PARTIAL_FREE);
>                 }
>
>                 /*
> @@ -5744,10 +5553,9 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>
>         /*
>          * Objects left in the slab. If it was not on the partial list be=
fore
> -        * then add it. This can only happen when cache has no per cpu pa=
rtial
> -        * list otherwise we would have put it there.
> +        * then add it.
>          */
> -       if (!IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && unlikely(was_full)) {
> +       if (unlikely(was_full)) {

This is not really related to your change but I wonder why we check
for was_full to detect that the slab was not on partial list instead
of checking !on_node_partial... They might be equivalent at this point
but it's still a bit confusing.

>                 add_partial(n, slab, DEACTIVATE_TO_TAIL);
>                 stat(s, FREE_ADD_PARTIAL);
>         }
> @@ -6396,8 +6204,8 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
>                 if (unlikely(!allow_spin)) {
>                         /*
>                          * __slab_free() can locklessly cmpxchg16 into a =
slab,
> -                        * but then it might need to take spin_lock or lo=
cal_lock
> -                        * in put_cpu_partial() for further processing.
> +                        * but then it might need to take spin_lock
> +                        * for further processing.
>                          * Avoid the complexity and simply add to a defer=
red list.
>                          */
>                         defer_free(s, head);
> @@ -7707,39 +7515,6 @@ static int init_kmem_cache_nodes(struct kmem_cache=
 *s)
>         return 1;
>  }
>
> -static void set_cpu_partial(struct kmem_cache *s)
> -{
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       unsigned int nr_objects;
> -
> -       /*
> -        * cpu_partial determined the maximum number of objects kept in t=
he
> -        * per cpu partial lists of a processor.
> -        *
> -        * Per cpu partial lists mainly contain slabs that just have one
> -        * object freed. If they are used for allocation then they can be
> -        * filled up again with minimal effort. The slab will never hit t=
he
> -        * per node partial lists and therefore no locking will be requir=
ed.
> -        *
> -        * For backwards compatibility reasons, this is determined as num=
ber
> -        * of objects, even though we now limit maximum number of pages, =
see
> -        * slub_set_cpu_partial()
> -        */
> -       if (!kmem_cache_has_cpu_partial(s))
> -               nr_objects =3D 0;
> -       else if (s->size >=3D PAGE_SIZE)
> -               nr_objects =3D 6;
> -       else if (s->size >=3D 1024)
> -               nr_objects =3D 24;
> -       else if (s->size >=3D 256)
> -               nr_objects =3D 52;
> -       else
> -               nr_objects =3D 120;
> -
> -       slub_set_cpu_partial(s, nr_objects);
> -#endif
> -}
> -
>  static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
>                                              struct kmem_cache_args *args=
)
>
> @@ -8595,8 +8370,6 @@ int do_kmem_cache_create(struct kmem_cache *s, cons=
t char *name,
>         s->min_partial =3D min_t(unsigned long, MAX_PARTIAL, ilog2(s->siz=
e) / 2);
>         s->min_partial =3D max_t(unsigned long, MIN_PARTIAL, s->min_parti=
al);
>
> -       set_cpu_partial(s);
> -
>         s->cpu_sheaves =3D alloc_percpu(struct slub_percpu_sheaves);
>         if (!s->cpu_sheaves) {
>                 err =3D -ENOMEM;
> @@ -8960,20 +8733,6 @@ static ssize_t show_slab_objects(struct kmem_cache=
 *s,
>                         total +=3D x;
>                         nodes[node] +=3D x;
>
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -                       slab =3D slub_percpu_partial_read_once(c);
> -                       if (slab) {
> -                               node =3D slab_nid(slab);
> -                               if (flags & SO_TOTAL)
> -                                       WARN_ON_ONCE(1);
> -                               else if (flags & SO_OBJECTS)
> -                                       WARN_ON_ONCE(1);
> -                               else
> -                                       x =3D data_race(slab->slabs);
> -                               total +=3D x;
> -                               nodes[node] +=3D x;
> -                       }
> -#endif
>                 }
>         }
>
> @@ -9108,12 +8867,7 @@ SLAB_ATTR(min_partial);
>
>  static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
>  {
> -       unsigned int nr_partial =3D 0;
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       nr_partial =3D s->cpu_partial;
> -#endif
> -
> -       return sysfs_emit(buf, "%u\n", nr_partial);
> +       return sysfs_emit(buf, "0\n");
>  }
>
>  static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
> @@ -9125,11 +8879,9 @@ static ssize_t cpu_partial_store(struct kmem_cache=
 *s, const char *buf,
>         err =3D kstrtouint(buf, 10, &objects);
>         if (err)
>                 return err;
> -       if (objects && !kmem_cache_has_cpu_partial(s))
> +       if (objects)
>                 return -EINVAL;
>
> -       slub_set_cpu_partial(s, objects);
> -       flush_all(s);
>         return length;
>  }
>  SLAB_ATTR(cpu_partial);
> @@ -9168,42 +8920,7 @@ SLAB_ATTR_RO(objects_partial);
>
>  static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  {
> -       int objects =3D 0;
> -       int slabs =3D 0;
> -       int cpu __maybe_unused;
> -       int len =3D 0;
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       for_each_online_cpu(cpu) {
> -               struct slab *slab;
> -
> -               slab =3D slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu=
));
> -
> -               if (slab)
> -                       slabs +=3D data_race(slab->slabs);
> -       }
> -#endif
> -
> -       /* Approximate half-full slabs, see slub_set_cpu_partial() */
> -       objects =3D (slabs * oo_objects(s->oo)) / 2;
> -       len +=3D sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
> -
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -       for_each_online_cpu(cpu) {
> -               struct slab *slab;
> -
> -               slab =3D slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu=
));
> -               if (slab) {
> -                       slabs =3D data_race(slab->slabs);
> -                       objects =3D (slabs * oo_objects(s->oo)) / 2;
> -                       len +=3D sysfs_emit_at(buf, len, " C%d=3D%d(%d)",
> -                                            cpu, objects, slabs);
> -               }
> -       }
> -#endif
> -       len +=3D sysfs_emit_at(buf, len, "\n");
> -
> -       return len;
> +       return sysfs_emit(buf, "0(0)\n");
>  }
>  SLAB_ATTR_RO(slabs_cpu_partial);
>
>
> --
> 2.52.0
>
