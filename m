Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DC388397
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599635; cv=none; b=LcI0YLFTafAC+T4Z243eqW/TNC2MdeCsD/vMvwhwNgvS9qgfJVGwoqLYBoEic5S4Hkk9xRe0aTpgKSPm9DbLG4JEcpW9998Gp4I8HlU4c887fn06iIy4wMRa1cQK5QVOIF/wTkOoZHq3enQhM662kHa1EkP9PMMUA0sJzNaTtss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599635; c=relaxed/simple;
	bh=yNMYzK+BxdnAmQZAovUk1PGMxP6S1Zpp9l+HmXOhugU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnAmgii5RvuJKra9Ld78jsgUlmXYvlHJjjd76xmRnZ8Q2+cgifXfkcRIYlIw2FSMFbmRxUAbzUlaf0xNgZhEs31EbTw1meGZV9s6/+tH5FuIKzQhN2LThTQFTthS3jhoAoT7eMXXge9KFYZKCRyfJlLeTgRQsz7JDubBlpOxZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYjjWrCr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYjjWrCr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab973140bso50440545ad.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787599633; x=1788204433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yS3JUiCyvYcm65hMZ3R2gXl//P97rHoVTNMt/uUNh0M=;
        b=gYjjWrCrbxrKNP4MvAZLRkAOwBZSFodsHJlztTLXfn/phwgIcYqWC1AZv9X2pM2zyC
         ZJe9EnYT5ZezjBjlPjtiM9svdBvSB6Xr+Ks8XBtFRHU8pg+mHVZ11y+jQ+2V2FMf9n7A
         d9TcJf2kR9iHaFizwH0Kvtl5MFGoMGHE5jwc8xOHoQBtirjkcD4422MqejIMwUE9hzdK
         4qVWQ8HQGT/l1sORcKYbpDqKa0m7PfOABEDcgOfqbnnCru/wf1PMMKh3lbT/7JbWLxCW
         pHOjtuSAOi7QeCXIRtdktpOz8rYsBWKz/QYZBr7SvvDt/+TonjF2x0WOaLbGZz65OnuV
         KreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787599633; x=1788204433;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yS3JUiCyvYcm65hMZ3R2gXl//P97rHoVTNMt/uUNh0M=;
        b=DP9zur/2Hv1Rty38v5MiovSTagHBY1XBEPgInpViVQO3EgdjTy8ghzNe380+PEg9H3
         ZVjtEw7u20kjjh7hlDpvMID/vD2PTLHhnVuZazZV9qg3jj5v9lKZd4PygqfVKOUxNV3y
         Xohel7NOOjoZTHtDEbIfovgFTV6qDs3A6TF7bSuuFJ4pLYXR1yPlMy45hW5PXCvsoF8j
         c6FvuaKORXJLD8hasQsV5AjhNkshKr4JBDHeJV4s1NKcJ/SCtcLSY43cWyf+REiiu/0Z
         e2Bf32RsH8xwLKbid/806ITJmW9VhggcucaK0QUzB+H4Nr8obQMlsOLDzVqWe9mBe/Dy
         PszA==
X-Forwarded-Encrypted: i=1; AHgh+RoLYJE5HLkk0i++AyTXafT7fsnoic9hnHMf0Sk5V6RrIPCdP7AccvsEAGQ+4vd18kVxUyk=@vger.kernel.org
X-Gm-Message-State: AFuF++myXnN0KFGY2bMidxev2RY2NO+Z6Fd+WCm3KdPgQsc3uvLHQ4nD
	69aQB0B99gB1VRqd1Sp4bXtGuw3/7aeegoM3+Zj/K/Le2xX44tN+QxOP
X-Gm-Gg: AR+sD10pk19uOw2R3xMNGG7ZPZ2CEjx8TsCJA/SR05I34Lv1UUEvEsp1ZzfZWrUxeqN
	9VloUmu71hkx7eHwv70HeZDhhvjoFZlBLiBihLiyK5ZylWcHmOGhkzA+9DhOa1H68MKPj8dn3lN
	CYUJ0RPgWWBkCWRDxHcSkE1grH2u+L+TSfrAjT2G7MNlAsPWjqsXsoXNWpCYNkszhgXcXdoFu2s
	m/p23R9H6URWuGmW3A0v0nwSyTIgb4Qhj5ALr8qhJe2zVDm4+7N9l3zCKh5iPZU4YAcukH258ce
	UnCBkAayh+KBvofrISdk7Sq+VjbfL5nyuwMFIKfNT3apXBQMBkE5/IWZIWGaEY7epIurKHofI9k
	ZJW79/+Go5DZqRRA9gNIPFp0sGhst5NbedA3evBUDrdcYRoc4tObCXGcx9z8+YB0orkEP2lk15w
	0TDurx+old0jWL7p+Qd9T4mX+j3cmec4P6EEkYnF1pRIEL16UZbw9OHLzVzbXwJ4vjJiwYXz4eb
	fy4x0fGegfv2XKQ93aTpLq62ofspqORhy65MSeXERGjrw==
