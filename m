Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A44499B4
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783813893; cv=none; b=UPyRHWz+yYD8//scPA6qZVt1K4JSzYAsqRQw8sM3/C8gOLmWMaUkv/Zmv/UASGb+hdzj1HojXBgSDuxZk/Zi0Rer9wOz3nDxhK0amKgaHZFzlOnrDSMgSBhM2jLQgGt+66OFvOVwIuxqMkzjqQvzRsmbIUuPMDN4ndTQ54hLLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783813893; c=relaxed/simple;
	bh=CZVXlF7CNCLQyRyu2QpONHLUkZgYKsO0a2Pggbt7zSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pd86I14nSJg4I9hqfSApGAgoCNOiL/4yD9qnkUxPJo14LzGTwes3dNMx6mgfqnM8hEN+4UlqSGQNAm1lEEcJvO7cDzVqJQHKf9N6Nr3Rj4AqcqjAAZtYYzj6i+5awqBk8LFdWuBmNpYzNNjcF8n9FlHzreIHZ77hR86h08EBcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHyjL6ld; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHyjL6ld"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c7c61b5292so36598175ad.0
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783813891; x=1784418691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=akjSyov2pD+eDiEd1DGG3+NxaHQ1/rRc5MIhqInjnIA=;
        b=hHyjL6ld2RTLYmOc4EZ7TgGH8OfdTPPdhrk8DxkpSxQURwchx4n1BaxPz8K5KejH60
         Crqm1AOuWIff0RkUCzYc+HlDViGEAMddXrLyjHwxsp9ewcP0AR1xXYVWb35k8lZR7FnE
         4iIwGdPjwcfSh1oh1M5ui+mZ4L/CLKL6altX9h3DU5Kd5zYxFHS23bdpoAEvbZS59Myb
         S6pUyVeZ/tv7aaud5hu1+htL/4UR+ACj6Do7A0Gw9FAcfhVV/wFZ+OTE83sVaUgsXw1b
         vzwW5hzbwQh2nOKSbk+Sz360lJlp6dtyyU/+61YENC2vhDyRdaxhIJCcC9JofJSVf7Ld
         pf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783813891; x=1784418691;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akjSyov2pD+eDiEd1DGG3+NxaHQ1/rRc5MIhqInjnIA=;
        b=k2pBAzXLO0V2lcRIZUyW3dHyMajRBPFUShIquCg9eYz6og/QjEyXr48V902lZbU6/u
         hJ/9k5MWBxAp7haA4O3nkCMOy8Khfs9rIY/xtROm+pwQh0aWqNyaTRuA1aefeIRHGwTy
         ITBSv87h7hD7MCh/8BUrhJWEtGvHQdWb5jAcY/aICTwIMZfQvgCV/lzlFKS7fn6p655M
         cjldv5rl9vMZKw7t/dVztCNxvYwK+VF3H0c1Fql6osTFkTCbCL8GYNu096V1+ftS5L++
         ZChCQ1DZHHBtVkqi9RhLCPuyqXg3hroHT5Okd1LAmmFOewqqJzYEOQ0O7KTxi6BuGyzc
         jYjw==
X-Forwarded-Encrypted: i=1; AHgh+Rq8UmotRssaSLDCWD1jWrIB/s8TRF+F+nW0sXfSpQxT3vRSrvhELCNga8DE4AADCKDOC34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMx96AaHS76dRt3UiA2xyqaHSfPUTQNj4OiiZkHRXHpWQ8IcWV
	mlwb+R5ffHClYeKSZ1iSaqKBJOUTn+22HYgMDuKdVZqpbbIFIUY81Iv1MaB61A==
