Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A93BB137
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766600; cv=none; b=RhDt/TLYfkHhJeT/MuktCpBveYpMGP3JLSCHyqMUS4xaqO3bRYU35IRWKl65aGia7mjBaM0co72HDEjp9o+syg7uhjhTjF7sCAnE6YudPrqXr6r5skZucDyVSkiI09RkVRNQWaEMSk1UF7siMBv/+Srcqcz4RVEiy5RTQqDw8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766600; c=relaxed/simple;
	bh=j1OfiMuTcA9LGCS4MAFN3Q3MI5OtDqQwCxuT9+cOIhM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GTtYwTtCv4ykJANTGOU58HGTycOEVK02aKSn0+M45nkHNSPJH3aEMOQMhNZoMJsRuGSDenAxnDMN2buWlPhYkrAKZsDcvNaMVLic3EjnXB82q8AIDMt7m8SgxyphsUA11wFu0JXxpVbCqOd11pQJyFu2LW8v4Ss70ezQDGUdS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hH55bSkt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH55bSkt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2031100a91.2
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766598; x=1784371398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8PZ8FpA/aY8u0ev7WtUpirEz0oiIzSDRKpXC7bRcTzQ=;
        b=hH55bSktALQPRk9InYdX5Vg5/0xRnrS1yxT/Gcd/kN34f5m1Cre/24qERD43iDgF+c
         Di6oeuI08cRYD3GPi1LPLioPhtbcpiHm+Pm84X1Ue/OcWHjO7FxbS3UaJV9tzMyv59Ux
         oE4BeHgTZABrBhiM8FnGx46oDxU/krcjGyDO53Abp7t+mdN9PGESd8DVj74UlkIwtsG8
         M3ZPmFhNgxuUk5LTggfoOxJqQ5cOuv6Nj2VgAUSb0YgD3tUGTu/2wwp5ktL1VbYpOboI
         WUDtRneVHD/wxOhxIX+VqsHx0G4lM64CgZ3hgErecytELJziiPZnLEAevgyKKryJF88q
         a05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766598; x=1784371398;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PZ8FpA/aY8u0ev7WtUpirEz0oiIzSDRKpXC7bRcTzQ=;
        b=RW56Fyf5ajAp1wSM5qBmuy5FR/i5bUnMIThXb+985rgReCpGwiEnp9oyN+5+AWvV+Q
         CnFzoHZExH25VJ1efQMWG6h8rcfC5s3Ob4fADgf4cfzsq11qFOtTqUOtwN+HDQy2qNse
         c/3emYNguEWtJ4BAPsZyzXni5wWI0uEotYdAAudwuWn0j8GU/5i1TpFD6K9qMGipSFg2
         TzwOccaWoya3VLkZ2hBheBgp0JwQXEqcXySGtrJTS1uV1jVS8fHlaNzTx3fyGSgwImWt
         aeTrUQwBqrWsERc5VUdLgbF0HMZ/vMjKTI6erUEZHnVYQgExPeyJS2HJaUKG1cmw1zz5
         k64w==
X-Forwarded-Encrypted: i=1; AHgh+RpLOKHNmi/C5pRJ83U+owWlrSjjxwRCRSJ0FvEFdILMkSLUEWpiVTzsZl9Yn7jHYO1UOAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygsftrArHMw1ogDyIIA5ML0nLzPmeksfpu/x1WAi94voJijOq
	/s0MAM9Bsel/J6pdLMYT9If58r+BEwcmZuxxbx2k+ffsIM+6lmJr5h+4
X-Gm-Gg: AfdE7cmfQxnW9GDUFHm5oZ5/LXD1JTOfGLwJaCQ1Us1x4n4pDo3zf30vdAYEcjb/eG3
	CSdBkNYXHZAXZXqzRoq5IRreiKVYzLg/PfG27G5LiJ3BZBQAstebhnsHUYB8DxcLXy6/PxyZywu
	HDYqSMQ4VJDpCZpeAbvz+J7qpmfxiWKNd20pjhmtZnh6+7J6KGDD4de382fu0xkvzv+tzY4ADN1
	GAugwWShMIj3LCT0YCqhXexiDWINP6CeylV888f8dS5viQinOLk4m/O8ShphjgMqHmcwnUt4Zy5
	XUnBleZ8m679CWMtTreEAavCA8nMK1vh4X8ftz+231JmiIs8G+OUXPtPxE8OJEWPy0zbhpfk3xi
	tAbzpCzD3ucwKq5UgKo84oYs2MqieQvDNmDJlNiJ3dqY4oTSy1rlLN0l5TAKbmzD6Bqx6j7peNt
	FcshFJRh+bfJOLw07iZ2qJmDgDJ0Rfn9E+qulGc5NclWDX4UGWMDs=
