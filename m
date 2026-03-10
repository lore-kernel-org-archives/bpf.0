Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6F26F288
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151483; cv=none; b=Q7yirRiIzPvh3w65fFoGS3fOo5xypXEHXuk83IkvjYZR/4PAN15Osxay86+bEZhPovzVilmiM0ZmU1SOBR/wU185lkVLvf+vPGe0RwbvAP2vrp308x6og0Ue9iquIGTvWvSOp9DxG/WsX5ouJozhQ4ftFBsySKSGfgiiE5xq67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151483; c=relaxed/simple;
	bh=M5CIm6wSiXkBfEQgajoC8zVkBU8NrJ82HgOthYMycew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sK4bppozYHC5j6NtgpJMlK4go3mmhn3AxHS7fGq14F3HWd/8c+hk7ytJ+B/Ejcx2438dz1UCq5Q+1ICfytU2jcNHDp7ToOM2obR03+fE0CQkQl8fO8dnG44h1SCXo4DLXyQ/NZedDX5dEDuYgyc+D56IK+bbhGvmknLRY+wC12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCdOZJ7n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCdOZJ7n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48539d21b76so18680155e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773151480; x=1773756280; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcu33aclB1bH4+eu5ZYZLwHfFROzANJJDnUJYvttoj0=;
        b=fCdOZJ7npdph40cysDqmoxpg4t49iHLzH7n0XYGY8x3kNTl/TG01N7Oo3S9gHevag6
         QIvdWiBJp1wH3hE98qm7QJ6Cd/j8ntxTR3o+BTs5me6JDKLNM8wtF352uDyinqMWRPO3
         gBXaJHeELHrRI1xmePBkysHI6/SODw13IlVwyemYlsPP2VIjAGvk28+aM6wxOnWeAkOr
         VOntkWxaHRLEWkv88dFghvn38BkNmzJEdtix1fLurkZ7POZ4TeYnsAD1L3zHz7CeG+Cp
         JmEElxIE361HsyiI3HwdKhfXITC3arhf3mELtjiM3oick4vUO2t2uRSf0Y7sC78nodB7
         j4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151480; x=1773756280;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcu33aclB1bH4+eu5ZYZLwHfFROzANJJDnUJYvttoj0=;
        b=YWqXGRMH7kdAIBeWVJKck9p96a0/YvTCs/8HhYDfGa5YxucRPNUd4Qcy6zNbRZJdVs
         D/XjV73s7Zrlmm02J6TFz2N9zRkESncM4LgGn8uiS2g7TyBPhFFdK+U6j9qZd33/XlvI
         ynG3R1n/0jcXyVhstVfzkykYgvmKER8XE+dAlI1CspetQYtu+8fnz8KKVfksS4NMi92j
         Pvf4IXU7Sjy4xbxhNdVsobnR5Qsn+G6lrpYTc+OattMgtzYbsc/zN8wwaIx8zu75wEkZ
         hxXpBPRPXE3w8HVnuzaJyhKyzXu48auIkBh7T4OHgTYBVDri809+z0gKcZHacZAPCj5b
         lxXA==
X-Forwarded-Encrypted: i=1; AJvYcCVP0H60p3osfPKQU7qbCbKlI5Jfs5MLH2JYwflwMULqJ3jzt8TB3TIw62JLmrznMcCesCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2ElxhH/7gkQhuV7nV81nWFhkQUQHQfqte9a3LQFT3M4HdVvD
	RTSR4uFcKcRYPYMK0/t0wEu3kKoC7zJ7UaD/rw6m0gxXCRFqdSpS0jGV
