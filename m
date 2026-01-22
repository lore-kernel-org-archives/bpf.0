Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFB3B95F4
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070912; cv=none; b=bQUYdpa0rLnwT0pJ1yz/5QQnImmdjlcqpajs57Vqvs5QrtRHSv/FcGQ2bMX1mbwSCbwyLsdHcAQAE8xkY3AfZOLVXjbVtlyQ5ApRupbV0Iwxszhz0nHW7zvc5ogGUjgUka5C3hiTSoC9eotv6nXX+ga3BfysL8J+Ip/5tIO8R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070912; c=relaxed/simple;
	bh=liNxOHqtS4owacMiu+udobP6pfVRmWGgqJuFGkWX1uY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVv5ek8PKxknsEt4vlYLHDFgdaEs8etWAI1qnP43EpGLykqtwehZWNFvbHmZL9ak6PF+8cp+s36EoNcSrHG/Mkd4lyIXAuMXKMZWSlOhVDE41ybnK3XJJRryEE3HIP5rdnBERAKFASFicIrSPuy6DVCb9hrAVw9M0RpZ3WMLKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfBlyAVk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfBlyAVk"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so4030435e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769070909; x=1769675709; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JlbrNRekBYaQARK5CsNzqxZ3EG2Jrckv5T/Vqrwj6ms=;
        b=JfBlyAVkQEzBDNUdEnaIWPaB3DB/hC+iaw3AOV6WYubBlC07fQBAN50JbitY4dCriL
         EfCVT4QxmPtKJA/siLC3Jnt1NNJIZ0LqT4rcDEx++kbd/2/I2gyd3HqHc0ekCWd4qnkc
         CUcTqWrmkEkvz0Z8dFT/rdL6TMxgPl/FnxnJElHRFY6O6IxUsobQ0aZIlDKQU8YPlXZd
         lH9RyEdaG9mreLGkHxpIwpalieWifMFt6tQagXXaMEIlDEj9Sx99ooXFGTG68lOWclEc
         vrXl60pH95saHMK6B2G4lZ5YmYySlLo7fJZud1/Ue672yN/ZGcq7rD11ylxTjJs3uQ8l
         9lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070909; x=1769675709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlbrNRekBYaQARK5CsNzqxZ3EG2Jrckv5T/Vqrwj6ms=;
        b=hs3GHeGqLTKBxSif4kaa83OdHB35bT5AxGbFqgl0epyZLt0LrT4+So68lsjY05zON5
         78/r8nbzn6MJj0MfqCGgMRbTISCCGgF7NY2SqCHfvDe8y+LpHd4XgCtvaWm8zSakjwSe
         ydUnliQLzU02a7ZKOQXj3+RUsbCodgTGOb12ejaeAaFvjVfKmHl01pktUJf3K77fmgQr
         odJdqmEfTu3XWPx5fnesVm4De9OMldCs6lfSDcFiUC3T0h80oJawEjEOoBKoCpMIde+g
         DyLBYrbwrhdJbQ/ADYV0lhVXmk8mlYpwEo6a3vnVrfPKUo2nOWJY1+gPPU9pAuo+76gC
         FAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOTYfLmcLP811uwuSBw3i8xCk2DQKS8w0ZllT7GZc+PmP4ULh0HIoO9PnVpNkymLM9K+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWk3IexGIMAAH0xyri4hyf9wq4LhboFBkN0vs3lBtFdIJkD0Y5
	u9HYwA5QfIVEK9lIUc+8cOjnERC7K8g85+Pq45OhQpfnUJfAFEFPAdVb
X-Gm-Gg: AZuq6aKOFciP+fLw9QOJ5ppP6TjFiCOYF8YNKay6JmoPTiKLLxPVCCTmpuwtz1dl615
	ayiwLj2NkZjRJMO2sbUsyONtCOfSqqephc0P18cP7Kv61lTCC4/AXNffVBSDCMHJ4rzI1vO26xh
	wnzz+G9OMHQKhUGDdcBcGa/MrlYUROxR6RRR5AE2tAliBI2LYJWBXukQiPr/PROp7yNZv7+R+bu
	Y4SpuxVsKQVtxvM0FhS+25M3qanZ3grKWUkSGlGL3BMW+Mp5J3VeIdu/LfmkD2P+nsMl12wDRSC
	SZuPQ4KeL+cYQuh6wiiyf6oAka5PSmUMqm2lOnX+EwSJfvCeiLgeZOzQgCo0r9AyQJcUuL7iahe
	BBjo0/2HCeFnuyQKmdwNwwfd51jSE1Q+oz0AK9ANixvXz/Ihb7PMe5dMSuYwH
