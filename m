Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E9421884
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543657; cv=pass; b=pkdu8SCCCdBV42tSQCfJ8VXH7B6tLKMIaHlqM03mIZkEYTNjUvOKrGbHkoZ0e5/re7t4u1BiXPcZYoYndWGN2Rnj8hQvFL0mYxURE7FwvPTKsMbOHcOFdd21wypL7MsameWk7X1jZQNwF0eEruBE/FWc3GSodZbEC6dv8AYU5jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543657; c=relaxed/simple;
	bh=Rxv4nPM/ftL4RuPoq2pbTqaR/Bm98LGV+PIa3QWzLvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6562GoPeet7Yh3yHFZpc2kN2m8PiubIysE1CJAQZdsR10qyPOVb/Q49fLhlzVTdfYGsuUMZO1GNwvkDDQ3aLi+d/6blwrS+83v9diVWlF6oaqG4PaASy9n2FJw0nfg3o9/KxdtQPbVqhKlViFgAehCVonKYdCEj8q8av7kEMZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYpUPw9u; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYpUPw9u"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43b949bf4easo698367f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543654; cv=none;
        d=google.com; s=arc-20240605;
        b=WtOzSKlQ1dpEKH+JUV/qchen44unziqktwJdGZoOizphChxdCwlRtfmSW7SGPkwP9l
         ekrEQxRF++bD7FXCW6+7/PACVxNjfC4KKCwMjFNTHRCae+n16G4gj4W0TiThZ0y1SN0u
         HDwIY2ErnMKr1D2vqIrqQN5bIL+930lKE6Lj2mKTw2epvYK6F3HHe/7ZBItyjMtYhG7i
         JmG/UBrAeb/6RD0XZxlx2scmXQmys58RCVgY7yEgTsmAW4ghbBzwIFoPrqLwAft1UrsX
         TEhi9ICiyfbohTOiYAdaqHzVJmbCkAem0ICV3ASltVUR1f2xp8csQkWyYn1eBD/eoyj5
         0WZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rxv4nPM/ftL4RuPoq2pbTqaR/Bm98LGV+PIa3QWzLvg=;
        fh=1JuR1Aycb0V8ZSPv77yGVmIk71vaa0wSf/gOb+23LOc=;
        b=CDz8YJcGD1/Eyltb+MTMmGTPvI85GvGCzn2inAETq4iAdJbA/l62IlEYQtFf/KOnvm
         d6B7YuUE75ygqA/jPX3lYAkpgFHRikOtaiyYWogDiNx4jdMOwSr8wAncSA7enyVW89ls
         cN2vTZ7DutMwTlTAaGiLDvIzxVRHjBMETfmSQx800ouc02/+9wixXDz/gXDXRgyLJeo6
         1Oy7RnOYsbTF5gqhZZn2v6XgOTFnLb5EI45pKI0S8QGGQRTy6UCp1Xzr5Ogj21WMv8V8
         Geb6WEzVdycwirCyRzpOVHQPT9LIFsceOh15niduSOqxPmzeb3p+XkBCeYLoRHcN6+px
         F+ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543654; x=1775148454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxv4nPM/ftL4RuPoq2pbTqaR/Bm98LGV+PIa3QWzLvg=;
        b=QYpUPw9uD3ZrXqA2iuVm3TIrx7QRqOdkTzCgrajI+KG0TAwTl7UHsk3xGWGAHA8PI0
         Dj/IwPmyzgNdR7gDIq6ZGfcaEbImGQWfNH0UDFLoLnWK3PBHESXM2tBbtMIzBuSrc9nP
         Dj6l0cuGfYHCa65ef63AcQrVZub597GvBq15xhsF2XRK0X3facKWdmY2srp4KaiQKhW7
         zAxaKT5B0izHkahQG8FdWQvQvIveT2xjILzSZMKTy5DZtbcbK/eSftoNmeWO7G2Qxqo5
         F3KL0QEq7Os+zfNUKJG+HG8uG94zYczNr9zekzgdOQqb58NmI96pKCOmr6CPCquHrqsD
         HBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543654; x=1775148454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rxv4nPM/ftL4RuPoq2pbTqaR/Bm98LGV+PIa3QWzLvg=;
        b=tJL20EnImrWE7+uxj/ax+Mr7YsXA4fM7EFPuloxMvp5iJBkPBKBOYLeskZ2m36cfh9
         aXyj+DHiOAC/+IqpjjQwsjgUppftyOUHWRL1bFioKMaVFXKsJrn1Q2VDlOCqaeoEVHDc
         m+kKHCoqvQnzKpWOoIN3S2a7abmxNVyLGCqZRJly1ZcIzBhlUlt/GORFccn4baOWbj9f
         86yDfpFdvtpGTiGh0doSeTlhIzRuMKRtX65O0qURuf1Qi9SZt/eW5X5hD3PKBlUb1w21
         L1GjBRdcolFvB624j5hApnfleU8yBOGIhMGAd1UXg5jJspg3KPwyUApM4zXr3GtBAvmX
         8J8g==
