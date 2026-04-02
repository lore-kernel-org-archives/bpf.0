Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229A3B4EBB
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173893; cv=pass; b=lac+/q+cy8EnAOfilVxdC0SobTRwLlQIL/IXVt7syngnZ4uCPaJbcC1gsoF6D772HA7m921Fdb6W44XIXpwAJ6VaSKy8TE2E2L1ilAKZuC+fmW1i/CwRlfYwexj9scqCpjKvB0yGDuQUvo+Dh6XyiVuIdvv6jO9uuyrEpr2FhQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173893; c=relaxed/simple;
	bh=86SZ5KLGm2lvhJPPSpNGoMDzweIe7AeL9IXw3wwrwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAoVrqX6iAuix0Rhj3Lb9vr4VPl8isfiTPd43l4sjg0IpwuIEIQaDTHvsY2PNmz8yxTNi3Oy9bXOkNJr6AzKZZikLx/3EZb34Cskvnmq9I4bqBj4P+msTDf5KGHhkynru6tISTSKW63OtKrs2fkctNG434LcRZgnqT/6BIfrD1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0PwOUI9; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0PwOUI9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-487012ce896so7597635e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 16:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775173890; cv=none;
        d=google.com; s=arc-20240605;
        b=DG2+m4uUlpHJTTflBwu80ncXPe2Ror4KExppMXRR9ZR6VpdmxYxcjxrNXIga55q+4/
         lFqmnileS+IlX8MiSqL/z4T9v6TnTLbXzxbolF4gLc/+aEG/3XLYTksOeRrFqxRg650a
         I4O4E6eryAUpeogonCkWZe1ioIBDAdD2BhpFP3flGBxXxcquo+7rP4kSC+LJDfEoAFyN
         5pA5ty1BRoa/38MYlP04+3GoucvCyt2c12i+/eQqPdp/qTWeGA44vvhc/0Fycx14XCFC
         /lsEJPKHqMdWHiwVO2s52ZuW6dEnqOA0SNnei3fwAE6lK86Xg47jz6pGhRslZmWilnAY
         fAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jTTGzBsXtLsRYJUzM7/8tWYbksjwyn/uceSfv/H9opQ=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=lZ1KF/B6gufy8GcXis1b3SUcgH8DQ9F6qsSlWk0Uce/lvICkB/y+0sEvS/5LJtuDx9
         m+Op8ub/r1ZUvodBhUWhH1q76x9HLBd4tTAW6SX4trCnO8R/ZnUOrm45FWifusSKWB0G
         nbt4pmjLAom073yxN39GhW6Y7+lB0iVuLOuObbxknIFqpGj+6zjtcLUKyT4kddgTAcU6
         zIefndY38fUJnFdRqG/WGmaiRPiATMeNPWVWy3Y1wfY8CKvGPmLqJbJ7dFShjCOQ4Bd4
         m3NT4Tx6ogWy1iHDuaBcyzxhq7BDCMEd4y+8hf8yS5kylB1TsmbZCKBM49dspwedL8n0
         1Dzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775173890; x=1775778690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTTGzBsXtLsRYJUzM7/8tWYbksjwyn/uceSfv/H9opQ=;
        b=p0PwOUI96xxCqe4U5y8X6t8I2zYuEnk+CYj8Sm7KHsT/6vZ0NiT5HYh3m4KolUZgur
         GJLJKn2Of7JmS2wk2tUeRWGa+IJwxAKZPDpqqryDuax18esZpuvVJyx78g3B/L4hhZP8
         AnYfvNkkZ+Mfy6pFufFts3NIVeWSSkA5Bi5/fof30RN2c4LcINYTti82TaiiXisC9Nin
         WLGxCRvn2vajdLcmtNiYLhPthQNdA5etSt5gsanEmAVho9W/KHj+SeI3usatyErPzO1x
         h/TFJLLgr6JKeC/p9hEBEpqPWBJ5qSlmDmANc03vdGZFqc3uk8wJWV6baqDLr28lewYG
         9D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173890; x=1775778690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jTTGzBsXtLsRYJUzM7/8tWYbksjwyn/uceSfv/H9opQ=;
        b=oIs8fwS/C+yLeulmvX8CyS8zWSLtUoCoTIxnxpURnaiEkMIbu7v/lcmmqeUPBnGk/4
         yQ6EFGeZF+FVKZVoFAVpUM9DyRIooX7PlOfMT+nzjCeZP5cn+SR+vskxNJDnMhZSdlbe
         kDx90PcdHLTwwxBV57m0Gv2tsccFSCGQCT2ILfmS4k6FGFBvL13Fa2bBEgGUUNPe5u3l
         nXN7vJQ1AvKkDxs6FoqYKspdwaTfTzUAR6WeCE0TJuHUChQkqAAzYwJvThULwFQOb4A7
         SsOWpYiUVZOSJWO1z9X16QeoYAMr7bEYgZcI6jSP6ZT8/uf2Yy8En6jBlr7bdCn8xDRr
         sEtA==
