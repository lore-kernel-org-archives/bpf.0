Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05631B837
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033380; cv=pass; b=DloUKBBHJLYY44XLITKZx3DJYaUzn+fFnR6qN2SNR5lfuVMyIa7PeYj7dJX5i3N2/piRLddvOGIdAPQUE/DhpVqb04oLqGab6AEinD5FqEcMF1v9KFw20eFhwoFugRQkqVGo6CxkMR2g1yFnuo8Z1pH99ns7E1TkT85ILr5BcaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033380; c=relaxed/simple;
	bh=+VwFKp2yXiqXKvAhrwEy7hcvLAfm8OL5EYb9qsuxwS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvYU/C9tpNXkHXpwrj/0nehsIyfbb+MjiUtPbNrQf4UZfih5RQU2qOVKWUyMuEY7Hqz19rTpBS+ojYJ7E+GVqdHD8uYK/etCxe72UzUQqLxGlXwP70UwtJ4koquhV66vkuP/DRBw4M5adIspX4L+YOxu1hXP0ChX43rf4atQi5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOa/pS53; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOa/pS53"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so704830f8f.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776033377; cv=none;
        d=google.com; s=arc-20240605;
        b=cS2ny6jtpqQVbGxOYdCR83ZF4vBrTeVG7GsEUbzIEaHj7sARzMONqU5ud0a8GGc+Zb
         jed2jo0D/Vilx6tj7PNNKSGP4HQ9ISJmsqrtlfyNKuk/f2UKh7xIRWn0+aynMNjzVnoO
         v23/CQB7e3vhDF4vEW+plG7zVQMNVXQZurcrrno0mDRZCtjtViUclQRf1r8f9jiWdTVn
         yWkzYene/NyUiQPIJpFVy9+cq2lZHlooelc5SATPeFveDt2ZTUfJmJVScYQCx37+XXz0
         jN8h8mhZSYAKLRRmMxDUsBtbPklP3PyO+0Fbb5gtslxcXD26mZGvEUr2u6+Nbllz322C
         anhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UI+IAH+iPGDoDuTMJ55u8GMYHWSAQf0lFA7jDE3n4cI=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=Kqrf8luP7kt2nIi5soEBYbAKmURzkQXrFTHKlTDwtIiz94oktav8bGjCSwEGPiyfSK
         mnLjyYWgEepfOoeiE79X+F+UPgoy7672+MLOhgJVy/S4RpzeNzqPi3mEBko9/GVd/HsF
         b8+Wpqbm26lfBCd8fH07opcoim6y4hdSt2ZdUVWfgdWKdkGPhySB8v6uMXEknA8gahTq
         I0uZuckCptnTTEKBDn/K0B7luyYt5ilIpfSLto2Nl68yis9mArCIs7yZ51JaSJv+yQXm
         ngik8Y1pnANvQkrlMSpQLLb0L8jJaff485elnzqBDEgL6NkImIYDan92BRXArIVtfiS+
         0wgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776033377; x=1776638177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI+IAH+iPGDoDuTMJ55u8GMYHWSAQf0lFA7jDE3n4cI=;
        b=dOa/pS53NGBGYVJzC6dN2YFy9HYzi8NMenKCzpk6e9RzzNhqMhTzlRHhEhhZyvosuN
         R6PdFw3yq/ZTyGkPPsSPeE3fTW2YgyDSGZxs6cKvHyVLGUun+GzHwPDuCvdl73t5LzCn
         mrfvoX3HaFla+d4lGvpVyDBV8El7M2R33Wrl7fFWwB9Myhqn+3flzOG/Wqf1T5yEAQaF
         yfmi40l7CPGV7ofYQPA4CaX8+vW+7naTRk/XJlw5fezGkZ1GEEDu8ZtL1TS4dOqJKPKR
         2O1Il1ig2ad9dnuQCyQuKx5lHl2VqxNDssD7Z9/BJPK5HRBcYHr+P1VsRtRi3fWa7kJA
         Kbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776033377; x=1776638177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UI+IAH+iPGDoDuTMJ55u8GMYHWSAQf0lFA7jDE3n4cI=;
        b=qC26rNjoP4sR1WcxGImRLMss6PVA7OSDLTWfcli2z6UoGrDttATlQ7ZktaZaF3fZ38
         LBFjPEKF05UfxGhpKPVo6c8Zg5TFFZzKEEi8oY/dtyeA3o8AGSJexd8lMluND6woV7L8
         wtWeojJQ3x7nh0zyGjGN5QpYtpIA25Uz9JPeha60e6aXqUknGyz6uyxVWKr9T6nbyBuj
         7IGHOyCrUGfDkD8tpVU/t6FpYfCMpu8cZv0gFEam63KFM+fEFkXVCtq8/1GZfR9Ocoww
         lsQijHcBXnrJx+eYmGyYnW6j16xMy3RiDkwWfm1EIpEmEbclqvOk2M8eejDJTPaqEgTX
         BPDw==
