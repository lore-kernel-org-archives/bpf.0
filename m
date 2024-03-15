Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0226AF2
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521944; cv=none; b=BEuCFYgHKF8+9EesT9dmWXr6KAKIlxcxhalMa4sMLR7T17RbSPsj0MjsA0lpyoqFHdEhyhXHxE0UFfVRJZ2ficD/5NeRymbXxkhsaeFu41IZAsKFPRrRch19NyuLHF10YkGFTiMLXU6j+76ayUjii2b3vFrgCL5iQ9Jkzpm+wPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521944; c=relaxed/simple;
	bh=D1813do/uskOEUdvyxNXcKh7StjKPgkwZCyXFkchDMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWkUGIgMvebBDBg+PRZHHqhAac3e3aqeoTqgMuZvka2FZ9PHOgadh80M6SM+OAqrcZxzJYWOnr70Slzo9f9fPmahtfus+AXg4CiJYU0KAeUbb7xtMfTz/li9dbwrZBOQ1mhHzrOC9cov4WGW0MHSW8Pap0aNbAw2X8157u9cS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRRm455j; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRRm455j"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so2225341b3a.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710521942; x=1711126742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1NU8JPYJBQgHRkppyJN3pM9D6bDHka13EuB3PZwDWE=;
        b=HRRm455jnK9KDCJWlqcPpuTAOoz8OJvs/w9aKj30qdLvcF6pB1GvauPacf4yI0qkxp
         DLhoqBgpTO8V1IO7j2ZgVKze26hLH9iyO21pb1I9STJ3ULmYFlcjKozAl3z3rjMZD30l
         oNh0JhZDV+Wq4oqimQ0OEJa00o3s6FLT7s0zlsbmyu1FiUaTq+LPivRsaBaStFO8lWgD
         CnmQxT25V9LPAQuFgh+ga5Ay+54EipeJQU29RVSzoppIPsmjuUDFhN3tOeVVwNPhejFT
         WlpzoOiW+GFbiho/9r1Z+hJEYD8vcFn8m7kEv/zJcjrUmCVHvNTF9Ra7QXx/Ja0lMRHg
         j0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521942; x=1711126742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1NU8JPYJBQgHRkppyJN3pM9D6bDHka13EuB3PZwDWE=;
        b=Wpljp7EZQ8KOSWhMh2/G3raP1vHgzT1Z3n5g4YIYcGImqNbscJ/LMZkqXAQTwwos6x
         liyLk0Er7Ytxjh6qunO8FKuxlpNSReRO6WhzoaxNDSsa5JPpiueBpaQbU2H/qi0umbtb
         6O0FOOu8W7Z402Mf63UNCeuH7xZAEP2Iyepr+RbvMGf9k17yhaqrDBWwgQfXijFVcKl7
         YvzzJe7ZBjecg7b6pCCW/0rjJRPushwjfoW3DZZhAKQeP0Wf6SbK00ywaGgp3X84lK9a
         3ggAzyUDusp9IqoojQps+FbsgSnAe0AxCUcs/XcSAiJmZf9Bk2Q1Obr69qcQ5qCt8tlt
         LShA==
X-Forwarded-Encrypted: i=1; AJvYcCUmooDP9c9OkFhWDCPS6iyTddvLP5Nmg7D8vflldGXzHlhIziRNYt8OhPChOJE8P4SYjV3BTu2hvS1dRh2kic2842/e
X-Gm-Message-State: AOJu0YzqiZkyDX7KLn4x6rB8KCgbvvry7nDuR4SQAp5t/xDDJl4fmPRd
	smfdfK63BQSf4HPBeQXuut8/R4pdHlfWrkdaUe6uVOJEROHrkqld83JUMKU4sVp8Bcd/HnNpfSm
	zWDLvKvLipWPnEqJGM9Yb1NaLowU=
X-Google-Smtp-Source: AGHT+IHs+YEoYPA8eMG0zg26Efl8/E8Ay7fOub1mIEOMNetEKhfFvZcQrwR0tiIewXaAaDRo+n732lEATqZyIX+LmUk=
X-Received: by 2002:a05:6a00:1405:b0:6e6:7bcb:b886 with SMTP id
 l5-20020a056a00140500b006e67bcbb886mr4331332pfu.30.1710521941827; Fri, 15 Mar
 2024 09:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315051813.1320559-1-andrii@kernel.org> <20240315051813.1320559-2-andrii@kernel.org>
 <CAADnVQLFCVCdb4Uu+6QJMDybUc5RqLCF-5yS2eQVoQ==qq3vvQ@mail.gmail.com> <CAEf4BzYuMJVoEhK=wHhzDN2193ZvTupG6i+Ya6YjZNWohdADxQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYuMJVoEhK=wHhzDN2193ZvTupG6i+Ya6YjZNWohdADxQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:58:50 -0700
