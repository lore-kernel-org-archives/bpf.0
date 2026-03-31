Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94063CE490
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995625; cv=none; b=qwTxQ8ua3tyo9VYzcmliNjpKuQfEVL0FKM96NGpnXt9Gv6rGmr+pmlWBUdfgKNXW1FUrllM3gcKubUuQIiaMH+/2vd48UYgHYhvh8bnz0Q5xpMOhPjetV6rgVkWkzqjosKVL+4W0JQEymXHd5OSWz+JDPXTukQ/SAJ90mNdqT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995625; c=relaxed/simple;
	bh=6JksdqbSs7UFsSErMe8QZtSsDJXKn4BEAXrbjJuCCbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZqxRe7i2o1a+fjz56Sj8+HXCLKe3rZ6MNZswsGJaxQ8+4ZJTb2UYypSPh7XO7Jwg3JHEZ7QOCTDkOB75cVCYhtnsXVAZXQh+P269zTm7be86dY4FGOej0pXB+myvtARPCQl/d0LtGx32/5i99j1FPy1Id3jIP8kuFWDBPDy7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jhT49E1C; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jhT49E1C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zXQNmiogbyw1NJuhM0YFjGk4ZyDEp+jwHxeXaTE7WHI=; b=jhT49E1C3rOjBeb0Tfi1DOVUYi
	dBfVn4dDH8MPhNAutdLtl9Fp6TsFBIDhwhlryGQYQd1nnHHl5qxQFuO7MNu9TgFsDwkkdc2qJsbCH
	qe1CyshBETLcitRQgAdlOvJ3RwVra53/hFCVa/RcMNSDnVgggh5RUgEkE+nnmBqDgP5Fnfzfk7O6T
	PK1SN7Xi58SEsrisAo7H5IA8LbH0cZZL9iypyS7YJoqMIxjFKkjXT2/Dr27H8NGaCnZ+p8hBMcZCi
	/E0V98foaQWadLuv9CMGr4Y0ZIOjzkBOJx7HnMlnUefw4Gpo1bNaDqDJo0+x+52NDdh7x8Phl1CTs
	cmHsB5zg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w7hRd-0002dy-1k;
	Wed, 01 Apr 2026 00:20:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: puranjay@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add more precision tracking tests for atomics
Date: Wed,  1 Apr 2026 00:20:20 +0200
Message-ID: <20260331222020.401848-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331222020.401848-1-daniel@iogearbox.net>
References: <20260331222020.401848-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27957/Tue Mar 31 08:24:30 2026)

Add verifier precision tracking tests for BPF atomic fetch operations.
Validate that backtrack_insn correctly propagates precision from the
fetch dst_reg to the stack slot for {fetch_add,xchg,cmpxchg} atomics.
For the first two src_reg gets the old memory value, and for the last
one r0. The fetched register is used for pointer arithmetic to trigger
backtracking. Also add coverage for fetch_{or,and,xor} flavors which
exercises the bitwise atomic fetch variants going through the same
insn->imm & BPF_FETCH check but with different imm values.

Add dual-precision regression tests for fetch_add and cmpxchg where
both the fetched value and a reread of the same stack slot are tracked
for precision. After the atomic operation, the stack slot is STACK_MISC,
so the ldx does not set INSN_F_STACK_ACCESS. These tests verify that
stack precision propagates solely through the atomic fetch's load side.

Add map-based tests for fetch_add and cmpxchg which validate that non-
stack atomic fetch completes precision tracking without falling back
to mark_all_scalars_precise. Lastly, add 32-bit variants for {fetch_add,
cmpxchg} on map values to cover the second valid atomic operand size.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_precision
  [...]
  + /etc/rcS.d/S50-startup
  ./test_progs -t verifier_precision
  [    1.697105] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.700220] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.777043] tsc: Refined TSC clocksource calibration: 3407.986 MHz
  [    1.777619] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc6d7268, max_idle_ns: 440795260133 ns
  [    1.778658] clocksource: Switched to clocksource tsc
  #633/1   verifier_precision/bpf_neg:OK
  #633/2   verifier_precision/bpf_end_to_le:OK
  #633/3   verifier_precision/bpf_end_to_be:OK
  #633/4   verifier_precision/bpf_end_bswap:OK
  #633/5   verifier_precision/bpf_load_acquire:OK
  #633/6   verifier_precision/bpf_store_release:OK
  #633/7   verifier_precision/state_loop_first_last_equal:OK
  #633/8   verifier_precision/bpf_cond_op_r10:OK
  #633/9   verifier_precision/bpf_cond_op_not_r10:OK
  #633/10  verifier_precision/bpf_atomic_fetch_add_precision:OK
  #633/11  verifier_precision/bpf_atomic_xchg_precision:OK
  #633/12  verifier_precision/bpf_atomic_fetch_or_precision:OK
  #633/13  verifier_precision/bpf_atomic_fetch_and_precision:OK
  #633/14  verifier_precision/bpf_atomic_fetch_xor_precision:OK
  #633/15  verifier_precision/bpf_atomic_cmpxchg_precision:OK
  #633/16  verifier_precision/bpf_atomic_fetch_add_dual_precision:OK
  #633/17  verifier_precision/bpf_atomic_cmpxchg_dual_precision:OK
  #633/18  verifier_precision/bpf_atomic_fetch_add_map_precision:OK
  #633/19  verifier_precision/bpf_atomic_cmpxchg_map_precision:OK
  #633/20  verifier_precision/bpf_atomic_fetch_add_32bit_precision:OK
  #633/21  verifier_precision/bpf_atomic_cmpxchg_32bit_precision:OK
  #633/22  verifier_precision/bpf_neg_2:OK
  #633/23  verifier_precision/bpf_neg_3:OK
  #633/24  verifier_precision/bpf_neg_4:OK
  #633/25  verifier_precision/bpf_neg_5:OK
  #633     verifier_precision:OK
  Summary: 1/25 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - Add more coverage

 .../selftests/bpf/progs/verifier_precision.c  | 341 ++++++++++++++++++
 1 file changed, 341 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 1fe090cd6744..4794903aec8e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -5,6 +5,13 @@
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} precision_map SEC(".maps");
+
 SEC("?raw_tp")
 __success __log_level(2)
 __msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
