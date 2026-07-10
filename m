Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9B2AD3F
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644327; cv=none; b=Bh/wxc8ilKfYok9qR8kA15Ayk48/tEV2hZo8/LBilrQqPFXgMzlvJMUzGg/ova3EIrHHH53iUlF8SJlXjIMcm6S1j3mY/8veQ1KRqHjmep2frF3/FEy/oLPDFJNzKLLTLf/rsnkHTVugYvgy3jSB1AnctPrYovsMbWt3n6jlFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644327; c=relaxed/simple;
	bh=Zcvm8sec0oCN+Qx20H5/FaFYKZKi6r51xefPeT54P34=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCscCaBn5d3c8yBV7eiCq/UC8Zw08ywRxN6D1lEc5ClKUdeGYvd9SwgChmDavypzjMg69gFvF5JNzwIfltT+5KojE1aFDUbDoxgRdCYkqSfX09L6ynZa8+LNyb86gYsPHh/qAeVsdb5HcNWSJL4A1u7BPVuULTQNCrRbwvJxKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c768Wg5N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c768Wg5N"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so395126b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783644326; x=1784249126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0TrCHZ6itYxdYCmCBRPd2YlQ4nA7Qw6jSwmjKLODZ/o=;
        b=c768Wg5NUXLUrvohSD2X2UloDFPiZe/+E/arIxqAf74T2xGyc7tN6TsHiqIhisNdjk
         jpOSDqyhV+3eh3gZX8MjDJTeWHwxXxyohPzjoTyMZhKbcKSNPC/92khWMYk7O1BvWJZA
         N+DcXAav38MwDAlnPwj0tmT4mXEdFoGbkzLyOcUL/8NohXqnWi61avNx0s8yTw2y8EK6
         5RRpFBnV+ITBJ4nmNnilhgC+DucJHGxZZqTYfKvX8tUHnnlAzGtALabtNfGNdSQRIMGJ
         sGOmDAJuKHu+kRGvfjZxSQkWRzW04QcSy4ydAHyPg6CJNSMNkrQOpTV37tTMBjyV5euy
         24CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783644326; x=1784249126;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TrCHZ6itYxdYCmCBRPd2YlQ4nA7Qw6jSwmjKLODZ/o=;
        b=WZedUH4tWEimxt+SVXMuUJmq9xwHN6VUzxJU+y+f7UuFf5rC238IseJ8+Ca1Nh50LO
         AeKtHqtXaH17waGXhlO3lulMsjIreS2fpQlxgMY7ZuzQTn0Nq8JprLoeguINKNWmoNrG
         eVaxz5Y4QWlBTYJ6BdXFglE/uZDG2Eb3nFVS0frzXYIUXt7uYy0inzdgwBaJ4qiOYCUX
         mWS+uGCprBPJZfLOqWEo+vXNkz2XdloGc4v8kvDkqqXNsLBWFJ49dAAK1Dnb0PlvfDOk
         dTlKLkPPpdNM6dGIa+YH7tc2IzQRCf/AkdTALereuTmrByJOvbGDu6yIit4dc1yTi4iZ
         V30g==
X-Forwarded-Encrypted: i=1; AHgh+RoNg2l4af/MU7JcaL9OqtyQ37RrZ4VtHp/AH8Egduziy/c2UUzNKJqYfTE68j+2qxFOnoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoAT0SC2RHDEZTPBVcO6GMY7wkgQIQj6Gv2VrdBrY39huexYf
	Y8KWgfulzuSydnsaG4vQJKfy4XX25gF82N8lJA8JTpxyfFa9xCM0SZ8S
