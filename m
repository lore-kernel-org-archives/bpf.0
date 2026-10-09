Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B651588D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571793; cv=none; b=JftXtJfseBUFljW2j/7QP6OvW7YMus0dhon+6hDEtJzJZflZPjVrXan2XVDN7Z9L4aEqBPTLaxDgi7MLG7Hff1u0pHvlpB8OZhCTHF+wg/LCREKa70m42jMnO6oWnMNIjxhLylwAHz9KipnMhk3Hby1kU7HaEivDGENtnjOjqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571793; c=relaxed/simple;
	bh=Q3FnLwZG3muNZ4yk4OIA0n8d1A/2Jyrd1KYAhYPjMnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAk/FCGpY0QWSHuWfHyk/loAQlOuNp3gkOD2Cn6m2e0lfu/86+FwjaqMRS0RC8gguQNFkkm0ZSmY5I9icJyO2qB7E8Pu+3L+1QpsXEmBjLDQF1LoNBiH8C+nxFyNOyT4krlwUyzza3IM/4FGdtZZxJGePhiYpmmpVAB/+3OQ6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkSXq7yf; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkSXq7yf"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so31348eec.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571790; x=1792176590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ISKt6FvgzyNKMawZDI9/eBxqq2y056UPyin58bp7Ffw=;
        b=pkSXq7yfDPlK9qPvpT+DZgYFkBBS8MkBPljfDq9WcJ0Xw6B2rO/bjMhfMlNHEkDFM4
         mcRA37XgsAxLj2HpAjjuKW2A/84cgdPNMsInzEKyC/jr2SH1se85W9UnE4bOGIqL6Dqc
         3jfl7yqgEpmHgq/W0vexAmHZQUkyHM/zfYopLTY9txzybtUSJ7bkYHE0UAy05UgalP2p
         KnpGwK5CSMPB1Mzv6J33+cWA2nSC90qF7WYVhsQzjXrEGrO5mFIx2PLnwJ0z9ya2igWS
         V5dN9cjs+geTuVbZIGgG/9hU/NorqyMpkrhAxWgxmr/48T4USLBAx9TZPqBiXgL/R99S
         ojPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571791; x=1792176591;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ISKt6FvgzyNKMawZDI9/eBxqq2y056UPyin58bp7Ffw=;
        b=XyJZu4fR7x26R7kyGjpJtqhny91vmGujxwcxD6BGwYAIPuyB83i9uR2mOvzUfI0R1q
         qOM4ewZ3SMZYJwTuKeuJZJFXsSAwwgiF2aOA5I5t/gWWGV2gzXlig0haFJv3cq+qk5lJ
         GfDrroCUpjNEPC1TgONIA3/7VEwRmRTXc1WCxooWn1Et/fVXi3+bPNrWb/OCbybuEKrP
         ADfc2++U7ej2hAWLDl1SGuld05G3P/23NRaYVI6eJ2weq0y2KSoRI2pcf7ZgbRW3ZNOj
         TLvFLI7k1B8NkFojQf8LEq3eqWmo8fPhvZnAwH+TpBCOxkLMd63HOhPPRbHsh2N352he
         FNIw==
X-Forwarded-Encrypted: i=1; AKwUvBwkGlkgO7XS22c1TLGaLT+iQfppHWmX+yXo8ZelFNDfJWEVekNUrz8U0qbn4AGHpTMj+Hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2DrUJAcXziiIoJksspT5AyNepDbYgJoidD3ECEHVd10xOENti
	qhWryY9Dy5Ac2NHga9uLIg9x81CmVzTD5RIZ5ljFq9O6jwpEyJk1uMPg
X-Gm-Gg: AYBFou01qKxmMu6rDgoSRAPCOOlAkRm6VUA0kFHbO4KAvgf5K+tFD4s1mMmkUnowK4n
	CxRq72sCpxwU+0cJdPPQ3Bb3X5ZJqlbqokwIsE1R6J5/AA8vdV9cyiQ9T6iFID6Z22HtIJuG2z8
	E33GGZpCqqxgAH58ZEDPYBVqtu/4JFjr+s/Jg/hn25rTaI6xPYQ2/Wj80fn7EkMtE9LhgUi50EY
	VYXoR7vmkxmyQ3l7pzDOcVUpknVxlr8k1u6s+/AD+jdAd+29npMftydl1p0Dto9PX3SVLp1jRek
	8C1L7WW/WJiUOSunenEAHwiKveycN+99bCR3Nhc8UfAf/EwppTnhTK+yx8LgBIKZJt9WLORoJ43
	C/nXzE9RYQ0TUXP9uY384MTiTxx8kqoBTsVAan+nZ1YJL1haE2CY9PtEQuEvlTko0NfReWcYK6g
	u3Ec7k8vDgQDsFgedpuLPYN44W5fSC70K8sCww5MGsJ/Brw/mYgpzA7Ccv/Xo3szqyZxEeD1nJw
	EbX2ilOdThEWn8q0+CM5msBTnDlfrpkynLUFQhZR3ymUlfqxAbXX6Yy
