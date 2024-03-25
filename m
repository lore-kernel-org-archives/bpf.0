Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD3144311
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387274; cv=none; b=ZelUYcB5FjVkqaSHTmRy+ij2GY0DurEgSyiYXtdsxmaZ8Uz6qfwnnCYA5rwXEoEaFPPdw0R9EhF/kYJEbnA79FTDcGNhq0B59Q/PXk6B7NhcIvZZHopQHft7jHVmp2dO0zmFggL4FfeFwim/bvpMQbmf6E5W8ExJBsNpX+KRfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387274; c=relaxed/simple;
	bh=zC4eSJN9H7wkWzBk/SVlMgcBZYGR8L2yIV4MBz6ueD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/VTIe/jVnfhonxK+G8wflHTdlvpzmJaT5xibCSY8Fwsi2WXWWlbVHKsm9rqgtZQ/qhB7Q1VT4mLR7C5bVAVfja0Qt6oUoCmSAMbtdrAUI9T/ZT7jW8iRw8FRIiklPVrT4huKJ4wCslNQb8wr+n93fUOHlsSgFMUwfCKJBg7n8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0xOj14Q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0xOj14Q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3227573a12.1
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387272; x=1711992072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqhy5/uk+MEM5f7ULfd8n8YY3GZWfnrFZQDZok68FI8=;
        b=K0xOj14QAq/vDKQtzC5s+aVS3eKpssXo607SjWtJh8udcEN+wzfNB0L1s7AOtOvWMi
         iNZ1g12kKYmPvfjbhXv0MkhdYw/uvDuYAoTMF9TRJ4fTGOqWOQsD82v5aw52/94X3oHX
         vja3xMkytNnh/Q0yLpH6DI9JPuo/VMrMguDN3FR4RUWUxZ4uFeSeMHpyir2iZ5wO7awc
         SjQZv05vpojq4Hi8j3bA/lf3oI7ZlFmirB5JBdeqsreXEpBDBqEMQgCGfYMjUXmp8ANj
         bLqQG5sJImhYTujJgHfykiLnJUYKpPOAL8mRFuB018k+NU7e98mffmXOImbAwOXnoORr
         ZFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387272; x=1711992072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqhy5/uk+MEM5f7ULfd8n8YY3GZWfnrFZQDZok68FI8=;
        b=QPeqdTpAgUwHFZlOhe7lnuzlOWtiH2ON0i+zVxxWL7NkP/wkYvtlWEKpoMoGwAVf6l
         wrFjpXX7C+rFUZHrLihbWyL3asHxjDYvUjqo9aEEW+LfXJEVcOdSbA2Ecuqu3UAL7rwn
         Oi2fDMBDpz860RdY19Pyzoko8j8HsdXANFTXECDExJtIgccKJgPdpHau42BDFvY7sTRw
         yQgIwElSolHFdlTwuIDRzY98Dyxhyt+kyBpP9/2NLHP1ZJa4hI3jgRwbzsCri/k2U/5w
         Q1mNxcp5Xol8GTJgaqHcv02dTOxiJR70kJSoy3bAll+Nd6rqxYwRFi77Rrx099FVGG2j
         GnEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9+7HqHd7B4XcrZUeS5Jp7Ett/w1Q8YHEh9lm9jb+Y+HhPGATjsjQxIkc2c/TMcBNtNWB3wTIF0T+Kf2xAYb3h+K38
X-Gm-Message-State: AOJu0YxYLRFT82nHxrFXG02rfMbopzEG0sFemU5XAyU+L60ytbweAsa8
	qAHDS7pivfdi1iMZpA87PLroVq9LLZ9buuv1q6Wp3z7PlM30aRVl+ToZIgP6KoAOiO+kXS2vlV6
	oT7Hmtnb4lawoMWAdnx3P9v82XWE=
X-Google-Smtp-Source: AGHT+IGdkRX+JYg+RXIM5D/e5Pd6zm2G9WZykVOkr6OraGvVduP/IGrrk4bup7gqHkU0o4DVJLAR32yc59w6uL8/Y3k=
X-Received: by 2002:a17:902:d4c3:b0:1e0:d6ce:7e29 with SMTP id
 o3-20020a170902d4c300b001e0d6ce7e29mr682065plg.62.1711387271691; Mon, 25 Mar
 2024 10:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <CAADnVQJqnLnv4AUvCaefP13CDcJOXM=kJpSOv33t-u-OTzb0UQ@mail.gmail.com>
 <CAEf4BzYFc1b-OAXWf4WN_vM2evZgsW7reJqo8iwKP80EXBJMKw@mail.gmail.com> <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
