Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEC2F3621
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340469; cv=none; b=nnhzbfY0LB1JTYmdcg+ZrUk78batzpb4AyB4OTSkbY1XPHe5Kpbc2/xotXaScEB1AESJe9uW00jTROlXt5JKSCiVbOxmq26RP5YYoKgKOtjcIVHRUIP7DwJhFrF9riEUf4yBi2Hsa7VYcPEjIDXJs4J7QhBtAlEdBMQj//YFcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340469; c=relaxed/simple;
	bh=D6U9UN4/UpDcIdXNBNv9ua82ay7WspC9HxWxgiaYpeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lgek9WZPfGmT/448LnD/6ItFDSWZj+uu9isvUb50wVEDq0mjDPvf/OpoFEvmBfoeXxUA/8NtndrKHAixVco47fh9r/2naLWum9F/8m2d7WOsNn7RVjJK5wjIp+4yzFuRFkPxVV6MHb6sqwI0e9KKK3GwwNurs17XgO5ytarjB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIQeBmr5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIQeBmr5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd3af345so1491628c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340467; x=1780945267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvxEpJERM5xWM8UmO51OfzQ+NUTTD52io6b9y1jxnSI=;
        b=UIQeBmr5WcZZhRn4JTyBWCYWpkifURtwoPOdMeOONn9WnuI7hOmg7hqQgc2j0GDlGo
         zao+KJhEdc9hKyo4i1qEAJdOb6VwlvbxJEzoCtr6LlToGmfbupKmfhYjrtKMAA6/xBYu
         hwXpoJpvrK5w2D0N7uWM2TklWxjVPvAbeT3e7H0H6nSAcjgu07URG95HPjcyqUnFQRRu
         3RiQq5sqXPHeNUz7u2Sh7Qp8SgEXNaZheNrhP21X3hzVGuXaOVqpJM8Du6q+rfwdu/Ny
         4c3/cCFiUkltEp+RKez0NCsulM3jfMQwWYz5UA6nFlkWbl4LGkW0RBtEqXL7H43yEGfN
         337A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340467; x=1780945267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvxEpJERM5xWM8UmO51OfzQ+NUTTD52io6b9y1jxnSI=;
        b=fFdqXh+dqdzA5Q2kl/Fw6Y06BhIY8nyXK/rcstU396AlbnVbk2XjxhiIlqtAioW56K
         H9sNlK2XFexddpYs8+pDDnGO7RTmZFM5ggwu5NXVmuj1UT5ggVm7vhMkiJgwwREcXMeX
         IWh7RZ+irMgfhWdHyiIHReuf0IYPuHDmZaa3Um3adoE42vXGEo/BZ57XkI8kEmvQD2ZR
         Vi2L1rrIsrQhNEomncskIJBfetxUgbHF2sDE9nmJ5WOMiHnzJ9i3ceQKB7ZxdzKU7ZoU
         ClwfTf7kxnEdJAXeswXn5pa0T0rOos9QV79d1XYF+kbzanH91C1UCYMSlmiTjtpi9JKf
         WwXw==
X-Forwarded-Encrypted: i=1; AFNElJ8HJMd1y/4maZ4itWhM9UqOryP0FXxJv5sAWYkta3BNetoAkkJeUV+EB5OeQesksU3NE7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxarXm6LIVdfqMACi1ApCb6mBZK2nSzl3MDvUN4ptsZl3TyX6/8
	vzlw5KpzBLiPMvdtrYkL9JKmAxWM6Cs20CrkqFe5uHQjsYgsNdOOHivP
X-Gm-Gg: Acq92OFiGiZ1xvGpiK8RSUVqFZjt35j8rrfsn/7TsFlT3MuSoqx2FIiwOUDddIZAYdl
	EcRDeAqQmohNYRTQ3QmsbKpC+Re97toa97MBE21jkoYk7L3mB2GCSJJ6gjk0/6rELyUzbTORhTn
	eA5CLJ+Hjzs24Qb463VUOBf2TfeVPByLl+oNklCRI6esvZsILQtxmOYiWntrmS5lJK78rY1yNsT
	fzH5nlPNUcxHXwCw/mCsccbjrk0nseB4IJ2HBjtBYYICsUv9UMZVrhe+hSqcO3XBdqmO2KZq2RO
	LC3StkSH+KYD0RC4v9V2JuVwxJ6dvMphiLTL9ybtA/7jfSR8FTQvzAJLek5xRFEhdIcwUrQ6dSK
	MUJXrJ6P+dC0HFInALur+DG4OivZmB0jdpuhqUhGPf3pLZjUgDn9LsI+eAcKDSRE6LT2/55K92p
	bZXCzLi//zHvwX9Qodx70ErkujXhKhe4dJKV1/xgf/I7J2EkGmmCUIn+c2TMbNE+Pnq6vvHZpUH
	7bLavTDs+Ab9A==
