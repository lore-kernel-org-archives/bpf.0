Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12F342510
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962871; cv=none; b=TRJ9cOhfNU8A9IunyU7n+p46uTVMBCJZDUtsaTf2bGZB2+APHT5mer0Fciu71Xtqdvg7BqrObu94qybhiJ46MMcOHp0TnBlPrNflBYqsq+18kzQVdjZV6XmpaaFx2/2Dz+kEFh8Sokx3YKgkKgwZgXyDD/w31QMH7O1FXUBIu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962871; c=relaxed/simple;
	bh=R59z2RWj+zz+da3l3FqIF6KJsiOuZESuna0g2Bc5NoI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jGkOTrzPtRq38nZ7B5Hd2iUNwPDByCpfZFLyGGDWXAiL6aQpHVxws8LsV3mvRrPdVrkDHqKn0DrcsoE/aOShBpEiotgrwKq8g8wwVdXUHWSKnBKdFVNFbx/HxYoSOlqq2TlbHi1wEZMUU7WNYl8UoyjQg8s4vpCsAeVd95mVY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c50ofcsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c50ofcsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DDA1F000FF;
	Mon, 21 Sep 2026 03:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962870;
	bh=gtP0N4N9M0Bf1ohXBgrq8kVE+8W5NyP3vdFJ/I62WK0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c50ofcsJg8FGRP+SvqdagLLMmUiXJ70Gg/5yq8nlOF4zyvZY252RpTGNLE7Ex6wZJ
	 xHnztbqrGkoAbzSHmU9QUcucYZ0TmX6LeMgp8Fey/pPXCSmHvDLk3NR1IKaxkxmPUd
	 oCB2iZDEHUDrAOsO2mvHwF3ZqSxUb8ZQWanj6v+f4vnfHoYg3fWulTFfxPCSJc5NaX
	 /z/mk8op3zBfE4KnwpUI355QgPzkED+C8BHpyjK/T7CqEXxx+ZCXUXUeT3ZxUrg8ld
	 vd/aAgqnTLy15WqpQe+1JGBtzqNrcp+5QzMX7DzdZ3dQx/bV+ZWc5V0OpKo7NkbAoD
	 QSf1I/eAU5CuQ==
Content-Type: multipart/mixed; boundary="===============2321460482249962034=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85f9995a43edb70c76615280e103dc5325742e88330f36c97962ee35f17e3e32@mail.kernel.org>
In-Reply-To: <20260921023843.411943-9-memxor@gmail.com>
References: <20260921023843.411943-9-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 08/11] bpf: Preserve stack initialization for generic output buffers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 03:54:28 +0000 (UTC)

--===============2321460482249962034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0c94f1214cc33..7f1cc115456f4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6993,10 +6993,11 @@ static int check_stack_range_initialized(
>  	 * but BTF based global subprog validation isn't accurate enough.
>  	 */
>  	bool allow_poison = access_size < 0 || clobber;
> -	/* The call will initialize the memory; uninitialized stack allowed */
>  	u32 arg_slot = arg_slot_from_argno(argno);
> -	bool raw_mode = meta && arg_slot < MAX_BPF_FUNC_ARGS &&
> -		       (meta->arg_raw_mem.mask & BIT(arg_slot));
> +	bool uninit = clobber && meta && arg_slot < MAX_BPF_FUNC_ARGS &&
> +		      (meta->arg_raw_mem.mask & BIT(arg_slot));
> +	bool raw_mode = uninit && env->allow_uninit_stack &&
> +			!(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));

Can gating raw_mode on env->allow_uninit_stack cause unprivileged
programs to miss the fastcall contract check?

Before this commit, a generic MEM_UNINIT argument with a constant size
always took raw mode and was later written byte by byte by
mark_raw_stack():

kernel/bpf/verifier.c:mark_raw_stack() {
    for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
        if (!meta->arg_raw_mem.size[slot])
            continue;
        ...
        err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
                               BPF_WRITE, -1, false, false);
    }
}

This check_mem_access() call reaches check_stack_write_fixed_off(),
which calls check_fastcall_stack_contract() to disable the fastcall
rewrite for stack ranges touched by the output buffer. That call to
check_fastcall_stack_contract() is the only mechanism that disables
the fastcall rewrite for output buffers, since
check_stack_range_initialized() itself never calls it.

After this commit, raw_mode is false whenever env->allow_uninit_stack
is false (which is true only for CAP_PERFMON). The byte loop below then
accepts STACK_INVALID slots but leaves them STACK_INVALID, and never
sets arg_raw_mem.size[slot], so mark_raw_stack() skips the slot
entirely and no stack access is ever recorded for the output range.

