Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359D835E953
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158647; cv=pass; b=W6wdwOUSV6IpHHF4qKk0vtJuzx1hz6KhbcoqvvxXQEsDfJlUV9temVr0wtBD4yYBkxFdKhELzb34qy7tFMJCQvgrH19enS/aVHrHZTZlr4Hg+AY5E+nM3Bv/QYEaSHyXAhU2KnJ9XGiQ+hIrfHYRUZqayad574cel1nws5/9qW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158647; c=relaxed/simple;
	bh=doMwYSTuXe/JETZRl1N7Raoz/ERAK0foPnDNZyFizSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXF0CLscuJxHHdKHaeC2WuPdSfLTFJTfDCeMu/o8Nr7XiWQr2PjyGbmJb5HFjgpac8kuZmswG4WJfsaeypwejAMoaKu4VPNDNp9bFLvQ4ZLF8A5tVCpVEn33VHz/4bXyNyF/COWF43aXRq2WMjKO0Zn3yGWKeW5VgDv2xysPD2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JODTMHvv; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JODTMHvv"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so163320166b.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 12:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158644; cv=none;
        d=google.com; s=arc-20240605;
        b=WU+hG0TMY4Q8APpyIi0V2vO5X+XwSDL+kL21KP5DxJILgIT9Qm0Ti9GY6Y/ILe4hDh
         kBt6dgXId6hQL7EKND7tzWYS2fQYuFVtg7jIZ4xK2zfLatstN90cymLNt4ObX7tcgNmy
         vLublqxknEPtM+Gi4WwTIZE7C1/7qv3L9nwXDmWGqx08sbUGafJd6BMPnTwTw4bAMCnU
         BleQicP5RZ3qipQnSVPEakc/steB6Uff+qvjw42GUhP7Qpcuf7gN1y4bW80JPy7Z34qf
         wQJqlirB6XPsVlsnIfzlxHGjctEKSmmfeX2OBjfDqiL4lTavOayrxMEk+fQV1HdjAGFW
         HpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        fh=rAMHdh7MRXcFxydS3Pi6JwAQD3NZentisk2Z4fR6a3I=;
        b=MKgBI58/1C8CzJ6J+seFZS0SgNcWBoBTbKaP99I7cVCss7NppSAWB4kIwivGH2zcsr
         opB3wlESb84ptz4EntBZCLMkPqGlsbO8pxv5DbpRA8Dpfr1wHI8iuoXqQFI2epJaBg/m
         YglyCFl1jEWWHdJujdYd8z21BhNFXhOHtnpVU08Xf/YL6xaoVEgMbca5kg7aUd4w/dc9
         yQLwprSp1lrSCxD90+RoJWslF+Q9g08ICULn5oyQLursC6Fkj1d9exZZJcd4sL4nJCza
         thaLYuIJeN5GOGHb2lmyCWlO9mNrJiS6dHmcbzbrXMEHt2eIwwvmbXNDit1S5yVMufCv
         NuAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775158644; x=1775763444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        b=JODTMHvvyZqxvt1TS85u6XFqiirfBpBno+oIjSasOSVMES9Ugs6IIdMyDMzgvaY0rU
         qHlFkrSgW4attLx/GnfXy1VtKquehTbbtUPwnot0S9Le2Hy3Cou1OCysyB6/8vqnYuTB
         SLs74p1eieESlFXQ3d7mQQ3JAI3CYWXwFmxyBqiRb6AwSLYWDkkDMSHWfEPSfxjF/7KH
         CBsYDXyYhqug6UdzOqYVdbVN+cXfZV8jYCR4d9p15s3trB5hhytMS7L9VGnbs5K6cn2H
         JQdlyO8Kodqo5shWMien+4CWf3WqPGdDzEsy/tcIW1y4/YVWVT9Oa9Lau0AF8fuFpeqU
         2Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158644; x=1775763444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        b=p4anyN9DcBroznrxEQzvpWmZoJbECYy7v2L0HMji43omaA0x6gddcnFDhIgAaBUyJp
         VhVC/XO8g1Lg/PvEmey3llx3bazhfa7qoEAkEju/ErI8hm1K7VPoXoEk01VTOQtBNh9/
         7lqmACF9w39PTvt0MVyMXh5Br8sJ1IoKGpdpMe2NCuqT1QnCtOdPKUCgpRXeMFagOxmz
         kiN1jgv6SWDoRIADe55Y0uIv7if9sfK0cDIJ1GgcEolBjEV+0v1mxj4H586Kf7siKkPK
         Ys/vlhpF3heF+MCQcTWjkVmfIZKempnguXleIMn6INw2VlzceelkHO7X1DA6UrtoTgQF
         eQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq1kZw+uw0l11PzcCVlAb84EvoP3FNhd61kOdAWCHIT4+HRl+GRINmeL96mQoh12x97Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3/ultzLbiz6wEyUC6QMoVrCyB+xIrm+5Hv0cGe43JsMEnEHp
	u/e4VcUrdM1ys2bOB6hGcyEMKjY/KuDRmazMadz9ROvpzAp2HxRyVUufXjM31Loxom+OIoPSBzQ
	0eOirmT6Oh3fA4vV2zkJqkOvByFq6bkvvLJJzkX3T
