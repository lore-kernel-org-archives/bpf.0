Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729936;
	b=xzDxWb4Otciirv0MAoFOKAsD7eI+5tSz2JSdoFf1e9FvNTLpY4kkCazAZTcfw1dmFE6L
	 S59pTh9281v+NuAkOuVEFMhHuDOZuCrn/IAjQbw2XHLRmHA5GNyI6l+RMyeayknaNGXfb
	 VhALcinN+j+cRT/lh5o3lpny1IjOzNnCKSNznS7YM39GhEofpPUgTmx3vnQI/NXB8NZB1
	 NeW2Cg4oP2Dek0e9Q/BMbsl8kSOszBUSMXq1+GB93k63O8BcyneRm324DikYvDM7MMGpw
	 /45CTokMLU8rj9stOh8QN6csPFl+3hHRBbBgewx5YosApzoim9e8YD5zSKtIGLRgp+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729936;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GGaE1qmOX0XSLLPtwH4YObFVEwZzLL39kmhyeWNe6tU=;
	b=Tg84H1pU/5SO60fK1oCQzM4ZwHIMcEIofwXqR1EBtMiuUjhEBFAboh/dKyDRh3tWLsQX
	 gyUbg2qdIAUvGF3bssxVXpmUI/ig9HUzaY/Y7HjP8ajupSUi5bW9LPIRhW/dqlK+kD5uy
	 +9h25syF7qU5p6g02/JqM+S5dESIW/UCMP58o5In00cNjVbD3NMDFcQkG6FPQvxrlN+7V
	 R0TjpQP0OH0J/9A7F/YslilmjoJbhYBo6PrbfC/mbQ/ArLN0NUXCVBsoqGYjhcTeb6doJ
	 NJffTBf+ZhK2n89dxsFdAoM5p8deRxfxmCkrND6yV+R6jDkvlz0GOy16fzRA1Amce6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DUTY7QV9;
	arc=none smtp.remote-ip=91.218.175.177
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D2606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E2D2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DUTY7QV9
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zo09GNgf0pXdePnCPl0ruATW0SNC4vI/eJ/Ulc7x7co=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729933; v=1; x=1794334733;
 b=DUTY7QV9uJCHDJsgbbrKR+pVZg+nvXlGU4ddwPMDuSGflhzj99u7RfEIDF0cekt2cOcaLNeW
 ygoVD1QG9DGisjvRHmCpSrNwGym9t2ZfISCB8CgORjfBzc0v5+1tslnDinBc7ecVQzVgSYcdJQI
 g+mqZjYBcQQpC4sI8P6gZNyc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36c57bbdd4ee3765;
	Tue, 03 Nov 2026 18:18:53 +0000
X-Mizu-Trace-ID: 36c57bbdd4ee3765
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v4 4/8] selftests/bpf: spell the addr_space_cast address spaces in decimal
Date: Tue,  3 Nov 2026 10:18:12 -0800
Message-ID: <20261103181816.254686-5-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103181816.254686-1-vineet.gupta@linux.dev>
References: <20261103181816.254686-1-vineet.gupta@linux.dev>
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

