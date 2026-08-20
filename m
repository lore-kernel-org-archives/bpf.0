Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C046D2DB
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233438; cv=none; b=m2E7NGNTunhHXdg/7aNsAeTgj98xfxGdK8L9q5hJdAgoyIkdpULzyFXbInCNGtUoADBGFEG61dCNaiU49AzfnMbW5McT5hD4aq8kzrzjFX59zW5EKCIbl8HwAXN8Wc3DmDwVdTIBoFBV1uV1kB7PB1B3DLp/q3ZaiFIKmFWBTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233438; c=relaxed/simple;
	bh=ZnAmjiVSKJYihj0B64j7d/zzIwGbot/sichQbuvRPK0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP7JvyYCXO6mPyZuFKZUVxGpcQB9Jk4f2n4l/VfaPoCJ+aeKnTobhhbEN60OfdakripQuhEUZxey0hG2aJd4OCB2C1SzFumhNe4gfLS6ELMEeXkYfWEAU0JLZwTYFRqjQkSjjojejdbPhBY9QNeUo4x/wrfWg66ZYhhWCU6/h8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELlktNZt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELlktNZt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954dff6536so19414345e9.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787233435; x=1787838235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJ9Yt7JrbYNUEPYLCZUAgAXvfeuA5IIBTzwglQ2xn1o=;
        b=ELlktNZtzMrNSRf3ph7WEiQiQSyTxyy/mybDodQH/eUexRZ1fx99uHIzaG+IQH7lj1
         UMA2XozayqhOz+ptNE3Q2UyQ1aN0Z3OL9QRjc7zzsrbQSBKME6U2WD0bKVKqUXkkjcmv
         qtRLtFFmwEO8zvTSY/RgJP9xTKnVhuhQu0zxwcwxyvEKsDFodq818/khsZCgyTDlC8PC
         MPWFdc/COubRWNsNuPsFBm+KBRlJoiNCAdZVvhPVh+fZRj0vZ3DaWo9jpY4jzehr/jZH
         tq/xuoPX2WzkQqyKET2tmm7Mg1+6rThs1kUmvt5QkTpjTw6nOISmNW4WimTuRT1u5YGK
         uCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787233435; x=1787838235;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJ9Yt7JrbYNUEPYLCZUAgAXvfeuA5IIBTzwglQ2xn1o=;
        b=WfrMdFb2X1hATXZ8+GSfZ/CpzY72RhDzMAX7pWEuC/uD+xkMTHrMciIx/wDTO52QYE
         L3FCupDNESYt8IiSstiTEW8ubOJWB3DiX+PNOaB0peTor5Nht1JFRt+SzMef49ZhKlpi
         ZBuHkTaEmipmetsCFcoPVCBYoHhyZ39NYo5sp7AenBVz2RoWSMmi44i1toYJqxVWnxhJ
         mn6RReuU4oEZPlskEMIrMG6evQbLFZJCWzVJBgYVg4vfDAkvrDY/JqpBL3zJTxCR0K9r
         sZkB4qIIyg4zH26i1/2GPMcHVY5krkW3tYZDoneRbQNbym7K1k3jR+uTExQilXY0MvCa
         Dwiw==
X-Gm-Message-State: AOJu0YwSlnZn0EdbGHjLnl4PxOoQEaxMwgCyLSBnepWE10/8raYDeZNw
	dcxb3gMfkTttPSvjW8yoby3QxDFx5Aarl9udewnYqP296xqqnXM/Yv6S
X-Gm-Gg: AR+sD10VOybOaW8o6r2K1VcD2NZWPuUmjVW19Xgs+KWC4KMPmyN4aGCVEnl7DWVBCPe
	HWV2JNOjzdlxD421rTZfADNpVtyEglqRGkW2wYmVlzcwuuHS++5REaWKAqWRFz6u9fD+kGSxiHZ
	iI5NyZ6jo/QHlCYCD1+QuSdAeuuvM+JUhYIUZzp8RuwBMHQDhm+CrpwZdaOS0rX5fSVf2eoM9jG
	KybnfWE9CYSaCi0qLKq9XjdEAGLKx7J0kefjwEaxrbuu7is0IRqpRX4Zi3n3nSG3Dqt+EWze6+h
	37uEtwEwLq9YfdpsmWC0cgdzZGUJ03F5wQdwF9A8+eIMOkMwWSd20QTybuzDFsudQaDzbxdFbGV
	VSxlQSCclZZ5iyUb6gE2BpK1QrQ0Wz95gBK6ICzZvWn8LAhqthKfVozy6wbKWdMmczr+3f6sFtg
	kQK9HcHaxQZunQw1xK9KdpC/sx07ya5JBO1OZ+juNBNtnzyGdodq0SPFZP1JTAsctzlYW4IDU=
