Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E82D7804
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537846; cv=none; b=irNgGiZafi/Uk7KCWh67K0ur9+HbAKZcw7IO44UOAzeFkIJqgjfxaC0b7dv4L5W20GwxzfRWXxnQvpiFPLQLSmxienERxz15oltHZKII7SHwZBzZwk+rVX8O/IUdmK7L1BKDGC5lD/MkKLze1WpQC+ULLPcnJIifG9xMAtbByM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537846; c=relaxed/simple;
	bh=GV1SY4c2fzlzo6fX5tbPqwpSIJrRqDyNam3nkfGtQJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPr0/dZZKLw5x2EBSE2oVB4max4WHWtHQtdPP22oNGvxwKw9WCNZnuwPFLrbatMg6r77+FxtrEZBKw5qdnW0oMUt+sspTMhxyGzbGv5LCc4JRC7lv6hgobhYvk0f6FCiJ3dtuiCHH86x8wfJs1Z3S1k6V4+axh1kPrzez2Sdp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlxWJxJx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlxWJxJx"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1996083a12.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537845; x=1779142645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7mbGY8zUp4Stmyf9OXEpNnChS/Bjn8U2B0Qfpbuf84=;
        b=IlxWJxJxd4N6MP7xRRCJLG65H9J/UXB9Zpec4B9LdiEAj/39l4a1kiglCXkJ0h0okJ
         3wKBAvDaaBHXNZKO4XjLpAU4tmgzErWZ74fQwoG0ju338Z5eJlhRkNrWf5q6izIrSHZD
         AZyLT49KFLLmTHiUp3QKkKUX/4qM2mC+8P8CTQTNJ/8U07OfAYF0K/It92ufH68esErf
         OO8bXoLA4qorJ6o2+V1Zs+cDnZgEsA6ShqZk9wdcbRwE4iMzrAQVb+bKecFZXCdUxsA2
         xmbJaktI5gC7Yz3IPp+6Pqg6eu0dSSvbz5BwaR4qhFvTGlmoCPlnpgz8PKwFA6lDK28o
         YT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537845; x=1779142645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7mbGY8zUp4Stmyf9OXEpNnChS/Bjn8U2B0Qfpbuf84=;
        b=Mp2JDjATBpppeml5Efiu8bd2e+JdQ7qKKTXss9QBN7oROdiR51asIHhmwI4X4lB3fz
         c1W+qHVSaF9H16Zfe/korogXH9h718xRbPhYll/JCMReWk2Kz1oasyg6Cy7bwJXwihNz
         5sxtl2nI//m3LQlU/4JbmXFcoQrMZacAXkipjHl3mI8+V9NymrBknlpR2RtS29AMVp6G
         iziUKejHRNV64uO7HxZEIvh9GHT2xLlZZ9H8TdcBctkNbyYJbz4leqAX1Rqnh9edyubD
         LaaoaiUSbP0E4iGaRsRwes+TdrMkba7ICMvJiiGwItlZkxKDqX9ByU62xqHwvA+FX5Rl
         2NPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QwSrATGPPRVs3r1tEEl7QECG+Wghr4pnc+Kz8wmuTaH7NtG2QmlzswohD8tlg4ej8ccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZOAUT+CFbLpVw3iuBUxHspcBczDUzqWuKts2MuSwvL4TFa1K
	oJNdSpq2WvVnM/Qed0CHVy8l/NC33wycTBmOoFrBDv07r+fikOwtynq+Cy8vtA==
X-Gm-Gg: Acq92OETIQpUb5CBNhMKxlVQTLj3nrChF+dRdx5k+2hoe620xpWajKr4GBOhqB6BHS4
	Y9J5aHvQC/jHFgOvjoHFrAkjp1KkvymfxYz2f7fp220FBgXZQO/0Ov3PH7wjREGEx3Ec+GJnWzM
	U+9Tx+/xe4Mh8/CN+LQFr4nz1ZBOJM5pcVKmfhFqwoKIwonLec191k09sctxD0bf/7FOzBUpzy3
	YmJHtFzRYuhH8PRZJeNU6eFv50C6isAJsqu8iOYc0xqKqXYnAyY7Rf7RTMzeFA926BZuBEBYQUU
	2vdVLhNgL8J0Kc3JNFI4NZJhoM1q/ptN23q0vwbXOx1A4LJjkRR+mzEY1HCcK/x4vWln/a1fWhT
	sJG/yAJ2Cvf2GvsP5QRV6sRmqjeC+5aWfmFyqS1zt1JZz0rxFX1rOAswcDQiEp+2g1yV89Xk0p1
	g5FCBw4/8rUeLGLogNqnNGrhEPxEZszk6zE0MY1nkYID9WLCVEZeImOo/Dmp3aqp0czUead31zz
	Iyo0deo/T3KVSZgtfpFiJaZGm1nlo278A==
X-Received: by 2002:a05:6a20:6a09:b0:3a2:f14a:4290 with SMTP id adf61e73a8af0-3aa5aa7a02dmr27720750637.38.1778537844766;
        Mon, 11 May 2026 15:17:24 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm21943329b3a.19.2026.05.11.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:17:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
Date: Mon, 11 May 2026 22:16:48 +0000
Message-ID: <20260511221648.3251464-4-visitorckw@gmail.com>
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
 arch/riscv/net/bpf_jit_comp32.c | 50 +++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index f8509950fed4..7fd726a09b26 100644
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
@@ -902,11 +902,43 @@ static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
 		case BPF_MEM:
 			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
 			break;
-		case BPF_ATOMIC: /* Only BPF_ADD supported */
-			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
-			     ctx);
+		case BPF_ATOMIC:
+		{
+			bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
+			s8 fetch_reg = is_fetch ? lo(rs) : RV_REG_ZERO;
+			int aq = is_fetch ? 1 : 0;
+			int rl = is_fetch ? 1 : 0;
+
+			switch (imm) {
+			case BPF_ADD:
+			case BPF_ADD | BPF_FETCH:
+				emit(rv_amoadd_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+				break;
+			case BPF_AND:
+			case BPF_AND | BPF_FETCH:
+				emit(rv_amoand_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+				break;
+			case BPF_OR:
+			case BPF_OR | BPF_FETCH:
+				emit(rv_amoor_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+				break;
+			case BPF_XOR:
+			case BPF_XOR | BPF_FETCH:
+				emit(rv_amoxor_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+				break;
+			case BPF_XCHG:
+				emit(rv_amoswap_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+				break;
+			default:
+				return -1;
+			}
+			if (is_fetch) {
+				emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
+				bpf_put_reg64(src, rs, ctx);
+			}
 			break;
 		}
+		}
 		break;
 	case BPF_DW:
 		emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
@@ -1308,20 +1340,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
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
2.54.0.563.g4f69b47b94-goog

