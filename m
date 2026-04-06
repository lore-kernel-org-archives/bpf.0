Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155D280309
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775451287; cv=pass; b=cmMIbp82yY6GuOOYASdxgmgQgWB2Miv3+oYUZoe02BTIcjO0bz+vkYzu1JKHbrbkb3MndPKYwvvaJj28nivYIFGjpgPclWPP2oe4JuH4bCqjGciMw1prYSCNvbDZBpVcYfdGLe1zOVRyZc7QpnRIR+0+pDN1ppxN0uqZQm0QBMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775451287; c=relaxed/simple;
	bh=Xt0OXcdnJaKViosuBSvt2Nv7cs6IdO3XL/brHAl+9gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5nIiYmYzdaT/pfPBg/LxVAwuqZzbdvK969nn6zZNGgAqJAwBZnvG6O2iftCfVrbhc1AmXWLGbamd9lIXTosem9CakY+vfI1cX/x5FvmGv/y/FN117NEypcvL3znsfIT+BHJDoNNwPYNJo5NMzNyvrtsfniINpENzWXXyujuenw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMTkCgjB; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMTkCgjB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso50759445e9.1
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 21:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775451283; cv=none;
        d=google.com; s=arc-20240605;
        b=E7MOZw2YvT8VBrHaSOiTM3tEid9mgCejL/qcM6JziplOtdX6m+ppDGl3b9/MRp7Mgh
         fzel1hkZYM5+/ZsydfK7fE+euRUoPOb9IzHFxCXR2cqYptTjtLNl+BYwctkgl4kWSoUy
         xbnE3d+BLnQR1flxgkLec+toVMQg0yysS0Eos/PZK4qFzrOgugTLerGLeGAdGnRnQ8lH
         yPWkoxJI0X4RQIwrBNeO9LJNOprPCfbwPqRBE0zpcK0HUdJRUrNxXJuSDF8uqtgF4A//
         qA9Zp82ZOsQv35dMPVlw8hmnvWG69Qu81xJd98z1RXCILiVnEg9g+BY4WWCTAtThIOQS
         aEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ort9iZB8cZt5BJvdzMj2wC3QXyjpdV1Z8nihjQbBgiY=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=bGO/TtHiqgFTYnc4XfNxrKrH/0IF9G9t3PtAoHFcnNy3G4rbSgoALADeOGHFjB6b8H
         OG3nLqoqpr8VoQ0ykwBSgZdZlcA+H5Zwo3EeDnK9WsM2+pjO4t0YVX7IlL7iv1ZhUwd1
         LEmG8u+MWt9kxj3vZFezjhrPvgtG5luP2IoyvdyCNHuWUPOoA2K7s/PiyuYrMnm57PYS
         Bwxmz8Rnj4cTV0ou+FXElRd/nY3QmdxyH5SjFdvlDrnY8o6+1+Dw/dHcctSCxi7Macjk
         /kLGdqSyQBghcEsu9F76R/OJ80VzCS4l/ZUz7y6a79diUX4v9W6+heomKboTMCs3HSbb
         OpMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775451283; x=1776056083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ort9iZB8cZt5BJvdzMj2wC3QXyjpdV1Z8nihjQbBgiY=;
        b=WMTkCgjBUxYAdjys9LqyYatKkbf1W9Xy/3aU2GuTWYudiVw0onjilwRCrDfKg6Lc4U
         cSQeixrRcvg7R8a8ec/rh18XfalH4bkG4/AYJVLFXVM1h/DlleyUsztiYDFnTdyI1dfD
         F72/DVmGS3yWnUpLSxUw4bKt2ZisTDMkwyXau+tfeWiQMuxtwZTbrlX/lnL2HjXu8elJ
         jvQIwLmg7+RPoPG+37YeICnYgM9D9k7WFy1Q7UyVoqQZZBEPPUGbOeHTxYRQO2kvBMtN
         oyIiq11AuETNyHssG10YgAB/vU64nd5p2f34uyQCPk7Bq67JI0UB29zqERHw5SgrZdEy
         M4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775451283; x=1776056083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ort9iZB8cZt5BJvdzMj2wC3QXyjpdV1Z8nihjQbBgiY=;
        b=fVCIjdJ1j0NutKI0uko7Iu/S6YCW81wQ+DlA9BYrQXyRPcgLmLzcqP+6sojAePdTU6
         jxncaX01iDYvMZLusxYHCnOT+Xk3y/IPJJWgWGM8qywbCpD6JwVh0uj3/t1j8F7y2QKe
         2XEUpL+YqqVi75rrfShJejF5Sw2440Y7b8yQFCU7DFmMqSa1rLRw8OK2DAiPgJPEATxs
         R9k/Req+iPWMQ7nnzAs9NPGLhZLWC2PG21raaH/amwiEx3dn6r2r3cWj5lVTsvDEIJKa
         K01TZfNaXYyAzG0svhTO9zpnJFqACPFHDK5aT4K3qnOrnKndeY+Op/XLZxmisNRRTmAl
         vhLA==
