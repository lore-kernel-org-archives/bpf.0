Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2062BCF4C
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692785; cv=pass; b=p9tv9vchjpaVJnhsoyszz7Zxgf3PZWkKopm+gTxyudalJo24fX8W0aSmyF6HyDowIuoJiLlltchAZDRJ7qf7EC8rQVmcxJD/b6mqYCSZMx1RiJzHf3J2xYKYdaxlQL8rooTz+UBMyM6sLOO3UKBxpJY8DeYgxtC8FFPqlOgIoN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692785; c=relaxed/simple;
	bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1yEO32Bj3WNqRJS8jMp/klAcINJ3ti2kPke8ElkGxU9na0XgFUmbB8SkvNyz6CgDQpxRYTmQhnPoQWR2n/xGc4RzFaYRVnQV+sxhg+5CvEsdzSX3t7EN6cUAEnqS8d3SWMFYDjpecBZp7wQCftymmO1EVyM5W8BbxfW3zMNZo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq2/u5u/; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq2/u5u/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5033a2c4b81so42950241cf.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 19:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770692783; cv=none;
        d=google.com; s=arc-20240605;
        b=fpMQkgk4WXCHvjbR1EHSedW+xICNpR/Kuaxp0p6bQsYAWxsqerXsXW9bzzYslXrsJu
         RInnLkg0Hx1q/Hmlyv2e67eM293jml2zlmbHPwzA0sOLzcsikd5/O4eGDGdoJpIP1w/D
         ZMjuHj6fBdzSyksZ6DyZ/I/NE3/gk24OrM1X5HM8rRtx5M0sKdvbIUzbWbDHg+GUosrg
         Z4tSZGkRIYbfkiapSezrvjakNIxuzf4XLxvPu70zPMrzthGrz4pJCghisVR47e++LCIa
         l70+ZJbpDF97q4l13sHblpXgVAF4wzkFUxiFxoIk1uhc3odxvWmfnLSjCqwXht66vKa/
         14vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        fh=eEsAm/ZQ3Nfg6hBKYwcSgXJ272o9PxibyYpYktTXwac=;
        b=VFvZA+id935iu+sbYAwpABleTGEk0OEnLoeJELcsyHaarIcewHacpDX0NZVmM14ukE
         Kx7/cKOTim4tnVEeXfyH7To2x2LvRTU6ybUibfGSibOrnXLCOiIiX0Ax8W4Y8Vi5E8yU
         fbGS9imPqMSa6jDoQVWgB/OaAEBdtBTcFd2+yA09d88L79d8X+HVS8AY2mibtzoF3F/G
         t4q26t4LrHEPo1OlK594ucAU2sY2KoYO7K6kxRVtnw0XHUqKL6Acuoxi1g+t+arBEeMy
         BYUE3blvwS68V+OqmVl+SvHYTgt01tUAuTX8AGgnvym9AmbMObZoxWIdiDVLuO84pJHu
         RXEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770692783; x=1771297583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        b=Sq2/u5u/SR/Y3824UlkyKTDn+fQMmZNgxgCqKi7VEJUlJxBIWfL2h3MfPOxAHaCznI
         Z9AqS97gM7JwczGyrW6JlQOrsgSF7NbhOgwLrMp2iEDzX2Z51hxjehkO+olidzs1zL9j
         CpdIEhoilog5c2O0D7j+MgjwRxMkZR3GQ9RkIEzL5Ie8PHNPFqsYP/+P3fPgM/9ZSyXd
         ObuA26UsSUbJxaYsEcswwhVd3OEflgyMwUxZovKQvircRAnLx/1XF8w4JfaCIo9J4r2+
         s5PVxWVoB3jN+fO/H7pEcVZgqO2Sx+r5uemkXuwcUAMwrfv3rS/CtZ2SkS98fRUWpaof
         Mq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692783; x=1771297583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zs2JbvSIqeHpuWlBVpOIszGZrAjqw0xVXh8hmXatvrY=;
        b=k25PNlVKTTgUzrMuaCEfoKT0ECXssqwZ4dyabsxKal8nNpkU1YTIGBZBBT8cPHZ5lO
         3pK5xKgnbegIbp6d/qEid7KqXyoZStAA47l0GumnakaYiiFB25SEzRD0+/Usb83cNN0f
         H/l1dG499k5O5jqOhKJDQcq45Kccw6BovOUjSSAJtPe3Vj4MNbcLLgxKQ8tP/C14BDoT
         3NhQcMEKXNBnCRlIKDWWv5+7cW07nFDY2BIUL70FN4qWp+SY80GwePMp++pdDbqoykST
         YXPvA8MCnLIOdsgi+rZYXiRlcosvuIHKo9CMoYujbT0SdKBsDJhZ5zugK+kogI7B4CDa
         0BXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1jfx6ohiKzWF8tH34X5wScvIZGuwmTpLYC2NBp4FYmOLuAE/EXuPHjN0jzKsA9Hk3vGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9sOxiaAUZvjVoqniOIAPPr95q73pS0rriKzftBExclnKCrVT
	90sNGtIESi8ZAyrSfNLZtlURT4nmoNwLZKHm0/VGvnb2+vA04bndQHzMAXKe5ct/KCVnwMqTMo8
	TUlDWpp1XEuz8m8NHMe3FY9aX3zmGQCJfdOGs
