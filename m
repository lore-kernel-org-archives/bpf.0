Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FC7DA66
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966567; cv=none; b=n+WZbzJ+hp2ZMjzPtS474vtWj1oMwBUlyV47SWRFiT7Ea5p0VUtyNYuOKS85X70hRXYgjjpkfneJM08wZcmJorU/yrWao53zV8R3XBbgLhq3w29NZGZkmb7lLaTyNUBOzm+Gk4UqDkFxuFBN9VYc99Jfd019eDECUnSujICTftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966567; c=relaxed/simple;
	bh=CQiqV1KaE4298GS9iOOY1pvTIAej+c3yZkpXzwYVvWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtXiWIQfkqyPnllSqBkQZvRhXOBrSt34sVQFJw5Ecc7LRgWg8Skf4Fb0jzw94CWFM7cwlDyZtnCXz8eKSSJxfYqpSkzRfC5XamMj5XliDAB4eg9enP1ygob0M/CvV9HIawuM34pfnawdLRlGLhTEPcsrg07hxoyOPQoCctPetL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIy9wz+T; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIy9wz+T"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13810b63a1aso1961631c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780966565; x=1781571365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WbVDq4Me5SvMdt7jQSlsDmPo63jO8d/GWOnS8OM5oU=;
        b=GIy9wz+TJxDWNgt2DW58H3ATZoMYpl2/wQQw2dIBF8A9528fhG/432tKysmD3TlLJP
         PlVU6zxPMmYq7zMTigt1hjIge4W4BVlJqF4LgXMrKE2Vwi0yumWVv7YQnFZh+9Ug5Uyw
         aAgybUr33Wu7yLj37nScibIL6O6wbykNodhWSkIYdp1vM1R9TvrGKchZCVNwVYv6g4B6
         UVYZUGS23Byd30ZiYvb73VDYLzJZjPDUo/mBml8DZtoab61e0p99vmOxICPcDN5Cog+I
         GQOhtfuJA6o71DvtSx/1J6MrMEg8NtJvNanL6VeZv5zP+C+AxDB1vwCPVAxb3DAOFSqF
         EBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966565; x=1781571365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WbVDq4Me5SvMdt7jQSlsDmPo63jO8d/GWOnS8OM5oU=;
        b=PsQcRWIDUn05R+D9iJ5NfhTDZK9LuL5n94sBGdGHmyLZqaC9mE9z/y5gEtsK+5uL/w
         wRJOLFWP+3vHlxb1WuWt+hJN6+XCJb2X5+KlykxeM3UVpBK1BtJZ5C42msi6G4LCWHDs
         Qx9iNqwZz7Lq2b7OMjmNT1mySy/C20uAg+wzNdBXqIgkPki6xsmS9+vA51Mc6DYODPAX
         ++MggleLZFWz5XNQg9NUurHdlKiP4sPqJbRhq8116rnz2tAnOgabbGWETkSTYgwLaHqz
         SsKUfJD3H5b9lPWwQIj4lR5+eLg6MFI//SpdcqF2zMryzqu+NIPBneGAEJ9Va/zPUQsH
         SWqw==
X-Forwarded-Encrypted: i=1; AFNElJ+pU6wHnVwfcN6yaE+ojI8U0/tsmCkJQ8+JP3lTZsD6YoH87+TCQqUv5svi6hfIdQbhpTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBppYpMGgEqykLY8ovXVRG07ETrJ2pVj2Y0CylEa1AMvtslpjx
	8naEJfk5giTEhaVcTWXEogCucQ2KYonIZUmao37QdkBYqKIJFE7DYGHp
