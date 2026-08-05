Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC53CEB9A
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950195; cv=none; b=F4FginMUZ/udmr5ZdO5poHNijOxFJIqgMneZu9GFXkIV76sefANO5O+Mtn+JT4bc5p/UH3mC1iEFnjqI1RMf6DjR5+UO/jK9Y8NgjoTRvkZe6Iqsv3UNvn7/gszd56uoVdPQuNy7RrJ/iLucmvCEk7CwDWsuzMQfZ/rxqiRNct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950195; c=relaxed/simple;
	bh=dkAXb3JS8eFzlTK+lXfYVhA0cp3khb3vLH9zUwSJz48=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o339KQOM1bsN1DwyVMqMY97MaY3RMMFwHNYpI3UxbHb/73zY353Jl3GcXXmv6PKDK8YAhOSxLSlSCx0wPjlPKZtGVZpo6J17gtNyyczIuFBUzejomS4wVpapXwOeciORBEu0dYFSQ9vfQwy6PZZ5JBZkVw2vH/UwTNnJnDjNoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxOG5iQm; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxOG5iQm"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso284919f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950189; x=1786554989; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8VJc23U1dcq0+E12PLvQ8uLJBFzns9EgPSHZJXFX1rI=;
        b=dxOG5iQmEnoXGuUZUoCp+udtdyQ69E8uaf40l8xt2u2tEhMqVHl5v8omxnSoj+pbDU
         JtEvBgmbbWAWvPrNIenqVuw9rSarqAe2kM5gBX6vYB5MTSTpL4aXEFgk0ugUVbdnljhY
         CQM/bAksQXJYOv64hG9cz2TuAUY+uJjlA1xjezrxN4mnVB1Fq0PL3MItl08soVNDFpUy
         STcFrXjqmpX65FKZLYjW75CsKl7D1oFkEAVAN804C4T1OrlmVTn7nI5R8dckT+ghD+mZ
         Ww2tsixwnb7tTk74C8dxj+8fqkHE1NOvVo0c1TBO6eq+gK/UsLsVtY0zWf8TGqBOXPV3
         lDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950189; x=1786554989;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VJc23U1dcq0+E12PLvQ8uLJBFzns9EgPSHZJXFX1rI=;
        b=mU1777HdylJxoK6n2kR+0vfPekP4lts4/Suvj7eNgY+nsqicHHl13CroNB/eO62jTN
         wD1EBX/KiVSFG+KBUjA72MBBKCa4NOsmhg+L2Fda2CT5zXOCWM/TDnqcQ9jgopyI7DfD
         z261+0qQuKmNnpOA5NJchcmqgyOLGmWJ5B89NFsy7gQVYDb+W3b1znxTVwTl/pjLk9o6
         pVdQKHIMGAxv5dGlJ2wVHUCJBaNcj9FzL1WX2LdA6yjtdAEcnb+maSYlCjarq69iBEpY
         C7xu0YU3aAAbBzGlVfV5i3WCcIwcO6wsToevqS+vLLPi5e/rZgcu7MDOEs9fxMzz3jez
         5BqA==
X-Gm-Message-State: AOJu0YyxklQnhJBatQ14Bpc3/PYxOTLImXNh5w/pjRUc/7cVHF+Gs4BG
	k6R6+aG6eIRVuxC8p1uMmOd+8ginnVNr9pb0Z8bJL7/7bKMBGK6wZucnjDhQ1bYP