In-Reply-To: <CAADnVQ+zT8C=rHtTbbsdoPVw-n7PPufPp0CC+jt2PUn9bB5gxw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 10:20:58 -0700
Message-ID: <CAEf4BzZqem6OQX=LHwz7cfvCGXmbFVHzSgD-9i6C8dfMJTMT3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Inline two LBR-related helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 7:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 9:45=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2024 at 4:46=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kern=
el.org> wrote:
> > > >
> > > >
> > > > There are still ways to reduce number of "wasted" records further, =
this is
> > > > a problem that requires many small and rather independent steps.
> > >
> > > I feel this is a wrong path to follow.
> > > I think it would be better to introduce a flag for kprobe/fentry
> > > to do perf_snapshot_branch_stack() as early as possible
> > > and then bpf prog can copy these 16 or 32 8-byte entries at
> > > its leasure.
> >
> > This is basically how Song started when he was adding this feature a
> > few years ago. And I feel like we discussed this and decided that it
> > would be cleaner to let the BPF program decide when (and whether) to
> > get LBR, based on conditions. It still feels like a right tradeoff.
>
> Right we discussed it back then and at that time it was about
> collecting stacks.
> What's different now is you want to collect all types of branches

I was using --lbr=3Dany from the get go (and it actually was a
motivation for the entire feature, because we were lacking visibility
inside some large function with lots of conditions), but yes, we had
to leave with a bunch of entries wasted, which on Intel CPUs with 32
entries was tolerable, but on AMD now is useless (we get only 1-2
useful entries right now).

> in retrnoop including plain 'jmp pc+10' and conditional jmps.
> This is not something that C code can control.
> always_inline in C and inline by the verifier reduce call frames,
> but they may have both positive and negative effect when
> all branches are collected.
> Hence __always_inline in kprobe_multi_link_prog_run()
> is a leap of faith with assumptions that compiler won't
> add jmps before calling into prog,
> but lots of different compiler flags add instrumentation:
> kasan, stack protector, security mitigation that count call depth, etc.
>

I understand that, but at least for now in practice it does help. I
have some more changes in fprobe/ftrace space which reduces waste of
LBR entries some more (and would be beneficial regardless of this
custom flag support we are discussing), and there is some really good
news with aggressive inlining. a) I get only 4 entries wasted for
multi-kprobe (7 for fentry, still not bad, but this one is harder to
optimize) and b) I get +25% speed up for multi-kprobes, which seems
like a nice side benefit.

So I agree that none of this is any guarantee, but it also is not some
binding UAPI, so seems worth doing. And as I pointed above, I don't
think I see any regression in performance, rather the opposite.

>
> > Granted, for PERF_SAMPLE_BRANCH_ANY you gotta take it immediately (and
> > that's what retsnoop does), but for PERF_SAMPLE_BRANCH_ANY_RETURN this
> > doesn't have to happen so fast. BPF program can evaluate some
> > conditions and grab LBR optionally, saving the overhead.
> >
> > With prog flag saying "kernel should capture LBR ASAP", we:
>
> I was suggesting to use per attachment flag.
> And kprobe is a lost cause.
> I would do it for fentry only where
> we can generate 'save LBR' call first thing in the bpf trampoline.
>

See above, I get down to just 4 unavoidable LBR entries wasted with
multi-kprobe, all without a custom flag anywhere.

I just really not think it's worth it to complicate trampoline just
for this, we'll save at most 1-2 LBR entries, inlining
bpf_get_branch_snapshot() gets all basically the same benefit, but
across all supported program types.


> >   a) lose this flexibility to decide whether and when to grab LBR;
> >   b) pay overhead regardless if LBR is ever actually used for any
> > given prog invocation;
>
> when retsnoop attaches a prog the prog gotta call that 'save LBR'
> as soon as possible without any branches.
> So per-attach flag is not really a downside.

for retsnoop, yes, but only if this is supported in multi-kprobe,
which is the main mode. But see above, I just don't think we have to
do this to get almost all the benefit. I just need to inline
bpf_get_branch_snapshot().

>
> >   c) have to dedicate a pretty large (32 * 24 =3D 768 bytes) per-CPU
> > buffers for something that is pretty niche (though hugely valuable
> > when needed, of course);
>
> I wouldn't worry about such a tiny buffer.
>
> >   d) each program type that supports bpf_get_branch_snapshot() helper
> > needs to implement this logic in their corresponding
> > `bpf_prog_run_xxx()` running helpers, which is more than a few places.
>
> I think new kfunc that copies from the buffer will do.
> Nothing needs to change.
> Maybe bpf_get_branch_snapshot() can be made smart too,
> but that is optional.
>

I meant that fentry would need to implement this LBR capture in BPF
trampoline, multi-kprobe in its kprobe_multi_link_prog_run, kprobe in
still another helper. And so on, we have many targeted "runner"
helpers for specific program types.

And just implementing this for fentry/fexit is not very useful.

