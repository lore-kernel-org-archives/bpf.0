Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09692BD0B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173099; cv=pass; b=HPkm06gtqopwMT6ASfSQImitC6RFE70Lt5SEVRgu5XBUiXGGG3cSlgIR4Zu/GOhoxG2/RMHHgiR26IL9ereYy2UF6k73Nkulbezoa9zvDzP9b6zXBQ5/B2YYuDLWEmrpKllHZMbserxltFnkZwzRQMAtyaYFevEZfuaeHJdVrRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173099; c=relaxed/simple;
	bh=zFr95wWl7cWHadZ/TML1uIX/Qy+SKAIMcION67MyEfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1+6FlHRYheRVaIDGHuYmcKzu1wTFnCcVWrdzyJGufJC98/T0U8TmwemeVtL/BgCms7zN0AF+pOpBYxoz7aR7n24S+PDHlAVdQ68cH8Oe9R5u9j8V7+Cl/SPSgUg8BkQ5q8sQPopdty+6fmoiecn3l07N909dsUPyXw09DBGOlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qe33xufZ; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe33xufZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a60975dc5so14555837b3.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 16:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775173097; cv=none;
        d=google.com; s=arc-20240605;
        b=NLXZogUuD4tHOanyOK4av1Fj4AYhNyhjkYA1hjTxn5AKaEeF3cgg+6GunIlF6bBxAN
         Tex6fld7DGU9kj71poCUBxNaTicjWRmCiiqChicaxT5vMidww8k7h0EbT5kKE2JJu/B8
         jlkQMn5pbiyPrtakVj+VZu/xQ8GgWN+YStxwhw+QgV2e8m/T+eDsqJroqw/7mXBB/6tG
         mBKFBKLOivdy1RQVKuPEuhm7XrQsvVi+v8+k7rwwZa89/j/AAf34sh5PAUZl+TAe4Wdt
         0xzXv42+tjgfD6wFR4Hq0K4bHMR7LaTjl8CPRUxJy+jC0dzKsM1sof/lcsnGb21T0FsK
         cibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mnHaA13rGwCM0vB5A0Mag7JnhR6Dh83pIMEMq8slLKQ=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=gjuHyebde8dKi1n/Qup9aCxFyR4BYI1S4N4mDY1QVTrbmMHSJTErx+vOObGE/rl4fr
         k1XwOW+0+uLRDulNlLKTE0Clnr61LUOk79Jrx4+VOcGTNypZCjiODS2MSjzx1rvyQcxd
         H8UYVtZljizuqxFZtZmDBUpqYm/PL/cm+cF/IMn2EJaXJ3efIeMFlLoUg7n1qFr1t3Av
         AY++21jt6r0Qt90xQpcFR9DuhUqg+wTAni+TlUqm4gA9FtMWkD4VB6Xy9sB/1ItqmnGH
         ErH2JrLWjw0WQB2nvUGrPu8TXucZS96lijVexUKVDatwB0ATESANuA2rTD7mRm7WeCnS
         89Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775173097; x=1775777897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnHaA13rGwCM0vB5A0Mag7JnhR6Dh83pIMEMq8slLKQ=;
        b=qe33xufZ+fXWgomxjKP44ZgJggpkq1CSoR1Wd26FNoBe73LZiblFGEo9mMjal9ckdw
         D7v4nxYyT+7HKtqxfyl5vfw2LGKefLCRoMroRACfswuMvhNALBacqI1dm8pxqqkxe9wE
         tst2BkSy0dzfI+XH57gseWp5EZOpyPaJx3r1e7NCw4R+hNPdX5pFhDxNhXgKebDXEvxN
         A17kZH/AwltAskmlTKMRFNLQo/thB4AIJ402n/LiGYj0ILbOoq/lX8jlRsY9eujZJpek
         g80XFpX+k6amySDNE8keuxprDRYlUYZqxbEGIMJd3Byf82jK537PolxfdL7cxaULEO0W
         ueEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173097; x=1775777897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnHaA13rGwCM0vB5A0Mag7JnhR6Dh83pIMEMq8slLKQ=;
        b=YntBwm233K/cuCzMft7QjTiT331iEI9qbmssfoV66X5DG/SGIQdunQFAe9BgANUeQi
         vp1fVMY6Bw1n17akRCYxAEP+IxNvQsY1mKYUrjpf8P5BosRl81ZMIhj6z89eR8IW1Cq0
         aSp4/ww9BfezNJlwDW1B8yOuKH2pFMKkoctkjw11GjN0ynALDoYG8Jq0kY9/fL/lowwF
         xK2fKBMfhTrjCI/vo0KOTkHG3BbzDKkmV39Z/mUjrE7Wyf2YUPnVHZx8qbBaPxYNk5JG
         fsJ2UMx/7lBRfPuz9s6GdBXmzeTkfO5Q9/k6Odw1X+5S6lkbP8ojDmqzCINPNQUMFQc1
         t6XA==
