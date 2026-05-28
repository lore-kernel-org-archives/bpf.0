Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC733BCD0F
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966652; cv=none; b=Qp/nP42aX5pvZ/T/Cvz0qI/CsUC13WsCNn98KTeEvjcj+TjUDj1HKduIHu/NROZ2dwebqftnKiA7/QuOplCuHI5kUVkr6ihxKmDtvcmW7DCjPTZsbMnN2kkzqYXhXaU2JIwYlV+HphVWyR4xSu50kjYzm9TJ4SOhZ16IPsVtZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966652; c=relaxed/simple;
	bh=/KwnVJ2dbFKGYx9yHvg5KoYWWC4aW2SQGlKiGmzLvYU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qlze/JitPZ4jNTJxcrxllBKMORvkwehtAVvqR7OAdSvn/b8GGhOu7lada3MEeq7LnJEpW2dh9WLs2qIueWxTTQWnQJpW5IK+YecVia9ZElQ6fu6pOcu3ELl/L9hDrGPpanLQ9xybD95DBeW4CR8bIWldGnnRAFT5TOOseV5VCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5htYmZ6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5htYmZ6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso68329095e9.3
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779966649; x=1780571449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsYRPtt8V39CegAnVfUYJmqEAedS3Hwf+vTU6He99LA=;
        b=R5htYmZ6/ZWqlbYEDIgtBbk92Q5VKySdQYzMZjXZcgpMpzuPTpUvFpV6Gkg8krrtKI
         7Rl2QLEo3T9P8g1gS88FowyZuW6HN+HO0Qrks+GQEcTkFkGrcdf/1YCStk0+PYHg1QFx
         doC42Ubpaa0zs4wMNO9YEDeOK5SZsfdbtv8cPmz6AcJwB+gjjv3IQ2YoYXAZbQjGb4J2
         1CwJm6NS0dUv2pXIkFUvX6U8L+pFHEgnrRGslQqBvFwz5W/pqp/ZdLnOxzGpBvuEjDrG
         A0+IyPYdW8ODEobQc1pRiNaKI0aisGyt2Atk1GArWFvyE86VDEaI83d6IkvIYGwPw+W4
         c6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966649; x=1780571449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsYRPtt8V39CegAnVfUYJmqEAedS3Hwf+vTU6He99LA=;
        b=jv8ciWLKHQ2rpfL+XbI3s+TdumWgWF3/qAj/kUWZzzhQUYR0wooYHb5TXM8FZKNoI+
         bcne3WAebN7KfY/ABC4oGZtUl56IWROn/xJSV8pL3tIgjvDN7se8wx3B/1r/YUT05nci
         FP0nWzdksOHf4obOXtMpr4mScLrU2Cm7ZGUmiwrMUp4IGejHynNmBzsgKzbtdGWyePeS
         +BXf/VFBqASBoKvB0oC8hHU4PkJ5FX47I+Dmwu0WQiW67i7aKpYb2yP6C1CuIpmp/3NA
         l8v/Js4ujg2bBuKTKy6NRuxH0RlbOLhynCFsVWODWEmNsMyBCWY4JyBAWju1SOsJP2Gs
         rRwQ==
X-Forwarded-Encrypted: i=1; AFNElJ84JmaMjlsRvUUJ5h95ROe3lTQl2toFIWocItysLvl1DM1RA2VdKxF3yuzlR+T8LwFlZXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDOxLXl/YelsSrsKkfB+gs4R9fhRh3e1Sk2AuPuj7v42o1D50
	nWNbg/zoNFn/bjipvtgVlqimEG6B8hUi3fKiE3GAS4b0Rf8eAYxnY4Cd
