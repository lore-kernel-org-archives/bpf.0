Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B5E212F89
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 03:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777174602; cv=none; b=mF2EsbzYiqR6yoggGiuPIuhBuI6JEvsiUMuH+gTB5Skw9PYnTkjhzpHfvlGwLzhTcZXlWY1Fow356HR49ZOdqvRun3vrh2LaWIL8MUlAvHUtdTVW/EG8Q6TYoOA+6Qr/ibVZ+6263ZSq9Sf60xcYY7wKNSOtApvNlXZATwFO4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777174602; c=relaxed/simple;
	bh=5/yqXs0X9iFvyVIxRpKEEfN9OIyF6kQqZS3hIyxP4+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0zoYShja+m/7s9OeuiIIj9FhSvyxqrwQw+iKwFcg1mpshBhY0zxvbXku9MohHiqzaVSmZXcsduO0t4N3+9foCMx77f+wRricuxISncCbMS6YoRL6bj6Qbwq3Shxzvz+mzkQ1yrZZYj3dvo5RdBtKQMFBxpppLcsgIC2X3vVCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kAXTa/tp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kAXTa/tp"
Message-ID: <89f588b9-0e0e-414f-8870-d79b2dc57a24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777174593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sk3G7hVkYAQqPtvPvb8Yi2jZOmwkB8FoFreyKJg+20=;
	b=kAXTa/tpk1AIjR2o7hPLwFp8qdzaDp/dby9fp/dgRDkaJN65E9o7VVW5F3ILnHDUY2UERQ
	TuE8Fj5TjErYSWBibVxdrtdP8iCa/mJb/qsqMUSMrEpOyAiiye0b0/oq7UPAK9R54NTjb3
	tvkugug+SHyahN7kwv36X3Q3gmRMw8U=
Date: Sun, 26 Apr 2026 11:36:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: use accessor functions for
 bpf_reg_state min/max fields
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com, bpf@vger.kernel.org
References: <20260424-cnums-everywhere-rfc-v1-v3-0-ca434b39a486@gmail.com>
 <20260424-cnums-everywhere-rfc-v1-v3-2-ca434b39a486@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260424-cnums-everywhere-rfc-v1-v3-2-ca434b39a486@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/4/25 06:52, Eduard Zingerman 写道:
