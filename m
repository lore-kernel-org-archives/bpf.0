Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBF831F9A3
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245031; cv=none; b=ejfs9GnI7iC6sRF6tNKJAT8eezO3zvnalVrSXCOgBPctArHxPWayZVCzCwu+EgEZvNKKziIrUQN4m/lwW7UXNCsrpGXxJrJeg3W/w3y9AeG1hAJh8AU7mlKPqwCGHfuGgqmiRKgLGfqJfm9ic3Y8QQcvD1F9WCeAgxv8bUqVx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245031; c=relaxed/simple;
	bh=nfdCb+ZX2vm8iVqO0V2fUhvxyc8e4s6DcEvQGAVwJzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unRRvPTTUJiKmDlURxHbSpgi8gsCSh/0VejVcgSvYoY7xuPtk++01BHM8+1RakmcqLHork/SN6SoxJvTu8LT2sa/3eS1+7hc5djbtUDZlUfYOMGZJzPK2LaevBatYissWF8f+PJiEaOiNN1FtgupK/o2ZD/ZUru88MqAqbp99Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPKD8jkU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPKD8jkU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso187395e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773245027; x=1773849827; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaSlV2hEW5hcNc0uAEcapl0te5oFyDK8uE1cGHT+3MU=;
        b=KPKD8jkUxFyJgcw82ry/iyv2XwtUiD9b+KNWlXbIO78igvucHWOypnPqVcAF7LNyZ7
         8h4gpM/lJ3sJTvglIPsq2tPdVG5HRLvZXK03WB36JfR1ydeCvigLZTyS9xeCaUPyIK5E
         58LxI+DgzL5bUwHkT+oKlUNUDavcLVTASMxlfpw8tHAHNM3Ha4ilzorik83TSWoa7Jrx
         aii/hFrWvdW7yuNUkImjEmdXNL1D6pmBVTk0uyjYm4dbhXia9i28cYR5y2tSM6pjdJnp
         iO7a37doele7ZPVNr+HudlELb2JH33jxNRez2BJTAJ6jgkCKAFCbm+0UwAdW8DXbiFAh
         BZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245027; x=1773849827;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaSlV2hEW5hcNc0uAEcapl0te5oFyDK8uE1cGHT+3MU=;
        b=PSwHuVpVfd/GknsnTxDCjRUjrrhcoX4Xxa/QJWaeEdu/sWWqLgLXJwmqcdHCcRiDY4
         fvHDuDTdpCF8UdTRZVT23FOTOR47eby1Wj5j68sRPALLKj3cpWY5RR1+pGdkAyFhWhc0
         Hs+aR3FzzV5p1/Xv5Rd1e6e2HqYh+h06zpOmxtUMpYvGmZ8uSWA+qh94dVeepS5jeWk5
         T57wwxQrF4tUY/NJEcX1lEIIGcu3l5SVUeo/01k3fUr4Ptbe24KzwsIvxuCto47KxPtM
         3LPNodknwh4+Sv3nJhL4+ercf18zNtv/hG0MofSE4+3D+6H1dZCWyy9MQBlBGImXOmg2
         +v/g==
X-Forwarded-Encrypted: i=1; AJvYcCU0oMZS5FDxC8mRoC+PqfAek3QPYUfLuw/Oiw6OxLGRfD8X3wIdR4KnW82mZN2c3HbC5Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAC9ZNHtmj4oCv9NxVp5aTtCEBJUzPaKwtQvxf6ehBPRzocL2
	rkvg4pfA8R2D7xk+jERxeXxNelx5wxM3h4j03uoCHXr0blqv+a4VO+DZ
X-Gm-Gg: ATEYQzxYS4m3TVMw+xC6vvuduDTeHuHeDZe7nOI75urqBiAiAvAkLom55V8GPrDBbht
	vftao0S4An/zOzu1pSG1mMX1C3TWeGEq4VMuERumqyYnPMh1XKEBofFR34rL1zCQhDYI5WZQixy
	rSWFB8JKoBu+hWsUjGSUkcXCNm+KM5wE1gDhftAXztDv5jvT7sRLL7/7Est2Dft/BJqCM+0Rs3i
	MRE7Tj2gxFbpKn0HLYUjECsWLrBsB/deax0BtpBHVuGf8l57Z1HlGWKDnRCg821aO8yyigkc1Jt
	W4WvG2llZ77S9+m+tQPDJx1QsKgZIgu5PH3Rmn/Lom3H8Y9jbzqH0BZVAm7brXz6bR/uLgxjLBE
	Gt2NYaThOAA7L4biM53v+FwozN2b622eUcdvxmYuQlXCY0r/JQXesaux4vcbYu9By/PIcS2sa9b
	WJEpO35pwczXDkUCft+JznUWJs54maoWbPp9SjxA==
X-Received: by 2002:a05:600c:444e:b0:485:2fc5:39e with SMTP id 5b1f17b1804b1-4854b117cdbmr52453635e9.27.1773245026857;
        Wed, 11 Mar 2026 09:03:46 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f255sm165940575e9.12.2026.03.11.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 09:03:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 ameryhung@gmail.com, kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next v2 03/11] bpf: Unify dynptr handling in the
 verifier