X-Gm-Gg: ATEYQzwZPlETmQp+LbBjHOmbbLBAA+e401EnsM1YP+SykOQ70qRWOekKlYCietrKwuu
	Zvj0v+dJEilz+/h7vMbGNmS92D4XWoNd0mD4EFOVeJHJ4zfsEx9t7tyoR7MF6BgqZW/qzSrY63w
	qaN5oNFYFxB1Fu5b70WpnKahDhxJcKYfGJuazUlAc7W3AjfedGC/gjL9Q1xFR+GUjeYNnkt/Vw+
	ZCj5qtHHpgSrC3mWfs72v0HhemXrFXh4KIhRPzz6AMMrq76/vrCL1wEYH1TRT2fwmKEuVJXKxoW
	Zmk50LkbdcBj8brMGZ1jsoOBOgBKpvDOwqA0G/gh9BEYxM8ZvjsWFgidCZ9jDMb8iqOBonFh0QQ
	jBGsFbLDz2XtZ2o3M24GpCTij9gUlbbmH8GwDmZch0v74T00Hp5+tVfZUhDaPL3JctfOIQM0G6H
	FklIxWdW0fwMTof0noAIwvLQ8K2ExSGzRv3GEIgdB86H66
X-Received: by 2002:a05:600c:4507:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-48534a29447mr159498805e9.33.1773151479669;
        Tue, 10 Mar 2026 07:04:39 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8dbb3sm33017671f8f.4.2026.03.10.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:04:39 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, martin.lau@kernel.org, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, Emil Tsalapatis
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
In-Reply-To: <20260309204430.201219-2-emil@etsalapatis.com>
References: <20260309204430.201219-1-emil@etsalapatis.com>
 <20260309204430.201219-2-emil@etsalapatis.com>
Date: Tue, 10 Mar 2026 14:04:38 +0000
Message-ID: <87tsunu6fd.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emil Tsalapatis <emil@etsalapatis.com> writes:

