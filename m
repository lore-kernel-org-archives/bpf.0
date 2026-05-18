Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97048AE2B
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120897; cv=pass; b=W1mwKSCXjB3l3f1ch2h/l0eNqdz/FSNUyMWP04CfU5dQGM9X5Bo0zrN8Nc3Md0BEbQLtwEF8rXA2nfsiYXCMbc02e6ScBU8r5GY+wwfkMxq6kekMT7xokzLAMga95qVToZxNE0N37U3fDd3BzRQf3GY2+XXqGzriad7MLf6JSE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120897; c=relaxed/simple;
	bh=EmYKj06afbAhmfrg0dU9ILwqg+Kx17GPBCdiKSIJuRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugiPk3n3Oih/5SbVKUfnpVaO2FDo6/bK7iADP49krBKDiUVNSJgkt7B+7ZHi8yTeKYcRx2bsJVuAX4esAWH9jYAKCnnplY05w3KHeahyDrPkMu0gm/tsYY0pIIc1T3vseEEGrTLvRop/gQlglcKl73gtkE+t3PGXdBKzBO7fz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBMieT8R; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBMieT8R"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-369576666d5so1124198a91.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779120888; cv=none;
        d=google.com; s=arc-20240605;
        b=SULIDotdgnEbQoD8kmd2tRcFW9rNXl/ih/Ok3z8/OguFZM9n7sCK05OoF0twGyDt1q
         9a4pSspKZ0rGv2wbMjsJw5FM/Zt4Rxq9hCKRBX4bkgcBPhskKAyDR+Fj/lz3eSoEL6vX
         9sltfG6jDPxOgliwmeGqBDEpgg8p2Au6g0MBis1hBFb0ZtVLAUmeMSoAjtazUSRnB9nw
         KxV6mdx4hlCaRj4UnbXgMaqamhYQpy5Pv/Lua33uOB2zHoa4g3+5rYxcYNStlHWohAYu
         MZF+Yi6qTYsAQyvwgpx80dmgLPlXdvH1q3mKLL//WfbEFFOL0ZaUdM8JBjckBVI4hWPD
         it0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        fh=pOVB6+7CGP6VDjcADxllBDU3GoIRMyHwdq4oFqVCSyE=;
        b=ipciEcVQjvlsNGwp+gOmMayKPSatUxLfDPhfV9XL55To9H8ZVRvu+FthQZ3vX2S5yU
         hUsqDprqWAmcGW2+5q0avH8sKVoD6PoJpVp8ivQBPdlbQekE/v6+StKLTb9MFRMyJ4PT
         OMu6Uf88TSqQNSZ3ibzDSU/3c9E5DvK+au/+2xY+06hjaPny7UA/GZBbhiuxDE+mwHSX
         oLbx7de0esavy5YIAi7kemg2c7stKDGgoVP8zGD2d4cJbHlqAG0KhG66ooxHbyphY+G0
         Ym4TpLgGhWRMheohrVQqv21OAmaOFYUaq6/WP0m++jMEdPht/V3ApfBQbUucmg76prQ2
         NNKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779120888; x=1779725688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        b=nBMieT8RN/OXdyhR8t0pMmB/zpvPQfGlaxlPd96cjf3lLKvZ7m3+Jdk39kkHQ0Riio
         vHxFKSRWhzhq874LZnald5hnjtUQ40ehymGF53y9Cpj3amIQp+4bqu1yeWP3tdgybkCb
         4m/pm2BJaum9Qx/tF72VhaUQ91LHWCALMtWJBvz3AWAEP5yjMXBos2Qe/7eGCFBoDule
         O+lG3T+x4TzN4cgDXOpOB6PWg04ta7CSMQFGHoZx6tbwhGCx6Wo2rd2mSwVWNA4qWtPW
         T4/u1No6D7B2R487wugtmKVFn57WVGIQ4QFLlPFcHnJrBszwiH5Il+NcL/GBaR6oEvYw
         AUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120888; x=1779725688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjHa52dJp+dkJOLU1Zzxxd+w92lhdzj56DEfyUv/Ue8=;
        b=qeldp/syN675XlQKOiwkwNNW2sbdp43zSQfxJx5NWQYzcoczcHqOQa09NUlwwlqz3x
         85yJASu1Axnxpfu7qkvyc8FcA70GbavgXjIt8feYN+s5Uw4XRACvopobWJHmPHIUUp0e
         TBJGV4txaDBC82EtR6KRkq8JHkFY9Q0wAk45qhELj9mWKiXlCP/lHJ7NjdaziFrYnUmu
         CwjK/T3dCqcXcOVWZID9FfdMjAzakmbNzgENL2t1y6L5FeAVZOeLzNvAqUgaWrG3YBow
         mpag4zA9SrXOpavEq8L0ZZi+GRa5JXrb81c5DVljeVvPj2E6RCpDUKBvpDGX7S7WeL4U
         E/AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ran5Gbtr4b2di0xfhswJ1A2O9xTgOYzE3tm2Om5hEaC034/IufYx7uVzpqZtymsPENzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+IKMW6DsFI1Dw3nym6Vd815izF6lO2GBa96OAc97zowP7D30a
	eGUr2xd0PTo0AMB0nEJFUYbQSjUNYJf5ZXcpdwLjOUBm87A45ZKw4pp10yVrvAWVhj3SSKgmROI
	4vP8f7jlNP600JfNEOUf//c9xrQa8rgQ=
