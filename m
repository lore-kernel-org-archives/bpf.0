Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013F1FBC8C
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787451369; cv=pass; b=C6n7UnKpCiMqmSvnAmdtlv2UAWBY3C3jgd31Po1DwFlj4RaHv1YD3vc690+WN/F2tcvO7iMO8+nzNzmCAvc4Fgum8r52/IJ0M7bEN2dh2i4BYwSHmmD7U1U7GxwFH5tBbezBRCt8F1AM0BxCnZGfHdzwclccYrylGwRRc4/rkpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787451369; c=relaxed/simple;
	bh=C8Hi7dx4Dz9qbEIsmQHMoCO9ghAgOYPYVPNCRQu1bd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwMxK+VJ9+XNHwK6lTUv4i5on7XUzMf9CEB2rxFBg6an6JuTV/53SyQ9p6S6j6DXHA9EA2mZPlOdVi/4JBsmmtMP7ZFAG79JQEnQeZmBeJlVTYbjqxEgrBHXQ8wnT/am+UFD9pYsav6OoKRmJlBvdi/2KAGGNSbOGo0Ivct3Z2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qARIt5nD; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qARIt5nD"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c167aa9500dso350390066b.3
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 19:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787451366; cv=none;
        d=google.com; s=arc-20260327;
        b=R7FH2arrHlE/MohOgvraY0Ecvt44apr1y57oKP2O7y3Od+X0Bnpr5ZQxpKcr0WIoQE
         EyQQcOIeqqU2Hw/aELGlXV7gJk5SjmspdKLYtXPJoRoJKD0UE//3ipiQgV+/8ytDdv0V
         I+rYNP3yMiH6OE4BtmOJ2jtx17nJm9Nu0/n9sbiNHktNT90omc6qIH6BHjeXe1FFHFMH
         L03HH/eGred2xYwWzM7/uNIvU8l4Oq+gAG5yVTtnDO9b1KjsFVtiOjiIEC1Cb9tVL4Cj
         YO8CddoPZJoWRa4Aw7EgoszQYTAEPH0fkoqfUU5AFor4wt2uE8oT3bljVsTjXbXHxXAC
         /OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZkGg/kOEabPgE6XFQkogcC3pK/J2kIC827u/rRa1r8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Ygx6eJ6OnwHnKU22s//18qfxvwh5UMBv36Fbrasn/0z0xVe+vLkO0Pfu6jTsdIshDQ
         IhBwa+vm6sQWwIkbEXn5OS4UwqsMZb7bR9BFC+wFxhTWl0xwVf8pErrUthvaLREzIq3z
         qyV1bg3yTdXjALZpMO/Fmr7WcQdp7zwU2c5PPYfE1G9YvzOvvKxz8AkqdmLBq9PJZxNH
         v1SdCZght/6b+IJFI5hKX4zh+lbEPDwVeWgpLMugq97Iv7q7rq/shEZQCIEvdZARvD14
         jG/hA5E6HKAe/a5RCe/uVvRrk5kKaUbXfQxI2Z9qcQWdNh6PMnBlEoxktoit6+/AxvtA
         J0GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787451366; x=1788056166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SZkGg/kOEabPgE6XFQkogcC3pK/J2kIC827u/rRa1r8=;
        b=qARIt5nDwmJ2ojsAfEUn0kD5StBRjegdWM/h2YU/0vMG+lGZ0sXmbm1rjnhMgyVTyT
         QD8nd9iFZjoHuU3d+0NQizIb4DTpdxf11GLj3mxn7mEsxCnhzaRQclV7lrvAIjqmZUE2
         IK4U8PUW0XMAbGT/exZfy7M8hjv+fcgN3dgRGs2eFfAnlb59nD5SdB/1JfFoL9psGMdP
         6sEQbXysPC/GmD9NtmC3KT9b6Eqba0aZy4gv6rG7jWARHF46O2z6PqFqrYXz+XEvSwli
         1kgBjscUF7yb4KWWtA6KyGUmE+h9QSj4Nc0SZUSd+/xrmaA+iPsK44enz1jUah2kzlcs
         75EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787451366; x=1788056166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZkGg/kOEabPgE6XFQkogcC3pK/J2kIC827u/rRa1r8=;
        b=qAACg1ou8IGEBBG+se9bSqJWYAud7P/d7u9mr6fPlxJDe3ql1UYPtxdNlby837sUA1
         phb/j8QAK/yvSA7rZlajQQM9jhCk9NCop90t7ZxP5YnKtc4TGSFJeGn6hXoJNAJY+08n
         /j6ZMR52nPFs4XE+4hsQDRibasE5+AlMjc88fpizWby0q2LBCIiTbdsGuursKLJIbqZ4
         A/xeRpN42gTlNUqyzZrvF1tzB7iN9P+5DCe7UCBIzZ9vjog5cA39ZJcTV53HjJ9bFuAy
         MrtTAl3iMTSojuGtHCoVT9aAGmQJECi16jgL9KhWavrZbku56FvEE04VnxfpxPOod4Lb
         /5iQ==
X-Gm-Message-State: AFuF++kxfIIfm38Zw5rQB9fy4k+XP8nQ+AruDC32RrrFh4LW/OaDRJbO
	JcqtOxpuRudQ6J1gepBQ/19pvK2EHHmAtFS/5WqJwmKGD38WajZJKkvRcFb0dmSsseYGdbvPFdn
	sj6l6QEdrtbACWsJVwxU0SM1rl8xwcdI=
