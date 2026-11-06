Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940593;
	b=MXz2M2gltdnIA5gce/V/Q00X/pAh/BBoHIH7zuNG7Roc9bwGWvqoHjvi3Pv3arXuuhDM
	 4eObTDNHW/d28XwPtBWMLARjhBlXQzpUk0Z7rBeIrY6hyQzkTiRMvtDAYS1DqC34dEbgv
	 3NhVk8MJVEqsXCPceRZcHOrq5EhLwBrPD5pqW3iN6MpscMfnPTilmwF7gbSta82HqmB+5
	 PGDEHDDpXDIFNXroAd6yUfKWsxB/xNJNFvXukk1w11yMx3n3lMCeQj8iHN3wMHF780fbI
	 Qh47U0O/fWETpnAEzo4P+elDTO875I27g8UDqPrTiMCiYP3vM736CD0LYUkozL8X9Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zjkdK5WQIF85WZ1IAE+DDAiDdjJ9qi8NtmjMhGkm5Zk=;
	b=3S5MgKfnwIkiNsi0iVH8JFDdj04Ct08kGgt+6Y6AokJm2J+szX5yL+r7Bowg91j7FPoZ
	 7XvVHYzUOcTJ9h3XC3opj2qbGd7+ibN12yqm34op0JuM0CdkZnvbh/D83QTCS3oUCzpFa
	 w8DcjNfWo/kopMwJ5ykzd6kNxS7TK0tBbL8wuoPCR0+J9jCqsnXgKgjigtTklzIXQitGW
	 7Dtu6/fLqxtsKw1FtbXAszPPO4QtCqDbPlPcIFOMQVCq2W+isTsPASbin86I5u3h9a4mu
	 TVGa+JkjTWfW9Szrr4eEBkJ/ShEneFWn5P4C3zuZKDmm7xYiO8B7sQtx4VM2Im24QKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJnyCocB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6C606A331
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJnyCocB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E871F008A1;
	Fri,  6 Nov 2026 04:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793940592;
	bh=zjkdK5WQIF85WZ1IAE+DDAiDdjJ9qi8NtmjMhGkm5Zk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YJnyCocBFaBvmHkduh+Zo9IlcQC+X4e7jVtHQATCp0y/i1Db572HbDoWoVl0Nmfyn
	 oiQjccbD+kJjFnjpTnFJgiEhiz/l5b8KzFVjVQZDalyFNG0HD8vvw3xa/83iqUWeS2
	 oZxyv6Nkt6GpWLHlhCulkwim+lqq9J/+9okV1iGys7CyMRmk6nGjDDV8mS1hv3Llue
	 MADckBhACuS3VYM6lUWjtWS3DydJKRGgdGtBlkHxEKlc4BNhkfseJIigpvnVTs30Q7
	 M3sVdqQ+McW2tRo2jl9l0LWHbZ7vrgu6vLMg2LpDICv+Zy/Yf/SvOmZFhe7DiDYR4L
	 us28P3FYPO5Jw==
Message-ID: <sashiko-outbox-200769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 27/45] bpf: Track a pointer to one of a set
 of functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-28-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-28-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:49:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: unconditional R1-R5 split in do_check_insn() causes state e=
xplosion
--

commit 75a36349ee42f80ce6f3c17dd0dfc5718a853221
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Track a pointer to one of a set of functions

This commit tracks a pointer read from a function table as a single
register state representing a set of target functions (func_set) instead
of branching states at the load instruction. The function set is later
expanded into individual function targets when a callx instruction or a
helper/kfunc call requires a specific function.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 437a3fc03d0bf..41500f03b41be 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12028,13 +12072,93 @@ static int check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
[ ... ]
> +/* The insn needs to know the function: go on with each function of the =
set. */
> +static int split_func_set(struct bpf_verifier_env *env, int regno)
> +{
> +	struct bpf_reg_state *reg =3D reg_state(env, regno);
> +	struct bpf_verifier_state *branch;
> +	struct bpf_func_set *set;
> +	u32 i;
> +
> +	if (reg->type !=3D PTR_TO_FUNC || !reg->func_set)
> +		return 0;
> +	set =3D env->func_sets[reg->func_set - 1];
> +	reg->func_set =3D 0;
> +	for (i =3D 0; i < set->cnt; i++) {
> +		reg->subprogno =3D set->subprog[i];
> +		if (i =3D=3D set->cnt - 1)
> +			break;
> +		branch =3D push_stack(env, env->insn_idx, env->insn_idx, false);
> +		if (IS_ERR(branch))
> +			return PTR_ERR(branch);
> +	}
> +	return 0;
> +}
[ ... ]
> @@ -20952,6 +21068,12 @@ static int do_check_insn(struct bpf_verifier_env=
 *env, bool *do_print_state)
>  				return check_func_callx(env, insn, &env->insn_idx);
>  			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
>  				return check_func_call(env, insn, &env->insn_idx);
> +			/* a callback is one function */
> +			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> +				err =3D split_func_set(env, i);
> +				if (err)
> +					return err;
> +			}
>  			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
>  				return check_kfunc_call(env, insn, &env->insn_idx);
>  			return check_helper_call(env, insn, &env->insn_idx);

[Severity: Medium]
In do_check_insn(), split_func_set() is called unconditionally across all
registers BPF_REG_1 through BPF_REG_5 before every kfunc and helper call,
without checking whether the register is actually a callback argument or
even live at env->insn_idx.

Within a basic block, helper and kfunc calls that do not invoke synchronous
callbacks do not have a flow point set, so do_check_block() steps into the
call instruction without running bpf_flow_deliver() or
bpf_clean_verifier_state():

  do_check_block()
    do_check_insn()
      split_func_set()

If a caller-saved register in R1..R5 was loaded with a func_set of size N
earlier in the block and copied to a callee-saved register R6..R9 or
spilled to the stack before a helper or kfunc call that does not overwrite
that register, the dead register still holds PTR_TO_FUNC with reg->func_set
set when reaching the call.

In that case, split_func_set() clones env->cur_state N - 1 times onto
env->head at env->insn_idx. After env->cur_state finishes the call,
flow_drain() delivers those N - 1 states to env->insn_idx, allocating N - 1
flow_state objects, cleaning the dead register in flow_arrive(), and queuing
a duplicate pending state at env->insn_idx that re-verifies the call and the
rest of the basic block a second time.

Furthermore, if a second register in R1..R5 is marked live in
live_regs_before at the call while also holding a func_set, looping over
BPF_REG_1..BPF_REG_5 splits both registers and produces all N * N
combinations at env->insn_idx. For example, bpf_timer_set_callback_proto
sets arg3_type =3D ARG_PTR_TO_PROG_AUX, which causes bpf_get_call_summary()=
 to
set arg_slot_cnt =3D 3 and compute_insn_live_regs() to mark R3 live in
live_regs_before even though the BPF program only passes R1 and R2. If a
program loads a callback from a table of N >=3D 33 functions into R3 and
copies r2 =3D r3 before calling bpf_timer_set_callback(), splitting both R2
and R3 creates N * N >=3D 1089 unjoinable states at env->insn_idx, exceeding
BPF_FLOW_MAX_STATES (1024) in flow_merge() and failing verification with
-E2BIG.

Should split_func_set() only be invoked for registers that correspond to
actual callback arguments (such as inside check_func_arg() /
process_kf_arg_ptr_to_func(), or gated on the call prototype and
live_regs_before)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D27
