Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C4351C34
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693927; cv=none; b=B4Ykf9/jfE31LLH9AVJRy0U6UHCIaUKopnm+PnXsVWFRumvKKzZXpyVrFORq1eA9+DH/Vm7Vw7uAfRkyxqAHpsNnI1ADUsDvKz0cH6dtBXdvZvG/U+HDxk4H5tMrR+QyaRBTil7//HTigVFgJfsXScy03nF5fJARFjmCVFlAJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693927; c=relaxed/simple;
	bh=B2qT1iL8Jpe5wuW9YquNWYf0vxVMNWj+Z02k6SPZYG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+lIASZ4n24Op0GqbJf3kdZeQ62OveLPHY6ndGRO9lULNydv9wmoUtpHy1tCvqY2GZaf3TFnA8J731WGhUyikVFHkwl0oBIzm1WKdUNQsHHLUhPZMX987ugIrngYrxMdm/dl1ywa47kJsQcytzARXpXQlaeZjbCZ6YD2x6l3qqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqPMT+HB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqPMT+HB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26D4C19421;
	Mon, 16 Mar 2026 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773693927;
	bh=B2qT1iL8Jpe5wuW9YquNWYf0vxVMNWj+Z02k6SPZYG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZqPMT+HB4GMhkh8ydsHMvOxFeBeagAUezppDegjdCzF7I63C4rMi2kM4Lg/kBWW7R
	 YvR/I0hEGYAfwd8N5FQF0nM866QRL3dzLYtzmF61kFCdO8INSMdAmd6xYC7R6eVkdd
	 hrUQmsA3xJh7Vk/6bSjbJWCUVjahNVbdX63i6nw6z3oSeYZSrEoMqi+V74/Zt07Qk5
	 R3XkWEc0qY1Wffpks+6w/V8C6YIPuPz5zdKFw7MAKq+nAKCcYCA6TTfKpEbK7otzat
	 rB7YhzdmoxcDAboETRXB4ucYmgW1pDDCAgebcJia2eGJl+AOK9UQ5UKbohkyUntKJO
	 ZExTpMDlf7zJA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
Subject: Re: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset
 in interpreter
In-Reply-To: <20260316190220.113417-2-tangyazhou@zju.edu.cn>
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-2-tangyazhou@zju.edu.cn>
Date: Mon, 16 Mar 2026 20:45:22 +0000
Message-ID: <m25x6vtsf1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yazhou Tang <tangyazhou@zju.edu.cn> writes:

> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> Currently, the BPF instruction set allows bpf-to-bpf call (or internal call,
> pseudo call) to use a 32-bit `imm` field to represent the relative jump offset.
>
> However, when JIT is disabled or falls back to interpreter, the verifier
> invokes `bpf_patch_call_args()` to rewrite the call instruction. In this
> function, the 32-bit `imm` is downcasted to s16 and stored in the `off` field.
>
> ```c
> void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> {
> 	stack_depth = max_t(u32, stack_depth, 1);
> 	insn->off = (s16) insn->imm;
> 	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
> 		__bpf_call_base_args;
> 	insn->code = BPF_JMP | BPF_CALL_ARGS;
> }
> ```
>
> If the original `imm` exceeds the s16 range (i.e., jump offset > 32KB),
> this downcast silently truncates the offset, resulting in an incorrect
> call target.
>
> Fix this by explicitly checking the offset boundary in `fixup_call_args()`.
> If the offset is out of range, reject the program with -EINVAL and emit
> a clear verifier log message.
>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>
> We also evaluated a potentially more fundamental fix: patching the instruction
> stream in `do_misc_fixups()` to mov the 32-bit `imm` into an auxiliary register
> (`BPF_REG_AX`) prior to the call, and then utilizing `BPF_REG_AX` to resolve
> the jump target in the interpreter.
>
> To avoid degrading performance, this patching must be strictly confined to
> cases where JIT is disabled. However, reliably determining the final JIT
> execution status during the verification stage is not easy. Therefore, we
> opted for the simplest and safest fix for now.
>
>  kernel/bpf/verifier.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df22bfc572e2..0ee8a3333193 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23109,6 +23109,12 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  
>  		if (!bpf_pseudo_call(insn))
>  			continue;
> +
> +		if (insn->imm < S16_MIN || insn->imm > S16_MAX) {
> +			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
> +			return -EINVAL;
> +		}
> +

Thanks for the patch. The interpreter truncation fix looks correct, but there's
a similar truncation bug in the JIT success path that should be addressed as
well.

In jit_subprogs(), the "make interpreter insns consistent for dump" fixup at
the end has the same s16 truncation problem:

insn->off = env->insn_aux_data[i].call_imm;
subprog = find_subprog(env, i + insn->off + 1);
insn->imm = subprog;

When call_imm exceeds s16 range, insn->off truncates it, and find_subprog()
looks up the wrong instruction index. In my testing with your selftest,
find_subprog() returns -ENOENT (-2), so insn->imm = -2. This causes bpftool to
compute the call target as __bpf_call_base + (-2), which shows a bogus address
in the xlated dump instead of the actual subprog symbol:

   1: (85) call pc+9#bpf_prog_115951674716e036_padding_subprog
   2: (85) call pc+3402#0xffff80008026d276

The 0xffff80008026d276 is __bpf_call_base - 2, not target_subprog.  This also
leaks the address of __bpf_call_base to userspace.

The fix is to use call_imm directly for the find_subprog() lookup instead of
reading back from the truncated insn->off:

insn->off = env->insn_aux_data[i].call_imm;
subprog = find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
insn->imm = subprog;

this still leaves the ->off to be wrong, but that is fine in my opinion.

Could you fold this into the series as well?
