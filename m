Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010A347FC4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950153; cv=pass; b=VEdC4gxSldsZ3ITjcqBfY6/cYu88wYbJWiFTK/ZgOgOUbkH1n8BPrr7qsf42IbIHCx89LdOQk9cJkI9/rU2sPXR5GT9qilfoTND7vnE4mMHZrK8/GL5qX7PwI5BhM6FzuxUaBd5XV5/pzOd21pD6qN2lpL6jZSXaDQqHmbRaOpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950153; c=relaxed/simple;
	bh=JknAXXqWi5aZnJLBDeAZhohwZU8+AXpxsMT9BnGevWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyNN70zntvAsdTcdnqGOUKRRuCcUrJXqK+31FVewtf/rzYW47pxcfIfkTJ8gAf+PmPqbHxRa6b0V8+HQVTtyDuhuZyeUICbKJI6f5q5jOtFKL/o3Pf6sYPK9AZH7hffw+Vmh6EjWt9ZvRUxnLTi14ThAayVkxY1+w1uWpKek/Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZCr+yUi; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZCr+yUi"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37dedd62b90so22340a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 16:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782950151; cv=none;
        d=google.com; s=arc-20260327;
        b=cxQesN/IJEKO+AjAndkU58KDQUW9bN1ArSiD+7O1GFLv98UuIQ8b8oHAyTjsMhyBvw
         2menfC3Yfk03JrN5hJaZSywnFw4PcAYyysV38QaURzWCDi6/iZegCrRXeTI1BT6FLwAo
         +kxeeAQDJo5U5ZgeNWSptxaAolJyGnAzEO/giD24l3h54rKhOdi0tIyytUiEAjReMDwn
         eREgiFMFHKMKRGFbCD9XMw+KWd8Ny5JOJeS/eC1AT5PY9sG0vr6tQ+Nq0n3+v6E6+P12
         aaRPoICZXjR08SPBbpmWZu4jvvFd8wmCL8jpC+QlIpc0aj+1z071A7TejruMx32dqI9p
         M3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HP2ggHn3iCW0WAW4x0H1w6yxZnanmAeHQSwJ6ngTwfQ=;
        fh=4kFQU9HPOPvuu2V5BArdfPk/6VjvrlgZ+yfyvRIGgbg=;
        b=JFanoy7hOIzhx8dPyDPpzk61+FH7asuRSi8Z39L3GjJqBKP5lk0ue+9ZclmAC2ay3c
         F7Vl0QKz+qthuw/GBFUEcrMcPr0TRwFjasULaHYUfWNlfZzlg8XalyHRr1+3dR9D0wgx
         oBHM01ctmde+mYAhrmPZIQLhuiE/zgZ70dSWTj35P1rXS/Nq2yMP1j8BMZM4ywspmP+m
         sxm+sdmJmBtJA2OVb2AzczcWk/18LJbO8s76UnPYUlZBJgx1KN/Ly9hragON2MNxgHoZ
         +7TSAGbIzrmJuPPtjduCJGG7Zj6bCtOOYrgoCTRcGEq9r0OyuXtPE9jowvaFPlM7pte7
         +Llg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950151; x=1783554951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP2ggHn3iCW0WAW4x0H1w6yxZnanmAeHQSwJ6ngTwfQ=;
        b=NZCr+yUi+tBl4N2jeRD3mrURqRoUQxK6efdrUe3bie1qmJO0YzSrEiNMBAPiQhUEPx
         USz5NcwsgJEttJVC21tI3xXvx9gkH5TL897u6GskFkK4fGiVh3JcHHsU0pDX93J4Cm5X
         ci5XFuWQPDJ6VrZrNPbLUntikwcrEQm+yPuPCH+wdiL15uxffZQyrUyzQ0A2n4XJ54PI
         PsIH+k7hp0FS1yNcDJiDO3OWDErkXD/hXI6Ww8tUVeiup+nFTLW+itpt7ogtfp11DNGj
         Z5Ua0sRQfYwm4QYP3y0ToMPlUsw/W+6i0NZ/F0XEMRAPX54Cfr+u5fuovbuU5MGJ1tBq
         yxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950151; x=1783554951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HP2ggHn3iCW0WAW4x0H1w6yxZnanmAeHQSwJ6ngTwfQ=;
        b=PoDubPMskx18HYqGUNpEx/tpvKQK+aQ48E11RgKAHIo3G0e7f3c0eDFlfJELtselXf
         u/bfjUw7BybaOtCMmJPafrcFGMQpQ2hH+KugFNeRQwX8NiArVE5/tlKPEL+n5QcDmTE8
         5Uduryc2584Lh8Hq+apg64lqiT0lD1++8pmHwsoSWmbH0IQ3Mq9omPdc1vGZ65IeDR0A
         FfzUDaBwtzx6hw0DsCDWg/z2DntyTdKjtGNGzTHIxKBu8H7ztAN7Q1wnHC9+VLLOUJ+x
         XzUWFXKk7ozlyfF2wkqBNGmuENpBR9b4iqsdb22bttuaZirQZ8JiU16DYktLvGLbatkO
         XxoA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+ljGdir66VOCRIOx0MxhNgh7bdWa9Qgy9j3gSQ+slfqnx4NvqbTME6mc/Gjv1gidZ7xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHqEVumWt2EJuRIWldRyIPm4eemOSYescYQR21nGIEzmVmtGS
	9ArfbjhPvMc6mkOzPHZ1z7eFUZRN7T1XN3YAwofVLAypGIJa1COWgmPhzMJEcQYrtipK2mGhBQQ
	z0OTYxx9NlD9FyxZDVAKTEgXcFQLfX28=
