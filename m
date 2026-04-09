Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D73E1D07
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754036; cv=none; b=FINWrjp839VS9xa9zuaENvn/Ez18NdtuANk3T79lc2U+kqabfGLE7NoI7L35BZUgK8ykcVMaxsslNI0te6Z2VrW+Q+Lnh0qIrWNnE1wQ1JH5b3GbqGAh6BGrlf4YrmJVVKMDgyf7t9eBOKGDHjuNR1CpMb/xV8HcuWDof9xc6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754036; c=relaxed/simple;
	bh=3wbUd8yGbo9kb6C5sKjQ0SO+FDQxAKTkv85/oJv3Ha4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgngvMTUCqYx8ElX0Z6WKtoOQBEHWsSBb6P34Zw3MFvYtbSqeB1gioSmndK55A+RopDb0pdbYYbYjJycC0jAjfngOdwwoLL52wk0pP3XBsW+ucgm8djZB/QiV56D1h/AOn1C6qBJ5YEQHIeS15IGlvxnQz2pUzaaXlk3oatEOzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL/2qsth; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL/2qsth"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66eba04b29eso2360936a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775754034; x=1776358834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7kFV8NKTKmwZ0pH/nFhfxgz03QI1ybi7N+ccmkGFss=;
        b=jL/2qsth9fwHrgLHnFWMlSWOnrAUkTFHlPvWYNOnuWD4VsLvPmSyxJ8I5Vt+i9LlzP
         FO2a42TQ7gbolkqk12w4uK20G/SyEGB/aS+WIEst8d8NenVlhyJ+2PHf+lxWhS4dCSsT
         YQeqqJ5+V0Q2Dfh8DNrJSo0NnOv7muiCWU0Rb0xuRSNHl+9FjMI7nfr+RqNNPX+EDG68
         GIcPAOqTPNFFwPemLmEccTWvLBgT5TZDHX1Szy/nYf8zkLBBhDcWrwnQFyzsa1yz5CaD
         C3wJCTBrREU0Ej5YYPeALimF63sb38ZihCqvOHSRX/1+PJjSq/kCWFLv8+/wbOuEfaGO
         x6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754034; x=1776358834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7kFV8NKTKmwZ0pH/nFhfxgz03QI1ybi7N+ccmkGFss=;
        b=Fu/3l7MPx5AzGX3vEOfR8Rl+jrkUTDZh6GSpsaDWTUGFLHGH3akISHgotvOyKNeUuN
         8uDkIK94iJoKb9s8ADe5Hkc6ZSncePgjDBjTE9MDpHczXQaBOUtgfdHO76LopMB3QPzO
         PvhcuF4+xhzc4WTcT4KUoePx1p0LCm5djwMRBkYd7DAcO9n/DxEay5gnCUksRJi20Vwj
         p9wb1M+uXPqaCBhPHKEuFFYjBSDrxaCzuqAGJ9o20cxdtdQVMBPet2zG+hgw0K9wI2+b
         DfSfPmKfIeo+FBVDnM+st7dmsuc3I5mbxK6lVtfWcBbwGctK4oSd9G1z5NzB5uoyQ18F
         +i7g==
X-Forwarded-Encrypted: i=1; AJvYcCVNfLzuWhEYk4E0yQRWm6waRDaM2m0iSYPNbl3PyT6y5wyGjUsILaClRlYnqXO4KQK7wFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwNv+CppHAu7rqIrR/9m+W8/bnEyX+RHK3lD0xpBLHUfodUAJ
	1Qs/QihHLHbhrd+inAbxGLATzWmjEuFNRVxUPuGkgIw21wnmbDWXtDa4
X-Gm-Gg: AeBDiev0U+bMi0/ZNQaCGTvo1qOEwfl3xV4lslzOHO2RToUM0up2XJaV5+IgoAYXV4G
	KZW4uIqzG9cINvOWF/vl+Zv13fCp+B27Cb8uTV/wz7bHqZuKSVnNvZsLfP4wy3GbmFTJvcvVdE4
	fZ161kvFrqZ2KdclonN3w/cZ4y9KcR5q6+Ylj8wBzosDM633bT+Ctrlc8JJavExCQcMVMB3fieE
	1yDdAqkv3+fUOl9Hub54rFz9mJOu569lXHLcthzhzla1JfV6RhWGULKZi93Rs1wWuybIKX24nrr
	iTQCn30jAp15fdgkm8Wy9Wr/BrXhLhdyw7Jb4axO7SGr0byKK0QVSVpRIdXBq1GKuyziuJKs7ze
	XbIyP+JO425K6J/TPHyrworOxqrqW9ItpHopuNHpH7S1RLM2UOdjCSPP2w2D/ub8oMeAcSZb4T0
	Y3mlH7qnTFtfMxkow/sX0LknM/StxmQMAyGn1PNP4bQyG2GRBHHopTULc9fHRaeFftJDo6PNG2h
	blViZKJXjDnR05R6Lwyuw==
