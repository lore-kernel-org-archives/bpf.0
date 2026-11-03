Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708869;
	b=ddNFwp1MHka1GRFyjYbCJY4erDXtxluTlmp68eSWnXImc15/S9XVifTcwzRCyzLlfx7X
	 XCZdElnt5R8wrGcF8vrVYXF1OXqr6VAMr4lupQeHnsSJxtycq3QG3LI0RHICI8zfZMZXt
	 +R/stDw2aGy4LKbV4UYOTWRhajadtXN9m2MM/Da2c3ZooSWQW7dIWsJuQI22eNzamVfJC
	 AvyK0J/uioMEiAMMc7l2XnrMxndHnHpT3Bxm3hDyItp4AYt43nW9vQSpv2IEUcCFaNYfW
	 qZhbNNRRD0ZCMsZvsk0e94XgsmQfgbkwUSp5lOnU4L4f6V19X9a6Ib8A/dHfh8CayBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708869;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=s+XmBuqkw8zC64mzRmsNm6A7ktg16Q5IV8HxRXn+oeI=;
	b=ST+2clrX/C0iILsLORPvv6GQhRMAumwa+QCxCglbOZVrU+zVGWWld7gKhCKFSgCKOXk+
	 TocCCihvwu5Jy/GJrIdw2KYHRpIaJFIY7jS8LhZoEi500jjpgyrsjYFBI1PcHAR7jbpU6
	 McLnTPivGTtTaiwfHeWJNwfyzjF0XLDKOcM8wHhdwuY8uk9aPFgUQJE2r7nrTiKDRJ3wU
	 zgu+goYYiAa7PUjzESFLpMcx/kGbJ5g3t9NIE2iwRkBKp6F7yA7xjQsqNUO7aLOVVnZ/l
	 aHVUmBxG1qPSjr8EO8HSF91MVtCewZvUDAAfsWDfnyQe7vH6UxVgiPHBC/zuAEbZO8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=IHG1bntg;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33354606D80F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33354606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=IHG1bntg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=s+XmBuqkw8zC64mzRmsNm6A7ktg16Q5IV8HxRXn+oeI=; b=IHG1bntgewmxx8Ixc1VZOCAUsM
	98NUPsOJsLjXknH4vi9S/aj7akdWbVNVWw5uINVcQU8ndihub1gttxUleq8osY/+7J66sel6xU+2n
	FVsAHfHCaJesbdpofTBdJ4ED4bXiCFVMTaJcYVe+hOf6fgMwTPdD8w3ZsSfpjRjgWtnPgEt4vlvuc
	1Ctoa3tt+FAi8DeJWkT7UC7yV6rLgp+EtRhGJ/x3yxrgkdNI3LfP64NdcIsJ2t5YJR1IommWM5nIE
	PvAEQapwFgjqT6064ymjx3mq3jdKXWCyxVGBYwYmEQfYGjLKJRAN9BYEgRMwnH9ITi5nCWkf23UA4
	zJb8h+Eg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc9-000MSp-2Q;
	Tue, 03 Nov 2026 13:27:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 20/20] selftests/bpf: Extend the JIT instruction tests for arm64 encodings
Date: Tue,  3 Nov 2026 13:27:33 +0100
Message-ID: <20261103122733.1383002-21-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

Cover the sequences the arm64 JIT now emits: compares, bit tests,
constant arithmetic, immediates, the sign jumps across the short branch
range, also over a region which a call of a subprogram shrinks in the
extra pass of the JIT, every form of the arena address computation, and
a tail call with the index scaled to the entry and zero extended. The
tests check results, so they run on every JIT, the sign extending loads
and the arena atomics on those that take them, the load-acquire and
store-release of the arena program built with __imm_insn().

The arena atomics are guarded at build time only: On an arm64 CPU without
LSE the kernel refuses them at load, as the ll/sc atomics have no arena
support yet, and their subtests fail rather than skip on purpose, as
that is an open gap of the JIT conformance and not of the hardware.

  # PLATFORM=aarch64 CROSS_COMPILE=aarch64-linux-gnu- ./vmtest.sh -- ./test_progs -t jit_insns
  [...]
  #193/1   jit_insns/arena_zero_off:OK
  #193/2   jit_insns/cast_to_user:OK
  #193/3   jit_insns/arena_offsets:OK
  #193/4   jit_insns/arena_offsets_ldsx:OK
  #193/5   jit_insns/arena_offsets_atomics:OK
  #193/6   jit_insns/arena_acq_rel:OK
  #193/7   jit_insns/alu_imm:OK
  #193/8   jit_insns/alu_reg:OK
  #193/9   jit_insns/alu_imm_regs:OK
  #193/10  jit_insns/div_const:OK
  #193/11  jit_insns/alu_reg_pairs:OK
  #193/12  jit_insns/alu_edges:OK
  #193/13  jit_insns/shifts:OK
  #193/14  jit_insns/shift_counts:OK
  #193/15  jit_insns/atomics:OK
  #193/16  jit_insns/atomic_reg_pairs:OK
  #193/17  jit_insns/xadd_chain:OK
  #193/18  jit_insns/ld_imm64:OK
  #193/19  jit_insns/jmp_imm:OK
  #193/20  jit_insns/jmp_reg:OK
  #193/21  jit_insns/jmp_reg_pairs:OK
  #193/22  jit_insns/jmp_edges:OK
  #193/23  jit_insns/staggered_jumps:OK
  #193/24  jit_insns/max_jmp:OK
  #193/25  jit_insns/sign_jumps:OK
  #193/26  jit_insns/convergence:OK
  #193/27  jit_insns/same_len_not_converged:OK
  #193/28  jit_insns/calls:OK
  #193/29  jit_insns/helper_calls:OK
  #193/30  jit_insns/tail_call:OK
  #193/31  jit_insns/ldst_zero_off:OK
  #193/32  jit_insns/ldst_offsets:OK
  #193/33  jit_insns/acq_rel:OK
  #193/34  jit_insns/atomic_ptr_operand:OK
  #193/35  jit_insns/movsx:OK
  #193/36  jit_insns/jset_imm:OK
  #193/37  jit_insns/cmp_imm:OK
  #193/38  jit_insns/alu_consts:OK
  #193/39  jit_insns/bswap:OK
  #193/40  jit_insns/probe_mem:OK
  #193     jit_insns:OK
  #194/1   jit_insns_blinded/alu_imm:OK
  #194/2   jit_insns_blinded/alu_imm_regs:OK
  #194/3   jit_insns_blinded/alu_edges:OK
  #194/4   jit_insns_blinded/div_const:OK
  #194/5   jit_insns_blinded/shifts:OK
  #194/6   jit_insns_blinded/xadd_chain:OK
  #194/7   jit_insns_blinded/ld_imm64:OK
  #194/8   jit_insns_blinded/jmp_imm:OK
  #194/9   jit_insns_blinded/jmp_edges:OK
  #194/10  jit_insns_blinded/ldst_zero_off:OK
  #194/11  jit_insns_blinded/ldst_offsets:OK
  #194/12  jit_insns_blinded/jset_imm:OK
  #194/13  jit_insns_blinded/cmp_imm:OK
  #194/14  jit_insns_blinded/alu_consts:OK
  #194     jit_insns_blinded:OK
  Summary: 2/54 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/jit_insns.c      | 604 ++++++++++++++++--
 .../selftests/bpf/progs/jit_insns_arena.c     | 446 ++++++++++++-
 2 files changed, 988 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 52bffe27199b..220eeea8a23f 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -592,13 +592,14 @@ static void test_alu_imm_regs(void)
  * of the 32-bit operations carry garbage in the upper 32 bits.
  */
 static const __s32 unsigned_divisors[] = {
-	2, 3, 7, 10, 25, 641, 1000, 4096, 65536, 1000000007, 0x7fffffff,
-	-2, -10, -0x7fffffff - 1, -1, 1,
+	2, 3, 7, 10, 14, 25, 56, 641, 1000, 4096, 65536, 0x40000000, 1000000007,
+	0x7fffffff, -2, -10, -0x7fffffff - 1, -1, 1,
 };
 
 static const __s32 signed_divisors[] = {
-	2, 3, 7, 25, 1000, 0x40000000, 0x7fffffff,
-	-2, -3, -5, -7, -1000, -0x7fffffff, -0x7fffffff - 1, 1, -1,
+	2, 3, 4, 7, 8, 25, 1000, 0x80000, 0x40000000, 0x7fffffff,
+	-2, -3, -4, -5, -7, -8, -1000, -0x40000000, -0x7fffffff, -0x7fffffff - 1,
+	1, -1,
 };
 
 static int dividends(__u32 flags, __s32 imm, __u64 *n)
