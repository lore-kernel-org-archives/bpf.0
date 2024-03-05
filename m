Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0C16415
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659831; cv=none; b=AHm6TkFYBMxMVXvg+lXBwKxzaVRgfjYQMfa3HDLYIi5Bz+8JWNlPT6YQmAvPFaoxQmVW0Sctjc8yE0xprpRRo3cq1/KhGNE1nldWJ7h8MpLSfFBXV7WT2sg8jXAv9GPQgjlxWqw5NI2FoM3T8NZkUVn8UB140mA+mtVyyjWNVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659831; c=relaxed/simple;
	bh=W3XlTx89ClJ3U/0wxxBHo2wbHEQWnjS7V8KQPW1ONlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/ULOpaTAmaMi3KxjviLdXi6FpFZeMz9V+cnTnudDRublZr5aQJKCuY6y3c68CUGwIfSAZuGgeXgo0ChIJfNdhQPQJbtfppkqHDcJbN2u5sEaTSWMcW7OqPdRAfyBiFA6J3bhkLwX/kZG6gqUEJXeQEB5uWeoAu7b5Bu3DLyVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw2uvZDn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw2uvZDn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5c81ccfb9so3094263b3a.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659829; x=1710264629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+uzJQ5KakYYL8HuBQeHeAfCJ7o0RrAdADogwcMgejw=;
        b=lw2uvZDnAcSLkedJkmI0sSLuS1tFRJG2N8cRwoNuG+Oq/Wme/1ixIizOpfTyFZz9i7
         nPqxK7mBCTbeabaY+mllIGlLYKd5VzGjEPNBh2s8+WLoO3ckkaaeIFBd45wdNGRCLMMt
         rMfv26zbJROO4oktfN8eM/JwU4CA+O0ZGzTzdMxCVUpeeQveAQNJdCeWSUVVkvOPWlpN
         LBma0Lv/KxZqi0ouFVu6ehHjXa+btEUGyq6S3k7HhVsHCGP1qlu5sDcwoFphx+Y8u2cn
         MyOn7PYGqnB99kqtk68wTyFxtqCEIQvzbp7js8GUzcFxMB2bXTPBg+JhDQAD1bp18dRq
         PIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659829; x=1710264629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+uzJQ5KakYYL8HuBQeHeAfCJ7o0RrAdADogwcMgejw=;
        b=saM1oOejgWmBiqcA4WSd6JDRAfQWJ2QzDsAOdNLkwE4EtVrkFfSs48BrnfNardnyKK
         ZH8AYWaAMEFjjT2iHzoGhKWoM1v4l/sbnaCF4N1WVQRGVF8c/ZeQttLgFXmjdFRgVG9/
         Q30DE2HVfgCxTHKgSAISNJEnMYyP307YShsyYd+7xC4QdHiIU3UwQD0SWFU3WHTxlS9F
         HHqLJi+s+0tKNndaYuRKCRMliiIzzPGSiapULpRk/bSmd4wFc2IIqgkJFmqpLOCTczGy
         kEJeOX+BvU/mqkljuSqQe7LOYdV7CxIUJ/+Y+DJXR+q9CmHkJzLDG/AbSOEzLMoR3AbW
         mf7g==
X-Forwarded-Encrypted: i=1; AJvYcCUTyAq3bHLmJS54kKm0+WMHAU6qqz7/5KMHzv6vKN3o3C/1ZaLljTQ1WD1ZMBuQaoRfwtRJxdD+QoH1bVSaMRYlTD6S
X-Gm-Message-State: AOJu0YxLrE7MnT3z3Wb2RsUffqoJFFJvHQdZug9kFrxXV0ppmGNaxGVs
	F4w5txFRjdxLWpEghID/ndi38m8Ao2JZnqKjbL8dudkRg9aZhC6uxVClOTFzpiBXdot2Ff98uGn
	OMTUPnUpbx8SxW1zw20xpzQKkcmA=
X-Google-Smtp-Source: AGHT+IGCCLeWsG1Tc3Hsfxh5Hdo1ahPC1EKzQ9RfFy93JkcjyEFmpzO4pab/xmA7xfTlIL+VaW0hOSOQqxnsV1WYlxk=
X-Received: by 2002:aa7:8889:0:b0:6e5:53b4:8c16 with SMTP id
 z9-20020aa78889000000b006e553b48c16mr12600817pfe.21.1709659828728; Tue, 05
 Mar 2024 09:30:28 -0800 (PST)
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
 <ZebWqIgABbk8dQXT@krava> <Zec6guiGtXHgUpbx@krava>