X-Gm-Message-State: AOJu0YxEy/9Qh6SRDf3rUkoG2fQrDfgZXaLuBnpLfhozspPWIqPFxqDc
	idIPRKMniHhSQsmXnqy5Cw/hCiU/ag2TqpxJGPT6ZOpm52AS3N1Dw164z4zyB0r7kA2xZkWjVg2
	3NZYhJYu25RaSVRlto+/dbvVlT6ft05M=
X-Gm-Gg: AeBDietz9CrOnEXgSRQzjMRQfF62DeKj2hZFd9ip05yNRAU6X2sSZfx+6qsVuCbQ3Q7
	TZ2UOQOBrVM/mwqC1g+xA6fDdx8x/me+U1px/iJJ6ALaqY7YDTFwS8eVRRg4841F9x1yv6Pp3st
	6+39jqLIrczk3zSY/z/dzmNgV7gEM0aVcJkJcZXFGe2Ry/p6cann1g4jVgSi4tfz7DvNl+P5xUz
	9b8YvUj3X96hk1yM2SIgPnGcUjmmFroydsviC+acytuZbIooNgUXSesVSR2yDCciqjY3u+EAPCT
	qBB0+c8=
X-Received: by 2002:a05:690c:38a:b0:7a1:a97:c144 with SMTP id
 00721157ae682-7a4d31e8722mr14196337b3.5.1775173096767; Thu, 02 Apr 2026
 16:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012742.3917613-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012742.3917613-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Apr 2026 16:38:05 -0700
