Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A884FDA74
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572125; cv=none; b=Qn+BYeu8To9+hnhBzb+CFx7ZNeLsowxAEHaR1xmhHzLBm2uyYyaN7Cp5l9AIsSIsBEs0fIrx92Dg9keg+mjhmue9dmZ9LE/NQVB7rVduGwzzWiMNVSNWy6gQxwZNebEJoLXahxv5ISJzpcAP4X5TglTkGYrACn0GEfrJ36sl//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572125; c=relaxed/simple;
	bh=0JPPC9tSlWlbYH7wLGcj/NXA9339rxvtpPhEP+T6BPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itmeivxo2pDGdus1TW2ZKlA5QhHWD4rOVTmOuQOjbBsHUdireO8jG/T4bXjIK5VEpxn6Qtkv0G/ZEOdODxy1RGYRWsXODIUJlYaT4q4SrwipZgc7u3udgm8OJnhehpr/18r9ZH8l14f3p4gKG1fxfT4F7d45kfrMgo9T2i09tZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+xcPoxo; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+xcPoxo"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-356b1e20700so402073eec.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791572123; x=1792176923; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FkevH2TCWV2bmLz8DDSTG55mwHPWVPmvW5UpSY6vXlo=;
        b=D+xcPoxoW+lcvrV1Z1RmjV2EfAzi6s5NFwdZymyikVtp61fxHEYKCRwnSJ538r1g0K
         le7sB18CuwFEQtkqYD2N7wKzNTwLRQnTJm5ejijFNznlLzSQvwJ1BNmn500ZwI1A9Qqq
         WE0O8EdJ8weuT6l1LNG53jNGJYobVqnnGOj8VvJITFXv/OJfT3VkqWb7pxbN/dok5Aou
         H2RGoEDCNN6dLyg87026SfNcd7LruDKH1gqX8WIjiYQ8sg+sbCiMkF210nJLm6qiAXsv
         i7fllFNomRUcvGg8dKDJObqTcewfcYk4rrBH817j7AvJPgIorJuNU0s/rD3b/wSJKC+t
         /pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791572123; x=1792176923;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkevH2TCWV2bmLz8DDSTG55mwHPWVPmvW5UpSY6vXlo=;
        b=wfAFU6CufqeQPiwV1OVFQAHXtjSChbA88BeTIfqzSlNTw8kI6hQnXC230nHCPojokr
         Mrf6DIkmO6Qs38fuj6MwWEfQtkLsuRG/Xiisj1CPrJTGoA7LH2eQVqhhFYSQftgiXQRY
         5n7bB8aVOoVknRqmGvjHuNke+DsYPJNoFe+FbS2/f9nBGIBMq6P1taLUsIMgy6sobjrJ
         4lUGDNDQLfsIkj2ZFawHFbFSxTsVrIX9uGVyUsO2iDjNb0tqgPY3DFJwYraTYc20tNJ7
         EGMpNBBu0u6SZsxrv0RLhWLvA67jVa232qOVmbuOWB9BTNo2Vw1NaF96DCXc+olsbdH5
         vDiA==
X-Forwarded-Encrypted: i=1; AKwUvBy9iW855B7Z7p64hbln6+KwQIZgzRCEeFVuafQYqO3sTNKFVGRw19e1i5yCwDoZ5SddayA=@vger.kernel.org
X-Gm-Message-State: AFuF++ljS2FEWKvbhZg76HGQ6JmcwFJZ39fZXSoyLtdYDYhmCYUf8G98
	VM55ZspnkoeEqjS+nPJnIuN/JExqjNoVJfEqn3M9/U/vWHolO8gIdqCM