X-Gm-Gg: AfdE7clTzDEwy2SrQrFgtJBmnwFXI3IpcAkX25iYr+SJjIQ9Q4B0M2zYb0nUZc5CL8t
	G9c5gNgqMdWnXeEeE0y9hsaJzrICQ2D11wZQsRL11rXCNel1mUrDE5oK5rK+bXffzcVitBCiQEJ
	LpJ6xloHmLhVoAsQPuUgpnGT9d5r18XOopgPjYOJ879PMuc0ra+oH5Mt/O4Il906xCcRnNf/bZT
	LEX37+a+e8a8w/47w8FNP1ZyLtWPPw5e3lHc+IL1VgQevMA7M87i0sAdwEs8XO/LWvfO/QKnX/M
	/NERNMye5mRarBxJB6LihhTvKWgXQpvxMfG75dCYEHZxMFiP8x/vjDDEPlJG/jOOd18sAcGY2Jt
	QsbEgMuplneaTJjHY9mUNX8V07XYNY06NIpuLkctHpSTjhGmd5x0Pl82cxVm1Bav9mEh8yp8MZ+
	5vmix5LfurvwNoAVpmqscK+2/toHvissmQVgeoHsbE
X-Received: by 2002:a17:903:2f90:b0:2ca:4cfd:a6ea with SMTP id d9443c01a7336-2ce9e7b0335mr39283475ad.16.1783813890822;
        Sat, 11 Jul 2026 16:51:30 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e26esm79241765ad.44.2026.07.11.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 16:51:30 -0700 (PDT)
Message-ID: <55f4d7bba39f0fd1e85f436423a4b9a967470701.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Sat, 11 Jul 2026 16:51:27 -0700
In-Reply-To: <3b272469-9563-4843-8126-5c6698a84d98@linux.dev>
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
	 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
	 <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
	 <3b272469-9563-4843-8126-5c6698a84d98@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-07-11 at 10:57 -0700, Ihor Solodrai wrote:
> On 2026-07-11 3:43 a.m., Eduard Zingerman wrote:
> > On Fri, 2026-07-10 at 12:29 -0700, Ihor Solodrai wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 64572f85edc8..20aeca6b4f95 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u3=
2 kfunc_btf_id, const struct bpf_p
> > > =C2=A0=C2=A0	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id=
);
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +/*
> > > + * Return the union of a kfunc's flags across all hooks.
> > > + * Unlike btf_kfunc_flags(), not restricted to a calling
> > > + * program's hook. Used when attaching to a kfunc for tracing.
> > > + */
> > > +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf=
_id)
> > > +{
> > > +	enum btf_kfunc_hook hook;
> > > +	u32 *hook_flags;
> > > +	u32 flags =3D 0;
> > > +
> > > +	for (hook =3D 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
> > > +		hook_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> > > +		if (hook_flags)
> > > +			flags |=3D *hook_flags;
> > > +	}
> > > +
> > > +	return flags;
> > > +}
> >=20
> > This. Is. So. Ugly. You guys should reflect a bit more on the llm outpu=
t.
>=20
> Hi Eduard, thank you for the review.
>=20
> I think it's healthy to have a clanker hater bias on the list,
> given the circumstances.=C2=A0 However not every slop is a decision made
> by a LLM, it's often humans.
>=20
> >=20
> > The fact that we currently have a technical possibility to have the sam=
e
> > kfunc in different sets with different flags seem to be accidental.
> > Is there ever a valid scenario for this?
>=20
> I don't know about "valid", but in fact there are kfuncs that
> currently have inconsistent flags.
>=20
> For example KF_SLEEPABLE can be on or off depending on the kfunc set:
> https://lore.kernel.org/bpf/ah8-6CNIHPCJxAOM@krava/
>=20
>=20
> > Grepping kernel code all I can find are these kfuncs from
> > drivers/hid/bpf/hid_bpf_dispatch.c:
> >=20
> > =C2=A0=C2=A0 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
> > =C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | =
KF_RET_NULL | KF_SLEEPABLE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | K=
F_SLEEPABLE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_try_input_report)
> > =C2=A0=C2=A0 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
> > =C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 /* for syscall HID-BPF */
> > =C2=A0=C2=A0 BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | =
KF_RET_NULL)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_hw_request)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
> > =C2=A0=C2=A0 BTF_ID_FLAGS(func, hid_bpf_input_report)
> > =C2=A0=C2=A0 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
> > =C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_=
syscall_kfunc_set);
> >=20
> > But this appears to be a misuse:
> > (a) syscall programs are always sleepable
> > (b) e.g. hid_bpf_allocate_context() calls kzalloc_obj() which can sleep=
,
> > =C2=A0=C2=A0=C2=A0=C2=A0 as far as I understand. Meaning that hid_bpf_a=
llocate_context()
> > =C2=A0=C2=A0=C2=A0=C2=A0 should always be marked with KF_SLEEPABLE.
> >=20
> > Am I confused?
> >=20
> > If I am not confused, I think that resolve_btfids() has to verify that
> > kfunc flags are always the same across multiple sets.
>=20
> Some form of build-time enforcement will be implemented as part of
> resolve_btfids() BTF handling, see the v1 here:
> https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.d=
ev/
>=20
> *If* you're right about no valid use-case for incosistent kfunc flags,
> then long-term I agree: build-time enforcement of consistency, and
> then the acummulation can be replaced by a search (find first) here.
>=20
> But this has to be confirmed somehow (by thoroughly inspecting all
> current inconsistencies and flags?..)
>=20
> However if there is even one valid use-case, then we are in trouble,
> because then depending on the flag semantics it may or may not make
> sense for it to be consistent accross kfunc sets. And it's not even
> clear what a good solution to that might look like: separate groups of
> flags? consistency enforcement for some flags, but not others (this is
> literally what Andrii suggested in resolve_btfids thread)?
>=20
> Accumulating flags across the sets is an acceptable workaround for
> this fix IMO. We can be more specific and *only* check for the
> KF_IMPLICIT_ARGS for the purposes of this fix though, but we still
> have to walk all hooks and OR.

