Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3D40B6D9
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906783; cv=none; b=Lt8i7eI8tkJ8jCWWOqnaPpYiE6Vt+k7vy9n46G6xTmtaxY7Ntzi9QjYRgNcRpErlJq/9DnrbxfxIo3QeYEFSkRu4KtVfvjL8Kf1M+fFujecGXJQbDMfGrGBarDwK9eTxj+LMhqrUcy/6finqEuioLykArhTEKO38GfNAlRZymOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906783; c=relaxed/simple;
	bh=YstouwT8ARs8xDvHBmp2Bqf2YY58eY8Ejf+cHYRHRSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li3v1HQPjSksBQcDqkP1sWGZvyz/UfP5AY/n3yoZAX9KXiziNuSMo3VrduNjhExolM2fUivavPStViI+yjiUCXPpZ0bTXLFeqc07q7x62tofCuOI36sLP/rQVmazImL/pSIa+L/yYZCS61tx54ZaHyjHgdgWpbCjofGai+OLTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: +msueeiOQmqwla+eIzxngw==
X-CSE-MsgGUID: bmp0DpKqQ4qwiKcoARA9ZA==
X-IPAS-Result: =?us-ascii?q?A2GABAD5Xm9p/zcImYJaHgE8DAILFYFQg0iBaoRYkXQDn?=
 =?us-ascii?q?i6BawYJAQEBAQEBAQEBTQ0EAQEDBIUAAox6JzcGDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQEBAQsBAQEFAQEBAQEBBgMBAQICgR2GCUYNhAeBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARcCDX4BBSNWEAkCCwMKAgImAgIhEgEFARwGE4MDgnMUBpJUnEeBM?=
 =?us-ascii?q?oEB3XotVIEsBhQBgQouiFMBgW+EAIR4QoINgUqCPTg+gkoXAoErARIBIYNbg?=
 =?us-ascii?q?mkEgiKBDoMIiHKBCYZlJgkdAwcHDg0eRg8FHANZLAETQhMXCwcFajkoAhkBA?=
 =?us-ascii?q?gGBBSNLBQMRGR2BGQohHRcTH1gbBwUTI2wGGwYcEgIDAQICOlMMI4FSAgIEg?=
 =?us-ascii?q?TBje4IBD4cQAYEABS5vGg4iAkFSAwtiCz03FBtKkABHgTyCHBAggQAxMRIeL?=
 =?us-ascii?q?Y4xB4Qmg1GPD59TgT6EJoRRH4culVQzhASNE5lULphYjgmVZ4VANRKBSIEQc?=
 =?us-ascii?q?E04bAaCMBM/GQ+SIcgeaTwCBwEKAQEDCZFsLYFQAQE?=
IronPort-Data: A9a23:FkbWJK9MwjMT1osP450mDrUDG3+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 2ZNUWmEMqzZZmegfd8gYIm/9EIOsZSEn4MyQABu+X8xFiIbosfsO4+lIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48z8kk/rOHuagYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWQtWo4ow/jb8k035a6q4GpwUmEWPJingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445jXBYuQR4/Zwahxrid/
 O5wWamYEm/FCEFsdNM1CHG0GwkmVUFPFSSuzXKX6aR/xGWfG5fgLmkH4Ojb8uT0984uaVyi+
 8D0JxhOawueiu+354u+U/Zoj4cuDdv7OowA7yQIITHxVZ7KQLjGU+DG6NtZwjoql4ZTEP2Yb
 sFfayIHgBboOkYXfA5KU9Ru2rr17pX8W2QwRFa9pLE34nnayQVZ0KDmdtvOPMGHToNclQCav
 goq+kygWk9LboTPk2vtHnSEjOrXxQ/je5srSKSn991hh3Sp7z0hIUhDPbe8iaPg0BHhAoM3x
 1Yv0iA2o4As+0GxCNrwRRu1pDiDpBF0ZjZLO+gqrQ2AzqvK7hyIXC4ZQzUHYddgttdeqSEWO
 kGh3NbyGDFisZqsTGuC8r7XoBKgKS4aMjpXDcMbdjfp9eUPt6kRtnryojtLFb7wgtDxGC/92
 SHQ6jUzjPMahogJz81XHGwrYRrx+fAlrSZsuW07u15JCSsjPOaYi3SAswSz0Bq5BN/xo5nol
 CFsdzKiAB8y4WGlznXXH7pUTdlFFt6ZMDCUnFhuAZQ77DWx6jakc8hd5Dx1OF1ud80DfDr0Z
 k7YsB9Q45lIVEaXgG4eS9zZNvnGOoC6RYS1DK2PNYETCnWzHSfelBxTiYer9ziFuCARfWsXY
 MzznRqEZZrCNZla8Q==
IronPort-HdrOrdr: A9a23:Apy0R6rb5poNbP4cDjaZG68aV5rQeYIsimQD101hICG9vPb4qy
 nIpoV+6faUskd1ZJhEo7vrBEDuex7hHOFOkPMs1NuZMDUO21HYTr2Kj7GD/9SIIUSXygc678
 hdmsNFeb7N5DZB4/rS0U2VNOll5/Gi3MmT9J/j5kYoYSZUL5xR1isRMHfjLmRGADB8I7cEPq
 f03LsgmxOQPU5OTsO1ABA+LpP+TtTw5e/bSC9DPT4LgTP+6g+V1A==