Meanwhile, mark_fastcall_patterns() still recognizes a fastcall pattern
from BPF_STX stores to R10, and subprog->fastcall_stack_off is set from
them. If a helper output buffer is the only thing touching a stack
region, that region contributes nothing to lowest_off, so the fastcall
pattern is still recognized.

Then check_stack_access_within_bounds() -> grow_stack_state() raises
env->subprog_info[].stack_depth to cover the buffer, but
bpf_remove_fastcall_spills_fills() later overwrites it:

kernel/bpf/fixups.c:bpf_remove_fastcall_spills_fills() {
    if (modified && !subprog->keep_fastcall_stack)
        subprog->stack_depth = -subprog->fastcall_stack_off;
}

and do_misc_fixups() propagates the shrunken value with
env->prog->aux->stack_depth = subprogs[0].stack_depth.

This means the JIT emits a frame of the reduced size while the helper
writes outside that frame. For example, a CAP_BPF | CAP_NET_ADMIN
program (without CAP_PERFMON) that does:

    *(u64 *)(r10 - 8) = r1;         /* fastcall pattern recognized */
    call bpf_get_smp_processor_id;
    r1 = *(u64 *)(r10 - 8);
    r2 = r10;
    r2 += -512;                     /* output buffer */
    r3 = 64;
    call bpf_skb_load_bytes;        /* arg3 = ARG_PTR_TO_UNINIT_MEM */

would have stack_depth reach 512 during do_check(), but the contract
check never fires, so the rewrite is applied and stack_depth is reset
to -fastcall_stack_off. The JIT then emits a frame of that reduced
size, while bpf_skb_load_bytes() writes 64 bytes at r10-512, outside
the frame.

Does this produce kernel stack corruption from a non-CAP_PERFMON
program?

>
>  	access_size = abs(access_size);
>
> @@ -7035,6 +7036,7 @@ static int check_stack_range_initialized(
>  		max_off = reg_smax(reg) + off;
>  	}
>
> +	/* Unprivileged outputs retain each byte's initialization state. */
>  	if (raw_mode) {
>  		meta->arg_raw_mem.size[arg_slot] = access_size;
>  		return 0;

This isn't a bug, but the comment describes the opposite of the code
path it precedes. raw_mode is only true when env->allow_uninit_stack
is set, which requires CAP_PERFMON, so this is the privileged path.
The block records the range so mark_raw_stack() can mark the whole
buffer STACK_MISC, which is the opposite of retaining each byte's
initialization state. The behaviour the comment describes belongs to
the unprivileged fall-through byte loop below.

> @@ -7054,8 +7056,8 @@ static int check_stack_range_initialized(
>  		if (*stype == STACK_MISC)
>  			goto mark;
>  		if ((*stype == STACK_ZERO) ||
> -		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
> -			if (clobber) {
> +		    (*stype == STACK_INVALID && (uninit || env->allow_uninit_stack))) {
> +			if (clobber && (*stype != STACK_INVALID || env->allow_uninit_stack)) {
>  				/* helper can write anything into the stack */
>  				*stype = STACK_MISC;
>  			}

Can unprivileged programs still read back buffers filled by helpers
that fully initialize them?

Because raw_mode now requires env->allow_uninit_stack, STACK_INVALID
slots of an output argument are accepted but left STACK_INVALID (the
clobber condition (*stype != STACK_INVALID || env->allow_uninit_stack)
is false), so any later load from the buffer fails with "invalid read
from stack ..." in check_stack_read_fixed_off().

This change affects helpers that write every byte they are given, not
just partial writers. For example, bpf_skb_load_bytes() with a constant
size writes every byte, yet its output is now treated as
possibly-uninitialized for unprivileged callers.

The commit message acknowledges this: "This also changes readback from
existing full-writing helpers: without permission to read uninitialized
stack memory, programs must initialize those bytes themselves before
reading them after a call."

However, the stated motivation is partial-output helpers such as
bpf_snprintf() that may leave bytes untouched. Those helpers are newly
annotated with MEM_UNINIT by this same commit and previously required
a pre-initialized buffer anyway, so for them the change is a pure
relaxation.

Would distinguishing partial writers from full writers (e.g. a separate
flag) avoid breaking existing unprivileged users of
bpf_skb_load_bytes() and similar helpers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35555832550
--===============2321460482249962034==--
