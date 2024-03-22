Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C484376
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066647; cv=none; b=g8GtT4puaUErGQ20WnTx1ZQGBF4Be81QFgVzv/eQgVv1U7psh5vRDI5sR0mFpNBzC4wKr6aR/ZWf1ZEXApBy6sC3pqVvY5Fa8RiDPWfaJ4lhp9W9CnYEkSpaA9wfS6CuVhYycPoJgc7foqRgP3RTl+DeCA61k2V0KsPvBcRdOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066647; c=relaxed/simple;
	bh=uTd1EN278H1nPpevzGrQZ/oimkzTziOrhI062sQp4PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6VfL6VwXr3NyA/pryhGmfoMhcz3M5H6oGrTk1cnAe3SVto1x6ErNcUM7UHjHgtbB/4JZFtqFhaK+lKIvuTay5OCR0x663FYxYCVHpxDtRVyENTQN5Adi+JFiLd1iiQqc/o/Pl+blf9VsA9hom78gGMgMCea835NpMN1md54Koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeN3qhOr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeN3qhOr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so1101780a91.0
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711066645; x=1711671445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/n3Nxb++oIros5hOkqhPSO/W6MqX9cpwwv03nag91I=;
        b=OeN3qhOrlBGPpEsZHtxqgAmpTcZVk34V5mbrBvek1LxjwJFxGC9TE6tQ4codNoQnQN
         3OUT2YgLyYaCNe4HvO32CKxTwxpJdsepEwnijfshG8L5aAHext+uQ4zYdOuvApwbJi/y
         vYHZ546xPMLpG0AYTQg95o55J4unFzmcTbmIkmgovYwTxZb9TcJJlGYWMQO6JMkSw8Ei
         xbYADwT0kqLQlZf/WokQ+sZbN4qQClR1hzbAatN+nHSjiceMOZfnlEvQjJ4Jj1fnQ4xh
         Vt0ZEJOV8FxWFD82GdqemhgoYDQOb/eT5ubSRqlwTm4YaS1lQwydmGd4Hh/gWiUQ5qqe
         nL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711066645; x=1711671445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/n3Nxb++oIros5hOkqhPSO/W6MqX9cpwwv03nag91I=;
        b=Ea8I4P7U5osEEzlSmP1yQ2enXL4NVnk7DQT/aIoN4bx2JVeXGOMHLKH4AvnCXwnJOr
         /bPlQU61w1SvqMMuChS0jBenR33+B4VqSnIhn+in5AGUZ22IMGRS8xFrhYPneHYa0GR+
         rz2LblcUqrQvDnyQo0cENs4pbH6SbQBgfUtYQ4y0uoaiw+vz6Aacu3XQLuMQB0Jb/cry
         xN10IImRB5haPQTkXSTelAws9AosCr87Gx72UtCbq1GuaHDtyZatCuizVwZpSuEhcktR
         aaTBOS/vymBkArwPyALJltECxl0aZFwadnvWsHO3GF3ONNsyr6/cClGQMkU19RvkAalG
         tnKA==
X-Forwarded-Encrypted: i=1; AJvYcCVrggIWBmmqXabHx6J/tW3uSNTqNM+heojYosS5/dEtT1oPeMcYp56oHXRddToYqUfMtKGhJwM4NgoBXxhvjpc2UgSv
X-Gm-Message-State: AOJu0Yzi7OuDSKlVUqWPDc4vW1C3Ymle1ADxhFxszN9dflu42n4T8/CU
	EMHaidLoLZSOiHVWpWgmBurTuXEVlMYEF1k33rHjoqrDb7h/bL/fJUqFAWycsKSpEVjDSF5obt7
	CyTvmXVSFMQ8GEq4re1edexOj4khbv+71xGo=
X-Google-Smtp-Source: AGHT+IGjfIbls0dGQoBe55nK18JMgX08EN7uXOYfgYkknWGKrHlLrgIJyroUIsQK7YOEouM2dplUeUKup8e+ewH8IVg=
X-Received: by 2002:a17:90a:6fa2:b0:29b:b1f3:c4ab with SMTP id
 e31-20020a17090a6fa200b0029bb1f3c4abmr752506pjk.46.1711066645462; Thu, 21 Mar
 2024 17:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200114.2219721-1-yonghong.song@linux.dev> <CAADnVQL3yAnS4+A59OBmpbhEhQx7Was-EnTcLW9k4ddnXQi31w@mail.gmail.com>
 <559d9eb6-9832-4947-8d32-9be84c217659@linux.dev> <CAADnVQJ2vEebnbJ4t-zArLgLxdYtHUoPhvo0FsHYRWG48yqpLg@mail.gmail.com>
In-Reply-To: <CAADnVQJ2vEebnbJ4t-zArLgLxdYtHUoPhvo0FsHYRWG48yqpLg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 17:17:13 -0700
Message-ID: <CAEf4BzaUMb9+qiFkMNj4G+M1hE=Zb-zrR8K2T+cjXfASTnFkcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Handle <orig_name>.llvm.<hash>
 symbol properly
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 4:55=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> > >>   static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
> > >>                         const char *sym_name, void *ctx)
> > >>   {
> > >> +       int lto_enabled =3D check_lto_kernel();
> > >> +       char orig_name[PATH_MAX], *res;
> > >>          struct bpf_object *obj =3D ctx;
> > >>          const struct btf_type *t;
> > >>          struct extern_desc *ext;
> > >>
> > >> -       ext =3D find_extern_by_name(obj, sym_name);
> > >> +       /* Only check static variables in data sections */
> > >> +       if (sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled=
 =3D=3D 1) {
> > > why bother grepping config.gz ?
> > > I see no harm in doing below strstr unconditionally.
> >
> > Do you mean we skip condition
> >         sym_type =3D=3D 'd' && obj->need_kallsyms && lto_enabled =3D=3D=
 1
> > all together?
> >
> > For condition sym_type =3D=3D 'd', Andrii suggested (in private discuss=
ion)
> > to focus on data first since that is the issue we hitted. Of course
> > we could do all symbols here too.
> >
> > For condition obj->need_kallsyms, I can remove this one.
> >
> > For lto_enabled =3D=3D 1, the main goal is to avoid extra overhead for
> > not-lto kernels.
> >
> > I guess that the overhead is not that bad since typically symbol name
> > is not long. So removing all conditions seems indeed a viable solution.
>
> I was suggesting to remove the last lto_enabled =3D=3D 1 check and
> check_lto_kernel() since it will simplify the patch significantly and
> won't cause any slowdown.

+1, grepping Kconfig seems like an overkill

> The first two checks... I'm not sure.

I'd say we shouldn't do this for functions, because if LLVM rewrites
them, then usually that means that function signature is changed,
which seems dangerous to just silently resolve. I'd start with data
symbols for now.

> The less corner cases the better. strstr is fast enough.

yep, I doubt it would be noticeable if we do strstr()

> Ok to remove them all.