@@ -1123,7 +1124,8 @@ static void test_ld_imm64(void)
 	static const __u64 imms[] = {
 		0, 1, 0x7fffffff, 0x80000000, 0xffffffff, 0x100000000ULL,
 		0xffffffffffffffffULL, 0xffffffff80000000ULL, 0xffffffff7fffffffULL,
-		0x0123456789abcdefULL,
+		0x0123456789abcdefULL, 0xcccccccccccccccdULL, 0x5a5a12345a5a5a5aULL,
+		0x5a5a00005a5affffULL, 0x00ff00ff00ff00ffULL, 0x1234567812345678ULL,
 	};
 	int block = 64, bit, adj, sign, p, pattern, index, rd, i;
 	struct batch b;
@@ -1471,6 +1473,10 @@ static void test_staggered_jumps(void)
 		  BPF_JMP32_IMM(BPF_JLT, BPF_REG_1, 0x80000000, 0), 1234, 0 },
 		{ "staggered jmp32_jsge_x",
 		  BPF_JMP32_REG(BPF_JSGE, BPF_REG_1, BPF_REG_2, 0), -2, -2 },
+		{ "staggered jmp_jeq_k zero",
+		  BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0), 0, 0 },
+		{ "staggered jmp_jslt_k zero",
+		  BPF_JMP_IMM(BPF_JSLT, BPF_REG_1, 0, 0), -1, 0 },
 	};
 	char desc[64];
 	int i, d;
@@ -1519,7 +1525,7 @@ static const __u64 inputs[] = {
 };
 
 struct prog {
-	struct bpf_insn insns[16];
+	struct bpf_insn insns[32];
 	int cnt;
 };
 
@@ -1572,7 +1578,7 @@ static void test_ldst_zero_off(void)
 	static const int aops[] = {
 		BPF_ADD, BPF_ADD | BPF_FETCH, BPF_OR, BPF_XCHG, BPF_CMPXCHG,
 	};
-	static const __s32 imms[] = { 0x5a, -1 };
+	static const __s32 imms[] = { 0x5a, -1, 0 };
 	struct prog p;
 	char desc[64];
 	int b, k, s, j, fd;
@@ -1649,12 +1655,13 @@ static void test_ldst_zero_off(void)
 				close(fd);
 			}
 
-			/* Store an immediate with a zero offset into a zeroed stack slot */
+			/* Store an immediate with a zero offset over in0 in a stack slot */
 			for (k = 0; k < ARRAY_SIZE(imms); k++) {
 				int rd = pair_reg(b, 1);
 
 				prog_start(&p);
-				EMIT(&p, BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0));
+				EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
+				EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rd, -8));
 				EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
 				EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8));
 				EMIT(&p, BPF_ST_MEM(size, rb, 0, imms[k]));
@@ -1665,8 +1672,10 @@ static void test_ldst_zero_off(void)
 				fd = prog_load(&p, desc);
 				if (fd < 0)
 					return;
-				prog_run(fd, 0, 0,
-					 head_merge(0, (__u64)(__s64)imms[k], size), desc);
+				for (j = 0; j < ARRAY_SIZE(inputs); j++)
+					prog_run(fd, inputs[j], 0,
+						 head_merge(inputs[j], (__u64)(__s64)imms[k], size),
+						 desc);
 				close(fd);
 			}
 
@@ -1759,11 +1768,20 @@ static int offsets_for(int size, bool unaligned, int *off)
 	off[cnt++] = -128;
 	off[cnt++] = -128 - n;
 	off[cnt++] = -256;
+	off[cnt++] = -256 - n;
 	off[cnt++] = -4096;
 	off[cnt++] = -MEM_BASE;
+	/* The last offset of the scaled form and the first past it, 4095 to 16384 */
+	if (n < 8)
+		off[cnt++] = 0xfff * n;
+	if (n > 1 && n < 8)
+		off[cnt++] = 0x1000 * n;
 	if (n > 1 && unaligned) {
 		off[cnt++] = 13;
 		off[cnt++] = 127;
+		off[cnt++] = 255;
+		off[cnt++] = 257;
+		off[cnt++] = -257;
 		off[cnt++] = -13;
 		off[cnt++] = -129;
 	}
