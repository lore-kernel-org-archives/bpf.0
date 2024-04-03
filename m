Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9E154BF0
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174510; cv=none; b=ltfNcWJqueeZb3TgTdnLJyjTcigjWfL3/Kck6xvIJ/0N2mQx28GEfv/9H15FpjvdGJbRVqws9IZ5ehSbo3IOTQZZ/yjW2GDzdBIg210+zfacUWy8JipV8Ms+TIUsd5iue73CV9AeWm+QwpS9wNoeYsqB4Qued38KO2Mm2rXDE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174510; c=relaxed/simple;
	bh=LVlaeu6KPagLxOplJZu/9aaiwB9oc7nFb3dGqDHXOrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa0RvAwF5W5n8P/6RPAINDx3aAJvnYsSFvb5dIVA/4Aw5X2Uol2NDdLvL+cwVs7L0mIn6cYHRLwiQvaIhM9geTzF/MhJxS3Hww9CgTUdsBvX8fS8wgtC8NXwJ/N50r1cq3LKf01ECVMY+eDEXSymM045Fjm1IGuVMNuAzTbm1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrGSjdzq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrGSjdzq"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4317aed91baso1457041cf.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174508; x=1712779308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcuT4Y/Ytb2sbFYkj/cVm5/+jWTpqPRb07HNetnH48s=;
        b=KrGSjdzq6BvNTjzAUOc5gFB7hFyaeJe7L2REcPMSJz2z6nv673oy9Y03sgY6GJVzsZ
         XiFkmgKN+8adyEYWaaGfDhxS0NEaVdLMCccAOzZvRZzfoek9ey39QwIwAV9jTd+PqsXO
         /YbyMRg6PSGLwoRR+0vm6YT1IDnIJJpHJrQFGqX+q/uZB/W1pIVBRX1KRMwnMQow1p3U
         VODtOGqznYo8gZvQn8iwzGmzIHP0Ym4p4gdfPWEi4bkOtxMIRMscq/nG92bbGaarlO0M
         lC2mh7/ksd0I9p8vw1keCoIWXQMoHd6bzfn81h4pB1Pgk8+Irtj/5VyXG7vLNyhUAzd5
         BYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174508; x=1712779308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcuT4Y/Ytb2sbFYkj/cVm5/+jWTpqPRb07HNetnH48s=;
        b=eZv3EKxQEFF6q/iBB/uxz7OhMoaRBv2rW7p2pyEdHtzIt2AANaF6GC26GV5Wqv35cB
         nAspD1eRxDAhNtgHh8FnB+B3H2PECtGO9Ob5TXMNc4OQqJYKwtR6C0338Qz39Z2vkzUN
         zMMqcl76T6wAvaXgbqeum+6sSeNozETi92+8AD852UzYOvVaZBRtxqx834OK98bjEir2
         f3XZN0Npe8NmGWum6mvop1iAOlt0zAYbJsLFDd4DzUlSW+jcpNIvDs7NcA0FDnPKC6A3
         B/mobb1se+J9lDxbCCERLPlCABFUBGti6HBh+cjrsqVHINNGnsZKzCnLj+5CfEHpcezn
         YhIw==
X-Gm-Message-State: AOJu0YyRnUD0GEANCWR9RuIAulTInB1UGqrr4qKVCyrKq9n0zSp2Yfl/
	VzYoU9v0a3Czub5UMoQwHigkzkL7BvBtnXxYk4ovKwKc9y2L2P3LwJlERpqLLZl82S90v9zi/Yj
	GmsV4YU2yAcWxFc5qYMEH7+3SuA6IhDWAi04=
