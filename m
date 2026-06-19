Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457D34C141
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912444; cv=none; b=WiNSPLkwDP6r3ZB8+9iPS1c+52uYWRinPdqym3MLawymaSEyuNGpHWyT267cPP+8PWC0pkTqIlzMwtk+tBt/zB5ZhmUGZDpAVEVZWAyAxEQO/KyjN2gJ8tOXfsDU14e/o/AjJj4nGlJQ1sUb1JtuH1aqpZthRFPmpPEXAgZyOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912444; c=relaxed/simple;
	bh=j7t+/5X7tMGh6m8GxCRalB8GMZdWdBzyW45g5GYkF3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dtoL1JOLqJnxFgNU3JNGRHPpoyt8qSZrTSAR9VYbjfmNOSsCfsaVGbiIQhoPyvYHcUfJsTXpbPnjeriUlccm9vUVJBuhCZFDtEfxK3E8qba0PXocaNjcdmFRe31FQV0cLr4aBSzw+YMx2TZJzgll07Ul5G/7cSBk1c+MRYTO28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqnXauqM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqnXauqM"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0e3a9c3a1so349055eaf.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912442; x=1782517242; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0eI3sYPiCKgcrE6O+2BfABnyJmJRQ7/XjPh53N9B2c=;
        b=mqnXauqM6sd+iM2IVbvQf6Xx3YyTz+3XljVGryeGLh6dHQom2s+J2rcJt9In52K1AL
         TwDcj7vG0O0XBz09nxOfXT3lxafm2oO2OzCvzjQ12DqrD0LtHF7Fwtstqo5+MtVKyqbu
         T8bR4AdxlJ3PnOS0BIOkaQPcnUx/+O1SbFj7kQ0w2w4yUGUjgW1K5mcPn3NqeoBR1wO9
         WBx/d7mDZwVhhsX9rJB+MTKiNbF7ZEMvwgVmUOS37l5SjuvTPzc1AlumkRUjw4qtcZP7
         8dHc5piX4Sv7n1t9oLu3hcaF3JnM8FOtqUHP33J7j4iB9BYU8XHjKSvNBdaJmgLnSbdU
         Gvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912442; x=1782517242;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0eI3sYPiCKgcrE6O+2BfABnyJmJRQ7/XjPh53N9B2c=;
        b=jjyipCwlqVSomQaE0mLe66R+ZxUdzcI6S1S/t/vniyPH3Kdqw8V6+ZdzyvyzRDJDpE
         joBvggc0A7esUxTQqUFk9Juaf7QBtG5uB7+qPyzcqWjBZNsOBzJm/BmnHlJgzrxCtQCz
         O9a7RXIkkWwaiUyr7qJJZ7/T4A5QyMpNa6tzCTQpzYr8206YgdPujhSKtPF+YNxML9I4
         B2gwEFrdawv+3Gm1C1dDd3rpu5aqEv5PgjRNmYn3neuX1eYKBGp9GOcKIrrbqHcrICbe
         h977SzLG1T4IqKMvzDJHIemjATlH8aJeY1mgGfeldyQ/5Wj/UpIwOnHj1fSxvg6ONENv
         2A0w==
X-Forwarded-Encrypted: i=1; AFNElJ+jhfG0A0PCNrfqN+YlV6t/yfmPiEHfu4PEj/V1MEGlKcYiIRiQWu/6fz9iSqVmpZ4oJ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bLAsmAEu4FFwkENZealDrER2ZnQzRuMKKVnAiPhF7jo1U7NF
	g2+0yHKk/COpKits+avacmdiAVXjA2tXhSpSb6q6bEPXl0mUlUNtWVR3
X-Gm-Gg: AfdE7cnpaRRz0RhBEYpSH/cYDg+rIJuOLOZSHEx30OijII3TLDukJ3jQjV5/c9Mqhj5
	YXJNsYHjbmOOhd2xirHkWe5kPVt3xvso/a1OPo0kP1l7O1+hs61HS2iXzlTHoWNjTv12khAp5L8
	cpm8Srt9UIGCYjqd87xPxXAPR7xFc5FNhcET1e3BuXCZXkm+QpMNgjOXHrfeo3uQuQRE/wK0/z1
	dv/1UfEbZOAUaBQWIW5ezHVXc8ld+HEhg8Xb9GAdjSm7bd7gR5VpmH0apcawYDQN2dTjcWZu66E
	mfRzNJ7cpA5KCrXbst2Pb4kPOLN0AGBgO1Nkc+QOiy0qVTuenb5ot/3LbIwhrXoN+Z1jOiFZ5qC
	eer8dPlOoyqV0ZEZeU1wqWVZXMCA0YCf36DIoynVGg+zOAx9JQuJqphcmNyG4FKYJJEClSwOjbv
	I/uz1oPtey3QDWdswNKqZP53i+v6oMCMD+39y95LbgBIY+xOsM3EEJIX2CYpqL5UpXyhAzbSgHu
	lSofSU=
X-Received: by 2002:a05:6820:f02c:b0:6a0:e6f3:bc72 with SMTP id 006d021491bc7-6a0e6f3c1c5mr2252797eaf.8.1781912441822;
        Fri, 19 Jun 2026 16:40:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea0c3de4sm801501eaf.9.2026.06.19.16.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 16:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 16:40:40 -0700
