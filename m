Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C51DFCF
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064956; cv=none; b=OsVWOhy/X+aXEnHknUeS7YptTe+vF48BGerSqvV13XSuCjwpHe3Pm+t9/XHEmE2RGQMpP1DLd/xxbgXvj8F2bSI4CvtJpeNWx235yhXwvbBuMjUM9xmPKD37R7N6n7k3LknrnoN/EsOYleJtzyucTRQqRgOz24shc0ePRDcPskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064956; c=relaxed/simple;
	bh=U9Hfw6j1dyJhARcIsb0RCPDaHZtNTt3FJQFyXxOehEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfdxt2egYY0IehykwsuK8mjQLO6CS5VP2fCSri+3BB9ogfMoUG5mCYyc9ghkrXQYNE6ltK7NEoJa2rjjIQ/lc7PAFNinRDBwud+HW9LMvs92cCCt0H0JeldBTAO9maVvjZ9Iuu8FqaxSiOQbPtNN9P7m3aa8xqM9eP/1JMAZYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFCEWuJ9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFCEWuJ9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ddd1624beso983773f8f.1
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711064953; x=1711669753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVy5ZBTlKaKhG1C6dPVi2PqNTPCYocFSYTl+Zzlfhfk=;
        b=TFCEWuJ9olUpc3K3PQHCYcgIH+OHbYwJWae0/dhSHgXLvzPnBDE6z40jWS+NbieRxy
         UHGIma8ViYRmgk6kR+J7glQUkNNn2szYcAe7f2IDYVBAiCYHwrU91WujrUyUfcAjke6o
         Yjt9wJiH04QwtkW9UsD3ns5u63AKGGOmYlAJ4gcetk5fhFzHfV+b304J3bReiEzsy/1b
         FU0CaiPKDZFV26luC3YlRAJbcKFaUI8lHBq6eS9EctCCn4U5sGgXApCBVkoYuRiMnBdG
         E6wmGWGIQdWFxrG4yi63XpSHVzIgqrqfrITjT3HQ3KO3XGvfgZ4beDsg/bsfAOQCB5CE
         +6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711064953; x=1711669753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVy5ZBTlKaKhG1C6dPVi2PqNTPCYocFSYTl+Zzlfhfk=;
        b=rKqAFUFsrjYJt6MNtHWvLx5kLIItMMLLCAonFG7mVCUM2y+pjcqeIlXdy+96Q4NAG2
         c6+UtdZYk7KQolfaZWPDjoCv6l6TmC16b0VwXQSFxzJZXj1Uzz3AyK6Xh9DNbuFY+SzP
         62f2qq2XZ5hxxbDYiaFeBT3153HhRgFlpUdb5qq8e+dQmvJpyumZHBC6kGZgFgCVokcj
         DxxZtoYwXC6oLGA/Ip0ydB7g3tKpAuimaubX9tEGQKKROuvPyg3jm9y3kA2F+OOYXVpj
         BMXfnIBKxLswyyOhzMbRcUNXCYjIH/wcMXlyAP/s5m5RQIhXwfJmyQt98sx9UEzzRcft
         Pzjw==
X-Gm-Message-State: AOJu0YwNv+wbop+llF5YHbP/+oCMsF6/MrH/QFaKHLUyIAJV9S7SAEHg
	wLdeq3D1dp8j4LLM6wxKVrkWjijhdW2w38uZJBMmUfcN5OM0VWP73g1ygCFXsCKXOR1cVt4pQ+W
	z9BRsswWzds88kW3wTEq7OmRErnk=
X-Google-Smtp-Source: AGHT+IHgIbTwq3D94DjLFJmXjf6VEVhDWQkGiZaC8Vi55twVbYOEM1JXVh6NC3hVwgivJiKAr7Zv/jEdgmNkIn6AYwQ=
X-Received: by 2002:adf:efc5:0:b0:33e:764b:ab17 with SMTP id
 i5-20020adfefc5000000b0033e764bab17mr291436wrp.14.1711064952611; Thu, 21 Mar
 2024 16:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321180501.734779-1-andrii@kernel.org> <20240321180501.734779-4-andrii@kernel.org>
