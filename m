Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7322657D1
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864922; cv=none; b=QnyZQyVTWprvsyfa8PnAzLpPoYuP7dW/HzNc87+VtNRFhBrSBTva+OXUVdurLvC0KZtTnS7kPi6l8g03NiF1ul+5QGZ1n4xU+3JUdUJi6lvcnrEc1fogxp6NY5JgmuurYxd8R3QZFkxgmlgXKDPxNNa71zDXmfeEgrtC5uUHniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864922; c=relaxed/simple;
	bh=ABTyS/Xldihvqv79z+xvxVBaj6bDNRwDQWTqTyOHbg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9LJarM3RRuos4AbeVZSzPj1xVNoAGxrbXqwGeCoaQxYqfQSwCdK2O4yvg7cubEJx0tBYRtsHYJGwoAAf0+sO1xirxIDmxdTOe9IblLn+ypRCvO+aLY/b/lzo2r97Rkvbce2693uEXFQ5bnFBR8SFQZcaSaLqpb4huLZPDls/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqGWyzfh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqGWyzfh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc29f1956cso34618655ad.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710864920; x=1711469720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWW48VjvS8IATwUmFC/oK6i1usReaIWqNgBiuMMR0ms=;
        b=AqGWyzfh3vC4QAPIUnqUubDddFH+tz/S5ekGpLIjKqKY4RrdM5gRfW4HMfreomW4Il
         gmjhG7Yb6Qb+auH8eKeUSI3+VMigY2PaM5tqGC5VYXGRrVG1wzwDVVO24Md9Ex0ygnv8
         KAXxQRb+6wlUF3XQwGnQUWpHFFPiYt1QaG0+0sXszUuvjAqsY49rTKJB75xCaCaxfrLC
         jZctvAys69F3lbO6qH39Hg19oLoDYDQ2c5vR+jyprWUNh8vABTz54/OwVWcRb1aR7nv1
         2v7zRuwoci8R9TtcWFrOEbNRSUCZY0S18kfkMfkHJARpeo+sRFT9xg7kkktoExIsEygj
         WLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864920; x=1711469720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWW48VjvS8IATwUmFC/oK6i1usReaIWqNgBiuMMR0ms=;
        b=qIPTBV27u9a9tkWD3pfSDHo70ohAvZkBMeMaG5ItSI4pu6l4hK7+KkTZzm638W+rWy
         LnQoXMxvovQMB0LqxAe3XH6bhB5Kk087T+DnMaZlo4R8UGRUlnnVs5uY262p3h5QHkJI
         DCMeIThxsmsC+Wig35PaZpHJanHt2+lrPLPJ12xVrrUNSnZ/0JD8Hrb2ZyF8YkL6xKGF
         ITCtX/DaSg7nhA5sGxIscBZ+bpZGaQs2T0LkP2K8afBRPk14FUbBPsCr7oDB1i+S34Yn
         icZ1R4jGrfK+15f4ILHKpDhVv9aoKjmPsIOu8YaWKtddrm34SBlMetTFjFXv1Vy2+rme
         nJGA==
X-Forwarded-Encrypted: i=1; AJvYcCX0aTHRUHpL1ILiN9ePtfdYJaGK6cPl1upu4nhi7xJOjhhkj9idOdgZVGITf63hMQrJH2BIxILbecuZSq5cSmZH7zNw
X-Gm-Message-State: AOJu0YzCsXi2gPG4SGhdLkUNfUENplyKdoNYC28oA2Qjpx6PGcrdx2nG
	qUg7TZcUbwCGLHrG8THsgyTzOoZJSWt54vKhbzIlK7RO+lPJRzz4isGu6GbOJnc3ClTw0TB+kx7
	yKUzwb/8XrGfYF83fgD202VPIvHg=
X-Google-Smtp-Source: AGHT+IFeABnh3OMeZJXqAYW6j9hlCmRFV+CBJvDKqNQKk0J2yt8USqyjGdZeP1G1tHgekwDOth1C+ePAB3TtRJrjxX0=
X-Received: by 2002:a17:902:8bc6:b0:1dd:6eba:c592 with SMTP id
 r6-20020a1709028bc600b001dd6ebac592mr14154792plo.56.1710864920107; Tue, 19
 Mar 2024 09:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318184037.3209242-1-andrii@kernel.org> <20240318184037.3209242-5-andrii@kernel.org>
 <CAADnVQJdkMgLGGBb4eGJP+gaNjM2BJF7bWew+ZOHE5GEE8Sxdg@mail.gmail.com>
In-Reply-To: <CAADnVQJdkMgLGGBb4eGJP+gaNjM2BJF7bWew+ZOHE5GEE8Sxdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:15:08 -0700
Message-ID: <CAEf4BzaAgt3f5Nzc6qqeFWOim67ZpDjpPCJuKEKHpmsTxDbmQg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 18, 2024 at 11:40=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> >
> > -int bpf_raw_tracepoint_open(const char *name, int prog_fd)
> > +int bpf_raw_tp_open(int prog_fd, struct bpf_raw_tp_opts *opts)
>
> ...
>
> >  LIBBPF_1.4.0 {
> >         global:
> > +               bpf_program__attach_raw_tracepoint_opts;
> > +               bpf_raw_tp_open;
>
> So far all api-s that accept opts have the "_opts" suffix.
> Why deviate from that?

_opts suffix in API functions was never really a universal rule. We
were adding xxx_opts() variant if we already had xxx() that didn't
have opts but already existed. But for new APIs where opts were added
from the very beginning we usually didn't do _opts() naming, e.g.,
bpf_token_create() accepts opts struct, but doesn't reflect opts in
the name.

In this case, given I decided to go with shorter "bpf_raw_tp_open()"
naming (as I found "bpf_raw_tracepoint_open_opts" way too verbose), I
decided to not add _opts suffix.

It's a different question on whether to do bpf_raw_tp_open() vs
keeping the original long name bpf_raw_tracepoint_open + adding _opts.
Let me address that in Eduard's email.
