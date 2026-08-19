Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1B3BE652
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110803; cv=none; b=ZaJJBEQxtXh6KEIbExJRlldGqq0wHlmvVa6oLvHe0nsH/MMauWol48PaVPn11adb8UlM1JOVu+vQYuOBYS2Z5uoeluETk1N5JcMAs7gKWv4RcAby1rI/0VJN3UL2npmfPL5lGLkYYAsABQNGikPw/02PM2DEoc9mzYtfUrD4AMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110803; c=relaxed/simple;
	bh=4MPakgeR6DEUsdvkQgqqdkptURvaB53A8UfqRI9kzLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWLVYZUmLf9n6MciRpCHjMVWUGZhJllL4vvkGnco23rRNTeYhWwrC3ZpehowAFgHInoKQw6N276Oa8rXa4Jke3kseDoalNZCbszEJd0fCuxfT5WGq6LKrBsc245lbyFXCvRn1xTukLaeY/KKEWQ3fauVeuCv79gfj6pliGXuzYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+3xia3o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+3xia3o"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cace91f112so5912715ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 20:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787110801; x=1787715601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4QMIt096BKggo5NvuhtcYECHLPM8Jtw2a6EmwYlipWk=;
        b=X+3xia3oy6YfOwk/J2PyPYtRvf7DdJ3F7IGWJy9gKNqmtmwAMOy0BCxX/0vKvIUN2F
         EtuHRnGWKXiovdjNuEa+nGBFpYlfzYDImhQKy31MTWzumYHN4AGo9kDY4zthlkBO5LP3
         k2NQpzAoL8UxPOoOtOyzdlWxNe2UVLaz5JB3eV/MzzvIu80bvOihp3v5/p1tg4bFtpzc
         dl5lsCuWuuadpdTeJ5I4BQ/jIWPHXXsKgnRMoqcIom0zgk0TEgjtXxc29hvG4vyYjuwo
         zxym1atoR/hVMoajVlkU9IFczwegLtEJ/k1gbHH/RLqu0AP7YfSRtvZc7dL4mXQS4gPb
         jZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787110801; x=1787715601;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4QMIt096BKggo5NvuhtcYECHLPM8Jtw2a6EmwYlipWk=;
        b=MP8Y6vcGVWSzGdeJPM37TRwse+AsMIK2scv44sSKoXfS1Ax1cMc0RNRqlmDdKfjZ7C
         HSbuoh3A7akXCOG/hdKzDJOfdWqSQPPYpnVl7rR71Xgw2L+bIsFLHVm9t0gdtLNBRND8
         ikdHXhVRrgkX8zG5FEemCvaTitNld7e3Gl6F34JVdm73uu064oHrIYMVr+L/DGg2pZLy
         GwQ+D9IfVHWe6oYf4BX4xJP4ig3HBTbGOEs9rOjwQHy4Hd+n0brz9pjS5XqWHkaQ39Mb
         sgh9+T+iwC5iFA0Blw/9GUiGE8kNWnGRsgE/QDSHmP9qQZfXQ5q58H703Wd5mkjwork1
         n6kw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5gt/DqTDb32Am5/PShQyc+CzqmwpsTNr4zxaSAQuZ09GWMHfdRrma3DlPhAgsjrZhUDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx728q9qB89NBy7Jdr4UrJlaSnvifmI3e+rYS3Dnabzna49+aqq
	vEmQ3hVNVqHuA+3NWzTHkC+ofhiYB9TIzL7u52iUwZw7qZkH0G2cD0b2
