Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420659178
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198364; cv=none; b=NWKCNR7HR4XP9M7cIeedaA8rX4dhEkzvM7bjX3NbS77BPCoZ+Y+/jluu0SDXdYBJG+EXGpuYooWoQSJH69fdC+7ME+dSklhvrUxUu0hjoxzBeIbRdz6uhksZwCFz+eH/KuTIX4OEvx9xnOIcIYkbz5xhD2zr8UUI7XzB9kKOR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198364; c=relaxed/simple;
	bh=JFzLbq4Dk41VLjS87Q8f92QmrhlQYluE3V4qNxgv6bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuSfURHxWZ2aq5BFj6mN6+K6ga9zf4IAXpuDQDmPXxNGAtvcq0Q8dVQfrqC7i3YkW6N+Cd6IC/bAtD5WlJLWakBjRp1D3q5qCuQbLydGM2omNWDTIIUsJ2mAHGhh7LDQy4Ivh7k6v9+Y2W5KEx2itoXpUJXzk5F29FyO2VsiWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuDuwa+n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuDuwa+n"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso2765371a91.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710198362; x=1710803162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkzKzHemEf7AAMAt34M2UcTPtGEgZi8eg2uqfCyOjSQ=;
        b=VuDuwa+nnA0883BaMOVS0gJTRdjk+WpkvEdRtVhYit4TWZwOzETVWrW6qCx9xBq+6N
         bPigFLeho/gPrAI4LDCzNvHXHnIhO4GRNyhJVt96Pe7sUAM80/HeeDWIhm4XovwtE6Mw
         2h0ZUd/tn6/ySAJ3l7OcgtqAioADCM7PSBKniifJG/PH1UWSjOfiA5lSvPUEYXRwUQEf
         S7ksO0scY7l2ZSs7j1mdr3DP/s4Z7KG4L/EXfUtP8Q+spX0sZsBEt1lm+GZB3lBI2F56
         ECE6paA5ogM7zW/FRpSy0epRFZgF5EMnQ9uZ07Jj3+AhT5bHeol36ozPvLjUbzOZPmnW
         xptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198362; x=1710803162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkzKzHemEf7AAMAt34M2UcTPtGEgZi8eg2uqfCyOjSQ=;
        b=C5BeuV7IWgdpxNSARctRsk7m1su5YQMQEmt7sDcSXQKDoLGCwShLWOKHbwh8yzZkKK
         +mYtSd3TtlpTSl66o6vOlIKA3Bgp6gsWa0jefQgRz/eiF+erGsl1GVD6XlsSFiOzDcQX
         s5qich9SfOyDnyM01O5aVnj48yDkCto9UPOTz7uNh5Dib+qcMvlexLoPU6yXLnhAPTyc
         KDyN8m3L0lTr9FJksaQ35SbqQoXvjeagqwOzRbYuOVBaYXaRZsAwywgqXhB2cNqR8jkB
         Vn5vC+/zOMUpFXKtTE9xVRNU0xRwIPiq6Y7IhDmPyRxXorjYJ1Mtx1aXiTmWNq62V3ty
         cR/g==
X-Forwarded-Encrypted: i=1; AJvYcCVj7CBWw+hXROAlVBoRt/1EZWo1e3cXFxIeal2ziuFG/noAggO1hDLmHOr+FOVdbBv3Or4f2+xigM3O18csvSLXm9cl
X-Gm-Message-State: AOJu0Yzmmyyy69KIUqtCFAfgFMpCqJqQyK4KCuproYlbou7qD7UJGdk3
	8Nj5awBr+xsNl+Q3j8N0zkKG5C4n2Jw8tBcZ0ghy42nuXVuSxCYlL2zMOyIUxQffZBXl11fXRXQ
	wlm/Dm7bgtgK3i8LQZDmZNM/LCuE=
X-Google-Smtp-Source: AGHT+IGmBTGwOmzTvlwv0TYdcVEcz30XaB28tm6gC0n7cnmzR0czxSVUxhPUgcqawrib9Y5eNy8zwQXBzxrwEtS9R+w=
X-Received: by 2002:a17:90a:77c5:b0:299:1777:134c with SMTP id
 e5-20020a17090a77c500b002991777134cmr1778656pjs.33.1710198361657; Mon, 11 Mar
 2024 16:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava> <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava> <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava> <Ze7kGP5aAYGseRuM@krava> <CAEf4BzZwg-h5QejGRHwZ4h_up2VJZ=cCoU-a_8Jr6JCqso620Q@mail.gmail.com>
 <Ze928Ht_GvV6_GzU@krava>
