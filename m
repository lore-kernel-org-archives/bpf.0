Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB929A9
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064333; cv=none; b=VESFUQxtxUBH3boKc+CwjIexRXqanV8lLFoZ0Hea9PCU5Lx4wGuXBVq+SlC3S24w8oorypEd1CZManx0unXtQiNtBM9ebTaVIS/ubxWG25T4g6WO6Ris6K7iTK53h09PQSf5JGOjkKEj3hr5dfRL5p2bOLBpwXo46PyCsTRqlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064333; c=relaxed/simple;
	bh=sQu6WtwR2XPZh3jXCsD8oLMV/Y2Ot8ytM1QE+l9Cx40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKFzE3A2F4pA4PB9lwYOzY8+doeMOvTBB1XkBVMFhMEk2z1+Dl+aWgCAk1tFvhvnbsZ4HdGyGK5qnmxKfukRwpu2HKzmkeMbsxFKEDSr0AjJHcfTRcMhysm3Dwmwjuvepqy43Kg8kFHxUFVmYOj7aOfmgJGJSIJWz2WTcg5K1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8Xyqztj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8Xyqztj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1040772a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711064331; x=1711669131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pb+vymm4li8Yw2PnqcY0acFyyip9i0h25SkWm2a4YQ=;
        b=E8Xyqztjx5u+cg7eZGXt1vHLG2j8IZGp26VlckX6wIu+1waT2c+j8a/huLQN3Wy0tv
         S5onuQAjO/GQJ9MnyzoGp5RmjW+73oZz5Y64foKPtVOOkGykD/0S3XpNOnYrJJYPHzH6
         3W55iXxzubqLVnLkhC6xmpQD051XClRKEhwwijihkIUYLb7/zhrCiaMTc1tr7seswG82
         C3/IVtrtct+BvcxlRXBWwRHcq2g5AcICAuUvwc7CXdQGWQ4oe0KPwx5J/d4cjt++2gbl
         goXdiB+2ZKupduh22Xl50UeBB/ULz5rgVI3gHz6l37Y/faJHgCLiL6R6TwNr84y66z3t
         31aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711064331; x=1711669131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pb+vymm4li8Yw2PnqcY0acFyyip9i0h25SkWm2a4YQ=;
        b=O1d2f0vCARn2vShMTWYVtraTyjTl6CVTS0adyy/0QOqBBWgCZyZv7KWAqa2giurvRW
         wDqoE2RaPXYW84FeGAxUc9xmgZKVmQtxtkDeHBDCfjsZUUBzgYEOIVBSvNJny6+siwlC
         sxCBXN5R7bYJLpdYJyPY166Nd2QEPAABva44ielGt70lZBl+2429F2AGYSvWR48GPkCz
         Rfu5JNtRwLqoD6mdy7Zy7WVZ2bnXGErO3mjzZODLkq2vc2dCYWQ1e+iJmc6B3XTFLEcx
         JVIcA0R7W6O2x7mX4vqw9Nlb/AfSpzgh1iNkWM85uhBlh1Pdo4Ec9EyqZXDDGX9u1AQH
         ZPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVJPOb4+frTBDyIFk3abWJocj/MAQdfUjc6PcOnSQPN6usTttSt7W/ofmyqaPEPRaTCsVSQO6u8lYsc3cIv6phQG7yi
X-Gm-Message-State: AOJu0YxjDxWiS1IAmU8Nr/BWolxwPw4qQo34WOBc10yn1OXlo6kcZJVg
	BQcCVQdvNgRqbTTrrwkPlHkey6Q7G6vR4XdVLADu0TJt2yarLwJYHqEx/aAOoe8BNTg219OSxmf
	a83zHL3V5dWTCYfGp/NCYCwV9seA=