X-Received: by 2002:a17:90b:4a0a:b0:37e:144d:7f6e with SMTP id 98e67ed59e1d1-38dc73bb90dmr2629285a91.3.1783766598001;
        Sat, 11 Jul 2026 03:43:18 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a56224673sm3994086a91.13.2026.07.11.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:43:17 -0700 (PDT)
Message-ID: <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Sat, 11 Jul 2026 03:43:14 -0700
In-Reply-To: <20260710192940.3020280-2-ihor.solodrai@linux.dev>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
	 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-10 at 12:29 -0700, Ihor Solodrai wrote:

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85edc8..20aeca6b4f95 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kf=
unc_btf_id, const struct bpf_p
> =C2=A0	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> =C2=A0}
> =C2=A0
> +/*
> + * Return the union of a kfunc's flags across all hooks.
> + * Unlike btf_kfunc_flags(), not restricted to a calling
> + * program's hook. Used when attaching to a kfunc for tracing.
> + */
> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
> +{
> +	enum btf_kfunc_hook hook;
> +	u32 *hook_flags;
> +	u32 flags =3D 0;
> +
> +	for (hook =3D 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
> +		hook_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> +		if (hook_flags)
> +			flags |=3D *hook_flags;
> +	}
> +
> +	return flags;
> +}

This. Is. So. Ugly. You guys should reflect a bit more on the llm output.

The fact that we currently have a technical possibility to have the same
kfunc in different sets with different flags seem to be accidental.
Is there ever a valid scenario for this?
Grepping kernel code all I can find are these kfuncs from
drivers/hid/bpf/hid_bpf_dispatch.c:

  BTF_KFUNCS_START(hid_bpf_kfunc_ids)
  ...
  BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | K=
F_SLEEPABLE)
  BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
  BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
  BTF_ID_FLAGS(func, hid_bpf_try_input_report)
  BTF_KFUNCS_END(hid_bpf_kfunc_ids)
  ...
  /* for syscall HID-BPF */
  BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
  BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
  BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
  BTF_ID_FLAGS(func, hid_bpf_hw_request)
  BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
  BTF_ID_FLAGS(func, hid_bpf_input_report)
  BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
  ...
  register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_s=
et);

But this appears to be a misuse:
(a) syscall programs are always sleepable
(b) e.g. hid_bpf_allocate_context() calls kzalloc_obj() which can sleep,
    as far as I understand. Meaning that hid_bpf_allocate_context()
    should always be marked with KF_SLEEPABLE.

Am I confused?

If I am not confused, I think that resolve_btfids() has to verify that
kfunc flags are always the same across multiple sets.

> +
> =C2=A0u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_bt=
f_id,
> =C2=A0				const struct bpf_prog *prog)
> =C2=A0{
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6515d4d3c003..2f56ab8d6b58 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2584,24 +2584,24 @@ static struct btf *find_kfunc_desc_btf(struct bpf=
_verifier_env *env, s16 offset)
> =C2=A0
> =C2=A0#define KF_IMPL_SUFFIX "_impl"
> =C2=A0
> -static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_=
env *env,
> -						=C2=A0=C2=A0=C2=A0 struct btf *btf,
> -						=C2=A0=C2=A0=C2=A0 const char *func_name)
> +static const struct btf_type *
> +find_kfunc_impl_proto(struct bpf_verifier_log *log, struct btf *btf, con=
st char *func_name)

Nit: no need to reformat the declaration.