X-Gm-Features: AQROBzDllfvSnNe2PYX8AFG1lQ1Ht3izC63HT1Zp_nVkKlZTi6ezcjinRNdNI5M
Message-ID: <CAMB2axM+UaJU0NpmkdwquinVjmJKBXeb+Ch-MQk_YskSyvrb+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register
> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>
> The following is an example to show how stack arguments are saved
> and transferred between caller and callee:
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>   }
>
> The following is a illustration of stack allocation:
>
>    Caller (foo)                           Callee (bar)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    r12-relative stack arg area:           r12-relative stack arg area:
>
>    r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from =
caller's outgoing r12-24)
>    r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from =
caller's outgoing r12-32)
>                                      ||+> r12-24: [incoming arg 8] (from =
caller's outgoing r12-40)
>    ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>    r12-24: [outgoing arg 6 to callee]+||   ...
>    r12-32: [outgoing arg 7 to callee]-+|
>    r12-40: [outgoing arg 8 to callee]--+
>
>   The caller writes outgoing args past its own incoming area.
>   At the call site, the verifier transfers the caller's outgoing
>   slots into the callee's incoming slots.
>
> The verifier tracks stack arg slots separately from the regular r10
> stack. A new 'bpf_stack_arg_state' structure mirrors the existing stack
> slot tracking (spilled_ptr + slot_type[]) but lives in a dedicated
> 'stack_arg_slots' array in bpf_func_state. This separation keeps the
> stack arg area from interfering with the normal stack and frame pointer
> (r10) bookkeeping.
>
> If the bpf function has more than one calls, e.g.,
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar1(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>     bar2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>     ...
>   }
>
> The following is an illustration:
>
>    Caller (foo)                           Callee (bar1)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    r12-relative stack arg area:           r12-relative stack arg area:
>
>    r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from =
caller's outgoing r12-24)
>    r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from =
caller's outgoing r12-32)
>                                      ||+> r12-24: [incoming arg 8] (from =
caller's outgoing r12-40)
>    ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>    r12-24: [outgoing arg 6 to callee]+||  ...
>    r12-32: [outgoing arg 7 to callee]-+|
>    r12-40: [outgoing arg 8 to callee]--+
>    ...
>    Back from bar1
>    ...                                     Callee (bar2)
>    =3D=3D=3D                                     =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>                                      +---> r12-8:  [incoming arg 6] (from=
 caller's outgoing r12-24)
>                                      |+--> r12-16: [incoming arg 7] (from=
 caller's outgoing r12-32)
>                                      ||+-> r12-24: [incoming arg 8] (from=
 caller's outgoing r12-40)
>                                      |||+> r12-32: [incoming arg 9] (from=
 caller's outgoing r12-48)
>    ---- incoming/outgoing boundary   ||||  ---- incoming/outgoing boundar=
y
>    r12-24: [outgoing arg 6 to callee]+|||  ...
>    r12-32: [outgoing arg 7 to callee]-+||
>    r12-40: [outgoing arg 8 to callee]--+|
>    r12-48: [outgoing arg 9 to callee]---+
>
> Global subprogs with >5 args are not yet supported.
>
>   [1] https://github.com/llvm/llvm-project/pull/189060
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h          |   2 +
>  include/linux/bpf_verifier.h |  15 ++-
>  kernel/bpf/btf.c             |  14 +-
>  kernel/bpf/verifier.c        | 248 ++++++++++++++++++++++++++++++++---
>  4 files changed, 257 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e24c4a2e95f7..a0a1e14e4394 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1666,6 +1666,8 @@ struct bpf_prog_aux {
>         u32 max_pkt_offset;
>         u32 max_tp_access;
>         u32 stack_depth;
> +       u16 incoming_stack_arg_depth;
> +       u16 stack_arg_depth; /* both incoming and max outgoing of stack a=
rguments */
>         u32 id;
>         u32 func_cnt; /* used by non-func prog as the number of func prog=
s */
>         u32 real_func_cnt; /* includes hidden progs, only used for JIT an=
d freeing progs */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..a260610cd1c1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -268,6 +268,11 @@ struct bpf_retval_range {
>         bool return_32bit;
>  };
>
> +struct bpf_stack_arg_state {
> +       struct bpf_reg_state spilled_ptr; /* for spilled scalar/pointer s=
emantics */
> +       u8 slot_type[BPF_REG_SIZE];
> +};
> +
>  /* state of the program:
>   * type of all registers and stack info
>   */
> @@ -319,6 +324,10 @@ struct bpf_func_state {
>          * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>          */
>         int allocated_stack;
> +
> +       u16 stack_arg_depth; /* Size of incoming + max outgoing stack arg=
s in bytes. */
> +       u16 incoming_stack_arg_depth; /* Size of incoming stack args in b=
ytes. */
> +       struct bpf_stack_arg_state *stack_arg_slots;
>  };
>
>  #define MAX_CALL_FRAMES 8
> @@ -674,10 +683,12 @@ struct bpf_subprog_info {
>         bool keep_fastcall_stack: 1;
>         bool changes_pkt_data: 1;
>         bool might_sleep: 1;
> -       u8 arg_cnt:3;
> +       u8 arg_cnt:4;
>
>         enum priv_stack_mode priv_stack_mode;
> -       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +       struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> +       u16 incoming_stack_arg_depth;
> +       u16 outgoing_stack_arg_depth;
>  };
>
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..c5f3aa05d5a3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7887,13 +7887,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>         }
>         args =3D (const struct btf_param *)(t + 1);
>         nargs =3D btf_type_vlen(t);
> -       if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> -               if (!is_global)
> -                       return -EINVAL;
> -               bpf_log(log, "Global function %s() with %d > %d args. Bug=
gy compiler.\n",
> +       if (nargs > MAX_BPF_FUNC_ARGS) {
> +               bpf_log(log, "Function %s() with %d > %d args not support=
ed.\n",
> +                       tname, nargs, MAX_BPF_FUNC_ARGS);
> +               return -EINVAL;
> +       }
> +       if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
> +               bpf_log(log, "Global function %s() with %d > %d args not =
supported.\n",
>                         tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>                 return -EINVAL;
>         }
> +       if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +               sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_R=
EG_ARGS) * BPF_REG_SIZE;
> +
>         /* check that function is void or returns int, exception cb also =
requires this */
>         t =3D btf_type_by_id(btf, t->type);
>         while (btf_type_is_modifier(t))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..d424fe611ef8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1488,6 +1488,19 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
>                 return -ENOMEM;
>
>         dst->allocated_stack =3D src->allocated_stack;
> +
> +       /* copy stack_arg_slots state */
> +       n =3D src->stack_arg_depth / BPF_REG_SIZE;
> +       if (n) {
> +               dst->stack_arg_slots =3D copy_array(dst->stack_arg_slots,=
 src->stack_arg_slots, n,
> +                                                 sizeof(struct bpf_stack=
_arg_state),
> +                                                 GFP_KERNEL_ACCOUNT);
> +               if (!dst->stack_arg_slots)
> +                       return -ENOMEM;
> +
> +               dst->stack_arg_depth =3D src->stack_arg_depth;
> +               dst->incoming_stack_arg_depth =3D src->incoming_stack_arg=
_depth;
> +       }
>         return 0;
>  }
>
> @@ -1529,6 +1542,25 @@ static int grow_stack_state(struct bpf_verifier_en=
v *env, struct bpf_func_state
>         return 0;
>  }
>
> +static int grow_stack_arg_slots(struct bpf_verifier_env *env,
> +                               struct bpf_func_state *state, int size)
> +{
> +       size_t old_n =3D state->stack_arg_depth / BPF_REG_SIZE, n;
> +
> +       size =3D round_up(size, BPF_REG_SIZE);
> +       n =3D size / BPF_REG_SIZE;
> +       if (old_n >=3D n)
> +               return 0;
> +
> +       state->stack_arg_slots =3D realloc_array(state->stack_arg_slots, =
old_n, n,
> +                                              sizeof(struct bpf_stack_ar=
g_state));
> +       if (!state->stack_arg_slots)
> +               return -ENOMEM;
> +
> +       state->stack_arg_depth =3D size;
> +       return 0;
> +}
> +
>  /* Acquire a pointer id from the env and update the state->refs to inclu=
de
>   * this new pointer reference.
>   * On success, returns a valid pointer id to associate with the register
> @@ -1699,6 +1731,7 @@ static void free_func_state(struct bpf_func_state *=
state)
>  {
>         if (!state)
>                 return;
> +       kfree(state->stack_arg_slots);
>         kfree(state->stack);
>         kfree(state);
>  }
> @@ -5848,6 +5881,101 @@ static int check_stack_write(struct bpf_verifier_=
env *env,
>         return err;
>  }
>
> +/* Validate that a stack arg access is 8-byte sized and aligned. */
> +static int check_stack_arg_access(struct bpf_verifier_env *env,
> +                                 struct bpf_insn *insn, const char *op)
> +{
> +       int size =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> +
> +       if (size !=3D BPF_REG_SIZE) {
> +               verbose(env, "stack arg %s must be %d bytes, got %d\n",
> +                       op, BPF_REG_SIZE, size);
> +               return -EINVAL;
> +       }
> +       if (insn->off % BPF_REG_SIZE) {
> +               verbose(env, "stack arg %s offset %d not aligned to %d\n"=
,
> +                       op, insn->off, BPF_REG_SIZE);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +/* Check that a stack arg slot has been properly initialized. */
> +static bool is_stack_arg_slot_initialized(struct bpf_func_state *state, =
int spi)
> +{
> +       u8 type;
> +
> +       if (spi >=3D (int)(state->stack_arg_depth / BPF_REG_SIZE))
> +               return false;
> +       type =3D state->stack_arg_slots[spi].slot_type[BPF_REG_SIZE - 1];
> +       return type =3D=3D STACK_SPILL || type =3D=3D STACK_MISC;
> +}
> +
> +/*
> + * Write a value to the stack arg area.
> + * off is the negative offset from the stack arg frame pointer.
> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_write(struct bpf_verifier_env *env, struct bp=
f_func_state *state,
> +                                int off, int value_regno)
> +{
> +       int spi =3D (-off - 1) / BPF_REG_SIZE;
> +       struct bpf_func_state *cur;
> +       struct bpf_reg_state *reg;
> +       int i, err;
> +       u8 type;
> +
> +       err =3D grow_stack_arg_slots(env, state, -off);
> +       if (err)
> +               return err;
> +
> +       cur =3D env->cur_state->frame[env->cur_state->curframe];
> +       if (value_regno >=3D 0) {
> +               reg =3D &cur->regs[value_regno];
> +               state->stack_arg_slots[spi].spilled_ptr =3D *reg;
> +               type =3D is_spillable_regtype(reg->type) ? STACK_SPILL : =
STACK_MISC;
> +               for (i =3D 0; i < BPF_REG_SIZE; i++)
> +                       state->stack_arg_slots[spi].slot_type[i] =3D type=
;
> +       } else {
> +               /* BPF_ST: store immediate, treat as scalar */
> +               reg =3D &state->stack_arg_slots[spi].spilled_ptr;
> +               reg->type =3D SCALAR_VALUE;
> +               __mark_reg_known(reg, (u32)env->prog->insnsi[env->insn_id=
x].imm);
> +               for (i =3D 0; i < BPF_REG_SIZE; i++)
> +                       state->stack_arg_slots[spi].slot_type[i] =3D STAC=
K_MISC;
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Read a value from the stack arg area.
> + * off is the negative offset from the stack arg frame pointer.
> + * Callers ensures off is 8-byte aligned and size is BPF_REG_SIZE.
> + */
> +static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
> +                               int off, int dst_regno)
> +{
> +       int spi =3D (-off - 1) / BPF_REG_SIZE;
> +       struct bpf_func_state *cur;
> +       u8 *stype;
> +
> +       if (-off > state->stack_arg_depth) {
> +               verbose(env, "invalid read from stack arg off %d depth %d=
\n",
> +                       off, state->stack_arg_depth);
> +               return -EACCES;
> +       }
> +
> +       stype =3D state->stack_arg_slots[spi].slot_type;
> +       cur =3D env->cur_state->frame[env->cur_state->curframe];
> +
> +       if (stype[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL)
> +               copy_register_state(&cur->regs[dst_regno],
> +                                   &state->stack_arg_slots[spi].spilled_=
ptr);
> +       else
> +               mark_reg_unknown(env, cur->regs, dst_regno);
> +       return 0;
> +}
> +
>  static int check_map_access_type(struct bpf_verifier_env *env, u32 regno=
,
>                                  int off, int size, enum bpf_access_type =
type)
>  {
> @@ -8022,10 +8150,23 @@ static int check_load_mem(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>                           bool strict_alignment_once, bool is_ldsx,
>                           bool allow_trust_mismatch, const char *ctx)
>  {
> +       struct bpf_verifier_state *vstate =3D env->cur_state;
> +       struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         enum bpf_reg_type src_reg_type;
>         int err;
>
> +       /* Handle stack arg access */
> +       if (insn->src_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
> +               err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK)=
;
> +               if (err)
> +                       return err;
> +               err =3D check_stack_arg_access(env, insn, "read");
> +               if (err)
> +                       return err;
> +               return check_stack_arg_read(env, state, insn->off, insn->=
dst_reg);
> +       }
> +
>         /* check src operand */
>         err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
>         if (err)
> @@ -8054,10 +8195,23 @@ static int check_load_mem(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
>  static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
>                            bool strict_alignment_once)
>  {
> +       struct bpf_verifier_state *vstate =3D env->cur_state;
> +       struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         enum bpf_reg_type dst_reg_type;
>         int err;
>
> +       /* Handle stack arg write */
> +       if (insn->dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
> +               err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
> +               if (err)
> +                       return err;
> +               err =3D check_stack_arg_access(env, insn, "write");
> +               if (err)
> +                       return err;
> +               return check_stack_arg_write(env, state, insn->off, insn-=
>src_reg);
> +       }
> +
>         /* check src1 operand */
>         err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
>         if (err)
> @@ -10940,8 +11094,10 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                            int *insn_idx)
>  {
>         struct bpf_verifier_state *state =3D env->cur_state;
> +       struct bpf_subprog_info *caller_info;
>         struct bpf_func_state *caller;
>         int err, subprog, target_insn;
> +       u16 callee_incoming;
>
>         target_insn =3D *insn_idx + insn->imm + 1;
>         subprog =3D find_subprog(env, target_insn);
> @@ -10993,6 +11149,15 @@ static int check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                 return 0;
>         }
>
> +       /*
> +        * Track caller's outgoing stack arg depth (max across all callee=
s).
> +        * This is needed so the JIT knows how much stack arg space to al=
locate.
> +        */
> +       caller_info =3D &env->subprog_info[caller->subprogno];
> +       callee_incoming =3D env->subprog_info[subprog].incoming_stack_arg=
_depth;
> +       if (callee_incoming > caller_info->outgoing_stack_arg_depth)
> +               caller_info->outgoing_stack_arg_depth =3D callee_incoming=
;
> +
>         /* for regular function entry setup new frame and continue
>          * from that frame.
>          */
> @@ -11048,13 +11213,41 @@ static int set_callee_state(struct bpf_verifier=
_env *env,
>                             struct bpf_func_state *caller,
>                             struct bpf_func_state *callee, int insn_idx)
>  {

Taking note when reading the change to set_callee_state():

The function is not called when handling callback function, which uses
push_callback_call() -> setup_func_entry() -> callback specific
set_callee_state_cb. So caller stack argument will not be transferred.

This should be fine as callee's stack_arg_depth will remain zero and
then when callee tries to do r12 based load, check_stack_arg_read()
should reject the program. Not sure if this needs a selftest since
callbacks' set_callee_state_cb will also transfer register state very
intentionally.

> -       int i;
> +       struct bpf_subprog_info *callee_info;
> +       int i, err;
>
>         /* copy r1 - r5 args that callee can access.  The copy includes p=
arent
>          * pointers, which connects us up to the liveness chain
>          */
>         for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
>                 callee->regs[i] =3D caller->regs[i];
> +
> +       /*
> +        * Transfer stack args from caller's outgoing area to callee's in=
coming area.
> +        * Caller wrote outgoing args at offsets '-(incoming + 8)', '-(in=
coming + 16)', ...
> +        * These outgoing args will go to callee's incoming area.
> +        */
> +       callee_info =3D &env->subprog_info[callee->subprogno];
> +       if (callee_info->incoming_stack_arg_depth) {
> +               int caller_incoming_slots =3D caller->incoming_stack_arg_=
depth / BPF_REG_SIZE;
> +               int callee_incoming_slots =3D callee_info->incoming_stack=
_arg_depth / BPF_REG_SIZE;
> +
> +               callee->incoming_stack_arg_depth =3D callee_info->incomin=
g_stack_arg_depth;
> +               err =3D grow_stack_arg_slots(env, callee, callee_info->in=
coming_stack_arg_depth);
> +               if (err)
> +                       return err;
> +
> +               for (i =3D 0; i < callee_incoming_slots; i++) {
> +                       int caller_spi =3D i + caller_incoming_slots;
> +
> +                       if (!is_stack_arg_slot_initialized(caller, caller=
_spi)) {
> +                               verbose(env, "stack arg#%d not properly i=
nitialized\n",
> +                                       i + 1 + MAX_BPF_FUNC_REG_ARGS);
> +                               return -EINVAL;
> +                       }
> +                       callee->stack_arg_slots[i] =3D caller->stack_arg_=
slots[caller_spi];
> +               }
> +       }
>         return 0;
>  }
>
> @@ -21262,23 +21455,37 @@ static int do_check_insn(struct bpf_verifier_en=
v *env, bool *do_print_state)
>                         verbose(env, "BPF_ST uses reserved fields\n");
>                         return -EINVAL;
>                 }
> -               /* check src operand */
> -               err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> -               if (err)
> -                       return err;
>
> -               dst_reg_type =3D cur_regs(env)[insn->dst_reg].type;
> +               /* Handle stack arg write (store immediate) */
> +               if (insn->dst_reg =3D=3D BPF_REG_STACK_ARG_BASE) {
> +                       struct bpf_verifier_state *vstate =3D env->cur_st=
ate;
> +                       struct bpf_func_state *state =3D vstate->frame[vs=
tate->curframe];
>
> -               /* check that memory (dst_reg + off) is writeable */
> -               err =3D check_mem_access(env, env->insn_idx, insn->dst_re=
g,
> -                                      insn->off, BPF_SIZE(insn->code),
> -                                      BPF_WRITE, -1, false, false);
> -               if (err)
> -                       return err;
> +                       err =3D check_stack_arg_access(env, insn, "write"=
);
> +                       if (err)
> +                               return err;
> +                       err =3D check_stack_arg_write(env, state, insn->o=
ff, -1);
> +                       if (err)
> +                               return err;
> +               } else {
> +                       /* check src operand */
> +                       err =3D check_reg_arg(env, insn->dst_reg, SRC_OP)=
;
> +                       if (err)
> +                               return err;
>
> -               err =3D save_aux_ptr_type(env, dst_reg_type, false);
> -               if (err)
> -                       return err;
> +                       dst_reg_type =3D cur_regs(env)[insn->dst_reg].typ=
e;
> +
> +                       /* check that memory (dst_reg + off) is writeable=
 */
> +                       err =3D check_mem_access(env, env->insn_idx, insn=
->dst_reg,
> +                                              insn->off, BPF_SIZE(insn->=
code),
> +                                              BPF_WRITE, -1, false, fals=
e);
> +                       if (err)
> +                               return err;
> +
> +                       err =3D save_aux_ptr_type(env, dst_reg_type, fals=
e);
> +                       if (err)
> +                               return err;
> +               }
>         } else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
>                 u8 opcode =3D BPF_OP(insn->code);
>
> @@ -22974,8 +23181,14 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>         int err, num_exentries;
>         int old_len, subprog_start_adjustment =3D 0;
>
> -       if (env->subprog_cnt <=3D 1)
> +       if (env->subprog_cnt <=3D 1) {
> +               /*
> +                * Even without subprogs, kfunc calls with >5 args need s=
tack arg space
> +                * allocated by the root program.
> +                */
> +               prog->aux->stack_arg_depth =3D env->subprog_info[0].outgo=
ing_stack_arg_depth;
>                 return 0;
> +       }
>
>         for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) =
{
>                 if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
> @@ -23065,6 +23278,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>
>                 func[i]->aux->name[0] =3D 'F';
>                 func[i]->aux->stack_depth =3D env->subprog_info[i].stack_=
depth;
> +               func[i]->aux->incoming_stack_arg_depth =3D env->subprog_i=
nfo[i].incoming_stack_arg_depth;
> +               func[i]->aux->stack_arg_depth =3D env->subprog_info[i].in=
coming_stack_arg_depth +
> +                                               env->subprog_info[i].outg=
oing_stack_arg_depth;
>                 if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STAC=
K_ADAPTIVE)
>                         func[i]->aux->jits_use_priv_stack =3D true;
>
> --
> 2.52.0
>
>
