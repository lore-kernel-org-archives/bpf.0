Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FD381EA0
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409963; cv=none; b=Y+RzhsXx/bCHvozsws5krDj47OXuKgbJT+xPsLbcPmqHsljoCKVzDs9QaBYC3TBJnzmA8MrNmn+43nh6LGvHGNcN5KpaJs97MOlwZH+uZq378MgdaYGEH8jOXqD0BmIOIJtTB7x0NDiOdOsoDRRRM+PNZulBM5+hD6FShRdoUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409963; c=relaxed/simple;
	bh=hy56b/PtBkVhFLI5LKf4pDyM4C4J7GZqaJ9coNE0ZJ8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OuMzyytfOW3uj14fI9fWw4NLhImeQ28X6YYxPDrfguM2PwkZAH2y9+Za61EoB0OLRGKHD1eYEksqDCSP2xf7pR7HwnPX2UeUkfaLcSBwOV1uHo0SXAnHlbdNuW/riP9keibwclSn4iO76KWEC6Ur9iYPcZmR+TeBB+UR0E+d2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoUbN/Dy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoUbN/Dy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74AD1F000FF;
	Mon, 14 Sep 2026 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409961;
	bh=2Z/i5jIL2ut5BDBXuBs21UtQJqQduyVSCwyc7fgyh2o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PoUbN/DyOEdQRBM5EDRHvNXVMe+sjop91NT6bI+16dkO/bB6dS693dBo4ZtJeF6LU
	 jsMnZgXLilmFOSTHiDQyFNXOk6xz5vWiw6nkRB8CcYdnwxrPXJbNYsId83r11RGdv2
	 Q1SeJBezk3s/e9logceQtCDkbRkTFCVnwKnYYK4TsNxkfKicFqvFYVfrrE9yGTO2HN
	 Q202Ke09v3AB7NwoBdnDBPikLUAAxYqm/a7NP0932jxWNgTwYc2HRR/Pw1jYOos3cI
	 ajKy332p4gwR7Rwh5/NoZE9546U17RaC9tsPFYDHQIswVe8M5udUIlEgA8SDd1wIBp
	 S3AL4Ha7QodSg==
Content-Type: multipart/mixed; boundary="===============2896433261446549126=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bd3031fea55606071e3d51cca06e09c51d419bd22b479547f66d819dd5c52038@mail.kernel.org>
In-Reply-To: <20260914170326.249953-3-daniel@iogearbox.net>
References: <20260914170326.249953-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 02/11] bpf: Bound the number of indirect jump edges in a program
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:20 +0000 (UTC)

--===============2896433261446549126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36b65797877d0..04bb8f71cabe3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -977,6 +977,7 @@ struct bpf_verifier_env {
>  		int cur_stack;
>  		/* current position in the insn_postorder vector */
>  		int cur_postorder;
> +		u32 gotox_edges;
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 5cfd02c42afd5..df4513e71c80a 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -9,6 +9,8 @@
>
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>
> +#define BPF_MAX_GOTOX_EDGES	BPF_COMPLEXITY_LIMIT_INSNS
> +
>  /* non-recursive DFS pseudo code
>   * 1  procedure DFS-iterative(G,v):
>   * 2      label v as discovered
> @@ -388,6 +390,18 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
>  			return PTR_ERR(jt);
>
>  		env->insn_aux_data[t].jt = jt;
> +
> +		if (check_add_overflow(env->cfg.gotox_edges, jt->cnt,
> +				       &env->cfg.gotox_edges) ||
> +		    env->cfg.gotox_edges > BPF_MAX_GOTOX_EDGES) {
> +			verbose(env, "number of indirect jump edges in the program exceeds %u\n",
> +				BPF_MAX_GOTOX_EDGES);
> +			bpf_diag_program_structure(env, t, "too many indirect jump edges",
> +				"Reduce the number of indirect jumps, or the number of distinct targets they can reach.",
> +				"The program has more than %u indirect jump edges in total, counted over every gotox instruction.",
> +				BPF_MAX_GOTOX_EDGES);
> +			return -E2BIG;
> +		}
>  	}
>
>  	mark_prune_point(env, t);

Does this bound prevent the load-time DoS the commit message describes?

The accounting itself is correct: the counter increments only inside the
if (!jt) block, so each gotox contributes jt->cnt exactly once, and the
counter is program-wide across both walk_cfg passes.

However, gotox_edges counts the CFG edges added, not the work that
check_cfg() performs. The expensive operations happen before this check:

  visit_gotox_insn() -> create_jt() -> jt_from_subprog()

jt_from_subprog() loops over every insn_array map in the program, and
for each map it allocates map->max_entries u32s and calls
bpf_copy_insn_array_uniq(), which does one map_lookup_elem() per entry
and then sorts them. This runs once per gotox instruction.

The edges added per gotox are only the distinct targets that survive the
sort and dedup, which can be 1 or 2 no matter how large the maps are.

So the cost is O(gotox_count * total_map_entries * log) while the limit
constrains gotox_count * distinct_targets. A program can sit at a small
fraction of BPF_MAX_GOTOX_EDGES and still take arbitrarily long to reject.

The commit message states "1024 such gotox are already ~1e6 edges and
about 4s of CPU to load" and "Progs with real switch statements are
orders of magnitude below this", which reads as if the 1e6-edge bound
caps load time in the seconds range. It does not.

This is confirmed by the next patch in the series, b94c1f057586
("bpf: Cache the jump table of a subprogram during CFG discovery"),
which measures with this bound already applied: "A program of 4003
instructions with 2000 gotox and one 500k entry map holding two distinct
targets has 4000 indirect jump edges, 0.4% of the limit, and takes 343s
to be rejected. [...] At the insn limit, with a single 1M entry map, the
same shape extrapolates to 41 hours." That patch carries the edge
accounting over verbatim and instead builds each subprogram's jump table
once, which makes check_cfg linear.

For the unprivileged load path, bpf_check() holds bpf_verifier_lock, so
a single such program stalls all other non-privileged program loads for
the duration.

Given the Fixes: tag and Reported-by:, should the commit message clarify
that this patch bounds the edge count only, and that the per-gotox
jump-table construction cost is addressed separately in the next patch?
Otherwise the series might be read as closing the DoS at this commit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============2896433261446549126==--