In-Reply-To: <Ze928Ht_GvV6_GzU@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 16:05:49 -0700
Message-ID: <CAEf4Bzbi723hhhZKFWOBDVo7xyQXN8Rf616fu+vyb_2m+obNQA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, yunwei356@gmail.com, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:26=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Mar 11, 2024 at 10:32:23AM -0700, Andrii Nakryiko wrote:
> > On Mon, Mar 11, 2024 at 3:59=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Tue, Mar 05, 2024 at 09:24:08AM +0100, Jiri Olsa wrote:
> > > > On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> > > > > On Sun, Mar 3, 2024 at 2:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.=
com> wrote:
> > > > > >
> > > > > > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote=
:
> > > > > > > On Fri, Mar 1, 2024 at 9:01=E2=80=AFAM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko=
 wrote:
> > > > > > > > > > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsa=
jiri@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > One of uprobe pain points is having slow execution th=
at involves
> > > > > > > > > > > two traps in worst case scenario or single trap if th=
e original
> > > > > > > > > > > instruction can be emulated. For return uprobes there=
's one extra
> > > > > > > > > > > trap on top of that.
> > > > > > > > > > >
> > > > > > > > > > > My current idea on how to make this faster is to foll=
ow the optimized
> > > > > > > > > > > kprobes and replace the normal uprobe trap instructio=
n with jump to
> > > > > > > > > > > user space trampoline that:
> > > > > > > > > > >
> > > > > > > > > > >   - executes syscall to call uprobe consumers callbac=
ks
> > > > > > > > > >
> > > > > > > > > > Did you get a chance to measure relative performance of=
 syscall vs
> > > > > > > > > > int3 interrupt handling? If not, do you think you'll be=
 able to get
> > > > > > > > > > some numbers by the time the conference starts? This sh=
ould inform the
> > > > > > > > > > decision whether it even makes sense to go through all =
the trouble.
> > > > > > > > >
> > > > > > > > > right, will do that
> > > > > > > >
> > > > > > > > I believe Yusheng measured syscall vs uprobe performance
> > > > > > > > difference during LPC. iirc it was something like 3x.
> > > > > > >
> > > > > > > Do you have a link to slides? Was it actual uprobe vs just so=
me fast
> > > > > > > syscall (not doing BPF program execution) comparison? Or comp=
aring the
> > > > > > > performance of int3 handling vs equivalent syscall handling.
> > > > > > >
> > > > > > > I suspect it's the former, and so probably not that represent=
ative.
> > > > > > > I'm curious about the performance of going
> > > > > > > userspace->kernel->userspace through int3 vs syscall (all oth=
er things
> > > > > > > being equal).
> > > > > >
> > > > > > I have a simple test [1] comparing:
> > > > > >   - uprobe with 2 traps
> > > > > >   - uprobe with 1 trap
> > > > > >   - syscall executing uprobe
> > > > > >
> > > > > > the syscall takes uprobe address as argument, finds the uprobe =
and executes
> > > > > > its consumers, which should be comparable to what the trampolin=
e will do
> > > > > >
> > > > > > test does same amount of loops triggering each uprobe type and =
measures
> > > > > > the time it took
> > > > > >
> > > > > >   # ./test_progs -t uprobe_syscall_bench -v
> > > > > >   bpf_testmod.ko is already unloaded.
> > > > > >   Loading bpf_testmod.ko...
> > > > > >   Successfully loaded bpf_testmod.ko.
> > > > > >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> > > > > >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> > > > > >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> > > > > >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> > > > > >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> > > > > >   test_bench_1: uprobes (1 trap) in  36.439s
> > > > > >   test_bench_1: uprobes (2 trap) in  91.960s
> > > > > >   test_bench_1: syscalls         in  17.872s
> > > > > >   #395/1   uprobe_syscall_bench/bench_1:OK
> > > > > >   #395     uprobe_syscall_bench:OK
> > > > > >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > > > >
> > > > > > syscall uprobe execution seems to be ~2x faster than 1 trap upr=
obe
> > > > > > and ~5x faster than 2 traps uprobe
> > > > > >
> > > > >
> > > > > Thanks for running benchmarks! I quickly looked at the selftest a=
nd
> > > > > noticed this:
> > > > >
> > > > > +/*
> > > > > + * Assuming following prolog:
> > > > > + *
> > > > > + * 6984ac:       55                      push   %rbp
> > > > > + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> > > > > + */
> > > > > +noinline void uprobe2_bench_trigger(void)
> > > > > +{
> > > > > +        asm volatile ("");
> > > > > +}
> > > > >
> > > > > This actually will be optimized out to just ret in -O2 mode (make
> > > > > RELEASE=3D1 for selftests):
> > > > >
> > > > > 00000000005a0ce0 <uprobe2_bench_trigger>:
> > > > >   5a0ce0: c3                            retq
> > > > >   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax=
,%rax)
> > > > >   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> > > > >
> > > > > So be careful with that.
> > > >
> > > > right, I did not mean for this to be checked in, just wanted to get=
 the