In-Reply-To: <20260307064439.3247440-4-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
 <20260307064439.3247440-4-ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 16:03:45 +0000
Message-ID: <87ikb2tkta.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amery Hung <ameryhung@gmail.com> writes:

> Simplify dynptr checking for helper and kfunc by unifying it. Remember
> initialized dynptr in process_dynptr_func() so that we can easily
> retrieve the information for verification later.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 179 +++++++++---------------------------------
>  1 file changed, 36 insertions(+), 143 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0f77c4c5b510..d52780962adb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -277,8 +277,15 @@ struct bpf_map_desc {
>  	int uid;
>  };
>  
> +struct bpf_dynptr_desc {
> +	enum bpf_dynptr_type type;
> +	u32 id;
> +	u32 ref_obj_id;
nit: let's add a comment here explaining what this field is for.
> +};
> +
>  struct bpf_call_arg_meta {
>  	struct bpf_map_desc map;
> +	struct bpf_dynptr_desc initialized_dynptr;
>  	bool raw_mode;
>  	bool pkt_access;
>  	u8 release_regno;
> @@ -287,7 +294,6 @@ struct bpf_call_arg_meta {
>  	int mem_size;
>  	u64 msize_max_value;
>  	int ref_obj_id;
> -	int dynptr_id;
>  	int func_id;
>  	struct btf *btf;
>  	u32 btf_id;
> @@ -346,16 +352,12 @@ struct bpf_kfunc_call_arg_meta {
>  	struct {
>  		struct btf_field *field;
>  	} arg_rbtree_root;
> -	struct {
> -		enum bpf_dynptr_type type;
> -		u32 id;
> -		u32 ref_obj_id;
> -	} initialized_dynptr;
>  	struct {
>  		u8 spi;
>  		u8 frameno;
>  	} iter;
>  	struct bpf_map_desc map;
> +	struct bpf_dynptr_desc initialized_dynptr;
>  	u64 mem_size;
>  };
>  
> @@ -511,11 +513,6 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
>  		func_id == BPF_FUNC_skc_to_tcp_request_sock;
>  }
>  
> -static bool is_dynptr_ref_function(enum bpf_func_id func_id)
> -{
> -	return func_id == BPF_FUNC_dynptr_data;
> -}
> -
>  static bool is_sync_callback_calling_kfunc(u32 btf_id);
>  static bool is_async_callback_calling_kfunc(u32 btf_id);
>  static bool is_callback_calling_kfunc(u32 btf_id);
> @@ -597,8 +594,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
>  		ref_obj_uses++;
>  	if (is_acquire_function(func_id, map))
>  		ref_obj_uses++;
> -	if (is_dynptr_ref_function(func_id))
> -		ref_obj_uses++;
>  
>  	return ref_obj_uses > 1;
>  }
> @@ -8750,7 +8745,8 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>   * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
>   */
>  static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
> -			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
> +			       enum bpf_arg_type arg_type, int clone_ref_obj_id,
> +			       struct bpf_dynptr_desc *initialized_dynptr)
>  {
>  	struct bpf_reg_state *reg = reg_state(env, regno);
>  	int err;
> @@ -8825,6 +8821,20 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
>  		}
>  
>  		err = mark_dynptr_read(env, reg);
> +
> +		if (initialized_dynptr) {
> +			struct bpf_func_state *state = func(env, reg);
state is only used if reg->type != CONST_PTR_TO_DYNPTR, does it make
sense to move state = func(env, reg); to the corresponding if block?
> +			int spi;
> +
> +			if (reg->type != CONST_PTR_TO_DYNPTR) {
> +				spi = dynptr_get_spi(env, reg);
looking at the deleted dynptr_id() and dynptr_ref_obj_id() spi can be
negative, what changed here that we no longer need this check?
> +				reg = &state->stack[spi].spilled_ptr;
> +			}
> +
> +			initialized_dynptr->id = reg->id;
> +			initialized_dynptr->type = reg->dynptr.type;
> +			initialized_dynptr->ref_obj_id = reg->ref_obj_id;
> +		}
>  	}
>  	return err;
>  }
> @@ -9587,72 +9597,6 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
>  	}
>  }
>  
> -static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env *env,
> -						const struct bpf_func_proto *fn,
> -						struct bpf_reg_state *regs)
> -{
> -	struct bpf_reg_state *state = NULL;
> -	int i;
> -
> -	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
> -		if (arg_type_is_dynptr(fn->arg_type[i])) {
> -			if (state) {
> -				verbose(env, "verifier internal error: multiple dynptr args\n");
> -				return NULL;
> -			}
> -			state = &regs[BPF_REG_1 + i];
> -		}
> -
> -	if (!state)
> -		verbose(env, "verifier internal error: no dynptr arg found\n");
> -
> -	return state;
> -}
> -
> -static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> -{
> -	struct bpf_func_state *state = func(env, reg);
> -	int spi;
> -
> -	if (reg->type == CONST_PTR_TO_DYNPTR)
> -		return reg->id;
> -	spi = dynptr_get_spi(env, reg);
> -	if (spi < 0)
> -		return spi;
> -	return state->stack[spi].spilled_ptr.id;
> -}
> -
> -static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> -{
> -	struct bpf_func_state *state = func(env, reg);
> -	int spi;
> -
> -	if (reg->type == CONST_PTR_TO_DYNPTR)
> -		return reg->ref_obj_id;
> -	spi = dynptr_get_spi(env, reg);
> -	if (spi < 0)
> -		return spi;
> -	return state->stack[spi].spilled_ptr.ref_obj_id;
> -}
> -
> -static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
> -					    struct bpf_reg_state *reg)
> -{
> -	struct bpf_func_state *state = func(env, reg);
> -	int spi;
> -
> -	if (reg->type == CONST_PTR_TO_DYNPTR)
> -		return reg->dynptr.type;
> -
> -	spi = __get_spi(reg->var_off.value);
> -	if (spi < 0) {
> -		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
> -		return BPF_DYNPTR_TYPE_INVALID;
> -	}
> -
> -	return state->stack[spi].spilled_ptr.dynptr.type;
> -}
> -
>  static int check_reg_const_str(struct bpf_verifier_env *env,
>  			       struct bpf_reg_state *reg, u32 regno)
>  {
> @@ -10007,7 +9951,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  					 true, meta);
>  		break;
>  	case ARG_PTR_TO_DYNPTR:
> -		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
> +		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0,
> +					  &meta->initialized_dynptr);
>  		if (err)
>  			return err;
>  		break;
> @@ -10666,7 +10611,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
>  			if (ret)
>  				return ret;
>  
> -			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
> +			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0, NULL);
>  			if (ret)
>  				return ret;
>  		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
> @@ -11771,52 +11716,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  			}
>  		}
>  		break;
> -	case BPF_FUNC_dynptr_data:
> -	{
> -		struct bpf_reg_state *reg;
> -		int id, ref_obj_id;
> -
> -		reg = get_dynptr_arg_reg(env, fn, regs);
> -		if (!reg)
> -			return -EFAULT;
> -
> -
> -		if (meta.dynptr_id) {
> -			verifier_bug(env, "meta.dynptr_id already set");
> -			return -EFAULT;
> -		}
> -		if (meta.ref_obj_id) {
> -			verifier_bug(env, "meta.ref_obj_id already set");
> -			return -EFAULT;
> -		}
> -
> -		id = dynptr_id(env, reg);
> -		if (id < 0) {
> -			verifier_bug(env, "failed to obtain dynptr id");
> -			return id;
> -		}
> -
> -		ref_obj_id = dynptr_ref_obj_id(env, reg);
> -		if (ref_obj_id < 0) {
> -			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
> -			return ref_obj_id;
> -		}
> -
> -		meta.dynptr_id = id;
> -		meta.ref_obj_id = ref_obj_id;
> -
> -		break;
> -	}
>  	case BPF_FUNC_dynptr_write:
>  	{
> -		enum bpf_dynptr_type dynptr_type;
> -		struct bpf_reg_state *reg;
> -
> -		reg = get_dynptr_arg_reg(env, fn, regs);
> -		if (!reg)
> -			return -EFAULT;
> +		enum bpf_dynptr_type dynptr_type = meta.initialized_dynptr.type;
>  
> -		dynptr_type = dynptr_get_type(env, reg);
>  		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
>  			return -EFAULT;
>  
> @@ -12007,10 +11910,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return -EFAULT;
>  	}
>  
> -	if (is_dynptr_ref_function(func_id))
> -		regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
> -
> -	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
> +	if (is_ptr_cast_function(func_id)) {
>  		/* For release_reference() */
>  		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
>  	} else if (is_acquire_function(func_id, meta.map.ptr)) {
> @@ -12024,6 +11924,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		regs[BPF_REG_0].ref_obj_id = id;
>  	}
>  
> +	if (func_id == BPF_FUNC_dynptr_data) {
> +		regs[BPF_REG_0].dynptr_id = meta.initialized_dynptr.id;
> +		regs[BPF_REG_0].ref_obj_id = meta.initialized_dynptr.ref_obj_id;
> +	}
> +
>  	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
>  	if (err)
>  		return err;
> @@ -13559,22 +13464,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  				}
>  			}
>  
> -			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
> +			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id,
> +						  &meta->initialized_dynptr);
>  			if (ret < 0)
>  				return ret;
> -
> -			if (!(dynptr_arg_type & MEM_UNINIT)) {
> -				int id = dynptr_id(env, reg);
> -
> -				if (id < 0) {
> -					verifier_bug(env, "failed to obtain dynptr id");
> -					return id;
> -				}
> -				meta->initialized_dynptr.id = id;
> -				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
> -				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
> -			}
> -
>  			break;
>  		}
>  		case KF_ARG_PTR_TO_ITER:
> -- 
> 2.47.3
