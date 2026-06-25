Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702B2DF68
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351068; cv=none; b=MSqqLv4DI8qkCZmvhfmXxGPfQldCHtEmy5iGp27zgaH1uC7HMxE3wd73Mm2o0qx1oc+NFHyKPuGD+nt/QlJuxQUH+VtVYTXKah2kPm/RUgxxvUjY6h21NBxHOjaH44P5lbFkoPcjaqjtSFqZ1IcYuN+OR5OKFAUTqpU294A2YJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351068; c=relaxed/simple;
	bh=3BFkmTiZFshV02Vrut0z+XMP9I7EOwq/DBeYFp5eOQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBlCIZF4JSC/ZgpDh+8rOgHCf+cF9+BtjogzV7/TYUDCVVKWkdj7CkiCvEPhqCfx+M/s6NjB3+WkgRNgfBghMJPRyUADwHeQ03O0hK0yxbBEq0JuxrQkDSRH6UQpiMJ0kEwr20ihg9poz4gB5g6Ipwi+iZkCvOv8sN4FWqixxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLEYQwYR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLEYQwYR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6afcc99a5so1724495ad.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782351066; x=1782955866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rlXu+Hnw6Z/kmMWLUxr71CqrEGIckzoH2Ulnmnf/AWk=;
        b=YLEYQwYRYJqFOQYVjOSZhI0JS9KT/GjWCZ7yglS22ZfDhRHXWCJ2n5Z/eQ9amfFdiF
         sZjmTprVcsDytIIFebvbbSm5+Cb3VKyx91YmPlfaphJ0PkKgCm6tZxgEcrD5UtOs+jnc
         SNiKIHJalKCPy38ir+DkyRkrqiF5VQJMtHomKhMZ9te8OpcgFm/OfqePwtsAUP5DuEk+
         0Ny/jQNiWF8yyqlAPjfbYCg9ce6wvHvLl9caC4G7FKEHZ/SZ18jtX9gwbXUEtNpqtrvU
         /KLAU3pMtKEtd98Iz9G0aXksKzGT4Xik6xunO259ltlGMWUl1bIBbx6szhDIgmKzTojr
         mOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782351066; x=1782955866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlXu+Hnw6Z/kmMWLUxr71CqrEGIckzoH2Ulnmnf/AWk=;
        b=gngKpRuBZx1STwvLlQR0Zh6owdnJxzpEJP/3R+tGM+WHwFBAuG+sothNYOfBbxqUCi
         +3wsdkBFzY3vqdQYuzYPbL1Fhw3bE4jRRGdwE9ZU7oaTl5tJ5SUpBmwPrljV7TW/6uRv
         TjdbYGqWsGuX8K2WKKfDWgvD/Mn9z3kEzK3YENF2Z7Jzry6ZC8Cz7if77Q0OsZ+/mvTJ
         eW+pVTqs7t6r1MxJcGbVbAvnM+QlC8FUNaWMJ+JaGLA+0hbbxQUH8Z6Dqdm4uimWyMxk
         RblY5I0Sdu6ICnscayW3W821yzdJ5nNFGIhVPod4PcYHl/BmVcUTS+YtBaNpKP/ONP6L
         BleQ==
X-Forwarded-Encrypted: i=1; AHgh+RrokaEa92W6okjyj380hgThbZAuV2yWNLeRRVgfJd9pHnIIHWgB3aK3SFmpGx2IgOS76aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6W1/shSNUoPlhWvD+1E+XuDfPp1jmZYAt5IpYP342t/XnejPo
	5mouj4gU9dvHWXmVKipSNmh1B79tF6CAiB5KTVwzGX8lTxyu0H5u75/A5KqUX8ZZamc=
X-Gm-Gg: AfdE7cmfzLkU77bnaX/AeymRRLRCcIhRKQaBzclo5G5h4wtN5uyC+SPqlYdTzMbFiY3
	6MEofrDT+7kfyEJC25t9P8EQejfhUWGa/ZhMID2GTIa1o5FXY4nf+z3jOGiSUx99lonC8gxBIZ/
	MDnZfa13CCFeaQlXFxbgUs84qP3eE1XqYP0n6wZ1Uf6L/130lcO0Cwk1Fx5zjRY0bd5fXtfNNUO
	WjXBQ2C8EGSl8qirbYhTBSRvZc8Ykm5cRO7aJCixfYUqdE949vpW/iWnCvnO8R+5O++8ElaODgw
	Ty7t6FcxOgUlD2sXnJeMgRmvp1+f/GVfl5Jcr52pAcxilzt+bwKHFIwAOa4I8rtYcB8CHbuPYg0
	IP3PRdqlvpFboMJV8FxMTBQGJwxgxSfk8hUcyGhZr3M6B4y+qcoPZFCvKXW6AGXkJm+aVbmEiNo
	T5GEac5skWma9N3DGeanV35QxeEJkISMbKZz/YInzMAg==
