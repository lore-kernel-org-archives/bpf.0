Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61568466AE5
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266429; cv=none; b=YPN2uYLByTKVOf/t9d+3Bwiye52z5O84UTdWoRsKyjfVLRNDyEYM/4MIUrHf0YTU/g5qcU4tIIrrQaSdbNsZqLyIJhEIcNgDKTpUrl5A9xzJFYFTATvVJpNwLpyoTKCIAeLmI8bT4F9B/xPEtclZAK6avNvKkGDJRKHPW0aYS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266429; c=relaxed/simple;
	bh=46rmRz3ulKiJ9/xkxzhmmoYJJJzY6BDV1JwtixuwqoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGteT4/Q7cZW1YxuXXR4mwwSQWibEX5rHNWljL3gC/pL4/CG32OErg0r1DiEQtDkgmLMOwOgsTgE/JNe/WQGzqioOmNmpjPRWk4hQX66YE+E093Bkad3+i8YNNBNG0HOYRykWZjsHJq3iwtncynvMK9VPBB8B3sHSZVN920RDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nukOPZMT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nukOPZMT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ccf2360620so2300125ad.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785266422; x=1785871222; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hEbndDpFhHqj/WLRo1MORhUKkvNCPnU6fzDE30t5MiY=;
        b=nukOPZMTFH+lslo7cW/kiYLVI9jDchCM8oDgRKb82GUUHFmXaawpQ/FTmSi0LjzMsZ
         KFklYDPis9mTxIvFTaRxm3g0Adugc/X4rjclj6cTGw/NAMW2xEmm5PCbScBXE2CGyKlr
         vF3k89ehK8LMb/Sr8+wA+mbKJnHaYnMKwqnsmDummzZcaPoYUYL76IT2NlxYNG2tAltJ
         ix08EHDHaU9xZfNnYWT2O5QJ+v8FdKW3I8Ow2Y3lEEwAVj1I9TrZrKNR/+PEqmiDDcub
         HluytQQDSz4HKZDDpZ6ZoO4p0lE9ByNr4KO83hK/+Fy7ubs4EHTFFTM8RgqR0Xs8/Ta5
         n9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266422; x=1785871222;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEbndDpFhHqj/WLRo1MORhUKkvNCPnU6fzDE30t5MiY=;
        b=j6XwUve9N/K3kKU0mo6BItLy3TnIFAkZB5307toO++EiSRDTMn9mSN1VH89XQq+YZ8
         W/FWJUYkaPTBHAbra3ZrxZEsi2xUCpQODXNU0KLmKJIyk2Nhgmx9bdlGJC+z6aUbcdvu
         rC9e15c2FvSz4chc9EdcaPt5KuY+tpwjnUlwxqTh2+5/j4IaMrQ7eYK9mA1sUV3cC5iu
         UrGVBBSRzZ6RGirfs0f5Ykr+rLNQU5eE1oUsflbLP1V6zfli+tT+bpWxgNLKFUuQthX1
         f69qlGIeYpmoLkt8oZLiBfl6VdXwvoCiEgsZzCYVYesaJb9LirmZ2+H+Gu0vacE8zkeo
         eIqw==
X-Forwarded-Encrypted: i=1; AHgh+RqvgnfIrSnjWVn9CIw3Z20EYVW+bOFmkbxkJV3zXG3eDZb4UqzpJ/ME+xsawrLzwoUhoNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnXu1Uqfeix3VtrAXpDa4b2EnWZP87fHujUGzmq7ve7oDBoGZ
	Yvlio2w0CQu5Wbbn0lIdIFcN4CfYhlYop6hZeXEl5WpiApNsOoZ9DqzC
X-Gm-Gg: AR+sD12H9c4WLgAzi1tFblp5eoDclSL3vYQwJKXQA1u88107njTFxhCQPSz7bVh3i/5
	2QB9STApSXSNJRAQqebKJUXUxfHOp0t+8UhSAszxJNEmYjH3mjRElIIMWt/B/gvpFK3FxB8vL4w
	H30b+KQUzFQ9X3j9y53fy5zyvUWVBGW88sTg99sZ5jDuFNwKrFCJywtESaPJLclpPh/V/04H9KE
	h0x9J2g1+pUV40OhdF3RRkeF6lW7Mn+h/7HmyhTQqKalYvB0nsz0pIq3LnXPT7YoDmXpN5vSwy9
	M2D0ccvWbItFojuA8MYnNnSq4WWyWWouO1XTJyfS0KhNZ4Fgrwk/XLnLFSkIZ7rzEJWO7tebhhv
	Tccu2vM/lSsMmZlqQuEzkf+A8Owhu5SlCvODgpXzMvvvQNGaxjHVcnKtRlh/ZxHxcTVEuBU6lZM
	25gQgTf6gCTP4JCo1P43nHHWx0Lv3Tu1p8QGS/YfZ87otsFvczlebQlB2fhq0p2avXRkDbakPlP
	IoVMmevFfAK8+B0HLGUw1hhtCvEBlVgkALuyrjJ44fqJQ==
X-Received: by 2002:a17:902:f64a:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2d015a8b174mr44330025ad.5.1785266407459;
        Tue, 28 Jul 2026 12:20:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5258:1ab6:44ba:7529? ([2620:10d:c090:500::4:c456])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm2610644eec.22.2026.07.28.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:20:07 -0700 (PDT)
