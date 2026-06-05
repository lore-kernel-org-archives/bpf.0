Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D63E9580
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689584; cv=pass; b=dUCQm8UcNLEvXROhNJ7r+ty1uAXUOZDB3bhOzVa5FEDXI6EINvk4joHEMJF71icXivN2BYPH8ChAzdKL4hS3FX+hzzXjPkBhMCYkILmRand92pmRf7q+xaKf7hO7SRqXkqH8m1pVO6NO3GqfhiYQCzHAy1Q8indIRVKJswOasAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689584; c=relaxed/simple;
	bh=1bbslR6O7pAnfgONfzpWzoKVocFLZxHaQJqgfgdo41c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIz3+nK2lYqr1NarB+AsgsRDWSysw6KeOtDyW2pkMcobGvyPBgiXeX1Wc8wIXXlj2EpjMCEbxfBlaYTnvjBn97iUMmTwQpN33livdobhCaZbicIuqqS+aV8qomCGzEa4i/gJG4Fp/zXKXULJMmpIWhzJbTPOhcwVl6bq3I6IFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6w6JMuK; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6w6JMuK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e0b3db3499so17833877b3.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 12:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689582; cv=none;
        d=google.com; s=arc-20240605;
        b=MrZw031trqwJr32KYHrAeYMdVNGHdWKGh3MzWUxMVPhfVuYslQqMHWTgwKzYkQsU4V
         UY39qoMM+Vl9KGvAQFUK6BkSz/WCv4eYhRo62rRI1wRiM2t85nOaiIJ2bZsRvnSB2NQl
         dT9ZWVJAafFVTABl+UEXvuq8gsJdN4SYDBqWwdt5v0RlJ5aSWwzhzLX5XrVUFEoDsXwH
         0lOcR2s6i8odNBHmxMjN5VE3hQgkZstctzLdnM9XSDkfc5ejt2+LSUZIxTceIUMsgdRY
         nMHjeAB8gzAO/UyQb4R9fWVvwZlXAoSXXlnL+j/0ezyx5L6G5RQHq9hfGputZl1To0Xo
         1jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=ibfoYRZlWIPWrmvNbnwRccBb4Aw1WdMqfZCqs/ZBUnifsNBuyIJvBUUv9+qP3+NNQD
         FalH7thafgfR5Oi+KAPs5Ubyn4g+qGnPf4R96ahrFaxoUrBGNawlnLxZR8KOaUccYy7X
         nrgReX91GZzDG2Eo4OEih2QGzk3BqqYLaPOdKvJ4vmIk5AZLPxJrlY0o7h0ODu/iY3yD
         E9hZOseeHZXk62bm3jM473q5gQm44KY87OSpbPf6+pxH2/pOY5aMRXsNVAk/wyDTF4CV
         jOBS3JEMHPR+Nqzpr88MtB3uUaiiv+EfTofxm/CKPraC2pN+YK4drRugvo/jYecmRxjc
         j0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689582; x=1781294382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        b=Z6w6JMuKeg8X1C+mFugaS7MnhgVD401g44vC/MfvMhB5jvspHTuqv+zFPt7YQ9uGcQ
         G1Zcg1Q8UVvtXBvf3ruefoINCAYipU050KcbUc0DSPdWH7j3zhh6S82SIzm0388so+xz
         BC4gqze4qAqkWhpCB0pVmNFNObpXqyolUMfpifnigChTbr60CkuHoy9DD6RAoOhw/jSE
         HTXD5R/3BeAfmaw44sj4CPhCJVeLELY1Bjb+CVyES/eOTHe90FpTcNymY+TXOwpm9tML
         CFt10TH5wE6Fj4n1garGjN8bNoGCtcE2H/wM9/LWQh+/7LUyUGtvC49E1RHBmoBX2sRt
         qiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689582; x=1781294382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctdYFil8k1KSTdKhmfPPRD50Fe9swriPVxWQulSiEeE=;
        b=VkBfIQv5sqKbURy2GjxN+aD7KPz8eNCjFeIn2MrB11QU6RZKPqZ8Fii2cHnEypMILM
         4+TVNplD6RB31BCFKoCVMJJa5gmB6RjMdByPsu/1YWPKwdRxRUqXURpTdABqJ6uy9wyI
         vrhG4/eInUzHk6LqBXNvtxiy7GfSgtqkKl87BNHLSJ3hfDUJQlZ0jO0ZrumV+7UveDOI
         ipWru05OmAuzntO0ACy6pjMNliXxAGKxOwMkgFdyv4sEisFVJ5pv3N1bahOIIIn2jslf
         p2wKAGnPCcmdVCVz46ugaRhvsZgSpPmmSmkuqVVD/IR+bb/lnfc+5QD/DBo/SbFIT0e0
         zhyw==
