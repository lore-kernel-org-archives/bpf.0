Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571E3A16B8
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692260; cv=none; b=ZE+hgrNffRnYbV2VQ1O7cJPupvLrijGPXfLMYRb7LAhjIMs/v3VThZyXRWLjxrt3jxLV//xUoatsdxk/7db+lRwTtmR8Rysw3ATgvZf9ayCnLjIPvRAw90LAcrZ6jhKjw+WpAIFnqsv5cmZ8RgaA+YpegEbdQ9AWFYcIhuxc/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692260; c=relaxed/simple;
	bh=NUbj7ueElKf+z9biq29K5uwG20OSMFPac455RXJpGHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv2vr2E/ESx7kfLBzrO82JPY6NquA4qJ2bBwZVIoMnPatssGTEQk0nuM6LIV05VO4atAHh9J8UMRsPCp2b9ffMPWazn57EAq8wIonjl5zRbtxZ2nW50gu5KNsoDoY1x1WJlFit1WgiVTr92mnUrtC6k9yB/RXPqT4O62R8PN4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcK98J64; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcK98J64"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso6075125e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692257; x=1777297057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COU9hrTl1+B29GfVAYIK2QUpj5WgJFaOuszlhFn04dw=;
        b=NcK98J64p86ej6ybWeXCCupTIMvADrCGx7TnqrEVZXqrxV4yQYB+QVSmzXc+FJondY
         Ka5D9EjZkSjnGGjGnrKZvS7D/jsV+V6cbQ8HAeftan3xDyySK7T6sSXHJvLV/+0bkYPx
         hR4Fo2Tt3PTymf26QI9u1W3IsxSUTA2M3DYOck+xnV5+13jGqjTyJNjBBdXUdGvWvQKy
         3/hi8ushZWCJQA32Vv4PNlIdlOZJfo5sbf46/OW/1lEOjanWCTUZgtxuoaVzR8+ZD1tM
         YMnTI+2tuwfCwMHyf0nNXsi8GYQRcMT3uRPg2Nr5yRLbZcHL7OIjQj8KuZiEMeeRWOF1
         bSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692257; x=1777297057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COU9hrTl1+B29GfVAYIK2QUpj5WgJFaOuszlhFn04dw=;
        b=iKx6uakssa1fuZlWXKSdLkBc+kw9SW9zHiIuI2b+4Xs49IsHywBj6EjGS32giNqA3Q
         wHB6sYGPTtiAAz/dAz8YHPRFshWA4JADTzDfng/XQABRQHFRtsR8bgYg+KD1k4RNKpWK
         rDMb5+z3b2uhM3xQ9YpRPn8Gn0umM0YkZglhKhgLpCezsw3VNpEYNRvgW2kAwgibZI9c
         f5hZ8CVJ4Qz1RIfAUoSUbkp44xK5yIiEFuHu0SynuA/SjBobdyXSOKpBUh8l9q/No4Io
         hjCoqdIpT+LvMiAWVcP1sAp1Kftqeh7GpJcYuFATTH6ZR8jpipnt+uxc8x5xCWbL0bOD
         /buw==
X-Forwarded-Encrypted: i=1; AFNElJ/SgJWQHC3r4Y6RjudesxFDME1kRkAjk2jd+t85e+SycU914lPLSHmxisryJ+4X1cIfgFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/y46MmvBxv66ljzKTZmtr6tmyo7087oGSnQHc6y//s9bn+we
	LC7chSZIzqrefqBjegZI1uViS9buMo7YSkV5QFLU74ruleDF0qnlxY40
X-Gm-Gg: AeBDieuQ2iCyXv7+3H24ALx9rWV4wOjg0OGsqHjfpRe9c0ljPbZSwRvcOlNF8AjX6IC
	jQIRXamJjp04poHMbuHGSVB8v8X3fSKWQfLxOakpQHH/1fxUf4B8RNrNIqLc8xh9qlER6nhJbyg
	AOH7a6cxF7gxWukd6NxglIWuu8RcfAqoHK9eGsFYV2n4JDByKlJEXBcAIdAEUY7sTqnU+xnmOk4
	52c2zS92OdtidwcshB9Phjuy+JcxRVpJwUHDeekqn0QL1JmJhCi6+Dr8z0PKh3wNVhQ/2sAIjWX
	POaYNyDOleIf3JZX++AhBdBa388SMmRCETRhyIYsTXEl9qEZJoLbQQ1+mRjaPlYXtQh0lRfhe3C
	nmG5Kt5b9+2yYFtJJX1/UvInYOm9JajXzqnRAyXovktpxb1TL92kto3vDlCCvnrEzgX2saOx+PV
	Jf4dD9NHXKJbxSXK5jvB1nfAfIovtg7tQxDNSbZOIg/Bxh/6SSJWIl0xOXu03xL5U26GnyCyX91
	l3uFk98
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr181736715e9.18.1776692257212;
        Mon, 20 Apr 2026 06:37:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm103837305e9.22.2026.04.20.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:37:36 -0700 (PDT)
Message-ID: <3f9d8cf9-d025-410f-abd3-470433a4d479@gmail.com>
Date: Mon, 20 Apr 2026 14:37:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Add support for verifier warning
 messages
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260418171701.610025-1-memxor@gmail.com>
 <20260418171701.610025-2-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260418171701.610025-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> Add a mode where log_level 16 can be used to receive warnings and have
