Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF218613F
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652622; cv=none; b=kcOuTFxH8JWrOuuUoIdKLreyYXMG+27i7DpktZHD5ebQv9A8iAWMwatl8L7zfxY5/W2AW5tMEzOYNwxMIYk4o/PK0VAAYCQcusinjdHViAPmnUpCQlDr7Z+FMhZaErhSw+KcYsfdoWq/nAMiawi9hyZf10N2PNtJr4GS4VqxL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652622; c=relaxed/simple;
	bh=g93wclb+ZlwuizDmW0U9+SzYtHyjMaeknCe2Mb2dO6Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF9Awtgh7idO8P82iEv7A4+18oGCmZh0CVBdoqeWDjy+t0xuxcVzIIxMw2Xg1OXdgK8K1/BR3vdO5MwZENv78bnilsnsLco0xV/9SdloHenYr3OJ4SZ33bIHbEID2xtS/My4hqfxbyLtlY8j3/JYaJZ0yLaJXipweWac9rzGp3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf67wW5Q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf67wW5Q"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso442629966b.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709652619; x=1710257419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b7U/KDCqNO0FYvbMNvwiEMaDUSp4db64cJK3cNb4c2I=;
        b=Yf67wW5QrNN9T5NC+CbbyWOpsJfbck9On8sAU4fFvNLwnsQPO51vpNPCTFHMNaLqeA
         4UQ6YiDq3hhoF3yQM2TDMJdVuA4AGZehat5BqZTHvwNU2GVUjF45/bdVChs6XMtGhNSz
         DBiUeSdTDGcIroBV1/47eILjnlRTS5mWc6xI0ruR0HTBeREjO2P8F/GOIyVWuPdqrL/X
         Kn+1b1W8Rr5jP2cBk4bk0si0wEi3954vxbGJOB6cREH02TUC3SlJ1h8HtBslijatXeJC
         Y3WGPqNul0XTNN25h0+aM4V/0HqvA7on6y8tHiCbojQmJK8gHCQFKHgaQ7xkb2yxMmQu
         5f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652619; x=1710257419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7U/KDCqNO0FYvbMNvwiEMaDUSp4db64cJK3cNb4c2I=;
        b=xTAURngz+aQb5Inisqxgc2cAavaDzTmAiA3qSARM4vbB/zezV6Ma/gprUj3GqCUUyj
         4xEqGbNNikS0HNTTEbhue5oETP/be0JHhXh/jQYCnRi2OpqL6y83fmEC8YAAbFMnGidA
         ByA/u8JYFEPSQd1Ff3nsupNNAO4kzsYJno/xaEkqmRq1ZKFemBjYM6094TR+AsU1WNNh
         FIy74LgJlcUU+byp9eGKX+LXJBHuT17Ql6Lttty6RY0p8SHKEYDzhDXY46hGHpyGawlw
         hUjbXMSWVmhfgI5ux+4RUat3UiB78wNZF5U2TUYOCwakDwiobpb9LU2sL3XK2TyIYIe5
         B+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWNUeRf8Hh7Cf20flp5ZqUt70Erb6rFGy/nvTKoSca/2WLjQk/9oXvzypqYk4J3LLMnmxXF4AO4wkmb/4BmjuugdyEg
X-Gm-Message-State: AOJu0YxGcEL1JNApZzCVBaw5hcAcU+/qD3rm9zATlBIGdGG7L73R2cxi
	M3bLoPCrMwKPGsfVzwk4hAel7srbTni6OWOWA/ki/l1n/98W65/a6zdVGvfI
X-Google-Smtp-Source: AGHT+IFC2Ovo+lE/JiG2FMQqkJAvm3KMIKZfr2XKdAe5vK+dJ6oiBxSxMxi7rni7OEOAcwVVjSprPQ==
X-Received: by 2002:a17:906:a844:b0:a45:755c:93d9 with SMTP id dx4-20020a170906a84400b00a45755c93d9mr3577943ejb.47.1709652618505;
        Tue, 05 Mar 2024 07:30:18 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090660c800b00a45a09e7e23sm993753ejk.136.2024.03.05.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:30:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Mar 2024 16:30:10 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	yunwei356@gmail.com, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <Zec6guiGtXHgUpbx@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZebWqIgABbk8dQXT@krava>