X-Gm-Message-State: AOJu0YxePzLMmV3UEa1hF3g5Bg8dD+Ajb8lCqjkjrgsw4kG/GZUZnfUW
	K0/L7uE1E9Xg2JgZnVyGaLX8hV6jlx01b+n74qF28h7TDeUN0lIUwLpwun7C/rxAT7FREufHOY+
	2qIS/+EfNbp+P2xr0vSEITGv4MLn+UqU=
X-Gm-Gg: Acq92OHRAfKmGwVu9aMOnFhPk3SoB47VBRJaEUWA7bSmt/PmYeeRyxfLD0zbKPJdhYJ
	CvDTUwT/scH6T/Op/xgVyDHZIH/FmMqO8+63Ey0KU7+96j6wiYddikKvhX+mFL9EwHlt++P7JV3
	q+RRuGsG63tMBw8n+jqaJ36SK5wmsGODxuYM3QKNBMbNqfCnVZF/1TEAd5LhTCCQVLSzqEluZzy
	emfSNpE7Ai0NfLMgOL4y8C2O4mgIGvNPl5lmDMgQD4GmWdboZPcenn498VbgrGuFWHcp7R1Q/i5
	KUDLdLqWYHGCXoaRI2mcdmKT0PFCl9grQQ==
X-Received: by 2002:a05:690c:4907:b0:7dc:aa85:5c67 with SMTP id
 00721157ae682-7ed0a9d67dfmr55745037b3.11.1780689581972; Fri, 05 Jun 2026
 12:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605183551.969144-3-ameryhung@gmail.com> <e267e030d9e626dd07af109d4bb866bcd31e034c2041fcf324033591b582bb81@mail.kernel.org>
In-Reply-To: <e267e030d9e626dd07af109d4bb866bcd31e034c2041fcf324033591b582bb81@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 12:59:29 -0700
X-Gm-Features: AVHnY4LmfmkXkfCsZ32Q0qVybvOCxkFOL30jSEf-h-BGFSAM8mzBeTzfUW4ORQU
Message-ID: <CAMB2axOZQjFEP3732DCfyBAyOQU0PaA55GdRZ54E430jzMhLNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error for
 "__ref" struct_ops arguments
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a741bf447931..5a69af569089 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18363,9 +18363,15 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >
> >       /* Acquire references for struct_ops program arguments tagged wit=
h "__ref" */
> >       if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) =
{
> > -             for (i =3D 0; i < aux->ctx_arg_info_size; i++)
> > -                     aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info=
[i].refcounted ?
> > -                                                   acquire_reference(e=
nv, 0, 0) : 0;
> > +             for (i =3D 0; i < aux->ctx_arg_info_size; i++) {
> > +                     int id;
> > +
> > +                     id =3D aux->ctx_arg_info[i].refcounted ? acquire_=
reference(env, 0, 0) : 0;
> > +                     if (id < 0)
> > +                             return id;
>
> Does this direct return bypass the cleanup path and leak env->cur_state?
>
> Earlier in do_check_common(), env->cur_state is allocated via kzalloc_obj=
().
> Other error paths in this function set the return variable and jump to th=
e
> out label to call free_states(env) for proper cleanup.
>
> Should this be updated to set ret =3D id and goto out instead of returnin=
g
> directly?
>

Yes. Will fix it and resend.

> > +
> > +                     aux->ctx_arg_info[i].ref_id =3D id;
> > +             }
> >       }
> >
> >       ret =3D do_check(env);
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270340=
08594
