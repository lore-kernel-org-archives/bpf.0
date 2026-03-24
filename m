Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D235C185
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396691; cv=pass; b=QJj+djqJZYPwsJ26PfBzApTXVx6mVhI2CWkIfQvI7MWsKAuG67QJygVCldTGQkHbcTPhdbmSlLhmydObDqRJ6UqyPAH5mdQhRhcU11qUUPkvMXVQAzxvtzKgHgfPJTCirJdjMDwsGtSdkcSS0CETKUmzHH5pN2J9MI409c6y6JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396691; c=relaxed/simple;
	bh=xPKWbIly7dh8K8JR2qkdsv4UDQA3AzFqM28EOiwaQSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+FcMzuDWDLbL84TogkhJV0mS2XHCEbNg23Qa+Fl/K4f/iSGwiT1g2QANn/3hbuf66A1YIY4sNWtTtLYoaIT+hOQt3CdPCf4o8td8n2ovd9ZQSLXeiSOGmWjIRaIm4F+nRSd+/t4Ja3XjLXXra8578RW6Dd1NTBj4/8zSuR+utQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArFeVUh4; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArFeVUh4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb439299so49443865e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774396689; cv=none;
        d=google.com; s=arc-20240605;
        b=geu6YOCNRwWt71fiwOLBCMvCm1rWtbBGz6HhBcMoXD52/+GrKplKAcj/fR8AKaA4MG
         8BGK54HlAnNJwAfl9QJ6MyOm9kEYlIN42r5AnbbqWinR6+lGWV6LQoSJyjx6qCtXkxW0
         ufvKvx9yFCglzqDROt/Rp4bw6tE7Yp0e8ObOcozQq6WeUXqt6gG29D3FBhAUT1DOZuMo
         QvTh9cLK9/COjnq6Fg8amD6/Cx+cRpKBFRFj3fLsnT71uWqDqXMMoEQTIOSy+UzrRcET
         QH2yiYvjgZXa6g8HbrBLPMkaYgldgZG56S4zu+w2I4g7jifJVZaOlnnqO5uAMu6HI8Aa
         xTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etU8j3vS14BezcGNdb50PUpoD9wOmsL5Xj5VH+Oqqhs=;
        fh=zADm7OR1HaZJraV/GiIICm8qfYkkXM0mti9HQA4zGjY=;
        b=DEtDQBiqAN7d+Z07YutYv5T+GlbnfedPIq3M0oLvTyAxH6DarnpyEh/z9dQgVoWvSb
         RdxXXJvLvAyqJxdm79oYIYkvik2UT6xYUcpMn4lVS04vRn6ezebN+/EHNW/I+uIRe/MK
         3YupiQJe2LeyfJLRh93e7JxRv4BCLUmpFYz04i3fNGPMHVhK5Hv3/rymmG5dvCj93YR6
         ngwyDs3mEAgqU+zcBNwlYYOQiQBrCP/hAlf0cdJbcOvjsUDaYX3aZV4gYrTBTSfXmZ1s
         CEolVZYHlDnlZ1RBscX1D6UtIQj268O1ISjnc8ui/BM4zV/9L9t1ctdoRlCTRvjHGbaL
         E0HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774396689; x=1775001489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etU8j3vS14BezcGNdb50PUpoD9wOmsL5Xj5VH+Oqqhs=;
        b=ArFeVUh4/PQv5kjmaZYNQhgIwdxA9yOnP4vtKKeFMfl4e8cSRSXC8sXYGd5ASlZgVq
         KrMWeLDAv1VbmNdsr5fJY9iNRUBK4wzFz1edrJv7uSlsHSx0rhnOrw6al21fwGNAM8RX
         uF8lEZKd88Zw9j6pJN04fLI6xdUL7apX4oVj+VvlDB/HPpmhQHEfPa5kAZasJlp/K5jR
         Y70CuK5W8MUvIaQn7DwgJ22QxxkwCGxMgi/qk8+IG9j3jArj3BeAwZjg6sXMyp2u0yp3
         3/lm3sJcHXX+53oYTQRMrmMIE6IdgZH4GTYoDyBkec+XjrLbImfg4BwvWLJNMvawlfA7
         tp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774396689; x=1775001489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etU8j3vS14BezcGNdb50PUpoD9wOmsL5Xj5VH+Oqqhs=;
        b=R/yjSC2gcaZk0b88M1T+gUeJH3lO/qGdslnq3O4rmd0j1ICCBlCQ/a4J7eG8h/nr9z
         /1Iy4efQP1e7mA8LRXS11W2JdCYZLutdUoFWsQrBRmO6B0FcONq0s4+fE6DHN4s2/2vc
         jB44fSgCDYmqvjAd+NiArKjo7F/2h6MhgRJye9x7iioVQvf3v+kCZMqEH2IXR72n4xsP
         mTgxYQsefT2tyhW7mm6bhQo3t8pvGt3VHRAI/j1He5zbvL0NXFpUtTVWPWWgcY24gmjE
         SSTeH5grOeL5UGtU+ps3CdtbZv+opYgpIZVcVyo6sXbstSQlwtKU2CpNeUFwMj/oKj1x
         PdVw==
X-Forwarded-Encrypted: i=1; AJvYcCWp941dFO1BF7seld9u7cWwgeJYrJ3OSWnF7SCVaKUR+W79N6s/TN5INXYxCacBZ/V8mWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMf7YencAeFjqZ1aKDcDhU+OsCjiv9WNygKoegpos7Cf2Q2ODI
	Twdxgwd0VH1g60nZSTw39pnXJLUPd4hnyR37GDA3OYBjVY7iMDw8GkJ+ogt/e29YDrtY6G/BwBh
	pkPYzl/GAn2JyklM/Sprvu7yC1rpYTw8=
