Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE53750DC
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643116; cv=none; b=IDr6HhG7g8ArgSB6AD3675bjlGvt5Z7Wfq+XxNdUDWErlNerKM0cWHQtHgWymSCKMTlJgUVlbQC6cOWuSCLEHyciVZQsZmY9RM6v3mLwgapVN1MIBgQVZnV+t7Sg6HioLb2K7G/56nb+0tN2Gb3Ot1OdYVPt6GLSioKfR80PoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643116; c=relaxed/simple;
	bh=bi+6sUnHKlEUMGA6r0TjLG/9imupYiG4TY4uYgFcBVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnRIEzIRSfuuhnl/DbQ2kVQP855ZmMwrCKRlpPDPuIpMtwzew7FLjd/5o3ukc/Yy1zh+GhCi5yEdbtkUAPeQ8UT4yA4WqcnwnVqLiCBggPyEZdMEuu86HltQfOLMtqM5V8+alfV3nPYIuZ2q4gf2zzy0QGl8VE0xQVDPQpdryvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ/GQpyU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ/GQpyU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c5cce2c6so1150129f8f.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 08:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643113; x=1773247913; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpoDneLkO6OZwYLW2uXWBWuwRjmbz8T2ttllNFOLrjE=;
        b=cZ/GQpyUHcqIvazso5ZJ3zbORHYJ92/AoyVOV3owQcs1B4qiZTV73IwSiBNHGfABog
         wKPXQWMjHJzJKlOFmxGFzkidI4me5xe7ySZsW4inB7da6b5wBu2hhYzp0GJ0x6mkB09i
         TesbUWhuqLI+qoY04F2/yQzoCsMC3umfMdA1iO/HXA5tXFLrQqIPkRXzM8wLVr8UYAVN
         Kwwour85gtMm1PY1r/Wzhi6jtPeOXKKIdSQkXUkp2ant0aVPpxnVz8egAVm8swmrFzhH
         dZQGSf6aaPKNMDmgL/oS1njzDJv5o2zJaM8SGJo5TXrU3+HY1PTMTNKOlGtLakQQdt0f
         Bwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643113; x=1773247913;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpoDneLkO6OZwYLW2uXWBWuwRjmbz8T2ttllNFOLrjE=;
        b=rhalH6rc3xXQjV80F3FjvxeuP0ybGMtr7mD8UOr362Ognwo21ke7jIZxVTqpl3cJne
         Oo15qvYi0d68wLR09LsdkQ7b9p3zVYJZeRmdcRwopHuN+vdRf8INyHPaIvpnjDyQ4GM4
         MgmqIzcV0iyHf6+3cuyeD9ZXalSJF7ERvXxi5Ku5+PbJb+L1dvdv8Op0C2DU3jIWVz2q
         aPh9X89y37J3wyLR8qAx6gA1qgT8rvfJpybXSFkQD0acK8JUxowYkkHnygonvjxBKXzP
         SJFw1SgQTjJk1m8+7JbBKNMZSU/LALLX0DBzG4o5o8cMDexx2C34me87NV9GJGen89jb
         a1dw==
X-Forwarded-Encrypted: i=1; AJvYcCWm2YJaTIx2y4C7ggzRfMaFl2f+lky2PYlKEtm7QVDXK+47gLnyR2EoqQ2qRRWJWl4pla8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDe/BQNuhUOb84DmvS4MlAfnbo84wvnviL9QYkW7MKowyT699
	FZLuaupqNN6bDwoJJa3dPLk+ousOVlKb8etYbXBgJOVzS6QW2YfFr/ggzJtLwQ==
X-Gm-Gg: ATEYQzxQpkjsqu02rm4J7oAZYnTOCGQDbOIAx6/t5rpAjjNwckgYGaVwVG7NbHVDusW
	pe71jdg+pBNwnqROxtm3JmkKYEqPncK5NsHNigOfw+ywLRvrDTi9mV2xlrj3k0yjgrKgz6G1wIM
	UQD3L2hZCe9h635LSiX7akbf+hUbfahWawA5Ufh1RQxj20n/VNXxaBG0/SOgl024yWWLG+CaU8y
	yxogjkeyK+78FtjDzrnSjCoWQDWJirjtuLCKAcpNXQxz7zg1syqFI3dOubnXhDUJZupnZK0re7Y
	7VYcYVdQ09ez3u8gv8pVG0EzN6doOPsvAz5YFytFXkQeHUTGAyE/fbckdfBG2jEark3R335tGZ0
	o4el4e54ZKNQbHXfcjVw2ww+qCCJYFwNcXaxLut8dd5Tkr+8u/vd1U5zIhifRe+zHgxFAZRoJ70
	aXFPgS0OAU/AUmbSCX/V9Nd1Eer/SfUJbYB/1EDg==
X-Received: by 2002:a05:6000:40e0:b0:439:af81:1b23 with SMTP id ffacd0b85a97d-439c7f791a0mr5175785f8f.21.1772643112424;
        Wed, 04 Mar 2026 08:51:52 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4175fd2sm28630097f8f.14.2026.03.04.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:51:51 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, martin.lau@kernel.org, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, Emil Tsalapatis
 <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Only enforce 8 frame call stack
 limit for all-static stacks
