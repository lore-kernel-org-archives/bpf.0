Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89183BED42
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537839; cv=none; b=b0t4xOj5X6OcNzGlUsKBbgYRv/cv+Ctu7ljeWUOyxJ8+wmOc2R/WIvDRug7CulWKjq/6Nh5FSq7TugWBW5G+8w/g9ktTcQavPkhPe3CE9lv0+2/gZZroObJEqvbI/vTLq9RCS8/UWwJaYntjcGI7N1qRS7f4Sdf1he6JGYScX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537839; c=relaxed/simple;
	bh=JoVYuvHzO7OGK7CJlqRXcfoQ6RTGzrXDxxCk2RJK94s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6lREGJg8pNtJvgAcBBpEnuDPONb+flZqC7I3P+VaFpPdbrIVGoZOvnCEVjU3oUY272xhLW+rqvLO5vRCriXpKw1kXK+vbdz2OEgF7/k4xauzx+ZPVaFlvgPTw5jLlKjX5CPOyoFuqiBJGZDqqnp/iGiKLxe9xefUyMzr4gaZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmntwRi3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmntwRi3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so2525223b3a.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537837; x=1779142637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHGA0pnULoE9zOAnQoCX1h4jacBv900xuE41+ziaiRY=;
        b=MmntwRi3mDSwL7LOjCPKjZKQOgqHm3j2E6wL1bv7+1k/Cp76JkSV9DHaD2Q+pw6BRe
         YjTIXt+BvtiArKM4pwbLTWlVlVyxgijTdSCbhZqSf6tV2ff1hhCuCCue5BV5B2QEFYbE
         krUA9Lnot2tnCdR/LoVdUHRPt9xmYaIfFkjc8j6DG0Rf7NCSGj+L2dgxNUq9FIXVbCr4
         dmGjXIl5lGchJvB65ZCMF4pnwmYKlSw9M+2oiw9FKiDwiWADmcnO6bvEzxmRi/LrCYx9
         U3Af3q6CWBIyzEz1vtTu7aNQOpitolFuOe+szQVEA+NyELP498KknlT9dxxBEB5mCpXf
         PYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537837; x=1779142637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHGA0pnULoE9zOAnQoCX1h4jacBv900xuE41+ziaiRY=;
        b=IOUma7GpQY/f/dH0miLGhW85sYBAtz+slIXmVBz6bQIu8QA/aV2z0fXpbjGJO0Kkqs
         NdiTfjVddqcN+L9GkUgnNrMtW13x7UK8ok8V1Zu+Hu0pQRzKVIV6ZAPK1TyYLPv5HG7V
         0Nnp7ek13zZSfdLQG8uKFRswfmPXouNRBqSKwCV7R3OBhifaeLr3umakZAbMxMW84oJH
         L7TEpxQ3+RhmNMLO04DUvSQd1OVRWbhW1JhYcchxaH5nTw/MQo+X0m9zYhoB/nZPwIxU
         XgP8b0VVCuP+x5mVaF/W9Fsxkd0fouiITPP8lp6n7zmerDMAHAEeTMKSG6xhaDniD3IG
         D0Bg==
X-Forwarded-Encrypted: i=1; AFNElJ/VzNmHSapByMod+VP4w0qEleMzhEmC4sePbcVaas5wGxprs/Rxav7a8PwkfFAW8xitt50=@vger.kernel.org
X-Gm-Message-State: AOJu0YytyoMShcNI3hrrnPuW4nZ6/Uq+/LDn8QeOsZdYP0Ys/eKuMsvL
	B59sefQEwqYpxpgfFZYtir0Jz2IndLY4+V++x+AXO6fVQmbUKj5DyuELA2wbAw==
X-Gm-Gg: Acq92OFKwgB2cTloWGwrMtXvY55wqdr7x9A82ZI/9O7CQv75m+VXFMa61+2DsCEO3PH
	UyXdEWdlca9fmNEaJ57xek6gQbX3qLaiBcXRthfKI1HvS6ZQ0UKHXdWCr5wh6qZM8gLBm2Z2+5Q
	SSY+Vyo7wP+mHqVgMJF7XrxgIi3FaO49PUyiiSvOsEe7Fb5Q2OUBQugc54YJVpgbKfiSNoj5whQ
	c0HNo0ZeNXyrWR6mnZfZK6n24YA7HZ0XCuxbB0ObbHrxjU47VHg6t6RIEv9cX7Y0yjKHBra56uN
	X8Q/TiB7Pt1bEVDLDPTzJbNnk9dbp1VOmA4w/INILLWLRVwieZ5Qt/IkACHByEXtmpQ8MfNkUeG
	ksjU09rgbufXSatXtjjPdomGsZmVrcbyzvSTsASZDHmpC491NCg+mj/cfwQW915m0BMcQRrY5OG
	M9pGFAJaHjKcFymESBoeQaDm6JlCqzevFir9hysY5gkw1D5sTWdzhFujdEhe9PSV4RoE4etkGmq
	xwCk3ohIZEXboJwGrigwlL1+WgN6cJXWg==
X-Received: by 2002:a05:6a00:2354:b0:837:80a:5ab4 with SMTP id d2e1a72fcca58-83eebf9e29fmr296684b3a.44.1778537837238;
        Mon, 11 May 2026 15:17:17 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm21943329b3a.19.2026.05.11.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:17:16 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v2 2/3] riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
Date: Mon, 11 May 2026 22:16:47 +0000
Message-ID: <20260511221648.3251464-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511221648.3251464-1-visitorckw@gmail.com>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current rv32 bpf jit compiler incorrectly treats BPF_MOVSX as a
standard zero-extended move operation. The bpf instruction set allows
sign-extension moves by reusing the BPF_MOV opcode with the instruction
offset set to 8, 16, or 32.

Update the bpf_jit_emit_insn() function to check the offset field for
both ALU and ALU64 MOV operations. If the offset is non-zero, emit the
correct slli and srai instructions to perform the sign extension.

Before this patch:
[   19.549705] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.551354] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.552576] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.553542] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
[   19.554807] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)

After this patch:
[   17.931172] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 125 PASS
[   17.932198] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 124 PASS
[   17.933039] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 124 PASS
[   17.933918] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 124 PASS
[   17.934751] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 122 PASS

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/riscv/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 7396899ea276..f8509950fed4 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -974,6 +974,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	switch (code) {
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn->off != 0) {
+			const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
+			const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
+
+			if (insn->off == 8) {
+				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
+			} else if (insn->off == 16) {
+				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
+			} else {
+				emit(rv_addi(lo(rd), lo(rs), 0), ctx);
+			}
+			emit(rv_srai(hi(rd), lo(rd), 31), ctx);
+			bpf_put_reg64(dst, rd, ctx);
+			break;
+		}
+		fallthrough;
 
 	case BPF_ALU64 | BPF_ADD | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
@@ -1024,6 +1042,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_zext64(dst, ctx);
 			break;
 		}
+		if (insn->off != 0) {
+			const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
+			const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
+
+			if (insn->off == 8) {
+				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
+			} else if (insn->off == 16) {
+				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
+				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
+			}
+			bpf_put_reg32(dst, rd, ctx);
+			break;
+		}
 		fallthrough;
 
 	case BPF_ALU | BPF_ADD | BPF_X:
-- 
2.54.0.563.g4f69b47b94-goog

