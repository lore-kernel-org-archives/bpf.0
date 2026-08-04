Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327E45FFD1
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865339; cv=pass; b=rWf4bK759cw/LfK4MC6GJlcFDhAhwL42uetEniol9Lm2heJGyPXpTYvb0xxGAHwDnyEPwHJRt01/gSzjJkVXXPfWs3aLZO3p4pFkWVJqk26NN9qJDJ8CQZH5BRSnOcm9jp4YquD1kvHSXg2LdwHFC9u67lJh1CJ/21cEgYjBtps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865339; c=relaxed/simple;
	bh=1UbDvVnHrjweP/ajF6ocl6OhLoZyMNOLDKIJLKHoJf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlcElDkaKOX6LwItyughqhVdzMWJTHa4rDY20Dj/wji2CEoawh+/E1qo+jL/0LgIyt1pkd517jUnsIWVIgZ3TV+AMihWW44WQz2mmkeuTu/RV9fBhW7DDmtGTqXv0D5wQKGkXnEfqllIerYV/K/hltiN/EJ7ur7Vr29zORY7Alo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwQXq00v; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwQXq00v"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-82011c59e66so2794187b3.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785865336; cv=none;
        d=google.com; s=arc-20260327;
        b=WAcol26uEbM6GpCbrrCiiLQ9v0toQTRH7fgDf0FSRAGzzBmsghKo/2blcYDhzcwwgf
         gbAw0ZPtLbntyk6qVA7Fx0e2UuIOlGdZ3M+WB7rieSC3ch7GSYXcic8Lw/lI+i1ZJimJ
         rkLC9uzMeLD3HXsqJzCHNa0eYwIj/5Nxx50Imc0UtHF+fDh4GkslpOVUAA6cdtP2ScvJ
         kDcHu3D01FPgMgbqGTO61ZVb2BLONNQ9rPgg8U/xGgK86/wRWWYDnsohDX19ZYQJVEVA
         Dlup/NCv/1BgFkuCw8FVL82aw6ovWMUrjo2yyRsSPMhnBurU6+Dav2Mk+zqrgQzNNh5E
         J8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+xQjxgsi6m5xbG/b8676mNsYGAKIDvgB8j5VSi85dg=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=mzjRqSTFh9g5wG+AqQ+RFxBUR14fHQUNNSrgd9yXeXTsxH0Yp6WPvibHJ8CjSFVg5o
         ImmJnjJaW67Mvli7eAurbBG/yC2zIhbu3LFgS0EBMztVacQl8MCJd2lXOC7U2JTPwoJI
         RzObA386YIPdzSU5lQgCKjGtpVs8rMzcPV+zkC91Vzg0tMs7IEK0Un8b3J4fafTaiggY
         V0P3mes8R+jKcRLiZeoGSQgaJy3eYELKOOJyu+p3q4cq0p47pwWhxWzFBJiiYGu61X9D
         1plrQLzzIHTIJPLlG/D0yqzH98HW4HyK6HWnuhyseP1KmYPahP7MVbxFbLOyPFiAFsme
         T5og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785865336; x=1786470136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+xQjxgsi6m5xbG/b8676mNsYGAKIDvgB8j5VSi85dg=;
        b=KwQXq00vE8p+EX4bBL4BFGdI6oNJ4Srm2a8sB12iAU4qcqpyJB7hwwpzH2PKp710Cz
         Nn4dwLLxT4s9sAQWTTb34kmOpr1Ew8RUJxYqKtAC8j0Zn8tan4fEQWewhA/MoxQb6VR0
         kfRWcGIbDZe2Zob0yYSFhWNBz8QKNYH6Q+NQ3nNowgNo7ny/Kab0rJMuOZsOUyMYRiUd
         rOkbiizA7dN7HzNHydUBRx9uzH87KzeidY8Thw+IYIYStkAYd41y62I+TX7ORMpqQeEu
         6N6Um+bDGUsFKSJHPuqzUKOMhyTSjZlFzQIqKX12yDm9Zv6BEWLHG1DnegxP/f2RDxlm
         L90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865336; x=1786470136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+xQjxgsi6m5xbG/b8676mNsYGAKIDvgB8j5VSi85dg=;
        b=aMwnxS7feBDPTn4tAletBQOO0iKa9khV59ni6uKMv9Dn379lHcu3a+RZ05j5apjR6d
         AwM21I7PDM4Ymj/shDugVORcOKpuM6zjYlODLFdOM2x4ktjU5vLv2KQzijkqYaElgYJq
         Ib288yWCFCS3/3KzN6CPKDNBrtqcff+b5qVpEaWVnuPc8eaF/40WRB/zkqAckBbryaxh
         m8m7Ue2H4CDsq0iecSpFPR3jYXH90IOlYPDqgqYgpkDw95Ll84VyX9WzU3dDPEsNMpPj
         3m8Gzx7sG9jsIY1xcaz4foDdMtfD9GV64f2IkqlkJvjkaUw6kESUgspGj3ul9BGTTg0e
         XdFA==
