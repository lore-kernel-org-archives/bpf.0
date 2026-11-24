Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502443;
	b=kPLxdkehQqSn7hZENAXmBdw4k43EW9Su9s16zjfD/U/IE8/DfFhsN1/5Bgmfz9jtCINC
	 3CqywOav59mSQ+Zf46niznQpf3RiK9+jCH7Ax7zs71xcSg9J4kGTG9Cb1ZgZ2vQifa0kB
	 KkuuI4PRwN2I6vbSpCkH8jqN6jB6nHqVdXyI2QhjkzIf8Qe/+uqkAb8IrwdjDG7vElWcO
	 QEtEPnmBrCotS55BBV2Cy4B56yId8Hr5FYW6Lt12c0AkgsIH0k1HhkO2A1OKjtF7VHsp3
	 hPLH9SD/p0qQ6rQhdkNly9r/rlsy+py0+LxgPwFZVC780hphsUr4KSF4TQasvu9pBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502443;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gc6vfPyvPhlplgTEnEqpALp24kWCNxIpDra8jZ0c5eE=;
	b=5sKv6FeNDAOjwm39lwV1OEldTZLqwox6MfMnavnVRjLxTMYgpaJEOC6OSHizjYRsPUwC
	 esPi7id3bhhXobfzY3RjFzOZpDvMALvv9O6KGGI64FIOT3R1jQ7cdh7WaN8p86GWVVP+2
	 IIr6++863bvggPIXD/g6mX+vx9bQ5KMv3tM562fEZECVMnwZQFdNOLnQOwl+09jkK3L4v
	 an6mbBIm1WPHITHfLTP/p4Mg922nYCPQMP5Scs2VJlCufj9TszaJiKdJ8EeqLcGMIGffo
	 iD/tGHeGZ0Hi9wZAkl+iF1dkSvsX1jiDFlosB3ZEsTEHD4EchG8V3ypYlH2yZjoHkfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW0Y1IPl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F7606A32D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW0Y1IPl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E81F000CF;
	Tue, 24 Nov 2026 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795502443;
	bh=gc6vfPyvPhlplgTEnEqpALp24kWCNxIpDra8jZ0c5eE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NW0Y1IPlCzKi1dATcfIn+jenMqwVEFq+slJMHQaD1SIp8suCuE+0HQfCi6PN2nwEY
	 PEKeubQJ3N4nEPI+OsH+XkQVgVqlJwIQxSVShK5svb0Y/CAdJsE7jMPh8sdTr4A0Pt
	 /PO5qQvp+GpHAqqlmCyAxmE0JEjqyP4kJ8/8RguSJUiwqkL3ZpE5gacCUrm13Dz+jP
	 8lZzeR2axm40GNfNwKYObkJ/SwKvtWoV8W6wp6mS5ACnQygTw0Zk8sugLFGRFCRJ6A
	 kLS7bvAqEmJ1rJPVMqGMHX2S8AzjgMBpJKfsARACZ/lMU+KGnW2/mNg/YeOidOTAfM
	 dR0XE/bd2SyeA==
Content-Type: multipart/mixed; boundary="===============7739321913427557142=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <80250e379e325599bb7bfd45a21d059f534d8c12abc4090d5d8c84193116827d@mail.kernel.org>
In-Reply-To: <20261124060357.11700-2-emil@etsalapatis.com>
References: <20261124060357.11700-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or kmalloc_nolock at call time
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 24 Nov 2026 06:40:41 +0000 (UTC)

--===============7739321913427557142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add call for selecting kmalloc or kmalloc_nolock at call time

TL;DR:
- Mixing kmalloc() and kmalloc_nolock() local storage objects may cause false
  kmemleak reports of live objects
