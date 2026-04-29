Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12853BED18
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466146; cv=none; b=Bbcx/y68LFucmtWfbajh2oWrhD7mX8Dn4qgUWCj0IIZEzTum7GEEqZ+CE/u99vgQPwnjRX1MSuswRtprIN4GlRWvU7CpR44Q6jhuqr6Fzb1RDCuJtc15RDic06SVi8/wPhlAy7dD7f7CYe6SBHbg/TShfSxZ+qUpmTrIhx64F4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466146; c=relaxed/simple;
	bh=R6LT/oXtwCIK8rBIYICuZx9Lf4fBXDESH6WRM3D3CCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhIFTksFg6AE4CtvHXK3eyf/YxTdsXixmfO0HMkNxNiixSJSRro4Xl+upHjJ4dUp8wqYXW8Sc9l3JFVpuVA6lCadZQmM2qxvL+CCv3xZOh73t9ko4ZdVrEC/IgeqUsROShujo3oEi0r2preChCIFcxONAE9a1adx+X03/dMfMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR5SAkx4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR5SAkx4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so7615171a91.3
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466144; x=1778070944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Quty2+kN4SQkJsBp5DT7Nz27mG7X1e/3uN0TQkO7euI=;
        b=jR5SAkx4NjBUmwyqsG3ga2JbSumv0G2NcpfF8yNSGE3uKi1XhORvY065IZdyOtFBe/
         TCWvmGdtEtAEnSuZ9g08Jr9twJoHSRzlmAWcRE6fb0l7mQq8kTCtr1QqTvUeUHoOvBHY
         QCiZ0t1KU91StUUQ+YOfrYexs8bedhFRQUwWLipu58qv38+RsqsbqRRXQ7q9+WDARd3b
         MeaDNWyL5rlJAkcUrsKAerCmoZVTZiqHwvpBDz50ksO5KDxe6ONIU8peRzcCK9tsBxaP
         tMS4WcJnmbpfXlKPBjsOYzvm8qDm1u61CNqVo9GCPkcfADf+Q+MEpFL2zIJWSe08Lk3K
         0t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466144; x=1778070944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Quty2+kN4SQkJsBp5DT7Nz27mG7X1e/3uN0TQkO7euI=;
        b=GICsB+LTlVepuF626I9spKpw/V1to14Ovs2/hmMV3NH8lQIMv/ZVFYq+TM5+hgcWI3
         BjwyZRsuhXnlpz+Lo7rEn9zuY0faqJmtOLfDgZjSFEpunv2l6c08iqEdpc1ut9X1ZdHi
         wpvTXH6fQsFECfVQprHU7tYkRlmQr+o29u1h47s18ivchCsmYfe4cqOrGtARrnrhB2DV
         EovNVs41TrqjL4s+tX6Td9KYNm88eTJW9FObGYN9LDXiWVYfsPU5HblhnbiI6dyjfls/
         TBq8k+A4b5nnXv8omN2KGGg5TXnblbQ4L9mAM10g7iLu493ZsqcWXFW1lGlaNN0jgJ8+
         55QA==
X-Forwarded-Encrypted: i=1; AFNElJ9WIigxr+2sQpPTkO/ueDHkfhajCrr7PRCqtQR/3xEubS7ZH5mN0+1a6zMx30ywrrqTn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqwyX1ylIOWqaukvKn6fgGu6Y4DJ2DAmRud6yvzyHHdzPhbRW
	hqknY9v5BshYM1AHOLXQuH7TSTypblUDZY0MGXhC5CNEAx9KkUy4qX/P
X-Gm-Gg: AeBDiet4l3D5TUX0G42QdOOyTekm8IwhOaEg1G1okgVN23x5c7v7ZDivqjEf3l5XGF+
	7PMHv7xn+IgTJ7BOfspmnXsFdcb0EWKhOD4sJkftAF2N2R94//bwuJrAGkT8kqKAvhffWzlEBzq
	X3gnS3NPjWlmxM8IWgTj0CX4MDyEqK+a2eJiHeiskMkWwdMnmMDPN7oS1uXWBLg4VylxsPWYUDV
	z3uDfSNeHcNGjvWEMDRVqC8NdQylc+QqMkaQDklfbbSSM4L7WpiV+ugj+ILgbj0FV9DGFb/AFjl
	S09Y+RCVHIbM4Bl+H5O8sunURAgdpV2RW/YIJaz0P4Z1ABxwtUanH6rW8h0ePtU8bNSpizSVJul
	nsEOQoOD3WyOkl3kfDP95i+BoESn7cP9jl740nGa2VLpsDqSLBbhSwfDOfmhPRcifTfGzhT6ILy
	qlUnMkyFv2vIDc+rT6NQbYYvjJdlB1QDXEDfpgikKEFQbd6NW2DvGnNhNXldorLGR7BxorVqDLd
	rpkXpQJFUDB5C2NYarblUTwPB8zCKI8CSeedkyYlfeB
