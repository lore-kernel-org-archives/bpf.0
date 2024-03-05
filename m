Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCF7B3E7
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627059; cv=none; b=DTTQbDinwbkdsizRZPNF7esF+/baUZyZ4CIlOvkIw5n7K3Qy/q5xQ2InJ7NmWJOxdTluRzPHLlO0g87eAvkO12WTrFMMX8WXtSfcT6sElWhDjFzn8aa/G7ue+M4HmJrpTiTSt/+aD3wm9T9Y3cBwkB2e21adZb4GL4K72dCjTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627059; c=relaxed/simple;
	bh=Uh9o34sIm/aJj5QwMne7eOtJ3A7gQBIg8vj4WitGRHQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM5HBYkFbiUydJ5rGepSKynlXA1YtQAdlervXLfalavCbty3aRTxib7vhgzkCjy/vu8/BIikmsobI1Kgb4ZjLlfArPIXMu0VJCZAEM3d15Mdzezo1hzdwHUZ53PSS/zKb9/664ABaX+2LXnpDhM79gHOHYWD36+MXy8iNPFmPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAoBU4aW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAoBU4aW"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so4273978a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627056; x=1710231856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0HW0FAd4wXxARZCkThpH5NoJjK1DnfT6VYy0Msr/dk=;
        b=VAoBU4aW6t+1ylAHkztzIxF7FXvfiD2caxESwzMAfb8Lo4J657cZMm/VI192HVOmjz
         E6lSfolVOpJrC01j/sFVPhbht8waKdURnZCSIv02L6v8SSrqsR3DgHgX1WtTWUsZE48Y
         KINFqye4RX7CeCf72z4SqdraJpsFw7z77qh+rpKxF4d80Jmeh7jfgaHCOm7TFUl3CUgI
         AS+AUxsModqof/CxMWY5M54obq0BMR6j6w5RKQckkGHbobMNcuUb0t6JYge0qzFSG7Ti
         E0TYKdRtWarnNTmXM6Pd7VqBBv8dOBw5z30jw7VIAUfGgDrXNLP2+FbKQxEsYqvYr5Zm
         dn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627056; x=1710231856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0HW0FAd4wXxARZCkThpH5NoJjK1DnfT6VYy0Msr/dk=;
        b=pBuKicPLdQ5hUBWlDoWZ4sHU27onoi7Ow2sUwr+1JJe0UlJGb1+6A7GWb6spOcu8JC
         jYbwc3Ud6XloDzGNmBrbLUMF7bjwxGRcTrjvw6qnudcO8Wy/we3AR25o+3X08j63jK0Z
         Aw3jWMcdGxgpqgCYvbCtga3TyvO8baWD+oj9gw9BAXfxwcGdktT8LgjhQMYrukDXmNCL
         818a7/WF/oTErsBfDcOPwfaOFcqNq0jNr0ySkLL7shWOshlUSLICgbyrF+XTs4/Bmd/i
         W4M2Bz452+pGYRu8uBDCBe9gbbzvF5luV5EPy8fz0wqrFgwLMZmUFHJrjO/TfBNIUgEc
         kWmg==
X-Forwarded-Encrypted: i=1; AJvYcCVtA0vE1ZuTFy12tFoazoKCxj2U+jLKlw5+DVVE+KuWP46Nk5R1CAFjvjiNS+xn5v6hSVjj+7eM2T9/2ZradNqvyxN9
X-Gm-Message-State: AOJu0Yx4a6nFHFeLy9q3yio0PJ1WOJAScoCsqJK3nxSg5HKO+K/MNUHw
	kwecYt5Z8vj5MPNoJmmzeIhAVPCMHLBjZHc3Y3YpjR1AmJIJK8Henp6sZoUi
X-Google-Smtp-Source: AGHT+IH8FF419VrLIXHfMkAF0HxLUWC2ddSEi3dQraDGOg6ObMrLGEivA/vIOmzlPN1PZCvhB3twYQ==
X-Received: by 2002:a17:906:e211:b0:a43:fd9e:2d44 with SMTP id gf17-20020a170906e21100b00a43fd9e2d44mr7967250ejb.42.1709627055735;
        Tue, 05 Mar 2024 00:24:15 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id os26-20020a170906af7a00b00a450b817705sm2893060ejb.154.2024.03.05.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:24:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Mar 2024 09:24:08 +0100
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
Message-ID: <ZebWqIgABbk8dQXT@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>

