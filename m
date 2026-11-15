Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794740435;
	b=huHwJoohT81CqGWCdMohggLEH49gWF82h/UPJBth2GsBN3GO9Lg9VkskNchaG9eYKGDI
	 qjQULmp5puWO/jNNEetyaBeo6PWnn98fxiLuloNx1HTExu7Nm+KiNcgDPx4sIgxvvEn7X
	 jH6xz5FjizL/SVq0+GVjhkTpw82Bk7scuQiMs9ZqJevdzuFf7brlZ5HQNPrGCNs/fYqdk
	 XeigEkUaLbFFrxD58ICt6mC3WuTEdhHHHNQXaW9Pn/tbtDlr46fpRTX0tN/U3cA9pFCip
	 6VghvKzcvCnptr13LyH23Q4gi1dzBBRQIPCoWY6ALQLVCyeK2JkXQB50mKHhbKANxgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740435;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nSw/c279jOIfupflk9IEBe6c2JhepI9AKelZ1eMdb/k=;
	b=o6fcNw00Y71pO4roXhpN6d24k7isM3n5AFTVdZ498+3kkcX2eE7T0cdn/pO2x6dey79w
	 qGcK7HD6LoRd547s6+QTrItmjhaMVxTCf9Rm6TJTzm+0HbtEQCxpnQU7jomefFj/q3ORk
	 pxhwWn00GdLiwyxq+voWbkMJHuPfm4TSh4HN8KflfEUQNvdL/C+bI5b/mOu1LbRLhunMD
	 lxLoi7/EOuE8HSku7umr1hLn8I2QqpG9v0rw3/VmLNglAnhw88ubY26Eao6/J7gocKw9A
	 TmNqa8Ajq1MeU4E9HO2D+lwQMLPILPbzEXie30VwGx+lLFoV01X7I6Oo5NH8Rve+Q9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fylNnq4o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76C606A31E;
	Sun, 15 Nov 2026 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fylNnq4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6881F000C4;
	Sun, 15 Nov 2026 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794740435;
	bh=nSw/c279jOIfupflk9IEBe6c2JhepI9AKelZ1eMdb/k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fylNnq4o8c75uIdq+onoCAaeOAIoUSYPOd1AMXfA9NGGuptGbGKZUQWfUGGBqbhOe
	 9IBZfxu8e6n7WXx5scIKWNsabnJGHKB4fjN4BhibYVkrzthpRGK3n7lpUIOvLP/RB4
	 3Cl0nSaQJDgyGazAejAJOx5qxF9kGfYQYEW8cCXDkr06b0DK75DR0h7JsNy9Na42H1
	 T/+TAyMOULdEdf7QjbAWi5mgr4CbfwI0FtqiwrvRn+ioiy6xMRURO6il7Um1yfsPSQ
	 IGxWKcUbvk8hKetJ0fXAuDjQACNh8U7Mk0azEm/aT7oMaKOBev4ES7IWJ4UPTd1we5
	 cT8r3mLEAgA+g==
Content-Type: multipart/mixed; boundary="===============3766954732386504907=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a0ed645f06e4b9a94870a12f30260d7f9f54761895bff67599ecfe0e26a23138@mail.kernel.org>
In-Reply-To: <20261115102559.465375-2-chenyuan@kylinos.cn>
References: <20261115102559.465375-2-chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Use a 32-bit compare in the array map gen_lookups
From: bot+bpf-ci@kernel.org
To: chenyuan@kylinos.cn,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,martin.lau@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 15 Nov 2026 11:00:33 +0000 (UTC)

--===============3766954732386504907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use a 32-bit compare in the array map gen_lookups

TL;DR:
- BPF_JMP32 may break sparc64 JIT of array and array-of-map lookups, falling
  back to interpreter or failing to load
- Commit message: incomplete bypass_spec_v1 condition and likely wrong Fixes:
  tag

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -230,10 +230,10 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
>  	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
>  	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
>  	if (!map->bypass_spec_v1) {
> -		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
> +		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 4);
>  		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
>  	} else {
> -		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
> +		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 3);
>  	}

Can this break JIT compilation on sparc64?  The inlined lookups for plain
array maps and array-of-maps now always emit a BPF_JMP32 | BPF_JGE | BPF_K
instruction, but arch/sparc/net/bpf_jit_comp_64.c has no BPF_JMP32 handling
at all.  build_insn() only has the BPF_JMP | BPF_JGE | BPF_K cases, so the
new opcode reaches:

    default:
        pr_err_once("unknown opcode %02x\n", code);
        return -EINVAL;

