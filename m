Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBD2F25F5
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953528; cv=pass; b=su0aHbvy4WBjATknwiaXgnM9rTJIogqwWy67eeXXY5WKvaRwrPL4UvJRzGa2l5NckFUz1WZQDL4hWS8t7o/H78c4eJi5fLoB3Yya4RCQVa3JvdZ2rMaI0fKZ3NFMevKN+zNaobDyyaBlT1ShLY1kODLOurX2Kr3UQkiqsHZ3/mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953528; c=relaxed/simple;
	bh=mcZsxQtgOIXZj8BC7xCkbL9RuKKHyBHlF1NCWv4C2oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0AvAAIpkHa1/xUeI7Le5rpSqQxC/FPoNCC6CbGLqAH54Vp7UETWayNAvYMp89NOQMqvZqqsEgn9T4jFLvY+98DdYTuCPHCz+QUyHVde42lSP2k5abGv+R2W0vYoTibTxNGSn9lm4IdYHGxp1GCjCoeV4vHU6rZRjTRhqHdLzgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWSE6e5d; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWSE6e5d"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so3630690f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 07:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776953525; cv=none;
        d=google.com; s=arc-20240605;
        b=NGQ5sZ73qTpY3iZqDwxbX1q0+u1n8tKcne8nWxhschMrBbI1DS5wXVzF0Qa+cg0kcp
         D7+acbB4YRVLLyaRVkJdTxihYhDtyQ6G4daK2ETRTB/fPMAW53zBSiQIfrtWOm9rOPVq
         2NBrWYkWVX5MFxVvRfaG5ZEBK9tlZ2UXQgdpRoo5d7MajKXTf0TZVPo/992fKsPZJ+l8
         qW7U4Dw529KLinfaZ/jJWcRreveBI6t48HyDgrY0vMaJhRcWXdpEzWSQWSJIg1vDEpRD
         TW0O1hB543gQRGL0bAFBV7bYGMfmSvuhZ2QAE5gV7ZnE10hvM9i7LDlPcTr9g+k5p7Ny
         lwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mcZsxQtgOIXZj8BC7xCkbL9RuKKHyBHlF1NCWv4C2oI=;
        fh=Br5lLhY3MzgK0fWzj3HLWesy3NoJc+p3kv4TRnn1ZEA=;
        b=eL5JX1blcGQ5Fn2oXd+NJeiKY5S+WrdDZ4bJJZFbO4rWbAxYOUOB8oRzTlO/mxnTKb
         44tku/qYLhI95LjjnQJG99o3d72Hw9NlMe4aOKXnCtQv1meQ+PXtYPeTWwGwFay30yJo
         DjIvWv4sGhmw1Vbf92POBQDmN4d+Yr6RxLfX6V5MJjQXl0jQIcU//vB+pTwz2SWZv1tA
         7IWDZFfVvcvKxW5UPHJfZVLf53+YceoE1SM2LNcx5/OgfFEOI5QtHAlKritk40m7WzOk
         S2nPfx6QTNCT2sNYCUCIt8MqPUJBJn3e3cH118d0gQY1UehomDk2zQrT4VKPQBOUHfP7
         2/Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776953525; x=1777558325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcZsxQtgOIXZj8BC7xCkbL9RuKKHyBHlF1NCWv4C2oI=;
        b=WWSE6e5dDxs3tmyydUSTKT2ixh6AOWaSR96dO4ePByuValRN+nJ6NrZNOZR4G+xlOv
         yTLpGAtyAWGdAZrG757Nd914PXBDr8RvKjZWKmND1IKuidD6jtbe4y1BsRkdbfnoiHjc
         7ZM8xRqKMK0L4xOWi/gq1ye4/kNEFxiVrMwInVnugOWk4grICoZrfxzKeRlb7v5I6V71
         Uid175KF1STHnn9ItIRTy0aze66pd41q03y2FxioetqWyjP2pOMRKbFygkyfVrChRZ6P
         2s1ukR6k55689OdTtNEk7wnAJdouH/JqjrnL47gw7nkopq93FUtBMYHsscuBvZDHqxr5
         uSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776953525; x=1777558325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcZsxQtgOIXZj8BC7xCkbL9RuKKHyBHlF1NCWv4C2oI=;
        b=Igl7iKjXzrvZbnC0RrAA7bad3ikxBWeFqsSIfTDKYnrbbGEY2g2QF6V8i8i+tnuok1
         f1BAmIVL/4FYPpoSoMs4ueCFsre1fwVNo8VJsLE5H7+ASK5OVs2ZZU/2+TVjOKbfWkIW
         r85EXWKynM9w/cfTR2sJhoyN5EtwS8lf/cxx1vMgcH9BAR8UYR+Gu6IMiq0Bjq1D27Ll
         X5kfX9UEeS4gvrXEtPV/1A+X6zuNz6aaS3TwbiXR4cxO+L3ZkD1uBgYRQnNQ7Y3Lk9dj
         7+7xWSeJbkEypA+GwiOXEsztUGp0Pq/5cOQKYxQvJN202W25fU6V4wjaxFTVCEh/XD3h
         N0xg==
