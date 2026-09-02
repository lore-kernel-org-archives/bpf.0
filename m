Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E790839EF35
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337262; cv=none; b=f45ULtFM8Tnbip69VupHpVS3uPWlFoqsaN+cbxN9CBUH1yQlQjUZo0l66UZxuBn0FTV/VFXHKwLPlQuK5lVi5MgA3kgTkICvXRDv3H5/XQFDd3FiycfTh0D4MqZ8YbMA+mio5DAM1vjDWECx2VKdghlFwHHPhuKId/vXNzVsd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337262; c=relaxed/simple;
	bh=r69zjqycqfKAIl2+oJnCdFvo0+BheXTPVR8xUwJt6L0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iaYeAIC9thGjjxcMS6F79P6408InGluwzu/NINhFScZ/JoBFdkT+RtPCVRWF33Qhv461fg0s2l6ictTO8cuQKXKd13D/1xyOpe923maFQJoZtWF734DOnjD0UXg3fawyrkqMsnibFYXdnfyDuItOoX+/6+N93GvPShdYQhlqUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjTZkkCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjTZkkCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48511F000E9;
	Wed,  2 Sep 2026 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337260;
	bh=gARJUxFYbk7M9YbMuu9fU+8HUThv6HTnzgTwvFhH9Vc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EjTZkkCiNDhfyoIXVsy8p+I8BLdKxfjDkFeJz8gEf0pooY/MZNFENPNWswZuu/caP
	 TWFYoGtvPeNkXd069BThqs0LLrMVjYixxoCMBauG9kpLhdEKu/mJM4Arz6gnbbmcY5
	 AYxMN9tfHREesOnovFCcW+ilS0PimTI+lqs/EAhrlsxc+RSH3HsSxxHe7GqviN6zgK
	 HGArFOWZXuduJyPTeDjazhjADjX0g4VQHUgDyeBjQp7GTOW3bFVHeDUlhjwcOdnh4a
	 H2ideEnP9wqzqnMq+679Xxsu6iCa5NSqxAYsutlPBTWP/DzuCmyWlGsEH7DbMar6+E
	 SNXX1vFYESowA==
Content-Type: multipart/mixed; boundary="===============3052137760251129788=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b0ba1541a65b9ac64e3dd00358e379af24dec9d386a74bc9a4eb90fe1ee3fc9@mail.kernel.org>
In-Reply-To: <20260902070239.16968-3-emil@etsalapatis.com>
References: <20260902070239.16968-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Track availability information for ranges in range tree
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,nickolay.lysenko@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 08:20:59 +0000 (UTC)

--===============3052137760251129788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     The patch adds two operations: Adding a range as unavailable, and
>     turning a range from unavailable to available.

The changelog describes only the two new range states, but the diff makes
two further changes that it never mentions, both of which are the
load-bearing part for reviewers of kernel/bpf/arena.c:

First, range_tree_clear() gains a new return value, -EAGAIN. That changes
the contract of a function called from three places in arena.c
(arena_vm_fault(), arena_alloc_pages() and arena_reserve_pages()), none of
which handle it in this commit. A reader of this changelog has no way to
know the clear() contract moved, and the two follow-up commits in the series
(779ba112cb6ed, 0b79959d464ca) depend on exactly that behaviour.

