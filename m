Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78855280318
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163782; cv=pass; b=QlORqMWOkkGcDhIaPSHpLKVJ4tUM6Mn515+Y8Ptw6oaYqeQE+iqpEeRD9RgEbfZrulzMqtVaKBbfhvqeaNFXqqoFO1kqo4kClT8Mn58gRnGI76bb99kd8oQYmMZCCt/ABZperiKTH3xBqa29H+rjmJLmIS5Awi0+GbdpjWlIANM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163782; c=relaxed/simple;
	bh=5N39OHqjIr3XWNB3KNAt/6lTfN/wDFgw11Me7p5QJA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufO3m5Bk+s8uaYVkCE/xSzqJeQR61xde2k350kyQMT3sOZ+soceetJUfc1LdHZ436KesVSb/fTp2F1XB0wH5EH6BA7qg5qk48W+ti0GwCLKD72vRrceqGL9hAhUWdQnSpk3Fy3jkfGbJXsjj5IY7TZYBBgSOvpkEHBQgwj3Pl7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYjL/fvK; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYjL/fvK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a2ee65171so19983087b3.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775163779; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4rnJGkPtfNSCGOU7J84omaHHk75tlLslqvfCG8G9SbMJThrXsRu1UdrPvcyhbfYp+
         JfmHnRH70R6J+rOHZ9i5/pYc6lh0AtS3jteGyHOi7yhhP1/yzDyFnTbWvS4xLLZIIZxz
         nVvqAySAl8KWgHVPD5FxcVQZPvWRLH2ej3xn3faM4xgDU0ZInS23s6aanySpf1g6lcqA
         6RTyHCqG5OTHB/P3+To3v//HNchXb2gEc+dakrBWcaikPnEzug2SlzpkKIfXKjYJnB/z
         /3ist7Jb/rJ+YqpMR/5FrUMUMAj6GbCbZLiUe6DLbovkO9Q/aSA/eeSyaCisunSq9gjm
         05vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=atMvwavJF4frfzsqBuzEq80pf9J4/YlmbJO4DrDD+cg=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=Ysrk5bvYAC9pYaCZ8I+uDwxAAOPVGGnDvBkr14KoyQKCzxv2sgaWzB1kbOWaAC4Odv
         FZTWl8nRCLdzL4iVzaNezec+ujrRbVNlSdnV0J0z1P3NbhPoIeWq8D3j/xciKD8P1DLU
         kAlojzxsFV+cRsQ8CEzc2q+Ansp/3D/iEcgtLKvUb0OTMP3ZaZOHbNnJ7Fa1stQRpB56
         zOjHh+rqTx04OKAqhgRETPXcD6wpSrPkJ7ALrELn4+blKzzXIVXxMt/tom36RN72fW22
         SiK3YpgyAeCtpI1oJosFdwuOSXknoRvilB9cyLEKvhSI9/blnM8gZUP1W+HA9ztDGRpp
         aoCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775163779; x=1775768579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atMvwavJF4frfzsqBuzEq80pf9J4/YlmbJO4DrDD+cg=;
        b=EYjL/fvK3+U2KbEzNW+KOOlPbApd3WAWEznP5IbTJCpUSJYpyWqjcOnKdo6AX4rMiP
         IXFFf6Fyw3DfpdBGCBrhuvdPjvh7Glvb++/FCCYHywxhbSK3LhAev2+KH1UDrzE65010
         48P3kjrOsYV4lghP/FB3a68czf4WEVbpN9zeO3yYspGFeTxPdWjyQpxRKbnAvCZKdd77
         6vpo2qKa/WdE9Gu1/69AyajTEu/5BM/6pwcT63dFhfgNLoKWtFP15DpakESUZ5uk9DVo
         0/RLkiIxvqkF931roGlSHL1djC2Bc/R1Si3MwDdcjEI3pQyWauGTQXE61V1TABtJPAOo
         HpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163779; x=1775768579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=atMvwavJF4frfzsqBuzEq80pf9J4/YlmbJO4DrDD+cg=;
        b=g9c3SwZFpto8+6MRBBpeqwpNLqsfZbqN5++vzYiuISz4FzjALSrMNAeAWZBt8weVos
         Ka5xEGt/XH73rXUiLY+ZWtLxRkQ+5kCXpmnJbUApLd835H4fR+uigeVLXkhiSqfNhATG
         FRi7NpkKqqBjnqH/W/OaSmAEqUSP/7OFkMqeovZ5jDeovOqe1aYIDB38HmAbgQ4JnFhU
         M/aY/G4F6NkBAlkX7K0ZSG+E6hjAXtdBIj8OAVFvDkMrS2Ua0JEAd6L/QVDsPkbLbXP5
         Ar4bOUwmnPK/E7UGZ7khazG+x2OZNFGwuLOqguyNA5KaSEtAifGf/HXcQGK0NfF4JrGP
         wX5A==
