Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913282;
	b=h322iXjvKv5jdlUAgDnlCzLXhy0R7M0DSe0ZQK1WARLfO4lDXdIMJWCZbKMg/HWEzXe+
	 ZRrxtrp/ExF26OZr4A3/h0pWjxSHHDsFgzQve7lDN5fZ67S/Q+sOGzzWngZwQrksAJ9TW
	 Bp5kssfteMIa8tOKOY0O1QXyeA/+WAaW/ENR2bJ8CjPO6n3DnRtQHHHAEMwFclwdA/Yes
	 2h/5FvSAldJT54wtPLK8Q2N/+wecxsSQTvljpTON/0SZVWcpR3zEuYFI6HNB02ntBlCob
	 uS/YRCOibX1wYxzqZ7UQ/haDr1jTpKVIGmNExXsE8BcSNLpk4k5RM79bMzC4Blp3ayQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913282;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=khMG3Nf4jVFkyHA2UKSeSuvTDTzg/XMhVF7O241qpr0=;
	b=rry4MHgU348a5yCiQmhNcjLR+ILZWMdLND21FVXy8Z2ycFBQXoBmrez1W+oBGOMt1QN8
	 eqVB1evcx/6SLZn6oDv5aAltzE1jTXoi1VLFvCztBo3PQzvzftjVVGjnMZ5wMbqY7Itp2
	 mODh6iaT9NjjVgkSDiCpy2H5sEBsIloHKA5csGSv7sxMcxduQGfSh8pH+OYwMtziQTKLN
	 ZCfBckaMCPgXtekCX2VTY7MTKMlHf/r89gyGRy1TZ3Di93eu84eoTCB00gN7pw8FDakRx
	 defuLsPAH5QNdKDUn981lvs0xCnB3UNszXA2ut/Pq5Z4Ulu8QFQBHOoCcthZo8HGlwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z24vXluW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF85606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z24vXluW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0F61F0089F;
	Thu,  5 Nov 2026 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913282;
	bh=khMG3Nf4jVFkyHA2UKSeSuvTDTzg/XMhVF7O241qpr0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z24vXluWU6SjHAX3pi84cubEUmj8Yomh7B++gsmoGPDSTgeRHsy8RbkW867PEX0xE
	 9ovee58xgkuTh6aYdgX4JhUvieEJWwJDITs2fmqIfqEiv/UHnRbPEqZBMWv+7pIN4o
	 I3zxLUTBrMGR9OuV46YAW9kSDW2VEiCrxo3qn+Dpf4mnfGu9ShSSlYqpj1NFQ0vvYP
	 udu6uYRBaM9zVoRWd1FCJg+sjo4xhbmmhRuH4uKJM8496kR5uN3TlpD5nbCtWSgF5f
	 yNfHJgd9hIBEHwyf642EYa3mzvPfWGflzNUYkzV1jC0GDx8rGrSBexWNGgJdIHBxrf
	 1/HqjALh/W8dw==
Message-ID: <sashiko-outbox-200205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/35] bpf: Add may_goto to the loops that
 the verifier marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261105204513.2230344-2-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
 <20261105204513.2230344-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:14:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: unadjusted BPF_JMP32 | BPF_JA self-jump in bpf_insert_loop_gu=
ards()
- [Low] bpf: bpf_insert_loop_guards() logs shifted insn index instead of or=
ig_idx
--

commit 9383027921f2fdc75a3e30a579a0417926be85e9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add may_goto to the loops that the verifier marks

This commit introduces bpf_insert_loop_guards() to prepend may_goto
instructions to loops marked by the verifier, along with per-subprogram
budget exit sequences when the guard unwinds or exits the subprogram.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f95af2ca3591b..6fd79c2fbdc1e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -587,6 +587,225 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn=
, u32 delta)
>  	return 0;
>  }
> =20
> +static bool jumps_to_itself(const struct bpf_insn *insn)
> +{
> +	u8 class =3D BPF_CLASS(insn->code), op =3D BPF_OP(insn->code);
> +
> +	return (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) && op !=3D BPF_=
CALL && op !=3D BPF_EXIT &&
> +	       insn->code !=3D (BPF_JMP32 | BPF_JA) && insn->off =3D=3D -1;
> +}

[ ... ]

> +int bpf_insert_loop_guards(struct bpf_verifier_env *env)
> +{

[ ... ]

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

[ ... ]

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

[Severity: High]
What happens here when the guarded instruction at patch[n] is a 32-bit
unconditional jump to itself (BPF_JMP32 | BPF_JA with imm =3D=3D -1)?

In jumps_to_itself(), BPF_JMP32 | BPF_JA is excluded and only insn->off =3D=
=3D -1
is checked, so jumps_to_itself(&patch[n]) returns false. Control then passes
to bpf_adj_moved_insn(&patch[n], n):

kernel/bpf/fixups.c:bpf_adj_moved_insn() {
	...
	} else if ((class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) &&
		   op !=3D BPF_CALL && op !=3D BPF_EXIT) {
		if (insn->code !=3D (BPF_JMP32 | BPF_JA)) {
			off =3D insn->off;
			off_min =3D S16_MIN;
			is_imm =3D false;
		}
		/* jump to itself stays */
		if (off >=3D -1)
			return 0;
	...
}

Because off is -1, bpf_adj_moved_insn() returns 0 without subtracting n from
patch[n].imm, and patch_list_adj_insn() during bpf_patch_list_commit() also
leaves it unchanged because the target n + (-1) + 1 =3D n is within the pat=
ch.

Wouldn't that leave patch[n].imm as -1 so that at runtime execution passes
through the prepended may_goto once and then spins forever on patch[n]
itself, bypassing the loop guard? And when adjusting a self-jumping
BPF_JMP32 | BPF_JA, shouldn't n be subtracted from patch[n].imm rather than
patch[n].off?

> +		if (err) {
> +			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
> +			break;
> +		}

[Severity: Low]
Should these two verbose() calls in bpf_insert_loop_guards() log
aux[i].orig_idx instead of i, as bpf_patch_list_insert(),
bpf_patch_list_commit(), and bpf_convert_ctx_accesses() do?

Before this loop runs, the first pass in bpf_insert_loop_guards() calls
append_budget_exit() and commits those patches via bpf_patch_list_commit().
Any subprogram that received a budget exit has 2 or 3 instructions appended,
so i in subsequent subprograms is shifted relative to the original program.

Also, in kernel/bpf/verifier.c:bpf_check():

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

Calling bpf_insert_loop_guards() before check_max_stack_depth() rewrites
instructions before check_exception_cb(), check_recursion(), and
check_callbacks(), which log raw instruction indices from env->prog->insnsi.
Should bpf_insert_loop_guards() be placed after check_max_stack_depth() with
the other instruction rewrites?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204513.2230=
344-1-alexei.starovoitov@gmail.com?part=3D1