X-Gm-Gg: Acq92OEfkd/eFA4C50D4y1mRmyPObZ4EgxFiQxzooiK/DiYOWN9NvySpt0Icw+jD2Gm
	Gqs44DqlAwanl8YPghNnd6qeR0zqfa3MPecgM9Qw881wkIt13TUIePjVmotftZBVfCYK3vAozHM
	G/ZGQW5vT3STDBt33LReG9wFoSCA4e3N0FvesKOun7FeiFDvj9NPtR2Y7KQ0NQ81gHXDSR2LxAZ
	+jIEBUZT1t55/tUmekKJ1YyMVji4Z0Z4X+Iw+UsR8e85RyJ6mY9a0tKo8tUDjtrQ1AG5hw3yI7k
	7eFev/8qKV2PUPRl9ve3gz+iSMZMRvyYW1oonCfg2F5FkamKnh4luaXQLYMKttXiluWitQWGxdV
	rhtfjmEECgRPB42nkG5El7ka5rcbLgHPX+APC9KnifW2rRovjOuQmKEXpwD8bhT/Ij4wkK/xZMa
	4RXpnk7esHVvo9Ld423zkxDSse+c3Q64RECY1MNYWFlE61cG0s6tTtBymsfyV0a1ihE362sfccT
	0veVL5+dStQF+1cBNc=
X-Received: by 2002:a05:7022:1284:b0:138:1987:7d8d with SMTP id a92af1059eb24-13831b9d2a0mr258272c88.18.1780966564859;
        Mon, 08 Jun 2026 17:56:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cde6:fb53:a1a3:a385? ([2620:10d:c090:500::3:b685])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm14286859c88.14.2026.06.08.17.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 17:56:04 -0700 (PDT)
Message-ID: <52592e76c7e3b735d3fb33899c8f32fab8346cd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/17] bpf: Report Memory Safety bounds
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 08 Jun 2026 17:56:03 -0700
In-Reply-To: <20260605063412.974640-10-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 920ac17758c2..0abe1ab19d25 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[...]

> +void bpf_diag_report_mem_bounds(struct bpf_verifier_env *env, u32 insn_i=
dx,
> +				int regno, const char *reg_name,
> +				const char *type_name,
> +				enum bpf_diag_mem_bounds_kind kind,
> +				int off, int size, u32 mem_size,
> +				const struct bpf_reg_state *reg)

Nit: here as well, I'm not sure the 'enum' pays for itself.