X-Gm-Gg: Acq92OHWdoysy93JdLAy3C3BbYTWLF/bdJ79pbVb54RCWf8j8O6X3uwK55AERfBKON6
	PCKlp7WDhJ1K0JSVptS+0Y3ssZeGz0AIHslMDWRI9ybnNQxBUu2n3E0Ctjg7q4lc8ufIuTKLDY6
	4ekACBIP6dfRffz3GG9EM9kq9thWkrv41KTeS8nnDlKljOwsB6wB+ZjqnZhW1D7bfkodplADIAS
	NCsaivDFdZKeNNWPMCVenMI56ZacVR7J5mYH9uvAMTn4FztZaS8GBouyL4BPLFGL2g7/9Iqj2vw
	EZzRGMHq25SZYghNY105DhzJtjoaU1EqXw==
X-Received: by 2002:a17:90b:4a:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-369519feb17mr15447389a91.7.1779120887793; Mon, 18 May 2026
 09:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514135342.22130-1-jolsa@kernel.org> <20260514135342.22130-2-jolsa@kernel.org>
 <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 May 2026 09:14:35 -0700
X-Gm-Features: AVHnY4JK4mY1rOZBzuAPZOoe3LWqZaJCXqcJOCk5pjKz8K5LnElg5g71QZFlCcA
Message-ID: <CAEf4BzaSKBJDyo=GpRAfB45nqCu4CQ6RyVv2kX2hXhF+KhBTBA@mail.gmail.com>
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
>
> You seem to have forgotten to Cc LKML and x86 :-(
>
> On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
>
> > @@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *aupr=
obe, struct vm_area_struct *vma,
> >  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma,
> >                        unsigned long vaddr, unsigned long tramp)
> >  {
> > -     u8 call[5];
> > +     u8 insn[OPT_INSN_SIZE], *call =3D &insn[LEA_INSN_SIZE];
> >
> > -     __text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> > +     /*
> > +      * We have nop10 instruction (with first byte overwritten to int3=
),
> > +      * changing it to:
> > +      *   lea -0x80(%rsp), %rsp
> > +      *   call tramp
> > +      */
> > +     memcpy(insn, lea_rsp, LEA_INSN_SIZE);
> > +     __text_gen_insn(call, CALL_INSN_OPCODE,
> > +                     (const void *) (vaddr + LEA_INSN_SIZE),
> >                       (const void *) tramp, CALL_INSN_SIZE);
> > -     return int3_update(auprobe, vma, vaddr, call, true /* optimize */=
);
> > +     return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true=
 /* optimize */);
> >  }
> >
> >  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area=
_struct *vma,
> >                          unsigned long vaddr)
> >  {
> > -     return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* o=
ptimize */);
> > +     /*
> > +      * We have optimized nop10 (lea, call), changing it to 'jmp rel8'=
 to
> > +      * end of the 10-byte slot instead of restoring the original nop1=
0,
> > +      * because we could have thread already inside lea instruction.
>
> Inaccurate, RIP could be on CALL, not inside LEA. Writing NOP10 would
> make it inside NOP10 though, and that would cause havoc IF you use the
> normal NOP10.
>
> Thing is, the encoding of NOP{8,9,10} would actually allow you to
> preserve the CALL instruction :-)
>
> That is, observe:
>
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
>
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs n=
opw 0x00000000(%rax,%rax,1)
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x78, 0x56, 0x34, 0x12 -- cs n=
opw 0x12345678(%rax,%rbp,8)
>
> Specifically the CALL opcode sits in the SIB byte and decodes like:
>
>   e8 :=3D 11 101 000
>
>   scale =3D 11  (2^3 =3D 8)
>   index =3D 101 BP
>   base  =3D 000 AX
>
> And the displacement is just that, a displacement.
>
> So you *could* in fact, write back _A_ NOP10, just not the standard
> NOP10.
>
> > +      */
> > +     u8 jmp[OPT_INSN_SIZE] =3D { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
> > +
> > +     return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, fals=
e /* optimize */);
> >  }
>
> Changelog wants significant update to explain this scheme.
>
> So we have:
>
>   NOP10 -+-> LEA -0x80(%rsp), %rsp, CALL foo -> JMP.d8 +8
>          |                                          |
>          `------------------------------------------'
>
> And you want to belabour the point of how you ensure re-writing the CALL
> instruction isn't a problem (because I'm not convinced).
>
> Note that the above results in:
>
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw =
0x00000000(%rax,%rax,1)
>
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- int3
> optimize-tail:
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-finish:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x8=
0(%rsp),%rsp; call 0x78563412
>
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-finish:
> 6: 0xeb, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- jmp.d8 +=
8; call 0x78563412
>
> optimize-int3:
> 7: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-tail:
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
> optimize-finish:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
>
> Note that from step 7 to step 8, you re-write the CALL instruction
> without going through INT3. This means it is entirely possible for a
> concurrent execution to observe a composite instruction.
>
> This is NOT sound!

We shouldn't need to change call instruction ever, uprobe trampoline
is permanent within the given process and its address won't change.

>
> However, I think it can be salvaged, if instead of only writing INT3 at
> +0, you also write INT3 at +5. The sequence then becomes:
>
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw =
0x00000000(%rax,%rax,1)
>
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x00, 0x00, 0x00, 0x00 -- int3; in=
t3
> optimize-tail(s):
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; in=
t3
> optimize-finish-1:
> 3: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> optimize-finish-2:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x8=
0(%rsp),%rsp; call 0x78563412
>
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; ca=
ll 0x78563412
> unoptimize-finish:
> 6: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- cs nopw =
0x78563412(%rax,%rbp,8); call 0x78563412
>
> optimize-int3:
> 7: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; in=
t3
> optimize-tail(s):
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x78, 0x56, 0x34, 0x12 -- int3; in=
t3
> optimize-finish-1:
> 9: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; ca=
ll 0x12345678
> optimize-finish-2:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- lea -0x8=
0(%rsp),%rsp; call 0x12345678
>

[...]
