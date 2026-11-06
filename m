Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938954;
	b=0q8k/eLhQOuBvt/4Yze9neRQdD951mUqZCyIoVScZXedHAfj0KVVAtyNgEX66n6BKsGM
	 +gdPHr8/wq+sVFRONaCjn8q+Id7h4bfJc0U5PxnRr73jOiqaxcuXtZXRWuJQcsargJSZJ
	 ocDGUjo81gQp+FGAJj+aHqwMWi5htlcb0IAmYEp1BhtCrkcGUSru0Cioq3MMhfeUO+Nja
	 jVfbqCKKM1iEqC9+TE0DJo1i2qccw2xHM3U3EPuH0rd3jg4nEDlIvrzdgszc42RzHcgrW
	 axEBgV5flCdryYWnLKWqZKFrsDwHdpcTjvGpwy8qo5KTGDcfaUXHm+DfVaD47r8VChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ViTxXTsL76UddcXkrquaP0oUjV5t/+8gWmGq8eaGYA=;
	b=Pi1ixnaD/Gko44dcGPlzeETZgBa+D5MJArv2tyjseq6Xqo3qpiI7Tqemv7AGspLQ6DF1
	 /Zwx4SjHa2UlbUYo8WPYD/9z5dQekvChfCiVbhtW361efSC/YEt0qgleR2DaozDQ8jPZM
	 yYXRJyCMVk2UjnTYSivM9XDWoOg/ZJj4G0cgY75sGzF6q35gIxsPN1D9B8JkLn7qFnO3X
	 l6AjcnU8tk03Pc7tvjl++mGcBBSu9NjbLZrQoytxmcJmeT0nebkUIa1LFFqTnzALxvPT2
	 S4CUEgviId02evbnS/L1W6kPpY9huoS/n87sBDpm4ujkK7AeRx6voVbXKX3qgkZhFBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtABj+PY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA3606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtABj+PY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CE1F0089F;
	Fri,  6 Nov 2026 04:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938954;
	bh=8ViTxXTsL76UddcXkrquaP0oUjV5t/+8gWmGq8eaGYA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WtABj+PYxJ43fWRXpAz7y4nYdq9kHSkJl3g2LAQfOVnoECfZqxyJIijZLBisfVHJw
	 oIMZl40iCUf0PxVPfFgftzoYPhLGIH6125h7PnjkToZcYqpj/oakK9SgiUUNyecy5k
	 G4KJmdNzGxdeXQpG7pqmTbGmEHhvp3reiHinbi/PQ3SkWxSHDa/W/lAwnMdso7e6oD
	 Jx/egGsSIrmXhuZYAX0pkzDyh/ZuBYpOIckOvyZX6OnoKNJOKXhdPlL00Zg7/O5VC8
	 ZADBx6LIbiRH+gF2EP3HjcG95+bnPPsBAAKikW+Rex2GB0Gz/PoZg2tA1QRD55f8u3
	 aMYsLKnR9HHqA==
Message-ID: <sashiko-outbox-200712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 01/45] bpf: Add may_goto to the loops that
 the verifier marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-2-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:22:33 +0000
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
- [Low] bpf: bpf_insert_loop_guards() logs shifted insn index instead of or=
ig_idx
--

commit 4a3883a17feaa6708a44e871a9a6eab87f5197bc
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add may_goto to the loops that the verifier marks

This commit introduces bpf_insert_loop_guards() to insert may_goto
instructions in front of loop instructions marked by the verifier, along
with per-subprogram budget exit sequences when needed.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f95af2ca3591b..6fd79c2fbdc1e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -587,6 +587,225 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn=
, u32 delta)

[ ... ]

