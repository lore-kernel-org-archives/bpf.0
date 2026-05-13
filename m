Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DE29AAEA
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633487; cv=pass; b=NAWWzbX+WCF66TehNb3yqRIT0vNBe/sj09jaZtmLdmHnLt+5iMFk/Wap6MAYp74Dk7s4/nGik4bT/uJkpl4l/4ePEs4nesYY5CRqmQRXEl95jjIG0fcCLZvXhUovyDAsdDLih6j54IjIuswEiJ5j/Ca8T5eoeVKSRHrd5l8vCHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633487; c=relaxed/simple;
	bh=izyNufNv3l0EJK2+rtZ1T7rBl3b1uNLGp9DIpmbczBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc9TNPcp6Zt464WQHSWc9cqIfc6IMI9GMoNtqQnvTmvVb5Yd0C/ItFYiEA6H3C8MdzteLjUkHRH5XPL+LFUIaQgHPPF5TZjHEzaEmgKZP8suvvatg6VS6IngpCz4hmMUB8JDGuMkNmwjDbR76D8oHAt7SH1jMz2DElRMzzVsLRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pC71eVXu; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pC71eVXu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44b052142e1so3418535f8f.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778633484; cv=none;
        d=google.com; s=arc-20240605;
        b=L3zRzksvOWH0fS6bB7qHlmreY72ShnHzMlLBLFgSWKmeYIMp0wL6PxEMVKqdFTCO79
         zPjh1ySPi0ao16aSqr3osX/XFy9bhyVn7OsESazENW3X8bH4eFNi2z8CFedHOGQ9zlkx
         qeZKCjJMxUT90YK2qv1k7rJGldgb18133LEKmaE2O9NZlscRCDIK2Mybbf6oDWL+aaPF
         J54DklAnlb2IHLefHd3K+egy6LG5Q8JstsJRacnZAPf6tkNpkF1Mv54zSLAJVorKzn9Z
         rGb5R8XqfxK8cl6gnqpiCoFY77i9A3TC9teXmRRWvOBJiun0QlEjUa2lhhWZQ9rWUW9w
         MB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        fh=YBh0UWSmic20FoZQUVh5rBLcCvoPucO5o5HwpmzjAf0=;
        b=eYKGQmb4pwzvm3CXKYhR3sK8DqWPAVbfENvqf2AWyxIvZjerlIB1UMSaCu/7QKM8ZG
         EkXLAz+wyox0zCPASwj3D2jXTqmTVvIps1Bej3E5lOe+2fSVG4HdsUiPB8YpBXds4P63
         nw0464VvFafil/XZt8LtvkOXIphMWPYmsHjba/amyCJk8La1jEiEEn3mt6jjJ7M/Ui0V
         RIZ+YefLcV2eyqSECf9VX0FvPuZvUjdzCnuL2I3n7mX2Hm4goXKB2MlbEzx8I0TE0DGr
         fNOIh85rpneg1GV9YhWFrhbS1zfDbJXHXIviuZmUDmBEENrnddzNG2KMmpZ+yZMOQ8gu
         vepQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778633484; x=1779238284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        b=pC71eVXurgf8caoIXfmSy14jVsV6DMbcG3ZpiY3KbFvMTBWgSBb0V0Ev8LJ3eUx85z
         wb3FpsxuYOjXuky3A/MVX3+s3HnipsymhSvhNtKXddtSWPKT45kmbxrQPOClpE08eS9k
         Fs8Z4a2y6C1CRwMedrrVbj8bCjJr5XGagYLgyh0KacbQPlKzMJ6Ewzn/wq7B1SpbUls/
         5GrpGwLl9OASDSpYmyTqMAQ1RtM/ZlIcjGAmZHluO5cWODf3PtmlYCa6sNOxO9ZFTDqS
         tOWjy2Bpdx+dFcsUZ5V7D+M5pJYH+tV20PYEJSPs97Met6N06ELVEl2HOhVPzlpdzrXI
         y4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778633484; x=1779238284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0yqDbK591ypC5eJWQGsP1nPlMWdMRq98a5gApsWXZY=;
        b=OWkONE+XS5jfcTRgyTQBJD/RX3v1Q6GHjtn9gQwYs1mvjRN2cDwToCatgj4LmYrUC+
         zRDYsmcu4LOII5/KNQ+g6QR1chQp1SNK1e0wzcW360fmpIo2ttW7RhQmQr1a4dlWvpWL
         9LEzEAy8ZHQtV0W3YTqtJ66OmSqQD8zm5+hChehF/XOzMwQIvVriMJS6seuWtPpAE8ro
         u2GNR97oAJVk/w3sDWxaJVI4NuAqITCSL8jYOChTi/zfVaW9iP8Vx1Q+wzgrGNUlnOxF
         3Rf98gWlG/ARGNZCzmg+q2gyrFnKhnZrMRtjh+q1Fs8jD0vLLts8afsIH8vi/0bXU1XE
         rV0g==