@@ -1975,7 +1993,7 @@ static void store_offsets(struct off_mem *m, int size, int rb, int rd, __s32 imm
 static void test_ldst_offsets(void)
 {
 	static const int sizes[] = { BPF_B, BPF_H, BPF_W, BPF_DW };
-	static const __s32 imms[] = { -1, 0x7fffffff, -0x7fffffff - 1 };
+	static const __s32 imms[] = { 0, -1, 0x7fffffff, -0x7fffffff - 1 };
 	int b, k, s, i, nr, off[32];
 	struct off_mem m = {};
 	bool unaligned;
@@ -2088,7 +2106,8 @@ static void jmp_prog(struct prog *p, bool is64, int op, int d, __s32 imm, int of
 static void test_jset_imm(void)
 {
 	static const __s32 masks[] = {
-		0x1, 0x40, 0x80, 0xff, 0x100, 0x7fff, 0x7fffffff, -1, -0x7fffffff - 1,
+		0x1, 0x2, 0x40, 0x80, 0xff, 0x100, 0x7fff, 0x8000, 0x10000, 0x7fffffff,
+		0x40000000, -1, -0x7fffffff - 1,
 	};
 	struct prog p;
 	char desc[64];
@@ -2155,7 +2174,11 @@ static bool cmp_taken(int op, bool is64, __u64 v, __u64 c)
 static void test_cmp_imm(void)
 {
 	static const __s32 imms[] = {
-		1, -1, 0x7f, 0x80, -0x80, -0x81, 0x1000, 0x7fffffff,
+		0, 1, -1, 0x7f, 0x80, -0x80, -0x81, 0x1000, 0x7fffffff,
+		0xfff, 0x1001, 0xffff, 0x10000, 0x10001, -0x1000, -0x1001,
+		-0x7fffffff - 1, 0x7ffffffe, 0x12345, -0x12345, 0xfff001,
+		0xffffff, -0xffffff, 0x1000000, -0x1000000, 0x3ffc, -0x10001,
+		0xfff000, -0xfff, -0xfff000, -0xfff001, 0x1000001,
 	};
 	static const int ops[] = {
 		BPF_JEQ, BPF_JNE, BPF_JGT, BPF_JGE, BPF_JLT, BPF_JLE,
@@ -2186,8 +2209,18 @@ static void test_cmp_imm(void)
 
 						prog_run(fd, inputs[j], 0, taken, desc);
 					}
+					/* The operands at the immediate and right next to it */
+					for (j = -1; j <= 1; j++) {
+						__s64 near = (__s64)imms[m] + j;
+						__u64 v = is64 ? (__u64)near : (__u32)near;
+						__u64 c = is64 ? (__u64)(__s64)imms[m] :
+							  (__u32)imms[m];
+						__u64 taken = cmp_taken(ops[o], is64, v, c);
+
+						prog_run(fd, v, 0, taken, desc);
+					}
 					close(fd);
-					if (m)
+					if (imms[m] < -1 || imms[m] > 1)
 						continue;
 					/* A jump over nothing lands on the same path either way */
 					jmp_prog(&p, is64, ops[o], d, imms[m], 0);
@@ -2234,12 +2267,31 @@ static void test_alu_consts(void)
 		{ BPF_ADD, 1 }, { BPF_ADD, -1 }, { BPF_SUB, 1 }, { BPF_SUB, -1 },
 		{ BPF_ADD, 128 }, { BPF_SUB, 128 }, { BPF_ADD, -128 },
 		{ BPF_AND, 0xff }, { BPF_AND, 0xffff }, { BPF_AND, 0x7f },
-		{ BPF_AND, 0x3ff }, { BPF_AND, 0x7fffffff },
-		{ BPF_OR, 0xff }, { BPF_XOR, -1 }, { BPF_XOR, 0x80 },
+		{ BPF_AND, 0x3ff }, { BPF_AND, 0x7fffffff }, { BPF_AND, -1 },
+		{ BPF_OR, 0xff }, { BPF_OR, -1 }, { BPF_XOR, -1 }, { BPF_XOR, 0x80 },
 		{ BPF_MUL, 2 }, { BPF_MUL, 3 }, { BPF_MUL, 4 }, { BPF_MUL, 5 },
 		{ BPF_MUL, 7 }, { BPF_MUL, 8 }, { BPF_MUL, 9 }, { BPF_MUL, 16 },
+		{ BPF_MUL, 17 }, { BPF_MUL, 33 }, { BPF_MUL, 0x40000001 },
 		{ BPF_MUL, 0x40000000 }, { BPF_MUL, -3 }, { BPF_MUL, -0x7fffffff - 1 },
 		{ BPF_MUL, 0 }, { BPF_MUL, 1 }, { BPF_MUL, -1 },
+		{ BPF_ADD, 0 }, { BPF_SUB, 0 }, { BPF_OR, 0 }, { BPF_XOR, 0 }, { BPF_AND, 0 },
+		{ BPF_MUL, 6 }, { BPF_MUL, 10 }, { BPF_MUL, 12 }, { BPF_MUL, 14 },
+		{ BPF_MUL, 15 }, { BPF_MUL, 24 }, { BPF_MUL, 31 }, { BPF_MUL, 48 },
+		{ BPF_MUL, 0x3fffffff }, { BPF_MUL, 0x7fffffff }, { BPF_MUL, -2 },
+		{ BPF_MUL, -4 }, { BPF_MUL, -6 }, { BPF_MUL, -7 }, { BPF_MUL, -8 },
+		{ BPF_MUL, -9 }, { BPF_MUL, -14 }, { BPF_MUL, -15 }, { BPF_MUL, -16 },
+		{ BPF_MUL, -0x40000000 }, { BPF_MUL, -0x7fffffff },
+		{ BPF_ADD, 0x10000 }, { BPF_ADD, 0x10001 }, { BPF_SUB, 0x10001 },
+		{ BPF_ADD, 0x12345 }, { BPF_ADD, -0x12345 }, { BPF_SUB, 0x12345 },
+		{ BPF_SUB, -0x12345 }, { BPF_ADD, 0xffffff }, { BPF_ADD, -0xffffff },
+		{ BPF_SUB, 0xffffff }, { BPF_ADD, 0x1000000 }, { BPF_SUB, -0x1000000 },
+		{ BPF_ADD, 0x123000 }, { BPF_ADD, 0xfff001 }, { BPF_SUB, 0x1001 },
+		{ BPF_ADD, -0x7fffffff - 1 }, { BPF_SUB, -0x7fffffff - 1 },
+		{ BPF_MUL, 66 }, { BPF_MUL, 272 }, { BPF_MUL, 240 }, { BPF_MUL, 992 },
+		{ BPF_MUL, -17 }, { BPF_MUL, -33 }, { BPF_MUL, -48 }, { BPF_MUL, -96 },
+		{ BPF_MUL, -12 }, { BPF_MUL, -24 }, { BPF_MUL, -28 },
+		{ BPF_ADD, 0x3ffc }, { BPF_ADD, -0x10001 }, { BPF_SUB, 0x3ffc },
+		{ BPF_SUB, -0x10001 },
 	};
 	struct prog p;
 	char desc[64];
@@ -2338,6 +2390,15 @@ static void test_probe_mem(void)
 		{ BPF_B, false }, { BPF_H, false }, { BPF_W, false }, { BPF_DW, false },
 		{ BPF_B, true }, { BPF_H, true }, { BPF_W, true },
 	};
+	/* Offsets of the scaled, the unscaled and the register form, within the ctx and outside */
+	static const struct {
+		int size;
+		__s16 off;
+	} probes_in[] = {
+		{ BPF_DW, 8 }, { BPF_W, 4 }, { BPF_H, 2 }, { BPF_B, 13 },
+	}, probes_out[] = {
+		{ BPF_DW, 0 }, { BPF_B, 13 }, { BPF_DW, -8 }, { BPF_W, 4096 }, { BPF_H, -4096 },
+	};
 	int kfunc_id, type_id, b, k, l, j, fd;
 	struct bpf_insn call;
 	struct btf *btf;
@@ -2396,24 +2457,52 @@ static void test_probe_mem(void)
 		}
 	}
 
-	/* NULL and a user address are not touched and read as zero */
-	for (j = 0; j < 2; j++) {
-		__u64 addr = j ? 0x00007ffffffff000ULL : 0;
+	/* The offset forms through the untrusted pointer of the cast to void */
+	for (l = 0; l < ARRAY_SIZE(probes_in); l++) {
+		int size = probes_in[l].size, off = probes_in[l].off;
 
 		prog_start(&p);
-		EMIT(&p, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, 0, 0, (__u32)addr));
-		EMIT(&p, BPF_RAW_INSN(0, 0, 0, 0, addr >> 32));
-		EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, type_id));
+		EMIT(&p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_6));
+		EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, 0));
 		EMIT(&p, call);
-		EMIT(&p, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0));
+		EMIT(&p, BPF_LDX_MEM(size, BPF_REG_3, BPF_REG_0, off));
 		prog_end(&p, BPF_REG_3);
-		snprintf(desc, sizeof(desc), "probe_mem addr=0x%llx", addr);
+		snprintf(desc, sizeof(desc), "probe_mem void size=%d off=%d", size, off);
 		fd = prog_load(&p, desc);
 		if (fd < 0)
 			return;
-		prog_run(fd, 0, 0, 0, desc);
+		for (j = 0; j < ARRAY_SIZE(inputs); j++) {
+			struct pat_ctx c = { .in0 = inputs[j], .in1 = ~inputs[j] };
+
+			prog_run(fd, c.in0, c.in1, load_bytes((__u8 *)&c + off, size), desc);
+		}
 		close(fd);
 	}
