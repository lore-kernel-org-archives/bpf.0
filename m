Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E73C6A6
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192373; cv=none; b=SvOj81kkqo0KgObBnecPO05hmfuNZhZEAdqY8JFhIEFzwLXhNTLG4KJsRyIEBKPZVOee4entPEEWT1xIw3JV0qn7DWf4hQFn+ZVmrttyDcj/J4s0NtCdxXqco1Sbpxhv/6sLtdG9uT3VlEnC48C/uTBDnltBiF96uZxBSvTTQaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192373; c=relaxed/simple;
	bh=V64YYGSKB3Ob5S8CfMduDttLrTEl4pQnhE1y/XH4Btc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEf2V4KHyDUrVMFQKuDzvzLJN3YW0daNLkwdAdvARFvUYsWN2pjR0CH7qDY+714BH4STC8og0MZlGM6hz8cQBuIojIsnJ3F9XlTxalq5hBIavioYzUhvLpetIDM5R30TCQUA5cKgRR3D1cojQybY5scixuTyd1iHISKPUG6apcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkFAPa4K; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkFAPa4K"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a450615d1c4so834789666b.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710192370; x=1710797170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rITG58cgrsrQttyoA5hJk+YDXivw6WgkPz6/GQrbA4=;
        b=OkFAPa4KrAgDvO1I5kni2kR6f2k2gKXMC+f2tddgu2tEslj0UdWyzN9JRw6xR58drt
         SwRBuj+eKNQvt7orzP1mpu7dEY6gHWwJ8rGkzIQFw8hcD1AVQrpBw2wHbbeQDEaMvmBt
         LlzJnIW4vKW3Wh/6ELpMVd+y9hWMwMRaPVcqGxUAI9yzSQrie+RjCBT3yaZht06/MCbU
         6TB+3xKdMqIiuzrtozBeQ6Nsjvt+FMvv0cRxYH6wY7KqXCBXLKe5FciKjbmB009gPOgI
         cvhuKXN7YdkeG4VQ+34UpvzDXL2EZ9uyfh3P0TL2bGIkZ8KCk6nNeA9FlDN1qOoPndzK
         L85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192370; x=1710797170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rITG58cgrsrQttyoA5hJk+YDXivw6WgkPz6/GQrbA4=;
        b=kfJR3SF0IP5uamL81JvTjrEhaCpDXiU8gSCvISFNrmdgbzEHfO7oHtXWGvHBDu0liW
         3ZVZkDZP+b6fcSw31RjpPaySkY4agmIxTi2FtJuCjX52fXcs2ub3q8D85b9F/RDTw1fs
         bTWW229YO0a9EUoJfFffXIGKoQ2zHHnaSDnajMVXel+0YIKTfbLlwEBYNBGg0GKK1yWb
         JJOktIS6ZrUiaCfj9M1pF6JvWVcna37IZkn3PqVH96mmozlOb5xkcZ1o+VHbTSvjlO3J
         b7W4AFmtLWkEionUoHBmQ7x0zDiaDLue2MVhQxboeb30YQO/WfH6xsf2ZY7X3qbBnw/I
         y6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWESaDfgbpjZtJXotrtQrXUQ8UcGqEj+/93h6UqDp4uATm53RQPiU9KnLJwpdjmfrqftMl/6uqcJ6C4hazsMkob6c4y
X-Gm-Message-State: AOJu0Yx6gAgejw+Ueq65dlmHAAgGCHlILI2QHenBTDLXLgPt2ZMiKR2U
	M1rxiDglNUKKdqJZGTcZtzDdsHPasRT7RfSYu+iGdrbPqpJWQrQ9
X-Google-Smtp-Source: AGHT+IHRwlC6PlhXdoZPGXmptGoLTR97EFT2v/B0ogw+EB+XaUqwut3UmjhmlWfsRo+4cje7jMRw4A==
X-Received: by 2002:a17:907:d50a:b0:a43:ffe1:7d1 with SMTP id wb10-20020a170907d50a00b00a43ffe107d1mr7587824ejc.17.1710192369820;
        Mon, 11 Mar 2024 14:26:09 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id l8-20020a170906230800b00a4131367204sm3191569eja.80.2024.03.11.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:26:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 22:26:08 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	yunwei356@gmail.com, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <Ze928Ht_GvV6_GzU@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
 <Ze7kGP5aAYGseRuM@krava>
 <CAEf4BzZwg-h5QejGRHwZ4h_up2VJZ=cCoU-a_8Jr6JCqso620Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZwg-h5QejGRHwZ4h_up2VJZ=cCoU-a_8Jr6JCqso620Q@mail.gmail.com>

