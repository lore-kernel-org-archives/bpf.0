Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A093DDDD3
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970657; cv=pass; b=LGXiO106fSeauk4mpBm8HtJ7gQDlabOtuwqtu6geJo3PjyhKfK/khTO1+h8OieGfa6LNrvzwO4dbZdEys/6R0NcCqR8If4YgwL2B4iknqMVQIs6cLqMx7kPoi2dmI736F0gk1sb2v9AgIEhlHo5isI87KZsoY43IChhMHJssbnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970657; c=relaxed/simple;
	bh=EhD5gEGH6GSuwxMWRGP4oKBNXirjXIMchRNXI5VvahM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcam8f86oCyWaa1DhCloZMB73NPTog13aL0ZCYmP52kDoVsdEC8v3fnTsPZNqyvxGvfwREnrWQ4kaaShKkfs1730bMWHyKjrdfxyPsMWy2BTOAfV2t9kwq6iMPXdQC+HDvgcN1SEC98GdcBflY6DWce1gcRnEQgLxO5bojcR6OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOlygZPA; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOlygZPA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so1689935e9.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774970655; cv=none;
        d=google.com; s=arc-20240605;
        b=hv5oQhAjQT/mqeeU//9/FgWS3W21LmhopBkY1OZFg5EVHatZ8zPMC5FYovTgUnhqsz
         CTekaBAwOJJ9vdCd0r9gs163eAW4hIcuOOqw+8o85DWVrv3wtcpnza/TaRBEO5cQCs4s
         +8szD3SpuhFDSwMnY1KFdpyyrh7QUNDZIwo0Ninqnk01cVW3TQqcSuZkTeLevCW/slhg
         /I9OO2vckhtJt/jhJeYPm91avacvQi823tjkNB1Nvsfo/M04wc87xq12O3xLG1moK7hV
         0E2Z43pL509DoSBqxt0yRJibxd0PFrK3JdojdTjgAxc/Du5qNCgJGfJuXf0cVfGXFwya
         kiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SGFhbyoYTQhRoR8CNaMRtIaS092Mdbpa9pQ3Tyd4RHc=;
        fh=flW7n/RyBRHXTbFiijFMkqIkrJ8e0RxDR2K6vm8bpB8=;
        b=dbbrqDhEWHAts2GsTw/XQbpepRcJckjxWaq7dP4wSOCofYpibDjDpHQlQy9sXqKTrJ
         i+ajpUz7STCFOaDrmMTZN632LbU5oKcmhEjM5ytibQunoHohaHd1ekom+SnSW9l14cA3
         5++DaUUDpzb8KNLV9UrDPUmlhRH1nReNQqkblrqKExEsx2D2kH+AVlJgkz+Ery1VHSEW
         57nje4mUq5nitC0yqdx1J6JtxcVKcI2CVWZZXA5jF+O63kW/ZHqM4nCGeXc8CYsOlrJF
         TfOECSLNZVzR2Mh2MquiX8JfAoI1HSo9CJML1+c45rNXVBw25jMudrl1rNYYNLsNCQG2
         NVAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970655; x=1775575455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGFhbyoYTQhRoR8CNaMRtIaS092Mdbpa9pQ3Tyd4RHc=;
        b=GOlygZPA3OEtbYnB0uIfizZgTfWf09Ct69jg7f57+7pCOfadys/37reA4fM0tMfLY6
         9qJOCA6iIbIBynyJBVlJQ5wxE/pAB8EbdWq8wHNjvr4xbIVtNqPb1XgniDT7MRE5xEfg
         CuyAz3eLLUiL+gKyThMlKobjgyyviYAhtl57+/utSfaPFPYjYBHmtcgI4e5Mt4I6DPnm
         uu36vG2LJFNpNlWxDqa5M+r4OjJdUrUUTzueyjjJCj0er9C9srzCwyHQmsFNv7mp8P9J
         3Sj0ieN/uNxOSQOmeO3r33JDZ5na3iDBacdXPfEzIdBmqC/FemsjrM0O6fVe6PDJ3YE3
         NIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970655; x=1775575455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGFhbyoYTQhRoR8CNaMRtIaS092Mdbpa9pQ3Tyd4RHc=;
        b=WGRnmd+U+D9zojBVv/lj1x6jXQs4BCE6dRIaAjvnm/7SRGNdZOIsxAENoNUhtW2cul
         xkM2XX22dcRtMVB75/fgqLuAr4gmN0nUow4pw4psvs71awkFn/PRv9xI4WdH0j7U5USG
         L0tLk+ih2vRD/GxQFSrTUj4YfsgmcQ90Olz2akzN3Euv7slBHb0jlRMW5Ud8466WIRUx
         VvlQh2f8zL5gaSwQzeqz2ymkkGer5dpkkAiwL1qmsJupvpGtHVKdp4I+UVQ3vZZ626TX
         Qb4Six1tFpyb0j/y1xDskHPak+qlNjQRc7o5LkH3lgnuCiUk+ZLCJdcj+XZfIuWJP0eZ
         HSaA==
X-Forwarded-Encrypted: i=1; AJvYcCWm0JwK5tMQcWblljILzkGNOWigqxqCXQHI+CG/mYVPbdgMAvQ3FYxAAH+xouz2YAEbZus=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2pCq83/OoH7E/Veq01frGcvbf+2hlIMhaNSuhlrPwzm+HH0c
	4HSInqN/E5AZbpSCpQYD5VBYY0Z8VI59XfaHvTE5k5nmcdJHVDPXfRObtVLmTfdfvhlewj/D20u
	PCOGCa4wAzMJ7YbTS2l+t9StB5jQFXkbWNQ==
