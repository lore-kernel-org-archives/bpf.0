Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC43CA4B6
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939011; cv=none; b=typ6r+h5vwKeo9Pv/eeu/8bi57lIkuChC6OFxnBC/pTUV6exsIsom682EWmQLX+X70pfL4pdP5ln0Dm+qRz/v55tyJBAsJfbsBzg7c8TxZoLB3FJpG2JWRlzufju/gZAkTC6fPmI0+2BwQK1SaH750/v8ObWBELhZl8+4TEYIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939011; c=relaxed/simple;
	bh=5Y4WBOyq6I/Qela99udNax7LXhHmFsjv57v9RvXO5TM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=s3+6xV8okfrzXO31py5u4hmHOK+2nJiyPHQbyZYHoI3iK7FyjcTc1mMPnPW2WHfKDjmV6srFNV5QTKAurURAubJZGufcRIky43xlAqBJCWArQhQZP6+UlFIKU7TK95Z0x9q4NjHGCJKiZHg8Y/ZVvotoqbpuHAp2RllkU4WP27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCghAZ43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCghAZ43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD201F00A3F;
	Wed,  9 Sep 2026 07:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939002;
	bh=kIEyPfMIYMgiBDR1Jiy9v7zIKOghJuiJzr9TveM7D+A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UCghAZ43K+iNfmvx6p7JOKr+ZKRkUcLsgss3UBYcY8RfnaPslnlBJachT9xN1PovE
	 Ds5+wLDTzBDlDa7oRi2Ib8BQ+Z1wfLxtOaecfoK5F9XAXpotrRfqIDuQAXAG84uVBm
	 MK2g2JXxlEj7dwBgFHsL21li9YVPP1aQ2VLlZauydniia0hwUQf5Zl0YV+TfG2wG1E
	 NkQsq16Z9igR4etrTMshMLjYmvSaIUijpYPBJyJdXPD89cB6jLCVnkD4leVK+8xltc
	 AhU5zF46EqgmOSplgceWMWhRba64tpCrBOa+D3G5lEZEYQD3LvQRqHqp7cTMLoQ4Wf
	 G0ncSJ3jFSoog==
Content-Type: multipart/mixed; boundary="===============7952128138821316242=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08f0a36fb18cbbd2a82a3666f443a96518054f785e8bccc0c18e476f00ec63a6@mail.kernel.org>
In-Reply-To: <20260909062626.4009860-1-yonghong.song@linux.dev>
References: <20260909062626.4009860-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 12/12] selftests/bpf: Add tests for by-value kfunc arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 07:30:00 +0000 (UTC)

--===============7952128138821316242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add kfuncs taking a 16-byte struct and an __int128 by value, with
> combinations of <= 8 byte arguments and '> 8 && <= 16' byte arguments,
> and tests that call them. Each checks the value the kfunc returns, so a
> misplaced argument shows up rather than passing quietly.
>
> Between them the cases cover an argument the two conventions place
> alike, one arm64 moves between registers, one an ABI moves to or from
> the stack, and one both ABIs pad the stack for. All of them run on both
> arches; what differs is how many instructions the JIT emits to get
> there. Two more cover the rejections that hold everywhere, an aggregate
> holding a pointer and one too large to pass by value.

The changelog describes two new rejection ('__failure') cases, but only
one of the two is added by this commit, and a third rejection case that
IS added is never mentioned.

Looking at the added tests:

1. 'an aggregate holding a pointer' -> present:

progs/aggregate_arg_kfunc.c adds:
    SEC("tc") __arch_x86_64 __arch_arm64
    __failure __msg("R1 type STRUCT is not composed of scalars")
    int aggregate_arg_kfunc_ptr_member(struct __sk_buff *skb)

2. 'one too large to pass by value' -> NOT added here:

progs/aggregate_arg_kfunc.c contains exactly one __failure program (the
ptr_member one above), and the commit declares no kfunc taking a by-value
aggregate larger than 16 bytes in test_kmods/bpf_testmod_kfunc.h, so such
a case cannot exist in this commit.