X-Forwarded-Encrypted: i=1; AFNElJ/4OavB1IzJ3beiY3HsdEJUcW6oycuT4/JJHKJ+kQeunsS0VTR9HB1TL9A9m0/+7p0j548=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tH1FLjAU7mrff+8g8xtYl7ttKzfIZ3o25e6nu6hXeX9T+z6n
	sCV18t8tT5BJLCpcsdpq89cPeCNTFMvI8mJ0DLJpWaERo6yecWABV7l5Y6qA4xKfrO+Otu0BnPb
	bCEF43M3ClGvR2aTVi34QEqbMm40YRzQ=
X-Gm-Gg: Acq92OHcwtzXWWLfdUFA8xZpgKIh/Z9leYFcw19MRuFn223356MP3nTYFhMGgJSdKAQ
	2lJ6zuSrAJHJWMFPGwtLtMoK+btlwYrKozOXp+4OuL06IIluFV24BaTHpAFcO5W5RQSF8icemV8
	L/5mjeongoR/kdVQX/ZSgyMIw1hhfqfonNEOY/cwslo8acgL298ws7083JOjjsQOP7mS22ifXe7
	A2r2EzLCz3dSyYqDQpPMW+BRSisYgT170qDZpfD+Sn7nexbGtL2AMoovzr8DFskO378qxPp6m7L
	ndHMgFuQZN62rLarWCaqBlQDZZajVirXE4UFw1ZUSFTxXPpXD0YzmHHSDUXA1st4NBCAiBiFJrq
	JwdQbcrCQmcjrf3C4vrDcMFuHkg==
X-Received: by 2002:a05:6000:3109:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45c59702e8fmr1423029f8f.31.1778633484225; Tue, 12 May 2026
 17:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com> <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
In-Reply-To: <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 May 2026 17:51:12 -0700
X-Gm-Features: AVHnY4K10O6Mxpl9QjZAt4PGuFBG9tJtHHyQLjkej2TGD7aWVby8-50dFABh7DA
Message-ID: <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Samuel Wu <wusamuel@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 1:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> >
> > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > wakeup_sources, and puts a config flag around the sysfs interface.
> >
> > Currently, a traversal of wakeup sources require going through
> > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to qu=
ery
> > sysfs is inefficient, as there can be hundreds of wakeup_sources, with =
each
> > wakeup source also having multiple attributes. debugfs is unstable and
> > insecure.
> >
> > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safel=
y
> > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > sources list is needed to start traversing the list.
> >
> > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > speedup (sampled 75 times in table below). For a device under load, the
> > speedup is greater.
> > +-------+----+----------+----------+
> > |       | n  | AVG (ms) | STD (ms) |
> > +-------+----+----------+----------+
> > | sysfs | 75 | 44.9     | 12.6     |
> > +-------+----+----------+----------+
> > | BPF   | 75 | 1.3      | 0.7      |
> > +-------+----+----------+----------+
> >
> > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > iterators [1]. However, BPF already allows for traversing of a simple l=
ist
> > with bpf_for(), and this current patchset has the added benefit of bein=
g
> > ~2-3x more performant than BPF iterators.
>
> This looks good to me, you can add for the set:
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Rafael,
how do you want to route it?

If you ack it we can take it into bpf-next.
I'd think patch 1 shouldn't conflict with other 'wakeup' changes.
