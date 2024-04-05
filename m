Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8F63C1
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279008; cv=none; b=dxkKlprVObjz4G0v8TzjaR8LLqCVbV6d2rjiq9aayfUur7mXojLoieRYFW/JKFVMvGH2dyBngazZ6wksEkcgpIME+zgGhicSB9npilEpj1YqBhP9/nXDbwssnWmqyAV4rSTSPFiwzV6X7uTuvHumaW45S8U8eYpvqf02g62Nous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279008; c=relaxed/simple;
	bh=LX1sw9XlGQs6Bb61xgIx1basAFSOIY5ctc1SWTwPaiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihR1zDrVVhtZ2xBGTTUkkvU8wxYuacNJmcmpNEBu9LWtFmygnpMCT5ofAhU2jLuPlEESCUcx6RBKyFrFXde65nY3xCR9Xxlc3JwXqd7Osndkd5V9uaQ1VHkY09CDzVWIKmvCSCVEYrRDdrqMIOIYNUT23RiYVgAZ+yGTZ1lT9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwtbkaAt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwtbkaAt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343e70dd405so65184f8f.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712279004; x=1712883804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRyr+p+ZX/A/ElRQhPIyIImyjoaLWF4jx1iTT27s/0o=;
        b=VwtbkaAtZSX0iaUo22cfG8LAKos42FAf0hu7yKQBKQs003NqkK9YZVF13JRXu2QLGQ
         6TUegA0hNZ2g4Ip/IisKjlRA6MnS07rP4GoeX02uMJfELttFIBbAI4iC/g7n9XYuSNT4
         cv2RfJ1I/lN2Q2tq1KRYzOiww2jhIPUM0ZZcdwz30So/uUwtB237xnkpX8CtPd0L9lfT
         SHKdY4wG5IDObk/wAWpnreA9G/mdd2Kk4uNng+nQRAStQRsZ9wRlaH6yVIk7XtrDgkhi
         QyMcbWDVgXA+Ub7ptjVrxOaWu7KI7I/7ESy2ycBt+pGRsEuY8Jdfi7X8BJx8LDpc329D
         UGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712279004; x=1712883804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRyr+p+ZX/A/ElRQhPIyIImyjoaLWF4jx1iTT27s/0o=;
        b=BhsPHLhxnChAlq0/mRbgLLLOXcL6XDqVhczInVr8Isw9ity2xBTljfG3nlFHSSpURJ
         Diq2+ff5lJMtPW8bunIRttklyKEHHBW/VcVnRBq0Z4xXYWkoESaF+9fjgYp3Dn8krivJ
         UfHHTqusTs/TSc0bkzU8M/nwY1XtMi9raI34SjGHmVXdGHbORDifgDBZit4DlM6Tvv1c
         mMWhacnFrGZpPFfYzjJHFhEe7nG8rrRqMpHqSxLJfVegZ8nbpy1/W/2QKBG7+bzZnzM0
         pIZK+PEcFAPc/fR7m5BK33ugaSXqrgfpN4RIA9E3me3uXYVAr/DE1249cUjPZv7XvegI
         vLRA==
X-Gm-Message-State: AOJu0YyqgMMYz1RrdElSkdPA8aZEK/2kz0nqGEKgAFleE+x0nWaM5fQy
	TsjTT5Jx+ZgdX/1Yac1FQUMhyOzO52EkSMrKFQ5AuuV2iGx/+zBdgvZD++YF+7cNefmZU3htgiK
	Sw0HqJvdRLjIPcGeoAQglfKuD/1k=
X-Google-Smtp-Source: AGHT+IFy4WACXMNCS2ABclM5maOfSqICulD6y/P9bdPGcVo9JXad+zB8S1XRiVqcbb3CGdgCvq/zhvm6qqDsllhZTzU=
X-Received: by 2002:adf:a417:0:b0:343:dd78:d817 with SMTP id
 d23-20020adfa417000000b00343dd78d817mr23476wra.50.1712279004217; Thu, 04 Apr
 2024 18:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152638.31377-1-hffilwlqm@gmail.com> <20240402152638.31377-3-hffilwlqm@gmail.com>
