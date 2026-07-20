Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9173141CB5D;
	Mon, 20 Jul 2026 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552614; cv=none; b=O+giU6ZmiOVqbWc9s2X8KDNe462coNrnAkDQASomfCga4xhsmKdeqftR3G5IJX4do1gVOCdegdkntVmciMrwBWQvsSyXVQ8IKBKk0l0kGsW3OPyMoy/P577KBfAzVDswjVB7/XPYzeK+nSVrh6N7gRYUFVF4WCTsZtU9H9DFwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552614; c=relaxed/simple;
	bh=gCgsSOO/kYR6Mk0fZ0sUZB0n3+Z8OP4GKz3AvXGTDpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IoyYPYh95MVkJeeqZPJigclU3Km9ManjOFnmmGn8JWRXj8HAFrTU8GvnnYYxR0GKY2OJ+m3IuuAhGUiLmpwSNvhz/oeynegTppIT3NOcnprmhYy/Um3stwuhXI9FM5so6q/kAK3lZA7VQZD348Q0PfrQIFuVwtqhWteqWl3h1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdfcxN1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdfcxN1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED34A1F00A3F;
	Mon, 20 Jul 2026 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552613;
	bh=MLaBEkNcDAfJaYgjm0xh/71XLnSe7xFsmGFPFBxNA7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PdfcxN1B3Yd65mEe/WFPYDBj15Plnqy5YNHJozkKvKuG4xmVC26f5ltMOPmtbm1s+
	 t+ZzfyHPtMSnePXvtbYiuiV2cpTHGtN96M6wxIs2d1Z/kze5pDLCX5CDEVOG3WfLq+
	 8bbKJg1ZxR7j7TLzbDZqMLoDpx7sUvRA025Y/tAp/klVFlZ/xNoVQ7iK2JQCHhFjw+
	 clqMVoIHDsruzb8RLo4jzaFPqS4Nxscfl9kxH4L8IlL6EOSi9dwmpYGoaB0FfaTE4u
	 EjBpLV9AUIL2O0p3h8hH86Y6mTbDLGe8K2LsmXjmh2j4toH0/ljU69psor5WC6RwHj
	 8jbxQMw8e3eOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 4/8] mm/slab: extend deferred free
 mechanism to handle rcu sheaves
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260720-kfree_rcu_nolock-v4-4-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-4-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:03:32 +0000
Message-Id: <20260720130332.ED34A1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `__kfree_rcu_sheaf()` acquires a lock using `local_trylock()`, whi=
ch triggers a lockdep 'Invalid wait context' warning when called via `kvfre=
e_call_rcu()`.
--

--- Patch [4]: [PATCH slab/for-next v4 4/8] mm/slab: extend deferred free m=
echanism to handle rcu sheaves ---
commit 136141e9d7cd5370bbb83aa5e26b9b28ea8267ad
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: extend deferred free mechanism to handle rcu sheaves

This commit extends the deferred free mechanism to handle RCU sheaves when
spinning is not allowed and IRQs are disabled. It queues the RCU sheaf on
an IRQ work to safely invoke call_rcu() later, and updates barrier syncs.

> diff --git a/mm/slub.c b/mm/slub.c
> index 680fe64aff72e..8afa6b47b1f2b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -6154,8 +6161,22 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void =
*obj, unsigned int free_flags)
>  	 * we flush before local_unlock to make sure a racing
>  	 * flush_all_rcu_sheaves() doesn't miss this sheaf
>  	 */
> -	if (rcu_sheaf)
> -		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +	if (rcu_sheaf) {
> +		/*
> +		 * With !allow_spin, we might have interrupted call_rcu()'s
> +		 * IRQ-disabled critical section. If IRQs are not disabled,
> +		 * we know that's not the case.
> +		 */
> +		if (unlikely(!allow_spin && irqs_disabled())) {
> +			struct deferred_percpu_work *dpw;
> +
> +			dpw =3D this_cpu_ptr(&deferred_percpu_work);
> +			if (llist_add(&rcu_sheaf->llnode, &dpw->rcu_sheaves))
> +				irq_work_queue(&dpw->work);
> +		} else {
> +			call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
> +		}
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but since this modifies
__kfree_rcu_sheaf(), I wanted to ask about a preexisting locking issue in
this execution path.

Earlier in __kfree_rcu_sheaf(), the code unconditionally acquires a lock via
local_trylock(&s->cpu_sheaves->lock). However, this function is reachable f=
rom
kvfree_call_rcu(), which can be called under a raw_spinlock_t (like pi_lock)
and from hardirq context:

mm/slab_common.c:kvfree_call_rcu() {
	...
	if (kfree_rcu_sheaf(ptr))
		return;
	...
}

which routes to:

mm/slub.c:__kfree_rcu_sheaf() {
	...
	if (!local_trylock(&s->cpu_sheaves->lock))
		goto fail;
	...
}

Will acquiring a local_trylock within this wait context trigger a lockdep
"Invalid wait context" warning, since it statically violates the raw
spinlock locking rules?

> =20
>  	local_unlock(&s->cpu_sheaves->lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D4
