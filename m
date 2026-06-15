Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1893E3159;
	Mon, 15 Jun 2026 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522707; cv=none; b=B+5B7A6egGZfkQW/4RynBpQepmc7LK3FWlVr1EJSUapgCcp/2mRdUXuOo+bDX/y4phzcYOqqI3VVQmRG1X23PWgeVJl4VkD33ePzW9Q0ismWtwVePDfK5EH8gzGD1aeOWN3jYTp+KPbWe6G9K0HsjDFoJHsoXmdEKdwlUW1fUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522707; c=relaxed/simple;
	bh=L67UhP7sztmmFyMog22+2GLMZsO+ikluCnU0mn1N9gs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwCS7yrOk6qQYTDTx5EBVWe/xN4GAl/T/WVAe02jKwucVJnuQ2WdopE3YOEgcHIUk5wH3vZ7rnKJgyiIrUe3bn0a1fY9aQ/muSLlGbhAfR5+UrUzj6blL8iRjqpDD2x7qQzVp3kbqpNmJiopgirvMouC4LwEESp9v81kX27RSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvk1XbyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvk1XbyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D51F00A3A;
	Mon, 15 Jun 2026 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522706;
	bh=gdsWK2qHCF2RtCgp14Fch2ef6bV6blmJUbTrHpW+Eo0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Pvk1XbyN/O4ohWnPQBr1D/BNK9CZjjthGoALQC7uOtZYnvGhwqZgKnfvwH7p38rkk
	 NSNwEjuQ8WBhzatcbvfJc57P4SHteKmP/t9ODdLXkEwy4nPsOuu9ryVgPFlGpVUlYd
	 YDyzITj+LLDcvWtfngyImfqWi4vslPKxmuFm7Ct/C/IAmkX8Ec18CzrBuXaDN8pj6/
	 toSPNazy1784geJtAMmWwAAR/g7gDvCAVS6TF52DDjY554sYVSBh7NkRHggBpl0ovi
	 qIVjvmc72HQRduCOIKJLCaXFelAg0kUk64Q36I1QaPPXNHpPK2M4+ONW10I/jSYA6q
	 GA3opq13YZ0tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 4/9] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:25:05 +0000
Message-Id: <20260615112506.131D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Acquiring a local_trylock inside a raw_spinlock_t wait context tri=
ggers a lockdep Invalid wait context warning.
--

commit 05f00697f28bd84542538d9e89bbc00e3f7a427a
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: use call_rcu() in unknown context if irqs are enabled

This commit modifies the fallback logic for deferred RCU freeing in the
slab allocator. It now uses call_rcu() even in an unknown context as long
as interrupts are enabled.

Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pv=
zpgZTngNS+fg4rw@mail.gmail.com

> diff --git a/mm/slub.c b/mm/slub.c
> index b0d38d5153865..6a3552b70683d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6158,8 +6158,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *=
obj, bool allow_spin)
>  	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
>  		rcu_sheaf =3D NULL;
>  	} else {
> -		if (unlikely(!allow_spin)) {
> -			/* call_rcu() cannot be called in an unknown context */
> +		/* call_rcu() disables IRQs to protect percpu data structures */

[Severity: High]
This isn't a bug introduced by this patch, but since you are modifying
__kfree_rcu_sheaf() here, can this function trigger an invalid wait context
warning in lockdep?

According to the RCU guidelines, kvfree_call_rcu() is frequently called
while holding a raw_spinlock_t (such as pi_lock in kernel/sched/core.c)
and from hardirq context:

mm/slab_common.c:kvfree_call_rcu() {
    ...
    if (kfree_rcu_sheaf(ptr))
        return;
    ...
}

This calls into __kfree_rcu_sheaf(), which unconditionally attempts to
acquire a local_lock earlier in the function:

mm/slub.c:__kfree_rcu_sheaf() {
    ...
    if (!local_trylock(&s->cpu_sheaves->lock))
        goto fail;
    ...
}

Because local_lock has a lower lockdep wait type than raw_spinlock_t,
does this wait context inversion violate nesting rules and trigger
warnings?=20

Guarding lock_map_acquire_try with !IS_ENABLED(CONFIG_PREEMPT_RT) does not
prevent this because local_trylock internally checks wait contexts
regardless. Could this lead to panics on systems with panic_on_warn enabled?

> +		if (unlikely(!allow_spin && irqs_disabled())) {
>  			rcu_sheaf->size--;
>  			local_unlock(&s->cpu_sheaves->lock);
>  			goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D4
