Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166044;
	b=QzKv2HkBedy7NBFYQHOfnipEZoekTdt4P1nVKVQtngrVXDRz2I2L0GGsTRYY/nWJpet+
	 Hix25WMW3uvDOvSOM1xIpFCrXE2/TIHBe2UU168e+6xouVKd7mmVcfHWj+8gdEl+oMP/a
	 1Ro9gWacMubyz+PFoIjqMHdCtl4PJc4IRbcz0jRP5LPiNtmaBFY82kEi2vO5YmcupqOex
	 BSP/c1Mkwz23PMojtKvgFtk2GZuFKw1JRXLkNKYhJExb+93hrS5ywvPbgoqq7xeO/AI2c
	 ec+7Hp37rdChxsRbJRL/ZUQlkpQSMT4+laSjp/GBZoMSZe7PYQhXiFh+ul+ELEsAXzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166044;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=6OLkz6il/59o/6C9lXwuQrRhIF+33c0EWzY6IaM0qZU=;
	b=jJhOJXcYIN+uzMP6fOlyLcQ88OFk5E/AS9NywdLDq5jYOJ3gusu7TXTkLczlKCxuEcnq
	 beKqX52FEGif3URSETSJp26nrgAPJAEuwhQ+XV2MEasFgKmjpXkO23e4xBz1vY+yO74lM
	 eIeIefVY7jSE6IfkSX57PTmK+zsxf9M+ULRyFOZ0dY6jBFI1v8m+iydXPp55TzvT6dEv3
	 iN+UqJ6Kz5sN4nC1wLga9gvhv1lXpL9xkz64Ge9/cAWl8G9sbDAgXQmH/cX9qGoaqDPal
	 FX2YYFCWAXIFFdTCasA5awk0FNhglQ2VZmM9ghWjzIU230LcttkJGpSUzHRbWkL+Kig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=IWGfvvMv;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F5606A320
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=IWGfvvMv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6OLkz6il/59o/6C9lXwuQrRhIF+33c0EWzY6IaM0qZU=; b=IWGfvvMvbo/HZOcOMlzK8hhW+3
	y4vgc8vty3rmtIFCG4qB0Oh1Qj8N8tHSusWj9RoWyTMpPSWvSBBl5bt4fB2JeqeVgTbRAGLV/3Hy3
	07zs9728UejDXtbMBny2c6cNh+Cm3unldlLqTjftP3KrzVSdyBVviO6T27KEBJUfzW7M2PiW2BNLt
	0wn4b+qofsfhjrWiswylEzkFl7Oid59XC26pwOXnwogTPlDeFM3LMI2Kg14gnpwV03brytMLgFXkh
	hzyaq5iB3k5KbZVsnM8fR8be/TeAN/FA8zATevGF4td47/jkEmC9vtzyUS2R/Uuj6twrdY9GqEseu
	z8byFuJw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Xx-000Phy-35;
	Sun, 08 Nov 2026 20:27:22 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 05/24] arm64, insn: Reject sign extending loads of 64 bits
Date: Sun,  8 Nov 2026 20:26:31 +0100
Message-ID: <c3b4128577d93ae25be8800db562d4bbcaa76a9f.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

With the 64-bit size, the encoding of LDRSB, LDRSH and LDRSW becomes
PRFM. So when asked for a 64-bit sign extending load, the load and
store encoders returned a prefetch instead of failing. The BPF JIT
never asks for one, as BPF_MEMSX has no BPF_DW form, but return
AARCH64_BREAK_FAULT as for other invalid operands.

Before/after for a 64-bit sign extending load from x1 + 8 into x0:

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

