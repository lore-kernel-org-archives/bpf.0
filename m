Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125493;
	b=ZyybU651bjdQkKyOS0TCc8yHumjZpzBF4u9npAMSizrdITpNudmOyy6YU5RAXgs4wzCz
	 8GLtM7ekvt21OJRIbKKAHeFgm/3OY6Nnrio5Cjm+VsRwsQCd/zz3hwanai5Ij/aiW3X4e
	 TOv9rSwjUIzQyb5KiLMXKHGoWXB/+cdB9AD1mdirIS5S1f2WvcuKQCpuzBZsitmPbAiZP
	 59Xkyik4ODceR2kFup4yhhL/aO6Iy9CqqeY+xK79V/rWV05Lsrolc/yCNTjR/TIX5vuCC
	 5JuBFYZBzP1C0fW7mGRDKFGCadD/XWoAIaR8B8bFWKQUStURG1HvS8HS858mNNT9Piw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=0rr9hDxKroVUMK/NU8D0faEJVJCUtx/8yVn3K+Qe/+k=;
	b=bJqIg309mWp03i47GKhvMvVxyIpYMrS37Yc9QDyFhUqtuJIHPAUIkyb+kInhcJyCNCp2
	 KUzOYB/Ojjv/BaIQ7LZ4Q100iebTw36RPkthBBWIJi/i1Dh+rmgAZZo4gy64BI9yMnycx
	 i+JsHB9jp4bNrdFHLM6GLIzh0MzhnM20r4zF5BAsqToxMhUoYkrFfHMv9HZ6sDgNzcfKv
	 F2Dc78zz89Acdhfyj+ZSHrhvciNdReV4R8Iz2GsiMN6+gxaxbbaIDYIC7FyzW5rerOXS6
	 0dCy6ThuXocEr0vKsGJyez1ICg/94A7kQQooveAcONasLBbk+KkO6euhpK8GwtcRHqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hevESGmY;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C073606A32A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C073606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hevESGmY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0rr9hDxKroVUMK/NU8D0faEJVJCUtx/8yVn3K+Qe/+k=; b=hevESGmYgnljV/llF5wojMuIVE
	THyVl2TCI3svkkE8UWoUlpsiuzVR56mKVlcWsp8LHQo6b6Ojk0ZahEQDFRfxOVFjaABu+0EttNpPw
	RdGR+ISFER+zrV11gUjX7XdFbT3QaULE/cSXVs2fP67JYp6y26oi9YESqV3IoQi35Lxg8WA9vuEi5
	bHm41wG+DzTeAFi0WYcId7VZ1eDERXnOssZ4HEeYltAgDCvfU5uGLJd2YLL3Um0eXN7k1gJOoExic
	Wn63m+2JedB4BwbMI6DPNP26Abo+QWn0XD/84HHqdp69bFyDso3qqQZASePGeZ04oFcaE4100UB/P
	LxhcAGhQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqt-000Il8-2g;
	Tue, 27 Oct 2026 19:24:51 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 09/21] bpf, arm64: Use the unscaled forms for negative and unaligned offsets
Date: Tue, 27 Oct 2026 19:24:33 +0100
Message-ID: <20261027182445.1156335-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

A load or store with a negative offset, or with one that is not a multiple
of the access size, does not fit the scaled unsigned 12-bit immediate form
and was emitted as a mov of the offset into a temporary followed by the
register offset form. LDUR and STUR take a signed 9-bit byte offset, so
use them for the offsets from -256 to 255 the other form cannot encode,
which saves the mov. The unscaled forms have the same latency and issue
on the same pipelines as the scaled ones on Neoverse N1 through V3. LLVM
emits such offsets for every 32-bit and wider header field behind the
14-byte Ethernet header of a packet parser, and negative ones for the
container of a list or rbtree node.

