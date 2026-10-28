Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149816;
	b=PlTnFp2QL+KK8eM4kcIMntde9X3uDtmJJiR7H9AHONI0eUkkubbQyrBTeXesVaI+1Msb
	 rUk/12mc9Lmgbg4xEr/LY61r8SogDy0oJrn5mxXtKhaWtXXSgvx/hKIVIOxDLea0/kqyr
	 Ar0sN14M/Cx1ln75eqM5eg+wB8dLIAkNSc0Ubaz9gVLETE67DMNW6NbyDDReK3+iCtreV
	 Vi9dsKC4W3KkUmAbSmdZQWzt/nzwga1c5CU4n5YiB+iykm1EicNM4Ubs7pR+gQe7vuF2R
	 s4GegJQrSj+JVez3dirse4pe6o14hXDwl/cqjQ7xKvpqyD6vD4lG4TKuFp3q1iw5Ypg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gh8SXkpFU5ILApurssIZiU0bYCI3BLsEOn3lKsl9M3g=;
	b=hduhE78V/2PIFNGQWkys8GeXhXhAKmiXTav5Rc9xv/mqr3BpsAv2E+PG0tUUvSvFWDeC
	 je6pNROQEPhGsTRzi50o+7x24mQdIvpbTvtTQUqGOfjXjokhL57ASsQu55/geDyDg9euY
	 pBCqpw6IK6xAE4LQztXOBHkivrUwfKFVVuL7VhI7W4Y/QvB0JUKNLzXBvNjqgIMjafjXg
	 0EvE8QpwQ1fMs0PbOw/O/JS9Pys5ybZfyFKQ1uehvopJWk4ogffmZw3Y/KTztPKFQ85KQ
	 i/waykQKHYJgMMA0RhPlrHuvaq0II3k6vUUrUy7R0Ek7ZIj3g5iPb1CuU1t9Rp7wC4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PrPFpx3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A5606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrPFpx3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560531F01825;
	Wed, 28 Oct 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149816;
	bh=gh8SXkpFU5ILApurssIZiU0bYCI3BLsEOn3lKsl9M3g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PrPFpx3/BM3LrZIAWhe+LEtFPDzHxbQe9IfQTwI7mKATMm2kiomwRtKfSDJ9R4Y88
	 9jJUGehbiQC6NBrLiPYyjBQVX4tJpQ36ZpxQ6wTMjk81fq0+k0HdNkp/nBSQZmYRph
	 Y+8to7IbUEBbqckYSoX9ItpkIBa9PWBKuzyscF41PmKpTk4S3me64IjEwdNbgkis2K
	 eRDRz7Iv6X7OLS0uo1a1GfaCATk9R8uRBOvX6hLgwjeJ+z1AxckIA9P+IMXYOw7HTK
	 x7zD7+fPI822AZ4lLMLRXe1i4wuDbPt7uBw35cOp8l8CV1RSvb8JOGcTu6tIqWyJ1s
	 +I9o0pMYNO4gw==
Message-ID: <sashiko-outbox-187304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 04/11] bpf: Give the inlined bpf_loop a
 pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <a9599f7ed1c7bbb5109d2a9e2c7135af15045738.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <a9599f7ed1c7bbb5109d2a9e2c7135af15045738.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:10:15 +0000
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
- [High] bpf: inline_bpf_loop() emits pad to unseen target deleted by dead =
code removal
- [High] bpf: inline_bpf_loop() leaves orphaned unwind_goto after LDX_MEM w=
hen !pad
--

commit f87a8cc4d4bc638d4f9d4773f7657f7aec4d7868
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Give the inlined bpf_loop a pad

