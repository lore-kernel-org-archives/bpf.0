Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A83C10B8
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720429; cv=pass; b=DhtYFt0l26aBsROwUoD260/BVmJ70UJe1ueD4CI7AZbAMU1m1xJsMINcrWccSHdMk5CyLptbO80kKaKCWvyIvB1bpOVRPxmu0QCiPDDgbs1eD0/Ju7oXV85b9GSRdiBt7wKzQwtOJ5+OrKm5v97O5Qr9bQnfleOsIGa1pc6uO84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720429; c=relaxed/simple;
	bh=11MuPmJZKp7P6An3z5S/ki+AVc8RJ/2v3t7law0viKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjKJIFIXO3UOgifoAylQTygvrEvxdtbPhhs39rmCZmj/b3nw5ZP3TkCykib5b70rRY1WMJTLQpfeRPpBYrfA7SIrLiRBt1I9jcwGsF1b1E0sHLF20U8bvrpSeJEJ9B5k8fmlchGm3uZqdo0cOjJtX0Qds+CcFKo6H4mMMb96cKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5YOdupw; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5YOdupw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so184780a91.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720428; cv=none;
        d=google.com; s=arc-20260327;
        b=re95XHJRqV5yNlcaSa8wpo6y0Y8IK8ryHr68/qbHlyphsaPnSo4P80xdYwOw8585+m
         RWLXV+u7rxuQRTWA05zWQ25A//0pCcF8gdABcqUEKH8A1+CLqSKyhswD8LpyC/p8Y/8V
         iTLt3GZ+f5x+jUMjvtNJNk2IictNNa5Dle4OJHbVdYJoawKG84t/d90xzffFH160KA90
         GvW2uwWGU6T6bix2jiPQ03nhwGlYLwu8BdME+RY38jpsyUyGZzK1+m9rkRDGEt9Jnhok
         ZKGh/Y95IvocLoeOFBE6D5BJb/c+ee3ARg5ZQ6YxMXKkW3gkHL40PRbaKRU6JiZQ5C2f
         S22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1lPM681/F0Zd9+Gz8WdUtiAkD19dEnXD5xoNuwGJ/pw=;
        fh=nMjePTiPkngZLK/mIuIlPDwZGUa9IdD4TLwdvhK83r0=;
        b=aFu3lBY3kqnOj5fCMHzmTkR28nr6UwX3ZzND43kxRghvA6QM01y++LTntzxMxLWNoa
         bsa4ZbHDDTYtZqoxSW9IncXAbD3fxC6yNRZyiIl8NLT6ty/gYuXv7UHW6TzDg/j5q4zV
         TmYan+UKWrVUeYI44CXUY09bdfMD0186Xbqp1ltenzeuE0MCkpp2tYnvEDqehvRi+tgY
         uSKzHrb/5Hcwa8Z4+tFq4VL43nrNtHP5mQw3VjdaBXBquYNrNUPZNTHjqsH7zJ50hc1D
         B6d9a+Np7ItNFDNHuMTZKES/i7bFotE/xnGm/HK4N04V2l5+/P/yo9Pkn5ZoCugRl2IH
         ShLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783720428; x=1784325228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1lPM681/F0Zd9+Gz8WdUtiAkD19dEnXD5xoNuwGJ/pw=;
        b=N5YOdupwIm23GxASmmhBuZfiDqGRGHk8KY3sfKc1TT6du6CqG0pWXTk27pH8XpMZP0
         IZZz/AqB1/O3g1qhaISnrqkMKkncR7ZpyByJyvIUmNVYJ+/2zKZnRA5lT/h5QKOZ55Kp
         igYaAJ+m2K5D82PMi194O75ei5ijkROgblMQCLf9kiui2ZAfynCVgpVh24uqfiTs2uO9
         aKofMGbLPHG30jTLtlrFgUBjolAxLrr7ev+uwpU5s8m3vi1QE612uotCcv3dUUbTiTzB
         Os9MnVTsbn46Ine/WEmqomHNJrGL+HY5ORfA/gzsvsJ11Jv+gQUp0hI/ojda3zwtT5SX
         d9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720428; x=1784325228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lPM681/F0Zd9+Gz8WdUtiAkD19dEnXD5xoNuwGJ/pw=;
        b=rhLwHLZxOl+qLcFc0JO0bgcIZWeP6qV9ar79UfQ/CeX0M68qz6XQ+eKOVrZqKaClFc
         GxIsu+OG0QOJ7r3+cJETu7bkfiFlQIk+IZaQNmdSHOp67IUETWWjO4DRONV3gRqAYiph
         hITz9sKa4dgTTyW6kKmg+wfnlFcli5Yyu39ts22zsaTJ3WjXG68MBHB/UjQ7LqL6SHfX
         zlk+3cAdzxXpRMsppncHLd3SzHNIUlPwQk32uZraCVmNC6ORvMxaIE7EzFlOivu5rOhP
         jQkFrL6Ufc6aZs7YtzGFPSrg7nTN+EoPbyKX7n5UWNkv2ss/o8h2VfZSyme7kzmxTZ8/
         HJ8w==
