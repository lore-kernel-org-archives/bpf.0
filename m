Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AD55C326;
	Fri, 16 Oct 2026 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172966; cv=none; b=PxVakZSjPH2X1VuORmMM/T2O7t/FBc4FmQBKV7jrgMjaExeHoEcKmcZt1h6t2G55acrJxg49qCuhT3k7LRriy1jPopBzIWNPC64LXTBMAtMCqFmPJKKypQbuZKQXxDJOregHI9JDfIBAcy7CvIEFFPOT5IcMWnCOhHXUovzFLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172966; c=relaxed/simple;
	bh=dWRQ2aF4/VaPlp0h4V3RSLl+xiCisBrJ5hzbd5rHqiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cj2Bg88VBkpUW6TD92zbGFvkA6taeHY0U40Eba0wm935jKHJu6GEMoFugkRv8VqG5qky0N/4VhRjfKFmSBWah5Ra5PgZiUcStVSGGEjrqZo10fBza8P/y+c0rEWK6tbkUwYn7rrjM9dygOQ4ALmeEYhiN7iMr0BP5uauoqiuiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoV1rqKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoV1rqKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0001F000C4;
	Fri, 16 Oct 2026 17:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172965;
	bh=khC4eyWshOpMfKEOEAE78FZ5zFD7AWn5w7V2kZ90LUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WoV1rqKnq9Ci8pyOvu0kcUDfVS8vcTn8PMPFnCXP3Zmz2wWWg71ONLHdcHx+/VRnr
	 cjE6GSrmeUr2JDRPuOZer26Hsj+yVlwTz5Bvl4Z3wAlW75uLrR/+CgmQQNpMj7yrNp
	 EB57BD2EhfY3p15VaW2/+SQ5U1Tc3zmtWn5ndalh0/DHm2ehWyTOtbSsrW6yTdE1L5
	 qEbtAL3mo+bFRSt5WKY4kouUuwm0eXz48OwKzobnRfButMecoWpzvp9HyB0xk4PxX4
	 zESNV/S2W9lCkbntty/HKpg2dLUzsKLtQhDxyG/6CiADEo9qWqFva/SaNHE9jd0jXD
	 j/6OvZ0KfimEg==
Date: Fri, 16 Oct 2026 07:49:23 -1000
Message-ID: <6780de9ee6208d26065d42ec10c23efa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf, x86: Support fetching AND/OR/XOR atomics in arena
In-Reply-To: <20261016171319.1623447-2-puranjay@kernel.org>
References: <20261016171319.1623447-1-puranjay@kernel.org> <20261016171319.1623447-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, Oct 16, 2026 at 10:13:12AM -0700, Puranjay Mohan wrote:
> x86-64 has no single instruction for a fetching AND/OR/XOR, so the JIT
> lowers them to a CMPXCHG loop. That loop could not be used against arena
> memory: it contains two memory accesses, the load of the old value and
> the CMPXCHG itself, either of which can fault when the arena page goes
> away, while the verifier reserves only one exception table entry per
> instruction. bpf_jit_supports_insn() therefore rejected the three opcodes
> and such programs failed to load with
>
>   BPF_ATOMIC stores into R1 arena is not allowed
>
> Emit the same loop with R12-indexed addressing and give each of the two
> accesses its own exception table entry. The verifier still reserves one
> per instruction, so the JIT accounts for the extra entry itself by
> rescanning the instruction stream in bpf_int_jit_compile() before the
> extable is sized, as s390 does in bpf_jit_alloc() for its BPF_XCHG
> lowering. The rescan sits after the extra-pass early exit, so a program
> is counted exactly once. Drop the bpf_jit_supports_insn() rejection.
>
> A loop without the load would need only one entry, since a CMPXCHG that
> loses the comparison reloads RAX, but its first CMPXCHG would then almost
> always lose. Every operation would pay for a second locked CMPXCHG, which
> makes the fetching insn more expensive than the load and CMPXCHG loop
> programs write by hand today. The second entry is paid for once, in the
> JIT.
>
> Both entries resume past the whole loop rather than past the faulting
> instruction alone, with the fetch destination cleared, so a fault cannot
> re-enter the loop, and both are reported as writes since the BPF insn is
> a read-modify-write. This repurposes the INSN_LEN field of the fixup as a
> resume distance rather than an instruction length; a sequence long enough
> to overflow its 8 bits would first have to exceed BPF_MAX_INSN_SIZE, which
> do_jit() rejects before the image is used.
>
> The loop needs RAX for CMPXCHG and saves R0 in BPF_REG_AX, which it also
> substitutes for R0 when either operand is R0. ex_handler_bpf() may then
> have to name r10 as the register holding the arena address or the one to
> clear on fault; reg2pt_regs[] already has that entry.
>
> An access through a number, made by a program loaded with
> BPF_F_ARENA_SCALAR, keeps its address in BPF_REG_AX itself (see
> arena_scalar_access()), which is where the loop would save R0. Save R0 on
> the stack in that case, as the div and mod lowering does. An R0 operand
> stays in that stack slot: the new value is built from it, RAX ends up
> holding the old value that R0 is to return, and the slot is dropped
> instead of popped. Both entries resume before that pop or drop, so a
> fault leaves the stack balanced.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