This commit updates inline_bpf_loop() to emit an unwind landing pad when the
callback subprogram can unwind and an unwind_goto instruction follows the
bpf_loop() call. The inlined pad restores callee-saved registers R6-R8, jum=
ps
to the caller's landing pad, and rewrites the original unwind_goto after the
bpf_loop() call into a no-op jump.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f062ef7dd943d..94a379c94c675 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2836,6 +2836,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
>  	return 0;
>  }
> =20
> +/*
> + * When the callback can unwind and unwind_goto follows the call of bpf_=
loop,
> + * unwind_goto follows the call of the callback, and the pad restores r6=
-r8 and
> + * jumps to the pad after the call of bpf_loop with the r0 of the callba=
ck, which
> + * the verifier has checked with the state of that r0. The unwind_goto t=
hat
> + * followed the call of bpf_loop doesn't follow a call anymore and becom=
es a
> + * no-op jump. A loop of no rounds never runs its callback, so the verif=
ier asked
> + * for no unwind_goto there, and the insn after the call is some other i=
nsn.
> + */
>  static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
>  					int position,
>  					s32 stack_base,
> @@ -2848,6 +2857,8 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_=
verifier_env *env,
>  	int reg_loop_max =3D BPF_REG_6;
>  	int reg_loop_cnt =3D BPF_REG_7;
>  	int reg_loop_ctx =3D BPF_REG_8;
> +	bool pad =3D env->subprog_info[callback_subprogno].can_unwind &&
> +		   bpf_is_unwind_goto(&env->prog->insnsi[position + 1]);

[Severity: High]
Can this leave a live BPF_JMP32_A instruction targeting a dead caller landi=
ng
pad that gets removed by bpf_opt_remove_dead_code(), leading to an
out-of-bounds read in addrs[] or ctx->offset[] during JIT compilation?

In inline_bpf_loop(), pad is enabled without checking whether the target of
the unwind_goto at position + 1 was actually visited during verification:

    caller_pad =3D position + 2 + env->prog->insnsi[position + 1].off;
    env->insn_aux_data[caller_pad].seen

The caller's landing pad can remain unseen while can_unwind and
bpf_is_unwind_goto(&env->prog->insnsi[position + 1]) are both true, for
example when bpf_loop() is called with 0 iterations (r1 =3D=3D 0, which ski=
ps
push_callback_call() in check_helper_call() while still marking the call si=
te
fit_for_inline in update_loop_inline_state()) or when unwind_exit in the
callback lies on a branch not taken for this call site.

In bpf_check(), bpf_optimize_bpf_loop() runs before
bpf_opt_hard_wire_dead_code_branches() and bpf_opt_remove_dead_code():

bpf_check()
  bpf_optimize_bpf_loop()
    inline_bpf_loop()
      bpf_patch_insn_data()
        adjust_insn_aux_data()
  bpf_opt_hard_wire_dead_code_branches()
  bpf_opt_remove_dead_code()
    verifier_remove_insns()
      bpf_remove_insns()
        bpf_adj_branches()
          bpf_adj_delta_to_off()

When bpf_patch_insn_data() patches the inlined loop, adjust_insn_aux_data()
marks all patched instructions in insn_buf as seen, including the inlined
pad and its trailing BPF_JMP32_A instruction, while the original unwind_goto
is overwritten with BPF_JMP_A(0).

When bpf_opt_hard_wire_dead_code_branches() runs next, it preserves the
inlined BPF_UNWIND_GOTO because its target (the inlined pad) is marked seen,
and ignores the BPF_JMP32_A instruction because it is an unconditional jump.

When bpf_opt_remove_dead_code() then removes the unseen caller landing pad
range [pos, end_old), bpf_adj_delta_to_off() only adjusts forward jumps when
curr + off + 1 >=3D end_old. Because BPF_JMP32_A targets caller_pad inside =
the
removed range [pos, end_old), its imm offset is not adjusted. If caller_pad
is at the end of a subprogram and preceded by other dead instructions (or
followed by a subprogram where bpf_do_misc_fixups() calls adjust_jmp_off()
for may_goto), BPF_JMP32_A jumps past the end of the subprogram, causing
do_jit() on x86-64 to read past addrs[] and bpf2a64_offset() on arm64 to re=
ad
past ctx->offset[].

Should pad also require env->insn_aux_data[position + 2 +
env->prog->insnsi[position + 1].off].seen to be true?

