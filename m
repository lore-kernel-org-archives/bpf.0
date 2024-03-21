Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57435228
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061832; cv=none; b=Lw3AmGSBy5DVDQMVMB++Wq7iq8UoDqTO+ZsB8AGsNBZ7LuT+nZb6w9ZEa9loQYCJr0H9ZOuJjZf1PBc8de8PH48kliHFpJjvwaK1dd98S0vg34pGU4+8m3Y4cQJvdPJ8bjJ1HMcyJUvLNU7Pl1df6oMHsSghkBItyTZRAUnKGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061832; c=relaxed/simple;
	bh=Vu4zpT340JKJZkHhapIvWJ8uY3YlU0+VP7D7+/hcoAU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIGTIBzHpjoYOIBpvzyjhJbxtTGTHOtwJG4Ovl00DUFDvtH/nouUdbAr09xNV/XzCYfGWo9CmhEUhbcTyBmnOYjadLQsoAdoZP5PIXkOqWYQQ3RGmIFM0fx9Z2bzP0k3ub0o1ndDrE1yFtYwRyvtGg520Hb3WY8MDlhoEtVJGBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKRhQpvh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKRhQpvh"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51381021af1so2427592e87.0
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711061829; x=1711666629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vOCnINvfHBOteItC3eaX1M+FiT4AF52jo1gYZhmtKgc=;
        b=TKRhQpvhrl5xe3Vz3DNaLDwo3Rweg8k8FqiM+SCySjInhwiJitX3ZptYzH09l7R4jo
         siefEI/f4LY6vsB+jJ03FbfSXqC2pAiFeK3C3umchamfm8rveRcaSA2PYm+qREkRa3GN
         TNXN2u5gbuq2rr1+m8mfKX+41T1Ra4Y4UBTddGJhoncF6EDDY97LSgb5L4q0dgNqgmiw
         5GcVBsvrTzX9HsUr5WQ9QK+fwXMe5m9Lmh6CUAr1hfN6kjHwLr0o9lzlrwC41u5LCfte
         Prb7uPWPR3V1CbLwE5SsEiAJ0G1QNQLmggcPSYxiY+o7MV3Aylx6NtCY8bWhfLjYhVy4
         nOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711061829; x=1711666629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOCnINvfHBOteItC3eaX1M+FiT4AF52jo1gYZhmtKgc=;
        b=Zaq+eyBvv38aSWLganlF+3LxRZxLtxlavmAHCfXPTJr2PJhTvAGLnqMp3NV87GsiRw
         W4eZli/bCsJZdsUw3KOfLMagTf60VXbtEbk0lWzzlN4GKi8Q81LpiZmwhRaU1EL0eoF0
         AvoBdUbkIWg8QV0iTYADI67zkefGqaqRJtOUwZNcCQxa8UnCYZs0VRx5JX8UUg3fmYVA
         WaY4fJtdPegsO+AsFoOJf0UAvPK4n0rODfHs+FGbs8Um1t19a4KIbxvaLCWQzLdJkH0X
         24hykGEzf2QwoLirNJsP74gp5iLdJmcqfDvu/CF/5+9tXoyivafX55Rx6I+70BmW7rK4
         h+LA==
X-Forwarded-Encrypted: i=1; AJvYcCUzAmD0ul/HFBHLLe5kEBx1T7Y8/wU0VpkvNl5OokVT9zu5o2/tUq2R/TowJyyeHp5AkYgDGAzAD+TKWnP/5T8HiZpe
X-Gm-Message-State: AOJu0Yyl+cGEnscx860+ggpPkK/jH8cyDKoF2USono9G/0zH1tSDPYt4
	+2KJH+7bIHANycrNMgk0LoNeC23+oQA5MUwR+ApnjVPmmJ3i4JaM
X-Google-Smtp-Source: AGHT+IE7vkHRIlL1J877mE4+n6hM94laHvSY5MwgrIsQ/oeMGCXqEYim1Z/lICOgDOqxF9S0ybGP1w==
X-Received: by 2002:a05:6512:46e:b0:513:bed1:5069 with SMTP id x14-20020a056512046e00b00513bed15069mr294299lfd.13.1711061828519;
        Thu, 21 Mar 2024 15:57:08 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090624cc00b00a46aac377e8sm381396ejb.54.2024.03.21.15.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:57:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 23:57:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, peterz@infradead.org, song@kernel.org
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
Message-ID: <Zfy7PZVNmzVl9NId@krava>
References: <20240321180501.734779-1-andrii@kernel.org>
 <20240321180501.734779-4-andrii@kernel.org>
 <ZfyhvaGMPPsvqkp-@krava>
 <CAEf4BzavNBj01bhse_Ag35wnGv2=OhiHSd280f0G6uCWyMq7sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzavNBj01bhse_Ag35wnGv2=OhiHSd280f0G6uCWyMq7sg@mail.gmail.com>

