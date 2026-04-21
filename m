Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D376FC5
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731855; cv=none; b=OCE9402yBvyVDoiuLGBDC3TlGu9Wf+PbyXuKtjtUtyIygGezCnPyWaXD7fORy1CnIbkAaLGsPiZhv4C71V7XDXkC8D+iL048AIl6YjtSyinwhzMQn4EWjN8AV8Ji8+uw2StfMFgKQVXsEhd6VLZKR9mJPtrLHwT2xB0H1bJVUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731855; c=relaxed/simple;
	bh=uIq8D8tx8NXe5dX69S5xbsWjNnLwxWzSn2rjSSnlVI4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uv/GSvYv+JSNGzfGudnlQzYRGAtebf6CWSngYjU+QhWRzD6EvBFcAl69jEL9gXr7aRV+ldwQRA9Hx20QcimqTAL46CA60RGhriCAaEABMwdqeMyYERW8WO/dvZUTf7UkcgAFmCShQqZzQ1IfT67BEVJ/TH3RtQ/fKjzY0cIeGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpWFqaoI; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpWFqaoI"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4232323a7daso1694444fac.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731853; x=1777336653; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azN1gj0qSctBQVr+7rpCulKYfD9ubmnLg2J1Uf3oy+M=;
        b=KpWFqaoII/aL0R8BYZE7reSUabH+hzpg4mZ1pFMDlFEyOTyUEHO4PNAITfUjwqbXrM
         mf+JU3tusyo1ekn1X3/L2z2lAXzXJboh1AMZowWEfmZulOTT4moiEqlC6F3CpfvXyuxE
         ApA0cE9Xj9wlFuIOdSx2NOtIKmlq71mKS+rSrNKhw23Kj+QQWUR6Rvt9oju+VvIXuqTJ
         IWFCvAfe3UC1Wfx7fBgGrdKRvKPPNPP482FFWw0k+E6u5jtRxt/5vZQAZ5Ro/feHTtv1
         t4+uGCShOrwY/Ok0udVAlBpf9EtFlE8IguC3dMzcpP5bjM/j1JBCnyuvEagie7ZDUGAa
         gcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731853; x=1777336653;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azN1gj0qSctBQVr+7rpCulKYfD9ubmnLg2J1Uf3oy+M=;
        b=bdj6APSQYdD+ZY5plR6qLdXHr/XxGgk7/idp+emMqqiQXC0RgIrIH8J7aac9CmiJDV
         55e1NgfAcQT5+R9apdjdkwjz1RaXFYuYtX0+Gh9dfC2xPayHyXwfOp3KYjMQPY88TdU3
         8V/tnPHIyp4s5e++0BOSn21H+6Lfj7IQkyHkoORcLuYM/El5SnUy+swqwXkq8nmBQaEa
         us9vClS6iBBBr4wE8VlWXCQV2nsrzS1RMVGxAsLQdi99S5IoX//GKA4lnXuaWQuuCYKl
         ILHCueZRkja8xAWbhDKVjg3QPLBciTCAU7h4F24z8ILKR45yRBLxScsTHYqDfRfX8sJ3
         uweQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7H3JcxDPmJfXJRJjZBMK5nv67rw1O6WAPnDee5gZkHCB5m8lmqwtJ594gzliP/9J55cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygt+ZgtzZN/0jbjSK7VgytE3v5cEV3Rr5g4UzKO9YWNeY6E/34
	I52DYtJyyuDML3MxuuKAhzjQGNOCLQjFmmMNRGFyQtWXCZV+GX7XiIjH
