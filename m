Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F681A0BD0
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775413238; cv=none; b=BZA8F7XsQ0IRw08o6h1wnOnrsOcJHldnrx1YQBKW2RW9Rnsvy9CxIP6YFjgiGi92rcdwKmY3E7epioK68fNEYodnHZ4ClmMiPfjhJiUT3B8bUCdv6kLD97nhUKo3cXALZxg9YFeUutmXhLFkfB3aCPmOOin+T66PhHLGTq/FUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775413238; c=relaxed/simple;
	bh=79XDv9G3lubUWiVOHGH6u301hScP4XQ071Wl3Bgbyzs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IwuR3ifHMg0gG2Etz/gEkKB4d2VcrSOqtb4dkhptkOYVrvHAsemAWxWiEkWOZYaOrHBav0Ol0hgUoF28poHSFlcZ2jeU9/40zNusCfsX16nL4qIToQROXMnGIopereNYac/x0qbGw1ZW2uOAEiz9In1Ot66a/Hnj8ayE3ZoEz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlV5b9Kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlV5b9Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59425C116C6;
	Sun,  5 Apr 2026 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775413238;
	bh=79XDv9G3lubUWiVOHGH6u301hScP4XQ071Wl3Bgbyzs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GlV5b9KhhL//iuaguJGb+JDbE9p/G/9jJns7u0isuDJ0fI5btjoZYJJkVmR6MFnQD
	 D/waVZx7HOa1yCQXHN9MZlRTeM18SchdWX0Hnb3XmWa8bE6LfEyJjv7aBrLGCVxg6d
	 1LjX+Yrb8S0krjtdI+6DmzPitgAP5CNEuYswb0j//H75S47W82MntaSoIeSeJp8ivG
	 ZZj4y+9oL2zr7JWUWnRLoBEKJc8MNs0NFfsQn6yO+g1LZfvcfj7CGA4Zn+J9lfswGe
	 WxQb1r5/FQJPP6uIzL5qeXXLyK1E4HVx/d60RBsQjHgCjz+3eIOjFEhdBvnATHcbSt
	 1TcaVn+e20ylw==
Content-Type: multipart/mixed; boundary="===============7270530951059331149=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e093e4d67ae569dd8183db5affaa8ec67c3d20c7b9a46c0f78a223041efc0921@mail.kernel.org>
In-Reply-To: <20260405172626.1337674-1-yonghong.song@linux.dev>
References: <20260405172626.1337674-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 08/11] bpf,x86: Implement JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  5 Apr 2026 18:20:38 +0000 (UTC)

--===============7270530951059331149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 32864dbc2c4e..206f342a0ca0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2449,6 +2529,41 @@ st:			if (is_imm8(insn->off))
>  			}
>  			if (!imm32)
>  				return -EINVAL;
> +
> +			if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
> +				s32 outgoing_base = -(prog_stack_depth + outgoing_stack_arg_depth);
> +				int n_args = outgoing_stack_arg_depth / 8;
> +
> +				ip += push_stack_args(&prog, outgoing_base, n_args, 1);
> +			}
> +
> +			if (src_reg != BPF_PSEUDO_CALL && insn->off > 0) {
> +				/* Kfunc calls: arg 6 -> R9, args 7+ -> push. */
> +				s32 outgoing_base = -(prog_stack_depth + outgoing_stack_arg_depth);
> +				int kfunc_stack_args = insn->off;
> +
> +				stack_args = kfunc_stack_args > 1 ? kfunc_stack_args - 1 : 0;
> +
> +				/* Push args 7+ in reverse order */
> +				if (stack_args > 0)
> +					ip += push_stack_args(&prog, outgoing_base, kfunc_stack_args, 2);
> +
> +				/* mov r9, [rbp + outgoing_base] (arg 6) */
> +				if (is_imm8(outgoing_base)) {
> +					EMIT4(0x4C, 0x8B, 0x4D, outgoing_base);
> +					ip += 4;
> +				} else {
> +					EMIT3_off32(0x4C, 0x8B, 0x8D, outgoing_base);
> +					ip += 7;
> +				}
> +			}
>  			if (priv_frame_ptr) {
>  				push_r9(&prog);
>  				ip += 2;

When priv_frame_ptr is active (private stack in use), R9 holds the
private frame pointer throughout the program. The existing push_r9 /
pop_r9 around calls preserves R9 across the function call.

With this new code, two issues arise when stack args and
priv_frame_ptr are both active.

For kfunc calls with stack args: the MOV R9, [rbp + outgoing_base]
overwrites the priv_frame_ptr in R9 with arg6 before push_r9 saves
it. After the call, pop_r9 restores arg6 into R9 instead of the
priv_frame_ptr, so subsequent BPF_REG_FP accesses (which map to R9
when priv_frame_ptr is set) would reference the wrong memory.

For both kfunc and BPF-to-BPF calls: push_r9 inserts an extra 8
bytes onto the stack between the pushed args and the CALL
instruction. The callee then sees the wrong values for its stack
arguments. For example, with a BPF-to-BPF call the callee's
incoming arg formula expects [rbp + 16] to be the first stack arg,
but instead it finds the caller's saved R9 value:

    push_stack_args:  [RSP] = arg1, [RSP+8] = arg2
    push_r9:          [RSP] = R9,   [RSP+8] = arg1, [RSP+16] = arg2
    CALL:             [RSP] = ret,  [RSP+8] = R9 ...
    callee prologue:  [rbp+16] = R9  (expected arg1)

Both priv_stack_mode and stack_arg_depth are set independently per
subprog in jit_subprogs(), so can this combination actually be
reached?

> @@ -2458,6 +2573,14 @@ st:			if (is_imm8(insn->off))
>  				return -EINVAL;
>  			if (priv_frame_ptr)
>  				pop_r9(&prog);
> +			if (stack_args > 0) {
> +				/* add rsp, stack_args * 8 */
> +				EMIT4(0x48, 0x83, 0xC4, stack_args * 8);
> +			}
> +			if (src_reg == BPF_PSEUDO_CALL && outgoing_stack_arg_depth > 0) {
> +				/* add rsp, outgoing_stack_arg_depth */
> +				EMIT4(0x48, 0x83, 0xC4, outgoing_stack_arg_depth);
> +			}
>  			break;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24006922024
--===============7270530951059331149==--