X-Gm-Message-State: AOJu0YxlRNrSsnffSdYqI0/HT/6N65NxahBO0o29F9sgi/UTy57QIEcr
	NQVpzSnroWUFHHTOeP4Zq1zcLb+rCOn3GbdV6K96hmFztikBhBAnfKD2aJfyQOEe3Ds1xz4J0/N
	nRIjKyN/cFL5GTADw1SfIT2FqvvJZX/U=
X-Gm-Gg: AR+sD120tuG0NZqqb0BpNbyIpQtBfCcGT1qpndicA4RVEQ64DtPNjgz2YjCbgCfaBo9
	7bhqH1uXuKJLTgUOr3JsfoV6oNkbY8AJUtc45OHb+VA8Qs5nTJXLB6WVe2qdf1X0O2aFZ8avtVy
	QwY/2++EBTxxTLIuRpDRfPhbV4MUwgXKqIsFRQLh6lQzmuiNvS2XhXI7avQ0CexwKejGrVB/xwX
	pSbwM2qIddT67lbtTJr9QDY8j8ehjSUiIWBsVgXoG1l4gAaDV0L4GyaaE4wn/B/C5VwvUeAHZn+
	kzv2NkZI88PyGYynA4eSS+Pjv49tNFlInRDOFz6/HzyJ
X-Received: by 2002:a05:690c:4886:b0:80b:9114:3b7b with SMTP id
 00721157ae682-82022323ae6mr1017847b3.17.1785865336403; Tue, 04 Aug 2026
 10:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803125115.2264733-1-memxor@gmail.com> <20260803125115.2264733-2-memxor@gmail.com>
In-Reply-To: <20260803125115.2264733-2-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Aug 2026 10:42:05 -0700
X-Gm-Features: AUfX_mzLoEqXKZ-1bhKqE2Ppy3rXRKjLXJBMpWSD-hZweax2m6NIzO6Nc8nwK7c
Message-ID: <CAMB2axPCF12OGokrt3R5d9f8Y9JxvGfF7LaNRHW_7bOp6aLnuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Support __arena and __arena_nullable
 kfunc argument suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:12=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> From: Tejun Heo <tj@kernel.org>