Second, is_range_tree_set() is rewritten from 'while ((rn =
range_it_iter_first(rt, start, last)))' to 'for (rn =
range_it_iter_first(...); rn; rn = __range_it_iter_next(rn, start, last))'.
This is not mentioned at all, and the immediately preceding commit in the
series -- 780d99e4d42da ("bpf: Update is_range_tree_set to work for
consecutive ranges") -- had just rewritten that same loop into the while()
form this commit replaces. Either the iterator switch belongs in
780d99e4d42da, or this changelog should say why the loop needed changing
again?

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..f49b52fa85860 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -766,7 +766,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +	range_tree_set_avail(&arena->rt, pgoff + mapped, page_cnt - mapped);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	if (mapped) {
>  		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);

Looking at arena_alloc_pages() around line 718, this commit gives
range_tree_clear() a brand-new return value, -EAGAIN, emitted by the
pre-scan loop it adds:

kernel/bpf/range_tree.c:range_tree_clear() {
    /* Scan for unavailable ranges and try again if so. */
    while ((rn = range_it_iter_first(rt, first, last))) {
            if (!range_available(rn))
                    return -EAGAIN;
            first = rn->rn_last + 1;
    }
}

The name -EAGAIN and the comment ("try again") say the condition is
transient, but neither arena.c caller that reaches range_tree_clear() from
a kfunc distinguishes it from a permanent failure.

At arena_alloc_pages() (uaddr path): is_range_tree_set() deliberately keeps
no availability check, so it returns 0 for a range that is
present-but-unavailable. range_tree_clear() then returns -EAGAIN, control
falls to 'if (ret) goto out_unlock_free_pages', and arena_alloc_pages()
returns 0 -- bpf_arena_alloc_pages() hands the BPF program NULL. The check
at line 715 and the act at line 718 now disagree about what "set" means.

At arena_reserve_pages() around line 966: -EAGAIN is returned verbatim
through the bpf_arena_reserve_pages() kfunc, whose error set was previously
only {0, -EINVAL, -EBUSY}.

At this commit the condition is structurally impossible -- every range_node
is created with available=true. Per the forward-search rule the git range
198c2bf..667144ef was checked, and the path IS enabled two commits later by
779ba112cb6ed ("bpf: Fix arena race between page free and alloc leading to
incoherency"), where arena_free_pages()/arena_free_worker() mark ranges
unavailable across a flush_tlb_kernel_range() + zap_pages() window
(zap_pages() takes mmap_read_lock() and mmput(), so the window is long, not
narrow).

That same series adds explicit -EAGAIN handling everywhere else it matters
-- arena_vm_fault() gets '-EAGAIN -> VM_FAULT_RETRY' and
arena_free_pages()/arena_free_worker() get 'if (ret != -EAGAIN)
WARN_ON_ONCE(ret)' -- but at the series tip 667144ef the two sites above
are unchanged (667144ef:kernel/bpf/arena.c lines 749 and 1019). So the gap
is not work-in-progress that the series completes: a BPF program allocating
at a fixed uaddr, or reserving a vaddr range, transiently overlapping a
range another CPU is mid-free will see a spurious NULL / an undocumented
-EAGAIN with no retry loop anywhere in the kernel or in the arena selftest
allocators (buddy_init, buddy_unreserve_arena_vaddr). No crash or
corruption -- hence low severity -- but it is a silent,
previously-impossible failure mode.

Worth confirming whether these two paths were meant to retry like the fault
handler does, or whether -EAGAIN should be documented on
bpf_arena_reserve_pages()?

>     bpf: Track availability information for ranges in range tree
>
>     Arena address ranges are currently encoded in a range tree: Ranges
>     present in the tree are free and available for allocation, while
>     absent ranges are allocated. However, this opens up the arena code to
>     subtle races between page table updates, range tree updates, and
>     concurrent allocations that can cause permanent inconsistencies.
>     Avoiding such races involves distinguishing between memory ranges that
>     are free and ready to be allocated, and ranges that are being freed but
>     should not be reused yet. Such tracking is cleanly possible through the
>     arena's range tree. The range tree is only consumed by arena and has no
>     additional future consumers, so it can be tailored towards tracking more
>     state. Alternatives such as deferring range freeing require more
>     asynchrony and per-range state tracking in the main arena code, and can
>     introduce additional race conditions.
>     Expand the tree to track whether a range present in the tree is
>     available for allocation. For now, all ranges are available: We add
>     the option to add back a range in an unavailable state, and to move
>     already present ranges from unavailable to available. We do not
>     implement other transitions, since they are not required to support
>     BPF arenas.
>     The patch adds two operations: Adding a range as unavailable, and
>     turning a range from unavailable to available. Unavailable ranges are
>     not mergable, and will be imminently be turned available by the ongoing
>     arena free() operation that created them. Turning ranges from
>     unavailable to available is a simple flag change on the range with an
>     optional merge with adjacent available ranges.
>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This looks like a bug fix for the race condition in the range tree design
(where ranges cannot distinguish between 'free and ready to allocate' vs
'being freed but not yet reusable'). The race condition was introduced when
the range tree was first added.

Should this include:

  Fixes: 341eef908d04 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33603499110
--===============3052137760251129788==--
