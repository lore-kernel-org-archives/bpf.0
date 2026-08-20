Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006D2E2286
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207079; cv=none; b=EDF87AdQkz+iHjQ9nttUQ87OykqGWiRSMfyEBmk6b4fGna4jILHtvb3TbV7qb1APZFga8K59/rEJcGyHSao2bMiF+BGUJUis0RX+PPiAQsxXZ6C5s/g4nrgG2Lo3qmaJw8UALsPeHrvuK3NMgxhD7Bz2yVKpCJ0nPT0O0UujMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207079; c=relaxed/simple;
	bh=FezNnkok3eNvo3QgVOvbF98eaPfQLWAjwVgnp7kiDls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K6A1xRan7kxhvi/kK8pA2cSOyqBAsQr9PmFNoz/D1kP248CpQMnRwbNjEN/UuHH3YrFPBuOaX2P1jJDwIT1I42Y2W/rqNPR8/76KcL/lCqSSFmJYg6xbeA5lX1Qw85TGIGHciJJrVjONb1hOkpt+l6ZsGLqnc1ch5HYtXeG9a7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n90vmhnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n90vmhnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7251F000E9;
	Thu, 20 Aug 2026 06:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787207077;
	bh=CoJ30A7j6brBjQ7hW8JW4/8hesxbwyT4M5eJFTIrqDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n90vmhnmXPfSDGgiqmZZPW1DXosjGN78xpghyN27saNVNbqNL51i7GUoAEmKcHrbH
	 7+YQulGDOA4uHfyksAOIuk6MOg9GdzLqZb59p5lx/Mkj8bylEEIxjs9vWev3tFzDfQ
	 qCNEf6/SXxycdf5U1ZBAJme7IaXdXQhVe3tXORqblRLhfB/QZIVVtcL0SHmBcaV3o9
	 sdc0D9lry5vN2ZMKLx2Qe6BA6czoy7CQD21nXqzgOAF2LjnCGXRWG7o6r2LJf+ZAiO
	 3Yn0zV0wZWvuOmX/e1jceNB6PfjmB66xbgEMKAgRwRRj34pJ98vGP8RBBPXvCUPWr0
	 hv9qu/iOOyGKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
References: <cover.1787205002.git.zhuhui@kylinos.cn>
 <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 06:24:37 +0000
Message-Id: <20260820062437.AD7251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling bpf_proactive_reclaim or bpf_proactive_reclaim_swappiness =
from sleepable BPF programs can cause an ABBA deadlock with filesystem lock=
s due to the unprotected use of GFP_KERNEL. Additionally, the recursion che=
ck bpf_in_reclaim_context() misses paths like drop_caches that can lead to =
nested shrinker deadlocks.
--

--- Patch [1]: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim kf=
uncs ---
commit 4402e19f8110b925da0a7b84926bd5e1fe8cd6da
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfuncs

This commit exposes memory cgroup proactive reclaim to sleepable BPF
programs via bpf_proactive_reclaim() and bpf_proactive_reclaim_swappiness().
These kfuncs perform one pass of reclaim using try_to_free_mem_cgroup_pages.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..dc51868b3acfe 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +static bool bpf_in_reclaim_context(void)
> +{
> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> +}

[Severity: High]
Could this recursion check miss contexts like /proc/sys/vm/drop_caches?

Operations like drop_caches invoke shrinkers without setting PF_MEMALLOC or
reclaim_state. If a BPF program traces a shrinker callback during drop_cach=
es
and calls bpf_proactive_reclaim(), it would bypass this check, potentially
triggering nested shrinker invocations and deadlocks on shrinker-internal l=
ocks.

> +static unsigned long
> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_p=
ages,
> +			    int *swappiness)
> +{
> +	unsigned long nr_reclaimed;
> +
> +	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	nr_reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERN=
EL,
> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    swappiness);

[Severity: High]
Does the unconditional use of GFP_KERNEL here risk an ABBA deadlock?

If a sleepable BPF program (such as an LSM or fentry hook) attaches to a VFS
function that holds a filesystem lock (like inode_lock), calling this kfunc
will initiate memory reclaim with GFP_KERNEL. The reclaim path may then
enter filesystem shrinkers that attempt to acquire the exact same filesystem
locks.

Since the BPF verifier cannot track kernel lock state to prevent this, expo=
sing
a kfunc that can deadlock the kernel could violate BPF safety guarantees.

[ ... ]

> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * the memory.reclaim cgroup file: pages are reclaimed according to the
> + * cgroup's own swappiness setting and swap is allowed. Note that,
> + * unlike memory.reclaim, this does not retry until @size is reached;
> + * callers can invoke it again if needed.
> + *
> + * The reclaim runs with GFP_KERNEL, so this function must not be called
> + * from a context that holds a filesystem lock (e.g. an LSM hook invoked
> + * with inode_lock held): the reclaim path may enter filesystem shrinkers
> + * and deadlock trying to reacquire the lock. Contexts that set

[Severity: High]
As noted in this comment, leaving the responsibility to the BPF programmer =
to
avoid deadlocks is risky given the BPF safety model.

Is there a way to enforce this safety boundary within the kernel, perhaps by
utilizing memalloc_nofs_save() internally or passing a more restricted GFP
mask?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787205002.gi=
t.zhuhui@kylinos.cn?part=3D1
