Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385669;
	b=Zyi/aHT9S2tBX8L5bBcL4CYukWQvd2dmvP+B7T2VNI+l3N5C7cGiO/3UcxxKzEWEY8xR
	 P/w0uCycNaRvIfqeBQLhxBkWTS8PJ/fUEmeke9DGjl7yYueYDVAXvHxzjJyUQ+JU7LAPC
	 c/C5EXAo4s/OwN7EikozuGkI2Wog2AbE8RA+WCX9G8cPjE0fmkbn0kULeFBOvfI2muRxL
	 QnRPRwbtQsHtGhZk51ECLg5LLWeMqB3YMvraozcq76LiSrdDBJasp4TOoI5whjoYUDpny
	 I2eSsBboRrrux0aoIdYRqJ4URHyTuRsA4zTj2UdI7QOhYyMBnb+W/BXX2qAJGDgHvjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385669;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wZUUMr2d/SFq1TdbKQcQSes1GXbfqO3Dn0rOFbmFhTI=;
	b=HfRg6p8eXEvDkVncojaSfm6u3b+OubDsm/u8ml0k7S4Am47vRYoaihoITyx4kYtEtCnS
	 CzbEEFrMPF6A217RJRuTPlIDSUsptAAttEH2HmmDXTyQzhLvOJQ5hUJ4ESzka8xlO+yH4
	 M33advwGSX3rE1BEk6y5TSyOPxuWJzb230HIJ9y1wflfu3hDW7t6y5oyzjDMGj+b6qGWr
	 1RmvaAmiJrapQ9qZcHcgn3rfFXwrxDjfUl0V4YpfmdRo5p1qgqJWB9utbxj+XNI6hZhkF
	 HulD3DKvoc0vvcYjVZl/e58yTKoiJ626jkk580lMyKWhIf05vGcGFOI3MEKSyWQgdkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awiukooX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1B60A2617
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awiukooX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF491F00A06;
	Wed, 11 Nov 2026 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385668;
	bh=wZUUMr2d/SFq1TdbKQcQSes1GXbfqO3Dn0rOFbmFhTI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=awiukooXekhpigaPbdun6YIiuIcS8tnNzx51g6y/QLrzbsDY07+otjYPfFaOibdfx
	 C5z/1B3bYJtx+X8bxlYgHE5Kj1lLzWoN8kcCEgEXXcCPNz0LZw5wuS2RhmeAxoysUl
	 o2sltpLQHnyAcaUNQNh9xgIU9UBAMndkOGh2lcSzIayEMIoAT+qlH4mOZ1CfghHBrm
	 0fKUiBZVj1sPr1Z55Sy6A83OSb+lAE/sx634hAKNAje7zIFVlf9xJd32Wqd1hoYJ9+
	 WNgkae/6tn3K9huVj1TDsI3nFSEfmvPmZ2j5D3IPEVGs0NoyeVY/kDQOoRrLoQGujp
	 5OyEBJMsgLQiQ==
Content-Type: multipart/mixed; boundary="===============2698898182789188549=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c4898c345148b7c5e3fe3c2cb6289d616218cf1a6113cda045a8cb5d61b6603f@mail.kernel.org>
In-Reply-To: <20261111051341.2800252-11-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-11-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/29] bpf: Detect a dead branch when a range and var_off don't overlap
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:27:48 +0000 (UTC)

--===============2698898182789188549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Detect a dead branch when a range and var_off don't overlap

TL;DR: Possible regression: when reg_is_empty() marks a branch dead, the
surviving branch loses its refined register bounds, so programs that loaded
before this patch may now be rejected by the verifier (hand-traced, not run).

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18916,7 +18946,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
>  	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
>  	 * TRUE branch will be taken.
>  	 */
> -	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
> +	if (reg_is_empty(&env->false_reg1) || reg_is_empty(&env->false_reg2))
>  		return 1;

When reg_is_empty() newly finds the fall-through branch dead, the jump
branch no longer gets the refinement it used to get.  Could this cause
programs that loaded before this patch to be rejected?

Before the patch, a fall-through whose refined range had no member of
var_off was not detected, both branches stayed live, and
check_cond_jmp_op() put the refined registers into the jump state:

    other_branch_regs[insn->dst_reg] = env->true_reg1;

With this patch simulate_both_branches_taken() returns 1 here before it
refines env->true_reg1.  With pred == 1, check_cond_jmp_op() only does
`*insn_idx += insn->off; return 0;`, so the jump target keeps the
unrefined dst_reg, which is strictly looser than the refined one.

The commit message example, extended (hand-traced, not run):

    0: call bpf_ktime_get_ns
    1: r0 <<= 3
    2: r0 += 5             // var_off=(0x5; ~0x7)
    3: if r0 s< -2 goto out
    4: if r0 s> 1 goto L   // fall-through s[-2, 1]: no member, now dead
    5: r0 = 0
    6: exit
    L: if r0 s> 100 goto out
       r1 = <map value, size > 100>; r1 += r0; r0 = *(u8 *)(r1 + 0)

Before the patch, at L r0 is env->true_reg1 = s[2, S64_MAX-2], and
reg_bounds_sync() (via __reg_bound_offset() knowing bit 63 is 0) turns
that into [5, S64_MAX-2].  The fall-through of "s> 100" is [5, 100] and
the access is accepted.

After the patch, at L r0 is still s[-2, S64_MAX-2] with the sign bit
unknown.  The fall-through of "s> 100" is s[-2, 100], which is not empty
(5 is a member), and since it crosses 0, __update_reg64_bounds() and
__reg_bound_offset() cannot tighten it.  The access then fails with "min
value is negative".

The same loss seems to happen for pred == 0: env->false_reg1 and
env->false_reg2 are refined and found live, then thrown away.  Would it
make sense to use the refined registers of the surviving branch when the
other branch is found empty?  That looks sound, since the refined state
then has the same members as the incoming one.

>  	/* Jump (TRUE) branch */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982641817
--===============2698898182789188549==--