and bpf_int_jit_compile() returns the program un-JITed.

bpf_do_misc_fixups() inlines map_gen_lookup whenever
prog->jit_requested && BITS_PER_LONG == 64, which sparc64 satisfies with
net.core.bpf_jit_enable=1.  The old 64-bit BPF_JMP_IMM(BPF_JGE, ...) was
JITed fine there.

So every sparc64 program calling bpf_map_lookup_elem() on an array map or
array-of-maps loses its JIT, even programs with no JMP32 of their own.  In
__bpf_prog_select_runtime():

    if (!fp->jited && jit_needed) {
        *err = -ENOTSUPP;

With CONFIG_BPF_JIT_ALWAYS_ON=y these programs would then fail to load with
-ENOTSUPP, and otherwise they silently fall back to the interpreter.

There is no JIT capability gate for JMP32 here.  Could the compare avoid
JMP32, for example by loading the bound into a scratch register with a
zero-extending BPF_MOV32_IMM and using a 64-bit BPF_JMP_REG(BPF_JGE, ...)?
R1-R5 are dead after the replaced helper call.  Alternatively, should JMP32
support be added to the sparc64 JIT first?

percpu_array_map_gen_lookup() is not affected, since sparc64 returns false
from bpf_jit_supports_percpu_insn() and takes the -EOPNOTSUPP fallback.

commit 3777fda5a1d0e595d3e7d05daddd4eaed5926bc9
Author: Yuan Chen <chenyuan@kylinos.cn>

>     bpf: Use a 32-bit compare in the array map gen_lookups
>
>     array_map_gen_lookup(), percpu_array_map_gen_lookup() and
>     array_of_map_gen_lookup() bound the inlined index with
>     BPF_JMP_IMM(BPF_JGE, idx, max_entries, ...).  The index is a
>     zero-extended u32, but the immediate of a 64-bit JGE is sign-extended,
>     so for max_entries >= 0x80000000 the compare is never true.
>
>     With bypass_spec_v1, an out-of-range key can therefore produce
>     an address beyond the end of the array:
>     array->value + index * elem_size.
>     Without bypass_spec_v1 the index_mask AND keeps the access in bounds,
>     but such a key returns a masked element instead of NULL.
>
>     Creating such a map needs at least a 16 GiB allocation (max_entries
>     0x80000000, elem_size 8); the out-of-bounds path also needs a
>     CAP_PERFMON creator or mitigations=off.
>
>     Use BPF_JMP32_IMM() for the three compares, as commit 70504de0bb62
>     ("xsk: Use a 32-bit compare in xsk_map_gen_lookup") did for
>     xsk_map_gen_lookup().
>
>     Fixes: b2157399cc98 ("bpf: prevent out-of-bounds speculation")
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

The commit message says the out-of-bounds path "also needs a CAP_PERFMON
creator or mitigations=off".  Is that complete?

map->bypass_spec_v1 comes from bpf_bypass_spec_v1(NULL) in
array_map_alloc(), which is:

    return bpf_jit_bypass_spec_v1() ||
           cpu_mitigations_off() ||
           bpf_token_capable(token, CAP_PERFMON);

On LoongArch, bpf_jit_bypass_spec_v1() unconditionally returns true.  On
powerpc64 it returns true unless both SEC_FTR_FAVOUR_SECURITY and
SEC_FTR_BNDS_CHK_SPEC_BAR are set, and always on configs that are neither
E500 nor BOOK3S_64.

On those systems every array map, including one created by an unprivileged
user, takes the bypass branch, so neither CAP_PERFMON nor mitigations=off
is needed.  Could this say "or when bpf_bypass_spec_v1() is true" instead?

Also, the Fixes: tag points at b2157399cc98 ("bpf: prevent out-of-bounds
speculation"), but that commit only added the unpriv/index_mask variants of
the sequences; the 64-bit BPF_JMP_IMM(BPF_JGE, idx, max_entries) compare
already existed.  The sign-extended compare was introduced by:

  Fixes: 81ed18ab3098 ("bpf: add helper inlining infra and optimize map_array lookup")

for array_map_gen_lookup(), with the percpu and array-of-map variants coming
from db69718b8efa ("bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY
maps") and 7b0c2a0508b9 ("bpf: inline map in map lookup functions for array
and htab").  Should the Fixes: tag be updated?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43705303096
--===============3766954732386504907==--
