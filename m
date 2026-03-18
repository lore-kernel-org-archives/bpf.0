Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE0279DC9
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868389; cv=none; b=ggt5B+sfluyZcgQna3DWXaDIaJMniQrQWWZ0rN/bAsE2UPfAK1+WCzmH/l4HeyLTxDOgDeVf2Pwgpthk5aftNje5HSVs5Yt510APjSjjWUKUIpTkSayC17+CyvT5N7Nd+guLwezk162rAJpHCPYLgvw0efQXfRNW3b+9CKFdhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868389; c=relaxed/simple;
	bh=rUYZycwwVw92iF8E4/cVL1FoQFyqobduCxrM+9nEffw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0RhitzbhphjfBNZxAS/CoTm5TsIBJ0TgvyTfm8YAXg8e+yQHJAhRcfpob/aVBCLzqmflB7DguO4b1LqbLLVE7O9+BNy/9IY5ntROHNlc8FJMza/eC8z90HcgDUtMHR8Y9Ks2CbxXrnEJB/Rzhpj//iq2hYjTMuQySoJchT4Ams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4l0twIV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4l0twIV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aae4816912so1552355ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773868387; x=1774473187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rTkeg0Bgvtr2r3RprCxUT7LbI+9oycLCobJe06WryTA=;
        b=R4l0twIVMX/oRH0vfqRxt+s/+9yHOxWjJxRLUBl2VaIXQkxl4w7gHcI7+j25OjwNRl
         xeEWyygvWZ39Vj+RcMiXp9WFlaIfWiEj4OFL5JSOnpTDGN9S69ZdorJShdy2xUK6RW5z
         6UcYJfIVolItnIUuuwjC5a0HDUiukFNrGuEoiijj1ZnJNz26On34sbr+m/zE2CmyRODM
         l/TW5iQxnJQU/c6kKipC2xoNy/xIcpK41kVnR8e6EQhyWM8uwN2+5TiPfeaxZLI+uxQV
         y6NBrzbg846+a7dbd7Si0L+onlINBDcKv/gjXa9lJZRr/4kzq5sjhOhY49l6PMLQoUht
         sixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868387; x=1774473187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTkeg0Bgvtr2r3RprCxUT7LbI+9oycLCobJe06WryTA=;
        b=WGpAfMSsqsf0bQqVHePvU/JSpoV2CYa98m4QIYfsbZUyIbNbP60tqveC3WQhK4HQfp
         nY0BYCiVdWmc+lfpFKZEGK2h5U+SCSxP13PmBveBsj5zRqtCTGsPZ8FoOc1jULZHoIzC
         IoFnW3Tfo0A0rqQCdl1Diyz6tHM5iuJgXmu6TA9A9U+U+IKiGBzCCMupc2wM4yH73rwL
         55W3AsyTeQZ7xHXbwUgziSUgs9S5LNjuvI/2wZRQx9RxJFkTgbvNUijh8wHOyVJ2FFt0
         O+s6kx7VSlN8FjP0leC8mjY1At/OEhqwtA9j3q70OXne3rSFIvAtA7Ppis8gqI/sBW8H
         RwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2/Scu+W+QerJrZDA/BXk1kVwSy1F7R1mwdUcyxJey5epnRyYrMe0tatpbP/HtRcHphoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPS9kfj4YlB6fyW9XySppHZKxv7Yk780PjYWfSaB/VUNxaGxx
	3FfP1QUq45IzpfG05WQSxGUJ5TUy8I9qWQWRjpDBn7FkWJwbdY/nlwOD
X-Gm-Gg: ATEYQzw8hEGqE5vBxcWYJ8wW4NrXFI8VTI73lsEOoplehlx4ykHedPmR+W0ygkYpMyy
	CoQ3V1WFH0Z9TqG6l2jdz9vzjLFI/YsCwHWdVUN4r6XdeWG1s8NSgv6AiNBSMzwbxu+N649c7t/
	VVcLPJgGQ/HQC4juwICN6ytHP5wDD8/4MgyHcNuJ16HVNojq4dA3Wkv8bTgw334JeLFV8vXbL9m
	tlGs1h4VWQQSXM3TADLo7KCI9mrGr/aEj5QJUp+ekIvHgn68h297+KOiltfXSec+osnpxlDOToG
	sMpCljf8wSXvwoCJhm3P8i/Xvx+5BUDSBrEfEiaGUQvy4ZcqYfjbc5+99kWjnr+i1TCkENbdLjh
	LVJFgQv2NFxkLwVK9V+r40fRxybSXjFEPc4i5iTjMPeX51xsQjDpIVKB8ERlZtGxperQBmYyH8F
	bjpknHn8ygyKXSIS7cQtnFHqbzRzOMU1X0UW7etZv2vO8bUegQtqU=
X-Received: by 2002:a17:902:d506:b0:2b0:5fbe:130b with SMTP id d9443c01a7336-2b06e34aee0mr51454505ad.19.1773868387463;
        Wed, 18 Mar 2026 14:13:07 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e6216c5sm46886755ad.73.2026.03.18.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:13:07 -0700 (PDT)
Message-ID: <e05e441f4b071a33c71f28d6668f2e580952c7da.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for
 syscall PTR_TO_CTX
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, Emil
 Tsalapatis <emil@etsalapatis.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kkd@meta.com, kernel-team@meta.com