X-Received: by 2002:a17:902:cf04:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d670cbd304mr87978445ad.12.1787599633443;
        Mon, 24 Aug 2026 12:27:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:21a6:ad3f:64a7:7661? ([2620:10d:c090:500::5:ef40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280af94751sm19755863eec.26.2026.08.24.12.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:27:13 -0700 (PDT)
Message-ID: <5add32b3e212f7bcc01eb920c51749ae6d2aafcd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Report which member makes a kfunc
 return type unsupported
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 24 Aug 2026 12:27:11 -0700
In-Reply-To: <20260824144948.992324-1-yonghong.song@linux.dev>
References: <20260824144943.991316-1-yonghong.song@linux.dev>
	 <20260824144948.992324-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-24 at 07:49 -0700, Yonghong Song wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9aa29c367008..c6aecba6437a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11623,10 +11623,14 @@ static bool is_kfunc_arg_implicit(const struct =
bpf_call_arg_meta *meta, u32 arg_
>  	return argn <=3D arg_idx;
>  }
> =20
> -/* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
> -bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> -			       const struct btf *btf,
> -			       const struct btf_type *t, int rec)
> +/*
> + * Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed.
> + * On failure @bad, when given, names the member that made the answer no=
, so a
> + * diagnostic can point at it rather than at the whole type.
> + */
> +static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const s=
truct btf *btf,
> +				   const struct btf_type *t, int rec,
> +				   const struct btf_member **bad)
>  {
>  	const struct btf_type *member_type;
>  	const struct btf_member *member;
> @@ -11644,23 +11648,35 @@ bool btf_type_is_scalar_struct(struct bpf_verif=
ier_env *env,
>  				verbose(env, "max struct nesting depth exceeded\n");
>  				return false;
>  			}
> -			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
> +			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1, bad))
>  				return false;
>  			continue;
>  		}
>  		if (btf_type_is_array(member_type)) {
>  			array =3D btf_array(member_type);
>  			if (!array->nelems)
> -				return false;
> +				goto bad_member;
>  			member_type =3D btf_type_skip_modifiers(btf, array->type, NULL);
>  			if (!btf_type_is_scalar(member_type))
> -				return false;
> +				goto bad_member;
>  			continue;
>  		}
>  		if (!btf_type_is_scalar(member_type))
> -			return false;
> +			goto bad_member;
>  	}
>  	return true;
> +
> +bad_member:
> +	if (bad)
> +		*bad =3D member;

The bot is correct about the nested types, would be nice to return the
containing struct.

> +	return false;
> +}
> +
> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> +			       const struct btf *btf,
> +			       const struct btf_type *t, int rec)
> +{

Nit: all callers specify 'rec =3D=3D 0', hide it as well and remove the par=
ameter?

> +	return btf_scalar_struct_walk(env, btf, t, rec, NULL);
>  }
> =20
>  enum kfunc_ptr_arg_type {
> @@ -14030,17 +14046,41 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
>  		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
>  			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
>  	} else if (btf_type_is_struct(t)) {
> +		const struct btf_member *bad =3D NULL;
> +
>  		/*
>  		 * The returned struct comes back as raw register bits modeled
>  		 * as an unknown scalar, so it must contain only scalars:
>  		 * otherwise a pointer field would be laundered into a scalar
>  		 * and escape provenance and reference tracking.
>  		 */
> -		if (!btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +		if (!btf_scalar_struct_walk(env, desc_btf, t, 0, &bad)) {
> +			const char *member_note =3D "";
> +
>  			verbose(env,
>  				"kernel function %s returns %s %s that is not composed of scalars\n"=
,
>  				func_name, btf_type_str(t),
>  				btf_name_by_offset(desc_btf, t->name_off));
> +			if (bad) {
> +				const char *bad_name =3D btf_name_by_offset(desc_btf, bad->name_off)=
;
> +				const struct btf_type *bad_type;
> +
> +				bad_type =3D btf_type_skip_modifiers(desc_btf, bad->type, NULL);
> +				verbose(env, "member '%s' has type %s\n", bad_name,
> +					btf_type_str(bad_type));
> +				member_note =3D bpf_diag_fmt(
> +					env, " Its member '%s' is %s, not a scalar.", bad_name,
> +					btf_type_str(bad_type));
> +			}

Nit: since we are going into some details with this message,
     it seems appropriate to handle the case when bad =3D=3D NULL,
     but btf_scalar_struct_walk() returns false, saying that
     the structure is more then 4 levels deep.

> +			bpf_diag_program_structure(
> +				env, insn_idx, "unsupported kernel function return type",
> +				"Call a kernel function that returns only scalars by value.",
> +				"%s() returns %s %s by value.%s "
> +				"A by-value return arrives as raw register bits that the verifier "
> +				"can only model as unknown scalars, so e.g. a pointer may lose "
> +				"the provenance and reference tracking that make it safe to use.",

Nit: I think this description adds more confusion. I'd say something
     like "Only kfuncs returning scalar values or arena pointers, or
     structures composed of scalar values and arena pointers are
     supported".

> +				func_name, btf_type_str(t),
> +				btf_name_by_offset(desc_btf, t->name_off), member_note);
>  			return -EINVAL;
>  		}
>  		mark_kfunc_ret_regs(env, regs, t->size);
