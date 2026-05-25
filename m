Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04C382F14
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723850; cv=none; b=mU2EtDDBWJlsq2R/7yuSXwJsAyO8h0dhXvUm34vzOZnyqK+ChPuFXiotBz+nkLlCP7KtfxMT2ZEeNvGvAf97BUW3dLPrfXkAS4qcPZNxmoiw4SMhRDWMiWzVxV74hpckaApejh39W5KadCdqh2C3V1dwAqhwifXuEtLWBUj350k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723850; c=relaxed/simple;
	bh=PeRv/zuBKjklDXbHAJvShctHzya75FZlIB0CwBE4aCI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH+RuDGDzqiFtJZxsnnefYF9rapGTHHVWogTWe5jULwhSfc7bO5fv/x3ZYumvPWLY5sh6FjmYlV0OmGuKGuOesDFXWp+xAz4tdwM/Y5WLoZOpeZ+ysKoIe/0kum5Ebsn7kfPo3WOK6EDka4oomvtawR/Y8EUanr0OmIEM2Dep38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwdnQiW/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwdnQiW/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso8406265e9.1
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723847; x=1780328647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GuX/N/jM1mRTztcavrKb/7VNbwxABT+aEEn/gD5Zek=;
        b=qwdnQiW/r+CH2PkUUKKGZM9I9OVv4WqELRpiOjntfia9P2MQDIOLRvQwWh88GzqSle
         tpeXIb9kmWqCmzQIpHOL/a7tTVhYAX366aogTbhN/F1fQdiX859EMk4J7vNBvdwGJZoP
         WbpCcmTopi5weITlfagP8hXPzVSpZ55F2ieW9UY2GlIct3r2NcIIXqro0uDFH/8GLIL1
         PVw7n/+AdP+t4Th75eO8etWOoSxhFExFGwWeSqfNpbaKcMqI0v/P+O7vWNr0LHsSfL2U
         GKl56smdk8YmfbPigyRVav+LzMF2kIlF1intgKIdIS+sCWZrBhEp2roAIm/t0algS+LX
         VbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723847; x=1780328647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GuX/N/jM1mRTztcavrKb/7VNbwxABT+aEEn/gD5Zek=;
        b=C1I7QHWhXGRnn1vry8CM1QOa6CORi40qq1fOTqGOt9yFZbVbCELxK3C8ATQI5THcn9
         3HPKeqlVP9qbK0HgC5swbVX6sJmKKdtof2N/qPqT5zMq2SwGduhMJGOKhAHdCiSSOYVF
         jcXKNg6I/f0kau3MkuhHFPJS/mNeiPnRC8R006CDUyeQy8w4JDh/Yu79f2hGJUzNdTZG
         pTc4xgACRfpU4ALAglK0tMyrb5kZ5yI1TMZX9GENDRh1S6D62o9MSMDMKa2bkLvrk2Gw
         6tk2gsvSSvisdGNdPt5AKERJqvM7E0pultXynus/ZQACLyVKbQHn2ihosUlIzR5J9iHq
         437w==
X-Forwarded-Encrypted: i=1; AFNElJ9WnFeQcl2r25RroTlF2JkTVOCSDOOESdrTQ64+O2Vc7kI0Jy840gs5gpUrKefjK2xMTK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDpZg4v2VEkUcRyN0w+zWlIAEDySUg3x3yWQ9rdn6lRW5wrXMu
	X2f9P6gWsbGt3HLUqW6a6U/OkVp+Aht1tkKaw1qy/RqcinV4KOHm5yxN
X-Gm-Gg: Acq92OF/gBIpdr5sGnHc760eXyXGUo6YLfnCKc4VU14CJf+ge0VwR+enlW+n7PGROnq
	laA5lC+ulTXE66felbAujtBTuRhcklezsUjulylzmGc1uDOiUH4//yRjy/r1sWt4QSsWfH+nRpm
	xUS8valraUUO0hahl08tJjpk29S4nE1mpCh9uX3oTxH3xXKZhNG9MHSG6ICIw5up3GtVsPN5Zft
	lKV7hG6MDvGxNv5QUoUVR77ubwg7gt6NrSeR4mCM10HTV39fzVxTV1T4jCwTdbpiGopZvoaof0A
	fSCecyb2XvGFJSisFoEoT1fyIasnyzzzVnlOy88oc7kVs0lLwe/HL5MOP4aPLVT3SWfc2NLgMgD
	TUeGLMjmdFFQjnLGUg5qqIW9lTy459K2OPW2jQpf4awgSXymzF3Vmw+pQyadd555VFhuTnp3eSL
	R0LK4CsBwBlo4=
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr269295035e9.21.1779723847013;
        Mon, 25 May 2026 08:44:07 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428ec538sm86946705e9.23.2026.05.25.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:44:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 17:44:04 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 11/12] selftests/bpf: Add tests for uprobe nop10 red
 zone clobbering
Message-ID: <ahRuRPmrKdrDjOnP@krava>
References: <20260521124411.31133-12-jolsa@kernel.org>
 <7773c27d0070aa7544a5a7596aceb8abacb4fbdb20a3aab998f05c39de4f20dc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7773c27d0070aa7544a5a7596aceb8abacb4fbdb20a3aab998f05c39de4f20dc@mail.kernel.org>

On Thu, May 21, 2026 at 01:26:07PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 969f4deba9fd..efff0c515184 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index fda3a298ccfc..8004c9568ffa 100644
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
> 
> Following up on a review comment from sashiko-bot: is this test reliable
> across different compiler versions?

Andrii replied this one in the original post:
  https://lore.kernel.org/bpf/CAEf4BzZ-nASpoF+-vLYZ1D8eWRVd5JWAuhrwx8XZNrX7ZPY5_Q@mail.gmail.com/

jirka

> 
> The x86-64 USDT macro uses the "nor" inline assembly constraint, which allows
> the compiler to allocate these operands to CPU registers. Because there is no
> register pressure in usdt_red_zone_trigger(), modern compilers might allocate
> the local variables a1, a2, and a3 directly to registers rather than the
> stack's red zone.
> 
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pass
> even on buggy kernels, creating a false positive.
> 
> The author acknowledged this concern but kept the test as-is, noting that
> selftests compile with -O0 and there's also an assembly-based test.
> 
> Would it be safer to explicitly force these operands into the red zone using
> inline assembly constraints, rather than depending on the compiler's register
> allocator?
> 
> Reference:
> https://lore.kernel.org/bpf/20260509021238.AE98FC2BCB0@smtp.kernel.org/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868