X-Received: by 2002:a05:600c:811a:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4801ead0fd1mr264704155e9.16.1769070908912;
        Thu, 22 Jan 2026 00:35:08 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704087asm48051015e9.6.2026.01.22.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:35:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Jan 2026 09:35:07 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
Message-ID: <aXHhO6R_PRw5yClo@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:48:29AM -0800, Andrii Nakryiko wrote:
> On Mon, Jan 12, 2026 at 1:50 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to call bpf_get_stackid helper from trigger programs,
> > so far added for kprobe multi.
> >
> > Adding the --stacktrace/-g option to enable it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c            |  4 ++++
> >  tools/testing/selftests/bpf/bench.h            |  1 +
> >  .../selftests/bpf/benchs/bench_trigger.c       |  1 +
> >  .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
> 
> This now actually becomes a stack trace benchmark :) But I don't mind,
> I think it would be good to be able to benchmark this. But I think we
> should then implement it for all different tracing programs (tp,
> raw_tp, fentry/fexit/fmod_ret) for consistency and so we can compare
> and contrast?...

fyi I updated the bench for all program types and got some stats

current fix WITHOUT stacktrace:

        usermode-count :  810.652 ± 1.036M/s
        kernel-count   :  336.645 ± 2.812M/s
        syscall-count  :   27.798 ± 0.063M/s
        fentry         :   67.677 ± 0.291M/s
        fexit          :   49.970 ± 0.214M/s
        fmodret        :   52.860 ± 0.237M/s
        rawtp          :   65.196 ± 0.224M/s
        tp             :   34.120 ± 0.042M/s
        kprobe         :   25.157 ± 0.019M/s
        kprobe-multi   :   33.223 ± 0.205M/s
        kprobe-multi-all:    4.739 ± 0.003M/s
        kretprobe      :   10.904 ± 0.020M/s
        kretprobe-multi:   15.996 ± 0.023M/s
        kretprobe-multi-all:    2.559 ± 0.092M/s

current fix WITH stacktrace:

        usermode-count :  782.529 ± 5.866M/s
        kernel-count   :  341.116 ± 2.247M/s
        syscall-count  :   27.481 ± 0.267M/s
        fentry         :    2.397 ± 0.026M/s
        fexit          :    2.472 ± 0.008M/s
        fmodret        :    2.475 ± 0.014M/s
        rawtp          :    2.593 ± 0.031M/s
        tp             :    2.641 ± 0.020M/s
        kprobe         :    3.848 ± 0.014M/s
        kprobe-multi   :    4.188 ± 0.025M/s
        kprobe-multi-all:    0.261 ± 0.026M/s
        kretprobe      :    3.782 ± 0.011M/s
        kretprobe-multi:    4.157 ± 0.023M/s
        kretprobe-multi-all:    0.177 ± 0.000M/s

with similar fix for fentry/fexit/raw_tp/tp WITH stacktrace:

        usermode-count :  792.613 ± 1.322M/s
        kernel-count   :  337.725 ± 2.422M/s
        syscall-count  :   27.363 ± 0.030M/s
        fentry         :   14.911 ± 0.083M/s
        fexit          :   13.749 ± 0.060M/s
        fmodret        :   13.987 ± 0.049M/s
        rawtp          :   13.760 ± 0.042M/s
        tp             :    7.060 ± 0.026M/s
        kprobe         :    3.920 ± 0.012M/s
        kprobe-multi   :    4.186 ± 0.030M/s
        kprobe-multi-all:    0.281 ± 0.006M/s
        kretprobe      :    3.782 ± 0.005M/s
        kretprobe-multi:    4.030 ± 0.014M/s
        kretprobe-multi-all:    0.178 ± 0.000M/s

so cutting the extra initial unwind gets some speedup ex expected

I'm getting wrong callstack for rawtp programs, so I need to find out why,
but the rest of the tracing programs fentry/fexit.. work ok

jirka
