Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177C388377
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945336; cv=none; b=ZPr/WhntpsstUinjDESfqcMAckRDucuKn1u7pRu64iMO5uy/jTV+NDmh3EAQgIBiM+jV6D9xTiH3mWrm7HQ0MEm8hSFfMstLcZp13b7372mEWxGUMEYWUUgXQbirDH163xe5SQ3GA+4lSanwPVqwGCjVXkbL8bGnBdigACtBemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945336; c=relaxed/simple;
	bh=5CabYYlry9mkrsalyxMhdxHJuPBA2AKegedssn3rnEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oZjYOu9NG7mPDbJa18vswwc1ToImsBPorF3s57sj+jDDCt6dvse7L8KH98ktcyA5Tbq+jmaM2qzrPNQPyYWE7Q6vEBfPNyXA9Jm9gx6j321LUY2dKxrEZdVklsh9SLYLKsnexcnYtVuFTHGTLCKLY3FGXX4e8mPC8QT3v8AskuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxNYfg/n; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxNYfg/n"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so2520685e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785945333; x=1786550133; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VeDcRUx+RTnE/Ze/OlfrwmXJoMqppFerU+uUytDI/00=;
        b=mxNYfg/nmwTdateT9hHoQA4oAeDciDgM3H65zMGZJ6Alrquso/B3StmM4LwPuGgY+5
         Si8kgqVOXC6NJLbzaKVhyhyNDCymVGdeNk5YFrByX9+chfnsgd7NI2KMWNPQlA1o40iS
         ipxVy76qXC/TpSRbx9OEgwnuWct5W0LdPUeX20PqtgEE7iKMZp2rnwRfDEd1MQY1SAXS
         4wsBMD5k4QJ8phy1EYohslehl1I77w31n7oOdu5/2031W/oawns0Fhr/xup6vSXK63O3
         MJf9cQVExsW8v3RL1C6fTA7u019OF6ddpHo2LyTC+uZINmPG1pqpkT0UXdB/wnrvgd4s
         XPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785945333; x=1786550133;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VeDcRUx+RTnE/Ze/OlfrwmXJoMqppFerU+uUytDI/00=;
        b=rAULM/7ML2rpD9/xPykBULs8lZgFr4vfUzQyxrCrr2UwK/irfG0D5tV1xHKY/Le/2f
         G8j3CiEZQh3wGGp5sd5ibL/PeSbLHFnYvtLzpYwXAeXQN8zy1O5aMeOvmLs7Yywnh7U5
         rgb/mgu3TEnWDTNHoWDXFAPSNVzqfCyUe/Msucy78/19cVWSAJdzqeCW2q+uG9ee8WSp
         8y5zNewd1JfWH7f9L6xj6/uz/IJo2dIb5CSuKv1+2Chgfu5fuL5bSFE5gK0uVH5K6Y1U
         fmEsmX0GMgMYGGtIlFITWobNeP98jciYxIYCvQUxiqk8BmL3qpQhZ2oBMBmmRTZW+82o
         ta0Q==
X-Gm-Message-State: AOJu0YxdrG0WFV16YanhWsz001NGw83OLObWhpVivQi1GdNQwlxus8Ov
	Xcy4nMZcrPwbf87QKm7jZO3i8Qna/DN6SAnLB8eZfPrVQ+OFvKWHPbhv
X-Gm-Gg: AR+sD10jWf/Dts/UB8IkwBIlpNoDe16iTXRfPNGlZhGJ0+o43bgYwmU50W9pfK9N+iK
	NTwF8dSQrXGAqwkjhlcSjhG7QM1a3Dtjb92ipon0I6Yq6e2CIqxcy/tBi7uSIZYIJWRpvbpH0PM
	aquurDgMs0u37xZzECl7V+b0dbBD1hIr7mTljorgiA3AIhKRQI0KmDIzIjbemv04lnkVbL0LH5A
	Qiz8ZdDo6URxgvsmD/DLnobtKbU6xN7BQE+N8Il5cD12Si6uWH6vYrwbPV0ljHH2VaGUurh7dtH
	o2IVQA2/mgRwDHsi+rJKFtwkGeHt0UqvLnx2/JyZXs6acsVyHooJ8w8I7Txq5WCgEpgsxiH/3Eq
	SpVCveY0PFQocGXqDevUnCb2Oecy+lJsp8Jw9ptf0R3mtJ+qYM1NGgdIG+sngCYlRHkcgYGjy9I
	+Az7btZAxruCsOI8lqrCwQTeG5KlPUDsZML8gkoMw57UcsAEhBUpFoVyL4Q14DGGQ5PbHeqb7HB
	+cooc4RuAJug8sNe7Zc9ufHD7ibO58Rdfie9jichB/HN60yPS+VvxdGxJR9w3S/Y5dkw/S6hhEF
	BPCBT3ql0XmYLYOpsrbbzVDv3cY=
