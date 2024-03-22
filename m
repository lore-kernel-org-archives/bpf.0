Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC77360275
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126442; cv=none; b=srD0uNbYoTvTf1AAmJjj9e8BPfNE9Afo75kVSQkzWCLXKkhsILJ+oJAmTlVVZRltWtFMUR9kn4AVxQWaId+gLawLFxVM8J66pkL8N+oIvL+Udr6Xun47G8px2CXBGtOIhJN+Fzzz0mvGngwLXyxZM3nYbD5QlFZC3Pv8yFR3Zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126442; c=relaxed/simple;
	bh=AkNyXH4NyoxUUo4k/9i4OW7GAehJH0X0X8O8N+oQJeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVxsl204dQOLM3Hbwg3Ncq1l5lAD767QBD3cl4VUeAFGJ+hWqXNFpGjfvk7wLBFbVo9YML/jPswsjXkDoUNuWpGoMRDnLvOAVcGBE2LvU/Klb7UNwXrvkExmcKIG2jq47bkyyfCTLVc2lG+EOXGtgl7V/EHJkWWCcxuDVLUp2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpOmG/EM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpOmG/EM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so1740414b3a.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126440; x=1711731240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRLuqorgzjD+eKRbioSrIkh61wW+t7EIcOsJ14tErjE=;
        b=bpOmG/EM/hfI3YIxZbzhfaNmhu1DS8ohQtnzlGNCAVPn9tXhSJ+7XoOPGX6PsKAfRL
         QbdIgF1QMtbaDW1HGfh0pOtzJ0HNmQjizR37vwRT0F2jsNzbZpIhMtPM/pthhdnaANMN
         ZhiTy6n3GqWHNUhFNxYQeHf8zwrV5i19m0sUH6pPF745u+3EX3cBl2tgj78KlSmIhp1j
         1tmdGfLHbq2TKxASOp6q2Z6RJ9eiE9iGd5om2wsyGSMIF5iVS+3H86p1m5J5vae8vWHJ
         HMiH7mszcMWL47MZvjEfhB98+lXxYce6wnUUSFJF5Ak+dEjmJPhgVLxLrgXAepON3qaq
         7aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126440; x=1711731240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRLuqorgzjD+eKRbioSrIkh61wW+t7EIcOsJ14tErjE=;
        b=g4pQK5rqNhz5Yz0/sGnyGPCIaF8rkSvzeu+A+hXs3C9p9d2t9KTG8YE5FZMa1iV5r8
         6+p2QSzNisZXRbEkK4kcAHVPS1UVBbzudiuzxilyV3uYgvrsSwe4NeuaGcrCYOg6MSna
         ijBAWzo6ZyZ9Qu8pmZYE2Y8BEhRi5NuxLpiid3E7LXV+Zxe9vtmVNXZUFWKlVxkMKqsV
         kOwkYftol9QPo/pxcK4LDqeMkcQuSsxMG/Wwq6iavO6OnirdsGSK2KQ3os10EZvB4cQu
         WpfNnPmtyeKIR+dqGuvEVNJnr5ZwJP0yInT0fcXMyy8GEpLWx2STCN9DXb/O1zcNCujE
         W8jw==
X-Forwarded-Encrypted: i=1; AJvYcCX879yDFGF3GqaHW7+D/sfXzTytHoPHZwsqXUVgiEjmAQEFHH/SS8+IRPgWuLA7onpQ6H5lOJMwq0je7cVosOAWNZF3
X-Gm-Message-State: AOJu0YysAIcP37HMfnPI1tPuo1KT/5sD586pt0+vEYwXebHctdExscvS
	erDt7aS27I/AxMWV1CZ85Ppue8vZOPAxN2KVL8+VAF3gdWja1DWet5+OFVP+KHF7YVhomTj7BBN
	PKMbqf617oZfaZBcHGlGi6UE8C3gYH7am
