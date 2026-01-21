Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417313644CF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020245; cv=pass; b=kHWuLCWu/kkx/ZA16uSzcodLMxDcQp8A+kMXamvwesdD6zmdtl3yccYEvseePH1fQXd25g9E2RWJ62AswxfiJrQA87F3Pd/U8A15ZedOQJt3B0oL/JmJfa3n4mVzEtwmHb1QrNqT/ZAlOiL/Q6P3elvT+HMCho1J+/t9HNl4tMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020245; c=relaxed/simple;
	bh=/9VJUFF9ruHM7qSzpdjHScGya0CItlSE0a9twsqMD2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5lQTd0dhj+0rsrc0IFeEiQuEJ9+Uv0kgmL/0Cmzl20vOL13/OGYd8O1U3GgFrROqPb+3zOMJ8hzpkhy8w3o5y6pWcDbGCK6bLXB3chwXgry6Vr0RipA6NC8eqVX3xs1djpHm5YmFhFR93SO/dMykHXo2tKoJJTNdnkmnXxcmxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSnBm1/9; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSnBm1/9"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so36481cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 10:30:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769020241; cv=none;
        d=google.com; s=arc-20240605;
        b=Ar0NU/gPthkUAiwarIPDKfIK89roXuZgzaBZHcdYh/H/268VHtUwym1aXGvlaARnD1
         UuTXqvgeKNPfeS0ywVrlMldBov7taFkgbh5zal4zefbYxmwaIOujyF8t0idMhz+cXtgd
         0mZPJ9f37Mjg1HEAi7N27eHfOtCTmTdvkJN9+3A18IXIl6ZVqGAIqWSFdWyITQX4Ahx+
         /kZSi2mlnf+5PZjKkqJziuxo+kjcxWdecJbJ5d91djaQ13S5xGjqTNwn6aQ2zYY9JZ9q
         nurtCC6s50k9Z3eNMOHk5+tPN7KVzJatXFemwD/U0joL6CxEQrgiw3W3nZILGXNwpaz7
         kEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hk+loGahu/yMxf2HTXU45I8jZGBJg9jz2G1ZhRfU2lM=;
        fh=/1Kuw6BIvaP2TzxozgaF0HPuOAt47ThC4V1LsGTsUys=;
        b=QtUtfx8LZfDJJOMJRGLZt8/WekUwrWXLwfiN33ilCEHXGGTv5Riwjfm50bv3kJWgiP
         R2oh+A3HZIGopjsBKmm0aIV4+gODRgg+oqjhy7k4MQapXLG91oAn2aQYdN5b8esDtnSF
         nKTtUtDi9/pR8VUiBs3HODzikGhWxVr6tJNJ8dqboomLf9IcC94jYylbvbavz+YA4pJ+
         EzmV2YxjPoNhl7WiNwmf8JGKPNGmSi4HRSVYOoU0799B7rdkFqGNjbk5YxF+La3yPcDe
         mXntjQdrrlzxcjfVVzMaC4VbyhqW5CS9jwINwOvG/xJCsitX/frntSND0kzMDjsadXBL
         c6Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769020241; x=1769625041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk+loGahu/yMxf2HTXU45I8jZGBJg9jz2G1ZhRfU2lM=;
        b=pSnBm1/9ArLTbe2VrCtGxD1xqLZgn1+DFChsU9XiI49QUc94xhlGR7At7RsOLL4v2b
         SBZENluZ+QeMu+H/EEeOH8pgNauUn/PM6+N6OdhTr1i/A1i2Y64xDzLRHzfM3lElNhff
         DzDA5UK/+YSkodm3U95SoNpT6+cnYNwcZmCYIFjqH9c5bPFaaK0VaVFTigDKd4Y8iOXK
         Q9VTxnWMsIZx/Yu1I6gQRjn7SyYBMcTq5ygohOQFgiAXaNN2q910jdNB2uGWAFA6oHOP
         zsTMspCm9JEpU6cTOqdsyIpumNwxU3NeDggr5dwSfXwxg8rL0/w4a4l9qgPsuZqb6w/z
         TS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769020241; x=1769625041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hk+loGahu/yMxf2HTXU45I8jZGBJg9jz2G1ZhRfU2lM=;
        b=Hl4nTPaQ+wtNt9iinXFd3URTqQ/JajDQa4qhXYxpmDZnl0mvi1QrvjHWn7ycqS4xss
         XxXnxgQdcKb2rPyiiuWj58IwHooDrnz0kuwYLax1YEbiaZMWS2mTZ7hy9P4YtUNVG7aF
         cBN2OM3+bcwBMKsp3OHhqZI3jdb2P6c3lu+qx3K1PuaPucl/zzPyKWov9cpL+9conR/u
         U7GDCEB/Mgo7nFpqqX8tVJNbh2t0Gy0FY3asD0h0o0IrNVZB84ohagm5dk3MqcJS488o
         +8Eq/Jwn7uBQc8SwBem6x1aMwMt4B5XNC2aFHCAgFICksAhqDQLMTbDsv51YQRiATeaL
         kt2A==