Message-Id: <DJDF8QCVEUSF.2DSJG76WRHFU2@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 09/17] bpf: Report Memory Safety bounds
 errors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-10-memxor@gmail.com>
In-Reply-To: <20260619205934.1312876-10-memxor@gmail.com>

On Fri Jun 19, 2026 at 1:59 PM PDT, Kumar Kartikeya Dwivedi wrote:
> +
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

unnecessary line wrap.

> +		if (!start) {
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

also

> +		scnprintf(buf, size, "unknown");
> +		return;
> +	}
> +
> +	fmt =3D &scratch->reg_fmt;
> +	memset(fmt, 0, sizeof(*fmt));
> +
> +	bpf_diag_format_scalar_range(fmt, fmt->range, sizeof(fmt->range),
> +				     reg->r64);

also doesn't need to wrap. Up to 100 chars is ok.

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

can they be NULL?

> +
> +	switch (kind) {
> +	case BPF_DIAG_MEM_NEGATIVE_MIN:
> +		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg)=
,
> +					off);

no line wrap pls

> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the smallest possible access starts at %s, below 0",
> +			  start);
> +		break;
> +	case BPF_DIAG_MEM_MIN_OUT_OF_RANGE:
> +		bpf_diag_format_s64_sum(start, BPF_DIAG_SCRATCH_STR_LEN, reg_smin(reg)=
,
> +					off);

same

> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the smallest possible access starts at %s, outside object_size %u"=
,
> +			  start, mem_size);
> +		break;
> +	case BPF_DIAG_MEM_UNBOUNDED:
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "%s has unsigned maximum %llu, which exceeds BPF_MAX_VAR_OFF %u",
> +			  reg_name, reg_umax(reg), BPF_MAX_VAR_OFF);
> +		break;
> +	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
> +	default:
> +		max_start =3D bpf_diag_mem_max_start(reg, off);
> +		max_end =3D max_start + size;
> +		scnprintf(proof, BPF_DIAG_SCRATCH_STR_LEN,
> +			  "the largest possible access ends at %llu: start %llu + access_size=
 %d, beyond object_size %u",
> +			  max_end, max_start, size, mem_size);
> +		break;
> +	}
> +
> +	bpf_diag_format_access_offset(env, offset_desc, BPF_DIAG_SCRATCH_STR_LE=
N,
> +				      off, reg);

same

> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY,
> +			       "access outside bounds");
> +	bpf_diag_report_reason(env,
> +			       "The verifier cannot prove offset + access_size <=3D object_si=
ze. Here, %s. %s is %s; offset is %s; access_size is %d; object_size is %u.=
",
> +			       proof, reg_name, type_name, offset_desc, size,
> +			       mem_size);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, "error",
> +			       "access may be outside object bounds");

same

> +
> +	if (regno >=3D 0)
> +		bpf_diag_print_history(env, &opts);
> +
> +	bpf_diag_report_suggestion(env,
> +				   "Add or adjust a bounds check that proves offset + access_size st=
ays within the object.");
> +}
> +
>  static void bpf_diag_format_var_offset(struct bpf_diag_reg_fmt *fmt,
>  				       char *buf, size_t size,
>  				       const struct bpf_diag_reg_snapshot *snapshot)
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> index d6e858cd39f2..fea7731d431c 100644
> --- a/kernel/bpf/diagnostics.h
> +++ b/kernel/bpf/diagnostics.h
> @@ -124,6 +124,13 @@ enum bpf_diag_invalid_deref_kind {
>  	BPF_DIAG_DEREF_INVALID_PTR,
>  };
> =20
> +enum bpf_diag_mem_bounds_kind {
> +	BPF_DIAG_MEM_NEGATIVE_MIN,
> +	BPF_DIAG_MEM_MIN_OUT_OF_RANGE,
> +	BPF_DIAG_MEM_UNBOUNDED,
> +	BPF_DIAG_MEM_MAX_OUT_OF_RANGE,
> +};
> +
>  struct bpf_diag_history_opts {
>  	enum bpf_diag_history_scope scope;
>  	u32 frameno;
> @@ -171,6 +178,15 @@ void bpf_diag_report_stack_arg_uninit(struct bpf_ver=
ifier_env *env,
>  				      u32 insn_idx, int nargs,
>  				      int stack_arg_slot,
>  				      const char *callee_name);
> +void bpf_diag_report_memory(struct bpf_verifier_env *env, u32 insn_idx,
> +			    const char *problem, const char *reason,
> +			    const char *suggestion);
> +void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_i=
dx,
> +				int regno, const char *reg_name,
> +				const char *type_name,
> +				enum bpf_diag_mem_bounds_kind kind,
> +				int off, int size, u32 mem_size,
> +				const struct bpf_reg_state *reg);
>  void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
>  			    bool cond_true);
>  void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
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

but these are way too long.
introduce const chart *fmt =3D "This store.."
at the top of the function?

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
> +						       size, off, i),
> +			       "Initialize every byte in the stack range before reading it, a=
djust the offset and size so the read covers only initialized bytes, or loa=
d with the privilege needed for uninitialized stack reads.");

also way too long.

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

and here too. Pls find a way to reduce indent of bpf_diag_report_memory( ..=
.bpf_diag_scratch_printf
I'd think bpf_diag_scratch_printf() can be done first and result passed int=
o bpf_diag_report_memory()

