Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125490;
	b=4CYOf/iKb7d22cEpFa5hVqC7n+Ea427u5LU9dviv23ob8lzxOnu3Ikq9vccKPgvF+kvA
	 cskRJK4ueNV9nEk7KGC5DrW0y4cVXQn8gesXyfeXcuC4DbPNfv5UovivO7KVHYBB5ssiE
	 tSOQ3K/zmbEBxFhtQXY8Wq0XwqJyD2ngWKNBWFRrttIKAy85CxDjc0LGb0fwzXLacY4U4
	 tF3pBZCOQJ/53QVtM9BsmAJX72X5glcp/dN6r5Iw4tQYvtncnFE/1i2x4ABsZT338b6ew
	 8qnK/xGkOPWWyVzletVBCMTxUgqOJw0PGGJdLjboelghjWgbUrhbk3LPP64HQm2sCfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125490;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=15ukw9yeC/z6MXz0i7Sibg4Gm+9txnsd3w6oj1/zZcA=;
	b=DtGPd3zFpcDYn4b+6UTug3MGClq+ULVInFNjTn2MNhfdhOYkA9g3p+0MeKqQPy57381x
	 iqiP9sF+KGd6HV4OBVR2g6axbV72Q/eeAoaWXPiv7BGKT9Vk/9/pw3z2eN7uEiUxmX71o
	 QGnoJei42NXmfF+oVrHhxobv/tBaxDoFFSETq6Lfj7Je2mUviLkCbGrksgsYyEMHBS9XM
	 x9noZxtyMA7fV69ElckloFl+H+U+BC5sVXarQs46CHyedx7TLFido3nASECzw7KWDtoPp
	 xCnp+oaScp46OoMWcYpmh4TIWalpn+o+vdbNJGE3ZOO47Gd9Y9wtFooKWjz3nrQBV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=NdmkbYFq;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34053606A323
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34053606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=NdmkbYFq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=15ukw9yeC/z6MXz0i7Sibg4Gm+9txnsd3w6oj1/zZcA=; b=NdmkbYFqk48XZADKRqSX9h84e1
	HFDycCHddmFpJrcMv7OGNChxgLz1GH+7rfQv5s4JOx9UHsrFDexvwxevg+5j04CZHYEb3GsRik2JS
	fk1ijrNtfVdO8u4ntKbPYcKv9Wk6SLZhB/887tJ76l7aPRjK9BkbL44M6j6WaBlb3WFtxWhaMM0Mm
	VlEhM88+HrtKfSHPa09h3i148DhVTcfV2P58frEfWpCL5B6DnnFcbbjCfYZsYN4RJuPdmX7cct5/x
	O9pzD0tQ+/i2ZLnW9DpoClzcVx/0ofRm6+oshsZ8npkWK7X7CDy4uPhUvgHmz8Syu0F/gYbeNmJO7
	+6q+mOOA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqq-000Iik-14;
	Tue, 27 Oct 2026 19:24:48 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 03/21] bpf, arm64: Emit ISB SY in the speculation barriers
Date: Tue, 27 Oct 2026 19:24:27 +0100
Message-ID: <20261027182445.1156335-4-daniel@iogearbox.net>
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

The Spectre-BHB loop of the epilogue and BPF_NOSPEC on cores without
FEAT_SB end in an ISB, which the JIT took from
aarch64_insn_get_isb_value(), the template of the instruction matcher
with CRm 0. The Arm ARM lists every CRm other than 0b1111 as reserved:
those encodings execute as a full system barrier, but must not be relied
upon by software. Emit ISB SY with CRm 0b1111, as the assembler does for
the isb of the kernel's own barriers.

Before/after:

  d50330df  isb #0
  d5033fdf  isb

Fixes: 0dfefc2ea2f2 ("arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs")
Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      | 2 +-
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b2fe6e6dcf44..af570c34a96d 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -341,6 +341,6 @@
 /* Barriers */
 #define A64_SB aarch64_insn_get_sb_value()
 #define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
-#define A64_ISB aarch64_insn_get_isb_value()
+#define A64_ISB (aarch64_insn_get_isb_value() | 0xf << 8)
 
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index febe072a8af2..7d5eb949cdf4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1026,7 +1026,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
 		emit(A64_B_(A64_COND_NE, -2), ctx);
 		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
-		emit(aarch64_insn_get_isb_value(), ctx);
+		emit(A64_ISB, ctx);
 	}
 
 	if (is_spectre_bhb_fw_mitigated()) {
-- 
2.43.0

