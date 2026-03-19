Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CD2D060D
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923144; cv=none; b=UxfoqNWSeV7eBMuJz/xl4VTNd/+kOfqSs4zjuigD1g5+LPbgUZvAlJCVPmTFBVAMUY1ORUMS+k3g71T/nmIKr5Zov2Ltz6G+2k2tdmelj3GPnikRV5M9G7HyCawdS/xPt4HsrJFlLppPRHJljOc8hLRpX2dC4BpQU+PkIZKxwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923144; c=relaxed/simple;
	bh=5kn3mmZPufoRdL/Ex165g9d4h2QddO3ZgMhiIBeAqvw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot9nfnfGrPlOy24quJlW3VkBjCjWhGGxGUmczP/wvWr1H64nxz0t5/cnaNyo/ARMWDnOiT4sTYJZEkCJufJ+5j9GxusSIto75y6aZ7UMzKZ64vcAmaynaT1IMfByMepnJhVcPHxO5GXRK98cFGLm194TFAjG9ga1HD17OtjhmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga8J0L/G; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga8J0L/G"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486b96760easo9876075e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923139; x=1774527939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kfaT1TDpXsavvQlLC9I6BDxWbvI6dysi1hOkUXl9Fo=;
        b=Ga8J0L/G3X1yFwXJT0bDO/XGcBSzC+Sa5mgV+5SPzbuJrnZVpfLLPb6S5Hk+nh8kVp
         KQyj4jbGqSkDuDJdwquCdzLXFKtt8AA0E+fM/V7toAcXLVgwmMxewCUer4qMFX+tYZH8
         wHKt9dCcI2TDO2mFR3SWuWvxDIPO3U9LSheBE3jMANDlo87iuGSLKkNI+gOOJn3ut6iK
         akEhAewlRiox3q2BxFKFk84aaLGFC2CJQpd13hMFIPWxrfROwTkwtNU/UeAH9MK78kTY
         v9HKcFrqsflislbaCNtn2Yd6nmUdu+Cl1+ufAxZpjiEIU8kqL6XIDYSmMaWhBFsleDOF
         NoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923139; x=1774527939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kfaT1TDpXsavvQlLC9I6BDxWbvI6dysi1hOkUXl9Fo=;
        b=Bo4/JWYunnfza9uCc4tcadeOX/b+zxKVLQd/8Idfmk+bKQW64Lj95hMLhWxBqs3qRe
         yCXnM7zi8y5FNOvU5BRD8dJUlohHGI0Qk50HFB0MrAOHyNcRNfjXnhUdlAhvRtvR3Xr7
         acQ9RK+lgXOCpeF5T4kvG2hCCeUhwNybmI/ke+gj6TmmbbAJ2cyVXrj+JT+/dvUNboOy
         2grXDhTKygNj4OqTzL1O917YRAJxTjUhR74HJUhHET3s6f0X5SGjvBH6YYtcbgDIt8y1
         aezkLG0Kja2GuDnSnw6GBEPYxHsweu/Z2rBAKsR3oqoANLsfzoZqLYCgROU/DfJ/WlQq
         lT/w==
X-Forwarded-Encrypted: i=1; AJvYcCWy6Uzm+ILPGIjYCD1rMv4nAo50ub+9sDPnxzKaRQjG1FzLh4O5Uy3fvHw7nW5juu88Nwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xcVrBF3iJol8t8ErxUrI1cJwjfYRbS8ylxEE7lOhTLdDcZ5J
	tBizz5VcWo+dseiQrCQzqAU4envDz3IzgsQEfNY7Kgow4EuQ/k3alE0+
X-Gm-Gg: ATEYQzxHbb/fobHL6ZVDkyCpLG8krBZM0+vHXbsFiTSOADGuqXa7e2WR4Db2O7pwZKP
	Qyx4iDMEy5L+0deuN0N2/3E8y5AmIYMjsjhLzaAAFLj+aj5MPwap7P5ItiGFpF73S3FqQ4Nrn/J
	dzFSgvJIrw7HL2ejrwgiohUMge7sOLoe8fN6soQvjEHUjK1B5y7C/v6LXiFZtqQlB3T0LEl7Uez
	ZtOmUKhjF0npH2z+TcJk7hld8s9EMnH5DNT0VqMylbegxSahjXDaQh9LhA2Yp3LKdpTbX7T4ygI
	7d2i23qAqH4e5Mb6A0lb4/MNWwo/Rs7eoa/NrJZDRpdb3Vq+2hxHY/pDs1Q9FJClxdgNqKjdp30
	8lkQcb6Ci2SxRPQ4JbZa1rEr/hbH96pvNxRhghJumxCLfuxGAPYkvK5cx8kE9RoMhYB5cje8r
X-Received: by 2002:a05:600c:3551:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486f456fe98mr121363695e9.29.1773923139248;
        Thu, 19 Mar 2026 05:25:39 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e162e2sm37494285e9.34.2026.03.19.05.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:25:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Mar 2026 13:25:36 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
Message-ID: <abvrQATstf5nuOpK@krava>
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318234210.1840295-1-ihor.solodrai@linux.dev>

On Wed, Mar 18, 2026 at 04:42:09PM -0700, Ihor Solodrai wrote:

SNIP

>  
> +/*
> + * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
> + *   - the _impl prototype with full arg list (this is meta->func_proto)
> + *   - the BPF API prototype w/o implicit args (func->type in BTF)
> + * To determine whether an argument is implicit, we compare its position
> + * against the number of arguments of both prototypes.
> + */
> +static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
> +{
> +	const struct btf_type *func, *func_proto;
> +	u32 argn, full_argn;
> +
> +	if (!(meta->kfunc_flags & KF_IMPLICIT_ARGS))
> +		return false;
> +
> +	full_argn = btf_type_vlen(meta->func_proto);
> +
> +	func = btf_type_by_id(meta->btf, meta->func_id);
> +	func_proto = btf_type_by_id(meta->btf, func->type);
> +	argn = btf_type_vlen(func_proto);
> +
> +	return argn <= arg_idx && arg_idx < full_argn;

hi,
I understand above is faster, but should we rather check for exact
types with something like:

__is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID ||
__is_kfunc_ptr_arg_type(btf, arg, KF_ARG_BTF_STRUCT_META

jirka