In-Reply-To: <Zec6guiGtXHgUpbx@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 09:30:16 -0800
Message-ID: <CAEf4BzbSuPQHHzoYJBeo5iOyb1Wgi+yt-LfK6vob=FR+dOpfkw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, yunwei356@gmail.com, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:30=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Mar 05, 2024 at 09:24:08AM +0100, Jiri Olsa wrote:
> > On Mon, Mar 04, 2024 at 04:55:33PM -0800, Andrii Nakryiko wrote:
> > > On Sun, Mar 3, 2024 at 2:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > > >
> > > > On Fri, Mar 01, 2024 at 09:26:57AM -0800, Andrii Nakryiko wrote:
> > > > > On Fri, Mar 1, 2024 at 9:01=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 1, 2024 at 12:18=E2=80=AFAM Jiri Olsa <olsajiri@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 29, 2024 at 04:25:17PM -0800, Andrii Nakryiko wro=
te:
> > > > > > > > On Thu, Feb 29, 2024 at 6:39=E2=80=AFAM Jiri Olsa <olsajiri=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > One of uprobe pain points is having slow execution that i=
nvolves
> > > > > > > > > two traps in worst case scenario or single trap if the or=
iginal
> > > > > > > > > instruction can be emulated. For return uprobes there's o=
ne extra
> > > > > > > > > trap on top of that.
> > > > > > > > >
> > > > > > > > > My current idea on how to make this faster is to follow t=
he optimized
> > > > > > > > > kprobes and replace the normal uprobe trap instruction wi=
th jump to
> > > > > > > > > user space trampoline that:
> > > > > > > > >
> > > > > > > > >   - executes syscall to call uprobe consumers callbacks
> > > > > > > >
> > > > > > > > Did you get a chance to measure relative performance of sys=
call vs
> > > > > > > > int3 interrupt handling? If not, do you think you'll be abl=
e to get
> > > > > > > > some numbers by the time the conference starts? This should=
 inform the
> > > > > > > > decision whether it even makes sense to go through all the =
trouble.
> > > > > > >
> > > > > > > right, will do that
> > > > > >
> > > > > > I believe Yusheng measured syscall vs uprobe performance
> > > > > > difference during LPC. iirc it was something like 3x.
> > > > >
> > > > > Do you have a link to slides? Was it actual uprobe vs just some f=
ast
> > > > > syscall (not doing BPF program execution) comparison? Or comparin=
g the
> > > > > performance of int3 handling vs equivalent syscall handling.
> > > > >
> > > > > I suspect it's the former, and so probably not that representativ=
e.
> > > > > I'm curious about the performance of going
> > > > > userspace->kernel->userspace through int3 vs syscall (all other t=
hings
> > > > > being equal).
> > > >
> > > > I have a simple test [1] comparing:
> > > >   - uprobe with 2 traps
> > > >   - uprobe with 1 trap
> > > >   - syscall executing uprobe
> > > >
> > > > the syscall takes uprobe address as argument, finds the uprobe and =
executes
> > > > its consumers, which should be comparable to what the trampoline wi=
ll do
> > > >
> > > > test does same amount of loops triggering each uprobe type and meas=
ures
> > > > the time it took
> > > >
> > > >   # ./test_progs -t uprobe_syscall_bench -v
> > > >   bpf_testmod.ko is already unloaded.
> > > >   Loading bpf_testmod.ko...
> > > >   Successfully loaded bpf_testmod.ko.
> > > >   test_bench_1:PASS:uprobe_bench__open_and_load 0 nsec
> > > >   test_bench_1:PASS:uprobe_bench__attach 0 nsec
> > > >   test_bench_1:PASS:uprobe1_cnt 0 nsec
> > > >   test_bench_1:PASS:syscalls_uprobe1_cnt 0 nsec
> > > >   test_bench_1:PASS:uprobe2_cnt 0 nsec
> > > >   test_bench_1: uprobes (1 trap) in  36.439s
> > > >   test_bench_1: uprobes (2 trap) in  91.960s
> > > >   test_bench_1: syscalls         in  17.872s
> > > >   #395/1   uprobe_syscall_bench/bench_1:OK
> > > >   #395     uprobe_syscall_bench:OK
> > > >   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > > syscall uprobe execution seems to be ~2x faster than 1 trap uprobe
> > > > and ~5x faster than 2 traps uprobe
> > > >
> > >
> > > Thanks for running benchmarks! I quickly looked at the selftest and
> > > noticed this:
> > >
> > > +/*
> > > + * Assuming following prolog:
> > > + *
> > > + * 6984ac:       55                      push   %rbp
> > > + * 6984ad:       48 89 e5                mov    %rsp,%rbp
> > > + */
> > > +noinline void uprobe2_bench_trigger(void)
> > > +{
> > > +        asm volatile ("");
> > > +}
> > >
> > > This actually will be optimized out to just ret in -O2 mode (make
> > > RELEASE=3D1 for selftests):
> > >
> > > 00000000005a0ce0 <uprobe2_bench_trigger>:
> > >   5a0ce0: c3                            retq
> > >   5a0ce1: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%ra=
x)
> > >   5a0cec: 0f 1f 40 00                   nopl    (%rax)
> > >
> > > So be careful with that.
> >
> > right, I did not mean for this to be checked in, just wanted to get the
> > numbers quickly
> >
> > >
> > > Also, I just updated our existing set of uprobe benchmarks (see [0]),
> > > do you mind adding your syscall-based one as another one there and
> > > running all of them and sharing the numbers with us? Very curious to
> > > see both absolute and relative numbers from that benchmark. (and
> > > please do build with RELEASE=3D1)
> > >
> > > You should be able to just run benchs/run_bench_uprobes.sh (also don'=
t
> > > forget to add your syscall-based benchmark to the list of benchmarks
> > > in that shell script).
> >
> > yes, saw it and was going to run/compare it.. it's good idea to add
> > the syscall one and get all numbers together, will do that
>
> seems to be consistent with my previous test:
>
> base           :   15.854 =C2=B1 0.007M/s
> uprobe-nop     :    2.859 =C2=B1 0.007M/s
> uprobe-push    :    2.697 =C2=B1 0.002M/s
> uprobe-ret     :    1.081 =C2=B1 0.000M/s
> uprobe-syscall :    5.520 =C2=B1 0.006M/s
> uretprobe-nop  :    1.422 =C2=B1 0.002M/s
> uretprobe-push :    1.396 =C2=B1 0.002M/s
> uretprobe-ret  :    0.787 =C2=B1 0.000M/s
> uretprobe-syscall:    1.888 =C2=B1 0.002M/s
>
> syscall uprobe is ~2x faster than 1 trap uprobe and ~5x faster than 2 tra=
ps uprobe
>

