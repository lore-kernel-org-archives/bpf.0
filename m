Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9E3F4100
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723873; cv=none; b=B98xBluG+HkGx4GH66q54SqPBctUmQ1zGRG3K7K7zcjvpxxbnmBpVeSSrMhVPEiCn50mDvnStbDT1OBYEFyR+fTs74l4KZ+PE3qAmagNCb+8C0PZ3KeJ/+8zbRIzeYFrwXEbF1DgLxaxvyWRLRk43ADOIiyhIloZxopfESysiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723873; c=relaxed/simple;
	bh=8I//0fF31shqnHdQVH3tf8VYjvF+jvSDARogBpqIyJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiD+pp/arz+G3NkpXM4z9iK5dJhvUlIo5mUmzJTaZBZH10scyaVunGR2xYnVcq2YTibItGdZFbT5tyimgn/YHpfwMOok+K5f6IM5Nr2jf3qXB3euW8f7OeMKJHNxNq3EGHjJ+wGb3XNoxLbC2UkQFfv7N7mjFugG677HyMy4U2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUMl9iAp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUMl9iAp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49039a8851fso40857405e9.2
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723870; x=1780328670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GbnAv3QXs5/3MlM8KeCmv8axZFk210oLn3UWBRtrOME=;
        b=iUMl9iApVVHRPDOv5VUDQJJJoyHt3Ejn8fAMYik8e4TQoADQwwoFxxusE8zzWkSFeq
         Ty8DTakXd3gGkbTDc/VT5yrRwqHHWxFwYXxq+I71xLBG2+iP9m6wvTmg24+YvcA0XETb
         VVHd5p6EESr4gEpJfSpWjdOjyjDPzhUCOz/A8qyL4rDPvmTyHaJeXL2ywIXKgGs/RIq7
         8baYGqu1ojlH/16PmCUtCF98PNKjZBiEpyJ3zSZ0EIf+GEwOx33VqQmKqT8SMFrQ6M5A
         g7a5kEh9Y8g9fisV1wYZc/tPajXyoil5KKBxyBQXff/EFj6mlSQzv9el3enNWBqitaCY
         JHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723870; x=1780328670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbnAv3QXs5/3MlM8KeCmv8axZFk210oLn3UWBRtrOME=;
        b=TVtitB+EwBtFdx8PFSKcqyK9S7vNZwkFCoVpu9+rJRohVuzVKrdAxF0O5lH7Kz65fg
         fbat10RWattYvVs/IU2BeauM0K8HetDuaLPZTIhn9wQ+rMOA+RLZw7oiCcPle9/Jp5No
         BeqauDSxECBUy4CEPoiQqYFX2Cu49w5BVvWmXtSfi+1BgDz4g8gIHh6yhdudj5xkdAjL
         0MU2PqzXMCW2g1PFV32qDWXOE+63vpRqQw09iZH6/1niK8KRE18biGnEhAxgdrP5f1Rp
         w3Wx3AL6Gbw8l4TLIAkGstO1wRWiLCFoB6zKbaahv9VRhqdjiHyT05NhbztdS4XxlWxe
         aMHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sRFqI9I8xfcGcF4qEoNKr7hSzz8F/rl92SLNktAq0L/w8InXBXZHz8y4JUhck4wAAjq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7JOp3bXdcY3OCFe/Enk2/ii/F5VDJyHlMtHU1OMEGa0uggLN
	3MTibNdBc4b4n65gyQKYPHYwbAw8TE3/LwKdHBGWaUExMorcr0IOE38z6j/5p1EI
X-Gm-Gg: Acq92OF+OTw9hwLrKnnX1zY5DdHhiLdxT2Hj7BZVhUEpm+HeCR5WSt3LzRROjGzP3iO
	iQ20PHFj9N5wmbSXJK+2Qne4bLkSt9E6efNsW/SjwnNDa+CbUpqR88kdg02eqUXWCwd7HKtYCOV
	keXHQVzX7J/Oc2PMOVrswDawKc5YzVze+h3rdzlo1e3CynAYuliYHbOLJhlwGxrCcJy387N/uxN
	Sb2XoeHknseyNabhfJ60+ZYjXle597fwjxgXhEhwXyRPHce1O0VFQOwy++h04/pIlMTfJXmlDGK
	DYJQzZTz0EJmRjqid8jgNcs0p9412lyqJdhd7N04ogEg1VEe2n6KeEaf4C3HooYxvyyja5M+rvD
	K+ric8+Mg3WCQwNdGHQblCFonU5l8xS5PFARDdyCtN5U+li9jDtKILsIwxAnyoLbJu75Rytg0aA
	qevhBnJwTryQm8drLVML5oHA==
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490519170bamr183269425e9.18.1779723870241;
        Mon, 25 May 2026 08:44:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d48e23sm27013607f8f.20.2026.05.25.08.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:44:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 17:44:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 08/12] selftests/bpf: Change uprobe syscall tests to
 use nop10
Message-ID: <ahRuW4IfVZgyps5k@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-9-jolsa@kernel.org>
 <CAEf4BzZn0NvNwuPdh10z+MAdw-9K6CgZ0XnAL0J4XRpQHhFv2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZn0NvNwuPdh10z+MAdw-9K6CgZ0XnAL0J4XRpQHhFv2w@mail.gmail.com>

On Fri, May 22, 2026 at 11:57:04AM -0700, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 5:45 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Optimized uprobes are now on top of 10-bytes nop instructions,
> > reflect that in existing tests.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/benchs/bench_trigger.c      |  2 +-
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 28 ++++++++++---------
> >  tools/testing/selftests/bpf/prog_tests/usdt.c | 25 ++++++++++-------
> >  tools/testing/selftests/bpf/usdt_2.c          |  2 +-
> >  4 files changed, 32 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > index 2f22ec61667b..a60b8173cdc4 100644
> > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
> >  #ifdef __x86_64__
> >  __nocf_check __weak void uprobe_target_nop5(void)
> 
> heh, nop5 -> nop_a_lot ;)
> 
> 
> >  {
> > -       asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> > +       asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
> >  }
> >
> 
> [...]
> 
> > @@ -420,7 +421,8 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
> >         ASSERT_EQ(skel->bss->executed, executed, "executed");
> >
> >         /* .. and check the trampoline is as expected. */
> > -       call = (struct __arch_relative_insn *) addr;
> > +       ASSERT_OK(memcmp(addr, lea_rsp, 5), "lea_rsp");
> > +       call = (struct __arch_relative_insn *)(addr + 5);
> >         tramp = (void *) (call + 1) + call->raddr;
> >         ASSERT_EQ(call->op, 0xe8, "call");
> >         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> > @@ -432,7 +434,7 @@ static void check_detach(void *addr, void *tramp)
> >  {
> >         /* [uprobes_trampoline] stays after detach */
> >         ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
> > -       ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
> > +       ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
> 
> yeah, not jump anymore?

mixed up the selftest change.. I had it fixed already,
new version will have both fixes ;-)

thanks,
jirka

> 
> >  }
> >
> >  static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
> 
> [...]