X-Gm-Gg: ATEYQzzWhweHsFGX3lrqxysBI1nRtrIyvr9EiNiJLxBVKRsUpZ1bJOUXt+nPCbPz/v5
	cLI9bOwYms846HxA4TLL9ES7EjfNQybl/YJzKCqbY7bowL0ScR7DeSFlNCgiITvDWUTVuWpXSXX
	bD5GxyCMNvvXWIEdtmbW49jvIIpHhukflnTMyZu7LZr69Pkw5zHpoapz/ZDQBGTi0/GjmF1KUjL
	Meaf0TdD717hcrsgmksiNJns+WD4/pUJNs+dE9qIx7Kx2Po0+FNhOQlbn9cgQleAxcmndNffiUV
	PzGThuKaH++buD+0NN9E1YZDsN2fxVnWXjcjJEAYqdbCUr1u
X-Received: by 2002:a17:906:9fc5:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-b9c67b99e79mr7310666b.45.1775158643949; Thu, 02 Apr 2026
 12:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com> <2026040236-kiln-carat-bb6d@gregkh>
In-Reply-To: <2026040236-kiln-carat-bb6d@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 2 Apr 2026 12:37:12 -0700
X-Gm-Features: AQROBzBlWCEOhUiKVBdAOMQhIYruKxtYmNT9c2ETd_EsKRwXfwQK638DgBnNr5M
Message-ID: <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > > > This patchset adds requisite kfuncs for BPF programs to safely trav=
erse
> > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > >
> > > > Currently, a traversal of wakeup sources require going through
> > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls t=
o query
> > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, w=
ith each
> > > > wakeup source also having multiple attributes. debugfs is unstable =
and
> > > > insecure.
> > >
> > > Describe "inefficient" please?
> >
> > Ack; I=E2=80=99ll provide a more detailed breakdown in the v4 cover let=
ter. To
> > summarize: the "inefficiency" isn't just the number of sources (150),
> > but the fact that each source has 10 attributes. We are looking at
> > 1,500+ sysfs nodes to get a full snapshot of the system.
>
> Wait, no, something is wrong here.  You should NEVER be wanting to
> combine multiple sysfs files at the same time into a "snapshot" of the
> system because by virtue of how this works, it's going to change while
> you are actually traversing all of those files!

Agree, the current approach with sysfs might have stale values. The
BPF approach holds a lock while traversing the list. It's not a
perfect snapshot, but it's internally consistent and arguably better
than the current sysfs implementation.

> Why are you trying to read 1500+ sysfs files at once, and what are you
> doing with that information?  And if you really need it "all at once",
> why can't we provide it for you in a sane manner, instead of being
> forced to either walk the whole sysfs tree, or rely on a bpf script?

The data is fundamental for debugging and improving power at scale.
The original discussion and patch [1] provide more context of the
intent. To summarize the history, debugfs was unstable and insecure,
leading to the current sysfs implementation. However, sysfs has the
constraint of one attribute per node, requiring 10 sysfs accesses per
wakeup source.

That said, I completely agree that reading 1500+ sysfs files at once
is unreasonable. Perhaps the sysfs approach was manageable at the time
of [1], but moving forward we need a more scalable solution. This is
the main motivator and makes BPF the sane approach, as it improves
traversal in nearly every aspect (e.g. cycles, memory, simplicity,
scalability).

[1]: https://lore.kernel.org/all/20190715214348.81865-1-trong@android.com/

Thanks!
Sam
