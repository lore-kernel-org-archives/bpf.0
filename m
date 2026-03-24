Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA43537D6
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396774; cv=pass; b=Y/4JAVheVly5AXXbc0lQT0M6I1LskbA6tiTDz+5eiBwclckxKN8+nUrKDQ2c4JoEGnjAIlLlalnDVtzroH0y8IPGYT8eOgL51SpfgVC9deXCVgu+p3kS8dMI+WozWkGvvkVESevZHqDZ0FMWkIHeLWWVd/836ZjjwNeYLCEwZIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396774; c=relaxed/simple;
	bh=hThwroPBmtOEr8Zt0mhaIIEFfPukkoSM9kAGrO/AJU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfUUnX1Erxe+E5uk/IF+9kimGNuzbAGmxJF8bE1BCAI//YoyITeV6nM81P5cmzlv1Uth66nJUeZgjeOXA9tKhQ60bUAEkDqlEB9sNdovFuC4SL5w1++wapo81ESYRemoXePIgGLd3azUOW5M4uJAQC1QGQ6fZbYtywjBx+rex+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiNuxIyt; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiNuxIyt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so2041743f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774396771; cv=none;
        d=google.com; s=arc-20240605;
        b=TEAWwRENFb3Z1dIYru0Rc9nJ7PHnuu0QTlNcCJ7CWkxqlerZbIhBRQGbAk9wFCOA6L
         OlDhmA4X/yERQIYc8jk9uhu8pt+wLU6kKa7Zh2sPTeEiMmGMHOmcD/FV8YyFeIa1EDF5
         HoZ23olDv74qJkkN0CqrnBieXsRZeqpFbakwZN0UauyLVdlJFu3T2cOXwW+Nr1N/vjGm
         OJbULu3NbtIxe3X/TAOWV1Kgm85OC4XA/tpSvOXlM2H7p3UhvdjQS5fLW60T91sWTCJZ
         J/aoHkD+5/pRlAbyrdRpENXzBZe696fKjQAVE5giZQ9C+SiSJRZE8iJc+lcScrt9K8ee
         HJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LAPLAA0Q3V8ZfSSqOa3gqvGbSvp3OlBm9mZcJcj/jiw=;
        fh=jSMz8IrnfiXfXHFjPM0Wn0xSgi5WnW5o2LcjBDH0gsU=;
        b=jawljNZqga2ql4j14g7xvOO1QnCfRstZznusxFfU8S4eOnjBd2R9fKomuXlje9LnPg
         hgn9RSAvteez7cHGKdI+9oIZCi4T/fgqET5p3PqGJ71JScGd+jJDxRrjoaTdWd+N83h7
         LaopxD+lWNY/1ldDMG3toJwJB7g70O4NIgCsZZ9FQ14muztOiqtqMsooVeeaVVbwln08
         UM9xT6edgUvxwmA+IRuifBQuKVVAzQRwSzL4EgWY6PLJL69ZeemKjYlVzQlbvElWpUO4
         zm3WKz23nYBenaln0pAHFB961amW+ZvuQ9K6JsTdTdK82BCuwqOMuPTJWXgkRxWjfL6l
         L/Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774396771; x=1775001571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAPLAA0Q3V8ZfSSqOa3gqvGbSvp3OlBm9mZcJcj/jiw=;
        b=ZiNuxIyt23Ue3MlZHWfrxOZULSXSYSZ0nmURcV8r4VO84OMePMGPvAPrn2iLvJCDK3
         gHMfWpjxQ1O/HnKD6pKlX7kDKfNBr1ikh5A3f0+zkiRQ6RHE/ruOSMyLnbGzyHI2A66S
         fgJ5LwujrOSFmp74g6CcUDUM81jcmUWixxlgucneQgWZNK7DRe8kNhOCn8oLsyzNEz7z
         HQysIifNOHGKVcI4c0DGc0o1ZHfoY9jsDmTK0dBkTiN9GHUl93yt5K/o7nVT1iLFXR1v
         iMeZ9iv81Og9mNlaaG+++uuW0B0xDx65fC9Q3niHedRjyDhVr2NDf1p7IDcT/Hdpsqgp
         tIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774396771; x=1775001571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAPLAA0Q3V8ZfSSqOa3gqvGbSvp3OlBm9mZcJcj/jiw=;
        b=hxybLG0dymT72lkDMCbGCejOBHU7WqofXUYFX2X9e1XYWEeJzB98DNkqYTVQwKqXeA
         u0VSbe3NhX0VgWMhYuYTerKD/G8rgoZAInnePk+XMLtC2AlWjYp0vddTH6/FsBB9jUMA
         hN2EHo+mGTGvZV7YtTUcpljDXlcIA+N1TmblsE3J9qzjLl1dj9aMWbDYtT/5AaAeGKxD
         Kq7hoKFzP7oNJfFnzCEsT79MaBywRVVp5wrGVCTCp5xHGrHt1u1hxLdlbh7uroSxvCuf
         W05rUebbuEVX/dGSXGDguiPQT8IqwnT/PjbAcif3lOd8tn0jvQ1nqhGAn0CDowp+6hd5
         ivQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXomOkyClAM1nHpNnt14hpWL3o1PJJz1Dq7w9F9o76rS21hFR5fNA9ypYyWDfuF2b3CqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+svhL5mpOXePynTBuUwMJDCst1jsoFmwqhuGVaxkNUDpspbKu
	jGJ/aDdz0o7EYdvuy/buxvYdz5ct21/zbnUOtvzpZACncaYYX7mmR6tBZ9aPPnWY0AknzCvcVps
	GTgnPGzjaNsR/C3X8TfdSR/vX/E+YRF8=