>
> Passing an arena pointer to a kfunc takes two steps today. There is no
> arena pointer argument type, so the pointer crosses the boundary as a
> bare scalar, and the kfunc then offsets it by the arena base and casts
> it before it can touch the memory. Every such kfunc open-codes the same
> translation.
>
> Add the __arena and __arena_nullable argument suffixes to make this more
> convenient. The kfunc declares the parameter by its real pointer type
> and dereferences it directly, with the JIT rebasing the value at the
> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: the
> u32 offset stays within the guard-padded arena kernel mapping, and a
> fault on an unpopulated page recovers through the per-arena scratch
> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
> matching global subprog arena arguments.
>
> __arena rebases unconditionally, so the kfunc never sees NULL and a
> value with zero in the low 32 bits arrives as the arena base.
> __arena_nullable preserves NULL for optional arguments by skipping the
> rebase when the truncated value, arena offset 0, is zero. Keeping the
> plain form NULL-free saves the NULL test on every call.
>
> This patch adds the verifier side: the suffixes are recognized in
> check_kfunc_args() and distilled into argument flags in the function
> model stored in the kfunc descriptor. JITs retrieve the model while
> emitting the call, avoiding per-call state in insn_aux_data.
>
> JITs declare support with bpf_jit_supports_arena_args() and verification
> fails with -ENOTSUPP elsewhere.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++++++++
>  include/linux/bpf.h          |  6 ++++++
>  include/linux/filter.h       |  1 +
>  kernel/bpf/btf.c             | 18 +++++++++++++++-
>  kernel/bpf/core.c            |  5 +++++
>  kernel/bpf/verifier.c        | 40 +++++++++++++++++++++++++++++++++++-
>  6 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index cbde86d082cc..8e84484636c5 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -278,6 +278,33 @@ An example is given below::
>                  ...
>          }
>
> +2.3.8 __arena and __arena_nullable Annotations
> +----------------------------------------------
> +
> +Both annotations indicate that the pointer argument points into the
> +calling program's arena. The JIT rebases the value at the call site so
> +the kfunc receives a directly dereferenceable kernel address, subject to
> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access)=
.
> +
> +With ``__arena`` the rebase is unconditional and the argument is never
> +NULL: a value whose lower 32 bits are zero arrives as the arena base
> +address (arena offset 0). The kfunc must not check the argument for NULL=
.
> +With ``__arena_nullable`` such a value arrives as NULL instead and the
> +kfunc must check before dereferencing.
> +
> +An example is given below::
> +
> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
> +        {
> +        ...
> +        }
> +
> +Calling such a kfunc requires the program to use an arena map and a JIT =
with
> +arena argument support (currently x86-64); verification fails otherwise.=
 The
> +program can pass any value without compromising the kernel. A value that=
 does
> +not point into the arena is a program bug.
> +
>  .. _BPF_kfunc_nodef:
>
>  2.4 Using an existing kernel function
> @@ -515,6 +542,8 @@ In order to accommodate such requirements, the verifi=
er will enforce strict
>  PTR_TO_BTF_ID type matching if two types have the exact same name, with =
one
>  being suffixed with ``___init``.
>
> +.. _BPF_kfunc_arena_access:
> +
>  2.8 Accessing arena memory through kfunc arguments
>  --------------------------------------------------
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 356884587ae1..6da8a6be930c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
>  /* The argument is signed. */
>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>
> +/* The argument is an arena pointer. */
> +#define BTF_FMODEL_ARENA_ARG           BIT(2)
> +
> +/* The argument is nullable. */
> +#define BTF_FMODEL_NULLABLE_ARG                BIT(3)
> +
>  struct btf_func_model {
>         u8 ret_size;
>         u8 ret_flags;
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 32d5297c557e..36ce3403fe59 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
>  bool bpf_jit_supports_percpu_insn(void);
>  bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_stack_args(void);
> +bool bpf_jit_supports_arena_args(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_jit_supports_exceptions(void);
>  bool bpf_jit_supports_ptr_xchg(void);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 5e8ac45ce56a..bf86df91a70b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct btf=
_type *t)
>         return flags;
>  }
>
> +static u8 __get_arg_fmodel_flags(const struct btf *btf,
> +                                const struct btf_param *arg,
> +                                const struct btf_type *t)
> +{
> +       u8 flags =3D __get_type_fmodel_flags(t);
> +
> +       if (btf_param_match_suffix(btf, arg, "__arena") ||
> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
> +               flags |=3D BTF_FMODEL_ARENA_ARG;
> +       if (btf_param_match_suffix(btf, arg, "__nullable") ||
> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
> +               flags |=3D BTF_FMODEL_NULLABLE_ARG;
> +
> +       return flags;
> +}
> +
>  int btf_distill_func_proto(struct bpf_verifier_log *log,
>                            struct btf *btf,
>                            const struct btf_type *func,
> @@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
>                         return -EINVAL;
>                 }
>                 m->arg_size[i] =3D ret;
> -               m->arg_flags[i] =3D __get_type_fmodel_flags(t);
> +               m->arg_flags[i] =3D __get_arg_fmodel_flags(btf, &args[i],=
 t);
>         }
>         m->nr_args =3D nargs;
>         return 0;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index e2076667b245..a3e1fae32eac 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
>         return false;
>  }
>
> +bool __weak bpf_jit_supports_arena_args(void)
> +{
> +       return false;
> +}
> +
>  bool __weak bpf_jit_supports_far_kfunc_call(void)
>  {
>         return false;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd..4c50237f49f1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10907,6 +10907,16 @@ static bool is_kfunc_arg_irq_flag(const struct b=
tf *btf, const struct btf_param
>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>  }
>
> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_p=
aram *arg)
> +{
> +       return btf_param_match_suffix(btf, arg, "__arena");
> +}
> +
> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const str=
uct btf_param *arg)
> +{
> +       return btf_param_match_suffix(btf, arg, "__arena_nullable");
> +}
> +

