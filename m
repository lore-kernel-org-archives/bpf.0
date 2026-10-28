Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149352;
	b=j13TYl9nsKEgxRRM+BVXXrMwGY76xw1b7pzhNee5du7lt0vatoZXjfYK3VphnDXoVUBw
	 nhrxMpGYxfb1nsT3Z0IyczsEtmea2klTQtCh6Gu0yVgPdHUW7Wx1dmDSIr6L3sEpMDS9z
	 37tY9uk043tboXM595lvYaXWmSk6irYR7EfEGYtvS3XDhRAIehXbHnlq6EWnCsxI1UPs7
	 lptv1rz25h/i/F0k1bkWTa3x5y+fEPluUhluUwQ58DR6hFkMnJ+P1Z6gh8zJtuJnUDaxu
	 xy96GNgqSawybKgtWmZVQCWSPERL9V2bGpV9f1mvECE86ApkDjQhi93o86/pc841Vsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=htFBGPY5M1uT1EfanYjylWfA+iiJXrFmccR7o7mcw2I=;
	b=oLgvTjRJ7RzRFybRXpAovF5X2YKf49/Jacm3OrTB0+8e5YM9I0tMUPRk1zmKGyvQDPOf
	 R6bYRgU6U+HEnRoqq0rqhZZrIZVKod8GTL1G03evcCrAA7qq/CevOoi3uDW8ri9cmQ6hO
	 6JaLT9U8C5/aQG3FAJ3Pjpz0q/SWjVkBNDm647Fa3dgrMhSGzwdwRmQjjJ4xt1dH0SPW+
	 qNf8xDYy5xtz3cGoKFuXQi/Hk2E3zlmohmpKTeYs8CRz6SHqOJk+jBkgVI6pAC6GeRcHX
	 v/zjrSy2GW+bojIG4GkBgeNNIVc5Ptk0wr8DQ0S0mvVbdAJCfWs+Ee8VQzeAclRfyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="emN26Qy/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DB606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emN26Qy/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BF41F01825;
	Wed, 28 Oct 2026 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149351;
	bh=htFBGPY5M1uT1EfanYjylWfA+iiJXrFmccR7o7mcw2I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=emN26Qy/Z+g3O13ao5TprMGl8m1uCFfojS5OVtjx9Gofx6KzYuysuGSsV3GegIfVd
	 7QCGMPofD3riyPB4exN9OMR78qSDKQdUcIv4JjxsCcYoZLYJnU+9JdjqozbGnXorCD
	 rfXw/jnNepiO58X7jMmBEkS3cpJC5dcjaMW3+l8YS81yVa4OT7kcD7LBBxFbCC4Vfe
	 8cjSJ/WIUQSgc1KNU99TsqwN/CCKQffiJFldu3UlaneZPQNYKsigDx+NHnwkqLSdzC
	 cTLTjzDtkowvZ8EwXPX+n+LDT4q+ym0YJ2Q7PkR9qgAHB6bnmKYR+a8GQEIyoAD7of
	 T/GjHR1kcEs2Q==
Message-ID: <sashiko-outbox-187299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 02/11] bpf, arm64: Let the pad after a
 helper call have r0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <f86599ab5644a86943345b2650d1d11a0363bb6f.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <f86599ab5644a86943345b2650d1d11a0363bb6f.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:02:31 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf, arm64: memory leak of ctx.landing_ex in bpf_jit_free()
--

commit a9bbc452976e17e7771ffe7fb013d30ad6f17aba
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf, arm64: Let the pad after a helper call have r0

This commit adds landing pads after the epilogue for unwind_goto instructio=
ns
that follow helper or kfunc calls on arm64, copying the return value from x0
into x8 before branching to the pad. The extable fixup entries for these
calls are updated during a post-epilogue pass to point to the generated
landings.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index b8fb49b00063c..284c1dd791ad7 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2387,6 +2447,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ve=
rifier_env *env, struct bpf_pr
>  	if (ctx.offset =3D=3D NULL)
>  		goto out_off;
> =20
> +	for (i =3D 1; i < prog->len; i++)
> +		if (bpf_is_unwind_goto(&prog->insnsi[i]) &&
> +		    unwind_goto_after_helper(&prog->insnsi[i]))
> +			nr_landings++;
> +	if (nr_landings) {
> +		ctx.landing_ex =3D kvzalloc_objs(int, nr_landings);
> +		if (ctx.landing_ex =3D=3D NULL)
> +			goto out_off;
> +	}

[ ... ]

> @@ -2533,6 +2607,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  			prog->aux->priv_stack_ptr =3D NULL;
>  		}
>  		kvfree(ctx.offset);
> +		kvfree(ctx.landing_ex);
>  out_priv_stack:
>  		kfree(jit_data);
>  		prog->aux->jit_data =3D NULL;

[Severity: Medium]
Can this leak ctx.landing_ex if multi-function JIT compilation fails between
passes?

During the first pass of jit_subprogs() -> bpf_int_jit_compile() for a
subprogram (where prog->is_func is true and extra_pass is false), ctx is sa=
ved
in prog->aux->jit_data and the cleanup block is skipped so that ctx.landing=
_ex
and ctx.offset remain available for the second pass:

arch/arm64/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
	if (!prog->is_func || extra_pass) {
		...
	} else {
		jit_data->ctx =3D ctx;
		jit_data->ro_image =3D ro_image_ptr;
		jit_data->header =3D header;
		jit_data->ro_header =3D ro_header;
	}

	prog->bpf_func =3D (void *)ctx.ro_image + cfi_get_offset();
	prog->jited =3D 1;
	prog->jited_len =3D prog_size - cfi_get_offset();

	if (!prog->is_func || extra_pass) {
		...
		kvfree(ctx.offset);
		kvfree(ctx.landing_ex);
out_priv_stack:
		kfree(jit_data);
		prog->aux->jit_data =3D NULL;
	}
    ...
}

If a subsequent subprogram fails its initial JIT pass in jit_subprogs(), or=
 if
an earlier subprogram fails during the extra_pass loop, jit_subprogs() jumps
to out_free and calls bpf_jit_free() on each subprogram. However,
bpf_jit_free() frees jit_data without freeing jit_data->ctx.landing_ex (or =
the
pre-existing jit_data->ctx.offset):

arch/arm64/net/bpf_jit_comp.c:bpf_jit_free() {
	if (prog->jited) {
		struct arm64_jit_data *jit_data =3D prog->aux->jit_data;
		...
		if (jit_data) {
			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
			kfree(jit_data);
		}
    ...
}

Should bpf_jit_free() also call kvfree(jit_data->ctx.landing_ex) and
kvfree(jit_data->ctx.offset) before freeing jit_data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D2
