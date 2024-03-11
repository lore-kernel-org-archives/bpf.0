Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018794C631
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178358; cv=none; b=YMzMAbKyHdE7W/G7v3VTWVHdoif64H53nBC5KVFn5ekEvnYrT5a2FkETjsfoIM+X1ktOTlPmEgtXm7S7K7LeGqqM7ET9G64Kl2S6fLWFOyQNBVV8/8oOP9rmXoG6lnXbegm7UEU13gdihmizY9qIAcx+HlE/ny8/DryvvRAH088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178358; c=relaxed/simple;
	bh=VYYqu0LAHB1d22jRFK+/UZjNcackE+ohex9Efx7kVqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eygBEmReRfN+7wZapyw8dH/tU4scbIgwwDhjsZz/MdQR0q+AGLdCctN9y0Kqja6C77z63552D2yGLBFOWkz3dYz+2RYFl1R7XQZG39v8WEwG3wMdeP45t+WDsn/RY7Rq8pU3nXfW7a9fpjyRGmBllbBj9KPYyqSoWNJYBiJTXbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrL8LKRP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrL8LKRP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29be5386b74so1110122a91.3
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710178356; x=1710783156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6AoiSKvQGcEob7dfL4oufpOeY8cUzQeZAEEXqAug0M=;
        b=RrL8LKRPju2+Nac903JLQnWhNUaNnf7rhYIEH1x9dT9BqJ9OKy+l5wyX0r3e+udnpJ
         WaNjfV/AYK3Ts8xFhRBljUTAmQ1bn+c4px6v+sFmHeSfN9RjejgEyOwGYLDcp1gp9h3j
         ST5nYIdgYJQaCNXJqrVPPp6PGPxdD5U1LHCc+AnAslau5jvA/6jxX/jhzO7DPYAoMTOl
         YVBnG2APYI+Wdi3ycSmA9OueDfi6zXn4gddp1roKyhbVwmVkJ+ojaBjFMkzKfUfcvq4x
         kWYxao3XUkoEBOVDhbQnYe9WKDZwSLGu1DyRCnflDyMVpxIHG+21tAH3O8PPxrK0uSLr
         z/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178356; x=1710783156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6AoiSKvQGcEob7dfL4oufpOeY8cUzQeZAEEXqAug0M=;
        b=QERtsihTqmoZQHh+LyznT1uJLLS75NH7KdJYP8pO+yuAaEnRBHr+Z7trNQsUZ3WLAt
         nTgzEo9UxgTenpxAYWzb50a8A7dxV7/m9WrjgVoqE5+oHURekG0p0w/7C4248LKx2O0R
         P/CQLSq5oVIa1v6X6e/NaopREr6ARXGoMWk84FsAsufPA/8XzwAeI3KyMzdFshXwC1mh
         AHtEkNmAbQoR/zLPSUZt2tcE/wzg3mwjcwR0q6lY4xsX999JdLN5tgAM1OUFthGmcTVg
         K7JG/52PlhygSKLVJno5C1e3LS/C+hXcpEYsL4l6FU2+w0o9lnI7gCSua3EoStexTF3J
         TsGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVCpE9Dk9LXhBisIk36tE4Qx2ZyU+9D9nTCHSVxPU8F3hEilVOPcKKg72p0m5Xdrut0fZEiM6OOCUax6BT/QqX3jDb
X-Gm-Message-State: AOJu0YygDzZjji2XOsOdEkNDtBGtbGkHjZGccLZmnra4kRpTtsWjl0EG
	1zLW9N56mBOn86TQ2I/1J8eSPQ41hJqntUiDgfI1NOlbxdvINtDtw/bXngd71KEupghrPJQpsMs
	eh9T/QGZTrtRo2GvpFcCfnWbzGsk=
X-Google-Smtp-Source: AGHT+IEAaOEDx/93KDmL9DgJ7qHSeLRuZtUqbrNiWWsgqoogSRQ63DGZWuKfps0E40zJPNT7zvKo0gixuO+NsJ9lBYA=
X-Received: by 2002:a17:90a:fc48:b0:29b:ed0a:8cfd with SMTP id
 ee8-20020a17090afc4800b0029bed0a8cfdmr2945947pjb.4.1710178356212; Mon, 11 Mar
 2024 10:32:36 -0700 (PDT)
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
 <ZebWqIgABbk8dQXT@krava> <Ze7kGP5aAYGseRuM@krava>
