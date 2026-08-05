Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951133343C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949637; cv=pass; b=X7/HgVOKU7Xl3YN0WVfPDwhJrf/U0QD0NEGDfsr7h5tbpbqBjLrjp9VjVIBX6NE9BydZxFwJNCz3jUHhSa5sm1JXHUSwdkZPInmzmI99TO0tfoPNz4kkHCr5tIvC/gI84EZf1KKuxGwXRz27nEoIcflwSB+X85z81cEaqMEmQhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949637; c=relaxed/simple;
	bh=Gezi6BbIKhW4i5iJ/NDjMJqfWMtA0UJNv+OpFvKKCyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXn1p3k4/cRf8TAEmFbSP2NyKl9ZVwEIKmOQEoDB5XPK4KjYs/PKRNoQ2xZzVX7FxZzHCwXxzuF5vqkOus8GPnR9cmIuAhep53PjiIxhmaAKmXYXKCx97UIBh2H5GkM3yF65DtEpiBoRjXVwxnUj2rQ8QMIx6hojhaarJrQONQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olzggQdp; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olzggQdp"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-81f64e8dfbcso18452667b3.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 10:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785949635; cv=none;
        d=google.com; s=arc-20260327;
        b=fB4etB+olZKR8a/eF5t4al1hzupcsetjDy+EN9NyrB7JI7eNoMAifsFRyW8VVJyej0
         9h2ptBmaNkndbQ0d6xCgElFMU4B0zBDiZwiDMTSLdt1Z/E1oMGN9S0ElnWMuhpYANbdF
         U9hD4BroaDoH3sCPxNvhMXrqRSjSjCCLkgwo71FuwH212w3z4lb7nn93ZMn6iH/m8+3E
         GmRyyBZSv0CrccA7TEoZav7/2u2+SBwikRF9vU78Bfin5D7rs59HJO/Tat90f1kwUN9W
         svIq0TXWCXjURGsCdyCXcdbnowfWlkFktBDZiH4im5+uI0Ceh2ICI+Gh+Jvfm7wTt8wr
         8q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aocA4QAqPUPw75KBqGrjt/D7G8ta520DXVIpg5Z7p24=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=nw0dztSiUIEYBrZI8ayKpeZdLw5d9iqZ42l6lq/lK6wKpD4aAUjI9Hmpd6Q3t1nhO3
         wDC+q1SgYki48vl5NCn0J9bD4X/ibE376x0ETHrXaSR4cQDl9BdAcCJAw2Nph1iCVqEx
         Fyw+nko+q/SuXC8E/3Y5VVPtwjAqxTYim2Iq/s4v+7DlCYNAo6I4l7AS4Immu/pXYzGo
         dxnA7YB8hwDb1afQxVtZ7cA8ecYofXHWmwwlVwlEWvCLLddyo3beOfbBUft/Cr+u2Vv9
         xsOTEsyUmR+5nap6GW/K0YxLSVkj5+HmamRMkle0ew9B4D9N7HW8JIqACFpKMea/XwUW
         GYKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785949635; x=1786554435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aocA4QAqPUPw75KBqGrjt/D7G8ta520DXVIpg5Z7p24=;
        b=olzggQdptq5fLwbCZJTfB8Cc7aAGpG4pTPGNky6N1JounjiT4WlqiMrxG2jNuu2ROC
         plCZFPtdapYjQjfyMoyWK+UqDvQa/ovL+8D2Lyoi92Nxu/Wc+7h0w7HW+tyzP7AL4H5e
         QQqI0h3FxnPx8UMGrnc3iF0JkaReWCZKDR5k4qw5hBjQzgx9kgWYhnDIOMksYeI9Dmc1
         0BVx6hw7G8Wa2Jpj62Ml8bmHbS+yUIPidM89GNDlLGoyEABVfC1o93C3s+QIbNimYxkt
         /znowHut4h0GEAq+lCkmWPTohfjbFmxzsy+SYGgqUyjuA574rEftXM4Jthz9ZoHynix0
         q59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785949635; x=1786554435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aocA4QAqPUPw75KBqGrjt/D7G8ta520DXVIpg5Z7p24=;
        b=P3wOTc94gayUoW8e8sH7V7E2iNG8K7c0tDDZ8CYQHoK0TFk44O2RrSRB0ShFvdWh8o
         G1HlKZrOCqGZeoioDJCR3TswhWTrMz1FvcIwka+ZymqAcF8IEwMffjGgozbK42ESOi8y
         xRob5LJQMxtjfiqh+vHD3WG3s+V8x5tQQpB2LZRVf/Ffzpv5CbpA4/sDgY9ZNPsTPIwZ
         e4e4Z4NhatBsS9eOHttY7Ao6IkTbOiKyGG7SubTPO+Bh2kGAc/er5edxJUJ+EU/oA5mx
         ePXbg+xT3q7QPdYIMKrwiYBodic49xhC0e9jpgaw8QlbdaOla8MEg4k4IHA+etJbhvj4
         dVRg==