X-Received: by 2002:a17:906:478e:b0:b9c:69df:4d8e with SMTP id a640c23a62f3a-b9c69df5f1amr1369873566b.25.1775754032988;
        Thu, 09 Apr 2026 10:00:32 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:a778:a387:b2af:188b? ([2a02:8109:a307:d900:a778:a387:b2af:188b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1765sm7974666b.56.2026.04.09.10.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:00:32 -0700 (PDT)
Message-ID: <048e6632-1388-4643-91b2-18dd5844cf5e@gmail.com>
Date: Thu, 9 Apr 2026 18:00:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 01/14] bpf: share several utility functions as
 internal API
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
 <20260408-patch-set-v1-1-1a666e860d42@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260408-patch-set-v1-1-1a666e860d42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/26 2:33 AM, Eduard Zingerman wrote:
> Namely:
> - bpf_subprog_is_global
> - bpf_vlog_alignment
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Simple renaming, all callsites are covered.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>   include/linux/bpf_verifier.h |  2 ++
>   kernel/bpf/log.c             |  4 ++--
>   kernel/bpf/verifier.c        | 10 +++++-----
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 36bfd96d4563087209d73dfcfe43786df0184256..15f7f9f35be98f6f30c46cdf03cf5c0249a8ac38 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1121,12 +1121,14 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
>   			  u32 frameno, bool print_all);
>   void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
>   		      u32 frameno);
> +u32 bpf_vlog_alignment(u32 pos);
>   
>   struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
>   int bpf_jmp_offset(struct bpf_insn *insn);
>   struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>   void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>   bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
> +bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>   
>   int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>   int bpf_compute_const_regs(struct bpf_verifier_env *env);
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 37d72b0521920daf6f3274ad77d055c8b3aafa1b..f0902ecb7df69b6d43deaf808b4c0f00cc3438f2 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -847,7 +847,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
>   		mark_verifier_state_clean(env);
>   }
>   
> -static inline u32 vlog_alignment(u32 pos)
> +u32 bpf_vlog_alignment(u32 pos)
>   {
>   	return round_up(max(pos + BPF_LOG_MIN_ALIGNMENT / 2, BPF_LOG_ALIGNMENT),
>   			BPF_LOG_MIN_ALIGNMENT) - pos - 1;
> @@ -859,7 +859,7 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
>   	if (env->prev_log_pos && env->prev_log_pos == env->log.end_pos) {
>   		/* remove new line character */
>   		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
> -		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
> +		verbose(env, "%*c;", bpf_vlog_alignment(env->prev_insn_print_pos), ' ');
>   	} else {
>   		verbose(env, "%d:", env->insn_idx);
>   	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84699a428077d66f68203cdcccddee5f8207cd34..dd81cfbad680712e4d871163b8ee179fafe8587c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -421,7 +421,7 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>   	return rec;
>   }
>   
> -static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
> +bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog)
>   {
>   	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
>   
> @@ -4610,7 +4610,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   			if (subprog < 0)
>   				return -EFAULT;
>   
> -			if (subprog_is_global(env, subprog)) {
> +			if (bpf_subprog_is_global(env, subprog)) {
>   				/* check that jump history doesn't have any
>   				 * extra instructions from subprog; the next
>   				 * instruction after call to global subprog
> @@ -6971,7 +6971,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>   		if (subprog[idx].has_tail_call)
>   			tail_call_reachable = true;
>   
> -		frame = subprog_is_global(env, idx) ? 0 : frame + 1;
> +		frame = bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
>   		if (frame >= MAX_CALL_FRAMES) {
>   			verbose(env, "the call stack of %d frames is too deep !\n",
>   				frame);
> @@ -11040,7 +11040,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   	err = btf_check_subprog_call(env, subprog, caller->regs);
>   	if (err == -EFAULT)
>   		return err;
> -	if (subprog_is_global(env, subprog)) {
> +	if (bpf_subprog_is_global(env, subprog)) {
>   		const char *sub_name = subprog_name(env, subprog);
>   
>   		if (env->cur_state->active_locks) {
> @@ -25186,7 +25186,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
>   again:
>   	new_cnt = 0;
>   	for (i = 1; i < env->subprog_cnt; i++) {
> -		if (!subprog_is_global(env, i))
> +		if (!bpf_subprog_is_global(env, i))
>   			continue;
>   
>   		sub_aux = subprog_aux(env, i);
> 

