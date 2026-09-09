Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D23ED109
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990660; cv=none; b=FabDQ4gQTj4NSaIBXaMroMpYkFHlpnG68LxXnykO2HqS4+gZ3XucNbkwiEIQKSD8BZfp8jr+/zru//H9iwRwoPxRYuEFXE6egztQuKwQ/WvVKux+JXHS9R2T4gP8SJjpp2d4qTgNG7JgvnUjBShulynQPWcdjAyUr/7YEkCJ654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990660; c=relaxed/simple;
	bh=lFqjPwBnN9QL/aiFYcnoueehKPwCKbSHzUxH4BFoAB8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kSSl4rLBOC7dYp2sDQHV4c9jIK0cw6REjiOSdG9MbpF0L70BTcGyhbdcDTyxIn+QK0ZcaJtkckkLdvBe1AcMHUPzcR91JbTwsmswfQXrQWxFMzdqWJg77MHyGMtZSBPMxvjEbZ/FmZsrl4F1PYW1k3vT+1FNGRmomvcp7fxllmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce8+GTpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce8+GTpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285F61F000FF;
	Wed,  9 Sep 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990655;
	bh=icIJ9fD0NLlqxMdZlSq2TmFBzjxHiEkcA+vXEHOUg08=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ce8+GTpL98PxHuq0Arak1EkwroGQMgCsG0MGvJe/EV/aTAya8WCiC8Y4TZENHsdg6
	 ZFY7bJP8K8BeX7rOyhyPzQhQpzMpnBFWnhD80zOOnqOiFP0csEetEyExpFXhBAJTqu
	 5bSm8DrklnnPKJK/4p1PbJyO7gx7xgxH/PdSvRCemwyn1bfJ2trhO4GPIgntnK7R/R
	 NIoSFtdO32f6bmStgQw1Gm6EcNfMJD+OromgqZrKa6RGiA5xQ0r82buvTrX0QEClEs
	 v2o3o7ffBVk+qcB1i0YkSAUhhADuJdA0HvpBaXUdJykgIlDUsAY/Wex7vvixenxmXz
	 u70HpbJK1jOAQ==
Content-Type: multipart/mixed; boundary="===============4108503343457194960=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <166c425cf9f3333fca4bf3c4756db7516c2255a4dcdc608f70c34587ac2a2ded@mail.kernel.org>
In-Reply-To: <20260909204035.24289-4-daniel@iogearbox.net>
References: <20260909204035.24289-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 4/6] bpf: Reject indirect jumps that leave their subprogram
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,jamesburton@meta.com,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:50:55 +0000 (UTC)