- Unconfirmed: asks for justification that the run-time context test excludes
  NMI and allocator-internal contexts

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> +void *bpf_map_kmalloc_maylock(const struct bpf_map *map, size_t size, gfp_t flags)
> +{
> +	const gfp_t nolock_flags = __GFP_ACCOUNT | __GFP_ZERO |
> +				   __GFP_NOWARN | __GFP_NOMEMALLOC;
> +	struct mem_cgroup *memcg, *old_memcg;
> +	void *ptr = NULL;
> +
> +	bpf_map_memcg_enter(map, &old_memcg, &memcg);
> +	if (IS_ENABLED(CONFIG_MEMCG))
> +		flags |= __GFP_ACCOUNT;
> +
> +	/* Only try the spinning allocation when preemption disables are tracked. */
> +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
> +	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
> +		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
> +	/* Allocation failed or kmalloc_nolock()-only context. */
> +	if (!ptr)
> +		ptr = kmalloc_nolock(size, flags, NUMA_NO_NODE);

Can this leave live objects reported by kmemleak?  kmalloc() objects are
registered with kmemleak, but kmalloc_nolock() objects are not, because
slab_post_alloc_hook() only calls kmemleak_alloc_recursive() when
alloc_flags_allow_spinning() is true.  Before this patch every selem and
storage came from kmalloc_nolock(), so none were registered.  Now both
kinds end up in the same RCU hlists, and kmemleak never scans the contents
of an unregistered object.

For example:

1. A kprobe program in atomic context creates task T's storage S and selem
   A for map M1 through kmalloc_nolock().  Neither is registered.

2. A preemptible caller, such as an fentry program or
   bpf_pid_task_storage_update_elem(), creates selem B for map M2 on T.
   bpf_selem_alloc() gets B from kmalloc(), so B is registered.
   bpf_selem_link_storage_nolock() makes S->list.first point to B, and
   A.snode.pprev points into B.

3. A later selem C of M2, created through kmalloc_nolock() for another
   owner, hashes to the same bucket.  hlist_add_head_rcu() makes
   b->list.first point to C and C.map_node.next point to B.

B is now referenced only from S, A and C, none of which kmemleak scans, so
B can be reported as an unreferenced object even though it is live.  The
same applies to sk storage, where softirq programs use kmalloc_nolock() and
cgroup sockopt programs or syscall updates use kmalloc().

A similar false positive was fixed before in ccff81e1d028 ("bpf: Fix false
positive kmemleak report in bpf_ringbuf_area_alloc()").

Should the kmalloc()ed local storage objects be marked with
kmemleak_not_leak() or kmemleak_ignore(), or should kmemleak registration
otherwise be kept the same for both paths?

This isn't a confirmed bug, but the BPF subsystem guide lists kmalloc() in
an op that programs can reach as potentially unsafe when the verifier
admits the op for kprobe, tracepoint or perf event programs.
bpf_task_storage_get() and bpf_cgrp_storage_get() are offered to all of
those program types by bpf_base_func_proto(), and reach this code through:

bpf_task_storage_get()
  bpf_local_storage_update()
    bpf_selem_alloc() / bpf_local_storage_alloc()
      bpf_map_kmalloc_maylock()
        kmalloc()

The guide lists bpf_mem_cache_alloc(), bpf_map_kmalloc_nolock() with
kfree_nolock(), and a verifier restriction to the program types in
may_update_sockmap() as safe.  This code uses a run-time context test
instead (CONFIG_PREEMPT_COUNT && preempt_count() == 0 && !irqs_disabled()
&& !CONFIG_PREEMPT_RT).

That test appears to exclude NMI, hardirq, softirq and contexts holding
spinning locks inside the allocator, since those raise preempt_count().
One context does look able to reach kmalloc(): raw_tp/tp_btf programs run
via __bpf_trace_run() under rcu_read_lock_dont_migrate() and the tracepoint
SRCU guard, so preempt_count() can be zero there.  Those call sites hold no
spinning lock, so kmalloc(GFP_NOWAIT) seems fine on that analysis.

Could the changelog or a comment state why this run-time test excludes
every NMI and inside-allocator context that the guide is concerned about?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45338923700
--===============7739321913427557142==--