X-Google-Smtp-Source: AGHT+IErA8IBP4ld85ByBEK1P++d5wCa+Qe6N3I8Mtvfb+AlvLZWr+wYrnGQms/NlS+NW6NvfO5XvyOt7iAH6Pz0ZA8=
X-Received: by 2002:a05:6a20:3d07:b0:1a3:4203:d518 with SMTP id
 y7-20020a056a203d0700b001a34203d518mr264174pzi.7.1711125942029; Fri, 22 Mar
 2024 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
 <CAADnVQLWv4eeKiEEZB1QjorFvNpmPLreBr3TPscf9kry8n25Cg@mail.gmail.com>
In-Reply-To: <CAADnVQLWv4eeKiEEZB1QjorFvNpmPLreBr3TPscf9kry8n25Cg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Mar 2024 09:45:29 -0700
Message-ID: <CAEf4BzYUZPULju9pnk3hoEb1uGROqSxM9tren9a5VqT7xCTOCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:49=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Add arch-specific inlining of bpf_get_smp_processor_id() using x86-64's
> > gs segment-based addressing.
> >
> > Just to be on the safer side both rip-relative addressing is implemente=
d
> > (providing a shorter instruction, but limiting offset to signed 32 bits=
)
> > and more universal absolute memory offset addressing is used as
> > a fallback in (unlikely) scenario that given offset doesn't fit int s32=
.
> > The latter is 5 bytes longer, and it seems compilers prefer rip-relativ=
e
> > instructions when compiling kernel code.
> >
> > Both instructions were tested and confirmed using gdb. We also already
> > have a BPF selftest (raw_tp_test_run) that validates correctness of
> > bpf_get_smp_processor_id(), while running target BPF program on each
> > online CPU.
> >
> > Here's a disassembly of bpf_get_smp_processor_id() helper:
> >
> > $ gdb -batch -ex 'file vmlinux' -ex 'set disassembly-flavor intel' -ex =
'disassemble/r bpf_get_smp_processor_id'
> > Dump of assembler code for function bpf_get_smp_processor_id:
> >    0xffffffff810fa890 <+0>:     0f 1f 44 00 00          nop    DWORD PT=
R [rax+rax*1+0x0]
> >    0xffffffff810fa895 <+5>:     65 8b 05 70 62 f3 7e    mov    eax,DWOR=
D PTR gs:[rip+0x7ef36270]        # 0x30b0c <pcpu_hot+12>
> >    0xffffffff810fa89c <+12>:    48 98                   cdqe
> >    0xffffffff810fa89e <+14>:    c3                      ret
> > End of assembler dump.
> >
> > And here's a GDB disassembly dump of a piece of BPF program calling
> > bpf_get_smp_processor_id().
> >
> >   $ sudo cat /proc/kallsyms | rg 'pcpu_hot|bpf_prog_2b455b4f8a8d48c5_ke=
xit'
> >   000000000002d840 A pcpu_hot
> >   ffffffffa000f8a8 t bpf_prog_2b455b4f8a8d48c5_kexit      [bpf]
> >
> > Then attaching GDB to the running kernel in QEMU and breaking inside BP=
F
> > program:
> >
> > (gdb) b *0xffffffffa000f8e2
> > Breakpoint 1 at 0xffffffffa000f8e2
> >
> > When RIP-relative instruction is used:
> >
> >   0xffffffffa000f8e2      mov    %gs:0x6001df63(%rip),%eax        # 0x2=
d84c <pcpu_hot+12>
> >   0xffffffffa000f8e9      cltq
> >
> > You can see that final address is resolved to <pcpu_hot+12> as expected=
.
> >
> > When absolute addressing is used:
> >
> >   0xffffffffa000f8e2      movabs %gs:0x2d84c,%eax
> >   0xffffffffa000f8ed      cltq
> >
> > And here 0x2d84c matches pcpu_hot address from kallsyms (0x2d840),
> > plus 12 (0xc) bytes offset of cpu_number field.
> >
> > This inlining eliminates entire function call for this (rather trivial =
in terms
> > of instructions executed) helper, saving a bit of performance, but fore=
most
> > saving LBR records (1 for PERF_SAMPLE_BRANCH_ANY_RETURN mode, and 2 for
> > PERF_SAMPLE_BRANCH_ANY), which is what motivated this work in the first
> > place.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 4900b1ee019f..5b7fdc24b5b8 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -457,6 +457,9 @@ static void emit_prologue(u8 **pprog, u32 stack_dep=
th, bool ebpf_from_cbpf,
> >         *pprog =3D prog;
> >  }
> >
> > +/* reference to bpf_get_smp_processor_id() helper implementation to de=
tect it for inlining */
> > +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> > +
> >  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> >  {
> >         u8 *prog =3D *pprog;
> > @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, void=
 *ip, u8 opcode)