+
+	/* NULL and a user address are not touched and read as zero, in every form */
+	for (l = 0; l < ARRAY_SIZE(probes_out); l++) {
+		int size = probes_out[l].size, off = probes_out[l].off;
+
+		for (j = 0; j < 2; j++) {
+			__u64 addr = j ? 0x00007ffffffe0000ULL : 0;
+
+			prog_start(&p);
+			EMIT(&p, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, 0, 0,
+					      (__u32)addr));
+			EMIT(&p, BPF_RAW_INSN(0, 0, 0, 0, addr >> 32));
+			EMIT(&p, BPF_MOV32_IMM(BPF_REG_2, l ? 0 : type_id));
+			EMIT(&p, call);
+			EMIT(&p, BPF_LDX_MEM(size, BPF_REG_3, BPF_REG_0, off));
+			prog_end(&p, BPF_REG_3);
+			snprintf(desc, sizeof(desc), "probe_mem addr=0x%llx size=%d off=%d",
+				 addr, size, off);
+			fd = prog_load(&p, desc);
+			if (fd < 0)
+				return;
+			prog_run(fd, 0, 0, 0, desc);
+			close(fd);
+		}
+	}
 }
 
 /*
@@ -2425,9 +2514,11 @@ static void test_probe_mem(void)
 static void test_acq_rel(void)
 {
 	static const int sizes[] = { BPF_B, BPF_H, BPF_W, BPF_DW };
+	/* The slot through the base at the slot, below it and above it */
+	static const int offs[] = { 0, 8, -8 };
 	struct prog p;
 	char desc[64];
-	int b, k, s, j, fd;
+	int b, k, s, o, j, fd;
 
 	for (b = 0; b < ARRAY_SIZE(pat_regs); b++) {
 		int rb = pat_regs[b];
@@ -2438,49 +2529,169 @@ static void test_acq_rel(void)
 			for (k = 0; k < NR_PAIRS; k++) {
 				int rd = pair_reg(b, k);
 
-				/* Load-acquire from the slot, also into the base */
-				prog_start(&p);
-				EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
-				EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rd, -8));
-				EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
-				EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8));
-				EMIT(&p, BPF_ATOMIC_OP(size, BPF_LOAD_ACQ, rd, rb, 0));
-				prog_end(&p, rd);
-				snprintf(desc, sizeof(desc), "load_acq size=%d base=r%d dst=r%d",
-					 size, rb, rd);
-				fd = prog_load(&p, desc);
-				if (fd < 0)
-					return;
-				for (j = 0; j < ARRAY_SIZE(inputs); j++)
-					prog_run(fd, inputs[j], 0,
-						 head_bytes(inputs[j], size), desc);
-				close(fd);
+				for (o = 0; o < ARRAY_SIZE(offs); o++) {
+					int off = offs[o];
+
+					/* Load-acquire from the slot, also into the base */
+					prog_start(&p);
+					EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
+					EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rd, -8));
+					EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
+					EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8 - off));
+					EMIT(&p, BPF_ATOMIC_OP(size, BPF_LOAD_ACQ, rd, rb, off));
+					prog_end(&p, rd);
+					snprintf(desc, sizeof(desc),
+						 "load_acq size=%d base=r%d dst=r%d off=%d",
+						 size, rb, rd, off);
+					fd = prog_load(&p, desc);
+					if (fd < 0)
+						return;
+					for (j = 0; j < ARRAY_SIZE(inputs); j++)
+						prog_run(fd, inputs[j], 0,
+							 head_bytes(inputs[j], size), desc);
+					close(fd);
+
+					if (rd == rb)
+						continue;
+					/* Store-release of in1 over the slot holding in0 */
+					prog_start(&p);
+					EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
+					EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rd, -8));
+					EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN1));
+					EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
+					EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8 - off));
+					EMIT(&p, BPF_ATOMIC_OP(size, BPF_STORE_REL, rb, rd, off));
+					EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_10, -8));
+					prog_end(&p, rd);
+					snprintf(desc, sizeof(desc),
+						 "store_rel size=%d base=r%d src=r%d off=%d",
+						 size, rb, rd, off);
+					fd = prog_load(&p, desc);
+					if (fd < 0)
+						return;
+					for (j = 0; j < ARRAY_SIZE(inputs); j++) {
+						__u64 in1 = inputs[(j + 1) % ARRAY_SIZE(inputs)];
+
+						prog_run(fd, inputs[j], in1,
+							 head_merge(inputs[j], in1, size), desc);
+					}
+					close(fd);
+				}
+			}
+		}
+	}
+}
+
+/* The n-th register after pat_regs[b] that is neither it nor r0 */
+static int ptr_operand_reg(int b, int n)
+{
+	int i = b;
+
+	while (n--) {
+		do {
+			i = (i + 1) % ARRAY_SIZE(pat_regs);
+		} while (pat_regs[i] == BPF_REG_0);
+	}
+	return pat_regs[i];
+}
+
+/* rr |= bit unless ra == rb, compared in the width of size */
+static void check_eq(struct prog *p, int size, int ra, int rb, int rr, int bit)
+{
+	if (size == BPF_W)
+		EMIT(p, BPF_JMP32_REG(BPF_JEQ, ra, rb, 1));
+	else
+		EMIT(p, BPF_JMP_REG(BPF_JEQ, ra, rb, 1));
+	EMIT(p, BPF_ALU64_IMM(BPF_OR, rr, bit));
+}
+
+/*
+ * Atomics with the pointer itself as the operand (src == dst, and cmpxchg
+ * with the pointer as the new value), the bytes written checked against the
+ * operation done on a copy of the pointer made a number by two negations.
+ */
+static void test_atomic_ptr_operand(void)
+{
+	static const int sizes[] = { BPF_DW, BPF_W };
+	static const int ops[] = { BPF_ADD, BPF_AND, BPF_OR, BPF_XOR };
+	struct prog p;
+	char desc[64];
+	int b, k, s, j, fd;
+
+	for (b = 0; b < ARRAY_SIZE(pat_regs); b++) {
+		/* The pointer, a copy of it, the expected value, the memory and the result */
+		int rb = pat_regs[b], rp = ptr_operand_reg(b, 1), rv = ptr_operand_reg(b, 2);
+		int rm = ptr_operand_reg(b, 3), rr = ptr_operand_reg(b, 4);
+
+		for (s = 0; s < ARRAY_SIZE(sizes); s++) {
+			int size = sizes[s];
+			bool w = size == BPF_W;
+
+			for (k = 0; k < ARRAY_SIZE(ops); k++) {
+				int op = ops[k];
 
-				if (rd == rb)
-					continue;
-				/* Store-release of in1 over the slot holding in0 */
 				prog_start(&p);
-				EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN0));
-				EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rd, -8));
-				EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_6, IN1));
+				EMIT(&p, BPF_MOV64_IMM(rr, 0));
+				EMIT(&p, BPF_LDX_MEM(BPF_DW, rv, BPF_REG_6, IN0));
+				EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rv, -8));
 				EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
 				EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8));
-				EMIT(&p, BPF_ATOMIC_OP(size, BPF_STORE_REL, rb, rd, 0));
-				EMIT(&p, BPF_LDX_MEM(BPF_DW, rd, BPF_REG_10, -8));
-				prog_end(&p, rd);
-				snprintf(desc, sizeof(desc), "store_rel size=%d base=r%d src=r%d",
-					 size, rb, rd);
+				EMIT(&p, BPF_MOV64_REG(rp, rb));
+				EMIT(&p, BPF_ALU64_IMM(BPF_NEG, rp, 0));
+				EMIT(&p, BPF_ALU64_IMM(BPF_NEG, rp, 0));
+				/* The bytes the atomic operates on, whichever the byte order */
+				EMIT(&p, BPF_LDX_MEM(size, rv, rb, 0));
+				EMIT(&p, BPF_ATOMIC_OP(size, op, rb, rb, 0));
+				/* The memory holds in0 <op> pointer, the register the pointer */
+				if (w)
+					EMIT(&p, BPF_ALU32_REG(op, rv, rp));
+				else
+					EMIT(&p, BPF_ALU64_REG(op, rv, rp));
+				/* Read back through fp, a clobbered pointer must not fault */
+				EMIT(&p, BPF_LDX_MEM(size, rm, BPF_REG_10, -8));
+				check_eq(&p, BPF_DW, rm, rv, rr, 1);
+				check_eq(&p, BPF_DW, rb, rp, rr, 2);
+				prog_end(&p, rr);
+				snprintf(desc, sizeof(desc), "atomic%d_%s ptr=r%d",
+					 w ? 32 : 64, alu_name(op), rb);
 				fd = prog_load(&p, desc);
 				if (fd < 0)
 					return;
