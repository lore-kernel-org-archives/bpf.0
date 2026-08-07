Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF946E00D;
	Fri,  7 Aug 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115177; cv=none; b=TsK4C6gbDYjuwoc5OXAO5CKR4goMsx/GGP1iKHOguf00IM9ig2lAQalAX9V+jNb2iaNnKq3SuiO3XmgXvo5yCQvgdyLFzq5yD6pIUuHcmn10GVeHVi7jJUumWDkzyrQJ7MQOykyjdztIZcDEHZ3mufF3U6n5Zcoyf1M0p8IvMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115177; c=relaxed/simple;
	bh=yk4LsY4gIh9UJrIyWO9SAoByH68iNr9VG0NYvYTzYic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uFFPJviBgOd+8pPjMUqgBPi2xmFHEvwusSQOjhlzV1RS9biMiM/2u+IaX6NizeAl3avLDwjkRP7Ggxu4CXq0d8pFrci91l8uQKacwE7HeSb2MMhCPSxwuLYNjaGUHAxsYQlP7NLULphmmNXZqeek9S6TZdio3UrL65DYPcJW7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNCX9Etr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNCX9Etr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDED21F000E9;
	Fri,  7 Aug 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115170;
	bh=IksxDfdyGRteW5g2TlU26RLrf5nK8spnIwRAVc8SqZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNCX9Etr1SQ+JZt+iDDCUbtz1fHaQOl+iCUjwW4hx5zifpG/t6Zw/Q7lz0fiL80Rs
	 Dyab2n9L/vRNCnErqyt65GHUkkZMLoCrh1sDUf4IViM1FO3DeNAwM3IlDnrpa9u3Rx
	 +JXppYV6tKc1ZbhGQebTqkXftvvH7/FlZ6hzBPeuDOlvgBIm3Fqd56a/DpJN26Y9ll
	 +VsVMvt7Y4Cyh7sFfSnXZZ0vlXrtxA97i/Qy/sAAYNqLyU1WaLsVc24dHa9vEJQFVu
	 ZpCvIbsaeALJtU0YcC0ZQSS9VMRBFDmTbUC8ic8jK0slyoFLxZ91/7NfufeCfS8WP1
	 bIWVMZVpcTxOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/5] mm/slab: handle large_kmalloc objects in
 kfree_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Vmxhc3RpbWlsIEJhYmthIChTVVNFKQ==?= <vbabka@kernel.org>
Cc: media-ci@linuxtv.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-4-ba993cbf7a60@kernel.org>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-4-ba993cbf7a60@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:06:09 +0000
Message-Id: <20260807150609.CDED21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Synchronous execution of __free_large_kmalloc_page in kfree_nolock=
() violates NMI wait-context and corrupts vmstat counters
- [High] Deferred clearing of PageLargeKmalloc bypasses double-free protect=
ion, causing infinite loops
--

--- Patch [4]: [PATCH RFC 4/5] mm/slab: handle large_kmalloc objects in kfr=
ee_nolock() ---
commit 9af1d6506b418b2d9de0922f293e12ee55babdd3
Author: Vlastimil Babka (SUSE) <vbabka@kernel.org>

mm/slab: handle large_kmalloc objects in kfree_nolock()
   =20
Large kmalloc objects is the only remaining case that kfree_nolock()
cannot handle from kmalloc() allocations. Note kmalloc_nolock() does not
return large kmalloc objects.

> diff --git a/mm/slub.c b/mm/slub.c
> index 423b5bdb910bd..3be98faa9f0de 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -6365,6 +6367,21 @@ static void free_to_pcs_bulk(struct kmem_cache *s,=
 size_t size, void **p)
>  	}
>  }
> =20
> +static inline void
> +__free_large_kmalloc_page(struct page *page, unsigned int free_flags)
> +{
> +	unsigned int order =3D compound_order(page);
> +
> +	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> +			      -(PAGE_SIZE << order));
> +	__ClearPageLargeKmalloc(page);
> +
> +	if (free_flags & SLAB_FREE_NOLOCK)
> +		free_frozen_pages_nolock(page, order);

[Severity: High]
Is it safe to execute this synchronously in NMI context on PREEMPT_RT kerne=
ls?

When kmemleak is disabled, kmemleak_may_need_free() returns false, which
causes free_large_kmalloc() to call __free_large_kmalloc_page() synchronous=
ly
from kfree_nolock(), even in NMI context.

This results in free_frozen_pages_nolock() attempting to acquire the zone
lock, which is an rt_mutex (sleeping lock) on PREEMPT_RT, leading to a panic
when called from NMI.

Additionally, mod_lruvec_page_state() uses a non-atomic read-modify-write
protected by local_irq_save() on architectures without
CONFIG_HAVE_CMPXCHG_LOCAL. This fails to mask NMIs and can silently corrupt
vmstat counters.

Would it be better to always defer freeing large kmalloc pages in
kfree_nolock() to avoid these issues?

> +	else
> +		free_frozen_pages(page, order);
> +}
> +

[ ... ]

> @@ -6712,9 +6756,11 @@ size_t ksize(const void *objp)
>  }
>  EXPORT_SYMBOL(ksize);
> =20
> -static void free_large_kmalloc(struct page *page, void *object)
> +static void free_large_kmalloc(struct page *page, void *object,
> +			       unsigned int free_flags)
>  {
>  	unsigned int order =3D compound_order(page);
> +	bool nolock =3D free_flags & SLAB_FREE_NOLOCK;
> =20
>  	if (WARN_ON_ONCE(!PageLargeKmalloc(page))) {
>  		dump_page(page, "Not a kmalloc allocation");
> @@ -6724,14 +6770,16 @@ static void free_large_kmalloc(struct page *page,=
 void *object)
>  	if (WARN_ON_ONCE(order =3D=3D 0))
>  		pr_warn_once("object pointer: 0x%p\n", object);
> =20
> -	kmemleak_free(object);
> +	if (!nolock)
> +		kmemleak_free(object);
> +
>  	kasan_kfree_large(object);
>  	kmsan_kfree_large(object);
> =20
> -	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
> -			      -(PAGE_SIZE << order));
> -	__ClearPageLargeKmalloc(page);
> -	free_frozen_pages(page, order);
> +	if (unlikely(nolock && kmemleak_may_need_free(object)))
> +		defer_free_large_kmalloc(object);

[Severity: High]
Could moving the __ClearPageLargeKmalloc() call to the asynchronous
__free_large_kmalloc_page() bypass double-free protection?

When a free is deferred via defer_free_large_kmalloc(), the PageLargeKmalloc
flag remains set until the IRQ work executes. If the caller has a double-fr=
ee
bug and kfree_nolock() is called again on the same object during this windo=
w,
the WARN_ON_ONCE(!PageLargeKmalloc(page)) check at the start of
free_large_kmalloc() will pass.

This allows the second free to proceed and call defer_free_large_kmalloc()
again. Since this uses llist_add() with the same llnode, it creates a circu=
lar
linked list (llnode->next =3D llnode). When deferred_percpu_work_fn() later
processes this list with llist_for_each_safe(), it will loop infinitely and
cause a hard lockup.

> +	else
> +		__free_large_kmalloc_page(page, free_flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-kfree_nolo=
ck_kmalloc-v1-0-ba993cbf7a60@kernel.org?part=3D4