X-Gm-Message-State: AOJu0YwaBeGS2iNafBa08VMId5liv07l3kTAWujIfTIMNDpuRyCgfCfh
	/Avfu/3zA87KmRH583UmW4pyOKNsZChvHYOMXPMctN4JSEOo52GqVn+upqTBMLYYeZpCTt6Czbj
	BXmhUqaOSTDcnpnSUBbGN7r9dDv7vZBE=
X-Gm-Gg: AeBDievaoZ4RIpPDih3Y3WzPPNynHXUm+6DF0JHPKciVdNgwQOb/IrWwdGW0Kyi+pji
	sIozASPqYVuLPM2HnPgt7o84io88q5R9GkMaeX5YprRosfAOnO7K6UYwGuJH2I4hZZW/35m2EVs
	/jfhMAP4s0YkWm0Qw1c0EVd7I4BT5p7WixoishN1NvBNXy4mOuV1HLAaTFH+q1yIdaoECM7UyIJ
	mlLpamdKOQ/V98jQqSPtkwJPSiyQzP0U1wB57jy/DTgDThIDcyal8bqe+6S+0uExRzWlFtlJ2pP
	iwRzwdpiF///WIXhO/rO5bonFZXR9ADCWxBbG3tnBMgF9QMc6gtpvXQ9+cLv9gjVtWWxvmI0+GT
	ws2NnPL4Fjy/LQpUkKwhVKky7gg==
X-Received: by 2002:a05:6000:220b:b0:43d:30b4:1859 with SMTP id
 ffacd0b85a97d-43d64235cf5mr15635903f8f.7.1776033376417; Sun, 12 Apr 2026
 15:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045826.254200-1-yonghong.song@linux.dev> <20260412050033.267815-1-yonghong.song@linux.dev>
In-Reply-To: <20260412050033.267815-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 15:36:04 -0700
X-Gm-Features: AQROBzCfK-CJ_wPOaknOG4OzvQg-dmfsL6h1FquTD41CdK8i9_FRR_uF_q_pg6I
Message-ID: <CAADnVQL462NnYNquWqJL8=CFZr6vJOxVzCPCpijV2MLAx0y67A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 15/18] bpf,x86: Implement JIT support for
 stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:00=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> Add x86_64 JIT support for BPF functions and kfuncs with more than
