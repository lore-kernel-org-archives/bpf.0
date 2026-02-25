Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CF3D903F
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044219; cv=none; b=sxuDpYKtrybo62BCskqYZISd4Eh0Fw8i+xca6Vtp+QxrBj6i+ebIOYtUeLF/fdEI9pV/QAJWQA2kwyLQosoLyRYj/cOOmMGWPHUOs5m96QXVCcUkRANkxlq5mXbcA4VP6SnbvZNdflHGpG0VF7+Mhu4a6RhtQTzYxa6C7QNLaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044219; c=relaxed/simple;
	bh=HvjR3kpQYiCAqTjSMeLdm6d4cm70cKz4mWAlOhRmcEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMiAgAvtZgm4nZgFVxlFmTDthrOMWsJOyAKhNTCXGBeH4Jj6bhRBE4BWF1hgO+pkdLmOABSnnMV8cpRd9FiQHOONXiRH/8DacbNpqR+kKfTHboOi4uvyHBpSzOVPYCsjFqa0a9uLuaOIeMbEmou/nMpJBrelrhJcQfW6G666+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNFkvvFx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNFkvvFx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so440105e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044217; x=1772649017; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FnbM5EnO2GxrIGc1dBOoZyqSpexXn48KFfCSUQj0RSk=;
        b=GNFkvvFxgEudX/7LNwpxu8kTJW/XEJLwIvhgHj0AvQ2gLkdkh31ThSX+fVD4pXISM/
         r0JLUF9DzinQ7tbPcUTLBzUk5R7og2Fz94QcNtWI7yyQCqYcyhqe4GO/lXoPzLsDp+4U
         sAKYL/HsQpskVq/C5c4rFpNvmpQ0U2BkBwAmLQ4n3tX9c7F1yk+psdFQQfyO4iEgDuSS
         b5siRZIsW1zX6HEzsE/ab15AHAUszP5++aHqEyB9UEZHAqlrF/n8CQ1+ODCJ7IYQUleg
         EUJ8keESHrmqIB/tBz+rSN+uggSRtG1bsGWZsOd3XjLozB8HupFNNua1/h9KpB+YDSGd
         XwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044217; x=1772649017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnbM5EnO2GxrIGc1dBOoZyqSpexXn48KFfCSUQj0RSk=;
        b=w+0Lz3XK3j6xbzcDJi8qQqNgXaaQS5Ul+Wza936xc4VcmC5zySVio22l9Ju+iiQ68H
         iNcXSuA3f+vzM7Gimmrjuigr9DtD2I9tYts6DfjtAKX1m81QISOwHEwYIdUvvS31+Nlx
         gttJWCUX2D2yM1CDuZRQ3T/YDRXBL9cLDEVW3PR60+K7fBSwSJxxbvgK1BxoLfATGCDG
         Uf3FBrkIMhmhMosK+Wah7ELmVOxg2kRD/797Uz/D8BajbRJr31+wuQSIhN5kguiHG5sH
         LfSqyTQwTCopVkE+uiY4pHnS2nicG4Wjp3IP0HEsG/NXrM0ypwLvzVwv40+IKtrdLYni
         GJFA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbnykMyk0kzFJxH39p0ZFoBRcdDOHkPY4qw8DRlcCVZNJMFDzpGlIS1fDHVPGYl++l5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWwNlISMQAC0+Oj/UGUqrekjymfZcGTY30L0PM61Q4gtKMGZy9
	UCHt6naJl2iN2qZGF51mU1iCLyiTViF+PTSCuy9kE4VpB03rXyTQJrmU
X-Gm-Gg: ATEYQzyx31VppNiOVHCxGxYtzwU1QvxzlT95NK/nB0AXoQqekvbiygP9AF1lGfF4zTc
	UY62SzehQhCFU7rQT0D1on9zHV2MLhhFskCg/aES9ulSah8R+w9V1QIgT8eO73oGlaSLyBHn7kp
	yY3/CcxTRggIsGHVe/YVIO1LdTQuh8Zf/TEh0v1oWb9T7znyUtFO79LmyfBMznHAuiplg1zSiuY
	hb1sIn2l2RQmn5j9/kvGGKJzqUvEDkNqNcIs072eHPtpy+F0LEZ115SJ1TlUrzwHidncZXHHrqf
	kd0LxsRORo5WNAiIvrd6H0bNZzfCmRB45ONtFBy6omtneGF5ycajCVx4rmFGbYlPLDz14PygLfW
	dVn3BK7Eot6g8E0pN+QgVgRAh9nk2nuNZmpFa633ctXUCl4JdcPs5nivwPt1L6SFrIOgyV39DDM
	xFuLbq8wpMIjMkaxU=
X-Received: by 2002:a05:600c:8107:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-483a95c5313mr306173925e9.15.1772044216438;
        Wed, 25 Feb 2026 10:30:16 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:413a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e6c9sm67252695e9.8.2026.02.25.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:30:15 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Consolidate sleepable checks in
 check_helper_call()
In-Reply-To: <20260225134950.2781351-1-puranjay@kernel.org>
References: <20260225134950.2781351-1-puranjay@kernel.org>
Date: Wed, 25 Feb 2026 18:30:15 +0000
Message-ID: <877bs0llqg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> check_helper_call() prints the error message for every
> env->cur_state->active* element when calling a sleepable helper.
> Consolidate all of them into a single print statement.
>
> The check for env->cur_state->active_locks was not part of the removed
> print statements and will not be triggered with the consolidated print
> as well because it is checked in do_check() before check_helper_call()
> is even reached.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  kernel/bpf/verifier.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1153a828ce8d..e8c4a5f8520d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11549,6 +11549,19 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>  	       in_sleepable(env);
>  }
>  
> +static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
> +{
> +	if (env->cur_state->active_rcu_locks)
> +		return "rcu_read_lock region";
> +	if (env->cur_state->active_preempt_locks)
> +		return "non-preemptible region";
> +	if (env->cur_state->active_irq_id)
> +		return "IRQ-disabled region";
> +	if (env->cur_state->active_locks)
> +		return "lock region";
> +	return "non-sleepable context";
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx_p)
>  {
> @@ -11609,28 +11622,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>  		return err;
>  	}
>  
> -	if (env->cur_state->active_rcu_locks) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in rcu_read_lock region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (env->cur_state->active_preempt_locks) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (env->cur_state->active_irq_id) {
> -		if (fn->might_sleep) {
> -			verbose(env, "sleepable helper %s#%d in IRQ-disabled region\n",
> -				func_id_name(func_id), func_id);
> -			return -EINVAL;
> -		}
> +	if (fn->might_sleep && !in_sleepable_context(env)) {
> +		verbose(env, "sleepable helper %s#%d in %s\n",
> +			func_id_name(func_id), func_id,
> +			non_sleepable_context_description(env));
> +		return -EINVAL;
>  	}
>  
>  	/* Track non-sleepable context for helpers. */
>
> base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
> -- 
> 2.47.3
