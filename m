Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDD175A79
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574827; cv=none; b=doWJS6TcWtJpvkxj+jMKraoiczrrcqK4ZTD8pFhIEf13oqactmV0ppJWuZ9q91sMq5hoOWrKRtKsBHU1/dYcMB0vg/d4nkyf2vzETzOUIVNxOLfAw2P2Xh9iB9TvR5JFFcF1g1SDuZkpxQhI73Dsz+HOA2iY/CoFsW6pSy2hJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574827; c=relaxed/simple;
	bh=HkNPfs3/wfKa3oTl3hxHFoZ4z62pLeEWtRVWphx6VrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OD/dy7e5ERwgb5A387rGWtaI8PfK+ztBA38BNEGnaaA0I1xs7MRWPPKjcx/jrXFg3tJdkNtkdR41vs6NmFpXaJOh3FwhOsPGWYqB//dTH9eDQxIeZAvwi01u/lTEqfsOW32l51xFZVLGmbpHmqpsaUSC8kNotRnV3RamZOVnWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUeYKrks; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUeYKrks"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1529108a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786574825; x=1787179625; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8xjbogRaV6Z0jkiyIDgjLOg1GDv22OCE53W1CPvrezk=;
        b=LUeYKrksw2AQBoF4vhHUMWSThF5iaqTpzfJQ9zsDhPtiqqHkKYiDpnaHMJudtjNzXi
         7ObpGTONFpkNcvQzXWTWYZVmfQZUyB3E4zs7k5i34DlXXZK483V6X/XdxkadGeLpscq7
         IAsT0hJM5PRX2WzZd2V1ifYdJMy1Jc2shmvcpMiZZRIwv8RZZ5sFquOByCYHqLk1LBSS
         +NVDqhRGnvG+U89/3pKpjWgdVdH6pj0+SSikvjsXc4q4YSpckBTLr7gVQPMSwRzlfGIt
         hPutlb3IjE4KqkwJZw/o0tKLu/pCIbCA9RTofTXBclHOHoGSeQVIqaKtgg0W1psmFoXE
         Uu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786574825; x=1787179625;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xjbogRaV6Z0jkiyIDgjLOg1GDv22OCE53W1CPvrezk=;
        b=RClsmcvXnumo4UOO6ZBjwzTctkNPUAjWVXRyWWukEtrpOgGJM/QHQnku5Uf3qgz6FM
         0dSzCF/Zabqq+OS6jySLwYP2hLX5JvpyORH3I95htdDIhxX1VjnIUFCgKY/stFPhmeGZ
         BoaTVgQB4jj9kUxqHMOOxUoFim77H4D7c+v9y0K9NTwpBZ2ep2m41z0G6fGnv5NMCFYE
         JkGkMgc65fe9K7z3tZSMhNEomX8J3O9502h2WNPnSS6iD6vI0AX/xI+fquiqo6cfgXcs
         loHMr2L7VFG9kjDGYHb+kG9qjOJvWXyKmgQC21SYoB9xg/8L/TYVuxQnek9Vty5x8WAp
         sx1g==
X-Forwarded-Encrypted: i=1; AHgh+RrTGkcrFj/VLcQ8IPqpu49dEu8xtl5oxRwCh8lvT8OD1KJrgL60w//rZf8B5y51KnZ5Rxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVDVBm5dTCCurtbFaMSTcaSOgdRZ37Sti6zbrfcP/ZtOkb9w0
	9M4cVrlaug9tN6BtgimAh/FzXZG/LW6xUIqrDstA6/fQJaWWvcRMAQRRjAkzXE4F
X-Gm-Gg: AR+sD10cgJ0lCdeF64bqezaGKW6GZXf44Vupex3N62fvjy/4Ppt1NfAf4HKS7ar+pp4
	fE7E9LCnoFrvrq415bBBSBMQ8EzNSjOGGSI1iATbALSUlZN/c1JxhTKCVpyr1adgMdSQvi3wUEx
	/Gv2uC9rFHSV3fqu6PdkubX3wzhYpUI5SLcRbnHdA3WVMnd+XLkrKizcRUsdPiM2HpM5Hgk7ZXe
	nAowMOzmMVqCP4q9Wa50rpsU2TTnKJ4a785CP2NEbH/bfJUcYzx2mug36DWGsVm0/XXqk6N3boN
	hS5qn92We26bzdnK+ptcm7KkX36QRIJG7FfHEhTfrmt4T039/zHltF94b9qrHaRpFoW3rd2fs+y
	tZN8f3X1dgySv+HYsGYyUJ91jqGz+i5jFv56IS5BnYAq4lfYhICn1v+V721keNDVhzeH5MmdIwS
	ThBRqDVrlqPAe5U1sjBYrIf5ILwi+u/NjPi0Ht3e8PLdstUUELH8cbHtivMDtWEaAwl/+GEMJhH
	hO2S1ScuXGY06XX7eB0xUR7Uv+DvJho
X-Received: by 2002:a17:90b:3d86:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3931e237c28mr1912503a91.15.1786574825450;
        Wed, 12 Aug 2026 15:47:05 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f2a7d9bsm511232a91.8.2026.08.12.15.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:47:05 -0700 (PDT)
