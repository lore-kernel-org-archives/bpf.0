Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630F3375D0
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351005; cv=pass; b=samQYEVtWdUWncET5oO79WH7btwnJuhgkHu3VBPY071PLvI+76m5dUVovzDtEzfb+dzHN8J/2FFioRdSHGsTD8k/ppQmNxizM/tAMLW0R0vwK026TPzmFQwKbWzEXV2AAiCadZpb/eGIRWRPSB/HSilUMycqN3uj1upbLaM1Ca8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351005; c=relaxed/simple;
	bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHef1FPQTtInxqkiSu8OYpq6zqyBnLxIa5VF6r4g5b/xk4HxULFtuP8xqk9O00gVV2qRiK/XAxOC48lnSSejFFvMu/DL181HWCV9Ti3x+QC+SYbwsknMLXJnvGVoMtFE9KRR081m9qvZjv59dlOzrKuJj718BysjBdkuxmE2JIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpWKB0Uu; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpWKB0Uu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b885e8c679bso36624666b.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 20:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770351004; cv=none;
        d=google.com; s=arc-20240605;
        b=PJ8kQ8ckKS68K113T70Nm05Xp/sxWfiHtN0iJfCrtSPUc569uvbVaT/CdaLjNtnJk9
         pZ5YAB2DyQb6MGiBxSV/WVYNwfyEbyGrJdp20eO6PSe/zlghcgtsWtu8KIIFPY37af0b
         FFwvIFc1XWmutaSpjLer2nSbqf3sN55vMdML1/AXDMzesLjRbFKk9tPzZQsZaBRw2Hse
         vIf6q4jqdWZj8UbsL5sCFF8BqcwU2y2mRrCObDMNldC//Iab5s4cV0S/ngqSXsneh94g
         jJx4NrVZ6Q4NJ0DhiITFCUlnaPUfAFk+On6BgEixMmVTWfdxFJHZgePrhz2TXmib2R4/
         dlsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        fh=6P470A7w/DF32H67kvlitkAj6gcuu7nuXZ3E3Gup2cs=;
        b=ILiAfR+03gTFNOxYZkNpuYh+5RojYhwnX85hMYtkqkjB3vKeYQeuNX2CQ2hT2nO9wo
         JVHt1qZaxzJO9OFJm390g5DZHgubiSV+4Dbml++i3HExZO0BzzksDgZT0YE2vYIsgluH
         HbMc+NwtvuP9CTWvZHq3Hb/jvlvUBcKAn3z+5cE++rdEbtnIAAPfXoC3FwAQVJ8Fbcun
         vdiqZNRSZsZ+Y7elbCZXHqOCRRwKXyjXBjszdX3WgjXjuwZ4eswydfTtj5E44/MHUHjF
         nHd1okATnk9i2pcsAaxvgjM7R+n11b1yZE5/jNFHR417bZ/o3cXSemrqAAt5QcZ45cdV
         Gtfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351004; x=1770955804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        b=WpWKB0UusxXul9U9xdQlw3wzAufITslB9IHz3SPSXreh04kXuATvUtpbmQqfa5qCan
         /A9oupjusRYO8aP2jNxP3NaWQcQOkUADDlz6xFsRcJ6J+Nis77R0641aFTJj0JOsdsQa
         /cg1Wlh1iTq7LCcffxjgxnG4WK7mH0Anu7p7P4fSRKOwwG2n9MLvE8D8DWmXYlSX7uVn
         CufFJe+8aeJYAnLmJEcIx7d5ZwGSt4s7wh38U1jdiNPIihcpU/kzaNE4yrrn0XTJ50uj
         Dn48xaE0+0X6h9/0+Kpu97i7sXnX0iG8i/11hF6cdn2Jw5pEPbuQzXCWV4RvbsP+6CeL
         BknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351004; x=1770955804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        b=c0WbZQ15q+KxkkfRG6DXHYHfTsBRG4DHOUPZd4Uv9pFBh8l+TpvNy3e/2m7FHHSKNa
         uL241XUvQHcOV8tE3/beVs1Hdvzn4GdCCGQ2moJIYL4wkRLJz+mxthRM0lPnLMQVbQVq
         lCAtz5UdFXSQYBmGyljLgyKLy/SHDj6dGRPrWwjoIX0YJ95me+zYCNvl6U/6XZwzCy/7
         qpDxcNyThisouU6Y503lfqTbCq41v0/ZVoWIXGeP9lgTcs9ZwmwAGEEKpYVP+HI4nz+k
         IB1qiG33mNOQs72n4XV4TzjYan2HUL2aarFcgflZ38tvIYoDRKBTl/dHY61h5QYA9fRi
         Nhqg==
