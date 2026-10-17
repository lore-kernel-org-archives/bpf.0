Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA83AE198
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256904; cv=none; b=slKzoPqkEHuDVROyPVKEOC924NHN7QA9wZWPCD60D30DSsxP6e2FAr4nt5ZFfmfHJzwvd66n+nx+PcJrZxVUvxi8oSOc3OBxhMqjEDpoPeg9iJ/WYbxS117Sw3coeA8FqFqKZ3o8Fyf7T6SMBUzoWIkGBGn9xSbzKkVXHLw+1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256904; c=relaxed/simple;
	bh=UUXlxn6hA40QKHvGT9LkIfNFy1QOC8gTV6nw5t9/4PU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=gcJJfO0MNbOw/2YFsbxJAwATsgeVktgFgQhFBqgvrzxsQYU/1jeeUL+rZtBV3Cl3JkCw84bJM4q/crVhJp5j4zk8TSKuP4Rw8S7oMDn+9mgqmulUNt3M1bJrRtlP4fPyENTEmvwPK9Ka7ffITlN3+2tBDrIVEDbef59P+oBvjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkEGTrxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkEGTrxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9C41F000C4;
	Sat, 17 Oct 2026 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256902;
	bh=yaUX/S7OJOuYqczerXcnGJ/KKSDg+8shBFvXb+RKWFA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FkEGTrxx19zVVxZqgNfqT5CC8/ESR/GYyT/9O+iEPQdj3ci8vMrNYGLH0A84AOzkm
	 y6uac2+BdFwNsOHBXt06Rr6UgglvX2Y2xV4oD9FBG41lldX62T+ngXHYnoxHNLbhvz
	 yTNnc4Shrrz0kC1W9fOO0HAFKAz9Cwj57l0faCrMXMZaoGjfJ1IAaXC5EgTyLt8r2T
	 ILkQfPxORV/CLBgtwmQnQCgLYDvUXADiI9BvZXD6SJ5dHNl8kAK9nk5TAaANnkiweq
	 zlxW2kFu7zaHNeA+HjWP02R3PH0dGm8VKkd6ZDo3SWvAubnjxkJsLeZD8OrBDyF9zR
	 IvyqeT0S1gkww==
Message-ID: <sashiko-outbox-175688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 39/43] bpf: Refuse the prologue for an
 extension that cannot take it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
 <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:08:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: missing changes_pkt_data check and mark for extension pro=
logue
- [Medium] bpf: bpf_convert_ctx_accesses() rejects extensions with no-op ge=
n_prologue()
--

commit 2e35aa5750da9b2ad248d0380937d26b001912e7
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Refuse the prologue for an extension that cannot take it

This commit adds ext_prog_takes_prologue() to reject BPF_PROG_TYPE_EXT
programs that write to packet data unless their first argument is
ARG_PTR_TO_CTX and any remaining register arguments are scalars.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fe59e3114d828..32911d7f494cb 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -858,6 +858,25 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ver=
ifier_env *env,
>  	return 0;
>  }
> =20
> +/*
> + * The prologue takes the context from R1, and it can clobber R2-R5. An
> + * extension gets the arguments of the function that it replaces.
> + */
> +static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
> +{
> +	const struct bpf_subprog_info *sub =3D &env->subprog_info[0];
> +	int i, cnt =3D min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
> +
> +	if (!cnt || sub->args[0].arg_type !=3D ARG_PTR_TO_CTX)
> +		return false;
> +
> +	for (i =3D 1; i < cnt; i++)
> +		if (sub->args[i].arg_type !=3D ARG_SCALAR)
> +			return false;
> +
> +	return true;
> +}
> +
>  /* convert load instructions that access fields of a context type into a
>   * sequence of instructions that access fields of the underlying structu=
re:
>   *     struct __sk_buff    -> struct sk_buff
> @@ -909,6 +928,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env=
 *env)
>  			verifier_bug(env, "gen_prologue is null");
>  			return -EFAULT;
>  		}
> +		if (env->seen_direct_write &&
> +		    env->prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +		    !ext_prog_takes_prologue(env)) {
> +			verbose(env,
> +				"Extension writing packet data must take ctx and scalars only\n");
> +			return -EINVAL;
> +		}
>  		cnt =3D ops->gen_prologue(insn_buf, env->seen_direct_write,
>  					env->prog);

[Severity: Critical]
Can allowing an extension program to receive bpf_unclone_prologue() here
cause a use-after-free of skb->head in the target program when the
replaced global subprogram has changes_pkt_data =3D=3D false?

When bpf_unclone_prologue() is prepended to an extension program, it emits
a call to BPF_FUNC_skb_pull_data:

net/core/filter.c:bpf_unclone_prologue() {
	...
	/* ret =3D bpf_skb_pull_data(skb, 0); */
	*insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
	*insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
	*insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
			       BPF_FUNC_skb_pull_data);
	...
}

