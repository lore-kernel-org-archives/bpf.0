Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914526;
	b=Seeiw10HPxHT/sFDGnNjmN/bNiqFe812Rtw6usuOS9XgLB5soqLuX1yISqi21ZqRQnfb
	 Y7bdRb9V01/dlaz/SOIW9rWyazXKwgxIFNo9/8t80vH700pkzq193cksw7wOVEANkLq9g
	 xxWdvmMuZQdFkszRc08oYmgeV/BhX3wiZ/wLSTmVfek37cd58i2OEbAQVSOrNtebNEB2j
	 /m/14nlzt3Ufdc/ty07bcuE/GdlH2m/aCkje4TXWlpvfbw0vpWe7UP4TSJLaSVaI6d2vp
	 jaUFfffBTJZ3dRftKP623ymcq6akASYv63QoXs1QBv0PZFl9rKnyq0+qkRFyUApl0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914526;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=hp4W77jxzMHFy4EqyP7InIA4zbdTOogWwq0m0Sk1FeM=;
	b=Oi2XEhnGMpPlGsIDc8mpgC2Zf/qV6Oc3eJG9oQz6Esh29/0q5Xte1COh+WgNmF1lPt5C
	 5UqF1NbGaEFZJajuVyzdM0tm3T37zSPq539m4yIevWRaDpzMWWyL657H7T0metNyk+KSx
	 kWVld5GwXZqxIxCGc6XZQMnidOS4Jv3JrkQvWmJERZ1ilxVAV0S2L6+ZwkGj6ej6qfiwu
	 DPy8oeVrpgLms89/Z2eh8wtagsUru3h5XvkTWDb9NuUoGxcahT3KXIBV6Ou5qWW0bxSHh
	 eWeyiFA7z+cRCji/XE+k3Ytx0rTSxKFNfFvOGz//T2tO7TIQCCdLva0SeunrmVOHAMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn9nC37M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D32606A333
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn9nC37M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253891F0089F;
	Thu,  5 Nov 2026 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914526;
	bh=hp4W77jxzMHFy4EqyP7InIA4zbdTOogWwq0m0Sk1FeM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Tn9nC37M7WShq04gQLWXsSq6WlRsYtacW6xmrRoDeow3Oknc3N4i5AedeaSest4KX
	 +4oFV6oK8skqFlk5P3JaG9+39GJKVY5TkbHsYQhw7kJ7rUx6KhQCADG2FZxW/25w7t
	 SnaTQRvLWVCvPbPvSdW70VURmE7gbUQmCLaN6/VTcOo39QvZljzq3cUd5S5YwYHljz
	 Ov7qI6W0cwIppRXeZfKcuzj/MH25mVz4zEVEnb5Javhzc1P0O37pLKUrayt/Ik2hBU
	 lRVHkUog9X+skaDBbf6fahQbjCfM6ExnfFfQft5Lkgcu2g3a/PqCKPxCl/NMAmP+2h
	 fYzGU3wpTKY1w==
Content-Type: multipart/mixed; boundary="===============0876656459859166077=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fcbec8669c7546e28eed01101db19cbc77acf022bed23699db6ef352fe6330bc@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-30-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-30-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 29/35] selftests/bpf: Adjust tests to log lines that are gone
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:26 +0000 (UTC)

--===============0876656459859166077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to log lines that are gone

TL;DR: Commit message only: for_u32_spills_u64_fill() is rewritten, not just
re-matched against new log lines. It looks like a fix for a vacuous test;
consider a separate patch or say so in the message.

> Without this patch 114 subtests of test_progs and 4 tests of test_verifier
> fail. Their progs get the old verdict, but the tests match lines of the
> verifier log that the kernel does not print any more. Keep the progs. Match
> the line of the new log that shows the same fact.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> --- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c

[ ... ]

> @@ -239,28 +240,21 @@ __naked void for_u32_spills_u64_fill(void)
>  	call %[bpf_get_prandom_u32];			\
>  	r6 = r0;					\
>  	w7 = 0xffffffff;				\
> -	/* Additional insns to introduce a pruning point. */\
> -	r3 = 1;						\
> -	r3 = 1;						\
> -	r3 = 1;						\
> -	r3 = 1;						\
> +	r9 = 0xffffffff ll;				\
> +	/* Additional insns to have a place where paths meet. */\
>  	call %[bpf_get_prandom_u32];			\
>  	if r0 == 0 goto l0_%=;				\
>  	r3 = 1;						\
> -l0_%=:	w3 /= 0;					\
> +l0_%=:	r3 = 1;						\
>  	/* u32 spills, u64 fill */			\
>  	*(u32*)(r10 - 4) = r6;				\
>  	*(u32*)(r10 - 8) = r7;				\
>  	r8 = *(u64*)(r10 - 8);				\
>  	/* if r8 != X goto pc+1  r8 known in fallthrough branch */\
> -	if r8 != 0xffffffff goto l1_%=;			\
> +	if r8 != r9 goto l1_%=;				\
>  	r3 = 1;						\
> -l1_%=:	/* if r8 == X goto pc+1  condition always true on first\
> -	 * traversal, so starts backtracking to mark r8 as requiring\
> -	 * precision. r7 marked as needing precision. r6 not marked\
> -	 * since it's not tracked.			\
> -	 */						\
> -	if r8 == 0xffffffff goto l2_%=;			\
> +l1_%=:	/* if r8 == X goto pc+1 */			\
> +	if r8 == r9 goto l2_%=;				\
>  	/* fails if r8 correctly marked unknown after fill. */\
>  	w3 /= 0;					\
>  l2_%=:	r0 = 0;						\

The commit message says "Keep the progs. Match the line of the new log that
shows the same fact.", but for_u32_spills_u64_fill() gets a different
program, and its expected message stays "div by zero", so the rewrite is not
visible in the expectations.

The old program had this where the two paths of 'if r0 == 0 goto l0_%='
meet:

    l0_%=:	w3 /= 0;

check_alu_op() rejects BPF_DIV with BPF_K and imm 0 as soon as the insn is
reached:

    if ((opcode == BPF_MOD || opcode == BPF_DIV) &&
        BPF_SRC(insn->code) == BPF_K && insn->imm == 0) {
            verbose(env, "div by zero\n");

So every load stopped there, before the u32 spills and the u64 fill, under
the old verifier and the new one alike.  The test looks to have been vacuous
since it was added in 0be2516f865f ("selftests/bpf: Tests for state pruning
with u32 spill/fill").  The old 'if r8 != 0xffffffff' compares also used a
sign-extended imm (-1), while a wrong fill would give 0x00000000ffffffff.

This patch removes that div, replaces the four 'r3 = 1' insns with
'r9 = 0xffffffff ll', and compares r8 against r9.  Now only the final
'w3 /= 0' gives "div by zero", and only if r8 is unknown after the fill.

That looks like a real fix, but it has nothing to do with log lines that are
gone, and the old program would still have got the same verdict under the
new verifier.

Could this go in its own patch, or could the commit message at least say
that this test was vacuous and how it was fixed?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============0876656459859166077==--
