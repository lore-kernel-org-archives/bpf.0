Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0751368D4C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649718; cv=none; b=M+arO7aid3o3iT1WleEA43yegatHVuQEEsZJRAm7Xh2tct6XDNOPoQa5kvKXItLRzSEgtc1eA6TJ875Ayj6Ht3Sl0cR+Z9l/AhG6f/1BdV0nEHvYuf+ADtwBD9JAT18lsPFCneR66DVK/mcSvZyGJ+JSaY1RuKrAbKASlAixB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649718; c=relaxed/simple;
	bh=OtQZB59vqhRT2UOz9CDtFNHpTxXh2peRvSW5+/z2QUg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FvAQxhXphzEIX0d28rs3eCKH4tkYULZyMCbyayLgvm7xK6Wz088EIxHphr4N+dQwDv9YRXczHxvDKZe2wexM4IX38QerUrLf6kyTl7iTbJJ6Ezt35TlLfFelZPk7A+IoFGjvL5PGDGctmW6hNHE/dqGEFAZGiiKEG8vCVQMBz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Top4bUs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Top4bUs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE1D1F00A3D;
	Sat,  5 Sep 2026 23:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649716;
	bh=peffDe1FscJmzHJj4olIA9VH941aNVYDDvHcXEzNWEw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Top4bUs0hjYN1m4wr2vO77M2vfekcxxXAWu3HfJHF6s48SYuq6Vikc5JlJDcRTgQA
	 J01pU7RQ0b90ZSp9iHmquzcbBBJy78SRSq7a814MHtmrvVk1q0ztFkSei75UgCfSOn
	 oR0G7d4kG0MuIubtQTzRNXa/ylszKbk3VygL8fBagAWmU+UdTBa0jfw6lBvlfEhnfi
	 HRgZXx7xOB/eSxOciAGPWjmz6pMox54bzr41o7JwvOxrAgwn1G/VJxcFYW/DmaeNxF
	 jyADqxDAjjrDRDHivElRjTRGmdia0lm+RKgdRYN5vS1GsRxeFYtsRqwReyC5QY1zmP
	 Crwvw8WiGxETw==
Content-Type: multipart/mixed; boundary="===============8825046529455296876=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <40ffa664fac297b60b3387d9e763a2adc31e5ef0692791b718054cd5b5772133@mail.kernel.org>
In-Reply-To: <20260905220117.922028-8-ameryhung@gmail.com>
References: <20260905220117.922028-8-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 07/22] bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:35 +0000 (UTC)

--===============8825046529455296876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f620920ea575..547703f54a89 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -922,6 +922,7 @@ enum bpf_arg_type {
>  	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
>  	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
>  	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
> +	ARG_PTR_TO_PROG_AUX,	/* pointer to the caller's bpf_prog_aux */
>  	__BPF_ARG_TYPE_MAX,
>
>  	/* Extended arg_types. */

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 72bfd8f93ae4..1b731aad54da 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1510,6 +1510,7 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_TIMER,
>  	.arg2_type	= ARG_PTR_TO_FUNC,
> +	.arg3_type	= ARG_PTR_TO_PROG_AUX,
>  };

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a0a74a5e23be..22f5aff76b40 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9400,9 +9406,42 @@ static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_
>  	return true;
>  }
>
> -static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
> +static bool check_arg_prog_aux(struct bpf_verifier_env *env,
> +			       const struct bpf_func_proto *proto)
>  {
> -	return check_raw_mode_ok(fn, meta) &&
> +	bool seen = false;
> +	argno_t argno;
> +	u32 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(proto->arg_type); i++) {
> +		if (proto->arg_type[i] == ARG_UNUSED)
> +			break;

Does this early break work correctly for kfunc protos?

gen_kfunc_arg_proto() in verifier.c skips __ign and implicit arguments
without assigning a type, leaving ARG_UNUSED holes in the middle of
proto->arg_type. For example:

  bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
                        int node_id, u64 flags)

leaves arg_type[1] == ARG_UNUSED while arg_type[2], [3], [4] have real
types. Similarly:

  bpf_list_push_front_impl(head, node, meta__ign, off)

leaves arg_type[2] == ARG_UNUSED while arg_type[3] is a real type.

The loop above terminates at the first hole and never inspects remaining
arguments. If a kfunc has a prog_aux argument after a hole, or has >5
arguments with a prog_aux argument in position 6+, these checks are
unreachable.

The consequence is a net loss of validation. check_kfunc_args()
previously performed both checks unconditionally, per argument, from
BTF. Both were deleted from that function (which now does an unguarded
cur_aux(env)->arg_prog = regno) and moved here, where the early break
makes them unreachable for affected signatures.

The stack-argument check is the more critical one. argno_from_arg(i + 1)
/ reg_from_argno() return -1 for arguments 6 and above, and
check_kfunc_args() now assigns that value into the 4-bit arg_prog
bitfield (include/linux/bpf_verifier.h), yielding arg_prog == 0xf.
bpf_fixup_kfunc_call() would then emit BPF_LD_IMM64(15, (long)prog->aux),
storing to a non-existent register number.

No in-tree kfunc currently combines >5 arguments, a non-implicit
bpf_prog_aux argument and a preceding hole, so the escalation is latent;
the validation loss itself is not.

