Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322B41BA79;
	Mon, 20 Jul 2026 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552198; cv=none; b=epIpHIjJk1Bm+cIClY5+uhz8ka6txNG+IOdCCTxKJ+ghCo9N3w+zP1CxpVLCt/lcLeh4N981yW/PnXXSsmOXAUWnoDAxLIb0zboasNpGyrOjzTWk+4yC8g3WqnDLLK2nAF8sO8V4/v9RopZjFMt7LOhbEVAMzA50AC+B/twTBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552198; c=relaxed/simple;
	bh=51yuat7FvU0PthhpGiKFzfQWwWHzp0lh20PBTUlNzUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KZiFgLvbizyYTr1zgxaN9hVfLfm/zG2yXXWeULh55tG7lgl1QRnQu2+o8VsO5+iTmzKUHlQuqX1fl2hdg4Wd/a8q47MueMNe1Vq5APJobtJsiI/9qKoFA6oiIKQ9atAU64OkwwwS9DvuIJIlZyI1DcuDosgIQ4cmT93fQGrlQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abfS4EOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abfS4EOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D01F00A3A;
	Mon, 20 Jul 2026 12:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552197;
	bh=un4HkghspyZsqT1HV3ewuK+Ez+dYAlrY3NSEAHDyFnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abfS4EOEPhAp6c0ycU/Mbb7K78dsFerBVOYtIZv2iEk/4WIVHuO8I05lyk8ltjXRw
	 BIt+WCcu0ZC+bdaxCDe/M/wUixF6f8+804PoFHoQ62Eer9v1mrguQomvlfRvXohuK+
	 6eJxwq8MKQtp+OGYtw6PQgQSzad0fsgvT+C/3ZkWWLKUkLNpbPVNJBCsOAGNTWvbUh
	 kO1EZMUAfOxKwWeMVXXMMg4dVjvDq6+99Pt39OFcyUeUb9+Uay12/4i0FZlYEIXU8g
	 y00qjTqFWmFiq3wOfsq2nyO2PTPV81seuoEPTBQx9EvxJhUocfLUxtRl4GxU3nKr6s
	 Rt9ROxqZUusUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf()
 on PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
 <20260720-kfree_rcu_nolock-v4-5-964e03c41a4e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:56:36 +0000
Message-Id: <20260720125637.129D01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Calling `local_trylock()` inside `kvfree_call_rcu()` on PREEMPT_RT=
 violates lockdep wait-type nesting rules and is unsafe in hardirq/NMI cont=
ext.

Pre-existing issues:
- [High] Preexisting bug: Using GFP_NOWAIT in __kfree_rcu_sheaf() can cause=
 lock recursion deadlocks when called under scheduler locks.
--

--- Patch [5]: [PATCH slab/for-next v4 5/8] mm/slab: allow kfree_rcu_sheaf(=
) on PREEMPT_RT ---
commit 9ccf08cd866ca28e999f59be7998db3bfc32fb7a
Author: Harry Yoo (Oracle) <harry@kernel.org>
Subject: mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT

This patch allows kfree_rcu_sheaf() to be used on PREEMPT_RT by setting
SLAB_FREE_NOLOCK when PREEMPT_RT is enabled. It relaxes the limitation
in kvfree_call_rcu() and skips the lockdep wait-type override map on
PREEMPT_RT to avoid suppressing valid warnings.

Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162=
@kernel.org [1]
Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab543be=
@kernel.org [2]

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9c9ae1384f476..8c631bf97cd5b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
[ ... ]
> @@ -1954,7 +1962,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>  	if (!head)
>  		might_sleep();
> =20
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +	if (kfree_rcu_sheaf(ptr))
>  		return;
> =20
>  	// Queue the object but don't yet schedule the batch.
> diff --git a/mm/slub.c b/mm/slub.c
> index 8afa6b47b1f2b..deac315d0f23e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -6080,10 +6081,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj, unsigned int free_flags)
>  	struct slab_sheaf *rcu_sheaf;
>  	bool allow_spin =3D free_flags_allow_spinning(free_flags);
> =20
> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
> -		return false;
> +	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
> =20
> -	lock_map_acquire_try(&kfree_rcu_sheaf_map);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lock_map_acquire_try(&kfree_rcu_sheaf_map);
> =20
>  	if (!local_trylock(&s->cpu_sheaves->lock))
             ^^^^^^^^^^^^^

[Severity: High]
Will this cause lockdep wait-type violations and potential crashes on
PREEMPT_RT?

Since this patch removes the !IS_ENABLED(CONFIG_PREEMPT_RT) guard in
kvfree_call_rcu() inside mm/slab_common.c, kvfree_call_rcu() can now reach
this path on PREEMPT_RT.

Because kvfree_call_rcu() can be called while holding a raw spinlock (like
the scheduler's pi_lock) or in hardirq context, it seems this local_trylock=
()
will attempt to acquire a sleeping lock (rt_mutex on PREEMPT_RT) in an
invalid context.

Since the lockdep override map is intentionally skipped for PREEMPT_RT just
above, will this correctly trigger lockdep "invalid wait context" splats
and potentially cause panics if the trylock is attempted from hardirq/NMI
context?

[Severity: High]
This is a pre-existing issue, but since we are enabling this path for
PREEMPT_RT, does the use of GFP_NOWAIT later in this function cause
lock recursion deadlocks?

When the fast path fails, __kfree_rcu_sheaf() calls:

    empty =3D alloc_empty_sheaf(s, GFP_NOWAIT, alloc_flags);

GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM, which invokes wakeup_kswapd().
The wake-up path enters the scheduler via try_to_wake_up() and attempts to
acquire scheduler locks like pi_lock and the runqueue lock.

If kvfree_call_rcu() was called while the CPU already holds these scheduler
locks, will this wake-up attempt cause a lock recursion self-deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-kfree_rcu_=
nolock-v4-0-964e03c41a4e@kernel.org?part=3D5
