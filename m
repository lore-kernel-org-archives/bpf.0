Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBF380FFA
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079040; cv=none; b=ieQImEW0B7V3aDuv9scDxL8FdKgFLaIiqVKDD8CutMGRe/lKKJHV74zQYJl7VVvoN0kECXArUK+gAKHa4yyVBts30HhpDP4Nf8JQ9NBs91p6mqWVS2DX92vjKtRfjTgbpb9QsxQZ8MDWHWZM6svlBepe3DOJWntVBAs2w/lP+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079040; c=relaxed/simple;
	bh=G0zmhU1iLu794HmVyNXLwX+Mb88CKrpHGaPhKOFmix0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5T7ee3DgmWqIv2eEVFwxsplVTFeKFKpqrZ/k/XUef4VLMO9GzFrJHeP+rELlhuMfqfFm4sY7e9h3LztmxU4rPKcWLxCO1RRV7FKcIw9Imprj4M6lSPPGc5D7TzkgCOHcVJS11eXhy+KIfTnBvRFEyaTu7L5rHbzkUM+kIyDljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdK8P4SU; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdK8P4SU"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304d8362a58so1425929eec.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 11:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079038; x=1780683838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DRS8HG/oHO794H+uRGaokOiUrHw90s1jfosUOUrSAkY=;
        b=EdK8P4SUZEttyvNy4xiBRfDmq7q2qFy4G2nOKm3HQ2sDmBQS+5/5e3hvsyoje+B9Oo
         vErZ2VQgkIJHL3ikyniSwNJAQrY1aFK9o8jh8a+YRiIhk3ApHR0pXO5cH+pE7tVOX9Mb
         JID7+4J6UGA/A9s1StyVrybi8CjE98r6vMVhErSUpXB68NNrvHq5NDw+HzAdfcNsKgWh
         5t5HC8Rqo7upmW8iMAG/bxCwjEX/UlNDAYah1dSaGTSUezMgDxTavboixJWTKbC77YTl
         BoFqHGnzPhOletgm6KKmza0goUUawD87+t/QhAlb4ZkWpRhLXMfTbJXyO2jJkpEr6xbi
         iTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079038; x=1780683838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRS8HG/oHO794H+uRGaokOiUrHw90s1jfosUOUrSAkY=;
        b=EOvjEBwptfTkEX0WFoENKyYh6PlhBkY6Hs3/JTwlsUZUBMFNAz7CQYYB46qrypOQ5J
         ncFwnwDRNIADsSSPKSKDGfbDoMMa5OoikKXXGIwgkELeyTtG9j1scdhqTkXVYsiqSFpf
         SZk1DPRMNm4tDs6QoywS2HCOCwlxESOaESJiortvIgrl6IVRU7cNGwh1dCNi+ML+fGC5
         5CACb7Lm9O7nMabngnn0U2iIWNiX2McAESZ4hjBN20PpZSVxUKbGlxfR2uyAQc68jp3s
         fyVzCqh/IAbH2Q8kt7P2bqq0LQHjoO97+lLgYxZshLkZSnlEz8sXCGn3zRgC4HKoxwW3
         StSg==
X-Gm-Message-State: AOJu0YyorK3LS8Za46fAY8snYoLJFqNvJuzIBBjJgLTU1r4FZNmUFvjx
	hh7wKLr/1gem8gbcuzazanNfbRKHEPhS7LPD0z2BQYt6VvDfBqB6VUwjgsLrf345
X-Gm-Gg: Acq92OH1QyHa/2Bqr/9TvzhmFEXofGBK4HZZd3GoGI0FB/QQW4QXVwBI9KBespuRrmm
	N3jMb7rFzqoKz9tmieDNru48gTgfY/M0tQG/MiwQ+tG/NYbGJ6jqWIVshEv4S43Y+Ks4364csBa
	6Q5bQcOulRx32+cm6bPI+kgEGfe9eXrhJ/loqFxgTGiMgJzm5pJkPnm+uYejg/QgLXEP739E5TA
	STjJktLCpEUb3HlrYBUw6aflIf9zL60vNfIERpnPkdxvX+We91B/G4vymNfgXeTAinXyrzlILOK
	WXZNtTeyXzWIBHPswn9KYBr9K7CSyDlsSGxQqGiMfGC4UG6Vy1QOcd9WHWGZP+xJOjlguW7EhnI
	beWfReDtvMKCmcF0zJ5Gsc6EUhWtF76G1wvf9JZ/LK0QzB0g9TQoNOc8SIhDsLiT1avXttieMR0
	fVvXWK9T1L5xnUkppj8QvKiT5YyLyDnU8h8SgkMHAGDBDXxQVZLczLBGPu5zDI36f5SPvqcgGKF
	xJbvjQlo6KiYFhHQAM=