> 5 arguments. The extra arguments are passed through a stack area
> addressed by register r12 (BPF_REG_STACK_ARG_BASE) in BPF bytecode,
> which the JIT translates to native code.
>
> The JIT follows the x86-64 calling convention for both BPF-to-BPF
> and kfunc calls:
>   - Arg 6 is passed in the R9 register
>   - Args 7+ are passed on the stack
>
> Incoming arg 6 (BPF r12+8) is translated to a MOV from R9 rather
> than a memory load. Incoming args 7+ (BPF r12+16, r12+24, ...) map
> directly to [rbp + 16], [rbp + 24], ..., matching the x86-64 stack
> layout after CALL + PUSH RBP, so no offset adjustment is needed.
>
> The verifier guarantees that neither tail_call_reachable nor
> priv_stack is set when outgoing stack args exist, so R9 is always
> available. When BPF bytecode writes to the arg-6 stack slot
> (the most negative outgoing offset), the JIT emits a MOV into R9
> instead of a memory store. Outgoing args 7+ are placed at [rsp]
> in a pre-allocated area below callee-saved registers, using:
>   native_off =3D outgoing_arg_base + bpf_off
>
> The native x86_64 stack layout:
>
>   high address
>   +-------------------------+
>   | incoming stack arg N    |  [rbp + 16 + (N-2)*8]  (from caller)
>   | ...                     |
>   | incoming stack arg 7    |  [rbp + 16]
>   +-------------------------+
>   | return address          |  [rbp + 8]
>   | saved rbp               |  [rbp]
>   +-------------------------+
>   | BPF program stack       |  (round_up(stack_depth, 8) bytes)
>   +-------------------------+
>   | callee-saved regs       |  (r12, rbx, r13, r14, r15 as needed)
>   +-------------------------+
>   | outgoing arg M          |  [rsp + (M-7)*8]
>   | ...                     |
>   | outgoing arg 7          |  [rsp]
>   +-------------------------+  rsp
>   low address
>
>   (Arg 6 is in R9, not on the stack)
>
>   [1] https://github.com/llvm/llvm-project/pull/189060
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 172 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 164 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 32864dbc2c4e..ec57b9a6b417 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -390,6 +390,34 @@ static void pop_callee_regs(u8 **pprog, bool *callee=
_regs_used)
>         *pprog =3D prog;
>  }
>
> +/* add rsp, depth */
> +static void emit_add_rsp(u8 **pprog, u16 depth)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       if (!depth)
> +               return;
> +       if (is_imm8(depth))
> +               EMIT4(0x48, 0x83, 0xC4, depth); /* add rsp, imm8 */
> +       else
> +               EMIT3_off32(0x48, 0x81, 0xC4, depth); /* add rsp, imm32 *=
/
> +       *pprog =3D prog;
> +}
> +
> +/* sub rsp, depth */
> +static void emit_sub_rsp(u8 **pprog, u16 depth)
> +{
> +       u8 *prog =3D *pprog;
> +
> +       if (!depth)
> +               return;
> +       if (is_imm8(depth))
> +               EMIT4(0x48, 0x83, 0xEC, depth); /* sub rsp, imm8 */
> +       else
> +               EMIT3_off32(0x48, 0x81, 0xEC, depth); /* sub rsp, imm32 *=
/
> +       *pprog =3D prog;
> +}
> +
>  static void emit_nops(u8 **pprog, int len)
>  {
>         u8 *prog =3D *pprog;
> @@ -725,8 +753,8 @@ static void emit_return(u8 **pprog, u8 *ip)
>   */
>  static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>                                         u8 **pprog, bool *callee_regs_use=
d,
> -                                       u32 stack_depth, u8 *ip,
> -                                       struct jit_context *ctx)
> +                                       u32 stack_depth, u16 outgoing_dep=
th,
> +                                       u8 *ip, struct jit_context *ctx)
>  {
>         int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
>         u8 *prog =3D *pprog, *start =3D *pprog;
> @@ -775,6 +803,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
>         /* Inc tail_call_cnt if the slot is populated. */
>         EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax],=
 1 */
>
> +       /* Deallocate outgoing stack arg area. */
> +       emit_add_rsp(&prog, outgoing_depth);

leftover?
tailcalls are 6+ args don't mix.