X-Received: by 2002:a17:90b:554f:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-36491f6c91fmr7853015a91.3.1777466144094;
        Wed, 29 Apr 2026 05:35:44 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a419c9a6sm2261855a91.7.2026.04.29.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:35:43 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
Date: Wed, 29 Apr 2026 12:35:13 +0000
Message-ID: <20260429123513.3477780-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429123513.3477780-1-visitorckw@gmail.com>
References: <20260429123513.3477780-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RV32 BPF JIT compiler currently only supports the BPF_ADD atomic
operation. Other 32 bit atomic operations (and, or, xor, xchg) and
their BPF_FETCH variants are not supported and gracefully fall back to
the interpreter.

Since the RISC-V A extension is required for Linux on RV32, we can
natively support these 32-bit BPF atomic operations by mapping them
directly to the corresponding RISC-V amo*.w instructions.

Implement BPF_ADD, BPF_AND, BPF_OR, BPF_XOR, and BPF_XCHG with and
without BPF_FETCH. BPF_CMPXCHG requires a more complex lr.w/sc.w
loop and is left to fall back to the interpreter.

Before this patch:
[  138.862161] test_bpf: Summary: 1054 PASSED, 0 FAILED, [843/1042 JIT'ed]

After this patch:
[  157.024124] test_bpf: Summary: 1054 PASSED, 0 FAILED, [902/1042 JIT'ed]

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/riscv/net/bpf_jit_comp32.c | 47 +++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index f8509950fed4..710c56b20f98 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -877,7 +877,7 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 
 static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
 			  struct rv_jit_context *ctx, const u8 size,
-			  const u8 mode)
+			  const u8 mode, s32 imm)
 {
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
@@ -902,11 +902,40 @@ static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
 		case BPF_MEM:
 			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
 			break;
-		case BPF_ATOMIC: /* Only BPF_ADD supported */
-			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
-			     ctx);
+		case BPF_ATOMIC:
+		{
+			s8 fetch_reg = (imm & BPF_FETCH) ? lo(rs) : RV_REG_ZERO;
+
+			switch (imm) {
+			case BPF_ADD:
+			case BPF_ADD | BPF_FETCH:
+				emit(rv_amoadd_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
+				break;
+			case BPF_AND:
+			case BPF_AND | BPF_FETCH:
+				emit(rv_amoand_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
+				break;
+			case BPF_OR:
+			case BPF_OR | BPF_FETCH:
+				emit(rv_amoor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
+				break;
+			case BPF_XOR:
+			case BPF_XOR | BPF_FETCH:
+				emit(rv_amoxor_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
+				break;
+			case BPF_XCHG:
+				emit(rv_amoswap_w(fetch_reg, lo(rs), RV_REG_T0, 0, 0), ctx);
+				break;
+			default:
+				return -1;
+			}
+			if (imm & BPF_FETCH) {
+				emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
+				bpf_put_reg64(src, rs, ctx);
+			}
 			break;
 		}
+		}
 		break;
 	case BPF_DW:
 		emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
@@ -1308,20 +1337,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		}
 
 		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
-				   BPF_MODE(code)))
+				   BPF_MODE(code), 0))
 			return -1;
 		break;
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
-		if (insn->imm != BPF_ADD) {
-			pr_info_once(
-				"bpf-jit: not supported: atomic operation %02x ***\n",
-				insn->imm);
+		if (insn->imm == BPF_CMPXCHG)
 			return -EFAULT;
-		}
 
 		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
-				   BPF_MODE(code)))
+				   BPF_MODE(code), insn->imm))
 			return -1;
 		break;
 
-- 
2.54.0.545.g6539524ca2-goog