Message-ID: <CAEf4BzY433C4NJog_mQLQC0oK_7k5zs2xSgxx9qQ7f+QsST5cA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:31=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 15, 2024 at 9:03=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 10:18=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping betw=
een
> > > one syscall execution and BPF program run. While we use a fast
> > > get_pgid() syscall, syscall overhead can still be non-trivial.
> > >
> > > This patch adds kprobe/fentry set of benchmarks significantly amortiz=
ing
> > > the cost of syscall vs actual BPF triggering overhead. We do this by
> > > employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp progra=
m
> > > which does a tight parameterized loop calling cheap BPF helper
> > > (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> > > attached for benchmarking.
> > >
> > > This way 1 bpf() syscall causes N executions of BPF program being
> > > benchmarked. N defaults to 100, but can be adjusted with
> > > --trig-batch-iters CLI argument.
> > >
> > > Results speak for themselves:
> > >
> > > $ ./run_bench_trigger.sh
> > > uprobe-base         :  138.054 =C2=B1 0.556M/s
> > > base                :   16.650 =C2=B1 0.123M/s
> >
> > What's going on here? Why two bases are so different?
> > I thought the "base" is what all other benchmarks
> > should be compared against.
> > The "base" is the theoretical maximum for all benchs.
> > Or uprobe* benches should be compared with uprobe-base
> > while all other benchs compared with 'base' ?
> > Probably not anymore due to this new approach.
> > The 'base' is kinda lost its value then.
>
> naming is hard. base is doing syscall(get_pgid) in a tight loop. It's
> base compared to previous trigger benchmarks where we used syscall to
> trigger kprobe/fentry programs. uprobe-base is just a user-space loop
> that does atomic_inc() in a tight loop. So uprobe-base is basically
> the measure of how fast CPU is, but it's unrealistic to expect either
> fentry/kprobe to get close, and especially it's unrealistic to expect
> uprobes to get close to it.
>
> Naming suggestions are welcome, though.
>
> I'm not sure what the "base" should be for xxx-fast benchmarks? Doing
> a counter loop in driver BPF program, perhaps? Would you like me to
> add base-fast benchmark doing just that?
>

How about this.

base -> base-syscall (i.e., "syscall-calling baseline")
uprobe-base -> base-user-loop (i.e., "user space-only baseline")
and then for "fast" baseline we add "base-kernel-loop" for
"kernel-side looping baseline"

Or we can use some naming based on "counting": base-syscall-count,
base-user-count, base-kernel-count?

Any preferences, anyone?

>
> >
> > > tp                  :   11.068 =C2=B1 0.100M/s
> > > rawtp               :   14.087 =C2=B1 0.511M/s
> > > kprobe              :    9.641 =C2=B1 0.027M/s
> > > kprobe-multi        :   10.263 =C2=B1 0.061M/s
> > > kretprobe           :    5.475 =C2=B1 0.028M/s
> > > kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> > > fentry              :   14.544 =C2=B1 0.112M/s
> > > fexit               :   10.637 =C2=B1 0.073M/s
> > > fmodret             :   11.357 =C2=B1 0.061M/s
> > > kprobe-fast         :   14.286 =C2=B1 0.377M/s
> > > kprobe-multi-fast   :   14.999 =C2=B1 0.204M/s
> > > kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> > > kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s
> > > fentry-fast         :   31.475 =C2=B1 0.254M/s
> > > fexit-fast          :   17.379 =C2=B1 0.195M/s
> >
> > I think the "-fast" suffix doesn't really fit here.
> > It's a different way to benchmark fexit vs kprobe overhead.
> >
> > I think the old approach should be replaced with the new one.
> > There is no value in keeping the old stuff around when
> > now it's clear that it's measuring much more than it should.
>
> I'd say we should keep them. Note that fmod_ret, tp, and raw_tp can't
> be benchmarked the same way. So we don't have -fast variants for them.
> If we get rid of pre-existing fentry/kprobe benchmarks, we won't be
> able to compare raw_tp/fmod_ret/fexit.s to them.
>
> And to be clear, in practice I'm not comparing xxx-fast with xxx at
> all. I just put all the numbers in this patch summary to show that we
> indeed have a significant performance lost on syscall.
>
> In practice when comparing kprobe vs fentry, it should be kprobe-fast
> vs fentry-fast.
>
> >
> > > One huge and not yet explained deviation is a slowdown of
> > > kretprobe-multi, we should look into that separately.
> > >
> > > kretprobe           :    5.475 =C2=B1 0.028M/s
> > > kretprobe-multi     :    5.703 =C2=B1 0.036M/s
> > > kretprobe-fast      :    7.646 =C2=B1 0.084M/s
> > > kretprobe-multi-fast:    4.354 =C2=B1 0.066M/s
> >
> > That is weird indeed. Since it's a single cpu run
> > it cannot be due to contention.
> > My gut feel is that something odd is here:
> > #ifdef CONFIG_X86_KERNEL_IBT
> > static unsigned long get_entry_ip(unsigned long fentry_ip)
> >
> > Did you have it in your config?
>
> No, this was without IBT. I do have an upcoming small patch to
> eliminate unnecessary copy_kernel_nofault() in IBT path, but I don't
> think this is it. It should be pretty clear with profiling where we
> are losing CPU, I just didn't have time/desire to look into it, as I
> have tons of small things being worked on in parallel and didn't want
> to add another one.
>
> >
> > > +SEC("raw_tp")
> > > +int trigger_driver(void *ctx)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < batch_iters; i++)
> > > +               (void)bpf_get_smp_processor_id(); /* attach here to b=
enchmark */
> >
> > bpf_get_numa_node_id() is probably even faster and
> > not subject to DEBUG configs.
>
> Sure, I can switch to that, np.
