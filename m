Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629F2F8EB7
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782345323; cv=none; b=pReKcqIczSOHDWGAUFaHZRVXXjTTcB97waHxuqXaxTNHc3qaBZXp/05QeXHY5/JXmdWpf2EtwVn7GZALm3eLyKNrOj0NG67kZUGPECyVurTC9dBLoywtI37/5Pjj7DQkKlwcvVhrvFg+25e/HoiF3YD/FCi69D1jQo9jN5999Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782345323; c=relaxed/simple;
	bh=Z/V7L/Of0mik5sGZMI8EyTnfhyqy6i4hA4yIdOkADCI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srRbF7hvAH7enADYUq/n2tvtvwNHwIdUt7rPDwQvAitd3Tfk6iO1R8I5OhywGireOuNgAoxJ3+mUGE3JZhSnqmhr449snlKlM5oGctLsRmFvqDBu5fzODS+Zz1SsmRObIV/sZB7jAN97mVZEXha7seAWswIsxmSN5MebublOMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceqGvK4c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceqGvK4c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7cfa17fedso12393375ad.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782345321; x=1782950121; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydaVMjd5zUD5E0npf7sowdspDSMOv8LHNCf6PKl3y44=;
        b=ceqGvK4c6GGtCu/O8mS7GFYra+6lbQv5NaGAWk9G+LcYDV1voqVPbIjmPJwKlzvMcu
         F3+YPesMS4CZAeAfjolVkGXafnfuol4dNaREGgtoLxHv+b8Ft85Vm8fjel0pwC8WlcFJ
         764JlXufKRteBORVQ+oWPWsgGjer9W6lhdBC/+jtJ92F++czOvNd1SueTIjJJk/ddH9j
         KrfmTivMZGCiR5SoxtnyiFG2dPEYBjokPbwqwJrZDRwvJJkamGsLtaoyUKD+h3oQSUNx
         r8oQl/8P9efAmM7IDd7c2HzpaqpkLYhdgUmgpJ0Wg2IBXbURs7nPiShylpApFwbA1BDw
         RLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782345321; x=1782950121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydaVMjd5zUD5E0npf7sowdspDSMOv8LHNCf6PKl3y44=;
        b=YTllPkoMECU/G4PGWwet4HYsBcqf6vhs2I0DM56GnoQvN93lowYxSiXkFjBOUXzqZ6
         g476NnWoQ/00SR/54425duQj3dIHs4/1V3Zd8XiBnptS/jSIIv0FHEbPVcIxpNtm8wl6
         8K1h54GfoSz0yGXiRkY/X513Wt8bWrjgdTFs1V/zNe2M1938mA3mE8a2qmSzYG6z6HKr
         kYH/LckO+nH28AEkohx9js9KAiXcFp3rEzs4OkMQjx9jej9m7H/8IluhUx4KGpvz8Af+
         YTwHJsg0nvRNcsPJzx4XTN0UUdodjbVXGVqYTuiabQ0LhBO+P2j3z+s/mwST/1nreKP0
         iayw==
X-Forwarded-Encrypted: i=1; AHgh+RqdBCHSw9iCJxI5AIvI3eul+yKo1S3rSuvPE/mbjD+stSFAZh1EFCRBqRbIG3qxg1ShO8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBa9+yvwvxy+73O1htkyJ8RQfGOySU/jUn4nRVuuA4+yUY8ZFI
	nBRNQqlsnBr4mrZ57EvW3WI1weej4GnCARFVt7y1XaCjSZRYyR3VrfEA
X-Gm-Gg: AfdE7clkCCCa9L9wqDKGlHvBK5TrYxQPN48jwzF7IBc3LnRllxJ6NB+IwlOuXFPbnIA
	MG64i6EEKe6NOSMCs2efnRpXAvy2thY5uV/isc/6tlRBWjeJBiMNBknwd150MMQvQErAr6Tr8XR
	0G3ddmz1LLSm8mt6dPk8a/ESpqnEGr1pIQ9Dc6Waqi9SB2kwQ5MbIOEan5sEnwvjRl90mMmx4AS
	rZW7ChEOPwqc7HdyRHIWQElHFtg0JtR/2tU5k3IoFYG5UGDDuVZDmgNAoCnsCXTEKr9AlkL3v5i
	/JrICixUT+SQlKiiE+2I21d9y5lUEGo0uHWCxJDKGUfG7aWaNJwdEd94fg0m6hPrHK+9MKi/4F3
	VSBQBygf/vFZMy4G/6jwHyjSq8kyVE5Hsy9w4juUhUpTGJ9+mWwxpcNMrxjVtVyLdkjVKNuhLNr
	iJqEptmACWQwxE3JC/boOIW9w7+hWhQ0EXIB0MeNIUtg==
