Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A43644A0
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649716; cv=none; b=Sck4WdZQBisobIX2gJg4n5kJ7iYexN7gzACVKfJdbOiwAMsG+2QCxAq/776pnsfGBdmSfpgvRO/GQsbDlm6Ca7TAtecpz/RlxaYVxkb4p2EV9/s5Z28Tv0umi6yNeDLEByAfplvI2PeqL9HxX0uavw92axjX3OdHJaIV5T3XPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649716; c=relaxed/simple;
	bh=1vkPEjFhhg7l1MbWJeB7h6XTOPzpjb0DsaOXRmrPKY0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tNIkEVFKT39NZIDRimJWV6/UiQ8EVyZArS7JJtuTq2ycNmkWYRQjv0AT7keMc1ZedxTVg2OyEEbNwkwRYGBH0HKCWo4C0AkTo1oTVHSMza2IrG7hQ9B1uNITjdyGTM4E+7/KN3Wem9tGhYPesbJd3Sqlxq1uE9imDJFnDBJlAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEmqLuOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEmqLuOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025DB1F00A3A;
	Sat,  5 Sep 2026 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788649714;
	bh=VpgeurKK0ytYdC4y0iCeFyzdnt8zYRisPKZccFtEJ7o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZEmqLuOyCzniyA7jEPD3QSPVX+8WyLoUCcbk9VvRhUa5SYNy+mln8wtWdOWnozW/f
	 /36XRPyYJfPD6lwrKOja8thKDUifhatI6D/HnKr0hfoCd9sToF9YjEPePMKQnBB2H1
	 ckmjWq2ZGUOEM/kq8IuBM/qa56RB738NT6om2k3XQ4Smw6MlwlJHbNP5vLwf03EQdk
	 oHwgIDhTNw6AkRVikAPkqSEI1Y+2NFr0p4MfA1QQDr0rTC2Z9+zXu/E00W0r1TeYbU
	 m2+qUgHf9XqXhsKCzax8D/MJDwpIrz2HWCCW8mizMwP+sVU0UL5cmffpdRKMACIl+O
	 PR0NGl5F1OWDA==
Content-Type: multipart/mixed; boundary="===============7785990450871967204=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2f4372e64739b68cece2725901e21e0a9437726f003a2c454edda97ee10d0cb7@mail.kernel.org>
In-Reply-To: <20260905220117.922028-22-ameryhung@gmail.com>
References: <20260905220117.922028-22-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 21/22] bpf: Consolidate release argument validation
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 23:08:33 +0000 (UTC)

--===============7785990450871967204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 487ad1ee4179..6c5d7e544f84 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8825,29 +8862,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		return err;
>
>  skip_type_check:
> -	if (arg_type_is_release(arg_type)) {
> -		if (type_may_be_null(reg->type)) {
> -			verbose(env, "Possibly NULL pointer passed to trusted %s\n",
> -				reg_arg_name(env, argno));
> -			bpf_diag_call_arg(
> -				env, insn_idx, argno, meta->func_name,
> -				"the pointer may be NULL, but this call requires a non-NULL pointer",
> -				"Add a NULL check and make the call only on the non-NULL path.");
> -			return -EACCES;
> -		}
> -
> -		if (!arg_type_is_dynptr(arg_type) &&
> -		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
> -			verbose(env,
> -				"release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
> -				meta->func_name, reg_arg_name(env, argno));
> -			bpf_diag_call_arg(
> -				env, insn_idx, argno, meta->func_name,
> -				"release helpers require a value that owns a live resource returned by a matching acquire helper",
> -				"Pass the resource-owning pointer returned by the matching acquire helper, and avoid calling the release helper after ownership has already been transferred or released.");
> -			return -EINVAL;
> -		}
> -	}
> +	err = check_func_arg_release(env, reg, argno, arg_type, meta, insn_idx);
> +	if (err)
> +		return err;

Does removing the type_may_be_null() check here break the percpu kptr
RCU conversion path?

The deleted block rejected maybe-null registers passed to OBJ_RELEASE
helper arguments. Only bpf_kptr_xchg() arg2 has ARG_PTR_TO_BTR_ID_OR_NULL
| OBJ_RELEASE, so it is the only argument whose admission changes.

check_func_arg_release() only keeps the ownership half of the test:

kernel/bpf/verifier.c:check_func_arg_release() {
    if (arg_type_is_dynptr(arg_type) || reg_is_referenced(env, reg) ||
        bpf_register_is_null(reg))
        return 0;
}