> =C2=A0{
> -	char *buf =3D env->tmp_str_buf;
> =C2=A0	const struct btf_type *func;
> +	char buf[KSYM_NAME_LEN];

We attempt to avoid large allocations on stack, that's why tmp_str_buf
was used here in a first place. This is the second time I see llm doing thi=
s,
maybe adjust your agents.md or something. If tmp_str_buf is not big enough,
that can be adjusted. But I don't think it's necessary in this particular c=
ase.

> =C2=A0	s32 impl_id;
> =C2=A0	int len;
> =C2=A0
> -	len =3D snprintf(buf, TMP_STR_BUF_LEN, "%s%s", func_name, KF_IMPL_SUFFI=
X);
> -	if (len < 0 || len >=3D TMP_STR_BUF_LEN) {
> -		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SU=
FFIX);
> +	len =3D snprintf(buf, sizeof(buf), "%s%s", func_name, KF_IMPL_SUFFIX);
> +	if (len < 0 || len >=3D sizeof(buf)) {
> +		bpf_log(log, "function name %s%s is too long\n",
> +			func_name, KF_IMPL_SUFFIX);
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> =C2=A0	impl_id =3D btf_find_by_name_kind(btf, buf, BTF_KIND_FUNC);
> =C2=A0	if (impl_id <=3D 0) {
> -		verbose(env, "cannot find function %s in BTF\n", buf);
> +		bpf_log(log, "cannot find function %s in BTF\n", buf);
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> @@ -2653,7 +2653,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env=
 *env,
> =C2=A0	 * can be found through the counterpart _impl kfunc.
> =C2=A0	 */
> =C2=A0	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
> -		func_proto =3D find_kfunc_impl_proto(env, btf, func_name);
> +		func_proto =3D find_kfunc_impl_proto(&env->log, btf, func_name);
> =C2=A0	else
> =C2=A0		func_proto =3D btf_type_by_id(btf, func->type);
> =C2=A0
> @@ -18873,6 +18873,44 @@ static int btf_id_allow_sleepable(u32 btf_id, un=
signed long addr, const struct b
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> +/*
> + * Resolve the prototype describing a trace target's real ABI. A
> + * KF_IMPLICIT_ARGS kfunc has its injected args stripped from the public
> + * prototype, so use the _impl prototype; other targets use their own.
> + */
> +static const struct btf_type *
> +btf_attach_func_proto(struct bpf_verifier_log *log, struct btf *btf, u32=
 func_id)
> +{
> +	const struct btf_type *func;
> +	struct module *mod =3D NULL;
> +	const char *name;
> +	u32 kfunc_flags;
> +
> +	func =3D btf_type_by_id(btf, func_id);
> +	if (!func || !btf_type_is_func(func))
> +		return NULL;
> +
> +	/*
> +	 * btf_kfunc_accumulated_flags() reads kfunc_set_tab, which for a
> +	 * module is stable only once it is live; hold a module ref across
> +	 * the read to exclude a concurrent module load.
> +	 */
> +	if (btf_is_module(btf)) {

So, this function is supplied with a module BTF,
and the argument is that we can have an alive BTF reference
but not to hold a live module reference?

References to kfunc's modules are stored in the
bpf_prog_aux->kfunc_btf_tab, and the following code from core.c
suggests that module references would be present for as long
as the program using BTF from the module is present:

  static void bpf_prog_free_deferred(struct work_struct *work)
  {
	...
	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
	...
  }

?

> +		mod =3D btf_try_get_module(btf);
> +		if (!mod)
> +			return NULL;
> +	}
> +	kfunc_flags =3D btf_kfunc_accumulated_flags(btf, func_id);
> +	module_put(mod);
> +
> +	if (kfunc_flags & KF_IMPLICIT_ARGS) {
> +		name =3D btf_name_by_offset(btf, func->name_off);
> +		return find_kfunc_impl_proto(log, btf, name);
> +	}
> +
> +	return btf_type_by_id(btf, func->type);
> +}
> +
> =C2=A0int bpf_check_attach_target(struct bpf_verifier_log *log,
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct bpf_prog *prog,
> =C2=A0			=C2=A0=C2=A0=C2=A0 const struct bpf_prog *tgt_prog,
> @@ -19121,8 +19159,8 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
> =C2=A0		if (prog_extension &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 btf_check_type_match(log, prog, btf, t))
> =C2=A0			return -EINVAL;
> -		t =3D btf_type_by_id(btf, t->type);
> -		if (!btf_type_is_func_proto(t))
> +		t =3D btf_attach_func_proto(log, btf, btf_id);
> +		if (!t || !btf_type_is_func_proto(t))

This part seems fine.

> =C2=A0			return -EINVAL;
> =C2=A0
> =C2=A0		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attac=
h_type) &&
> @@ -19407,8 +19445,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf=
, struct bpf_prog *prog, u32 bt
> =C2=A0		return -EINVAL;
> =C2=A0	if (!btf_type_is_func(t))
> =C2=A0		return -EINVAL;
> -	t =3D btf_type_by_id(btf, t->type);
> -	if (!btf_type_is_func_proto(t))
> +	t =3D btf_attach_func_proto(NULL, btf, btf_id);
> +	if (!t || !btf_type_is_func_proto(t))
> =C2=A0		return -EINVAL;
> =C2=A0	err =3D btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmo=
del);
> =C2=A0	if (err < 0)
> --=20
> 2.55.0
