Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56E19E7F7
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771031; cv=pass; b=KMK+xxykug0RBKRxKxaNZJw/RYiz7i6ah33qtEtNGcNZVHHfbUy3VdrKfilRf3ZHufuxs8S3lWVSrjxSaaFsyY6jsZABtVFkaEbCDV+ee39eFgZ2xQeJzvy+1cN4V7qj85JZ+mqaU0PNPiXd2+sqYxFHLc1TZPFCJCaroghKwXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771031; c=relaxed/simple;
	bh=1BT9HUWAf7snIR8hyFT+J0f15K22ZkpTegEA0ejM33M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiSDEX92ArMeEfHHLBRIEk65QfxemsN47/ZDlKSZMwTtTjnT2BNT6TmWeuHBw181QuY59YZo+NILYqdqBVacUZpIAnBH9Ctvhy3mRTeJSBlWn9LR+kOcSg2uZpnhC2jMldaCup3oKyPm5fVP6I02ex2F7Kph14xojH2m6inUts0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBOvvq2+; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBOvvq2+"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b94a19fdso4813016f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772771028; cv=none;
        d=google.com; s=arc-20240605;
        b=eZxpOeikylv9Y2nhZq57iDCDN0T7Xokuulvx1s5kM8SlEZ7Nxn0jbv/t1Uk3hT8b1d
         VBNbGMJFMBxM7V2a+RqQmS6blbSJUoyp7hJBexmdvepkb7HeSPxZH4FCZOAGaxPDFBUq
         DJ59dBjW6T3aBR9QhfEmLiewAEGJX0/aQ1HHahkxIw8DfVbofGwYNq8G/C7ya2K53NDD
         KyRKpdCqYXBvRV/4gXnP9pKGtWu93Px+1YI0ehl/IW1N651dCMLeNwqNUbnzoPiQA63R
         aENmvTPQr1vauVaocx7aYddMF6OdWujTkPEVMwuGnHfCLQbyOLCe9nKc6t1jr9+CIzI2
         Dceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h66f4UU7F8wh9PpThD4xSxhHJl9Wg+/b0E+3OEiuvo0=;
        fh=LMDaiK5rbxVlKHQdijr03uTRe3gKuZ7n/w6+kJPuY5Q=;
        b=SkyAAyg1a1AjusrFHJYkDTLIp3fkSnNqwEmw+V7sC95OfT3pZQ0twxWuKIrRSzZQNI
         UJJMMzoq24u4bBBCs/Rcy4JImzlOp3iocyyV3ip9Wi0a+Svbhd5E5yxpgICh6bv/AJle
         YOsDnJeNWBxZfV1j6/r9mR2+aHPCmYrY0EwtfYw5upE7KlO1w1QOchA2fRG/TNSLNejb
         lUd5mQtAlfLFxL0WYRqzb27/OcvB2GtPVY4FTk28rYUHLgQ+l4NuCyCWQwd+xy8bAdKv
         Czzc3SscUaSbtlEBepaR8EIn7DpaSf8hoJ1tYtaUfYfLDzZcj8Mhq7a+6L6QDTOxtvZt
         cTaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771028; x=1773375828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h66f4UU7F8wh9PpThD4xSxhHJl9Wg+/b0E+3OEiuvo0=;
        b=gBOvvq2+S2wmEWYtHeeqb4+Z8Tlnpt7E0sHl1Yuef2zm+vLhTcoDxAhfsDDfAUmHQb
         apbxdUXgo91HIU4Ep/SSBMPZNOOShRuoNgLr17GOqtiaZ0kelDvzCjYqyz0eh6VvenhN
         ksoxSvlffA0E+UQEOnzPExzOcLIfK33UfFyU19QSM0hDtIHJPeM4tMaq/5XoVDGFlFbm
         TlfKJUv5M28CpEdIWymaWKCl46xtp6tv8xHV1pf+QWghdfz8WA74WF71B2syEQvj/3uy
         Gxl2BiUMcvVvIAoFOnpcAu3D/gw2yu6IVo1+2TmEsTCeArv1lN6M/6PaHPEKGnhxFtgM
         LG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771028; x=1773375828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h66f4UU7F8wh9PpThD4xSxhHJl9Wg+/b0E+3OEiuvo0=;
        b=jUU1tDuiYTMquUtjozsuTPSMKXoXGl97aau+6JsJsWB1kKA2HnpVHwqpG91K+oWHTw
         qe9ZakEDNGGBDfwFvaeFDw05yyH1ggJzCYJUBPHzPNeczrfCxgdGzjGTesuQ1tuzxraS
         4+xU+ZUUBi1hDSsRwBqGV6evVumb5dUHLRM5EQAymzp9xtvjc1diSGEou9reKtpDkaBk
         jCeVbWIBgsevqMVSUdrd/ZGTQxk13AqCI4CZzmZ8T+XmmsPLivlZ6Xoc9jWb2hn3/sAg
         CUGA1AEW7YP1V+oGRow43/C/TBcTBzXWlbm7cSexQG1p8OuwEj+WaUrnJ4iHRV51YEba
         N4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvUgOtHMC1W2YMp7XcBKmE5xLNHr0FGg9aIUagFPMjWSpeuDMcMgmB5uL8L33FJwea0jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrvM932chmTD1vmRPap+pHkoRD/DUSaXKvdklGVmk+Vk5Ohdmn
	eBHZ09mGxzML7ziBioNmgXuMl6y41gTSZ8A1yqGxGiV1WBrETjopauVek/XmqzgsRkHYVdK6MEz
	p5kh1PdaVof7GQp8CXPyWFNn+7+LgUUk=