In-Reply-To: <Ze7kGP5aAYGseRuM@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 10:32:23 -0700
Message-ID: <CAEf4BzZwg-h5QejGRHwZ4h_up2VJZ=cCoU-a_8Jr6JCqso620Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, yunwei356@gmail.com, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Oleg Nesterov <oleg@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:59=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
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
>
> it seems like good idea, I tried change below (use syscall on return
> trampoline) and got some speedup:
>
> current:
>   base           :   15.817 =C2=B1 0.009M/s
>   uprobe-nop     :    2.901 =C2=B1 0.000M/s
>   uprobe-push    :    2.743 =C2=B1 0.002M/s
>   uprobe-ret     :    1.089 =C2=B1 0.001M/s
>   uretprobe-nop  :    1.448 =C2=B1 0.001M/s
>   uretprobe-push :    1.407 =C2=B1 0.001M/s
>   uretprobe-ret  :    0.792 =C2=B1 0.001M/s
>
> with syscall:
>   base           :   15.831 =C2=B1 0.026M/s
>   uprobe-nop     :    2.904 =C2=B1 0.001M/s
>   uprobe-push    :    2.764 =C2=B1 0.002M/s
>   uprobe-ret     :    1.082 =C2=B1 0.001M/s
>   uretprobe-nop  :    1.785 =C2=B1 0.000M/s
>   uretprobe-push :    1.733 =C2=B1 0.001M/s
>   uretprobe-ret  :    0.885 =C2=B1 0.004M/s
>
> ~23% for nop/push (emulated) cases, ~11% for ret (sstep) case
>
> jirka

heh, I tried this as well over weekend, though I cut few more corners
(see diff below, I didn't add saving/restoring rax, though that would
be required, of course). My test machine is (way) slower, though, so I
got a slightly different numbers (up to 15%):

### baseline
uprobe-base    :   79.462 =C2=B1 0.058M/s
base           :    2.920 =C2=B1 0.004M/s
uprobe-nop     :    1.093 =C2=B1 0.001M/s
uprobe-push    :    1.066 =C2=B1 0.001M/s
uprobe-ret     :    0.480 =C2=B1 0.001M/s
uretprobe-nop  :    0.555 =C2=B1 0.000M/s
uretprobe-push :    0.549 =C2=B1 0.000M/s
uretprobe-ret  :    0.338 =C2=B1 0.000M/s


### uretprobe syscall (vs baseline)
uprobe-base    :   79.488 =C2=B1 0.033M/s
base           :    2.917 =C2=B1 0.003M/s
uprobe-nop     :    1.095 =C2=B1 0.001M/s
uprobe-push    :    1.058 =C2=B1 0.000M/s
uprobe-ret     :    0.483 =C2=B1 0.000M/s
uretprobe-nop  :    0.638 =C2=B1 0.000M/s (+15%)
uretprobe-push :    0.627 =C2=B1 0.000M/s (+14.2%)
uretprobe-ret  :    0.366 =C2=B1 0.000M/s (+8.3%)

Either way, yes, we should implement this. Are you planning to send an
official patch some time soon? I'm working on other small improvements
in uprobe/uretprobe, I'll probably send the first patches
today/tomorrow, but they shouldn't interfere with this uretprobe code
path.

See also a few comments on your code below.

My hacky changes:

commit dcf59baa5ad8ea4edb86ff1558eb1dcc28fcc7c0
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Sat Mar 9 20:16:02 2024 -0800

    [WIP] uprobes: implement uretprobe through syscall

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
b/arch/x86/entry/syscalls/syscall_32.tbl
index 5f8591ce7f25..0207dfb5018d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -466,3 +466,4 @@
 459    i386    lsm_get_self_attr       sys_lsm_get_self_attr
 460    i386    lsm_set_self_attr       sys_lsm_set_self_attr
 461    i386    lsm_list_modules        sys_lsm_list_modules
+462    i386    trace                   sys_trace
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..c16599e15bbb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -383,6 +383,7 @@
 459    common  lsm_get_self_attr       sys_lsm_get_self_attr
 460    common  lsm_set_self_attr       sys_lsm_set_self_attr
 461    common  lsm_list_modules        sys_lsm_list_modules
+462    common  trace                   sys_trace

 #
 # Due to a historical design error, certain syscalls are numbered differen=
tly
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..f2863c9fab3d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -965,6 +965,8 @@ asmlinkage long sys_lsm_set_self_attr(unsigned int
attr, struct lsm_ctx *ctx,
                                      size_t size, __u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);

+asmlinkage long sys_trace(int cmd);
+
 /*
  * Architecture-specific system calls
  */
