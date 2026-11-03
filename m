Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729945;
	b=Co9Xf6GfuQorsL6TlXE72Gnb8mlj8LHQUQA2Sn6MX4H7tY4y6mrGwI09eFmMqfs87/du
	 FDPYWHbzupFyuP5deY2t30gtd7uTZe+RX5RKkb8c1H9POQTN8bABhjuzu4B7JDHt2DRQ2
	 GqFqaZVB5SbNKuhOF+ND1LkEYHX8e1JC0/bHWmpZBCkCzCR5r/Y7DLLS4j/sU4Bh9Essv
	 Ussx6vsJhBdzc47bK1K99ayLkZaIgyiuOd55dFCyTBWjyiG3meX4lKdwlqFaYsvpHk9SX
	 Tfh1nRDCxzzD0fjYglrAI+9KUCTYfEnHIBvB4jc0eGwQ/1CxFXQdcYChlEattT8oNLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729945;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YSZQ+J6hgmvwL5BqaWSRwkZd+znwwTgC7/Ng8tbBvhs=;
	b=5Ehy38vr/coHFjamlbFprfxPx35CjF0iwi/qEduLaqfktx6x93F/13xkOStw1glPo4Su
	 ZKllaV915EmKCwoyFrF6Biust9VuB/z65ooHdC9vPf6tKkKX9w6zF/PVo1YxXpPPFv7Ar
	 7FDkCYOZ1GX8d7YxMveFDEwYcRPfzjroGvzqCz6zM6FpR/Wch3xGW9YMbm+VN88qbl1ix
	 XqFxw/lQ2tbsgu+yFawKkM4zJwyyOgbc0+rEvlHp8EQ0KlmuXC7NVY0I9Wx50YbiBAw2J
	 apWqObtkPOmUZV3h3lUdejjBfr5oM0A9uF2vT0e5kvgr4NrTGHMmmYlRqD/6iIifjVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dANVKjEM;
	arc=none smtp.remote-ip=95.215.58.106
Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649D606A330
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5649D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dANVKjEM
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=krvGQ2lkyDUQgDl9voqOAGs1UxNMtj+awsIr1zVTZ9M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729942; v=1; x=1794334742;
 b=dANVKjEM6SWER1GYVVQFrdcnWLQHYSMnNFXXwR+nKCocmZkOfhPZexAX3qFggTYv9JaS2RUN
 jZQLCB9rStL4a9MZZPY36gjdNUOonYDeznk85anlf03TDIIe03ACPBoNSCJS4SJrjeN84TrqMCW
 9Wd2f2VVBT0iwFrHnqGt+K+M=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3e27892a11e1cc9f;
	Tue, 03 Nov 2026 18:19:02 +0000
X-Mizu-Trace-ID: 3e27892a11e1cc9f
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
Subject: [PATCH bpf-next v4 5/8] selftests/bpf: write the mixed arena/scalar ALU tests in asm
Date: Tue,  3 Nov 2026 10:18:13 -0800
Message-ID: <20261103181816.254686-6-vineet.gupta@linux.dev>
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

They fail to build with BPF_GCC:

  progs/verifier_arena.c:566:5: error: optimization may eliminate reads and/or writes to register variables [-Werror=volatile-register-var]

for

  volatile register __u64 reg asm("r3");

and GCC means it. With the warning silenced it drops both scalar
accesses, leaving nothing that uses r3 as a scalar:

  call	7
  if w0 == 0 goto .L136
  r9 = arena ll;r3 = 0;r3 = addr_space_cast(r3, 0, 1);
  .L136:
  r0 = 0
  exit

`reg = 1ULL << 32' and `reg += 1' are both gone. The tests need one
instruction reached with r3 live as a scalar on one path and as an
arena pointer on the other; what is left gives the verifier no reason
to reject anything, so the __failure expectation would not hold. A
local register variable is not guaranteed to survive a helper call
either, which GCC is also entitled to act on.

Nothing here needs a compiler to allocate registers, so write the
whole body in asm like mixed_arena_stack_atomic below, which tests the
same shape. Both compilers then emit the same sequence, with the
branch landing on the shared ALU op:

  call 7
  r6=r0
  r3=1
  r3<<=32
  if w6==0 goto 4          <- lands on r3+=1
  r9=0 ll
  r3=0
  r3 = addr_space_cast(r3, 0, 1)
  r3+=1                    <- scalar on one path, arena pointer on the other
  r0=0
  exit