X-Gm-Gg: AYBFou1S24hSyGU5TARSwmuv2yXc6oEki3EbjrGVG4dLZXJYd7A1O8oODyqkzJM8KwH
	FdswH4dg9BErrmHkYDzlICR9rZ7eoMJf8U7RI2YkDjtWrEb/Zno6LvjofxmtmkHx6zJpi/IkoCR
	oITEUBkIDOLVr+HBmzBNB8drF5oQQDUL42TIgCuu/ANVyCmXCKO5MYv1Uc0mHbvWtFFlh59O4vi
	d7jTfpGqz+N0L0TlUcX80cZZIpWOjGlhwBWnKpFyHwiprXW6St/MGXDzCT+H9JAwLpzoMRq4lPF
	02WEiH2TtcZghH050Jg1FTRzPeVxDP0lYwvZmZxV8biaO1p7qqR/x2N/wej2hwMTGwE2tTklYBi
	nJHF6rhs3suYpPvGH3fIt/QCwIprLMM3Qm9W4khFvM8AhXxvXVJyXnEUow8EtjWNKBKZI1a6Zgq
	3M9D1rlC3AzXZ+V3oDvTMlgfGHo3e1ZEPEldxDXKHUOcaVJ/KVMXejDS+Zoi+HyvVf/QdN/ctO5
	LRC9fvDJZsRa0f/STYk0Yi7Ps1o/1jcZMaqNlYB7r326zxnwSrwZGVvJQ==
