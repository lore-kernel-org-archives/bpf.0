Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F250E5AF
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783446; cv=pass; b=uxGM4R5gJ9+E9dEG30/ZBlxFumKIVmHpzYdWFiZG44hChmRR4qSFyKu4lDyQndnBYYTyhgVUFOaRXFrzHPb5HHjxAC+z/tE+MlvJUgFUG3r/twCNRLaxCNZ2qVCL0ahtvRO08YF1lDDM9bZ5n/YoGr6xxkQVqRViqrLP9PILdqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783446; c=relaxed/simple;
	bh=2YckYVvFSikDNqY0ME2QLQTfkSCvtYJWAY4xeMb1qM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irfnUa8mFc6A3lIl09eoPGZ0+VTJd1qO2ozZB0plkrw4tw0BCGOVSqzxfGOZAKSUmaYgiCR+8Jo4ghv0di4zXoty2mp+NRy7ux0Tu8zV9kM1OwLKzFhLQV6IcuPYoiusz5JfAijPoMu/ctvEImrUgnhPnrWMW3leTKf0yo8zdcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1NO+pJD; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1NO+pJD"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so6519825ad.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790783441; cv=none;
        d=google.com; s=arc-20260327;
        b=JKqnm7OEI1pI2Bg+pBaJDSHppk3bJ6K2BlPHl7B3n/sXXDGokMlyCOwEjcQfDi9CKJ
         SdgWTE+sWUHCP+RdGz1weUiJxwQjZs831Ov9vgzoBvaleWJmVw5gCoKRvyz+/Lhy6xhz
         IP30O56WGa953w4KpQn+5ZfrN1RC9e4NZEmXi1RpYs1utm2nYCalYbIUs8Q7aPcEe4AC
         4M1SkEHePZoshojlLORnUbUlPGa/kG2FYRII/Zspl/qjiq3ZyVMrv6fmTos/2o0+Ldn4
         bDbJleyumalaclmO0OBkJcHjn0MNqzTYlRdLiNSEANzcICfeA1DJYgWe6VoDKlc/QL+a
         ybEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBrfV90YO/Lr3Y7Pp3FVqeVQM/bk1jsaULDTqQKal8I=;
        fh=FLd6JgKJC78bvz9uUBQxoN4rjy641h97g+CnETlClq4=;
        b=hH0DG7N5bmp/+vn4OcjxSWcsQgwVS2wHCcN/cNhuMTluNLHbwjg9EvuoZPx1mUosf9
         4I25hevEdlhIk/DXor6Ywhp4nd8LyOubcR7HyPlwQcVE3vwf/3CUf0Hsy7RbhFT6tQfB
         p5dLNMUFkKrV9kdNO9Sta8KaRsptfOeKXXXNpG1RCK/0vbMIgPiKnp60qvn1qVJbNT1V
         /ykmt3SffDjdto6BNVDka7oKWiIiIleZ7+LRdLfo3jSxCZ0aiRDOVx8487DYNhNx7UMt
         37Kg+k6R73rMF5Ryb/W3nxavbfZZirtiRUd9MoZ9fvY1fvJ9g84OlCjD3bsa7+Kb6uFP
         v/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783441; x=1791388241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aBrfV90YO/Lr3Y7Pp3FVqeVQM/bk1jsaULDTqQKal8I=;
        b=r1NO+pJD9kwxT2YLiccNvU5NGtgPL9T6jgYE8T8wvjg5p/w2jyZNypraa+bd42Xu38
         /g9aNN/2onrMD98N2VINIM8b7mvhD92aARZmYC2gjm9hZTQCRDGbKFl4y+ZUuEbSUn9u
         WcRu8ky49MP6Zx7sJMVbbx/DBEw/zfAkJqN3ZkGYb90rWyIcY4JTXpGbofytPYxunpDy
         9a1fI6SSletv2qqxasFGiZ9OVTR6iBH1puztpmu+3Xg3OPaCbugm1r4mRngvy/akYLDX
         CHyE8ZlgeXu0c3tgpHOKv3j+sw1iKEwDfxJQWd3yS54ekoyju2osf8JZ8S4XMUyX+qu4
         nfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783441; x=1791388241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBrfV90YO/Lr3Y7Pp3FVqeVQM/bk1jsaULDTqQKal8I=;
        b=pf55T38zLfVG22fkUU8u/hZW+MFEojzDdkK+NB0wX5nW7xbPkINVwPSD9TZ394BxBL
         YIP5CE00taHvLsxxnJlJXneMfYLpWoxTbhPpbpbpVB9p2f8YolFIjzSnkZ0QL6YwBbGP
         42gIcB8Lpa1KSLzkYuQY/04AHKmVBy+lH+qCblYQ8c9vt8l0AYBRmdh7X3x/3tfQDQVh
         i02duMlKuHNBtPgzYqp8pJZHB6U0BLx+Z5mwFN2joa7X1OKUp9hr1/abFPDaztHaXTsz
         m2noRSHSJf1kiYCvgo5/IdnqM+rkluYs8t57f+2LxO2RW1vaoMOoes6yZMZy1mt3baV1
         dZqA==
X-Gm-Message-State: AFq9FYKU3NY0hVOeTYkEvK538AEtJcicjZUtt14kkc+vQKzzWy24g4kz
	bpewtc8b6/zIZJntlwGkwuuX0MNdioXRW/IuPrGU+oYvEmSxjQUAQzfI7JwG78ACGgMlTVyXNfE
	ikGlaLFYkWGYyjOgf+GXl5K30gsHYBis=