In-Reply-To: <20240321180501.734779-4-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Mar 2024 16:49:00 -0700
Message-ID: <CAADnVQLWv4eeKiEEZB1QjorFvNpmPLreBr3TPscf9kry8n25Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf,x86: inline bpf_get_smp_processor_id()
 on x86-64
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:05=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> Add arch-specific inlining of bpf_get_smp_processor_id() using x86-64's
> gs segment-based addressing.
>
> Just to be on the safer side both rip-relative addressing is implemented
> (providing a shorter instruction, but limiting offset to signed 32 bits)
> and more universal absolute memory offset addressing is used as
> a fallback in (unlikely) scenario that given offset doesn't fit int s32.
> The latter is 5 bytes longer, and it seems compilers prefer rip-relative
> instructions when compiling kernel code.
>
> Both instructions were tested and confirmed using gdb. We also already
> have a BPF selftest (raw_tp_test_run) that validates correctness of
> bpf_get_smp_processor_id(), while running target BPF program on each
> online CPU.
>
> Here's a disassembly of bpf_get_smp_processor_id() helper:
>
> $ gdb -batch -ex 'file vmlinux' -ex 'set disassembly-flavor intel' -ex 'd=
isassemble/r bpf_get_smp_processor_id'
> Dump of assembler code for function bpf_get_smp_processor_id:
>    0xffffffff810fa890 <+0>:     0f 1f 44 00 00          nop    DWORD PTR =
[rax+rax*1+0x0]
>    0xffffffff810fa895 <+5>:     65 8b 05 70 62 f3 7e    mov    eax,DWORD =
PTR gs:[rip+0x7ef36270]        # 0x30b0c <pcpu_hot+12>
>    0xffffffff810fa89c <+12>:    48 98                   cdqe
>    0xffffffff810fa89e <+14>:    c3                      ret
> End of assembler dump.
>
> And here's a GDB disassembly dump of a piece of BPF program calling
> bpf_get_smp_processor_id().
>
>   $ sudo cat /proc/kallsyms | rg 'pcpu_hot|bpf_prog_2b455b4f8a8d48c5_kexi=
t'
>   000000000002d840 A pcpu_hot
>   ffffffffa000f8a8 t bpf_prog_2b455b4f8a8d48c5_kexit      [bpf]
>
> Then attaching GDB to the running kernel in QEMU and breaking inside BPF
> program:
>
> (gdb) b *0xffffffffa000f8e2
> Breakpoint 1 at 0xffffffffa000f8e2
>
> When RIP-relative instruction is used:
>
>   0xffffffffa000f8e2      mov    %gs:0x6001df63(%rip),%eax        # 0x2d8=
4c <pcpu_hot+12>
>   0xffffffffa000f8e9      cltq
>
> You can see that final address is resolved to <pcpu_hot+12> as expected.
>
> When absolute addressing is used:
>
>   0xffffffffa000f8e2      movabs %gs:0x2d84c,%eax
>   0xffffffffa000f8ed      cltq
>
> And here 0x2d84c matches pcpu_hot address from kallsyms (0x2d840),
> plus 12 (0xc) bytes offset of cpu_number field.
>
> This inlining eliminates entire function call for this (rather trivial in=
 terms
> of instructions executed) helper, saving a bit of performance, but foremo=
st
> saving LBR records (1 for PERF_SAMPLE_BRANCH_ANY_RETURN mode, and 2 for
> PERF_SAMPLE_BRANCH_ANY), which is what motivated this work in the first
> place.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 4900b1ee019f..5b7fdc24b5b8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -457,6 +457,9 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, bool ebpf_from_cbpf,
>         *pprog =3D prog;
>  }
>
> +/* reference to bpf_get_smp_processor_id() helper implementation to dete=
ct it for inlining */
> +extern u64 bpf_get_smp_processor_id(u64, u64, u64, u64, u64);
> +
>  static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
>  {
>         u8 *prog =3D *pprog;
> @@ -467,7 +470,28 @@ static int emit_patch(u8 **pprog, void *func, void *=
ip, u8 opcode)
>                 pr_err("Target call %p is out of range\n", func);
>                 return -ERANGE;
>         }
> -       EMIT1_off32(opcode, offset);
> +
> +       /* inline bpf_get_smp_processor_id() to avoid calls */
> +       if (opcode =3D=3D 0xE8 && func =3D=3D &bpf_get_smp_processor_id) =
{
> +               /* 7 to account for the mov instruction itself,
> +                * as rip value *after* mov instruction is used
> +                */
> +               offset =3D (void *)&pcpu_hot.cpu_number - ip - 7;
> +               if (is_simm32(offset)) {
> +                       /* mov eax,DWORD PTR gs:[rip+<offset>] ; <pcpu_ho=
t+12> */
> +                       EMIT3_off32(0x65, 0x8b, 0x05, (u32)offset);
> +               } else {
> +                       /* mov eax,DWORD PTR gs:<offset> ; <pcpu_hot+12> =
*/
> +                       offset =3D (s64)(void *)&pcpu_hot.cpu_number;
> +                       EMIT2(0x65, 0xa1);
> +                       EMIT((u32)offset, 4);
> +                       EMIT((u64)offset >> 32, 4);
> +               }
> +               EMIT2(0x48, 0x98); /* cdqe, zero-extend eax to rax */

Please introduce new pseudo insn that can access per-cpu vars
in a generic way instead of hacking a specific case.
Then we can use it in get_lookup in percpu array and hash maps
improving their performance and in lots of other places.

pw-bot: cr
