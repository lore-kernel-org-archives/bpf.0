Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A73EDAC9
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029124; cv=pass; b=kVzPWQclKId70BNVDkvN1/NmxlxR7AMM5tnzsaSsl97uErtt2OIae+U4lBFNaUoq0Z1MtI9iDy2PsbfKrijQD+2PFIDI6WAMj5TsWu51QAAhnBkL7nU0SazDhLa7sG10/E+uyip0v1ZD0yT9rWu9zsjFhitbFV4GPSiArWBiD0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029124; c=relaxed/simple;
	bh=YDyHEOSMn673X668lJYw+uyqdF+ziUDMh+gWKCZFRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJrY02e2/EhYZMYvNyHCZPFVi4ynRyLuKAvhgBjT3RGqMgowVH+x94C3zF9MN1uDfry5fzeTl3Da+hQHQj+xnAhDh7bygQGWBCrCWuvXsU9k6SfroKmg7dl8PrIAUL9Ai3cHqO/FiR+CEKFejGuQNeC8F4V9r9uXIHZ+Omt5KQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmQZrStR; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmQZrStR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50299648ae9so20821cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 12:58:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029120; cv=none;
        d=google.com; s=arc-20240605;
        b=b29QzIgJcZ29tK4zrqPwi0wZsNvTEAXlRK53RGtxK0JZahNdea6FyLv8p7yvXkXLmA
         p6nf0d2fkDX6u6qinaZwmh3mCCFQTxtKALzmEtVW7IeqoxmlxIW2tPPUPQU92MkxuvAO
         UYHCbxz4fomQc+5GXy6kvqXwQ3xETYNHRNwhY4whMYhRSRAWYKlqgD2Hjd6oYwDTOxZ1
         xjI7Xt5Y2zAj2rYdNRJpbzMCXXagm3tmoJWiSZxKQiD+4KqXgjd6Sn2lBc49B4Z9ODTY
         TIjzPMaemfKPgQ2AVGTq8NGDAH3HysltgzrqvU1CxVBCOZ3U6b75sdsvlfvUm6MPmtO4
         y+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        fh=Y5i5t49Hl8obLXTYg6m4l6qer4cpWdMjuhanvewd+x8=;
        b=AybWPBjce2x6wNR4WhrrNEv3Qdlj2l9g1S8j0cqQnSEZ7bqxoyhPK76r37DKVvnxw6
         D/NlsLYlk7QTSA/mA6Xxm/By3et1M7vKRed8zaPHaAw6ycDgzIHlk/6gvOE3/pKtq+H4
         2HQILLTwEydbgHLsMX4DLqDF0HepAgzXfdLfPBn2XxmJimuYgynXh8zpc9le4QUVTorL
         XuzCpgvKgDACAFnpBxwUydZMF9VIN4xwzyKuo/g+SVG+WcVw1JNHmzZYnhipg7j/3mhd
         EUjIgi4K22Z+salW28N37o18UF2rg/ZXqUTUuD46qUyqKJCQZXwlQp0YMksCyZfmIkCa
         pMAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769029120; x=1769633920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        b=AmQZrStRfqtT80psLJzrOcHhgPOB5a3uC8YzNKFAJ1ZlO+RMRd+RYNM2pWqL9iQ8zz
         gCejgNNKfcz5l2Ilo7v734bHmX/ntX8h6liIaZvXM4yLQ67ktHCxt4BQ+owfLOrOTWZq
         CpaR+DsA4UOu1mdI1Dgzg9yqj2Kwc61WdxAB8Vvhbi3M6RZvaqQ2vKFORi2WAhoiMBfO
         XRF7nxrA9QwaJmLp8+MyO2OVYddFBBOdyDf3vv8PfkwoDtQ1KE7QRSYgF+vVXlkerw3c
         TO8ZeL5wEEFCaXGo1X1X4HBDgw4NjlBVA86E+YaVmoV/AlL9PRtNDjndSTa2yNcRenev
         lfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029120; x=1769633920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MeTYXI3uAiRssw+rn1c1/h9gP0ELwUJeF0lPi9KAVw=;
        b=VV7YvBSiJQJ29cRLLBCwboy+dhK+4F8bWQsws2jyPwyfr2/X37o+/9gLOGiV5ReC9G
         h53uVog4J2jrtsyzW5RAYyqiZDIKsUAYQ+YrZyFpAuICTt84WaJqbi7/Qe8++jjbR61n
         p85ufdfN7vR/+jScVKexSX90/ajdmeqqhxkMeY5nk2pL2UDjtkiWTfLvNmgPQkTQte77
         UFixHE113kdQ1OCmXu9WmQ3y5TYQKIpKAemkA5LmzEF3z/GNemAtld2trPNIzRasmO6L
         CnofesOy6DdyyVZnHVsG/KF59ut49mYeyd8tAfctPb9X38Mv/Ybv8uhMMqxZ6+906yjH
         HBuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhecQySudK4uVbrgBOeiWuXhIoGCuL8iVO19u7MGKpvD36j8kycuKLWlLMcz/tgt8jdek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPhDZRAgsf8EthoMdNzieKexaQgZWGwo3Ilbrv2CCnNyuhOaO
	gPsMccckeo34C4TX9YnN8Qt16AiJf774VJh1wQE7hC0cDV/IwvkblPI054jCFfMaeW5laYuLNwg
	t4VjWZFdRBF3gZZDU/w1IZwVf8uzm62q8HNKR96v0
