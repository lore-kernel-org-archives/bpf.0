Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3022EF3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391229; cv=none; b=G/TsHkdE8PsikNPLR388VoaYo3IO8qynlCJQaEujifiIimtbRW7lYBupVNPJ6xiiznWeIq3NOGnYsTmynIL3EBWvxGBfzhTVxHtQ8lyBNDr3hzpoff/G5aBy1pPrhie1CfWSUJKwua56v5+nCkrqCMOKupOl8wOme7Dxck9s8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391229; c=relaxed/simple;
	bh=Ok3cHEbOCqoXYq6UqpsUBQYpX66UX3Wh8EvM3EaWyqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5XvAesCvDbTCS5G09gvaQPMMGgF+fZIBdYUJD0OXZHc6TzCY+YVISRD+RvG7JHe4vSC2Rd7jiW0Ri3ma3LBEYOIb5wy0Wi7RQaYBN+24wH3yXiq9hClPoTbIorRxJOld+wtpI6n1KtItemlhbjfY0P2i12J6kyfPi4eLj4NdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Q20gfgyY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q20gfgyY"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0ED773FB79
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712391222;
	bh=4w5lg7DeOe3LCRsqgZwV7U/9sNfG7JcNUgXKCyuVpSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Q20gfgyYMB/a8zKmsyTYiWi0gfeAiLAemRYFjkApLtCCOIgJMWW6oCnMUbVPcWI+X
	 RligjAigKiNdBqi1VmMZenwU/b0HHt1FW1/aTRPiyIk74aq9JS2DnjnkAuVeedgmAW
	 dujwNeBg0cYC/UARqQq0JQod/ATIP6O21DKXP8c62eceLFF3nIfT3lwmmnMKZurc5j
	 yqhxO9WC2e4u0OkVkjPhpQ3y7yMw+BTeh8hfvZz8E1qHgMB7duhjrm8ylSbNJKBf31
	 ooexeVswVTcT/TR40bfbIo6gR/DoePYogqnQg3Ry9NVcjDCV/zrQKMkMR3dU2v2XDV
	 x3s99wfdBHfRA==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e54fc19bso927976f8f.2
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 01:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712391221; x=1712996021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5lg7DeOe3LCRsqgZwV7U/9sNfG7JcNUgXKCyuVpSs=;
        b=VY0N9Puk2e33CLz1/wxxbTHgbWzIFGmtGfowGnfYtPL9woErsKS8C5Z17iqgK6Tq/c
         hOBEm5TrWmcT5surMGnkz8lD7CUmfSU+fezsRPEx6V8kLkkoqTwlQvYYQ1MvtOOcwhMC
         TKgHaQRS7WgL2mxzcquRzTRec4o5vVrZAL2qym/oa+GZAyM61x99MFoDAZ6LN+vF0c+I
         gqYlcYx8QqMo7SYwJ5pa1x+QYL2tHtfxGwOEC2U5t8tWnFewBd1HW3cjSLjdpzU8pnWb
         b/emwM4aDqvibXsrZLICSITaFkTMXVFtVH62YYenQKsjl5Ptf0oS0b5hULF3RupTfhVu
         TDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWhAV7p2JL4IFyeZjBbunkEhKBVrNN+n80L2bgFm0Kx64KrwvUhiRRKpyWsfy3ojYKEQWDi/v0wtK7/ZeWgT7uTQ5QF
X-Gm-Message-State: AOJu0YwOCNxyAf2QD0N4jOCU6/xnz5VantDwJhNM0G893NWo5upFBIAc
	4cQNgeYZ8M54LviwUqABV0ND/ld4rngqeI/5zP4XvK8pLhvX4v/JhhFlXB6dZO72yj8bXT3jfUN
	u2wSbaZ6qhEgvn6mkDGEX043bhkoWeVYOhpNuwgxUohguA4+5Cqr0pBfi7+uSK6DsuA==
X-Received: by 2002:adf:fccb:0:b0:343:bd44:b8bb with SMTP id f11-20020adffccb000000b00343bd44b8bbmr2556617wrs.12.1712391220858;
        Sat, 06 Apr 2024 01:13:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT0iyPV+c5mEtz/7mmX5nHiU4zAbRw6sQgj0CzMiZl4lXnM6HwckvfVU2cBGk8aUQQoY5uEg==
X-Received: by 2002:adf:fccb:0:b0:343:bd44:b8bb with SMTP id f11-20020adffccb000000b00343bd44b8bbmr2556586wrs.12.1712391219960;
        Sat, 06 Apr 2024 01:13:39 -0700 (PDT)
Received: from localhost (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00343e3023fbasm3634187wrz.34.2024.04.06.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 01:13:39 -0700 (PDT)
Date: Sat, 6 Apr 2024 10:13:37 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] libbpf: API to partially consume items from
 ringbuffer
Message-ID: <ZhEEMU_M2qSISfxB@gpd>
References: <20240405223556.11142-1-andrea.righi@canonical.com>
 <CAEf4BzZyd2T_S+46NcKsM-Vv0mMnsgGd_Hzaq7tn4DFkD+GOGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZyd2T_S+46NcKsM-Vv0mMnsgGd_Hzaq7tn4DFkD+GOGw@mail.gmail.com>

On Fri, Apr 05, 2024 at 04:16:34PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 5, 2024 at 3:36 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Introduce ring__consume_n() and ring_buffer__consume_n() API to
> > partially consume items from one (or more) ringbuffer(s).
> >
> > This can be useful, for example, to consume just a single item or when
> > we need to copy multiple items to a limited user-space buffer from the
> > ringbuffer callback.
> >
> > Practical example (where this API can be used):
> > https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217
> >
> > See also:
> > https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u
> >
> > [ Note: I haven't implemented the special case of n == 0 as "no limit",
> > because we still need to add a bunch of extra checks for INT_MAX, making
> > the code less readable and, from a performance perspective, it seems
> > that we may get more downsides than benefits, but I can try to look more
> > at this if you think it's worth it ]
> >
> > v3:
> >  - rename ring__consume_max() -> ring__consume_n() and
> >    ring_buffer__consume_max() -> ring_buffer__consume_n()
> >  - add new API to a new 1.5.0 cycle
> 
> You also need to update Makefile, CI is failing right now ([0]).

Yep, I wasn't sure if should have bumped up the version as well
(in libbpf_version.h). I'll add that.

> 
> Please also add a simple test to BPF selftests using the new API.
> Other than that the changes look good.

Ok, will add a selftest.

Thanks,
-Andrea

> 
>   [0] https://github.com/kernel-patches/bpf/actions/runs/8576515495/job/23507610313#step:11:73
> 
> pw-bot: cr
> 
> >  - fixed minor nits / comments
> >
> > v2:
> >  - introduce a new API instead of changing the callback's retcode
> >    behavior
> >
> > Andrea Righi (2):
> >       libbpf: ringbuf: allow to consume up to a certain amount of items
> >       libbpf: Add ring__consume_n / ring_buffer__consume_n
> >
> >  tools/lib/bpf/libbpf.h   | 12 ++++++++++
> >  tools/lib/bpf/libbpf.map |  6 +++++
> >  tools/lib/bpf/ringbuf.c  | 59 ++++++++++++++++++++++++++++++++++++++++--------
> >  3 files changed, 67 insertions(+), 10 deletions(-)