> +int bpf_insert_loop_guards(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int len =3D env->prog->len, i, r, s, to, n, jmp, err =3D 0;
> +	struct bpf_insn *patch, *insn;
> +	int *target, *leave, *moved;
> +	bool indirect;
> +	u16 *zero;
> +	s64 off;
> +
> +	for (i =3D 0; i < len; i++)
> +		if (aux[i].loop_guard)
> +			break;
> +	if (i =3D=3D len)
> +		return 0;
> +
> +	/*
> +	 * Where the subprog has 'r0 =3D 0; exit', 0 if it has none. And how fa=
r that moved
> +	 * the subprog: guard_to is from the time before.
> +	 */
> +	leave =3D kvcalloc(2 * env->subprog_cnt, sizeof(int), GFP_KERNEL_ACCOUN=
T);
> +	if (!leave)
> +		return -ENOMEM;
> +	moved =3D leave + env->subprog_cnt;
> +	for (s =3D 0; s < env->subprog_cnt && !err; s++) {
> +		leave[s] =3D append_budget_exit(env, s);
> +		if (leave[s] < 0)
> +			err =3D leave[s];
> +	}
> +	/* A guard cannot jump into a patch that is in the list: 'r0 =3D 0' has=
 no index yet. */
> +	err =3D err ?: bpf_patch_list_commit(env);

[ ... ]

> +	for (i =3D 0; i < len; i++) {
> +		to =3D target[i];
> +		if (to =3D=3D -1)
> +			continue;
> +		/*
> +		 *	may_goto to		or	may_goto +1
> +		 *	insn				goto +N
> +		 *					r0 =3D 0, ...
> +		 *					exit
> +		 *					insn
> +		 */
> +		n =3D 0;
> +		if (zero[i]) {
> +			patch[n++] =3D BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0);
> +			patch[n++] =3D BPF_JMP_A(hweight16(zero[i]) + 1);
> +			for (r =3D BPF_REG_0; r < BPF_REG_FP; r++)
> +				if (zero[i] & BIT(r))
> +					patch[n++] =3D BPF_MOV64_IMM(r, 0);
> +		}
> +		jmp =3D n++;
> +		/* What is behind moves with this patch. The other patches are not the=
re yet. */
> +		if (to =3D=3D -2)
> +			off =3D 0;
> +		else if (to > i)
> +			off =3D to - i + n - jmp - 1;
> +		else
> +			off =3D to - (i + jmp) - 1;
> +		if (off > S16_MAX || off < S16_MIN) {
> +			verbose(env, "exit of the loop is too far from insn %d for may_goto\n=
", i);
> +			err =3D -ERANGE;
> +			break;
> +		}
> +		patch[jmp] =3D BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
> +		if (to =3D=3D -2)
> +			patch[jmp] =3D budget_exit_insn(env, bpf_find_containing_subprog(env,=
 i));
> +		patch[n] =3D env->prog->insnsi[i];
> +		/* A jump to itself is a back edge. It goes through may_goto like the =
others. */
> +		if (jumps_to_itself(&patch[n]))
> +			patch[n].off -=3D n;
> +		else
> +			err =3D bpf_adj_moved_insn(&patch[n], n);
> +		if (err) {
> +			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
> +			break;
> +		}

[Severity: Low]
As reported by Sashiko on v2 [1], should these two verbose() calls in
bpf_insert_loop_guards() log aux[i].orig_idx instead of i?

The first pass in bpf_insert_loop_guards() calls append_budget_exit() for
each subprogram with a near loop guard that leaves the subprogram, and
commits those patches via bpf_patch_list_commit(env). Each appended budget
exit adds 2 or 3 instructions to the end of its subprogram, shifting the
instruction index i in all subsequent subprograms by moved[s]. If the
second pass then fails because off overflows 16 bits or
bpf_adj_moved_insn() returns -ERANGE, logging i reports the shifted index
rather than the original instruction index from the user program (unlike
bpf_patch_list_insert(), bpf_patch_list_commit(), and
bpf_convert_ctx_accesses() in kernel/bpf/fixups.c, which log orig_idx).

Similarly, in kernel/bpf/verifier.c:bpf_check():

	if (ret =3D=3D 0)
		ret =3D bpf_insert_loop_guards(env);

skip_full_check:
	kvfree(env->explored_states);

	/* might decrease stack depth, keep it before passes that
	 * allocate additional slots.
	 */
	if (ret =3D=3D 0)
		ret =3D bpf_remove_fastcall_spills_fills(env);

	if (ret =3D=3D 0)
		ret =3D check_max_stack_depth(env);

	/* instruction rewrites happen after this point */
	if (ret =3D=3D 0)
		ret =3D bpf_optimize_bpf_loop(env);

bpf_insert_loop_guards() is called before check_max_stack_depth(), ahead of
the "instruction rewrites happen after this point" boundary. Because helpers
called by check_max_stack_depth() (such as find_call_insn() in
check_exception_cb() and check_recursion(), as well as check_callbacks())
log raw instruction indices in env->prog->insnsi rather than orig_idx,
rewriting the program in bpf_insert_loop_guards() before
check_max_stack_depth() will also shift the instruction indices reported by
those diagnostics. Should bpf_insert_loop_guards() be moved after
check_max_stack_depth() with the other instruction rewrite passes?

[1] https://lore.kernel.org/r/20261105204513.2230344-2-alexei.starovoitov@g=
mail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D1
