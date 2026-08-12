Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E754351C31
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565236; cv=none; b=A7V0/j/AA4iKI/quuy5GaymWyYKdJxmJJh7QiTUj3AxfnuRY6lCbL77Uf6S3anURsCcokYC9N3SWR868XIEuRGxdAJV4PYGYqejXJnUqsj7VieG9DToibaKWefwRLpZUBYs2Ah7+685tSkrBEGZO4ldBtaReEXJv9xUCHvprZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565236; c=relaxed/simple;
	bh=+/OX2RfX5vIdOOQJs9OQvh5d5v19d+YPcGCTHo5g3tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvFSYzcBK1EKmd7ewLHPhlQH9uVB2+05W9UqzJ2pmSoJK2MennSQ/fzQ+EGdLs5ufZCcMtNuoSpLmNXuR7ZzhkU3b1POA3oNTv+rcuaiQ/rGioiXEav06vk6mAPlKH43/L/0AB7/2MuowSX15V5Xu+LxZVdbvRePm5AeCEqbLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyLw4Qd7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyLw4Qd7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1752925b3a.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786565231; x=1787170031; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0xwc9sqFMawiSG89Te8YjAN3hfZQKWJl+Nz/zByqDOA=;
        b=HyLw4Qd7rP9KTVZhNwUZh2LuK8bIrSmqfF1pSHJbS9Mb0Wey94/w+QHDQFxs2LlIo+
         zEJHMCvLO0dp1Uyyb33qzKXRSmSJSsWWhySppvq4Y67UNwZbqKTQ6b7ciniuAp387xdL
         RRTgfPpv+xm3PN8Yc69GqmUgI6aD2tAp3q/fOWTWztMGVxyWoEbjY144qoawqxLk9h5C
         LoDeWzKycfMvfUpeypUgOQbtTlTMl3+kEuXeVWFJovaurAQo45Srr4oyL8Pa1JUMOF1I
         nNck+QZlFo3E/ik+BAy0nC/zjbTMLbj2DA+byafQUPB3lLZH691y2gozgVUd7TaAGXUa
         SbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786565231; x=1787170031;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0xwc9sqFMawiSG89Te8YjAN3hfZQKWJl+Nz/zByqDOA=;
        b=jR+OGXyqKVCOUM4kHx6iHasQdg+UTJoTkblNgnfH6g/wLnPv0Q5t4hFyew5exf+aSx
         yFHL5Gm6iJRssp91DLYMpuK821P9sUiw5yoDFRaTww+vX7x/Y7VC/pB9mnjlBHkRoJn8
         wzChM6GoZae6W2jnat6vvGM4yv1j3scY/rqiyCfxgiaVG1AXo8tyhNxfwOdcvt/PwFzW
         mVv6mAEIB12KwdNBF1eW2wBWcgQJrHFOxxuYVBicNKQXD6Ucw8+E1D6bwmK1IxWu4nhn
         pzuXA2OF6EMyrpA1OszoY19tldyTAvLUObq5eSid4tUQ+xCQf/z3CfTFRr2MAm4dWgTH
         ocCw==
X-Forwarded-Encrypted: i=1; AHgh+RrAlGsCqxqSQLFJBxxuk7Tzd09YLVkE6xER6+drjKk7Nkr2dHUA6DyilDlRA7syAceFeuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpnXiI72KxxohpmROv0EJUbLENmeKPwceruLOM/PPCufTfOxS
	KUb3NFDXbuio0roUrwGciBdP6bf2+qFx6Vnd8UntomQKeqHfySV3Fu55
X-Gm-Gg: AR+sD12vMuOXvz53gNZgJr2hJuUZqtktX7XkkJlqXq8VBJAKww0pja7RY0cTy3NUmey
	x0pR7r11F5i3/cLbAWu0pLYy4qhohNcEC31pxv7ZgYHWsYPnsPardKiLRfDZiXnUfxYfhsQLQYF
	AX4pY71Q8Xnrx7TdTopterWJujueFMqpOM1Ps+138wnZZib3O5uQYfRZPUMgiIegRqu6YvGZXEX
	ESssm+VxEZ0O6ZkCYrIv7powT9mK9nMdEhFgs2fpwRFKBMK52QKFAT+JYSQ9LLMt55xGFlFX6XC
	zvQMsnLV3pHtqZmMbLzgAz9hcOBL+pkl+zPjkyng3vBkDFpo6ngRyb6B0ljwQCNoKZq/T3EExbL
	80fytYrdW94Zcfk5HLGZKMKpbB6Hpx4Ab1RN1YWW1k2syuvcsr6vKs8KwskkLPUHUAhhycCNpbI
	4/GZefxjyIOfl3/w2KWv62TwZVloczJvu0yFZhvNPUmFnkPk9tJVrt703Miy4wxZy+fN07VL6Oe
	2WmVUpkHbjqjBSG/T0+nDnTnHw=
X-Received: by 2002:a05:6a00:180d:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-84fc7493722mr431463b3a.4.1786565230740;
        Wed, 12 Aug 2026 13:07:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4781978sm107294b3a.20.2026.08.12.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:07:10 -0700 (PDT)
Message-ID: <45edea4007f2b3b02caa34ed448060d43bf1f6c3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Add helpers to describe the
 R0:R2 return register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 13:07:07 -0700
