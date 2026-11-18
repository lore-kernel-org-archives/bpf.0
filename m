Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986116;
	b=MqOGdTMGXFbHsfued/H9yRgPeaa03TCejwXGKfuqW25Vb4W2hadxPJ2RlAxHYGFq9itd
	 NmGJIiHXMgSsPfKQpngAiMXzaFR3YVbovvZiKO1hHTr43SRVO3/jO/W19UZgeK30uBBKG
	 MaEAE7Wa+HWUhxKSgJhOpeQFG7b9+tkIFuO2/a419lLHBDAURtFQJ5jbY3gfSlkY7025T
	 G6dMtyu4NBixUEY0KtZfHJ8id9GQzO/eZAkd0OmjANZkA2EC04DBRaX+zc+nvp/1vwLlE
	 gYM+3NVfsjm1V2wPoTWs4V4/Zkk2Isk2tHWXZijXVbXPni6J3RSwdpiuwypILYx2BTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986116;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ji0XZgDQd7ghLSiQktNtImFvdtMgYQ130FYZVNbr8qM=;
	b=mPCfO9m+Gdi2PQU6JyiZTv1Eszou/7M3J5XoFrQ+1+YpFBoQBANkKyJ5a0Z3K6VE0AF9
	 LU6cgbTMj2POEnznGah+CF9a5Ru+vLM3M430JY+n14ENdz+Wi1hEMxqY0+xETlxnRDa8a
	 mMUr9WojsfX0UeOQxNdGdfTdEGPwpQMqcr4IReNbZjdBJVomCBlx96v6qYYj78Je8ZirN
	 rEnMUlgc/uzyIYAoV+B594s+fMtSSuSN8qQWMcNaTsBVkX1tFEYVdBAg/2JaOAcyhv4WF
	 /c1mJTjir/w4EpCwi//5MtZeHAkKJyUcpJhBEh7wsdqpc3s2fDkE1GRV5oZan3I6LtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PObKyjeD;
	arc=none smtp.remote-ip=91.218.175.201
Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B04606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 07:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PObKyjeD
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JTaKwGCI/m+yFoX0PfLwq4ulDMkGkwlRqIMjjylQBII=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794986113; v=1; x=1795590913;
 b=PObKyjeDQ4cKXAmLXsT3Vihx8BVQEfqFFkTArl8SzZL/36oQ2iV3+vtCB32QSsp05VWD4YTC
 Da6qpd6TE3M4w1FixtgcnaMP+vdzchAqth2OPJIMlaWEvAt9FekmhqQoPf3dQTUkJvMBvyPBwu4
 PZlKUC+9YyyB5c7FucvRAeVo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 85aeb9bfd93c480a;
	Wed, 18 Nov 2026 07:15:12 +0000
X-Mizu-Trace-ID: 85aeb9bfd93c480a
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
Date: Wed, 18 Nov 2026 16:14:44 +0900
Message-ID: <20261118071444.10258-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: George Guo <guodongtai@kylinos.cn>

When testing bpf selftests "jit_insns" and "jit_insns_blinded", the
"ldst_offsets" subtest fails for word and doubleword stores:

  $ sudo ./test_progs -t jit_insns/ldst_offsets | grep FAIL | head -1
  store_offsets:FAIL:stx size=0 base=r0 src=r1: byte at offset -16384

The JIT incorrectly treats the signed 14-bit immediate of stptr.w
and stptr.d as a byte offset. For offsets outside the signed 12-bit
range of st.w and st.d, it checks the byte offset with
is_signed_imm14() and encodes it unchanged. However, the hardware
scales the encoded immediate by 4 when calculating the memory
address. For example, a store at offset -4096 writes at offset -16384
instead, outside the memory range checked by the verifier.

Pass the offset in units of 4 bytes when emitting stptr.w and stptr.d
for both immediate and register stores. Use these instructions only
for offsets that are multiples of 4 in the range [-32768, 32764], and
keep the register-offset fallback for other offsets that do not fit
the signed 12-bit immediate of st.w or st.d.

Before:
  $ sudo ./test_progs -t jit_insns/ldst_offsets | tail -1
  Summary: 0/0 PASSED, 0 SKIPPED, 2/2 FAILED

After:
  $ sudo ./test_progs -t jit_insns/ldst_offsets | tail -1
  Summary: 2/2 PASSED, 0 SKIPPED, 0/0 FAILED

Cc: stable@vger.kernel.org
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
v2:
- Rename is_ptr_off() to is_aligned_signed_imm16() and drop its comment (Tiezhu)
- Remove the now unused is_signed_imm14() (Tiezhu)
- Reword the commit message
v1: https://lore.kernel.org/all/20261118030219.6230-1-dongtai.guo@linux.dev/

 arch/loongarch/net/bpf_jit.c | 16 ++++++++--------
 arch/loongarch/net/bpf_jit.h |  6 +++++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 15af1abb5cb6..906f34f420f1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1400,8 +1400,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, t1, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrw, t1, dst, off);
+			} else if (is_aligned_signed_imm16(off)) {
+				emit_insn(ctx, stptrw, t1, dst, off >> 2);
 			} else {
 				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxw, t1, dst, t2);
@@ -1411,8 +1411,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_imm(ctx, t1, imm);
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, t1, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrd, t1, dst, off);
+			} else if (is_aligned_signed_imm16(off)) {
+				emit_insn(ctx, stptrd, t1, dst, off >> 2);
 			} else {
 				move_imm(ctx, t2, off);
 				emit_insn(ctx, stxd, t1, dst, t2);
@@ -1460,8 +1460,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		case BPF_W:
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, stw, src, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrw, src, dst, off);
+			} else if (is_aligned_signed_imm16(off)) {
+				emit_insn(ctx, stptrw, src, dst, off >> 2);
 			} else {
 				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxw, src, dst, t1);
@@ -1470,8 +1470,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 		case BPF_DW:
 			if (is_signed_imm12(off)) {
 				emit_insn(ctx, std, src, dst, off);
-			} else if (is_signed_imm14(off)) {
-				emit_insn(ctx, stptrd, src, dst, off);
+			} else if (is_aligned_signed_imm16(off)) {
+				emit_insn(ctx, stptrd, src, dst, off >> 2);
 			} else {
 				move_imm(ctx, t1, off);
 				emit_insn(ctx, stxd, src, dst, t1);
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
index 2bd0dc5b911c..777c76112d95 100644
--- a/arch/loongarch/net/bpf_jit.h
+++ b/arch/loongarch/net/bpf_jit.h
@@ -45,13 +45,17 @@ do {										\
 } while (0)
 
 #define is_signed_imm12(val)	signed_imm_check(val, 12)
-#define is_signed_imm14(val)	signed_imm_check(val, 14)
 #define is_signed_imm16(val)	signed_imm_check(val, 16)
 #define is_signed_imm26(val)	signed_imm_check(val, 26)
 #define is_signed_imm32(val)	signed_imm_check(val, 32)
 #define is_signed_imm52(val)	signed_imm_check(val, 52)
 #define is_unsigned_imm12(val)	unsigned_imm_check(val, 12)
 
+static inline bool is_aligned_signed_imm16(int off)
+{
+	return !(off & 3) && is_signed_imm16(off);
+}
+
 static inline int bpf2la_offset(int bpf_insn, int off, const struct jit_ctx *ctx)
 {
 	/* BPF JMP offset is relative to the next instruction */

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.53.0