X-Received: by 2002:a17:902:ebc6:b0:2c6:af4b:99a1 with SMTP id d9443c01a7336-2c7c3d2a805mr90029125ad.3.1782351065922;
        Wed, 24 Jun 2026 18:31:05 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b2bd7sm7819505ad.48.2026.06.24.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:31:05 -0700 (PDT)
Message-ID: <ace0c3d71d3d1c19ad6ba497252362474a8ad45e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/17] bpf: Report Memory Safety bounds
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 18:30:58 -0700
In-Reply-To: <20260619205934.1312876-10-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected memory-range verifier failures with Memory Safety report=
s
> while preserving the existing terse verifier messages for compatibility.
>=20
> Cover stack spill corruption, uninitialized stack reads, variable stack h=
elper
> accesses, and check_mem_region_access() range-proof failures. The bounds =
report
> spells out the required offset + access_size <=3D object_size proof with =
concrete
> values and uses scoped diagnostic history for causal context.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

> @@ -1541,6 +1555,153 @@ static void bpf_diag_format_scalar_range(struct b=
pf_diag_reg_fmt *fmt,

[...]

> +static void bpf_diag_format_access_offset(struct bpf_verifier_env *env,
> +					  char *buf, size_t size, int off,
> +					  const struct bpf_reg_state *reg)
> +{
> +	struct bpf_diag_scratch *scratch =3D bpf_diag_scratch(env);
> +	struct bpf_diag_reg_fmt *fmt;
> +	char *start;
> +
> +	if (tnum_is_const(reg->var_off)) {
> +		start =3D bpf_diag_scratch_buf(env, 2,
> +					     NULL);
> +		if (!start) {

Nit: this is an impossible branch, bpf_diag_format_access_offset()
     is called from bpf_diag_report_mem_bounds() under condition
     that bpf_diag_enabled(env) is true.

> +			scnprintf(buf, size, "constant");
> +			return;
> +		}
> +		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN,
> +					(s64)reg->var_off.value, off);
> +		scnprintf(buf, size, "constant %s", start);
> +		return;
> +	}
> +
> +	if (tnum_is_unknown(reg->var_off) &&
> +	    bpf_diag_cnum64_unknown(reg->r64)) {
> +		scnprintf(buf, size, "unknown");

Nit: I'd use "unbounded".

> +		return;
> +	}
> +
> +	fmt =3D &scratch->reg_fmt;
> +	memset(fmt, 0, sizeof(*fmt));
> +
> +	bpf_diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range),
> +				     reg->r64);
> +	if (off)
> +		scnprintf(buf, size,
> +			  "variable: known bits %#llx, unknown mask %#llx, plus fixed offset =
%d; %s",
> +			  (u64)reg->var_off.value, reg->var_off.mask, off,
> +			  fmt->range);
> +	else
> +		scnprintf(buf, size,
> +			  "variable: known bits %#llx, unknown mask %#llx; %s",
> +			  (u64)reg->var_off.value, reg->var_off.mask,
> +			  fmt->range);
> +}
> +
> +static u64 bpf_diag_mem_max_start(const struct bpf_reg_state *reg, int o=
ff)

Could you please elaborate a bit why is this function needed?
It is only called from

  > +	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
  > +	default:
  > +		max_start =3D bpf_diag_mem_max_start(reg, off);
  > +		max_end =3D max_start + size;
  > +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
  > +			  "the largest possible access ends at %llu: start %llu + access_si=
ze %d, beyond object_size %u",
  > +			  max_end, max_start, size, mem_size);
  > +		break;

And there it would report "start 0 + access_size 10" in case of negative of=
fset.
Which is not verifier actually checks for:

  __check_mem_access(env, reg, argno, reg_umax(reg) + off, ...)
                                      ^^^^^^^^^^^^^^^^^^^
                                  this parameter is declared as 'int'