Date: Wed, 18 Mar 2026 14:13:04 -0700
In-Reply-To: <20260318103526.2590079-2-memxor@gmail.com>
References: <20260318103526.2590079-1-memxor@gmail.com>
	 <20260318103526.2590079-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 03:35 -0700, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..14bf64e0c600 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7843,6 +7843,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32
> regn
> =C2=A0		 * Program types that don't rewrite ctx accesses can safely
> =C2=A0		 * dereference ctx pointers with fixed offsets.
> =C2=A0		 */
> +		bool var_off_ok =3D resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_=
SYSCALL;
> =C2=A0		bool fixed_off_ok =3D !env->ops->convert_ctx_access;
> =C2=A0		struct bpf_retval_range range;
> =C2=A0		struct bpf_insn_access_aux info =3D {
> @@ -7857,16 +7858,26 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, u32
> regn
> =C2=A0			return -EACCES;
> =C2=A0		}
> =C2=A0
> -		err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> -		if (err < 0)
> -			return err;
> -
> =C2=A0		/*
> =C2=A0		 * Fold the register's constant offset into the insn offset so
> -		 * that is_valid_access() sees the true effective offset.
> +		 * that is_valid_access() sees the true effective offset. If the
> +		 * register's offset is allowed to be variable, then the maximum
> +		 * possible offset is simulated (which is equal to var_off.value
> +		 * when var_off is constant).
> =C2=A0		 */

Nit: I'm not sure this comment adds much value, I'd drop it altogether.

> -		if (fixed_off_ok)
> -			off +=3D reg->var_off.value;
> +		if (var_off_ok) {
> +			err =3D check_mem_region_access(env, regno, off, size, U16_MAX, false=
);
                                                                           =
  ^^^^^^^^
                 Nit: Maybe leave a comment here saying that the following =
check_ctx_access()
                      ensures proper maximal bound?
                 Nit: check_mem_region_access() which calls __check_mem_acc=
ess(), maybe add
                     `case PTR_TO_CTX` there for error reporting?

> +			if (err)
> +				return err;
> +			off +=3D reg->umax_value;
> +		} else {
> +			err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
> +			if (err < 0)
> +				return err;
> +			if (fixed_off_ok)
> +				off +=3D reg->var_off.value;
> +		}

Let's simplify this as:

		if (var_off_ok)
			err =3D check_mem_region_access(env, regno, off, size, U16_MAX, false);
		else
			err =3D __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
		if (err < 0)
			return err;
		off +=3D reg->umax_value;

Tbh, the above looks a bit ad-hoc, one might argue that a better way in
terms of abstraction would be to adjust bpf_verifier_ops->is_valid_access()
to accept or reject varying offset access.

> =C2=A0		err =3D check_ctx_access(env, insn_idx, off, size, t, &info);
> =C2=A0		if (err)
> =C2=A0			verbose_linfo(env, insn_idx, "; ");
> @@ -8442,22 +8453,16 @@ static int check_helper_mem_access(struct bpf_ver=
ifier_env *env, int regno,
> =C2=A0		return check_ptr_to_btf_access(env, regs, regno, 0,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 access_size, BPF_READ, -1=
);
> =C2=A0	case PTR_TO_CTX:
> -		/* in case the function doesn't know how to access the context,
> -		 * (because we are in a program of type SYSCALL for example), we
> -		 * can not statically check its size.
> -		 * Dynamically check it now.
> -		 */
> -		if (!env->ops->convert_ctx_access) {
> -			int offset =3D access_size - 1;
> -
> -			/* Allow zero-byte read from PTR_TO_CTX */
> -			if (access_size =3D=3D 0)
> -				return zero_size_allowed ? 0 : -EACCES;
> -
> -			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> -						access_type, -1, false, false);
> +		/* Only permit reading or writing syscall context using helper calls. =
*/
> +		if (resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_SYSCALL) {

Nit: this is a second place where this check is hard-coded.

> +			int err =3D check_mem_region_access(env, regno, 0, access_size, U16_M=
AX,
> +							=C2=A0 zero_size_allowed);
> +			if (err)
> +				return err;
> +			if (env->prog->aux->max_ctx_offset < reg->umax_value + access_size)
> +				env->prog->aux->max_ctx_offset =3D reg->umax_value + access_size;
> +			return 0;

Why is this change necessary at all? Wouldn't old code handle all
relevant cases, now that check_mem_access() is updated?

> =C2=A0		}
> -
> =C2=A0		fallthrough;
> =C2=A0	default: /* scalar_value or invalid ptr */
> =C2=A0		/* Allow zero-byte read from NULL, regardless of pointer type */

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index f02012a2fbaa..2250fc31574d 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -134,7 +134,6 @@ __noinline __weak int subprog_user_anon_mem(user_stru=
ct_t *t)
> =C2=A0
> =C2=A0SEC("?tracepoint")
> =C2=A0__failure __log_level(2)
> -__msg("invalid bpf_context access")

Nit: should this test case be forked as tracepoint and non-tracepoint versi=
ons?

> =C2=A0__msg("Caller passes invalid args into func#1 ('subprog_user_anon_m=
em')")
> =C2=A0int anon_user_mem_invalid(void *ctx)
> =C2=A0{