> > Now, let's see how much we can also realistically save with this approa=
ch.
> >
> > For fentry, we do save a few (2) entries, indeed. With changes in this
> > patch we are at:
> >
> >   [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
> >   [#06] __x64_sys_bpf+0x1a                       ->
> > bpf_trampoline_6442508829+0x7f
> >   [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_r=
ecur+0x0
> >   [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x=
0
> >   [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_r=
ecur+0xe
> >   [#02] __bpf_prog_enter_recur+0x43              ->
> > bpf_trampoline_6442508829+0xa1
> >   [#01] bpf_trampoline_6442508829+0xad           ->
> > bpf_prog_dc54a596b39d4177_fexit1+0x0
> >   [#00] bpf_prog_dc54a596b39d4177_fexit1+0x101   ->
> > intel_pmu_snapshot_branch_stack+0x0
> >
> > With flag and kernel support, we'll be at something like
> >
> >   [#07] __sys_bpf+0xdfc                          ->  __x64_sys_bpf+0x18
> >   [#06] __x64_sys_bpf+0x1a                       ->
> > bpf_trampoline_6442508829+0x7f
> >   [#05] bpf_trampoline_6442508829+0x9c           ->  __bpf_prog_enter_r=
ecur+0x0
> >   [#04] __bpf_prog_enter_recur+0x9               ->  migrate_disable+0x=
0
> >   [#03] migrate_disable+0x37                     ->  __bpf_prog_enter_r=
ecur+0xe
> >   [#02] __bpf_prog_enter_recur+0x43              ->
> > intel_pmu_snapshot_branch_stack+0x0
>
> with flag migrate_disable and prog_enter* will be gone.

I don't think we can get rid of migrate_disable, we need to make sure
we are freezing LBR on the CPU on which BPF program will run. So it's
either preempt_disable or migrate_disable.

Yes, __bpf_prog_enter_recur() won't be there if we code-generate code
for BPF trampoline (though, ugh, who wants more code generation than
necessary, but that's an aside). But then see above, migrate_disable
will have to be called before __bpf_prog_enter_recur(), which is just
more opaque code generation than necessary.

> It will be only bpf_trampoline_ and intel_pmu_snapshot_branch_stack.

Note also __x64_sys_bpf+0x1a, it's the artifact of how fexit is
implemented, we call into original function and it returns into
trampoline. So this seems unavoidable as well without completely
changing how trampoline works for fexit. Multi-kprobe actually,
conveniently, avoids this problem.

> If we try hard we can inline
> wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> Then it will be bpf_trampoline_ only and
> that's as minimal as it can get. One entry.
> Hacking all over the kernel with inline won't get anywhere close.

It's not like I'm doing something technically wrong, just enabling
more inlining. And it's not really all over the kernel, few targeted
places that deal with LBR and BPF programs running.

>
> > For PERF_SAMPLE_BRANCH_ANY_RETURN return mode there will be no savings
> > at all. Is it really worth it?
>
> any_return is ok today.
> Especially with fentry.

Yes, even today we are at 2-3 entries, I'm not too worried about this
in general.

>
> > While inlining bpf_get_branch_snapshot() does benefit only LBR use
> > case, it's a rather typical BPF helper inlining procedure we do for a
> > lot of helpers, so it's not exactly a hack or anything, just an
> > optimization.
>
> Inlining bpf_get_branch_snapshot() may be ok,
> but the way you're doing is not a clear win.
> Replacing size / 24 (that compiler optimize into mul)
> with actual divide and adding extra mul will be slower.
> div+mul vs mul is quite a difference.
> How noticable is that is questionable,
> but from inlining perspective it doesn't feel right to do
> "inline to avoid extra frame" instead of
> "inline to improve performance".

Yes, I saw this division-through-multiplication division. I can
replicate that as well, but it will be pretty hard to understand, so I
thought it is probably not worth it. Note that
bpf_get_branch_snapshot() is not some sort of performance-critical
helper, if you are calling it on some super frequent kprobe/fentry,
you are paying a lot of price just for copying 700+ bytes (and
probably a bunch of other stuff).

So I think it's a wrong tradeoff to optimize for performance.
bpf_get_branch_snapshot() is about information (most complete LBR),
and that's why the inlining. I know it's a bit unconventional compared
to other inlining cases, but it's still valid objection, no?

>
> > But inlining bpf_get_smp_processor_id() goes way beyond LBR, it's a
> > pretty frequently used helper used to implement various
> > BPF-program-specific per-CPU usages (recursion protection, temporary
> > storage, or just plain replacing BPF_MAP_TYPE_ARRAY_PERCPU with global
> > variables, which is already a bit faster approach, and now will be
> > even faster). And the implementation is well-contained.
>
> Agree that inlining bpf_get_smp_processor_id() is a good thing,
> but please do it cleanly so that per-cpu accessors can be
> reused in other places.
> I'll reply with details in the other thread.

Agreed, internal special instruction makes sense, replied on that patch as =
well.
