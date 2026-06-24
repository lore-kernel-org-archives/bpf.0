Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB030D41D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307456; cv=none; b=ASGdzIOWUrH38e6h0JfI39ffwuiGvghEjmqqnd5vXxBuaMJRUKRyoITaM3ixIruWJqropcYofX0d5esKMrLZXq12Z3Wl+wwD0Y8LHxtrQjFeNuJsc4yqoJcKesWzjEl2wBAFwZoEM9wa/68++Z7mW1l8js3W+ecrcVC30+s1eXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307456; c=relaxed/simple;
	bh=T4ftCxW/0PPUattbtP1zXHAGEX9+rHF7tg4gTEcax7k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlU4CQHD+R3sBLHXr2et20WAoS5UE3XaR7Ua+cYaPvhiqDihZtGgDkWLcSCpr9PnCYcsViUP/XW2bc9IaKWqVPwAa3YvK8wfcdXUsNXFJAFr3bTBK1QEsiyLLFVByx7iSQyv5VwKvbEbe7ZfCdIKZBtZkKKVVWmSBsbeHTo5JmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id5z+oqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id5z+oqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9391F000E9;
	Wed, 24 Jun 2026 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307455;
	bh=4JaYj0AS0N8aZ81Kn7Kmskp7WxAOblfgjdLzTBRZiLU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=id5z+oqg/encK9/cpdERZGQZSjnfUKBlkkbBUEz7ZMuswfIVp0MQhUbMWG7bUPpKt
	 VNhaDs20h0Isxav2F/6DWqqT1oVW/BNfd36ML+iZUfeKL2gjP+q2uoI4YZs2KvbBiN
	 /FIe9ZNwGoCpdPp67cXBU+/qQ+7H5C8ZiSAzEbmnjlINnudVo7K1ne/4RJXtL/uvit
	 E5CGIH88scmxDnyD9RvFepo96WQquck0PG/ZZCjUdZ/648c3xQD9vFhsfKdpVlMzSR
	 bGYcbTArjnwHraYurBLDoYG4PKMwinSEs7sAQRd2Oxxj41wKdpvmrfO8ZQ1sOb29q8
	 5mV+N8dca0OEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/4] mm/slab: handle allow_spin in slab_free_hook()
 instead of open coding
Reply-To: sashiko-reviews@lists.linux.dev
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, bpf@vger.kernel.org
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-2-fdf4d17351dd@kernel.org>
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
 <20260624-kmalloc-nolock-fixes-v1-2-fdf4d17351dd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:24:14 +0000
Message-Id: <20260624132415.1C9391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] slab_free_hook() proceeds with an unsafe GFP_NOWAIT allocation aft=
er VM_WARN_ON_ONCE(!allow_spin) for SLAB_TYPESAFE_BY_RCU caches, deadlockin=
g NMI callers.
--

commit b732dfb9de7b44943319ed866b71dd254fecb07a
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: handle allow_spin in slab_free_hook() instead of open coding

This commit refactors slab_free_hook() to accept an allow_spin parameter,
replacing the open-coded hook logic in memcg_alloc_abort_single() and
kfree_nolock(). It ensures that spinlock-acquiring free hooks and KASAN
quarantine operations are bypassed when allow_spin is false.

> diff --git a/mm/slub.c b/mm/slub.c
> index 32672a92581b0..85760c8ff2e29 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -2654,6 +2665,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init,
>  	if (still_accessible) {
>  		struct rcu_delayed_free *delayed_free;
> =20
> +		VM_WARN_ON_ONCE(!allow_spin);
>  		delayed_free =3D kmalloc_obj(*delayed_free, GFP_NOWAIT);

[Severity: High]
If allow_spin is false (e.g., when called from kfree_nolock() in NMI or
atomic context), this triggers the warning but still proceeds to call
kmalloc_obj() with GFP_NOWAIT.

Since GFP_NOWAIT does not prevent the slab allocator from acquiring spinloc=
ks
(such as pcp->lock or node->list_lock), and it does not strip
__GFP_KSWAPD_RECLAIM which can wake kswapd and acquire scheduler locks, cou=
ld
this lead to a deadlock if called in NMI context?

Should this path explicitly skip the allocation or return early when
allow_spin is false?

>  		if (delayed_free) {
>  			/*
>  			 * Let KASAN track our call stack as a "related work

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-kmalloc-no=
lock-fixes-v1-0-fdf4d17351dd@kernel.org?part=3D2