> Replace direct access to bpf_reg_state->{smin,smax,umin,umax,
> s32_min,s32_max,u32_min,u32_max}_value with getter/setter inline
> functions, preparing for future switch to cnum-based internal
> representation.
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   drivers/net/ethernet/netronome/nfp/bpf/verifier.c |    8 +-
>   include/linux/bpf_verifier.h                      |   64 ++
>   kernel/bpf/log.c                                  |   24 +-
>   kernel/bpf/states.c                               |   16 +-
>   kernel/bpf/verifier.c                             | 1233 ++++++++++-----------
>   5 files changed, 678 insertions(+), 667 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
> index 70368fe7c510..1caa87da72b5 100644
> --- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
> +++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
> @@ -561,10 +561,10 @@ nfp_bpf_check_alu(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
>   	const struct bpf_reg_state *dreg =
>   		cur_regs(env) + meta->insn.dst_reg;
>   
> -	meta->umin_src = min(meta->umin_src, sreg->umin_value);
> -	meta->umax_src = max(meta->umax_src, sreg->umax_value);
> -	meta->umin_dst = min(meta->umin_dst, dreg->umin_value);
> -	meta->umax_dst = max(meta->umax_dst, dreg->umax_value);
> +	meta->umin_src = min(meta->umin_src, reg_umin(sreg));
> +	meta->umax_src = max(meta->umax_src, reg_umax(sreg));
> +	meta->umin_dst = min(meta->umin_dst, reg_umin(dreg));
> +	meta->umax_dst = max(meta->umax_dst, reg_umax(dreg));

Compilation failed with the following errors:
ERROR: modpost: "cnum64_umin" 
[drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
ERROR: modpost: "cnum64_umax" 
[drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!

These symbols are implemented in kernel/bpf/cnum.c, but were not 
exported for module use, so modpost fails for nfp.ko.

>   	/* NFP supports u16 and u32 multiplication.
>   	 *
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d5b4303315dd..bf3ffa56bbe5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -209,6 +209,70 @@ struct bpf_reg_state {
>   	bool precise;
>   };
>   
> +static inline s64 reg_smin(const struct bpf_reg_state *reg)
> +{
> +	return reg->smin_value;
> +}
> +
> +static inline s64 reg_smax(const struct bpf_reg_state *reg)
> +{
> +	return reg->smax_value;
> +}
> +
> +static inline u64 reg_umin(const struct bpf_reg_state *reg)
> +{
> +	return reg->umin_value;
> +}
> +
> +static inline u64 reg_umax(const struct bpf_reg_state *reg)
> +{
> +	return reg->umax_value;
> +}
> +
> +static inline s32 reg_s32_min(const struct bpf_reg_state *reg)
> +{
> +	return reg->s32_min_value;
> +}
> +
> +static inline s32 reg_s32_max(const struct bpf_reg_state *reg)
> +{
> +	return reg->s32_max_value;
> +}
> +
> +static inline u32 reg_u32_min(const struct bpf_reg_state *reg)
> +{
> +	return reg->u32_min_value;
> +}
> +
> +static inline u32 reg_u32_max(const struct bpf_reg_state *reg)
> +{
> +	return reg->u32_max_value;
> +}
> +
> +static inline void reg_set_srange32(struct bpf_reg_state *reg, s32 smin, s32 smax)
> +{
> +	reg->s32_min_value = smin;
> +	reg->s32_max_value = smax;
> +}
> +
> +static inline void reg_set_urange32(struct bpf_reg_state *reg, u32 umin, u32 umax)
> +{
> +	reg->u32_min_value = umin;
> +	reg->u32_max_value = umax;
> +}
> +
> +static inline void reg_set_srange64(struct bpf_reg_state *reg, s64 smin, s64 smax)
> +{
> +	reg->smin_value = smin;
> +	reg->smax_value = smax;
> +}
> +
> +static inline void reg_set_urange64(struct bpf_reg_state *reg, u64 umin, u64 umax)
> +{
> +	reg->umin_value = umin;
> +	reg->umax_value = umax;
> +}
> +
>   enum bpf_stack_slot_type {
>   	STACK_INVALID,    /* nothing was stored in this stack slot */
>   	STACK_SPILL,      /* register spilled into stack */
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 011e4ec25acd..64566b86dd27 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -571,20 +571,20 @@ static void print_scalar_ranges(struct bpf_verifier_env *env,
>   		u64 val;
>   		bool omit;
>   	} minmaxs[] = {
> -		{"smin",   reg->smin_value,         reg->smin_value == S64_MIN},
> -		{"smax",   reg->smax_value,         reg->smax_value == S64_MAX},
> -		{"umin",   reg->umin_value,         reg->umin_value == 0},
> -		{"umax",   reg->umax_value,         reg->umax_value == U64_MAX},
> +		{"smin",   reg_smin(reg),         reg_smin(reg) == S64_MIN},
> +		{"smax",   reg_smax(reg),         reg_smax(reg) == S64_MAX},
> +		{"umin",   reg_umin(reg),         reg_umin(reg) == 0},
> +		{"umax",   reg_umax(reg),         reg_umax(reg) == U64_MAX},
>   		{"smin32",
> -		 is_snum_decimal((s64)reg->s32_min_value)
> -			 ? (s64)reg->s32_min_value
> -			 : (u32)reg->s32_min_value, reg->s32_min_value == S32_MIN},
> +		 is_snum_decimal((s64)reg_s32_min(reg))
> +			 ? (s64)reg_s32_min(reg)
> +			 : (u32)reg_s32_min(reg), reg_s32_min(reg) == S32_MIN},
>   		{"smax32",
> -		 is_snum_decimal((s64)reg->s32_max_value)
> -			 ? (s64)reg->s32_max_value
> -			 : (u32)reg->s32_max_value, reg->s32_max_value == S32_MAX},
> -		{"umin32", reg->u32_min_value,      reg->u32_min_value == 0},
> -		{"umax32", reg->u32_max_value,      reg->u32_max_value == U32_MAX},
> +		 is_snum_decimal((s64)reg_s32_max(reg))
> +			 ? (s64)reg_s32_max(reg)
> +			 : (u32)reg_s32_max(reg), reg_s32_max(reg) == S32_MAX},
> +		{"umin32", reg_u32_min(reg),      reg_u32_min(reg) == 0},
> +		{"umax32", reg_u32_max(reg),      reg_u32_max(reg) == U32_MAX},
>   	}, *m1, *m2, *mend = &minmaxs[ARRAY_SIZE(minmaxs)];
>   	bool neg1, neg2;
>   
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8478d2c6ed5b..a78ae891b743 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -301,14 +301,14 @@ int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_s
>   static bool range_within(const struct bpf_reg_state *old,
>   			 const struct bpf_reg_state *cur)
>   {
> -	return old->umin_value <= cur->umin_value &&
> -	       old->umax_value >= cur->umax_value &&
> -	       old->smin_value <= cur->smin_value &&
> -	       old->smax_value >= cur->smax_value &&
> -	       old->u32_min_value <= cur->u32_min_value &&
> -	       old->u32_max_value >= cur->u32_max_value &&
> -	       old->s32_min_value <= cur->s32_min_value &&
> -	       old->s32_max_value >= cur->s32_max_value;
> +	return reg_umin(old) <= reg_umin(cur) &&
> +	       reg_umax(old) >= reg_umax(cur) &&
> +	       reg_smin(old) <= reg_smin(cur) &&
> +	       reg_smax(old) >= reg_smax(cur) &&
> +	       reg_u32_min(old) <= reg_u32_min(cur) &&
> +	       reg_u32_max(old) >= reg_u32_max(cur) &&
> +	       reg_s32_min(old) <= reg_s32_min(cur) &&
> +	       reg_s32_max(old) >= reg_s32_max(cur);
>   }
>   
>   /* If in the old state two registers had the same id, then they need to have
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ff6ff1c27517..b91d2789e7b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -320,12 +320,12 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
>   	bool unknown = true;
>   
>   	verbose(env, "%s the register %s has", ctx, reg_name);
> -	if (reg->smin_value > S64_MIN) {
> -		verbose(env, " smin=%lld", reg->smin_value);
> +	if (reg_smin(reg) > S64_MIN) {
> +		verbose(env, " smin=%lld", reg_smin(reg));
>   		unknown = false;
>   	}
> -	if (reg->smax_value < S64_MAX) {
> -		verbose(env, " smax=%lld", reg->smax_value);
> +	if (reg_smax(reg) < S64_MAX) {
> +		verbose(env, " smax=%lld", reg_smax(reg));
>   		unknown = false;
>   	}
>   	if (unknown)
> @@ -1796,15 +1796,10 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
>   static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>   {
>   	reg->var_off = tnum_const(imm);
> -	reg->smin_value = (s64)imm;
> -	reg->smax_value = (s64)imm;
> -	reg->umin_value = imm;
> -	reg->umax_value = imm;
> -
> -	reg->s32_min_value = (s32)imm;
> -	reg->s32_max_value = (s32)imm;
> -	reg->u32_min_value = (u32)imm;
> -	reg->u32_max_value = (u32)imm;
> +	reg_set_srange64(reg, (s64)imm, (s64)imm);
> +	reg_set_urange64(reg, imm, imm);
> +	reg_set_srange32(reg, (s32)imm, (s32)imm);
> +	reg_set_urange32(reg, (u32)imm, (u32)imm);
>   }
>   
>   /* Mark the unknown part of a register (variable offset or scalar value) as
> @@ -1823,10 +1818,8 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>   static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
>   {
>   	reg->var_off = tnum_const_subreg(reg->var_off, imm);
> -	reg->s32_min_value = (s32)imm;
> -	reg->s32_max_value = (s32)imm;
> -	reg->u32_min_value = (u32)imm;
> -	reg->u32_max_value = (u32)imm;
> +	reg_set_srange32(reg, (s32)imm, (s32)imm);
> +	reg_set_urange32(reg, (u32)imm, (u32)imm);
>   }
>   
>   /* Mark the 'variable offset' part of a register as zero.  This should be
> @@ -1937,34 +1930,25 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
>   	       tnum_equals_const(reg->var_off, 0);
>   }
>   
> +static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
> +{
> +	reg_set_srange32(reg, S32_MIN, S32_MAX);
> +	reg_set_urange32(reg, 0, U32_MAX);
> +}
> +
>   /* Reset the min/max bounds of a register */
>   static void __mark_reg_unbounded(struct bpf_reg_state *reg)
>   {
> -	reg->smin_value = S64_MIN;
> -	reg->smax_value = S64_MAX;
> -	reg->umin_value = 0;
> -	reg->umax_value = U64_MAX;
> +	reg_set_srange64(reg, S64_MIN, S64_MAX);
> +	reg_set_urange64(reg, 0, U64_MAX);
>   
> -	reg->s32_min_value = S32_MIN;
> -	reg->s32_max_value = S32_MAX;
> -	reg->u32_min_value = 0;
> -	reg->u32_max_value = U32_MAX;
> +	__mark_reg32_unbounded(reg);
>   }
>   
>   static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
>   {
> -	reg->smin_value = S64_MIN;
> -	reg->smax_value = S64_MAX;
> -	reg->umin_value = 0;
> -	reg->umax_value = U64_MAX;
> -}
> -
> -static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
> -{
> -	reg->s32_min_value = S32_MIN;
> -	reg->s32_max_value = S32_MAX;
> -	reg->u32_min_value = 0;
> -	reg->u32_max_value = U32_MAX;
> +	reg_set_srange64(reg, S64_MIN, S64_MAX);
> +	reg_set_urange64(reg, 0, U64_MAX);
>   }
>   
>   static void reset_reg64_and_tnum(struct bpf_reg_state *reg)
> @@ -1983,15 +1967,14 @@ static void __update_reg32_bounds(struct bpf_reg_state *reg)
>   {
>   	struct tnum var32_off = tnum_subreg(reg->var_off);
>   
> -	/* min signed is max(sign bit) | min(other bits) */
> -	reg->s32_min_value = max_t(s32, reg->s32_min_value,
> -			var32_off.value | (var32_off.mask & S32_MIN));
> -	/* max signed is min(sign bit) | max(other bits) */
> -	reg->s32_max_value = min_t(s32, reg->s32_max_value,
> -			var32_off.value | (var32_off.mask & S32_MAX));
> -	reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)var32_off.value);
> -	reg->u32_max_value = min(reg->u32_max_value,
> -				 (u32)(var32_off.value | var32_off.mask));
> +	reg_set_srange32(reg,
> +			 /* min signed is max(sign bit) | min(other bits) */
> +			 max_t(s32, reg_s32_min(reg), var32_off.value | (var32_off.mask & S32_MIN)),
> +			 /* max signed is min(sign bit) | max(other bits) */
> +			 min_t(s32, reg_s32_max(reg), var32_off.value | (var32_off.mask & S32_MAX)));
> +	reg_set_urange32(reg,
> +			 max_t(u32, reg_u32_min(reg), (u32)var32_off.value),
> +			 min(reg_u32_max(reg), (u32)(var32_off.value | var32_off.mask)));
>   }
>   
>   static void __update_reg64_bounds(struct bpf_reg_state *reg)
> @@ -2000,25 +1983,27 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
>   	bool umin_in_tnum;
>   
>   	/* min signed is max(sign bit) | min(other bits) */
> -	reg->smin_value = max_t(s64, reg->smin_value,
> -				reg->var_off.value | (reg->var_off.mask & S64_MIN));
>   	/* max signed is min(sign bit) | max(other bits) */
> -	reg->smax_value = min_t(s64, reg->smax_value,
> -				reg->var_off.value | (reg->var_off.mask & S64_MAX));
> -	reg->umin_value = max(reg->umin_value, reg->var_off.value);
> -	reg->umax_value = min(reg->umax_value,
> -			      reg->var_off.value | reg->var_off.mask);
> +	reg_set_srange64(reg,
> +			 max_t(s64, reg_smin(reg),
> +			       reg->var_off.value | (reg->var_off.mask & S64_MIN)),
> +			 min_t(s64, reg_smax(reg),
> +			       reg->var_off.value | (reg->var_off.mask & S64_MAX)));
> +	reg_set_urange64(reg,
> +			 max(reg_umin(reg), reg->var_off.value),
> +			 min(reg_umax(reg),
> +			     reg->var_off.value | reg->var_off.mask));
>   
>   	/* Check if u64 and tnum overlap in a single value */
> -	tnum_next = tnum_step(reg->var_off, reg->umin_value);
> -	umin_in_tnum = (reg->umin_value & ~reg->var_off.mask) == reg->var_off.value;
> +	tnum_next = tnum_step(reg->var_off, reg_umin(reg));
> +	umin_in_tnum = (reg_umin(reg) & ~reg->var_off.mask) == reg->var_off.value;
>   	tmax = reg->var_off.value | reg->var_off.mask;
> -	if (umin_in_tnum && tnum_next > reg->umax_value) {
> +	if (umin_in_tnum && tnum_next > reg_umax(reg)) {
>   		/* The u64 range and the tnum only overlap in umin.
>   		 * u64:  ---[xxxxxx]-----
>   		 * tnum: --xx----------x-
>   		 */
> -		___mark_reg_known(reg, reg->umin_value);
> +		___mark_reg_known(reg, reg_umin(reg));
>   	} else if (!umin_in_tnum && tnum_next == tmax) {
>   		/* The u64 range and the tnum only overlap in the maximum value
>   		 * represented by the tnum, called tmax.
> @@ -2026,8 +2011,8 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
>   		 * tnum: xx-----x--------
>   		 */
>   		___mark_reg_known(reg, tmax);
> -	} else if (!umin_in_tnum && tnum_next <= reg->umax_value &&
> -		   tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
> +	} else if (!umin_in_tnum && tnum_next <= reg_umax(reg) &&
> +		   tnum_step(reg->var_off, tnum_next) > reg_umax(reg)) {
>   		/* The u64 range and the tnum only overlap in between umin
>   		 * (excluded) and umax.
>   		 * u64:  ---[xxxxxx]-----
> @@ -2067,28 +2052,32 @@ static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
>   	 *
>   	 * So we use all these insights to derive bounds for subregisters here.
>   	 */
> -	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
> +	if ((reg_umin(reg) >> 32) == (reg_umax(reg) >> 32)) {
>   		/* u64 to u32 casting preserves validity of low 32 bits as
>   		 * a range, if upper 32 bits are the same
>   		 */
> -		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
> -		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
> +		reg_set_urange32(reg,
> +				 max_t(u32, reg_u32_min(reg), (u32)reg_umin(reg)),
> +				 min_t(u32, reg_u32_max(reg), (u32)reg_umax(reg)));
>   
> -		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
> -			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> -			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> +		if ((s32)reg_umin(reg) <= (s32)reg_umax(reg)) {
> +			reg_set_srange32(reg,
> +					 max_t(s32, reg_s32_min(reg), (s32)reg_umin(reg)),
> +					 min_t(s32, reg_s32_max(reg), (s32)reg_umax(reg)));
>   		}
>   	}
> -	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
> +	if ((reg_smin(reg) >> 32) == (reg_smax(reg) >> 32)) {
>   		/* low 32 bits should form a proper u32 range */
> -		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
> -			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
> -			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
> +		if ((u32)reg_smin(reg) <= (u32)reg_smax(reg)) {
> +			reg_set_urange32(reg,
> +					 max_t(u32, reg_u32_min(reg), (u32)reg_smin(reg)),
> +					 min_t(u32, reg_u32_max(reg), (u32)reg_smax(reg)));
>   		}
>   		/* low 32 bits should form a proper s32 range */
> -		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
> -			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> -			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> +		if ((s32)reg_smin(reg) <= (s32)reg_smax(reg)) {
> +			reg_set_srange32(reg,
> +					 max_t(s32, reg_s32_min(reg), (s32)reg_smin(reg)),
> +					 min_t(s32, reg_s32_max(reg), (s32)reg_smax(reg)));
>   		}
>   	}
>   	/* Special case where upper bits form a small sequence of two
> @@ -2104,15 +2093,17 @@ static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
>   	 * [0xfffffff0fffffff0; 0xfffffff100000010], forms a valid s32 range
>   	 * [-16, 16] ([0xfffffff0; 0x00000010]) in its 32 bit subregister.
>   	 */
> -	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
> -	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
> -		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
> -		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
> +	if ((u32)(reg_umin(reg) >> 32) + 1 == (u32)(reg_umax(reg) >> 32) &&
> +	    (s32)reg_umin(reg) < 0 && (s32)reg_umax(reg) >= 0) {
> +		reg_set_srange32(reg,
> +				 max_t(s32, reg_s32_min(reg), (s32)reg_umin(reg)),
> +				 min_t(s32, reg_s32_max(reg), (s32)reg_umax(reg)));
>   	}
> -	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
> -	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
> -		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
> -		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
> +	if ((u32)(reg_smin(reg) >> 32) + 1 == (u32)(reg_smax(reg) >> 32) &&
> +	    (s32)reg_smin(reg) < 0 && (s32)reg_smax(reg) >= 0) {
> +		reg_set_srange32(reg,
> +				 max_t(s32, reg_s32_min(reg), (s32)reg_smin(reg)),
> +				 min_t(s32, reg_s32_max(reg), (s32)reg_smax(reg)));
>   	}
>   }
>   
> @@ -2121,19 +2112,21 @@ static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
>   	/* if u32 range forms a valid s32 range (due to matching sign bit),
>   	 * try to learn from that
>   	 */
> -	if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
> -		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
> -		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
> +	if ((s32)reg_u32_min(reg) <= (s32)reg_u32_max(reg)) {
> +		reg_set_srange32(reg,
> +				 max_t(s32, reg_s32_min(reg), reg_u32_min(reg)),
> +				 min_t(s32, reg_s32_max(reg), reg_u32_max(reg)));
>   	}
>   	/* If we cannot cross the sign boundary, then signed and unsigned bounds
>   	 * are the same, so combine.  This works even in the negative case, e.g.
>   	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
>   	 */
> -	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
> -		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
> -		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
> +	if ((u32)reg_s32_min(reg) <= (u32)reg_s32_max(reg)) {
> +		reg_set_urange32(reg,
> +				 max_t(u32, reg_s32_min(reg), reg_u32_min(reg)),
> +				 min_t(u32, reg_s32_max(reg), reg_u32_max(reg)));
>   	} else {
> -		if (reg->u32_max_value < (u32)reg->s32_min_value) {
> +		if (reg_u32_max(reg) < (u32)reg_s32_min(reg)) {
>   			/* See __reg64_deduce_bounds() for detailed explanation.
>   			 * Refine ranges in the following situation:
>   			 *
> @@ -2143,9 +2136,11 @@ static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
>   			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
>   			 * 0                     S32_MAX S32_MIN                    -1
>   			 */
> -			reg->s32_min_value = (s32)reg->u32_min_value;
> -			reg->u32_max_value = min_t(u32, reg->u32_max_value, reg->s32_max_value);
> -		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
> +			reg_set_srange32(reg, (s32)reg_u32_min(reg), reg_s32_max(reg));
> +			reg_set_urange32(reg,
> +					 reg_u32_min(reg),
> +					 min_t(u32, reg_u32_max(reg), reg_s32_max(reg)));
> +		} else if ((u32)reg_s32_max(reg) < reg_u32_min(reg)) {
>   			/*
>   			 * 0                                                   U32_MAX
>   			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
> @@ -2153,8 +2148,10 @@ static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
>   			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
>   			 * 0                     S32_MAX S32_MIN                    -1
>   			 */
> -			reg->s32_max_value = (s32)reg->u32_max_value;
> -			reg->u32_min_value = max_t(u32, reg->u32_min_value, reg->s32_min_value);
> +			reg_set_srange32(reg, reg_s32_min(reg), (s32)reg_u32_max(reg));
> +			reg_set_urange32(reg,
> +					 max_t(u32, reg_u32_min(reg), reg_s32_min(reg)),
> +					 reg_u32_max(reg));
>   		}
>   	}
>   }
> @@ -2228,17 +2225,19 @@ static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
>   	 * casting umin/umax as smin/smax and checking if they form valid
>   	 * range, and vice versa. Those are equivalent checks.
>   	 */
> -	if ((s64)reg->umin_value <= (s64)reg->umax_value) {
> -		reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
> -		reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
> +	if ((s64)reg_umin(reg) <= (s64)reg_umax(reg)) {
> +		reg_set_srange64(reg,
> +				 max_t(s64, reg_smin(reg), reg_umin(reg)),
> +				 min_t(s64, reg_smax(reg), reg_umax(reg)));
>   	}
>   	/* If we cannot cross the sign boundary, then signed and unsigned bounds
>   	 * are the same, so combine.  This works even in the negative case, e.g.
>   	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
>   	 */
> -	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
> -		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
> -		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
> +	if ((u64)reg_smin(reg) <= (u64)reg_smax(reg)) {
> +		reg_set_urange64(reg,
> +				 max_t(u64, reg_smin(reg), reg_umin(reg)),
> +				 min_t(u64, reg_smax(reg), reg_umax(reg)));
>   	} else {
>   		/* If the s64 range crosses the sign boundary, then it's split
>   		 * between the beginning and end of the U64 domain. In that
> @@ -2275,10 +2274,10 @@ static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
>   		 * The first condition below corresponds to the first diagram
>   		 * above.
>   		 */
> -		if (reg->umax_value < (u64)reg->smin_value) {
> -			reg->smin_value = (s64)reg->umin_value;
> -			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
> -		} else if ((u64)reg->smax_value < reg->umin_value) {
> +		if (reg_umax(reg) < (u64)reg_smin(reg)) {
> +			reg_set_srange64(reg, (s64)reg_umin(reg), reg_smax(reg));
> +			reg_set_urange64(reg, reg_umin(reg), min_t(u64, reg_umax(reg), reg_smax(reg)));
> +		} else if ((u64)reg_smax(reg) < reg_umin(reg)) {
>   			/* This second condition considers the case where the u64 range
>   			 * overlaps with the negative portion of the s64 range:
>   			 *
> @@ -2288,8 +2287,8 @@ static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
>   			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
>   			 * 0                     S64_MAX S64_MIN                    -1
>   			 */
> -			reg->smax_value = (s64)reg->umax_value;
> -			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
> +			reg_set_srange64(reg, reg_smin(reg), (s64)reg_umax(reg));
> +			reg_set_urange64(reg, max_t(u64, reg_umin(reg), reg_smin(reg)), reg_umax(reg));
>   		}
>   	}
>   }
> @@ -2312,15 +2311,17 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
>   	__s64 new_smin, new_smax;
>   
>   	/* u32 -> u64 tightening, it's always well-formed */
> -	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
> -	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
> -	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
> -	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
> +	new_umin = (reg_umin(reg) & ~0xffffffffULL) | reg_u32_min(reg);
> +	new_umax = (reg_umax(reg) & ~0xffffffffULL) | reg_u32_max(reg);
> +	reg_set_urange64(reg,
> +			 max_t(u64, reg_umin(reg), new_umin),
> +			 min_t(u64, reg_umax(reg), new_umax));
>   	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
> -	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
> -	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
> -	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
> -	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
> +	new_smin = (reg_smin(reg) & ~0xffffffffULL) | reg_u32_min(reg);
> +	new_smax = (reg_smax(reg) & ~0xffffffffULL) | reg_u32_max(reg);
> +	reg_set_srange64(reg,
> +			 max_t(s64, reg_smin(reg), new_smin),
> +			 min_t(s64, reg_smax(reg), new_smax));
>   
>   	/* Here we would like to handle a special case after sign extending load,
>   	 * when upper bits for a 64-bit range are all 1s or all 0s.
> @@ -2351,13 +2352,11 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
>   	 *  - 0x0000_0000_7fff_ffff == (s64)S32_MAX
>   	 * These relations are used in the conditions below.
>   	 */
> -	if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
> -		reg->smin_value = reg->s32_min_value;
> -		reg->smax_value = reg->s32_max_value;
> -		reg->umin_value = reg->s32_min_value;
> -		reg->umax_value = reg->s32_max_value;
> +	if (reg_s32_min(reg) >= 0 && reg_smin(reg) >= S32_MIN && reg_smax(reg) <= S32_MAX) {
> +		reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
> +		reg_set_urange64(reg, reg_s32_min(reg), reg_s32_max(reg));
>   		reg->var_off = tnum_intersect(reg->var_off,
> -					      tnum_range(reg->smin_value, reg->smax_value));
> +					      tnum_range(reg_smin(reg), reg_smax(reg)));
>   	}
>   }
>   
> @@ -2373,11 +2372,11 @@ static void __reg_deduce_bounds(struct bpf_reg_state *reg)
>   static void __reg_bound_offset(struct bpf_reg_state *reg)
>   {
>   	struct tnum var64_off = tnum_intersect(reg->var_off,
> -					       tnum_range(reg->umin_value,
> -							  reg->umax_value));
> +					       tnum_range(reg_umin(reg),
> +							  reg_umax(reg)));
>   	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
> -					       tnum_range(reg->u32_min_value,
> -							  reg->u32_max_value));
> +					       tnum_range(reg_u32_min(reg),
> +							  reg_u32_max(reg)));
>   
>   	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
>   }
> @@ -2405,9 +2404,9 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
>   
>   static bool range_bounds_violation(struct bpf_reg_state *reg)
>   {
> -	return (reg->umin_value > reg->umax_value || reg->smin_value > reg->smax_value ||
> -		reg->u32_min_value > reg->u32_max_value ||
> -		reg->s32_min_value > reg->s32_max_value);
> +	return (reg_umin(reg) > reg_umax(reg) || reg_smin(reg) > reg_smax(reg) ||
> +		reg_u32_min(reg) > reg_u32_max(reg) ||
> +		reg_s32_min(reg) > reg_s32_max(reg));
>   }
>   
>   static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
> @@ -2418,8 +2417,8 @@ static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
>   	if (!tnum_is_const(reg->var_off))
>   		return false;
>   
> -	return reg->umin_value != uval || reg->umax_value != uval ||
> -	       reg->smin_value != sval || reg->smax_value != sval;
> +	return reg_umin(reg) != uval || reg_umax(reg) != uval ||
> +	       reg_smin(reg) != sval || reg_smax(reg) != sval;
>   }
>   
>   static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
> @@ -2430,8 +2429,8 @@ static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
>   	if (!tnum_subreg_is_const(reg->var_off))
>   		return false;
>   
> -	return reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
> -	       reg->s32_min_value != sval32 || reg->s32_max_value != sval32;
> +	return reg_u32_min(reg) != uval32 || reg_u32_max(reg) != uval32 ||
> +	       reg_s32_min(reg) != sval32 || reg_s32_max(reg) != sval32;
>   }
>   
>   static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> @@ -2458,10 +2457,10 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
>   out:
>   	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s u64=[%#llx, %#llx] "
>   		     "s64=[%#llx, %#llx] u32=[%#x, %#x] s32=[%#x, %#x] var_off=(%#llx, %#llx)",
> -		     ctx, msg, reg->umin_value, reg->umax_value,
> -		     reg->smin_value, reg->smax_value,
> -		     reg->u32_min_value, reg->u32_max_value,
> -		     reg->s32_min_value, reg->s32_max_value,
> +		     ctx, msg, reg_umin(reg), reg_umax(reg),
> +		     reg_smin(reg), reg_smax(reg),
> +		     reg_u32_min(reg), reg_u32_max(reg),
> +		     reg_s32_min(reg), reg_s32_max(reg),
>   		     reg->var_off.value, reg->var_off.mask);
>   	if (env->test_reg_invariants)
>   		return -EFAULT;
> @@ -2476,21 +2475,17 @@ static bool __reg32_bound_s64(s32 a)
>   
>   static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>   {
> -	reg->umin_value = reg->u32_min_value;
> -	reg->umax_value = reg->u32_max_value;
> +	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
>   
>   	/* Attempt to pull 32-bit signed bounds into 64-bit bounds but must
>   	 * be positive otherwise set to worse case bounds and refine later
>   	 * from tnum.
>   	 */
> -	if (__reg32_bound_s64(reg->s32_min_value) &&
> -	    __reg32_bound_s64(reg->s32_max_value)) {
> -		reg->smin_value = reg->s32_min_value;
> -		reg->smax_value = reg->s32_max_value;
> -	} else {
> -		reg->smin_value = 0;
> -		reg->smax_value = U32_MAX;
> -	}
> +	if (__reg32_bound_s64(reg_s32_min(reg)) &&
> +	    __reg32_bound_s64(reg_s32_max(reg)))
> +		reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
> +	else
> +		reg_set_srange64(reg, 0, U32_MAX);
>   }
>   
>   /* Mark a register as having a completely unknown (scalar) value. */
> @@ -2534,11 +2529,12 @@ static int __mark_reg_s32_range(struct bpf_verifier_env *env,
>   {
>   	struct bpf_reg_state *reg = regs + regno;
>   
> -	reg->s32_min_value = max_t(s32, reg->s32_min_value, s32_min);
> -	reg->s32_max_value = min_t(s32, reg->s32_max_value, s32_max);
> -
> -	reg->smin_value = max_t(s64, reg->smin_value, s32_min);
> -	reg->smax_value = min_t(s64, reg->smax_value, s32_max);
> +	reg_set_srange32(reg,
> +			 max_t(s32, reg_s32_min(reg), s32_min),
> +			 min_t(s32, reg_s32_max(reg), s32_max));
> +	reg_set_srange64(reg,
> +			 max_t(s64, reg_smin(reg), s32_min),
> +			 min_t(s64, reg_smax(reg), s32_max));
>   
>   	reg_bounds_sync(reg);
>   
> @@ -3801,7 +3797,7 @@ static bool is_bpf_st_mem(struct bpf_insn *insn)
>   
>   static int get_reg_width(struct bpf_reg_state *reg)
>   {
> -	return fls64(reg->umax_value);
> +	return fls64(reg_umax(reg));
>   }
>   
>   /* See comment for mark_fastcall_pattern_for_call() */
> @@ -3990,8 +3986,8 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>   	bool zero_used = false;
>   
>   	cur = env->cur_state->frame[env->cur_state->curframe];
> -	min_off = ptr_reg->smin_value + off;
> -	max_off = ptr_reg->smax_value + off + size;
> +	min_off = reg_smin(ptr_reg) + off;
> +	max_off = reg_smax(ptr_reg) + off + size;
>   	if (value_regno >= 0)
>   		value_reg = &cur->regs[value_regno];
>   	if ((value_reg && bpf_register_is_null(value_reg)) ||
> @@ -4324,8 +4320,8 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg
>   	if (err)
>   		return err;
>   
> -	min_off = reg->smin_value + off;
> -	max_off = reg->smax_value + off;
> +	min_off = reg_smin(reg) + off;
> +	max_off = reg_smax(reg) + off;
>   	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
>   	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
>   	return 0;
> @@ -4425,13 +4421,13 @@ static int check_map_access_type(struct bpf_verifier_env *env, struct bpf_reg_st
>   
>   	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
>   		verbose(env, "write into map forbidden, value_size=%d off=%lld size=%d\n",
> -			map->value_size, reg->smin_value + off, size);
> +			map->value_size, reg_smin(reg) + off, size);
>   		return -EACCES;
>   	}
>   
>   	if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
>   		verbose(env, "read from map forbidden, value_size=%d off=%lld size=%d\n",
> -			map->value_size, reg->smin_value + off, size);
> +			map->value_size, reg_smin(reg) + off, size);
>   		return -EACCES;
>   	}
>   
> @@ -4493,15 +4489,15 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
>   	 * index'es we need to make sure that whatever we use
>   	 * will have a set floor within our range.
>   	 */
> -	if (reg->smin_value < 0 &&
> -	    (reg->smin_value == S64_MIN ||
> -	     (off + reg->smin_value != (s64)(s32)(off + reg->smin_value)) ||
> -	      reg->smin_value + off < 0)) {
> +	if (reg_smin(reg) < 0 &&
> +	    (reg_smin(reg) == S64_MIN ||
> +	     (off + reg_smin(reg) != (s64)(s32)(off + reg_smin(reg))) ||
> +	      reg_smin(reg) + off < 0)) {
>   		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
>   			reg_arg_name(env, argno));
>   		return -EACCES;
>   	}
> -	err = __check_mem_access(env, reg, argno, reg->smin_value + off, size,
> +	err = __check_mem_access(env, reg, argno, reg_smin(reg) + off, size,
>   				 mem_size, zero_size_allowed);
>   	if (err) {
>   		verbose(env, "%s min value is outside of the allowed memory range\n",
> @@ -4511,14 +4507,14 @@ static int check_mem_region_access(struct bpf_verifier_env *env, struct bpf_reg_
>   
>   	/* If we haven't set a max value then we need to bail since we can't be
>   	 * sure we won't do bad things.
> -	 * If reg->umax_value + off could overflow, treat that as unbounded too.
> +	 * If reg_umax(reg) + off could overflow, treat that as unbounded too.
>   	 */
> -	if (reg->umax_value >= BPF_MAX_VAR_OFF) {
> +	if (reg_umax(reg) >= BPF_MAX_VAR_OFF) {
>   		verbose(env, "%s unbounded memory access, make sure to bounds check any such access\n",
>   			reg_arg_name(env, argno));
>   		return -EACCES;
>   	}
> -	err = __check_mem_access(env, reg, argno, reg->umax_value + off, size,
> +	err = __check_mem_access(env, reg, argno, reg_umax(reg) + off, size,
>   				 mem_size, zero_size_allowed);
>   	if (err) {
>   		verbose(env, "%s max value is outside of the allowed memory range\n",
> @@ -4546,7 +4542,7 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
>   		return -EACCES;
>   	}
>   
> -	if (reg->smin_value < 0) {
> +	if (reg_smin(reg) < 0) {
>   		verbose(env, "negative offset %s ptr %s off=%lld disallowed\n",
>   			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.value);
>   		return -EACCES;
> @@ -4846,8 +4842,8 @@ static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg_state *
>   		 * this program. To check that [x1, x2) overlaps with [y1, y2),
>   		 * it is sufficient to check x1 < y2 && y1 < x2.
>   		 */
> -		if (reg->smin_value + off < p + field->size &&
> -		    p < reg->umax_value + off + size) {
> +		if (reg_smin(reg) + off < p + field->size &&
> +		    p < reg_umax(reg) + off + size) {
>   			switch (field->type) {
>   			case BPF_KPTR_UNREF:
>   			case BPF_KPTR_REF:
> @@ -4942,14 +4938,14 @@ static int check_packet_access(struct bpf_verifier_env *env, struct bpf_reg_stat
>   		return err;
>   
>   	/* __check_mem_access has made sure "off + size - 1" is within u16.
> -	 * reg->umax_value can't be bigger than MAX_PACKET_OFF which is 0xffff,
> +	 * reg_umax(reg) can't be bigger than MAX_PACKET_OFF which is 0xffff,
>   	 * otherwise find_good_pkt_pointers would have refused to set range info
>   	 * that __check_mem_access would have rejected this pkt access.
> -	 * Therefore, "off + reg->umax_value + size - 1" won't overflow u32.
> +	 * Therefore, "off + reg_umax(reg) + size - 1" won't overflow u32.
>   	 */
>   	env->prog->aux->max_pkt_offset =
>   		max_t(u32, env->prog->aux->max_pkt_offset,
> -		      off + reg->umax_value + size - 1);
> +		      off + reg_umax(reg) + size - 1);
>   
>   	return 0;
>   }
> @@ -5010,7 +5006,7 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, struct b
>   		err = __check_ptr_off_reg(env, reg, argno, fixed_off_ok);
>   	if (err)
>   		return err;
> -	off += reg->umax_value;
> +	off += reg_umax(reg);
>   
>   	err = __check_ctx_access(env, insn_idx, off, access_size, t, info);
>   	if (err)
> @@ -5037,7 +5033,7 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
>   	struct bpf_insn_access_aux info = {};
>   	bool valid;
>   
> -	if (reg->smin_value < 0) {
> +	if (reg_smin(reg) < 0) {
>   		verbose(env, "%s min value is negative, either use unsigned index or do a if (index >=0) check.\n",
>   			reg_arg_name(env, argno));
>   		return -EACCES;
> @@ -5655,15 +5651,12 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>   
>   	/* fix arithmetic bounds */
>   	mask = ((u64)1 << (size * 8)) - 1;
> -	if ((reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
> -		reg->umin_value &= mask;
> -		reg->umax_value &= mask;
> +	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask)) {
> +		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
>   	} else {
> -		reg->umin_value = 0;
> -		reg->umax_value = mask;
> +		reg_set_urange64(reg, 0, mask);
>   	}
> -	reg->smin_value = reg->umin_value;
> -	reg->smax_value = reg->umax_value;
> +	reg_set_srange64(reg, reg_umin(reg), reg_umax(reg));
>   
>   	/* If size is smaller than 32bit register the 32bit register
>   	 * values are also truncated so we push 64-bit bounds into
> @@ -5678,19 +5671,18 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>   static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
>   {
>   	if (size == 1) {
> -		reg->smin_value = reg->s32_min_value = S8_MIN;
> -		reg->smax_value = reg->s32_max_value = S8_MAX;
> +		reg_set_srange64(reg, S8_MIN, S8_MAX);
> +		reg_set_srange32(reg, S8_MIN, S8_MAX);
>   	} else if (size == 2) {
> -		reg->smin_value = reg->s32_min_value = S16_MIN;
> -		reg->smax_value = reg->s32_max_value = S16_MAX;
> +		reg_set_srange64(reg, S16_MIN, S16_MAX);
> +		reg_set_srange32(reg, S16_MIN, S16_MAX);
>   	} else {
>   		/* size == 4 */
> -		reg->smin_value = reg->s32_min_value = S32_MIN;
> -		reg->smax_value = reg->s32_max_value = S32_MAX;
> +		reg_set_srange64(reg, S32_MIN, S32_MAX);
> +		reg_set_srange32(reg, S32_MIN, S32_MAX);
>   	}
> -	reg->umin_value = reg->u32_min_value = 0;
> -	reg->umax_value = U64_MAX;
> -	reg->u32_max_value = U32_MAX;
> +	reg_set_urange64(reg, 0, U64_MAX);
> +	reg_set_urange32(reg, 0, U32_MAX);
>   	reg->var_off = tnum_unknown;
>   }
>   
> @@ -5711,29 +5703,29 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>   			reg->var_off = tnum_const((s32)u64_cval);
>   
>   		u64_cval = reg->var_off.value;
> -		reg->smax_value = reg->smin_value = u64_cval;
> -		reg->umax_value = reg->umin_value = u64_cval;
> -		reg->s32_max_value = reg->s32_min_value = u64_cval;
> -		reg->u32_max_value = reg->u32_min_value = u64_cval;
> +		reg_set_srange64(reg, u64_cval, u64_cval);
> +		reg_set_urange64(reg, u64_cval, u64_cval);
> +		reg_set_srange32(reg, u64_cval, u64_cval);
> +		reg_set_urange32(reg, u64_cval, u64_cval);
>   		return;
>   	}
>   
> -	top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
> -	top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;
> +	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
> +	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
>   
>   	if (top_smax_value != top_smin_value)
>   		goto out;
>   
>   	/* find the s64_min and s64_min after sign extension */
>   	if (size == 1) {
> -		init_s64_max = (s8)reg->smax_value;
> -		init_s64_min = (s8)reg->smin_value;
> +		init_s64_max = (s8)reg_smax(reg);
> +		init_s64_min = (s8)reg_smin(reg);
>   	} else if (size == 2) {
> -		init_s64_max = (s16)reg->smax_value;
> -		init_s64_min = (s16)reg->smin_value;
> +		init_s64_max = (s16)reg_smax(reg);
> +		init_s64_min = (s16)reg_smin(reg);
>   	} else {
> -		init_s64_max = (s32)reg->smax_value;
> -		init_s64_min = (s32)reg->smin_value;
> +		init_s64_max = (s32)reg_smax(reg);
> +		init_s64_min = (s32)reg_smin(reg);
>   	}
>   
>   	s64_max = max(init_s64_max, init_s64_min);
> @@ -5741,10 +5733,10 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>   
>   	/* both of s64_max/s64_min positive or negative */
>   	if ((s64_max >= 0) == (s64_min >= 0)) {
> -		reg->s32_min_value = reg->smin_value = s64_min;
> -		reg->s32_max_value = reg->smax_value = s64_max;
> -		reg->u32_min_value = reg->umin_value = s64_min;
> -		reg->u32_max_value = reg->umax_value = s64_max;
> +		reg_set_srange64(reg, s64_min, s64_max);
> +		reg_set_urange64(reg, s64_min, s64_max);
> +		reg_set_srange32(reg, s64_min, s64_max);
> +		reg_set_urange32(reg, s64_min, s64_max);
>   		reg->var_off = tnum_range(s64_min, s64_max);
>   		return;
>   	}
> @@ -5755,16 +5747,12 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>   
>   static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
>   {
> -	if (size == 1) {
> -		reg->s32_min_value = S8_MIN;
> -		reg->s32_max_value = S8_MAX;
> -	} else {
> +	if (size == 1)
> +		reg_set_srange32(reg, S8_MIN, S8_MAX);
> +	else
>   		/* size == 2 */
> -		reg->s32_min_value = S16_MIN;
> -		reg->s32_max_value = S16_MAX;
> -	}
> -	reg->u32_min_value = 0;
> -	reg->u32_max_value = U32_MAX;
> +		reg_set_srange32(reg, S16_MIN, S16_MAX);
> +	reg_set_urange32(reg, 0, U32_MAX);
>   	reg->var_off = tnum_subreg(tnum_unknown);
>   }
>   
> @@ -5782,34 +5770,32 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
>   			reg->var_off = tnum_const((s16)u32_val);
>   
>   		u32_val = reg->var_off.value;
> -		reg->s32_min_value = reg->s32_max_value = u32_val;
> -		reg->u32_min_value = reg->u32_max_value = u32_val;
> +		reg_set_srange32(reg, u32_val, u32_val);
> +		reg_set_urange32(reg, u32_val, u32_val);
>   		return;
>   	}
>   
> -	top_smax_value = ((u32)reg->s32_max_value >> num_bits) << num_bits;
> -	top_smin_value = ((u32)reg->s32_min_value >> num_bits) << num_bits;
> +	top_smax_value = ((u32)reg_s32_max(reg) >> num_bits) << num_bits;
> +	top_smin_value = ((u32)reg_s32_min(reg) >> num_bits) << num_bits;
>   
>   	if (top_smax_value != top_smin_value)
>   		goto out;
>   
>   	/* find the s32_min and s32_min after sign extension */
>   	if (size == 1) {
> -		init_s32_max = (s8)reg->s32_max_value;
> -		init_s32_min = (s8)reg->s32_min_value;
> +		init_s32_max = (s8)reg_s32_max(reg);
> +		init_s32_min = (s8)reg_s32_min(reg);
>   	} else {
>   		/* size == 2 */
> -		init_s32_max = (s16)reg->s32_max_value;
> -		init_s32_min = (s16)reg->s32_min_value;
> +		init_s32_max = (s16)reg_s32_max(reg);
> +		init_s32_min = (s16)reg_s32_min(reg);
>   	}
>   	s32_max = max(init_s32_max, init_s32_min);
>   	s32_min = min(init_s32_max, init_s32_min);
>   
>   	if ((s32_min >= 0) == (s32_max >= 0)) {
> -		reg->s32_min_value = s32_min;
> -		reg->s32_max_value = s32_max;
> -		reg->u32_min_value = (u32)s32_min;
> -		reg->u32_max_value = (u32)s32_max;
> +		reg_set_srange32(reg, s32_min, s32_max);
> +		reg_set_urange32(reg, (u32)s32_min, (u32)s32_max);
>   		reg->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
>   		return;
>   	}
> @@ -6266,14 +6252,14 @@ static int check_stack_access_within_bounds(
>   		min_off = (s64)reg->var_off.value + off;
>   		max_off = min_off + access_size;
>   	} else {
> -		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
> -		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
> +		if (reg_smax(reg) >= BPF_MAX_VAR_OFF ||
> +		    reg_smin(reg) <= -BPF_MAX_VAR_OFF) {
>   			verbose(env, "invalid unbounded variable-offset%s stack %s\n",
>   				err_extra, reg_arg_name(env, argno));
>   			return -EACCES;
>   		}
> -		min_off = reg->smin_value + off;
> -		max_off = reg->smax_value + off + access_size;
> +		min_off = reg_smin(reg) + off;
> +		max_off = reg_smax(reg) + off + access_size;
>   	}
>   
>   	err = check_stack_slot_within_bounds(env, min_off, state, type);
> @@ -6891,8 +6877,8 @@ static int check_stack_range_initialized(
>   		if (meta && meta->raw_mode)
>   			meta = NULL;
>   
> -		min_off = reg->smin_value + off;
> -		max_off = reg->smax_value + off;
> +		min_off = reg_smin(reg) + off;
> +		max_off = reg_smax(reg) + off;
>   	}
>   
>   	if (meta && meta->raw_mode) {
> @@ -7048,8 +7034,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
>   							  zero_size_allowed);
>   			if (err)
>   				return err;
> -			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> -				env->prog->aux->max_ctx_offset = reg->umax_value + access_size;
> +			if (env->prog->aux->max_ctx_offset < reg_umax(reg) + access_size)
> +				env->prog->aux->max_ctx_offset = reg_umax(reg) + access_size;
>   			return 0;
>   		}
>   		fallthrough;
> @@ -7088,7 +7074,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>   	 * out. Only upper bounds can be learned because retval is an
>   	 * int type and negative retvals are allowed.
>   	 */
> -	meta->msize_max_value = size_reg->umax_value;
> +	meta->msize_max_value = reg_umax(size_reg);
>   
>   	/* The register is SCALAR_VALUE; the access check happens using
>   	 * its boundaries. For unprivileged variable accesses, disable
> @@ -7098,24 +7084,24 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>   	if (!tnum_is_const(size_reg->var_off))
>   		meta = NULL;
>   
> -	if (size_reg->smin_value < 0) {
> +	if (reg_smin(size_reg) < 0) {
>   		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
>   			reg_arg_name(env, size_argno));
>   		return -EACCES;
>   	}
>   
> -	if (size_reg->umin_value == 0 && !zero_size_allowed) {
> +	if (reg_umin(size_reg) == 0 && !zero_size_allowed) {
>   		verbose(env, "%s invalid zero-sized read: u64=[%lld,%lld]\n",
> -			reg_arg_name(env, size_argno), size_reg->umin_value, size_reg->umax_value);
> +			reg_arg_name(env, size_argno), reg_umin(size_reg), reg_umax(size_reg));
>   		return -EACCES;
>   	}
>   
> -	if (size_reg->umax_value >= BPF_MAX_VAR_SIZ) {
> +	if (reg_umax(size_reg) >= BPF_MAX_VAR_SIZ) {
>   		verbose(env, "%s unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
>   			reg_arg_name(env, size_argno));
>   		return -EACCES;
>   	}
> -	err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
> +	err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
>   				      access_type, zero_size_allowed, meta);
>   	if (!err)
>   		err = mark_chain_precision(env, reg_from_argno(size_argno));
> @@ -9848,9 +9834,9 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
>   static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
>   {
>   	if (range.return_32bit)
> -		return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
> +		return range.minval <= reg_s32_min(reg) && reg_s32_max(reg) <= range.maxval;
>   	else
> -		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
> +		return range.minval <= reg_smin(reg) && reg_smax(reg) <= range.maxval;
>   }
>   
>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
> @@ -9959,21 +9945,15 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
>   	case BPF_FUNC_probe_read_str:
>   	case BPF_FUNC_probe_read_kernel_str:
>   	case BPF_FUNC_probe_read_user_str:
> -		ret_reg->smax_value = meta->msize_max_value;
> -		ret_reg->s32_max_value = meta->msize_max_value;
> -		ret_reg->smin_value = -MAX_ERRNO;
> -		ret_reg->s32_min_value = -MAX_ERRNO;
> +		reg_set_srange64(ret_reg, -MAX_ERRNO, meta->msize_max_value);
> +		reg_set_srange32(ret_reg, -MAX_ERRNO, meta->msize_max_value);
>   		reg_bounds_sync(ret_reg);
>   		break;
>   	case BPF_FUNC_get_smp_processor_id:
> -		ret_reg->umax_value = nr_cpu_ids - 1;
> -		ret_reg->u32_max_value = nr_cpu_ids - 1;
> -		ret_reg->smax_value = nr_cpu_ids - 1;
> -		ret_reg->s32_max_value = nr_cpu_ids - 1;
> -		ret_reg->umin_value = 0;
> -		ret_reg->u32_min_value = 0;
> -		ret_reg->smin_value = 0;
> -		ret_reg->s32_min_value = 0;
> +		reg_set_urange64(ret_reg, 0, nr_cpu_ids - 1);
> +		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
> +		reg_set_srange64(ret_reg, 0, nr_cpu_ids - 1);
> +		reg_set_srange32(ret_reg, 0, nr_cpu_ids - 1);
>   		reg_bounds_sync(ret_reg);
>   		break;
>   	}
> @@ -10438,7 +10418,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		err = mark_chain_precision(env, BPF_REG_1);
>   		if (err)
>   			return err;
> -		if (cur_func(env)->callback_depth < regs[BPF_REG_1].umax_value) {
> +		if (cur_func(env)->callback_depth < reg_umax(&regs[BPF_REG_1])) {
>   			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
>   						 set_loop_callback_state);
>   		} else {
> @@ -13403,7 +13383,7 @@ static bool check_reg_sane_offset_scalar(struct bpf_verifier_env *env,
>   {
>   	bool known = tnum_is_const(reg->var_off);
>   	s64 val = reg->var_off.value;
> -	s64 smin = reg->smin_value;
> +	s64 smin = reg_smin(reg);
>   
>   	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
>   		verbose(env, "math between %s pointer and %lld is not allowed\n",
> @@ -13432,7 +13412,7 @@ static bool check_reg_sane_offset_ptr(struct bpf_verifier_env *env,
>   {
>   	bool known = tnum_is_const(reg->var_off);
>   	s64 val = reg->var_off.value;
> -	s64 smin = reg->smin_value;
> +	s64 smin = reg_smin(reg);
>   
>   	if (known && (val >= BPF_MAX_VAR_OFF || val <= -BPF_MAX_VAR_OFF)) {
>   		verbose(env, "%s pointer offset %lld is not allowed\n",
> @@ -13474,7 +13454,7 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
>   		break;
>   	case PTR_TO_MAP_VALUE:
>   		max = ptr_reg->map_ptr->value_size;
> -		ptr_limit = mask_to_left ? ptr_reg->smin_value : ptr_reg->umax_value;
> +		ptr_limit = mask_to_left ? reg_smin(ptr_reg) : reg_umax(ptr_reg);
>   		break;
>   	default:
>   		return REASON_TYPE;
> @@ -13563,7 +13543,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
>   	struct bpf_insn_aux_data *aux = commit_window ? cur_aux(env) : &info->aux;
>   	struct bpf_verifier_state *vstate = env->cur_state;
>   	bool off_is_imm = tnum_is_const(off_reg->var_off);
> -	bool off_is_neg = off_reg->smin_value < 0;
> +	bool off_is_neg = reg_smin(off_reg) < 0;
>   	bool ptr_is_dst_reg = ptr_reg == dst_reg;
>   	u8 opcode = BPF_OP(insn->code);
>   	u32 alu_state, alu_limit;
> @@ -13582,7 +13562,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
>   
>   	if (!commit_window) {
>   		if (!tnum_is_const(off_reg->var_off) &&
> -		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0))
> +		    (reg_smin(off_reg) < 0) != (reg_smax(off_reg) < 0))
>   			return REASON_BOUNDS;
>   
>   		info->mask_to_left = (opcode == BPF_ADD &&  off_is_neg) ||
> @@ -13776,10 +13756,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   	struct bpf_func_state *state = vstate->frame[vstate->curframe];
>   	struct bpf_reg_state *regs = state->regs, *dst_reg;
>   	bool known = tnum_is_const(off_reg->var_off);
> -	s64 smin_val = off_reg->smin_value, smax_val = off_reg->smax_value,
> -	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
> -	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
> -	    umin_ptr = ptr_reg->umin_value, umax_ptr = ptr_reg->umax_value;
> +	s64 smin_val = reg_smin(off_reg), smax_val = reg_smax(off_reg),
> +	    smin_ptr = reg_smin(ptr_reg), smax_ptr = reg_smax(ptr_reg);
> +	u64 umin_val = reg_umin(off_reg), umax_val = reg_umax(off_reg),
> +	    umin_ptr = reg_umin(ptr_reg), umax_ptr = reg_umax(ptr_reg);
>   	struct bpf_sanitize_info info = {};
>   	u8 opcode = BPF_OP(insn->code);
>   	u32 dst = insn->dst_reg;
> @@ -13881,15 +13861,22 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   		 * added into the variable offset, and we copy the fixed offset
>   		 * from ptr_reg.
>   		 */
> -		if (check_add_overflow(smin_ptr, smin_val, &dst_reg->smin_value) ||
> -		    check_add_overflow(smax_ptr, smax_val, &dst_reg->smax_value)) {
> -			dst_reg->smin_value = S64_MIN;
> -			dst_reg->smax_value = S64_MAX;
> +		{
> +		s64 smin_res, smax_res;
> +		u64 umin_res, umax_res;
> +
> +		if (check_add_overflow(smin_ptr, smin_val, &smin_res) ||
> +		    check_add_overflow(smax_ptr, smax_val, &smax_res)) {
> +			reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
> +		} else {
> +			reg_set_srange64(dst_reg, smin_res, smax_res);
> +		}
> +		if (check_add_overflow(umin_ptr, umin_val, &umin_res) ||
> +		    check_add_overflow(umax_ptr, umax_val, &umax_res)) {
> +			reg_set_urange64(dst_reg, 0, U64_MAX);
> +		} else {
> +			reg_set_urange64(dst_reg, umin_res, umax_res);
>   		}
> -		if (check_add_overflow(umin_ptr, umin_val, &dst_reg->umin_value) ||
> -		    check_add_overflow(umax_ptr, umax_val, &dst_reg->umax_value)) {
> -			dst_reg->umin_value = 0;
> -			dst_reg->umax_value = U64_MAX;
>   		}
>   		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
>   		dst_reg->raw = ptr_reg->raw;
> @@ -13925,20 +13912,23 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   		/* A new variable offset is created.  If the subtrahend is known
>   		 * nonnegative, then any reg->range we had before is still good.
>   		 */
> -		if (check_sub_overflow(smin_ptr, smax_val, &dst_reg->smin_value) ||
> -		    check_sub_overflow(smax_ptr, smin_val, &dst_reg->smax_value)) {
> +		{
> +		s64 smin_res, smax_res;
> +
> +		if (check_sub_overflow(smin_ptr, smax_val, &smin_res) ||
> +		    check_sub_overflow(smax_ptr, smin_val, &smax_res)) {
>   			/* Overflow possible, we know nothing */
> -			dst_reg->smin_value = S64_MIN;
> -			dst_reg->smax_value = S64_MAX;
> +			reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
> +		} else {
> +			reg_set_srange64(dst_reg, smin_res, smax_res);
> +		}
>   		}
>   		if (umin_ptr < umax_val) {
>   			/* Overflow possible, we know nothing */
> -			dst_reg->umin_value = 0;
> -			dst_reg->umax_value = U64_MAX;
> +			reg_set_urange64(dst_reg, 0, U64_MAX);
>   		} else {
>   			/* Cannot overflow (as long as bounds are consistent) */
> -			dst_reg->umin_value = umin_ptr - umax_val;
> -			dst_reg->umax_value = umax_ptr - umin_val;
> +			reg_set_urange64(dst_reg, umin_ptr - umax_val, umax_ptr - umin_val);
>   		}
>   		dst_reg->var_off = tnum_sub(ptr_reg->var_off, off_reg->var_off);
>   		dst_reg->raw = ptr_reg->raw;
> @@ -13996,18 +13986,18 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>   static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
>   				 struct bpf_reg_state *src_reg)
>   {
> -	s32 *dst_smin = &dst_reg->s32_min_value;
> -	s32 *dst_smax = &dst_reg->s32_max_value;
> -	u32 *dst_umin = &dst_reg->u32_min_value;
> -	u32 *dst_umax = &dst_reg->u32_max_value;
> -	u32 umin_val = src_reg->u32_min_value;
> -	u32 umax_val = src_reg->u32_max_value;
> +	s32 smin = reg_s32_min(dst_reg);
> +	s32 smax = reg_s32_max(dst_reg);
> +	u32 umin = reg_u32_min(dst_reg);
> +	u32 umax = reg_u32_max(dst_reg);
> +	u32 umin_val = reg_u32_min(src_reg);
> +	u32 umax_val = reg_u32_max(src_reg);
>   	bool min_overflow, max_overflow;
>   
> -	if (check_add_overflow(*dst_smin, src_reg->s32_min_value, dst_smin) ||
> -	    check_add_overflow(*dst_smax, src_reg->s32_max_value, dst_smax)) {
> -		*dst_smin = S32_MIN;
> -		*dst_smax = S32_MAX;
> +	if (check_add_overflow(smin, reg_s32_min(src_reg), &smin) ||
> +	    check_add_overflow(smax, reg_s32_max(src_reg), &smax)) {
> +		smin = S32_MIN;
> +		smax = S32_MAX;
>   	}
>   
>   	/* If either all additions overflow or no additions overflow, then
> @@ -14015,30 +14005,33 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
>   	 * dst_umax + src_umax. Otherwise (some additions overflow), set
>   	 * the output bounds to unbounded.
>   	 */
> -	min_overflow = check_add_overflow(*dst_umin, umin_val, dst_umin);
> -	max_overflow = check_add_overflow(*dst_umax, umax_val, dst_umax);
> +	min_overflow = check_add_overflow(umin, umin_val, &umin);
> +	max_overflow = check_add_overflow(umax, umax_val, &umax);
>   
>   	if (!min_overflow && max_overflow) {
> -		*dst_umin = 0;
> -		*dst_umax = U32_MAX;
> +		umin = 0;
> +		umax = U32_MAX;
>   	}
> +
> +	reg_set_srange32(dst_reg, smin, smax);
> +	reg_set_urange32(dst_reg, umin, umax);
>   }
>   
>   static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
>   			       struct bpf_reg_state *src_reg)
>   {
> -	s64 *dst_smin = &dst_reg->smin_value;
> -	s64 *dst_smax = &dst_reg->smax_value;
> -	u64 *dst_umin = &dst_reg->umin_value;
> -	u64 *dst_umax = &dst_reg->umax_value;
> -	u64 umin_val = src_reg->umin_value;
> -	u64 umax_val = src_reg->umax_value;
> +	s64 smin = reg_smin(dst_reg);
> +	s64 smax = reg_smax(dst_reg);
> +	u64 umin = reg_umin(dst_reg);
> +	u64 umax = reg_umax(dst_reg);
> +	u64 umin_val = reg_umin(src_reg);
> +	u64 umax_val = reg_umax(src_reg);
>   	bool min_overflow, max_overflow;
>   
> -	if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
> -	    check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax)) {
> -		*dst_smin = S64_MIN;
> -		*dst_smax = S64_MAX;
> +	if (check_add_overflow(smin, reg_smin(src_reg), &smin) ||
> +	    check_add_overflow(smax, reg_smax(src_reg), &smax)) {
> +		smin = S64_MIN;
> +		smax = S64_MAX;
>   	}
>   
>   	/* If either all additions overflow or no additions overflow, then
> @@ -14046,31 +14039,34 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
>   	 * dst_umax + src_umax. Otherwise (some additions overflow), set
>   	 * the output bounds to unbounded.
>   	 */
> -	min_overflow = check_add_overflow(*dst_umin, umin_val, dst_umin);
> -	max_overflow = check_add_overflow(*dst_umax, umax_val, dst_umax);
> +	min_overflow = check_add_overflow(umin, umin_val, &umin);
> +	max_overflow = check_add_overflow(umax, umax_val, &umax);
>   
>   	if (!min_overflow && max_overflow) {
> -		*dst_umin = 0;
> -		*dst_umax = U64_MAX;
> +		umin = 0;
> +		umax = U64_MAX;
>   	}
> +
> +	reg_set_srange64(dst_reg, smin, smax);
> +	reg_set_urange64(dst_reg, umin, umax);
>   }
>   
>   static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
>   				 struct bpf_reg_state *src_reg)
>   {
> -	s32 *dst_smin = &dst_reg->s32_min_value;
> -	s32 *dst_smax = &dst_reg->s32_max_value;
> -	u32 *dst_umin = &dst_reg->u32_min_value;
> -	u32 *dst_umax = &dst_reg->u32_max_value;
> -	u32 umin_val = src_reg->u32_min_value;
> -	u32 umax_val = src_reg->u32_max_value;
> +	s32 smin = reg_s32_min(dst_reg);
> +	s32 smax = reg_s32_max(dst_reg);
> +	u32 umin = reg_u32_min(dst_reg);
> +	u32 umax = reg_u32_max(dst_reg);
> +	u32 umin_val = reg_u32_min(src_reg);
> +	u32 umax_val = reg_u32_max(src_reg);
>   	bool min_underflow, max_underflow;
>   
> -	if (check_sub_overflow(*dst_smin, src_reg->s32_max_value, dst_smin) ||
> -	    check_sub_overflow(*dst_smax, src_reg->s32_min_value, dst_smax)) {
> +	if (check_sub_overflow(smin, reg_s32_max(src_reg), &smin) ||
> +	    check_sub_overflow(smax, reg_s32_min(src_reg), &smax)) {
>   		/* Overflow possible, we know nothing */
> -		*dst_smin = S32_MIN;
> -		*dst_smax = S32_MAX;
> +		smin = S32_MIN;
> +		smax = S32_MAX;
>   	}
>   
>   	/* If either all subtractions underflow or no subtractions
> @@ -14078,31 +14074,34 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
>   	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
>   	 * underflow), set the output bounds to unbounded.
>   	 */
> -	min_underflow = check_sub_overflow(*dst_umin, umax_val, dst_umin);
> -	max_underflow = check_sub_overflow(*dst_umax, umin_val, dst_umax);
> +	min_underflow = check_sub_overflow(umin, umax_val, &umin);
> +	max_underflow = check_sub_overflow(umax, umin_val, &umax);
>   
>   	if (min_underflow && !max_underflow) {
> -		*dst_umin = 0;
> -		*dst_umax = U32_MAX;
> +		umin = 0;
> +		umax = U32_MAX;
>   	}
> +
> +	reg_set_srange32(dst_reg, smin, smax);
> +	reg_set_urange32(dst_reg, umin, umax);
>   }
>   
>   static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
>   			       struct bpf_reg_state *src_reg)
>   {
> -	s64 *dst_smin = &dst_reg->smin_value;
> -	s64 *dst_smax = &dst_reg->smax_value;
> -	u64 *dst_umin = &dst_reg->umin_value;
> -	u64 *dst_umax = &dst_reg->umax_value;
> -	u64 umin_val = src_reg->umin_value;
> -	u64 umax_val = src_reg->umax_value;
> +	s64 smin = reg_smin(dst_reg);
> +	s64 smax = reg_smax(dst_reg);
> +	u64 umin = reg_umin(dst_reg);
> +	u64 umax = reg_umax(dst_reg);
> +	u64 umin_val = reg_umin(src_reg);
> +	u64 umax_val = reg_umax(src_reg);
>   	bool min_underflow, max_underflow;
>   
> -	if (check_sub_overflow(*dst_smin, src_reg->smax_value, dst_smin) ||
> -	    check_sub_overflow(*dst_smax, src_reg->smin_value, dst_smax)) {
> +	if (check_sub_overflow(smin, reg_smax(src_reg), &smin) ||
> +	    check_sub_overflow(smax, reg_smin(src_reg), &smax)) {
>   		/* Overflow possible, we know nothing */
> -		*dst_smin = S64_MIN;
> -		*dst_smax = S64_MAX;
> +		smin = S64_MIN;
> +		smax = S64_MAX;
>   	}
>   
>   	/* If either all subtractions underflow or no subtractions
> @@ -14110,113 +14109,116 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
>   	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
>   	 * underflow), set the output bounds to unbounded.
>   	 */
> -	min_underflow = check_sub_overflow(*dst_umin, umax_val, dst_umin);
> -	max_underflow = check_sub_overflow(*dst_umax, umin_val, dst_umax);
> +	min_underflow = check_sub_overflow(umin, umax_val, &umin);
> +	max_underflow = check_sub_overflow(umax, umin_val, &umax);
>   
>   	if (min_underflow && !max_underflow) {
> -		*dst_umin = 0;
> -		*dst_umax = U64_MAX;
> +		umin = 0;
> +		umax = U64_MAX;
>   	}
> +
> +	reg_set_srange64(dst_reg, smin, smax);
> +	reg_set_urange64(dst_reg, umin, umax);
>   }
>   
>   static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
>   				 struct bpf_reg_state *src_reg)
>   {
> -	s32 *dst_smin = &dst_reg->s32_min_value;
> -	s32 *dst_smax = &dst_reg->s32_max_value;
> -	u32 *dst_umin = &dst_reg->u32_min_value;
> -	u32 *dst_umax = &dst_reg->u32_max_value;
> +	s32 smin = reg_s32_min(dst_reg);
> +	s32 smax = reg_s32_max(dst_reg);
> +	u32 umin = reg_u32_min(dst_reg);
> +	u32 umax = reg_u32_max(dst_reg);
>   	s32 tmp_prod[4];
>   
> -	if (check_mul_overflow(*dst_umax, src_reg->u32_max_value, dst_umax) ||
> -	    check_mul_overflow(*dst_umin, src_reg->u32_min_value, dst_umin)) {
> +	if (check_mul_overflow(umax, reg_u32_max(src_reg), &umax) ||
> +	    check_mul_overflow(umin, reg_u32_min(src_reg), &umin)) {
>   		/* Overflow possible, we know nothing */
> -		*dst_umin = 0;
> -		*dst_umax = U32_MAX;
> +		umin = 0;
> +		umax = U32_MAX;
>   	}
> -	if (check_mul_overflow(*dst_smin, src_reg->s32_min_value, &tmp_prod[0]) ||
> -	    check_mul_overflow(*dst_smin, src_reg->s32_max_value, &tmp_prod[1]) ||
> -	    check_mul_overflow(*dst_smax, src_reg->s32_min_value, &tmp_prod[2]) ||
> -	    check_mul_overflow(*dst_smax, src_reg->s32_max_value, &tmp_prod[3])) {
> +	if (check_mul_overflow(smin, reg_s32_min(src_reg), &tmp_prod[0]) ||
> +	    check_mul_overflow(smin, reg_s32_max(src_reg), &tmp_prod[1]) ||
> +	    check_mul_overflow(smax, reg_s32_min(src_reg), &tmp_prod[2]) ||
> +	    check_mul_overflow(smax, reg_s32_max(src_reg), &tmp_prod[3])) {
>   		/* Overflow possible, we know nothing */
> -		*dst_smin = S32_MIN;
> -		*dst_smax = S32_MAX;
> +		smin = S32_MIN;
> +		smax = S32_MAX;
>   	} else {
> -		*dst_smin = min_array(tmp_prod, 4);
> -		*dst_smax = max_array(tmp_prod, 4);
> +		smin = min_array(tmp_prod, 4);
> +		smax = max_array(tmp_prod, 4);
>   	}
> +
> +	reg_set_srange32(dst_reg, smin, smax);
> +	reg_set_urange32(dst_reg, umin, umax);
>   }
>   
>   static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
>   			       struct bpf_reg_state *src_reg)
>   {
> -	s64 *dst_smin = &dst_reg->smin_value;
> -	s64 *dst_smax = &dst_reg->smax_value;
> -	u64 *dst_umin = &dst_reg->umin_value;
> -	u64 *dst_umax = &dst_reg->umax_value;
> +	s64 smin = reg_smin(dst_reg);
> +	s64 smax = reg_smax(dst_reg);
> +	u64 umin = reg_umin(dst_reg);
> +	u64 umax = reg_umax(dst_reg);
>   	s64 tmp_prod[4];
>   
> -	if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
> -	    check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin)) {
> +	if (check_mul_overflow(umax, reg_umax(src_reg), &umax) ||
> +	    check_mul_overflow(umin, reg_umin(src_reg), &umin)) {
>   		/* Overflow possible, we know nothing */
> -		*dst_umin = 0;
> -		*dst_umax = U64_MAX;
> +		umin = 0;
> +		umax = U64_MAX;
>   	}
> -	if (check_mul_overflow(*dst_smin, src_reg->smin_value, &tmp_prod[0]) ||
> -	    check_mul_overflow(*dst_smin, src_reg->smax_value, &tmp_prod[1]) ||
> -	    check_mul_overflow(*dst_smax, src_reg->smin_value, &tmp_prod[2]) ||
> -	    check_mul_overflow(*dst_smax, src_reg->smax_value, &tmp_prod[3])) {
> +	if (check_mul_overflow(smin, reg_smin(src_reg), &tmp_prod[0]) ||
> +	    check_mul_overflow(smin, reg_smax(src_reg), &tmp_prod[1]) ||
> +	    check_mul_overflow(smax, reg_smin(src_reg), &tmp_prod[2]) ||
> +	    check_mul_overflow(smax, reg_smax(src_reg), &tmp_prod[3])) {
>   		/* Overflow possible, we know nothing */
> -		*dst_smin = S64_MIN;
> -		*dst_smax = S64_MAX;
> +		smin = S64_MIN;
> +		smax = S64_MAX;
>   	} else {
> -		*dst_smin = min_array(tmp_prod, 4);
> -		*dst_smax = max_array(tmp_prod, 4);
> +		smin = min_array(tmp_prod, 4);
> +		smax = max_array(tmp_prod, 4);
>   	}
> +
> +	reg_set_srange64(dst_reg, smin, smax);
> +	reg_set_urange64(dst_reg, umin, umax);
>   }
>   
>   static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
>   				  struct bpf_reg_state *src_reg)
>   {
> -	u32 *dst_umin = &dst_reg->u32_min_value;
> -	u32 *dst_umax = &dst_reg->u32_max_value;
> -	u32 src_val = src_reg->u32_min_value; /* non-zero, const divisor */
> +	u32 src_val = reg_u32_min(src_reg); /* non-zero, const divisor */
>   
> -	*dst_umin = *dst_umin / src_val;
> -	*dst_umax = *dst_umax / src_val;
> +	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) / src_val,
> +			 reg_u32_max(dst_reg) / src_val);
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->s32_min_value = S32_MIN;
> -	dst_reg->s32_max_value = S32_MAX;
> +	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   	reset_reg64_and_tnum(dst_reg);
>   }
>   
>   static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
>   				struct bpf_reg_state *src_reg)
>   {
> -	u64 *dst_umin = &dst_reg->umin_value;
> -	u64 *dst_umax = &dst_reg->umax_value;
> -	u64 src_val = src_reg->umin_value; /* non-zero, const divisor */
> +	u64 src_val = reg_umin(src_reg); /* non-zero, const divisor */
>   
> -	*dst_umin = div64_u64(*dst_umin, src_val);
> -	*dst_umax = div64_u64(*dst_umax, src_val);
> +	reg_set_urange64(dst_reg, div64_u64(reg_umin(dst_reg), src_val),
> +			 div64_u64(reg_umax(dst_reg), src_val));
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->smin_value = S64_MIN;
> -	dst_reg->smax_value = S64_MAX;
> +	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   	reset_reg32_and_tnum(dst_reg);
>   }
>   
>   static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
>   				  struct bpf_reg_state *src_reg)
>   {
> -	s32 *dst_smin = &dst_reg->s32_min_value;
> -	s32 *dst_smax = &dst_reg->s32_max_value;
> -	s32 src_val = src_reg->s32_min_value; /* non-zero, const divisor */
> +	s32 smin = reg_s32_min(dst_reg);
> +	s32 smax = reg_s32_max(dst_reg);
> +	s32 src_val = reg_s32_min(src_reg); /* non-zero, const divisor */
>   	s32 res1, res2;
>   
>   	/* BPF div specification: S32_MIN / -1 = S32_MIN */
> -	if (*dst_smin == S32_MIN && src_val == -1) {
> +	if (smin == S32_MIN && src_val == -1) {
>   		/*
>   		 * If the dividend range contains more than just S32_MIN,
>   		 * we cannot precisely track the result, so it becomes unbounded.
> @@ -14225,35 +14227,35 @@ static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
>   		 *     = {S32_MIN} U [S32_MAX-9, S32_MAX] = [S32_MIN, S32_MAX]
>   		 * Otherwise (if dividend is exactly S32_MIN), result remains S32_MIN.
>   		 */
> -		if (*dst_smax != S32_MIN) {
> -			*dst_smin = S32_MIN;
> -			*dst_smax = S32_MAX;
> +		if (smax != S32_MIN) {
> +			smin = S32_MIN;
> +			smax = S32_MAX;
>   		}
>   		goto reset;
>   	}
>   
> -	res1 = *dst_smin / src_val;
> -	res2 = *dst_smax / src_val;
> -	*dst_smin = min(res1, res2);
> -	*dst_smax = max(res1, res2);
> +	res1 = smin / src_val;
> +	res2 = smax / src_val;
> +	smin = min(res1, res2);
> +	smax = max(res1, res2);
>   
>   reset:
> +	reg_set_srange32(dst_reg, smin, smax);
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->u32_min_value = 0;
> -	dst_reg->u32_max_value = U32_MAX;
> +	reg_set_urange32(dst_reg, 0, U32_MAX);
>   	reset_reg64_and_tnum(dst_reg);
>   }
>   
>   static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
>   				struct bpf_reg_state *src_reg)
>   {
> -	s64 *dst_smin = &dst_reg->smin_value;
> -	s64 *dst_smax = &dst_reg->smax_value;
> -	s64 src_val = src_reg->smin_value; /* non-zero, const divisor */
> +	s64 smin = reg_smin(dst_reg);
> +	s64 smax = reg_smax(dst_reg);
> +	s64 src_val = reg_smin(src_reg); /* non-zero, const divisor */
>   	s64 res1, res2;
>   
>   	/* BPF div specification: S64_MIN / -1 = S64_MIN */
> -	if (*dst_smin == S64_MIN && src_val == -1) {
> +	if (smin == S64_MIN && src_val == -1) {
>   		/*
>   		 * If the dividend range contains more than just S64_MIN,
>   		 * we cannot precisely track the result, so it becomes unbounded.
> @@ -14262,79 +14264,69 @@ static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
>   		 *     = {S64_MIN} U [S64_MAX-9, S64_MAX] = [S64_MIN, S64_MAX]
>   		 * Otherwise (if dividend is exactly S64_MIN), result remains S64_MIN.
>   		 */
> -		if (*dst_smax != S64_MIN) {
> -			*dst_smin = S64_MIN;
> -			*dst_smax = S64_MAX;
> +		if (smax != S64_MIN) {
> +			smin = S64_MIN;
> +			smax = S64_MAX;
>   		}
>   		goto reset;
>   	}
>   
> -	res1 = div64_s64(*dst_smin, src_val);
> -	res2 = div64_s64(*dst_smax, src_val);
> -	*dst_smin = min(res1, res2);
> -	*dst_smax = max(res1, res2);
> +	res1 = div64_s64(smin, src_val);
> +	res2 = div64_s64(smax, src_val);
> +	smin = min(res1, res2);
> +	smax = max(res1, res2);
>   
>   reset:
> +	reg_set_srange64(dst_reg, smin, smax);
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->umin_value = 0;
> -	dst_reg->umax_value = U64_MAX;
> +	reg_set_urange64(dst_reg, 0, U64_MAX);
>   	reset_reg32_and_tnum(dst_reg);
>   }
>   
>   static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
>   				  struct bpf_reg_state *src_reg)
>   {
> -	u32 *dst_umin = &dst_reg->u32_min_value;
> -	u32 *dst_umax = &dst_reg->u32_max_value;
> -	u32 src_val = src_reg->u32_min_value; /* non-zero, const divisor */
> +	u32 src_val = reg_u32_min(src_reg); /* non-zero, const divisor */
>   	u32 res_max = src_val - 1;
>   
>   	/*
>   	 * If dst_umax <= res_max, the result remains unchanged.
>   	 * e.g., [2, 5] % 10 = [2, 5].
>   	 */
> -	if (*dst_umax <= res_max)
> +	if (reg_u32_max(dst_reg) <= res_max)
>   		return;
>   
> -	*dst_umin = 0;
> -	*dst_umax = min(*dst_umax, res_max);
> +	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), res_max));
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->s32_min_value = S32_MIN;
> -	dst_reg->s32_max_value = S32_MAX;
> +	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   	reset_reg64_and_tnum(dst_reg);
>   }
>   
>   static void scalar_min_max_umod(struct bpf_reg_state *dst_reg,
>   				struct bpf_reg_state *src_reg)
>   {
> -	u64 *dst_umin = &dst_reg->umin_value;
> -	u64 *dst_umax = &dst_reg->umax_value;
> -	u64 src_val = src_reg->umin_value; /* non-zero, const divisor */
> +	u64 src_val = reg_umin(src_reg); /* non-zero, const divisor */
>   	u64 res_max = src_val - 1;
>   
>   	/*
>   	 * If dst_umax <= res_max, the result remains unchanged.
>   	 * e.g., [2, 5] % 10 = [2, 5].
>   	 */
> -	if (*dst_umax <= res_max)
> +	if (reg_umax(dst_reg) <= res_max)
>   		return;
>   
> -	*dst_umin = 0;
> -	*dst_umax = min(*dst_umax, res_max);
> +	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), res_max));
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->smin_value = S64_MIN;
> -	dst_reg->smax_value = S64_MAX;
> +	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   	reset_reg32_and_tnum(dst_reg);
>   }
>   
>   static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
>   				  struct bpf_reg_state *src_reg)
>   {
> -	s32 *dst_smin = &dst_reg->s32_min_value;
> -	s32 *dst_smax = &dst_reg->s32_max_value;
> -	s32 src_val = src_reg->s32_min_value; /* non-zero, const divisor */
> +	s32 src_val = reg_s32_min(src_reg); /* non-zero, const divisor */
>   
>   	/*
>   	 * Safe absolute value calculation:
> @@ -14354,33 +14346,27 @@ static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
>   	 * If the dividend is already within the result range,
>   	 * the result remains unchanged. e.g., [-2, 5] % 10 = [-2, 5].
>   	 */
> -	if (*dst_smin >= -res_max_abs && *dst_smax <= res_max_abs)
> +	if (reg_s32_min(dst_reg) >= -res_max_abs && reg_s32_max(dst_reg) <= res_max_abs)
>   		return;
>   
>   	/* General case: result has the same sign as the dividend. */
> -	if (*dst_smin >= 0) {
> -		*dst_smin = 0;
> -		*dst_smax = min(*dst_smax, res_max_abs);
> -	} else if (*dst_smax <= 0) {
> -		*dst_smax = 0;
> -		*dst_smin = max(*dst_smin, -res_max_abs);
> +	if (reg_s32_min(dst_reg) >= 0) {
> +		reg_set_srange32(dst_reg, 0, min(reg_s32_max(dst_reg), res_max_abs));
> +	} else if (reg_s32_max(dst_reg) <= 0) {
> +		reg_set_srange32(dst_reg, max(reg_s32_min(dst_reg), -res_max_abs), 0);
>   	} else {
> -		*dst_smin = -res_max_abs;
> -		*dst_smax = res_max_abs;
> +		reg_set_srange32(dst_reg, -res_max_abs, res_max_abs);
>   	}
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->u32_min_value = 0;
> -	dst_reg->u32_max_value = U32_MAX;
> +	reg_set_urange32(dst_reg, 0, U32_MAX);
>   	reset_reg64_and_tnum(dst_reg);
>   }
>   
>   static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
>   				struct bpf_reg_state *src_reg)
>   {
> -	s64 *dst_smin = &dst_reg->smin_value;
> -	s64 *dst_smax = &dst_reg->smax_value;
> -	s64 src_val = src_reg->smin_value; /* non-zero, const divisor */
> +	s64 src_val = reg_smin(src_reg); /* non-zero, const divisor */
>   
>   	/*
>   	 * Safe absolute value calculation:
> @@ -14400,24 +14386,20 @@ static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
>   	 * If the dividend is already within the result range,
>   	 * the result remains unchanged. e.g., [-2, 5] % 10 = [-2, 5].
>   	 */
> -	if (*dst_smin >= -res_max_abs && *dst_smax <= res_max_abs)
> +	if (reg_smin(dst_reg) >= -res_max_abs && reg_smax(dst_reg) <= res_max_abs)
>   		return;
>   
>   	/* General case: result has the same sign as the dividend. */
> -	if (*dst_smin >= 0) {
> -		*dst_smin = 0;
> -		*dst_smax = min(*dst_smax, res_max_abs);
> -	} else if (*dst_smax <= 0) {
> -		*dst_smax = 0;
> -		*dst_smin = max(*dst_smin, -res_max_abs);
> +	if (reg_smin(dst_reg) >= 0) {
> +		reg_set_srange64(dst_reg, 0, min(reg_smax(dst_reg), res_max_abs));
> +	} else if (reg_smax(dst_reg) <= 0) {
> +		reg_set_srange64(dst_reg, max(reg_smin(dst_reg), -res_max_abs), 0);
>   	} else {
> -		*dst_smin = -res_max_abs;
> -		*dst_smax = res_max_abs;
> +		reg_set_srange64(dst_reg, -res_max_abs, res_max_abs);
>   	}
>   
>   	/* Reset other ranges/tnum to unbounded/unknown. */
> -	dst_reg->umin_value = 0;
> -	dst_reg->umax_value = U64_MAX;
> +	reg_set_urange64(dst_reg, 0, U64_MAX);
>   	reset_reg32_and_tnum(dst_reg);
>   }
>   
> @@ -14427,7 +14409,7 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>   	bool src_known = tnum_subreg_is_const(src_reg->var_off);
>   	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
>   	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
> -	u32 umax_val = src_reg->u32_max_value;
> +	u32 umax_val = reg_u32_max(src_reg);
>   
>   	if (src_known && dst_known) {
>   		__mark_reg32_known(dst_reg, var32_off.value);
> @@ -14437,19 +14419,15 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>   	/* We get our minimum from the var_off, since that's inherently
>   	 * bitwise.  Our maximum is the minimum of the operands' maxima.
>   	 */
> -	dst_reg->u32_min_value = var32_off.value;
> -	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
> +	reg_set_urange32(dst_reg, var32_off.value, min(reg_u32_max(dst_reg), umax_val));
>   
>   	/* Safe to set s32 bounds by casting u32 result into s32 when u32
>   	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
>   	 */
> -	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
> -		dst_reg->s32_min_value = dst_reg->u32_min_value;
> -		dst_reg->s32_max_value = dst_reg->u32_max_value;
> -	} else {
> -		dst_reg->s32_min_value = S32_MIN;
> -		dst_reg->s32_max_value = S32_MAX;
> -	}
> +	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
> +		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
> +	else
> +		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   }
>   
>   static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
> @@ -14457,7 +14435,7 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
>   {
>   	bool src_known = tnum_is_const(src_reg->var_off);
>   	bool dst_known = tnum_is_const(dst_reg->var_off);
> -	u64 umax_val = src_reg->umax_value;
> +	u64 umax_val = reg_umax(src_reg);
>   
>   	if (src_known && dst_known) {
>   		__mark_reg_known(dst_reg, dst_reg->var_off.value);
> @@ -14467,19 +14445,15 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
>   	/* We get our minimum from the var_off, since that's inherently
>   	 * bitwise.  Our maximum is the minimum of the operands' maxima.
>   	 */
> -	dst_reg->umin_value = dst_reg->var_off.value;
> -	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
> +	reg_set_urange64(dst_reg, dst_reg->var_off.value, min(reg_umax(dst_reg), umax_val));
>   
>   	/* Safe to set s64 bounds by casting u64 result into s64 when u64
>   	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
>   	 */
> -	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> -		dst_reg->smin_value = dst_reg->umin_value;
> -		dst_reg->smax_value = dst_reg->umax_value;
> -	} else {
> -		dst_reg->smin_value = S64_MIN;
> -		dst_reg->smax_value = S64_MAX;
> -	}
> +	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
> +		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
> +	else
> +		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   	/* We may learn something more from the var_off */
>   	__update_reg_bounds(dst_reg);
>   }
> @@ -14490,7 +14464,7 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
>   	bool src_known = tnum_subreg_is_const(src_reg->var_off);
>   	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
>   	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
> -	u32 umin_val = src_reg->u32_min_value;
> +	u32 umin_val = reg_u32_min(src_reg);
>   
>   	if (src_known && dst_known) {
>   		__mark_reg32_known(dst_reg, var32_off.value);
> @@ -14500,19 +14474,16 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
>   	/* We get our maximum from the var_off, and our minimum is the
>   	 * maximum of the operands' minima
>   	 */
> -	dst_reg->u32_min_value = max(dst_reg->u32_min_value, umin_val);
> -	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
> +	reg_set_urange32(dst_reg, max(reg_u32_min(dst_reg), umin_val),
> +			 var32_off.value | var32_off.mask);
>   
>   	/* Safe to set s32 bounds by casting u32 result into s32 when u32
>   	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
>   	 */
> -	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
> -		dst_reg->s32_min_value = dst_reg->u32_min_value;
> -		dst_reg->s32_max_value = dst_reg->u32_max_value;
> -	} else {
> -		dst_reg->s32_min_value = S32_MIN;
> -		dst_reg->s32_max_value = S32_MAX;
> -	}
> +	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
> +		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
> +	else
> +		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   }
>   
>   static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
> @@ -14520,7 +14491,7 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
>   {
>   	bool src_known = tnum_is_const(src_reg->var_off);
>   	bool dst_known = tnum_is_const(dst_reg->var_off);
> -	u64 umin_val = src_reg->umin_value;
> +	u64 umin_val = reg_umin(src_reg);
>   
>   	if (src_known && dst_known) {
>   		__mark_reg_known(dst_reg, dst_reg->var_off.value);
> @@ -14530,19 +14501,16 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
>   	/* We get our maximum from the var_off, and our minimum is the
>   	 * maximum of the operands' minima
>   	 */
> -	dst_reg->umin_value = max(dst_reg->umin_value, umin_val);
> -	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
> +	reg_set_urange64(dst_reg, max(reg_umin(dst_reg), umin_val),
> +			 dst_reg->var_off.value | dst_reg->var_off.mask);
>   
>   	/* Safe to set s64 bounds by casting u64 result into s64 when u64
>   	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
>   	 */
> -	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> -		dst_reg->smin_value = dst_reg->umin_value;
> -		dst_reg->smax_value = dst_reg->umax_value;
> -	} else {
> -		dst_reg->smin_value = S64_MIN;
> -		dst_reg->smax_value = S64_MAX;
> -	}
> +	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
> +		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
> +	else
> +		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   	/* We may learn something more from the var_off */
>   	__update_reg_bounds(dst_reg);
>   }
> @@ -14560,19 +14528,15 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
>   	}
>   
>   	/* We get both minimum and maximum from the var32_off. */
> -	dst_reg->u32_min_value = var32_off.value;
> -	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
> +	reg_set_urange32(dst_reg, var32_off.value, var32_off.value | var32_off.mask);
>   
>   	/* Safe to set s32 bounds by casting u32 result into s32 when u32
>   	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
>   	 */
> -	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
> -		dst_reg->s32_min_value = dst_reg->u32_min_value;
> -		dst_reg->s32_max_value = dst_reg->u32_max_value;
> -	} else {
> -		dst_reg->s32_min_value = S32_MIN;
> -		dst_reg->s32_max_value = S32_MAX;
> -	}
> +	if ((s32)reg_u32_min(dst_reg) <= (s32)reg_u32_max(dst_reg))
> +		reg_set_srange32(dst_reg, reg_u32_min(dst_reg), reg_u32_max(dst_reg));
> +	else
> +		reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   }
>   
>   static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
> @@ -14588,19 +14552,16 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
>   	}
>   
>   	/* We get both minimum and maximum from the var_off. */
> -	dst_reg->umin_value = dst_reg->var_off.value;
> -	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
> +	reg_set_urange64(dst_reg, dst_reg->var_off.value,
> +			 dst_reg->var_off.value | dst_reg->var_off.mask);
>   
>   	/* Safe to set s64 bounds by casting u64 result into s64 when u64
>   	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
>   	 */
> -	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> -		dst_reg->smin_value = dst_reg->umin_value;
> -		dst_reg->smax_value = dst_reg->umax_value;
> -	} else {
> -		dst_reg->smin_value = S64_MIN;
> -		dst_reg->smax_value = S64_MAX;
> -	}
> +	if ((s64)reg_umin(dst_reg) <= (s64)reg_umax(dst_reg))
> +		reg_set_srange64(dst_reg, reg_umin(dst_reg), reg_umax(dst_reg));
> +	else
> +		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   
>   	__update_reg_bounds(dst_reg);
>   }
> @@ -14611,23 +14572,20 @@ static void __scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
>   	/* We lose all sign bit information (except what we can pick
>   	 * up from var_off)
>   	 */
> -	dst_reg->s32_min_value = S32_MIN;
> -	dst_reg->s32_max_value = S32_MAX;
> +	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   	/* If we might shift our top bit out, then we know nothing */
> -	if (umax_val > 31 || dst_reg->u32_max_value > 1ULL << (31 - umax_val)) {
> -		dst_reg->u32_min_value = 0;
> -		dst_reg->u32_max_value = U32_MAX;
> -	} else {
> -		dst_reg->u32_min_value <<= umin_val;
> -		dst_reg->u32_max_value <<= umax_val;
> -	}
> +	if (umax_val > 31 || reg_u32_max(dst_reg) > 1ULL << (31 - umax_val))
> +		reg_set_urange32(dst_reg, 0, U32_MAX);
> +	else
> +		reg_set_urange32(dst_reg, reg_u32_min(dst_reg) << umin_val,
> +				 reg_u32_max(dst_reg) << umax_val);
>   }
>   
>   static void scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
>   				 struct bpf_reg_state *src_reg)
>   {
> -	u32 umax_val = src_reg->u32_max_value;
> -	u32 umin_val = src_reg->u32_min_value;
> +	u32 umax_val = reg_u32_max(src_reg);
> +	u32 umin_val = reg_u32_min(src_reg);
>   	/* u32 alu operation will zext upper bits */
>   	struct tnum subreg = tnum_subreg(dst_reg->var_off);
>   
> @@ -14649,29 +14607,25 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
>   	 * because s32 bounds don't flip sign when shifting to the left by
>   	 * 32bits.
>   	 */
> -	if (umin_val == 32 && umax_val == 32) {
> -		dst_reg->smax_value = (s64)dst_reg->s32_max_value << 32;
> -		dst_reg->smin_value = (s64)dst_reg->s32_min_value << 32;
> -	} else {
> -		dst_reg->smax_value = S64_MAX;
> -		dst_reg->smin_value = S64_MIN;
> -	}
> +	if (umin_val == 32 && umax_val == 32)
> +		reg_set_srange64(dst_reg, (s64)reg_s32_min(dst_reg) << 32,
> +				 (s64)reg_s32_max(dst_reg) << 32);
> +	else
> +		reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   
>   	/* If we might shift our top bit out, then we know nothing */
> -	if (dst_reg->umax_value > 1ULL << (63 - umax_val)) {
> -		dst_reg->umin_value = 0;
> -		dst_reg->umax_value = U64_MAX;
> -	} else {
> -		dst_reg->umin_value <<= umin_val;
> -		dst_reg->umax_value <<= umax_val;
> -	}
> +	if (reg_umax(dst_reg) > 1ULL << (63 - umax_val))
> +		reg_set_urange64(dst_reg, 0, U64_MAX);
> +	else
> +		reg_set_urange64(dst_reg, reg_umin(dst_reg) << umin_val,
> +				 reg_umax(dst_reg) << umax_val);
>   }
>   
>   static void scalar_min_max_lsh(struct bpf_reg_state *dst_reg,
>   			       struct bpf_reg_state *src_reg)
>   {
> -	u64 umax_val = src_reg->umax_value;
> -	u64 umin_val = src_reg->umin_value;
> +	u64 umax_val = reg_umax(src_reg);
> +	u64 umin_val = reg_umin(src_reg);
>   
>   	/* scalar64 calc uses 32bit unshifted bounds so must be called first */
>   	__scalar64_min_max_lsh(dst_reg, umin_val, umax_val);
> @@ -14686,8 +14640,8 @@ static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
>   				 struct bpf_reg_state *src_reg)
>   {
>   	struct tnum subreg = tnum_subreg(dst_reg->var_off);
> -	u32 umax_val = src_reg->u32_max_value;
> -	u32 umin_val = src_reg->u32_min_value;
> +	u32 umax_val = reg_u32_max(src_reg);
> +	u32 umin_val = reg_u32_min(src_reg);
>   
>   	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
>   	 * be negative, then either:
> @@ -14703,12 +14657,11 @@ static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
>   	 * and rely on inferring new ones from the unsigned bounds and
>   	 * var_off of the result.
>   	 */
> -	dst_reg->s32_min_value = S32_MIN;
> -	dst_reg->s32_max_value = S32_MAX;
> +	reg_set_srange32(dst_reg, S32_MIN, S32_MAX);
>   
>   	dst_reg->var_off = tnum_rshift(subreg, umin_val);
> -	dst_reg->u32_min_value >>= umax_val;
> -	dst_reg->u32_max_value >>= umin_val;
> +	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) >> umax_val,
> +			 reg_u32_max(dst_reg) >> umin_val);
>   
>   	__mark_reg64_unbounded(dst_reg);
>   	__update_reg32_bounds(dst_reg);
> @@ -14717,8 +14670,8 @@ static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
>   static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
>   			       struct bpf_reg_state *src_reg)
>   {
> -	u64 umax_val = src_reg->umax_value;
> -	u64 umin_val = src_reg->umin_value;
> +	u64 umax_val = reg_umax(src_reg);
> +	u64 umin_val = reg_umin(src_reg);
>   
>   	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
>   	 * be negative, then either:
> @@ -14734,11 +14687,10 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
>   	 * and rely on inferring new ones from the unsigned bounds and
>   	 * var_off of the result.
>   	 */
> -	dst_reg->smin_value = S64_MIN;
> -	dst_reg->smax_value = S64_MAX;
> +	reg_set_srange64(dst_reg, S64_MIN, S64_MAX);
>   	dst_reg->var_off = tnum_rshift(dst_reg->var_off, umin_val);
> -	dst_reg->umin_value >>= umax_val;
> -	dst_reg->umax_value >>= umin_val;
> +	reg_set_urange64(dst_reg, reg_umin(dst_reg) >> umax_val,
> +			 reg_umax(dst_reg) >> umin_val);
>   
>   	/* Its not easy to operate on alu32 bounds here because it depends
>   	 * on bits being shifted in. Take easy way out and mark unbounded
> @@ -14751,21 +14703,21 @@ static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
>   static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
>   				  struct bpf_reg_state *src_reg)
>   {
> -	u64 umin_val = src_reg->u32_min_value;
> +	u64 umin_val = reg_u32_min(src_reg);
>   
>   	/* Upon reaching here, src_known is true and
>   	 * umax_val is equal to umin_val.
>   	 */
> -	dst_reg->s32_min_value = (u32)(((s32)dst_reg->s32_min_value) >> umin_val);
> -	dst_reg->s32_max_value = (u32)(((s32)dst_reg->s32_max_value) >> umin_val);
> +	reg_set_srange32(dst_reg,
> +			 (u32)(((s32)reg_s32_min(dst_reg)) >> umin_val),
> +			 (u32)(((s32)reg_s32_max(dst_reg)) >> umin_val));
>   
>   	dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off), umin_val, 32);
>   
>   	/* blow away the dst_reg umin_value/umax_value and rely on
>   	 * dst_reg var_off to refine the result.
>   	 */
> -	dst_reg->u32_min_value = 0;
> -	dst_reg->u32_max_value = U32_MAX;
> +	reg_set_urange32(dst_reg, 0, U32_MAX);
>   
>   	__mark_reg64_unbounded(dst_reg);
>   	__update_reg32_bounds(dst_reg);
> @@ -14774,21 +14726,20 @@ static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
>   static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
>   				struct bpf_reg_state *src_reg)
>   {
> -	u64 umin_val = src_reg->umin_value;
> +	u64 umin_val = reg_umin(src_reg);
>   
>   	/* Upon reaching here, src_known is true and umax_val is equal
>   	 * to umin_val.
>   	 */
> -	dst_reg->smin_value >>= umin_val;
> -	dst_reg->smax_value >>= umin_val;
> +	reg_set_srange64(dst_reg, reg_smin(dst_reg) >> umin_val,
> +			 reg_smax(dst_reg) >> umin_val);
>   
>   	dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
>   
>   	/* blow away the dst_reg umin_value/umax_value and rely on
>   	 * dst_reg var_off to refine the result.
>   	 */
> -	dst_reg->umin_value = 0;
> -	dst_reg->umax_value = U64_MAX;
> +	reg_set_urange64(dst_reg, 0, U64_MAX);
>   
>   	/* Its not easy to operate on alu32 bounds here because it depends
>   	 * on bits being shifted in from upper 32-bits. Take easy way out
> @@ -14855,13 +14806,13 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>   
>   	if (insn_bitness == 32) {
>   		if (tnum_subreg_is_const(src_reg->var_off)
> -		    && src_reg->s32_min_value == src_reg->s32_max_value
> -		    && src_reg->u32_min_value == src_reg->u32_max_value)
> +		    && reg_s32_min(src_reg) == reg_s32_max(src_reg)
> +		    && reg_u32_min(src_reg) == reg_u32_max(src_reg))
>   			src_is_const = true;
>   	} else {
>   		if (tnum_is_const(src_reg->var_off)
> -		    && src_reg->smin_value == src_reg->smax_value
> -		    && src_reg->umin_value == src_reg->umax_value)
> +		    && reg_smin(src_reg) == reg_smax(src_reg)
> +		    && reg_umin(src_reg) == reg_umax(src_reg))
>   			src_is_const = true;
>   	}
>   
> @@ -14891,7 +14842,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>   	case BPF_LSH:
>   	case BPF_RSH:
>   	case BPF_ARSH:
> -		return (src_is_const && src_reg->umax_value < insn_bitness);
> +		return (src_is_const && reg_umax(src_reg) < insn_bitness);
>   	default:
>   		return false;
>   	}
> @@ -14904,9 +14855,9 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
>   	struct bpf_reg_state *regs;
>   	bool alu32;
>   
> -	if (dst_reg->smin_value == -1 && dst_reg->smax_value == 0)
> +	if (reg_smin(dst_reg) == -1 && reg_smax(dst_reg) == 0)
>   		alu32 = false;
> -	else if (dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0)
> +	else if (reg_s32_min(dst_reg) == -1 && reg_s32_max(dst_reg) == 0)
>   		alu32 = true;
>   	else
>   		return 0;
> @@ -14990,7 +14941,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   		break;
>   	case BPF_DIV:
>   		/* BPF div specification: x / 0 = 0 */
> -		if ((alu32 && src_reg.u32_min_value == 0) || (!alu32 && src_reg.umin_value == 0)) {
> +		if ((alu32 && reg_u32_min(&src_reg) == 0) || (!alu32 && reg_umin(&src_reg) == 0)) {
>   			___mark_reg_known(dst_reg, 0);
>   			break;
>   		}
> @@ -15007,7 +14958,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>   		break;
>   	case BPF_MOD:
>   		/* BPF mod specification: x % 0 = x */
> -		if ((alu32 && src_reg.u32_min_value == 0) || (!alu32 && src_reg.umin_value == 0))
> +		if ((alu32 && reg_u32_min(&src_reg) == 0) || (!alu32 && reg_umin(&src_reg) == 0))
>   			break;
>   		if (alu32)
>   			if (off == 1)
> @@ -15195,7 +15146,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>   	 * umax_value before the ALU operation. After adjust_scalar_min_max_vals(),
>   	 * alu32 ops will have zero-extended the result, making umax_value <= U32_MAX.
>   	 */
> -	u64 dst_umax = dst_reg->umax_value;
> +	u64 dst_umax = reg_umax(dst_reg);
>   
>   	err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
>   	if (err)
> @@ -15337,7 +15288,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   					} else if (src_reg->type == SCALAR_VALUE) {
>   						bool no_sext;
>   
> -						no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
> +						no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
>   						if (no_sext)
>   							assign_scalar_id_before_mov(env, src_reg);
>   						copy_register_state(dst_reg, src_reg);
> @@ -15372,7 +15323,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>   						dst_reg->subreg_def = env->insn_idx + 1;
>   					} else {
>   						/* case: W1 = (s8, s16)W2 */
> -						bool no_sext = src_reg->umax_value < (1ULL << (insn->off - 1));
> +						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
>   
>   						if (no_sext)
>   							assign_scalar_id_before_mov(env, src_reg);
> @@ -15454,17 +15405,17 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
>   	struct bpf_reg_state *reg;
>   	int new_range;
>   
> -	if (dst_reg->umax_value == 0 && range_right_open)
> +	if (reg_umax(dst_reg) == 0 && range_right_open)
>   		/* This doesn't give us any range */
>   		return;
>   
> -	if (dst_reg->umax_value > MAX_PACKET_OFF)
> +	if (reg_umax(dst_reg) > MAX_PACKET_OFF)
>   		/* Risk of overflow.  For instance, ptr + (1<<63) may be less
>   		 * than pkt_end, but that's because it's also less than pkt.
>   		 */
>   		return;
>   
> -	new_range = dst_reg->umax_value;
> +	new_range = reg_umax(dst_reg);
>   	if (range_right_open)
>   		new_range++;
>   
> @@ -15513,7 +15464,7 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
>   	/* If our ids match, then we must have the same max_value.  And we
>   	 * don't care about the other reg's fixed offset, since if it's too big
>   	 * the range won't allow anything.
> -	 * dst_reg->umax_value is known < MAX_PACKET_OFF, therefore it fits in a u16.
> +	 * reg_umax(dst_reg) is known < MAX_PACKET_OFF, therefore it fits in a u16.
>   	 */
>   	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
>   		if (reg->type == type && reg->id == dst_reg->id)
> @@ -15569,14 +15520,14 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
>   {
>   	struct tnum t1 = is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_off;
>   	struct tnum t2 = is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_off;
> -	u64 umin1 = is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_value;
> -	u64 umax1 = is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_value;
> -	s64 smin1 = is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_value;
> -	s64 smax1 = is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_value;
> -	u64 umin2 = is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_value;
> -	u64 umax2 = is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_value;
> -	s64 smin2 = is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
> -	s64 smax2 = is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
> +	u64 umin1 = is_jmp32 ? (u64)reg_u32_min(reg1) : reg_umin(reg1);
> +	u64 umax1 = is_jmp32 ? (u64)reg_u32_max(reg1) : reg_umax(reg1);
> +	s64 smin1 = is_jmp32 ? (s64)reg_s32_min(reg1) : reg_smin(reg1);
> +	s64 smax1 = is_jmp32 ? (s64)reg_s32_max(reg1) : reg_smax(reg1);
> +	u64 umin2 = is_jmp32 ? (u64)reg_u32_min(reg2) : reg_umin(reg2);
> +	u64 umax2 = is_jmp32 ? (u64)reg_u32_max(reg2) : reg_umax(reg2);
> +	s64 smin2 = is_jmp32 ? (s64)reg_s32_min(reg2) : reg_smin(reg2);
> +	s64 smax2 = is_jmp32 ? (s64)reg_s32_max(reg2) : reg_smax(reg2);
>   
>   	if (reg1 == reg2) {
>   		switch (opcode) {
> @@ -15621,11 +15572,11 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
>   			 * utilize 32-bit subrange knowledge to eliminate
>   			 * branches that can't be taken a priori
>   			 */
> -			if (reg1->u32_min_value > reg2->u32_max_value ||
> -			    reg1->u32_max_value < reg2->u32_min_value)
> +			if (reg_u32_min(reg1) > reg_u32_max(reg2) ||
> +			    reg_u32_max(reg1) < reg_u32_min(reg2))
>   				return 0;
> -			if (reg1->s32_min_value > reg2->s32_max_value ||
> -			    reg1->s32_max_value < reg2->s32_min_value)
> +			if (reg_s32_min(reg1) > reg_s32_max(reg2) ||
> +			    reg_s32_max(reg1) < reg_s32_min(reg2))
>   				return 0;
>   		}
>   		break;
> @@ -15647,11 +15598,11 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
>   			 * utilize 32-bit subrange knowledge to eliminate
>   			 * branches that can't be taken a priori
>   			 */
> -			if (reg1->u32_min_value > reg2->u32_max_value ||
> -			    reg1->u32_max_value < reg2->u32_min_value)
> +			if (reg_u32_min(reg1) > reg_u32_max(reg2) ||
> +			    reg_u32_max(reg1) < reg_u32_min(reg2))
>   				return 1;
> -			if (reg1->s32_min_value > reg2->s32_max_value ||
> -			    reg1->s32_max_value < reg2->s32_min_value)
> +			if (reg_s32_min(reg1) > reg_s32_max(reg2) ||
> +			    reg_s32_max(reg1) < reg_s32_min(reg2))
>   				return 1;
>   		}
>   		break;
> @@ -15878,27 +15829,23 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   	switch (opcode) {
>   	case BPF_JEQ:
>   		if (is_jmp32) {
> -			reg1->u32_min_value = max(reg1->u32_min_value, reg2->u32_min_value);
> -			reg1->u32_max_value = min(reg1->u32_max_value, reg2->u32_max_value);
> -			reg1->s32_min_value = max(reg1->s32_min_value, reg2->s32_min_value);
> -			reg1->s32_max_value = min(reg1->s32_max_value, reg2->s32_max_value);
> -			reg2->u32_min_value = reg1->u32_min_value;
> -			reg2->u32_max_value = reg1->u32_max_value;
> -			reg2->s32_min_value = reg1->s32_min_value;
> -			reg2->s32_max_value = reg1->s32_max_value;
> +			reg_set_urange32(reg1, max(reg_u32_min(reg1), reg_u32_min(reg2)),
> +					 min(reg_u32_max(reg1), reg_u32_max(reg2)));
> +			reg_set_srange32(reg1, max(reg_s32_min(reg1), reg_s32_min(reg2)),
> +					 min(reg_s32_max(reg1), reg_s32_max(reg2)));
> +			reg_set_urange32(reg2, reg_u32_min(reg1), reg_u32_max(reg1));
> +			reg_set_srange32(reg2, reg_s32_min(reg1), reg_s32_max(reg1));
>   
>   			t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
>   			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
>   			reg2->var_off = tnum_with_subreg(reg2->var_off, t);
>   		} else {
> -			reg1->umin_value = max(reg1->umin_value, reg2->umin_value);
> -			reg1->umax_value = min(reg1->umax_value, reg2->umax_value);
> -			reg1->smin_value = max(reg1->smin_value, reg2->smin_value);
> -			reg1->smax_value = min(reg1->smax_value, reg2->smax_value);
> -			reg2->umin_value = reg1->umin_value;
> -			reg2->umax_value = reg1->umax_value;
> -			reg2->smin_value = reg1->smin_value;
> -			reg2->smax_value = reg1->smax_value;
> +			reg_set_urange64(reg1, max(reg_umin(reg1), reg_umin(reg2)),
> +					 min(reg_umax(reg1), reg_umax(reg2)));
> +			reg_set_srange64(reg1, max(reg_smin(reg1), reg_smin(reg2)),
> +					 min(reg_smax(reg1), reg_smax(reg2)));
> +			reg_set_urange64(reg2, reg_umin(reg1), reg_umax(reg1));
> +			reg_set_srange64(reg2, reg_smin(reg1), reg_smax(reg1));
>   
>   			reg1->var_off = tnum_intersect(reg1->var_off, reg2->var_off);
>   			reg2->var_off = reg1->var_off;
> @@ -15915,8 +15862,8 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   		 */
>   		val = reg_const_value(reg2, is_jmp32);
>   		if (is_jmp32) {
> -			/* u32_min_value is not equal to 0xffffffff at this point,
> -			 * because otherwise u32_max_value is 0xffffffff as well,
> +			/* u32_min is not equal to 0xffffffff at this point,
> +			 * because otherwise u32_max is 0xffffffff as well,
>   			 * in such a case both reg1 and reg2 would be constants,
>   			 * jump would be predicted and regs_refine_cond_op()
>   			 * wouldn't be called.
> @@ -15924,23 +15871,23 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
>   			 * below.
>   			 */
> -			if (reg1->u32_min_value == (u32)val)
> -				reg1->u32_min_value++;
> -			if (reg1->u32_max_value == (u32)val)
> -				reg1->u32_max_value--;
> -			if (reg1->s32_min_value == (s32)val)
> -				reg1->s32_min_value++;
> -			if (reg1->s32_max_value == (s32)val)
> -				reg1->s32_max_value--;
> +			if (reg_u32_min(reg1) == (u32)val)
> +				reg_set_urange32(reg1, reg_u32_min(reg1) + 1, reg_u32_max(reg1));
> +			if (reg_u32_max(reg1) == (u32)val)
> +				reg_set_urange32(reg1, reg_u32_min(reg1), reg_u32_max(reg1) - 1);
> +			if (reg_s32_min(reg1) == (s32)val)
> +				reg_set_srange32(reg1, reg_s32_min(reg1) + 1, reg_s32_max(reg1));
> +			if (reg_s32_max(reg1) == (s32)val)
> +				reg_set_srange32(reg1, reg_s32_min(reg1), reg_s32_max(reg1) - 1);
>   		} else {
> -			if (reg1->umin_value == (u64)val)
> -				reg1->umin_value++;
> -			if (reg1->umax_value == (u64)val)
> -				reg1->umax_value--;
> -			if (reg1->smin_value == (s64)val)
> -				reg1->smin_value++;
> -			if (reg1->smax_value == (s64)val)
> -				reg1->smax_value--;
> +			if (reg_umin(reg1) == (u64)val)
> +				reg_set_urange64(reg1, reg_umin(reg1) + 1, reg_umax(reg1));
> +			if (reg_umax(reg1) == (u64)val)
> +				reg_set_urange64(reg1, reg_umin(reg1), reg_umax(reg1) - 1);
> +			if (reg_smin(reg1) == (s64)val)
> +				reg_set_srange64(reg1, reg_smin(reg1) + 1, reg_smax(reg1));
> +			if (reg_smax(reg1) == (s64)val)
> +				reg_set_srange64(reg1, reg_smin(reg1), reg_smax(reg1) - 1);
>   		}
>   		break;
>   	case BPF_JSET:
> @@ -15987,38 +15934,38 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   		break;
>   	case BPF_JLE:
>   		if (is_jmp32) {
> -			reg1->u32_max_value = min(reg1->u32_max_value, reg2->u32_max_value);
> -			reg2->u32_min_value = max(reg1->u32_min_value, reg2->u32_min_value);
> +			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), reg_u32_max(reg2)));
> +			reg_set_urange32(reg2, max(reg_u32_min(reg1), reg_u32_min(reg2)), reg_u32_max(reg2));
>   		} else {
> -			reg1->umax_value = min(reg1->umax_value, reg2->umax_value);
> -			reg2->umin_value = max(reg1->umin_value, reg2->umin_value);
> +			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax(reg2)));
> +			reg_set_urange64(reg2, max(reg_umin(reg1), reg_umin(reg2)), reg_umax(reg2));
>   		}
>   		break;
>   	case BPF_JLT:
>   		if (is_jmp32) {
> -			reg1->u32_max_value = min(reg1->u32_max_value, reg2->u32_max_value - 1);
> -			reg2->u32_min_value = max(reg1->u32_min_value + 1, reg2->u32_min_value);
> +			reg_set_urange32(reg1, reg_u32_min(reg1), min(reg_u32_max(reg1), reg_u32_max(reg2) - 1));
> +			reg_set_urange32(reg2, max(reg_u32_min(reg1) + 1, reg_u32_min(reg2)), reg_u32_max(reg2));
>   		} else {
> -			reg1->umax_value = min(reg1->umax_value, reg2->umax_value - 1);
> -			reg2->umin_value = max(reg1->umin_value + 1, reg2->umin_value);
> +			reg_set_urange64(reg1, reg_umin(reg1), min(reg_umax(reg1), reg_umax(reg2) - 1));
> +			reg_set_urange64(reg2, max(reg_umin(reg1) + 1, reg_umin(reg2)), reg_umax(reg2));
>   		}
>   		break;
>   	case BPF_JSLE:
>   		if (is_jmp32) {
> -			reg1->s32_max_value = min(reg1->s32_max_value, reg2->s32_max_value);
> -			reg2->s32_min_value = max(reg1->s32_min_value, reg2->s32_min_value);
> +			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), reg_s32_max(reg2)));
> +			reg_set_srange32(reg2, max(reg_s32_min(reg1), reg_s32_min(reg2)), reg_s32_max(reg2));
>   		} else {
> -			reg1->smax_value = min(reg1->smax_value, reg2->smax_value);
> -			reg2->smin_value = max(reg1->smin_value, reg2->smin_value);
> +			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax(reg2)));
> +			reg_set_srange64(reg2, max(reg_smin(reg1), reg_smin(reg2)), reg_smax(reg2));
>   		}
>   		break;
>   	case BPF_JSLT:
>   		if (is_jmp32) {
> -			reg1->s32_max_value = min(reg1->s32_max_value, reg2->s32_max_value - 1);
> -			reg2->s32_min_value = max(reg1->s32_min_value + 1, reg2->s32_min_value);
> +			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), reg_s32_max(reg2) - 1));
> +			reg_set_srange32(reg2, max(reg_s32_min(reg1) + 1, reg_s32_min(reg2)), reg_s32_max(reg2));
>   		} else {
> -			reg1->smax_value = min(reg1->smax_value, reg2->smax_value - 1);
> -			reg2->smin_value = max(reg1->smin_value + 1, reg2->smin_value);
> +			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax(reg2) - 1));
> +			reg_set_srange64(reg2, max(reg_smin(reg1) + 1, reg_smin(reg2)), reg_smax(reg2));
>   		}
>   		break;
>   	default:
> @@ -17519,16 +17466,16 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>   				       u32 *pmin_index, u32 *pmax_index)
>   {
>   	struct bpf_reg_state *reg = reg_state(env, regno);
> -	u64 min_index = reg->umin_value;
> -	u64 max_index = reg->umax_value;
> +	u64 min_index = reg_umin(reg);
> +	u64 max_index = reg_umax(reg);
>   	const u32 size = 8;
>   
>   	if (min_index > (u64) U32_MAX * size) {
> -		verbose(env, "the sum of R%u umin_value %llu is too big\n", regno, reg->umin_value);
> +		verbose(env, "the sum of R%u umin_value %llu is too big\n", regno, reg_umin(reg));
>   		return -ERANGE;
>   	}
>   	if (max_index > (u64) U32_MAX * size) {
> -		verbose(env, "the sum of R%u umax_value %llu is too big\n", regno, reg->umax_value);
> +		verbose(env, "the sum of R%u umax_value %llu is too big\n", regno, reg_umax(reg));
>   		return -ERANGE;
>   	}
>   
> 

-- 
Thanks
Kaitao Cheng