In-Reply-To: <20260303043106.406099-2-emil@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
 <20260303043106.406099-2-emil@etsalapatis.com>
Date: Wed, 04 Mar 2026 16:51:51 +0000
Message-ID: <87tsuvy1ug.fsf@gmail.com>
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
>  include/linux/bpf_verifier.h                  |  6 +++
>  kernel/bpf/verifier.c                         | 43 ++++++++++++-------
>  .../selftests/bpf/progs/test_global_func3.c   | 18 ++++----
>  3 files changed, 42 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c1e30096ea7b..39a54e631bcd 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -650,6 +650,8 @@ enum priv_stack_mode {
>  	PRIV_STACK_ADAPTIVE,
>  };
>  
> +struct bpf_subprog_info;
> +
>  struct bpf_subprog_info {
>  	/* 'start' has to be the first field otherwise find_subprog() won't work */
>  	u32 start; /* insn idx of function entry point */
> @@ -677,6 +679,10 @@ struct bpf_subprog_info {
>  
>  	enum priv_stack_mode priv_stack_mode;
>  	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +
> +	int ret_insn;
> +	int frame;
> +	int cidx;
nit: can you add comment that cidx means caller index, i saw it below
and it clarifies this code a lot.
>  };
>  
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1153a828ce8d..d362ddd47d71 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6652,9 +6652,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
> +	subprog[idx].cidx = -1;
>  
>  	i = subprog[idx].start;
>  	if (!priv_stack_supported)
> @@ -6706,8 +6708,11 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	} else {
>  		depth += subprog_depth;
>  		if (depth > MAX_BPF_STACK) {
> +			for (total = 1; subprog[idx].cidx >= 0 ; total++)
nit: I think the way this loop is implemented below is more readable:
for (tmp = idx; tmp >= 0; tmp = subprog[tmp].cidx)
    total++;
it is confusing now, because for loop initializes and increments total,
but tracks cidx for exit check. 
> +				idx = subprog[idx].cidx;
> +
>  			verbose(env, "combined stack size of %d calls is %d. Too large\n",
> -				frame + 1, depth);
> +				total, depth);
>  			return -EACCES;
>  		}
>  	}
> @@ -6723,8 +6728,8 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  				continue;
>  			if (subprog[idx].is_cb)
>  				err = true;
> -			for (int c = 0; c < frame && !err; c++) {
> -				if (subprog[ret_prog[c]].is_cb) {
> +			for (tmp = idx; tmp >= 0 && !err; tmp = subprog[tmp].cidx) {
> +				if (subprog[tmp].is_cb) {
>  					err = true;
>  					break;
>  				}
> @@ -6740,8 +6745,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
>  			continue;
>  		/* remember insn and function to return to */
> -		ret_insn[frame] = i + 1;
> -		ret_prog[frame] = idx;
> +
> +		subprog[idx].frame = frame;
> +		subprog[idx].ret_insn = i + 1;
>  
>  		/* find the callee */
>  		next_insn = i + insn[i].imm + 1;
> @@ -6762,6 +6768,9 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  			}
>  		}
>  		i = next_insn;
> +
> +		/* caller idx */
> +		subprog[sidx].cidx = idx;
>  		idx = sidx;
>  		if (!priv_stack_supported)
>  			subprog[idx].priv_stack_mode = NO_PRIV_STACK;
> @@ -6769,7 +6778,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  		if (subprog[idx].has_tail_call)
>  			tail_call_reachable = true;
>  
> -		frame++;
> +		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
>  		if (frame >= MAX_CALL_FRAMES) {
>  			verbose(env, "the call stack of %d frames is too deep !\n",
>  				frame);
> @@ -6783,12 +6792,12 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
>  	if (tail_call_reachable)
> -		for (j = 0; j < frame; j++) {
> -			if (subprog[ret_prog[j]].is_exception_cb) {
> +		for (tmp = idx; tmp >= 0; tmp = subprog[tmp].cidx) {
> +			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> -			subprog[ret_prog[j]].tail_call_reachable = true;
> +			subprog[tmp].tail_call_reachable = true;
>  		}
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable = true;
> @@ -6796,13 +6805,15 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	/* end of for() loop means the last insn of the 'subprog'
>  	 * was reached. Doesn't matter whether it was JA or EXIT
>  	 */
> -	if (frame == 0)
> +	if (frame == 0 && subprog[idx].cidx < 0)
>  		return 0;
>  	if (subprog[idx].priv_stack_mode != PRIV_STACK_ADAPTIVE)
>  		depth -= round_up_stack_depth(env, subprog[idx].stack_depth);
> -	frame--;
> -	i = ret_insn[frame];
> -	idx = ret_prog[frame];
> +
> +	idx = subprog[idx].cidx;
> +	frame = subprog[idx].frame;
> +	i = subprog[idx].ret_insn;
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
