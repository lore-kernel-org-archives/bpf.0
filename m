Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1C83CD9
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408888; cv=none; b=CrTf9rCMIvsSdD1R6uijDSQ8Sfrn++2aard528SFBqDMnRYPuL3CHccxvGRSWwwLpv9lMcc2wwSE/jc+g/+kF3JhK6PbMHgOg7a0n73q83YwZjNT1uEgzwcK4MXNdoUsA+muo2+8OWu5omkMt+pJ1PFIMPyQKUCYomDIVkBYKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408888; c=relaxed/simple;
	bh=tNIHVwhM+Wyb9UWYsk600r/+VyxJkxdP2ttKiG5NpMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYyooqcF698agGkQUPFc6owjFM8UtYs4zka7dlNb/HgpBI2KrI4QincKDGjybtAru7hHNhF112baDsNT6KicDCWPGPts2pb+8xBBwXPbS/M9942Nrji+PMkM3a9dhqzn5BSBQ9mLaL7X5NP1qFczWELTPjpmPaSJarkeG+Qgcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpIDLMO3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpIDLMO3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1deffa23bb9so36673135ad.2
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711408887; x=1712013687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMTzsIjNPgCz1BhdkIpCxIGPBChcnqnuL+nP/IiBZ0=;
        b=PpIDLMO3saBSUvFkXzn09h4xecAooIt4ADbifgWEYEG3AlbWLd2zspYqxQ54aoRS5h
         Ye0/1gjAlOY2FZ6IwBFS6csnVMXmo88geTJuX5nboY6XHUeOQ7u/mmsLRX2LxS83wLLd
         BEzACtddYTk+rMsJ8FOyubZWxiFqxDex0imRRXXaANk43Gs/9cX6Jwj6UKOH9FuZ1pDt
         O8JpLBzMlC4z1OdAG+tcHUJxwNiyrEo+dT4VOwRuQdsYihRJ/t/nQxGMJEIlm2feepro
         mi2BJlfzUIa9nejKrvbYastdfRNn96VmOAo1KhbGqgW4B/u7eyydfmocqdtQiUYiKTP+
         +IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408887; x=1712013687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVMTzsIjNPgCz1BhdkIpCxIGPBChcnqnuL+nP/IiBZ0=;
        b=MFxZyEOIkn7GJT7BpzqqJ8rUWXP/JeVui2TU9VJ2THxg7TzwTusbqAapUF9ITxA4dV
         B/IFUqNyzCwnsNMYBqjS7oxG+MJ/P0zvkCS6d4zMMgxodeDQMc/L3efk5NjVpcQZmFKO
         eTkXbu8xzZ6HtU8qnUFm95Osd+rrdxsODpePdSfasecMVw+5UJsxVXg+rDB/ttmpd7ie
         n6jEoSwWtXKiWSJK0S1CkPNsy2vPkIUd/+FUT9Ol3WGrQRjQT0i48OiwuwAvqOADErX7
         8KywY/0blGZQmJzDe/Vaqgc+QH4MdyhgmyUMqXFf6SXT+0HPtUZA72ni+/WFGLBGGLSq
         GvrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lZtJbiSVU4SOXQIZ0GnxzS2DttNb3jN5znQ8Qa7lnx/32dKV94QLBznWTw5wjGw+rADx4k6+y0Yxbt/FEqDo3eCq
X-Gm-Message-State: AOJu0YzCIsU95vUMySF28XKFRSfoNC4xGsOUjpk/wxJyYQ7VyToEmE+T
	d9ILkkCgWbWY4qpmbmIMY8iXaGDPm3PonFRgFjpQMYHWrG59uLVDxfrdE72HoV2/ogFoHTAYQSl
	eFrfySxBMvMDksYyA8f8qXkipbpA=
X-Google-Smtp-Source: AGHT+IG5bT5ZIm1osGxgZO0/nIxf7dHuhCjNw920P96nsRYD3bZ9biYE84VzunhowTWB/uVqm+opjp+5CRHQ4idlk4Q=
X-Received: by 2002:a17:903:234d:b0:1dc:ad9c:4c9d with SMTP id
 c13-20020a170903234d00b001dcad9c4c9dmr11463458plh.31.1711408886632; Mon, 25
 Mar 2024 16:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-3-andrii@kernel.org>
 <CAADnVQ+pTK9_BF-wPyQBuzK4wUtraEg64Kee33w0d63iqQuiHg@mail.gmail.com>
In-Reply-To: <CAADnVQ+pTK9_BF-wPyQBuzK4wUtraEg64Kee33w0d63iqQuiHg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 16:21:14 -0700
Message-ID: <CAEf4Bza1bEq-WaAsZKpCdJGXCMEzCMYHPdCO35rh_GRevVyi0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: add batched, mostly in-kernel
 BPF triggering benchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:21=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 5:00=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> > +
> > +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> > +{
> > +       long ret;
> > +
> > +       switch (key) {
> > +       case ARG_TRIG_BATCH_ITERS:
> > +               ret =3D strtol(arg, NULL, 10);
> > +               if (ret < 1 || ret > UINT_MAX) {
> > +                       fprintf(stderr, "invalid --trig-batch-iters val=
ue");
> > +                       argp_usage(state);
> > +               }
>
> ...
>
> > +const volatile int batch_iters =3D 0;
> > +
> > +SEC("raw_tp")
> > +int trigger_count(void *ctx)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < batch_iters; i++)
> > +               inc_counter();
>
> so it's passing the verifier due to bounded loop logic, right?

yep

>
> Then let's limit cmd line arg to something small instead of UINT_MAX.
> Otherwise users will be surprised by the errors
> coming from --trig-batch-iters 500k

sure, I don't think it makes any difference much beyond 100-200, I
tried 500 and it made no difference. So I can limit it to 500 or a
1000
