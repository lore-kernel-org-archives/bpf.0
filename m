Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4028BFB
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600148; cv=none; b=q2UmTsI0NYJe809higT7/hu/GpdKSKIhP5CUhvYnbbl9c1o3+b+VOWLBz9k8srmntuFcT7SxAlKTx4jubIYYufyeXfu3vwxNaSTmmRRa+x7EkYekQSoKdTsDe0nmq0XwozxN/TxVyE9viD+GhHtZvLG102+aENHSetO1Hg9wFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600148; c=relaxed/simple;
	bh=kaJRHz+miQdFJRCW81j9OztIQ7vbDSTwsL2yiqJU9nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiVRazqo8Yt0oW/gcLxywMQPQxz+ZwPisaHvJ7pW9Dd2umQDNLpd3Vhkx3mSmcxRWyFPIZWqIAg453AufOfNuHDdYTufgDj/asIICtGDlBlhmu8wHPRLl6qj1ZCYgmHPNbQajX62M9SzcBcyVfu+Ws/xCwGwK36JgV9pf6GKqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+oKXKNK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+oKXKNK"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4701656a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 16:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709600146; x=1710204946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g011V8PiEAASXZHVO0VZ+fzWEJMv1CB3Z4GHYEGhcBQ=;
        b=K+oKXKNKEHNoSGBUEHPI1KmlhiBmnz56oGAf9T6yHrc3NuNKPLI5Yloe0Rbr8X0YWA
         yySr9GTrzuQXAApVlr8YBQkJwXHwROaJ4R6UqFKmcQePb9HdO6KsD+aoRx0Wtmh2jQ+A
         0l5EGeok8fL+anF7nTeKXCm5zdCGqJMQ+UplIDy0xfS+oR+5WOZso4nk1YUoZlTWHij4
         p7uGZLHgA0sun30wSYQj7ti4iL/1NvTt4BPxB+Q30typ+5YTZc7XDnKSkIEMoHbIdnUy
         qVWoTH8RrEK09yDvzmeB6Pvy+4ADbD41PrSL8uHvk3cAxBpdpcpwAVxk4fZoFUEyyEz0
         9dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709600146; x=1710204946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g011V8PiEAASXZHVO0VZ+fzWEJMv1CB3Z4GHYEGhcBQ=;
        b=mBduCr0tHH3sRDXYiC5ug2PO1AZJEaBXxFEoM/nSOvXM0lvwzx2HpzniFvYMbae3wj
         JnEjiSnajwz5jHKrBCaSH6Ag6qXVpYJnmrcYnHRdICcaDyWbT9CyJ1fJoHOzSXwGqn7b
         OYhFylo6AK4iONodpznBYMgzIHpCs2O+bCrXNy4o1xXsnv0b3u4tkV/9cLua3HycvFOt
         g+/u2Sz9ew4l6QggDxUUxOQd76S+7I3cjClboqYe7ovhjKVGqlU0QyFD63MeG4uNsNbl
         XwQHKMFmKdEuTJQdN57v1koAoNMTUbhTe9tUhBZYVn9UbhxmlUsnvV3xbPyb/Wg75E6a
         FH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVUuuNN2+C1fIRPZJdNxcIpQvag/RNVVd4X3Mzjnrrl9XA1wRNdP/OKBFfto0xQyD6+kNV5jY1qA4D9HF5IAmliCTJ
X-Gm-Message-State: AOJu0YzBECvVDXnl4AThhEz6LvbcTYE30FFpoPrOKr/67uZTCMP/j6f3
	xL6rkl3dtb9cNZJX5K9XRSp0I/I99jH/s27lqlEURpDyzI0h1IZUaFlJj0zxVLfe9qU2rQtf4Qe
	/gvvFjiVRu0DZJQz1H4Ib5s961CCUrCzlQHs=
X-Google-Smtp-Source: AGHT+IGeFprd5EhpmMb7eRHyhLFE6Nytti0bqmMN59enLOhoknmz6w+VXF9alZG7CSPt/LQdSnLwA+BlXfZYXf19ne0=
X-Received: by 2002:a05:6a21:9988:b0:1a1:5059:b221 with SMTP id
 ve8-20020a056a21998800b001a15059b221mr455635pzb.1.1709600146103; Mon, 04 Mar
 2024 16:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeCXHKJ--iYYbmLj@krava> <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava> <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com> <ZeRO9_IiLSy9D7jQ@krava>