X-Gm-Message-State: AOJu0Yx2nEkxsT4fs4GDiAT26l2/B44E5H5KPiMpKtdj6s1LTTBE6IYL
	xtvrAVXCxnjEIKh7x3vdHcoGwrRViZkY1kaPDqdEz0b81Mptj65CAD2x9M0IDWwNb5fabezCFyL
	CGp9kSYrCz6okYUF0JlOmS7TRcQpHROo=
X-Gm-Gg: AeBDieu1sqU6Kb/EOooV80rFpIGXGUSFbGxvYqHG1EreAxWY9hcurvPJdlzdhVxUa8X
	lDYp0Bshcvzmuu9rBholBngL2lkjQ8QPDUxijdETDS5oLZxRsPhePfTgiWruS1s7byVCeP0Jau9
	O+TAJZfnGPnuq4u/WOnLbBJ9p5XhzZus9/9kwsDHwZ7kSupMs7SEEKVi7IxfjC7eygQpm2srTU0
	6++haENImAeYGnvt7Ehj6GsK+4PrXDORzkxpYvGTJXp/cptLfGiudhF1A7K0EQXhuF29UnqmrwR
	2+DrT64=
X-Received: by 2002:a05:690c:c4fa:b0:79a:5fb9:62ad with SMTP id
 00721157ae682-7a4d5d538f6mr9423297b3.43.1775163779255; Thu, 02 Apr 2026
 14:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012747.3918081-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012747.3918081-1-yonghong.song@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 2 Apr 2026 14:02:48 -0700