X-Google-Smtp-Source: AGHT+IE++rayCgpszSZruuXncSSjP2ZFZ3u3UgVftUpOYuUTwZlSmouRPB9wI0Au+BC5097BDsF43zzHI3me67qSnXk=
X-Received: by 2002:a05:622a:189c:b0:434:39f2:e2a8 with SMTP id
 v28-20020a05622a189c00b0043439f2e2a8mr400261qtc.15.1712174507740; Wed, 03 Apr
 2024 13:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
 <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
 <CAK3+h2zAF-N9s=PO3eW4GJ86Ov14rBOAZFEDqYbSeFBnss_PyA@mail.gmail.com>
 <CAEf4BzbKz2xCK6jqVnzA4uWnZKx+UteNPcZ3zFtyYe885stnLA@mail.gmail.com>
 <CAK3+h2wkbuMrcPg6E7Gh0AxbGiSKNGJ6RX=psxtBP6k9W0L6PQ@mail.gmail.com> <CAEf4BzYY09WnHsz3peLYMy0=A3JkivV-zxD2GjmGrQWLbhW7mQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYY09WnHsz3peLYMy0=A3JkivV-zxD2GjmGrQWLbhW7mQ@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Wed, 3 Apr 2024 13:01:36 -0700
Message-ID: <CAK3+h2zpV75MkOx49RvXyvf+DwHjHaF9e8jFj+3AG2qZQZEr8A@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 12:35=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > On Wed, Apr 3, 2024 at 11:56=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Vincent Li <vincent.mc.li@gma=
il.com> wrote:
> > > >
> > > > On Wed, Apr 3, 2024 at 10:56=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li=
@gmail.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Once I enabled the open source firewall IPfire kernel 6.6.15
> > > > > > DEBUG_INFO_BTF, the IPfire ISO image is increased from about 45=
0MB to
> > > > > > about 1.5GB, I suspect because IPfire has many driver modules t=
o
> > > > >
> > > > > BTF can't be that big. I think you just get all the DWARF for mod=
ules
> > > > > and vmlinux itself. DWARF is necessary to generate BTF during the
> > > > > build time, but it can be stripped out afterwards, leaving just (=
much
> > > > > smaller) BTF intact.
> > > >
> > > > ok good to hear that :).  I am new to this, how to strip
> > > > kernel/modules DWARF after kernel/modules being built?
> > > >
> > > > >
> > > > > > support as many hardware as possible, pahole generated BTF for =
all
> > > > > > these modules, that could increase the size of the ISO image, s=
o I
> > > > > > wonder if I could disable modules BTF only but keep vmlinux BTF=
, or
> > > > > > maybe selectively enable BTF for some modules, but not other mo=
dules?
> > > > > >
> > > > > > I found this discussion [0] making DEBUG_INFO_BTF_MODULES selec=
table
> > > > > > independently. I am still not sure how to disable modules BTF, =
I tried
> > > > > > make menuconfig, still not obvious to me how to disable
> > > > > > DEBUG_INFO_BTF_MODULES
> > > > >
> > > > > I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but s=
ee
> > > > > above, I don't think the BTF is a problem here, it's not strippin=
g out
> > > > > DWARF.
> >
> > I  manually change the CONFIG_DEBUG_INFO_BTF_MODULES=3Dy to
> > CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
> > in .config, but make oldconfig always flip it back to y, if I run make
> > bzImage without make oldconfig, it will have "Restart config..."
> > like below and n  flipped to y again when examining the .config
>
> Maybe CONFIG_MODULE_ALLOW_BTF_MISMATCH is auto-selecting it, try
> turning both off.
>

originally CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set, so I set it to
n, still CONFIG_DEBUG_INFO_BTF_MODULES set back to y, I also tried set
CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_LANG_EXCLUDE to n,
no effect, all back to y

> >
> > # make bzImage
> >
> >  SYNC    include/config/auto.conf.cmd
> > *
> > * Restart config...
> > *
> >
> > >
> > > strip -g ? I don't know how this is normally done in Linux distros.
> > >
> > > > >
> > > > > >
> > > > > > [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvw=
uCJLjesqw-_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b29=
4ec2d
> > > > > >
> > > > > > Thanks!
> > > > > >
