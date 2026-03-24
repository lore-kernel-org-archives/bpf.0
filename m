Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC973559D6
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391106; cv=pass; b=RjDryAFY+K3vCv6PpzMO4AhzgRc0znkmy/tTB1n/ezPcjcbV1girwcVgzi/gUP0BXmBf2AwuV4Wje81Euo+D3K/2gkSI7eqTguYF1Hpfm783obKkbjVfYLrv7PFhvgD09FetAYjEuK3YZ1/s/QL83rkKJ22xzk7oizpgGXrnVQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391106; c=relaxed/simple;
	bh=b/lnJxU0z2Qtes6sK0TTmBav9/WZQZgluT+8cGqNTCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSJ2EameRqRb0Vo8+ulVXWkLawUiD/yvN1RPSf7EkQsIZDWvOxPtirpWux5u/ztO/a0Z6zMveFoBz49KLjwYR8zMbjzlmn/mM2dFazOafw130owLRIrbJppTOnjFPTOzVzeub8MKmcYJE/GKJch5UjJrWn6PK/ne7o69lGh9L6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMLoNcO4; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMLoNcO4"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b4915161fso4252135f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774391103; cv=none;
        d=google.com; s=arc-20240605;
        b=ku2EfoLBFDO88BKqbwc9XqXIOXbDN3IOkyKrKg8bPVzyIZU3HlNJZtSZ4haXa01zyw
         FAvlNfIdzRjKvWYeoLnF6TR2E/hVfwbjhTFXjQXU2xoTgeF/RPqMHIBbcBJdT+imk081
         BCEwj9w76JLa2bzteRXzgx0ZXvj84InYfJ4l25SdnvMO0QUeld2VE2aXokj7VffZPRhz
         NjZgDLK+sBHw+XcnQOWcK4Umz5ceogn8NgIC6iU/ibc82VKaNYWd5VzFdBTY1dhuF5qi
         gluDLh4kmhOkEML+hLQBO69yb1mZYjKQyrJfIH7tVFL++YcJ5p6vYnXovqDWRrSjSRXS
         B6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A27qaPJVSe5UFbnhSQn259bTZHNlbTV+2ATC98SquhA=;
        fh=4W6uGWcW4oIYXN274xk0fSrls6OjvG1h1wxEWGKY+z0=;
        b=CFVM25wHxbPPfJgXjhOReNUcg31vzvElDPX96J79hdWfYwUnmvJdBknutVJtOydPx4
         ROFaVIwgBcz3ySabafiHmlKZaerEZPVXR6WCpj7ToSmfxOmH/HB0PcbSbZr6z6NDOFqC
         jNIwtO2SH3JqEVvQgyPQ6kK5goUOv0kS1GEEUYhUv5qfH4gd6iSxCgo7RCp4yd1L1A1M
         uOz2RYE9rEg4n/6bNHyhqR07hohvZrESyqFILgKe5lBHY5sN3s1wejF7b8B5c/1uOL/E
         2Ze7XYtLG155s6ghfR/+8qFwragFzlPpCotTuyooaAi624ugsWLjY5y4wAR+wVtXWZEn
         q62A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774391103; x=1774995903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A27qaPJVSe5UFbnhSQn259bTZHNlbTV+2ATC98SquhA=;
        b=aMLoNcO4YCZz7Sob9r63CORLW3fUfoABVwZa1tFQdTOq72ULJQ8tUxtHcxJ2UUvS4r
         OzI+vwNpq66zyrtEYRIiLZvFJSnNwRHJVjm15zZBOZ0Fa6puLnYVG+feKjBCtxDZcLUG
         WNvfUYpskic2lMjhZpPwdtmaZqQzqvDyZBSxvwYsEeyKM2BEfCj9hJ9K/N6IRNPf60lt
         rAQPi4N2PpLniaHK0YHla17EVYCn3DrTKnXMiwGqxhT6upB+pNTAvh86BsyoYdf4Drtv
         uwUJs5Q8DQ6PcIB7MBeTpZOF/7FZ8mFyjdHYrdpQodzjyHWWWHc/b6gzB2uvWptG8/uX
         MluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774391103; x=1774995903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A27qaPJVSe5UFbnhSQn259bTZHNlbTV+2ATC98SquhA=;
        b=U94zby0IKnwpYgPC3x3cB/RREiXXuAn0f+MnDWUfTceBUJLJlbqnRsa1+NbZUvCuft
         CurJcwyTDz/D/IEJ41RkKxSaemMG/mRXeux+9F2UPxL3eqEIDN2bQ+yPRCcqTR8yreeu
         igBiJUIp4sUiDcAg9xLmzDcjYTD1GD9efAf02nyH7ESo5N0CdBK5c+t2it99E+KuW2bU
         qaa3dfPJNWlPtUxg0mOUeSEDRNd9YHhI1eF5QhILFhq+8Yma7gl08nUqWUtlfy3c1j5J
         UQJsiU1a4VRoqnQoISLuGMAlIMnPL1MzLDfqRJuAvvXSN+fDGTkPwfViReJUpZ2TxVYB
         i41w==
