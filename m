Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964283115BC
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045665; cv=none; b=TyuyyjYLDwymkOLY6i6LgbNM5BM/4oSMfCIlBozxUEMs3ealVB7uObuLAww2vyqzGFTowJTGIndhWnrxLt4B/hftDBIogdX3j2j+p4yFoJnt3SfwUlo6BUHwp2eoto9mU/bdFOAsfxLE9C6S84cnrr4m7Hh30++Q5GuubGSiWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045665; c=relaxed/simple;
	bh=zukmXB9JhKZRWk4X1XAmimIxhtKTAvEw9yQCWtBvWIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umvpMAdgrHvA8q64O+5GmO3XcmHJbXyV7XFBPu2YGlWm+mwKsG4LjpV9pI2tSLqng/rjooRB0wr/OiRRP84RfWewbMYB+2wzzx1nOvEcSqVNkj7JDl/mGIb55QydTvr4i1/R14rDcXILrePKNhazMgoaazVhTM2qiKHsOKA+I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaRBlkzp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaRBlkzp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4398ebdf520so779290f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045663; x=1772650463; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hIwgzEUV/2QZYUSqhxnufvRzJbqEzauuXZUT6omx+HE=;
        b=VaRBlkzpeL8jMwcZp9VJScrpSfA+CFzBejDHmmDfcbdncSupdvjMB29k0eJwUMaeGn
         PWl4x0vlbv5NW+qn8No49t/3bNKj3zISTB97oBh1XxIkkf6vZTzwOiHnh0wCNNxtMWSc
         rv2/ChmVhkYU6liWrzpRglbBYJiPkt0S1IuiuGJ/veHVLRgwmtgvpj61zHjzD/HVqQ23
         ADOp+NytNlZ0jpxbAYGerwfqg09b0gA2nJxXoReoclDXTmp8q0MYHeRKogv8/xMRvGyc
         7U3BG9TfykcWxCqKZdig1CzLHq+s3mG7r2RHUJ+jf5xEUM3QLy55R5S85O+hTjdEdT1P
         on/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045663; x=1772650463;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIwgzEUV/2QZYUSqhxnufvRzJbqEzauuXZUT6omx+HE=;
        b=CoOavkJmdKTXzQCR+vHC0AjQOeOVnmPobgiCsYy9lnfPyw8Q87Shp89/4YfzobpiNx
         yUy+V7GzVFVDtNbNvdrwLVz3RG+axlnxMt3x9XaYLlYDc3pZaC6ind/ToO59jclGLYhE
         4qzw7Geo39Zg4PIBnffhm2J3lj8HK8LU4Hy3WzIZCMeSVzu+vjDagMqedJpQQDVbhBkS
         wae6GaD7LdmwVmtRzgxbTNeJL9xvU7erm16yDr59hOm6drdKKecBjQrpIxioSK8YwiEK
         fBzAU/Z5etLl9uK0rk/+PSgMTDimW38GR+4kgJbDOWEn47pGqZSj56GM6GvqDRcXIuVY
         BYPg==
X-Forwarded-Encrypted: i=1; AJvYcCWgyt0uDAXfgJm5AmeuyYO/Upu67o76kXzBwwD+ltSoNwE5psQKSUWyBh2G9F9mXiWFXP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/HbZHZ8U+2+hagUOG6wPuHxOa9obJCqCt1yPeUmpgOW2YKd+
	D7rcceHDeWBaYUvBfL4ZoRZg97+kzCQt3V6Xq81FzhglChrjaaXhyKXH
