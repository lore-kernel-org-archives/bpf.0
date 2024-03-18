Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C1535A3
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779279; cv=none; b=ATpy1ib99rxbCPghJqS424a6f3f+gjq5QCfeQoGO7ADBCHwmxdriFDGA9nvOcjAfnDRSyiYqtTqZfa+DZ9UyamFb0/guScB23zyIDuAh/MQm7FdpcIBixKSjr7OfAXTnPqnHfTB6ChohPxY6Dx7TWp/kjaLPJibOIwEh8VwalCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779279; c=relaxed/simple;
	bh=QZo9s5ESHQGW9m07Am2nOd80FgXivJ2uUv1el3Ml4Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqjlpsa6qgKRDhL3XfZAMGt0/e0/bJiW0xYOI3+slIkfm27XnMrrYJQRVvGLFviKgEPYfUChKp70KpwMvw32Aidz7XykUuIxHks4pkPpGm9/+OByNn7XrcwAchQf2S2tK7+LB5SX+qoP8ueapVWW9P8QFU2cWR1IyRvgXzYyIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7iYrlFI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7iYrlFI"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6c0098328so3769509b3a.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710779277; x=1711384077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y699/UWVViluLuRLEjXJqXWwacOFKvFvMGgBefP0DGk=;
        b=P7iYrlFI9O7z5QbiMDJLNZzD2BOyscZBB6bjj9QaRaLZ5YJ/5TppynaV/0+2ZmazYk
         bB+5ojqICQoepwMogJ16cFLHMxQ7RUic+KNeCAsIiCT5Oua/mpv4OiMx5/s7WfZeV6aP
         R5NuDZguwZ/bErHf9EN4f21NHAPwZjPE7yiGFV0E0rV7ba1LnwVakiD9ySXsMVt1mmOM
         +R2qTZmM7RKjuCPBfD2WT4smmyn/TyRDsbkKbpC5OpSYCifZesIYKNqYcO3W4Gt4v6ng
         ektilqux3SlGlXjd/5iJv8Mc69nSl6ohlFLeWc0gOaxUyOMxxb+T6b+VCRxODZIptc4l
         8mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710779277; x=1711384077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y699/UWVViluLuRLEjXJqXWwacOFKvFvMGgBefP0DGk=;
        b=rAGD1eQXOZJ9TUa+oCb05EYjjulY1mfX1NbZ2Rp8vVi+EH2WBckTYr8wtCknbCBfY0
         PGdgIhqZu2SktBkFSGK8LCiNXDSzrDzAQFjVD3pI36mqGmtGwfEJI3OcY7Zg77LZkuI3
         zObkA8720piQBdgDpGM0oiAjLXfYeaVgM3B35mqA/Ci2g1IYQAA/d33c4xy+xJ4fTUr3
         RfFgbeWY1C8YNeD1eMwhUUD91Z5TtYnS8oEtLD9UfzdVmoJMZ3ce5x01suRMLs9glgKq
         g5Yq/12L4x3n953AH4vh4jeVZ2dDS1H4P7z88ZMjybvbgrnFKJ5kvquQr59S+rChn4S6
         tO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3n/YGT92Xk2HP6tVtewDIezAe6xJamY7+A4Az4eCy0odPBnfSA2oRq/mLOHtw1Auys5Gr0oNtEq1BWlbnQ1U+0foU
X-Gm-Message-State: AOJu0YyFiCpxEeW/qmheHaWfvQeokiIciDdwESZ733puUiAyM/hdweWr
	SHRjd7SOQhGne5SVzTo/1us8APlK8Q1dbs8bFb+qMV+iVyiV7AjitpM4i1UcKgCJtrHcSAhcgV3
	7UOj62myr21JpV1cbS1W4Wk4B9imRV6UV
X-Google-Smtp-Source: AGHT+IEDg3gEigglhnhJRCkhkoGn+0raxMlzOooFDYjFzTcvVoRSEDQMQyRTB33Mxeztp5GCfcKSqZ0wWnmTP6U9pLk=
X-Received: by 2002:aa7:88cf:0:b0:6e6:8b59:1bad with SMTP id
 k15-20020aa788cf000000b006e68b591badmr212943pff.25.1710779277362; Mon, 18 Mar
 2024 09:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315204524.967664-1-andrii@kernel.org> <20240315204524.967664-4-andrii@kernel.org>
 <Zfdu5xIO0ONUCMGr@krava>
In-Reply-To: <Zfdu5xIO0ONUCMGr@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Mar 2024 09:27:45 -0700
Message-ID: <CAEf4BzarWYxKximjp4KNwagy6qhGTFrCy=48TXhzY-O36ZQr7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: support BPF cookie in raw tracepoint
 (raw_tp, tp_btf) programs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 3:30=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Mar 15, 2024 at 01:45:22PM -0700, Andrii Nakryiko wrote:
> > Wire up BPF cookie for raw tracepoint programs (both BTF and non-BTF
> > aware variants). This brings them up to part w.r.t. BPF cookie usage
> > with classic tracepoint and fentry/fexit programs.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           | 13 +++++++++----
> >  kernel/trace/bpf_trace.c       | 13 +++++++++++++
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  5 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f8a09a742e38..32dde6ce7e92 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1611,6 +1611,7 @@ struct bpf_tracing_link {
> >  struct bpf_raw_tp_link {
> >       struct bpf_link link;
> >       struct bpf_raw_event_map *btp;
> > +     u64 cookie;
> >  };
> >
> >  struct bpf_link_primer {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3c42b9f1bada..bf80b614c4db 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1664,6 +1664,7 @@ union bpf_attr {
> >       struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN comm=
and */
> >               __u64 name;
> >               __u32 prog_fd;
>
> should we add __u32 :32; in here ?
>

I thought that's why we have __aligned_u64? But I'll look around in
bpf_attr if we do that elsewhere. I'll need to respin to fix config
without CONFIG_BPF anyways, so will incorporate this as well.

> jirka
>
> > +             __aligned_u64 cookie;
> >       } raw_tracepoint;
> >
> >       struct { /* anonymous struct for BPF_BTF_LOAD */

[...]