X-Gm-Gg: AYBFou1ClN+8hkImHO7+8/gD6gy6aqxfgtWAvUiTE1rFQjkIe8lULzGbK/mHj5d3jGT
	H2SqvMbycjy5X2lxyx2VeMwuQwHtsOy8g3jFZiKhgt3wPETgzaL1Nj0dLcrPFtp3XmmYF+lg3E8
	1ejtWmPbcDIfUO28C0oYdGqdWe9TL/pW0Ncgz+9Rc3noY/pQ0wTL5EabIDfjiHWiTq8hitiQ8Bm
	KPYDW9z0neLh5TOvMA9d+joMrG2mcb0YWjQWpaejbuvrwutOg3CbqmDHesSAi+EuiuRNf0MPHcO
	h0D7l2x72yNyakD8BQciylW4c/z3t8Pl2DgTB0v0SE6MkHpc9V3Us+aOUEEy9EDxxtV+UGObMBt
	B0AvgacxpOWCzAi/CIp8jwvLHwlZlGq5DOSGuAlbOgWS9Aw==
X-Received: by 2002:a17:903:234c:b0:2dd:c100:7cc1 with SMTP id
 d9443c01a7336-2e2e4a27f5fmr16574075ad.61.1790783441015; Wed, 30 Sep 2026
 08:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzbgkghzOfHJh-A9z=kMn=NaHgr04_DUUrQ63bvHaAsqTg@mail.gmail.com> <CAOu3gNjv_NciUt-UxxmfpyakLzpF2tmu+J34g91gxAkuFMSOfw@mail.gmail.com>
In-Reply-To: <CAOu3gNjv_NciUt-UxxmfpyakLzpF2tmu+J34g91gxAkuFMSOfw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Sep 2026 08:50:28 -0700
X-Gm-Features: AclHuK_l6ykNSHXyeYRmlHjDbilWp3hX2Q4h1T8ofeDqzepSKXq3CoTMutHzu00
Message-ID: <CAEf4BzaCMsHqanDs3LP04p93LcSina=1VY0+gTV+XjZmh6GG=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Version bpf_program__set_autoattach()
 ABI change
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com, 
	linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 7:04=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Thu, Sep 24, 2026 at 7:19=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > bpf_program__set_autoattach()'s return type changed from void to int =
to
> > > let callers observe the new -EINVAL rejection for MANUAL-strategy
> > > programs, but the symbol stayed under its original LIBBPF_1.0.0 node =
in
> > > libbpf.map. Binaries already linked against the old void-returning AB=
I
> > > recorded a request for exactly that symbol@version pair at link time;
> > > without a version bump they would silently start hitting the new
> > > rejection behavior underneath them after a libbpf upgrade.
> > >
> > > Split the symbol via ELF symbol versioning:
> > >
> > >   - bpf_program__set_autoattach_deprecated() keeps the original
> > >     unconditional behavior, bound via COMPAT_VERSION() to the existin=
g
> > >     LIBBPF_1.0.0 node.
> > >   - bpf_program__set_autoattach_v1_8_0() carries the new MANUAL-rejec=
ting
> > >     behavior, bound via DEFAULT_VERSION() to the new LIBBPF_1.8.0 nod=
e.
> > >
> > > Old binaries keep resolving bpf_program__set_autoattach() to the old
> > > behavior at runtime; anything linked against the current headers/map
> > > gets the new int-returning, MANUAL-rejecting behavior. Also adds the
> > > missing __LIBBPF_MARK_DEPRECATED_1_8 gate to libbpf_common.h (only th=
e
> > > 1.0 gate existed) so LIBBPF_DEPRECATED_SINCE(1, 8, ...) can mark the
> > > deprecated variant.
> > >
> > > Assisted-by: Claude:claude-sonnet-5
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c        | 9 ++++++++-
> > >  tools/lib/bpf/libbpf.h        | 6 ++++++
> > >  tools/lib/bpf/libbpf.map      | 2 ++
> > >  tools/lib/bpf/libbpf_common.h | 6 ++++++
> > >  4 files changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 85e1d9c775ab..224fb0247a39 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -9974,7 +9974,14 @@ bool bpf_program__autoattach(const struct bpf_=
program *prog)
> > >         return prog->autoattach;
> > >  }
> > >
> > > -int bpf_program__set_autoattach(struct bpf_program *prog, bool autoa=
ttach)
> > > +COMPAT_VERSION(bpf_program__set_autoattach_deprecated, bpf_program__=
set_autoattach, LIBBPF_1.0.0)
> >
> > no compat stuff, it should be backwards compatible to change return
> > from void to int
>
> I was more worried about legacy binaries dynamiclly linking against
> this risking to somehow getting silently rejected by load_strategy =3D=3D
> BPF_PROG_LOAD_STRATEGY_MANUAL check. But yea, practically this is
> impossible so I will drop this.

from what I understand, changing void -> int return type shouldn't
break even the old binaries compiled against old (void-returning)
definition when dynamically linked against newer libbpf with
int-returning API. so we should be good.

Generally speaking, we try to avoid this COMPAT_VERSION as a plague in
libbpf v1.0+


>
> Andrey
>

[...]
