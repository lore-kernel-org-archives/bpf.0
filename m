Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D82E7F3A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881735; cv=none; b=hHcC64E0sAqUX3swWv4ghg16okKSSIBc5GGuyNmeTKnBlZoMI6nsbQN9NBxK+ZgDDDL4xKv86ymB2bOt1kQy1f/qoJ6lUXOU65Ho7mQF5/5oE0QtQ5bJHsV0ca/GBry8VdO0jX0CvOm3NVDKVyDvwulARDqlPa/NRC6h7Y+Wsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881735; c=relaxed/simple;
	bh=nUlWW8ZTO/lyAeALqHUgw0YuC67ptIyg9dbxd1WDMBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJYn20ENy4q1yWutEP/MTFAjIAXMATUICYOppM6mQKfIv5Bc7+7num+reQbhWnIlBBmYHGXvdd7Qw2XJEmzoInn0FPRWog2F9OdZYgdKzAJLK5pJetaJnwq/KYOZ0TDf4nc8spTdkRV5uY7/6OhGGmOVsHr3xFnkwAX7gD+6Tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRomtF9U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRomtF9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B04C4CEF7;
	Mon, 30 Mar 2026 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881735;
	bh=nUlWW8ZTO/lyAeALqHUgw0YuC67ptIyg9dbxd1WDMBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eRomtF9Uv+KlbkwykHEoj9iPRT6IHnLYQIbRb4okJDQF4iY/kFHAFvWd60bm0IKem
	 b2D9gUvFtIL7vGIR7BOxh4sVMrzjlxnTrDnJp85TH9MuWpTThsFxVkuCFpBq6YW0SJ
	 rgf0GzONPbmaxbE5ElMfxvwSmLJAss9VqRO3mG6gekRIBLr2UXhGw9VErVPMdY5PHc
	 W1IWDN3g2F0okaEwwNTksBW5b7QPhY6kN3o0DUbgdrUWAv8KtdJBWs/Re3tckx6iJV
	 UDQe+f4OkaZ7lJzetO8aOz2QBQdDr0ysOCQcdtkvCVTxp5PgX5kYgix6NcUi/pE9Fi
	 gpuZMhNBTIUnA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, eddyz87@gmail.com
Cc: ast@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add more precision tracking
 tests for atomics
In-Reply-To: <20260330132750.377862-2-daniel@iogearbox.net>
References: <20260330132750.377862-1-daniel@iogearbox.net>
 <20260330132750.377862-2-daniel@iogearbox.net>