From the verifier's point of view, __arena and __arena_nullable all
maps to KF_ARG_PTR_TO_ARENA and require the same check so maybe
is_kfunc_arg_arena() alone with two suffix matching is good enough,
but it also doesn't hurt to have two separated functions.

>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>                                           const struct btf_param *arg,
>                                           const char *name)
> @@ -11127,6 +11137,7 @@ enum kfunc_ptr_arg_type {
>         KF_ARG_PTR_TO_IRQ_FLAG,
>         KF_ARG_PTR_TO_RES_SPIN_LOCK,
>         KF_ARG_PTR_TO_TASK_WORK,
> +       KF_ARG_PTR_TO_ARENA,
>  };
>
>  enum special_kfunc_type {
> @@ -11412,7 +11423,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>                         reg_arg_name(env, argno), btf_type_str(t));
>                 return -EINVAL;
>         }
> -
>         ref_t =3D btf_type_skip_modifiers(meta->btf, t->type, NULL);
>         ref_tname =3D btf_name_by_offset(meta->btf, ref_t->name_off);
>
> @@ -11461,6 +11471,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, =
struct bpf_call_arg_meta *meta,
>                 arg_type =3D KF_ARG_PTR_TO_RES_SPIN_LOCK;
>         else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
>                 arg_type =3D KF_ARG_PTR_TO_CALLBACK;
> +       else if (is_kfunc_arg_arena(meta->btf, &args[arg]) ||
> +                is_kfunc_arg_arena_nullable(meta->btf, &args[arg]))
> +               arg_type =3D KF_ARG_PTR_TO_ARENA;
>         else if (arg + 1 < nargs &&
>                  (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
>                   is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))=
) {
> @@ -12154,6 +12167,31 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>
>                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
>
> +               if (base_type(kf_arg_type) =3D=3D KF_ARG_PTR_TO_ARENA) {
> +                       if (!bpf_jit_supports_arena_args()) {
> +                               verbose(env, "JIT does not support kfunc =
%s() with arena pointer arguments\n",
> +                                       func_name);
> +                               return -ENOTSUPP;
> +                       }

nit: JIT and register-based arg check can be done earlier in
get_kfunc_arg_type(). We probably will want a consolidated pass
validating bpf_func_proto.

> +                       if (!env->prog->aux->arena) {
> +                               verbose(env,
> +                                       "%s arena pointer requires a prog=
ram with an associated arena\n",
> +                                       reg_arg_name(env, argno));
> +                               return -EINVAL;
> +                       }
> +                       if (regno < 0) {
> +                               verbose(env, "%s arena pointer cannot be =
a stack argument\n",
> +                                       reg_arg_name(env, argno));
> +                               return -EINVAL;
> +                       }
> +                       if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D=
 SCALAR_VALUE) {
> +                               verbose(env, "%s is not a pointer to aren=
a or scalar\n",
> +                                       reg_arg_name(env, argno));
> +                               return -EINVAL;
> +                       }
> +                       continue;
> +               }
> +

Can we move arena argument checking to the second switch case below?
It only takes adding one condition below.

This help reduce churn in the future when check_kfunc_args() also
receieve check_reg_type().

>                 if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) || t=
ype_may_be_null(reg->type)) &&
>                     !is_kfunc_arg_nullable(meta->btf, &args[i])) {
>                         verbose(env, "Possibly NULL pointer passed to tru=
sted %s\n",

  if (btf_type_is_ptr(t) && base_type(kf_arg_type) !=3D KF_ARG_PTR_TO_ARENA=
 &&
      (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
      !type_may_be_null(kf_arg_type)) {
          verbose(env, "Possibly NULL pointer passed to trusted %s\n",


> --
> 2.53.0
>
>