X-Gm-Gg: AZuq6aLok62rAvMdJ9B4UVQE4znWgVibwNBBboN7wucpbzM8EcmtMTTEfyMshL3gvSX
	LDEE8RtXEgZAlYrik/p3kJ6KAUud2LWXz1zdjBQ20znO6/emujCMYzgBimfIcsi3HkhJN5KKQQd
	bPpfjCfHA4abYTuKR2nnAvw+BWj+Zpqmw5T42GRSqQ+Prt1rbiVqdmIqH0yzGHq1NcAM7MaVlq4
	7tFys59C+SV5xjXw1v9uF/uU8vxV3R68EUGbFCxohXWSOAd0ml1PUpE+qaPzmwTY5oC7aYLCNmS
	67L8lp1AgzIoZ4oENx0MsxE=
X-Received: by 2002:ac8:7d13:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-502ebd66753mr2584691cf.14.1769029119662; Wed, 21 Jan 2026
 12:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz> <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 20:58:27 +0000
X-Gm-Features: AZwV_QgyZJFEnbtAO31t9RJqeLgp-_C0IEAaScaHgOZ1k_x7UdBOLV4hvrPmpf8
Message-ID: <CAJuCfpHZ5xJwg8uvK4XJ1+oBuNYQv3XMO8LHt9eEj_tJE=WkpA@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] slab: update overview comments
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
> The changes related to sheaves made the description of locking and other
> details outdated. Update it to reflect current state.
>
> Also add a new copyright line due to major changes.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 141 +++++++++++++++++++++++++++++---------------------------=
------
>  1 file changed, 67 insertions(+), 74 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2c522d2bf547..476a279f1a94 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1,13 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * SLUB: A slab allocator that limits cache line use instead of queuing
> - * objects in per cpu and per node lists.
> + * SLUB: A slab allocator with low overhead percpu array caches and most=
ly
> + * lockless freeing of objects to slabs in the slowpath.
>   *
> - * The allocator synchronizes using per slab locks or atomic operations
> - * and only uses a centralized lock to manage a pool of partial slabs.
> + * The allocator synchronizes using spin_trylock for percpu arrays in th=
e
> + * fastpath, and cmpxchg_double (or bit spinlock) for slowpath freeing.
> + * Uses a centralized lock to manage a pool of partial slabs.
>   *
>   * (C) 2007 SGI, Christoph Lameter
>   * (C) 2011 Linux Foundation, Christoph Lameter
> + * (C) 2025 SUSE, Vlastimil Babka
>   */
>
>  #include <linux/mm.h>
> @@ -53,11 +55,13 @@
>
>  /*
>   * Lock order:
> - *   1. slab_mutex (Global Mutex)
> - *   2. node->list_lock (Spinlock)
> - *   3. kmem_cache->cpu_slab->lock (Local lock)
> - *   4. slab_lock(slab) (Only on some arches)
> - *   5. object_map_lock (Only for debugging)
> + *   0.  cpu_hotplug_lock
> + *   1.  slab_mutex (Global Mutex)
> + *   2a. kmem_cache->cpu_sheaves->lock (Local trylock)
> + *   2b. node->barn->lock (Spinlock)
> + *   2c. node->list_lock (Spinlock)
> + *   3.  slab_lock(slab) (Only on some arches)
> + *   4.  object_map_lock (Only for debugging)
>   *
>   *   slab_mutex
>   *
> @@ -78,31 +82,38 @@
>   *     C. slab->objects        -> Number of objects in slab
>   *     D. slab->frozen         -> frozen state
>   *
> - *   Frozen slabs
> + *   SL_partial slabs
> + *
> + *   Slabs on node partial list have at least one free object. A limited=
 number
> + *   of slabs on the list can be fully free (slab->inuse =3D=3D 0), unti=
l we start
> + *   discarding them. These slabs are marked with SL_partial, and the fl=
ag is
> + *   cleared while removing them, usually to grab their freelist afterwa=
rds.
> + *   This clearing also exempts them from list management. Please see
> + *   __slab_free() for more details.
>   *
> - *   If a slab is frozen then it is exempt from list management. It is
> - *   the cpu slab which is actively allocated from by the processor that
> - *   froze it and it is not on any list. The processor that froze the
> - *   slab is the one who can perform list operations on the slab. Other
> - *   processors may put objects onto the freelist but the processor that
> - *   froze the slab is the only one that can retrieve the objects from t=
he
> - *   slab's freelist.
> + *   Full slabs
>   *
> - *   CPU partial slabs
> + *   For caches without debugging enabled, full slabs (slab->inuse =3D=
=3D
> + *   slab->objects and slab->freelist =3D=3D NULL) are not placed on any=
 list.
> + *   The __slab_free() freeing the first object from such a slab will pl=
ace
> + *   it on the partial list. Caches with debugging enabled place such sl=
ab
> + *   on the full list and use different allocation and freeing paths.
> + *
> + *   Frozen slabs
>   *
> - *   The partially empty slabs cached on the CPU partial list are used
> - *   for performance reasons, which speeds up the allocation process.
> - *   These slabs are not frozen, but are also exempt from list managemen=
t,
> - *   by clearing the SL_partial flag when moving out of the node
> - *   partial list. Please see __slab_free() for more details.
> + *   If a slab is frozen then it is exempt from list management. It is u=
sed to
> + *   indicate a slab that has failed consistency checks and thus cannot =
be
> + *   allocated from anymore - it is also marked as full. Any previously
> + *   allocated objects will be simply leaked upon freeing instead of att=
empting
> + *   to modify the potentially corrupted freelist and metadata.
>   *
>   *   To sum up, the current scheme is:
> - *   - node partial slab: SL_partial && !frozen
> - *   - cpu partial slab: !SL_partial && !frozen
> - *   - cpu slab: !SL_partial && frozen
> - *   - full slab: !SL_partial && !frozen
> + *   - node partial slab:            SL_partial && !full && !frozen
> + *   - taken off partial list:      !SL_partial && !full && !frozen
> + *   - full slab, not on any list:  !SL_partial &&  full && !frozen
> + *   - frozen due to inconsistency: !SL_partial &&  full &&  frozen
>   *
> - *   list_lock
> + *   node->list_lock (spinlock)
>   *
>   *   The list_lock protects the partial and full list on each node and
>   *   the partial slab counter. If taken then no new slabs may be added o=
r
> @@ -112,47 +123,46 @@
>   *
>   *   The list_lock is a centralized lock and thus we avoid taking it as
>   *   much as possible. As long as SLUB does not have to handle partial
> - *   slabs, operations can continue without any centralized lock. F.e.
> - *   allocating a long series of objects that fill up slabs does not req=
uire
> - *   the list lock.
> + *   slabs, operations can continue without any centralized lock.
>   *
>   *   For debug caches, all allocations are forced to go through a list_l=
ock
>   *   protected region to serialize against concurrent validation.
>   *
> - *   cpu_slab->lock local lock
> + *   cpu_sheaves->lock (local_trylock)
>   *
> - *   This locks protect slowpath manipulation of all kmem_cache_cpu fiel=
ds
> - *   except the stat counters. This is a percpu structure manipulated on=
ly by
> - *   the local cpu, so the lock protects against being preempted or inte=
rrupted
> - *   by an irq. Fast path operations rely on lockless operations instead=
.
> + *   This lock protects fastpath operations on the percpu sheaves. On !R=
T it
> + *   only disables preemption and does no atomic operations. As long as =
the main
> + *   or spare sheaf can handle the allocation or free, there is no other
> + *   overhead.
>   *
> - *   On PREEMPT_RT, the local lock neither disables interrupts nor preem=
ption
> - *   which means the lockless fastpath cannot be used as it might interf=
ere with
> - *   an in-progress slow path operations. In this case the local lock is=
 always
> - *   taken but it still utilizes the freelist for the common operations.
> + *   node->barn->lock (spinlock)
>   *
> - *   lockless fastpaths
> + *   This lock protects the operations on per-NUMA-node barn. It can qui=
ckly
> + *   serve an empty or full sheaf if available, and avoid more expensive=
 refill
> + *   or flush operation.
>   *
> - *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_f=
ree())
> - *   are fully lockless when satisfied from the percpu slab (and when
> - *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
> - *   They also don't disable preemption or migration or irqs. They rely =
on
> - *   the transaction id (tid) field to detect being preempted or moved t=
o
> - *   another cpu.
> + *   Lockless freeing
> + *
> + *   Objects may have to be freed to their slabs when they are from a re=
mote
> + *   node (where we want to avoid filling local sheaves with remote obje=
cts)
> + *   or when there are too many full sheaves. On architectures supportin=
g
> + *   cmpxchg_double this is done by a lockless update of slab's freelist=
 and
> + *   counters, otherwise slab_lock is taken. This only needs to take the
> + *   list_lock if it's a first free to a full slab, or when there are to=
o many
> + *   fully free slabs and some need to be discarded.
>   *
>   *   irq, preemption, migration considerations
>   *
> - *   Interrupts are disabled as part of list_lock or local_lock operatio=
ns, or
> + *   Interrupts are disabled as part of list_lock or barn lock operation=
s, or
>   *   around the slab_lock operation, in order to make the slab allocator=
 safe
>   *   to use in the context of an irq.
> + *   Preemption is disabled as part of local_trylock operations.
> + *   kmalloc_nolock() and kfree_nolock() are safe in NMI context but see
> + *   their limitations.
>   *
> - *   In addition, preemption (or migration on PREEMPT_RT) is disabled in=
 the
> - *   allocation slowpath, bulk allocation, and put_cpu_partial(), so tha=
t the
> - *   local cpu doesn't change in the process and e.g. the kmem_cache_cpu=
 pointer
> - *   doesn't have to be revalidated in each section protected by the loc=
al lock.
> - *
> - * SLUB assigns one slab for allocation to each processor.
> - * Allocations only occur from these slabs called cpu slabs.
> + * SLUB assigns two object arrays called sheaves for caching allocation =
and

s/allocation/allocations

> + * frees on each cpu, with a NUMA node shared barn for balancing between=
 cpus.
> + * Allocations and frees are primarily served from these sheaves.
>   *
>   * Slabs with free elements are kept on a partial list and during regula=
r
>   * operations no list for full slabs is used. If an object in a full sla=
b is
> @@ -160,25 +170,8 @@
>   * We track full slabs for debugging purposes though because otherwise w=
e
>   * cannot scan all objects.
>   *
> - * Slabs are freed when they become empty. Teardown and setup is
> - * minimal so we rely on the page allocators per cpu caches for
> - * fast frees and allocs.
> - *
> - * slab->frozen                The slab is frozen and exempt from list p=
rocessing.
> - *                     This means that the slab is dedicated to a purpos=
e
> - *                     such as satisfying allocations for a specific
> - *                     processor. Objects may be freed in the slab while
> - *                     it is frozen but slab_free will then skip the usu=
al
> - *                     list operations. It is up to the processor holdin=
g
> - *                     the slab to integrate the slab into the slab list=
s
> - *                     when the slab is no longer needed.
> - *
> - *                     One use of this flag is to mark slabs that are
> - *                     used for allocations. Then such a slab becomes a =
cpu
> - *                     slab. The cpu slab may be equipped with an additi=
onal
> - *                     freelist that allows lockless access to
> - *                     free objects in addition to the regular freelist
> - *                     that requires the slab lock.
> + * Slabs are freed when they become empty. Teardown and setup is minimal=
 so we
> + * rely on the page allocators per cpu caches for fast frees and allocs.
>   *
>   * SLAB_DEBUG_FLAGS    Slab requires special handling due to debug
>   *                     options set. This moves slab handling out of
>
> --
> 2.52.0
>