X-Forwarded-Encrypted: i=1; AJvYcCW5mxK/uAs0NQyOGu1We3f0e4r8pS380Wk7m5OpO5hYjuUr6Z7YS9et3N1+09R0vd66pGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQwwXFl66UmFb9+iIqNpvwcx+qAYVVKhg+hNQyV5AUi6jAoVd
	dSXzm7CVkQlHxs20c0pjfWvQzMNJ1XZWQqyfUlDzUnZQIqTkghgFJj6P6/wqAPWtOKd/wk1MaWu
	82o32Ql4WSaL7NdLuczkWC9BHvm58GJ8=
X-Gm-Gg: AZuq6aJqqeO0CS25qogVcSF/k8J5gxQ+SIFQIuLVC34p0/tHg2DmdvziuoXkw+v99WT
	7RRUj663d8H2+KziNC6EB9CFKdIvI8u8OFK+AUtZg8PZuwcg1Al+fFeuzb/ybWwELyUH1gCa1a+
	ZmqbKPqpx1rA7nDAHQzGZLsqGqt2obzKawaw2UD9yJ6V1kLfGsjKYh8OW35l2Xjv1vjtMC4YQ+c
	+RPrJBR/HLeKjH22WKTu3PytZ5de3RBXeeZzSk2+vNt6ykc27dG9Od8U61Jm7ikpSvXtZMV
X-Received: by 2002:a17:907:6091:b0:b88:5385:59d7 with SMTP id
 a640c23a62f3a-b8edf14caafmr70992166b.4.1770351003846; Thu, 05 Feb 2026
 20:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
 <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com> <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
In-Reply-To: <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 6 Feb 2026 12:09:52 +0800
X-Gm-Features: AZwV_QiHtOYxxPJvq-D2Vb8pnfHmY5SKlgGaNk_QBcR7mOob47oiA5NF3J8engI
Message-ID: <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@good=
mis.org> wrote:
> > > > >
> > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > >
> > > > > > Testing revealed that sorting within resolve_btfids introduces =
issues with
> > > > > > btf__dedup. Therefore, I plan to move the sorting logic directl=
y into
> > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which =
are
> > > > > > invoked by pahole. However, it means that we need a newer pahol=
e
> > > > > > version.
> > > > >
> > > > > Sorting isn't a requirement just something I wanted to bring up. =
If it's
> > > > > too complex and doesn't achieve much benefit then let's not do it=
.
> > > > >
> > > > > My worry is because "cat trace" takes quite a long time just read=
ing the
> > > > > BTF arguments. I'm worried it will just get worse with enums as w=
ell.
> > > > >
> > > > > I have trace-cmd reading BTF now (just haven't officially release=
d it) and
> > > > > doing an extract and reading the trace.dat file is much faster th=
an reading
> > > > > the trace file with arguments. I'll need to implement the enum lo=
gic too in
> > > > > libtraceevent.
> > > >
> > > > If you mean to do pretty printing of the trace in user space then +=
1 from me.
> > > >
> > > > I don't like sorting enums either in resolve_btfid, pahole or kerne=
l.
> > > > Sorted BTF by name was ok, since it doesn't change original semanti=
cs.
> > > > While sorting enums by value gets us to the grey zone where
> > > > the sequence of enum names in vmlinux.h becomes different than in d=
warf.
> > >
> > > Thanks, I agreed.
> > >
> > > >
> > > > Also id->name mapping in general is not precise.
> > > > There is no requirement for enums to be unique.
> > > > Just grabbing the first one:
> > > > ATA_PIO0 =3D 1,
> > > > ATA_PIO1 =3D 3,
> > > > ATA_PIO2 =3D 7,
> > > > ATA_UDMA0 =3D 1,
> > > > ATA_UDMA1 =3D 3,
> > > > ATA_UDMA2 =3D 7,
> > > > ATA_ID_CYLS =3D 1,
> > > > ATA_ID_HEADS =3D 3,
> > > > SCR_ERROR =3D 1,
> > > > SCR_CONTROL =3D 2,
> > > > SCR_ACTIVE =3D 3,
> > > >
> > > > All these names are part of the same enum type.
> > > > Which one to print? First one?
> >
> > Another option is to print all matching entries, incurring increased
> > overhead and extended trace log length. However, I prefer printing
> > the first matching entry, though it might be inaccurate in rare cases.
>
> I disagree. It's not rare.
> I wouldn't print anything. Let user space deal with it.

Okay, I will implement this in libtraceevent first. By the way, would the f=
irst
patch [1] introducing the for_each_enumand for_each_enum64 helper
macros be acceptable?

[1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@gmai=
l.com/