X-Received: by 2002:a05:7022:1606:b0:135:d76a:aedc with SMTP id a92af1059eb24-137d4299ea6mr5092011c88.33.1780340466926;
        Mon, 01 Jun 2026 12:01:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c10c1sm9194644eec.1.2026.06.01.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:01:06 -0700 (PDT)
Message-ID: <cba7e9dcfca6fd091d831d24eff2cca66e5217e9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Allow subprogs to return arena
 pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, 	song@kernel.org, mattbobrowski@google.com
Date: Mon, 01 Jun 2026 12:01:04 -0700
In-Reply-To: <20260530002259.4505-4-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
	 <20260530002259.4505-4-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 20:22 -0400, Emil Tsalapatis wrote:
> BPF subprogs currently only return void or scalar values. However,
> it is also safe to return arena pointers between subprogs in the same
> BPF program: Arena pointers are guaranteed to be safe for both programs
> at any point. Expand the verifier to permit returning an arena pointer
> to the caller.
>=20
> The main subprog is still not allowed to return an arena pointer because
> arena pointers are internal to the BPF program, and the return values
> permitted for each main subprog depend on the program type anyway.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c6a930aca67e..7a8101879f84 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7880,6 +7880,36 @@ static int btf_scan_type_tags(struct bpf_verifier_=
env *env,
>  	return 0;
>  }
> =20
> +/* Check whether the type is a valid return type. */
> +static int btf_validate_return_type(struct bpf_verifier_env *env, struct=
 btf *btf,
> +		const struct btf_type *t, int subprog)
> +{
> +	u32 tags =3D 0;
> +	int err;
> +
> +	err =3D btf_scan_type_tags(env, btf, t->type, &tags);
> +	if (err)
> +		return err;
> +	t =3D btf_type_by_id(btf, t->type);
> +
> +	while (btf_type_is_modifier(t))
> +		t =3D btf_type_by_id(btf, t->type);

Nit: btf_type_skip_modifiers().

> +
> +	/*
> +	 * We allow all subprogs except for the main one to return any kind of =
arena pointer.
> +	 * General arena variables are not allowed, since it makes no sense to =
return by value
> +	 * a variable that's on the heap in the first place.
> +	 */
> +	if (subprog && (tags & ARG_TAG_ARENA) && btf_type_is_ptr(t))
> +		return 0;
> +
> +	/* We always accept void or scalars. */
> +	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  /* Process BTF of a function to produce high-level expectation of functi=
on
>   * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This informa=
tion
>   * is cached in subprog info for reuse.
> @@ -7963,17 +7993,15 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>  			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>  		return -EINVAL;
>  	}
> -	/* check that function is void or returns int, exception cb also requir=
es this */
> -	t =3D btf_type_by_id(btf, t->type);
> -	while (btf_type_is_modifier(t))
> -		t =3D btf_type_by_id(btf, t->type);
> -	if (!btf_type_is_void(t) && !btf_type_is_int(t) && !btf_is_any_enum(t))=
 {
> -		if (!is_global)
> -			return -EINVAL;
> -		bpf_log(log,
> -			"Global function %s() return value not void or scalar. "
> -			"Only those are supported.\n",
> -			tname);
> +
> +	err =3D btf_validate_return_type(env, btf, t, subprog);
> +	if (err) {
> +		if (is_global) {

I understand that this is how it was implemented previously,
but do we report a sane error if non-global function returns
non-void/int/enum?

> +			bpf_log(log,
> +				"Global function %s() return value not void or scalar. "
> +				"Only those are supported.\n",
> +				tname);
> +		}
>  		return -EINVAL;

Nit: 'return err'?

>  	}
> =20

[...]