X-Received: by 2002:a05:7300:2388:b0:2f4:d190:37bf with SMTP id 5a478bee46e88-304eb1f59aamr1948101eec.16.1780079038106;
        Fri, 29 May 2026 11:23:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cc2c:f0b5:a02d:c0fb? ([2620:10d:c090:500::2:a9e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed30a012sm2155845eec.10.2026.05.29.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:23:57 -0700 (PDT)
Message-ID: <ac73ed389e823187e972df061e8cfe9627fc11f1.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing
 ranges with zero
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 29 May 2026 11:23:56 -0700
In-Reply-To: <20260529085933.A3B101F00893@smtp.kernel.org>
References: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
	 <20260529085933.A3B101F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-29 at 08:59 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] Inconsistent verifier state and bypassed linked register synch=
ronization.
> - [Medium] Missing scalar type check applies zero-comparison workaround t=
o pointer offsets.
> --
>=20
> commit dc22ab232b73a45e1aacc8d291fb5640c3a0d950
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: fork state when comparing sign crossing ranges with zero
>=20
> This commit introduces a workaround for the verifier when evaluating a
> comparison of a sign-crossing scalar against zero. It forks the verifier =
state
> to process negative and non-negative branches separately, restoring preci=
sion
> lost in the cnum-based scalar representation.
>=20
> Link: https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e=
3.camel@gmail.com/T/
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c8d980fdd7099..7998e8da5e554 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -15965,6 +15965,73 @@ static void sync_linked_regs(struct bpf_verifi=
er_env *env, struct bpf_verifier_s
> > +static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
> > +				    struct bpf_insn *insn,
> > +				    struct bpf_reg_state *src_reg,
> > +				    struct bpf_reg_state *dst_reg)
> > +{
> [ ... ]
> > +	if (!is_reg_const(src_reg, is_jmp32) || reg_const_value(src_reg, is_j=
mp32) !=3D 0)
> > +		return 0;
> > +
>=20
> [Severity: Medium]
> Does this code apply the scalar workaround to pointer types?
>=20
> It appears that dst_reg is not checked for SCALAR_VALUE. If dst_reg is a=
=20
> valid pointer with a variable offset (e.g., PTR_TO_MAP_VALUE) that happen=
s=20
> to cross zero, and the program compares it against zero (if (ptr =3D=3D 0=
)),=20
> the verifier might artificially restrict the pointer's offset and fork th=
e state.
>=20
> Since valid pointers are not zero, both forks will follow the fall-throug=
h=20
> path, meaning this doesn't create a safety vulnerability but could lead t=
o=20
> unnecessary state exploration and semantically incorrect behavior. Should=
 we=20
> verify dst_reg->type =3D=3D SCALAR_VALUE here?

Should probably restrict to SCALAR_VALUE.

> > +	bool cross_sign32 =3D is_jmp32 &&
> > +		dst_reg->r32.size < S32_MAX &&
> > +		cnum32_smin(dst_reg->r32) < 0 && cnum32_smax(dst_reg->r32) > 0;
> > +	bool cross_sign64 =3D !is_jmp32 &&
> > +		dst_reg->r64.size < S64_MAX &&
> > +		cnum64_smin(dst_reg->r64) < 0 && cnum64_smax(dst_reg->r64) > 0;
> > +	if (!cross_sign32 && !cross_sign64)
> > +		return 0;
> > +
> > +	fork =3D push_stack(env, env->insn_idx, env->insn_idx, cur->speculati=
ve);
> > +	if (!fork)
> > +		return -ENOMEM;
> > +
> > +	fork_dst_regno =3D swapped ? insn->src_reg : insn->dst_reg;
> > +	fork_dst_reg =3D &fork->frame[fork->curframe]->regs[fork_dst_regno];
> > +	if (is_jmp32) {
> > +		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
> > +		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
> > +	} else {
> > +		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
> > +		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
> > +	}
>=20
> [Severity: Medium]
> Are we leaving dst_reg and fork_dst_reg in an inconsistent state by not
> calling reg_bounds_sync()?
>=20
> Because dst_reg->r32 or r64 are modified directly here without syncing,=
=20
> the bounds are narrowed but var_off and the other bounds remain wide.
>=20
> Additionally, because the dst_reg bounds are forced to be strictly negati=
ve=20
> here, is_branch_taken() later in check_cond_jmp_op() might evaluate=20
> the branch statically (pred =3D=3D 0). If it does, check_cond_jmp_op() wi=
ll=20
> return early and completely bypass sync_linked_regs() for the current bra=
nch.
>=20
> While this makes the verifier strictly more conservative for the linked
> registers (since wider bounds fail faster), it could cause linked registe=
rs
> to lose precision and lead to potential spurious rejections.

Missing reg_bounds_sync() is a good point.

> > +	return 0;
> > +}