diff --git a/include/uapi/asm-generic/unistd.h
b/include/uapi/asm-generic/unistd.h
index 75f00965ab15..2f66eb8b068e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_att=
r)
 #define __NR_lsm_list_modules 461
 __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)

+#define __NR_trace 462
+__SYSCALL(__NR_TRACE, sys_trace)
+
 #undef __NR_syscalls
-#define __NR_syscalls 462
+#define __NR_syscalls 463

 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 56a460719628..c6fc15bdbffc 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -28,6 +28,7 @@
 #include <linux/khugepaged.h>

 #include <linux/uprobes.h>
+#include <linux/syscalls.h>

 #define UINSNS_PER_PAGE
(PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
 #define MAX_UPROBE_XOL_SLOTS           UINSNS_PER_PAGE
@@ -1488,8 +1489,15 @@ static int xol_add_vma(struct mm_struct *mm,
struct xol_area *area)
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
        struct mm_struct *mm =3D current->mm;
-       uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
+       //uprobe_opcode_t insn =3D UPROBE_SWBP_INSN;
        struct xol_area *area;
+       char uret_syscall_patch[] =3D {
+               /* mov rax, __NR_trace */
+               0x48, 0xC7, 0xC0, 0xCE, 0x01, 0x00, 0x00,
+               /* syscall */
+               0x0F, 0x05,
+       };
+       const int URET_SYSCALL_INSNS_SIZE =3D ARRAY_SIZE(uret_syscall_patch=
);

        area =3D kmalloc(sizeof(*area), GFP_KERNEL);
        if (unlikely(!area))
@@ -1513,7 +1521,8 @@ static struct xol_area
*__create_xol_area(unsigned long vaddr)
        /* Reserve the 1st slot for get_trampoline_vaddr() */
        set_bit(0, area->bitmap);
        atomic_set(&area->slot_count, 1);
-       arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SI=
ZE);
+       arch_uprobe_copy_ixol(area->pages[0], 0, &uret_syscall_patch,
URET_SYSCALL_INSNS_SIZE);
+       //arch_uprobe_copy_ixol(area->pages[0], 0, &insn,
UPROBE_SWBP_INSN_SIZE);

        if (!xol_add_vma(mm, area))
                return area;
@@ -2366,3 +2375,16 @@ void __init uprobes_init(void)

        BUG_ON(register_die_notifier(&uprobe_exception_nb));
 }
+
+SYSCALL_DEFINE0(trace)
+{
+       struct pt_regs *regs =3D current_pt_regs();
+
+       //printk("BEFORE UTRACE!!!\n");
+
+       handle_trampoline(regs);
+
+       //printk("AFTER UTRACE!!!\n");
+
+       return 0;
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index faad00cce269..4a3bc957dd43 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -174,6 +174,7 @@ COND_SYSCALL_COMPAT(fadvise64_64);
 COND_SYSCALL(lsm_get_self_attr);
 COND_SYSCALL(lsm_set_self_attr);
 COND_SYSCALL(lsm_list_modules);
+COND_SYSCALL(trace);

 /* CONFIG_MMU only */
 COND_SYSCALL(swapon);

>
>
> ---
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 7e8d46f4147f..fa5f8a058bc2 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -383,6 +383,7 @@
>  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
>  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
>  461    common  lsm_list_modules        sys_lsm_list_modules
> +462    64      uprobe                  sys_uprobe
>

we should call it "uretprobe", "uprobe" will be a separate thing with
different logic.

I went with generic "trace", but realized that it would be better to
have separate more targeted "special/internal" syscalls (where, if
necessary, extra arguments would be passed through stack to avoid
storing/restoring user-space registers). We have rg_sigreturn
precedent which explicitly states that userspace shouldn't use it and
shouldn't rely on any specific arguments conventions.

[...]

>  /*
>   * Deprecated system calls which are still defined in
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f46e0ca0169c..9ef244c8ff19 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -138,6 +138,8 @@ extern bool arch_uretprobe_is_alive(struct return_ins=
tance *ret, enum rp_check c
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *=
regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr=
,
>                                          void *src, unsigned long len);
> +extern void uprobe_handle_trampoline(struct pt_regs *regs);
> +uprobe_opcode_t* arch_uprobe_trampoline(unsigned long *psize);

just `void *` here? it can be a sequence of instructions now

>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 75f00965ab15..2702799648e6 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_a=
ttr)
>  #define __NR_lsm_list_modules 461
>  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
>
> +#define __NR_uprobe 462
> +__SYSCALL(__NR_uprobe, sys_uprobe)

[...]