In-Reply-To: <20240402152638.31377-3-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 4 Apr 2024 18:03:13 -0700
Message-ID: <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Pu Lehui <pulehui@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>   * Solution changes from percpu tail_call_cnt to tail_call_cnt at task_s=
truct.

Please remind us what was wrong with per-cpu approach?

Also notice we have pseudo per-cpu bpf insns now,
so things might be easier today.

On Tue, Apr 2, 2024 at 8:27=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
...
>
> As a result, the previous tailcall way can be removed totally, including
>
> 1. "push rax" at prologue.
> 2. load tail_call_cnt to rax before calling function.
> 3. "pop rax" before jumping to tailcallee when tailcall.
> 4. "push rax" and load tail_call_cnt to rax at trampoline.

Please trim it.
It looks like you've been copy pasting it and it's no longer
accurate.
Short description of the problem will do.

> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling=
 in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64=
 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 137 +++++++++++++++++++++---------------
>  1 file changed, 81 insertions(+), 56 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 3b639d6f2f54d..cd06e02e83b64 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -11,6 +11,7 @@
>  #include <linux/bpf.h>
>  #include <linux/memory.h>
>  #include <linux/sort.h>
> +#include <linux/sched.h>
>  #include <asm/extable.h>
>  #include <asm/ftrace.h>
>  #include <asm/set_memory.h>
> @@ -18,6 +19,8 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include <asm/current.h>
> +#include <asm/percpu.h>
>
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>
> @@ -273,7 +276,7 @@ struct jit_context {
>  /* Number of bytes emit_patch() needs to generate instructions */
>  #define X86_PATCH_SIZE         5
>  /* Number of bytes that will be skipped on tailcall */
> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> +#define X86_TAIL_CALL_OFFSET   (14 + ENDBR_INSN_SIZE)
>
>  static void push_r12(u8 **pprog)
>  {
> @@ -403,6 +406,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>         *pprog =3D prog;
>  }
>
> +static int emit_call(u8 **pprog, void *func, void *ip);
> +static __used void bpf_tail_call_cnt_init(void);
> +
>  /*
>   * Emit x86-64 prologue code for BPF program.
>   * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
> @@ -410,9 +416,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>   */
>  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cb=
pf,
>                           bool tail_call_reachable, bool is_subprog,
> -                         bool is_exception_cb)
> +                         bool is_exception_cb, u8 *ip)
>  {
> -       u8 *prog =3D *pprog;
> +       u8 *prog =3D *pprog, *start =3D *pprog;
>
>         emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash)=
;
>         /* BPF trampoline can be made to work without these nops,
> @@ -421,13 +427,14 @@ static void emit_prologue(u8 **pprog, u32 stack_dep=
th, bool ebpf_from_cbpf,
>         emit_nops(&prog, X86_PATCH_SIZE);
>         if (!ebpf_from_cbpf) {
>                 if (tail_call_reachable && !is_subprog)
> -                       /* When it's the entry of the whole tailcall cont=
ext,
> -                        * zeroing rax means initialising tail_call_cnt.
> +                       /* Call bpf_tail_call_cnt_init to initilise
> +                        * tail_call_cnt.
>                          */
> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> +                       emit_call(&prog, bpf_tail_call_cnt_init,
> +                                 ip + (prog - start));

You're repeating the same bug we discussed before.
There is nothing in bpf_tail_call_cnt_init() that
prevents the compiler from scratching rdi,rsi,...
bpf_tail_call_cnt_init() is a normal function from compiler pov
and it's allowed to use those regs.
Must have been lucky that CI is not showing crashes.