> +{
> +	/* A negative fixed offset can clamp the maximum start to zero when
> +	 * the unsigned variable maximum is smaller than -off.
> +	 */
> +	if (off < 0 && reg_umax(reg) < (u64)-off)
> +		return 0;
> +	return reg_umax(reg) + off;
> +}
> +
> +void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_i=
dx,
> +				int regno, const char *reg_name,
> +				const char *type_name,
> +				enum bpf_diag_mem_bounds_kind kind,
> +				int off, int size, u32 mem_size,
> +				const struct bpf_reg_state *reg)
> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno =3D bpf_diag_current_frameno(env),
> +		.regno =3D regno,
> +	};
> +	char *offset_desc, *proof, *start;
> +	u64 max_start, max_end;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	offset_desc =3D bpf_diag_scratch_buf(env, 0, NULL);
> +	proof =3D bpf_diag_scratch_buf(env, 1, NULL);
> +	start =3D bpf_diag_scratch_buf(env, 2, NULL);
> +	if (!offset_desc || !proof || !start)
> +		return;
> +
> +	switch (kind) {
> +	case BPF_DIAG_MEM_NEGATIVE_MIN:
> +		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg)=
,
> +					off);
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the smallest possible access starts at %s, below 0",

Nit: "the minimal bound for a memory access is a negative value: %s".

> +			  start);
> +		break;
> +	case BPF_DIAG_MEM_MIN_OUT_OF_RANGE:
> +		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg)=
,
> +					off);
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the smallest possible access starts at %s, outside object_size %u"=
,

Nit: "the minimal bound for a memory access is %s and is outside of the obj=
ect of size %u"

> +			  start, mem_size);
> +		break;
> +	case BPF_DIAG_MEM_UNBOUNDED:
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "%s has unsigned maximum %llu, which exceeds BPF_MAX_VAR_OFF %u",

Nit: "the maximal bound for a memory access is %llu and exceeds maximum all=
owed offset of %u".

> +			  reg_name, reg_umax(reg), BPF_MAX_VAR_OFF);
> +		break;
> +	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
> +	default:

Nit: compounding this with 'default:' looks strange.

> +		max_start =3D bpf_diag_mem_max_start(reg, off);
> +		max_end =3D max_start + size;
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the largest possible access ends at %llu: start %llu + access_size=
 %d, beyond object_size %u",