X-Received: by 2002:a05:600c:1550:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4994e6c5521mr94240855e9.0.1785945333042;
        Wed, 05 Aug 2026 08:55:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e9ad922sm45193485e9.4.2026.08.05.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 08:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 17:55:32 +0200
Message-Id: <DKH4S76GIO67.18GLTGT6YDR6L@gmail.com>
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
In-Reply-To: <CAMB2axPCF12OGokrt3R5d9f8Y9JxvGfF7LaNRHW_7bOp6aLnuA@mail.gmail.com>

On Tue Aug 4, 2026 at 7:42 PM CEST, Amery Hung wrote:
> On Mon, Aug 3, 2026 at 6:12=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
>>
>> From: Tejun Heo <tj@kernel.org>
>>
>> Passing an arena pointer to a kfunc takes two steps today. There is no
>> arena pointer argument type, so the pointer crosses the boundary as a
>> bare scalar, and the kfunc then offsets it by the arena base and casts
>> it before it can touch the memory. Every such kfunc open-codes the same
>> translation.
>>
>> Add the __arena and __arena_nullable argument suffixes to make this more
>> convenient. The kfunc declares the parameter by its real pointer type
>> and dereferences it directly, with the JIT rebasing the value at the
>> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: th=
e
>> u32 offset stays within the guard-padded arena kernel mapping, and a
>> fault on an unpopulated page recovers through the per-arena scratch
>> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
>> matching global subprog arena arguments.
>>
>> __arena rebases unconditionally, so the kfunc never sees NULL and a
>> value with zero in the low 32 bits arrives as the arena base.
>> __arena_nullable preserves NULL for optional arguments by skipping the
>> rebase when the truncated value, arena offset 0, is zero. Keeping the
>> plain form NULL-free saves the NULL test on every call.
>>
>> This patch adds the verifier side: the suffixes are recognized in
>> check_kfunc_args() and distilled into argument flags in the function
>> model stored in the kfunc descriptor. JITs retrieve the model while
>> emitting the call, avoiding per-call state in insn_aux_data.
>>
>> JITs declare support with bpf_jit_supports_arena_args() and verification
>> fails with -ENOTSUPP elsewhere.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  Documentation/bpf/kfuncs.rst | 29 ++++++++++++++++++++++++++
>>  include/linux/bpf.h          |  6 ++++++
>>  include/linux/filter.h       |  1 +
>>  kernel/bpf/btf.c             | 18 +++++++++++++++-
>>  kernel/bpf/core.c            |  5 +++++
>>  kernel/bpf/verifier.c        | 40 +++++++++++++++++++++++++++++++++++-
>>  6 files changed, 97 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index cbde86d082cc..8e84484636c5 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -278,6 +278,33 @@ An example is given below::
>>                  ...
>>          }
>>
>> +2.3.8 __arena and __arena_nullable Annotations
>> +----------------------------------------------
>> +
>> +Both annotations indicate that the pointer argument points into the
>> +calling program's arena. The JIT rebases the value at the call site so
>> +the kfunc receives a directly dereferenceable kernel address, subject t=
o
>> +the access rules described in :ref:`BPF_kfunc_arena_access` (at most
>> +``GUARD_SZ / 2``, 32 KiB, past the pointer in a single unchecked access=
).
>> +
>> +With ``__arena`` the rebase is unconditional and the argument is never
>> +NULL: a value whose lower 32 bits are zero arrives as the arena base
>> +address (arena offset 0). The kfunc must not check the argument for NUL=
L.
>> +With ``__arena_nullable`` such a value arrives as NULL instead and the
>> +kfunc must check before dereferencing.
>> +
>> +An example is given below::
>> +
>> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
>> +        {
>> +        ...
>> +        }
>> +
>> +Calling such a kfunc requires the program to use an arena map and a JIT=
 with