X-Gm-Gg: AR+sD13jfAphA6/ssckJLi/vIC5JsTGHgTJJKwUHt4+0n3qtBB41htKLjrUaIxRcEIz
	J6zvoGO8VJb85Xnut61sWK6bKdAEyxJrR4XimwnhfsfJGxhuki3Lx5zLIHaZWb+VqMZo2Mx2t5C
	nwLt87X7MdBvy2nEQBwyoyqMPXt4WBEF8ZolyhOYZoJG5Z09qSPSp+Oeoq4R7vR28vi0btFLpvw
	plzNljBpjMoWpOiIbrbbqg4zWVueiNzeSRizVhDfeZRulxAvJobTr7lG6wYxgmhfHA3Y504p8Sl
	UfT4omBq9o24foAJAiyEVMgPvfxF+BRLc7xYp4bcx+ZHGYmphpAG6H/Va+6idProdpk0ZwrFuU1
	+
X-Received: by 2002:a17:907:9346:b0:c1a:5d49:f99d with SMTP id
 a640c23a62f3a-c246a3ab4c2mr2034017966b.7.1787451365510; Sat, 22 Aug 2026
 19:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823010900.1730708-1-nickolay.lysenko@gmail.com>
 <20260823010900.1730708-4-nickolay.lysenko@gmail.com> <20260823011851.0213D1F000E9@smtp.kernel.org>
In-Reply-To: <20260823011851.0213D1F000E9@smtp.kernel.org>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Sat, 22 Aug 2026 19:15:53 -0700
X-Gm-Features: AcwNN1V8XOzF03yXekhbA-aQZ_JhNkIvdx3R7Ce_2bgQP3RqOFMq2LFBYypxT_g
Message-ID: <CAMtxOX3MwTE7C4nMdEpR1T16BX8L4TYRFc2uuk=RROXWJB7LBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/9] selftests/bpf: factor the permissive-mode
 skip suffix into a helper
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same finding as on v5 3/8, refuted there with a minimal Makefile:
https://lore.kernel.org/bpf/CAMtxOX3f-u0cnDiXuHyxUuiMWwosC9sj3xmTDy-ATaFAKu=
X4RA@mail.gmail.com/

On Sat, Aug 22, 2026 at 6:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Missing space in the SKIP message for the LINK step causes merged=
 text output.
> --
>
> --- Patch [3]: [PATCH bpf-next v6 3/9] selftests/bpf: factor the permissi=
ve-mode skip suffix into a helper ---
> commit 0c0b26d03c8f590d99a07e3db037b9c093922751
> Author: Mykola Lysenko <nickolay.lysenko@gmail.com>
>
> selftests/bpf: factor the permissive-mode skip suffix into a helper
>
> With BPF_STRICT_BUILD=3D0, eleven recipes append the same tail. This patc=
h
> factors the tail into skip_on_fail, parameterized by the SKIP tag, option=
al
> extra files to remove, and an optional note. Every call site is intended =
to
> keep its exact message and behavior.
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 8d71345c2e86c..04eea6ebc75cd 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -48,6 +48,14 @@ SKIP_CRYPTO        ?=3D
> >  BPF_STRICT_BUILD ?=3D 1
> >  PERMISSIVE :=3D $(filter 0,$(BPF_STRICT_BUILD))
> >
> > +# Permissive-mode recipe suffix: on failure, remove the target, emit a
> > +# SKIP marker and report success so the rest of the build continues.
> > +# $(1) - SKIP tag (BPF, TEST, BENCH, SKEL, LINK, ...)
> > +# $(2) - optional extra files to remove alongside the target
> > +# $(3) - optional note appended to the SKIP message
> > +skip_on_fail =3D $(if $(PERMISSIVE),|| { $(RM) $@ $(2); \
> > +     printf '  %-12s %s\n' 'SKIP-$(1)' '$(notdir $@)$(if $(3), $(3))' =
1>&2; })
>
> [Severity: Low]
> Does this formatting behave exactly as intended when the note is appended=
?
>
> Because GNU Make strips the leading space after the comma in the then-par=
t
> of the $(if) function, it appears that $(if $(3), $(3)) will strip the
> leading space.
>
> Would this result in appending the note directly to the target name witho=
ut
> any whitespace separation?
>
> [ ... ]
>
> > @@ -1018,8 +1008,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
> >                $(OUTPUT)/usdt_2.o \
> >                #
> >       $(call msg,BINARY,,$@)
> > -     $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@ $(if $(PERMISSIVE),|| \
> > -             ($(RM) $@; printf '  %-12s %s\n' 'SKIP-LINK' '$(notdir $@=
) (some benchmarks may have been skipped)' 1>&2))
> > +     $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@ $(call skip_on_fail,LINK,,(some benchmarks may have been skipped))
>
> [Severity: Low]
> When this build fails in permissive mode on the bench target, the
> skip_on_fail macro is called with the note as the third argument.
>
> With the space-stripping behavior above, won't this result in the SKIP
> message being formatted incorrectly as:
>
> bench(some benchmarks may have been skipped)
>
> instead of the previous behavior:
>
> bench (some benchmarks may have been skipped)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823010900.17=
30708-1-nickolay.lysenko@gmail.com?part=3D3
