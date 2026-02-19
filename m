Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A742D3A93
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539566; cv=none; b=FWSVu+/Xetr0CoXYx9KygFNjRu6lUwx6PmmMiRQ27yuDZT9KKvL8zERiCHxaxMUtqJJkzbu0RYSvx0P8Zip7qfVi9psq94lkfGcqlrI5mXB4N92+oZ+0nYLmT829oxl9/qb77Cnsq8pCR3GEedMIR9bBp2UIIeU43k0pwQwecn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539566; c=relaxed/simple;
	bh=bbzWzc8xHJrdQgDPXXj+4ItdwmwMkrRzopVU7QhGr+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UODTsAey/bOdiq+IIIVeTjRN5rSrPxXA5pOpgjeTGt8lY6eSrzx7/PGq3UtwuPaeMsPooeD9WmO0NAvf5tnXNMz4oaz5re5AjCUSITFdBJ9d42Kl4JWpKmSsE8ztZ/p1NAGyyiRGF/PsmKBDh/jQdE5bOZB+L9Qk63sCIc2WMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDmgKyP7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDmgKyP7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824af5e5c81so1435182b3a.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 14:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771539565; x=1772144365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hi0Ni2krJfbIM3+nNIDFTvEx8TLbKRoLbTYrx9Ru3VU=;
        b=GDmgKyP7/oVvtZE7LGrUhUJjKzApJE8ILDCyin7JFLkvF2Zy6neu6QH5Vgxw6n5C1V
         io6XMVB3PhL7cZmRBj+YoZga0CCBXkxagzPjgaIaCJahAGv+0qe38NzyfVl/tS5iHbe/
         zoxP20HBQ4zz0wZ/L4Np1t5iU/Wtw8sO5ulIXsL82laR+pRt2JooCvFuNU3HEU/SPuJ1
         p8d0/7F+LSzIOlmq1E8H4RhnKxpzwxAFn/9MOg+e/Uzlxev0EqCdd0oxBtmHnYOXAVtF
         obiqYVog7tePK0WvuTQvl2p32js7QJUCVfHDUr9Jn6achUEGQHOlVqUfgEqhoAOiKviI
         b1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539565; x=1772144365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi0Ni2krJfbIM3+nNIDFTvEx8TLbKRoLbTYrx9Ru3VU=;
        b=Ud+sqzBFGVjKC8OOHbqYe4JFpxrDPN/43sA8bMyNZk0jYEfAZMTib8R6L/FoVLIhAP
         BiSdjhSdadRXJ+SqKassMhZeNgD7GJGQg2yZbOzyJPsdAzdVGXdGYPLFy0qW0+uvu8sV
         jQSwSKkiLaewxpGh3JJGK3V7hB251xaejtYpANaTQ0kZFWOlest75vnozUCND/NCISPi
         VSMtr0+yazNZjtmLLXRCZXH6K5z10W59SpH/5il4eKf6YTzc1sLLSsn6WNftWRvI9m2M
         P7vXxrw3AbN8Td7OGG6snLGLKFKVTbxkQAqOkE1g0JC2MsjG6S0ITF6KXG3H5KVXB7AM
         tMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWItjfIABFspeVk7w+LZ9tAWItrRTVqwXw8Mv586I6l1wICzl0qeiks4rPnp23uU2PIho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjoTVpSlBcERycBbmGKkjZbsnUtRf605PfcuLj0l7NkuT5x91
	k3MP1A2v7XXhlS9lByvWoZRxorCu/Yt/e+lbBiEuynHG35yGVgn+wQEV/vskAwTE
X-Gm-Gg: AZuq6aJql3w/8ZkoAvAWh3t20BeHrBgC5IrFJcSUP7ird82ydvjhDbAZbdtMsj3el8u
	vT7uJxCIEI31QwrNH+uHxe8cUy45UF5b7OOms4Ic81eytwfvWGEPSkb04PPsfN/fSymkMc9tHeF
	NAGmEJ33P6bvKvqwgZIVA7Jv157NrMyd1E5/MmM/WfTN8/7VE0dYgbjEL5dmHSAe8iJ/dkj/gzw
	xaO6K0FFdwxtr47TTFQ3omzxiRCioHKXayWSJzQBBRHZt77/3tXOmAKinkjLOMIqeG72iPCZGCu
	YfDH/sWIdHhm1w/gyOXDm+Utubio+vkchpG7scSC02vGfXAL6Rwf6HLro81FZqnI8yGa5gEQ/y5
	CXOWkN0sZSwwBQfBSwntRx2zYL92BJ0iqhd/GVmkWYYJ3VACuY0e45giRxeQN+OqXmVuza4W36S
	NRpidzgu9kAzeZEPRL/IM1LD8Ms1bz4Upwi3pZ1Y/C537/sMPBGpd3