Before/after for r0 = *(u32 *)(r1 + 26) and r0 = *(u64 *)(r1 - 16):

  d280034a  mov x10, #0x1a
  b86a6808  ldr w8, [x0, x10]
  b841a008  ldur w8, [x0, #26]

  928001ea  mov x10, #0xfffffffffffffff0
  f86a6808  ldr x8, [x0, x10]
  f85f0008  ldur x8, [x0, #-16]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 53 +++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 4dc465772937..b57420391282 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -346,6 +346,12 @@ static bool is_lsi_offset(int offset, int scale)
 	return true;
 }
 
+/* The unscaled forms take a signed 9-bit byte offset instead */
+static bool is_lsu_offset(int offset)
+{
+	return offset >= -SZ_256 && offset < SZ_256;
+}
+
 /* The A64 size of a BPF load or store, and the scale of its offset */
 static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
 {
@@ -365,18 +371,36 @@ static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
 	}
 }
 
-/* The A64 type of a BPF load or store, in the immediate or register offset form */
-static enum aarch64_insn_ldst_type a64_ldst_type(const u8 code, bool reg_offset)
-{
+/* The forms of a load or store: scaled unsigned immediate, unscaled, register offset */
+enum a64_ldst_form { A64_LDST_IMM, A64_LDST_UNSCALED, A64_LDST_REG };
+
+/* The A64 type of a BPF load or store in the given form */
+static enum aarch64_insn_ldst_type a64_ldst_type(const u8 code, enum a64_ldst_form form)
+{
+	static const enum aarch64_insn_ldst_type types[][3] = {
+		[A64_LDST_IMM] = {
+			AARCH64_INSN_LDST_LOAD_IMM_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
+			AARCH64_INSN_LDST_STORE_IMM_OFFSET,
+		},
+		[A64_LDST_UNSCALED] = {
+			AARCH64_INSN_LDST_LOAD_UNSCALED_IMM_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_UNSCALED_IMM_OFFSET,
+			AARCH64_INSN_LDST_STORE_UNSCALED_IMM_OFFSET,
+		},
+		[A64_LDST_REG] = {
+			AARCH64_INSN_LDST_LOAD_REG_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET,
+			AARCH64_INSN_LDST_STORE_REG_OFFSET,
+		},
+	};
+
 	if (BPF_CLASS(code) != BPF_LDX)
-		return reg_offset ? AARCH64_INSN_LDST_STORE_REG_OFFSET :
-				    AARCH64_INSN_LDST_STORE_IMM_OFFSET;
+		return types[form][2];
 	if (BPF_MODE(code) == BPF_MEMSX || BPF_MODE(code) == BPF_PROBE_MEMSX ||
 	    BPF_MODE(code) == BPF_PROBE_MEM32SX)
-		return reg_offset ? AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET :
-				    AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET;
-	return reg_offset ? AARCH64_INSN_LDST_LOAD_REG_OFFSET :
-			    AARCH64_INSN_LDST_LOAD_IMM_OFFSET;
+		return types[form][1];
+	return types[form][0];
 }
 
 /*
@@ -389,6 +413,7 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 		      const u8 tmp, struct jit_ctx *ctx)
 {
 	enum aarch64_insn_size_type size;
+	enum aarch64_insn_ldst_type type;
 	s32 off_adj = off;
 	u8 rn_adj = rn;
 	int scale;
@@ -405,12 +430,16 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 	}
 
 	if (is_lsi_offset(off_adj, scale)) {
-		emit(aarch64_insn_gen_load_store_imm(rt, rn_adj, off_adj, size,
-						     a64_ldst_type(code, false)), ctx);
+		type = a64_ldst_type(code, A64_LDST_IMM);
+		emit(aarch64_insn_gen_load_store_imm(rt, rn_adj, off_adj, size, type), ctx);
+	} else if (is_lsu_offset(off_adj)) {
+		type = a64_ldst_type(code, A64_LDST_UNSCALED);
+		emit(aarch64_insn_gen_load_store_unscaled(rt, rn_adj, off_adj, size, type), ctx);
 	} else {
+		type = a64_ldst_type(code, A64_LDST_REG);
 		emit_a64_mov_i(1, tmp, off, ctx);
 		emit(aarch64_insn_gen_load_store_reg(rt, rn, tmp, AARCH64_INSN_EXTEND_UXTX,
-						     size, a64_ldst_type(code, true)), ctx);
+						     size, type), ctx);
 	}
 }
 
-- 
2.43.0