At runtime, if skb->cloned is set (for instance, when the target program
did not perform direct packet writes itself and thus received no
bpf_unclone_prologue() at entry, or cloned the skb via
bpf_clone_redirect() before the call), bpf_skb_pull_data() calls
bpf_try_make_writable() -> skb_ensure_writable() -> pskb_expand_head(),
which reallocates skb->head and frees the old buffer.

In the target program, check_func_call() only invalidates packet pointers
and skb dynptr slices in callee-saved registers (R6-R9) if the called
subprogram has changes_pkt_data set:

kernel/bpf/verifier.c:check_func_call() {
	...
	if (env->subprog_info[subprog].changes_pkt_data)
		clear_all_pkt_pointers(env);
	...
}

However, direct packet stores (such as *(u8 *)(long)skb->data =3D val) and
bpf_dynptr_slice_rdwr() set env->seen_direct_write during do_check_main(),
after bpf_check_cfg() and check_attach_btf_id() ->
bpf_check_attach_target() have already run. Neither sets
prog->aux->changes_pkt_data during bpf_check_cfg(), and
bpf_convert_ctx_accesses() does not set prog->aux->changes_pkt_data or
verify that the target subprogram has tgt_changes_pkt_data set (both for
initial attach in bpf_check_attach_target() and subsequent re-attach via
bpf_tracing_prog_attach()).

If the target program holds a packet pointer (PTR_TO_PACKET,
PTR_TO_PACKET_META, or a BPF_DYNPTR_TYPE_SKB slice) in R6-R9 across a call
to a global function sub(struct __sk_buff *skb) with changes_pkt_data =3D=3D
false, and an extension replaces sub() and writes to packet data, wouldn't
the caller dereference the stale pointer in R6-R9 into the freed skb->head
after the extension's prologue runs pskb_expand_head()?

[Severity: Medium]
Also, should the ext_prog_takes_prologue() check be performed only after
ops->gen_prologue() returns cnt > 0?

In kernel/bpf/verifier.c, may_access_direct_pkt_data() sets
env->seen_direct_write =3D true on BPF_WRITE for BPF_PROG_TYPE_XDP,
BPF_PROG_TYPE_SK_MSG, and BPF_PROG_TYPE_CGROUP_SOCKOPT in addition to the
skb program types:

kernel/bpf/verifier.c:may_access_direct_pkt_data() {
	switch (env->prog->type) {
	...
	case BPF_PROG_TYPE_SCHED_CLS:
	case BPF_PROG_TYPE_SCHED_ACT:
	case BPF_PROG_TYPE_XDP:
	case BPF_PROG_TYPE_LWT_XMIT:
	case BPF_PROG_TYPE_SK_SKB:
	case BPF_PROG_TYPE_SK_MSG:
		if (meta && !meta->btf && meta->func_id)
			return meta->fn->pkt_access;

		if (t =3D=3D BPF_WRITE)
			env->seen_direct_write =3D true;
		return true;

	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
		if (t =3D=3D BPF_WRITE)
			env->seen_direct_write =3D true;

		return true;
	...
}

For XDP, SK_MSG, and CGROUP_SOCKOPT targets, ops->gen_prologue() is
bpf_noop_prologue() or cg_sockopt_get_prologue(), which return 0 when
env->seen_direct_write is set. Checking ext_prog_takes_prologue() before
checking cnt > 0 rejects extensions attached to those program types (for
example, an XDP extension taking a struct bpf_dynptr * and calling
bpf_dynptr_slice_rdwr(), or taking ctx in R2) even though no prologue is
generated for them.

>  		if (cnt >=3D INSN_BUF_SIZE) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017163745.3341=
787-1-alexei.starovoitov@gmail.com?part=3D39