> +			  max_end, max_start, size, mem_size);
> +		break;
> +	}
> +

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c5f24528071..af04709c5178 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3527,6 +3527,13 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  	    !bpf_is_spilled_scalar_reg(&state->stack[spi]) &&
>  	    size !=3D BPF_REG_SIZE) {
>  		verbose(env, "attempt to corrupt spilled pointer on stack\n");
> +		bpf_diag_report_memory(env, insn_idx,
> +				       "stack spill corruption",
> +				       bpf_diag_scratch_printf(env,
> +							       0,
> +							       "This store writes %d bytes at stack offset %d into a stac=
k slot that currently holds a spilled pointer. Partial writes to spilled po=
inters are rejected because they can corrupt pointer metadata and leak kern=
el pointers.",
> +							       size, off),
> +				       "Write the full 8-byte spilled pointer slot, or use a separat=
e stack slot for scalar data before overwriting only part of it.");
>  		return -EACCES;
>  	}
> =20
> @@ -3811,6 +3818,18 @@ static void mark_reg_stack_read(struct bpf_verifie=
r_env *env,
>  	}
>  }
> =20
> +static void bpf_diag_report_stack_read_uninit(struct bpf_verifier_env *e=
nv,
> +					      int off, int i, int size)
> +{
> +	bpf_diag_report_memory(env, env->insn_idx,
> +			       "uninitialized stack read",
> +			       bpf_diag_scratch_printf(env,
> +						       0,
> +						       "This rejected read uses %d bytes at stack offset %d, but b=
yte %d in that range is uninitialized on this path. Programs with sufficien=
t privilege can be allowed to read uninitialized stack bytes, but this prog=
ram is being rejected without that allowance.",

Nit: instead of "sufficient privilege" I'd refer to CAP_BPF (or which one i=
s it?).

> +						       size, off, i),
> +			       "Initialize every byte in the stack range before reading it, a=
djust the offset and size so the read covers only initialized bytes, or loa=
d with the privilege needed for uninitialized stack reads.");
> +}
> +
>  /* Read the stack at 'off' and put the results into the register indicat=
ed by
>   * 'dst_regno'. It handles reg filling if the addressed stack slot is a
>   * spilled reg.
> @@ -3896,9 +3915,12 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  					if (type =3D=3D STACK_POISON) {
>  						verbose(env, "reading from stack off %d+%d size %d, slot poisoned =
by dead code elimination\n",
>  							off, i, size);
> +						return -EFAULT;

sashiko is right to call this out as a behavioral change,
but it is a correct changer nonetheless.

>  					} else {
>  						verbose(env, "invalid read from stack off %d+%d size %d\n",
>  							off, i, size);
> +						bpf_diag_report_stack_read_uninit(env, off, i,
> +										  size);
>  					}
>  					return -EACCES;
>  				}
> @@ -3951,9 +3973,12 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  			if (type =3D=3D STACK_POISON) {
>  				verbose(env, "reading from stack off %d+%d size %d, slot poisoned by=
 dead code elimination\n",
>  					off, i, size);
> +				return -EFAULT;
>  			} else {
>  				verbose(env, "invalid read from stack off %d+%d size %d\n",
>  					off, i, size);
> +				bpf_diag_report_stack_read_uninit(env, off, i,
> +								  size);
>  			}
>  			return -EACCES;
>  		}
> @@ -4045,6 +4070,13 @@ static int check_stack_read(struct bpf_verifier_en=
v *env,
>  		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
>  		verbose(env, "variable offset stack pointer cannot be passed into help=
er function; var_off=3D%s off=3D%d size=3D%d\n",
>  			tn_buf, off, size);
> +		bpf_diag_report_memory(env, env->insn_idx,
> +				       "variable stack access",
> +				       bpf_diag_scratch_printf(env,
> +							       0,
> +							       "The helper would access the stack through variable offset=
 %s plus fixed offset %d and size %d. Helper stack memory arguments require=
 a constant stack offset and a precise initialized range.",
> +							       tn_buf, off, size),
> +				       "Use a fixed stack offset for helper memory arguments, or cop=
y the needed bytes into a fixed stack slot first.");
>  		return -EACCES;
>  	}
>  	/* Variable offset is prohibited for unprivileged mode for simplicity
> @@ -4312,6 +4344,12 @@ static int check_mem_region_access(struct bpf_veri=
fier_env *env, struct bpf_reg_
>  	      reg_smin(reg) + off < 0)) {
>  		verbose(env, "%s min value is negative, either use unsigned index or d=
o a if (index >=3D0) check.\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_mem_bounds(env, env->insn_idx,
> +					   reg_from_argno(argno),
> +					   reg_arg_name(env, argno),
> +					   reg_type_str(env, reg->type),
> +					   BPF_DIAG_MEM_NEGATIVE_MIN,
> +					   off, size, mem_size, reg);

Nit: avoid duplicating this 10 parameters call?

        err =3D -EACCESS;
        kind =3D BPF_DIAG_MEM_NEGATIVE_MIN;
        goto report_error;

  report_error:
        bpf_diag_report_mem_bounds(...);
        return err;

?

>  		return -EACCES;
>  	}
>  	err =3D __check_mem_access(env, reg, argno, reg_smin(reg) + off, size,
> @@ -4319,6 +4357,12 @@ static int check_mem_region_access(struct bpf_veri=
fier_env *env, struct bpf_reg_
>  	if (err) {
>  		verbose(env, "%s min value is outside of the allowed memory range\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_mem_bounds(env, env->insn_idx,
> +					   reg_from_argno(argno),
> +					   reg_arg_name(env, argno),
> +					   reg_type_str(env, reg->type),
> +					   BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
> +					   off, size, mem_size, reg);
>  		return err;
>  	}
> =20
> @@ -4329,6 +4373,12 @@ static int check_mem_region_access(struct bpf_veri=
fier_env *env, struct bpf_reg_
>  	if (reg_umax(reg) >=3D BPF_MAX_VAR_OFF) {
>  		verbose(env, "%s unbounded memory access, make sure to bounds check an=
y such access\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_mem_bounds(env, env->insn_idx,
> +					   reg_from_argno(argno),
> +					   reg_arg_name(env, argno),
> +					   reg_type_str(env, reg->type),
> +					   BPF_DIAG_MEM_UNBOUNDED,
> +					   off, size, mem_size, reg);
>  		return -EACCES;
>  	}
>  	err =3D __check_mem_access(env, reg, argno, reg_umax(reg) + off, size,
> @@ -4336,6 +4386,12 @@ static int check_mem_region_access(struct bpf_veri=
fier_env *env, struct bpf_reg_
>  	if (err) {
>  		verbose(env, "%s max value is outside of the allowed memory range\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_mem_bounds(env, env->insn_idx,
> +					   reg_from_argno(argno),
> +					   reg_arg_name(env, argno),
> +					   reg_type_str(env, reg->type),
> +					   BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
> +					   off, size, mem_size, reg);
>  		return err;
>  	}
> =20