X-Gm-Gg: AR+sD11hmXu3DmcAPj/CyEfMrHnBhP5pBXgcdmIBV5OQzBkBc626jgfikXXC+ow3mHl
	/e5mj65U4u3BgyynV4eLrUjH5D2t4DUEuMTfPPXeIK7lF1DnZ1cB42j7GKOusjc+erI2oiURxXU
	/WPfQwUNj0U4yL9WO8C5H937WynrF/rYhz3ZHhpIo9BdF5nxvpLE7NWGrHJFT8VAs35tOO2DMjB
	XfFGtlggC+0JzvEck6KQCU5FJYt784eC4jhYXmNUQv33bQlFnSUZ51kyBYkRynqaFc4UaRd7iwJ
	9Kk0+A8EAMIJBcuJ9vgnBp1lOcfugCBUjyMiqqfXDCLhyC9hDjdxwsDe0DMV1qegMobfRVYElQX
	qgSeaV7trDcp48m3uWnR56Ls8YBxZ6VLVeCR/hskKXWec3OFcF9ENaowkifCDRqgFR1k5KAh/Gi
	0sCaAhK2nnV7MpZpf8Cuk+ZNp87Ek8SFnaTNSGLlc/V409DXjyUjnJn/7LXJPQA9kA3+YssdLmA
	RNu+mJ9hxLWt2j3ifHPOzmO2CE=
X-Received: by 2002:a17:903:3b84:b0:2d5:2f49:b3de with SMTP id d9443c01a7336-2d5fd3e78f6mr34824095ad.0.1787110800832;
        Tue, 18 Aug 2026 20:40:00 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e53cf5sm20184755ad.45.2026.08.18.20.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 20:40:00 -0700 (PDT)
Message-ID: <04238b5fe022a851b8e1fad0af03dd45c15faf7c.camel@gmail.com>
Subject: Re: [RFC bpf-next 3/6] bpf: support low-32 subreg scalar linking
 for zero-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 20:39:57 -0700
In-Reply-To: <20260814231945.3884596-4-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
> Problem
> =3D=3D=3D=3D=3D=3D=3D
> Currently register equality tracking and propagation only works for full
> 64-bits (with additional constant offset). It is missing the
> relationship: "these two regs share only their low 32-bits".
>=20
> An illustrative snippet:
>=20
> > =C2=A0r6 =3D ...=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* full 64-bit=
 unknown */
> > =C2=A0w7 =3D w6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 32-bi=
t zero-extend mov from wide src */
> > =C2=A0if w6 !=3D 0 goto .Lxx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/* branch not taken, src narrowed */
> > =C2=A0if w7 =3D=3D 0 goto .Lok=C2=A0=C2=A0 <-- missing
>=20
> It works if the register is narrow to begin with, e.g.
> > =C2=A0r6 =3D *(u32 *)(...)
>=20
> Rephrased in verifier speak:
>=20
> The linked-scalar equality relation sync_linked_regs() maintains is full
> 64-bit only; there is no subregister (low-32) equality link.
> A 32-bit mov (w1 =3D w2) is therefore either promoted to a full-64-bit li=
nk
> when the source is provably u32, or the link is dropped entirely when the
> wider source has unknown high bits. A later narrowing of the source to it=
s
> low 32 bits never reaches dst, causing safe programs to be rejected. Note=
 that