X-Gm-Gg: AfdE7cnwTFAx3RlK9JZ/4Qn7S1OAH4bIATM+wTcZ8m9yJd68g+hS6iemwEuSMrKY0uw
	qPPx56sBjzWo8YsgwHXnvbNnWDkwtNJX3X4efMGbTpJMs4h0zHOcgthFf7VyWAORN58s+zh2XRz
	vwuWmECXmoPuep3oz5zEoebV5z6N3TuYXfb2qEFMggwCnl9z4fh8RKZGdeMfPS3R9OlsYXthIqZ
	9WIgUpmUmQspyoEjap/Q1CVJl0Cs97eW9GmmIgx/6IvDw6v5Om/R6S5v+4a4PTYIscJBDZEYegO
	VKmTuEAE7SAZp8aK99XXPmBQ7SY16XPjJFGDcyiDXrieAx6Ya14k+hhnL2SRh6fyoPt5oZvZhs6
	psXOjDFvx0o4Lrg==
X-Received: by 2002:a17:90b:17c2:b0:37f:9e21:91d6 with SMTP id
 98e67ed59e1d1-380aa1d5609mr3108978a91.13.1782950151033; Wed, 01 Jul 2026
 16:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626172026.7327-1-jp.kobryn@linux.dev> <CAEf4Bzb-3GA2OGTOBg-dgUNPJfH8-PDi=3gFZbyZLMmP9DFvLQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb-3GA2OGTOBg-dgUNPJfH8-PDi=3gFZbyZLMmP9DFvLQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 16:55:39 -0700
X-Gm-Features: AVVi8Cd7RLp2sDxm4meo2RErciO6kZoycRP_dvGG9v9k9QED7bmTWWAHpXC8Y9A
Message-ID: <CAADnVQKYf1oRXTsp8yBCFVR+zjj1kt470+-3XUCp+KNdFB-8Sw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/bpf: make it clear that kfuncs should be non-static
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: JP Kobryn <jp.kobryn@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 26, 2026 at 10:21=E2=80=AFAM JP Kobryn <jp.kobryn@linux.dev> =
wrote:
> >
> > The kfunc documentation mentions how the macro __bpf_kfunc prevents
> > inlining for static functions. This makes it sound like static kfuncs a=
re
> > acceptable. Although static kfuncs may happen to work, it is by chance =
that
> > the compiler chose not to rename these functions and BTF resolution sti=
ll
> > succeeds.
> >
> > Make it clear in the documentation why kfuncs should not be declared
> > static. First, remove wording that makes it sound like static is ok. Th=
en
> > point out the external naming needed for BTF resolution. Finally point =
out
> > that sparse may warn on unreferenced kfuncs and that this warning can b=
e
> > ignored.
> >
> > Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> > ---
> >  Documentation/bpf/kfuncs.rst | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rs=
t
> > index 4c814ff6061e..1dbaff8d4805 100644
> > --- a/Documentation/bpf/kfuncs.rst
> > +++ b/Documentation/bpf/kfuncs.rst
> > @@ -276,19 +276,26 @@ This set encodes the BTF ID of each kfunc listed =
above, and encodes the flags
> >  along with it. Ofcourse, it is also allowed to specify no flags.
> >
> >  kfunc definitions should also always be annotated with the ``__bpf_kfu=
nc``
> > -macro. This prevents issues such as the compiler inlining the kfunc if=
 it's a
> > -static kernel function, or the function being elided in an LTO build a=
s it's
> > -not used in the rest of the kernel. Developers should not manually add
> > -annotations to their kfunc to prevent these issues. If an annotation i=
s
> > -required to prevent such an issue with your kfunc, it is a bug and sho=
uld be
> > -added to the definition of the macro so that other kfuncs are similarl=
y
> > -protected. An example is given below::
> > +macro. This prevents issues such as the compiler inlining the kfunc, o=
r the
> > +function being elided in an LTO build as it's not used in the rest of =
the
> > +kernel. Developers should not manually add annotations to their kfunc =
to prevent
> > +these issues. If an annotation is required to prevent such an issue wi=
th your
> > +kfunc, it is a bug and should be added to the definition of the macro =
so that
> > +other kfuncs are similarly protected. An example is given below::
> >
> >          __bpf_kfunc struct task_struct *bpf_get_task_pid(s32 pid)
> >          {
> >          ...
> >          }
> >
> > +Note that kfuncs must not be declared ``static``. A kfunc can be calle=
d from a
>
> it seems like we do have static kfuncs and they work fine... And
> __noclone in __bpf_kfunc is meant to prevent compiler doing
> .constprop/.isra and other transformations.

There is no guarantee that compilers will follow that logic,
since "static" vs "__used __retain __noclone noinline" kinda conflict
with each other.
Next thing, some post optimizer that only looks at the symbol table
will decide to remove it.

So applied to bpf-next with typo fixed.