X-Gm-Gg: ATEYQzwNymFe+SbmEG64QB5/CNcfFcF/Zg3GG1naK728ZCn8vIwtqfG0HqLjOXpEk0U
	2TbKUHcPrhSgRn5ZkqZNY8NSNRMsPDbb8mm11uHTJ5ulRuSmps4j3p5rm3vbQlYEkphnKxSbjI3
	/oNb+SRDtIuflFkB5e2OnagY7bW6yQaLqi01zBXMGRzozFiD4pWHWrnoPz19P3GMlSzYrTuS2/r
	5h8dhXjRwPWxfAevxfPpuguGWclvDJFuCC4b11oikaiptNH+SYIX+sU1HliuHhGrhhXRaqtygLA
	DuyByqcnMuvJty/6XJ9M0O3+Z+PiTj5BaOI/ta6gQj3WFoau3lX28vZexHWFK+duekGgCENUW0l
	OEPPrUR1GGB5HVlFDZuFsnbTy6Q==
X-Received: by 2002:a05:600c:4ed3:b0:483:6d4a:7e6d with SMTP id
 5b1f17b1804b1-48727f1b67emr281584945e9.30.1774970654552; Tue, 31 Mar 2026
 08:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
 <20260330-sleepable_tracepoints-v8-1-2e323467f3a0@meta.com> <CAEf4BzaR-Lm=zGkf3ar1bbeEKwgedrPbMwrPvJunVe1LCcjfag@mail.gmail.com>
In-Reply-To: <CAEf4BzaR-Lm=zGkf3ar1bbeEKwgedrPbMwrPvJunVe1LCcjfag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Mar 2026 08:24:02 -0700
X-Gm-Features: AQROBzBnpl7k_GhWJiRxibC5-dDrlrH10O95w5fd-_R_WgIwpT-H-vHsYScbzuk
Message-ID: <CAADnVQL0GG114O0Oig+PRvscgH9v-hg5vSDVoqwKgOX-TpoNow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 3:20=E2=80=AFPM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Rework __bpf_trace_run() to support sleepable BPF programs by using
> > explicit RCU flavor selection, following the uprobe_prog_run() pattern.
> >
> > For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
> > protection with migrate_disable(). For non-sleepable programs, use the
> > regular rcu_read_lock_dont_migrate().
> >
> > Remove the preempt_disable_notrace/preempt_enable_notrace pair from
> > the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
> > migration protection and RCU locking are now handled per-program
> > inside __bpf_trace_run().
> >
> > Adapt bpf_prog_test_run_raw_tp() for sleepable programs: select
> > RCU flavor per-program and reject BPF_F_TEST_RUN_ON_CPU since
> > sleepable programs cannot run in hardirq or preempt-disabled context.
> >
> > This prepares the runtime execution path for both BTF-based raw
> > tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
> > sleepable BPF programs on faultable tracepoints (e.g. syscall
> > tracepoints). The verifier changes to allow loading sleepable
> > programs are in a subsequent patch.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  include/trace/bpf_probe.h |  2 --
> >  kernel/trace/bpf_trace.c  | 20 ++++++++++++++---
> >  net/bpf/test_run.c        | 55 ++++++++++++++++++++++++++++++++++-----=
--------
> >  3 files changed, 57 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > index 9391d54d3f12..d1de8f9aa07f 100644
> > --- a/include/trace/bpf_probe.h
> > +++ b/include/trace/bpf_probe.h
> > @@ -58,9 +58,7 @@ static notrace void                                  =
                 \
> >  __bpf_trace_##call(void *__data, proto)                               =
         \
> >  {                                                                     =
 \
> >         might_fault();                                                 =
 \
> > -       preempt_disable_notrace();                                     =
 \
> >         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U6=
4(args));        \
> > -       preempt_enable_notrace();                                      =
 \
> >  }
> >
> >  #undef DECLARE_EVENT_SYSCALL_CLASS
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 0b040a417442..8066249e4ba2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_even=
t_map *btp)
> >  static __always_inline
> >  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> >  {
> > +       struct srcu_ctr __percpu *scp =3D NULL;
> >         struct bpf_prog *prog =3D link->link.prog;
> > +       bool sleepable =3D prog->sleepable;
> >         struct bpf_run_ctx *old_run_ctx;
> >         struct bpf_trace_run_ctx run_ctx;
> >
> > -       rcu_read_lock_dont_migrate();
> > +       if (sleepable) {
> > +               scp =3D rcu_read_lock_tasks_trace();
> > +               migrate_disable();
> > +       } else {
> > +               rcu_read_lock_dont_migrate();
> > +       }
> > +
>
> At first, looking at this repeating pattern I was going to suggest
> adding some macro, e.g., bpf_prog_run_rcu_pre(prog) and
> bpf_prog_run_rcu_post(prog) (whatever the name) which would do this
> dance of sleepable/non-sleepable rcu lock and migration. But then I
> thought why not have a scoped guard for this? I'd even look into
> hiding run_ctx manipulation inside it.
>
> Curious what others think, whether it would make sense?

I feel copy pasting it in these two places is fine for now.
If it spreads then yeah the helper would be needed.