The only test matching that description is aggregate_arg_too_big_fail()
in progs/aggregate_arg_func.c with:
    __failure __msg("... has size 24, only 1 to 16 bytes can be passed by value")

which was added by the earlier commit b3f328dbfb8a ("selftests/bpf: Add
inline-asm tests for by-value arguments") and is untouched here.

3. This commit adds a rejection case the changelog never mentions:

progs/arena_kfunc.c gains 16 lines adding:
    /* The struct takes two slots, so the arena pointer is the sixth. */
    SEC("syscall") __arch_x86_64 __arch_arm64
    __failure __msg("arena pointer cannot be a stack argument")
    int arena_arg_stack_after_pair(void *ctx)

together with the new bpf_kfunc_call_test_pair_arena_arg() kfunc and its
__ksym declaration. arena_kfunc.c is one of the six files in the diffstat
but is not described anywhere in the message.

Could the message be updated to say that one new rejection case is added
for an aggregate holding a pointer (with the too-large rejection being
already covered by aggregate_arg_func.c), and add a sentence for the
arena stack-argument rejection in arena_kfunc.c?

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
> new file mode 100644
> index 000000000000..c8a088e2f5e3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c

[ ... ]

> +/*
> + * One argument further and the hole pushes the last one off x7 and onto the
> + * arm64 stack, which the JIT does not shift into. The x86-64 ABI packs the
> + * eightbytes, so its last two are on the stack where BPF put them.
> + */

Does the comment accurately reflect what the arm64 JIT does? Looking at
bpf_jit_place_args() with arm64_arg_abi:

For bpf_kfunc_call_test_i128_arg_ovf(u64 a, __int128 v, u64 b, u64 c, u64 d,
u64 e, u64 f), the arm64 calling convention computes:
  slot0(a)->pos0, slot1/2(v)->pos2/3, slot3(b)->4, slot4(c)->5,
  slot5(d)->6, slot6(e)->7, slot7(f)->pos8

Position 8 is the first arm64 stack slot (a64_arg_on_stack(8) is true),
so bpf_jit_plan_arg_moves() emits the move {dst=8, src=7}.

arch/arm64/net/bpf_jit_comp.c:emit_kfunc_arg_moves() handles this with:

    if (a64_arg_on_stack(dst))
            emit(A64_STR64I(reg, A64_SP, a64_arg_stack_off(dst)), ctx);

The space is reserved by kfunc_abi_slots() returning 9 for this kfunc,
giving out_stack_arg_cnt = 4, nr_on_stack = 1, and ctx->stack_arg_size
becomes 16 bytes.

This test is annotated '__success __retval(0)', which depends on the JIT
correctly placing argument f into the arm64 stack. Does the comment need
updating to reflect that the JIT does shift into the arm64 stack?

> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
> index 1cd3eee07802..80b8cbf15cdb 100644
> --- a/tools/testing/selftests/bpf/progs/stack_arg_fail.c
> +++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c

[ ... ]

> @@ -3,20 +3,10 @@
>
>  #include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
> -#include "../test_kmods/bpf_testmod_kfunc.h"
>  #include "bpf_misc.h"
>
>  #if defined(__BPF_FEATURE_STACK_ARGUMENT)
>
> -SEC("socket")
> -__failure __msg("Unrecognized *(R11-8) type STRUCT")
> -int test_stack_arg_big(struct __sk_buff *ctx)
> -{
> -	struct prog_test_big_arg s = {1, 2};
> -
> -	return bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s);
> -}
> -

The changelog says "the test is removed and the same call is covered by
the cases above." That holds only on x86_64 and arm64.

The replacement, aggregate_arg_kfunc_straddle() in
progs/aggregate_arg_kfunc.c:97-107, makes the byte-identical call
bpf_kfunc_call_stack_arg_big(1, 2, 3, 4, 5, s) and correctly checks the
return value, but it is tagged:

  SEC("tc")
  __arch_x86_64 __arch_arm64
  __load_if_JITed()
  __success __retval(0)

test_loader.c:1339 skips a test whose arch_mask excludes the host arch.
The deleted test was gated only on __BPF_FEATURE_STACK_ARGUMENT and ran
everywhere.