X-Gm-Gg: AR+sD12hC7DLWpfJbYqBbHtAb30oXhP1KgOQH4K7LPRxJJWxAmiYH4MntsoyaGhL0Is
	rNajLGToDXGZc0+GEHCQR5Jcx68o/7dfTfRU8XzoH2jJ+1WVfiVZkYj6CQvucoTNJITaoyV+rMc
	fVYxyM1xNOvfsYDgBSjnFCcu/eSn0u+e2CubwYskTaUJWPX0mZUy3O5CtQIYpmlmVd9q86P5JAo
	RF/xMu4S74Jl4L/hDg78Few05i/u61kfgccrXXtwUDD077QyCzHlijonCQKL78B7lKZSh8/2LuU
	FW0mfTDLrjxBVX7YQ7yEtm1Ert2cDV7FFQ5IS8PZ9Gh44iS2tUu4gPqkDQf1Gto5XoKNH34YHwx
	PQvf/cFZobd/eLa8ypgHCdElnf2romMQujA5IlQe4Z+scWIS3PvyMMPLXY0Mf3MBoO0DhsEYA3W
	5x9/AruGFXgWsZspnqXVCUUx+SWxwNiCpJ3DX6qbXsgzeTantlY25js71KTrNUy4ImbtM6f5swb
	ZDDlPhFW6dr4dV74JQ+fOMcjs5dIryFRn//pb7e0OCmkksayNZ6kE9izLdkfYRKXdStcerqTbW+
	jVcJve4vfPyVyo9JGCkofD7faWo=
X-Received: by 2002:a05:600c:354a:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4994e7b72dcmr116082735e9.9.1785950188870;
        Wed, 05 Aug 2026 10:16:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fcb46esm218642755e9.5.2026.08.05.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 19:16:28 +0200
Message-Id: <DKH6I5WC40A6.27R7VZIJOIRFS@gmail.com>
Cc: <bpf@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Support __arena and
 __arena_nullable kfunc argument suffixes
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-2-memxor@gmail.com>
 <CAMB2axPCF12OGokrt3R5d9f8Y9JxvGfF7LaNRHW_7bOp6aLnuA@mail.gmail.com>
 <DKH4QQFMWZJ9.DVYV5B6WWOWV@gmail.com>
 <CAMB2axNK=uzUQ9GYQo7gEGoyeet0pv4aJo4MKkjtO-FQjPBWDA@mail.gmail.com>
In-Reply-To: <CAMB2axNK=uzUQ9GYQo7gEGoyeet0pv4aJo4MKkjtO-FQjPBWDA@mail.gmail.com>

On Wed Aug 5, 2026 at 7:07 PM CEST, Amery Hung wrote:
> On Wed, Aug 5, 2026 at 8:53=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
>>
>> On Tue Aug 4, 2026 at 7:42 PM CEST, Amery Hung wrote:
>> > On Mon, Aug 3, 2026 at 6:12=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor=
@gmail.com> wrote:
>> >>
>> >> From: Tejun Heo <tj@kernel.org>
>> >>
>> >> Passing an arena pointer to a kfunc takes two steps today. There is n=
o
>> >> arena pointer argument type, so the pointer crosses the boundary as a
>> >> bare scalar, and the kfunc then offsets it by the arena base and cast=
s
>> >> it before it can touch the memory. Every such kfunc open-codes the sa=
me
>> >> translation.
>> >>
>> >> Add the __arena and __arena_nullable argument suffixes to make this m=
ore
>> >> convenient. The kfunc declares the parameter by its real pointer type
>> >> and dereferences it directly, with the JIT rebasing the value at the
>> >> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed:=
 the
