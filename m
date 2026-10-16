Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2352ED34;
	Fri, 16 Oct 2026 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172968; cv=none; b=CYeWbonYVMymdTjed7o80+Ob1SxsOkStyGkdSy+XOIalu0YmTn7yU18LmDE+/DFTvPU954zkgzviNmeMyO7bkTWSCGX4ggHlYsr5wPHeEVM7bw/sPommhfJ/YiDp1hlwQgTu8/ek5fD+PDMOFl+UWH/i5w5ENcU2vDxlRBVfVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172968; c=relaxed/simple;
	bh=UyBJX0/0KzYg8qyPNHJutHM78POcNnYCsxWzSCjVgzA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hGfLKm2IoGpg9fBAo0rAhEdb7fTrL4FqmKn5EY8BAhCQb+o/1CVXdYg3bwJw8lODWV0RJFZ1k+rbxLnEKd7z5cdz/wPdeX0v34CIqJG6HdeVQWv0QmTEeresstDFRCY7/2HCu3yH7S+IX9QcRcaAyyBuCZjswOfUEN+ogNd+mRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jedKCDaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jedKCDaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EB91F000C5;
	Fri, 16 Oct 2026 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172966;
	bh=c+Q2WRyX9uvFEt5WnU72kmonNKdTPES+k9xnAuTMxLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jedKCDaWnotORQcDppEZx2vU+TyHE0ZVlpHL1KaVzTzdRFQJ5UnzWqA0LdY6LMoTn
	 PvSIOdtukh3p0mUHym8Muk/SKDpaJDIxmENbphQCoV75J+wS8MGGvhQM63Lluang1A
	 WK5q7axsfvmrMUI9+Qo8LXp+g1jESuFV/B2eKdEjdSifW0+wBEsywzgt8k5rD3sFjE
	 hH3ikQGMYhSL1upnVJZI5rJcugKCqQGtb4iq6aVVpA1UgB024rNN+VaRWXx8ucMQCk
	 E896EYUx5TSogAcVI5SvSeJaVJzIPYh5Vgpo2b5s+5YyyFsEyEz0zYVB6QXz/M4z5r
	 6GtCRO1GOLP0w==
Date: Fri, 16 Oct 2026 07:49:25 -1000
Message-ID: <d0d742e7dcb71676a8a37ebd4e53feef@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] selftests/bpf: Test fetching AND/OR/XOR atomics in arena
In-Reply-To: <20261016171319.1623447-3-puranjay@kernel.org>
References: <20261016171319.1623447-1-puranjay@kernel.org> <20261016171319.1623447-3-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, Oct 16, 2026 at 10:13:13AM -0700, Puranjay Mohan wrote:
> The arena and/or/xor tests never exercised the fetching form of the
> instruction. Commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics
> failure due to llvm change") deliberately switched them to
> __c11_atomic_fetch_*() with memory_order_relaxed, which clang lowers to a
> non-fetching locked instruction when the result is unused, because
> x86-64 could not JIT the fetching one against an arena.
>
> It can now, so check the returned old value with __sync_fetch_and_*().
> Keep a __c11_atomic_fetch_*() of each width per operation with the result
> discarded: that spelling is what selects the non-fetching insn, which
> would otherwise lose its only coverage, on every architecture rather than
> just x86. Compiling the prog with clang 22 before and after confirms the
> split: 6 non-fetching and no fetching arena and/or/xor before, 6 and 22
> after.
>
> The new globals go in their operation's block, and the or block keeps its
> u32s first, so .addr_space.1 stays free of the padding holes that clang
> before 18 cannot fill when it is built without address space casts.
>
> Add a fetch_r0 test for the two register assignments the x86 JIT has to
> special-case, where the operand and where the arena pointer is R0 and
> BPF_REG_AX is substituted for it. Clang picks its own registers and will
> not reliably produce either, so spell the instructions out. The values
> have bits set above 32 so that a truncating move on that path shows up.
> Add both forms to the uaf test as well, since the substitution only
> reaches the exception table when such an access faults, and check that
> the fault cleared the fetched register and left the address alone. They
> fault on the page after the freed one: the freed page is the first of the
> arena, whose 32-bit address is 0, which would make the address check
> empty. The address is read back afterwards, which gives 0 if the JIT's
> exception table entry recovered the fault, but not if the arena had
> mapped its zeroed scratch page and let the access succeed. The powerpc64
> JIT does not clear the register of a faulting atomic yet, so those checks
> are skipped there.
>
> Both spell addr_space_cast textually, which needs LLVM 19, so uaf gains
> the __BPF_FEATURE_ADDR_SPACE_CAST guard that every other textual use in
> the file already has. It was plain C before and built on older clang.
>
> Drop x86 from the exclusion list of the uaf test, which covers the fault
> path. Its page is gone before the first access, so it faults on the load;
> the CMPXCHG entry is only reached when the page goes away between the two
> accesses, which a test cannot arrange.
>
> Finally cover fetching AND/OR/XOR through a number in
> verifier_arena_scalar, on x86-64 and arm64. Both widths are run with the
> operand in a register and in R0, which is where the x86-64 JIT keeps the
> operand on the stack because BPF_REG_AX holds the address. The 32-bit
> operands have bits set above 32 so that a missing zero-extension shows.
> The page is also freed first, after storing a nonzero value in it so that
> an access which did not fault would show, and the test checks that the
> fetched register comes back 0 and R0 is left alone, and that reading the
> address back gives 0. R0 is compared with a value derived from the page
> address: the verifier would decide a comparison with a constant at load
> time and drop it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
