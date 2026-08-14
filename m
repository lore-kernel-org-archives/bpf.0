Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5239D6E9
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747422; cv=none; b=M+jtF1GUEuln0HZo/DbXrUiz9k1Z045csmXCWp1Rd6fpF1F4jL+OjVKZnbxvMhTx4tnTaeJIHXQeRxt5tGB4/9n25HtElwr0SK/YGK5nlrQfj3V4Ko4Tr/c7PKMo3gKKwJMqCbpBpVETRCxuT8ui8iUswMXddtXMdGaxJ8xnC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747422; c=relaxed/simple;
	bh=fDJdkxkvEIBT8Yds5Sgxr5mokhNrgKZhwz+bZG6J7V4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOhfuhl3rET/2lTWxm0jG+ptT4TJHfD7AHpadO0/XjBVp65lV9QkNwd9ntg0UtBf0Cs8uxPzaW5aIPxIw68V65HC1JtDQRwCa8awTjnSwiC5JAgNxLSLEl6kgmOPPbJAeb1XGx+I1ivrXDBeOWuUwWj4IxOLmmv9Vi4tML/qkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzbdOWkY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzbdOWkY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace91f112so19374965ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786747421; x=1787352221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNOmiyJ5d+wdC5MRanoWdRl3OWEUl7DoeAZRkbaPj6Q=;
        b=JzbdOWkY9xo8RNGYkTr9Oosij8+EijKjYceDwg9Vk3o1puJcKdBY2DfoIh7UaNdJYj
         lbtZ6zAl+EmGi58Yb4+DanHd7G/Alz6D+WQOt0tGvgA4GQ0kvXjG4KxxC0eVQLjRo45O
         85JXbWq1PFxoTwzawAcawCvBGtsx2H7wYnqOmISR0greo2JDKpu7ctXEnpQLZ9LHFHE0
         cUfoyIGGkSyUrKURmQfIOp/ueaq/BxDbYXF2uondYbZvbyACY0IcCwtmWK/TFWXctzdk
         rCnxdxs23iPc9YbxyuEgdnejz5nB4PozWH0Q+WhY6SJo4uMjf+tF+OdHiTnFhBLy9bmu
         9YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747421; x=1787352221;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNOmiyJ5d+wdC5MRanoWdRl3OWEUl7DoeAZRkbaPj6Q=;
        b=TEPRfhkFdPoBW/f+YfG39OVcI6bLJciZOAqG49OpDwHejYwzQkKvsqhZSuLS2iFUQI
         pino3E7CgOgP1c3BmBLUm8foKWlrp/Ih/6XVyUWHtBqUEkAgn2gbLB8mN747dS5IgbVY
         P4mx7pGpWAHmQsVs+D1To4Xwh+CorofCY8FHTm6CCO6sXWwijv37+zsilpqVhelrMv/F
         Z+u8vx7wQAzQAtWJNVL83z0Uvkj4CX/tZqs0gV/C5Jt2Q3zUaCTXeQDZa+DHJzSOQsEd
         AZuiKTKFb40SF3V9OA+Qaym8tpQdQCEn+kwHU6tKM9dU1sC35O3Np3LUAgA/zGgGmmIy
         kNBw==
X-Forwarded-Encrypted: i=1; AHgh+RqC9ATjdIiN9YjlAf+keIiZfD1R/Hr4pWIlALEeNUm1Hn2Flyz0Fqfe+cLZf2KqbNUBEeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqefvZ4iUUjDT78/inH+D0RvsDEWCnVjDAOqAyKt9OO/ynYD/j
	sPpBWC53GaivKdDAUj40YNi53riMjZhKQW7ebsrjqr1QMumAFPgQekuK
X-Gm-Gg: AR+sD12skUk56X5DgotTWWkxYa9P9nKkxgiKYU6Ctn+OHqisbYHF7kbgFlOgivqpJ7k
	g3dQEdUJ3c9SZGAdgBUC+wkHL7RIzuKyL0HiQg/NnI/3gTKuFb0+tYQ/UUbMy0q8ZXPVq5DJfw1
	Tr5SOqrZhufNIHMVBqcZL/IBtF4ZcDAH7jflz10NjlOmuLm4rfTsbHGwiSmb8KPoQHu59vzRmhx
	+UsIBQnQj67Ij/UTC9c8naeZ8VbTLSVfQ+k8sYeXtf0TuB0yCfIQCCRstwvmdqtCTMEkk8cN+UA
	7YmersloANmnpp7BHtiYwMkD5OO9FTqGp38RFu51SfIh6cG7rzCx38wPt8b9Z+IEuerZa0WKMRQ
	sxD0oCf5Lu6f0OWvukN6ajgbdMN/oxqOVjOEazov7TOjgg7L/wYUrFi7AItnhfM4cj46cjY7ban
	70HoVXzix8lma5ek0tZX6rTHxQa7td9wfPiFEr3g0croilV7fb2Q7sZP634L0MN0tWlNQkuhiAu
	lmJQFZ8t7YBYrAZPoSEVTiwxSfi3l3yRhklstTnoz6x
X-Received: by 2002:a17:903:1965:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2d3b0db9f3cmr105848565ad.7.1786747420812;
        Fri, 14 Aug 2026 15:43:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm8449955eec.21.2026.08.14.15.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:43:40 -0700 (PDT)
Message-ID: <82a2bfbf1173867428d43edb65c9d32b9a61e90d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 02/11] bpf: Add helpers to describe the
 R0:R2 return register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Fri, 14 Aug 2026 15:43:39 -0700
In-Reply-To: <20260813200220.1994468-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
	 <20260813200220.1994468-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:

...

> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf *btf =3D env->prog->aux->btf;
> +	const struct btf_type *type;
> +	int subprog;
> +	u32 size;
> =20
> -	return btf_type_is_void(type);
> +	for (subprog =3D 0; subprog < env->subprog_cnt; subprog++) {
> +		type =3D subprog_ret_type(env, subprog);
> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
> +			continue;

Is the check '!(btf_type_is_struct(type) || btf_type_is_scalar(type))'
needed after v4->v5 migration?

> +		if (IS_ERR(btf_resolve_size(btf, type, &size)))
> +			continue;

Let's propagate this error instead of ignoring it. Or add WARN_ON_ONCE().
After BTF validation it shouldn't really happen.

> +		if (ret_regs_cnt(size) > 1) {
> +			subprog_info(env, subprog)->ret_reg_pair =3D true;
> +			/*
> +			 * The R0:R2 return convention is only implemented in
> +			 * the JIT: the interpreter propagates BPF_R0 alone out
> +			 * of a subprogram, so a caller reading R2 would see a
> +			 * stale value.
> +			 */
> +			env->prog->jit_required =3D 1;
> +		}
> +	}
>  }
> =20
>  static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)

...

Regarding the bot comment:

> Additionally, should jit_required be set for subprogs whose BTF prototype=
s
> are marked unreliable?  btf_check_subprog_call() can flag a mismatch with
> prog->aux->func_info_aux[subprog].unreliable =3D true, and check_func_cal=
l()
> only aborts on -EFAULT, so a static callee with an aggregate return can
> load today without using the BTF return type. Subprogs subsequently delet=
ed
> by bpf_opt_remove_dead_code() (which runs after this pass) also don't nee=
d
> jit_required set.

It seem to be correct. As prepare_func_exit() unconditionally copies
r0 and r2 to caller's frame, the verifier would conclude that r2 is
initialized; while interpreter won't copy it. One option is to force
nregs =3D=3D 1 if there is no jit.

(Or derive this information not from BTF, I'll comment on that later).