X-Gm-Features: AQROBzBCYxDCEKZKVvMfdK4SglaVMdJJDT17sxscpM5NMqw6x-vos1Qo4YkDX1o
Message-ID: <CAMB2axMxqbZ2W_CZk4Hw7APi7b9n108MmR2Jm_v9SQjWo+BKZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/10] bpf: Support stack arguments for kfunc calls
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
> Extend the stack argument mechanism to kfunc calls, allowing kfuncs
> with more than 5 parameters to receive additional arguments via the
> r12-based stack arg area.
>
> For kfuncs, the caller is a BPF program and the callee is a kernel
> function. The BPF program writes outgoing args at r12-relative offsets
> past its own incoming area.
>
> The following is an example to show how stack arguments are saved:
>
>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>      ...
>      kfunc1(a1, a2, a3, a4, a5, a6, a7, a8);
>      ...
>      kfunc2(a1, a2, a3, a4, a5, a6, a7, a8, a9);
>      ...
>    }
>
> The following is an illustration:
>
>    Caller (foo)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>        r12-relative stack arg area:
>
>        r12-8:  [incoming arg 6]
>        r12-16: [incoming arg 7]
>
>        ---- incoming/outgoing boundary (kfunc1)
>        r12-24: [outgoing arg 6 to callee]
>        r12-32: [outgoing arg 7 to callee]
>        r12-40: [outgoing arg 8 to callee]
>        ...
>        Back from kfunc1
>        ...
>
>        ---- incoming/outgoing boundary
>        r12-24: [outgoing arg 6 to callee]
>        r12-32: [outgoing arg 7 to callee]
>        r12-40: [outgoing arg 8 to callee]
>        r12-48: [outgoing arg 9 to callee]
>
> Later JIT will marshal outgoing arguments to the native calling conventio=
n
> for kfunc1() and kfunc2().
>
> In check_kfunc_args(), for args beyond the 5th, retrieve the spilled
> register state from the caller's stack arg slots. Temporarily copy
> it into regs[BPF_REG_1] to reuse the existing type checking
> infrastructure, then restore after checking. Also in fixup_kfunc_call(),
> repurpose insn->off (no longer needed after kfunc address resolution)
> to store the number of stack args, so the JIT knows how many args to mars=
hal.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/verifier.c | 97 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d424fe611ef8..6579156486b8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3502,7 +3502,7 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
>         struct bpf_kfunc_meta kfunc;
>         struct bpf_kfunc_desc *desc;
>         unsigned long addr;
> -       int err;
> +       int i, err;
>
>         prog_aux =3D env->prog->aux;
>         tab =3D prog_aux->kfunc_tab;
> @@ -3578,6 +3578,14 @@ static int add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, s16 offset)
>         if (err)
>                 return err;
>
> +       for (i =3D MAX_BPF_FUNC_REG_ARGS; i < func_model.nr_args; i++) {
> +               if (func_model.arg_size[i] > sizeof(u64)) {
> +                       verbose(env, "kfunc %s arg#%d size %d > %zu not s=
upported for stack args\n",
> +                               kfunc.name, i, func_model.arg_size[i], si=
zeof(u64));
> +                       return -EINVAL;
> +               }
> +       }
> +
>         desc =3D &tab->descs[tab->nr_descs++];
>         desc->func_id =3D func_id;
>         desc->offset =3D offset;
> @@ -12995,9 +13003,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *e=
nv,
>                        struct bpf_kfunc_call_arg_meta *meta,
>                        const struct btf_type *t, const struct btf_type *r=
ef_t,
>                        const char *ref_tname, const struct btf_param *arg=
s,
> -                      int argno, int nargs)
> +                      int argno, int nargs, u32 regno)
>  {
> -       u32 regno =3D argno + 1;
>         struct bpf_reg_state *regs =3D cur_regs(env);
>         struct bpf_reg_state *reg =3D &regs[regno];
>         bool arg_mem_size =3D false;

[...]

> @@ -13677,9 +13684,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>
>         args =3D (const struct btf_param *)(meta->func_proto + 1);
>         nargs =3D btf_type_vlen(meta->func_proto);
> -       if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +       if (nargs > MAX_BPF_FUNC_ARGS) {
>                 verbose(env, "Function %s has %d > %d args\n", func_name,=
 nargs,
> -                       MAX_BPF_FUNC_REG_ARGS);
> +                       MAX_BPF_FUNC_ARGS);
>                 return -EINVAL;
>         }
>
> @@ -13687,13 +13694,41 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>          * verifier sees.
>          */
>         for (i =3D 0; i < nargs; i++) {
> -               struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &r=
egs[i + 1];
> +               struct bpf_reg_state *regs =3D cur_regs(env), *reg;
> +               struct bpf_reg_state saved_reg;
>                 const struct btf_type *t, *ref_t, *resolve_ret;
>                 enum bpf_arg_type arg_type =3D ARG_DONTCARE;
>                 u32 regno =3D i + 1, ref_id, type_size;
>                 bool is_ret_buf_sz =3D false;
> +               bool is_stack_arg =3D false;
>                 int kf_arg_type;
>
> +               if (i < MAX_BPF_FUNC_REG_ARGS) {
> +                       reg =3D &regs[i + 1];
> +               } else {
> +                       /*
> +                        * Retrieve the spilled reg state from the stack =
arg slot.
> +                        * Reuse the existing type checking infrastructur=
e which
> +                        * reads from cur_regs(env)[regno], temporarily c=
opy the
> +                        * stack arg reg state into regs[BPF_REG_1] and r=
estore
> +                        * it after checking.
> +                        */
> +                       struct bpf_func_state *caller =3D cur_func(env);
> +                       int spi =3D caller->incoming_stack_arg_depth / BP=
F_REG_SIZE +
> +                                 (i - MAX_BPF_FUNC_REG_ARGS);
> +
> +                       if (!is_stack_arg_slot_initialized(caller, spi)) =
{
> +                               verbose(env, "stack arg#%d not properly i=
nitialized\n", i);
> +                               return -EINVAL;
> +                       }
> +
> +                       is_stack_arg =3D true;
> +                       regno =3D BPF_REG_1;

is_kfunc_arg_mem_size() and is_kfunc_arg_const_mem_size() will not
work properly in get_kfunc_ptr_arg_type(). Since they assume regno + 1
to be the size, R2 would be accidentally treated as size.

Maybe consider creating a helper to retrieve bpf_reg_state of a
specific arg and use it in get_kfunc_ptr_arg_type() instead of copying
and restoring?

> +                       saved_reg =3D regs[BPF_REG_1];
> +                       regs[BPF_REG_1] =3D caller->stack_arg_slots[spi].=
spilled_ptr;
> +                       reg =3D &regs[BPF_REG_1];
> +               }
> +
>                 if (is_kfunc_arg_prog_aux(btf, &args[i])) {
>                         /* Reject repeated use bpf_prog_aux */
>                         if (meta->arg_prog) {
> @@ -13702,7 +13737,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         }
>                         meta->arg_prog =3D true;
>                         cur_aux(env)->arg_prog =3D regno;
> -                       continue;
> +                       goto next_arg;
>                 }
>
>                 if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_im=
plicit(meta, i))
> @@ -13725,9 +13760,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                         verbose(env, "R%d must be a known=
 constant\n", regno);
>                                         return -EINVAL;
>                                 }
> -                               ret =3D mark_chain_precision(env, regno);
> -                               if (ret < 0)
> -                                       return ret;
> +                               if (i < MAX_BPF_FUNC_REG_ARGS) {
> +                                       ret =3D mark_chain_precision(env,=
 regno);
> +                                       if (ret < 0)
> +                                               return ret;
> +                               }
>                                 meta->arg_constant.found =3D true;
>                                 meta->arg_constant.value =3D reg->var_off=
.value;
>                         } else if (is_kfunc_arg_scalar_with_name(btf, &ar=
gs[i], "rdonly_buf_size")) {
> @@ -13749,11 +13786,13 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                                 }
>
>                                 meta->r0_size =3D reg->var_off.value;
> -                               ret =3D mark_chain_precision(env, regno);
> -                               if (ret)
> -                                       return ret;
> +                               if (i < MAX_BPF_FUNC_REG_ARGS) {
> +                                       ret =3D mark_chain_precision(env,=
 regno);
> +                                       if (ret)
> +                                               return ret;
> +                               }
>                         }
> -                       continue;
> +                       goto next_arg;
>                 }
>
>                 if (!btf_type_is_ptr(t)) {
> @@ -13782,13 +13821,14 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                 ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
>                 ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
>
> -               kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_=
t, ref_tname, args, i, nargs);
> +               kf_arg_type =3D get_kfunc_ptr_arg_type(env, meta, t, ref_=
t, ref_tname, args, i, nargs,
> +                                                    regno);
>                 if (kf_arg_type < 0)
>                         return kf_arg_type;
>
>                 switch (kf_arg_type) {
>                 case KF_ARG_PTR_TO_NULL:
> -                       continue;
> +                       goto next_arg;
>                 case KF_ARG_PTR_TO_MAP:
>                         if (!reg->map_ptr) {
>                                 verbose(env, "pointer in R%d isn't map po=
inter\n", regno);
> @@ -14201,6 +14241,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         break;
>                 }
>                 }
> +next_arg:
> +               if (is_stack_arg)
> +                       regs[BPF_REG_1] =3D saved_reg;
>         }
>
>         if (is_kfunc_release(meta) && !meta->release_regno) {
> @@ -14778,7 +14821,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>
>         nargs =3D btf_type_vlen(meta.func_proto);
>         args =3D (const struct btf_param *)(meta.func_proto + 1);
> -       for (i =3D 0; i < nargs; i++) {
> +       for (i =3D 0; i < nargs && i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                 u32 regno =3D i + 1;
>
>                 t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NUL=
L);
> @@ -14789,6 +14832,16 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                         mark_btf_func_reg_size(env, regno, t->size);
>         }
>
> +       /* Track outgoing stack arg depth for kfuncs with >5 args */
> +       if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> +               struct bpf_func_state *caller =3D cur_func(env);
> +               struct bpf_subprog_info *caller_info =3D &env->subprog_in=
fo[caller->subprogno];
> +               u16 kfunc_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_A=
RGS) * BPF_REG_SIZE;
> +
> +               if (kfunc_stack_arg_depth > caller_info->outgoing_stack_a=
rg_depth)
> +                       caller_info->outgoing_stack_arg_depth =3D kfunc_s=
tack_arg_depth;
> +       }
> +
>         if (is_iter_next_kfunc(&meta)) {
>                 err =3D process_iter_next_call(env, insn_idx, &meta);
>                 if (err)
> @@ -23615,6 +23668,16 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>         if (!bpf_jit_supports_far_kfunc_call())
>                 insn->imm =3D BPF_CALL_IMM(desc->addr);
>
> +       /*
> +        * After resolving the kfunc address, insn->off is no longer need=
ed
> +        * for BTF fd index. Repurpose it to store the number of stack ar=
gs
> +        * so the JIT can marshal them.
> +        */
> +       if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
> +               insn->off =3D desc->func_model.nr_args - MAX_BPF_FUNC_REG=
_ARGS;
> +       else
> +               insn->off =3D 0;
> +
>         if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_=
kfunc(desc->func_id)) {
>                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_au=
x_data[insn_idx].kptr_struct_meta;
>                 struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (lo=
ng)kptr_struct_meta) };
> --
> 2.52.0
>
>
