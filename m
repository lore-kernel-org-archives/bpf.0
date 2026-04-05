Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141B2C032E
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775421402; cv=pass; b=AipzILMPumLlNhGBqd0zGqiEfBfguEZl08hufrs3uQ97yx365T3dC1WhxdtuLvBeKeekHgBSpq4fBRr6CdlNieeksO0UrILguSODYwzwENbW2W261hitmbc7i1Zfu7V0uJ0t5V/S6cnxYcMkTDVC+fmuOUhDg2VnkcJsh+3A7Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775421402; c=relaxed/simple;
	bh=zMplxoeb9UtmMsFH6mUn1SlkC1CEpOAm0CAWJLWPXoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+M1A9v9Tgy7thI12rCxYUtojhsy1g8E0VgArnB4eNtJ2J+YkHX/kK4Zffy6zC9oKs1/pX9BYQlq+02R33P+QB0arnPzcEJi7vFWGTDIQrNOEhy6PjOk4/gV02rCON6NL+h3Fqx20/6vr4UKuas1R4oqweJq1elK1+A1TGRQvb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irFnOCw+; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irFnOCw+"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d23305225so2747043f8f.2
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 13:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775421399; cv=none;
        d=google.com; s=arc-20240605;
        b=WoKGBQR5Mehv/0of6kIPp7yz+PxIGLszgjAqYgja7VC+VGYwLkXuAzJWgI/A7AQB1P
         hoxZzHr6beKy4OhfOMG1BlW6XOTGZKmitR8XcOfW6uB7vLNlxc2HNgRxaEcWuyVcy9cn
         E7BcFrtUQ8JoRP1w3xc4NIOvzk6gOm+9W3SALpqyK9jfGmb8t/Pw5WK+/XErF+89hIIv
         6+ccww4a7hZJtEnLC4VRcSM2EId+92f2wXGrToU/sVHTt25uXZAspuW24KLB6BPsLn+5
         STX5G/LqgFKwzJbzWLS/Uzzo+Ahr885+CvjElyQCFtAFhvUcGYOlxXFeY1sO5My0UE+U
         B+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CT/kJcGAfFxEGzKBJSVzjm7jaoVTWgA/wO/+3EAYdmI=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=H/zNRx/2wNbdv5cvR62Gbo5DYYcg9vzHv5gYmwTEnQpMeqyWXyyp0Dzq1+3eHuR9Ug
         qLW5jx+UlWire/1wSVc5u5hhIJBiptMFq/ONnPoQAzPqjIcfHYzWpubXSxY8oV7Fvdru
         hOlZ1LNqP44L30sMMJhiRwUD7BCp7JoZ0bBuE+sGCQ7QuMDA0O6hxcuCZgbo7unnQ/8d
         7g8tT/FgRV+bL7h+Uw3swiqkGqBdGe/5Hjq9jtZ3/JIrSHlaJ1UnmaFq+SMoSU4rX8dS
         2e6r543hTLq9neEPdd+uz3mloOHiJioR5eoUBiBZIHu96QCfPSg1BFRa5Gjvi7nB69OV
         nDhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775421399; x=1776026199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT/kJcGAfFxEGzKBJSVzjm7jaoVTWgA/wO/+3EAYdmI=;
        b=irFnOCw+z5yglf7PwZTm5z/jE4VkHFPQ2qex1dRbTf4Z5gw/LKs5yfZgbUM+ZxoAeS
         qBRlSuMt3P/k2Bj5IrcQrEo6LjhyxKQ/HRoVRcR4GlWBfOumCy4ppgVWMJf7r5ElovNc
         cV8XWplU3cITSmsIKnI/Q16lAmlnNL0qys8v7aPSo6QE9At4SeomygXvT4TAfv+Z5+9T
         U1g8pb2zxIeIu+tM1+emUQE+p0lCyH8YgUP915cnekW0CSnx+Y3G1YL2lAxp4dLf1UIi
         J68/+QcIoxrnhJeg7aReq/A5TSkqQwymzvLz0DFUqQR+SZM2o4OWavBWe25nKHB3p9ya
         UCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775421399; x=1776026199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CT/kJcGAfFxEGzKBJSVzjm7jaoVTWgA/wO/+3EAYdmI=;
        b=iZ7sNzoXQxlUsi5OhJGhTcJ47coL+WuqFAzkKl7tfkwQ9HOKnpYeevJ8kMW944XZLC
         6sMMyK08SjjQx9ap+H2eYfZnibRzcMsgbUTmeja8qj0oGJay2KLgnhLHJXr+QCU1Hbv3
         lmpDZGtVJ1LdFr3YGIzWVBiIJnPyu6EiHHgpXdGFYD0KBOyrPDw2i5Bn8zfSlrWTquA6
         b6JhLswGjvwLl4Ze3kjjpRmKEFZaqcCYSr9V0LmR4jDmAvqzZZnkv24IUiqB78VNnUId
         Z2SpfS5IqpPFuXHwnNPzg5xX7BJTWWLBiYaikCE8A4bvlOsvfkD38YZiui795n8wZcHQ
         9FHA==
X-Gm-Message-State: AOJu0YzVPG+4ti2bsNhoSfDJymJXNE9S4bhYqng1zy5Zkf2IyLRtQBrm
	8Qsx28d+iDoMbSOKhBfpi8r9l8i+yWfc//4FkUtGQqkn2HN86nU1V7btWvh8cZt8/rKNqnH/QSh
	8uPTXkf4gOrrj+wjF54gau33n60Uv/LU=