X-Gm-Gg: AZuq6aIYOu+li24LI4fCMXqG8u441Zp8XspOki7jwrk/0zIjTDXt8WzJbT2ECdKz+fQ
	IGkPGs/4SlbrBLrC3+R4Ut2r/4MGXqivWSTMBF8+o+pJ/jfUtpYUbaVE+fq3rxHyNERpJSNSGq5
	NCNXzmgrykZ2EmzmKprOZLywijJit+/dUm6A36jpcaG3c1V7Bzzss32gw3DmzOPkuSwrSFEa1al
	Nt0HfMFCs+rGKO6xlPPDX6pSUOuq5jD7SPlISvGn1VtPjeJk7AjrbF9wv++hS5PJ5amhFY8rOwh
	GAm9Tw==
X-Received: by 2002:ac8:5e4f:0:b0:4ff:c5f7:ece1 with SMTP id
 d75a77b69052e-506399957bbmr161017941cf.68.1770692783468; Mon, 09 Feb 2026
 19:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CAGsJ_4wgG6-FvDbLw4De0r_vPO1fTH_69A2VyntabmS6H5ZM8Q@mail.gmail.com> <83e395c84c9bfa52f1abccf12ff6d39547d6bede.camel@ibm.com>
In-Reply-To: <83e395c84c9bfa52f1abccf12ff6d39547d6bede.camel@ibm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Feb 2026 11:06:12 +0800
X-Gm-Features: AZwV_QhTXOQjAfDYIo7_EqjytxWr7_a25J4WmOIDz0_JDW-Suw5MsajhD5JzpZg
Message-ID: <CAGsJ_4wymvTimJrKoq1=PRmX6BMwKp9pRH62cQ_a06Avms-0XQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 6:07=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi Barry,
>
> On Mon, 2026-02-09 at 18:25 +0800, Barry Song wrote:
> > On Sat, Feb 7, 2026 at 3:40=E2=80=AFAM Viacheslav Dubeyko <Slava.Dubeyk=
o@ibm.com> wrote:
> > >
> > > Hello,
> > >
> > [...]
> > >
> > > The continuous learning model can be adopted during training phase.
> > > It implies that kernel subsystem can receive ML model recommendations
> > > even during training phase. ML model proxy on kernel side can estimat=
e
> > > the current kernel subsystem state, tries to apply the ML model
> > > recommendations, and estimate the efficiency of applied recommendatio=
ns.
> > > Generally speaking, ML model proxy on kernel side can consider severa=
l
> > > modes of interaction with ML model recommendations: (1) emergency mod=
e,
> > > (2) learning mode, (3) collaboration mode, (4) recommendation mode.
> > > The emergency mode is the mode when kernel subsystem is in critical s=
tate
> > > and it is required to work as efficient as possible without capabilit=
y of
> > > involving the ML model recommendations (for example, ML model
> > > recommendations are completely inadequate or load is very high).
> > > The learning mode implies that kernel subsystem can try to apply
> > > the ML model recommendations for some operations with the goal of
> > > estimation the maturity of ML model. Also, ML model proxy can degrade
> > > the mode to learning state if ML model recommendations becomes ineffi=
cient.
> > > The collaboration mode has the goal of using ML recommendations in
> > > 50% of operations with the goal of achieving mature state of ML model=
.
> > > And, finally, ML model proxy can convert kernel subsystem in recommen=
dation
> > > mode if ML model is mature enough and efficiency of applying
> > > the ML recommendations is higher than using human-made algorithms.
> >
> > Hi Slava,
> >
> > Do we have any concrete examples where an ML-based proxy,
> > together with its userspace ML agent, has demonstrated
> > measurable performance improvements over well-designed,
> > human-crafted kernel algorithms?
> >
> > Such examples could be in scheduling, filesystem I/O, or memory
> > reclamation and readahead. I think having a real, data-backed
> > example would be much more helpful for this discussion than
> > reasoning about an abstract framework without a concrete use
> > case.
> >
>
> This patchset [1] is the first step of declaring the ML library API with =
the
> goal of discussing it. As the next step, I am considering of using ML lib=
rary
> API for implementing two real-life use-cases: (1) GC subsystem of LFS fil=
e
> systems (NILFS2, F2FS, SSDFS), (2) ML-based DAMON approach. I see multipl=
e
> potential real-life use-cases of ML library. But let me start from these =
two
> ones and, then, we will able to extend the approach for other use-cases. =
The
> goal of this talk is to hear the opinion of the community and to elaborat=
e the
> proper vision of ML library architecture.

I=E2=80=99m very interested in your real-world use case.
If you have any early-stage prototype code that demonstrates the full
flow from user space to kernel space=E2=80=94including both the kernel ML p=
roxy
and the user-space ML agent (for example, for filesystem garbage
collection)=E2=80=94I=E2=80=99d be glad to take a look if you=E2=80=99re ab=
le to share it.

Thanks
Barry