X-Received: by 2002:a05:600c:3b95:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499aa1b97ccmr212949125e9.11.1787233434628;
        Thu, 20 Aug 2026 06:43:54 -0700 (PDT)
Received: from krava (37-188-251-242.red.o2.cz. [37.188.251.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b4568a65sm23005125e9.2.2026.08.20.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:43:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 20 Aug 2026 15:43:48 +0200
To: Christian Simon <simon@swine.de>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org,
	yonghong.song@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: guard uprobes against private-stack
 corruption
Message-ID: <aocElNhiC22PVQqS@krava>
References: <20260818203234.1142913-1-simon@swine.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818203234.1142913-1-simon@swine.de>

On Tue, Aug 18, 2026 at 09:32:27PM +0100, Christian Simon wrote:
> Eligible BPF programs use one private stack per program and CPU. Both
> bpf_prog_run_array_uprobe() and uprobe_prog_run() use migrate_disable()
> to keep an invocation on one CPU, but another task can still preempt it
> and run the same program on that CPU. The second invocation then reuses
> and can overwrite the first invocation's private stack.
> 
> Protect each real program invocation with the existing per-program
> recursion context. When the program is already active on this CPU,
> account for the missed invocation and skip it. Return zero when skipping
> an uprobe-multi invocation so session handling does not suppress its
> return probe.
> 
> Skip dummy_bpf_prog in the classic array path before acquiring the
> recursion context because its active pointer is NULL.
> 
> Add a regression test that pins two threads to one CPU and overlaps
> classic and multi uprobe invocations while preserving a sentinel in a
> private stack frame. Without the guards, the second invocation executes
> and corrupts the first invocation's sentinel.
> 
> Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Simon <simon@swine.de>
> ---
> Changes in v2:
> - Address review comments from sashiko-bot
>   - Guard the uprobe-multi path as well.
>   - Remove const from correct line
> - Add a regression selftest for uprobe-classic/multi paths.
> - Add the arm64 Fixes tag.
> 
>  include/linux/bpf.h                           |  33 +++--
>  kernel/trace/bpf_trace.c                      |  11 +-
>  .../bpf/prog_tests/uprobe_private_stack.c     | 118 ++++++++++++++++++
>  .../bpf/progs/uprobe_private_stack.c          |  54 ++++++++
>  4 files changed, 206 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_private_stack.c
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_private_stack.c

please split the change into 3 patches - uprobe, uprobe_multi, selftest

> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..a94fc9898ece 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2572,6 +2572,14 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
>  
>  typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
>  
> +#ifdef CONFIG_BPF_SYSCALL
> +void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
> +#else
> +static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
> +{
> +}
> +#endif
> +
>  static __always_inline u32
>  bpf_prog_run_array(const struct bpf_prog_array *array,
>  		   const void *ctx, bpf_prog_run_fn run_prog)
> @@ -2617,7 +2625,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>  			  const void *ctx, bpf_prog_run_fn run_prog)
>  {
>  	const struct bpf_prog_array_item *item;
> -	const struct bpf_prog *prog;
> +	struct bpf_prog *prog;
>  	struct bpf_run_ctx *old_run_ctx;
>  	struct bpf_trace_run_ctx run_ctx;
>  	u32 ret = 1;
> @@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	item = &array->items[0];
>  	while ((prog = READ_ONCE(item->prog))) {
> +		/* dummy_bpf_prog has no recursion state. */
> +		if (unlikely(!prog->len)) {
> +			item++;
> +			continue;
> +		}
> +
> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> +			bpf_prog_inc_misses_counter(prog);
> +			bpf_prog_put_recursion_context(prog);
> +			item++;
> +			continue;

so uprobe program has this problem only when using private stack, right?
but we exclude all the programs, I think we should check program has private
stack as well

jirka

> +		}
> +
>  		if (!prog->sleepable)
>  			rcu_read_lock();
>  
>  		run_ctx.bpf_cookie = item->bpf_cookie;
>  		ret &= run_prog(prog, ctx);
> -		item++;
>  
>  		if (!prog->sleepable)
>  			rcu_read_unlock();
> +
> +		bpf_prog_put_recursion_context(prog);
> +		item++;

SNIP