>                 else
>                         /* Keep the same instruction layout. */
> -                       EMIT2(0x66, 0x90); /* nop2 */
> +                       emit_nops(&prog, X86_PATCH_SIZE);
>         }
>         /* Exception callback receives FP as third parameter */
>         if (is_exception_cb) {
> @@ -452,8 +459,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, bool ebpf_from_cbpf,
>         /* sub rsp, rounded_stack_depth */
>         if (stack_depth)
>                 EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
> -       if (tail_call_reachable)
> -               EMIT1(0x50);         /* push rax */
>         *pprog =3D prog;
>  }
>
> @@ -589,13 +594,61 @@ static void emit_return(u8 **pprog, u8 *ip)
>         *pprog =3D prog;
>  }
>
> +static __used void bpf_tail_call_cnt_init(void)
> +{
> +       /* The following asm equals to
> +        *
> +        * u32 *tcc_ptr =3D &current->bpf_tail_call_cnt;
> +        *
> +        * *tcc_ptr =3D 0;
> +        */
> +
> +       asm volatile (
> +           "addq " __percpu_arg(0) ", %1\n\t"
> +           "addq %2, %1\n\t"
> +           "movq (%1), %1\n\t"
> +           "addq %3, %1\n\t"
> +           "movl $0, (%1)\n\t"
> +           :
> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
> +             "i" (offsetof(struct pcpu_hot, current_task)),
> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
> +       );
> +}
> +
> +static __used u32 *bpf_tail_call_cnt_ptr(void)
> +{
> +       u32 *tcc_ptr;
> +
> +       /* The following asm equals to
> +        *
> +        * u32 *tcc_ptr =3D &current->bpf_tail_call_cnt;
> +        *
> +        * return tcc_ptr;
> +        */
> +
> +       asm volatile (
> +           "addq " __percpu_arg(1) ", %2\n\t"
> +           "addq %3, %2\n\t"
> +           "movq (%2), %2\n\t"
> +           "addq %4, %2\n\t"
> +           "movq %2, %0\n\t"
> +           : "=3Dr" (tcc_ptr)
> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
> +             "i" (offsetof(struct pcpu_hot, current_task)),
> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
> +       );
> +
> +       return tcc_ptr;
> +}
> +
>  /*
>   * Generate the following code:
>   *
>   * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
>   *   if (index >=3D array->map.max_entries)
>   *     goto out;
> - *   if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> + *   if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
>   *     goto out;
>   *   prog =3D array->ptrs[index];
>   *   if (prog =3D=3D NULL)
> @@ -608,7 +661,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
>                                         u32 stack_depth, u8 *ip,
>                                         struct jit_context *ctx)
>  {
> -       int tcc_off =3D -4 - round_up(stack_depth, 8);
>         u8 *prog =3D *pprog, *start =3D *pprog;
>         int offset;
>
> @@ -630,16 +682,16 @@ static void emit_bpf_tail_call_indirect(struct bpf_=
prog *bpf_prog,
>         EMIT2(X86_JBE, offset);                   /* jbe out */
>
>         /*
> -        * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> +        * if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
>          *      goto out;
>          */
> -       EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [=
rbp - tcc_off] */
> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CA=
LL_CNT */
> +       /* call bpf_tail_call_cnt_ptr */
> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip + (prog - start));

same issue.

> +       EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax],=
 MAX_TAIL_CALL_CNT */
>
>         offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
>         EMIT2(X86_JAE, offset);                   /* jae out */
> -       EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
> -       EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp -=
 tcc_off], eax */
> +       EMIT2(0xFF, 0x00);                        /* inc dword ptr [rax] =
*/
>
>         /* prog =3D array->ptrs[index]; */
>         EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx =
* 8 + offsetof(...)] */
> @@ -663,7 +715,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
>                         pop_r12(&prog);
>         }
>
> -       EMIT1(0x58);                              /* pop rax */
>         if (stack_depth)
>                 EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
>                             round_up(stack_depth, 8));
> @@ -691,21 +742,20 @@ static void emit_bpf_tail_call_direct(struct bpf_pr=
og *bpf_prog,
>                                       bool *callee_regs_used, u32 stack_d=
epth,
>                                       struct jit_context *ctx)
>  {
> -       int tcc_off =3D -4 - round_up(stack_depth, 8);
>         u8 *prog =3D *pprog, *start =3D *pprog;
>         int offset;
>
>         /*
> -        * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
> +        * if ((*tcc_ptr)++ >=3D MAX_TAIL_CALL_CNT)
>          *      goto out;
>          */
> -       EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword p=
tr [rbp - tcc_off] */
> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAI=
L_CALL_CNT */
> +       /* call bpf_tail_call_cnt_ptr */
> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip);

and here as well.

pw-bot: cr