X-Gm-Message-State: AOJu0YyCEONF2QWWFzUtgqGKiPMu6X8D/1yiypjs4ZvMwP7hIM+UeZ7S
	ZhgRS/aHkZ3G56DuSGVmsAGdTyeNcgmcM1BOLAyC5C+cB7HPnlRanlvAKfqs3u6skcZ9TibmDZx
	eDkZoTL8Wd/edZNyPHizKhM4RogOHQZ4=
X-Gm-Gg: AeBDievwgKyq7pAFSVvqTjvzMJlW1+dPXhc7iMLKUk2zSizDA242CkgwvDdyvTL4LjR
	7P3SpL24NoGpcNRI95CeuuPBEaoSl+u1wp1NyPHOa6tklGRywfJdpHqP4rs9n0622S/kne8huSm
	Z3xBpL7+oPobCFE9PBpPlA3wr07EROblGogB6VQNyJOhmPm/AaY2Wfsj49N0If8pkrBX7tAeHCn
	ZeUfXve25hNRkRMufBFAqqE9a82sdbyvAv7buhm55l+2PJWC6Qnx1icBvegT9VfX2r0dgWDJcjg
	oWUTb0CJgMAz/vNC9fUbGVamCJA9VGplgEf/dDbDiq+WcB02CXAJSWoeYzkbFbmiBJoIL+VF91u
	Gf7UwFjNaO7o9i18Pke/L1nYi5w==
X-Received: by 2002:a05:600c:6305:b0:488:80b6:873a with SMTP id
 5b1f17b1804b1-488997a4679mr158281905e9.21.1775451282792; Sun, 05 Apr 2026
 21:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405172505.1329392-1-yonghong.song@linux.dev>
 <20260405172626.1337674-1-yonghong.song@linux.dev> <CAADnVQLyoAS39gZvOzOT0qEAj4bzcZLVuupTAhyQSv6d5aQGWA@mail.gmail.com>
 <0903790e-a63c-4b62-b751-ce08ffcf8f57@linux.dev>