X-Received: by 2002:a05:7301:488b:b0:351:51c4:a296 with SMTP id 5a478bee46e88-3537dde56bamr3572229eec.4.1791571790491;
        Fri, 09 Oct 2026 11:49:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:26fd:a5f6:5f7e:c6b7? ([2620:10d:c090:500::4:66bf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm10105125eec.0.2026.10.09.11.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:49:50 -0700 (PDT)
Message-ID: <5e7f4719d517bdb1aa391f46f032ef0652630dd6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/51] bpf: derive global subprog stack
 liveness from BTF signatures
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Date: Fri, 09 Oct 2026 11:49:48 -0700
In-Reply-To: <12bdbe361c0dac1e815745e4394dbac721526b99d0dcd8a6b587086d29bb39ea@mail.kernel.org>
References: <20261009-scev-minimal-rebase-v3-10-bcba9bc53ac9@gmail.com>
	 <12bdbe361c0dac1e815745e4394dbac721526b99d0dcd8a6b587086d29bb39ea@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-09 at 12:07 +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: derive global subprog stack liveness from BTF signatures
>=20
> TL;DR: bpf_global_subprog_stack_access_bytes() likely matches ARG_ANYTHIN=
G
> where btf_prepare_func_args() assigns ARG_SCALAR, so scalar args may get =
the
> conservative read/write-all result; safe but less precise liveness.
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8987c9a69d10..a5456a6e2694 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -14571,6 +14571,72 @@ bpf_kfunc_stack_access_bytes(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> > =C2=A0	return info;
> > =C2=A0}
> >=20
>=20
> [ ... ]
>=20
> > +struct arg_access_info
> > +bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, st=
ruct bpf_insn *insn,
> > +				      int arg, int insn_idx)
> > +{
>=20
> [ ... ]
>=20
> > +	switch (base_type(sub->args[arg].arg_type)) {
> > +	case ARG_UNUSED:	/* Not an argument slot. */
> > +	case ARG_ANYTHING:	/* A scalar, the callee can't dereference it. */
> > +		return (struct arg_access_info) {};
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^
>=20
> Can this case ARG_ANYTHING ever match?  btf_prepare_func_args() doesn't
> assign ARG_ANYTHING to a subprog argument.  It encodes scalar parameters,
> including both halves of a 16-byte struct passed by value, as ARG_SCALAR:
>=20
> kernel/bpf/btf.c:btf_prepare_func_args() {
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0w=
hile (nslots--)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sub->args[slots_used++].arg=
_type =3D ARG_SCALAR;
> =C2=A0=C2=A0=C2=A0=C2=A0...
> }
>=20
> do_check_common() and the exception callback check test for ARG_SCALAR to=
o,
> and ARG_SCALAR and ARG_ANYTHING are separate values in enum bpf_arg_type.
>=20
> A scalar argument slot would therefore fall through to the default label,
> which returns the conservative result (size =3D U32_MAX, may_read, may_wr=
ite)
> rather than the empty access described by the comment.
>=20
> For example, with allow_ptr_leaks the main pass accepts a stack-derived
> scalar here:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0r1 =3D r10
> =C2=A0=C2=A0=C2=A0=C2=A0r2 =3D r10
> =C2=A0=C2=A0=C2=A0=C2=A0r2 +=3D -8
> =C2=A0=C2=A0=C2=A0=C2=A0r1 -=3D r2
> =C2=A0=C2=A0=C2=A0=C2=A0call global_func(int x)
>=20
> Pointer minus pointer becomes an unknown scalar, so the ARG_SCALAR check
> passes.  arg_track_alu64() keeps the frame identity (dst->frame =3D=3D
> src->frame sets dst->off_cnt =3D 0), so arg_is_fp() is still true for r1.
>=20
> record_arg_access() then calls record_stack_access() with off_cnt =3D=3D =
0,
> which does mark_stack_read_all() and mark_stack_may_write_all() for the
> whole caller frame at the call.  Before this patch the callee was analyze=
d
> in context and made no stack accesses through its scalar parameter.
>=20
> The result is safe but less precise.  More stack slots stay live, every
> stack slot may be written at the call, and SCEV can no longer keep
> stack-based recurrences across the call.
>=20
> Should this be case ARG_SCALAR: instead?  That looks sound, since neither
> the callee nor an freplace body can dereference a scalar argument.  No la=
ter
> commit in the series (up to 726d0559f576) changes this.

Valid point.
Should use ARG_SCALAR, can also add ARG_PTR_TO_ARENA.

...