X-Gm-Gg: ATEYQzwrQIfMFlabfMEch0Ncizl00v7ZJfC/SfD13xtU9id+fUZZWB96exYssHvJgKt
	R4k1mEUWk4TBa8z6BISG1tTwutzDflTBhPml8jESCzSmKRJutGWf6Ct+FfgM9eG1J6Ak+gEXIfg
	3VneKXP+iUdI8bYWFYseHKXb2zRUIbmxGVRpzN8mlJvL7Q7lDK6bZvtObCdwauZ0bKOQDoNmoX1
	Clom4QwnuJdo4tf0ws7inFjbTmtQ0KreykuV/T6biF/WEIENW591WGQ6XsoVMtey9H+nOVX+2tp
	PaU67uk29bdKH3BPNvgN4ub4SNZ8L5uPP5Y+8VR3fj/y8gp68EGaQx1GLut3UnjRS143CrH0QYa
	xdeZt5GbxsntaChfXP8GvQXVwgE+PvvUjtynw
X-Received: by 2002:a5d:64e6:0:b0:439:c5c5:4146 with SMTP id
 ffacd0b85a97d-43b889991bbmr2048368f8f.11.1774396688402; Tue, 24 Mar 2026
 16:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
 <CAP01T74asfp5DY+wFd6pDVpSsiuPxjPaPE8iaFaczBUHe0BERw@mail.gmail.com> <871ph8kgxy.fsf@gmail.com>
In-Reply-To: <871ph8kgxy.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 16:57:57 -0700
X-Gm-Features: AQROBzDGFmrz6fDg7dETNDuzkFYhy7kGja7P4o_qOiPxy7LJkVPHe0iFzupXIWc
Message-ID: <CAADnVQLhkPcteADXk1OCHqWLWaLCrxiFsebut-1YtFRLyMbPbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Tue, 24 Mar 2026 at 20:03, Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> This series adds support for sleepable BPF programs attached to raw
> >> tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
> >> tracepoints (tp). The motivation is to allow BPF programs on syscall
> >> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
> >> enabling reliable user memory reads that can page-fault.
> >>
> >> This series removes restriction for faultable tracepoints:
> >>
> >> Patch 1 modifies __bpf_trace_run() to support sleepable programs
> >> following the uprobe_prog_run() pattern: use explicit
> >> rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
> >> non-sleepable programs. Also removes preempt_disable from the faultabl=
e
> >> tracepoint BPF callback wrapper, since migration protection and RCU
> >> locking are now managed per-program inside __bpf_trace_run().
> >>
> >> Patch 2 renames bpf_prog_run_array_uprobe() to
> >> bpf_prog_run_array_sleepable() to support new usecase.
> >>
> >> Patch 3 adds sleepable support for classic tracepoints
> >> (BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
> >> and restructuring perf_syscall_enter/exit() to run BPF programs in
> >> faultable context before the preempt-disabled per-cpu buffer
> >> allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
> >> lifetime protection, following the uprobe pattern. This adds
> >> rcu_tasks_trace overhead for all classic tracepoint BPF programs on
> >> syscall tracepoints, not just sleepable ones.
> >>
> >> Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
> >> BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
> >> load-time and attach-time checks to reject sleepable programs on
> >> non-faultable tracepoints.
> >>
> >> Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
> >> raw_tracepoint.s, tp.s, and tracepoint.s.
> >>
> >> Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positive
> >> cases using bpf_copy_from_user() on sys_enter nanosleep, plus negative
> >> tests for non-faultable tracepoints.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >> Changes in v6:
> >> - Remove recursion check from trace_call_bpf_faultable(), sleepable
> >> tracepoints are called from syscall enter/exit, no recursion is
> >> possible.(Kumar)
> >
> > Is this true? Can't the same program reenter due to the same syscall
> > from a different task which preempted the task running the previous
> > program?
> > Just asking because it wasn't clear to me, since we discussed
> > bpf_prog_get_recursion_context() instead.
> >
> Good question, this is my understanding, though I'm not 100% confident:
> There are 2 mechanisms we discussed:
>  * bpf_prog_get_recursion_context() - per program recursion guard, I
>  understand this is used to prevent self-recursion, where BPF program
>  infinitely generates calls to itself.
>  * bpf_prog_active - per CPU counter used to prevent deadlock between
>  instrumentation BPF prog (tracepoint, kprobe) and map operation
>  generating an event triggering those BPF progs when holding map bucket
>  spinlock.
>
> I suggest that none of these applies for the usecase, because we open
> sleepable only for syscall enter/exit:
>  * Deadlock on the map bucket spinlock is not possible (bpf_prog_active)
>  * BPF program can't generate another syscall enter/exit - no infinite
>  recursion (bpf_prog_get_recursion_context())
>
> As for the situation that you describe: same program reenter due to the
> same syscall from a different task which preempted the task running the
> previous - this is normally supported, behaviour - similar to what
> we have when NMI runs on the same CPU and calls common BPF subprog, or
> two tasks schedule sleepable bpf_task_works callbacks, that can
> interleave on the same CPU.
>
> Let me know if my understanding is not correct. Thanks for checking this
> series!

I think it's fine to skip recursion check, but
make sure private stack is disabled too.
See bpf_enable_priv_stack() and bpf_prog_check_recur().

priv stack is per-cpu per-prog.
So if sleepable prog attached to a syscall gets preempted
and that syscall fires again bad things happen with priv stack.