On Mon, Mar 11, 2024 at 10:32:23AM -0700, Andrii Nakryiko wrote:
> On Mon, Mar 11, 2024 at 3:59 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Mar 05, 2024 at 09:24:08AM +0100, Jiri Olsa wrote:
> > > On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> > > > On Sun, Mar 3, 2024 at 2:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > > > > > On Fri, Mar 1, 2024 at 9:01 AM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > > > > > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > One of uprobe pain points is having slow execution that involves
> > > > > > > > > > two traps in worst case scenario or single trap if the original
> > > > > > > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > > > > > > trap on top of that.
> > > > > > > > > >
> > > > > > > > > > My current idea on how to make this faster is to follow the optimized
> > > > > > > > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > > > > > > > user space trampoline that:
> > > > > > > > > >
> > > > > > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > > > > > >
> > > > > > > > > Did you get a chance to measure relative performance of syscall vs
> > > > > > > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > > > > > > some numbers by the time the conference starts? This should inform the
> > > > > > > > > decision whether it even makes sense to go through all the trouble.
> > > > > > > >
> > > > > > > > right, will do that
> > > > > > >
> > > > > > > I believe Yusheng measured syscall vs uprobe performance
> > > > > > > difference during LPC. iirc it was something like 3x.
> > > > > >
> > > > > > Do you have a link to slides? Was it actual uprobe vs just some fast
> > > > > > syscall (not doing BPF program execution) comparison? Or comparing the
> > > > > > performance of int3 handling vs equivalent syscall handling.
> > > > > >
> > > > > > I suspect it's the former, and so probably not that representative.
> > > > > > I'm curious about the performance of going
> > > > > > userspace->kernel->userspace through int3 vs syscall (all other things
> > > > > > being equal).
> > > > >
> > > > > I have a simple test [1] comparing:
> > > > >   - uprobe with 2 traps
> > > > >   - uprobe with 1 trap
> > > > >   - syscall executing uprobe
> > > > >
> > > > > the syscall takes uprobe address as argument, finds the uprobe and executes
> > > > > its consumers, which should be comparable to what the trampoline will do
> > > > >
> > > > > test does same amount of loops triggering each uprobe type and measures
> > > > > the time it took
> > > > >
> > > > >   # ./test_progs -t uprobe_syscall_bench -v
> > > > >   bpf_testmod.ko is already unloaded.
> > > > >   Loading bpf_testmod.ko...
> > > > >   Successfully loaded bpf_testmod.ko.
> > > > >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> > > > >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> > > > >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> > > > >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> > > > >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> > > > >   test_bench_1: uprobes (1 trap) in  36.439s
> > > > >   test_bench_1: uprobes (2 trap) in  91.960s
> > > > >   test_bench_1: syscalls         in  17.872s
> > > > >   #395/1   uprobe_syscall_bench/bench_1:OK
> > > > >   #395     uprobe_syscall_bench:OK
> > > > >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > > >
> > > > > syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> > > > > and ~5x faster than 2 traps uprobe
> > > > >
> > > >
> > > > Thanks for running benchmarks! I quickly looked at the selftest and
> > > > noticed this:
> > > >
> > > > +/*
> > > > + * Assuming following prolog:
> > > > + *
> > > > + * 6984ac:       55                      push   %rbp
> > > > + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> > > > + */
> > > > +noinline void uprobe2_bench_trigger(void)
> > > > +{
> > > > +        asm volatile ("");
> > > > +}
> > > >
> > > > This actually will be optimized out to just ret in -O2 mode (make
> > > > RELEASE=1 for selftests):
> > > >
> > > > 00000000005a0ce0 <uprobe2_bench_trigger>:
> > > >   5a0ce0: c3                            retq
> > > >   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
> > > >   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> > > >
> > > > So be careful with that.
> > >
> > > right, I did not mean for this to be checked in, just wanted to get the
> > > numbers quickly
> > >
> > > >
> > > > Also, I just updated our existing set of uprobe benchmarks (see [0]),
> > > > do you mind adding your syscall-based one as another one there and
> > > > running all of them and sharing the numbers with us? Very curious to
> > > > see both absolute and relative numbers from that benchmark. (and
> > > > please do build with RELEASE=1)
> > > >
> > > > You should be able to just run benchs/run_bench_uprobes.sh (also don't
> > > > forget to add your syscall-based benchmark to the list of benchmarks
> > > > in that shell script).
> > >
> > > yes, saw it and was going to run/compare it.. it's good idea to add
> > > the syscall one and get all numbers together, will do that
> > >
> > > >
> > > > Thank you!
> > > >
> > > >
> > > > BTW, while I think patching multiple instructions for syscall-based
> > > > uprobe is going to be extremely tricky, I think at least u*ret*probe's
> > > > int3 can be pretty easily optimized away with syscall, given that the
> > > > kernel controls code generation there. If anything, it will get the
> > > > uretprobe case a bit closer to the performance of uprobe. Give it some
> > > > thought.
> > >
> > > hm, right.. the trampoline is there already, but at the moment is global
> > > and used by all uretprobes.. and int3 code moves userspace (changes rip)
> > > to the original return address.. maybe we can do that through syscall
> > > as well
> >
> > it seems like good idea, I tried change below (use syscall on return
> > trampoline) and got some speedup:
> >
> > current:
> >   base           :   15.817 ± 0.009M/s
> >   uprobe-nop     :    2.901 ± 0.000M/s
> >   uprobe-push    :    2.743 ± 0.002M/s
> >   uprobe-ret     :    1.089 ± 0.001M/s
> >   uretprobe-nop  :    1.448 ± 0.001M/s
> >   uretprobe-push :    1.407 ± 0.001M/s
> >   uretprobe-ret  :    0.792 ± 0.001M/s
> >
> > with syscall:
> >   base           :   15.831 ± 0.026M/s
> >   uprobe-nop     :    2.904 ± 0.001M/s
> >   uprobe-push    :    2.764 ± 0.002M/s
> >   uprobe-ret     :    1.082 ± 0.001M/s
> >   uretprobe-nop  :    1.785 ± 0.000M/s
> >   uretprobe-push :    1.733 ± 0.001M/s
> >   uretprobe-ret  :    0.885 ± 0.004M/s
> >
> > ~23% for nop/push (emulated) cases, ~11% for ret (sstep) case
> >
> > jirka
> 
> heh, I tried this as well over weekend, though I cut few more corners
> (see diff below, I didn't add saving/restoring rax, though that would
> be required, of course). My test machine is (way) slower, though, so I
> got a slightly different numbers (up to 15%):

