Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056B34AAF9
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905340; cv=none; b=hki40eRnBgCO61/IPS3cbJwWACOVR9kgFkMP80c6oMJakhkENsqJgEJE1AVbUwSG2CoKsSPLgMZ/UU1telNxZRp8UiXcPZs8hBNfDadgOyjPrcqxSpkPpA4tVIc/LjfcnLe8q7IQSRrJAGcaE/PISEtMpmBskWDIXVcAnk2mHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905340; c=relaxed/simple;
	bh=XD47VTdwe/ZJBdj6MZoWCW/UMzemuKDt7miHskXjrUs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOXB7aFVg9T+6tpHLhuux7nct7L+KTwTb2WRseMR0C2QK7F4xEQ5c2igcF/6y2++thYTIqzlAONBZYXmhVJIb2ZaqDO2YDnZF7F0Q0WoWxSTQVSf6d4PqxTEYADbwMX3FpKnrDMeuRLegJ9Fp5LOSRQ4/l7xLIEFCCrVRS4O6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvVwKXgq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvVwKXgq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-481188b7760so58190575e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770905336; x=1771510136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFCti9j+GkIzPtG9TbFu5j45QAjEOOP8FfRURZOpKE8=;
        b=bvVwKXgq46XRrNPXjK7MGUp2yJXHmWHfjht5oztSu8EcdxhwvCjBPyVUen3JZ1i7Vi
         dBIfN9LJVYYaR6BfHigZAqJu6uuBXQkAiS85/KBhXPpyZyQxsEHE7IlgSSCyn2fDugWy
         elSpU9a2aGLTxA9lIBlLy48VLhmrfpaN7eKrpmBJLOiWETK2h3lo2JUe1XwrhdNYIQ/0
         tKUoR/FIzdOon+spvsSvyFOUQLrmPY9jYAT/Scu+M0fiBTFPT36i5r6sBUbHMsT71SUz
         b7yt5WMcqmFqSItAWdxaA03VCC0wqipREIgJo64mKa0Um/6tU61MjOxZBk/wGUKMDLWx
         URGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905336; x=1771510136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFCti9j+GkIzPtG9TbFu5j45QAjEOOP8FfRURZOpKE8=;
        b=S8CZHx1YBPnn8E4rnBPz4Lq9ZYr5KIBfnGXJRUQn5Ww2+gIr7yeWrt+6Q4wfkk+1jk
         GQkNtgyakW80hPM9z4olYWBFGmyPTDg8h1ktahF2+E4yuVRu1ztXj4yLcbv9jV/IwuYZ
         b1+dH+IdZQRzlPtxa4fgBD/ZRkpiLpOMLt1cDVy5BO4nmQ8JqZujU3XNh2dHYqOtT/Pg
         P6O2n27SS+NBlv8+nAuKVp2wSsbI082Om2U6x+q7sxit5qxPy2PdWbpS2BJco935fE3l
         TqnGO1EVMKaeyC8Y2OVZ76yAU2eB0A+o4GbqyPV8VVLWmGelNJl2QaR6cAttI2noIgFk
         lWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJvaowr5iWZD65hZkIpNpjd5TFp/oSmswHjLUrw3e/pFYDPlViA+arWSKyOSjZJosBRDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFp9UNovn3k3rjHCer1WuPQjJ4B5HeOyFfszrTUIxD3L+dRgHG
	Dc4Emf/v1SB56QTlnhM/zgo1YorrQVpVoCtnu04R5gCa0/0HXu4Q4+aT
X-Gm-Gg: AZuq6aLoAbKrUQ9RGV6s2rmjK+F8cZr8OQjug0JrZE+6cSGg3bfAMvcjdlssLJrkpNC
	0UMIJEesLoth70AxxsNU5VEPo84hhTA6iSSTv1sujP8+RQyFRmfVm/pFLq9oU6thqCc44M5Isom
	boOqVvwzXiCAgrjgHVZFeVR/ng0YtzkX7y7DieOHplKIrkF05yCGKn1kOwCwJ97RjO4QHAOyF13
	rwYgtbvTjmNHmt5yu/CmQPeXQp/hiLcI7gF44y1JBYNCcmBc3IO8JuPNLyCMRExCd1jEgfv6Qzm
	ssOYIGjTXPuVAy2DOAe1qJ49St/jbchuzJ3LrlQ3jk+3whx/bJTVzi3SCWdpfAweytTUPtxlbmN
	Fwx1sMYCeRO1sxxuitLl8gQgrJ2LNNDonhQ2WBcMflL+RE+DDKrr3fVabkgwi4TbvmZbUXakx
X-Received: by 2002:a05:600c:19ca:b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-4836570f25fmr40504965e9.21.1770905336138;
        Thu, 12 Feb 2026 06:08:56 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a64cf1asm44037315e9.5.2026.02.12.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:08:55 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 15:08:53 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/5] libbpf: Add uprobe syscall feature
 detection
Message-ID: <aY3e9azas9lR_ZJ6@krava>
References: <20260211084858.750950-1-jolsa@kernel.org>
 <20260211084858.750950-3-jolsa@kernel.org>
 <CAEf4BzZ1FGHjogijuAEcdVbvmN=kakyLyi3iw1ZX5YpLfVgaZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ1FGHjogijuAEcdVbvmN=kakyLyi3iw1ZX5YpLfVgaZQ@mail.gmail.com>

On Wed, Feb 11, 2026 at 01:45:08PM -0800, Andrii Nakryiko wrote:
> On Wed, Feb 11, 2026 at 12:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe syscall feature detection that will be used
> > in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/features.c        | 24 ++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index b842b83e2480..04a225c7f2c0 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
> > @@ -506,6 +506,27 @@ static int probe_kern_arg_ctx_tag(int token_fd)
> >         return probe_fd(prog_fd);
> >  }
> >
> > +#ifdef __x86_64__
> > +
> > +#ifndef __NR_uprobe
> > +#define __NR_uprobe 336
> > +#endif
> > +
> > +static int probe_uprobe_syscall(int token_fd)
> > +{
> > +       /*
> > +        * If kernel supports uprobe() syscall, it will return -ENXIO when called
> > +        * from the outside of a kernel-generated uprobe trampoline.
> > +        */
> > +       return syscall(__NR_uprobe) < 0 && errno == ENXIO;
> > +}
> > +#else
> > +static int probe_uprobe_syscall(int token_fd)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  typedef int (*feature_probe_fn)(int /* token_fd */);
> >
> >  static struct kern_feature_cache feature_cache;
> > @@ -581,6 +602,9 @@ static struct kern_feature_desc {
> >         [FEAT_BTF_QMARK_DATASEC] = {
> >                 "BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
> >         },
> > +       [FEAT_UPROBE_SYSCALL] = {
> > +               "Kernel supports uprobe syscall", probe_uprobe_syscall,
> 
> this will conflict with libbpf arena relocation fix landed into bpf,
> so let's wait until trees merge.
> 
> But also, this description is going into the middle of a sentence,
> start it with lower case

ok, will change

jirka