> an associated log buffer. Add a warn() macro that emits messages to log
> buffer without any restrictions, aggregate the warnings emitted, and
> then use it to decide whether we reset the log or not.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   Documentation/bpf/kfuncs.rst |  4 +++-
>   include/linux/bpf_verifier.h | 11 +++++++++--
>   kernel/bpf/log.c             |  2 +-
>   kernel/bpf/verifier.c        | 21 +++++++++++++++++++--
>   4 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 75e6c078e0e7..47d60011d8eb 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -353,7 +353,9 @@ marked with KF_DEPRECATED should also have any relevant information
>   captured in its kernel doc. Such information typically includes the
>   kfunc's expected remaining lifespan, a recommendation for new
>   functionality that can replace it if any is available, and possibly a
> -rationale for why it is being removed.
> +rationale for why it is being removed. When verifier warning logging is
> +requested, the verifier will emit a warning when a BPF program uses a
> +deprecated kfunc.
>   
>   Note that while on some occasions, a KF_DEPRECATED kfunc may continue to be
>   supported and have its KF_DEPRECATED flag removed, it is likely to be far more
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..515afcb83ec7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -689,15 +689,21 @@ struct bpf_verifier_log {
>   #define BPF_LOG_LEVEL2	2
>   #define BPF_LOG_STATS	4
>   #define BPF_LOG_FIXED	8
> +#define BPF_LOG_LEVEL_WARN	16
>   #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
> -#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
> +#define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED | BPF_LOG_LEVEL_WARN)
>   #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
>   #define BPF_LOG_MIN_ALIGNMENT 8U
>   #define BPF_LOG_ALIGNMENT 40U
>   
>   static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
>   {
> -	return log && log->level;
> +	return log && (log->level & ~BPF_LOG_LEVEL_WARN);
> +}
> +
> +static inline bool bpf_verifier_warn_needed(const struct bpf_verifier_log *log)
> +{
> +	return log && (log->level & BPF_LOG_LEVEL_WARN);
>   }
>   

It looks like there is a little inconsistency in how we handle warnings 
vs stats and other log type, all other log types go through generic 
verbose function and have level check inlined in verifier, while 
warnings have a separate warn() func.
I think warning should either follow the existing design similar to 
other types or we should consistently refactor all log types.

>   #define BPF_MAX_SUBPROGS 256
> @@ -848,6 +854,7 @@ struct bpf_verifier_env {
>   	bool bypass_spec_v4;
>   	bool seen_direct_write;
>   	bool seen_exception;
> +	bool warnings;

nit: bool has_warnings is a bit more verbose, but I think better 
describes this variable.

>   	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
>   	const struct bpf_line_info *prev_linfo;
>   	struct bpf_verifier_log log;
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 011e4ec25acd..2cf79fac8d43 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -154,7 +154,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
>   	if (WARN_ON_ONCE(new_pos > log->end_pos))
>   		return;
>   
> -	if (!bpf_verifier_log_needed(log) || log->level == BPF_LOG_KERNEL)
> +	if (!log || log->level == 0 || log->level == BPF_LOG_KERNEL)
>   		return;
>   
>   	/* if position to which we reset is beyond current log window,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 69d75515ed3f..8de2a4e5f5de 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -47,6 +47,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
>   enum bpf_features {
>   	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
>   	BPF_FEAT_STREAMS	     = 1,
> +	BPF_FEAT_VERIFIER_WARNINGS   = 2,

What is the usage scenario for feature detection for verifier warnings?
My gut feeling is that if you don't have warnings feature, you don't 
have warnings, and bitmask should just work if you pass warnings bit 
it's noop.

>   	__MAX_BPF_FEAT,
>   };
>   
> @@ -282,6 +283,20 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
>   	va_end(args);
>   }
>   
> +__printf(2, 3) static void warn(void *private_data, const char *fmt, ...)
> +{
> +	struct bpf_verifier_env *env = private_data;
> +	va_list args;
> +
> +	if (!bpf_verifier_warn_needed(&env->log))
> +		return;
> +
> +	va_start(args, fmt);
> +	bpf_verifier_vlog(&env->log, fmt, args);
> +	va_end(args);
> +	env->warnings = true;
> +}
> +
>   static void verbose_invalid_scalar(struct bpf_verifier_env *env,
>   				   struct bpf_reg_state *reg,
>   				   struct bpf_retval_range range, const char *ctx,
> @@ -1683,7 +1698,8 @@ static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
>   		if (err)
>   			return err;
>   	}
> -	if (pop_log)
> +	/* Preserve warning output across branch explorations. */
> +	if (pop_log && !(env->warnings && bpf_verifier_warn_needed(&env->log)))

Is it possible that env->warnings == true, but 
bpf_verifier_warn_needed() == false? As far as I see you just check if 
`!env->warnings` which better correspond to the comment.

>   		bpf_vlog_reset(&env->log, head->log_pos);
>   	if (insn_idx)
>   		*insn_idx = head->insn_idx;
> @@ -18803,7 +18819,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>   
>   	ret = do_check(env);
>   out:
> -	if (!ret && pop_log)
> +	if (!ret && pop_log &&
> +	    !(env->warnings && bpf_verifier_warn_needed(&env->log)))
>   		bpf_vlog_reset(&env->log, 0);
>   	free_states(env);
>   	return ret;

