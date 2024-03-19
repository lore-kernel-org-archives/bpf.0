Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E1651BB
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864600; cv=none; b=p4FuykUUWyLOyUfdr1PS73xLBB7g5os0/IpR45VIGNOQT4n90uDR7aUv6OOK7vf0g0GozptIRZ5mdH2ldfvVMqdepAn3sMNUIS6P97N6ChxiwhmmELzQvW8pv3QoIB8cIPZhCERMY6N/LvExv70JblSTa++vKHMmsH3Ee050J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864600; c=relaxed/simple;
	bh=G59Qac68EdOuM9KuC6Xcjn3FZGTtdAr7BwgN64U3sMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmliUKvilrjRrUmUJpmPZwGQsP33W09AM+2MoEFzEGe4gCtFtbISSolnyQ3bn+gFgVsBlv4WUK7NcIXqJ+brexJjqoGPwIEtfVbQv26SUpmk7EW6NZjPOQOVE/ntct+HABtbo2ga01yOCa9Zc2wNBmE0KI4BOwMqGH79FKy+EAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKmMobZJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKmMobZJ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so3018440a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710864598; x=1711469398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cwwDZot3hHkFC84q0xMrqfpJYP0q0WMDc7YeJNpK6g=;
        b=HKmMobZJeDo1ui3ySLkBsOlT1gFt7gu87P/gTSzD3fQoAd8AeM0GCiTxJPtTIp3txf
         3gGZ8ooL1UjiCdbaNAwuTExZcXXEvVc0OOtRRTHSnBT/vt9renV5gNCys9nhSP/JUQZ8
         n9XcdlKoP5oKyT1+7kryX7XVl4CeI4K42ePJCqp8pPJL1/QialIHNdCS/AxCL35eU4Cd
         NlQJh4P37a1e9XAObi4tn8sn6FSodalT7kwTDOFnqws9f25dEfmKY1ljh/gHJ82qFMwk
         FcvuXcNorvzNVpcRntEfYLro+uXAbmdrdeSwfKc48n1ToWieMPfJsfN4YDHIdEQk2AIg
         +g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864598; x=1711469398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cwwDZot3hHkFC84q0xMrqfpJYP0q0WMDc7YeJNpK6g=;
        b=S+XgNpmAfSdROC6/1OAdf4T26tA16CIpUcMJwNV95Hw8GSVmdWIid0lOQayXmgxYVL
         M44bOinwR5Yodl7KMa5yXMA+VLWYd54L4VPnx1pCpA87g9NkpJ020wCxm0vbYIIEZhrK
         mbEYEq7wFhOs+fuocE/9OOjhljK+YHMXDt5lu2brRjAueabBIIYIwcB5PGo5oalT0b7r
         tqwmTLLe1kczw7KtNlwbMQ90ey83F4BrxetnzzdxZN0TjZ+TZ5qCOz7JBj2iioYvCD78
         5xDuQDwNr148/ezi8xoodLwcW3igOXsn3Vm+PoEn/Wme+BIezzQeHF24celCKfoOJ6nt
         27tw==
X-Forwarded-Encrypted: i=1; AJvYcCUJZRTzAY4tdpdrXv2FKfhLz83DTCtLD9/L278MDnCvMxGJ8QmoUmuMJIW2rktWziLb1bWkknm5F2jI9hjcdX2v/7O5
X-Gm-Message-State: AOJu0YzeSauutwwtCgnJFde82XYX+xUnA2q+/SJ5FTbjRm91FPpQaejy
	VG+M+1XNT7RI4ZQHEU9QJrGrPsc2yEVbnZa9KBYf/erbRtWyI3CLPfF9hmxQ3CNEA3R1CKk5fGQ
	fDjqR0PL3b97VLNMLJaKyyuXrmes=
X-Google-Smtp-Source: AGHT+IHGht8XsX/FrATVqFiZffZbqhDZN8XL24b8Hwf1bqczw2gmtR3oGlH6csW0P9Zrxu2DP0r3r367ftBFifckj7M=
X-Received: by 2002:a17:90a:fc81:b0:29c:67:115a with SMTP id
 ci1-20020a17090afc8100b0029c0067115amr12760258pjb.42.1710864598449; Tue, 19
 Mar 2024 09:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318184037.3209242-1-andrii@kernel.org> <20240318184037.3209242-4-andrii@kernel.org>
 <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com> <ZfmJm21mKaJN4vyh@krava>
In-Reply-To: <ZfmJm21mKaJN4vyh@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:09:46 -0700
Message-ID: <CAEf4BzYp+rA+jov+GZsk2BjO2nBUYOe6vCL_ndiGQFP4dxH-=g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: support BPF cookie in raw tracepoint
 (raw_tp, tp_btf) programs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 5:48=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Mar 19, 2024 at 11:19:08AM +0200, Eduard Zingerman wrote:
> > On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > @@ -2373,15 +2378,23 @@ static __always_inline
> > >  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> > >  {
> > >     struct bpf_prog *prog =3D link->link.prog;
> > > +   struct bpf_run_ctx *old_run_ctx;
> > > +   struct bpf_trace_run_ctx run_ctx;
> >
> > The struct bpf_trace_run_ctx has two fields: bpf_cookie, is_uprobe
> > (there is also run_ctx but it's size is zero).
> > The is_uprobe field is not set by the code below.
> > Is it necessary to zero-init `run_ctx` variable?

no, not really, we need to initialize fields that are going to be
used, and is_uprobe *shouldn't be used*, but see below

> >
>
> I think it's ok because the is_uprobe is used by kprobes/uprobes helpers
> while here it's used for tp programs, so it won't be used
>

yep, that's my understanding and why I didn't add is_uprobe =3D false,
no need to pay for that (however the cost would be trivial, so if
necessary it's not a problem to add it)

> OTOH it might be cleaner to add special run ctx struct for tp programs,
> (like bpf_tp_run_ctx) to avoid confusion.. but then we'd need new helper
> version for bpf_get_attach_cookie.. perhaps just adding some explaining
> comment will be fine

so when I was implementing this, I didn't want to touch yet more code,
but I felt it wrong that bpf_trace_run_ctx is shared between
kprobe/uprobe and other BPF_PROG_TYPE_TRACE programs (fentry/fexit,
tp_btf) and also perf_event/tracepoint programs. I'd say kprobe/uprobe
should get its own, given they have these extra things like uprobe vs
kprobe flag.

But I'd like to leave it to some future clean ups, and minimize the
amount of changes in this patch set, as I intend to backport it to a
rather old kernel we need this functionality in.

>
> jirka