-				for (j = 0; j < ARRAY_SIZE(inputs); j++) {
-					__u64 in1 = inputs[(j + 1) % ARRAY_SIZE(inputs)];
-
-					prog_run(fd, inputs[j], in1,
-						 head_merge(inputs[j], in1, size), desc);
-				}
+				for (j = 0; j < ARRAY_SIZE(inputs); j++)
+					prog_run(fd, inputs[j], 0, 0, desc);
 				close(fd);
 			}
+
+			/* The pointer as the new value, r0 holds in0 and matches */
+			if (rb == BPF_REG_0)
+				continue;
+			prog_start(&p);
+			EMIT(&p, BPF_MOV64_IMM(rr, 0));
+			EMIT(&p, BPF_LDX_MEM(BPF_DW, rv, BPF_REG_6, IN0));
+			EMIT(&p, BPF_STX_MEM(BPF_DW, BPF_REG_10, rv, -8));
+			EMIT(&p, BPF_MOV64_REG(rb, BPF_REG_10));
+			EMIT(&p, BPF_ALU64_IMM(BPF_ADD, rb, -8));
+			EMIT(&p, BPF_MOV64_REG(rp, rb));
+			EMIT(&p, BPF_ALU64_IMM(BPF_NEG, rp, 0));
+			EMIT(&p, BPF_ALU64_IMM(BPF_NEG, rp, 0));
+			/* r0 holds the bytes the atomic compares with and matches */
+			EMIT(&p, BPF_LDX_MEM(size, BPF_REG_0, rb, 0));
+			EMIT(&p, BPF_MOV64_REG(rv, BPF_REG_0));
+			EMIT(&p, BPF_ATOMIC_OP(size, BPF_CMPXCHG, rb, rb, 0));
+			/* The memory holds the pointer in the width, r0 the old value */
+			EMIT(&p, BPF_LDX_MEM(size, rm, BPF_REG_10, -8));
+			check_eq(&p, size, rm, rp, rr, 1);
+			check_eq(&p, BPF_DW, BPF_REG_0, rv, rr, 2);
+			check_eq(&p, BPF_DW, rb, rp, rr, 4);
+			prog_end(&p, rr);
+			snprintf(desc, sizeof(desc), "atomic%d_cmpxchg ptr=r%d new=r%d",
+				 w ? 32 : 64, rb, rb);
+			fd = prog_load(&p, desc);
+			if (fd < 0)
+				return;
+			for (j = 0; j < ARRAY_SIZE(inputs); j++)
+				prog_run(fd, inputs[j], 0, 0, desc);
+			close(fd);
 		}
 	}
 }
@@ -2550,6 +2761,183 @@ static void test_max_jmp(void)
 	max_jmp(true, false);
 }
 