X-Gm-Gg: AeBDiesiYbW6KhFKst5NQJTFl36NzIzPxWNQBSd6k9kR4cBalz+XWuLlnvsd3S62UKp
	oclyndUrchoPDqM/4iiP6GN0/wdPzvRWjJx2CwcYKELNKxQ4J5IAKNawJ5UMsNln8yIUnUV8FVN
	/dCkNpq8OvmUUYQxKE1hVAQL+uPb91o+5t0PwsZPlzY2N7Lt40qsdujc4nc7bGSb0lND0gDMC0b
	/vpTNszCLjLyzFzf3vjJv4O5WojXsvORA9gAcBSyUCZa8fzcHCMSkCzS3v66sLtXlF1u+ypEp2A
	+qrnG2jbXvzfuOmzoTLf4kG4n2m2kZO/TQKAMtm40JB2yH//TPk1qCBlNDegDRNkZDH+byxNP+J
	wFYao1cowIwq0qjlSnYOhCxehAg==
X-Received: by 2002:a05:6000:420f:b0:43b:4a2c:ff4 with SMTP id
 ffacd0b85a97d-43d292d3a09mr16245883f8f.33.1775421399176; Sun, 05 Apr 2026
 13:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405172505.1329392-1-yonghong.song@linux.dev> <20260405172626.1337674-1-yonghong.song@linux.dev>
In-Reply-To: <20260405172626.1337674-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 13:36:27 -0700
X-Gm-Features: AQROBzCl9rELB75pOOO4nxF6dbiRyJTCcSX89QmFx5rExQpGVzO9W7CNv01nVuw
Message-ID: <CAADnVQLyoAS39gZvOzOT0qEAj4bzcZLVuupTAhyQSv6d5aQGWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 10:26=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Add x86_64 JIT support for BPF functions and kfuncs with more than
> 5 arguments. The extra arguments are passed through a stack area
> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
> which the JIT translates to RBP-relative accesses in native code.
>
> The JIT follows the native x86_64 calling convention for stack
> argument placement. Incoming stack args from the caller sit above
> the callee's frame pointer at [rbp + 16], [rbp + 24], etc., exactly
> where x86_64 expects them after CALL + PUSH RBP. Only the outgoing
> stack arg area is allocated below the program stack in the prologue.
>
> The native x86_64 stack layout for a function with incoming and
> outgoing stack args:
>
>   high address
>   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>   =E2=94=82 incoming stack arg N    =E2=94=82  [rbp + 16 + (N-1)*8]  (fro=
m caller)
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
>   =E2=94=82 BPF program stack       =E2=94=82  (stack_depth bytes)
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 outgoing stack arg 1    =E2=94=82  [rbp - prog_stack_depth - =
outgoing_depth]
>   =E2=94=82 ...                     =E2=94=82   (written via r12-relative=
 STX/ST)
>   =E2=94=82 outgoing stack arg M    =E2=94=82  [rbp - prog_stack_depth - =
8]
>   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=A4
>   =E2=94=82 callee-saved regs ...   =E2=94=82  (pushed after sub rsp)
>   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98  rsp
>   low address
>
> BPF r12-relative offsets are translated to native RBP-relative
> offsets with two formulas:
>   - Incoming args (load: -off <=3D incoming_depth):
>       native_off =3D 8 - bpf_off  =E2=86=92  [rbp + 16 + ...]
>   - Outgoing args (store: -off > incoming_depth):
>       native_off =3D -(bpf_prog_stack + stack_arg_depth + 8) - bpf_off
>
> Since callee-saved registers are pushed below the outgoing area,
> outgoing args are not at [rsp] at call time. Therefore, for both BPF-to-B=
PF
> calls and kfunc calls, outgoing args are explicitly pushed from the
> outgoing area onto the stack before CALL and rsp is restored after return=
.
>
> For kfunc calls specifically, arg 6 is loaded into R9 and args 7+
> are pushed onto the native stack, per the x86_64 calling convention.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 135 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 129 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 32864dbc2c4e..206f342a0ca0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -390,6 +390,28 @@ static void pop_callee_regs(u8 **pprog, bool *callee=
_regs_used)
>         *pprog =3D prog;
>  }
>
> +/* Push stack args from [rbp + outgoing_base + (k - 1) * 8] in reverse o=
rder. */
> +static int push_stack_args(u8 **pprog, s32 outgoing_base, int from, int =
to)
> +{
> +       u8 *prog =3D *pprog;
> +       int k, bytes =3D 0;
> +       s32 off;
> +
> +       for (k =3D from; k >=3D to; k--) {
> +               off =3D outgoing_base + (k - 1) * 8;
> +               /* push qword [rbp + off] */
> +               if (is_imm8(off)) {
> +                       EMIT3(0xFF, 0x75, off);
> +                       bytes +=3D 3;
> +               } else {
> +                       EMIT2_off32(0xFF, 0xB5, off);
> +                       bytes +=3D 6;
> +               }
> +       }

This is not any better than v1.
It is still a copy.
As I said earlier:
https://lore.kernel.org/bpf/CAADnVQ+5Aqxpk1bTw47xZQ5E0HOtf0-HHjmDFHaay7CDJ-=
7aKQ@mail.gmail.com/
It has to be zero overhead. Copy pasting:

"
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
"

Remapping in earlier patches is unnecessary.
These STX [r12-N], src_reg emitted by LLVM will be JITed as-is into
store of src_reg into %rbp-M slot.
Only shift by 8 bytes is necessary for N to become M.
where STX of 6th argument becomes 'mov' from one register to x86's r9.

The feature has to be zero overhead to pass these args from bpf to native
and from struct_ops hooks into bpf progs.
All verifier considerations are secondary.

pw-bot: cr