> >                 pr_err("Target call %p is out of range\n", func);
> >                 return -ERANGE;
> >         }
> > -       EMIT1_off32(opcode, offset);
> > +
> > +       /* inline bpf_get_smp_processor_id() to avoid calls */
> > +       if (opcode =3D=3D 0xE8 && func =3D=3D &bpf_get_smp_processor_id=
) {
> > +               /* 7 to account for the mov instruction itself,
> > +                * as rip value *after* mov instruction is used
> > +                */
> > +               offset =3D (void *)&pcpu_hot.cpu_number - ip - 7;
> > +               if (is_simm32(offset)) {
> > +                       /* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcpu_=
hot+12> */
> > +                       EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> > +               } else {
> > +                       /* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+12=
> */
> > +                       offset =3D (s64)(void *)&pcpu_hot.cpu_number;
> > +                       EMIT2(0x65, 0xa1);
> > +                       EMIT((u32)offset, 4);
> > +                       EMIT((u64)offset >> 32, 4);
> > +               }
> > +               EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */
>
> Please introduce new pseudo insn that can access per-cpu vars
> in a generic way instead of hacking a specific case.

Sure, but do they have to be mutually exclusive? One doesn't prevent
the other. Having bpf_get_smp_processor_id() inlined benefits tons of
existing BPF applications transparently, which sounds like a win to
me.

Designing and adding new instruction also sounds fine, but it's a
separate feature and is more involved and will require careful
considerations. E.g., we'll need to think through whether all JITs
will be able to implement it in native code (i.e., whether they will
have enough free registers to implement this efficiently; x86-64 is
lucky to not need any extra registers, I believe ARM64 needs one extra
register, though; other architectures I have no idea). Safety
considerations as well (do we accept any random offset, or only ones
coming from per-CPU BTF variables, etc). I don't know if there are any
differences, but per-CPU access for module per-CPU variables is
something to look into (I have no clue).

And even once we have this instruction and corresponding compiler
support, it will still take a while until applications can assume its
availability, so that adds to logistics.

Also, even with this instruction, getting CPU ID efficiently is still
important for cases when a BPF application needs its own per-CPU
"storage" solution. I'm not sure it's a good experience to require
every user to figure out the pcpu_hot.cpu_number thing by themselves
through a few layers of kernel macros.

As an interim compromise and solution, would you like me to implement
a similar inlining for bpf_this_cpu_ptr() as well? It's just as
trivial to do as for bpf_get_smp_processor_id(), and would benefit all
existing users of bpf_this_cpu_ptr() as well, while relying on
existing BTF information and surrounding infrastructure?

What's the worst outcome? If the kernel changes how CPU number is
defined (not pcpu_hot.cpu_number) and we can't easily adapt JIT logic,
we can just stop doing inlining and we'll lose a bit of performance
and function call avoidance. Bad, but not API breaking or anything
like that. And we will detect when things change, we have a test that
checks this logic for each CPU, making sure we get the right one.



> Then we can use it in get_lookup in percpu array and hash maps
> improving their performance and in lots of other places.
>
> pw-bot: cr
