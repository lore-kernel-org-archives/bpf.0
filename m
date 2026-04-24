Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6D2BDC26
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052889; cv=none; b=oguu4siIMxTie+oNitcTVQrkalL1RLLzmUh7vD8Jmtu7h2TQHAJFwMHX89PwMUwXckwitmO5N8B2y6wGIDyVaS4xH5PRfI3IHdo/K/mKtdMeuCkqGTdOdJnn+9I+eTerpfyGIe8c3GKq5Vwl5GDfKAExwrvT4njSTvTUhDRC7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052889; c=relaxed/simple;
	bh=1aM7QBcSOmfnCl+mTcPRfZLqrQrKUlla8tFIpoZnhC4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q3/TrAq/f8AbrmxnkD22+26epc0pgVE8Bz3+xAbJ9YuoNpfL2BzYUqjDQX+2n+eCydvlUGMrc1v1IY0QmLF72QFtEKO70MUWTX2CimkIxHL4SrMc7VNjXKavU+6pCBXR0Y07XEgSzQ9RETzzWtRL4bkGaq/p4TNlGcNoJQp4K20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNLawzjo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNLawzjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBD6C19425;
	Fri, 24 Apr 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052888;
	bh=1aM7QBcSOmfnCl+mTcPRfZLqrQrKUlla8tFIpoZnhC4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kNLawzjoW/KWnnW0iFG3GYugHTuvgHJohiUyLGSMYqYtdWfeN/Bm/r8ucc0cV5hnT
	 Vkw2OBo3o2MdrPAD+wFQiCT1XE3bwCXxsvOYaSnqk7hfk4kBNZ7abR19W1EMtH3ZSa
	 5xfCucAktCe9RwRgy2u0X4im8biCy1Z870HQQ+hj58JGofzYglM5B8BlPy3BBzHWcg
	 dBbatZp0gYMt4Kq8ZHJcfUEYKUrSzgxOmLO6RCTdBNufLgXjkK/+bIswrgbvMbaN9e
	 74W1Y28KGp1C1O6IksaTUiR6E+GzE5qtF4rP9i3Tpk2rxKFujbXdv07OnEFrnCdLrs
	 uBZ++9+M7oNBA==
Content-Type: multipart/mixed; boundary="===============4618373723716735901=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e4650e8672368d1d36d1fcfba86d9494fd1dd23d131f79b378812170625a22fa@mail.kernel.org>
In-Reply-To: <20260424171703.2054695-1-yonghong.song@linux.dev>
References: <20260424171703.2054695-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 13/18] selftests/bpf: Add verifier tests for stack argument validation
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 17:48:08 +0000 (UTC)

--===============4618373723716735901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> new file mode 100644
> index 000000000000..6b596ad63774
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> @@ -0,0 +1,456 @@

[ ... ]

> +SEC("tc")
> +__description("stack_arg: pruning with different stack arg types")
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("invalid mem access 'scalar'")
> +__naked void stack_arg_pruning_type_mismatch(void)
> +{
> +	asm volatile (
> +		"call %[bpf_get_prandom_u32];"
> +		"r6 = r0;"
> +		/* local = 0 on program stack */
> +		"r7 = 0;"
> +		"*(u64 *)(r10 - 8) = r7;"
> +		/* Branch based on random value */
> +		"if r6 s> 3 goto l0_%=;"
> +		/* Path 1: store stack pointer to outgoing arg6 */
> +		"r1 = r10;"
> +		"r1 += -8;"
> +		"*(u64 *)(r11 - 8) = r1;"
> +		"goto l1_%=;"
> +	"l0_%=:"
> +		/* Path 2: store scalar to outgoing arg6 */
> +		"*(u64 *)(r11 - 8) = 42;"
> +	"l1_%=:"
> +		/* Call subprog that dereferences arg6 */
> +		"r1 = r6;"
> +		"r2 = 0;"
> +		"r3 = 0;"
> +		"r4 = 0;"
> +		"r5 = 0;"
> +		"call subprog_deref_arg6;"
> +		"exit;"
> +		:: __imm(bpf_get_prandom_u32)
> +		: __clobber_all
> +	);
> +}

Does the error message string match the expected register output?

During v6 review, sashiko-bot raised a concern about test fragility:
since subprog_deref_arg6 is standard C (not __naked), LLVM determines
which register is used to dereference f. If a future LLVM version
chooses a different register, the verifier error will mention that
register instead of R1, causing the test to fail.

You acknowledged the issue and said you would use a regex like
__msg("R{{[0-9]}} invalid mem access 'scalar'") to match the register
dynamically. However, the current code uses __msg("invalid mem access
'scalar'") without any register prefix.

The same pattern appears in stack_arg_release_ref,
stack_arg_stale_pkt_ptr, and stack_arg_null_propagation_fail. Should
these tests use the regex pattern to avoid compiler-dependent failures,
or be rewritten to make subprog_deref_arg6 a __naked function?

Reference:
https://lore.kernel.org/bpf/20260419172100.A89FEC2BCAF@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============4618373723716735901==--
