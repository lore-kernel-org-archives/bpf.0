Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96442E542C
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368792; cv=none; b=MRfoEWelRLORZZ4LbPrU+gIhygcqsmw69VcJpITwo06qLWSaonPDoAr/ijTyqALxXzHHYvyJhVO6OxSE7lz+E7ddxsXAb0HGjtAnqQI5j4pILbSFSzzd3L8QY/hlN2+FU3xH+Beng3QnDqvHb5dycNRC6FLkbwc2l5oLZQUViTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368792; c=relaxed/simple;
	bh=1lAj0RYynE1f5++3x9dW2tApKBrusbMFAf4fDQ7WuCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbUFZaSWq5g3rUKLjXeVsa+/CP/QAsfXUV7QvFSh0/v/7poqMnum4ndFYclrItusMH2riqUUhv5G7NnINKiDz0n3RuvvhaDG7TnU6VnmNgJDCvl9Uw+P9r0pFPT39omxQoQHoZBwIU8Myzxnz8sOVpwK7pQ3orTv//AeWzCmz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mkUtfXZh; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mkUtfXZh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1lAj0RYynE1f5++3x9dW2tApKBrusbMFAf4fDQ7WuCY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787368787; v=1; x=1787973587;
 b=mkUtfXZhaaVaT8lOZ94knMA6LW5CpdLC1sPJUw/Jq/F8kICDU0bXQwG/NpbqD4imlrI4yzKG
 iWpRONDpFzH1aHXz1B6343tw1C6lo+bQeACAC/SLwxeNgUcT7rGsIFpM24YI/Wg5zuGeYnDUrVD
 MxWj0pYheacKF5a3k2ofo2ow=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost (2a03:2880:10ff:4c::)
	by smtp.migadu.com with ESMTPS id 6c42c0bd215f903c;
	Sat, 22 Aug 2026 03:19:47 +0000
X-Mizu-Trace-ID: 6c42c0bd215f903c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 21 Aug 2026 20:19:45 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
Message-ID: <aojJoHl2uSe1IsfA@linux.dev>
References: <cover.1787205002.git.zhuhui@kylinos.cn>
 <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
 <CAEf4Bza0KYB+OHpa89K16+ptUQuQDJKyxxNCyDPcgQaO1mtxjg@mail.gmail.com>
 <DKUVJN7NQMAI.2JXLSBOGJTI1W@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKUVJN7NQMAI.2JXLSBOGJTI1W@gmail.com>

