Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71448E0FF
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052629; cv=none; b=LIemlKk49D3FTQTst9zUbjRSndwAsRtlbh0WTUsPwwJpsk0JMzM1994E5p6B2iOIGudb7OTXsy9TD91zHp0nIZhVObPGC0yXRodt9muyO9ywUfRL1hdtroGaBjnWJtx5KJOmYa7VlIe40i+1v5XqYuzf1IMwLDQG1WFOkuCVQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052629; c=relaxed/simple;
	bh=0BLOl0V511fQm0/dq0n9miYuEXEfjBrCRozA/DheL2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6ZW9TP9tKrzkvlXmzW0HWCh5xxGcqOsWcBlKwP8LvvH+oAikZcYiQCB8/TRyQj5iWoaJsAPBZkCl1K/7bRsqkmUdbD8KV0D8tmxNsOVMyZyFmX8efdsq8qUtbnUH3qZWKgqw8MTo9EVFfaBc1HqieyPu8J8DLlgdg9JWXP7IHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl3wUhWo; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl3wUhWo"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so1503811f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789052625; x=1789657425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPT1g/8kvXrQ081Um1YYJLe7xxs33IT2WMAPKokYw00=;
        b=gl3wUhWotOFUSbdQCgPUSNDhGKKZpBhMutokQAjlMIyZ8KZ96Ez/79mmWJElkxx8g7
         eaYL8yvfHBKFes+MwP+EupaxlFY6Ct9+6OgBgyRlp3Ndj/l7AwMY4+CmvKeRlrTwCrOy
         QzNICzJCxqk94MMIVJH7pMIAncSMh0Dt00CIkSGVXfwLj5EjVoyEzT5L19N1V+w3pL63
         NjsK5UfEFK9x4wknxuCJZFS4lr10ucOS4uxTwRkHHtSmsKBGGysYmMBtj60sEcXlN/p2
         jhH3DX43UzoSL2CtUI7QCRQnTqaWWEsDuVH+aeru5M6U+ydKXJfFFoM44N73r5y3zgyV
         YSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052625; x=1789657425;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPT1g/8kvXrQ081Um1YYJLe7xxs33IT2WMAPKokYw00=;
        b=OlQsW4x5mDCCUGBtgL3M4TgMzLxpdPWK0R00H43FUiyRoRAJU/p8qhWiukWwB7aeA9
         LlvBGZmod6jsJrzzo/O9YedPVfkXGDzXW03WxWvnecJpVB4r0O68DhEJT/6hSmpQ0/Rk
         48fvAr9nFO7zHFqtkNQmaIaVpZdeaXznhztlu9EmO+W0loBLK6KX5Uc7DSTykRq+wuqm
         l1rZYpCIjqQQ8h5msb6nfC8HVAQKsDSO81xAVOxOmBSicEOqd40Kb/M5bszr3GQi/o0O
         QQwZ/H6x9CkCBEEMixCi4iTRFjpiRc07EAlDYFU5x6BeQS3BoKIxBtd7wQp05sUa74K8
         zSWg==
X-Forwarded-Encrypted: i=1; AKwUvBxc6i7BK7Mtx15WVBNUOehkqv9nSIFaq+ZOI/KJz3hBxkK268DmfTJhMV0O0XPhi1IMDh4=@vger.kernel.org
X-Gm-Message-State: AFuF++kid7dXbPK1io8gg5D+2vmece8LzmvF1zy/TZenFXY37Y1k7pR1
	udQuUBXBcFhR6VBNxTET3xjLT4iZqEFi6bMiW+707LmWMrF2FzYADW5U
X-Gm-Gg: AYBFou1XLKJbMDQNW3AYl8ACtEraz6Ld/eNKjtb5O58IJmnO+pJeX8t6FxlXJ1wPpDU
	W7fxNgjOPCdUKMq+wdiCel7aAbMH3zwxO+9eG3EdROaAaNzRLMeD/88JaE5DXKSANn45VFAwhCP
	RVMpRG1jdVix3KKful/HyXdphurficMf8oZruRrc9ObOHMyTP4bdsnLr0JFtX3RzB3anEIXG5ck
	WsxYwxDK3m+8tiRpab4bVFvYAd1xSOyk0074wj6f76LwVqX9Ix1TaH4Ecmwa59J4hnkZilnbA6K
	c3l34d416Xqdwcvj1jowDW7dpHT5n3u0VzFHlLWvS9FXGK/EkAnSGHTfCwpabTVh7Olq/72nKuh
	O4o7GcX+EkkQXkhBRMD9W/+LHPSPP68uYRCdgDFjJ3BObH+AW8cEDMyEoqF08sszCp+WSWHVeRE
	K0n1vwZ2hbwqtfaH8AdLC4PKLEGEsEXUTUxxdYOQIVsh7LCzFue0c1xZj9haj3WxW3S4Ap6Es31
	1uod1FnTrXqVXl9XpB6SZq/k1nGIJd8AfO7
