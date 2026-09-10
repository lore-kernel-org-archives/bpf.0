Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31B475335
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040165; cv=none; b=rH9qU8Bv2p/swCUxOSGFNC9BXqiq1RXjrVEDHu+qFzWA16dH1AeTTARI8aS6mM4mnmwja1B9Pgub13n6xHKDE/rgl5tGtcOpGm13sLEe63+6Luo+l3kTJENYwsyiJyx4BiYG2h4FJvcxpCr++oK4/J0Miv0rJ6TsgWzpMGo2H3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040165; c=relaxed/simple;
	bh=krEy/0haNnQLGcupVxFd4sev0bS7JHL0Lezr+cD4nEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfd5SlPV+QA/jlDPQJDKSDULRXW5rsyk51Ldjox1CG3rEMyemBGjwq0F9pTzx7x7+genYKT8yWtR0Y1r2E1JlFyVcieGyVbBgSPLXrt2pJPW36i9hUSXzuNWPzme5Qr7Qh7Gjr7KihALCv8dD4Py8wJGIBmlSjlGKvYa90Xtr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZKsoDfH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZKsoDfH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso5009498f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040162; x=1789644962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HUf/Z4rleXhGFvSuUb5BzWOyuggvNV2U1MnsWLGrW9U=;
        b=lZKsoDfHyYY85PBhoEFRLimxh1jCd/HYU0RVsgK+gx7kZ75S4RqrMlJeWtDcdQ/4lU
         +ZMyNOfTT67/I/xmtXJZVCpee7TNHMH0X6NQSg4OJZcwBlTERurZ3M9LQWp42hE3WeZB
         h97/7twRMzZt9dx0kgL1synIYOsr9YDtj2K7aC6fBAekPnnyCVbqK3l6/BUZPed6d+hf
         XaQGOzZlVmfr6yTUgo8U9gTcUijPHF3ChFvIEAcMOp3GW6x0oS2DYGpg60Am9NM5hXmd
         kF3Z4OR4UXQbIVavKnjbfkJK0W0cyh81FM00EHWPNoDxg+K5CPMSxmfGONOUOn3V/doW
         XURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040162; x=1789644962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HUf/Z4rleXhGFvSuUb5BzWOyuggvNV2U1MnsWLGrW9U=;
        b=O35ktaY8bMJH+r9KU205SA8T8Onjec7V98tA87XNBfK2wVMMeXo825UUQUD9zsQJ8J
         PYe3isYSi/WFqpp4COJU1F3FKbx4EE6ZEoHNDaTxnXgEn0ITvOQcZnh5f4dTrXD5CZ5e
         H6nClh71boWUuUbNpASfvgiS/GL3mt74E+Zn6vOqKMBA4DCegVh6xR8waastXi2zW6lw
         jDPlaRLZcRi4NQV5DahK5An3k6bPuEAzwiPgScw5tp0A1r8b9eOgbE8BNUv/UHZhfsvJ
         R5SWLjOcLc9eF7mZM8z4WKodWXoAfPVwuZdUFpYFFdRcqjmSDv/GAOTQs+WZPv8UBbte
         9DOg==
X-Forwarded-Encrypted: i=1; AKwUvBzfXuJl45NoqpX2jQiQ7az38zCZ35G4IpL5zw1Oq4HDPq5pCX23p746msuZTEO63n4qisY=@vger.kernel.org
X-Gm-Message-State: AFuF++nObLaambSBrre9kZKz1nXIXSSRvn2G+v6fggB+q5bzvA62dD4F
	Kb0yqosw7oPPZMuRvr+d+8WEQJ68ARgLySEyCAjO8UVG5JMSnzX24Unw
X-Gm-Gg: AYBFou1qMvmciEcF9528W8cpJ6KGf6UoEk+tsqicmxd8nMyF5zKFTkNdoRaoPEBrQaG
	moLbapp8jobAeUXGaRct7gz7k8SFBcEtVgWKINcjOjU4T0vM9XE6pG0gxyOMnBtQUiAuB2OJx4E
	2EKe4kRWuYGO04gMGFYO/emWWog3/3iTi3oEEW0qpUQDeuHnE30YE+mOGEbj7ZjfpVYnJXxt0x6
	1uy6HSf2GRj6HpuIKmH6WbcWNhZ5wKfzPfTIAXy0YWLRFOTaLnqR0VFhpiOgeLPycwL22+ndj5d
	V4RfNM7/PXFDkFeYeWVbQ9Rs1Mu8vMCC2kYaENQu2Z7mdPdOgplfH2QBIjrGi3ELBytN9ZehHxQ
	MugK4wJwVLCC0zbDihM2MvlRPMMYeqAEfn77hvLMv9D/XiSIc1Cm23Cu6Gq0VSz8PWwRB2jGYMe
	CYmMazl3p/FYrwl4eGi6QwbNBtPtYh8aznvW51QvqG1fA1j3S+fl4mOgjAZjfo5X2HJb3RgZ5DC
	OYDc9iPad7c8lSdur0=
