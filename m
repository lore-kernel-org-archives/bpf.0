Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABA472F8A
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041574; cv=none; b=CjDIy7Vfsps2WpnmLqbTLO5FNQB8sViUBJ0JrXi0F3NzuS01TEIHZImC8KS/Lrfrah1J5difEWYnO4cwgsjeIP/P8uW/C0CBiH3YUafcnSCtLIkpk8W9tQfSZDw0Vl2RvxdukXT2Gf3b/jZTlrlYvcSbynK0cyjWc961k18xo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041574; c=relaxed/simple;
	bh=8GeEubeonBAiOkSUUEzfLFbZ7pPM49+lKevvAiqkOFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMVa1aD3Fn4TRoyCm+Am/kiHnpGf8N6HxGThXE6mGhtE/qCbrO2ZJeYcSlbeUWFGpTmlzmUHtl5KlQTfX4hJTkBEKf87iOCUTX9yEQfVzNBRD4RgQDXGZVo/LCVPl5ecexejNJdfAvXL0cDWKK0GQdgD6ph4fHbp5Ktknrg/QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxEnlkkY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxEnlkkY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso63080025e9.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789041571; x=1789646371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4O0lVSCuXn/M3lGULI1F0iE4xytGO5DLzvAq6NCbVQI=;
        b=JxEnlkkYOQPnEuV36sbBH7W2NgZW1rXzHGB9nkYirh87g3bZ2NMRlXrPoKwlB5HInJ
         tDcbxllYruwrNyNUPQ2m423rgOb2fgqsHoDlfkHi+lmYTbWKtPGnX4KG57d1aKalTd54
         6aEKVsjetUcEnZRyWO2u9DLiPQq8OS2Z2qVYZZggGBWyCbW9tiuDxigngvQibYO/B7f2
         A0Yw7qvpLmFMcRfSUjg+RE6C7NTgkCi2DPP5dDBlrjz9tKgYLrhUBmeVjxtWDUFAWBTB
         oFbnFu5l3bMed7k8+ldLP1uJFG3BSQoHDhGMxtjk3vKK57gML6O8mzDVo29Iu2oCIDsz
         IghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789041571; x=1789646371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4O0lVSCuXn/M3lGULI1F0iE4xytGO5DLzvAq6NCbVQI=;
        b=ZKzBq2rShTd4tDpoL+WZ1z9Nq3lBqZqaDZLNFZ77EpTIFFRpCZsUTx0k461vPos5t+
         Krt6gS+byO1rG8xuqEV0PoF084YBQ7U/WcsCA+WWUXVkuofBdxQj/WmQ/EhZ1gn+rOZX
         SL2TAlDPUgT6AedAL5+9XJv7gFcE2wmL0WR4k5Mt5rJvKi/M4CXWVVupFvFKDmzBET6o
         KAfwPmXZ6Fnv+H8/90WrZP3BlXqhKemfZDd94k001GZNJQLXP0ulVOPLahcRkRECEAQY
         HoZCsNwPL4KXsq6K/2V1R+SBQ0ixyZZ/JYu1+kjRisi7/nprKItIO88Ypkp1AIMaxKYY
         gVog==
X-Forwarded-Encrypted: i=1; AKwUvBxSMIvKXmPIpUQoZ6FG2qZEDwUE8B1uSnQ8IGfB0S3d6tADp0NapzST86w6pM/gphKb0g4=@vger.kernel.org
X-Gm-Message-State: AFuF++ly3MFzy2U9x1HWsEmqterMyScz17Z29FViKaupeVqOTo2q4CwX
	PJUILmUqUWt1LrSA2VrpWTBb9vVTs6wEAfQqDngKTfZjhHEHBYhRltKQ
