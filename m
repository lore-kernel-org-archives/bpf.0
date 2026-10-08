Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CC47206A
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449834; cv=none; b=D99Mr1iI95l4bmeWzoOXWIYeRogfVfYdLZNvMtfCETdrZ7D2jk/tPrLF5YDAwfBCCBSgkK34kD9S0oVHRcDdBzeKoii4vcZgmur+0f0w8MLu8mIKPxPYIrgRr1d6Ulw2B155hnSRoFqAj5udyNypzeTXByJjq5pLFkrgg55UKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449834; c=relaxed/simple;
	bh=lxOODbgF9uc/mBMKS3gNwoNMmtEUVic+0Vv8Dm/IBkE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uLzsggw2IkCQgDhDnxLLqYqDFWlzlVGbvltjAhRSlQD7hZJf1BIjA91pukXu4PhBKTKkU9zLQqrRhvC6wvQpU1OKoof124mOj2mkuLH40vx65m8JbQgzQRcdpfKyCokSURhu9VvgjH7Yd1I3nReO6T6EtTO/wqe3Ik7noko7TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPeQeEam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPeQeEam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FCE1F00893;
	Thu,  8 Oct 2026 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791449832;
	bh=MSE2/j9VOUqT3Wty6j2Rl7U8BdMbUG0xOhwVXU6R1ro=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MPeQeEamIV8TBEFioTSc0do3q5lcRLkKnX2Pcvd7EteTmaURuSMt5mseTki4AwgnU
	 qi7yRNSx0I1p6Cvo39qP/YwIv0e1+obat0+aWhPN+i21CetRfnPjQ9W1LXvybB1Rfe
	 hRwR8Bz0gjiugZOjDYxN1n/FS9o7JKF8M3xy8G2QXTKv+cDfy53UVl+d/yQ9stCpM/
	 sRwxdKn5NLKhF92w9b02xrDVCgjz/z+cezzRqCt6OVNF1WJLdYSnRsntYJDjJRJkrt
	 DEywUgEQ2swpy02Pj7oYL/kCabwNw7wMBEqUMg5sHClgISamisv+S+k/W7x6L7kEAM
	 R9Jz2p+Eb7xxw==
Content-Type: multipart/mixed; boundary="===============3506001643303004957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86f392fa0a39a0734d7b9264127865d733789042fe70a29725aa7a37aaa03a45@mail.kernel.org>
In-Reply-To: <20261008075035.2998664-1-yonghong.song@linux.dev>
References: <20261008075035.2998664-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v9 07/23] bpf: Verify an unwind through landing pads and epilogues
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 08:57:11 +0000 (UTC)

--===============3506001643303004957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Verify an unwind through landing pads and epilogues

TL;DR: In backtrack_insn(), if a landing pad directly follows a global call,
the normal return may take the new pad branch, which doesn't clear R2, so a
precise R2 could trigger verifier_bug() and -EFAULT.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c

[ ... ]

> @@ -434,6 +459,24 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  					return -EFAULT;
>  			}
>
> +			if (bpf_exc_pad_of_call(env, idx) == subseq_idx) {
> +				/*
> +				 * We came from the landing pad of a call to a
> +				 * global subprog, branched to from the state
> +				 * the call returns in: as on its return, no
> +				 * frame was entered here. The call clobbered
> +				 * r0-r5; r6-r9 and the stack are the caller's
> +				 * own and keep going back from here.
> +				 */
> +				bt_clear_reg(bt, BPF_REG_0);
> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> +					verifier_bug(env, "landing pad unexpected regs %x",
> +						     bt_reg_mask(bt));
> +					return -EFAULT;
> +				}
> +				return 0;
> +			}
> +
>  			/* callx calls static subprogs only */
>  			if (subprog >= 0 && bpf_subprog_is_global(env, subprog)) {
>  				/* check that jump history doesn't have any

[ ... ]

Is comparing subseq_idx with the call's pad enough to tell that the walk
came over the pad edge?

bpf_exc_check_info() accepts a record [c, c+1) -> c+1, because its pad check
treats end_off as exclusive.  With that layout the pad is the insn right
after the call:

    c:     call global_subprog
    c + 1: pad

In that case the normal return of the global call also has subseq_idx ==
idx + 1 == pad, so it now goes through the new pad branch instead of the
global call branch below it.

The pad branch clears only BPF_REG_0, while the global call branch also
clears R2.  For a global subprog that returns in the R0:R2 pair
(bpf_ret_reg_pair()), the normal return path really does define R2 as a
scalar.

If precision on R2 reaches the call insn over that edge, for example from
propagate_precision() when the path is pruned against a checkpoint where R2
is precise, the pad branch finds R2 still set in the mask:

    bt_clear_reg(bt, BPF_REG_0);
    if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
        verifier_bug(env, "landing pad unexpected regs %x", ...);
        return -EFAULT;
    }

That fires verifier_bug(), which is a WARN_ONCE under CONFIG_DEBUG_KERNEL
plus -EFAULT, rather than handling the edge as a normal global return as
happened before this patch.

Should the pad branch also clear R2, which is NOT_INIT on the real pad path
anyway, or should it apply only when subseq_idx != idx + 1?

I did not find a later patch in the series that touches backtrack_insn()
again to address this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645
--===============3506001643303004957==--