On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> On Sun, Mar 3, 2024 at 2:20 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Mar 1, 2024 at 9:01 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 1, 2024 at 12:18 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > >
> > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > > > On Thu, Feb 29, 2024 at 6:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > > > >
> > > > > > > One of uprobe pain points is having slow execution that involves
> > > > > > > two traps in worst case scenario or single trap if the original
> > > > > > > instruction can be emulated. For return uprobes there's one extra
> > > > > > > trap on top of that.
> > > > > > >
> > > > > > > My current idea on how to make this faster is to follow the optimized
> > > > > > > kprobes and replace the normal uprobe trap instruction with jump to
> > > > > > > user space trampoline that:
> > > > > > >
> > > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > > >
> > > > > > Did you get a chance to measure relative performance of syscall vs
> > > > > > int3 interrupt handling? If not, do you think you'll be able to get
> > > > > > some numbers by the time the conference starts? This should inform the
> > > > > > decision whether it even makes sense to go through all the trouble.
> > > > >
> > > > > right, will do that
> > > >
> > > > I believe Yusheng measured syscall vs uprobe performance
> > > > difference during LPC. iirc it was something like 3x.
> > >
> > > Do you have a link to slides? Was it actual uprobe vs just some fast
> > > syscall (not doing BPF program execution) comparison? Or comparing the
> > > performance of int3 handling vs equivalent syscall handling.
> > >
> > > I suspect it's the former, and so probably not that representative.
> > > I'm curious about the performance of going
> > > userspace->kernel->userspace through int3 vs syscall (all other things
> > > being equal).
> >
> > I have a simple test [1] comparing:
> >   - uprobe with 2 traps
> >   - uprobe with 1 trap
> >   - syscall executing uprobe
> >
> > the syscall takes uprobe address as argument, finds the uprobe and executes
> > its consumers, which should be comparable to what the trampoline will do
> >
> > test does same amount of loops triggering each uprobe type and measures
> > the time it took
> >
> >   # ./test_progs -t uprobe_syscall_bench -v
> >   bpf_testmod.ko is already unloaded.
> >   Loading bpf_testmod.ko...
> >   Successfully loaded bpf_testmod.ko.
> >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> >   test_bench_1: uprobes (1 trap) in  36.439s
> >   test_bench_1: uprobes (2 trap) in  91.960s
> >   test_bench_1: syscalls         in  17.872s
> >   #395/1   uprobe_syscall_bench/bench_1:OK
> >   #395     uprobe_syscall_bench:OK
> >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> >
> > syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> > and ~5x faster than 2 traps uprobe
> >
> 
> Thanks for running benchmarks! I quickly looked at the selftest and
> noticed this:
> 
> +/*
> + * Assuming following prolog:
> + *
> + * 6984ac:       55                      push   %rbp
> + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> + */
> +noinline void uprobe2_bench_trigger(void)
> +{
> +        asm volatile ("");
> +}
> 
> This actually will be optimized out to just ret in -O2 mode (make
> RELEASE=1 for selftests):
> 
> 00000000005a0ce0 <uprobe2_bench_trigger>:
>   5a0ce0: c3                            retq
>   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
>   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> 
> So be careful with that.

right, I did not mean for this to be checked in, just wanted to get the
numbers quickly

> 
> Also, I just updated our existing set of uprobe benchmarks (see [0]),
> do you mind adding your syscall-based one as another one there and
> running all of them and sharing the numbers with us? Very curious to
> see both absolute and relative numbers from that benchmark. (and
> please do build with RELEASE=1)
> 
> You should be able to just run benchs/run_bench_uprobes.sh (also don't
> forget to add your syscall-based benchmark to the list of benchmarks
> in that shell script).

yes, saw it and was going to run/compare it.. it's good idea to add
the syscall one and get all numbers together, will do that

> 
> Thank you!
> 
> 
> BTW, while I think patching multiple instructions for syscall-based
> uprobe is going to be extremely tricky, I think at least u*ret*probe's
> int3 can be pretty easily optimized away with syscall, given that the
> kernel controls code generation there. If anything, it will get the
> uretprobe case a bit closer to the performance of uprobe. Give it some
> thought.

hm, right.. the trampoline is there already, but at the moment is global
and used by all uretprobes.. and int3 code moves userspace (changes rip)
to the original return address.. maybe we can do that through syscall
as well

or we could add jump back to uretprobe's original return addrress to the
trampoline, but then we need special trampoline for each uretprobe,
I'll check

thanks,
jirka

> 
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240301214551.1686095-1-andrii@kernel.org/
> 
> > jirka
> >
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=uprobe_syscall_bench
> >
> > >
> > > > Certainly necessary to have a benchmark.
> > > > selftests/bpf/bench has one for uprobe.
> > > > Probably should extend with sys_bpf.
> > > >
> > > > Regarding:
> > > > > replace the normal uprobe trap instruction with jump to
> > > > user space trampoline
> > > >
> > > > it should probably be a call to trampoline instead of a jump.
> > > > Unless you plan to generate a different trampoline for every location ?
> > > >
> > > > Also how would you pick a space for a trampoline in the target process ?
> > > > Analyze /proc/pid/maps and look for gaps in executable sections?
> > >
> > > kernel already does that for uretprobes, it adds a new "[uprobes]"
> > > memory mapping, so this part is already implemented
> > >
> > > >
> > > > We can start simple with a USDT that uses nop5 instead of nop1
> > > > and explicit single trampoline for all USDT locations
> > > > that saves all (callee and caller saved) registers and
> > > > then does sys_bpf with a new cmd.
> > > >
> > > > To replace nop5 with a call to trampoline we can use text_poke_bp
> > > > approach: replace 1st byte with int3, replace 2-5 with target addr,
> > > > replace 1st byte to make an actual call insn.
> > > >
> > > > Once patched there will be no simulation of insns or kernel traps.
> > > > Just normal user code that calls into trampoline, that calls sys_bpf,
> > > > and returns back.