On Thu, Mar 21, 2024 at 02:09:41PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 21, 2024 at 2:08 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Mar 21, 2024 at 11:05:01AM -0700, Andrii Nakryiko wrote:
> > > Add arch-specific inlining of bpf_get_smp_processor_id() using x86-64's
> > > gs segment-based addressing.
> > >
> > > Just to be on the safer side both rip-relative addressing is implemented
> > > (providing a shorter instruction, but limiting offset to signed 32 bits)
> > > and more universal absolute memory offset addressing is used as
> > > a fallback in (unlikely) scenario that given offset doesn't fit int s32.
> > > The latter is 5 bytes longer, and it seems compilers prefer rip-relative
> > > instructions when compiling kernel code.
> > >
> > > Both instructions were tested and confirmed using gdb. We also already
> > > have a BPF selftest (raw_tp_test_run) that validates correctness of
> > > bpf_get_smp_processor_id(), while running target BPF program on each
> > > online CPU.
> > >
> > > Here's a disassembly of bpf_get_smp_processor_id() helper:
> > >
> > > $ gdb -batch -ex 'file vmlinux' -ex 'set disassembly-flavor intel' -ex 'disassemble/r bpf_get_smp_processor_id'
> > > Dump of assembler code for function bpf_get_smp_processor_id:
> > >    0xffffffff810fa890 <+0>:     0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
> > >    0xffffffff810fa895 <+5>:     65 8b 05 70 62 f3 7e    mov    eax,DWORD PTR gs:[rip+0x7ef36270]        # 0x30b0c <pcpu_hot+12>
> > >    0xffffffff810fa89c <+12>:    48 98                   cdqe
> > >    0xffffffff810fa89e <+14>:    c3                      ret
> > > End of assembler dump.
> > >
> > > And here's a GDB disassembly dump of a piece of BPF program calling
> > > bpf_get_smp_processor_id().
> > >
> > >   $ sudo cat /proc/kallsyms | rg 'pcpu_hot|bpf_prog_2b455b4f8a8d48c5_kexit'
> > >   000000000002d840 A pcpu_hot
> > >   ffffffffa000f8a8 t bpf_prog_2b455b4f8a8d48c5_kexit      [bpf]
> > >
> > > Then attaching GDB to the running kernel in QEMU and breaking inside BPF
> > > program:
> > >
> > > (gdb) b *0xffffffffa000f8e2
> > > Breakpoint 1 at 0xffffffffa000f8e2
> > >
> > > When RIP-relative instruction is used:
> > >
> > >   0xffffffffa000f8e2      mov    %gs:0x6001df63(%rip),%eax        # 0x2d84c <pcpu_hot+12>
> > >   0xffffffffa000f8e9      cltq
> > >
> > > You can see that final address is resolved to <pcpu_hot+12> as expected.
> > >
> > > When absolute addressing is used:
> > >
> > >   0xffffffffa000f8e2      movabs %gs:0x2d84c,%eax
> > >   0xffffffffa000f8ed      cltq
> > >
> > > And here 0x2d84c matches pcpu_hot address from kallsyms (0x2d840),
> > > plus 12 (0xc) bytes offset of cpu_number field.
> > >
> > > This inlining eliminates entire function call for this (rather trivial in terms
> > > of instructions executed) helper, saving a bit of performance, but foremost
> > > saving LBR records (1 for PERF_SAMPLE_BRANCH_ANY_RETURN mode, and 2 for
> > > PERF_SAMPLE_BRANCH_ANY), which is what motivated this work in the first
> > > place.
> >
> > this should also 'fix' the k[ret]probe-multi-fast benchmark issue right?
> 
> I already fixed it locally by switching to bpf_get_numa_node_id(), but
> this change would generally make my original approach not work because
> bpf_get_smp_processor_id() isn't actually called at runtime on x86-64
> :)

hm, but the reason was that program attached to bpf_get_smp_processor_id
called bpf_get_smp_processor_id helper:
  https://lore.kernel.org/bpf/CAEf4BzayNECKkmc4=XfLW5fzsPozMnjqOEmGO+r2UmEQXt1XyA@mail.gmail.com/

inlining of bpf_get_smp_processor_id helper call would prevent that, no?

jirka


> 
> >
> > https://lore.kernel.org/bpf/20240315051813.1320559-2-andrii@kernel.org/
> >
> > jirka
> >
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index 4900b1ee019f..5b7fdc24b5b8 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -457,6 +457,9 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> > >       *pprog = prog;
> > >  }
> > >
> > > +/* reference to bpf_get_smp_processor_id() helper implementation to detect it for inlining */
> > > +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> > > +
> > >  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> > >  {
> > >       u8 *prog = *pprog;
> > > @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> > >               pr_err("Target call %p is out of range\n", func);
> > >               return -ERANGE;
> > >       }
> > > -     EMIT1_off32(opcode, offset);
> > > +
> > > +     /* inline bpf_get_smp_processor_id() to avoid calls */
> > > +     if (opcode == 0xE8 && func == &bpf_get_smp_processor_id) {
> > > +             /* 7 to account for the mov instruction itself,
> > > +              * as rip value *after* mov instruction is used
> > > +              */
> > > +             offset = (void *)&pcpu_hot.cpu_number - ip - 7;
> > > +             if (is_simm32(offset)) {
> > > +                     /* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcpu_hot+12> */
> > > +                     EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> > > +             } else {
> > > +                     /* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+12> */
> > > +                     offset = (s64)(void *)&pcpu_hot.cpu_number;
> > > +                     EMIT2(0x65, 0xa1);
> > > +                     EMIT((u32)offset, 4);
> > > +                     EMIT((u64)offset >> 32, 4);
> > > +             }
> > > +             EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */
> > > +     } else {
> > > +             EMIT1_off32(opcode, offset);
> > > +     }
> > > +
> > >       *pprog = prog;
> > >       return 0;
> > >  }
> > > --
> > > 2.43.0
> > >
> > >
