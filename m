Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A957305
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194774; cv=none; b=fzxxQSriqcbcPaFP2kGD6SrHbvcpIhPTCm9QFW2gPUnIfRt9/4lNMli9SvR+p2OvH21LHMe38cmJaRPvmDek8NYTr1/kVvOA/wDlIrWiv46LDGiSsvwfrolVUJaPufVQ99GltJ5aakzrvwZr3/iTOQJjJW4ft4fu1+ZWSDy0quU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194774; c=relaxed/simple;
	bh=VBLCYZ3CnM5u6wqvMXmt8+ihpXXFRX3vfTkQJrFFBYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQAciG5mL5C9sg8atzwPWrlgY/5dESWJvnUWvYLSlPCJUDmsapEkWSwdudjkeNoike8Q0OH1tmYEDD27okDVtyS6fcVr7F1S+TIj5xeVvT2GWNJU0iMniPJHklyZppC9Q/L1UppoKDOq2eaKDYrUSYjgNs5hQNfOLeeCtCGRWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkUp3Ycv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkUp3Ycv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c23f53eabso622110a91.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710194771; x=1710799571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Qcp5QyK9rbto/1BCfSkUkVWLd78NqgSgQTAk4vuvt8=;
        b=EkUp3YcvSivGr1pOOKo40hb+BlH8BgfrIhFrVsdZ78RgA39G/gDGchCbHX3lswOBLJ
         GF5Zobuf2qVrBVx1UO5yRN7JS4ohrPlvgYlZdiskT+wre60ZuYsdvBW7eMVIjfd4VxGN
         TGqy9WNQfp/6sr7oJZW+JOankgOLB2oSe5GyR1aVGAiAh2oQoKot0DNTB2bMtsYR8MKv
         aqoa+NKYzKjBdUCdbrYycZGpby9bHynOAo7Zurls9J+c4v0eNmKRtvmOwZ479E1mo7ZX
         +ZPGbQWYE5q0HWPdRsql9dn3MWFq2qg1anShdNeh/jREiiqKCV/Zzgop1a1O1ZUaf4/o
         F3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710194771; x=1710799571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Qcp5QyK9rbto/1BCfSkUkVWLd78NqgSgQTAk4vuvt8=;
        b=IhYVOOPt7KsZiU0fqV89/RvufOntP2cyPrkOdOLbKffdUvkLLElQpyhKAhU6pxMWcg
         MMbChQ0m9kJDpdGQg5Wd3P4Up1ia16ZF5RWIu+CNeCvzC4BngN3zHebYCpLhtJo6Oyaq
         pHij9bMA3vijwN3h+GlEKTjc5GBf8JLeSzHuJoaZYc8id3Ekg0b7vLZOTnEUAPm3UIGZ
         cbE8dl4Rre+g/JFDpWvSbZd3ZH/8mQ3f81D+ovsNhtJt/AkcKHM0F0fv9KBYRnuXsVjY
         8MPBWKYCnom9nVKMr6VFtdPCdJNdXXzX+yxwprYwhTJcvEplrrRWsKPWBeVDnaCaelpp
         NZwA==
X-Gm-Message-State: AOJu0Ywt08PSUQ3mtf3RBTCEz+Zi0sNlqvVxFNo8pWpY1JwiRc2b/Xx9
	VnBmITgj00cZ5EmlBHjMwXS72ZCJ2LUDzU/GgzawQSysonKgFUNzrxfMTl2wOJ5ojvkwttXAyBf
	Q5lQcUIJeedUgZ68pKKIPL3n9Pjo=
X-Google-Smtp-Source: AGHT+IH+SHPX8ZZSQ4OueyyrIuxeMyckbMQMb/h2ENmEGjEmXftSlj3TXybp8Dez/vsZoDzP4UUPaAQD2mCz2lWRnWc=
X-Received: by 2002:a17:90a:8b05:b0:29b:dc3c:a28e with SMTP id
 y5-20020a17090a8b0500b0029bdc3ca28emr4153148pjn.41.1710194770819; Mon, 11 Mar
 2024 15:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com> <20240308010812.89848-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20240308010812.89848-4-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 15:05:59 -0700
Message-ID: <CAEf4BzYuou1A-3_1Q5qoecLsE42880MYvDCv6shOUVYZKHQb_Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/14] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW] instructi=
ons.
> They are similar to PROBE_MEM instructions with the following differences=
:
> - PROBE_MEM has to check that the address is in the kernel range with
>   src_reg + insn->off >=3D TASK_SIZE_MAX + PAGE_SIZE check
> - PROBE_MEM doesn't support store
> - PROBE_MEM32 relies on the verifier to clear upper 32-bit in the registe=
r
> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in %r12 =
in the prologue)
>   Due to bpf_arena constructions such %r12 + %reg + off16 access is guara=
nteed
>   to be within arena virtual range, so no address check at run-time.
> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop.
>   When LDX faults the destination register is zeroed.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  arch/x86/net/bpf_jit_comp.c | 191 +++++++++++++++++++++++++++++++++++-
>  include/linux/bpf.h         |   1 +
>  include/linux/filter.h      |   3 +
>  3 files changed, 194 insertions(+), 1 deletion(-)
>

[...]

> +static u8 add_3mod(u8 byte, u32 r1, u32 r2, u32 index)
> +{
> +       if (is_ereg(r1))
> +               byte |=3D 1;
> +       if (is_ereg(index))
> +               byte |=3D 2;
> +       if (is_ereg(r2))
> +               byte |=3D 4;
> +       return byte;
> +}
> +
>  /* Encode 'dst_reg' register into x86-64 opcode 'byte' */
>  static u8 add_1reg(u8 byte, u32 dst_reg)
>  {
> @@ -645,6 +659,8 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
>                 pop_r12(&prog);
>         } else {
>                 pop_callee_regs(&prog, callee_regs_used);
> +               if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))

ah, I guess this is where NULL is expected?.. But isn't `if
(bpf_prog->aux->arena)` equivalent and more straightforward check?

> +                       pop_r12(&prog);
>         }
>
>         EMIT1(0x58);                              /* pop rax */
> @@ -704,6 +720,8 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
>                 pop_r12(&prog);
>         } else {
>                 pop_callee_regs(&prog, callee_regs_used);
> +               if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
> +                       pop_r12(&prog);
>         }
>
>         EMIT1(0x58);                                  /* pop rax */

[...]

> @@ -1147,11 +1276,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>         bool tail_call_seen =3D false;
>         bool seen_exit =3D false;
>         u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
> +       u64 arena_vm_start;
>         int i, excnt =3D 0;
>         int ilen, proglen =3D 0;
>         u8 *prog =3D temp;
>         int err;
>
> +       arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->are=
na);

and I'm guessing here you didn't want that check... I'd probably go
with explicit pointer checks, but ok, it's fine

> +
>         detect_reg_usage(insn, insn_cnt, callee_regs_used,
>                          &tail_call_seen);
>

[...]