X-Gm-Gg: AfdE7clxfrYR0JBsAWPe1vdZQ6S2jR7AkP+PiRr/tyyEHZMmA8p2eLcJNQBUSVO7p3h
	NZercFG6um3mD+f6fsJuF59bPRzWLmJjSa9vSOCwEbdj43Z6sNbCpWpddpyyp8F3Lg9PqynpdVi
	191KOkPUu3KGDWnp7Nu2eqmfnI+SBpeiz8ALHjL3KTkCNBCLMQutF7Q4T1920cM/S9PnUdiLpJq
	6xguSW3gtwzeEWQbJjaZy0oGJVmWV+33q3B4ywCqt6QGaL3WL9S7wcicdg7EYl8pcH+ZeIlbCQk
	Nq9Ndv9w2whZsS2pCtw228hIUVmTFvFt6STzlMFYkb7fgwFzXXR2ikbuuxNa7l2gB7XdKPppOOI
	Z2+zn66x+4+AphJGE26Y9LEKCTEnkIh1T6Uj91vy/+PPdWZ+yuEeuWFdBWxG+DzYhryajQ9Bu6O
	AYFeu98yi8njsHcXHsGzeZzsCNRHTCvPvcVgAEynrLfEIlf+6C+AE=
X-Received: by 2002:a05:6a00:bd8c:b0:848:4809:51cc with SMTP id d2e1a72fcca58-8487077d938mr1191245b3a.32.1783644325678;
        Thu, 09 Jul 2026 17:45:25 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484f0acb85sm2551463b3a.50.2026.07.09.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:45:25 -0700 (PDT)
Message-ID: <c15584d5097e1dbbfd358f02eb27459af0f7d643.camel@gmail.com>
Subject: Re: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return
 types
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 17:45:22 -0700
In-Reply-To: <20260708201020.2160131-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201020.2160131-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
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
> and struct_ops function models. Allowing up to 16 bytes here is safe: the
> previous patch already rejects >8 byte returns on the return-reading path=
s,
> where the trampoline preserves only 8 bytes of the return value.
>=20
> btf_validate_return_type() is relaxed as it accepts a by-value struct or
> union up to 16 bytes in addition to void and scalars.
>=20
> With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
> verifier, JIT, precision-backtracking, live-register and trampoline-guard
> preparation from the earlier patches becomes reachable: this final patch
> enables <=3D16 byte aggregate return values end to end.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0include/linux/bpf_verifier.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0kernel/bpf/btf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 14 +++++++++++---
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0.../testing/selftests/bpf/progs/exceptions_fail.c=C2=A0 |=C2=A0 2 +=
-
> =C2=A04 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index fa255f326240..ae4dae8e57f9 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1433,6 +1433,8 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, =
u64 stack_mask);
> =C2=A0bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int =
subprog);
> =C2=A0bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog);
> =C2=A0int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id=
, u16 offset);
> +bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env, const str=
uct btf *btf,
> +				 const struct btf_type *t, int rec);

Nit: maybe remove the "__" prefix?

> =C2=A0
> =C2=A0int bpf_find_subprog(struct bpf_verifier_env *env, int off);
> =C2=A0bool bpf_is_throw_kfunc(struct bpf_insn *insn);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index dff5c0d91641..bab82d1c8cb9 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7572,7 +7572,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
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
> +	if (ret < 0 || ret > 16) {
> =C2=A0		bpf_log(log,
> =C2=A0			"The function %s return type %s is unsupported.\n",
> =C2=A0			tname, btf_type_str(t));
> @@ -7968,6 +7973,9 @@ static int btf_validate_return_type(struct bpf_veri=
fier_env *env, struct btf *bt
> =C2=A0	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t=
))
> =C2=A0		return 0;
> =C2=A0
> +	if (btf_type_is_struct(t) && t->size <=3D 16 && __btf_type_is_scalar_st=
ruct(env, btf, t, 0))

Nit:	if (__btf_type_is_scalar_struct(env, btf, t, 0) && t->size <=3D 16)

> +		return 0;
> +
> =C2=A0	return -EOPNOTSUPP;
> =C2=A0}
> =C2=A0

[...]