On Fri, Aug 21, 2026 at 09:38:31PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri Aug 21, 2026 at 9:12 PM CEST, Andrii Nakryiko wrote:
> > On Wed, Aug 19, 2026 at 11:12 PM Hui Zhu <hui.zhu@linux.dev> wrote:
> >>
> >> From: Hui Zhu <zhuhui@kylinos.cn>
> >>
> >> Expose memcg proactive reclaim to sleepable BPF programs:
> >> unsigned long bpf_proactive_reclaim(memcg, size);
> >> unsigned long bpf_proactive_reclaim_swappiness(memcg, size, swappiness);
> >>
> >> They perform one reclaim pass on @memcg, like a write to memory.reclaim:
> >> swap is allowed, and the anon/file balance follows the cgroup's
> >> swappiness or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS]
> >> plus SWAPPINESS_ANON_ONLY. Both go through a shared helper,
> >> bpf_proactive_reclaim_pages(), which guards against reclaim recursion
> >> and calls try_to_free_mem_cgroup_pages() with GFP_KERNEL and
> >> MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE, the same parameters
> >> user_proactive_reclaim() uses, and unlike memory.reclaim they do not
> >> retry until @size is reached.
> >>
> >> Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
> >> current->reclaim_state on entry and NULLs it on exit, so a nested call
> >> from an in-flight reclaim would corrupt the outer reclaim state (e.g.
> >> MGLRU dereferences current->reclaim_state->mm_walk). Both kfuncs
> >> therefore refuse to reclaim when PF_MEMALLOC is set or
> >> current->reclaim_state is non-NULL. The latter check also closes the
> >> window in try_to_free_mem_cgroup_pages() where reclaim_state is already
> >> installed but PF_MEMALLOC is not: only a tracepoint call sits in
> >> between, and while a sleepable BPF program cannot attach to the
> >> tracepoint itself, it can attach to the generated trace iterator
> >> function (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry.
> >>
> >> The kfuncs take @size in bytes; the return value is normalized to bytes
> >> as well, matching the byte-based unit of bpf_mem_cgroup_usage() and
> >> bpf_mem_cgroup_page_state(), so callers can mix them without manual
> >> page/byte conversions.
> >>
> >> An out-of-range @swappiness is reported with (unsigned long)-1 instead
> >> of 0, following the convention of bpf_mem_cgroup_vm_events() and
> >> bpf_mem_cgroup_page_state(), as 0 cannot be told apart from a
> >> successful pass that reclaimed nothing.
> >>
> >> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >> ---
> >>  mm/bpf_memcontrol.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 118 insertions(+)
> >>
> >> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> >> index 716df49d7647..dc51868b3acf 100644
> >> --- a/mm/bpf_memcontrol.c
> >> +++ b/mm/bpf_memcontrol.c
> >> @@ -6,6 +6,7 @@
> >>   */
> >>
> >>  #include <linux/memcontrol.h>
> >> +#include <linux/swap.h>
> >>  #include <linux/bpf.h>
> >>
> >>  __bpf_kfunc_start_defs();
> >> @@ -159,6 +160,120 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >>         mem_cgroup_flush_stats(memcg);
> >>  }
> >>
> >> +/*
> >> + * Reclaim must not recurse. try_to_free_mem_cgroup_pages() unconditionally
> >> + * overwrites current->reclaim_state on entry and resets it to NULL on exit.
> >> + * So invoking it from an in-flight reclaim would clobber the outer reclaim
> >> + * state and corrupt its accounting.
> >> + *
> >> + * The guards are PF_MEMALLOC and current->reclaim_state. Every reclaim
> >> + * entry point marks the current task with PF_MEMALLOC for the whole
> >> + * reclaim window: try_to_free_mem_cgroup_pages() and __perform_reclaim()
> >> + * do so via memalloc_noreclaim_save(), and kswapd keeps it set for its
> >> + * entire lifetime. A hook inside the reclaim path (shrink_node,
> >> + * shrink_slab, ...) executes in the context of the reclaiming task, where
> >> + * current->flags already carries the flag. The page allocator, the memcg
> >> + * charging path and node_reclaim() rely on the same flag to avoid reclaim
> >> + * recursion.
> >> + *
> >> + * reclaim_state is checked in addition because it is set slightly before
> >> + * PF_MEMALLOC in try_to_free_mem_cgroup_pages(), with only a tracepoint
> >> + * call in between. A sleepable BPF program cannot attach to the tracepoint
> >> + * itself, but it can attach to the generated trace iterator function
> >> + * (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry, so PF_MEMALLOC
> >> + * alone would leave that window open.
> >> + *
> >> + * Also, PF_MEMALLOC is set in some non-reclaim contexts (e.g. direct compaction
> >> + * and vmalloc), where the kfunc conservatively refuses to reclaim as well.
> >> + */
> >> +static bool bpf_in_reclaim_context(void)
> >> +{
> >> +       return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> >> +}
> >> +
> >> +/*
> >> + * Shared implementation of the proactive reclaim kfuncs: performs one
> >> + * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, and
> >> + * @swappiness as the anon/file balance override (NULL to follow the
> >> + * cgroup's own swappiness setting). Returns the reclaimed amount in
> >> + * bytes, keeping the byte-based unit of the kfuncs' @size argument.
> >> + */
> >> +static unsigned long
> >> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_pages,
> >> +                           int *swappiness)
> >> +{
> >> +       unsigned long nr_reclaimed;
> >> +
> >> +       if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> >> +               return 0;
> >> +
> >> +       nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> >> +                                                   MEMCG_RECLAIM_MAY_SWAP |
> >> +                                                   MEMCG_RECLAIM_PROACTIVE,
> >> +                                                   swappiness);
> >> +
> >> +       return nr_reclaimed * PAGE_SIZE;
> >> +}
> >> +
> >> +/**
> >> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> >> + *                         cgroup
> >> + * @memcg: the target memory cgroup to reclaim from
> >> + * @size:  the amount of memory to reclaim, in bytes
> >> + *
> >> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> >> + * the memory.reclaim cgroup file: pages are reclaimed according to the
> >> + * cgroup's own swappiness setting and swap is allowed. Note that,
> >> + * unlike memory.reclaim, this does not retry until @size is reached;
> >> + * callers can invoke it again if needed.
> >> + *
> >> + * The reclaim runs with GFP_KERNEL, so this function must not be called
> >> + * from a context that holds a filesystem lock (e.g. an LSM hook invoked
> >> + * with inode_lock held): the reclaim path may enter filesystem shrinkers
> >> + * and deadlock trying to reacquire the lock. Contexts that set
> >> + * PF_MEMALLOC_NOFS/NOIO are handled by the gfp context inheritance.
> >> + *
> >> + * Return:
> >> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> >> + *   pages), or 0 if @size is smaller than a page or the calling task is
> >> + *   already in a reclaim/freeing context (PF_MEMALLOC).
> >> + */
> >> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> >> +                                               unsigned long size)
> >> +{
> >> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL);
> >> +}
> >> +
> >> +/**
> >> + * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
> >> + *                                    memory cgroup with an explicit
> >> + *                                    swappiness
> >> + * @memcg:      the target memory cgroup to reclaim from
> >> + * @size:       the amount of memory to reclaim, in bytes
> >> + * @swappiness: swappiness override for this reclaim pass
> >> + *
> >> + * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
> >> + * balance is controlled by @swappiness instead of the cgroup's
> >> + * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS]
> >> + * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
> >> + *
> >> + * Return:
> >> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> >> + *   pages), (unsigned long)-1 if @swappiness is out of range, or 0 if
> >> + *   @size is smaller than a page or the calling task is already in a
> >> + *   reclaim/freeing context (PF_MEMALLOC).
> >> + */
> >> +__bpf_kfunc unsigned long
> >> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long size,
> >> +                                int swappiness)
> >> +{
> >> +       if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_ONLY)
> >> +               return (unsigned long)-1;
> >> +
> >> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
> >> +                                          &swappiness);
> >> +}
> >
> > I haven't followed previous discussion, so I apologize if this was
> > discussed, but if not, isn't it a bit an overkill to have second
> > variant just to provide optional swappiness? Valid range of swappinees
> > seems to be non-negative [0, 200], that special ANON is 201, so why
> > can't we defined that <0 swappiness just means no swappiness was
> > provided and get away with just one kfunc?
> >
> 
> I think my understanding of Shakeel's suggestion was that we only add one
> bpf_proactive_reclaim() for now, if swappiness parameter is necessary we can
> introduce the second API later. But given it seems Hui wants to add both, I
> think it would make sense to do what Andrii said and just introduce one kfunc
> with the swappiness parameter now.
> 
> But Hui, please wait for Shakeel to comment before respinning again.

Yes let's go with Andri's suggestion.

However Hui, don't respin the series. Let me go through it first. I am not happy
with the amount of text and comments added to the patches.

> 
> >> +
> >>  __bpf_kfunc_end_defs();
> >>
> >>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> >> @@ -172,6 +287,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
> >>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
> >>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
> >>
> >> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
> >> +BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
> >> +
> >>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
> >>
> >>  static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
> >> --
> >> 2.53.0
> >>
> 