Date: Mon, 30 Mar 2026 15:42:11 +0100
Message-ID: <m2ldf9z8e4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> Add verifier precision tracking tests for BPF atomic fetch operations.
> Validate that backtrack_insn correctly propagates precision from the
> fetch dst_reg to the stack slot for atomic64_{fetch_add,xchg,cmpxchg}.
>
>   # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_precision
>   [...]
>   + /etc/rcS.d/S50-startup
>   ./test_progs -t verifier_precision
>   [    1.697105] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.700220] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   [    1.777043] tsc: Refined TSC clocksource calibration: 3407.986 MHz
>   [    1.777619] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc6d7268, max_idle_ns: 440795260133 ns
>   [    1.778658] clocksource: Switched to clocksource tsc
>   #623/1   verifier_precision/bpf_neg:OK
>   #623/2   verifier_precision/bpf_end_to_le:OK
>   #623/3   verifier_precision/bpf_end_to_be:OK
>   #623/4   verifier_precision/bpf_end_bswap:OK
>   #623/5   verifier_precision/bpf_load_acquire:OK
>   #623/6   verifier_precision/bpf_store_release:OK
>   #623/7   verifier_precision/state_loop_first_last_equal:OK
>   #623/8   verifier_precision/bpf_cond_op_r10:OK
>   #623/9   verifier_precision/bpf_cond_op_not_r10:OK
>   #623/10  verifier_precision/bpf_atomic_fetch_add_precision:OK
>   #623/11  verifier_precision/bpf_atomic_xchg_precision:OK
>   #623/12  verifier_precision/bpf_atomic_cmpxchg_precision:OK
>   #623/13  verifier_precision/bpf_atomic_fetch_add_dual_precision:OK
>   #623/14  verifier_precision/bpf_atomic_cmpxchg_dual_precision:OK
>   #623/15  verifier_precision/bpf_atomic_fetch_add_map_precision:OK
>   #623/16  verifier_precision/bpf_atomic_cmpxchg_map_precision:OK
>   #623/17  verifier_precision/bpf_neg_2:OK
>   #623/18  verifier_precision/bpf_neg_3:OK
>   #623/19  verifier_precision/bpf_neg_4:OK
>   #623/20  verifier_precision/bpf_neg_5:OK
>   #623     verifier_precision:OK
>   Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  .../selftests/bpf/progs/verifier_precision.c  | 207 ++++++++++++++++++
>  1 file changed, 207 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
> index 1fe090cd6744..6dbd4feda337 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -5,6 +5,13 @@
>  #include "../../../include/linux/filter.h"
>  #include "bpf_misc.h"
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} precision_map SEC(".maps");
> +
>  SEC("?raw_tp")
>  __success __log_level(2)
>  __msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
> @@ -301,4 +308,204 @@ __naked int bpf_neg_5(void)
>  	::: __clobber_all);
>  }
>  
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
> +__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
> +__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
> +__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
> +__naked int bpf_atomic_fetch_add_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 8;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r2 = 0;"
> +	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
> +	"r3 = r10;"
> +	"r3 += r2;"			/* mark_precise */
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_insn(fetch_add_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
> +	: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
> +__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2)")
> +__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
> +__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
> +__naked int bpf_atomic_xchg_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 8;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r2 = 0;"
> +	".8byte %[xchg_insn];"		/* r2 = atomic_xchg(*(u64 *)(r10 - 8), r2) */
> +	"r3 = r10;"
> +	"r3 += r2;"			/* mark_precise */
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_insn(xchg_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_2, -8))
> +	: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r3 = r10")
> +__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
> +__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
> +__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
> +__naked int bpf_atomic_cmpxchg_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 8;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r0 = 0;"
> +	"r2 = 0;"
> +	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
> +	"r3 = r10;"
> +	"r3 += r0;"			/* mark_precise */
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_insn(cmpxchg_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8))
> +	: __clobber_all);
> +}
> +
> +/* Regression test for dual precision: Both the fetched value (r2) and
> + * a reread of the same stack slot (r3) are tracked for precision. After
> + * the atomic operation, the stack slot is STACK_MISC. Thus, the ldx at
> + * insn 4 does NOT set INSN_F_STACK_ACCESS. Precision for the stack slot
> + * propagates solely through the atomic fetch's load side (insn 3).
> + */
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r2,r3 stack= before 4: (79) r3 = *(u64 *)(r10 -8)")
> +__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
> +__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
> +__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
> +__naked int bpf_atomic_fetch_add_dual_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 8;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r2 = 0;"
> +	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
> +	"r3 = *(u64 *)(r10 - 8);"
> +	"r4 = r2;"
> +	"r4 += r3;"
> +	"r4 &= 7;"
> +	"r5 = r10;"
> +	"r5 += r4;"			/* mark_precise */
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_insn(fetch_add_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
> +	: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r0,r3 stack= before 5: (79) r3 = *(u64 *)(r10 -8)")
> +__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
> +__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
> +__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 8")
> +__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
> +__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
> +__naked int bpf_atomic_cmpxchg_dual_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 8;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r0 = 8;"
> +	"r2 = 0;"
> +	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
> +	"r3 = *(u64 *)(r10 - 8);"
> +	"r4 = r0;"
> +	"r4 += r3;"
> +	"r4 &= 7;"
> +	"r5 = r10;"
> +	"r5 += r4;"			/* mark_precise */
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_insn(cmpxchg_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8))
> +	: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
> +__msg("mark_precise: frame0: regs=r1 stack= before 9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
> +__not_msg("falling back to forcing all scalars precise")
> +__naked int bpf_atomic_fetch_add_map_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 0;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r2 = r10;"
> +	"r2 += -8;"
> +	"r1 = %[precision_map] ll;"
> +	"call %[bpf_map_lookup_elem];"
> +	"if r0 == 0 goto 1f;"
> +	"r1 = 0;"
> +	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u64 *)(r0 + 0), r1) */
> +	"r1 &= 7;"
> +	"r2 = r10;"
> +	"r2 += r1;"			/* mark_precise */
> +	"1: r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_addr(precision_map),
> +	  __imm(bpf_map_lookup_elem),
> +	  __imm_insn(fetch_add_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0))
> +	: __clobber_all);
> +}
> +
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
> +__msg("mark_precise: frame0: regs=r0 stack= before 11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1)")
> +__not_msg("falling back to forcing all scalars precise")
> +__naked int bpf_atomic_cmpxchg_map_precision(void)
> +{
> +	asm volatile (
> +	"r1 = 0;"
> +	"*(u64 *)(r10 - 8) = r1;"
> +	"r2 = r10;"
> +	"r2 += -8;"
> +	"r1 = %[precision_map] ll;"
> +	"call %[bpf_map_lookup_elem];"
> +	"if r0 == 0 goto 1f;"
> +	"r6 = r0;"
> +	"r0 = 0;"
> +	"r1 = 0;"
> +	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r6 + 0), r0, r1) */
> +	"r0 &= 7;"
> +	"r2 = r10;"
> +	"r2 += r0;"			/* mark_precise */
> +	"1: r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm_addr(precision_map),
> +	  __imm(bpf_map_lookup_elem),
> +	  __imm_insn(cmpxchg_insn,
> +		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_6, BPF_REG_1, 0))
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