X-Received: by 2002:a05:6a00:3a02:b0:81f:9b23:3d1c with SMTP id d2e1a72fcca58-824c5f11872mr19020181b3a.23.1771539565039;
        Thu, 19 Feb 2026 14:19:25 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm20242049b3a.50.2026.02.19.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 14:19:24 -0800 (PST)
Message-ID: <99fd7227e0abc0558a2954e95c1e049edc9ba7b3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 19 Feb 2026 14:19:21 -0800
In-Reply-To: <20260218182555.1501495-3-puranjay@kernel.org>
References: <20260218182555.1501495-1-puranjay@kernel.org>
	 <20260218182555.1501495-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 10:25 -0800, Puranjay Mohan wrote:

[...]

> @@ -10510,6 +10514,8 @@ static int release_reference_nomark(struct bpf_ve=
rifier_state *state, int ref_ob
>  		if (state->refs[i].type !=3D REF_TYPE_PTR)
>  			continue;
>  		if (state->refs[i].id =3D=3D ref_obj_id) {
> +			if (state->refs[i].forbid_sleep)
> +				state->forbid_sleep_count--;

Nit: I'd do it inside release_reference_state() just to have a
     fool-proof point for decrementing this counter.
     As it stands release_reference_state() is called from two
     more places and one need to think if .forbid_sleep_count
     needs to be handled there as well (it is not, at the moment).

>  			release_reference_state(state, i);
>  			return 0;
>  		}
> @@ -10847,7 +10853,8 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
> =20
>  		if (env->subprog_info[subprog].might_sleep &&
>  		    (env->cur_state->active_rcu_locks || env->cur_state->active_preemp=
t_locks ||
> -		     env->cur_state->active_irq_id || !in_sleepable(env))) {
> +		     env->cur_state->active_irq_id || env->cur_state->forbid_sleep_cou=
nt ||
> +		     !in_sleepable(env))) {

The whole expression is the same as '!in_sleepable_context(env)', right?

>  			verbose(env, "global functions that may sleep are not allowed in non-=
sleepable context,\n"
>  				     "i.e., in a RCU/IRQ/preempt-disabled section, or in\n"
>  				     "a non-sleepable BPF program context\n");
> @@ -11435,6 +11442,11 @@ static int check_resource_leak(struct bpf_verifi=
er_env *env, bool exception_exit
>  		return -EINVAL;
>  	}
> =20
> +	if (check_lock && env->cur_state->forbid_sleep_count) {
> +		verbose(env, "%s cannot be used inside nosleep region\n", prefix);
> +		return -EINVAL;
> +	}
> +

Is this check really necessary?
Some resource is forbidding sleep here, so there would be an error report a=
lready.

[...]

> @@ -11658,6 +11671,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		}
>  	}
> =20
> +	if (env->cur_state->forbid_sleep_count) {
> +		if (fn->might_sleep) {
> +			verbose(env, "sleepable helper %s#%d in nosleep region\n",
> +				func_id_name(func_id), func_id);
> +			return -EINVAL;
> +		}
> +	}
> +

Wdyt about consolidating this code as something like:

  if (fn->might_sleep && !in_sleepable_context(env)) {
	verbose(env, "sleepable helper %s#%d in %s region\n",
		func_id_name(func_id), func_id, non_sleepable_context_description(env));
	return -EINVAL;
  }

?

[...]

> @@ -14113,6 +14139,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		return -EACCES;
>  	}
> =20
> +	if (sleepable && env->cur_state->forbid_sleep_count) {
> +		verbose(env, "sleepable kfunc %s in nosleep region\n", func_name);
> +		return -EACCES;
> +	}
> +

Above this check there is:

        if (sleepable && !in_sleepable(env)) {
                verbose(env, "program must be sleepable to call sleepable k=
func %s\n", func_name);
                return -EACCES;
        }

Should it be `sleepable && !in_sleepable_context(env)` instead?
If it should, then this hunk would be redundant.

[...]