X-Google-Smtp-Source: AGHT+IFYDEB6VsX3dVyiBKtscXJtvaApDHBuIy/O7r+mqoYt1z1+jU0+HM3GCgKbd55Ibl/+tmwJlSfJ7lgAz8YT8FM=
X-Received: by 2002:a17:90a:1108:b0:29e:343:76c4 with SMTP id
 d8-20020a17090a110800b0029e034376c4mr791834pja.4.1711064331233; Thu, 21 Mar
 2024 16:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
 <ZfyhvaGMPPsvqkp-@krava> <CAEf4BzavNBj01bhse_Ag35wnGv2=OhiHSd280f0G6uCWyMq7sg@mail.gmail.com>
 <Zfy7PZVNmzVl9NId@krava>
In-Reply-To: <Zfy7PZVNmzVl9NId@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 16:38:38 -0700
Message-ID: <CAEf4BzYi-F2gKR=VmTXTQB5YPv4umh9kbjF2MfYdtH-eFRywKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, peterz@infradead.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:57=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 21, 2024 at 02:09:41PM -0700, Andrii Nakryiko wrote:
> > On Thu, Mar 21, 2024 at 2:08=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Mar 21, 2024 at 11:05:01AM -0700, Andrii Nakryiko wrote:
> > > > Add arch-specific inlining of bpf_get_smp_processor_id() using x86-=
64's
> > > > gs segment-based addressing.
> > > >
> > > > Just to be on the safer side both rip-relative addressing is implem=
ented
> > > > (providing a shorter instruction, but limiting offset to signed 32 =
bits)
> > > > and more universal absolute memory offset addressing is used as
> > > > a fallback in (unlikely) scenario that given offset doesn't fit int=
 s32.
> > > > The latter is 5 bytes longer, and it seems compilers prefer rip-rel=
ative
> > > > instructions when compiling kernel code.
> > > >
> > > > Both instructions were tested and confirmed using gdb. We also alre=
ady
> > > > have a BPF selftest (raw_tp_test_run) that validates correctness of
> > > > bpf_get_smp_processor_id(), while running target BPF program on eac=
h
> > > > online CPU.
> > > >
> > > > Here's a disassembly of bpf_get_smp_processor_id() helper:
> > > >
> > > > $ gdb -batch -ex 'file vmlinux' -ex 'set disassembly-flavor intel' =
-ex 'disassemble/r bpf_get_smp_processor_id'
> > > > Dump of assembler code for function bpf_get_smp_processor_id:
> > > >    0xffffffff810fa890 <+0>:     0f 1f 44 00 00          nop    DWOR=
D PTR [rax+rax*1+0x0]
> > > >    0xffffffff810fa895 <+5>:     65 8b 05 70 62 f3 7e    mov    eax,=
DWORD PTR gs:[rip+0x7ef36270]        # 0x30b0c <pcpu_hot+12>
> > > >    0xffffffff810fa89c <+12>:    48 98                   cdqe
> > > >    0xffffffff810fa89e <+14>:    c3                      ret
> > > > End of assembler dump.
> > > >
> > > > And here's a GDB disassembly dump of a piece of BPF program calling
> > > > bpf_get_smp_processor_id().
> > > >
> > > >   $ sudo cat /proc/kallsyms | rg 'pcpu_hot|bpf_prog_2b455b4f8a8d48c=
5_kexit'
> > > >   000000000002d840 A pcpu_hot
> > > >   ffffffffa000f8a8 t bpf_prog_2b455b4f8a8d48c5_kexit      [bpf]
> > > >
> > > > Then attaching GDB to the running kernel in QEMU and breaking insid=
e BPF
> > > > program:
> > > >
> > > > (gdb) b *0xffffffffa000f8e2
> > > > Breakpoint 1 at 0xffffffffa000f8e2
> > > >
> > > > When RIP-relative instruction is used:
> > > >
> > > >   0xffffffffa000f8e2      mov    %gs:0x6001df63(%rip),%eax        #=
 0x2d84c <pcpu_hot+12>
