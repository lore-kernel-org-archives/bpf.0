Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724D41CB5A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124835; cv=none; b=kjWQ83eNgOXjDP8tBp/L3Ms58jx4q6Gelv7suzh+lUd8bWlHEFIKt4kopUQ6rveWK4Cq0sFqpepTA3z4oAYIBl8FmNaNop2W+13oSSMtqRSLchy0a+Jkj5JeiVSuufpdBZ3Nd6xSTrVBPbDQSqjtFzvEWudxNlOQDLHVmscnFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124835; c=relaxed/simple;
	bh=o6KlfgtFWd/r3RFQYz5ZYog+GBQZYrQzpY9Ar61QkIg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kS7ZOHjw6vb6AJV/zIUMvGtAF22js1a3SghbHkY6W7E1oeQ4w4sBv1wF2s0yoKpXMmUyZVrUHcNwc4UFBADzzAj2iYcumOOTz9Hao0l3kOGOEK2z0PcloiBe5dgRoMIlIal44R4GJESvawo7D/CgPgHPrDXpIoLd0SYrwyJ4twU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjqLazw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjqLazw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C321F000FF;
	Sun,  4 Oct 2026 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791124834;
	bh=rs0rB0U0+stFfyG2+n54WozavnK20/+jMqOXuFGcMlU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RjqLazw9McPcqR283rA6T40nFU6jVD8EXj2yRdOLy2OmE1TYwqQ8mpK2qd0dGqZxy
	 RSI+Jo9Z6UGAeG/UTOGho1E8fAI9Yci87hTtcPoc3+RYvAas+rl9Tmdo3oM+LIfAk6
	 A1tfrNoyx6rCjtWeY6mL/BGFaxpHxzyLF0QZPBzvErt4IXtM2u7d530A+Gtv4mAitS
	 GXvL3vsqM/Fy4NUazL8dlHE49Kr8k/Kny1A05nD3XplWesiUiuLQzqRq4J29qD/7qh
	 P+tL7c3DfWAn8/h5sAwjE/a/jytQqT4S1EsyP9L38rEbY0oGVvRShW+nxDBSARtSuH
	 qVxGJKH4aPRtQ==
Content-Type: multipart/mixed; boundary="===============4486633613493486357=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e670403790a8fb64a6c541301c57686984e4f72fb46745282122c43caed4800@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-19-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-19-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 19/43] bpf: compute loop hierarchy
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:40:32 +0000 (UTC)

--===============4486633613493486357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: compute loop hierarchy

TL;DR: Nits only: insn_aux_data->loop_entry is written but never read, so
mark_entry() could be dropped; is_cond_jmp_insn() could reuse existing
helpers.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> index 0a9e10edca87..545cee0fd956 100644
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c
> @@ -154,3 +154,434 @@ int bpf_compute_idoms(struct bpf_verifier_env *env)

[ ... ]

> +static void mark_entry(struct bpf_verifier_env *env, int s)
> +{
> +	env->insn_aux_data[s].loop_entry = true;
> +}

This isn't a bug, but is insn_aux_data->loop_entry meant to have a reader
later?

mark_entry() is the only writer of the bit, and it is called from
mark_as_header() and from compute_loops_in_subprog().  Nothing in this
patch, or in the rest of the series, reads loop_entry.

If there is no reader planned, could mark_entry() and the bit be dropped
until something needs them?

[ ... ]

> +static bool is_cond_jmp_insn(struct bpf_insn *insn)
> +{
> +	u8 class = BPF_CLASS(insn->code);
> +	u8 opcode = BPF_OP(insn->code);
> +
> +	if (class != BPF_JMP && class != BPF_JMP32)
> +		return false;
> +
> +	switch (opcode) {
> +	case BPF_JEQ:
> +	case BPF_JGE:
[ ... ]
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

This isn't a bug, but could is_cond_jmp_insn() be replaced with
bpf_insn_is_cond_jump(insn->code) && !bpf_is_may_goto_insn(insn), as
bpf_prune_dead_branches() does in const_fold.c?

[ ... ]

> +			 * case E: 's' is explored, not in current DFS path,
> +			 * its innermost loop header is not in current DFS path,
> +			 * hence 's' is another entry into the same loop.
> +			 */
> +			h = aux[s].loop_header;
> +			mark_irreducible(env, h);
> +			mark_entry(env, s);

This isn't a bug, but the same question as for mark_entry() above applies
to this call: is there a planned reader for insn_aux_data->loop_entry, or
could the mark_entry(env, s) call be dropped along with the bit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============4486633613493486357==--