> +
>         if (bpf_prog->aux->exception_boundary) {
>                 pop_callee_regs(&prog, all_callee_regs_used);
>                 pop_r12(&prog);
> @@ -815,6 +846,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
>                                       struct bpf_jit_poke_descriptor *pok=
e,
>                                       u8 **pprog, u8 *ip,
>                                       bool *callee_regs_used, u32 stack_d=
epth,
> +                                     u16 outgoing_depth,
>                                       struct jit_context *ctx)
>  {
>         int tcc_ptr_off =3D BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
> @@ -842,6 +874,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
>         /* Inc tail_call_cnt if the slot is populated. */
>         EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [r=
ax], 1 */
>
> +       /* Deallocate outgoing stack arg area. */
> +       emit_add_rsp(&prog, outgoing_depth);
> +

another leftover?


>         if (bpf_prog->aux->exception_boundary) {
>                 pop_callee_regs(&prog, all_callee_regs_used);
>                 pop_r12(&prog);
> @@ -1664,16 +1699,48 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>         int i, excnt =3D 0;
>         int ilen, proglen =3D 0;
>         u8 *prog =3D temp;
> +       u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg=
_depth;
> +       u16 outgoing_rsp;
>         u32 stack_depth;
> +       int callee_saved_size;
> +       s32 outgoing_arg_base;
> +       bool has_stack_args;
>         int err;
>
>         stack_depth =3D bpf_prog->aux->stack_depth;
> +       stack_arg_depth =3D bpf_prog->aux->stack_arg_depth;
> +       incoming_stack_arg_depth =3D bpf_prog->aux->incoming_stack_arg_de=
pth;
> +       outgoing_stack_arg_depth =3D stack_arg_depth - incoming_stack_arg=
_depth;
>         priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
>         if (priv_stack_ptr) {
>                 priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ +=
 round_up(stack_depth, 8);
>                 stack_depth =3D 0;
>         }
>
> +       /*
> +        * Follow x86-64 calling convention for both BPF-to-BPF and
> +        * kfunc calls:
> +        *   - Arg 6 is passed in R9 register
> +        *   - Args 7+ are passed on the stack at [rsp]
> +        *
> +        * Incoming arg 6 is read from R9 (BPF r12+8 =E2=86=92 MOV from R=
9).
> +        * Incoming args 7+ are read from [rbp + 16], [rbp + 24], ...
> +        * (BPF r12+16, r12+24, ... map directly with no offset change).
> +        *
> +        * The verifier guarantees that neither tail_call_reachable nor
> +        * priv_stack is set when outgoing stack args exist, so R9 is
> +        * always available.
> +        *
> +        * Stack layout (high to low):
> +        *   [rbp + 16 + ...]    incoming stack args 7+ (from caller)
> +        *   [rbp + 8]           return address
> +        *   [rbp]               saved rbp
> +        *   [rbp - prog_stack]  program stack
> +        *   [below]             callee-saved regs
> +        *   [below]             outgoing args 7+ (=3D rsp)
> +        */
> +       has_stack_args =3D stack_arg_depth > 0;
> +
>         arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->are=
na);
>         user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->aren=
a);
>
> @@ -1700,6 +1767,41 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                         push_r12(&prog);
>                 push_callee_regs(&prog, callee_regs_used);
>         }
> +
> +       /* Compute callee-saved register area size. */
> +       callee_saved_size =3D 0;
> +       if (bpf_prog->aux->exception_boundary || arena_vm_start)
> +               callee_saved_size +=3D 8; /* r12 */
> +       if (bpf_prog->aux->exception_boundary) {
> +               callee_saved_size +=3D 4 * 8; /* rbx, r13, r14, r15 */
> +       } else {
> +               int j;
> +
> +               for (j =3D 0; j < 4; j++)
> +                       if (callee_regs_used[j])
> +                               callee_saved_size +=3D 8;
> +       }
> +       /*
> +        * Base offset from rbp for translating BPF outgoing args 7+
> +        * to native offsets:
> +        *   native_off =3D outgoing_arg_base + bpf_off
> +        *
> +        * BPF outgoing offsets are negative (r12 - N*8 for arg6,
> +        * ..., r12 - 8 for last arg). Arg 6 goes to R9 directly,
> +        * so only args 7+ occupy the outgoing stack area.
> +        *
> +        * Note that tail_call_reachable is guaranteed to be false when
> +        * stack args exist, so tcc pushes need not be accounted for.
> +        */
> +       outgoing_arg_base =3D -(round_up(stack_depth, 8) + callee_saved_s=
ize);
> +
> +       /*
> +        * Allocate outgoing stack arg area for args 7+ only.
> +        * Arg 6 goes into r9 register, not on stack.
> +        */
> +       outgoing_rsp =3D outgoing_stack_arg_depth > 8 ?  outgoing_stack_a=
rg_depth - 8 : 0;
> +       emit_sub_rsp(&prog, outgoing_rsp);
> +
>         if (arena_vm_start)
>                 emit_mov_imm64(&prog, X86_REG_R12,
>                                arena_vm_start >> 32, (u32) arena_vm_start=
);
> @@ -1715,13 +1817,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>         prog =3D temp;
>
>         for (i =3D 1; i <=3D insn_cnt; i++, insn++) {
> +               bool adjust_stack_arg_off =3D false;

This bool signal within a single insn is hard to read.

>                 const s32 imm32 =3D insn->imm;
>                 u32 dst_reg =3D insn->dst_reg;
>                 u32 src_reg =3D insn->src_reg;
>                 u8 b2 =3D 0, b3 =3D 0;
>                 u8 *start_of_ldx;
>                 s64 jmp_offset;
> -               s16 insn_off;
> +               s32 insn_off;
>                 u8 jmp_cond;
>                 u8 *func;
>                 int nops;
> @@ -1734,6 +1837,21 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                                 dst_reg =3D X86_REG_R9;
>                 }
>
> +               if (has_stack_args) {
> +                       u8 class =3D BPF_CLASS(insn->code);
> +
> +                       if (class =3D=3D BPF_LDX &&
> +                           src_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
> +                               src_reg =3D BPF_REG_FP;
> +                               adjust_stack_arg_off =3D true;
> +                       }
> +                       if ((class =3D=3D BPF_STX || class =3D=3D BPF_ST)=
 &&
> +                           dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
> +                               dst_reg =3D BPF_REG_FP;
> +                               adjust_stack_arg_off =3D true;
> +                       }
> +               }