X-Gm-Message-State: AOJu0YxlizVuw0ukEW3vWKUoU2rwQFBDv8jm6eqBvYjJaYEugeadj7EC
	Hq4VW7AMuU+C35HzTPg9tV8SI/faoN33+jo2PDzIqReRDOhXHaBjBrEn8wlW9AE45ZBI+QW0bzi
	oetBhn/P8ih9GSr4mdvRkQgxNCoJZu7v/Pw==
X-Gm-Gg: ATEYQzwvekcVUTnKnh5MdrPkeBOF5XMKNXkAXTYFt6U3/zkso46U/CIRw/fcFh1fcDS
	HBVGmVsyOEvjduilwS4jiclKMoN/CumCKcAAIiARG/rlAK6jqlN0GqUO7s+eKEQdpn/qDXZCkFM
	YJ4to2JaDCsQSSRTy/4ZHZ80Mn/u++DaTZUMdLQfpAyCZtpG5vGC2odwZF3/0FLbJ7qh4WOQa/m
	E2FxrXgJY9oEZCzICEQ+NigAbGO2KydCmN0p/RPFU/QvO6/icS9FN56mrHwJ308N+xG7VGje+/I
	akiGlBNzZU/cNHsNXlH18w6fClid1RIB9EGBPf5FK6/TE64C2TsVijUtCYQ+ZU26zxCitM48vdK
	mUo07gJqswge1xxVSCr9l11vLoA==
X-Received: by 2002:a05:600c:3b1b:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-488996a3560mr13182755e9.4.1775173890108; Thu, 02 Apr 2026
 16:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012803.3920450-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012803.3920450-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 16:51:18 -0700
