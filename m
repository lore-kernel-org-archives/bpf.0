Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B553E00BA
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089426; cv=none; b=TdU5LjGwZKFJoLErGpmbMKdV4CYn0qavaU3eJPleGa2TgS4XhjjbefWOF/0QZjfkUsNu60YqAUh2Wfhi1m+ZgAglhy1q7QwdpIHi5XtEKp+nEoh4LsTEBnaXY/DRCgREbx/SBmhkwHU8FDXrUaPI/7XXrBXkFOMPJMtOMIwqm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089426; c=relaxed/simple;
	bh=mbadVLZ6bL0J+sZop3+3uY+JWy25lmu6eAlB9b9yT5s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOcAKn5jLnweB86ln6fpXVE8W5SKFGMlzs+IDkbubgXmoGqoA2zVEFtCFr4k304LG5Ihan00gxarG6s4soxmvt78TMPZbNzWvxOnT0/NqSoiJ+Uk9aK6DZHB5s8bCSo5GrrM3Je4MWx8IRone9uoZ/peJHf02+kprNVIdJb7ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlt0m/QI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlt0m/QI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48fe26a177cso11811305e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779089422; x=1779694222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xh/AxLf471cnVpc03r7l2vpXef4hntdNPKHO+t5c94Q=;
        b=Dlt0m/QI03JED5CqzNLKjw/g+6PibRK1Kz8WmoiwcocTbvBqMUsNvFQJrUHi5pE/Cu
         io5dtfBFiFFeLWLCXB/9LR4IfodXX3GHfDMzgLyCBFJRVPNFKb4NC8uh8PnGRDzZLyWv
         gkTWC5zFJrWwvxBt2ZJgC8g2czPKjkLg56X2wS59ZHjqPFMUmQVxpBbK4ap+PWsZIKRa
         ai/0gjnfmE1auTcGlrxNJmueYRZvK5C6KiHTeVdMIlRJQkixAEI3pQ0p2DWq3O+INyFV
         VFGLIydfF4Ntc5sfNBHSOOBPLFFt9FxxxkNeGMLH4Hv+kL2eh0qNErzUssAaxzlEx2C5
         3xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089422; x=1779694222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh/AxLf471cnVpc03r7l2vpXef4hntdNPKHO+t5c94Q=;
        b=Q0JumCi/vnae+xRHdnCRVOPgF8gjwjkI3XYt7AZKbjzg46t/fQTyfCloZUvKvCDGml
         DyIj+0eckRk5zDaTiRGtnnguKvbW6rTVmK+gLCCrSdGIaKRYDLa5xduSSutc0Lj8f+YJ
         kCsEIW7XU0rO1gWvkWAiiubYXjcyYDi/+JWF3gzK7+pPWhWw6CwfZeBm1hpDUwvjdnSE
         iiC5RYY+OSXs8BCpZyjFYn3mHS5AED/zmTcOnBA7XdCQHf7mGRSVqwlyOzvroOa+GXoG
         1tP21CNAluMAwfHVJJE9/gG7DTmxl2wAA84gKZSqGkRT79jAWhgrMxlBmX7u/Xi/OazR
         /HEw==
X-Forwarded-Encrypted: i=1; AFNElJ/fAYk9fIw4UffDomKzhcvUnorM0v5ix1SNUsiSNEr6/PEdJ5x9d5ALOhY5WiHlCHUtSvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPqwXCeEuND1kQkc0fHj5BCwUBQgfONw7xALBE4bsQOIefX+j
	hIbB27OnpMfPcpz6X0rb8zmjf03cFkm+NhtWy+vAR8hdWTxwlUsPII+v
X-Gm-Gg: Acq92OG7NzbES1BPQydbOq/6/W6YN45sLZ+DR3cnZPg5RfHWYgVsuWu5oRlgn8PzEVq
	y/kCKRD3+py+e/Mw2uAq8P9S5RF7aRty/wVIMlCto0FPcdZhqNN4zrTXOGn5DsZGFyyu+9PTmKu
	cll6qDVzZUoPqYfYet6V6qZwcko4eLSfbWOF2s9upMTFklovhjk3VGZV/QX/KNiKDqOYT0w5RYy
	g2u4nV6xjeNQ2iY5UcWz0F/x4uZ0xWmgycNqT0SYhCnSqbk+hZnq7A/gwdG37RQ8XtBmx6zg8DD
	RfT9JRdyfKIsNJCrPVnMWseIqrlZk/4uqYq9WLqDKffVhAjPGksvKqP97wnW2s1LkDJA/cFjMLj
	fFxHAbhwK3af8dZIF4Fz5fKokR90GZjgbZ6Qw74w1jbJuAQ+dwQrmC1KaHBjfyhkL95gF1mO6cP
	41DMNWar322TrZfeo=
X-Received: by 2002:a05:600c:1d0d:b0:48f:da34:ec4e with SMTP id 5b1f17b1804b1-48fe632343dmr195664805e9.19.1779089421682;
        Mon, 18 May 2026 00:30:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fcasm218214925e9.5.2026.05.18.00.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 00:30:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 09:30:19 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 7/7] selftests/bpf: Add tests for uprobe nop10 red zone
 clobbering
Message-ID: <agrAC8ytVy5aOEU4@krava>
References: <20260514135342.22130-8-jolsa@kernel.org>
 <e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91d31e0c1378fe970db6385c7af419e97af0c2acd37b3b8775a2fac02ea2361@mail.kernel.org>

On Thu, May 14, 2026 at 02:55:27PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 82b3c0ce9253..d553485e7db5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index be34c4087ff5..606601ccdc42 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> > index f00cb52874e0..0ee78fb050a1 100644
> > --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> > +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
> > index b359b389f6c0..5e38f8605b02 100644
> > --- a/tools/testing/selftests/bpf/usdt_2.c
> > +++ b/tools/testing/selftests/bpf/usdt_2.c
> > @@ -13,4 +13,17 @@ void usdt_2(void)
> >  	USDT(optimized_attach, usdt_2);
> >  }
> >
> > +static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
> > +static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
> > +static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
> > +
> > +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> > +{
> > +	unsigned long a1 = usdt_red_zone_arg1;
> > +	unsigned long a2 = usdt_red_zone_arg2;
> > +	unsigned long a3 = usdt_red_zone_arg3;
> > +
> > +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> > +}
> > +
> >  #endif
> 
> Is this test reliable across different compiler versions and optimizations?
> 
> The USDT macro uses the "nor" inline assembly constraint, which allows the
> compiler to allocate these operands to CPU registers. Because there is no
> register pressure in usdt_red_zone_trigger(), modern compilers might allocate
> a1, a2, and a3 directly to registers rather than the stack's red zone.
> 
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pass
> even on buggy kernels, creating a false positive.
> 
> Would it be safer to explicitly force these operands into the red zone using
> inline assembly constraints, rather than depending on the compiler's register
> allocator?

answered by Andrii in:
  https://lore.kernel.org/bpf/CAEf4BzZ-nASpoF+-vLYZ1D8eWRVd5JWAuhrwx8XZNrX7ZPY5_Q@mail.gmail.com/

jirka