X-Gm-Gg: ATEYQzxzD0+rcSyvUnLsuXUbj7fwtbKrG2C+AwyiPOsFlr4SJV/DxCkMuhx3tN/SISQ
	NNE51fwbC+w77TfG343rus+boCO3p3zhmI3oNhuHsJxTN5NTIFpsiq4lgEui21JMopbEfCJBx9i
	Kiiizay/YryFTyIApW33nVySLAzRs/rbUFQ+W7F18gZs/iOOm78A8aGgvMZic52Y3oABlvP4fDd
	ho5uHHUz1MGLwJNMuB/AOdBcY3UAH67ZCcnR5+hnVt4kelagST5o9n8QvsmZw9LtShwSkcfDUEr
	NQJgP2YVCVh8i3sdGWr9uWfECMVBhfiGBinXuMYCjWZBKXTMZVXtEJMkgjbueizzOgkjU9UulST
	QH1FcUWKs256z3Tn05WksQTRgTw==
X-Received: by 2002:a05:6000:22c1:b0:43b:564c:1f57 with SMTP id
 ffacd0b85a97d-43b88a4ff9dmr1732429f8f.23.1774396771212; Tue, 24 Mar 2026
 16:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
 <CAP01T74asfp5DY+wFd6pDVpSsiuPxjPaPE8iaFaczBUHe0BERw@mail.gmail.com>
 <871ph8kgxy.fsf@gmail.com> <CAADnVQLhkPcteADXk1OCHqWLWaLCrxiFsebut-1YtFRLyMbPbw@mail.gmail.com>