X-Received: by 2002:a05:7301:7d19:b0:353:7b3a:1c84 with SMTP id 5a478bee46e88-3537df7772fmr3723058eec.5.1791572122951;
        Fri, 09 Oct 2026 11:55:22 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:26fd:a5f6:5f7e:c6b7? ([2620:10d:c090:500::4:66bf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm7520309eec.13.2026.10.09.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:55:22 -0700 (PDT)
Message-ID: <faf14259573df35d2fc49a8445be5cd79a0a8565.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 19/51] bpf: representation for intervals
 with steps
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Date: Fri, 09 Oct 2026 11:55:21 -0700
In-Reply-To: <debf620cc082978bcb926bf13fa5af72f46e25607f0ca9289f4bb41ca15530d3@mail.kernel.org>
References: <20261009-scev-minimal-rebase-v3-19-bcba9bc53ac9@gmail.com>
	 <debf620cc082978bcb926bf13fa5af72f46e25607f0ca9289f4bb41ca15530d3@mail.kernel.org>
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
> > bpf: representation for intervals with steps
>=20
> TL;DR:
> - Commit message says eq/neq branches ignore base/step, but they appear t=
o
> =C2=A0=C2=A0change branch pruning
> - Comment in reg_bounds_sync() names reg_umin() where reg_smin() seems
> =C2=A0=C2=A0intended (nit)
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0bpf: representation for intervals with steps
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0Extend scalar register tracking with a linear "=
base + step * k" description:
> > =C2=A0=C2=A0=C2=A0=C2=A0each scalar carries two u16 fields, base and st=
ep (invariant: base < step),
> > =C2=A0=C2=A0=C2=A0=C2=A0recording that its value is some point on the l=
ine base + step * k.
> > =C2=A0=C2=A0=C2=A0=C2=A0A fresh scalar starts as base=3D0, step=3D1, i.=
e. any integer.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0This lets the verifier reason about strided val=
ues, e.g. an index multiplied
> > =C2=A0=C2=A0=C2=A0=C2=A0by an element size, which neither the min/max b=
ounds nor the tnum can capture
> > =C2=A0=C2=A0=C2=A0=C2=A0for a non-power-of-2 stride. Such reasoning is =
necessary to allow
> > =C2=A0=C2=A0=C2=A0=C2=A0array access with a variable offset through PTR=
_TO_BTF_ID, e.g.
> > =C2=A0=C2=A0=C2=A0=C2=A0for expressions like p->arr[i].field.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0reg_bounds_sync() uses the description in two w=
ays:
> > =C2=A0=C2=A0=C2=A0=C2=A0- __reg_bound_offset() clears the low bits of v=
ar_off implied by the number
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of trailing zeros shared by base an=
d step.
> > =C2=A0=C2=A0=C2=A0=C2=A0- __update_bounds_from_step() intersects the 64=
-bit range with the line via
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cnum64_intersect_linear(), snapping=
 smin/smax to actual points on it.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This is the last step of the sync, =
as refining the range from var_off
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0can move the bounds off the line.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0range_within() is extended to check whether the=
 cur register's equation
> > =C2=A0=C2=A0=C2=A0=C2=A0describes a subset of the points described by t=
he old register's equation.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0Scalar ALU operations update base/step as follo=
ws:
> > =C2=A0=C2=A0=C2=A0=C2=A0- ADD of a constant (including pointer + scalar=
): keep step, shift base;
> > =C2=A0=C2=A0=C2=A0=C2=A0- MUL by a constant: scale step and base by the=
 constant;
> > =C2=A0=C2=A0=C2=A0=C2=A0- LSH by a constant: scale step and base by the=
 corresponding power of two;
> > =C2=A0=C2=A0=C2=A0=C2=A0- sign extension: keep the register unchanged i=
f all values fit the target
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0type, reset to base=3D0, step=3D1 o=
therwise;
> > =C2=A0=C2=A0=C2=A0=C2=A0- All other operations reset to base=3D0, step=
=3D1.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0Branch (eq/neq) checks do not take into account=
 base/step yet.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Eduard Zingerman <eddyz87@gmail.=
com>
>=20
> The changelog says "Branch (eq/neq) checks do not take into account base/=
step
> yet."  Is that accurate for this patch?
>=20
> is_scalar_branch_taken() ends by calling simulate_both_branches_taken(). =
 That
> function runs regs_refine_cond_op() and reg_bounds_sync() on copies of th=
e
> registers, and treats range_bounds_violation() as proof that a branch is =
dead.
>=20
> reg_bounds_sync() now ends with __update_bounds_from_step(), and
> cnum64_intersect_linear() returns CNUM64_EMPTY when the refined range hol=
ds no
> point of base + step * k.
>=20
> For example, take r1 in [0, 30] with step=3D3, base=3D0 (say from r0 *=3D=
 3 with r0
> in [0, 10]), followed by:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0if r1 =3D=3D 4 goto L
>=20
> The tnum and min/max checks cannot decide this.  In
> simulate_both_branches_taken() the true branch refines r64 to [4, 4], and=
 then
> in cnum64_intersect_linear():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0d =3D imod(base - imod(smin, step), step);   /* i=
mod(0 - 1, 3) =3D=3D 2 */
> =C2=A0=C2=A0=C2=A0=C2=A0if ((u64)smax - (u64)smin < d)              /* 0 =
< 2 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
eturn CNUM64_EMPTY;
>=20
> So the JEQ branch is treated as dead (pred =3D 0) purely because of
> base/step.  JNE behaves the same way, and JNE against a range edge now sn=
aps
> the bound onto the line ([0, 29] becomes [0, 27]).
>=20
> This looks sound as long as base/step are sound, but it is a real change =
to
> branch pruning, and mark_chain_precision() is called on the compared regi=
sters
> whenever pred >=3D 0.  Should the changelog describe this instead of sayi=
ng
> eq/neq branches ignore base/step?

Kind of. Sort of.
There is no explicit handling in is_scalar_branch_taken(),
as well as it is not wired for pointers.
I didn't think through if simulate_both_branches_taken()
is sufficient or some explicit rules is_scalar_branch_taken()
might be of use as well.

>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 47a632a6749a..f5b2500335a7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -2208,6 +2337,15 @@ static void reg_bounds_sync(struct bpf_reg_state=
 *reg)
> > =C2=A0	 * then new var_off is (0; 0x7f...fc) which improves our umax.
> > =C2=A0	 */
> > =C2=A0	__update_reg_bounds(reg);
> > +	/*
> > +	 * Both tnum and base+step define a sequence of points,
> > +	 * potentially w/o intersection, or intersecting after N
> > +	 * tnum_step()'s, where N can be large. On the other hand,
> > +	 * step+base *must* be in sync with r64 in order for
> > +	 * array traversal logic starting at reg_umin() to be sound.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^^^^^^^^^^
>=20
> This isn't a bug, but is reg_umin() the right function to name here?  The
> array traversal logic isn't part of this patch.

Yes, this should be reg_smin().