> +		if (proto->arg_type[i] != ARG_PTR_TO_PROG_AUX)
> +			continue;
> +
> +		if (seen) {
> +			verifier_bug(env, "Only 1 prog->aux argument supported");
> +			return false;
> +		}
> +
> +		argno = argno_from_arg(i + 1);
> +		if (reg_from_argno(argno) < 0) {
> +			verbose(env, "%s prog->aux cannot be a stack argument\n",
> +				reg_arg_name(env, argno));
> +			return false;
> +		}
> +
> +		seen = true;
> +	}
> +
> +	return true;
> +}
> +
> +static int check_func_proto(struct bpf_verifier_env *env, const struct bpf_func_proto *fn,
> +			    struct bpf_call_arg_meta *meta)
> +{
> +	return check_arg_prog_aux(env, fn) &&
> +	       check_raw_mode_ok(fn, meta) &&
>  	       check_arg_pair_ok(fn) &&
>  	       check_mem_arg_rw_flag_ok(fn) &&
>  	       check_proto_release_reg(fn, meta) &&

[ ... ]

> @@ -12044,6 +12083,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
>  	const char *ref_tname = NULL;
>  	int arg_type;
>
> +	if (is_kfunc_arg_prog_aux(meta->btf, &args[arg]))
> +		return ARG_PTR_TO_PROG_AUX;
> +
>  	t = btf_type_skip_modifiers(meta->btf, args[arg].type, NULL);
>
>  	/* Scalar arguments are classified from their BTF suffix/name alone. */
> @@ -12192,9 +12234,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
>  	}
>
>  	for (i = 0; i < nargs; i++) {
> -		if (is_kfunc_arg_prog_aux(btf, &args[i]) ||
> -		    is_kfunc_arg_ignore(btf, &args[i]) ||
> -		    is_kfunc_arg_implicit(meta, i))
> +		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, i))
>  			continue;

Does ARG_PTR_TO_PROG_AUX get recorded for KF_IMPLICIT_ARGS kfuncs with
a bpf_prog_aux argument?

The loop above skips implicit arguments before calling
get_kfunc_arg_type(), so those arguments never get a type and
proto->arg_type[i] stays ARG_UNUSED.

resolve_btfids' is_kf_implicit_arg() restricts implicit arguments to
exactly two types: bpf_prog_aux and btf_struct_meta.
process_kfunc_with_implicit_args() rewrites the BTF at build time: the
visible kfunc FUNC gets a truncated func_proto without the implicit
args, while a <name>_impl FUNC keeps the full one. fetch_kfunc_meta()
sets meta->func_proto to the _impl proto, so is_kfunc_arg_implicit()
returns true for the trailing bpf_prog_aux argument in KF_IMPLICIT_ARGS
kfuncs.

Concrete trace for bpf_wq_set_callback (kernel/bpf/helpers.c, registered
KF_IMPLICIT_ARGS):

  1. nargs = 4 from the _impl proto (wq, callback_fn, flags, aux); the
     visible proto has vlen 3.

  2. i == 3: is_kfunc_arg_implicit(meta, 3) is true -> continue,
     get_kfunc_arg_type() never runs, proto->arg_type[3] == ARG_UNUSED.

  3. check_kfunc_args() i == 3: arg_type == ARG_UNUSED, so the
     ARG_PTR_TO_PROG_AUX branch is skipped and the next line
     (is_kfunc_arg_implicit) continues. cur_aux(env)->arg_prog is never
     set.

  4. bpf_fixup_kfunc_call() tests env->insn_aux_data[insn_idx].arg_prog,
     which is 0, so no BPF_LD_IMM64(R4, prog->aux) is emitted.

  5. At run time bpf_wq_set_callback() is entered with whatever the
     program left in R4 and immediately dereferences it:

       return __bpf_async_set_callback(async, callback_fn, aux->prog);

This affects every KF_IMPLICIT_ARGS kfunc with a bpf_prog_aux argument:
bpf_wq_set_callback (helpers.c, aux->prog), bpf_task_work_schedule_signal
(helpers.c), bpf_task_work_schedule_resume (helpers.c), bpf_stream_vprintk
(stream.c, bpf_stream_get(stream_id, aux)), bpf_stream_print_stack (stream.c),
scx_bpf_cid_override (kernel/sched/ext/cid.c), plus the testmod kfuncs
bpf_kfunc_implicit_arg and bpf_kfunc_multi_st_ops_test_1_assoc. The
register is program-controlled, so this is an arbitrary kernel pointer
dereference reachable from a loadable BPF program.

The immediately following commit in the series, ef7ad41fb8d0, repairs
exactly this by adding ARG_IGNORE, moving the ignore/implicit test after
is_kfunc_arg_prog_aux() inside get_kfunc_arg_type(), and deleting the
pre-classification skip from gen_kfunc_arg_proto(). The ordering fix
from ef7ad41fb8d0 belongs in this commit to avoid a bisect hole.

>
>  		arg_type = get_kfunc_arg_type(env, meta, args, i, nargs);
> @@ -12204,7 +12244,7 @@ static int gen_kfunc_arg_proto(struct bpf_verifier_env *env, struct bpf_call_arg
>  		proto->arg_type[i] = arg_type;
>  	}
>
> -	return 0;
> +	return check_arg_prog_aux(env, proto) ? 0 : -EINVAL;
>  }

[ ... ]

> @@ -12799,18 +12839,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  		int regno = reg_from_argno(argno);
>  		u32 ref_id = args[i].type, type_size;
>
> -		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
> -			/* Reject repeated use bpf_prog_aux */
> -			if (meta->arg_prog) {
> -				verifier_bug(env, "Only 1 prog->aux argument supported per-kfunc");
> -				return -EFAULT;
> -			}
> -			if (regno < 0) {
> -				verbose(env, "%s prog->aux cannot be a stack argument\n",
> -					reg_arg_name(env, argno));
> -				return -EINVAL;
> -			}
> -			meta->arg_prog = true;
> +		if (arg_type == ARG_PTR_TO_PROG_AUX) {
>  			cur_aux(env)->arg_prog = regno;
>  			continue;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============8825046529455296876==--
