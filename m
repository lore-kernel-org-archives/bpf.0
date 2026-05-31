Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730A13A258;
	Sun, 31 May 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780249680; cv=none; b=K4RB0hoWqLGytzOhPNedjTHUctLSCbjbikhwb8wTvrTU9+IiK73HwMomRg4kPoHs0UMYVN3eQZokjyhFU6aMH1THKv2v3paeF7ep3Cq16Uy5Q0KIgKERbx47OkS08uMA3H4KQMh0BmgaO1kzumjXeRIkAGnc5i7NEVf67TmEcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780249680; c=relaxed/simple;
	bh=F3mI7ur+3TrZEuhPbRRWH/uaagucCCgMcjpOTxWgag8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=UgQqpRjOwQ7QP0qiGXy9P9FzTxe2Qajo5tKa7S3ktWjyMi2jGX99RVH5qGq/al/M9UesDFt8Lw2Ck5dbGqYotGivNZ0+/KI8Vj+uUVcbVJJ6j0hbM0NzoZnB26ESuSAvAzgkSzVCITGyWo48WWdCkxjKnkEtXdfEcpTCjb82pGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuDXv0f1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuDXv0f1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA811F00893;
	Sun, 31 May 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780249679;
	bh=SRhng7ZwRas2P1ADM7h74381kykfPa3pcL8IR8Sgsag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iuDXv0f1iop3nim+N4Thcks0PngriNRgeVPiAgKtBxzypHnxoTMMjLjp/89E9JBRZ
	 J7oClLQY++qvZPFaL7cOm6gepiOYfT3domo4RNKpi6RmfTbt4FORCfaHxm2ETsL/xi
	 NqGfxszFTID7uGZw41CWjkVP7+KI1W5ueUQrg5fHeWOpaiKiMbpzVIWCNV/G3S/Kfz
	 uXzOBEF+equVHqy2k6NFGA1UG/FPQnRZteKEQgm4iUUEcJYruwNY4f+ZMsHxOi6u5J
	 GhlaseKU9FawVQ+Iy2xlZSW+1IvWgPYeLqfjhqyspX4s4XfERaakiGk82QYGyeXAx+
	 lTa3BvBR6Kovw==
Date: Sun, 31 May 2026 07:47:58 -1000
Message-ID: <8cc56c7a4aa29628b7d17d85be7eadb9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, David Hildenbrand <david@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, bpf@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] bpf: Recover arena kernel faults with scratch page
In-Reply-To: <ahnedQ33ZH8ogjbC@slm.duckdns.org>
References: <20260522172219.1423324-1-tj@kernel.org> <20260522172219.1423324-3-tj@kernel.org> <7fd673df-22f3-4d70-a779-ea0b878188b3@kernel.org> <DIUMP21RASZI.2VNQV45RIL209@gmail.com> <3901fe0537edee9d7acdfd91695ead28@kernel.org> <CAADnVQJ+CqAszS2sSVu7gSfA_g4oaTR+SWmLNMX3_8c=OdR7NQ@mail.gmail.com> <ahnedQ33ZH8ogjbC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

I posted the check removal [1], and Sashiko's review flagged a
break-before-make problem with it [2] that I think is real.

The scratch page is a present PAGE_KERNEL mapping, so having
apply_range_set_cb() overwrite it via set_pte_at() during
bpf_arena_alloc_pages() is a valid->valid PFN change. I'm not familiar with
arm at all. David, my understanding is that's a break-before-make violation
on arm64, and that on any arch the stale TLB entry keeps resolving to the
shared scratch page until it's flushed, so a later access can hit scratch
instead of the new page. Is that what you were worried about?

So instead of just dropping the check, the install should route through an
invalid entry rather than overwrite in place:

	while (!ptep_try_set(pte, mk_pte(page, PAGE_KERNEL))) {
		old = ptep_get(pte);
		if (pte_none(old))
			continue;
		if (WARN_ON_ONCE(pte_page(old) != arena->scratch_page))
			return -EBUSY;
		ptep_get_and_clear(&init_mm, addr, pte);
		broke_scratch = true;
	}

ptep_try_set() only fills a none slot, so the slot goes scratch->none->page
and never valid->valid, and the loop copes with a concurrent fault
re-scratching it. This also closes the set_pte_at()-vs-ptep_try_set() race
I raised earlier, since both sides are now cmpxchg. A broken scratch entry
was live, so the caller flush_tlb_kernel_range()s those pages when
broke_scratch is set, like arena_free_pages() already does after clearing.

[1] https://lore.kernel.org/r/20260531165852.555930-1-tj@kernel.org
[2] https://lore.kernel.org/r/20260531170854.31EA51F00893@smtp.kernel.org

Thanks.
--
tejun