+/*
+ * A sign test forward and back over a region of n sign tests, which shrink
+ * it as they take the short branch: the test back comes within reach as the
+ * passes settle, the test ahead is decided at the sizing pass; n sweeps it.
+ */
+#define CHAIN_NO_CALL	0
+#define CHAIN_HELPER	1
+#define CHAIN_SUBPROG	2
+
+static void sign_jumps(int inner, bool back, int call, const char *desc)
+{
+	struct bpf_insn *insns;
+	int n = 0, top, sub = 0, i, fd;
+
+	insns = malloc((24 + 2 * inner) * sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, desc))
+		return;
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0);
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, IN1);
+	insns[n++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+	if (back)
+		insns[n++] = BPF_MOV64_IMM(BPF_REG_4, -2);
+	else
+		insns[n++] = BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 0);
+	top = n;
+	for (i = 0; i < inner; i++) {
+		insns[n++] = BPF_JMP_IMM(BPF_JSGE, BPF_REG_3, 0, 1);
+		insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1);
+	}
+	if (call != CHAIN_NO_CALL) {
+		/* The call clobbers r0 to r5: the count, the sign and the loop go to r7 to r9 */
+		insns[n++] = BPF_MOV64_REG(BPF_REG_7, BPF_REG_2);
+		insns[n++] = BPF_MOV64_REG(BPF_REG_8, BPF_REG_3);
+		if (back)
+			insns[n++] = BPF_MOV64_REG(BPF_REG_9, BPF_REG_4);
+		sub = n++;
+		insns[n++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_7);
+		insns[n++] = BPF_MOV64_REG(BPF_REG_3, BPF_REG_8);
+		if (back)
+			insns[n++] = BPF_MOV64_REG(BPF_REG_4, BPF_REG_9);
+	}
+	if (back) {
+		insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 1);
+		insns[n] = BPF_JMP_IMM(BPF_JSLT, BPF_REG_4, 0, top - n - 1);
+		n++;
+	} else {
+		insns[top - 1] = BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, n - top);
+	}
+	insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, RES);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[n++] = BPF_EXIT_INSN();
+	if (call == CHAIN_SUBPROG) {
+		insns[sub] = BPF_CALL_REL(n - sub - 1);
+		insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		insns[n++] = BPF_EXIT_INSN();
+	} else if (call == CHAIN_HELPER) {
+		insns[sub] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
+	}
+
+	fd = load_prog(insns, n, desc);
+	free(insns);
+	if (fd < 0)
+		return;
+	/* The adds taken with the inner sign set, none with the outer one */
+	prog_run(fd, 0, -1, back ? 2 * inner : inner, desc);
+	prog_run(fd, 0, 0, 0, desc);
+	prog_run(fd, -1, -1, back ? 2 * inner : 0, desc);
+	prog_run(fd, 1ULL << 63, 1, 0, desc);
+	close(fd);
+}
+
+/*
+ * A chain of sign tests over the region, each an instruction further out than
+ * the next, so each would fit the short reach only once the next one shrank,
+ * which a test ahead is not decided from; a call in the region shrinks it.
+ */
+static void sign_jump_chain(int inner, int outer, int call, const char *desc)
+{
+	struct bpf_insn *insns;
+	int n = 0, top, off, sub = 0, i, fd;
+
+	insns = malloc((16 + 2 * outer + 2 * inner) * sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, desc))
+		return;
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0);
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_1, IN1);
+	insns[n++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+	top = n;
+	n += outer;
+	for (i = 0; i < inner; i++) {
+		insns[n++] = BPF_JMP_IMM(BPF_JSGE, BPF_REG_3, 0, 1);
+		insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1);
+	}
+	if (call != CHAIN_NO_CALL) {
+		insns[n++] = BPF_MOV64_REG(BPF_REG_7, BPF_REG_2);
+		sub = n++;
+		insns[n++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_7);
+	}
+	/* The i-th test jumps to the i-th add behind the region, the same offset for all */
+	off = n - top - 1;
+	for (i = 0; i < outer; i++) {
+		insns[top + i] = BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, off);
+		insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1);
+	}
+	insns[n++] = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_2, RES);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insns[n++] = BPF_EXIT_INSN();
+	if (call == CHAIN_SUBPROG) {
+		insns[sub] = BPF_CALL_REL(n - sub - 1);
+		insns[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		insns[n++] = BPF_EXIT_INSN();
+	} else if (call == CHAIN_HELPER) {
+		insns[sub] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
+	}
+
+	fd = load_prog(insns, n, desc);
+	free(insns);
+	if (fd < 0)
+		return;
+	/* The adds of the region with the inner sign set, the ones behind it always */
+	prog_run(fd, 0, -1, inner + outer, desc);
+	prog_run(fd, 0, 0, outer, desc);
+	prog_run(fd, -1, -1, outer, desc);
+	prog_run(fd, 1ULL << 63, 1, outer, desc);
+	close(fd);
+}
+
+static void test_sign_jumps(void)
+{
+	/* 2729 to 2732: a region of 8188 to 8197 instructions as the sizing pass sees it */
+	static const int inners[] = { 16, 2000, 2729, 2730, 2731, 2732, 4200 };
+	static const int chain_inners[][2] = { { 2716, 2724 }, { 4080, 4098 } };
+	char desc[80];
+	int i, inner;
+
+	for (i = 0; i < ARRAY_SIZE(inners); i++) {
+		snprintf(desc, sizeof(desc), "sign jump over %d sign jumps", inners[i]);
+		sign_jumps(inners[i], false, CHAIN_NO_CALL, desc);
+		snprintf(desc, sizeof(desc), "sign jump back over %d sign jumps", inners[i]);
+		sign_jumps(inners[i], true, CHAIN_NO_CALL, desc);
+	}
+	/*
+	 * The region across the reach of a short branch of 8K instructions once
+	 * it has shrunk, which the test back comes within as the passes settle,
+	 * with a call of a subprogram also in the extra pass
+	 */
+	for (inner = 4086; inner <= 4100; inner++) {
+		snprintf(desc, sizeof(desc), "sign jump over %d sign jumps at the range", inner);
+		sign_jumps(inner, false, CHAIN_NO_CALL, desc);
+		snprintf(desc, sizeof(desc), "sign jump back over %d sign jumps at the range",
+			 inner);
+		sign_jumps(inner, true, CHAIN_NO_CALL, desc);
+		snprintf(desc, sizeof(desc), "sign jump back over %d sign jumps and a subprog call",
+			 inner);
+		sign_jumps(inner, true, CHAIN_SUBPROG, desc);
+	}
+	/*
+	 * Chains across the reach: at the reach of the sizing pass over 2716 to
+	 * 2724 inner tests, where the tests ahead are decided, and at the reach
+	 * of the shrunk one over 4080 to 4098, kept at the compare and branch.
+	 */
+	for (i = 0; i < ARRAY_SIZE(chain_inners); i++) {
+		for (inner = chain_inners[i][0]; inner <= chain_inners[i][1]; inner++) {
+			snprintf(desc, sizeof(desc), "sign jump chain over %d sign jumps", inner);
+			sign_jump_chain(inner, 20, CHAIN_NO_CALL, desc);
+			snprintf(desc, sizeof(desc),
+				 "sign jump chain over %d sign jumps and a call", inner);
+			sign_jump_chain(inner, 20, CHAIN_HELPER, desc);
+			snprintf(desc, sizeof(desc),
+				 "sign jump chain over %d sign jumps and a subprog call", inner);
+			sign_jump_chain(inner, 20, CHAIN_SUBPROG, desc);
+		}
+	}
+}
+
 /*
  * Fillers of two and three bytes of native code on x86-64: a 32-bit and a
  * 64-bit move between two low registers, which give a region every length
@@ -3103,6 +3491,94 @@ static void test_helper_calls(void)
 	close(map_fd);
 }
 
+/*
+ * A tail call with the index from the packet, which the JIT scales and takes
+ * the low 32 bits of: the entries return their index plus one, an empty one
+ * and an index from the array size on TAIL_FALL, the upper 32 bits ignored.
+ */
+#define TAIL_ENTRIES	7
+#define TAIL_FALL	0xfa11
+
+static void test_tail_call(void)
+{
+	static const int filled[] = { 0, 1, 3, 5 };
+	static const struct {
+		__u64 index;
+		__u32 res;
+	} cases[] = {
+		{ 0, 1 }, { 1, 2 }, { 3, 4 }, { 5, 6 },
+		{ 2, TAIL_FALL }, { 4, TAIL_FALL }, { 6, TAIL_FALL },
+		{ TAIL_ENTRIES, TAIL_FALL }, { 0x7fffffff, TAIL_FALL }, { 0xffffffff, TAIL_FALL },
+		{ 1ULL << 32, 1 }, { (1ULL << 32) | 3, 4 }, { (~0ULL << 32) | 5, 6 },
+		{ (~0ULL << 32) | 2, TAIL_FALL }, { ~0ULL, TAIL_FALL },
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, lopts,
+		.log_buf = log,
+		.log_size = sizeof(log),
+	);
+	struct {
+		__u64 index;
+		__u64 pad;
+	} pkt = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt,
+		.data_size_in = sizeof(pkt),
+	);
+	struct bpf_insn insns[16];
+	int map_fd, fd = -1, k, n, i;
+	char desc[64];
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, "tail_call", sizeof(__u32),
+				sizeof(__u32), TAIL_ENTRIES, NULL);
+	if (!ASSERT_GE(map_fd, 0, "prog array"))
+		return;
+	for (i = 0; i < ARRAY_SIZE(filled); i++) {
+		k = filled[i];
+		n = 0;
+		insns[n++] = BPF_MOV64_IMM(BPF_REG_0, k + 1);
+		insns[n++] = BPF_EXIT_INSN();
+		snprintf(desc, sizeof(desc), "tail call target %d", k);
+		fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, n, &lopts);
+		if (!ASSERT_GE(fd, 0, desc)) {
+			fprintf(stderr, "%s", log);
+			goto out;
+		}
+		ASSERT_OK(bpf_map_update_elem(map_fd, &k, &fd, BPF_ANY), desc);
+		close(fd);
+	}
+	/* The index from the packet, a call which comes back returns TAIL_FALL */
+	n = 0;
+	insns[n++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	insns[n++] = BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data));
+	insns[n++] = BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end));
+	insns[n++] = BPF_MOV64_REG(BPF_REG_4, BPF_REG_2);
+	insns[n++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8);
+	insns[n++] = BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 5);
+	insns[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_2, 0);
+	insns[n++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	insns[n++] = BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_2, BPF_PSEUDO_MAP_FD, 0,
+				  map_fd);
+	insns[n++] = BPF_RAW_INSN(0, 0, 0, 0, 0);
+	insns[n++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tail_call);
+	insns[n++] = BPF_MOV64_IMM(BPF_REG_0, TAIL_FALL);
+	insns[n++] = BPF_EXIT_INSN();
+	fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, n, &lopts);
+	if (!ASSERT_GE(fd, 0, "tail call")) {
+		fprintf(stderr, "%s", log);
+		goto out;
+	}
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		snprintf(desc, sizeof(desc), "tail call index 0x%llx", cases[i].index);
+		pkt.index = cases[i].index;
+		if (ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), desc))
+			ASSERT_EQ(opts.retval, cases[i].res, desc);
+	}
+out:
+	if (fd >= 0)
+		close(fd);
+	close(map_fd);
+}
+
 void test_jit_insns(void)
 {
 	RUN_TESTS(jit_insns_arena);
@@ -3142,6 +3618,8 @@ void test_jit_insns(void)
 		test_staggered_jumps();
 	if (test__start_subtest("max_jmp"))
 		test_max_jmp();
+	if (test__start_subtest("sign_jumps"))
+		test_sign_jumps();
 	if (test__start_subtest("convergence"))
 		test_convergence();
 	if (test__start_subtest("same_len_not_converged"))
@@ -3150,12 +3628,16 @@ void test_jit_insns(void)
 		test_calls();
 	if (test__start_subtest("helper_calls"))
 		test_helper_calls();
+	if (test__start_subtest("tail_call"))
+		test_tail_call();
 	if (test__start_subtest("ldst_zero_off"))
 		test_ldst_zero_off();
 	if (test__start_subtest("ldst_offsets"))
 		test_ldst_offsets();
 	if (test__start_subtest("acq_rel"))
 		test_acq_rel();
+	if (test__start_subtest("atomic_ptr_operand"))
+		test_atomic_ptr_operand();
 	if (test__start_subtest("movsx"))
 		test_movsx();
 	if (test__start_subtest("jset_imm"))
diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index 95736eae2a58..b4aade54b983 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -13,7 +13,7 @@
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 } arena SEC(".maps");
 
 /*
@@ -32,6 +32,49 @@ struct {
 #define VAL_SUM	0x11224578aaccef10
 #endif
 
+/*
+ * The load-acquire and store-release through __imm_insn(), as clang has
+ * syntax for them only with __BPF_FEATURE_LOAD_ACQ_STORE_REL.
+ */
+#define ATOMIC(SIZE, OP, DST, SRC, OFF)						\
+	{ .code = BPF_STX | BPF_ATOMIC | (SIZE), .dst_reg = DST, .src_reg = SRC,	\
+	  .off = OFF, .imm = OP }
+
+/* The fields of those instructions, which vmlinux.h does not carry */
+#ifndef BPF_STX
+#define BPF_STX		0x03
+#define BPF_W		0x00
+#define BPF_B		0x10
+#define BPF_DW		0x18
+#define BPF_ATOMIC	0xc0
+#endif
+#ifndef BPF_LOAD_ACQ
+#define BPF_LOAD_ACQ	0x100
+#define BPF_STORE_REL	0x110
+#endif
+
+#if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||		\
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
+#define ARENA_LDSX
+#endif
+#if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||		\
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||			\
+	defined(__TARGET_ARCH_s390)
+#define ARENA_ATOMICS
+#endif
+#if defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||		\
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||			\
+	defined(__TARGET_ARCH_s390)
+#define ARENA_ACQ_REL
+#endif
+
+/* The first byte in memory of the u32 0x12abcdef depends on the byte order */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define ACQ_B0	0xef
+#else
+#define ACQ_B0	0x12
+#endif
+
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 SEC("syscall")
 __success __retval(0)
