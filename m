Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AF350D74
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330864; cv=pass; b=KJLsSiOPbeoWUwET6TyXlIoE9UKalvMHg6Gyy/GSmr3Yx7wGUN3SgLpTVtXup5cHa/d8GwcbiU7rPfR4Klz6YC7YTUjaKY6APpMtN+v7kQDKcfoLURp6l14SLh5cGYNz94el6QozKW31CIUxTl90cszilPYD/pzeeFPA10c49ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330864; c=relaxed/simple;
	bh=yGW+rfVoYBJACn5bz7D625MSTBsjlPbEBqkQTyAh0S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szTxte+6dxHvIt5RbhpmHJRSfFcrV94DnZwCQFH3kbk5TR9zJtTPJLNwROwHLYmVWZWp7cqQcv3+wcCGbpV4bhBq0RGOuO5AFsJf0WgoFA1HpnDT/md2ifmBPuKM8EJA2YpnyeOQ6SbxF/wGUM+uMtM5M9EXPRqSS0T/yylLI28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA6YQS2c; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA6YQS2c"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fe723ca5e5so15956277b3.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782330861; cv=none;
        d=google.com; s=arc-20240605;
        b=lDbycKhj3c85g3cbvpTFL2I1swlf+PmPIjRuU5sHIjSq6ftcDe/rT1vNplRkJQLoIK
         UNPK+CoAS1/FSLIoCXvc8eetnvIkz7YrwUD+j5G4ox4l/kcC9WwskSscQn0Lej7GMcK7
         frX/VYRuZuj9c5A4ZtKtmtGKvnlmrSaErZrCTSjwctwg/JaOT/8+R6+d4mWYbwZWp4Dm
         90yjSJn+b/JD5R2N2hSCasZX+5sOA7R3fiSb1T2Cf5/zC7dQXIi0voHSGn828/gZK1NU
         g5pjEAvhl2w/QMFhpUkINgtqgQ0UpbV0pLOcOFjHO3I3yUEakUDgQ781zyhosLvEs0/y
         R5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zi8vt2Jkqw/BXMyJ0QyA2n/KwDWooYawhwWLuXdEns=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=hQx4NKCVpprLc5A46uQHYUh4H/qa6qFzahlB1Wr7v/l2/T9WNcZt4wzhxCBq/S5QwG
         v/4SQHThYTEIuCEJhUubKE3I2Fc31nKWctlxHSB+BNdy0O3c/vfClOT1IAuNtacbr1/p
         3UUAc7fYdQKoJ4KHZjYtOD7XtceNj3UsXi0Xh7ne/vINSOfclBqUCxd5WeZct/CIWUKn
         af9MCI8042u+bmYQ+lssSGSUy3CfAE8FQ1mOBimIg2zApe7TE4CW3dbr1cFffUL9vOe+
         FbYlwtMAvwbhJBpGvg/5K1pvr9lGU+CUNeA1OX2sFQn/SI0MZ3ZOhMbpHsLkDHy9qyhG
         5o7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782330861; x=1782935661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zi8vt2Jkqw/BXMyJ0QyA2n/KwDWooYawhwWLuXdEns=;
        b=ZA6YQS2cEhV5VAVwj4YTfMmB3XTuX4RbZYKG6jAbGyYQwtg8SZJ3FcxzZ2Kup9f4TS
         BqtnkjX30IDAEVXpKfFQQrk0tSkhXCcUgixyDiujmKC8uuw+E1SMZV5LLViU+lm+yDmo
         6mQ7+sc3YO+9ugRgYEe0Hw75uuHI6id2xOOBjbtUDPNfz5c4j8yyIq9QoNcZeFdkOHm1
         zXzK3MMjaOSnm3R9BbNx80E/lSb2hkQFOwGHWzkOqs+Hb/5fmM7cbGHsWott9K+rUfrY
         EmEvjTxO6J2sYrxPWgOL9Cp9l8JDgt+WJpeJFXZoRLmgMLOkVMV7tI5f6KSi70uC4tIF
         mTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782330861; x=1782935661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zi8vt2Jkqw/BXMyJ0QyA2n/KwDWooYawhwWLuXdEns=;
        b=Sih3GXfZGEzmdV4BYuaHrASWrwUzk5WdpEwkFvLeeF4S5ggscuonxWkjtGlGRsYG0v
         VoE3F5rRoMB4KeyGANoN2xeahiSgid9rBBCkzUGTxvY8owly5pPcbjgTwQUm0eGWB/T6
         gv89RqGBOyFK+XFpdX1CELTkZGxhUtOxl8qGncn2BLw3xGIxTWIp/gUPIsswWmJFB3Qc
         Rm925Li+O4FuSATpKWC3W/u7qqAHaRmsJ1LmroKNLl/5CERB5/Y9rbQdYi1V1hHwRkK8
         P6EobUaW7ulUeTVL0XO4+CScHGTIDmMSA5JHCV52bavFoyqcqQgQhQ5unvP9sKsIdpKU
         gXww==
