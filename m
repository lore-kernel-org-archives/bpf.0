Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2E41A7264
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816855; cv=none; b=PNRCS7u6Kji5Kc0S4Ja2wReiJAB7+/E/2aV0j53pVLcbi8kVJ7dDEAS17gha6TB0pca7PbNX5gjjDwiNW6v+0rfEsh9Baj2VrfasSkQp0Nx6Nj/jnApf7ndjS5dm84nR4x5qInUUeb77agJHgvzHvW/H2RDhtDBQ8mxMFotrkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816855; c=relaxed/simple;
	bh=dvhynloBUf0sqk2X+pyZ7EV3m1f79pBhPZFzWdiNYQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7IqkGwP7kT8OzHvCmwYO2L/ZZr7yp0esFpaBQAc8C5FmRPsf4tXWoNk2Xuzz9acgGNGce5QatzXNYQ+CcNb0qkFJsH538uBiXcksmNO6hSPEqURd8MJuZtM9V/400+bP9A/u3z8Et3GGuDR7aNTHjqPmI69AzWakAvVFS4k8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkaDx0aO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkaDx0aO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2158110a91.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816853; x=1787421653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=svaOlr/lwYVSdjf9T4JW703rWBa36Bln3C8trmD5qEE=;
        b=TkaDx0aO3nrII9YYYop65uI2vzZ7RMcIFFzYpTnwRb9/bVtuj63kQo0ZzxAJKASmOH
         4bIAiS1dSoTEUNxHwQ3506FkfayvJuk5OAnz8bxblg7TW8RGSRJgjh23IrNXaS5QHbA/
         8/ix9kEzvnNvZLR9E29g9QRsoD6BcIT+ZSMDtiz8JGH96JlcHP5pqGuvvfg+M/tg1WKo
         IU/ITIcWNYjfXlq/GLZRJczioi5h8Ba6xpAnQl2ioL0dxsq9KeZ8/aPLG2X5R/ssB++P
         2+/8Pr0lMili5W/GAr5JG0Iqqnmcy/QCaofLLme7rkvLn9i5bBiXmBs7a+cJWHsyJnhw
         ApNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816853; x=1787421653;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svaOlr/lwYVSdjf9T4JW703rWBa36Bln3C8trmD5qEE=;
        b=Toj14uxBPHf0Hf8HJXPKjlghZrPugdx07QI03Y2bwgiqr0xLdhzgPDmC0CmgYrgiLI
         HGMiTqOmo99f/8c0xlAmLQ3liuUITgxOulf7UVmIvVg/o9cflr9RP4WBdxBTNzTEWodj
         sLmehXpSlWCnGk1PRKgkMmmG1nHO0UTfguLUz2aOoIooKBQFOSSTvoVExjYS+SbD5LBZ
         IlT/riNNdbn1w0d5X3p1SxE/xO0mwkUY/94w+x5uEUJD2F2gBjaNmHadmVeKVTFGAJAN
         TzqB42hPAgjxjdH+tMw5ii60hW2lzpiehSh3VrSXrTyClNen/+N8PPLnKALOfCs9Efnv
         v01g==
X-Forwarded-Encrypted: i=1; AHgh+RodVx8hpiuosOeyB6xHVDtU+WZwu1E7wAyEt2hphK0QlKHl/dE5zYBUHTQMLtyUxPRoTdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1SvSzmsI/q6dA9+VRVkV4kBxQwzOj/ZfbT14+OS7x6cMWmy0
	wBEw/EZEFZsuaNfxqSOQ1QVvAjqJToE0FTNtsQe5caQT3nrxEE09z0RQ
X-Gm-Gg: AR+sD13e3aeNr1zwO0adzLQnQT8CO+QTdho6kAtYd124mkzrWoqalMfhP2qv8B1KbFK
	e2ek7gYnUu4EU0z3wzDc2oTO+Kd3ou823LHk4juMrWlmTO0YNZp0mM5HEfGLMTuiM9UFgip0JBj
	+A2Jc155q0mupHZHrstrlLoFSZj/ZdRPKUrg2htTeMR1thbGQZrK8EEw886VebLkQ+3dgikd8q2
	ARkojrx94CycbbtVqbKWScIacL+s556GG1QbFt0zml6nTe0z2/bfn0uK2ba/UKtebj4yroqx67U
	4Lk6nutL53FI7Aukl071t+Pxb7ieJ3gVvnTK2xQ/ymK+GnqZXa9qd1IVwLzmf8dzmPqhobpSBgC
	4Dg97QMX2BPAAnYYlbrL8sIue5cjCbQJpIYPC+1h6wfS2n8M05oEsoJv7AHs4H0BjA2mcyW8frC
	2CAjcERFJfwm2tmnqdpZqS0jYHD9lCYX1RFVuLv7vZF7BR50YjDRKdGaaJEdgrb4alr4NZe+vSQ
	TxI2qbHcL4UKP0z
