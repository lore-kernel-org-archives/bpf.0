Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60462330328;
	Mon, 15 Jun 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522391; cv=none; b=n2bRfxwEUTkQ8MqdH+YnyXpI3xhbGyA+CeUscsryx3dNbqy58DwxWgvAj1dPskqWxwWOrwoMLrFg1Vy35dm3hiC2ix4ba4Cqug3bND497QyF3NwnMR8wEYrKTkdQKTisqy6LJ+ueBJb8G+4oVMIlklnaK4kV68IVEg2VQiKDjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522391; c=relaxed/simple;
	bh=r6ky0dsg5vHKp3xviH3ta61A1XBpqqyJ6Y1iLdHA/gs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIgB3G0gYIS1+L6RA2y5uDlGwD4paoZ/CZWFAw7djP1F6tnndUag/969TrcH2Lxx2W2YpRjOV/lWsuTMHzoAG0XY79rwCOppZ1F5eMP4kgl18NhqhMg2140n6u9yj3swLaudRVz1wiYgpuKveZZv2uFwCYnsy6AeNkEWC+f4xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtfA0TT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtfA0TT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FC51F000E9;
	Mon, 15 Jun 2026 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522390;
	bh=R+DtcxYk5s4EfHaWDjgU6LSA91MgJNFIeLriaeC/BSI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EtfA0TT12YW3Ms4JqKolZ/zz0KdbQrouujWJwhtEyyLk8wrcr5TfMryQRnoLvAz22
	 suEvNEOOv+q+obvpNR1ubyQbw0LOQBei5JOMrkGw5AFM9Ww6dcJ4daMT1fKM82BWC8
	 Uby6VeFU2beP9nSkLJa2TbgAVDNICah0eIsk9uBhOavavEozbGlYNDQ2c3VIv30fb7
	 nQgzwlMSBGrxSiiFwKW/iso7cG1gEzkA7nAKWm7lDsyU2K72zY6G5QhM5qRKGpXO5o
	 BO2NH0Mx/phmSfXa01eb9G51Yw+IWYM117rwBZGPQGvKYQwqsUSJQNELKuJJRvS8MZ
	 SZeEFHHjVbB0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 6/9] mm/slab: allow kfree_rcu_sheaf() on
 PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-6-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:19:49 +0000
Message-Id: <20260615111949.F0FC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling kfree_rcu_sheaf() on PREEMPT_RT from kvfree_call_rcu() cau=
ses an 'Invalid wait context' lockdep splat and potential deadlocks due to =
acquiring a sleeping lock from raw_spinlock, hardirq, or NMI contexts.
--

commit 67f0bb194ef2843a6fa5bfccfbb53884ff1a37b2
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT

This commit allows kfree_rcu_sheaf() to be used on kernels with
CONFIG_PREEMPT_RT by assuming that spinning is not allowed. It removes
the unconditional bailout and relaxes the limitation to try the sheaves
path.

Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162=
@kernel.org

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 55546b8385ff3..807924a94fb08 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
[ ... ]
> @@ -1954,7 +1961,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>  	if (!head)
>  		might_sleep();
> =20
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
> +	if (kfree_rcu_sheaf(ptr))
>  		return;
> =20
>  	// Queue the object but don't yet schedule the batch.

[ ... ]
> diff --git a/mm/slub.c b/mm/slub.c
> index ba593c1c53d50..4850629774b2a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -6096,10 +6097,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj, bool allow_spin)
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *rcu_sheaf;
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

[Severity: High]
Does acquiring this local lock with CONFIG_PREEMPT_RT enabled from
kvfree_call_rcu() trigger an invalid wait context lockdep splat?

Since kvfree_call_rcu() can be called from hardirq or nmi context, or
while holding a raw_spinlock_t (like pi_lock), the caller is in a raw
spin wait context. With CONFIG_PREEMPT_RT, local_lock maps to a
spinlock_t (rt_mutex), which is a sleeping lock.

Even though this uses a trylock and allow_spin is false, acquiring a
sleeping lock under a raw spinlock or in hardirq context violates
lockdep's wait context rules because lockdep evaluates the declared wait
types of the locks, not the runtime behavior.

Additionally, could the rt_mutex trylock implementation internally attempt
to acquire the task's pi_lock, leading to a potential deadlock?

>  		goto fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D6