And what would that mean for the same function to have
KF_IMPLICIT_ARGS in one set and not to have it in another?
Given that actual function address is resolved to the exact same
function. Such accumulator would only proliferate already confusing
behaviour.

I don't think that the analysis of existing cases would take longer
than 1-2h.

> I don't think it's reasonable to wait for the comprehensive kfunc flags
> analysis and resolve_btfids series landing before fixing the garbage
> dereference bug.
>=20
> >=20
> > > +
> > > =C2=A0=C2=A0u32 *btf_kfunc_is_modify_return(const struct btf *btf, u3=
2 kfunc_btf_id,
> > > =C2=A0=C2=A0				const struct bpf_prog *prog)
> > > =C2=A0=C2=A0{
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 6515d4d3c003..2f56ab8d6b58 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2584,24 +2584,24 @@ static struct btf *find_kfunc_desc_btf(struct=
 bpf_verifier_env *env, s16 offset)
> > > =C2=A0=20
> > > =C2=A0=C2=A0#define KF_IMPL_SUFFIX "_impl"
> > > =C2=A0=20
> > > -static const struct btf_type *find_kfunc_impl_proto(struct bpf_verif=
ier_env *env,
> > > -						=C2=A0=C2=A0=C2=A0 struct btf *btf,
> > > -						=C2=A0=C2=A0=C2=A0 const char *func_name)
> > > +static const struct btf_type *
> > > +find_kfunc_impl_proto(struct bpf_verifier_log *log, struct btf *btf,=
 const char *func_name)
> >=20
> > Nit: no need to reformat the declaration.
> >=20
> > > =C2=A0=C2=A0{
> > > -	char *buf =3D env->tmp_str_buf;
> > > =C2=A0=C2=A0	const struct btf_type *func;
> > > +	char buf[KSYM_NAME_LEN];
> >=20
> > We attempt to avoid large allocations on stack, that's why tmp_str_buf
> > was used here in a first place. This is the second time I see llm doing=
 this,
> > maybe adjust your agents.md or something. If tmp_str_buf is not big eno=
ugh,
> > that can be adjusted. But I don't think it's necessary in this particul=
ar case.
>=20
> This is not just a llm artifact, the new callers in the attach path
> don't have env available, only the log. Do you suggest refactoring
> bpf_check_attach_target() and path through the env now just to avoid
> allocating this buffer?
>=20
> I aimed to keep the fix patch minimal, but I see this is going to be a
> challenge.

My bad, sorry.

> >=20
> > > =C2=A0=C2=A0	s32 impl_id;
> > > =C2=A0=C2=A0	int len;
> > > =C2=A0=20
> > > -	len =3D snprintf(buf, TMP_STR_BUF_LEN, "%s%s", func_name, KF_IMPL_S=
UFFIX);
> > > -	if (len < 0 || len >=3D TMP_STR_BUF_LEN) {
> > > -		verbose(env, "function name %s%s is too long\n", func_name, KF_IMP=
L_SUFFIX);
> > > +	len =3D snprintf(buf, sizeof(buf), "%s%s", func_name, KF_IMPL_SUFFI=
X);
> > > +	if (len < 0 || len >=3D sizeof(buf)) {
> > > +		bpf_log(log, "function name %s%s is too long\n",
> > > +			func_name, KF_IMPL_SUFFIX);
> > > =C2=A0=C2=A0		return NULL;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > =C2=A0=C2=A0	impl_id =3D btf_find_by_name_kind(btf, buf, BTF_KIND_FUN=
C);
> > > =C2=A0=C2=A0	if (impl_id <=3D 0) {
> > > -		verbose(env, "cannot find function %s in BTF\n", buf);
> > > +		bpf_log(log, "cannot find function %s in BTF\n", buf);
> > > =C2=A0=C2=A0		return NULL;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > @@ -2653,7 +2653,7 @@ static int fetch_kfunc_meta(struct bpf_verifier=
_env *env,
> > > =C2=A0=C2=A0	 * can be found through the counterpart _impl kfunc.
> > > =C2=A0=C2=A0	 */
> > > =C2=A0=C2=A0	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
> > > -		func_proto =3D find_kfunc_impl_proto(env, btf, func_name);
> > > +		func_proto =3D find_kfunc_impl_proto(&env->log, btf, func_name);
> > > =C2=A0=C2=A0	else
> > > =C2=A0=C2=A0		func_proto =3D btf_type_by_id(btf, func->type);
> > > =C2=A0=20
> > > @@ -18873,6 +18873,44 @@ static int btf_id_allow_sleepable(u32 btf_id=
, unsigned long addr, const struct b
> > > =C2=A0=C2=A0	return -EINVAL;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +/*
> > > + * Resolve the prototype describing a trace target's real ABI. A
> > > + * KF_IMPLICIT_ARGS kfunc has its injected args stripped from the pu=
blic
> > > + * prototype, so use the _impl prototype; other targets use their ow=
n.
> > > + */
> > > +static const struct btf_type *
> > > +btf_attach_func_proto(struct bpf_verifier_log *log, struct btf *btf,=
 u32 func_id)
> > > +{
> > > +	const struct btf_type *func;
> > > +	struct module *mod =3D NULL;
> > > +	const char *name;
> > > +	u32 kfunc_flags;
> > > +
> > > +	func =3D btf_type_by_id(btf, func_id);
> > > +	if (!func || !btf_type_is_func(func))
> > > +		return NULL;
> > > +
> > > +	/*
> > > +	 * btf_kfunc_accumulated_flags() reads kfunc_set_tab, which for a
> > > +	 * module is stable only once it is live; hold a module ref across
> > > +	 * the read to exclude a concurrent module load.
> > > +	 */
> > > +	if (btf_is_module(btf)) {
> >=20
> > So, this function is supplied with a module BTF,
> > and the argument is that we can have an alive BTF reference
> > but not to hold a live module reference?
>=20
> We have a convention (I don't know the history behind it) to always
> btf_try_get_module() before reading associated kfunc sets, see a
> comment in btf.c:
>=20
> =C2=A0=C2=A0 /* Caution:
> =C2=A0=C2=A0=C2=A0 * Reference to the module (obtained using btf_try_get_=
module)=20
> corresponding to
> =C2=A0=C2=A0=C2=A0 * the struct btf *MUST* be held when calling this func=
tion from verifier
> =C2=A0=C2=A0=C2=A0 * context. This is usually true as we stash references=
 in prog's=20
> kfunc_btf_tab;
> =C2=A0=C2=A0=C2=A0 * keeping the reference for the duration of the call p=
rovides the=20
> necessary
> =C2=A0=C2=A0=C2=A0 * protection for looking up a well-formed btf->kfunc_s=
et_tab.
> =C2=A0=C2=A0=C2=A0 */
>=20
> I don't think it's worth the risk violating this convention within the
> fix, even though you may be right about it being unnecessary in principle=
.

Ok, upon closer examination, if btf comes from prog->attach_btf the
module reference is not held at this point, when this function is
called from bpf_check_attach_target().

> >=20
> > References to kfunc's modules are stored in the
> > bpf_prog_aux->kfunc_btf_tab, and the following code from core.c
> > suggests that module references would be present for as long
> > as the program using BTF from the module is present:
> >=20
> > =C2=A0=C2=A0 static void bpf_prog_free_deferred(struct work_struct *wor=
k)
> > =C2=A0=C2=A0 {
> > 	...
> > 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
> > 	...
> > =C2=A0=C2=A0 }
> >=20
> > ?
> >=20
> > > +		mod =3D btf_try_get_module(btf);
> > > +		if (!mod)
> > > +			return NULL;
> > > +	}
> > > +	kfunc_flags =3D btf_kfunc_accumulated_flags(btf, func_id);
> > > +	module_put(mod);
> > > +
> > > +	if (kfunc_flags & KF_IMPLICIT_ARGS) {
> > > +		name =3D btf_name_by_offset(btf, func->name_off);
> > > +		return find_kfunc_impl_proto(log, btf, name);
> > > +	}
> > > +
> > > +	return btf_type_by_id(btf, func->type);
> > > +}
> > > +
> > > =C2=A0=C2=A0int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 const struct bpf_prog *prog,
> > > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0 const struct bpf_prog *tgt_prog,
> > > @@ -19121,8 +19159,8 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
> > > =C2=A0=C2=A0		if (prog_extension &&
> > > =C2=A0=C2=A0		=C2=A0=C2=A0=C2=A0 btf_check_type_match(log, prog, btf,=
 t))
> > > =C2=A0=C2=A0			return -EINVAL;
> > > -		t =3D btf_type_by_id(btf, t->type);
> > > -		if (!btf_type_is_func_proto(t))
> > > +		t =3D btf_attach_func_proto(log, btf, btf_id);
> > > +		if (!t || !btf_type_is_func_proto(t))
> >=20
> > This part seems fine.
> >=20
> > > =C2=A0=C2=A0			return -EINVAL;
> > > =C2=A0=20
> > > =C2=A0=C2=A0		if ((prog->aux->saved_dst_prog_type || prog->aux->saved=
_dst_attach_type) &&
> > > @@ -19407,8 +19445,8 @@ int bpf_check_attach_btf_id_multi(struct btf =
*btf, struct bpf_prog *prog, u32 bt
> > > =C2=A0=C2=A0		return -EINVAL;
> > > =C2=A0=C2=A0	if (!btf_type_is_func(t))
> > > =C2=A0=C2=A0		return -EINVAL;
> > > -	t =3D btf_type_by_id(btf, t->type);
> > > -	if (!btf_type_is_func_proto(t))
> > > +	t =3D btf_attach_func_proto(NULL, btf, btf_id);
> > > +	if (!t || !btf_type_is_func_proto(t))
> > > =C2=A0=C2=A0		return -EINVAL;
> > > =C2=A0=C2=A0	err =3D btf_distill_func_proto(NULL, btf, t, tname, &tgt=
_info->fmodel);
> > > =C2=A0=C2=A0	if (err < 0)
> > > --=20
> > > 2.55.0