X-Forwarded-Encrypted: i=1; AFNElJ+1PY/Vht8SjfYpE+4ZdxJE4jv1/5gKsu324vjvmJrGtvgliAULYCzzOayqpqJDbk/aOaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuWEjB//lYW8tkCkUh1fMywSUGOuKye48NWm1pzl0VsfQcqu+
	xs8xI0SO69YoqDnJ7yiPciCwWjG0QPrMBkvp5NNee9M2UOY68WMZUmtWUWwvrCD56LI4mgaLox+
	pSLA0+zsaKVJhu42apz1aw2gVQ+HVPTc=
X-Gm-Gg: AeBDievtJof/DY9PC3yYy5D2rmna6a0cl6atXf41KGqav+LU981eai6UyluuEFuWqnj
	nM3Tmmo/JH7F0/aMXOgIA6jBgZzSGfZeRhr/q3B+UZcmmXtcXdoAC9e/T75J7o8oZVNHUJV+HM/
	M/LcFBMIFQpVhz9WivRt8mmet1O1MtFjR1CIp10P0ZSGdC+wgcT13Y160m3N43QoneNTvbQRUWn
	PhJKJDl0YV7lkVeGEYFne+4Fm657hRwNDWJbmSscXqfaKIOc2N7o1ouIVZHv7xxjN6L3szVTR87
	f7VcBZGfAiw+m0V3FBzbZFmeCUaMkgo06DUsbh7ezPpGumpLVW4wdT9sgAivkSjGUmDg6wklTEe
	+puVpnAE9JZvXyeum6KQwoRqbU/TaHqEwFfMEc3K4suAOOOKBdTR8pow7ATAaA5qCNkmO
X-Received: by 2002:adf:f584:0:b0:43f:e16f:3cc3 with SMTP id
 ffacd0b85a97d-43fe3dfd5efmr29033966f8f.22.1776953525176; Thu, 23 Apr 2026
 07:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-1-d8ff138d6f05@meta.com>
 <20260423095650.GA3126523@noisy.programming.kicks-ass.net>
 <b06ad9d8-681e-41a4-bfd4-fc86f021add9@gmail.com> <20260423100452.25275b6c@gandalf.local.home>
In-Reply-To: <20260423100452.25275b6c@gandalf.local.home>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 23 Apr 2026 16:11:28 +0200
X-Gm-Features: AQROBzAoWxP3-deKMvCVCj5FxMVh-sEf3kG8SuhLEOyQMK2OKMjxqB4C8jeSVQ0
Message-ID: <CAP01T74UsUVp3W7J6S=aTzWCpSN9UfdCXxysnL3Yhc2PZR48qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 16:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 23 Apr 2026 13:39:24 +0100
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> > > Since you have a clear distinction between __BPF_DECLARE_TRACE() and
> > > __BPF_DELARE_TRACE_SYSCALL(), would it not make more sense to have
> > > different versions of __bpf_trace_run() instead of having a runtime
> > > condition on ->sleepable ?
> >
> > Syscall tracepoint can be sleepable or non-sleepable, so the runtime
>
> I'm not sure what you mean by a "syscall tracepoint can be sleepable or
> non-sleepable"? All syscall tracepoints are now allowed to sleep. When is it
> non-sleepable?
>

I think what he meant was that the BPF program attached to the syscall
tracepoint can be sleepable or non-sleepable, support for the former
is introduced by this set, so previously only programs that could not
sleep could be attached to syscall tracepoints.

> -- Steve
>
> > dispatch on prog->sleepable is needed anyway. I'm not sure how to
> > get access to bpf_prog in __BPF_DELARE_TRACE_SYSCALL(), that probably
> > won't look very clean.