X-Received: by 2002:a05:6000:2489:b0:485:8e72:93ad with SMTP id ffacd0b85a97d-485aac58437mr22521169f8f.0.1789052625013;
        Thu, 10 Sep 2026 08:03:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4821:971b:60ec:d55c? ([2620:10d:c092:500::7:3747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48594172546sm42974342f8f.15.2026.09.10.08.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:03:44 -0700 (PDT)
Message-ID: <ea68b32c-1af2-47ae-b168-4fd6791f607b@gmail.com>
Date: Thu, 10 Sep 2026 16:03:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/4] bpf: Add KF_PERFMON kfunc flag
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, eddyz87@gmail.com, info@starlabs.sg, bpf@vger.kernel.org
References: <20260910142107.40582-1-daniel@iogearbox.net>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260910142107.40582-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 3:21 PM, Daniel Borkmann wrote:
> Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
> behind CAP_PERFMON. However, the same is currently not true for kfuncs
> and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
> which can be used such that check_kfunc_call() ensures env->allow_ptr_leaks
> is permitted. This follows similar pattern to existing KF_DESTRUCTIVE flag.
> 

This problem has been reported and patch sent some time ago:
https://lore.kernel.org/all/20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn/

> The rejection returns -EPERM to match the other CAP_PERFMON gates in the
> verifier, that is, check_ptr_to_btf_access() and check_ptr_to_map_access(),
> which report the very same policy to user space.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  Documentation/bpf/kfuncs.rst | 10 ++++++++++
>  include/linux/btf.h          |  1 +
>  kernel/bpf/verifier.c        | 15 +++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 85f73e0bbd0f..6691fe8a32c3 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -486,6 +486,16 @@ Example usage in BPF program:
>  	/* note that the last argument is omitted */
>          bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
>  
> +2.5.10 KF_PERFMON flag
> +----------------------
> +
> +The KF_PERFMON flag is used for kfuncs that can expose kernel memory or kernel
> +addresses to the BPF program, for example by reading through a pointer that the
> +verifier does not check. Calling such a kfunc requires CAP_PERFMON, or
> +CAP_SYS_ADMIN, in the same way that the equivalent BPF helpers are gated in
> +bpf_base_func_proto(). A program loaded with CAP_BPF alone is rejected at load
> +time.
> +
>  2.6 Registering the kfuncs
>  --------------------------
>  
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 89d5a5c4f117..7c62ea17b116 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -80,6 +80,7 @@
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
>  #define KF_SPINLOCK_SAFE (1 << 17) /* kfunc is allowed inside bpf_spin_lock-ed region */
> +#define KF_PERFMON      (1 << 18) /* kfunc requires CAP_PERFMON */
>  
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 45234e2fbee6..5d61e74865a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11356,6 +11356,11 @@ static bool is_kfunc_destructive(struct bpf_call_arg_meta *meta)
>  	return meta->kfunc_flags & KF_DESTRUCTIVE;
>  }
>  
> +static bool is_kfunc_perfmon(struct bpf_call_arg_meta *meta)
> +{
> +	return meta->kfunc_flags & KF_PERFMON;
> +}
> +
>  static bool is_kfunc_rcu(struct bpf_call_arg_meta *meta)
>  {
>  	return meta->kfunc_flags & KF_RCU;
> @@ -13834,6 +13839,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		return -EACCES;
>  	}
>  
> +	if (is_kfunc_perfmon(&meta) && !env->allow_ptr_leaks) {
> +		verbose(env, "%s is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
> +			func_name);
> +		operation = bpf_diag_fmt(env, "kfunc %s", func_name);
> +		bpf_diag_policy(
> +			env, insn_idx, operation, "the kfunc requires CAP_PERFMON",
> +			"Load the program with CAP_PERFMON, or avoid the kfunc.");
> +		return -EPERM;
> +	}
> +
>  	sleepable = bpf_is_kfunc_sleepable(&meta);
>  	if (sleepable && !in_sleepable(env)) {
>  		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);