X-Gm-Gg: AeBDieverCcF1fbZih563FvHMyIxuykzTGI1jVMq740LwdSnJgMMvXxH+hWcWLnVYe5
	WERoK7PKnTjmb6T+iX90DsT6sHL0S5ygFaN3b8GL1NLFQCCYqQfPL0lw/+WS6dvfbPdv8LJ9m37
	9i9b3vKBO6T/Qp/lufutKIEIgI6Gj4prdKJfbI2Iew7rQSk5Kxv+kLi1ixiABtC2MXfVdjCCb2i
	+qz7/RDboQ5DxwvrXkewy4Mpn7XzOa/J7OHswVZruIglJ0mGra/OxUfGT6eji2w8ho8apZNVaym
	zhkhP96LJ25OVYaSb6P+/784tt3RZW+INUyKQEE0I8f578W0rXSe3B0j82x3IMawHtaS+17nkoN
	93iKJzH6oOz0ItuqZLz44LvCM1smfrV6aHg5n8l8oH0OCrNYLwmxobrXuL4j/ClqZzJdvC1cEHZ
	pcXiIebhyEYjo3ZEr81PzWZKJdU4nyevddRtyLNF7yYTH40h4JeRKbnHnLYgz0fqAL4Eon9WDIE
	IZCcJNJkfpG4k9DuEae4wNsAxk=
X-Received: by 2002:a05:6870:d154:b0:417:392e:4e67 with SMTP id 586e51a60fabf-42aded189acmr9042061fac.20.1776731852591;
        Mon, 20 Apr 2026 17:37:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a1a13sm10903748fac.12.2026.04.20.17.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 17:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 17:37:30 -0700
Message-Id: <DHYEVJXVGHP5.2CAI5PGRI0W8E@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 07/17] bpf: Support stack arguments for bpf
 functions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163352.734115-1-yonghong.song@linux.dev>
In-Reply-To: <20260419163352.734115-1-yonghong.song@linux.dev>

On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register BPF_REG_PARAMS (r11),
> introduced in the previous patch.
>
> The compiler uses positive r11 offsets for incoming (callee-side) args
> and negative r11 offsets for outgoing (caller-side) args, following the
> x86_64/arm64 calling convention direction. There is an 8-byte gap at
> offset 0 separating the two regions:
>   Incoming (callee reads):   r11+8 (arg6), r11+16 (arg7), ...
>   Outgoing (caller writes):  r11-8 (arg6), r11-16 (arg7), ...

This part looks clean now.

> A per-state bitmask out_stack_arg_mask tracks which outgoing stack arg
> slots have been written on the current path. Each bit corresponds to
> an outgoing slot index (bit 0 =3D r11-8 =3D arg6, bit 1 =3D r11-16 =3D ar=
g7,
> etc.). At a call site, the verifier checks that all slots required by
> the callee have their corresponding mask bits set. This enables
> precise per-path tracking: if one branch of a conditional writes arg6
> but another does not, the mask correctly reflects the difference and
> the verifier rejects the uninitialized path. The mask is included in
> stack_arg_safe() so that states with different sets of initialized
> slots are not incorrectly pruned together.

But this part I don't understand.
why do you need this bitmask?
Even when they're written out of order stack_arg_depth is all you need.
Then compare old->stack_arg_regs vs cur->stack_arg_regs.
If one is not written its state will be NOT_INIT.
so
  *(u64 *)(r11 - 16) =3D r7;
  // without *(u64 *)(r11 - 8) =3D r6;
  call bar1;                // arg6 =3D r6, arg7 =3D r7

will fail the verification.

> @@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
>  	u32 max_pkt_offset;
>  	u32 max_tp_access;
>  	u32 stack_depth;
> +	u16 incoming_stack_arg_depth;
> +	u16 stack_arg_depth; /* both incoming and max outgoing of stack argumen=
ts */

these two are ok. I'm assuming you don't want JIT to recompute them.

>  	u32 id;
>  	u32 func_cnt; /* used by non-func prog as the number of func progs */
>  	u32 real_func_cnt; /* includes hidden progs, only used for JIT and free=
ing progs */
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 9fbbddc40d21..bb6d8cab3a35 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -372,6 +372,11 @@ struct bpf_func_state {
>  	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>  	 */
>  	int allocated_stack;
> +
> +	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in b=
ytes. */
> +	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. =
*/

but incoming_stack_arg_depth looks odd.

Callee should be accessing caller's stack_arg_depth and
caller's stack_arg_regs.

> +	u16 out_stack_arg_mask; /* Bitmask of outgoing stack arg slots that hav=
e been written. */
> +	struct bpf_reg_state *stack_arg_regs; /* On-stack arguments */
>  };
> =20
>  #define MAX_CALL_FRAMES 8
> @@ -508,6 +513,17 @@ struct bpf_verifier_state {
>  	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>  	     iter++, reg =3D bpf_get_spilled_reg(iter, frame, mask))
> =20
> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
> +	((((slot) < frame->stack_arg_depth / BPF_REG_SIZE) &&           \
> +	  (frame->stack_arg_regs[slot].type !=3D NOT_INIT))               \
> +	 ? &frame->stack_arg_regs[slot] : NULL)
> +
> +/* Iterate over 'frame', setting 'reg' to either NULL or a spilled stack=
 arg. */
