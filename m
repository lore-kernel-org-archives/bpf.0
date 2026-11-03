Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=GukBlFloIR9ae//MjlzDFUatrUV/veUX/LzNRfIQWHrwXj/lC5u+Bmei3ka03cGs/b+/
	 7HP2KkRIY5WZADBKbHKtf/D8n4vF4Kd06ley/Kv1ht9G6iBGShTctopiiTnve1Iuojh9v
	 SuOcmJFXG1rNvUKyrNhtONl3SsvGbkuUJw1Kb7Bku5MFHg5DUAcfcG9FN0WlNxSdMcviR
	 vAoEeXYouV1tczxoZ+2PGnCiko1o3T5La4wzN5C+oQ9pYWzZ+8mRjPFPHF+1hEe4fWUVk
	 HQEYDo6vHig/RnkF5x9G7voxa3pUK5iTbT6ZS89ysVHlnjJfCyU8cNIa5Xjrmj2Rqww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=806nXd/wJqen30C13BT37cS1QU6i7e4LQHn+0vyYn8g=;
	b=jFNDGv9P69JC0Nc058ZV/dx98+7p3mbSiJ3sDz8+axrFgqgNY2Vfug4NN5vA6EbA3/Up
	 jdA7ySFpR/sNLHcxw5H7xoLBAaWsUNo2iVNiVpWNeSYDihlJ55kR7EuJMyNLiCY0P88H/
	 1q1YToHRoQ85G/WKbI80kw3TKTwPwmRPwz4E69jr+WSK5L1tzr7DEfvSZSoAXTBWaAcm1
	 3Ip8UpPU10zYg09U6S94pZxoh/4+jnQEYXBkFg4gA+ER2G+R2l/u2eccDXDkbnJUBnTc4
	 I5a6P2kWMNoVJ0Glk9FXGBU6Wk9inCNYG7s3LUqRwy32N+A1UxvHvTVm07cOBKzjgGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=gghxp+I6;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60988606A327
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60988606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=gghxp+I6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=806nXd/wJqen30C13BT37cS1QU6i7e4LQHn+0vyYn8g=; b=gghxp+I63B1qUjLkNDDxcMabbh
	VJL2xasvRtfLdgmooH/V2RW4CtV54CG67P3F61OKf53TvSEcElXGs2i7go+K+xSBzXIuAtPABIl2X
	WNpp2OnbWBty7M0MXzpKU/BrW5TQUDBciYKhlrOT59VGMIfIz8KPhgEsgWToo3T0+soHfdTk9Ji0W
	dz1Mzd5+RHNbrbCFTzKD5IL6nMk/ZPbbZ/FEJZ430nKWjV1ndJXG3K0PwajMQ5Doles4tSPnEyh+G
	6z8pwzA86bTgbfAylGCZDnjJF28SUMEtPELUnMQ2ayN//m90WyP9uhbA9eHKN15zqGGK0Q2zhm5XT
	jG65a9pw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc1-000MQT-1J;
	Tue, 03 Nov 2026 13:27:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 04/20] arm64, insn: Reject sign extending loads of 64 bits
Date: Tue,  3 Nov 2026 13:27:17 +0100
Message-ID: <20261103122733.1383002-5-daniel@iogearbox.net>
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

The sign extending loads exist for bytes, halfwords and words. With the
size of a doubleword, the opc of LDRSB, LDRSH and LDRSW encodes PRFM,
so aarch64_insn_gen_load_store_imm() and
aarch64_insn_gen_load_store_reg() returned a prefetch, which leaves the
destination register as it was, instead of failing. The BPF JIT, their
only user, does not ask for one, as BPF_MEMSX has no BPF_DW form and the
verifier rejects the opcode, but return AARCH64_BREAK_FAULT for it as
for the other invalid operands.

Before/after for a sign extending load of 64 bits from x1 + 8 into x0:

  f9800420  prfm pldl1keep, [x1, #8]
  d4202000  brk #0x100

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/lib/insn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index dc483d1b8bd5..48a481aa9656 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -389,6 +389,12 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		insn = aarch64_insn_get_ldr_reg_value();
 		break;
 	case AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET:
+		/* With the size of 64 bits this encodes PRFM */
+		if (size == AARCH64_INSN_SIZE_64) {
+			pr_err("%s: invalid size for a signed load %d\n",
+			       __func__, size);
+			return AARCH64_BREAK_FAULT;
+		}
 		insn = aarch64_insn_get_signed_ldr_reg_value();
 		break;
 	case AARCH64_INSN_LDST_STORE_REG_OFFSET:
@@ -437,6 +443,12 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 		insn = aarch64_insn_get_ldr_imm_value();
 		break;
 	case AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET:
+		/* With the size of 64 bits this encodes PRFM */
+		if (size == AARCH64_INSN_SIZE_64) {
+			pr_err("%s: invalid size for a signed load %d\n",
+			       __func__, size);
+			return AARCH64_BREAK_FAULT;
+		}
 		insn = aarch64_insn_get_signed_load_imm_value();
 		break;
 	case AARCH64_INSN_LDST_STORE_IMM_OFFSET:
-- 
2.43.0