> =20
>  	struct bpf_insn *insn_buf =3D env->insn_buf;
>  	struct bpf_prog *new_prog;
> @@ -2865,7 +2876,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_=
verifier_env *env,
>  	 */
>  	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
>  	insn_buf[cnt++] =3D BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
> -	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JA, 0, 0, 16);
> +	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JA, 0, 0, pad ? 22 : 16);
>  	/* spill R6, R7, R8 to use these as loop vars */
>  	insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offse=
t);
>  	insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offse=
t);
> @@ -2877,17 +2888,20 @@ static struct bpf_prog *inline_bpf_loop(struct bp=
f_verifier_env *env,
>  	/* loop header,
>  	 * if reg_loop_cnt >=3D reg_loop_max skip the loop body
>  	 */
> -	insn_buf[cnt++] =3D BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
> +	insn_buf[cnt++] =3D BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, pa=
d ? 6 : 5);
>  	/* callback call,
>  	 * correct callback offset would be set after patching
>  	 */
>  	insn_buf[cnt++] =3D BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
>  	insn_buf[cnt++] =3D BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
>  	insn_buf[cnt++] =3D BPF_CALL_REL(0);
> +	if (pad)
> +		/* to the pad below when the callback left with unwind_exit */
> +		insn_buf[cnt++] =3D BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GO=
TO, 7, 0);
>  	/* increment loop counter */
>  	insn_buf[cnt++] =3D BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
>  	/* jump to loop header if callback returned 0 */
> -	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6);
> +	insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, pad ? -7 : -6);
>  	/* return value of bpf_loop,
>  	 * set R0 to the number of iterations
>  	 */
> @@ -2896,12 +2910,35 @@ static struct bpf_prog *inline_bpf_loop(struct bp=
f_verifier_env *env,
>  	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offse=
t);
>  	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offse=
t);
>  	insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offse=
t);
> +	if (pad) {
> +		/* over the pad */
> +		insn_buf[cnt++] =3D BPF_JMP_IMM(BPF_JA, 0, 0, 4);
> +		/* the pad: r0 is what the callback unwound with */
> +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offs=
et);
> +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offs=
et);
> +		insn_buf[cnt++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offs=
et);
> +		/*
> +		 * To the pad of the caller, where the unwind_goto that follows
> +		 * the patch goes. Its offset is known once the patch is in and
> +		 * the jumps across it are adjusted, see below.
> +		 */
> +		insn_buf[cnt++] =3D BPF_JMP32_A(0);
> +	}
> =20
>  	*total_cnt =3D cnt;
>  	new_prog =3D bpf_patch_insn_data(env, position, insn_buf, cnt);
>  	if (!new_prog)
>  		return new_prog;
> =20
> +	if (pad) {
> +		struct bpf_insn *unwind_goto =3D &new_prog->insnsi[position + cnt];
> +
> +		/* the jump of the pad, one insn before, takes the target of the unwin=
d_goto */
> +		new_prog->insnsi[position + cnt - 1].imm =3D unwind_goto->off + 1;
> +		/* and the unwind_goto after the call of bpf_loop follows no call anym=
ore */
> +		*unwind_goto =3D BPF_JMP_A(0);
> +	}

[Severity: High]
What happens if bpf_is_unwind_goto(&new_prog->insnsi[position + cnt]) is tr=
ue,
but pad is false (for example, when
env->subprog_info[callback_subprogno].can_unwind is false, or when the
caller's landing pad was not reached from this call site)?

In check_unwind_insns() and check_cb_unwind(), an unwind_goto instruction is
permitted after a bpf_loop() call even when the callback subprogram has
can_unwind =3D=3D false:

kernel/bpf/verifier.c:check_cb_unwind() {
    if (!env->subprog_info[subprog].can_unwind)
        return 0;
    ...
}

When inline_bpf_loop() runs with pad =3D=3D false, it replaces the bpf_loop=
()
call with 19 instructions ending in BPF_LDX_MEM(BPF_DW, BPF_REG_8,
BPF_REG_10, r8_offset), and the error branch BPF_JMP_IMM(BPF_JA, 0, 0, 16)
jumps directly to new_prog->insnsi[position + cnt].

Because the rewrite of *unwind_goto =3D BPF_JMP_A(0) is guarded by if (pad),
an unwind_goto following the bpf_loop() call is left in place when !pad. If
the landing pad targeted by that unwind_goto was marked seen via another
unwinding call in the same subprogram, bpf_opt_hard_wire_dead_code_branches=
()
sees:

    if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen)

and preserves the orphaned unwind_goto instruction. That leaves
BPF_UNWIND_GOTO immediately following BPF_LDX_MEM instead of a call
instruction, causing the x86-64 and arm64 JITs (which assume insn[i - 1] is=
 a
call instruction) to emit bogus EX_TYPE_BPF exception table entries and
unwind stubs keyed inside the BPF_LDX_MEM instruction.

Should new_prog->insnsi[position + cnt] be rewritten to BPF_JMP_A(0) whenev=
er
bpf_is_unwind_goto(&new_prog->insnsi[position + cnt]) is true, regardless of
whether pad is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D4