X-Gm-Gg: AYBFou1i7zIt2EabZx6rSB9UcsqtDt5ODyQYLz5v12jQPjtdCdAqCy/PdbwO0Acnhwv
	cCbewSzcMIA6ccxCfJ2G3czYPfjZktNOtAiIyAnP+y9SYcC7Hn/uoGYCjel3+2aOKt4ImrEgLbJ
	vKc4yyGPrEpNrnY0h4EIAwYQJs6I1nZFrtImpR9h9XPzjgWPLXSY99UKmgjHSL/hWou8O1R698L
	Vs5DjnbNea6oeTfmOthlhJmy3m46t3Vaj6e42iyCNzIZMx3oaQ21V2slEEPcCgDwxF17sueAxlk
	PgmO0I9JYw6Bqg6WRLmRDyIr+kSgTXjkyghL3iNjgpoQldhIC2mtdCEL5fgBGCYE6fsHzuqwLOy
	2/AGyDX3uLRd0zZ0P+08rpJX5xz9lYQ3BeV/OW9NksHbSxy1RkFOJa9aVFFu4nlIRVWxvy10ZUA
	69JC+h6Qpb+1Xc4N+hZtFU0kJm4jDVv9jqhLy+a2KpjNYAdfgnaaEEtHvoMi+9WRq2a5GdIF/W1
	h4u3g8=
X-Received: by 2002:a05:600c:8b32:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49cf8244878mr493561635e9.11.1789041570883;
        Thu, 10 Sep 2026 04:59:30 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2a419sm78809615e9.7.2026.09.10.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:59:30 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:10:09 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg,
	bpf@vger.kernel.org, James Burton <jamesburton@meta.com>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf 4/6] bpf: Reject indirect jumps that leave their
 subprogram
Message-ID: <aqKeIVyaAXFXgT8Q@mail.gmail.com>
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204035.24289-4-daniel@iogearbox.net>

On 26/09/09 10:40PM, Daniel Borkmann wrote:
> The jump table of a subprog is collected in compute_subprog_jts() from the
> insn_array maps of the program, and a map is attributed to the subprog that
> contains its first entry. check_indirect_jump() instead resolves the targets
> from the map the gotox register actually points to, bounded only by the
> index range of that register, and never relates them back to the subprog
> of the gotox.
> 
> The two disagree, so bpf_insn_successors() reports a subset of the edges the
> BPF program can take and a gotox can enter a subprog the CFG never walked.
> The x86 epilogue there pops the callee saved registers of its own subprog and
> leaves the ones pushed by the current prologue unrestored, handing rbx, r13,
> r14 and r15 to the kernel with the values the BPF program left in them.

Why only x86? Maybe just remove the three lines above?

> 
> Close both ends in check_indirect_jump(): confine the resolved targets to the
> subprog of the gotox, and require each of them to be present in the jump table
> the CFG walked, that is, in the successor set bpf_insn_successors() reported
> for this instruction. The latter is the invariant that actually has to hold,
> the former is kept because it names the problem the BPF program has.
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Reported-by: James Burton <jamesburton@meta.com>
> Reported-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf_verifier.h                  |  1 +
>  kernel/bpf/cfg.c                              | 35 +++++-----
>  kernel/bpf/verifier.c                         | 65 +++++++++++++++++++
>  .../selftests/bpf/progs/verifier_gotox.c      |  2 +-
>  4 files changed, 85 insertions(+), 18 deletions(-)
> 
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
>  	if (!subprog->jt) {
>  		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
> @@ -383,20 +398,6 @@ create_jt(int t, struct bpf_verifier_env *env)
>  		return ERR_PTR(-ENOMEM);
>  	memcpy(jt->items, subprog->jt->items, subprog->jt->cnt << 2);
>  
> -	for (i = 0; i < jt->cnt; i++) {
> -		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
> -			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
> -					t, subprog_start, subprog_end);
> -			bpf_diag_program_structure(
> -				env, t, "jump table target out of range",
> -				"Keep every jump-table target inside the same subprogram.",
> -				"The jump table for instruction %d points outside subprogram range [%u,%u).",
> -				t, subprog_start, subprog_end);
> -			kvfree(jt);
> -			return ERR_PTR(-EINVAL);
> -		}
> -	}
> -
>  	return jt;
>  }
>  
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

The items[] is sorted. Is this enough to just check 0-th and (n-1)-th elements?

> +		u32 target = env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >= subprog_end)
> +			return reject_gotox_out_of_subprog(env, target, subprog_start,
> +							   subprog_end);
> +		if (!jt_contains(jt, target))
> +			return reject_gotox_without_cfg_edge(env, target);

Ah, I see, all elements should be checked because this check was added.

> +	}
> +
>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
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
> -- 
> 2.43.0

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