All that stuff looks unnecessary.

> +
>                 switch (insn->code) {
>                         /* ALU */
>                 case BPF_ALU | BPF_ADD | BPF_X:
> @@ -2129,12 +2247,20 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>                                 EMIT1(0xC7);
>                         goto st;
>                 case BPF_ST | BPF_MEM | BPF_DW:
> +                       if (adjust_stack_arg_off && insn->off =3D=3D -out=
going_stack_arg_depth) {
> +                               /* Arg 6: store immediate in r9 register =
*/
> +                               emit_mov_imm64(&prog, X86_REG_R9, imm32 >=
> 31, (u32)imm32);
> +                               break;
> +                       }
>                         EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>
> -st:                    if (is_imm8(insn->off))
> -                               EMIT2(add_1reg(0x40, dst_reg), insn->off)=
;
> +st:                    insn_off =3D insn->off;
> +                       if (adjust_stack_arg_off)
> +                               insn_off =3D outgoing_arg_base + insn_off=
;

Since this part needs to be done anyway, match dst_reg=3D=3Dr11 here
and do the right thing without bool adjust_stack_arg_off ?

> +                       if (is_imm8(insn_off))
> +                               EMIT2(add_1reg(0x40, dst_reg), insn_off);
>                         else
> -                               EMIT1_off32(add_1reg(0x80, dst_reg), insn=
->off);
> +                               EMIT1_off32(add_1reg(0x80, dst_reg), insn=
_off);
>
>                         EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->=
code)));
>                         break;
> @@ -2144,7 +2270,15 @@ st:                      if (is_imm8(insn->off))
>                 case BPF_STX | BPF_MEM | BPF_H:
>                 case BPF_STX | BPF_MEM | BPF_W:
>                 case BPF_STX | BPF_MEM | BPF_DW:
> -                       emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, sr=
c_reg, insn->off);
> +                       if (adjust_stack_arg_off && insn->off =3D=3D -out=
going_stack_arg_depth) {
> +                               /* Arg 6: store register value in r9 */
> +                               EMIT_mov(X86_REG_R9, src_reg);
> +                               break;
> +                       }
> +                       insn_off =3D insn->off;
> +                       if (adjust_stack_arg_off)
> +                               insn_off =3D outgoing_arg_base + insn_off=
;
> +                       emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, sr=
c_reg, insn_off);
>                         break;
>
>                 case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> @@ -2243,6 +2377,18 @@ st:                      if (is_imm8(insn->off))
>                 case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>                 case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>                         insn_off =3D insn->off;
> +                       if (adjust_stack_arg_off) {
> +                               if (insn_off =3D=3D 8) {
> +                                       /* Incoming arg 6: read from r9 *=
/
> +                                       EMIT_mov(dst_reg, X86_REG_R9);
> +                                       break;
> +                               }
> +                               /*
> +                                * Incoming args 7+: native_off =3D=3D bp=
f_off
> +                                * (r12+16 =E2=86=92 [rbp+16], r12+24 =E2=
=86=92 [rbp+24], ...)
> +                                * No offset adjustment needed.
> +                                */

Overall, looks ok. See how much cleaner and more performant JIT became ?