@@ -106,6 +149,407 @@ int cast_to_user(void *ctx)
 	: "r1", "r2", "r7", "r9");
 	return res != 0;
 }
+
+/*
+ * Every form of the arena address computation: offsets the add, the sub, the
+ * shifted add and a move take, the end of the second page, the narrow sizes
+ * and immediate stores, each checked through r2 at the same address.
+ */
+SEC("syscall")
+__success __retval(0)
+__naked void arena_offsets(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 2;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call bpf_arena_alloc_pages;			\
+	r7 = r0;					\
+	r0 = 1;						\
+	if r7 == 0 goto 9f;				\
+	r7 = addr_space_cast(r7, 0x0, 0x1);		\
+	r6 = r7;					\
+	r6 += 0x1000;					\
+	r9 = 0;						\
+	r8 = 0x1122334455667788 ll;			\
+	r5 = 0x0123456789abcdef ll;			\
+	r2 = r7;					\
+	r2 += 8;					\
+	*(u64 *)(r7 + 8) = r8;				\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	r1 = *(u64 *)(r7 + 8);				\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0xff8;					\
+	*(u64 *)(r6 - 8) = r8;				\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	r1 = *(u64 *)(r6 - 8);				\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0x1000;					\
+	*(u64 *)(r7 + 0x1000) = r8;			\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	r1 = *(u64 *)(r7 + 0x1000);			\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0x1238;					\
+	*(u64 *)(r7 + 0x1238) = r8;			\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	r1 = *(u64 *)(r7 + 0x1238);			\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0x1ff8;					\
+	*(u64 *)(r7 + 0x1ff8) = r8;			\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	r1 = *(u64 *)(r7 + 0x1ff8);			\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0xfff;					\
+	*(u8 *)(r7 + 0xfff) = r8;			\
+	r1 = *(u8 *)(r2 + 0);				\
+	r1 ^= 0x88;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = r5;				\
+	r1 = *(u8 *)(r7 + 0xfff);			\
+	r1 ^= 0xef;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 0x1001;					\
+	*(u8 *)(r7 + 0x1001) = r8;			\
+	r1 = *(u8 *)(r2 + 0);				\
+	r1 ^= 0x88;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = r5;				\
+	r1 = *(u8 *)(r7 + 0x1001);			\
+	r1 ^= 0xef;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+	*(u64 *)(r6 - 0x1000) = r8;			\
+	r1 = *(u64 *)(r7 + 0);				\
+	r1 ^= r8;					\
+	r9 |= r1;					\
+	*(u64 *)(r7 + 0) = r5;				\
+	r1 = *(u64 *)(r6 - 0x1000);			\
+	r1 ^= r5;					\
+	r9 |= r1;					\
+	*(u64 *)(r7 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 1;					\
+	*(u8 *)(r6 - 0xfff) = r8;			\
+	r1 = *(u8 *)(r2 + 0);				\
+	r1 ^= 0x88;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = r5;				\
+	r1 = *(u8 *)(r6 - 0xfff);			\
+	r1 ^= 0xef;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+	r6 += 8;					\
+	r2 = r7;					\
+	r2 += 7;					\
+	*(u8 *)(r6 - 0x1001) = r8;			\
+	r1 = *(u8 *)(r2 + 0);				\
+	r1 ^= 0x88;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = r5;				\
+	r1 = *(u8 *)(r6 - 0x1001);			\
+	r1 ^= 0xef;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+	r6 += -8;					\
+	r2 = r7;					\
+	r2 += 20;					\
+	*(u32 *)(r7 + 20) = r8;				\
+	r1 = *(u32 *)(r2 + 0);				\
+	w1 ^= w8;					\
+	r9 |= r1;					\
+	*(u32 *)(r2 + 0) = r5;				\
+	r1 = *(u32 *)(r7 + 20);				\
+	w1 ^= w5;					\
+	r9 |= r1;					\
+	*(u32 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 26;					\
+	*(u16 *)(r7 + 26) = r8;				\
+	r1 = *(u16 *)(r2 + 0);				\
+	r1 ^= 0x7788;					\
+	r9 |= r1;					\
+	*(u16 *)(r2 + 0) = r5;				\
+	r1 = *(u16 *)(r7 + 26);				\
+	r1 ^= 0xcdef;					\
+	r9 |= r1;					\
+	*(u16 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 29;					\
+	*(u8 *)(r7 + 29) = r8;				\
+	r1 = *(u8 *)(r2 + 0);				\
+	r1 ^= 0x88;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = r5;				\
+	r1 = *(u8 *)(r7 + 29);				\
+	r1 ^= 0xef;					\
+	r9 |= r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+	r2 = r7;					\
+	r2 += 8;					\
+	*(u64 *)(r2 + 0) = r5;				\
+	*(u64 *)(r7 + 8) = 0;				\
+	r1 = *(u64 *)(r2 + 0);				\
+	r9 |= r1;					\
+	*(u64 *)(r7 + 8) = 0x12345;			\
+	r1 = *(u64 *)(r2 + 0);				\
+	r1 ^= 0x12345;					\
+	r9 |= r1;					\
+	*(u32 *)(r7 + 8) = -1;				\
+	r1 = *(u32 *)(r2 + 0);				\
+	w1 ^= -1;					\
+	r9 |= r1;					\
+	r1 = *(u64 *)(r7 + 0x2000);			\
+	r9 |= r1;					\
+	r0 = 0;						\
+	if r9 == 0 goto 9f;				\
+	r0 = 1;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+/* The sign extending loads at an offset, the values written through r2 */
+#ifdef ARENA_LDSX
+SEC("syscall")
+__success __retval(0)
+__naked void arena_offsets_ldsx(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 2;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call bpf_arena_alloc_pages;			\
+	r7 = r0;					\
+	r0 = 1;						\
+	if r7 == 0 goto 9f;				\
+	r7 = addr_space_cast(r7, 0x0, 0x1);		\
+	r9 = 0;						\
+	r2 = r7;					\
+	r2 += 40;					\
+	*(u8 *)(r2 + 0) = -16;				\
+	r2 = r7;					\
+	r2 += 42;					\
+	*(u16 *)(r2 + 0) = -0x1234;			\
+	r2 = r7;					\
+	r2 += 44;					\
+	*(u32 *)(r2 + 0) = -0x12345678;			\
+	r1 = *(s8 *)(r7 + 40);				\
+	r1 += 16;					\
+	r9 |= r1;					\
+	r1 = *(s16 *)(r7 + 42);				\
+	r1 += 0x1234;					\
+	r9 |= r1;					\
+	r1 = *(s32 *)(r7 + 44);				\
+	r1 += 0x12345678;				\
+	r9 |= r1;					\
+	r0 = 0;						\
+	if r9 == 0 goto 9f;				\
+	r0 = 1;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+#endif /* ARENA_LDSX */
+
+/* The atomics at an offset and at zero, the results read back through r6 */
+#ifdef ARENA_ATOMICS
+SEC("syscall")
+__success __retval(0)
+__naked void arena_offsets_atomics(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 2;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call bpf_arena_alloc_pages;			\
+	r7 = r0;					\
+	r0 = 1;						\
+	if r7 == 0 goto 9f;				\
+	r7 = addr_space_cast(r7, 0x0, 0x1);		\
+	r6 = r7;					\
+	r6 += 0x1008;					\
+	r9 = 0;						\
+	r1 = 0x10;					\
+	*(u64 *)(r7 + 0x1008) = r1;			\
+	r8 = 1;						\
+	lock *(u64 *)(r7 + 0x1008) += r8;		\
+	r2 = 1;						\
+	r2 = atomic_fetch_add((u64 *)(r7 + 0x1008), r2);	\
+	r2 ^= 0x11;					\
+	r9 |= r2;					\
+	r3 = 0x77;					\
+	r3 = xchg_64(r7 + 0x1008, r3);			\
+	r3 ^= 0x12;					\
+	r9 |= r3;					\
+	r0 = 0x77;					\
+	r4 = 0x99;					\
+	r0 = cmpxchg_64(r7 + 0x1008, r0, r4);		\
+	r0 ^= 0x77;					\
+	r9 |= r0;					\
+	r1 = *(u64 *)(r6 + 0);				\
+	r1 ^= 0x99;					\
+	r9 |= r1;					\
+	*(u64 *)(r7 + 8) = r8;				\
+	lock *(u64 *)(r7 + 8) += r8;			\
+	r1 = *(u64 *)(r7 + 8);				\
+	r1 ^= 2;					\
+	r9 |= r1;					\
+	r6 += 8;					\
+	lock *(u64 *)(r6 - 8) += r8;			\
+	r1 = *(u64 *)(r7 + 0x1008);			\
+	r1 ^= 0x9a;					\
+	r9 |= r1;					\
+	lock *(u64 *)(r7 + 0x1000) += r8;		\
+	r1 = *(u64 *)(r7 + 0x1000);			\
+	r1 ^= 1;					\
+	r9 |= r1;					\
+	w1 = 0x10;					\
+	*(u32 *)(r7 + 0) = w1;				\
+	w8 = 1;						\
+	lock *(u32 *)(r7 + 0) += w8;			\
+	w2 = 1;						\
+	w2 = atomic_fetch_add((u32 *)(r7 + 0), w2);	\
+	w2 ^= 0x11;					\
+	r9 |= r2;					\
+	w3 = 0x77;					\
+	w3 = xchg32_32(r7 + 0, w3);			\
+	w3 ^= 0x12;					\
+	r9 |= r3;					\
+	w0 = 0x77;					\
+	w4 = 0x99;					\
+	w0 = cmpxchg32_32(r7 + 0, w0, w4);		\
+	w0 ^= 0x77;					\
+	r9 |= r0;					\
+	r1 = *(u32 *)(r7 + 0);				\
+	w1 ^= 0x99;					\
+	r9 |= r1;					\
+	r0 = 0;						\
+	if r9 == 0 goto 9f;				\
+	r0 = 1;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+#endif /* ARENA_ATOMICS */
+
+#ifdef ARENA_ACQ_REL
+static const struct bpf_insn store_rel8 = ATOMIC(BPF_DW, BPF_STORE_REL, 7, 1, 8);
+static const struct bpf_insn load_acq8 = ATOMIC(BPF_DW, BPF_LOAD_ACQ, 2, 7, 8);
+static const struct bpf_insn store_rel0 = ATOMIC(BPF_W, BPF_STORE_REL, 7, 1, 0);
+static const struct bpf_insn load_acq0 = ATOMIC(BPF_B, BPF_LOAD_ACQ, 2, 7, 0);
+static const struct bpf_insn store_rel_hi = ATOMIC(BPF_DW, BPF_STORE_REL, 7, 1, 0x1000);
+static const struct bpf_insn load_acq_lo = ATOMIC(BPF_DW, BPF_LOAD_ACQ, 2, 3, -8);
+
+/*
+ * The load-acquire and store-release at an offset and at zero, checked
+ * through r3 with a plain load and store, and at the offsets of the other
+ * two immediate forms into the second page.
+ */
+SEC("syscall")
+__success __retval(0)
+__naked void arena_acq_rel(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 2;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call bpf_arena_alloc_pages;			\
+	r7 = r0;					\
+	r0 = 1;						\
+	if r7 == 0 goto 9f;				\
+	r7 = addr_space_cast(r7, 0x0, 0x1);		\
+	r3 = r7;					\
+	r3 += 8;					\
+	r9 = 0;						\
+	r1 = 0x1234;					\
+	.8byte %[store_rel8];	/* store_release((u64 *)(r7 + 8), r1) */	\
+	r2 = *(u64 *)(r3 + 0);				\
+	r2 ^= 0x1234;					\
+	r9 |= r2;					\
+	r1 = 0x5678;					\
+	*(u64 *)(r3 + 0) = r1;				\
+	.8byte %[load_acq8];	/* r2 = load_acquire((u64 *)(r7 + 8)) */	\
+	r2 ^= 0x5678;					\
+	r9 |= r2;					\
+	w1 = 0x12abcdef;				\
+	.8byte %[store_rel0];	/* store_release((u32 *)(r7 + 0), w1) */	\
+	.8byte %[load_acq0];	/* w2 = load_acquire((u8 *)(r7 + 0)) */	\
+	r2 ^= %[b0];					\
+	r9 |= r2;					\
+	r1 = *(u32 *)(r7 + 0);				\
+	w1 ^= 0x12abcdef;				\
+	r9 |= r1;					\
+	r3 = r7;					\
+	r3 += 0x1008;					\
+	r1 = 0x9abc;					\
+	.8byte %[store_rel_hi];	/* store_release((u64 *)(r7 + 0x1000), r1) */	\
+	r2 = *(u64 *)(r3 - 8);				\
+	r2 ^= 0x9abc;					\
+	r9 |= r2;					\
+	r1 = 0xdef0;					\
+	*(u64 *)(r3 - 8) = r1;				\
+	.8byte %[load_acq_lo];	/* r2 = load_acquire((u64 *)(r3 - 8)) */	\
+	r2 ^= 0xdef0;					\
+	r9 |= r2;					\
+	r0 = 0;						\
+	if r9 == 0 goto 9f;				\
+	r0 = 1;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_const(b0, ACQ_B0),
+	  __imm_insn(store_rel8, store_rel8),
+	  __imm_insn(load_acq8, load_acq8),
+	  __imm_insn(store_rel0, store_rel0),
+	  __imm_insn(load_acq0, load_acq0),
+	  __imm_insn(store_rel_hi, store_rel_hi),
+	  __imm_insn(load_acq_lo, load_acq_lo)
+	: __clobber_all);
+}
+#endif /* ARENA_ACQ_REL */
 #endif
 
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