> > > > numbers quickly
> > > >
> > > > >
> > > > > Also, I just updated our existing set of uprobe benchmarks (see [=
0]),
> > > > > do you mind adding your syscall-based one as another one there an=
d
> > > > > running all of them and sharing the numbers with us? Very curious=
 to
> > > > > see both absolute and relative numbers from that benchmark. (and
> > > > > please do build with RELEASE=3D1)
> > > > >
> > > > > You should be able to just run benchs/run_bench_uprobes.sh (also =
don't
> > > > > forget to add your syscall-based benchmark to the list of benchma=
rks
> > > > > in that shell script).
> > > >
> > > > yes, saw it and was going to run/compare it.. it's good idea to add
> > > > the syscall one and get all numbers together, will do that
> > > >
> > > > >
> > > > > Thank you!
> > > > >
> > > > >
> > > > > BTW, while I think patching multiple instructions for syscall-bas=
ed
> > > > > uprobe is going to be extremely tricky, I think at least u*ret*pr=
obe's
> > > > > int3 can be pretty easily optimized away with syscall, given that=
 the
> > > > > kernel controls code generation there. If anything, it will get t=
he
> > > > > uretprobe case a bit closer to the performance of uprobe. Give it=
 some
> > > > > thought.
> > > >
> > > > hm, right.. the trampoline is there already, but at the moment is g=
lobal
> > > > and used by all uretprobes.. and int3 code moves userspace (changes=
 rip)