X-Gm-Message-State: AOJu0YxYP0iSm4mQydlX9zzToopArJi91o3g+fgtaAoyxuZYmggz+4gi
	sdsrtegkxkGEEMA3Vl4llnFvdKgOpOuW/sLebwqkupHxy2mqLFppGc99nMmqiRhPWf3XNLk12KJ
	mQ8YdA2J+RJF4PPjJY7ySgS85Kc5ue8A=
X-Gm-Gg: AR+sD10A6uhUTGAaUQyYo0tSbMEmPUl4KBE0jhW+cl4eVz/UWRJ9XZyyWcDl1WL9Obf
	6NC0ZP4ewjM0UiweGkNEs/edZgC1c1Mty2Od8mxURjQZPEfJnlcdyvif5Gfb0J8HHSGW2SxO4Hv
	hwQJZjmUAQqFGSG4dxZRcb6wa+zu6WNXVzbZAXLJgUNcn1W8wPiqTM7YjFVfSL36fRwpXijx2Nu
	gEKI3FkVRnD8zN2uLDP2uvLiR6bPkzaSPYDHaYPMsX1Dz5cBCj9i1UMV0MivEtdl7BE3S6WpX2b
	TC1547THnbBJnmmPbiiPjtrSRxy6vBxrM4fqByH04edT
X-Received: by 2002:a05:690c:3510:b0:80d:c24f:b790 with SMTP id
 00721157ae682-8201f0b7b51mr53077857b3.5.1785949634856; Wed, 05 Aug 2026
 10:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803125115.2264733-1-memxor@gmail.com> <20260803125115.2264733-2-memxor@gmail.com>
 <CAMB2axPCF12OGokrt3R5d9f8Y9JxvGfF7LaNRHW_7bOp6aLnuA@mail.gmail.com> <DKH4QQFMWZJ9.DVYV5B6WWOWV@gmail.com>
In-Reply-To: <DKH4QQFMWZJ9.DVYV5B6WWOWV@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 5 Aug 2026 10:07:03 -0700
X-Gm-Features: AUfX_mxljH-KN692g6FUWGpew5Xe-WyHAxI8c_IPzRM6febyWEGnqh7GOTW9cgo
Message-ID: <CAMB2axNK=uzUQ9GYQo7gEGoyeet0pv4aJo4MKkjtO-FQjPBWDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Support __arena and __arena_nullable
 kfunc argument suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:53=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Tue Aug 4, 2026 at 7:42 PM CEST, Amery Hung wrote:
> > On Mon, Aug 3, 2026 at 6:12=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> >>
> >> From: Tejun Heo <tj@kernel.org>
> >>
> >> Passing an arena pointer to a kfunc takes two steps today. There is no
> >> arena pointer argument type, so the pointer crosses the boundary as a
> >> bare scalar, and the kfunc then offsets it by the arena base and casts
> >> it before it can touch the memory. Every such kfunc open-codes the sam=
e
> >> translation.
> >>
> >> Add the __arena and __arena_nullable argument suffixes to make this mo=
re
> >> convenient. The kfunc declares the parameter by its real pointer type
> >> and dereferences it directly, with the JIT rebasing the value at the
> >> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: =
the
> >> u32 offset stays within the guard-padded arena kernel mapping, and a
> >> fault on an unpopulated page recovers through the per-arena scratch
> >> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
> >> matching global subprog arena arguments.
> >>
> >> __arena rebases unconditionally, so the kfunc never sees NULL and a
> >> value with zero in the low 32 bits arrives as the arena base.
> >> __arena_nullable preserves NULL for optional arguments by skipping the
> >> rebase when the truncated value, arena offset 0, is zero. Keeping the
> >> plain form NULL-free saves the NULL test on every call.
> >>
> >> This patch adds the verifier side: the suffixes are recognized in
> >> check_kfunc_args() and distilled into argument flags in the function
> >> model stored in the kfunc descriptor. JITs retrieve the model while
> >> emitting the call, avoiding per-call state in insn_aux_data.
> >>
> >> JITs declare support with bpf_jit_supports_arena_args() and verificati=
on
> >> fails with -ENOTSUPP elsewhere.
> >>
> >> Signed-off-by: Tejun Heo <tj@kernel.org>
> >> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> ---
> >>  Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++++++++
> >>  include/linux/bpf.h          |  6 ++++++
> >>  include/linux/filter.h       |  1 +
> >>  kernel/bpf/btf.c             | 18 +++++++++++++++-
> >>  kernel/bpf/core.c            |  5 +++++
> >>  kernel/bpf/verifier.c        | 40 +++++++++++++++++++++++++++++++++++=
-
> >>  6 files changed, 97 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.r=
st
> >> index cbde86d082cc..8e84484636c5 100644
> >> --- a/Documentation/bpf/kfuncs.rst
> >> +++ b/Documentation/bpf/kfuncs.rst
> >> @@ -278,6 +278,33 @@ An example is given below::
> >>                  ...
> >>          }
> >>
> >> +2.3.8 __arena and __arena_nullable Annotations
> >> +----------------------------------------------
> >> +
> >> +Both annotations indicate that the pointer argument points into the
> >> +calling program's arena. The JIT rebases the value at the call site s=
o
> >> +the kfunc receives a directly dereferenceable kernel address, subject=
 to