>> >> u32 offset stays within the guard-padded arena kernel mapping, and a
>> >> fault on an unpopulated page recovers through the per-arena scratch
>> >> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
>> >> matching global subprog arena arguments.
>> >>
>> >> __arena rebases unconditionally, so the kfunc never sees NULL and a
>> >> value with zero in the low 32 bits arrives as the arena base.
>> >> __arena_nullable preserves NULL for optional arguments by skipping th=
e
>> >> rebase when the truncated value, arena offset 0, is zero. Keeping the
>> >> plain form NULL-free saves the NULL test on every call.
>> >>
>> >> This patch adds the verifier side: the suffixes are recognized in
>> >> check_kfunc_args() and distilled into argument flags in the function
>> >> model stored in the kfunc descriptor. JITs retrieve the model while
>> >> emitting the call, avoiding per-call state in insn_aux_data.
>> >>
>> >> JITs declare support with bpf_jit_supports_arena_args() and verificat=
ion
>> >> fails with -ENOTSUPP elsewhere.
>> >>
>> >> Signed-off-by: Tejun Heo <tj@kernel.org>
>> >> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> >> ---
>> >>  Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++++++++
>> >>  include/linux/bpf.h          |  6 ++++++
>> >>  include/linux/filter.h       |  1 +
>> >>  kernel/bpf/btf.c             | 18 +++++++++++++++-
>> >>  kernel/bpf/core.c            |  5 +++++
>> >>  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++++++++++=
+-
>> >>  6 files changed, 97 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.=
rst
>> >> index cbde86d082cc..8e84484636c5 100644
>> >> --- a/Documentation/bpf/kfuncs.rst
>> >> +++ b/Documentation/bpf/kfuncs.rst
>> >> @@ -278,6 +278,33 @@ An example is given below::
>> >>                  ...
>> >>          }
>> >>
>> >> +2.3.8 __arena and __arena_nullable Annotations
>> >> +----------------------------------------------
>> >> +
>> >> +Both annotations indicate that the pointer argument points into the
>> >> +calling program's arena. The JIT rebases the value at the call site =
so
>> >> +the kfunc receives a directly dereferenceable kernel address, subjec=
t to
>> >> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
>> >> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked acc=
ess).
>> >> +
>> >> +With ``__arena`` the rebase is unconditional and the argument is nev=
er
>> >> +NULL: a value whose lower 32 bits are zero arrives as the arena base
>> >> +address (arena offset 0). The kfunc must not check the argument for =
NULL.
>> >> +With ``__arena_nullable`` such a value arrives as NULL instead and t=
he
>> >> +kfunc must check before dereferencing.
>> >> +
>> >> +An example is given below::
>> >> +
>> >> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
>> >> +        {
>> >> +        ...
>> >> +        }
>> >> +
>> >> +Calling such a kfunc requires the program to use an arena map and a =
JIT with
>> >> +arena argument support (currently x86-64); verification fails otherw=
ise. The
>> >> +program can pass any value without compromising the kernel. A value =
that does
>> >> +not point into the arena is a program bug.
>> >> +
>> >>  .. _BPF_kfunc_nodef:
>> >>
>> >>  2.4 Using an existing kernel function
>> >> @@ -515,6 +542,8 @@ In order to accommodate such requirements, the ve=
rifier will enforce strict
>> >>  PTR_TO_BTF_ID type matching if two types have the exact same name, w=
ith one
>> >>  being suffixed with ``___init``.
>> >>
>> >> +.. _BPF_kfunc_arena_access:
>> >> +
>> >>  2.8 Accessing arena memory through kfunc arguments
>> >>  --------------------------------------------------
>> >>
>> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> >> index 356884587ae1..6da8a6be930c 100644
>> >> --- a/include/linux/bpf.h
>> >> +++ b/include/linux/bpf.h
>> >> @@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
>> >>  /* The argument is signed. */
>> >>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>> >>
>> >> +/* The argument is an arena pointer. */
>> >> +#define BTF_FMODEL_ARENA_ARG           BIT(2)
>> >> +
>> >> +/* The argument is nullable. */
>> >> +#define BTF_FMODEL_NULLABLE_ARG                BIT(3)
>> >> +
>> >>  struct btf_func_model {
>> >>         u8 ret_size;
>> >>         u8 ret_flags;
>> >> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> >> index 32d5297c557e..36ce3403fe59 100644
>> >> --- a/include/linux/filter.h
>> >> +++ b/include/linux/filter.h
>> >> @@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
>> >>  bool bpf_jit_supports_percpu_insn(void);
>> >>  bool bpf_jit_supports_kfunc_call(void);
>> >>  bool bpf_jit_supports_stack_args(void);
>> >> +bool bpf_jit_supports_arena_args(void);
>> >>  bool bpf_jit_supports_far_kfunc_call(void);
>> >>  bool bpf_jit_supports_exceptions(void);
>> >>  bool bpf_jit_supports_ptr_xchg(void);
>> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> >> index 5e8ac45ce56a..bf86df91a70b 100644
>> >> --- a/kernel/bpf/btf.c
>> >> +++ b/kernel/bpf/btf.c
>> >> @@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct=
 btf_type *t)
