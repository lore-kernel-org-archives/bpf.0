Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986803;
	b=DKZJbCTLQIP0rDMCCU3iIbH0grpXMlB1uC950FW398yBdZhLQHMpxosocW8CNbylnJ0C
	 Rj8QfEGZGlI7t7zeKHgNtLvlE9UismxSJibmZia1Tx4PGNpacmB68OmyV8xp0LpBJY5Ar
	 KG3zhpff3U+Yw6j/VUBjgF0dWSdxHRfQEIPIbZcGNO8F3NkEKF0oWsY7zPnLrD5hU4yNS
	 o8O776HBlYctxrlTLpN9PWvbwv6t4EUriPJ9bCY2nNW6fk8W5VGjz2c/YnYx0IFuNTFj7
	 Z2Izc2OvZ55F3ZyrpznB75QP+R0A6Foa3sN32a2wfOlHEqCxmjbkCdR31rbTBOzkKiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986803;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=BmgtSFwZ88zLivY6TbE/0McFrSb2rkQ+P7wTZ7ogeMk=;
	b=E74KPIEV1l9/J0zD6KPSzufO6MxjuPbveiDVKTJGCUZR+Vi3WaypIWsPfowpRfIHT+ei
	 aUQEvEKWVyhfHWW4NWtwbWXA8hwRZvG2+wLs/bV0JEVHQXRzDrh/oFzED/Sog7/sXIn5S
	 FljauFzbXVf7aMS1Vi9JpDsT0VnonkWfCyQ3aPf408XFtFC5O0Lt3a3DURfy9mpD7jQEq
	 T8IFYEgYCZcapXrSFfkortBIOJmhPGO8nTy/p5eqQX18chLbdDN119dPoyw87Q/SXd1lG
	 ogLJaMIe6c7X5SqOZCd4z3QswGaUQmCn9ILLBKRu329LPT33iH8+znOEGp7z001pILA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCIoSWmK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B89606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCIoSWmK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C411F01825;
	Mon, 26 Oct 2026 03:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986802;
	bh=BmgtSFwZ88zLivY6TbE/0McFrSb2rkQ+P7wTZ7ogeMk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NCIoSWmKUAdgmznTGEynDQxLq5KvAQ0K1pfuTdeLvNluX63ANitR2an8IY3JgHZb6
	 hyBtq2UP0z4OVxT4MYjTABTpATdk2uHmRsWlaKd7kjd/je6a5n94lwwwAFMmAL9qoQ
	 1iCcLNuoJFOWEIyvABl4k6LMRFZziDQe8T1iF0qZgjE0d12zAQPlx8pU0WtcOyzi+1
	 /m9uCtXiveu/OzCWT5U9tnQ0mnX6hrtzy6XV5xSqltbapiDlJCo/8Zwr8KlHy5/Pv9
	 v85ZKwVLgAEwEckCJIvr9i/Wzk6X1KGMhc6Q7zwZQYj2gVaiWiAFViHc+8a2a+E6Ku
	 g4mz9NoVCFP2A==
Content-Type: multipart/mixed; boundary="===============5699443303493392689=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <abd26bab64571a7f77d3120b006a2254d94f8941e5e27d2d6ed92f6ad9da5ced@mail.kernel.org>
In-Reply-To: <20261026025943.404450-57-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-57-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 56/81] bpf: Bump MAX_CALL_FRAMES to 32
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:22 +0000 (UTC)

--===============5699443303493392689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Bump MAX_CALL_FRAMES to 32

TL;DR:
- Possible kernel stack overflow at program load: liveness analyze_subprog()
  recursion now reaches 32 levels (estimates, unmeasured)
