Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6431D95A3
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082801; cv=none; b=eGSO4dXWovbtSYnF85kiXgCSAqunWiMyEWh88kWm/OQm6W7O3dZY2qxfpbIAp6XDEkG6DijPOX5bdnA1/ERyLjWAjtaax7wGjYPdod+m2StmZ8mQ5DFGXWlRyy2Gkx9T47eSad+oy0JO3XypuP2z6UoNGsFZnUtCPynEnnJIcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082801; c=relaxed/simple;
	bh=3K+j+tWWlvLsw7KDwLdtMOZyU+LPAoX9BbZndSzhAQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1FGUZuFbScRtgTX7ZAYZ4PPvj5396sHTZ/L496Qxsq/TmHmJbVvnHkmy5RqSMRq3qc/Y1akc44YAXhpbZzQ+wuo3vcmPtlFsgezX4fLJIMzhhe6bDYuxTFHIq8O36NthWdeZUiT9N+mYgMNjkxgUvxrOuXzLgwCyLwzeiCCCTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sF10GIDY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sF10GIDY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d58efc7356so2706605ad.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787082799; x=1787687599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L0gjxz3MBBQueA2z90aXk+bKqQ2ObhgjQRJ3ydnnQcs=;
        b=sF10GIDYa8UP6r6SkixsgoEkGm+4UqX0w7y4m/SZxbTvOcyjK0KaFEtcutSPGrbCs3
         pMRBk1+x1PdRaNAEv76oMbeUh4o5OkojZxxmungGf7HAc/J2/AaS7nFWp7tcW39lwXtw
         5zOws9/DW0NhucnFta8zYj3DAO88boHe4EwWWqSeCM5w24pvi0RNFTmjLWmL8daTkjrb
         +RKvUXAbBh1X6Sg4DXaSMe3nQCY72Nn5xyZcVjScdcCTQ/rpzXCn6s794G50Xj5jGjp0
         M1dnx1Am7UZ9Cq5zQfJbdPW/0MWhDffeb5rvHK98IeF6PhR6Bz+GekLG7PYcvS4+O3ds
         puVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082799; x=1787687599;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L0gjxz3MBBQueA2z90aXk+bKqQ2ObhgjQRJ3ydnnQcs=;
        b=A4g0a+HFKJcsLs9nSjxlfb71KVBrlEBOaBmL3uGPZg19E1H6Onn0+S7Et6OAjHLpLK
         9pkOwfkshVrLVsZIC5ti5zq65m7b5HoFeo9c7NB9jhzd20gnonnz1w3869WgqVhnV+GM
         WZdFyDjjX4sCukA/ampyvO5ibzkMH/O3l11Sd6KfennJWmdMxGhr8PbOZNz8mkgFf3rk
         sClqdMr/mLMx57f+rK8EyQmSQajXhVssWc64twsQ++WFguf5ScuMGZeMDNON2i1ctdLC
         Cg7IzbIEaNjkYzD+w5P96hNsHO85LbWEZa3cNe7JqsU+Q2Ax55ivwnOlOG4xL+Z0feqo
         PKZg==
X-Forwarded-Encrypted: i=1; AHgh+RplDtaGTG2xj0aDBxunpT6QsjqL2YRDapHMeI4FG4o9sfZtuZSRjcE9vY3lh3+7K60nVgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhABMl6V1T0o0Rr93w2vfmCWZLqHFWPl0ol/SQ/uyqrtrMERa
	znW89t1Ywxt1X6Vogw7O1IZhE7iHNqWZh/eZ40wv6dhEzwHcxZ0CRTIBfULvYEEjF/0=