And while here also bring in __load_if_JITed(). A program binding an
arena map is rejected in check_map_prog_compatibility() with "JIT is
required to use arena" during map resolution, before do_check() can
reach the shared instruction, so without a JIT these would fail on the
wrong message rather than skip.

Both tests become visible once 6/8 stops hiding them, and pass:

  verifier_arena/mixed_arena_scalar_alu64_scalar_first   -> OK
  verifier_arena/mixed_arena_scalar_alu64_arena_first    -> OK

Notes:
 - This does need an __arena capable BPF_GCC.
 - Under clang the rewrite is not a no-op: the existing version spilled r3
   to the stack and did the shared ALU op on r1 reloaded from it, so the
   test was not exercising one register live as both a scalar and an arena
   pointer.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3 -> v4: was 7/8, now ahead of the guard removal that stops hiding
these tests. Otherwise unchanged.

 .../selftests/bpf/progs/verifier_arena.c      | 91 +++++++++++--------
 1 file changed, 51 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 9b149c724160..146febd99523 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -561,53 +561,64 @@ int arena_ptr_add_arena_ptr(void *ctx)
 	return 0;
 }
 
+/*
+ * Tests that one insn cannot be reached with a register holding a scalar
+ * on one path and an arena pointer on the other.
+ */
 SEC("syscall")
 __failure __msg("same insn cannot be used with and without arena pointer")
-int mixed_arena_scalar_alu64_scalar_first(void *ctx)
-{
-	volatile register __u64 reg asm("r3");
-	__u32 pick_arena = bpf_get_prandom_u32();
-
-	reg = 1ULL << 32;
-
-	if (pick_arena) {
-		asm volatile (
-			"r9 = %[arena] ll;"
-			"%[reg] = 0;"
-			"%[reg] = addr_space_cast(%[reg], 0, 1);"
-			: [reg] "=r"(reg)
-			: __imm_addr(arena)
-			: "r9"
-		);
-	}
-
-	reg += 1;
-
-	return 0;
+__load_if_JITed()
+__naked void mixed_arena_scalar_alu64_scalar_first(void)
+{
+	/*
+	 * The r9 load is never read.  libbpf binds the object's arena to
+	 * every program through fd_array, so the verifier knows about it
+	 * without this; the load is the fallback for a kernel without
+	 * fd_array_cnt and for the light skeleton loader.
+	 */
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r3 = 1;						\
+	r3 <<= 32;					\
+	if w6 == 0 goto 1f;				\
+	r9 = %[arena] ll;				\
+	r3 = 0;						\
+	r3 = addr_space_cast(r3, 0, 1);			\
+1:	r3 += 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
 }
 
+/*
+ * As mixed_arena_scalar_alu64_scalar_first(), including the r9 load, with
+ * the arena pointer established first.
+ */
 SEC("syscall")
 __failure __msg("same insn cannot be used with and without arena pointer")
-int mixed_arena_scalar_alu64_arena_first(void *ctx)
+__load_if_JITed()
+__naked void mixed_arena_scalar_alu64_arena_first(void)
 {
-	volatile register __u64 reg asm("r3");
-	__u32 pick_scalar = bpf_get_prandom_u32();
-
-	asm volatile (
-		"r9 = %[arena] ll;"
-		"%[reg] = 0;"
-		"%[reg] = addr_space_cast(%[reg], 0, 1);"
-		: [reg] "=r"(reg)
-		: __imm_addr(arena)
-		: "r9"
-	);
-
-	if (pick_scalar)
-		reg = 1ULL << 32;
-
-	reg += 1;
-
-	return 0;
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r9 = %[arena] ll;				\
+	r3 = 0;						\
+	r3 = addr_space_cast(r3, 0, 1);			\
+	if w6 == 0 goto 1f;				\
+	r3 = 1;						\
+	r3 <<= 32;					\
+1:	r3 += 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
 }
 
 SEC("syscall")
-- 
2.53.0-Meta

