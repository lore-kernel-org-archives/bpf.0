Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE440488C;
	Tue, 13 Oct 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899518; cv=none; b=Wv0HSSKHQS1LbBP6exf6Wwdr93wRf58PtEwYsz2nVhOvx0SoER8mtkqjITEYsE9diZMeyO4aarlN3zMCqwRBw0gzZGnO7mr+S4PnsxE4GIqkHAbQ+Wo+cCGGd5oPhxTAuavbp2NswL+A6k0coQ7WwW5fdg9Hvhqgi6vszRQeLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899518; c=relaxed/simple;
	bh=romQeCJTYlA5FMDuhkjcem52PpQdg2XBFPu85pnifC8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qbdf/2gP1l63mWmg4Vo/YEDl6YLg3gtWxjZV2vgGGkfoXK7ZAhoVh642iAdmujpTPHiIxNmxPZp6IN5hW2fbUn6PpX68c2pr0uM2jDb197ACm06KkmDGrlxqXBfDLz/g7oUHzPiYHTvfpgWRW/yj9rM2g4/OrGiPCPCZz7FEe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqPyW75b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqPyW75b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6321F000FF;
	Tue, 13 Oct 2026 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899517;
	bh=q8yMgqqvpPrYc+O4zjIJ+aEtoQ4Uhcu65nRUnv/vI7s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LqPyW75bM0UxAfU1SR5UuFQ7ewiND++tATeDK9B7cZXSodj3VR2N6K/bBC2IRkUFq
	 LOZ4q0v+ijAu7eHvC8OLLQc2TCClvrDAn9nxyNkQlA9Ydx+UmzLKR6orn15ahfZ1cS
	 j86iloNPPHVkS8aoXUvGJ7EbOHqyYcGBiHV9zMkFM3m70qQWE2F5U7SAmE8GklKeWR
	 f1enQvRt3Zamm4guW6OrTCk467GPakE4vpciTKePeIWSG/G9hXK2FfcsPh5sZwsOUg
	 L7rv7F0UwLP/bYRcIaQIPd135vWNaKYlqNEtyP4LK+lAvrTxQIruOy/gti+dY+ptvA
	 JwU7nEM0unxbQ==
Content-Type: multipart/mixed; boundary="===============6230471068222945793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f21dc3bab390094709065af0809fef22464aa3b98dcb48983716b6476ae35bd1@mail.kernel.org>
In-Reply-To: <20261013122125.843451-3-zhen.ni@easystack.cn>
References: <20261013122125.843451-3-zhen.ni@easystack.cn>
Subject: Re: [PATCH v2 2/6] mm/page_owner: add bpf_iter target "page_owner"
From: bot+bpf-ci@kernel.org
To: zhen.ni@easystack.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,vbabka@kernel.org,surenb@google.com,mhocko@suse.com,brendan.jackman@linux.dev,hannes@cmpxchg.org,ziy@nvidia.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,zhen.ni@easystack.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 13:51:54 +0000 (UTC)

--===============6230471068222945793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/page_owner: add bpf_iter target "page_owner"

TL;DR:
- Missing BPF_ITER_RESCHED may let one read() loop up to 1M objects without
  yielding, risking RCU stalls on !PREEMPT
- Commit message bpftrace example counts allocations, not pages

>     mm/page_owner: add bpf_iter target "page_owner"
>
>     Register a bpf_iter target "page_owner" that walks the pages eligible
>     for page_owner output, with the same eligibility rules as the
>     /sys/kernel/debug/page_owner read path.
>
>     For each eligible page the attached BPF program receives the pfn, the
>     page and the page_owner record, and can freely filter and format output.
>
>     The po_snap record in the scan cursor is taken inside the page_ext
>     RCU window and handed to the BPF program as a copy, so no RCU window
>     is needed at consumption time. Torn reads remain possible if the
>     record is concurrently updated while it is copied, but this is the
>     same best-effort behavior as the read path has always had.
>
>     The target is registered from pageowner_init() when both
>     CONFIG_PAGE_OWNER and CONFIG_BPF_SYSCALL are enabled; a registration
>     failure only disables the bpf_iter target.
>
>     Userspace tools such as bpftrace can attach to this target like any
>     other bpf_iter. For example, to count pages owned by init (pid 1):
>
>         bpftrace -e 'iter:page_owner / ctx->po->pid == 1 / { @ = count(); }'
>
>     Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

The example in the commit message says it counts pages owned by init:

    For example, to count pages owned by init (pid 1):
        bpftrace -e 'iter:page_owner / ctx->po->pid == 1 / { @ = count(); }'

Is that accurate?  The iterator produces one record per allocation, not one
per page, because page_owner_next_eligible() skips the tail pages of
high-order allocations:

    /*
     * Don't print "tail" pages of high-order allocations as that
     * would inflate the stats.
     */
    if (!IS_ALIGNED(pfn, 1 << page_owner->order))
        goto ext_put_continue;

So '@ = count()' counts allocations made by pid 1.  An order-9 THP
allocation is counted as 1 instead of 512 pages.

Could the example or its description be corrected so that it reports what
it claims, for instance with '@ = sum(1 << ctx->po->order)' to count pages?

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> new file mode 100644
> index 000000000000..938cb42ab7d7
> --- /dev/null
> +++ b/mm/page_owner_iter.c
> @@ -0,0 +1,124 @@

[ ... ]

> +static struct bpf_iter_reg page_owner_iter_reg_info = {
> +	.target			= "page_owner",
> +	.ctx_arg_info_size	= 2,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__page_owner, page),
> +		  PTR_TO_BTF_ID_OR_NULL },
> +		{ offsetof(struct bpf_iter__page_owner, po),
> +		  PTR_TO_BTF_ID_OR_NULL },
> +	},
> +	.seq_info		= &page_owner_iter_seq_info,
> +};

Should page_owner_iter_reg_info set .feature = BPF_ITER_RESCHED?

Without it, bpf_seq_read() never calls cond_resched() between objects for
this target, because can_resched = bpf_iter_support_resched(seq) is false.

page_owner_next_eligible() has no scheduling point on its hit path either:

    scan->po_snap = *page_owner;
    if (!scan->po_snap.handle)
        goto ext_put_continue;
    page_ext_put(page_ext);
    return true;

cond_resched() only runs on the ext_put_continue miss path.

When hits are back to back (runs of allocated order-0 pages, which is the
normal case for anon and page cache memory) and the BPF program writes less
than the user buffer size (the commit message's own '@ = count()' example
writes nothing to the seq_file), a single read() loops up to
MAX_ITER_OBJECTS (1,000,000) times.  Each pass does page_ext_get/put, a
struct copy and a BPF program run, with nothing yielding in between.  On
!PREEMPT kernels that holds the CPU and delays RCU quiescent states for the
whole loop.

This is the situation commit cf83b2d2e2b6 ("bpf: Permit cond_resched for
some iterators") hit in the same bpf_seq_read() loop, an rcu_sched
self-detected stall under load.  The debugfs read path doesn't have this
problem because read_page_owner() returns to userspace after every record.

The requirement for the flag looks satisfied, since nothing is held across
next() -> show(): page_owner_next_eligible() drops the page_ext RCU read
lock before returning, and already calls cond_resched() itself.  The other
iterators that can safely reschedule (task, task_file, task_vma, cgroup,
kmem_cache, dmabuf, kallsyms) all set BPF_ITER_RESCHED.

Later commits in this series (54a9d79ddbf5..e52345a241ae) do not add it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38403671988
--===============6230471068222945793==--