X-Forwarded-Encrypted: i=1; AJvYcCW7wUeZ/ye+nspb5a1yr89/Sj2PodIemMXpD6k6iDzbhYI1JrwEKzdY702mKmw3zZ7eqLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeA3DbuxCTWGwxoZ3blb0u4+hrJUqeD2Wne0K/V25pUB4lwrbE
	5ZlxxBYyyAag+rJuiBpUw1H+Lbn7QylcU+hTxJhVUx01n8dqQdTfEaX8h5sH/Mrsd0UYW0zGEsS
	AuOhS5W6RJnsHFoTiKKYLF/vbs0tP8NN4SVcDFB8I
X-Gm-Gg: AZuq6aKBrlwRuZYsP94cliILUpEMeJT9+6VPTY6wACl0Lz9C35tXLNXO9IrCxb5pazh
	aNPpazCokNZ4NEK/NcEwLPu2gOz7w77r7PE8G+xDF2ia8zqJBhDPh96kY8AcGTmd5cyGpBw79ZI
	gYt1rs0oB/vJemO1p6NkUKPdAkP9aqq1Kmw6Xl//SfSckPcWxeemtLl2dHho6AWnXbuwkOGlQI5
	6sJg7hWShZKJ5ArrygoDFcrmpBB1G1pkr9J64OBAMfbOczTGNTdTZ7VJeui51n23tt1O1W1EU1V
	jDcUUvcd8B4u+PDuGe+VxH0=
X-Received: by 2002:a05:622a:1825:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-502ebddf1damr405151cf.1.1769020240526; Wed, 21 Jan 2026
 10:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-17-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-17-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 18:30:28 +0000
X-Gm-Features: AZwV_QgJsx28PWNy6MDtA7PMODlO-XxW0gxWFH0Lcu8zvlUQSetLY7ny4kvP86A
Message-ID: <CAJuCfpHi_WqPkWvQuDqg3L1FNeV-P=E52uCakBCXz1AFmkHf=Q@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] slab: refill sheaves from all nodes
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
> __refill_objects() currently only attempts to get partial slabs from the
> local node and then allocates new slab(s). Expand it to trying also
> other nodes while observing the remote node defrag ratio, similarly to
> get_any_partial().
>
> This will prevent allocating new slabs on a node while other nodes have
> many free slabs. It does mean sheaves will contain non-local objects in
> that case. Allocations that care about specific node will still be
> served appropriately, but might get a slowpath allocation.
>
> Like get_any_partial() we do observe cpuset_zone_allowed(), although we
> might be refilling a sheaf that will be then used from a different
> allocation context.
>
> We can also use the resulting refill_objects() in
> __kmem_cache_alloc_bulk() for non-debug caches. This means
> kmem_cache_alloc_bulk() will get better performance when sheaves are
> exhausted. kmem_cache_alloc_bulk() cannot indicate a preferred node so
> it's compatible with sheaves refill in preferring the local node.
> Its users also have gfp flags that allow spinning, so document that
> as a requirement.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 106 insertions(+), 31 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d52de6e3c2d5..2c522d2bf547 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2518,8 +2518,8 @@ static void free_empty_sheaf(struct kmem_cache *s, =
struct slab_sheaf *sheaf)
>  }
>
>  static unsigned int
> -__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> -                unsigned int max);
> +refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int m=
in,
> +              unsigned int max);
>
>  static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>                          gfp_t gfp)
> @@ -2530,8 +2530,8 @@ static int refill_sheaf(struct kmem_cache *s, struc=
t slab_sheaf *sheaf,
>         if (!to_fill)
>                 return 0;
>
> -       filled =3D __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
> -                       to_fill, to_fill);
> +       filled =3D refill_objects(s, &sheaf->objects[sheaf->size], gfp, t=
o_fill,
> +                               to_fill);
>
>         sheaf->size +=3D filled;
>
> @@ -6522,29 +6522,22 @@ void kmem_cache_free_bulk(struct kmem_cache *s, s=
ize_t size, void **p)
>  EXPORT_SYMBOL(kmem_cache_free_bulk);
>
>  static unsigned int
> -__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int=
 min,
> -                unsigned int max)
> +__refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigne=
d int min,
> +                     unsigned int max, struct kmem_cache_node *n)
>  {
>         struct slab *slab, *slab2;
>         struct partial_context pc;
>         unsigned int refilled =3D 0;
>         unsigned long flags;
>         void *object;
> -       int node;
>
>         pc.flags =3D gfp;
>         pc.min_objects =3D min;
>         pc.max_objects =3D max;
>
> -       node =3D numa_mem_id();
> -
> -       if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +       if (!get_partial_node_bulk(s, n, &pc))
>                 return 0;
>
> -       /* TODO: consider also other nodes? */
> -       if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> -               goto new_slab;
> -
>         list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
>
>                 list_del(&slab->slab_list);
> @@ -6582,8 +6575,6 @@ __refill_objects(struct kmem_cache *s, void **p, gf=
p_t gfp, unsigned int min,
>         }
>
>         if (unlikely(!list_empty(&pc.slabs))) {
> -               struct kmem_cache_node *n =3D get_node(s, node);
> -
>                 spin_lock_irqsave(&n->list_lock, flags);
>
>                 list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_lis=
t) {
> @@ -6605,13 +6596,92 @@ __refill_objects(struct kmem_cache *s, void **p, =
gfp_t gfp, unsigned int min,
>                 }
>         }
>
> +       return refilled;
> +}
>
> -       if (likely(refilled >=3D min))
> -               goto out;
> +#ifdef CONFIG_NUMA
> +static unsigned int
> +__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned=
 int min,
