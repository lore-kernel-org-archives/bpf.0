Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619639;
	b=GGwRt/UuPCnGrhsB3+2vios4jho+5H0+SIYY4P6NSvNEq713HmsAeoYDwnuCbeD4LV6m
	 N5ah/GqS29l/tTjEe/ztT8jVKtu9Yiz4q3th3r3aRp7vsCeyklGs9CiYVNmoumw+YAIYw
	 GhnwCb98kBrgBFdBZlHZPIJ3J5GwSlYE0sVnxbZtHf+ZWBfJq0yQnJUsFogRAE5U0V3UN
	 g8vUO/RHxGNDG45tSm0yDj9M7IQEOVKJT+8sfsoqvAbdCJ+MAMmQMqGWazhPuVH/NmrB1
	 68sR903dCuuuIxt+v1zIUwjcUtoxF0TxPeFWK8rRkeRvY0qo6lUh2c188E/rL6prkNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
	b=uuOyMw6jnfzje2VIbodV8OnJDBRRrpACIvTgNAkcVX4W6ZwlimxNiEoMYDTGFU7in2EV
	 uRLk0+RtTDprAwiz08cmklC3HY1GitiqPEPmrceffcsTF81hhfB9k0jV5ukMsEKQQGcjG
	 RnrK9P2vFO+UIPXJ9sIoOqGB9FrYJu3PEpELiVkWymnhgq4T5ISNiFI8ifSw/PD3zRZ7I
	 JUE3h210zdmwznFcppHuL0qNmP+wgn/8wpy4K8Cz8YvDhwcdP5RU8P48icQg6K5abFalD
	 wQizQ6voAwgno7nt5T+od4of1NdolYd2nKzKr5HpHfTa1LoQsouiarxK/Gp3Y+dZqcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcqUIirm;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5A606A32E
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 01:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE5A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcqUIirm
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso727657a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619637; x=1795224437; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
        b=RcqUIirmGxFt13gqOdd6yUruatOAAsDo1l+dPkuJjNNuzPvD3QnAij4UXbGRvhh0uc
         CB+p4HwuNb3yIanJC4StdNg1xyj6mfG+vUc2WFPzTyF32DwG5+BQTCb37qSFg8C4xNP2
         7EU9wRMdhXmem62hPbaY/57Zh5HreZ8ahJoleP2aNajewrsjE2QzfZQmv3u9/lgn+xLR
         0leWgUok/fXwoL6EEe3C6aDeqLRdVZ08ngeqDwAhBIb0EVI0R47ojMwqPRyENsER68k+
         8KyH6iF4GnqEN2lLqp3cKb+jpJCg8AE62fQm9Inm4yLXagd6DMhiRrgMYQmiYRYXqezP
         vumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619637; x=1795224437;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDQ393osPw2BrYahUhOGo4g2UUQtrhZG2XU5v+nepPg=;
        b=fSnUpRQjzHye5clT9oPIfmRSq8N6mq0OofD/fYs0agbh48Ptv3Vb4FWF2xIFSzCmHI
         +hBEVWyHcDwwKBbXG4sVvNwse6h8hjOmwQvhQJTg89yr0jVIEReR/jxN77+Ixps7gsTP
         Q7V7V58zc/E2dXTSrI02dVfUUAvtyObz6MbxMI0eWqFpfyFFjxHg6jr5J/y5rCFKbdpa
         SWDin05fyoh/sSfj3HM9CEIwhTMExu2q7UhNXNZg7C17DR7qpkhb4zf8dN1Hvf3LprDt
         874knRCZfAeXg+XxYovKb1QM92aOBQhlSb7HuCtAZcQ7yLNeg+98v9aooi4dCOzL8VyY
         0L0g==
X-Forwarded-Encrypted: i=1; AL+hErHTDWxTCj67Yn799n4Iuj9dkICIDZJrF0s3wHt7pjIceJ5/JcX44SGp5y2PGhFPn9rEC0k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LS2KJjKHzBTUbWr7GbKiXtNC4who1HrNCslPeLxdZEY1A2zkt
	SANpuF4vs9dYGMDEE+TTHUTJukgOkK/Y01PANTMG1Ka6FWv79RgXshrG
