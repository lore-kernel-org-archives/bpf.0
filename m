Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48C38655C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989665; cv=none; b=k1Yh8eE3GncbNg1pkfc+AMlRX9JAzAVYT7nLKd+9J0lEOpvmqlNyBTU+R/KJDk0eV9BUl6awnpM5klVcUE0Cow1LBbemXR7piW3Oc9FJcTRDlArf1VCt9JKZoZySFbt+HKtoMlRMt25OF9AzdnhVK2UYi2/f8R5+wgihPM7rvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989665; c=relaxed/simple;
	bh=S2MIcANxmU184Ck6j61xWM6Wrd8y5Yftx+OOkCaOzNA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Nldr2CCcT5EF09KVus9NGTdfBqcWSQyjovvfR0uBmmfl/Wg1zpozrbpfm76XM0khVWllyQXwM1fDAAJtKRHCbONy7c7c0YXl4j3rDwq9G4/UoZ5foLbF+SINp08QY9vFptLl+D2aCPT/iCk6OhPwQvpHqMEDsE13H/hlKTf9fi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4Ywfn3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4Ywfn3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAC31F000FF;
	Wed,  9 Sep 2026 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989650;
	bh=vaXAAkEHffeyQEnHDTFiXKkwnTSR8QhnIrlDjcGFDvw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K4Ywfn3XBCERQL3gSbZ3XeiZddVCPL3HvAfBPoPxKgQrIJD2V6lxiRUE/qsBrJymg
	 ypHYBIzTHq/IxQ78EiQIi9E3PNmMbqPx3UGmoisTBVdbjfFQMLaWbsgM6ynG8lekt6
	 STwBHKRvPA1O1dyaxMMSenF9PtH31JE3ruLZFy2B7fxclrpFLrVyuP7CUxhCy+Yy64
	 JKYe0/stuAWsp3qzfQeznPRWvjnHwCq/ADukvdySiidF9G0CuqN3PC3tN7dxk8lvbP
	 kVM38JukQNy+oz5Qw8v2mvt3gjrMuVGE8vogCd4NFuOtcIy0uzYTv1zyFvQGpuCS0B
	 ROP0XJhJXv9Xg==
Content-Type: multipart/mixed; boundary="===============1197124412432829705=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf4cd1bdd358107b30b845dec987e4cf93ff63522eefd580854db28a8d2e66f9@mail.kernel.org>
In-Reply-To: <20260909204035.24289-3-daniel@iogearbox.net>
References: <20260909204035.24289-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 3/6] bpf: Cache the jump table of a subprogram during CFG discovery
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:34:09 +0000 (UTC)

--===============1197124412432829705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 04bb8f71cabe..301a47d2b272 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -805,6 +805,7 @@ struct bpf_subprog_info {
>  	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
>  	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
>  	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
> +	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
>  	u16 stack_depth; /* max. stack depth used by this function */
>  	u16 stack_extra;
>  	u32 insns_total;
> @@ -978,6 +979,7 @@ struct bpf_verifier_env {
>  		/* current position in the insn_postorder vector */
>  		int cur_postorder;
>  		u32 gotox_edges;
> +		bool subprog_jts_ready;
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index e9910228da58..8aee94689229 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> @@ -286,15 +286,17 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
>  }
>
>  /*
> - * Find and collect all maps which fit in the subprog. Return the result as one
> - * combined jump table in jt->items (allocated with kvcalloc)
> + * Collect the jump table of every subprogram that has one, as the combined
> + * table of all maps whose targets land inside that subprogram. All gotox
> + * instructions of a subprogram share the same table, so this is done in a
> + * single pass over the maps rather than once per gotox.
>   */
> -static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
> -					  int subprog_start, int subprog_end)
> +static int compute_subprog_jts(struct bpf_verifier_env *env)
>  {
> -	struct bpf_iarray *jt = NULL;
> +	struct bpf_subprog_info *subprog;
> +	struct bpf_iarray *jt, *jt_cur;
>  	struct bpf_map *map;
> -	struct bpf_iarray *jt_cur;
> +	u32 old_cnt;
>  	int i;
>
>  	for (i = 0; i < env->insn_array_map_cnt; i++) {
> @@ -305,40 +307,47 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>  		map = env->insn_array_maps[i];
>
>  		jt_cur = jt_from_map(map);
> -		if (IS_ERR(jt_cur)) {
> -			kvfree(jt);
> -			return jt_cur;
> +		if (IS_ERR(jt_cur))
> +			return PTR_ERR(jt_cur);
> +
> +		subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);
> +		if (!subprog) {
> +			kvfree(jt_cur);
> +			continue;
>  		}

Is the block comment above accurate? It states the table is "all maps
whose targets land inside that subprogram", but the code attributes a map
by its first entry only:

    subprog = bpf_find_containing_subprog(env, jt_cur->items[0]);

jt_from_map() sorts and de-duplicates, so items[0] is the map's lowest
target. A map whose lowest target is inside subprogram S but whose
remaining targets reach past (subprog + 1)->start is still merged into
S's table, so S->jt can contain targets that do not land inside S.

This case is not filtered here. The range check that rejects such
programs is in create_jt():

    for (i = 0; i < jt->cnt; i++)
            if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end)
                    ... return ERR_PTR(-EINVAL);

The old code's comment explained why testing a single element is
sufficient: "This is enough to check one element. The full table is
checked to fit inside the subprog later in create_jt()". The comment
above the loop in create_jt() said "Check that the every element of the
jump table fits within the given subprogram". Both are now deleted.

After the patch the one-element rationale appears nowhere in the file,
while the new comment asserts a stronger invariant than the code provides.

Would it be more accurate to say "all maps whose first target lands inside
that subprogram" and keep a note that the full table is validated later in
create_jt()?

In the follow-up commit e47f26bec05f ("bpf: Reject indirect jumps that
leave their subprogram"), the code is changed to match what this comment
already claims. The mismatch exists only at this commit.

> -		/*
> -		 * This is enough to check one element. The full table is
> -		 * checked to fit inside the subprog later in create_jt()
> -		 */
> -		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
> -			u32 old_cnt = jt ? jt->cnt : 0;
> -			jt = bpf_iarray_realloc(jt, old_cnt + jt_cur->cnt);
> -			if (!jt) {
> -				kvfree(jt_cur);
> -				return ERR_PTR(-ENOMEM);
> -			}
> -			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
> +		old_cnt = subprog->jt ? subprog->jt->cnt : 0;
> +		jt = bpf_iarray_realloc(subprog->jt, old_cnt + jt_cur->cnt);
> +		if (!jt) {
> +			subprog->jt = NULL;
> +			kvfree(jt_cur);
> +			return -ENOMEM;
>  		}
> +		memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
> +		subprog->jt = jt;
>
>  		kvfree(jt_cur);
>  	}

[ ... ]

> @@ -693,6 +719,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
>  	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
>
>  err_free:
> +	free_subprog_jts(env);
>  	kvfree(insn_state);
>  	kvfree(insn_stack);
>  	env->cfg.insn_state = env->cfg.insn_stack = NULL;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404843294
--===============1197124412432829705==--
