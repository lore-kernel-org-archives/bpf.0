Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A033D4F3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786848343; cv=none; b=fDD6GiRMadzpq9rkO6j5g7VvWGaw+/uNqCAFfpjREotvAj7JssPhzx7jccCthpzC1QHvIu0qXfD3AQNqhVvrKQswovusAFWtByUKvbF9d4F7nn2804leYucAVVPIvGNt0IBy8wb6fEnoxxmmNi210FicXRRHdsmfB3RLV3peKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786848343; c=relaxed/simple;
	bh=WB6yzUUnTCXm4t8k2Y819JQfUM0DumWO3o+RJYJt7gU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JkVvW498Cga32xqM1fyXFPUtMllHFvE7rNRzkFhHEFJfUQE128CM7zfrfKyg5fx5hdBG0W4/icXr88riHi8SovdBog29xPboUJFOP0zoW+Xq5+UH9sfBE3TS/JuLudz8GiCs5boSDgPwsBScB4LGCJh/kVLM34owvY78WqPB8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5qiorKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5qiorKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC461F00A3A;
	Sun, 16 Aug 2026 02:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786848341;
	bh=MlKFQwOFebc9MCPdysWzeAe1PryPComV29jlnRp6kd8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H5qiorKGGQmYPQ/YNP+qIOcLRxNKr5g9bmoVOy9dFykK0oaMAmAzefJvpKODRuC5U
	 +mnFagOPDGtpQJup6WbzBogcjaXdUUH69kSuMtFzqM7nHX3tFQ24twilxfY7zZDeJN
	 mR1MSRRJY9mcQW5+3UzMdacv+elcAaMsTUdTPaDlDIl/+s7TZRFv8VvbDVkJXPjbBB
	 oqSjiciW13ydHwhOAAGRgcKTkfJ7A7EE6ctawheSws8gz0eZ8DTULY5UpPkB8YPheA
	 IumNqMC2Sjed12SKfl1hwQ36mKcx927ExGRGdWx7E2DYB/XHWbRM+mwArDK4XrXPtN
	 GJ7mC0hoVFrMg==
Content-Type: multipart/mixed; boundary="===============9108484592743497598=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ca570d717200668cd118da805f14edfe0fbbf3e818d14851030917a2964f98e0@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-11-memxor@gmail.com>
References: <20260816015746.2632990-11-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/14] bpf: Correct Program Structure diagnostic context
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:45:41 +0000 (UTC)

--===============9108484592743497598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Correct Program Structure diagnostic context
>
> Program Structure reports have three attribution gaps. A missing jump table
> is reported at the beginning of its subprogram rather than at the gotox that
> needs the table, recursive-call details are present only in the legacy log,
> and the early subprogram-layout checks run before BTF line information is
> installed.
>
> Pass the failing gotox instruction into the jump-table lookup and include both
> ends of a recursive edge in the structured reason.
>
> The BTF validator needs the discovered subprogram boundaries together with
> the LD_ABS and tail-call properties collected during the layout scan. Split
> that property collection from layout validation, then validate BTF before
> reporting layout errors. This makes validated source information available to
> the jump-boundary and fallthrough reports without changing either check.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