X-Gm-Features: AQROBzCZShj2VEMynEMFuYjtNhTu9bIZKXXYN4gM7aFZGjyAXyWdasPDFWDa5n8
Message-ID: <CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7CDJ-7aKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf,x86: Implement JIT support for stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Add x86_64 JIT support for BPF functions and kfuncs with more than
> 5 arguments. The extra arguments are passed through a stack area
> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
> which the JIT translates to RBP-relative accesses in native code.
>
> There are two possible approaches to allocate the stack arg area:
>
>   Option 1: Allocate a single combined region (incoming + max_outgoing)
>     below the program stack in the function prologue. All r12-relative
>     accesses become [rbp - prog_stack_depth - offset] where the 'offset'
>     is the offset value in (incoming + max_outgoing) region. This is
>     simple because the area is always at a fixed offset from RBP.
>     The tradeoff is slightly higher stack usage when multiple callees
>     have different stack arg counts =E2=80=94 the area is sized to the ma=
ximum.
>
>   Option 2: Allocate each outgoing area individually at the call
>     site, sized exactly to the callee's needs. This minimizes
>     stack usage but significantly complicates the JIT: each call
>     site must dynamically adjust RSP, and addresses of stack args
>     would shift depending on context, making the offset
>     calculations harder.
>
> This patch uses Option 1 for simplicity.
>
> The native x86_64 stack layout for a function with incoming and
> outgoing stack args:
>
>   high address
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>   =E2=94=82 incoming stack arg N    =E2=94=82  [rbp + 16 + (N - 1) * 8]  =
(pushed by caller)
>   =E2=94=82 ...                     =E2=94=82
>   =E2=94=82 incoming stack arg 1    =E2=94=82  [rbp + 16]
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 return address          =E2=94=82  [rbp + 8]
>   =E2=94=82 saved rbp               =E2=94=82  [rbp]
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 callee-saved regs       =E2=94=82
>   =E2=94=82 BPF program stack       =E2=94=82  (stack_depth bytes)
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 incoming stack arg 1    =E2=94=82  [rbp - prog_stack_depth - =
8]
>   =E2=94=82 ...   (copied from      =E2=94=82   (copied in prologue)
>   =E2=94=82        caller's push)   =E2=94=82
>   =E2=94=82 incoming stack arg N    =E2=94=82  [rbp - prog_stack_depth - =
N * 8]
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 outgoing stack arg 1    =E2=94=82  (written via r12-relative =
STX/ST,
>   =E2=94=82 ...                     =E2=94=82   JIT translates to RBP-rel=
ative)
>   =E2=94=82 outgoing stack arg M    =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
>     ...                        Other stack usage
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>   =E2=94=82 incoming stack arg M    =E2=94=82 (copy from outgoing stack a=
rg to
>   =E2=94=82 ...                     =E2=94=82  incoming stack arg)
>   =E2=94=82 incoming stack arg 1    =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 return address          =E2=94=82
>   =E2=94=82 saved rbp               =E2=94=82
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 ...                     =E2=94=82
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98
>   low address
>
> In prologue, the caller's incoming stack arguments are copied to callee's
> incoming stack arguments, which will be fetched by later load insns.
> The outgoing stack arguments are written by JIT RBP-relative STX or ST.
>
> For each bpf-to-bpf call, push outgoing stack args onto the native
> stack before CALL, pop them after return. So the same 'outgoing stack arg=
'
> area is used by all bpf-to-bpf functions.
>
> For kfunc calls, push stack args (arg 7+) onto the native stack
> and load arg 6 into R9 per the x86_64 calling convention,
> then clean up RSP after return.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 145 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 32864dbc2c4e..807493f109e5 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -367,6 +367,27 @@ static void push_callee_regs(u8 **pprog, bool *calle=
e_regs_used)
>         *pprog =3D prog;
>  }
>
> +static int push_stack_args(u8 **pprog, s32 base_off, int from, int to)
> +{
> +       u8 *prog =3D *pprog;
> +       int j, off, cnt =3D 0;
> +
> +       for (j =3D from; j >=3D to; j--) {
> +               off =3D base_off - j * 8;
> +
> +               /* push qword [rbp + off] */
> +               if (is_imm8(off)) {
> +                       EMIT3(0xFF, 0x75, off);
> +                       cnt +=3D 3;
> +               } else {
> +                       EMIT2_off32(0xFF, 0xB5, off);
> +                       cnt +=3D 6;
> +               }
> +       }
> +       *pprog =3D prog;
> +       return cnt;
> +}
> +
>  static void pop_r12(u8 **pprog)
>  {
>         u8 *prog =3D *pprog;
> @@ -1664,19 +1685,35 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>         int i, excnt =3D 0;
>         int ilen, proglen =3D 0;
>         u8 *prog =3D temp;
> -       u32 stack_depth;
> +       u16 stack_arg_depth, incoming_stack_arg_depth;
> +       u32 prog_stack_depth, stack_depth;
> +       bool has_stack_args;
>         int err;
>
>         stack_depth =3D bpf_prog->aux->stack_depth;
> +       stack_arg_depth =3D bpf_prog->aux->stack_arg_depth;
> +       incoming_stack_arg_depth =3D bpf_prog->aux->incoming_stack_arg_de=
pth;
>         priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
>         if (priv_stack_ptr) {
>                 priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ +=
 round_up(stack_depth, 8);
>                 stack_depth =3D 0;
>         }
>
> +       /*
> +        * Save program stack depth before adding stack arg space.
> +        * Each function allocates its own stack arg space
> +        * (incoming + outgoing) below its BPF stack.
> +        * Stack args are accessed via RBP-based addressing.
> +        */
> +       prog_stack_depth =3D round_up(stack_depth, 8);
> +       if (stack_arg_depth)
> +               stack_depth +=3D stack_arg_depth;
> +       has_stack_args =3D stack_arg_depth > 0;
> +
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->are=
na);
>         user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->aren=
a);
>
> +
>         detect_reg_usage(insn, insn_cnt, callee_regs_used);
>
>         emit_prologue(&prog, image, stack_depth,
> @@ -1704,6 +1741,38 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                 emit_mov_imm64(&prog, X86_REG_R12,
>                                arena_vm_start >> 32, (u32) arena_vm_start=
);
>
> +       if (incoming_stack_arg_depth && bpf_is_subprog(bpf_prog)) {
> +               int n =3D incoming_stack_arg_depth / 8;
> +
> +               /*
> +                * Caller pushed stack args before CALL, so after prologu=
e
> +                * (CALL saves ret addr, then PUSH saves old RBP) they si=
t
> +                * above RBP:
> +                *
> +                *   [rbp + 16 + (n - 1) * 8]  stack_arg n
> +                *   ...
> +                *   [rbp + 24]                stack_arg 2
> +                *   [rbp + 16]                stack_arg 1
> +                *   [rbp +  8]                return address
> +                *   [rbp +  0]                saved rbp
> +                *
> +                * Copy each into callee's own region below the program s=
tack:
> +                *   [rbp - prog_stack_depth - i * 8]
> +                */
> +               for (i =3D 0; i < n; i++) {
> +                       s32 src =3D 16 + i * 8;
> +                       s32 dst =3D -prog_stack_depth - (i + 1) * 8;
> +
> +                       /* mov rax, [rbp + src] */
> +                       EMIT4(0x48, 0x8B, 0x45, src);
> +                       /* mov [rbp + dst], rax */
> +                       if (is_imm8(dst))
> +                               EMIT4(0x48, 0x89, 0x45, dst);
> +                       else
> +                               EMIT3_off32(0x48, 0x89, 0x85, dst);
> +               }

This is really suboptimal.
bpf calling convention for 6+ args needs to match x86.
With an exception of 6th arg.
All bpf insn need to remain as-is when calling another bpf prog
or kfunc. There should be no additional moves.
JIT should only special case 6th arg and convert bpf's STX [r12-N], src_reg
into 'mov r9, src_reg', since r9 is used to pass 6th argument on x86.
The rest of STX needs to be jitted pretty much as-is
with a twist that bpf's r12 becomes %rbp on x86.
And similar things in the callee.
Instead of LDX [r12+N] it will be a 'mov dst_reg, r9' where r9 is x86's r9.
Other LDX from [r12+M] will remain as-is, but r12->%rbp.
On arm64 more of the STX/LDX insns become native 'mov'-s
because arm64 has more registers for arguments.

pw-bot: cr
