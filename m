Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86F137923
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711055396; cv=none; b=RoOIsL9BAudp0vnMRyNGcNE5jb7WNtuwv3qv7HVfZeCVnd2k5t1AyQT+UpwE8QO4sqi1U39ytRKDAjSdky9lL2ho3VxhSBCFoeGlGr1PuvAN3tEqf3K9FrmmBwBqEMDh0WsrYioVRlsSSzxTR38lPqffBdGJKdiH3YPNkmmsdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711055396; c=relaxed/simple;
	bh=AYwMNywa9TyrRpfRvPF+3LO6fBFbCwHJhWX9eqhuw3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qksi4MsW/jnANpNMB86he39Mlt6/e+Fg56v+GDZyrvL2f2t9BaPxxmytxGIV5uMMamPr9ThVy/a9BcejVY492/Q3LWmPL97lthLEpIuP7EM6YVJMaDuTD/iIGfZVOcbYnr6JEHEWgx2Fp+DxObXx8aF85qcLYBXuczYOr7abxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z11601Dn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z11601Dn"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dca1efad59so948434a12.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 14:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711055394; x=1711660194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TUzv0dAMv3z5IbhgBfnNGcDkQ6ZK7nOkBedOSh5kww=;
        b=Z11601Dns1JK4SXLcXAh3vAMTTSI/iinrQ/3xfpoli1zN7R3t/gsRKDllhnivkQuty
         X7HsI0oY06SuwHdNLxL0FCeA4koAj7I8KqafpvKfsVrZHqw7W0YL0VMEtH/NL8VeaNrH
         NUbMkiAkVx1JnZRDqgoHTmovwiIHSZXzPq5egr6VtdzWkmiLZvtE6QK/PgsnuSxUoy2b
         ewulKhbGQcpWBgodLnG2ydHWOYiI16yUh1BB2CAznBq5lxfHzQaL87ynXMBwFv4an6Ju
         U1qcSPM4X4uZJvQuyWpQooFA92BgDkYSQa/NkprpbvHgRJBvEl82nOwdxSD+u/ehMJsI
         bhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055394; x=1711660194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TUzv0dAMv3z5IbhgBfnNGcDkQ6ZK7nOkBedOSh5kww=;
        b=pAwHP+c302xvg60/+Ipchxo6tr27qb8wyuvHcpULCKfxo0feFeIDiqIjdG07R9k7Pz
         BwgL+OFHHjRaZzvQg9y49X4Z1z8YTL4iusOPgJSYVLanv6ctv0BieMbbngVi9AnkkyGM
         lGFXSQDolb0KLGI9my/0lADbnhhPzXsoTeDovbycOyCig5hUrgTiO9J9YIt+HYLf2oun
         h8fkn3wZuZjkz+9IVXLTipZQYyAwlh+mS1QLfSVcA37mTIaZNC9KS0BcjdtjStoarYSt
         xlhT//3441IilK5jrBJAE4CpsY885rdAQUPWNmgaq12NBq6vNABjSrdfRPmEwp9LfQiN
         MHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUWMWkV6nMQVLs7HDejDZKHDl9WeR67qNCofQNX2owacUqzazZG50Emcdchdwi1eZ/+9NOpq9rC2b+jbxBFXFk+sE3K
X-Gm-Message-State: AOJu0Yy1pN2L2/liIE5a9eCYh1gWHCGCPeIg3U7WGD+u+lnGTZcJYwRM
	I9eic3QJzyPT05i0SwnBCwKFh+HopYfIyJGufgLJeLCsDOoQN4W6N+j484SpOchSCCFTAjVIWOM
	6eOXklY98LeXdTdv8R937ntF/HXc=
X-Google-Smtp-Source: AGHT+IEUP1MiEpNw6aUFvutn4YQZtCD8s9ap04RjWMr0v7Ttq7jD4Rnqazc4FwrjugPHEQVDoywrV3eryC4jznYuyP0=
X-Received: by 2002:a17:90b:fd4:b0:29b:3106:7f24 with SMTP id
 gd20-20020a17090b0fd400b0029b31067f24mr573230pjb.37.1711055394346; Thu, 21
 Mar 2024 14:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
 <ZfyhvaGMPPsvqkp-@krava>
In-Reply-To: <ZfyhvaGMPPsvqkp-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Mar 2024 14:09:41 -0700
Message-ID: <CAEf4BzavNBj01bhse_Ag35wnGv2=OhiHSd280f0G6uCWyMq7sg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, peterz@infradead.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:08=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Mar 21, 2024 at 11:05:01AM -0700, Andrii Nakryiko wrote:
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
>
> this should also 'fix' the k[ret]probe-multi-fast benchmark issue right?

I already fixed it locally by switching to bpf_get_numa_node_id(), but
this change would generally make my original approach not work because
bpf_get_smp_processor_id() isn't actually called at runtime on x86-64
:)

>
> https://lore.kernel.org/bpf/20240315051813.1320559-2-andrii@kernel.org/
>
> jirka
>
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
> >       *pprog =3D prog;
> >  }
> >
> > +/* reference to bpf_get_smp_processor_id() helper implementation to de=
tect it for inlining */
> > +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> > +
> >  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> >  {
> >       u8 *prog =3D *pprog;
> > @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, void=
 *ip, u8 opcode)
> >               pr_err("Target call %p is out of range\n", func);
> >               return -ERANGE;
> >       }
> > -     EMIT1_off32(opcode, offset);
> > +
> > +     /* inline bpf_get_smp_processor_id() to avoid calls */
> > +     if (opcode =3D=3D 0xE8 && func =3D=3D &bpf_get_smp_processor_id) =
{
> > +             /* 7 to account for the mov instruction itself,
> > +              * as rip value *after* mov instruction is used
> > +              */
> > +             offset =3D (void *)&pcpu_hot.cpu_number - ip - 7;
> > +             if (is_simm32(offset)) {
> > +                     /* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcpu_ho=
t+12> */
> > +                     EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> > +             } else {
> > +                     /* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+12> =
*/
> > +                     offset =3D (s64)(void *)&pcpu_hot.cpu_number;
> > +                     EMIT2(0x65, 0xa1);
> > +                     EMIT((u32)offset, 4);
> > +                     EMIT((u64)offset >> 32, 4);
> > +             }
> > +             EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */
> > +     } else {
> > +             EMIT1_off32(opcode, offset);
> > +     }
> > +
> >       *pprog =3D prog;
> >       return 0;
> >  }
> > --
> > 2.43.0
> >
> >