In-Reply-To: <0903790e-a63c-4b62-b751-ce08ffcf8f57@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 21:54:30 -0700
X-Gm-Features: AQROBzBNCZyZpS2XQ6FR7ph2iA_DFmq9-0XpeaAFRPnPTh-JARvNY_ie6V4XEMQ
Message-ID: <CAADnVQKyoAWQ8z6gyeBiBqor6rNrL+F_C3VY_1XMDqaQ7g81GQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 9:14=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 4/5/26 1:36 PM, Alexei Starovoitov wrote:
> > On Sun, Apr 5, 2026 at 10:26=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> Add x86_64 JIT support for BPF functions and kfuncs with more than
> >> 5 arguments. The extra arguments are passed through a stack area
> >> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
> >> which the JIT translates to RBP-relative accesses in native code.
> >>
> >> The JIT follows the native x86_64 calling convention for stack
> >> argument placement. Incoming stack args from the caller sit above
> >> the callee's frame pointer at [rbp + 16], [rbp + 24], etc., exactly
> >> where x86_64 expects them after CALL + PUSH RBP. Only the outgoing
> >> stack arg area is allocated below the program stack in the prologue.
> >>
> >> The native x86_64 stack layout for a function with incoming and
> >> outgoing stack args:
> >>
> >>    high address
> >>    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90
> >>    =E2=94=82 incoming stack arg N    =E2=94=82  [rbp + 16 + (N-1)*8]  =
(from caller)
> >>    =E2=94=82 ...                     =E2=94=82
> >>    =E2=94=82 incoming stack arg 1    =E2=94=82  [rbp + 16]
> >>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=A4
> >>    =E2=94=82 return address          =E2=94=82  [rbp + 8]
> >>    =E2=94=82 saved rbp               =E2=94=82  [rbp]
> >>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=A4
> >>    =E2=94=82 BPF program stack       =E2=94=82  (stack_depth bytes)
> >>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=A4
> >>    =E2=94=82 outgoing stack arg 1    =E2=94=82  [rbp - prog_stack_dept=
h - outgoing_depth]
> >>    =E2=94=82 ...                     =E2=94=82   (written via r12-rela=
tive STX/ST)
> >>    =E2=94=82 outgoing stack arg M    =E2=94=82  [rbp - prog_stack_dept=
h - 8]
> >>    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=A4
> >>    =E2=94=82 callee-saved regs ...   =E2=94=82  (pushed after sub rsp)
> >>    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98  rsp
> >>    low address
> >>
> >> BPF r12-relative offsets are translated to native RBP-relative
> >> offsets with two formulas:
> >>    - Incoming args (load: -off <=3D incoming_depth):
> >>        native_off =3D 8 - bpf_off  =E2=86=92  [rbp + 16 + ...]
> >>    - Outgoing args (store: -off > incoming_depth):
> >>        native_off =3D -(bpf_prog_stack + stack_arg_depth + 8) - bpf_of=
f
> >>
> >> Since callee-saved registers are pushed below the outgoing area,
> >> outgoing args are not at [rsp] at call time. Therefore, for both BPF-t=
o-BPF
> >> calls and kfunc calls, outgoing args are explicitly pushed from the
> >> outgoing area onto the stack before CALL and rsp is restored after ret=
urn.
> >>
> >> For kfunc calls specifically, arg 6 is loaded into R9 and args 7+
> >> are pushed onto the native stack, per the x86_64 calling convention.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   arch/x86/net/bpf_jit_comp.c | 135 ++++++++++++++++++++++++++++++++++=
--
> >>   1 file changed, 129 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 32864dbc2c4e..206f342a0ca0 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -390,6 +390,28 @@ static void pop_callee_regs(u8 **pprog, bool *cal=
lee_regs_used)
> >>          *pprog =3D prog;
> >>   }
> >>
> >> +/* Push stack args from [rbp + outgoing_base + (k - 1) * 8] in revers=
e order. */
> >> +static int push_stack_args(u8 **pprog, s32 outgoing_base, int from, i=
nt to)
> >> +{
> >> +       u8 *prog =3D *pprog;
> >> +       int k, bytes =3D 0;
> >> +       s32 off;
> >> +
> >> +       for (k =3D from; k >=3D to; k--) {
> >> +               off =3D outgoing_base + (k - 1) * 8;
> >> +               /* push qword [rbp + off] */
> >> +               if (is_imm8(off)) {
> >> +                       EMIT3(0xFF, 0x75, off);
> >> +                       bytes +=3D 3;
> >> +               } else {
> >> +                       EMIT2_off32(0xFF, 0xB5, off);
> >> +                       bytes +=3D 6;
> >> +               }
> >> +       }
> > This is not any better than v1.
> > It is still a copy.
> > As I said earlier:
> > https://lore.kernel.org/bpf/CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7=
CDJ-7aKQ@mail.gmail.com/
> > It has to be zero overhead. Copy pasting:
> >
> > "
> > bpf calling convention for 6+ args needs to match x86.
> > With an exception of 6th arg.
> > All bpf insn need to remain as-is when calling another bpf prog
> > or kfunc. There should be no additional moves.
> > JIT should only special case 6th arg and convert bpf's STX [r12-N], src=
_reg
> > into 'mov r9, src_reg', since r9 is used to pass 6th argument on x86.
> > The rest of STX needs to be jitted pretty much as-is
> > with a twist that bpf's r12 becomes %rbp on x86.
> > And similar things in the callee.
> > Instead of LDX [r12+N] it will be a 'mov dst_reg, r9' where r9 is x86's=
 r9.
> > Other LDX from [r12+M] will remain as-is, but r12->%rbp.
> > On arm64 more of the STX/LDX insns become native 'mov'-s
> > because arm64 has more registers for arguments.
> > "
> >
> > Remapping in earlier patches is unnecessary.
> > These STX [r12-N], src_reg emitted by LLVM will be JITed as-is into
> > store of src_reg into %rbp-M slot.
> > Only shift by 8 bytes is necessary for N to become M.
> > where STX of 6th argument becomes 'mov' from one register to x86's r9.
>
> Okay, I will do the following jit stack layout:
>
>    incoming stack arg N -> 1
>    return adderss
>    saved rbp
>    BPF program stack
>    tail call cnt <=3D=3D if tail call reachable
>    callee-saved regs
>    r9 <=3D=3D if priv_frame_ptr is not null
>    outgoing stack arg M -> 1
>    call ...
>    undo stack of outgoing stack arg + r9

It looks like you're trying to preserve r9 as an auxiliary register.
If it's in the way, rewrite JIT handling. The size of the diff
doesn't matter.
r9 should be the 6th argument.