In-Reply-To: <20260811000922.2380171-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811000922.2380171-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:09 -0700, Yonghong Song wrote:
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more tha=
n
> 16 bytes: such a value comes back in the R0:R2 register pair, with R2
> holding the upper half. See LLVM patches [1] and [2].
>=20
> Later patches teach the JIT, precision backtracking, live register analys=
is
> and the verifier itself about that convention. All of them need to answer
> the same question: does this subprogram return its value in a register
> pair? Add the shared helpers up front so that those patches can be ordere=
d
> independently of each other:
>=20
> =C2=A0- subprog_ret_type() resolves a subprogram's BTF return type. It is
> =C2=A0=C2=A0 factored out of subprog_returns_void(). The verifier_bug_if(=
!func) and
> =C2=A0=C2=A0 !func_proto checks it replaces are redundant, since
> =C2=A0=C2=A0 check_btf_func_early() already rejects a func_info record wh=
ose type_id
> =C2=A0=C2=A0 is not a BTF_KIND_FUNC pointing at a BTF_KIND_FUNC_PROTO. A =
check on
> =C2=A0=C2=A0 prog->aux->{btf,func_info} is added instead: unlike
> =C2=A0=C2=A0 subprog_returns_void(), which is only used for global subpro=
grams, later
> =C2=A0=C2=A0 callers ask about static subprograms too, and those may belo=
ng to a
> =C2=A0=C2=A0 program loaded without BTF.
>=20
> =C2=A0- ret_regs_cnt() maps the size of a return value to the number of
> =C2=A0=C2=A0 registers holding it.
>=20
> =C2=A0- bpf_ret_reg_pair() answers the question above. Its users query it=
 at
> =C2=A0=C2=A0 every subprogram call and at every subprogram exit, that is =
once per
> =C2=A0=C2=A0 verifier state rather than once per subprogram, so the answe=
r is
> =C2=A0=C2=A0 precomputed into bpf_subprog_info->ret_reg_pair by
> =C2=A0=C2=A0 bpf_compute_subprog_ret_regs() and the helper itself is a fl=
ag test.
> =C2=A0=C2=A0 It lives in bpf_verifier.h because kernel/bpf/backtrack.c an=
d
> =C2=A0=C2=A0 kernel/bpf/liveness.c need it as well.
>=20
> bpf_compute_subprog_ret_regs() runs in bpf_check() right before
> bpf_compute_live_registers(), which is the first of those users: by then
> BTF func_info has been validated and the subprogram list is final.
>=20
> No functional change, bpf_ret_reg_pair() has no callers yet.
>=20
> =C2=A0 [1] https://github.com/llvm/llvm-project/pull/190894
> =C2=A0 [2] https://github.com/llvm/llvm-project/pull/206876
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

I still think that bpf_compute_live_registers() can be used to compute
this information w/o the need to resort to BTF.

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 40150390dd50..58a177d26c46 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -382,27 +382,57 @@ bool bpf_subprog_is_global(const struct bpf_verifie=
r_env *env, int subprog)
> =C2=A0	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
> =C2=A0}
> =C2=A0
> -static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
> +/* Return type of a subprogram, NULL if it cannot be resolved */
> +static const struct btf_type *subprog_ret_type(struct bpf_verifier_env *=
env, int subprog)
> =C2=A0{
> -	const struct btf_type *type, *func, *func_proto;
> +	const struct btf_type *func, *func_proto;
> =C2=A0	const struct btf *btf =3D env->prog->aux->btf;
> =C2=A0	u32 btf_id;
> =C2=A0
> +	if (!btf || !env->prog->aux->func_info)
> +		return NULL;
> +
> =C2=A0	btf_id =3D env->prog->aux->func_info[subprog].type_id;
> =C2=A0
> +	/* Both already validated by prepare_btf_func() at prog load. */
> =C2=A0	func =3D btf_type_by_id(btf, btf_id);
> -	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
> -		return false;
> -
> =C2=A0	func_proto =3D btf_type_by_id(btf, func->type);
> -	if (!func_proto)
> -		return false;
> =C2=A0
> -	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
> -	if (!type)
> -		return false;
> +	return btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +}
> +
> +static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
> +{
> +	const struct btf_type *type =3D subprog_ret_type(env, subprog);
> =C2=A0
> -	return btf_type_is_void(type);
> +	return type && btf_type_is_void(type);
> +}
> +
> +/*
> + * Number of registers holding a function return value: a value of up to=
 8
> + * bytes is returned in R0, a value of more than 8 bytes and no more tha=
n 16
> + * bytes (an __int128 or a struct/union of such size) is returned in the=
 R0:R2
> + * register pair, with R2 holding the upper half.
> + */
> +static u32 ret_regs_cnt(u32 size)
> +{
> +	return size > 8 && size <=3D 16 ? 2 : 1;
> +}
> +
> +/*
> + * Resolve the return convention of every subprogram once, so that
> + * bpf_ret_reg_pair() is a plain flag test on the hot paths that use it.
> + */
> +static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf_type *type;
> +	int subprog;
> +
> +	for (subprog =3D 0; subprog < env->subprog_cnt; subprog++) {
> +		type =3D subprog_ret_type(env, subprog);
> +		if (type && (btf_type_is_struct(type) || btf_type_is_scalar(type)))
> +			subprog_info(env, subprog)->ret_reg_pair =3D ret_regs_cnt(type->size)=
 > 1;

Nit: there is a btf.c:btf_resolve_size() api function, it would be
     better to use it instead of calculating the size ad-hoc.

Should the jit_required flag be set here instead of the main
verification pass?

> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static const char *subprog_name(const struct bpf_verifier_env *env,=
 int subprog)

...