All three attribution gaps described here come from a8f427835394 ("bpf:
Report Program Structure CFG errors"), which added the jt_from_subprog()
report at the subprogram start, the sort_subprogs_topo() reason without
the caller and callee, and the two check_subprogs() reports that ran
before line_info was validated.  Should this carry:

  Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3de9e4f617b6..d2f08c6612c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3038,9 +3057,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
>  		}
>  next:
>  		if (i == subprog_end - 1) {
> -			/* to avoid fall-through from one subprog into another
> +			/*
> +			 * To avoid fall-through from one subprog into another,
>  			 * the last insn of the subprog should be either exit
> -			 * or unconditional jump back or bpf_throw call
> +			 * or unconditional jump back or bpf_throw call.
>  			 */
>  			if (code != (BPF_JMP | BPF_EXIT) &&
>  			    code != (BPF_JMP32 | BPF_JA) &&
>  			    code != (BPF_JMP | BPF_JA)) {

[ ... ]

> @@ -21124,17 +21145,19 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
>  
> -	/* Discover all subprograms before validating their layout and BTF. */
> +	/* Discover all subprograms and collect the properties needed by BTF validation. */
>  	ret = add_subprogs(env);
>  	if (ret < 0)
>  		goto skip_full_check;
>  
> -	ret = check_subprogs(env);
> +	find_subprog_properties(env);
> +
> +	/* Validate BTF and apply CO-RE before reporting subprogram layout errors. */
> +	ret = bpf_check_btf_info(env, attr, uattr);
>  	if (ret < 0)
>  		goto skip_full_check;
>  
> -	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
> -	ret = bpf_check_btf_info(env, attr, uattr);
> +	ret = check_subprogs(env);
>  	if (ret < 0)
>  		goto skip_full_check;

Can this reorder let CO-RE relocation patching read and write one
instruction past the end of prog->insnsi[]?

bpf_check_btf_info() applies CO-RE, and check_core_relo() only bounds the
relocation target against prog->len:

kernel/bpf/check_btf.c:check_core_relo() {
	...
	if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >= prog->len) {
	...
	err = bpf_core_apply(&ctx, &core_relo, i,
			     &prog->insnsi[core_relo.insn_off / 8]);
	...
}

so insn_off / 8 == prog->len - 1 is accepted, and bpf_core_patch_insn()
gets a pointer to the very last instruction.  If that instruction has
class BPF_LD, both the poison path and the normal path touch insn[1]:

tools/lib/bpf/relo_core.c:bpf_core_patch_insn() {
	...
	if (res->poison) {
poison:
		if (is_ldimm64_insn(insn))
			bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
	...
	case BPF_LD: {
		...
		insn[0].imm = new_val;
		insn[1].imm = new_val >> 32;
	...
}

bpf_core_poison_insn() stores code, dst_reg, src_reg, off and imm, so
that is a full struct bpf_insn write to insnsi[prog->len].

Was this previously prevented by check_subprogs() running first?  Its
fall-through check fires for the last instruction of the program, since
add_subprogs() sets subprog[env->subprog_cnt].start = insn_cnt:

kernel/bpf/verifier.c:check_subprogs() {
	...
	if (i == subprog_end - 1) {
		if (code != (BPF_JMP | BPF_EXIT) &&
		    code != (BPF_JMP32 | BPF_JA) &&
		    code != (BPF_JMP | BPF_JA)) {
			verbose(env, "last insn is not an exit or jmp\n");
	...
}

BPF_LD | BPF_IMM | BPF_DW is 0x18 and is not in that set, so a program
whose final instruction is the first half of a truncated LD_IMM64 was
rejected with -EINVAL before any relocation ran.

After the reorder, does anything between add_subprogs() and
check_core_relo() still reject that program?  add_subprogs() and the new
find_subprog_properties() only read insn[i] in bounds, and the dedicated
"invalid bpf_ld_imm64 insn" guard in check_and_resolve_insns(), which is
the one that tests i == insn_cnt - 1, runs later than check_subprogs()
in either ordering.

The path looks short to reach: bpf_check_btf_info() only needs
func_info_cnt or line_info_cnt to be non-zero, and check_btf_func()
early-returns when nfuncs is 0, so func_info_cnt == 0 with
line_info_cnt == 1 skips the nr_linfo/subprog_cnt agreement checks
entirely.  A single BPF_CORE_TYPE_ID_LOCAL relocation then returns from
bpf_core_calc_relo_insn() with poison and validate both false, so the
insn[1].imm store happens with no check on the contents of
insnsi[prog->len].

Does the resulting write land outside the allocation?
bpf_prog_alloc_no_stats() rounds the allocation up to a page:

kernel/bpf/core.c:bpf_prog_alloc_no_stats() {
	...
	size = round_up(size, __PAGE_SIZE);
	fp = __vmalloc(size, gfp_flags);
	...
}

where size is bpf_prog_size(insn_cnt).  For an insn_cnt that makes
bpf_prog_size() an exact multiple of PAGE_SIZE, &insnsi[prog->len] is
the first byte of the vmalloc guard page and the store faults; for other
lengths it lands in the page-rounding slack, where it is an
out-of-bounds write that will not be reported.  insn_cnt comes straight
from the load attribute, so the faulting length is easy to pick.

Would it work to keep the last-instruction part of the layout check
before bpf_check_btf_info(), or to have check_core_relo() reject a
relocation targeting the final instruction when that instruction is
BPF_LD | BPF_IMM | BPF_DW?

For what it is worth, nothing in the four commits that follow this one
restores the ordering or adds a trailing-instruction guard.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============9108484592743497598==--