X-Gm-Gg: AYBFou0NV28683QjMtUJ7xcFd1wHP8Ze88O1axEJX4oBZ6Z9SQP1TXIaDuvwVGrtWXm
	Zlm2fOa9n4drqg9mWLL3HOgx3CuykvjB/AlaFaLRhAT4MGnPssv0LgoY5Y4UKiAPGFpBGyqYESW
	7HV2/Ns8szgcFjjm/Xd7FYokeJiaS0JzmsUs1nQEIsA/5Fowpnn5VFg6cdFDHuQMvjhD/q+nDMA
	dJKH3hqLWZsi6W+BvYJp4ER4NKZzW0QsWquslDx4J3ztbp2XymTGi+TAqXBKM2anBnjlFU2xim+
	/CeZfLVNrdTZVrJE5Gcfs0BnSMB5zjBt3hFOyYiJuHleLwsuXfsV3a0Az8/cAmsrPvHPUBw4Nc4
	cVW6bVWWm6AsWpI9cAyUEDxP5p61vddFF7ECtbjK2/QxUqfQEF/JrP7RGptCEG32TdJg4xjabix
	0dzCEy1Eo0hJprrBpcBh39nOUhNSw4qztFxiNKgj/8Hnsl7BcFTYpDt3QgBcvcX7B70XQ9XYLia
	frLJWEfZncHeHxwj6h4KJr7ASkYS5o/mr8RRLfLlqL3MEyRgZ/9DuAdvwjM9P4uN/RkNMp+uBYG
	lKZAWrQ5YOAf72Yyvf7G2dKgj+Sfen8yxpDYGT4IjEWdYifiGb+bEXoCQyPGykPdcnzmBdGZJad
	JXEq5Z/fiFjkfFGxaXQPqwkcI2a+UC00nnQ==
X-Received: by 2002:a17:90b:5107:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3b1b0cdafd9mr2717852a91.32.1794619637389;
        Fri, 13 Nov 2026 17:27:17 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm6809102a91.14.2026.11.13.17.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 17:27:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 01:27:16 +0000
Message-Id: <DMUJKFF59EU0.3D4OXJLXB2N6B@gmail.com>
To: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Cc: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
 <jolsa@kernel.org>, <rostedt@goodmis.org>
Subject: Re: [PATCH bpf-next 1/3] arm64: perf: Don't report the caller twice
 in caller-regs callchains
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261114001846.873499-2-andrii@kernel.org>
References: <20261114001846.873499-1-andrii@kernel.org> <20261114001846.873499-2-andrii@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 04:18 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> perf_arch_fetch_caller_regs() sets regs->pc to the return address of
> the function it is used in (CALLER_ADDR0), but points regs->regs[29]
> at that function's own frame record, whose saved LR is that same
> return address. perf_callchain_kernel() reports regs->pc and then
> unwinds from the frame record at x29, so the caller shows up twice at
> the top of every kernel callchain built from perf_fetch_caller_regs():
> tracepoint events, software events emitted by __perf_sw_event_sched()
> (context-switches, cgroup-switches, cpu-migrations), and
> bpf_get_stack() and bpf_get_stackid() in tracepoint, raw tracepoint,
> tp_btf and fentry/fexit programs. E.g., for a tracepoint program
> attached to sched_process_fork:
>
>   __traceiter_sched_process_fork+0x44
>   __traceiter_sched_process_fork+0x44
>   kernel_clone+0x250
>   ...
>
> Use __builtin_frame_address(1), the caller's frame record, the same
> way kunwind_init_from_caller() does, so that pc and x29 describe the
> same frame.
>
> x86 had the same duplicate entry, fixed by commit 6d08340d1e35
> ("Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"").

riscv has the same duplicate it seems.
Its perf_arch_fetch_caller_regs() stores __builtin_frame_address(0)
in s0. walk_stackframe() reports epc, then frame->ra of that frame.
Can be a follow up by riscv folks.

> @@ -15,7 +15,7 @@
>
>  #define perf_arch_fetch_caller_regs(regs, __ip) { \
>  	(regs)->pc = (__ip);    \
> -	(regs)->regs[29] = (unsigned long) __builtin_frame_address(0); \
> +	(regs)->regs[29] = (unsigned long) __builtin_frame_address(1); \
>  	(regs)->sp = current_stack_pointer; \
>  	(regs)->pstate = PSR_MODE_EL1h;	\
>  }

Will, Mark,
this looks correct to me.
Mind if I take it via bpf-next together with the selftests?