X-Gm-Gg: Acq92OH7X4ioe9wjwyouEeS/mHpiB3+OY+q4kUdY2BlPMMYvLIjxLxPCixPZcJoOjoi
	DZiOai6gIlC07bE/6iLlAGVrfgnrupp3ttvlZay9NkHEYaT2UT+uplRWop4M1C3pjLQDysCI+EH
	3OINiRsCMNY1lC2AofUUsOzmmjtg+CNNXRnUcFOlnaD8boPlb0UuQxnSZgIJdhmxySI0WL2u5Ho
	ny0T+qOpCnckFBOKOM9JrNzs8agz2Ppi5cCPJOHP4h4ghd26xOhOr/rZOLZ3dWklosI3A5g8nN6
	17kcCsNq3x/uKrliKZPUU9E2QETpCyIB4zcupPVDRDf5hyRTgNHL8nzWFCrTLKzXQjv7L01UbzH
	YtEo4eZWZyq5fWUZ9v0EOt2MbCHuXjgzrBVkGSgrAti0vyHg4oar4Mh3qDkRs50eUyhqOOq1WB5
	+FNzahh/n+BJA+qXisAyzc0DmRzA==
X-Received: by 2002:a05:600c:4688:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-49042ae99afmr436971075e9.33.1779966649100;
        Thu, 28 May 2026 04:10:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b314dsm11971146f8f.30.2026.05.28.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:10:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 13:10:46 +0200
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/13] selftests/bpf: Add reattach tests for uprobe
 syscall
Message-ID: <ahgitmxJekXn_4Cs@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-12-jolsa@kernel.org>
 <87tsrt5bq7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsrt5bq7.fsf@cloudflare.com>

On Wed, May 27, 2026 at 01:32:48PM +0200, Jakub Sitnicki wrote:
> On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> > Adding reattach tests for uprobe syscall tests to make sure
> > we can re-attach and optimize same uprobe multiple times.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 114 ++++++++++++++++--
> >  1 file changed, 104 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 0868fb9793e0..969f4deba9fd 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -430,23 +430,28 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
> >  	return tramp;
> >  }
> >  
> > -static void check_detach(void *addr, void *tramp)
> > +static bool check_detach(void *addr, void *tramp)
> >  {
> >  	static const char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
> > +	bool ok = true;
> >  
> >  	/* [uprobes_trampoline] stays after detach */
> > -	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> > -	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
> > +	if (!ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline"))
> > +		ok = false;
> > +	if (!ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix"))
> > +		ok = false;
> > +	return ok;
> >  }
> 
> Nit: Maybe apply the same pattern you used in
> progs/get_func_args_test.c?
> 
> ok &= ASSERT_OK(...)
> ok &= ASSERT_OK(...)

ok, safes space ;-)

> 
> >  
> > -static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> > -		  trigger_t trigger, void *addr, int executed)
> > +static void *check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> > +		   trigger_t trigger, void *addr, int executed)
> 
> Nit: Kinda wish that was called check_attach_detach().

would need to check the existing code.. let's keep it

> 
> >  {
> >  	void *tramp;
> >  
> >  	tramp = check_attach(skel, trigger, addr, executed);
> >  	bpf_link__destroy(link);
> >  	check_detach(addr, tramp);
> > +	return tramp;
> >  }
> >  
> >  static void test_uprobe_legacy(void)
> > @@ -457,6 +462,7 @@ static void test_uprobe_legacy(void)
> >  	);
> >  	struct bpf_link *link;
> >  	unsigned long offset;
> > +	void *tramp;
> >  
> >  	offset = get_uprobe_offset(&uprobe_test);
> >  	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> > @@ -474,7 +480,28 @@ static void test_uprobe_legacy(void)
> >  	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> >  		goto cleanup;
> >  
> > -	check(skel, link, uprobe_test, uprobe_test, 2);
> > +	tramp = check(skel, link, uprobe_test, uprobe_test, 2);
> > +
> > +	/* reattach and detach without triggering optimization */
> > +	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
> > +					       0, "/proc/self/exe", offset, NULL);
> > +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
> > +		goto cleanup;
> > +
> 
> In theory we're missing a check here that an unoptimized uprobe was
> installed. If nothing happened at all between the last check() and
> check_destroy() below, the test would still pass.
> 
> Applies to the three similar changes after that one as well.

right, we can add extra check that there's int3 in here (and below)

thanks,
jirka