In-Reply-To: <CAADnVQLhkPcteADXk1OCHqWLWaLCrxiFsebut-1YtFRLyMbPbw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 16:59:20 -0700
X-Gm-Features: AQROBzBhWtQiRmp_saTJ8ZYlWNXM8OBUxz6R3FU5Bt1IoqgP-YW49_2jjxSlegs
Message-ID: <CAADnVQKqmhOhK7akAn8xvokVq4dqyjSa5JVwBio2SvhE=Bd7_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf: Add support for sleepable tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >
> > > On Tue, 24 Mar 2026 at 20:03, Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > >>
> > >> This series adds support for sleepable BPF programs attached to raw
> > >> tracepoints (tp_btf), classic raw tracepoints (raw_tp), and classic
> > >> tracepoints (tp). The motivation is to allow BPF programs on syscall
> > >> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
> > >> enabling reliable user memory reads that can page-fault.
> > >>
> > >> This series removes restriction for faultable tracepoints:
> > >>
> > >> Patch 1 modifies __bpf_trace_run() to support sleepable programs
> > >> following the uprobe_prog_run() pattern: use explicit
> > >> rcu_read_lock_trace() for sleepable programs and rcu_read_lock() for
> > >> non-sleepable programs. Also removes preempt_disable from the faulta=
ble
> > >> tracepoint BPF callback wrapper, since migration protection and RCU
> > >> locking are now managed per-program inside __bpf_trace_run().
> > >>
> > >> Patch 2 renames bpf_prog_run_array_uprobe() to
> > >> bpf_prog_run_array_sleepable() to support new usecase.
> > >>
> > >> Patch 3 adds sleepable support for classic tracepoints
> > >> (BPF_PROG_TYPE_TRACEPOINT) by introducing trace_call_bpf_faultable()
> > >> and restructuring perf_syscall_enter/exit() to run BPF programs in
> > >> faultable context before the preempt-disabled per-cpu buffer
> > >> allocation. trace_call_bpf_faultable() uses rcu_tasks_trace for
> > >> lifetime protection, following the uprobe pattern. This adds
> > >> rcu_tasks_trace overhead for all classic tracepoint BPF programs on
> > >> syscall tracepoints, not just sleepable ones.
> > >>
> > >> Patch 4 allows BPF_TRACE_RAW_TP, BPF_PROG_TYPE_RAW_TRACEPOINT, and
> > >> BPF_PROG_TYPE_TRACEPOINT programs to be loaded as sleepable, with
> > >> load-time and attach-time checks to reject sleepable programs on
> > >> non-faultable tracepoints.
> > >>
> > >> Patch 5 adds libbpf SEC_DEF handlers: tp_btf.s, raw_tp.s,
> > >> raw_tracepoint.s, tp.s, and tracepoint.s.
> > >>
> > >> Patch 6 adds selftests covering tp_btf.s, raw_tp.s, and tp.s positiv=
e
> > >> cases using bpf_copy_from_user() on sys_enter nanosleep, plus negati=
ve
> > >> tests for non-faultable tracepoints.
> > >>
> > >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > >> ---
> > >> Changes in v6:
> > >> - Remove recursion check from trace_call_bpf_faultable(), sleepable
> > >> tracepoints are called from syscall enter/exit, no recursion is
> > >> possible.(Kumar)
> > >
> > > Is this true? Can't the same program reenter due to the same syscall
> > > from a different task which preempted the task running the previous
> > > program?
> > > Just asking because it wasn't clear to me, since we discussed
> > > bpf_prog_get_recursion_context() instead.
> > >
> > Good question, this is my understanding, though I'm not 100% confident:
> > There are 2 mechanisms we discussed:
> >  * bpf_prog_get_recursion_context() - per program recursion guard, I
> >  understand this is used to prevent self-recursion, where BPF program
> >  infinitely generates calls to itself.
> >  * bpf_prog_active - per CPU counter used to prevent deadlock between
> >  instrumentation BPF prog (tracepoint, kprobe) and map operation
> >  generating an event triggering those BPF progs when holding map bucket
> >  spinlock.
> >
> > I suggest that none of these applies for the usecase, because we open
> > sleepable only for syscall enter/exit:
> >  * Deadlock on the map bucket spinlock is not possible (bpf_prog_active=
)
> >  * BPF program can't generate another syscall enter/exit - no infinite
> >  recursion (bpf_prog_get_recursion_context())
> >
> > As for the situation that you describe: same program reenter due to the
> > same syscall from a different task which preempted the task running the
> > previous - this is normally supported, behaviour - similar to what
> > we have when NMI runs on the same CPU and calls common BPF subprog, or
> > two tasks schedule sleepable bpf_task_works callbacks, that can
> > interleave on the same CPU.
> >
> > Let me know if my understanding is not correct. Thanks for checking thi=
s
> > series!
>
> I think it's fine to skip recursion check, but
> make sure private stack is disabled too.
> See bpf_enable_priv_stack() and bpf_prog_check_recur().
>
> priv stack is per-cpu per-prog.
> So if sleepable prog attached to a syscall gets preempted
> and that syscall fires again bad things happen with priv stack.

or add per-prog recursion check similar to all trampoline based progs
and allow priv stack.