In-Reply-To: <ZeRO9_IiLSy9D7jQ@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 4 Mar 2024 16:55:33 -0800
Message-ID: <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, yunwei356@gmail.com, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 2:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > On Fri, Mar 1, 2024 at 9:01=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wrote:
> > > > > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail=
.com> wrote:
> > > > > >
> > > > > > One of uprobe pain points is having slow execution that involve=
s
> > > > > > two traps in worst case scenario or single trap if the original
> > > > > > instruction can be emulated. For return uprobes there's one ext=
ra
> > > > > > trap on top of that.
> > > > > >
> > > > > > My current idea on how to make this faster is to follow the opt=
imized
> > > > > > kprobes and replace the normal uprobe trap instruction with jum=
p to
> > > > > > user space trampoline that:
> > > > > >
> > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > >
> > > > > Did you get a chance to measure relative performance of syscall v=
s
> > > > > int3 interrupt handling? If not, do you think you'll be able to g=
et
> > > > > some numbers by the time the conference starts? This should infor=
m the
> > > > > decision whether it even makes sense to go through all the troubl=
e.
> > > >
> > > > right, will do that
> > >
> > > I believe Yusheng measured syscall vs uprobe performance
> > > difference during LPC. iirc it was something like 3x.
> >
> > Do you have a link to slides? Was it actual uprobe vs just some fast
> > syscall (not doing BPF program execution) comparison? Or comparing the
> > performance of int3 handling vs equivalent syscall handling.
> >
> > I suspect it's the former, and so probably not that representative.
> > I'm curious about the performance of going
> > userspace->kernel->userspace through int3 vs syscall (all other things
> > being equal).
>
> I have a simple test [1] comparing:
>   - uprobe with 2 traps
>   - uprobe with 1 trap
>   - syscall executing uprobe
>
> the syscall takes uprobe address as argument, finds the uprobe and execut=
es
> its consumers, which should be comparable to what the trampoline will do
>
> test does same amount of loops triggering each uprobe type and measures
> the time it took
>
>   # ./test_progs -t uprobe_syscall_bench -v
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
>   test_bench_1:PASS:uprobe_bench__attach 0 nsec
>   test_bench_1:PASS:uprobe1_cnt 0 nsec
>   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
>   test_bench_1:PASS:uprobe2_cnt 0 nsec
>   test_bench_1: uprobes (1 trap) in  36.439s
>   test_bench_1: uprobes (2 trap) in  91.960s
>   test_bench_1: syscalls         in  17.872s
>   #395/1   uprobe_syscall_bench/bench_1:OK
>   #395     uprobe_syscall_bench:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> and ~5x faster than 2 traps uprobe
>

Thanks for running benchmarks! I quickly looked at the selftest and
noticed this:

+/*
+ * Assuming following prolog:
+ *
+ * 6984ac:       55                      push   %rbp
+ * 6984ad:       48 89 e5                mov    %rsp,%rbp
+ */
+noinline void uprobe2_bench_trigger(void)
+{
+        asm volatile ("");
+}

This actually will be optimized out to just ret in -O2 mode (make
RELEASE=3D1 for selftests):

00000000005a0ce0 <uprobe2_bench_trigger>:
  5a0ce0: c3                            retq
  5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
  5a0cec: 0f 1f 40 00                   nopl    (%rax)

So be careful with that.

Also, I just updated our existing set of uprobe benchmarks (see [0]),
do you mind adding your syscall-based one as another one there and
running all of them and sharing the numbers with us? Very curious to
see both absolute and relative numbers from that benchmark. (and
please do build with RELEASE=3D1)

You should be able to just run benchs/run_bench_uprobes.sh (also don't
forget to add your syscall-based benchmark to the list of benchmarks
in that shell script).

Thank you!


BTW, while I think patching multiple instructions for syscall-based
uprobe is going to be extremely tricky, I think at least u*ret*probe's
int3 can be pretty easily optimized away with syscall, given that the
kernel controls code generation there. If anything, it will get the
uretprobe case a bit closer to the performance of uprobe. Give it some
thought.


  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240301214551.1=
686095-1-andrii@kernel.org/

> jirka
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Duprobe_syscall_bench
>
> >
> > > Certainly necessary to have a benchmark.
> > > selftests/bpf/bench has one for uprobe.
> > > Probably should extend with sys_bpf.
> > >
> > > Regarding:
> > > > replace the normal uprobe trap instruction with jump to
> > > user space trampoline
> > >
> > > it should probably be a call to trampoline instead of a jump.
> > > Unless you plan to generate a different trampoline for every location=
 ?
> > >
> > > Also how would you pick a space for a trampoline in the target proces=
s ?
> > > Analyze /proc/pid/maps and look for gaps in executable sections?
> >
> > kernel already does that for uretprobes, it adds a new "[uprobes]"
> > memory mapping, so this part is already implemented
> >
> > >
> > > We can start simple with a USDT that uses nop5 instead of nop1
> > > and explicit single trampoline for all USDT locations
> > > that saves all (callee and caller saved) registers and
> > > then does sys_bpf with a new cmd.
> > >
> > > To replace nop5 with a call to trampoline we can use text_poke_bp
> > > approach: replace 1st byte with int3, replace 2-5 with target addr,
> > > replace 1st byte to make an actual call insn.
> > >
> > > Once patched there will be no simulation of insns or kernel traps.
> > > Just normal user code that calls into trampoline, that calls sys_bpf,
> > > and returns back.