X-Gm-Message-State: AOJu0Ywg3Qvupth5ZYVB1U31kWPlaxgtP9H0xgscVwG+o3jJ7LJlkTKG
	R93GOaz509gqcrfnGuXbRbhPvmO58w4AGVEig/ovO/15JNLNcGfHgogV30C/MeEb3z6xF5C2UEU
	s+xoTg21YzKO1Hsc/ev8k9/uJbobVjpO80jEkSO9Eog==
X-Gm-Gg: ATEYQzzbVqSxKd5Y4EcIXI+s9cbrTHcuQIDqHl3tuklJskkCpQSqEdAaKZu+253OoXt
	yyDKBDMEcIHHkyj8fjRzLDDwNxNpzpo2Ib1DuY77p4LAanAF1lA/MMzAb15TwOlDSWSka4846+e
	ujB2NnTu19VIQaZJKiR0En96JSB3vof7ivrNSe0W3gRHirio6Nu9uhQZywic2Eczwy/ekAspg3u
	CzNFCoCLBFpZRyuAZm8p5zL7XtpU2GZabxp3pgJx93lfUY705OVxG4faegAL87sCy+ue6OJ9zY2
	yDGEb2zhNb1noUDGDfb2bFYVsARlE/AkUW27jyH9s4KJRMJ+FerhpaVwehwnNVlrCBOQTfKn
X-Received: by 2002:a05:6000:144f:b0:43b:42af:75e with SMTP id
 ffacd0b85a97d-43b88a1c6e6mr1632825f8f.44.1774391103524; Tue, 24 Mar 2026
 15:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
 <CAP01T77acGZnCQTW08aG8ZgUNhswTJQsTgiHQ3-ZQ1TDXQ+wrg@mail.gmail.com> <CAADnVQLpkKzHbFsTzthwr6RJgut5PSqhXMju7MyRrhjVC6B=rg@mail.gmail.com>
In-Reply-To: <CAADnVQLpkKzHbFsTzthwr6RJgut5PSqhXMju7MyRrhjVC6B=rg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 23:24:27 +0100
X-Gm-Features: AQROBzAek4iGCsuQtngg5aTF9KR3_1VRkS-lmV6N3SESc56QZ8UWXEGx2UBLgpE
Message-ID: <CAP01T76HmVQ5zpJisz2anhAf7e6ABxoCQ4kiE2p=PZiM-rpwjw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write over
 spilled pointers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Mar 2026 at 23:19, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 3:12=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 24 Mar 2026 at 22:59, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Scrub slots if variable-offset stack write goes over spilled pointers=
.
> > > Otherwise is_spilled_reg() may =3D=3D true && spilled_ptr.type =3D=3D=
 NOT_INIT
> > > and valid program is rejected by check_stack_read_fixed_off()
> > > with obscure "invalid size of register fill" message.
> > >
> > > Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > > v1->v2: factored out into helper
> > > ---
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > >  kernel/bpf/verifier.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 70a100dd4d0c..11207e63c94e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -5251,6 +5251,18 @@ static void check_fastcall_stack_contract(stru=
ct bpf_verifier_env *env,
> > >         }
> > >  }
> > >
> > > +static void scrub_special_slot(struct bpf_func_state *state, int spi=
)
> > > +{
> > > +       int i;
> > > +
> > > +       /* regular write of data into stack destroys any spilled ptr =
*/
> > > +       state->stack[spi].spilled_ptr.type =3D NOT_INIT;
> >
> > nit: strictly speaking we don't need to keep this, right? It's only
> > checked when slot is STACK_SPILL.
>
> You mean to keep whatever leftover spilled_ptr state in there?
> I don't think it's a good idea.
> If we didn't have " =3D NOT_INIT" and had this bug with leftover STACK_SP=
ILL
> then check_stack_read_fixed_off() would have copied junk from spilled_ptr=
.

Ok, makes sense.