X-Talos-CUID: 9a23:Vm71XW1/8qdK+fJziNPRBbxfWcU+b3DQzVDpJlanDW8qRZyHWVmf5/Yx
X-Talos-MUID: 9a23:vVOrCwklwB1/HWaweq8kdnpoMd8wz7yNEXlRiIoHmMKDHBZZagW02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106920829"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 19:59:37 +0900
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 685511839F45
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:59:36 +0900 (JST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb6c7874cso56712337b3.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:59:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyofcPjnU7LtKZZLdCiCUJLWUp3yeHKqBcMPqc/IzJE5KkWfA8GbsTi1jeYwivkvxeOho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsFsbCSFMpte+21E8R/v2yvP7vczBHKGenc08MWjesRRuV26Yp
	1OFzyv5n/QjSYntC8inR0gXuFK3DQ5EV8ndA1l0jOX9wYNjyfBdNxJvqeV9Twcey2iSc/e0eKiA
	jL1sd81BNtjiR3zupkPr+ULLh6qvOsBtc7eCn8yrycA==
X-Received: by 2002:a05:690c:38b:b0:794:93f:99e2 with SMTP id
 00721157ae682-794093fa369mr10121547b3.23.1768906774610; Tue, 20 Jan 2026
 02:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070336.188850-2-ishiyama@hpc.is.uec.ac.jp>
 <cd994531bcbe33858623d135448bd0540c36bb739b894af5a99d009b617e08fb@mail.kernel.org>
 <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
In-Reply-To: <3d9e2ce9-3e47-4b10-aad2-93b37b235239@redhat.com>
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Date: Tue, 20 Jan 2026 19:59:23 +0900
X-Gmail-Original-Message-ID: <CAJjCV5GRvVi5M=vfiz_-hDHXyC=ziiu12vgzeZrxcy1jqHZxJg@mail.gmail.com>
X-Gm-Features: AZwV_Qgrr9ej0w2i2fxq5c0Ocj2PjDgWZ5Wf1sI-3U-sqMI5Xi2fsY-HzoK6F1g
Message-ID: <CAJjCV5GRvVi5M=vfiz_-hDHXyC=ziiu12vgzeZrxcy1jqHZxJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strncasecmp kfunc
To: Viktor Malik <vmalik@redhat.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, mykyta.yatsenko5@gmail.com, 
	andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I'll send v4 soon!

Yuzuki

2026=E5=B9=B41=E6=9C=8820=E6=97=A5(=E7=81=AB) 18:29 Viktor Malik <vmalik@re=
dhat.com>:
>
> On 1/20/26 08:21, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 9eaa4185e0a7..753753f039ff 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >
> > [ ... ]
> >
> >> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool igno=
re_case)
> >> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ign=
ore_case, size_t len)
> >>  {
> >>      char c1, c2;
> >> -    int i;
> >> +    int i, max_sz;
> >>
> >>      if (!copy_from_kernel_nofault_allowed(s1, 1) ||
> >>          !copy_from_kernel_nofault_allowed(s2, 1)) {
> >>              return -ERANGE;
> >>      }
> >>
> >> +    max_sz =3D min_t(int, len, XATTR_SIZE_MAX);
> >                    ^^^
> >
> > Can this truncation cause incorrect results when len > INT_MAX? The len
> > parameter is size_t, but min_t(int, ...) casts it to signed int before =
the
> > comparison. When len is larger than INT_MAX, the cast produces a negati=
ve
> > value, and min_t returns that negative value instead of XATTR_SIZE_MAX.
> >
> > For example, if a BPF program calls bpf_strncasecmp(s1, s2, SIZE_MAX):
> > - min_t(int, SIZE_MAX, 65536) evaluates to min_t(int, -1, 65536) =3D -1
> > - max_sz becomes -1
> > - The loop condition (i < max_sz) is (0 < -1), which is false
> > - The loop never executes, and the function returns 0 without comparing
> >
> > This would make bpf_strncasecmp("foo", "bar", SIZE_MAX) return 0 (equal=
)
> > when the strings are clearly different.
>
> This is a good point and we should IMO address it.
>
> >
> > Would using min_t(size_t, len, XATTR_SIZE_MAX) avoid this issue?
>
> Other string kfuncs use `i < len && i < XATTR_SIZE_MAX` in the loop
> condition, I'd stick to that for consistency.
>
> Viktor
>
> >
> >> +
> >>      guard(pagefault)();
> >> -    for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> >> +    for (i =3D 0; i < max_sz; i++) {
> >
> > [ ... ]
> >
> >> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__=
ign, size_t len)
> >> +{
> >> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
> >>  }
> >
> > The BPF verifier does not validate ranges for scalar kfunc parameters, =
so
> > BPF programs can pass arbitrary size_t values to len, triggering the
> > truncation issue described above.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2116=
2711653
>