Message-ID: <cc7d59269cbe0fb24f9cf0f0ae40d555d050e07a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 12:20:05 -0700
In-Reply-To: <20260724190813.1458271-16-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-16-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2326b12a1531..76a84574b23e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4924,6 +4924,19 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] =3D {
>  	[CONST_PTR_TO_MAP] =3D btf_bpf_map_id,
>  };
> =20
> +static enum bpf_reg_type lookup_reg2btf_ids(const struct btf_type *ref_t=
)

Nit: the function would be a bit simpler, if ref_id is passed as a
     parameter instead of ref_t.

> +{
> +	enum bpf_reg_type type;
> +
> +	for (type =3D 0; type < __BPF_REG_TYPE_MAX; type++) {
> +		if (reg2btf_ids[type] &&
> +		    btf_type_by_id(btf_vmlinux, *reg2btf_ids[type]) =3D=3D ref_t)
> +			return type;
> +	}
> +
> +	return NOT_INIT;
> +}

...

> @@ -11429,10 +11431,14 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
>  	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
>  		arg_mem_size =3D true;
> =20
> -	/* This is the catch all argument type of register types supported by
> -	 * check_helper_mem_access. However, we only allow when argument type i=
s
> -	 * pointer to scalar, or struct composed (recursively) of scalars. When
> -	 * arg_mem_size is true, the pointer can be void *.
> +	/* A pointer to a struct without a size argument is classified as KF_AR=
G_PTR_TO_BTF_ID */
> +	if (btf_type_is_struct(ref_t) && !arg_mem_size)
> +		return KF_ARG_PTR_TO_BTF_ID;
> +
> +	/*
> +	 * Otherwise this is a memory buffer supported by check_helper_mem_acce=
ss(): a pointer
> +	 * to a scalar, or to void when paired with a size argument. The access=
 size is derived
> +	 * from the pointed-to BTF type unless a size argument follows.

Nit: below conditions would be easier to read if the whole
	 thing was structured as:
	=20
	   if (arg_mem_size) {
	     if (!btf_type_is_void(ref_t)) {
		   ...
		   return -EINVAL;
		 }
	     return KF_ARG_PTR_TO_MEM;
	   } else {
	     if (btf_type_is_struct(ref_t))
	       return KF_ARG_PTR_TO_BTF_ID;
	     if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(ref_t)=
) {
		   ...
	       return -EINVAL;
	     }
	     return KF_ARG_PTR_TO_MEM || MEM_FIXED_SIZE;
	   }
	  =20
>  	 */
>  	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, met=
a->btf, ref_t, 0) &&
>  	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {

...

> @@ -12377,20 +12370,46 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
>  			break;
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			/* Only base_type is checked, further checks are done here */
> -			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
> -			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) =
&&
> -			    !reg2btf_ids[base_type(reg->type)]) {
> -				verbose(env, "%s is %s ", reg_arg_name(env, argno),
> -					reg_type_str(env, reg->type));
> -				verbose(env, "expected %s or socket\n",
> -					reg_type_str(env, base_type(reg->type) |
> -							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
> +			if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID ||
> +			    reg2btf_ids[base_type(reg->type)]) {
> +				if (!is_trusted_reg(env, reg) ||
> +				    bpf_type_has_unsafe_modifiers(reg->type)) {
> +					if (!is_kfunc_rcu(meta)) {
> +						verbose(env, "%s must be referenced or trusted\n",
> +							reg_arg_name(env, argno));
> +						return -EINVAL;
> +					}
> +					if (!is_rcu_reg(reg)) {
> +						verbose(env, "%s must be a rcu pointer\n",
> +							reg_arg_name(env, argno));
> +						return -EINVAL;
> +					}
> +				}
> +
> +				ret =3D process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref=
_id, meta, i, argno);
> +				if (ret < 0)
> +					return ret;
> +				break;
> +			}
> +
> +			if (!__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
> +				enum bpf_reg_type reg2btf_type =3D lookup_reg2btf_ids(ref_t);
> +
> +				verbose(env, "%s is %s expected %s %s",
> +					reg_arg_name(env, argno), reg_type_str(env, reg->type),
> +					btf_type_str(ref_t), ref_tname);
> +				if (reg2btf_type !=3D NOT_INIT)
> +					verbose(env, " or %s", reg_type_str(env, reg2btf_type));
> +				verbose(env, "\n");
>  				return -EINVAL;
>  			}
> -			ret =3D process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_=
id, meta, i, argno);
> -			if (ret < 0)
> -				return ret;
> -			break;
> +
> +			/*
> +			 * If the register does not contain btf id but the argument type is a=
 pointer to
> +			 * scalar-only struct, allow verifying it as a fixed size memory.
> +			 */
> +			kf_arg_type =3D KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
> +			fallthrough;

I think this now accepts one previously rejected case:
- register being PTR_TO_BTF_ID, pointer to scalar
- parameter being pointer to scalar w/o size register.
Previously it was rejected by the following code in the
get_kfunc_ptr_arg_type():

  if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_type(r=
eg->type)])) {
          if (!btf_type_is_struct(ref_t)) {
                  verbose(env, "kernel function %s %s pointer type %s %s is=
 not supported\n",

Is this intended?

...
