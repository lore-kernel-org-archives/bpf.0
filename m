Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7834751B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238788; cv=none; b=Ya19pJzKILDYl1yPPgBUmI94WnoH9xIYWZFHNXvr1rhaffZX+BHv1zPDvK0wSgcKkPcaIiTSX9GcMJ7YupMXGGXVghfjf+OtLB3LBMWJVvM8nOth4FwPBZsMdH7XhhSfgzX6nKmPIc234+15iicHgLmTzFpTcvAOkM1FysEjGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238788; c=relaxed/simple;
	bh=+J8iN0/xkjp18GmRVEJ2a9ujaySQoIY7aXMos0zGeEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ldKYdBZrLhzjeOFlQ7duR9RppqPtzUZI7khRmyMsTHoxSzCMKNSBMkYj1hop8OyWU0ChBPfFsZTAiRg4hWXh7/e8yT28/e6jOweAiSE0meN76+g1KG2q4J7yDyKtwAy6ElAcw4vrcG8OrRx18oHN8YWigMnDcvRtKSAI+xWPDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC2FCPL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC2FCPL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A6E1F000E9;
	Thu, 16 Jul 2026 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238787;
	bh=bi4kvrxa/pinhDFFaJj+XYbfSfuu+6TpdHPcuOkJQmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aC2FCPL9niL6GFy6u4KAyMiCOzcalxKbmqKi9vrPnosACwzgB1fhn9cZVBKnFfUJs
	 pSd3Gt3AAlWbztlCOFxu2kK/Wqe2cpHYQKEp8qkzO6mYpeUWaMPDdJdzEU2zhIwls4
	 pHvYzfFmqd9Wac6J5U5qN2X6jII9ia7do0GYeK+Tt8wbXeab0d/LOt7xKrJYmJmQ+X
	 QgmSfAOushWQL1wvykIJxL/7tIegUxknd/hXx0Tt1J5ojVkJPiTRoaWuKmTWagqNzl
	 ynLj2BwLVlkNNHtAgMkjeHExBSdx1njg2iX4QdeSsqxFk+XLiXqT6LdaewmamN8jic
	 JbLSn35zCyjXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write
 lock to avoid UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
 <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 21:53:06 +0000
Message-Id: <20260716215307.14A6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds `mmap_write_lock(&init_mm)` to prevent `ptdump` fro=
m encountering a Use-After-Free when `cpa_collapse_large_pages` frees kerne=
l page tables. However, it fails to protect lockless kernel page table walk=
ers like `vmalloc_to_page` and `lookup_address`, leaving them vulnerable to=
 the exact same UAF.
--

--- Patch [2]: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write=
 lock to avoid UAF ---
commit 5b395a03ec3db496bc431613dd4a4fe93dcd87d9
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Subject: x86/mm/pat: acquire init_mm write lock to avoid UAF

This patch adds an mmap write lock acquisition around kernel page table
collapsing in the x86 PAT code. It aims to prevent use-after-free issues
when concurrent walkers like ptdump traverse page tables while they are
being freed.

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d023a40a1e034..d1e63f7d267ff 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c

[ ... ]

> @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data=
 *cpa)
>  	}
>  }
> =20
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +	/*
> +	 * Take the mmap write lock on init_mm to:
> +	 * - Avoid a use-after-free if raced by ptdump (which takes its own
> +	 *   write lock on init_mm).
> +	 * - Serialise concurrent CPA walkers.
> +	 */
> +	scoped_guard(mmap_write_lock, &init_mm)
> +		__cpa_collapse_large_pages(cpa);

[Severity: High]
This is a pre-existing issue, but does taking the mmap write lock on init_mm
protect against lockless kernel page table walkers?

While this prevents a race with ptdump, functions like vmalloc_to_page() or
lookup_address() can still walk the kernel page tables without holding the
init_mm mmap lock.

If a lockless walker reaches the PMD level just as
__cpa_collapse_large_pages() collapses the huge page and calls
pagetable_free(), couldn't the walker encounter a use-after-free when it
calls pte_offset_kernel() on the freed page table?

For example, a concurrent call to vmalloc_to_page() could see:

CPU1
__cpa_collapse_large_pages()
    pagetable_free(ptdesc); /* freed immediately, no RCU grace period */

CPU2
vmalloc_to_page()
    ptep =3D pte_offset_kernel(pmd, addr); /* UAF on freed page table */
    pte =3D ptep_get(ptep);

Does this mean the page tables still need to be freed via RCU to ensure
these lockless walkers don't dereference freed memory?

> +}
> +
>  static void cpa_flush(struct cpa_data *cpa, int cache)
>  {
>  	unsigned int i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-series-vma=
p-race-fix-v4-0-8c108c4317df@kernel.org?part=3D2