Message-ID: <09a1229f680ad7b6e2d44aea142f76df94a69be7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/13] bpf: Enable aggregate return types up
 to 16 bytes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 15:47:02 -0700
In-Reply-To: <20260811000957.2382783-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000957.2382783-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> Relax btf_distill_func_proto() to accept a by-value struct or union that
> the R0:R2 convention added in earlier patches can carry:
>=20
> =C2=A0- a struct or union larger than 8 and up to 16 bytes, returned in t=
he
> =C2=A0=C2=A0 R0:R2 register pair, matching what LLVM emits for the BPF ta=
rget;
> =C2=A0- a struct or union up to 8 bytes, returned in R0 alone.
>=20
> A >8 byte scalar (__int128) was already accepted and is unchanged.
> Everything else stays rejected: a return type larger than 16 bytes, and a=
ny
> type that __get_type_size() cannot return in registers at all (e.g. an
> array), which it already reports as ret < 0.
>=20
> btf_distill_func_proto() also builds the trampoline (fentry/fexit/fmod_re=
t)
> and struct_ops function models, so relaxing it widens what those can atta=
ch
> to. A >8 byte return stays rejected on every path that reads the target's
> return value: commit c48796aa6c39 ("bpf: Reject >8 byte return values on
> return-reading trampoline paths") covers fexit, fmod_ret and fsession plu=
s
> their _multi variants, and struct_ops, and an fentry-only trampoline neve=
r
> sets BPF_TRAMP_F_CALL_ORIG so it does not touch the return value at all. =
A
> struct or union of 8 bytes or less is newly accepted for those paths; its
> single eightbyte is returned in R0 like any other scalar.
>=20
> btf_validate_return_type() is relaxed as well, so that it accepts a
> by-value struct or union up to 16 bytes in addition to void and scalars.
>=20
> With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
> verifier, JIT, precision-backtracking and live-register support from the
> earlier patches becomes reachable: this final patch enables <=3D16 byte
> aggregate return values end to end.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6606187ed4f4..5551abcea1d3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7592,7 +7592,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0	ret =3D __get_type_size(btf, func->type, &t);
> -	if (ret < 0 || btf_type_is_struct(t)) {
> +	/*
> +	 * __get_type_size() already restricts a non-negative ret to void, a
> +	 * pointer, an int, an enum or a struct/union, so only the size is chec=
ked
> +	 * here.
> +	 */

Nit: I'd drop this comment.

> +	if (ret < 0 || ret > 16) {
> =C2=A0		bpf_log(log,
> =C2=A0			"The function %s return type %s is unsupported.\n",
> =C2=A0			tname, btf_type_str(t));

...

> @@ -7988,6 +7993,35 @@ static int btf_validate_return_type(struct bpf_ver=
ifier_env *env, struct btf *bt
> =C2=A0	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t=
))
> =C2=A0		return 0;
> =C2=A0
> +	if (btf_type_is_struct(t) && t->size <=3D 16) {
> +		/*
> +		 * A >8 byte struct/union is returned in the R0:R2 register pair.
> +		 * A global function is verified in isolation, so its caller models
> +		 * the return as an opaque R0:R2 scalar pair; it must therefore
> +		 * contain only scalars, otherwise a pointer field would be
> +		 * laundered into a scalar and escape provenance and reference
> +		 * tracking. That requirement is enforced here: do_check_common()
> +		 * propagates the error for global functions and for the main
> +		 * program.
> +		 *
> +		 * A local (static) function is verified inline and its R0:R2 are
> +		 * copied as precise register state (with the JIT forced on when
> +		 * the pair is consumed), so a pointer field stays tracked and needs
> +		 * no such restriction. Accepting it here is not by itself what
> +		 * makes it legal: btf_check_subprog_call() drops any error other
> +		 * than -EFAULT. What it avoids is needlessly marking the
> +		 * subprogram's BTF unreliable.
> +		 *
> +		 * The main program (subprog 0) takes the scalar-only path as well,
> +		 * but its return value is the program's exit code, so a >8 byte
> +		 * return is rejected separately at BPF_EXIT.
> +		 */

Nit: the comment is way too long, I'd drop the justification.
     Especially given that at the moment btf_validate_return_type()
     would only be called from main/global subprograms/callback subprograms=
.

> +		bool local_func =3D subprog && !is_global;
> +
> +		if (local_func || __btf_type_is_scalar_struct(env, btf, t, 0))
> +			return 0;
> +	}
> +
> =C2=A0	return -EOPNOTSUPP;
> =C2=A0}
> =C2=A0

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8f0c4aed0781..f8294359c85d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11088,9 +11088,9 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_call_arg_meta *meta, u32 arg_
> =C2=A0}
> =C2=A0
> =C2=A0/* Returns true if struct is composed of scalars, 4 levels of nesti=
ng allowed */
> -static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> -					const struct btf *btf,
> -					const struct btf_type *t, int rec)
> +bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> +				 const struct btf *btf,
> +				 const struct btf_type *t, int rec)

Nit: since this function is now exported, let's drop the '__' prefix.

> =C2=A0{
> =C2=A0	const struct btf_type *member_type;
> =C2=A0	const struct btf_member *member;

...
