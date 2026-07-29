Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286104028F5;
	Wed, 29 Jul 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314412; cv=none; b=pKEEVUlk5SP/mtuiwmOrzlLi8JILKBM9M12YWN2iBqC8BcqDOHfDhm1LQfNqyTwo8i9P4+Nha9R8JRaslXlmR5fuV6Cg2Je1Simh4gIx5JIDiLwDemhUIcHKU1hiL9975anrMyFkvNbfa5TPnOuXJONB1iL0Idg6eVkXh7zT8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314412; c=relaxed/simple;
	bh=IWMgLR+zUlBx6ky0JA2NbI8ya8xixe0aAiQ3qsLCsR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugGEJL6ktr5m3PyfK3+4rSy/qGVjwu8X+Pv1BKKsX7FV+92yp0b6Z06aojH2N6wC4MZX9PVzq88CTuPkRty5BHiwnyznH/V7DKioLC/FP3Q8/c8fJMvAfUd7xDA7QHvubSLx4eIjLWqPQkaX8sJBJZ/W+8YzL8fABPE/hzDdykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjF39+Lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjF39+Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A006B1F000E9;
	Wed, 29 Jul 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314411;
	bh=fKqtGMds2kJ4DUszfPuo/l6QQgLPfmV763oWO1zPuCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjF39+Lcf+rDwZUA6PCK7Nil4DfBu6gEL+/ByxMd814rRGfuKyB1Q5TuNyhTzUmnx
	 C5nH4pN7hrdHGPygMlrIRNqk9ZoJa4wsvz/1HLus29sda66URiXibcynyioXGCLlMA
	 Ii0X118c+4GR8Y6YCFnQ+3tk4iLWt0IVgDfr/5WVw0sMOiYHObEVnX1sHAQmTBunQQ
	 YCyqFAIK+nO6itV0qabU9sqJpepMyljRvOHAbngItLCyAlUgSEW8CXsqzzNtH3RS2v
	 XU9SMS+EWeZ2d05y6OQNX3qQMgN4x9kIQQ2N7NAh6zHQXaoQNfLa3jtk9eHCCVeZFh
	 QGBdRiRfTZVSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] mm/slab: introduce struct kvfree_rcu_head for
 kvfree_rcu batching
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260729-kfree_rcu_nolock-v5-6-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-6-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:40:10 +0000
Message-Id: <20260729084010.A006B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exposing local_trylock() to lockdep wait-type checking on PREEMPT_=
RT triggers an 'Invalid wait context' splat.
--

--- Patch [6]: [PATCH v5 6/8] mm/slab: introduce struct kvfree_rcu_head for=
 kvfree_rcu batching ---
commit f07807d65d1f49531b5a23f93da3e184960e8332
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: introduce struct kvfree_rcu_head for kvfree_rcu batching

This commit introduces struct kvfree_rcu_head to optimize kvfree_rcu()
batching. It replaces the use of rcu_head with a single-pointer linked
list when batched, reducing overhead.

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 9c2cca9add893..691ce6db4519c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
[ ... ]
> @@ -1979,7 +1979,7 @@ void __init kfree_rcu_scheduler_running(void)
>   * be free'd in workqueue context. This allows us to: batch requests tog=
ether to
>   * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rc=
u() load.
>   */
> -void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> +void kvfree_call_rcu(struct kvfree_rcu_head *head, void *ptr)

[Severity: High]
Does this code path expose local_trylock() to lockdep wait-type checking on
PREEMPT_RT, triggering an 'Invalid wait context' splat?

When kvfree_call_rcu() is called under a raw spinlock or in hardirq context,
it can reach __kfree_rcu_sheaf():

mm/slub.c:__kfree_rcu_sheaf() {
	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
		lock_map_acquire_try(&kfree_rcu_sheaf_map);

	if (!local_trylock(&s->cpu_sheaves->lock))
		goto fail;
	...
}

On PREEMPT_RT, local_lock maps to a sleepable spinlock_t (wait type
LD_WAIT_CONFIG). CONFIG_PROVE_RAW_LOCK_NESTING checks declared wait-types
regardless of runtime behavior or trylock usage.

If the patch series removes the short-circuit in __kfree_rcu_sheaf() that
protected this path, does the subsequent local_trylock() execution violate
raw lock nesting rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D6