X-Forwarded-Encrypted: i=1; AHgh+RqK1lTMR/24IMRdDcHvkIU5JclXedeGBSWoLrPgxCRnN6Yq0EC0hOlIzNLW2vXkChBFbM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqkn1O0J3OIib2R3fYWzTvl1koin+sbQ2nrIX/gTdoi4ep2jZo
	x6XpjlnlKb0Cy7Q0K1Z9vibgTnnfo9coMpO7XP/8RMybruW8KkG8ZrY93wJSQe4ThE9NBCIWcOU
	30EpvM6oXbjdBR8WDsIE3kDDu80IrZ6TR4VMe
X-Gm-Gg: AfdE7cmt5pMlrlcezj5hP0+JoHWByJKX4igVCTd97iRXumYxh+DuumgHP81Yowv4V0E
	jBFDDMZX4YEJfnJjVzG8HVHsfv3uota3/ky0F0kp0wJxROTJX3sYziF+LvZ2Qq2i5MZ5GOc1kUZ
	7SyBd+AuDrofldXX0qRlSEWpK+GgBGgPK7XmFKi1C9OSWWgCqO5Lhvc16Hl51Bf6b2vRRh9Ez9G
	u9XNVEtpFB6oBD88+C6zhJc+AhoVM4Nzff0RMYYRgFK5uzpR0KABVBhvIvNq6/roUCnLxsbGf0L
	3JN9Ni373mXEm+x6dVQ+tKqNQwAL00N3F7cAFxDApfrF6lyekSahj3AEhU9aK7Ri
X-Received: by 2002:a17:90b:4b01:b0:37f:9ce0:af32 with SMTP id
 98e67ed59e1d1-38dc7b7bf56mr540855a91.29.1783720427703; Fri, 10 Jul 2026
 14:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178345549172.94179.7948304165383170781@digiscrypt.com> <20260707203352.97EDE1F000E9@smtp.kernel.org>
In-Reply-To: <20260707203352.97EDE1F000E9@smtp.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 14:53:34 -0700
X-Gm-Features: AVVi8Cd52ZVu6AqJOCRcj6EDOi1eaBLzp91fUWkkr2lJrwGsornZjA1xUYv5e3c
Message-ID: <CAEf4BzbBqysGiHFuEW0b+tg6uA-gv4s8gGCeF_QZ-L3nhDc8yA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix double-free of distilled base BTF on .BTF.ext
 parse error
To: sashiko-reviews@lists.linux.dev
Cc: Naveed Khan <naveed@digiscrypt.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 1:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] btf_parse_elf() incorrectly uses IS_ERR() to check the return va=
lue of the public API btf_ext__new(), rendering the error path and the patc=
hed double-free fix unreachable.
> - [High] In `btf_parse_elf`, the out-parameter `btf_ext` is not initializ=
ed to `NULL` at the beginning of the function. If the function fails early,=
 the error path reads the uninitialized pointer from the caller and passes =
it to `btf_ext__free()`, causing a crash.
> --
>
> --- Patch [1]: [PATCH] libbpf: fix double-free of distilled base BTF on .=
BTF.ext parse error ---
> commit 343ec621fb0622b822c4fef99c23ee0947343232
> Author: Naveed Khan <naveed@digiscrypt.com>
> Subject: libbpf: fix double-free of distilled base BTF on .BTF.ext parse =
error
>
> This patch fixes a double-free in the error path of btf_parse_elf(). By
> deferring the ownership transfer of the distilled base BTF until after
> .BTF.ext is parsed successfully, it ensures the base BTF is freed exactly
> once on failure.
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 823bce895178d..35695f33c6942 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> [ ... ]
> > @@ -1530,6 +1527,9 @@ static struct btf *btf_parse_elf(const char *path=
, struct btf *base_btf,
> >       } else if (btf_ext) {
>
> [Severity: High]
> This isn't a bug introduced by this patch, but immediately before this
> else-if block, btf_ext__new() is called and checked using IS_ERR():
>
>         *btf_ext =3D btf_ext__new(secs.btf_ext_data->d_buf, secs.btf_ext_=
data->d_size);
>         if (IS_ERR(*btf_ext)) {
>                 err =3D PTR_ERR(*btf_ext);
>                 goto done;
>         }
>
> Since btf_ext__new() is a public libbpf API, doesn't it return NULL on
> error rather than an ERR_PTR?
>
> If IS_ERR(NULL) is false, the error path is never taken for malformed
> .BTF.ext sections. Does this effectively make the double-free issue
> that this patch fixes structurally unreachable?

this is a bug in existing code, IS_ERR() shouldn't be used, I fixed
this up while applying as well.

>
> >               *btf_ext =3D NULL;
> >       }
> > +
> > +     if (dist_base_btf)
> > +             btf->owns_base =3D true;
> >  done:
> >       if (elf)
> >               elf_end(elf);
>
> [Severity: High]
> This is a pre-existing issue, but I have a question about the cleanup
> path below this done label:
>
>         if (btf_ext)
>                 btf_ext__free(*btf_ext);
>
> If a caller provides an uninitialized pointer (e.g., struct btf_ext *ext;
> btf__parse_elf(path, &ext);) and btf_parse_elf() fails early,
> isn't the out-parameter *btf_ext left uninitialized?
>
> Could this cause btf_ext__free() to read uninitialized memory from the
> caller's stack and crash? Should *btf_ext be initialized to NULL at the
> beginning of btf_parse_elf()?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178345549172.9417=
9.7948304165383170781@digiscrypt.com?part=3D1
>