>> >>         return flags;
>> >>  }
>> >>
>> >> +static u8 __get_arg_fmodel_flags(const struct btf *btf,
>> >> +                                const struct btf_param *arg,
>> >> +                                const struct btf_type *t)
>> >> +{
>> >> +       u8 flags =3D __get_type_fmodel_flags(t);
>> >> +
>> >> +       if (btf_param_match_suffix(btf, arg, "__arena") ||
>> >> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
>> >> +               flags |=3D BTF_FMODEL_ARENA_ARG;
>> >> +       if (btf_param_match_suffix(btf, arg, "__nullable") ||
>> >> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
>> >> +               flags |=3D BTF_FMODEL_NULLABLE_ARG;
>> >> +
>> >> +       return flags;
>> >> +}
>> >> +
>> >>  int btf_distill_func_proto(struct bpf_verifier_log *log,
>> >>                            struct btf *btf,
>> >>                            const struct btf_type *func,
>> >> @@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_=
log *log,
>> >>                         return -EINVAL;
>> >>                 }
>> >>                 m->arg_size[i] =3D ret;
>> >> -               m->arg_flags[i] =3D __get_type_fmodel_flags(t);
>> >> +               m->arg_flags[i] =3D __get_arg_fmodel_flags(btf, &args=
[i], t);
>> >>         }
>> >>         m->nr_args =3D nargs;
>> >>         return 0;
>> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> >> index e2076667b245..a3e1fae32eac 100644
>> >> --- a/kernel/bpf/core.c
>> >> +++ b/kernel/bpf/core.c
>> >> @@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
>> >>         return false;
>> >>  }
>> >>
>> >> +bool __weak bpf_jit_supports_arena_args(void)
>> >> +{
>> >> +       return false;
>> >> +}
>> >> +
>> >>  bool __weak bpf_jit_supports_far_kfunc_call(void)
>> >>  {
>> >>         return false;
>> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >> index b274004fccfd..4c50237f49f1 100644
>> >> --- a/kernel/bpf/verifier.c
>> >> +++ b/kernel/bpf/verifier.c
>> >> @@ -10907,6 +10907,16 @@ static bool is_kfunc_arg_irq_flag(const stru=
ct btf *btf, const struct btf_param
>> >>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>> >>  }
>> >>
>> >> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct b=
tf_param *arg)
>> >> +{
>> >> +       return btf_param_match_suffix(btf, arg, "__arena");
>> >> +}
>> >> +
>> >> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const=
 struct btf_param *arg)
