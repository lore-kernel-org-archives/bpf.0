Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BE395DB4
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680200; cv=none; b=e0r3VFTjRvyGREQ6GGEygPSMp9N0wghSEVNTeTWtVsMJt5DHfhOo3TsTVEBl6zIqkGUTjZGhael29ogxbdJFvQWrsSwWgDJWPAVkG6x9z5rMfTMvH4uMY7e0Ob7wmapqhPBK1OpG/538EqJcdggyyonarE9IVQUYYhI0HoEKcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680200; c=relaxed/simple;
	bh=fzWSsgO4f/GdqjiTLOqTFb5H54PKYba4VqFOp8XRlbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwQ9IElHdK8Kdm6f4jCi2HZTJXdXhVaPEzQOYVks0ZpXJt31TDVuYnkRj+OBXJAxdHM18Edq89v+bbTmy1EFu37SFMYejFkY9476CPd96U5rAQt867rN+6pggYSmAo7ifPK4148TdK6QQnzWWjnj0o98vgI9g4vlDLTW/KhPYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2BRjvjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2BRjvjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024A7C19425;
	Mon, 20 Apr 2026 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776680200;
	bh=fzWSsgO4f/GdqjiTLOqTFb5H54PKYba4VqFOp8XRlbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2BRjvjlm+Ijdoiku2z7SklesvpgK+VMgb83+XGCxF/4MWZy5K8OJfkssOLGwPbaW
	 ykNjCS7P1IZwpMLKuvRWabe33FO9EhTELWJw97X7KVHXxn/e5kobHkH2c4kcFgle5D
	 l4tU2zEw1lRL7jzgyY6jryd11MNrmXG2qFs9g44s0fmjl9wL/+htfStdAU/hzAIkW3
	 R2iY5h2gQ3EuYkmnzYlJMu+i9PDyRpYIvckQI3mXCFb5IMhxI/QFLWKkmnX5vptIo1
	 bumx9PKlFSgjZlPj8PTSKIQ10DBplYrLYn9CEUCHNrgy687lDxDvqXb3TIkE5vjf4+
	 kjXOCxeP7T/8A==
Date: Mon, 20 Apr 2026 11:16:34 +0100
From: Will Deacon <will@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>, kernel-team@meta.com,
	maz@kernel.org
Subject: Re: [PATCH bpf-next v13 6/6] bpf, arm64: Add JIT support for cpu
 time counter kfuncs
Message-ID: <aeX9Alsyk1Cb2QLG@willie-the-truck>
References: <20260418131614.1501848-1-puranjay@kernel.org>
 <20260418131614.1501848-7-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418131614.1501848-7-puranjay@kernel.org>

[+ Marc]

On Sat, Apr 18, 2026 at 06:16:04AM -0700, Puranjay Mohan wrote:
> Add ARM64 JIT inlining for bpf_get_cpu_time_counter() and
> bpf_cpu_time_counter_to_ns() kfuncs.
> 
> bpf_get_cpu_time_counter() is JIT-inlined as:
> 
>   ISB                       // serialize instruction stream
>   MRS Xn, CNTVCT_EL0        // read architected timer counter
> 
> The ISB before the MRS is required for ordering, matching the kernel's
> arch_timer_read_cntvct_el0() implementation.

Careful here: this will _not_ order counter accesses against normal
memory barriers (e.g. smp_mb(), acquire/release). If you need that, then
you need something like arch_counter_enforce_ordering(), which we do
have in __arch_counter_get_cntvct().

Furthermore, using the virtual counter may expose you to situations
where a guest value for CNTVOFF is installed (e.g. during the VCPU run
loop). Given all the contexts in which BPF can run, this worries me a
little as you might end up seeing a non-monotonic view of time between
BPF programs.

> On newer CPUs it will be JITed to:
> 
>   MRS Xn, CNTVCTSS_EL0      // self-synchronized (ISB not needed)
> 
> bpf_cpu_time_counter_to_ns() is JIT-inlined using mult/shift constants
> computed at JIT time from the architected timer frequency (CNTFRQ_EL0):
> 
>   MOV Xtmp, #mult           // load conversion multiplier
>   MUL Xn, Xarg, Xtmp        // delta_ticks * mult
>   LSR Xn, Xn, #shift        // >> shift = nanoseconds
> 
> On systems with a 1GHz counter (e.g., Neoverse-V2), mult=1 and shift=0,
> so the conversion collapses to a single MOV (identity).

Do you have any performance numbers to show that this is worthwhile
compared to calling a helper wrapping __arch_counter_get_cntvct().

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/include/asm/insn.h                 |  2 +
>  arch/arm64/net/bpf_jit.h                      |  4 ++
>  arch/arm64/net/bpf_jit_comp.c                 | 54 +++++++++++++++++++
>  .../selftests/bpf/progs/verifier_cpu_cycles.c | 50 ++++++++++++++++-
>  4 files changed, 109 insertions(+), 1 deletion(-)

Aren't you conveniently ignoring CPU errata here? I suspect this needs
to be predicated on the absence of those, in a similar way to how the
vDSO deals with the 'vsdo_clockmode'.

Will