@@ -301,4 +308,338 @@ __naked int bpf_neg_5(void)
 	::: __clobber_all);
 }
 
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_fetch_add_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
+	"r3 = r10;"
+	"r3 += r2;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(fetch_add_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_xchg_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[xchg_insn];"		/* r2 = atomic_xchg(*(u64 *)(r10 - 8), r2) */
+	"r3 = r10;"
+	"r3 += r2;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(xchg_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_or((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_fetch_or_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[fetch_or_insn];"	/* r2 = atomic_fetch_or(*(u64 *)(r10 - 8), r2) */
+	"r3 = r10;"
+	"r3 += r2;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(fetch_or_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_and((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_fetch_and_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[fetch_and_insn];"	/* r2 = atomic_fetch_and(*(u64 *)(r10 - 8), r2) */
+	"r3 = r10;"
+	"r3 += r2;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(fetch_and_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_xor((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_fetch_xor_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[fetch_xor_insn];"	/* r2 = atomic_fetch_xor(*(u64 *)(r10 - 8), r2) */
+	"r3 = r10;"
+	"r3 += r2;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(fetch_xor_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r3 = r10")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_cmpxchg_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 0;"
+	"r2 = 0;"
+	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
+	"r3 = r10;"
+	"r3 += r0;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(cmpxchg_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+/* Regression test for dual precision: Both the fetched value (r2) and
+ * a reread of the same stack slot (r3) are tracked for precision. After
+ * the atomic operation, the stack slot is STACK_MISC. Thus, the ldx at
+ * insn 4 does NOT set INSN_F_STACK_ACCESS. Precision for the stack slot
+ * propagates solely through the atomic fetch's load side (insn 3).
+ */
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r2,r3 stack= before 4: (79) r3 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_fetch_add_dual_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = 0;"
+	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
+	"r3 = *(u64 *)(r10 - 8);"
+	"r4 = r2;"
+	"r4 += r3;"
+	"r4 &= 7;"
+	"r5 = r10;"
+	"r5 += r4;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(fetch_add_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r0,r3 stack= before 5: (79) r3 = *(u64 *)(r10 -8)")
+__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
+__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
+__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 8")
+__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
+__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__naked int bpf_atomic_cmpxchg_dual_precision(void)
+{
+	asm volatile (
+	"r1 = 8;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 8;"
+	"r2 = 0;"
+	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
+	"r3 = *(u64 *)(r10 - 8);"
+	"r4 = r0;"
+	"r4 += r3;"
+	"r4 &= 7;"
+	"r5 = r10;"
+	"r5 += r4;"			/* mark_precise */
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(cmpxchg_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
+__msg("mark_precise: frame0: regs=r1 stack= before 9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
+__not_msg("falling back to forcing all scalars precise")
+__naked int bpf_atomic_fetch_add_map_precision(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[precision_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r1 = 0;"
+	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u64 *)(r0 + 0), r1) */
+	"r1 &= 7;"
+	"r2 = r10;"
+	"r2 += r1;"			/* mark_precise */
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(precision_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(fetch_add_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
+__msg("mark_precise: frame0: regs=r0 stack= before 11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1)")
+__not_msg("falling back to forcing all scalars precise")
+__naked int bpf_atomic_cmpxchg_map_precision(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[precision_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"r1 = 0;"
+	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r6 + 0), r0, r1) */
+	"r0 &= 7;"
+	"r2 = r10;"
+	"r2 += r0;"			/* mark_precise */
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(precision_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cmpxchg_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_6, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
+__msg("mark_precise: frame0: regs=r1 stack= before 9: (c3) r1 = atomic_fetch_add((u32 *)(r0 +0), r1)")
+__not_msg("falling back to forcing all scalars precise")
+__naked int bpf_atomic_fetch_add_32bit_precision(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[precision_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r1 = 0;"
+	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u32 *)(r0 + 0), r1) */
+	"r1 &= 7;"
+	"r2 = r10;"
+	"r2 += r1;"			/* mark_precise */
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(precision_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(fetch_add_insn,
+		     BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_0, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
+__msg("mark_precise: frame0: regs=r0 stack= before 11: (c3) r0 = atomic_cmpxchg((u32 *)(r6 +0), r0, r1)")
+__not_msg("falling back to forcing all scalars precise")
+__naked int bpf_atomic_cmpxchg_32bit_precision(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[precision_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r0;"
+	"r0 = 0;"
+	"r1 = 0;"
+	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u32 *)(r6 + 0), r0, r1) */
+	"r0 &= 7;"
+	"r2 = r10;"
+	"r2 += r0;"			/* mark_precise */
+	"1: r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(precision_map),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cmpxchg_insn,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_6, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