> > > >   0xffffffffa000f8e9      cltq
> > > >
> > > > You can see that final address is resolved to <pcpu_hot+12> as expe=
cted.
> > > >
> > > > When absolute addressing is used:
> > > >
> > > >   0xffffffffa000f8e2      movabs %gs:0x2d84c,%eax
> > > >   0xffffffffa000f8ed      cltq
> > > >
> > > > And here 0x2d84c matches pcpu_hot address from kallsyms (0x2d840),
> > > > plus 12 (0xc) bytes offset of cpu_number field.
> > > >
> > > > This inlining eliminates entire function call for this (rather triv=
ial in terms
> > > > of instructions executed) helper, saving a bit of performance, but =
foremost
> > > > saving LBR records (1 for PERF_SAMPLE_BRANCH_ANY_RETURN mode, and 2=
 for
> > > > PERF_SAMPLE_BRANCH_ANY), which is what motivated this work in the f=
irst
> > > > place.
> > >
> > > this should also 'fix' the k[ret]probe-multi-fast benchmark issue rig=
ht?
> >
> > I already fixed it locally by switching to bpf_get_numa_node_id(), but
> > this change would generally make my original approach not work because
> > bpf_get_smp_processor_id() isn't actually called at runtime on x86-64
> > :)
>
> hm, but the reason was that program attached to bpf_get_smp_processor_id
> called bpf_get_smp_processor_id helper:
>   https://lore.kernel.org/bpf/CAEf4BzayNECKkmc4=3DXfLW5fzsPozMnjqOEmGO+r2=
UmEQXt1XyA@mail.gmail.com/
>
> inlining of bpf_get_smp_processor_id helper call would prevent that, no?

Yes, I'm agreeing with you. I'm just saying that in v2 I'm attaching
to bpf_get_numa_node_id() instead, so all this is irrelevant.

>
> jirka
>
>
> >
> > >
> > > https://lore.kernel.org/bpf/20240315051813.1320559-2-andrii@kernel.or=
g/
> > >
> > > jirka
> > >
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
> > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_com=
p.c
> > > > index 4900b1ee019f..5b7fdc24b5b8 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -457,6 +457,9 @@ static void emit_prologue(u8 **pprog, u32 stack=
_depth, bool ebpf_from_cbpf,
> > > >       *pprog =3D prog;
> > > >  }
> > > >
> > > > +/* reference to bpf_get_smp_processor_id() helper implementation t=
o detect it for inlining */
> > > > +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> > > > +
> > > >  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> > > >  {
> > > >       u8 *prog =3D *pprog;
> > > > @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, =
void *ip, u8 opcode)
> > > >               pr_err("Target call %p is out of range\n", func);
> > > >               return -ERANGE;
> > > >       }
> > > > -     EMIT1_off32(opcode, offset);
> > > > +
> > > > +     /* inline bpf_get_smp_processor_id() to avoid calls */
> > > > +     if (opcode =3D=3D 0xE8 && func =3D=3D &bpf_get_smp_processor_=
id) {
> > > > +             /* 7 to account for the mov instruction itself,
> > > > +              * as rip value *after* mov instruction is used
> > > > +              */
> > > > +             offset =3D (void *)&pcpu_hot.cpu_number - ip - 7;
> > > > +             if (is_simm32(offset)) {
> > > > +                     /* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcp=
u_hot+12> */
> > > > +                     EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> > > > +             } else {
> > > > +                     /* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+=
12> */
> > > > +                     offset =3D (s64)(void *)&pcpu_hot.cpu_number;
> > > > +                     EMIT2(0x65, 0xa1);
> > > > +                     EMIT((u32)offset, 4);
> > > > +                     EMIT((u64)offset >> 32, 4);
> > > > +             }
> > > > +             EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */
> > > > +     } else {
> > > > +             EMIT1_off32(opcode, offset);
> > > > +     }
> > > > +
> > > >       *pprog =3D prog;
> > > >       return 0;
> > > >  }
> > > > --
> > > > 2.43.0
> > > >
> > > >
