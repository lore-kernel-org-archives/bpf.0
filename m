Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74E36922A
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877165; cv=none; b=pw3L6UwYiW3BjXW8AMQrEsOOlgStJHkPVlPcCzOMZZi7WCCvQxXdG4JGEwaqKmmvPPXHe4bKbn8yY2hgaWWp5aScNeRhXB756m4uasC/xA8UyqY+divzk0beMFTSBgbAsBkQ0pqWzvkPyY6Ej8U3LzPXl4A/0A1lfU9qt7oq0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877165; c=relaxed/simple;
	bh=DKRycFUVYrK7EcX7lAGbWXOidbJgFGQ928Yw1ffuRwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y9OLnNBE8/7Bqc7GyJaN8v8ULPUIHZwebHn5j2XUHJM8OKqCbz4BCr//gISPiu7oEswAA78w0ndHmLtG7WQD4x04njClWY608I8kXvKdhUSP8XHJVSEcV9duygWXrK+XdnSsjE0L98++QVhSkSi6VnxRKrLsklrJjfFup4oNziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJXDR96X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJXDR96X"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43621bf67ceso3175617f8f.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771877162; x=1772481962; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldVaHBF5RkD43MX1HVi+kdSf8I8BjAs4IR6oHiG6idg=;
        b=kJXDR96X08YD6V4CPKBglOXTmy3DMEGMq/eqBy00PfhXbcv7xyxDL+nv36NNuKpfkX
         3Hfr7gawe7qmjL8KLvJkukEcOWFI1eajpnzFaEPtI8f5sORBTzDTqCYL9jS0C2tuQXoA
         qsj1/2JsLqdiUed/nbY9UAO20v+h+u1KsesYIotCAUS9o+6bijqYEH0I8QBJRe1WPblG
         GmPssJVKnAeN0d8AcHop7f4ZiVPQS6EXjAIPTYsnT8PUHS0bl9Db/4QOdq0pBisEj1iZ
         0NEB+WZt4jZgOHvXncKoguBAprnoknaQnfKnXTolmdIAZHwY5Ub4FpapjHY08QzegMgN
         ncVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877162; x=1772481962;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldVaHBF5RkD43MX1HVi+kdSf8I8BjAs4IR6oHiG6idg=;
        b=sCzsFz76s5lUsBDP4ou/sJZiDHxFxtx6xRaTLTKJEYdqgY39KHcaGe7OHkPbIC1CBj
         W1MqZIlNgTXzoW9HKYR5Nfgxr8r9KmoZw7VUUMbFKqTZjZ9ZFU0zu14Afw4TjnL08UuE
         GkN5SqlALYMgxpj+D6zNBqUQtFAGW7EeYz55M2etUTMxMPqAD0+1sxgGA5yE5CoabhBX
         sJv6O9jVb/Dd0lr0nBx0MvFYw1PIRW8vXL0UmVNVC1burmAfc08agAmluZeqlZNzfenX
         38LHl/c7OOSYmD7ZpMfLGST7ACNdoPhZLnUJmwQWxn2T7HjBYm8en8heeuNOeJYtOnG1
         ohoA==
X-Forwarded-Encrypted: i=1; AJvYcCW4VB3HJzpYl/HR9GjB8OsKYIK7Qnr/pEIQRA5amfrz6MsqhEdzqL8dz9VmUeJ32eYCOvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB6JGPM09+gDYo3h5H9sdJIzKHLcAqKRDWl1A4zVX0/NztSJ5
	7EfFwr7/pvZ1RAeInFIWlT7+4gfpHDkhH8pXoYb6xeYaqqGOsqrkmMVy
X-Gm-Gg: ATEYQzw0+wf5Hv2HOl7brGJeblPLdX3xUmtHGmvQ/jxajB79tcqUhEI1b8RHP88DFUI
	oCVbqhKh1Cl/JcOiM/DNKl/e6zOAWnZksvOXQgZacs5N8TdkotuEGYsztk0LVn03+xcQUGNa1QU
	D7QwQ1Z5+a69aN6ZXVGOEPrKkZhqrr5em1G0LQFk1FLaexxpRcUjYi4BdAzIcfzwaY+hCS1hxyd
	JP9GI9VTmO/09mDpH6g/qEVkWB8mEiht564a6NhMqgV3fmuxZyEumHRQjrDhJ9tYSYtHzr8eNV9
	nXEog6lNKsNHd33qOPVAHW94oiDVo8bRsG7zbD6h33p/zCLNfyIVjxE/iatBt2VyvfLnJgKV6f4
	sddxLZFl7+lawetw9INegMIEg1ByyKKTJoYnFo3WXxDAkq8tJ1TeI+CgxA6p43VwWyqe+Zf1wjU
	JjIPn90ALwJxvLu4mN57o=
X-Received: by 2002:a05:6000:402b:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4396f153396mr17518443f8f.5.1771877161711;
        Mon, 23 Feb 2026 12:06:01 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:9032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm22051063f8f.19.2026.02.23.12.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:06:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/6] bpf: consolidate sleepable context
 error message printing
In-Reply-To: <20260223174659.2749964-3-puranjay@kernel.org>
References: <20260223174659.2749964-1-puranjay@kernel.org>
 <20260223174659.2749964-3-puranjay@kernel.org>
Date: Mon, 23 Feb 2026 20:06:00 +0000
Message-ID: <87y0kjb4yf.fsf@gmail.com>
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
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c693dd663cab..c2a63f8c8984 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11574,6 +11574,19 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
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
This check didn't exist before, did it? It looks right, but adding
something into the commit message to explain this would be nice.
Does it mean we can currently call a sleepable helper in the lock
region?
> +	return "non-sleepable context";
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  			     int *insn_idx_p)
>  {
> @@ -11634,28 +11647,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
> -- 
> 2.47.3