X-Gm-Message-State: AOJu0YxDsvxnFkzWJJOGrLW3YcHkETkWgxaRiv+DraCcUT2p3fUFOnGb
	gGwd5B0De2X+WFE1c+kxFUXTl27ctGC3JVK0Vfvtr6JkARppuy5YjzKi5zJjF4dVL1JdYOnkwxS
	yucxZer5Grjtuxb4i4tnZSx5zHP++UHM=
X-Gm-Gg: AfdE7cnIn1zB3d5vdVn4qZnmQPeZktKwtWUXOmZPMCsropJGX7B6qoDknZ7FpqtoC7/
	G3pWOmHz1fKbYDylBdsk6q20pHzH2nwp/m+plxDu90gUaDGf54Z0kCHTTNRKuW4Bjvvd73660eG
	p/V4mSY6pHOH0ok8/fkzz59E4dYVpq3wAAvKt6Qop8NbV3fZ9yZaTJvOTa7ZgJVnx7zKb5CfBXV
	euTgDGKxv9MIv3DkEt+Vl/q4NSXKIouD206ttAq951ZciuCvk99rXg41qGwe8iwOW0IZtwh
X-Received: by 2002:a05:690e:169e:b0:660:5b90:b426 with SMTP id
 956f58d0204a3-6636e53e726mr4172564d50.46.1782330860995; Wed, 24 Jun 2026
 12:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-14-ameryhung@gmail.com>
 <20260623235342.01B1D1F000E9@smtp.kernel.org>
In-Reply-To: <20260623235342.01B1D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 12:54:09 -0700
X-Gm-Features: AVVi8CfmwNMUdiauR6BDPeoAXHl3owOZ2zx-8waBBUKlemLLZK7trk5sd6GrhxQ
Message-ID: <CAMB2axMG5W+48gmPHZ=vgg_LT7YwostYT9NboV=J77XBCEOscQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 13/15] libbpf: Support attaching struct_ops to
 a cgroup
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf_map__attach_cgroup_opts() does not verify that the map has B=
PF_F_LINK set before calling bpf_map_update_elem(), leading to unintended g=
lobal registration of the struct_ops map.
> --
>
> commit 4549a23db01bbdf38f2f884251281fc0a75a8c97
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> Subject: Add bpf_map__attach_cgroup_opts() to attach a struct_ops map to =
a cgroup
>
> This commit introduces bpf_map__attach_cgroup_opts() to allow attaching a
> struct_ops map to a cgroup via a BPF link. It also extends
> bpf_prog_query_opts with a type_id field to select the struct_ops type
> during a BPF_STRUCT_OPS query.
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 1368752aa13c..17f8466e33fa 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
> > @@ -14104,6 +14104,65 @@ struct bpf_link *bpf_map__attach_struct_ops(co=
nst struct bpf_map *map)
> >       return &link->link;
> >  }
> >
> > +struct bpf_link *bpf_map__attach_cgroup_opts(const struct bpf_map *map=
, int cgroup_fd,
> > +                                          const struct bpf_cgroup_opts=
 *opts)
> > +{
> [ ... ]
> > +     link =3D calloc(1, sizeof(*link));
> > +     if (!link)
> > +             return libbpf_err_ptr(-ENOMEM);
> > +
> > +     err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vda=
ta, 0);
>
> [Severity: High]
> Does this function need to verify that the map has the BPF_F_LINK flag
> set before calling bpf_map_update_elem()?
>
> If a user passes a struct_ops map without the BPF_F_LINK flag to
> bpf_map__attach_cgroup_opts(), bpf_map_update_elem() will globally
> register the struct_ops.
>
> The subsequent bpf_link_create() call will then fail because
> BPF_STRUCT_OPS links require BPF_F_LINK. This results in the struct_ops
> remaining globally active on the system despite the API returning an erro=
r.
>

Agree. bpf_map__attach_cgroup_opts() does bpf_map_update_elem() before
bpf_link_create(). For a map without BPF_F_LINK that update takes the
non-link path and registers the struct_ops globally, which can't be
undone once the subsequent bpf_link_create() fails. I'll add an
explicit BPF_F_LINK check.

> > +     if (err && err !=3D -EBUSY) {
> > +             free(link);
> > +             return libbpf_err_ptr(err);
> > +     }
> > +
> > +     link->link.detach =3D bpf_link__detach_struct_ops;
> > +
> > +     fd =3D bpf_link_create(map->fd, cgroup_fd, BPF_STRUCT_OPS, &link_=
create_opts);
> > +     if (fd < 0) {
> > +             free(link);
> > +             return libbpf_err_ptr(fd);
> > +     }
> > +
> > +     link->link.fd =3D fd;
> > +     link->map_fd =3D map->fd;
> > +
> > +     return &link->link;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D13