>> +arena argument support (currently x86-64); verification fails otherwise=
. The
>> +program can pass any value without compromising the kernel. A value tha=
t does
>> +not point into the arena is a program bug.
>> +
>>  .. _BPF_kfunc_nodef:
>>
>>  2.4 Using an existing kernel function
>> @@ -515,6 +542,8 @@ In order to accommodate such requirements, the verif=
ier will enforce strict
>>  PTR_TO_BTF_ID type matching if two types have the exact same name, with=
 one
>>  being suffixed with ``___init``.
>>
>> +.. _BPF_kfunc_arena_access:
>> +
>>  2.8 Accessing arena memory through kfunc arguments
>>  --------------------------------------------------
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 356884587ae1..6da8a6be930c 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1213,6 +1213,12 @@ struct bpf_prog_offload {
>>  /* The argument is signed. */
>>  #define BTF_FMODEL_SIGNED_ARG          BIT(1)
>>
>> +/* The argument is an arena pointer. */
>> +#define BTF_FMODEL_ARENA_ARG           BIT(2)
>> +
>> +/* The argument is nullable. */
>> +#define BTF_FMODEL_NULLABLE_ARG                BIT(3)
>> +
>>  struct btf_func_model {
>>         u8 ret_size;
>>         u8 ret_flags;
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 32d5297c557e..36ce3403fe59 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1183,6 +1183,7 @@ bool bpf_jit_supports_subprog_tailcalls(void);
>>  bool bpf_jit_supports_percpu_insn(void);
>>  bool bpf_jit_supports_kfunc_call(void);
>>  bool bpf_jit_supports_stack_args(void);
>> +bool bpf_jit_supports_arena_args(void);
>>  bool bpf_jit_supports_far_kfunc_call(void);
>>  bool bpf_jit_supports_exceptions(void);
>>  bool bpf_jit_supports_ptr_xchg(void);
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 5e8ac45ce56a..bf86df91a70b 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7541,6 +7541,22 @@ static u8 __get_type_fmodel_flags(const struct bt=
f_type *t)
>>         return flags;
>>  }
>>
>> +static u8 __get_arg_fmodel_flags(const struct btf *btf,
>> +                                const struct btf_param *arg,
>> +                                const struct btf_type *t)
>> +{
>> +       u8 flags =3D __get_type_fmodel_flags(t);
>> +
>> +       if (btf_param_match_suffix(btf, arg, "__arena") ||
>> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
>> +               flags |=3D BTF_FMODEL_ARENA_ARG;
>> +       if (btf_param_match_suffix(btf, arg, "__nullable") ||
>> +           btf_param_match_suffix(btf, arg, "__arena_nullable"))
>> +               flags |=3D BTF_FMODEL_NULLABLE_ARG;
>> +
>> +       return flags;
>> +}
>> +
>>  int btf_distill_func_proto(struct bpf_verifier_log *log,
>>                            struct btf *btf,
>>                            const struct btf_type *func,
>> @@ -7606,7 +7622,7 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
>>                         return -EINVAL;
>>                 }
>>                 m->arg_size[i] =3D ret;
>> -               m->arg_flags[i] =3D __get_type_fmodel_flags(t);
>> +               m->arg_flags[i] =3D __get_arg_fmodel_flags(btf, &args[i]=
, t);
>>         }
>>         m->nr_args =3D nargs;
>>         return 0;
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index e2076667b245..a3e1fae32eac 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -3308,6 +3308,11 @@ bool __weak bpf_jit_supports_stack_args(void)
>>         return false;
>>  }
>>
>> +bool __weak bpf_jit_supports_arena_args(void)
>> +{
>> +       return false;
>> +}
>> +
>>  bool __weak bpf_jit_supports_far_kfunc_call(void)
>>  {
>>         return false;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b274004fccfd..4c50237f49f1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10907,6 +10907,16 @@ static bool is_kfunc_arg_irq_flag(const struct =
btf *btf, const struct btf_param
>>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>>  }
>>
>> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_=
param *arg)
>> +{
>> +       return btf_param_match_suffix(btf, arg, "__arena");
>> +}
>> +
>> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf, const st=
ruct btf_param *arg)
>> +{
>> +       return btf_param_match_suffix(btf, arg, "__arena_nullable");
>> +}
>> +
>
> From the verifier's point of view, __arena and __arena_nullable all
> maps to KF_ARG_PTR_TO_ARENA and require the same check so maybe
> is_kfunc_arg_arena() alone with two suffix matching is good enough,
> but it also doesn't hurt to have two separated functions.
>

Missed in previous reply; I consolidated both into the same is_kfunc_arg_ar=
ena()
predicate.

> [...]