> > > > to the original return address.. maybe we can do that through sysca=
ll
> > > > as well
> > >
> > > it seems like good idea, I tried change below (use syscall on return
> > > trampoline) and got some speedup:
> > >
> > > current:
> > >   base           :   15.817 =C2=B1 0.009M/s
> > >   uprobe-nop     :    2.901 =C2=B1 0.000M/s
> > >   uprobe-push    :    2.743 =C2=B1 0.002M/s
> > >   uprobe-ret     :    1.089 =C2=B1 0.001M/s
> > >   uretprobe-nop  :    1.448 =C2=B1 0.001M/s
> > >   uretprobe-push :    1.407 =C2=B1 0.001M/s
> > >   uretprobe-ret  :    0.792 =C2=B1 0.001M/s
> > >
> > > with syscall:
> > >   base           :   15.831 =C2=B1 0.026M/s
> > >   uprobe-nop     :    2.904 =C2=B1 0.001M/s
> > >   uprobe-push    :    2.764 =C2=B1 0.002M/s
> > >   uprobe-ret     :    1.082 =C2=B1 0.001M/s
> > >   uretprobe-nop  :    1.785 =C2=B1 0.000M/s
> > >   uretprobe-push :    1.733 =C2=B1 0.001M/s
> > >   uretprobe-ret  :    0.885 =C2=B1 0.004M/s
> > >
> > > ~23% for nop/push (emulated) cases, ~11% for ret (sstep) case
> > >
> > > jirka
> >
> > heh, I tried this as well over weekend, though I cut few more corners
> > (see diff below, I didn't add saving/restoring rax, though that would
> > be required, of course). My test machine is (way) slower, though, so I
> > got a slightly different numbers (up to 15%):
>
> nice :-) btw I just checked on another slower amd server and it's ~10% in
> all 3 cases, my previous results are from intel machine.. I guess the hw
> trap behaviour/speed makes this not proportional across archs
>
> >
> > ### baseline
> > uprobe-base    :   79.462 =C2=B1 0.058M/s
> > base           :    2.920 =C2=B1 0.004M/s
> > uprobe-nop     :    1.093 =C2=B1 0.001M/s
> > uprobe-push    :    1.066 =C2=B1 0.001M/s
> > uprobe-ret     :    0.480 =C2=B1 0.001M/s
> > uretprobe-nop  :    0.555 =C2=B1 0.000M/s
> > uretprobe-push :    0.549 =C2=B1 0.000M/s
> > uretprobe-ret  :    0.338 =C2=B1 0.000M/s
> >
> >
> > ### uretprobe syscall (vs baseline)
> > uprobe-base    :   79.488 =C2=B1 0.033M/s
> > base           :    2.917 =C2=B1 0.003M/s
> > uprobe-nop     :    1.095 =C2=B1 0.001M/s
> > uprobe-push    :    1.058 =C2=B1 0.000M/s
> > uprobe-ret     :    0.483 =C2=B1 0.000M/s
> > uretprobe-nop  :    0.638 =C2=B1 0.000M/s (+15%)
> > uretprobe-push :    0.627 =C2=B1 0.000M/s (+14.2%)
> > uretprobe-ret  :    0.366 =C2=B1 0.000M/s (+8.3%)
> >
> > Either way, yes, we should implement this. Are you planning to send an
> > official patch some time soon? I'm working on other small improvements
> > in uprobe/uretprobe, I'll probably send the first patches
> > today/tomorrow, but they shouldn't interfere with this uretprobe code
> > path.
>
> yes, wanted to finish/post it this week
>

great, looking forward, we can use these speeds up for uretprobe in
our production

> SNIP
>
> > > ---
> > > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/=
syscalls/syscall_64.tbl
> > > index 7e8d46f4147f..fa5f8a058bc2 100644
> > > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > > @@ -383,6 +383,7 @@
> > >  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
> > >  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
> > >  461    common  lsm_list_modules        sys_lsm_list_modules
> > > +462    64      uprobe                  sys_uprobe
> > >
> >
> > we should call it "uretprobe", "uprobe" will be a separate thing with
> > different logic.
> >
> > I went with generic "trace", but realized that it would be better to
> > have separate more targeted "special/internal" syscalls (where, if
> > necessary, extra arguments would be passed through stack to avoid
> > storing/restoring user-space registers). We have rg_sigreturn
> > precedent which explicitly states that userspace shouldn't use it and
> > shouldn't rely on any specific arguments conventions.
>
> somehow I thought of syscalls as of scare resource and wanted to add
> arguments/commands to the uprobe syscalls.. but having uretprobe
> dedicated syscall makes things easier

given we are at 462 already, not sure I believe it's scarce :) but
it's also a performance aspect, not using any arguments means we can
avoid saving/restoring user-space registers, so it makes sense to have
2-3 dedicated uprobe/uretprobe syscalls vs 1 more generic on (IMO), at
least from performance POV.

>
> >
> > [...]
> >
> > >  /*
> > >   * Deprecated system calls which are still defined in
> > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > index f46e0ca0169c..9ef244c8ff19 100644
> > > --- a/include/linux/uprobes.h
> > > +++ b/include/linux/uprobes.h
> > > @@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return=
_instance *ret, enum rp_check c
> > >  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_re=
gs *regs);
> > >  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long v=
addr,
> > >                                          void *src, unsigned long len=
);
> > > +extern void uprobe_handle_trampoline(struct pt_regs *regs);
> > > +uprobe_opcode_t* arch_uprobe_trampoline(unsigned long *psize);
> >
> > just `void *` here? it can be a sequence of instructions now
>
> hm, it's pointer to u8, which should be fine no? is there benefit to
> have void* in here instead?
>

Quick grepping initially brought up `typedef u32 uprobe_opcode_t;`,
but that's for non-x86 architectures. I don't think it matters all
that much (in my mind it's just a generated code blob, so just `void
*` memory, we don't have to look at its contents).


> thanks,
> jirka