> +{
> +	struct bpf_diag_history_opts opts =3D {
> +		.scope =3D BPF_DIAG_HISTORY_SCOPE_REG,
> +		.frameno =3D bpf_diag_current_frameno(env),
> +		.regno =3D regno,
> +	};
> +	char offset_desc[256];
> +	char proof[192];
> +	u64 max_start, max_end;
> +
> +	switch (kind) {
> +	case BPF_DIAG_MEM_NEGATIVE_MIN:
> +		scnprintf(proof, sizeof(proof),
> +			  "The smallest possible offset is %lld, below 0",
> +			  reg_smin(reg) + off);
> +		break;
> +	case BPF_DIAG_MEM_MIN_OUT_OF_RANGE:
> +		scnprintf(proof, sizeof(proof),
> +			  "The smallest possible access starts at %lld, outside an object of =
size %u",
> +			  reg_smin(reg) + off, mem_size);
> +		break;
> +	case BPF_DIAG_MEM_UNBOUNDED:
> +		scnprintf(proof, sizeof(proof),
> +			  "The access needs offset + size <=3D %u, but %s has no safe upper b=
ound",

Nit: this prints something like "... The access needs offset + size <=3D 48=
 ...",
     it is not obvious what "size" means in this context.

> +			  mem_size, reg_name);
> +		break;
> +	case BPF_DIAG_MEM_MAX_OUT_OF_RANGE:
> +	default:
> +		if (off < 0 && reg_umax(reg) < (u64)-off)

Could you please explain this a bit?

> +			max_start =3D 0;
> +		else
> +			max_start =3D reg_umax(reg) + off;
> +		max_end =3D max_start + size;
> +		scnprintf(proof, sizeof(proof),
> +			  "The largest possible access ends at %llu, beyond an object of size=
 %u",
> +			  max_end, mem_size);
> +		break;
> +	}
> +
> +	bpf_diag_format_access_offset(offset_desc, sizeof(offset_desc), off, re=
g);
> +
> +	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_MEMORY_SAFETY,
> +			       "access outside bounds");
> +	bpf_diag_report_reason(env,
> +			       "The verifier cannot prove that this access stays within the o=
bject: %s. %s is %s; offset is %s; access size %d; object size %u.",
> +			       proof, reg_name, type_name, offset_desc, size,
> +			       mem_size);
> +
> +	bpf_diag_report_section(env, "At");
> +	bpf_diag_report_source(env, insn_idx, '!',
> +			       "access may be outside object bounds");
> +
> +	bpf_diag_print_history(env, &opts);
> +
> +	bpf_diag_report_suggestion(env,
> +				   "Add or adjust a bounds check that proves offset + access size st=
ays within the object.");
> +}
> +
>  void bpf_diag_clear_history(struct bpf_verifier_state *state)
>  {
>  	kfree(state->diag_history);

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adf660ab9e7d..e9c121892b7e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> +static void bpf_diag_report_stack_read_failure(struct bpf_verifier_env *=
env,
> +					       int off, int i, int size,
> +					       bool poisoned)
> +{
> +	char reason[256];
> +
> +	if (poisoned) {
> +		scnprintf(reason, sizeof(reason),
> +			  "This read uses %d bytes at stack offset %d, but byte %d in that ra=
nge is poisoned because it was eliminated as dead code on this "
> +			  "path.",
> +			  size, off, i);
> +		bpf_diag_report_memory(env, env->insn_idx,
> +				       "poisoned stack read",
> +				       reason,
> +				       "Avoid reading stack bytes written only by code that the veri=
fier proved unreachable, or initialize the stack range again on "
> +				       "this path.");
> +		return;

That's an internal error, it should be properly propagated as -EFAULT
from check_stack_read_fixed_off() instead of being nicely printed here.

> +	}
> +
> +	scnprintf(reason, sizeof(reason),
> +		  "This read uses %d bytes at stack offset %d, but byte %d in that ran=
ge is uninitialized on this path.",
> +		  size, off, i);
> +	bpf_diag_report_memory(env, env->insn_idx,
> +			       "uninitialized stack read",
> +			       reason,
> +			       "Initialize every byte in the stack range before reading it, o=
r adjust the offset and size so the read covers only initialized "
> +			       "bytes.");

Might also mention that uninitialized stack reads are allowed when the
program is loaded in a privileged mode.

> +}
> +
>  /* Read the stack at 'off' and put the results into the register indicat=
ed by
>   * 'dst_regno'. It handles reg filling if the addressed stack slot is a
>   * spilled reg.

[...]

> @@ -3976,10 +4023,20 @@ static int check_stack_read(struct bpf_verifier_e=
nv *env,
>  	 */
>  	if (dst_regno < 0 && var_off) {
>  		char tn_buf[48];
> +		char reason[256];
> =20
>  		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
>  		verbose(env, "variable offset stack pointer cannot be passed into help=
er function; var_off=3D%s off=3D%d size=3D%d\n",
>  			tn_buf, off, size);
> +		scnprintf(reason, sizeof(reason),
> +			  "The helper would access the stack through a variable offset %s plu=
s fixed offset %d and size %d. Helper stack arguments need a "
> +			  "precise stack range so the verifier can prove every byte is initia=
lized and inside the stack.",
> +			  tn_buf, off, size);

It is not clear from such reason formulation that the problem is with regis=
ter not being constant, tbh.

> +		bpf_diag_report_memory(env, env->insn_idx,
> +				       "variable stack access",
> +				       reason,
> +				       "Use a fixed stack offset for helper memory arguments, or add=
 bounds checks and copy the needed bytes into a fixed stack slot "
> +				       "first.");
>  		return -EACCES;
>  	}
>  	/* Variable offset is prohibited for unprivileged mode for simplicity

> @@ -4266,6 +4333,11 @@ static int check_mem_region_access(struct bpf_veri=
fier_env *env, struct bpf_reg_
>  	if (reg_umax(reg) >=3D BPF_MAX_VAR_OFF) {
>  		verbose(env, "%s unbounded memory access, make sure to bounds check an=
y such access\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_mem_bounds(env, env->insn_idx, reg_from_argno(argno),
> +					   reg_arg_name(env, argno),
> +					   reg_type_str(env, reg->type),
> +					   BPF_DIAG_MEM_UNBOUNDED,
> +					   off, size, mem_size, reg);

I think that BPF_MAX_VAR_OFF limit should be mentioned in the error message=
.

[...]

(I'll continue tomorrow).
