Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3841EB5C
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178558; cv=none; b=fxNX8zQ7RxgrBk5IozeuX1dX0SGCnTLJRb2b4VySrPx/f3ykNsR6/SwRxhao1bGGHzJCFjybCDb+DlSeLHWGE0by2HErzOEOFNS2q2kC/LD5Bm+dgaFBEgikGjHASXoMv4Q2r95FqGLl2Z792UxPGyWXEw2vtieZkpQpeiuBhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178558; c=relaxed/simple;
	bh=jIZzAPDmpo8eeWzWJTQGn97v4WRN7R2lWViFjScTcQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBRn7etSavXVX3Lygvzr2G8RvQkfbmUG1iS0yj6MSSb5/m0KRMx2+N5aQ9ueNJJS4YaAT/OeOLsqtxBipipbd7zQ9LBHU57US2B4chQCC+9x0N9WeYbAtuwgEIAOeeUPz3fXqChHY73VP610boMk3MJYGEgANww49pv2ohqnqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGAkbZJS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGAkbZJS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso649368a91.2
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710178556; x=1710783356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwchO4wI/5kCqws8JxW6yJAyPRjqDwotrWweWTGArUI=;
        b=XGAkbZJSFBojRiqYfgHtrsplM/U/+gNEuptLl8LRQXkPPv4iYBOphPypfscYXmDXD6
         KHYWQ1Hqrl8ECutq2jV2d2pX5jTGqRaxudIm8gnJUCjlE7S3UJ1cFw3/h/IS2gNnz/4M
         ZQfSOAbulRgofIp1/ONr1Ulpo9nfxI51zUrpjLzRgoLltRaNWw8LOxb5RTPQOceQSeW7
         kNa5+AT769XbpkrAq/eci7tZnHYwgLAiAVOqnd09ZO4+l1YZndwEY1bqgSkEsJV44qwU
         +Iz/xWsx83RrLZRnC5GiuutS3wyLjWEAfm95KeCWq8j2u315NE6eiPCx+mJ/ai94XoOa
         pevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178556; x=1710783356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwchO4wI/5kCqws8JxW6yJAyPRjqDwotrWweWTGArUI=;
        b=T3yaKcl/J6hrFdBQ61RZGSB/6ZwyeMmif27Z2gWCeJgd70lBnkCl6oQ/Zzru45t6vM
         wUXuvQXr8vN6iaBj5oHHdL+xI9rOdOVqw8uiQVxT/J8HXlGU8yjpGQBh+t+MlPl9llxw
         rsnURfUmUwpTi9XUl/fhTj7utGwMDv9JjCty34tPkkwtXk+SPo/8bWVLd3EB+mPZte6n
         tTm43QapE8p0jh9+TpB8w8Uw5sfaq4Ipkhx9zH2xh5ZoQZ09v6X2VH8KMxyn3dr2QuYG
         tIZg+9HrNSazD87sZIRhK7tYjl0dNCVqERUv36OI2d0yxgyuzTS9v5gSLnKowlM2WnET
         3xPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAgRkdKsDtnas63d3aqWRLqT5WxA4LS9aQmHDOxl9bOrYwIKqVOBbpfflC8UCGb+lTvPSQd/HKowcCaDZywggO6aB/
X-Gm-Message-State: AOJu0YyHDh1H0ijHEuH2G3NvnnmOLJ36I9riNAFk36vCa4rekvtzkDzB
	qOWIsRqBDpD9fp+StNgujLX1Vt93/l0vw9AxuoQE4cGYkeWXX1YmQsa6tzBtQV+8XP5T1I6+EcQ
	b0ks7Tq4c5GaLdto7vBOVbtlBZu7LXE53
X-Google-Smtp-Source: AGHT+IH8dyp56w9D0GvwrN8A51Qb1vkRxXY39U/rIocdvIx7FzMAoq7P08/V/E4vTYZS51wk+RugXo7QA28znH9c8GQ=
X-Received: by 2002:a17:90a:dd89:b0:29a:be1b:6fbe with SMTP id
 l9-20020a17090add8900b0029abe1b6fbemr5076867pjv.31.1710178555830; Mon, 11 Mar
 2024 10:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309004739.2961431-1-andrii@kernel.org> <Ze6-qm9A4ytf_tcR@krava>
In-Reply-To: <Ze6-qm9A4ytf_tcR@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 10:35:43 -0700
Message-ID: <CAEf4BzY+=L_6k-JUv-jDK6PyWP3V_Pp8oBcYwtJd-yXTPSsajg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: move sleepable flag from bpf_prog_aux to bpf_prog
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Mar 08, 2024 at 04:47:39PM -0800, Andrii Nakryiko wrote:
> > prog->aux->sleepable is checked very frequently as part of (some) BPF
> > program run hot paths. So this extra aux indirection seems wasteful and
> > on busy systems might cause unnecessary memory cache misses.
> >
> > Let's move sleepable flag into prog itself to eliminate unnecessary
> > pointer dereference.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> curious did it show in some profile? however lgtm

Not really, micro-benchmarks won't show this. It's only on busy
systems where CPU cache is heavily utilized that this could make a
difference. I stumbled upon this just by reading code and realizing
this is now not just a verifier thing anymore.

>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
>
> > ---
> >  include/linux/bpf.h            |  8 ++++----
> >  kernel/bpf/bpf_iter.c          |  4 ++--
> >  kernel/bpf/core.c              |  2 +-
> >  kernel/bpf/syscall.c           |  6 +++---
> >  kernel/bpf/trampoline.c        |  4 ++--
> >  kernel/bpf/verifier.c          | 12 ++++++------
> >  kernel/events/core.c           |  2 +-
> >  kernel/trace/bpf_trace.c       |  2 +-
> >  net/bpf/bpf_dummy_struct_ops.c |  2 +-
> >  9 files changed, 21 insertions(+), 21 deletions(-)
> >

[...]