> the ADD_CONST32 machinery only applies to +=3D const offset, not to equal=
ity.
>=20
> This was seen with bpf-gcc codegen that tends to reuse "w0 =3D idx" for
> "return 0" on an idx=3D=3D0 path, for bpf_loop callbacks.
>=20
> Solution
> =3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0- Introduce a low-32-only link, BPF_FLAG_SUBREG_ZEXT, added to BPF_=
FLAG_LINK.
> =C2=A0- For a wide-source 32-bit mov, mark dst with BPF_FLAG_SUBREG_ZEXT =
instead
> =C2=A0=C2=A0 of clearing it (when src carries a scalar id).
> =C2=A0- On a later low-32 narrowing sync_linked_regs() re-derives such a =
register as
> =C2=A0=C2=A0 the zero-extension of the base's low 32 bits: it copies the =
base (keeping its
> =C2=A0=C2=A0 precise low-32 tnum) and re-applies zext_32_to_64() -- the s=
ame helper the
> =C2=A0=C2=A0 32-bit mov used -- which is sound even when the source has u=
nknown high bits.
> =C2=A0=C2=A0 This is applied only when neither side carries an ADD_CONST =
delta (the
> =C2=A0=C2=A0 combined subreg+delta case is not modeled).
> =C2=A0- Sites that group a subreg-linked register by its scalar id compar=
e ->id
> =C2=A0=C2=A0 directly: no masking is needed, since BPF_FLAG_SUBREG_ZEXT l=
ives in
> =C2=A0=C2=A0 ->flags.
>=20
> The reconstruction copies the base wholesale, so it must put back the fie=
lds
> that identify reg rather than known_reg -- ->id and, now, the link flag. =
This
> mirrors what the ADD_CONST arm below already does ("Must preserve off and=
 id,
> otherwise another sync_linked_regs() will be incorrect"). Dropping the fl=
ag
> while keeping the ->id would be worse than losing the link: the register =
would
> claim a full 64-bit equality with a base whose high bits are unknown, and=
 the
> next sync driven by it would copy a narrowed low-32 value straight onto t=
he
> base's high half.
>=20
> The link_flags_match() helper added by the previous patch is widened from
> BPF_FLAG_ADD_CONST to BPF_FLAG_LINK, so regs_exact() -- and through it
> states_maybe_looping() -- discriminates the new flavour as well. regsafe(=
)
> additionally checks it early, before the explore_alu_limits and !precise
> short-circuits, which the helper's call site below them does not cover.
>=20
> Note: the sync_linked_regs() reconstruction is wrapped in an extra block =
that
> looks redundant here. It is a placeholder for the sign-extension counterp=
art
> patch, which turns it into the else arm of an if/else on the link flavour=
;
> keeping it now avoids re-indenting the whole body there.
>=20
> Results
> =3D=3D=3D=3D=3D=3D=3D
> Improves verifier tracking (seen in the next selftest).
> selftest runs:
> =C2=A0- clang: no new regressions (-mcpu=3Dv3 and v4)
> =C2=A0- bpf-gcc: no new regressions; the measurable selftest pass improve=
ments
> =C2=A0=C2=A0 come with the sign-extension counterpart patch.
>=20
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

As a general comment, please make the commit messages and comments
less verbose.

...

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index d3105b9a9965..ef71999c4695 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -490,6 +490,9 @@ static int clean_verifier_state(struct bpf_verifier_e=
nv *env,
> =C2=A0 *
> =C2=A0 * Only meaningful when rold carries an id: the flags are only ever=
 set
> =C2=A0 * together with one, so rold->id =3D=3D 0 implies none of them is =
set.
> + *
> + * BPF_FLAG_LINK covers every flavour, so this widens automatically as n=
ew
> + * ones are added.
> =C2=A0 */
> =C2=A0static bool link_flags_match(const struct bpf_reg_state *rold,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 const struct bpf_reg_state *rcur)
> @@ -497,7 +500,7 @@ static bool link_flags_match(const struct bpf_reg_sta=
te *rold,
> =C2=A0	if (!rold->id)
> =C2=A0		return true;
> =C2=A0
> -	return (rold->flags & BPF_FLAG_ADD_CONST) =3D=3D (rcur->flags & BPF_FLA=
G_ADD_CONST);
> +	return (rold->flags & BPF_FLAG_LINK) =3D=3D (rcur->flags & BPF_FLAG_LIN=
K);
> =C2=A0}
> =C2=A0
> =C2=A0static bool regs_exact(const struct bpf_reg_state *rold,
> @@ -554,6 +557,24 @@ static bool regsafe(struct bpf_verifier_env *env, st=
ruct bpf_reg_state *rold,
> =C2=A0
> =C2=A0	switch (base_type(rold->type)) {
> =C2=A0	case SCALAR_VALUE:
> +		/*
> +		 * A low-32-bit-only link has different sync_linked_regs()
> +		 * semantics than a full/ADD_CONST equality. check_scalar_ids()
> +		 * only ever sees the plain ->id and never looks at ->flags, so a
> +		 * mismatch must be rejected explicitly.
> +		 * Check it here, before the explore_alu_limits and !precise
> +		 * short-circuits below (neither of which tests it). Note the
> +		 * pre-existing BPF_FLAG_ADD_CONST check sits after those
> +		 * short-circuits instead. The argument for checking early
> +		 * applies to it equally, but moving it makes regsafe() stricter
> +		 * on a path that predates this series, which is a pruning change
> +		 * that wants measuring on its own; it is deliberately left
> +		 * alone here.
> +		 */
> +		if (rold->id &&
> +		=C2=A0=C2=A0=C2=A0 (rold->flags & BPF_FLAG_SUBREG_ZEXT) !=3D (rcur->fl=
ags & BPF_FLAG_SUBREG_ZEXT))
> +			return false;
> +

Why is this check here? Isn't it covered by the changes in link_flags_match=
()?

> =C2=A0		if (env->explore_alu_limits) {
> =C2=A0			/* explore_alu_limits disables tnum_in() and range_within()
> =C2=A0			 * logic and requires everything to be strict
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93e69116ca9e..8a802d49d0a4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -15076,15 +15076,42 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> =C2=A0					if (insn->off =3D=3D 0) {
> =C2=A0						bool is_src_reg_u32 =3D get_reg_width(src_reg) <=3D 32;
> =C2=A0
> -						if (is_src_reg_u32)
> +						/*
> +						 * *dst_reg =3D *src_reg below copies src's id into dst, a
> +						 * full 64-bit equality link. That is only sound when src
> +						 * fits in u32: a 32-bit mov zero-extends dst, so for a
> +						 * wider src the link would let sync_linked_regs()
> +						 * propagate dst's [0, U32_MAX] range back onto src's
> +						 * unknown high bits. For a wide src drop the full link
> +						 * and form a low-32-only BPF_FLAG_SUBREG_ZEXT link instead, so a
> +						 * later narrowing of src's low 32 bits still reaches dst.
> +						 *
> +						 * wide_subreg_link gates that low-32 link and excludes:
> +						 *=C2=A0 - a self-mov (w6 =3D w6): src =3D=3D dst, nothing to link=
;
> +						 *=C2=A0=C2=A0=C2=A0 forming one would only mint an id and a spuri=
ous
> +						 *=C2=A0=C2=A0=C2=A0 self-link (inert in sync_linked_regs()).
> +						 *=C2=A0 - an ADD_CONST-linked src (rX =3D base + K):
> +						 *=C2=A0=C2=A0=C2=A0 assign_scalar_id_before_mov() would clear its
> +						 *=C2=A0=C2=A0=C2=A0 base+delta link, and a combined subreg+delta =
link
> +						 *=C2=A0=C2=A0=C2=A0 isn't modeled anyway (sync_linked_regs() skip=
s it).
> +						 * In both cases src is left untouched and dst is cleared,
> +						 * as before this feature.
> +						 */
> +						bool wide_subreg_link =3D !is_src_reg_u32 &&
> +							src_reg !=3D dst_reg &&
> +							!(src_reg->flags & BPF_FLAG_ADD_CONST);

Why checking `!(src_reg->flags & BPF_FLAG_ADD_CONST)`?
assign_scalar_id_before_mov resets() src_reg->flags and assigns
a fresh src_reg->id when `src_reg->flags & BPF_FLAG_ADD_CONST`.
The existing code already breaks ADD_CONST32 relationship for src
on mov, let's be symmetric here unless there is a good reason not to.

By the way, does assign_scalar_id_before_mov() need to handle
BPF_FLAG_SUBREG_ZEXT? It appears that it is fine to share id
if `src_reg->flags & BPF_FLAG_SUBREG_ZEXT`,
would be nice to drop a (short) comment there.

> +
> +						if (is_src_reg_u32 || wide_subreg_link)
> =C2=A0							assign_scalar_id_before_mov(env, src_reg);
> =C2=A0						*dst_reg =3D *src_reg;
> -						/* Make sure ID is cleared if src_reg is not in u32
> -						 * range otherwise dst_reg min/max could be incorrectly
> -						 * propagated into src_reg by sync_linked_regs()
> -						 */
> -						if (!is_src_reg_u32)
> -							clear_scalar_id(dst_reg);
> +						if (!is_src_reg_u32) {
> +							if (wide_subreg_link && src_reg->id) {
> +								/* ->id already copied above */
> +								dst_reg->flags |=3D BPF_FLAG_SUBREG_ZEXT;
> +							} else {
> +								clear_scalar_id(dst_reg);
> +							}
> +						}

Nit: I'd avoid excessive indentation:

						if (wide_subreg_link && src_reg->id)
							dst_reg->flags |=3D BPF_FLAG_SUBREG_ZEXT;
						else if (!is_src_reg_u32)
							clear_scalar_id(dst_reg);


> =C2=A0					} else {
> =C2=A0						/* case: W1 =3D (s8, s16)W2 */
> =C2=A0						bool no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1)=
);
> @@ -15953,6 +15980,52 @@ static void sync_linked_regs(struct bpf_verifier=
_env *env, struct bpf_verifier_s
> =C2=A0			continue;
> =C2=A0		if (reg->id !=3D known_reg->id)
> =C2=A0			continue;
> +		/*
> +		 * A low-32 linked register shares only the base's low 32 bits;
> +		 * the flag says how its high bits are derived. For
> +		 * BPF_FLAG_SUBREG_ZEXT they are zero (32-bit zero-extending mov).
> +		 * Rebuild it from known_reg's low 32 bits accordingly, but only
> +		 * when neither side carries an ADD_CONST delta -- with a delta
> +		 * the low bits differ from the base by that delta and the combined
> +		 * subreg+ADD_CONST reconstruction isn't modeled here, so leave reg
> +		 * unchanged (sound, just less precise).
> +		 */
> +		if (reg->flags & BPF_FLAG_SUBREG_ZEXT) {
> +			if (!((reg->flags | known_reg->flags) & BPF_FLAG_ADD_CONST)) {
> +				{
> +					u32 saved_id =3D reg->id;

Right above this hunk reg->id =3D=3D known_reg->id relationship is already
established, why is saved_id necessary?

> +					u8 saved_subreg =3D reg->flags & BPF_FLAG_SUBREG_ZEXT;
> +
> +					/*
> +					 * reg =3D zext32(known_reg): its low 32 bits come from
> +					 * the base and its high 32 are zero. Rather than
> +					 * rebuild the value by hand, copy the base (keeping
> +					 * its precise low-32 tnum) and re-clear the high half
> +					 * with the same zext_32_to_64() the 32-bit
> +					 * zero-extending mov used -- the zero high half is a
> +					 * fallout of it, so no dedicated reconstruction is
> +					 * needed.
> +					 */
> +					*reg =3D *known_reg;
> +					reg->id =3D saved_id;
> +					reg->flags =3D (reg->flags & ~BPF_FLAG_SUBREG_ZEXT) | saved_subreg;

This would look much simpler with bitfields.

> +					zext_32_to_64(reg);
> +					reg_bounds_sync(reg);
> +				}
> +				if (e->is_reg)
> +					mark_reg_scratched(env, e->regno);
> +				else
> +					mark_stack_slot_scratched(env, e->spi);
> +			}
> +			continue;
> +		}
> +		/*
> +		 * Dest-driven direction (known_reg is subreg-linked, reg is not):
> +		 * copying known_reg's low-32-only state into a full register would
> +		 * be unsound, so leave reg unchanged.
> +		 */
> +		if (known_reg->flags & BPF_FLAG_SUBREG_ZEXT)
> +			continue;
> =C2=A0		/*
> =C2=A0		 * Skip mixed 32/64-bit links: the delta relationship doesn't
> =C2=A0		 * hold across different ALU widths.