The inline asm in the arena tests writes the two address spaces of
addr_space_cast() in hex which trips up a GNU assembler bug:

  progs/jit_insns_arena.c:49: Error: unrecognized instruction `r7 =addr_space_cast(r7,0x0,0x1)'
  progs/jit_insns_arena.c:49: Error: expected ',', got 'x'

This has been fixed and landed binutils commit 835aee81fa93 ("bpf: accept
any spelling of the addr_space_cast address spaces"), but will only land
in the 2.47 release, so add the workarounds for now.
A GCC that defines __BPF_FEATURE_ADDR_SPACE_CAST would be paired with
a capable binutils.

No functional change.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3 -> v4: new patch.

 .../selftests/bpf/progs/arena_atomics.c       | 32 +++++++++----------
 .../selftests/bpf/progs/jit_insns_arena.c     |  8 ++---
 .../selftests/bpf/progs/verifier_arena.c      | 16 +++++-----
 .../selftests/bpf/progs/verifier_hmul_arena.c |  4 +--
 .../selftests/bpf/progs/verifier_ldsx.c       | 10 +++---
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/testing/selftests/bpf/progs/arena_atomics.c
index ce76a73d197b..2a9664f54399 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -227,11 +227,11 @@ int fetch_r0(const void *ctx)
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	asm volatile (
 	"r1 = %[fetch_src_r0_value] ll;"
-	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r1 = addr_space_cast(r1, 0, 1);"
 	"r0 = 0x1100000011 ll;"
 	".8byte %[fetch_src_r0_insn];"
 	"r2 = %[fetch_src_r0_result] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r0;"
 	:
 	: __imm_addr(fetch_src_r0_value),
@@ -242,16 +242,16 @@ int fetch_r0(const void *ctx)
 
 	asm volatile (
 	"r0 = %[fetch_dst_r0_value] ll;"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 0x1100000011 ll;"
 	".8byte %[fetch_dst_r0_insn];"
 	"r2 = %[fetch_dst_r0_result] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r1;"
 	/* r0 is only read by the atomic, so it must still be the pointer. */
 	"r3 = *(u64 *)(r0 + 0);"
 	"r2 = %[fetch_dst_r0_readback] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r3;"
 	:
 	: __imm_addr(fetch_dst_r0_value),
@@ -363,17 +363,17 @@ int uaf(const void *ctx)
 	asm volatile (
 	"r0 = %[page];"
 	"r0 += 4096;"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 1;"
 	"r2 = %[uaf_r0_before_dst_r0] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r0;"
 	".8byte %[fetch_dst_r0];"
 	"r2 = %[uaf_r0_after_dst_r0] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r0;"
 	"r2 = %[uaf_r1_after_dst_r0] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r1;"
 	: : [page]"r"(page64),
 	    __imm_insn(fetch_dst_r0,
@@ -387,11 +387,11 @@ int uaf(const void *ctx)
 	asm volatile (
 	"r1 = %[page];"
 	"r1 += 4096;"
-	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r1 = addr_space_cast(r1, 0, 1);"
 	"r0 = 1;"
 	".8byte %[fetch_src_r0];"
 	"r2 = %[uaf_r0_after_src_r0] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r0;"
 	: : [page]"r"(page64),
 	    __imm_insn(fetch_src_r0,
@@ -409,10 +409,10 @@ int uaf(const void *ctx)
 	asm volatile (
 	"r1 = %[page];"
 	"r1 += 4096;"
-	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r1 = addr_space_cast(r1, 0, 1);"
 	"r3 = *(u64 *)(r1 + 0);"
 	"r2 = %[uaf_reread] ll;"
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"
+	"r2 = addr_space_cast(r2, 0, 1);"
 	"*(u64 *)(r2 + 0) = r3;"
 	: : [page]"r"(page64),
 	    __imm_addr(uaf_reread)
@@ -460,10 +460,10 @@ int load_acquire(const void *ctx)
 #define LOAD_ACQUIRE_ARENA(SIZEOP, SIZE, SRC, DST)	\
 	{ asm volatile (				\
 	"r1 = %[" #SRC "] ll;"				\
-	"r1 = addr_space_cast(r1, 0x0, 0x1);"		\
+	"r1 = addr_space_cast(r1, 0, 1);"		\
 	".8byte %[load_acquire_insn];"			\
 	"r3 = %[" #DST "] ll;"				\
-	"r3 = addr_space_cast(r3, 0x0, 0x1);"		\
+	"r3 = addr_space_cast(r3, 0, 1);"		\
 	"*(" #SIZE " *)(r3 + 0) = r2;"			\
 	:						\
 	: __imm_addr(SRC),				\
@@ -515,7 +515,7 @@ int store_release(const void *ctx)
 	{ asm volatile (			\
 	"r1 = " VAL ";"				\
 	"r2 = %[" #DST "] ll;"			\
-	"r2 = addr_space_cast(r2, 0x0, 0x1);"	\
+	"r2 = addr_space_cast(r2, 0, 1);"	\
 	".8byte %[store_release_insn];"		\
 	:					\
 	: __imm_addr(DST),			\
diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index 95736eae2a58..997a897d66eb 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -47,7 +47,7 @@ int arena_zero_off(void *ctx)
 	/* Accesses through two base registers */
 	asm volatile ("					\
 	r7 = %[res];					\
-	r7 = addr_space_cast(r7, 0x0, 0x1);		\
+	r7 = addr_space_cast(r7, 0, 1);		\
 	r1 = r7;					\
 	r8 = 0x1122334455667788 ll;			\
 	*(u64 *)(r7 + 0) = r8;				\
@@ -93,12 +93,12 @@ int cast_to_user(void *ctx)
 	/* The user address comes back from the kernel one, NULL stays NULL */
 	asm volatile ("					\
 	r7 = %[page];					\
-	r1 = addr_space_cast(r7, 0x0, 0x1);		\
-	r1 = addr_space_cast(r1, 0x1, 0x0);		\
+	r1 = addr_space_cast(r7, 0, 1);		\
+	r1 = addr_space_cast(r1, 1, 0);		\
 	r9 = r1;					\
 	r9 ^= r7;					\
 	r2 = 0;						\
-	r2 = addr_space_cast(r2, 0x1, 0x0);		\
+	r2 = addr_space_cast(r2, 1, 0);		\
 	r9 |= r2;					\
 	%[res] = r9;					\
 "	: [res]"=r"(res)
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index b17a6dfc100d..9b149c724160 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -524,7 +524,7 @@ int scalar_add_arena_ptr(void *ctx)
 
 	asm volatile (
 		"%[arena_ptr] = 8192;"
-		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0, 1);"
 		"%[scalar] = 12;"
 		"%[scalar] += %[arena_ptr];"
 		: [scalar] "=r"(scalar),
@@ -549,9 +549,9 @@ int arena_ptr_add_arena_ptr(void *ctx)
 
 	asm volatile (
 		"%[arena_ptr1] = 8192;"
-		"%[arena_ptr1] = addr_space_cast(%[arena_ptr1], 0x0, 0x1);"
+		"%[arena_ptr1] = addr_space_cast(%[arena_ptr1], 0, 1);"
 		"%[arena_ptr2] = 4096;"
-		"%[arena_ptr2] = addr_space_cast(%[arena_ptr2], 0x0, 0x1);"
+		"%[arena_ptr2] = addr_space_cast(%[arena_ptr2], 0, 1);"
 		"%[arena_ptr2] += %[arena_ptr1];"
 		: [arena_ptr2] "=r"(arena_ptr2),
 		  [arena_ptr1] "=&r"(arena_ptr1)
@@ -574,7 +574,7 @@ int mixed_arena_scalar_alu64_scalar_first(void *ctx)
 		asm volatile (
 			"r9 = %[arena] ll;"
 			"%[reg] = 0;"
-			"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+			"%[reg] = addr_space_cast(%[reg], 0, 1);"
 			: [reg] "=r"(reg)
 			: __imm_addr(arena)
 			: "r9"
@@ -596,7 +596,7 @@ int mixed_arena_scalar_alu64_arena_first(void *ctx)
 	asm volatile (
 		"r9 = %[arena] ll;"
 		"%[reg] = 0;"
-		"%[reg] = addr_space_cast(%[reg], 0x0, 0x1);"
+		"%[reg] = addr_space_cast(%[reg], 0, 1);"
 		: [reg] "=r"(reg)
 		: __imm_addr(arena)
 		: "r9"
@@ -635,7 +635,7 @@ int scalar_xor_arena_ptr(void *ctx)
 
 	asm volatile (
 		"%[arena_ptr] = 8192;"
-		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0, 1);"
 		"%[scalar] = 12;"
 		"%[scalar] ^= %[arena_ptr];"
 		: [scalar] "=r"(scalar),
@@ -660,7 +660,7 @@ int arena_ptr_add_to_non_arena_ptr(void *ctx)
 
 	asm volatile (
 		"%[arena_ptr] = 8192;"
-		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0, 1);"
 		"%[dst] = %[ctx];"
 		"%[dst] += %[arena_ptr];"
 		: [arena_ptr] "=&r"(arena_ptr),
@@ -685,7 +685,7 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
 
 	asm volatile (
 		"%[arena_ptr] = 8192;"
-		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0, 1);"
 		"%[src] = %[ctx];"
 		"%[arena_ptr] += %[src];"
 		: [arena_ptr] "=&r"(arena_ptr),
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
index a8709ec447aa..b94892fff2f8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
@@ -29,7 +29,7 @@ __naked void uhmul64_arena_ptr(void)
 	asm volatile (
 	"r1 = %[arena] ll;"
 	"r0 = 1;"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	".8byte %[hmul];"
 	"exit;"
 	:
@@ -48,7 +48,7 @@ __naked void shmul64_arena_ptr(void)
 	asm volatile (
 	"r1 = %[arena] ll;"
 	"r1 = 1;"
-	"r1 = addr_space_cast(r1, 0x0, 0x1);"
+	"r1 = addr_space_cast(r1, 0, 1);"
 	"r0 = 2;"
 	".8byte %[hmul];"
 	"exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 49e8cd4bb4f9..45b2e52fd715 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -310,7 +310,7 @@ __naked void arena_ldsx_disasm(void *ctx)
 	"r4 = %[numa_no_node];"
 	"r5 = 0;"
 	"call %[bpf_arena_alloc_pages];"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = r0;"
 	"r8 = *(s32 *)(r0 + 16);"
 	"r8 = *(s16 *)(r0 + 24);"
@@ -338,7 +338,7 @@ __naked void arena_ldsx_exception(void *ctx)
 	asm volatile (
 	"r1 = %[arena] ll;"
 	"r0 = 0xdeadbeef;"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 0x3fe;"
 	"*(u64 *)(r0 + 0) = r1;"
 	"r0 = *(s8 *)(r0 + 0);"
@@ -364,7 +364,7 @@ __naked void arena_ldsx_s8(void *ctx)
 	"r4 = %[numa_no_node];"
 	"r5 = 0;"
 	"call %[bpf_arena_alloc_pages];"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 0x3fe;"
 	"*(u64 *)(r0 + 0) = r1;"
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
@@ -396,7 +396,7 @@ __naked void arena_ldsx_s16(void *ctx)
 	"r4 = %[numa_no_node];"
 	"r5 = 0;"
 	"call %[bpf_arena_alloc_pages];"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 0x3fffe;"
 	"*(u64 *)(r0 + 0) = r1;"
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
@@ -428,7 +428,7 @@ __naked void arena_ldsx_s32(void *ctx)
 	"r4 = %[numa_no_node];"
 	"r5 = 0;"
 	"call %[bpf_arena_alloc_pages];"
-	"r0 = addr_space_cast(r0, 0x0, 0x1);"
+	"r0 = addr_space_cast(r0, 0, 1);"
 	"r1 = 0xfffffffe;"
 	"*(u64 *)(r0 + 0) = r1;"
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-- 
2.53.0-Meta

