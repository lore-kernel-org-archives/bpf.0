Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C132FD1AA
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193225; cv=none; b=FBwsEl5GtUXfb/n8tYXsxTau7zTqKyZMRr5dlfO4ICTvr6VI5ByhwOdZ9gmEHox0XYV3/4/KcViwdEJReDvpikXVavCe+xcRD+0R7gbu0SgeCOQUKG1h6yAdDiqfO3mTLodwdiZLDI8dOqdLsZyZm4j32xRFJ8UHzaDAyRc9vFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193225; c=relaxed/simple;
	bh=SlDfy5C91wzXzlNZeQAHFIITWtbZaTlMYOFO371VqvI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rMYEFovMuQ5ZBkigbaxI5FCgQqScXSPlC896vhcvEzK1nw4OVuy3oZ4lIZVzhCT9rzC7ereLoFJN9EUgYvr7nvYxWUnjZrvFt0UU0JRgYX914RqrBo10ozZFEKziImMiI9Q7Q6moh+dhvO/Y2dx7GfD/wfP9J3hEyOAXhOqd4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtJeV9y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtJeV9y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED2A1F000E9;
	Thu, 20 Aug 2026 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787193224;
	bh=gtViPOAbNA/VYyOkdFzWL6uGxTotB4edTyG9T5iCeSY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VtJeV9y1XAblxyUX1SNdmhsQZtl9MVd1Hr1ZAE00wLyW0aQhz1tjvf0/CcKIRcRug
	 9bCjmuoIoQNoLQALCDGEdWhBO7a4lLIkoL5yYv/X7qQKTMziaRvpz6AyZyK9LuqMhT
	 UXAH1bYGs69DXXCd/u+I/BJ9EgiTBIVVLWkAHY71QPmrr4zYJi5BA+X5l/wjCPwGr6
	 TxK1sGlioshy9XYQ7U6/PPa7Av/YhWcyaJEFiMUQWMMIS7TH6baUiBYXnhhflcP4gp
	 RE+HxyNJaen3LrktQ6kUg4wQVD/wgMkfGYbef1lQRJPajNzU/ayMEIx3YcHJuw7MV6
	 CF2BI/xv+WX+g==
Content-Type: multipart/mixed; boundary="===============8216862283695747858=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e5c5b7f96f565f2f4746e836bd55e32f608d5774bf82df958669dab56ad8a04@mail.kernel.org>
In-Reply-To: <20260820013925.2515018-1-yonghong.song@linux.dev>
References: <20260820013925.2515018-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Track linked scalars across a "rX <<= 32; rX >>= 32" zero extension
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 02:33:43 +0000 (UTC)

--===============8216862283695747858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e421ea2b80c3..0fded097505e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15584,6 +15584,50 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +static bool linked_base_fits_u32(const struct bpf_reg_state *reg)
> +{
> +	if (reg->id & BPF_ADD_CONST32)
> +		return true;
> +	return reg_smin(reg) >= (s64)reg->delta &&
> +	       reg_smax(reg) <= (s64)U32_MAX + (s64)reg->delta;
> +}
> +
> +static bool is_shift32_insn(const struct bpf_insn *insn, u8 op)
> +{
> +	return insn->code == (BPF_ALU64 | op | BPF_K) && insn->off == 0 && insn->imm == 32;
> +}
> +
> +/* Handle "rX <<= 32; rX >>= 32", which zero extends the lower 32 bits. */
> +static bool is_zext_pair_lsh(struct bpf_verifier_env *env, struct bpf_insn *insn,
> +			     const struct bpf_reg_state *dst_reg)
> +{
> +	struct bpf_insn *next;
> +	int insn_idx = env->insn_idx;
> +
> +	if (!dst_reg->id || !is_shift32_insn(insn, BPF_LSH))
> +		return false;
> +	/* check_subprogs() guarantees a shift is never the last insn. */
> +	next = &env->prog->insnsi[insn_idx + 1];
> +	if (!is_shift32_insn(next, BPF_RSH) || next->dst_reg != insn->dst_reg)
> +		return false;
> +	/* Ensure the next insn has a single incoming edge. */
> +	return !bpf_is_prune_point(env, insn_idx + 1);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Is the comment accurate? In is_zext_pair_lsh(), the check
bpf_is_prune_point(env, insn_idx + 1) returns false when
env->insn_aux_data[idx].prune_point is not set, but not every merge point
gets that flag.

Looking at kernel/bpf/cfg.c, visit_gotox_insn() marks the gotox
instruction itself as a prune point, but marks each jump-table target with
mark_jmp_point() only, not mark_prune_point(). So an indirect-jump target
instruction can have many incoming edges (one per jump-table entry plus a
possible fall-through) while bpf_is_prune_point() returns false for it.

If such a target is the second shift of the pair, is_zext_pair_lsh()
would still return true even though the instruction has multiple incoming
edges.

The property actually being relied on appears to be "no verifier state is
checkpointed at insn_idx + 1", which does follow from
!bpf_is_prune_point(), since bpf_is_state_visited() in do_check() is
itself guarded by bpf_is_prune_point(). On an edge that arrives at the
second shift from somewhere other than the preceding first shift,
is_zext_pair_rsh() would fail its "env->prev_insn_idx != insn_idx - 1"
test and the id would be cleared as before.

Could the comment be reworded to state the actual invariant? For example:
"No state is checkpointed at insn_idx + 1, so the intermediate state
between the two shifts can never be pruned against."

> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32322608718
--===============8216862283695747858==--