X-Gm-Gg: ATEYQzwzgy0AgCw6Gp+MqGbKNzL7crNNMbx+RbHQcFqkiyBAGHMbsausmOXmqfnzn8M
	bRoCaPoKM1K0IP9ou45QBGq6CNPjiar74VsBt88Q9OWGpoaE0DEEtJz6wlJOMJsG7ilfKMF71gN
	sMtzicEUZbRNTmP5E1qLgVWOBhPJWZMSFIw9Quj5mbfqwALR2VfgmL+Sw16rs8O5lGakHSECMHd
	8QmR/TWqPZ1to2ZRwZAeK/GiA0tN+Sl48NkEI2xSphcAKtl50rxaKpr3LPxZPVuKbYNO2EUj+8v
	A06+awHmh1AmyyyIFnSuGv1Gm8SQgWur3wHrXFEk4xrBWPDv3VrWDI9/OYQ=
X-Received: by 2002:a05:6000:144c:b0:439:b7c9:2ef0 with SMTP id
 ffacd0b85a97d-439da88cebcmr882498f8f.33.1772771028118; Thu, 05 Mar 2026
 20:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com> <9a841572b63b4a741b20e14452a230a34203a2fb325275ad57fc5c0568a30c58@mail.kernel.org>
In-Reply-To: <9a841572b63b4a741b20e14452a230a34203a2fb325275ad57fc5c0568a30c58@mail.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:23:12 +0100
X-Gm-Features: AaiRm53XWQBnJL5qCyYYA6f_MO4ieqrjnaHSXZqHjERnQyolfPDk2SIsTPSCl5M
Message-ID: <CAP01T77_J8tua8HziBWZRunY9=LQ-Ut1mxJnKAk3cMCc00+7Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add sleepable execution path for raw
 tracepoint programs
To: bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, yatsenko@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 18:14, <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9bc0dfd235af..2dd345e0fdb0 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
>
> [ ... ]
>
> > @@ -2085,12 +2085,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> >       run_ctx.bpf_cookie = link->cookie;
> >       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> >
> > -     (void) bpf_prog_run(prog, args);
> > +     if (prog->sleepable) {
> > +             might_fault();
> > +             (void)bpf_prog_run(prog, args);
>
> At this commit, __BPF_DECLARE_TRACE_SYSCALL in include/trace/bpf_probe.h
> still wraps the BPF callback in preempt_disable_notrace() /
> preempt_enable_notrace():
>
> include/trace/bpf_probe.h:__BPF_DECLARE_TRACE_SYSCALL() {
>     might_fault();
>     preempt_disable_notrace();
>     bpf_trace_run##x(__data, ...);
>     preempt_enable_notrace();
> }
>
> Since __bpf_trace_run() is inlined into bpf_trace_run##x(), which is
> called between the preempt_disable_notrace() and
> preempt_enable_notrace(), the might_fault() here will execute with
> preempt_count > 0, producing a warning on CONFIG_DEBUG_ATOMIC_SLEEP
> kernels.
>
> More importantly, if the sleepable program calls a helper like
> bpf_copy_from_user(), the page fault handler will see in_atomic()
> and return -EFAULT for any non-resident page instead of faulting it
> in, defeating the purpose of sleepable programs.
>
> The v1 RFC series included a separate patch to remove
> preempt_disable_notrace() from __BPF_DECLARE_TRACE_SYSCALL.  Should
> that change be folded into this commit so the sleepable path works
> at each bisect point?

But sleepable programs are not yet permitted, so I think this is not
needed for bisection-friendliness.

>
> > +     } else {
> > +             /*
> > +              * Non-sleepable programs may run in the faultable context,
> > +              * do cant_sleep() only if program is non-sleepable and context
> > +              * is non-faultable.
> > +              */
> > +             if (!link->link.sleepable)
> > +                     cant_sleep();
> > +             rcu_read_lock();
> > +             (void)bpf_prog_run(prog, args);
> > +             rcu_read_unlock();
> > +     }
>
> [ ... ]
>
> The commit message states:
>
> > For non-sleepable programs, behavior is unchanged: cant_sleep() check,
> > rcu_read_lock() protection.
>
> The parent commit does not have a cant_sleep() call in
> __bpf_trace_run() -- it uses rcu_read_lock_dont_migrate().  The
> conditional cant_sleep() is new in this commit.  Could this sentence
> be updated to reflect the actual change?

This seems worth adjusting.

>
>

Other than that LGTM.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