> >> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
> >> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked acce=
ss).
> >> +
> >> +With ``__arena`` the rebase is unconditional and the argument is neve=
r
> >> +NULL: a value whose lower 32 bits are zero arrives as the arena base
> >> +address (arena offset 0). The kfunc must not check the argument for N=
ULL.
> >> +With ``__arena_nullable`` such a value arrives as NULL instead and th=
e
> >> +kfunc must check before dereferencing.
> >> +
> >> +An example is given below::
> >> +
> >> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
> >> +        {
> >> +        ...
> >> +        }
> >> +
> >> +Calling such a kfunc requires the program to use an arena map and a J=
IT with
> >> +arena argument support (currently x86-64); verification fails otherwi=
se. The
> >> +program can pass any value without compromising the kernel. A value t=
hat does
> >> +not point into the arena is a program bug.
> >> +
> >>  .. _BPF_kfunc_nodef:
> >>
> >>  2.4 Using an existing kernel function
> >> @@ -515,6 +542,8 @@ In order to accommodate such requirements, the ver=
ifier will enforce strict
> >>  PTR_TO_BTF_ID type matching if two types have the exact same name, wi=
th one
> >>  being suffixed with ``___init``.
> >>
> >> +.. _BPF_kfunc_arena_access:
> >> +
> >>  2.8 Accessing arena memory through kfunc arguments
> >>  --------------------------------------------------
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 356884587ae1..6da8a6be930c 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
> >>  /* The argument is signed. */
> >>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
> >>
> >> +/* The argument is an arena pointer. */
> >> +#define BTF_FMODEL_ARENA_ARG           BIT(2)
> >> +
> >> +/* The argument is nullable. */
> >> +#define BTF_FMODEL_NULLABLE_ARG                BIT(3)
> >> +
> >>  struct btf_func_model {
> >>         u8 ret_size;
> >>         u8 ret_flags;
> >> diff --git a/include/linux/filter.h b/include/linux/filter.h
> >> index 32d5297c557e..36ce3403fe59 100644
> >> --- a/include/linux/filter.h
> >> +++ b/include/linux/filter.h
> >> @@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
> >>  bool bpf_jit_supports_percpu_insn(void);
> >>  bool bpf_jit_supports_kfunc_call(void);
> >>  bool bpf_jit_supports_stack_args(void);
> >> +bool bpf_jit_supports_arena_args(void);
> >>  bool bpf_jit_supports_far_kfunc_call(void);
> >>  bool bpf_jit_supports_exceptions(void);
> >>  bool bpf_jit_supports_ptr_xchg(void);
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> index 5e8ac45ce56a..bf86df91a70b 100644
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >> @@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct =
btf_type *t)
> >>         return flags;
> >>  }
> >>
> >> +static u8 __get_arg_fmodel_flags(const struct btf *btf,
> >> +                                const struct btf_param *arg,
> >> +                                const struct btf_type *t)
> >> +{
> >> +       u8 flags =3D __get_type_fmodel_flags(t);
> >> +
> >> +       if (btf_param_match_suffix(btf, arg, "__arena") ||
> >> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
> >> +               flags |=3D BTF_FMODEL_ARENA_ARG;
> >> +       if (btf_param_match_suffix(btf, arg, "__nullable") ||
> >> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
> >> +               flags |=3D BTF_FMODEL_NULLABLE_ARG;
> >> +
> >> +       return flags;
> >> +}
> >> +
> >>  int btf_distill_func_proto(struct bpf_verifier_log *log,
> >>                            struct btf *btf,
> >>                            const struct btf_type *func,
> >> @@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_l=
og *log,
> >>                         return -EINVAL;
> >>                 }
> >>                 m->arg_size[i] =3D ret;
> >> -               m->arg_flags[i] =3D __get_type_fmodel_flags(t);
> >> +               m->arg_flags[i] =3D __get_arg_fmodel_flags(btf, &args[=
i], t);
> >>         }
> >>         m->nr_args =3D nargs;
> >>         return 0;
> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >> index e2076667b245..a3e1fae32eac 100644
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >> @@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
> >>         return false;
> >>  }
> >>
> >> +bool __weak bpf_jit_supports_arena_args(void)
> >> +{
> >> +       return false;
> >> +}
> >> +
> >>  bool __weak bpf_jit_supports_far_kfunc_call(void)
> >>  {
> >>         return false;
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index b274004fccfd..4c50237f49f1 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -10907,6 +10907,16 @@ static bool is_kfunc_arg_irq_flag(const struc=
t btf *btf, const struct btf_param
> >>         return btf_param_match_suffix(btf, arg, "__irq_flag");
> >>  }
> >>
> >> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct bt=
f_param *arg)
> >> +{
> >> +       return btf_param_match_suffix(btf, arg, "__arena");
> >> +}
> >> +
> >> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const =
struct btf_param *arg)
> >> +{
> >> +       return btf_param_match_suffix(btf, arg, "__arena_nullable");
> >> +}
> >> +
> >
> > From the verifier's point of view, __arena and __arena_nullable all
> > maps to KF_ARG_PTR_TO_ARENA and require the same check so maybe
> > is_kfunc_arg_arena() alone with two suffix matching is good enough,
> > but it also doesn't hurt to have two separated functions.
> >
> >>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
> >>                                           const struct btf_param *arg,
> >>                                           const char *name)
> >> @@ -11127,6 +11137,7 @@ enum kfunc_ptr_arg_type {
> >>         KF_ARG_PTR_TO_IRQ_FLAG,
> >>         KF_ARG_PTR_TO_RES_SPIN_LOCK,
> >>         KF_ARG_PTR_TO_TASK_WORK,
> >> +       KF_ARG_PTR_TO_ARENA,
> >>  };
> >>
> >>  enum special_kfunc_type {
> >> @@ -11412,7 +11423,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *en=
v, struct bpf_call_arg_meta *meta,
> >>                         reg_arg_name(env, argno), btf_type_str(t));
> >>                 return -EINVAL;
> >>         }
> >> -
> >>         ref_t =3D btf_type_skip_modifiers(meta->btf, t->type, NULL);
> >>         ref_tname =3D btf_name_by_offset(meta->btf, ref_t->name_off);
> >>
> >> @@ -11461,6 +11471,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *en=
v, struct bpf_call_arg_meta *meta,
> >>                 arg_type =3D KF_ARG_PTR_TO_RES_SPIN_LOCK;
> >>         else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
> >>                 arg_type =3D KF_ARG_PTR_TO_CALLBACK;
> >> +       else if (is_kfunc_arg_arena(meta->btf, &args[arg]) ||
> >> +                is_kfunc_arg_arena_nullable(meta->btf, &args[arg]))
> >> +               arg_type =3D KF_ARG_PTR_TO_ARENA;
> >>         else if (arg + 1 < nargs &&
> >>                  (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
> >>                   is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1=
]))) {
> >> @@ -12154,6 +12167,31 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_call_arg_me
> >>
> >>                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL)=
;
> >>
> >> +               if (base_type(kf_arg_type) =3D=3D KF_ARG_PTR_TO_ARENA)=
 {
> >> +                       if (!bpf_jit_supports_arena_args()) {
> >> +                               verbose(env, "JIT does not support kfu=
nc %s() with arena pointer arguments\n",
> >> +                                       func_name);
> >> +                               return -ENOTSUPP;
> >> +                       }
> >
> > nit: JIT and register-based arg check can be done earlier in
> > get_kfunc_arg_type(). We probably will want a consolidated pass
> > validating bpf_func_proto.
> >
>
> I moved it up there. We still have prog aux argument doing stack argument
> rejection later, but I will let you figure out the right placement when y=
ou
> rework these bits.

Sounds good to me. The placement is not really a blocker.

>
> Only thing left here now is the register type check.
>
> >> +                       if (!env->prog->aux->arena) {
> >> +                               verbose(env,
> >> +                                       "%s arena pointer requires a p=
rogram with an associated arena\n",
> >> +                                       reg_arg_name(env, argno));
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       if (regno < 0) {
> >> +                               verbose(env, "%s arena pointer cannot =
be a stack argument\n",
> >> +                                       reg_arg_name(env, argno));
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       if (reg->type !=3D PTR_TO_ARENA && reg->type !=
=3D SCALAR_VALUE) {
> >> +                               verbose(env, "%s is not a pointer to a=
rena or scalar\n",
> >> +                                       reg_arg_name(env, argno));
> >> +                               return -EINVAL;
> >> +                       }
> >> +                       continue;
> >> +               }
> >> +
> >
> > Can we move arena argument checking to the second switch case below?
> > It only takes adding one condition below.
> >
> > This help reduce churn in the future when check_kfunc_args() also
> > receieve check_reg_type().
> >
> >>                 if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) |=
| type_may_be_null(reg->type)) &&
> >>                     !is_kfunc_arg_nullable(meta->btf, &args[i])) {
> >>                         verbose(env, "Possibly NULL pointer passed to =
trusted %s\n",
> >
> >   if (btf_type_is_ptr(t) && base_type(kf_arg_type) !=3D KF_ARG_PTR_TO_A=
RENA &&
> >       (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
> >       !type_may_be_null(kf_arg_type)) {
> >           verbose(env, "Possibly NULL pointer passed to trusted %s\n",
> >
> >
>
> To simplify this and avoid special casing, I changed the kf_arg_type to
> KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL, since known NULL is kosher for both=
 cases
> and we place no static constraints on the precise value.

Make sense. Thanks for tweaking it!