X-Gm-Gg: AR+sD10txea9y7ub7/X4oW9F+fateUU/0bvtQLi+ahXMlE/KwQHt95AKSiocJ1TiYgd
	LK0ewFrx3SxzUKi4egpiQ1IoK5SB9w2ZwID5H0lfPJ3j8DpH2LXXlLRXXe3YlKwF0qJEYLY6BY8
	t2HVIYQJvIfd08U2hIXCESLk9QjWbEioqw+WUQ5HZLq1qz/VaMykgvM/3Keq+mshGkMycJa0MP4
	HENSgLb9izG+7UenOqHwkPcIqTThr0sieKow2QVW9VCcn65rWTYm2xGny7+zOu+P0o5MkNCx56R
	JfHvxro5rTNd8jTODBTA5wiBD0tmYUERVTkxTny02FNNkqnqdIOddLfdNHOrBcAz3an1JJxqW/N
	A7iw95Oamx8O7lrryTwRgZeUu4d6wFpK/pYlGRgeVrufPrPj+NAmP8d8IDIRsqYw6iK/ShP314m
	zkW8NzRc2kJWO8b+V6NMJjAguwRw5lSQGJLGFjF03g5buBscGCnsAs6IPmEFapH5vAxzN28MMZq
	g58RVe9LzN9n6U1s+yE2FwBDdA=
X-Received: by 2002:a17:903:17c5:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d5f6cbe0b1mr3396925ad.4.1787082799052;
        Tue, 18 Aug 2026 12:53:19 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ef9b3esm17915425ad.79.2026.08.18.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:53:18 -0700 (PDT)
Message-ID: <dfb4d201de87590bbca4663ede19fd6c4044035a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 02/10] bpf: Add helpers to describe the
 R0:R2 return register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 18 Aug 2026 12:53:15 -0700
In-Reply-To: <b8ef4589e63fb411f830f426eb4890901e99f30c.camel@gmail.com>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
		 <20260817042151.2286855-1-yonghong.song@linux.dev>
	 <b8ef4589e63fb411f830f426eb4890901e99f30c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-18 at 12:51 -0700, Eduard Zingerman wrote:
> On Sun, 2026-08-16 at 21:21 -0700, Yonghong Song wrote:
>=20
> ...
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b3c474ba7140..f1f1268d29c6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -385,27 +385,70 @@ bool bpf_subprog_is_global(const struct bpf_verif=
ier_env *env, int subprog)
>=20
> ...
>=20
> > +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> > +{
> > +	const struct btf *btf =3D env->prog->aux->btf;
> > +	const struct btf_type *type;
> > +	int subprog;
> > +	u32 size;
> > +
> > +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux=
))
> > +		return 0;
> > +
> > +	/*
> > +	 * Skip the main program: its return value is the program's exit code=
,
> > +	 * read out of R0, so it never uses the register pair. An extension d=
oes
> > +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
> > +	 * refuses to replace a function returning more than 8 bytes.
> > +	 */
> > +	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {
> > +		type =3D subprog_ret_type(env, subprog);
> > +		/*
> > +		 * This runs before btf_validate_return_type(), so apply the same
> > +		 * type filter here.
> > +		 */
> > +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type))=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
> I still think that only !type check is necessary here:

Actually: if (!type || !btf_type_is_void(type)) ...
since btf_resolve_size() does not like void.

> - btf_resolve_size can handle any type
> - BTF validation should guarantee that return type is not e.g. BTF_KIND_V=
AR
> =C2=A0 that would trigger -EINVAL
> - for local subprograms verifier checks if r0/r2 bear compatible types an=
yway
> - for global subprograms BTF compliance is enforced.
>=20
> Could you please explain why would you want to keep it here?
>=20
> > +			continue;
> > +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
> > +				=C2=A0=C2=A0=C2=A0 "cannot size return type of subprog %d", subpro=
g))
> > +			return -EFAULT;
> > +		if (ret_regs_cnt(size) > 1) {
> > +			subprog_info(env, subprog)->ret_reg_pair =3D true;
> > +			env->prog->jit_required =3D 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0const char *bpf_subprog_name(const struct bpf_verifier_env *env, =
int subprog)