--===============4108503343457194960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 301a47d2b272..baf2e17d7019 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -826,6 +826,7 @@ struct bpf_subprog_info {
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
>  	bool might_sleep: 1;
> +	bool jt_spans_subprogs: 1;
>  	u8 arg_cnt:4;
>
>  	enum priv_stack_mode priv_stack_mode;
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 8aee94689229..879587af8d08 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -315,6 +315,11 @@ static int compute_subprog_jts(struct bpf_verifier_env *env)
>  			kvfree(jt_cur);
>  			continue;
>  		}
> +		if (jt_cur->items[jt_cur->cnt - 1] >= (subprog + 1)->start) {
> +			subprog->jt_spans_subprogs = true;
> +			kvfree(jt_cur);
> +			continue;
> +		}
>
>  		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
>  		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
> @@ -346,6 +351,7 @@ static void free_subprog_jts(struct bpf_verifier_env *env)
>  	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
>  		kvfree(env->subprog_info[i].jt);
>  		env->subprog_info[i].jt = NULL;
> +		env->subprog_info[i].jt_spans_subprogs = false;
>  	}
>  	env->cfg.subprog_jts_ready = false;
>  }
> @@ -354,9 +360,8 @@ static struct bpf_iarray *
>  create_jt(int t, struct bpf_verifier_env *env)
>  {
>  	struct bpf_subprog_info *subprog;
> -	int subprog_start, subprog_end;
>  	struct bpf_iarray *jt;
> -	int i, err;
> +	int subprog_start, err;
>
>  	if (!env->cfg.subprog_jts_ready) {
>  		err = compute_subprog_jts(env);
> @@ -366,7 +371,17 @@ create_jt(int t, struct bpf_verifier_env *env)
>
>  	subprog = bpf_find_containing_subprog(env, t);
>  	subprog_start = subprog->start;
> -	subprog_end = (subprog + 1)->start;
> +
> +	if (subprog->jt_spans_subprogs) {
> +		verbose(env, "jump table of subprog starting at %u spans multiple subprogs\n",
> +			subprog_start);
> +		bpf_diag_program_structure(
> +			env, subprog_start, "jump table spans subprograms",
> +			"Keep every entry of a jump table inside one subprogram.",
> +			"A jump table found for the subprogram that starts at instruction %u reaches past its end at instruction %u.",
> +			subprog_start, (subprog + 1)->start);
> +		return ERR_PTR(-EINVAL);
> +	}

This isn't a bug, but since the cfg.c restructure appears to accept and
reject the same programs as before (the new items[jt_cur->cnt - 1] >=
(subprog + 1)->start test in compute_subprog_jts() accepts exactly the same
set of maps as the removed per-entry loop in create_jt()), would it be
cleaner to keep this Fixes-tagged patch to the check_indirect_jump() hunks
and send the jt_spans_subprogs refactor plus message rename as a separate
cleanup?

The functional security fix lives entirely in check_indirect_jump(), while
the cfg.c changes only modify the diagnostic wording and timing.

> [ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd2..45234e2fbee6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18165,11 +18165,56 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +/* 'jt' is sorted and free of duplicates, see sort_insn_array_uniq() */
> +static bool jt_contains(const struct bpf_iarray *jt, u32 target)
> +{
> +	int l = 0, r = jt->cnt - 1, m;
> +
> +	while (l <= r) {
> +		m = l + (r - l) / 2;
> +		if (jt->items[m] == target)
> +			return true;
> +		if (jt->items[m] < target)
> +			l = m + 1;
> +		else
> +			r = m - 1;
> +	}
> +	return false;
> +}
> +
> +static int reject_gotox_out_of_subprog(struct bpf_verifier_env *env, u32 target,
> +				       u32 subprog_start, u32 subprog_end)
> +{
> +	verbose(env, "indirect jump from insn %d to %u leaves the subprog [%u,%u)\n",
> +		     env->insn_idx, target, subprog_start, subprog_end);
> +	bpf_diag_program_structure(
> +		env, env->insn_idx, "indirect jump leaves subprogram",
> +		"Keep every reachable jump-table target inside the subprogram of the indirect jump.",
> +		"Instruction %d can jump indirectly to instruction %u, which is outside its own subprogram [%u,%u).",
> +		env->insn_idx, target, subprog_start, subprog_end);
> +	return -EINVAL;
> +}
> +
> +static int reject_gotox_without_cfg_edge(struct bpf_verifier_env *env, u32 target)
> +{
> +	verbose(env, "indirect jump from insn %d to %u is not in the jump table of the subprog\n",
> +		     env->insn_idx, target);
> +	bpf_diag_program_structure(
> +		env, env->insn_idx, "indirect jump target without CFG edge",
> +		"Resolve indirect jumps through a jump table whose entries all fall inside the subprogram of the jump.",
> +		"Instruction %d can jump indirectly to instruction %u, which is not part of the jump table of its subprogram.",
> +		env->insn_idx, target);
> +	return -EINVAL;
> +}
> +
>  /* gotox *dst_reg */
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
>  	struct bpf_verifier_state *other_branch;
> +	struct bpf_subprog_info *subprog;
> +	u32 subprog_start, subprog_end;
>  	struct bpf_reg_state *dst_reg;
> +	struct bpf_iarray *jt;
>  	struct bpf_map *map;
>  	u32 min_index, max_index;
>  	int err = 0;
> @@ -18212,6 +18257,26 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>
> +	subprog = bpf_find_containing_subprog(env, env->insn_idx);
> +	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", env->insn_idx))
> +		return -EFAULT;
> +	subprog_start = subprog->start;
> +	subprog_end = (subprog + 1)->start;
> +
> +	jt = env->insn_aux_data[env->insn_idx].jt;
> +	if (verifier_bug_if(!jt, env, "no jump table for insn %d", env->insn_idx))
> +		return -EFAULT;
> +
> +	for (i = 0; i < n; i++) {
> +		u32 target = env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >= subprog_end)
> +			return reject_gotox_out_of_subprog(env, target, subprog_start,
> +							   subprog_end);
> +		if (!jt_contains(jt, target))
> +			return reject_gotox_without_cfg_edge(env, target);
> +	}
> +
>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],

This isn't a bug, but would it be worth a sentence in the changelog about
the cfg.c side (the new jt_spans_subprogs bit and the renamed verifier
message), so readers of the log know why verifier_gotox.c's __msg had to
change?

The changelog describes only the kernel/bpf/verifier.c half of the diff,
but the patch also changes kernel/bpf/cfg.c: it moves the 'jump table
entry outside the subprog' detection from a per-entry loop in create_jt()
into a per-map maximum test in compute_subprog_jts(), and replaces the old
per-entry rejection with an early flag test in create_jt(). That rewrite
changes the user-visible verifier message from 'jump table for insn %d
points outside of the subprog [%u,%u]' to 'jump table of subprog starting
at %u spans multiple subprogs'.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717..3567b29e2378 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> @@ -318,7 +318,7 @@ __used static int test_subprog(void)
>  }
>
>  SEC("socket")
> -__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
> +__failure __msg("jump table of subprog starting at 0 spans multiple subprogs")
>  __naked void jump_table_outside_subprog(void)
>  {
>  	asm volatile ("						\


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404843294
--===============4108503343457194960==--