> +                    unsigned int max, int local_node)
> +{
> +       struct zonelist *zonelist;
> +       struct zoneref *z;
> +       struct zone *zone;
> +       enum zone_type highest_zoneidx =3D gfp_zone(gfp);
> +       unsigned int cpuset_mems_cookie;
> +       unsigned int refilled =3D 0;
> +
> +       /* see get_any_partial() for the defrag ratio description */
> +       if (!s->remote_node_defrag_ratio ||
> +                       get_cycles() % 1024 > s->remote_node_defrag_ratio=
)
> +               return 0;
> +
> +       do {
> +               cpuset_mems_cookie =3D read_mems_allowed_begin();
> +               zonelist =3D node_zonelist(mempolicy_slab_node(), gfp);
> +               for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx=
) {
> +                       struct kmem_cache_node *n;
> +                       unsigned int r;
> +
> +                       n =3D get_node(s, zone_to_nid(zone));
> +
> +                       if (!n || !cpuset_zone_allowed(zone, gfp) ||
> +                                       n->nr_partial <=3D s->min_partial=
)
> +                               continue;
> +
> +                       r =3D __refill_objects_node(s, p, gfp, min, max, =
n);
> +                       refilled +=3D r;
> +
> +                       if (r >=3D min) {
> +                               /*
> +                                * Don't check read_mems_allowed_retry() =
here -
> +                                * if mems_allowed was updated in paralle=
l, that
> +                                * was a harmless race between allocation=
 and
> +                                * the cpuset update
> +                                */
> +                               return refilled;
> +                       }
> +                       p +=3D r;
> +                       min -=3D r;
> +                       max -=3D r;
> +               }
> +       } while (read_mems_allowed_retry(cpuset_mems_cookie));
> +
> +       return refilled;
> +}
> +#else
> +static inline unsigned int
> +__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned=
 int min,
> +                    unsigned int max, int local_node)
> +{
> +       return 0;
> +}
> +#endif
> +
> +static unsigned int
> +refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int m=
in,
> +              unsigned int max)
> +{
> +       int local_node =3D numa_mem_id();
> +       unsigned int refilled;
> +       struct slab *slab;
> +
> +       if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> +               return 0;
> +
> +       refilled =3D __refill_objects_node(s, p, gfp, min, max,
> +                                        get_node(s, local_node));
> +       if (refilled >=3D min)
> +               return refilled;
> +
> +       refilled +=3D __refill_objects_any(s, p + refilled, gfp, min - re=
filled,
> +                                        max - refilled, local_node);
> +       if (refilled >=3D min)
> +               return refilled;
>
>  new_slab:
>
> -       slab =3D new_slab(s, pc.flags, node);
> +       slab =3D new_slab(s, gfp, local_node);
>         if (!slab)
>                 goto out;
>
> @@ -6626,8 +6696,8 @@ __refill_objects(struct kmem_cache *s, void **p, gf=
p_t gfp, unsigned int min,
>
>         if (refilled < min)
>                 goto new_slab;
> -out:
>
> +out:
>         return refilled;
>  }
>
> @@ -6637,18 +6707,20 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s,=
 gfp_t flags, size_t size,
>  {
>         int i;
>
> -       /*
> -        * TODO: this might be more efficient (if necessary) by reusing
> -        * __refill_objects()
> -        */
> -       for (i =3D 0; i < size; i++) {
> +       if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> +               for (i =3D 0; i < size; i++) {
>
> -               p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
> -                                    s->object_size);
> -               if (unlikely(!p[i]))
> -                       goto error;
> +                       p[i] =3D ___slab_alloc(s, flags, NUMA_NO_NODE, _R=
ET_IP_,
> +                                            s->object_size);
> +                       if (unlikely(!p[i]))
> +                               goto error;
>
> -               maybe_wipe_obj_freeptr(s, p[i]);
> +                       maybe_wipe_obj_freeptr(s, p[i]);
> +               }
> +       } else {
> +               i =3D refill_objects(s, p, flags, size, size);
> +               if (i < size)
> +                       goto error;
>         }
>
>         return i;
> @@ -6659,7 +6731,10 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, =
gfp_t flags, size_t size,
>
>  }
>
> -/* Note that interrupts must be enabled when calling this function. */
> +/*
> + * Note that interrupts must be enabled when calling this function and g=
fp
> + * flags must allow spinning.
> + */
>  int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size=
_t size,
>                                  void **p)
>  {
>
> --
> 2.52.0
>