X-Gm-Message-State: AOJu0YxWIBOvi2pnTqpg5JgKeZ+UnJBnQsnTWQtgI9ZPLBal9YWRGpgx
	Sfr4EzZds+bJx445Ujzy11H/61ZuuTzNX/DrEqebne6o//lr0CX3aJFeEkGsuHV9wkLTesFDO4s
	PApeVg+p3kh/doY+D9b+6am7kawz8/ho=
X-Gm-Gg: ATEYQzypfEhfm+HuJxOkxtaM44plOVR00PimAyXJIeJKr0TA+dPEztqq83MBuB7JXCv
	aynmvJemfYCqXaF3beTNvInh3mbTiqtyZfu73oKw2flHoJ8VvqQawnS4tkvgldg7AHpX9E0CNnS
	6kLOi4Yz4iOrJvETPIlQ4WJKc92pNjxti0XOAfAv8DKk8zO97s9DISWL1bOnfL5Sh+Y9XvYYKoR
	P5M547QrgJMf9X1QySiSUKh7EcNGydkrw73R5SZVyUt75LW81MJrCfzBe17HwcDDOo/KSs9UD/l
	tgkafUW1lCe5rNr4IqeEKtYpXjdmobPyoXE/SFPzWay05vCC/cRo5eGdeYtY
X-Received: by 2002:a05:6000:24c3:b0:43b:5091:39db with SMTP id
 ffacd0b85a97d-43b97a203f5mr4317766f8f.13.1774543654208; Thu, 26 Mar 2026
 09:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-3-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:46:58 +0100
X-Gm-Features: AQROBzBFq-Giws6ErZDhcg716aZigfVv5mVWiR1sjY2IYFp-MH71-_SRospZ8H4
Message-ID: <CAP01T76ZAxNyUqtJ0b-K79BA8QmmJcf4vsKR9dz8mJFG-tGUWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] bpf: Add sleepable support for classic
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add trace_call_bpf_faultable(), a variant of trace_call_bpf() for
> faultable tracepoints that supports sleepable BPF programs. It uses
> rcu_tasks_trace for lifetime protection and
> bpf_prog_run_array_sleepable() for per-program RCU flavor selection,
> following the uprobe_prog_run() pattern.
>
> Add per-prog recursion check to bpf_prog_run_array_sleepable(),
> controlled by is_uprobe flag, allows sleepable tracepoints to use
> private stack safely.
>
> Restructure perf_syscall_enter() and perf_syscall_exit() to run BPF
> filter before perf event processing. Previously, BPF ran after the
> per-cpu perf trace buffer was allocated under preempt_disable,
> requiring cleanup via perf_swevent_put_recursion_context() on filter.
> Now BPF runs in faultable context before preempt_disable, reading
> syscall arguments from local variables instead of the per-cpu trace
> record, removing the dependency on buffer allocation. This allows
> sleepable BPF programs to execute and avoids unnecessary buffer
> allocation when BPF filters the event. The perf event submission
> path (buffer allocation, fill, submit) remains under preempt_disable
> as before.
>
> Add an attach-time check in __perf_event_set_bpf_prog() to reject
> sleepable BPF_PROG_TYPE_TRACEPOINT programs on non-syscall
> tracepoints, since only syscall tracepoints run in faultable context.
>
> This prepares the classic tracepoint runtime and attach paths for
> sleepable programs. The verifier changes to allow loading sleepable
> BPF_PROG_TYPE_TRACEPOINT programs are in a subsequent patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Steven Rostedt <rostedt@goodmis.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com> # for BPF bits

> [...]
