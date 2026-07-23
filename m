Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534F3955F9
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784905; cv=none; b=lB2YaJ3udrOagQI+yz21axSSz0fQcq7ocBijyfVhkizXPjksz0ULudSh6+yZwBHynbHfApyZ0cmzar4tI//a4TFo2JSKMqFkSeXDnbfcqvnipQ9LaMRd+FD7RcqcLy4Luf9rQWDpQAMmSqWJOdybG8k81sIFbvajn0bCr0oLAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784905; c=relaxed/simple;
	bh=AVAS6XvwTp2S3300HB+UeXIezUrL7AgrGAA7AsPiLGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H4NDqb+TdiZADEjwzqVUGQYAzOUVQkEiQIPzOBlMuYekwu3ad1xVJsEc/FY8KZO5qtNYx2t4Z4k9CycvNMEqMTWlUyTTdduWC4U78FxBOLoqv6+SNoAyZl0G4sZXTR5Bq7nvPILCBt+uopYM1VJx0lN457NYHNTj6EyQ/yi6fxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwijI2m6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwijI2m6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40831F000E9;
	Thu, 23 Jul 2026 05:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784902;
	bh=1yyPBHWNbEuWxUoibbBuJz1NZwKx4/oUCA5bTElwVxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WwijI2m65Adn5/PtMHsBsT2UBESObgvi3+nxDviOjaVfCSlpy8LtSYqdp8i2x96QV
	 5csTQb2xvk7BQxDEncyP2PVH6fLbYbmFIBQTOAzcadsr4jS+EMWDSqVi5oxKT5s7Kr
	 WSXoLDalZWfo6u5W/wGO8sVv9hMmUx7JAAKyPT4/l/koeglalLVTubrRdzojotE95W
	 wRI/5T6EtDnbVhaiIJZtE8hu3iuf7zWNCZVh1ujd6NlRfFbJhXo9mqcS5y9lDz/2Tm
	 ndO5OhTC+ssVTLdam0I2j+Ewiers+G0c7jC0/PGcdne0vZgYYowzddIVf1yWEgWz28
	 WIWJRDpZ8fhVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 03/18] bpf: Split kfunc map argument into
 __const_map and __map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-4-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:35:02 +0000
Message-Id: <20260723053502.B40831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The newly introduced `KF_ARG_CONST_MAP_PTR` logic fails to ver=
ify that the register's base type is `CONST_PTR_TO_MAP`. Any register with =
a non-zero union aliasing `map_ptr` (such as `PTR_TO_MAP_VALUE`) can bypass=
 validation, leading to severe type confusion at runtime where user-control=
led map value memory is treated as a `struct bpf_map *`.
--

--- Patch [3]: [PATCH bpf-next v1 03/18] bpf: Split kfunc map argument into=
 __const_map and __map ---
commit 2aa2cd575b3d4be283e92e30e814910f54fbe0cc
Author: Amery Hung <ameryhung@gmail.com>

bpf: Split kfunc map argument into __const_map and __map

This commit splits the kfunc map argument annotation to avoid type confusio=
n.
__const_map indicates a verifier-known map, while __map indicates an opaque
struct bpf_map resolved at runtime.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bff51aff25579..0ba0de8eb8fe0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12164,6 +12168,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_call_arg_me
>  				}
>  			}
>  			fallthrough;
> +		case KF_ARG_CONST_MAP_PTR:
>  		case KF_ARG_PTR_TO_ITER:
>  		case KF_ARG_PTR_TO_LIST_HEAD:
>  		case KF_ARG_PTR_TO_LIST_NODE:

[Severity: Critical]
Does this skip the is_trusted_reg() checks and leave arg_type as ARG_DONTCA=
RE?
Since KF_ARG_CONST_MAP_PTR falls through to the break below, it seems we mi=
ght
bypass pointer type safety enforcement here.

[ ... ]
> @@ -12371,12 +12376,16 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
>  			if (ret < 0)
>  				return ret;
>  			break;
> -		case KF_ARG_PTR_TO_MAP:
> -			/* If argument has '__map' suffix expect 'struct bpf_map *' */
> -			ref_id =3D *reg2btf_ids[CONST_PTR_TO_MAP];
> -			ref_t =3D btf_type_by_id(btf_vmlinux, ref_id);
> -			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> -			fallthrough;
> +		case KF_ARG_CONST_MAP_PTR:
> +			if (!reg->map_ptr) {
> +				verbose(env, "pointer in %s isn't map pointer\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			ret =3D process_map_ptr_arg(env, reg, argno, meta);
> +			if (ret < 0)
> +				return ret;
> +			break;

[Severity: Critical]
Is there a missing check for base_type(reg->type) =3D=3D CONST_PTR_TO_MAP h=
ere?

Since this breaks instead of falling through to KF_ARG_PTR_TO_BTF_ID like t=
he
old code did, it looks like any register with a non-zero union aliasing
map_ptr (such as PTR_TO_MAP_VALUE) can bypass validation.

For example, could a BPF program call bpf_wq_init(wq, map__const_map, flags)
and pass a PTR_TO_MAP_VALUE for both the wq and map__const_map arguments?

If wq and map__const_map use the same register, process_map_ptr_arg() would
verify meta->map.ptr =3D=3D reg->map_ptr (which evaluates to true), and the=
n break
out without ever verifying the register type. This would cause the kernel to
treat user-controlled bytes inside a map value as a kernel struct bpf_map
object, potentially leading to memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D3