> +#define bpf_for_each_spilled_stack_arg(iter, frame, reg, mask)         \
> +	for (iter =3D 0, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask); =
\
> +	     iter < frame->stack_arg_depth / BPF_REG_SIZE;              \
> +	     iter++, reg =3D bpf_get_spilled_stack_arg(iter, frame, mask))
> +
>  #define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, _=
_expr)   \
>  	({                                                               \
>  		struct bpf_verifier_state *___vstate =3D __vst;            \
> @@ -525,6 +541,11 @@ struct bpf_verifier_state {
>  					continue;                        \
>  				(void)(__expr);                          \
>  			}                                                \
> +			bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) { \
> +				if (!__reg)                              \
> +					continue;                        \
> +				(void)(__expr);                          \
> +			}						 \
>  		}                                                        \
>  	})
> =20
> @@ -739,10 +760,13 @@ struct bpf_subprog_info {
>  	bool keep_fastcall_stack: 1;
>  	bool changes_pkt_data: 1;
>  	bool might_sleep: 1;
> -	u8 arg_cnt:3;
> +	u8 arg_cnt:4;
> =20
>  	enum priv_stack_mode priv_stack_mode;
> -	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> +	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> +	u16 incoming_stack_arg_depth;
> +	u16 outgoing_stack_arg_depth;
> +	u16 max_out_stack_arg_depth;

but you already have them in prog_aux?! another copy in bpf_subprog_info?!
Remove one of them. JIT only need one set.

>  };
> =20
>  struct bpf_verifier_env;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..c5f3aa05d5a3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7887,13 +7887,19 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>  	}
>  	args =3D (const struct btf_param *)(t + 1);
>  	nargs =3D btf_type_vlen(t);
> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
> -		if (!is_global)
> -			return -EINVAL;
> -		bpf_log(log, "Global function %s() with %d > %d args. Buggy compiler.\=
n",
> +	if (nargs > MAX_BPF_FUNC_ARGS) {
> +		bpf_log(log, "Function %s() with %d > %d args not supported.\n",
> +			tname, nargs, MAX_BPF_FUNC_ARGS);
> +		return -EINVAL;
> +	}
> +	if (is_global && nargs > MAX_BPF_FUNC_REG_ARGS) {
> +		bpf_log(log, "Global function %s() with %d > %d args not supported.\n"=
,
>  			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
>  		return -EINVAL;
>  	}
> +	if (nargs > MAX_BPF_FUNC_REG_ARGS)
> +		sub->incoming_stack_arg_depth =3D (nargs - MAX_BPF_FUNC_REG_ARGS) * BP=
F_REG_SIZE;
> +
>  	/* check that function is void or returns int, exception cb also requir=
es this */
>  	t =3D btf_type_by_id(btf, t->type);
>  	while (btf_type_is_modifier(t))
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fba9e8c00878..c4e0224ad2f2 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1123,6 +1123,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
> =20
>  		func[i]->aux->name[0] =3D 'F';
>  		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
> +		func[i]->aux->incoming_stack_arg_depth =3D env->subprog_info[i].incomi=
ng_stack_arg_depth;
> +		func[i]->aux->stack_arg_depth =3D env->subprog_info[i].incoming_stack_=
arg_depth +
> +						env->subprog_info[i].outgoing_stack_arg_depth;
>  		if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
>  			func[i]->aux->jits_use_priv_stack =3D true;
> =20
> @@ -1301,8 +1304,10 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
>  	struct bpf_insn_aux_data *orig_insn_aux;
>  	u32 *orig_subprog_starts;
> =20
> -	if (env->subprog_cnt <=3D 1)
> +	if (env->subprog_cnt <=3D 1) {
> +		env->prog->aux->stack_arg_depth =3D env->subprog_info[0].outgoing_stac=
k_arg_depth;
>  		return 0;
> +	}
> =20
>  	prog =3D orig_prog =3D env->prog;
>  	if (bpf_prog_need_blind(prog)) {
> @@ -1378,9 +1383,20 @@ int bpf_fixup_call_args(struct bpf_verifier_env *e=
nv)
>  	struct bpf_prog *prog =3D env->prog;
>  	struct bpf_insn *insn =3D prog->insnsi;
>  	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
> -	int i, depth;
> +	int depth;
>  #endif
> -	int err =3D 0;
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < env->subprog_cnt; i++) {
> +		struct bpf_subprog_info *subprog =3D &env->subprog_info[i];
> +
> +		if (subprog->max_out_stack_arg_depth > subprog->outgoing_stack_arg_dep=
th) {
> +			verbose(env,
> +				"func#%d writes stack arg slot at depth %u, but calls only require %=
u bytes\n",
> +				i, subprog->max_out_stack_arg_depth, subprog->outgoing_stack_arg_dep=
th);
> +			return -EINVAL;
> +		}
> +	}
> =20
>  	if (env->prog->jit_requested &&
>  	    !bpf_prog_is_offloaded(env->prog->aux)) {
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8478d2c6ed5b..235841d23fe3 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -838,6 +838,44 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  	return true;
>  }
> =20
> +/*
> + * Compare stack arg slots between old and current states.
> + * Outgoing stack args are path-local state and must agree for pruning.
> + */
> +static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
> +			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
> +			   enum exact_level exact)
> +{
> +	int i, nslots;
> +
> +	if (old->incoming_stack_arg_depth !=3D cur->incoming_stack_arg_depth)
> +		return false;
> +
> +	/* Compare both incoming and outgoing stack arg slots. */
> +	if (old->stack_arg_depth !=3D cur->stack_arg_depth)
> +		return false;
> +
> +	if (old->out_stack_arg_mask !=3D cur->out_stack_arg_mask)
> +		return false;

shouldn't be neccessary.

> +
> +	nslots =3D old->stack_arg_depth / BPF_REG_SIZE;
> +	for (i =3D 0; i < nslots; i++) {
> +		struct bpf_reg_state *old_arg =3D &old->stack_arg_regs[i];
> +		struct bpf_reg_state *cur_arg =3D &cur->stack_arg_regs[i];
> +
> +		if (old_arg->type =3D=3D NOT_INIT && cur_arg->type =3D=3D NOT_INIT)
> +			continue;
> +
> +		if (exact =3D=3D EXACT && old_arg->type !=3D cur_arg->type)
> +			return false;
> +
> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_=
state *cur,
>  		    struct bpf_idmap *idmap)
>  {
> @@ -929,6 +967,9 @@ static bool func_states_equal(struct bpf_verifier_env=
 *env, struct bpf_func_stat
>  	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
>  		return false;
> =20
> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
> +		return false;
> +
>  	return true;
>  }
> =20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6aa4dc161a56..78c9322870a5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state =
*dst, const struct bpf_func_st
>  		return -ENOMEM;
> =20
>  	dst->allocated_stack =3D src->allocated_stack;
> +
> +	/* copy stack args state */
> +	n =3D src->stack_arg_depth / BPF_REG_SIZE;
> +	if (n) {
> +		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg=
_regs, n,
> +					     sizeof(struct bpf_reg_state),
> +					     GFP_KERNEL_ACCOUNT);

copy is unnecessary.

> @@ -4220,6 +4254,13 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  					}
>  					if (type =3D=3D STACK_INVALID && env->allow_uninit_stack)
>  						continue;
> +					/*
> +					 * Cross-frame reads may hit slots poisoned by dead code eliminatio=
n.
> +					 * Static liveness can't track indirect references through pointers=
,
> +					 * so allow the read conservatively.
> +					 */
> +					if (type =3D=3D STACK_POISON && reg_state !=3D state)
> +						continue;

wait what? Is this a real issue? Are you saying you have a test prog
that passes FP derived pointers in arg 6, 7 and arg_tracking cannot detect =
it?
Then it should be added properly in arg_tracking.
This hack to allow reading poisoned slots is not ok.
This is a serious issue.

pw-bot: cr