great, thanks a lot for the numbers! It's good that we have comparable
benchmark numbers now.

> uretprobe is bit more tricky to compare, the speed up is there for the in=
itial
> uprobe hit, then there's again the trap from the uretprobe trampoline

yep, makes sense

>
> I have the bench changes in here [1], I'll send it out together with rfc =
post
>
> jirka
>
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=
=3Duprobe_syscall_bench_1
>
> >
> > >
> > > Thank you!
> > >
> > >
> > > BTW, while I think patching multiple instructions for syscall-based
> > > uprobe is going to be extremely tricky, I think at least u*ret*probe'=
s
> > > int3 can be pretty easily optimized away with syscall, given that the
> > > kernel controls code generation there. If anything, it will get the
> > > uretprobe case a bit closer to the performance of uprobe. Give it som=
e
> > > thought.
> >
> > hm, right.. the trampoline is there already, but at the moment is globa=
l
> > and used by all uretprobes.. and int3 code moves userspace (changes rip=
)
> > to the original return address.. maybe we can do that through syscall
> > as well
> >
> > or we could add jump back to uretprobe's original return addrress to th=
e
> > trampoline, but then we need special trampoline for each uretprobe,
> > I'll check
> >
> > thanks,
> > jirka
> >
> > >
> > >
> > >   [0] https://patchwork.kernel.org/project/netdevbpf/patch/2024030121=
4551.1686095-1-andrii@kernel.org/
> > >
> > > > jirka
> > > >
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/=
log/?h=3Duprobe_syscall_bench
> > > >
> > > > >
> > > > > > Certainly necessary to have a benchmark.
> > > > > > selftests/bpf/bench has one for uprobe.
> > > > > > Probably should extend with sys_bpf.
> > > > > >
> > > > > > Regarding:
> > > > > > > replace the normal uprobe trap instruction with jump to
> > > > > > user space trampoline
> > > > > >
> > > > > > it should probably be a call to trampoline instead of a jump.
> > > > > > Unless you plan to generate a different trampoline for every lo=
cation ?
> > > > > >
> > > > > > Also how would you pick a space for a trampoline in the target =
process ?
> > > > > > Analyze /proc/pid/maps and look for gaps in executable sections=
?
> > > > >
> > > > > kernel already does that for uretprobes, it adds a new "[uprobes]=
"
> > > > > memory mapping, so this part is already implemented
> > > > >
> > > > > >
> > > > > > We can start simple with a USDT that uses nop5 instead of nop1
> > > > > > and explicit single trampoline for all USDT locations
> > > > > > that saves all (callee and caller saved) registers and
> > > > > > then does sys_bpf with a new cmd.
> > > > > >
> > > > > > To replace nop5 with a call to trampoline we can use text_poke_=
bp
> > > > > > approach: replace 1st byte with int3, replace 2-5 with target a=
ddr,
> > > > > > replace 1st byte to make an actual call insn.
> > > > > >
> > > > > > Once patched there will be no simulation of insns or kernel tra=
ps.
> > > > > > Just normal user code that calls into trampoline, that calls sy=
s_bpf,
> > > > > > and returns back.
