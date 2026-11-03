Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=HQjWokHWVVTWao1d0B5Kwa0FjGmEFgYZYSHmau7RrzjE74X0l+azhRj50T0qIG0FhATk
	 oD+1rGhYwVNprly0Jr/j7hQpgViTM09ZsfJyIrXP6ZguU/wlXSxUzrJ4x2nhPQmaiy/ut
	 zLEp09xrGff2AjNSdc0TRhy4OoueT1TvDVnRDSqvFVoovi8rIUVVB/fUU1rF4aOW4zsSO
	 SoskFq/VKLm/YAvRfzqKtZvT+sXHgACeNO7OweNV4SpQ3h7Wum/28ByP0v39Pz2aZbIxB
	 gWGSNzSIRTJLh6LWRcD3D05EleG6MjuPI/i/zGUMvgLN11CfWkv2a/U3JDHB6F/+A2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=IRbwfF2XQCMohZHo6ahikel/LgqEWvd7ZDMwhUkVhaY=;
	b=QFl7Ay/rSB8cMaUd3Y2M9xmON1qPxi8zHXFiFSKDH8G6uo1xnhkSiuT63I7WxfabU05s
	 PacjrXwxM5nLhCVmK9lO4UW5SZvv2QQnNKULILSPlsnLN6+BY+JTagyCdKBVQTQ0m4axn
	 v10eBkCWdD/hx+SHNEurR3xm9SLIPMahHGXaZ6RXlBCbtC5heOI/Zx1rDUgKYttrG9vqJ
	 Jo0kOjwXrMgsUVtPsQVnum8f01vE0dA9V89kdvbYFfaGw8SnPdzIKg59CIln0IXJHamcY
	 tKA/8TYYoKO3YIA9W+4/+KKaMbh4kDOeFcSCdQq0A9XqfIAYrDBNtDiP+HkWIpCWujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=qzwEDbf2;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD606D810
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334AD606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=qzwEDbf2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=IRbwfF2XQCMohZHo6ahikel/LgqEWvd7ZDMwhUkVhaY=; b=qzwEDbf2sR3dufoeCFoxV+mjvR
	9rUCyYludGl4+clRSDmdMQMC3vG6iCcUa577Iwjx56BFVUPMFlhXivYh29rZcSSBA6n3F26pkXE7I
	coYV6TlU7ZNUbaKSZMCERBZZVL0OpZ8LDnfVK496fDQXSCom2F6zRIifZqZ+1INF1d/yyGdstHsi4
	yFOT0/DtqKors7gTKeFmeuzSc610uUBiN2mBNLIFQTSdnQmKNm1+S11obZwsUf8LJnI2z13jg1dDb
	hHHaMHREY9XshYURAaNM8CYvabndLG31DBPcdz0DqM352aXXGnq0VE0g6m39PT0hTvO8JdhsE08yF
	M9IvsMLw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc4-000MRJ-0N;
	Tue, 03 Nov 2026 13:27:40 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 09/20] bpf, arm64: Use the unscaled forms for negative and unaligned offsets
Date: Tue,  3 Nov 2026 13:27:22 +0100
Message-ID: <20261103122733.1383002-10-daniel@iogearbox.net>
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
index 41e2d1aef71f..2a9bbd600bc0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -357,6 +357,12 @@ static bool is_lsi_offset(int offset, int scale)
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
@@ -376,18 +382,36 @@ static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
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
@@ -400,6 +424,7 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 		      const u8 tmp, struct jit_ctx *ctx)
 {
 	enum aarch64_insn_size_type size;
+	enum aarch64_insn_ldst_type type;
 	s32 off_adj = off;
 	u8 rn_adj = rn;
 	int scale;
@@ -416,12 +441,16 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
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
-						     false, size, a64_ldst_type(code, true)), ctx);
+						     false, size, type), ctx);
 	}
 }
 
-- 
2.43.0