X-Received: by 2002:a05:600c:4f43:b0:49c:fc6e:a3d9 with SMTP id 5b1f17b1804b1-49cfc6ea7b4mr405126425e9.24.1789040161334;
        Thu, 10 Sep 2026 04:36:01 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fb40e1sm126389115e9.2.2026.09.10.04.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:36:00 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:46:39 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/6] bpf: Cache the jump table of a subprogram during
 CFG discovery
Message-ID: <aqKYn7UGWJxjgNDX@mail.gmail.com>
References: <20260909204035.24289-1-daniel@iogearbox.net>
 <20260909204035.24289-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909204035.24289-3-daniel@iogearbox.net>

On 26/09/09 10:40PM, Daniel Borkmann wrote:
> create_jt() builds the jump table of the subprogram containing a gotox by
> copying out and sorting every insn_array map of the program, and it does
> so once per gotox instruction. The cost is therefore the number of gotox
> instructions times the number of entries in all of the maps. A program of
> 4003 instructions with 2000 gotox and one 500k entry map holding two
> distinct targets has 4000 indirect jump edges, 0.4% of the limit, and
> takes 351s to be rejected. The map costs next to nothing to prepare, as
> an unset entry is already a valid target. At the insn limit, with a single
> 1M entry map, the same shape extrapolates to 43 hours.
> 
> All gotox instructions of a subprogram share the same jump table, so
> build the table of every subprogram in a single pass over the maps and
> hand each gotox a copy of it. Instruction aux data owns its jump table,
> see bpf_clear_insn_aux_data(), hence the copy; the copies add up to the
> number of indirect jump edges, which visit_gotox_insn() already bounds.
> 
> check_cfg() is then linear in the number of map entries plus the number
> of indirect jump edges, so what still scales now with the program is what
> BPF_MAX_GOTOX_EDGES bounds:
> 
>   gotox  map entries  edges     before     after
>   ----------------------------------------------
>     500       250000   1000     36.55s     0.07s
>    1000       250000   2000     75.65s     0.07s
>    2000       250000   4000    153.44s     0.07s
>    2000       125000   4000     69.61s     0.04s
>    2000       500000   4000    351.27s     0.15s
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/cfg.c             | 99 +++++++++++++++++++++++-------------
>  2 files changed, 65 insertions(+), 36 deletions(-)
> 
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
>  
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
>  
> -	if (!jt) {
> -		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
> -		bpf_diag_program_structure(
> -			env, subprog_start, "missing jump table",
> -			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
> -			"No jump table was found for the subprogram that starts at instruction %u.",
> -			subprog_start);
> -		return ERR_PTR(-EINVAL);
> +	for (i = 0; i < env->subprog_cnt; i++) {
> +		jt = env->subprog_info[i].jt;
> +		if (jt)
> +			jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
>  	}
>  
> -	jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
> -	return jt;
> +	env->cfg.subprog_jts_ready = true;
> +	return 0;
> +}
> +
> +static void free_subprog_jts(struct bpf_verifier_env *env)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
> +		kvfree(env->subprog_info[i].jt);
> +		env->subprog_info[i].jt = NULL;
> +	}
> +	env->cfg.subprog_jts_ready = false;
>  }
>  
>  static struct bpf_iarray *
> @@ -347,16 +356,33 @@ create_jt(int t, struct bpf_verifier_env *env)
>  	struct bpf_subprog_info *subprog;
>  	int subprog_start, subprog_end;
>  	struct bpf_iarray *jt;
> -	int i;
> +	int i, err;
> +
> +	if (!env->cfg.subprog_jts_ready) {
> +		err = compute_subprog_jts(env);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
>  
>  	subprog = bpf_find_containing_subprog(env, t);
>  	subprog_start = subprog->start;
>  	subprog_end = (subprog + 1)->start;
> -	jt = jt_from_subprog(env, subprog_start, subprog_end);
> -	if (IS_ERR(jt))
> -		return jt;
>  
> -	/* Check that the every element of the jump table fits within the given subprogram */
> +	if (!subprog->jt) {
> +		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
> +		bpf_diag_program_structure(
> +			env, subprog_start, "missing jump table",
> +			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
> +			"No jump table was found for the subprogram that starts at instruction %u.",
> +			subprog_start);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	jt = bpf_iarray_realloc(NULL, subprog->jt->cnt);
> +	if (!jt)
> +		return ERR_PTR(-ENOMEM);
> +	memcpy(jt->items, subprog->jt->items, subprog->jt->cnt << 2);
> +
>  	for (i = 0; i < jt->cnt; i++) {
>  		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
>  			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
> @@ -693,6 +719,7 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
>  	env->prog->aux->might_sleep = env->subprog_info[0].might_sleep;
>  
>  err_free:
> +	free_subprog_jts(env);
>  	kvfree(insn_state);
>  	kvfree(insn_stack);
>  	env->cfg.insn_state = env->cfg.insn_stack = NULL;
> -- 
> 2.43.0
> 

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