nice :-) btw I just checked on another slower amd server and it's ~10% in
all 3 cases, my previous results are from intel machine.. I guess the hw
trap behaviour/speed makes this not proportional across archs

> 
> ### baseline
> uprobe-base    :   79.462 ± 0.058M/s
> base           :    2.920 ± 0.004M/s
> uprobe-nop     :    1.093 ± 0.001M/s
> uprobe-push    :    1.066 ± 0.001M/s
> uprobe-ret     :    0.480 ± 0.001M/s
> uretprobe-nop  :    0.555 ± 0.000M/s
> uretprobe-push :    0.549 ± 0.000M/s
> uretprobe-ret  :    0.338 ± 0.000M/s
> 
> 
> ### uretprobe syscall (vs baseline)
> uprobe-base    :   79.488 ± 0.033M/s
> base           :    2.917 ± 0.003M/s
> uprobe-nop     :    1.095 ± 0.001M/s
> uprobe-push    :    1.058 ± 0.000M/s
> uprobe-ret     :    0.483 ± 0.000M/s
> uretprobe-nop  :    0.638 ± 0.000M/s (+15%)
> uretprobe-push :    0.627 ± 0.000M/s (+14.2%)
> uretprobe-ret  :    0.366 ± 0.000M/s (+8.3%)
> 
> Either way, yes, we should implement this. Are you planning to send an
> official patch some time soon? I'm working on other small improvements
> in uprobe/uretprobe, I'll probably send the first patches
> today/tomorrow, but they shouldn't interfere with this uretprobe code
> path.

yes, wanted to finish/post it this week

SNIP

> > ---
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 7e8d46f4147f..fa5f8a058bc2 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -383,6 +383,7 @@
> >  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
> >  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
> >  461    common  lsm_list_modules        sys_lsm_list_modules
> > +462    64      uprobe                  sys_uprobe
> >
> 
> we should call it "uretprobe", "uprobe" will be a separate thing with
> different logic.
> 
> I went with generic "trace", but realized that it would be better to
> have separate more targeted "special/internal" syscalls (where, if
> necessary, extra arguments would be passed through stack to avoid
> storing/restoring user-space registers). We have rg_sigreturn
> precedent which explicitly states that userspace shouldn't use it and
> shouldn't rely on any specific arguments conventions.

somehow I thought of syscalls as of scare resource and wanted to add
arguments/commands to the uprobe syscalls.. but having uretprobe
dedicated syscall makes things easier

> 
> [...]
> 
> >  /*
> >   * Deprecated system calls which are still defined in
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index f46e0ca0169c..9ef244c8ff19 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
> >  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
> >  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >                                          void *src, unsigned long len);
> > +extern void uprobe_handle_trampoline(struct pt_regs *regs);
> > +uprobe_opcode_t* arch_uprobe_trampoline(unsigned long *psize);
> 
> just `void *` here? it can be a sequence of instructions now

hm, it's pointer to u8, which should be fine no? is there benefit to
have void* in here instead?

thanks,
jirka