X-Gm-Gg: ATEYQzybstZB9P2WDj+USLUiK/E4kMZ8mOElRmo01s1guxeBVYFgH03o78oykyE8G2H
	f0jWDl3XcF3/8sO18D4GFgHPwTRCRecryUy/Gf6TqLzcbUN9QXHOQqYA9un5ZRy0XKprhRSsnct
	JoPmP2UvKbI0r4COrOTrzCqGD1geFVvtjkFodRBMgynF+CPGK3N/H+5wQfet5RtVjy01uQUrt+P
	MFjcR8Hlbo30yBOyGIMlaMe0BDzliF4McJMML1FmilL6AaMmVfS0Lsc0U9hCqutbMvfmMTRCggD
	+gud5DCkOlEUm3WHXEQ72vfdBMHQBs985Oo4eGM15NUoGqBdUq4GqnfZ3D3DPdXknaFNTCoi1qv
	WbbGTmX0HEM11Y+o74QGqrArwEdDNQgM9Wk6PxxdanYFAPmVjKHr6pEhvkQ3RuPn1Y0XkuaX716
	zP1MqzUpZ+gWJKPzs=
X-Received: by 2002:a05:6000:1846:b0:430:f593:aa34 with SMTP id ffacd0b85a97d-439971f152cmr196102f8f.17.1772045662962;
        Wed, 25 Feb 2026 10:54:22 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:413a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398d568772sm9156633f8f.0.2026.02.25.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:54:22 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/2] bpf: Consolidate sleepable checks in
 check_kfunc_call()
In-Reply-To: <20260225134950.2781351-2-puranjay@kernel.org>
References: <20260225134950.2781351-1-puranjay@kernel.org>
 <20260225134950.2781351-2-puranjay@kernel.org>
Date: Wed, 25 Feb 2026 18:54:21 +0000
Message-ID: <874in4lkma.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> check_kfunc_call() has multiple scattered checks that reject sleepable
> kfuncs in various non-sleepable contexts (RCU, preempt-disabled, IRQ-
> disabled). These are the same conditions already checked by
> in_sleepable_context(), so replace them with a single consolidated
> check.
>
> This also simplifies the preempt lock tracking by flattening the nested
> if/else structure into a linear chain: preempt_disable increments,
> preempt_enable checks for underflow and decrements, and the sleepable
> check uses in_sleepable_context() which covers all non-sleepable
> contexts uniformly.
>
> No functional change since in_sleepable_context() checks all the same
> state (active_rcu_locks, active_preempt_locks, active_locks,
> active_irq_id, in_sleepable).
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8c4a5f8520d..c26139b96c6a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14153,34 +14153,23 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  				}
>  			}));
>  		}
> -	} else if (sleepable && env->cur_state->active_rcu_locks) {
> -		verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
> -		return -EACCES;
> -	}
> -
> -	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
> -		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
> -		return -EACCES;
> -	}
> -
> -	if (env->cur_state->active_preempt_locks) {
> -		if (preempt_disable) {
> -			env->cur_state->active_preempt_locks++;
> -		} else if (preempt_enable) {
> -			env->cur_state->active_preempt_locks--;
> -		} else if (sleepable) {
> -			verbose(env, "kernel func %s is sleepable within non-preemptible region\n", func_name);
> -			return -EACCES;
> -		}
>  	} else if (preempt_disable) {
>  		env->cur_state->active_preempt_locks++;
>  	} else if (preempt_enable) {
> -		verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
> -		return -EINVAL;
> +		if (env->cur_state->active_preempt_locks == 0) {
> +			verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n",
> +				func_name);
> +			return -EINVAL;
> +		}
> +		env->cur_state->active_preempt_locks--;
> +	} else if (sleepable && !in_sleepable_context(env)) {
nit: it may be a little bit more readable if we put this check
separately, not in else if, so we get the next structure:
```
if (rcu_lock) {

} else if (rcu_unlock) {

} else if (preempt_disable) {

} else if (preempt_enable) {

}

if (sleepable && !in_sleepable_context(env)) {

}
```
the motivation is that logically this looks separated from the
active_*_lock accounting.
Overall the change looks like an improvement.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> +		verbose(env, "kernel func %s is sleepable within %s\n",
> +			func_name, non_sleepable_context_description(env));
> +		return -EACCES;
>  	}
>  
> -	if (env->cur_state->active_irq_id && sleepable) {
> -		verbose(env, "kernel func %s is sleepable within IRQ-disabled region\n", func_name);
> +	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
> +		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>  		return -EACCES;
>  	}
>  
> -- 
> 2.47.3