On riscv64, s390x and loongarch this call is no longer exercised at all.
Only x86 and arm64 define bpf_jit_arg_abi(); elsewhere
gen_kfunc_arg_proto() takes the '!abi && nslots > 1' branch at
verifier.c:12428 and rejects the argument with:

  "Function %s arg#%d type %s cannot be passed at argument slot %d on this architecture"

That message is new in this series and has no selftest coverage.

So on the non-ABI architectures the series swapped one rejection message
for another and this commit removed the only test that exercised the call
there. Should a __failure __msg("cannot be passed at argument slot") case
be added to restore coverage on those architectures?

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 1ae88a12d0c4..1d71ba0bc6ad 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> +__bpf_kfunc u64 bpf_kfunc_call_test_pair_arg(u64 a, struct prog_test_pair_arg s, u64 b)
> +{
> +	return a + s.lo + s.hi + b;
> +}
> +
> +__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a, u64 b, __int128 v)
> +{
> +	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
> +}
> +
> +__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd(u64 a, __int128 v, u64 b)
> +{
> +	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
> +}

[ ... ]

> +__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_shift(u64 a, __int128 v, u64 b, u64 c, u64 d)
> +{
> +	return a + b + c + d + (u64)((unsigned __int128)v >> 64) + (u64)v;
> +}
> +
> +__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_ovf(u64 a, __int128 v, u64 b, u64 c, u64 d, u64 e, u64 f)
> +{
> +	return a + b + c + d + e + f + (u64)((unsigned __int128)v >> 64) + (u64)v;
> +}

[ ... ]

> +__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f, u64 g, __int128 v)
> +{
> +	return a + b + c + d + e + f + g + (u64)((unsigned __int128)v >> 64) + (u64)v;
> +}

Three of the new kfuncs place the __int128 after a single-register
scalar: bpf_kfunc_call_test_i128_arg_odd(), i128_arg_shift(), and
i128_arg_ovf(), all of the shape 'u64 a, __int128 v, ...'.

This is exactly the shape a comment already in this same file warns
against. bpf_testmod.c:174-186 says, above bpf_testmod_test_int128_arg():

  /*
   * The __int128 'a' is the first argument on purpose. On arm64 a 16-byte
   * argument must start in an even-numbered register pair, so placing it
   * after a single-register scalar would leave a padding register (x1)
   * unused. pahole maps parameters to registers positionally and would then
   * see the following argument in an "unexpected" register and skip BTF
   * encoding of the whole function, making it unattachable. [...]
   */

On arm64 AAPCS64 rounds NGRN up to an even number for a 16-byte-aligned
type, so for (u64 a, __int128 v, u64 b) the actual placement is a=x0,
x1 padding, v=x2:x3, b=x4, while a positional mapping expects v=x1:x2
and b=x3.

Per the in-file comment that makes pahole drop the BTF FUNC record for
the whole function on arm64. For a kfunc that is worse than for an fentry
target: the name is registered with BTF_ID_FLAGS(), so resolve_btfids
would leave the ID at 0 and emit:

  'WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_i128_arg_odd'

which is fatal when CONFIG_WERROR selects --fatal_warnings. Even when
only a warning, libbpf cannot resolve the ksym against the module BTF,
so aggregate_arg_kfunc_int128_odd, aggregate_arg_kfunc_int128_shift and
aggregate_arg_kfunc_int128_ovf fail to load on arm64 instead of testing
the JIT.

bpf_kfunc_call_test_i128_arg_pad() has the same hazard in the milder
stack-vs-register form (a..g fill x0..x6, then v is pushed to the stack
where x7 would be expected positionally).

The pre-existing bpf_kfunc_call_test_i128() and
bpf_testmod_test_int128_arg() both deliberately keep the __int128 in the
first position, and only bpf_kfunc_call_test_i128_arg() (u64 a, u64 b,
__int128 v) among the new ones happens to land on an even register with
no padding.

Is the placement worth confirming against the pahole version used for CI
before this lands, given it's the one thing in the change that the
in-tree documentation says should not work on arm64?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441
--===============7952128138821316242==--