X-Received: by 2002:a17:90b:184b:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-3933b74d94dmr17370651a91.6.1786816852637;
        Sat, 15 Aug 2026 11:00:52 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96c7fcsm6933551a91.3.2026.08.15.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:00:52 -0700 (PDT)
Message-ID: <668871823f90f69896d3db27b56db2f53e481162.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 11/14] bpf: Report Call Type Safety argument
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	kkd@meta.com, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, 	clm@meta.com,
 ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 11:00:48 -0700
In-Reply-To: <3eda33675965763aa9b2e6a5784f32b34a6a83988a55fbea98b0dbd0cf3b088d@mail.kernel.org>
References: <20260815064612.378577-12-memxor@gmail.com>
	 <3eda33675965763aa9b2e6a5784f32b34a6a83988a55fbea98b0dbd0cf3b088d@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-15 at 07:49 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> > index 5d20ea9e470e..99784d465881 100644
> > --- a/kernel/bpf/diagnostics.c
> > +++ b/kernel/bpf/diagnostics.c
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f5bf8cf644b8..2c067be53106 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -12417,29 +12552,43 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >=20
> > =C2=A0	t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> >=20
> > -	if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || type_may_be_n=
ull(reg->type)) &&
> > +	if (btf_type_is_ptr(t)) {
> > +		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> > +		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> > +	}
> > +
> > +	if (btf_type_is_ptr(t) &&
> > +	=C2=A0=C2=A0=C2=A0 (bpf_register_is_null(reg) || type_may_be_null(reg=
->type)) &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0 !type_may_be_null(kf_arg_type)) {
> > +		const char *expected_type;
> > +
> > +		expected_type =3D bpf_diag_fmt_btf_type(env, btf, ref_id);
> > =C2=A0		verbose(env, "Possibly NULL pointer passed to trusted %s\n",
> > =C2=A0			reg_arg_name(env, argno));
> > +		bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Add a NULL check and call the kfun=
c only on the non-NULL path.",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "the pointer may be NULL, but this =
kfunc requires a non-NULL pointer to %s",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_type);
> > =C2=A0		return -EACCES;
> > =C2=A0	}
> >=20
> > =C2=A0	if (regno =3D=3D meta->release_regno && !is_kfunc_arg_dynptr(met=
a->btf, &args[i]) &&
> > =C2=A0	=C2=A0=C2=A0=C2=A0 !reg_is_referenced(env, reg) && !bpf_register=
_is_null(reg)) {
> > +		const char *expected_type;
> > +
> > +		expected_type =3D bpf_diag_fmt_btf_type(env, btf, ref_id);
> > =C2=A0		verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID=
 passed to %s\n",
> > =C2=A0			func_name, reg_arg_name(env, argno));
> > +		bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Pass the resource-owning pointer r=
eturned by the matching acquire kfunc, and avoid calling the release kfunc =
after ownership has already been transferred or released.",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "release kfuncs require a resource-=
owning value of type %s returned by a matching acquire kfunc",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected_type);
> > =C2=A0		return -EINVAL;
> > =C2=A0	}
>=20
> When the kfunc parameter is a plain void*, will bpf_diag_fmt_btf_type()
> format it correctly? For a void* parameter, ref_id becomes 0 after
> btf_type_skip_modifiers() and bpf_diag_fmt_btf_type() produces the
> literal string "()" for type ID 0.

This is legit btf.c:btf_show_name() needs a fix:

  --- a/kernel/bpf/btf.c
  +++ b/kernel/bpf/btf.c
  @@ -1172,9 +1172,9 @@ static const char *btf_show_name(struct btf_show *s=
how)
			id =3D 0;
			break;
		}
  +		t =3D btf_type_skip_qualifiers(show->btf, id);
		if (!id)
			break;
  -		t =3D btf_type_skip_qualifiers(show->btf, id);
	}
	/* We may not be able to represent this type; bail to be safe */
	if (i =3D=3D BTF_SHOW_MAX_ITER)

...