X-Received: by 2002:a17:902:ec86:b0:2c0:bcb3:86f with SMTP id d9443c01a7336-2c7fc657921mr2826995ad.6.1782345321206;
        Wed, 24 Jun 2026 16:55:21 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b26e6sm6897905ad.52.2026.06.24.16.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 16:55:20 -0700 (PDT)
Message-ID: <a23fcc350af79694718d7366dc13ca22766c27ab.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 08/17] bpf: Report Register Type Safety
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 16:55:13 -0700
In-Reply-To: <20260619205934.1312876-9-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-9-memxor@gmail.com>
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
> Augment selected register-state verifier failures with Register Type Safe=
ty
> reports. The existing verbose verifier messages remain in place; the new
> reports add reason, source context, causal path, and suggestions.
>=20
> Cover invalid pointer dereferences, unreadable registers, missing outgoin=
g
> stack arguments for bpf2bpf and kfunc calls, and rejected pointer arithme=
tic.
> Use scoped diagnostic history so reports start from the latest relevant v=
alue
> change and then show later branch outcomes.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/diagnostics.c | 234 ++++++++++++++++++++++++++++++++++++++-
>  kernel/bpf/diagnostics.h |  22 ++++
>  kernel/bpf/verifier.c    | 178 +++++++++++++++++++++++++++--
>  3 files changed, 423 insertions(+), 11 deletions(-)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index d6a9a2315f54..92a4aef3cc90 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -837,6 +837,217 @@ void bpf_diag_report_source(struct bpf_verifier_env=
 *env, u32 insn_idx,
>  	kfree(msg);
>  }
> =20
> +static u32 bpf_diag_current_frameno(const struct bpf_verifier_env *env)
> +{
> +	return env->cur_state->frame[env->cur_state->curframe]->frameno;
> +}
> +
> +static int bpf_diag_stack_argno(u8 slot);

Nit: move the initial definition?

> +void bpf_diag_report_register_type(struct bpf_verifier_env *env,
> +				   u32 insn_idx, int regno,
> +				   const char *problem, const char *reason,
> +				   const char *suggestion)

[...]

> +static void bpf_diag_format_stack_arg(char *buf, size_t size, u8 slot)
> +{
> +	int argno =3D bpf_diag_stack_argno(slot);
> +	const char *ordinal =3D bpf_diag_arg_ordinal(argno);
> +
> +	if (ordinal)
> +		scnprintf(buf, size, "outgoing stack argument %u (%s argument)",
> +			  slot + 1, ordinal);
> +	else
> +		scnprintf(buf, size, "outgoing stack argument %u", slot + 1);

Nit: for regular arguments you also fetch the argument's name.

> +}

[...]

> @@ -1726,7 +1937,24 @@ void bpf_diag_print_history(struct bpf_verifier_en=
v *env,
>  		}
>  	}
> =20
> -	if (!printed)
> -		bpf_diag_write(env,
> -			       "  no retained diagnostic events on this path\n");
> +	if (!printed) {
> +		if (opts && opts->scope =3D=3D BPF_DIAG_HISTORY_SCOPE_STACK_ARG &&
> +		    opts->stack_arg_slot >=3D 0) {

Nit: I'd skip this block entirely, the error message already says that
     the argument is not provided.

> +			const char *arg_buf;
> +
> +			arg_buf =3D bpf_diag_scratch_buf(env, 0, NULL);
> +			if (arg_buf)
> +				bpf_diag_format_stack_arg((char *)arg_buf,
> +							  BPF_DIAG_SCRATCH_STR_LEN,
> +							  opts->stack_arg_slot);
> +			else
> +				arg_buf =3D "this outgoing stack argument";
> +			bpf_diag_write(env,
> +				       "  no retained writes for %s on this path\n",
> +				       arg_buf);
> +		} else {
> +			bpf_diag_write(env,
> +				       "  no retained diagnostic events on this path\n");
> +		}
> +	}
>  }

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e584dec04b34..2c5f24528071 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -4362,6 +4368,12 @@ static int __check_ptr_off_reg(struct bpf_verifier=
_env *env,
>  	if (!fixed_off_ok && reg->var_off.value !=3D 0) {
>  		verbose(env, "dereference of modified %s ptr %s off=3D%lld disallowed\=
n",
>  			reg_type_str(env, reg->type), reg_arg_name(env, argno), reg->var_off.=
value);
> +		bpf_diag_report_invalid_deref(env, env->insn_idx,
> +					      reg_from_argno(argno),
> +					      reg_arg_name(env, argno),
> +					      reg_type_str(env, reg->type),

Should this use bpf_diag_reg_type_plain()?
Also, maybe pass reg->type to the bpf_diag_report_invalid_deref()
and convert it to string there?

> +					      BPF_DIAG_DEREF_MODIFIED_PTR,
> +					      reg->var_off.value);
>  		return -EACCES;
>  	}
> =20

[...]