On Tue, Mar 05, 2024 at 09:24:08AM +0100, Jiri Olsa wrote:
> On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> > On Sun, Mar 3, 2024 at 2:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > > > On Fri, Mar 1, 2024 at 9:01 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > > > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > > >
> > > > > > > > One of uprobe pain points is having slow execution that involves
> > > > > > > > two traps in worst case scenario or single trap if the original
> > > > > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > > > > trap on top of that.
> > > > > > > >
> > > > > > > > My current idea on how to make this faster is to follow the optimized
> > > > > > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > > > > > user space trampoline that:
> > > > > > > >
> > > > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > > > >
> > > > > > > Did you get a chance to measure relative performance of syscall vs
> > > > > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > > > > some numbers by the time the conference starts? This should inform the
> > > > > > > decision whether it even makes sense to go through all the trouble.
> > > > > >
> > > > > > right, will do that
> > > > >
> > > > > I believe Yusheng measured syscall vs uprobe performance
> > > > > difference during LPC. iirc it was something like 3x.
> > > >
> > > > Do you have a link to slides? Was it actual uprobe vs just some fast
> > > > syscall (not doing BPF program execution) comparison? Or comparing the
> > > > performance of int3 handling vs equivalent syscall handling.
> > > >
> > > > I suspect it's the former, and so probably not that representative.
> > > > I'm curious about the performance of going
> > > > userspace->kernel->userspace through int3 vs syscall (all other things
> > > > being equal).
> > >
> > > I have a simple test [1] comparing:
> > >   - uprobe with 2 traps
> > >   - uprobe with 1 trap
> > >   - syscall executing uprobe
> > >
> > > the syscall takes uprobe address as argument, finds the uprobe and executes
> > > its consumers, which should be comparable to what the trampoline will do
> > >
> > > test does same amount of loops triggering each uprobe type and measures
> > > the time it took
> > >
> > >   # ./test_progs -t uprobe_syscall_bench -v
> > >   bpf_testmod.ko is already unloaded.
> > >   Loading bpf_testmod.ko...
> > >   Successfully loaded bpf_testmod.ko.
> > >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> > >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> > >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> > >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> > >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> > >   test_bench_1: uprobes (1 trap) in  36.439s
> > >   test_bench_1: uprobes (2 trap) in  91.960s
> > >   test_bench_1: syscalls         in  17.872s
> > >   #395/1   uprobe_syscall_bench/bench_1:OK
> > >   #395     uprobe_syscall_bench:OK
> > >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> > > and ~5x faster than 2 traps uprobe
> > >
> > 
> > Thanks for running benchmarks! I quickly looked at the selftest and
> > noticed this:
> > 
> > +/*
> > + * Assuming following prolog:
> > + *
> > + * 6984ac:       55                      push   %rbp
> > + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> > + */
> > +noinline void uprobe2_bench_trigger(void)
> > +{
> > +        asm volatile ("");
> > +}
> > 
> > This actually will be optimized out to just ret in -O2 mode (make
> > RELEASE=1 for selftests):
> > 
> > 00000000005a0ce0 <uprobe2_bench_trigger>:
> >   5a0ce0: c3                            retq
> >   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
> >   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> > 
> > So be careful with that.
> 
> right, I did not mean for this to be checked in, just wanted to get the
> numbers quickly
> 
> > 
> > Also, I just updated our existing set of uprobe benchmarks (see [0]),
> > do you mind adding your syscall-based one as another one there and
> > running all of them and sharing the numbers with us? Very curious to
> > see both absolute and relative numbers from that benchmark. (and
> > please do build with RELEASE=1)
> > 
> > You should be able to just run benchs/run_bench_uprobes.sh (also don't
> > forget to add your syscall-based benchmark to the list of benchmarks
> > in that shell script).
> 
> yes, saw it and was going to run/compare it.. it's good idea to add
> the syscall one and get all numbers together, will do that

seems to be consistent with my previous test:

base           :   15.854 ± 0.007M/s
uprobe-nop     :    2.859 ± 0.007M/s
uprobe-push    :    2.697 ± 0.002M/s
uprobe-ret     :    1.081 ± 0.000M/s
uprobe-syscall :    5.520 ± 0.006M/s
uretprobe-nop  :    1.422 ± 0.002M/s
uretprobe-push :    1.396 ± 0.002M/s
uretprobe-ret  :    0.787 ± 0.000M/s
uretprobe-syscall:    1.888 ± 0.002M/s

syscall uprobe is ~2x faster than 1 trap uprobe and ~5x faster than 2 traps uprobe

uretprobe is bit more tricky to compare, the speed up is there for the initial
uprobe hit, then there's again the trap from the uretprobe trampoline

I have the bench changes in here [1], I'll send it out together with rfc post

jirka


[1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=uprobe_syscall_bench_1

> 
> > 
> > Thank you!
> > 
> > 
> > BTW, while I think patching multiple instructions for syscall-based
> > uprobe is going to be extremely tricky, I think at least u*ret*probe's
> > int3 can be pretty easily optimized away with syscall, given that the
> > kernel controls code generation there. If anything, it will get the
> > uretprobe case a bit closer to the performance of uprobe. Give it some
> > thought.
> 
> hm, right.. the trampoline is there already, but at the moment is global
> and used by all uretprobes.. and int3 code moves userspace (changes rip)
> to the original return address.. maybe we can do that through syscall
> as well
> 
> or we could add jump back to uretprobe's original return addrress to the
> trampoline, but then we need special trampoline for each uretprobe,
> I'll check
> 
> thanks,
> jirka
> 
> > 
> > 
> >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240301214551.1686095-1-andrii@kernel.org/
> > 
> > > jirka
> > >
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=uprobe_syscall_bench
> > >
> > > >
> > > > > Certainly necessary to have a benchmark.
> > > > > selftests/bpf/bench has one for uprobe.
> > > > > Probably should extend with sys_bpf.
> > > > >
> > > > > Regarding:
> > > > > > replace the normal uprobe trap instruction with jump to
> > > > > user space trampoline
> > > > >
> > > > > it should probably be a call to trampoline instead of a jump.
> > > > > Unless you plan to generate a different trampoline for every location ?
> > > > >
> > > > > Also how would you pick a space for a trampoline in the target process ?
> > > > > Analyze /proc/pid/maps and look for gaps in executable sections?
> > > >
> > > > kernel already does that for uretprobes, it adds a new "[uprobes]"
> > > > memory mapping, so this part is already implemented
> > > >
> > > > >
> > > > > We can start simple with a USDT that uses nop5 instead of nop1
> > > > > and explicit single trampoline for all USDT locations
> > > > > that saves all (callee and caller saved) registers and
> > > > > then does sys_bpf with a new cmd.
> > > > >
> > > > > To replace nop5 with a call to trampoline we can use text_poke_bp
> > > > > approach: replace 1st byte with int3, replace 2-5 with target addr,
> > > > > replace 1st byte to make an actual call insn.
> > > > >
> > > > > Once patched there will be no simulation of insns or kernel traps.
> > > > > Just normal user code that calls into trampoline, that calls sys_bpf,
> > > > > and returns back.
