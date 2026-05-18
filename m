Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75233CF032;
	Mon, 18 May 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088860; cv=none; b=RQ/G/iN2NRJFDH2oC4cJ6maZ7mlop20NDi3mokIMk63HFx073TOg99Doy/0UfJKoPN8yEG/4JKoiL5LMNK0E2E+H/QUo/1ifl36TVsgZJhr/YYnRVt9c3W0OrcLUag1l7ATtxYlH5Cr/qXzPxUGiNSoOp7Uejvt3UQAsCxAWO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088860; c=relaxed/simple;
	bh=f+VDzJu5kyWEt4aDEa8SHcG2BEIGEy0p37k+XH/gSn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDu3hdzPXULuq9+k543zPSwHqED6aJk3/5x78bOymfg4npd0x7h6tpLU5WyCf9zCO3c9ybKPNceVp5lOa12f/VfIonbEa1sAEWBse4P2MZUNxnwbOfRkGcjm8zExR/IfG0ywQNTz26zDmrlLkmZ4jnuVYQO7QSIQAnlnWpae+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bcr6ZW+6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcr6ZW+6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oymZOlMj6aZm2jiVzI4Upf5k8ifuN/pveVWUu4TydLQ=; b=bcr6ZW+6uMYVPPdYnu1n5lZvLE
	SGn2E8l0rK+cjQ+R6Sj5HL59towTXB6p12v2CEvZTRYmeGs2QkOf4gLowmIrvuI3JiuVpU2DOQQiu
	ndfkYABp9AVnYFrMPoKMGIujfaB+EX05Vg83yfMS2mbf0dy0/Ghhaty6xMyz/eRsGISxsZdQitFOR
	kBmGZPmASGz9S7TSlR7rOPtuNlSAhUKb6vCKWR0NYuqbdYs6gBQeYkthJrz5ORo1qBuec7q+BFWEp
	Y0NW5xhU2pyfHfK2jwpm1QeszCSqZfOkFSFOnoR0fhrifOkzGQX8T7FNYmekXVm65m4u8QGeakwRx
	sx+RmmBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOsHL-0000000A9JE-24Bl;
	Mon, 18 May 2026 07:20:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBF7B300329; Mon, 18 May 2026 09:20:42 +0200 (CEST)
Date: Mon, 18 May 2026 09:20:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
Message-ID: <20260518072042.GP3102624@noisy.programming.kicks-ass.net>
References: <20260517211232.1670594-1-tj@kernel.org>
 <20260517211232.1670594-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517211232.1670594-8-tj@kernel.org>

On Sun, May 17, 2026 at 11:12:31AM -1000, Tejun Heo wrote:
> Build a per-scheduler sub-allocator on top of pages claimed from the BPF
> arena registered in the previous patch. Subsequent kernel-managed
> arena-resident structures (e.g. per-CPU set_cmask cmask) carve their storage
> from this pool.
> 
> scx_arena_pool_init() creates a gen_pool. scx_arena_alloc() returns the
> kernel VA. On exhaustion, the pool grows by claiming more pages via
> bpf_arena_alloc_pages_sleepable(). Chunks are added at the kernel-side
> mapping address; callers translate to the BPF-arena form themselves if
> needed.
> 
> Allocations sleep (GFP_KERNEL) - they may grow the pool through vzalloc and
> arena page allocation. All current consumers run from the enable path (after
> ops.init() and the kernel-side arena auto-discovery, before validate_ops()),
> where sleeping is fine.
> 
> scx_arena_pool_destroy() walks each chunk, returns outstanding ranges to the
> gen_pool with gen_pool_free() and then calls gen_pool_destroy(). The
> underlying arena pages are released when the arena map itself is torn down,
> so the pool destroy doesn't free them explicitly.

Should this really be part of scx rather than be part of the bpf-arena
thing proper?