>> >> +{
>> >> +       return btf_param_match_suffix(btf, arg, "__arena_nullable");
>> >> +}
>> >> +
>> >
>> > From the verifier's point of view, __arena and __arena_nullable all
>> > maps to KF_ARG_PTR_TO_ARENA and require the same check so maybe
>> > is_kfunc_arg_arena() alone with two suffix matching is good enough,
>> > but it also doesn't hurt to have two separated functions.
>> >
>> >>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>> >>                                           const struct btf_param *arg=
,
>> >>                                           const char *name)
>> >> @@ -11127,6 +11137,7 @@ enum kfunc_ptr_arg_type {
>> >>         KF_ARG_PTR_TO_IRQ_FLAG,
>> >>         KF_ARG_PTR_TO_RES_SPIN_LOCK,
>> >>         KF_ARG_PTR_TO_TASK_WORK,
>> >> +       KF_ARG_PTR_TO_ARENA,
>> >>  };
>> >>
>> >>  enum special_kfunc_type {
>> >> @@ -11412,7 +11423,6 @@ get_kfunc_arg_type(struct bpf_verifier_env *e=
nv, struct bpf_call_arg_meta *meta,
>> >>                         reg_arg_name(env, argno), btf_type_str(t));
>> >>                 return -EINVAL;
>> >>         }
>> >> -
>> >>         ref_t =3D btf_type_skip_modifiers(meta->btf, t->type, NULL);
>> >>         ref_tname =3D btf_name_by_offset(meta->btf, ref_t->name_off);
>> >>
>> >> @@ -11461,6 +11471,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *e=
nv, struct bpf_call_arg_meta *meta,
>> >>                 arg_type =3D KF_ARG_PTR_TO_RES_SPIN_LOCK;
>> >>         else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
>> >>                 arg_type =3D KF_ARG_PTR_TO_CALLBACK;
>> >> +       else if (is_kfunc_arg_arena(meta->btf, &args[arg]) ||
>> >> +                is_kfunc_arg_arena_nullable(meta->btf, &args[arg]))
>> >> +               arg_type =3D KF_ARG_PTR_TO_ARENA;
>> >>         else if (arg + 1 < nargs &&
>> >>                  (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
>> >>                   is_kfunc_arg_const_mem_size(meta->btf, &args[arg + =
1]))) {
>> >> @@ -12154,6 +12167,31 @@ static int check_kfunc_args(struct bpf_verif=
ier_env *env, struct bpf_call_arg_me
>> >>
>> >>                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL=
);
>> >>
>> >> +               if (base_type(kf_arg_type) =3D=3D KF_ARG_PTR_TO_ARENA=
) {
>> >> +                       if (!bpf_jit_supports_arena_args()) {
>> >> +                               verbose(env, "JIT does not support kf=
unc %s() with arena pointer arguments\n",
>> >> +                                       func_name);
>> >> +                               return -ENOTSUPP;
>> >> +                       }
>> >
>> > nit: JIT and register-based arg check can be done earlier in
>> > get_kfunc_arg_type(). We probably will want a consolidated pass
>> > validating bpf_func_proto.
>> >
>>
>> I moved it up there. We still have prog aux argument doing stack argumen=
t
>> rejection later, but I will let you figure out the right placement when =
you
>> rework these bits.
>
> Sounds good to me. The placement is not really a blocker.
>
>>
>> Only thing left here now is the register type check.
>>
>> >> +                       if (!env->prog->aux->arena) {
>> >> +                               verbose(env,
>> >> +                                       "%s arena pointer requires a =
program with an associated arena\n",
>> >> +                                       reg_arg_name(env, argno));
>> >> +                               return -EINVAL;
>> >> +                       }
>> >> +                       if (regno < 0) {
>> >> +                               verbose(env, "%s arena pointer cannot=
 be a stack argument\n",
>> >> +                                       reg_arg_name(env, argno));
>> >> +                               return -EINVAL;
>> >> +                       }
>> >> +                       if (reg->type !=3D PTR_TO_ARENA && reg->type =
!=3D SCALAR_VALUE) {
>> >> +                               verbose(env, "%s is not a pointer to =
arena or scalar\n",
>> >> +                                       reg_arg_name(env, argno));
>> >> +                               return -EINVAL;
>> >> +                       }
>> >> +                       continue;
>> >> +               }
>> >> +
>> >
>> > Can we move arena argument checking to the second switch case below?
>> > It only takes adding one condition below.
>> >
>> > This help reduce churn in the future when check_kfunc_args() also
>> > receieve check_reg_type().
>> >
>> >>                 if (btf_type_is_ptr(t) && (bpf_register_is_null(reg) =
|| type_may_be_null(reg->type)) &&
>> >>                     !is_kfunc_arg_nullable(meta->btf, &args[i])) {
>> >>                         verbose(env, "Possibly NULL pointer passed to=
 trusted %s\n",
>> >
>> >   if (btf_type_is_ptr(t) && base_type(kf_arg_type) !=3D KF_ARG_PTR_TO_=
ARENA &&
>> >       (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
>> >       !type_may_be_null(kf_arg_type)) {
>> >           verbose(env, "Possibly NULL pointer passed to trusted %s\n",
>> >
>> >
>>
>> To simplify this and avoid special casing, I changed the kf_arg_type to
>> KF_ARG_PTR_TO_ARENA | PTR_MAYBE_NULL, since known NULL is kosher for bot=
h cases
>> and we place no static constraints on the precise value.
>
> Make sense. Thanks for tweaking it!

Actually, I realized env->prog->aux->arena is not resolved when
get_kfunc_arg_type() is called. In general, this feels like an accidental s=
ide
effect of the ordering of phases, so I decided to tweak it (move add_kfunc(=
) in
add_subprogs_and_kfuncs() out and before check_and_resolve_insns()).

This should make assumptions inside that function much simpler, and avoid s=
uch
footguns.

It should be a noop functionally, and hopefully more clear ordering of vari=
ous
checks. I prepended those NFC patches to the set, and we can discuss the de=
tails
in the next version.