> The BPF verifier currently enforces a call stack depth of 8 frames,
> regardless of the actual stack space consumption of those frames. The
> limit is necessary for static call stacks, because the bookkeeping data
> structures used by the verifier when stepping into static functions
> during verification only support 8 stack frames. However, this
> limitation only matters for static stack frames: Global subprogs are
> verified by themselves and do not require limiting the call depth.
>
> Relax this limitation to only apply to static stack frames. Verification
> now only fails when there is a sequence of 8 calls to non-global
> subprogs. Calling into a global subprog resets the counter. This allows
> deeper call stacks, provided all frames still fit in the stack.
>
> The change does not increase the maximum size of the call stack, only
> the maximum number of frames we can place in it.
>
> Also change the progs/test_global_func3.c selftest to use static
> functions, since with the new patch it would otherwise unexpectedly
> pass verification.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  include/linux/bpf_verifier.h                  |  9 ++++
>  kernel/bpf/verifier.c                         | 52 ++++++++++++-------
>  .../selftests/bpf/progs/test_global_func3.c   | 18 +++----
>  3 files changed, 52 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..b45c3bb801c5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -651,6 +651,12 @@ enum priv_stack_mode {
>  	PRIV_STACK_ADAPTIVE,
>  };
>  
> +struct bpf_subprog_call_depth_info {
> +	int ret_insn; /* caller instruction where we return to. */
> +	int caller; /* caller subprogram idx */
> +	int frame; /* # of consecutive static call stack frames on top of stack */
> +};
> +
>  struct bpf_subprog_info {
>  	/* 'start' has to be the first field otherwise find_subprog() won't work */
>  	u32 start; /* insn idx of function entry point */
> @@ -678,6 +684,9 @@ struct bpf_subprog_info {
>  
>  	enum priv_stack_mode priv_stack_mode;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +
> +	/* temporary state used for call frame depth calculation */
> +	struct bpf_subprog_call_depth_info dinfo;
>  };
>  
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e4f69918693..ccd4efec179d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6733,9 +6733,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	int depth = 0, frame = 0, i, subprog_end, subprog_depth;
>  	bool tail_call_reachable = false;
> -	int ret_insn[MAX_CALL_FRAMES];
> -	int ret_prog[MAX_CALL_FRAMES];
> -	int j;
> +	int total;
> +	int tmp;
> +
> +	/* no caller idx */
> +	subprog[idx].dinfo.caller = -1;
>  
>  	i = subprog[idx].start;
>  	if (!priv_stack_supported)
> @@ -6787,8 +6789,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	} else {
>  		depth += subprog_depth;
>  		if (depth > MAX_BPF_STACK) {
> +			total = 0;
> +			for (tmp = idx; tmp >= 0; tmp = subprog[tmp].dinfo.caller)
> +				total++;
> +
>  			verbose(env, "combined stack size of %d calls is %d. Too large\n",
> -				frame + 1, depth);
> +				total, depth);
>  			return -EACCES;
>  		}
>  	}
> @@ -6802,10 +6808,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  
>  			if (!is_bpf_throw_kfunc(insn + i))
>  				continue;
> -			if (subprog[idx].is_cb)
> -				err = true;
> -			for (int c = 0; c < frame && !err; c++) {
> -				if (subprog[ret_prog[c]].is_cb) {
> +			for (tmp = idx; tmp >= 0 && !err; tmp = subprog[tmp].dinfo.caller) {
> +				if (subprog[tmp].is_cb) {
>  					err = true;
>  					break;
>  				}
> @@ -6821,8 +6825,6 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>  			continue;
>  		/* remember insn and function to return to */
> -		ret_insn[frame] = i + 1;
> -		ret_prog[frame] = idx;
>  
>  		/* find the callee */
>  		next_insn = i + insn[i].imm + 1;
> @@ -6842,7 +6844,16 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  				return -EINVAL;
>  			}
>  		}
> +
> +		/* store caller info for after we return from callee */
> +		subprog[idx].dinfo.frame = frame;
> +		subprog[idx].dinfo.ret_insn = i + 1;
> +
> +		/* push caller idx into callee's dinfo */
> +		subprog[sidx].dinfo.caller = idx;
> +
>  		i = next_insn;
> +
>  		idx = sidx;
>  		if (!priv_stack_supported)
>  			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
> @@ -6850,7 +6861,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable = true;
>  
> -		frame++;
> +		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
>  		if (frame >= MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);
> @@ -6864,12 +6875,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
>  	if (tail_call_reachable)
> -		for (j = 0; j < frame; j++) {
> -			if (subprog[ret_prog[j]].is_exception_cb) {
> +		for (tmp = idx; tmp >= 0; tmp = subprog[tmp].dinfo.caller) {
> +			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> -			subprog[ret_prog[j]].tail_call_reachable = true;
> +			subprog[tmp].tail_call_reachable = true;
>  		}
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable = true;
> @@ -6877,13 +6888,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	/* end of for() loop means the last insn of the 'subprog'
>  	 * was reached. Doesn't matter whether it was JA or EXIT
>  	 */
> -	if (frame == 0)
> +	if (frame == 0 && subprog[idx].dinfo.caller < 0)
>  		return 0;
>  	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
>  		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
> -	frame--;
> -	i = ret_insn[frame];
> -	idx = ret_prog[frame];
> +
> +	/* pop caller idx from callee */
> +	idx = subprog[idx].dinfo.caller;
> +
> +	/* retrieve caller state from its frame */
> +	frame = subprog[idx].dinfo.frame;
> +	i = subprog[idx].dinfo.ret_insn;
> +
>  	goto continue_func;
>  }
>  
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
> index 142b682d3c2f..974fd8c19561 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func3.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
> @@ -5,56 +5,56 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f1(struct __sk_buff *skb)
>  {
>  	return skb->len;
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f2(int val, struct __sk_buff *skb)
>  {
>  	return f1(skb) + val;
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f3(int val, struct __sk_buff *skb, int var)
>  {
>  	return f2(var, skb) + val;
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f4(struct __sk_buff *skb)
>  {
>  	return f3(1, skb, 2);
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f5(struct __sk_buff *skb)
>  {
>  	return f4(skb);
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f6(struct __sk_buff *skb)
>  {
>  	return f5(skb);
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f7(struct __sk_buff *skb)
>  {
>  	return f6(skb);
>  }
>  
> -__attribute__ ((noinline))
> +static __attribute__ ((noinline))
>  int f8(struct __sk_buff *skb)
>  {
>  	return f7(skb);
>  }
>  
>  SEC("tc")
> -__failure __msg("the call stack of 8 frames")
> +__failure __msg("the call stack of 9 frames")
>  int global_func3(struct __sk_buff *skb)
>  {
>  	return f8(skb);
> -- 
> 2.49.0