but for the percpu-kptr RCU conversion path, release_reg() assumes the
released register is known non-NULL. In check_helper_call():

    bool convert_rcu = (func_id == BPF_FUNC_kptr_xchg) && in_rcu_cs(env) &&
                       (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
    err = release_reg(env, reg, convert_rcu, !!meta.dynptr.id);

release_reg() then calls ref_convert_alloc_rcu_protected(), which for
every register carrying the id does:

    reg->id = 0;
    reg->type &= ~MEM_ALLOC;
    reg->type |= MEM_RCU;

PTR_MAYBE_NULL is deliberately not touched, and reg->id is zeroed. Before
this patch that combination was unreachable because a maybe-null register
could not be passed to bpf_kptr_xchg() at all. Now the verifier can
produce PTR_TO_BTF_ID | MEM_PERCPU | MEM_RCU | PTR_MAYBE_NULL with
reg->id == 0.

That state breaks NULL-check identity matching. check_cond_jmp_op() calls
mark_ptr_or_null_regs() for any JEQ/JNE-against-0 on a maybe-null
register, and mark_ptr_or_null_regs() uses u32 id = regs[regno].id, i.e.
0. mark_ptr_or_null_reg() then matches on:

    if (type_may_be_null(reg->type) && reg->id == id &&
        (is_rcu_reg(reg) || !WARN_ON_ONCE(!reg->id))) {

is_rcu_reg() is just "reg->type & MEM_RCU", so the id==0 sanity WARN is
bypassed and every maybe-null MEM_RCU register with id 0 in the state is
marked non-NULL by a NULL check on any one of them.

Concrete accepted-but-unsafe program with percpu kptr fields pc1/pc2 in a
map value:

    p1 = bpf_percpu_obj_new(struct val_t);
      /* MEM_ALLOC|MEM_PERCPU|PTR_MAYBE_NULL, id=N1 */

    p2 = bpf_percpu_obj_new(struct val_t);
      /* MEM_ALLOC|MEM_PERCPU|PTR_MAYBE_NULL, id=N2 */

    bpf_rcu_read_lock();

    old = bpf_kptr_xchg(&v->pc1, p1);
      /* p1 -> MEM_RCU|MEM_PERCPU|PTR_MAYBE_NULL, id=0 */

    old = bpf_kptr_xchg(&v->pc2, p2);
      /* p2 -> MEM_RCU|MEM_PERCPU|PTR_MAYBE_NULL, id=0 */

    if (p1) {
      /* clears PTR_MAYBE_NULL on p1 AND on p2 (both id 0, both MEM_RCU) */

      q = bpf_this_cpu_ptr(p2);
      /* R1 now looks non-NULL, so ARG_PTR_TO_PERCPU_BTF_ID is accepted */

      q->field = 1;
      /* q is PTR_TO_BTF_ID|MEM_ALLOC|MEM_RCU, non-NULL, writable */
    }
    bpf_rcu_read_unlock();

If bpf_percpu_obj_new() for p2 returned NULL at runtime, the program
stores NULL into the percpu kptr field and then executes
this_cpu_ptr(NULL), which writes at NULL + __per_cpu_offset[cpu].

This would be an unchecked write into the per-CPU area from a
verifier-accepted program.

Note that progs/map_kptr_fail.c:kptr_xchg_possibly_null was deliberately
flipped from __failure to __success, so the relaxation is intentional,
but the changelog does not address the percpu/RCU conversion path, and no
test covers a nullable percpu source xchg'd inside an RCU critical
section.

Should the verifier keep rejecting type_may_be_null(reg->type) for
OBJ_RELEASE helper arguments when the destination kptr field is
BPF_KPTR_PERCPU, or should ref_convert_alloc_rcu_protected() leave a
fresh non-zero reg->id so that maybe-null identity tracking stays intact?

> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> index 50ea3d72d446..8743f52e755d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> @@ -11,8 +11,8 @@ struct {
>  	const char *prog_name;
>  	const char *err_msg;
>  } cb_refs_tests[] = {
> -	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
> -	{ "leak_prog", "Possibly NULL pointer passed to trusted R2" },
> +	{ "underflow_prog", "release function bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
> +	{ "leak_prog", "Unreleased reference id=4 alloc_insn=33" },

This isn't a bug, but could the leak_prog expectation be more robust?

The new expectation hard-codes a full instruction index, "Unreleased
reference id=4 alloc_insn=33", which pins the test to one compiler's
instruction layout for the callback subprog cb2().

Every neighbouring expectation in the same table deliberately truncates
the digits and documents why:

    { "nested_cb", "Unreleased reference id=4 alloc_insn=2" },
      /* alloc_insn=2{4,5} */

    { "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" },
      /* alloc_insn=1{1,2} */

and the equivalent expectation added for the same verifier message in
map_kptr_fail.c drops the number entirely:

    __failure __msg("Unreleased reference id=4 alloc_insn=")

Matching in test_cb_refs() is strstr(log_buf, cb_refs_tests[i].err_msg),
so a truncated prefix such as "Unreleased reference id=4 alloc_insn=3"
matches equally well while tolerating a one- or two-instruction shift from
a different clang version.

As written, the entry breaks with any layout change in cb2(), and unlike
the two neighbours it carries no comment recording the observed range.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============7785990450871967204==--