- Stale packed-layout comments (nit)

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c0227e74899b..6139e889c86a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -458,7 +458,7 @@ struct bpf_func_state {
>  	struct loop_stack_entry *loop_stack;
>  };
>  
> -#define MAX_CALL_FRAMES 16
> +#define MAX_CALL_FRAMES 32
>  
>  /* instruction history flags, used in bpf_jmp_history_entry.flags field.
>   * Frame number and SPI are stored in dedicated fields of bpf_jmp_history_entry.

Can this bump overflow the kernel stack while the program is being loaded?

analyze_subprog() in kernel/bpf/liveness.c calls itself once for each static
callee (or callback) that receives a frame-pointer-derived argument.  Its
only depth limit is:

    if (depth == MAX_CALL_FRAMES - 1)
            return -EINVAL;

so the deepest recursion now goes from 16 to 32 nested calls.  Each level
holds this array, whose address is passed to the recursive call:

    struct arg_track callee_args[MAX_AT_TRACK_REGS] = {};

MAX_AT_TRACK_REGS is MAX_BPF_REG + MAX_STACK_ARG_SLOTS = 11 + (24 - 5) = 30.
With the u32 mask change in this patch, sizeof(struct arg_track) grows from
10 to 12 bytes (4-byte alignment plus 2 bytes of tail padding), so
callee_args is 360 bytes per level.  32 levels need 11,520 bytes for this
array alone, compared to 16 * 300 = 4,800 bytes before the patch.

That lower bound does not count saved registers, return addresses, the
64-byte acc bitmap in merge_may_write() (static with one caller, so probably
inlined), the bpf() syscall path above bpf_compute_subprog_arg_access()
(which has its own u32 callsites[MAX_CALL_FRAMES], 128 bytes), or the frame
of compute_subprog_args() at the deepest level.  That frame holds
at_out[MAX_AT_TRACK_REGS] plus at_stack_arg_entry[MAX_STACK_ARG_SLOTS], 588
bytes, and its kvmalloc() calls can enter reclaim.

On 32-bit configs with 8KB kernel stacks (arm and x86_32 without KASAN),
11.5KB is larger than THREAD_SIZE.  On x86-64 and arm64 with 16KB stacks, at
roughly 450-500 bytes per level this comes to about 14-16KB before reaching
the leaf, which leaves little or no headroom.  These per-frame numbers are
estimates, not measurements.

The call path is:

bpf_check()
  bpf_compute_live_registers()
    bpf_compute_subprog_arg_access()
      analyze_subprog()   <- recurses up to 32 levels

This runs before do_check_main() and check_max_stack_depth(), and
sort_subprogs_topo() only rejects recursion, so nothing earlier limits call
depth.  A chain of 32 static subprogs that each forward a stack pointer
(for example r1 = r10 - 8 passed down), loaded by a CAP_BPF loader or a BPF
token holder, reaches 32 levels.  That is the Rust use case named in the
commit message.  It also happens on configs that reject the program later,
such as the interpreter, where the 32-byte minimum frame limits
check_max_stack_depth() to 16 frames.

The result would be a kernel stack overflow during program load (a guard
page oops/panic with CONFIG_VMAP_STACK, silent corruption without it).  The
verifier otherwise avoids recursion (see the "non-recursive
depth-first-search" comment in bpf_check_cfg()), and the commit message
does not mention verifier stack use.

The selftest added later in the series (08f1453d610f) passes only skb
through its 32-frame chain, so has_fp_args() is false and this path is not
exercised.  analyze_subprog() is unchanged up to 51224d16c11b, and no later
commit in that range addresses this.

Should the walk be made iterative with a heap-allocated stack, should
callee_args move off the kernel stack (for example as per-depth scratch in
env), or should the liveness recursion limit be kept independent of
MAX_CALL_FRAMES?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 50e24237a6b7..e55ba1db2e1f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3654,8 +3654,8 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
>  }
>  
>  /* Layout of one packed linked register in the jump history, see linked_regs_pack() */
> -#define LR_FRAMENO_BITS	4
> -#define LR_INDEX_BITS	11
> +#define LR_FRAMENO_BITS	5
> +#define LR_INDEX_BITS	10
>  #define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
>  #define LR_IS_REG	BIT(LR_FRAMENO_BITS)
>  #define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)

This isn't a bug, but the comments describing this packed layout still show
the old widths.  The comment above linked_regs_pack() says:

 * Pack linked registers for a jump history entry, one u16 each:
 * - 4 bits frameno
 * - 1 bit  is_reg
 * - 11 bits register or stack slot index

and the linked_regs comment in struct bpf_jmp_history_entry in
include/linux/bpf_verifier.h says:

    Each is packed as 4 bits of frame number, one bit telling a register
    from a stack slot and 11 bits of register or slot index, see
    linked_regs_pack().

Should both be updated to 5 bits of frame number and 10 bits of index to
match LR_FRAMENO_BITS and LR_INDEX_BITS, and the commit message's own "the
index of a register or a stack slot loses one bit"?

There is no functional impact, since bpf_push_jmp_history() returns 0 before
it records anything in this tree.  Both comments are deleted later in the
series by 1dc2b8088ff9 ("bpf: Remove precision tracking"), so this only
matters if this patch is taken without that one.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============5699443303493392689==--
