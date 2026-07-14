Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22C1DE4FB
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988814; cv=none; b=lmwif3Y+w1tZLaPLBc0zUx5XbC8mWygnf/YC5X1c+63COxegiQQd901ysjHOEmZxdoxNSmnqlJUCRuhQzepxCQWx0ruvG41KQpEgHY1yoUxzWqsdW0e1vofcHR03XzY8W7DLtCF0Gc1xP30BiS78ZVrtVkV7y54oBhICMhdwijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988814; c=relaxed/simple;
	bh=kqjs8i5Xs6LCh3vScraC6SOCCs8ALahddMkZsW0/mCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic/u31rIdf6ZgQ4WFzpjNEmgehD3upwWNt2zm2+VMir8u+WizgmbfnxtFoulKfqyTiLJ+Ku6vZmXXa7NRGSzXcYzZvCA22wBSCbj2z2rnoQzTIDJG1oU8LeC1ncuuhKpfzYhK5tgyGu7ouVgPiMaW48ejWbkStTKery8cMsV7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAwzevdg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAwzevdg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce98cb8165so4516405ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988812; x=1784593612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KgXQYuVybZT9KNEa8c+0sS3pMAKReFnk7Wi8Pjluu4g=;
        b=AAwzevdgRIqEwGeiPVX1n59jZ6SShppEH2SUllMKYMEWOyviOjVNELRt9Djc6BGAkV
         vG0my49tdqahsmnu20/qKh8Giy2kBLt+gftga6dcoozVeupGa4kWtyusqSfg7qaQmEci
         JgYKKVnhmZNpTzrlrmQEZQVmlOLEcGljACMMzYdlTYCfF4W+xVhR/vfyJfUL0ZX5hHur
         iLgR507XBLiFnNNkbz7kBGgMwkz7895J5R7OTyHE11MocQIktrcb3DLmUEzSzRwQCcmn
         Uh/nZa5mzZYreFqNnoqqonF7emn8u1FRSLRzpiYjZWg+tvtq8wc2AngDoFybpmsDKEEk
         Krdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988812; x=1784593612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KgXQYuVybZT9KNEa8c+0sS3pMAKReFnk7Wi8Pjluu4g=;
        b=E6UBQg0QDORb8JIxJVdV4SQiiRGGY4/xcl+f688qBwsxUZ/scMXMOWt7NnhS0Herat
         +nrbN4tMgTBDZgAw2g00hXaltwoxCL6B18dVqCtYy+i6ZLozUgvspFMal+HzJ5yUZWy2
         StLRKecBDPbvBGpBETXrYwtfwCPAtI9fYdh0idpDpJdOJ3YhsQ0LULbGDa1fY5GYMYT2
         FP/oMeGSnQTG1wft/KNEPexK7EdwHrSKrZTktRbyKFUdHQI7s/tRwKnsLhXil0yjw30j
         hbFnvO1kEG5vlj1+ReMVSxjnDzimmh57ULROgVfCoVq+VbfyKPTo4NQGBgyZEOxHUNgZ
         5hug==
X-Forwarded-Encrypted: i=1; AHgh+RojCEkIw4O6Qm75+dD+V0coPgfmzHNyzXLIJjDbYMjUtNV5fzOXFGi4bxpNLBq1XwR7HEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsFloL0hjwxXTo/fPHF6++nc65A5EzjQS6s3Xiv6iP+YqVUXj
	BPINy2/q3O/YYg+y44uL9XFxYsvqA5boD6nkAYpV39yN1bzZHnevhNLv
X-Gm-Gg: AfdE7cmX6+D83HzweyNmXCK9y+iy/t8ccEvOea/nHWezAC+MPUCc6Ds+/jDzlH2tIUC
	8+IBDNKg7Zwgk5KZEzx+ObixWGnifi1AAhIxGti9cBoqIJGj0YWNzl+mSzdnf4m9A8bmuUoaoMB
	3CAvZ0ZL81FteP5+VshbF9dk16Bqeoij25JrvnmNgNSrIG62wZwsdi/keq/J1kG9Netvx3DuasY
	fikSgB4qVCE3wYqds7hmXsLJIHRLBHXOMQgUXC0hcW6NVt1EyUdQusOEfJJqmkOZOSUSrZrvGRk
	bugZhMnKSQJVNKgTrheSOc9nx+FiSoFhQ2GAWdTTu0/YMT4jZrBzr3Rn13tI2TD7oxT3USwrMRm
	dGrU3LIy4J7I0wxEbOiGPZKgp7iY3dM0P1Sf9cik+LQpPDYcBjOj9w+Rt5LbbCSzsxpHgodhPRK
	OJeO0dSG1wDkGBSUEjktjcIEDQoPcv0dwqMwJE1R1mixlNwIGZ/v6PJ8Rj9alMSmHxPeCjUCpk+
	BU0cS0dDoyGDMI=
X-Received: by 2002:a17:902:d511:b0:2ca:d4f:adab with SMTP id d9443c01a7336-2ce8292cb2cmr149647585ad.19.1783988812034;
        Mon, 13 Jul 2026 17:26:52 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm105796545ad.53.2026.07.13.17.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:26:51 -0700 (PDT)
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
	aou@eecs.berkeley.edu,
	pulehui@huawei.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v4 3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
Date: Tue, 14 Jul 2026 00:24:51 +0000
Message-ID: <20260714002451.4091139-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260714002451.4091139-1-visitorckw@gmail.com>
References: <20260714002451.4091139-1-visitorckw@gmail.com>
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
 arch/riscv/net/bpf_jit_comp32.c | 64 +++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 39e2b0b907dc..a9e0bd5cc81d 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -874,14 +874,58 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 	return 0;
 }
 
-static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
-			  struct rv_jit_context *ctx, const u8 size,
-			  const u8 mode)
+static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
+			   struct rv_jit_context *ctx,
+			   const struct bpf_insn *insn)
+{
+	s32 imm = insn->imm;
+	bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
+	s8 fetch_reg = is_fetch ? lo(rs) : RV_REG_ZERO;
+	int aq = is_fetch ? 1 : 0;
+	int rl = is_fetch ? 1 : 0;
+
+	switch (imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		emit(rv_amoadd_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		emit(rv_amoand_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		emit(rv_amoor_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		emit(rv_amoxor_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
+		break;
+	case BPF_XCHG:
+		emit(rv_amoswap_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
+		break;
+	default:
+		return -1;
+	}
+
+	if (is_fetch) {
+		emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
+		bpf_put_reg64(src, rs, ctx);
+	}
+	return 0;
+}
+
+static int emit_store_r64(const s8 *dst, const s8 *src,
+			  struct rv_jit_context *ctx,
+			  const struct bpf_insn *insn)
 {
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
 	const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
 	const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
+	u8 size = BPF_SIZE(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	s16 off = insn->off;
 
 	if (mode == BPF_ATOMIC && size != BPF_W)
 		return -1;
@@ -901,9 +945,9 @@ static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
 		case BPF_MEM:
 			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
 			break;
-		case BPF_ATOMIC: /* Only BPF_ADD supported */
-			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
-			     ctx);
+		case BPF_ATOMIC:
+			if (emit_bpf_atomic(RV_REG_T0, src, rs, ctx, insn))
+				return -1;
 			break;
 		}
 		break;
@@ -1303,21 +1347,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			src = tmp2;
 		}
 
-		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
-				   BPF_MODE(code)))
+		if (emit_store_r64(dst, src, ctx, insn))
 			return -1;
 		break;
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
-		if (insn->imm != BPF_ADD) {
+		if (insn->imm == BPF_CMPXCHG) {
 			pr_info_once(
 				"bpf-jit: not supported: atomic operation %02x ***\n",
 				insn->imm);
 			return -EFAULT;
 		}
 
-		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
-				   BPF_MODE(code)))
+		if (emit_store_r64(dst, src, ctx, insn))
 			return -1;
 		break;
 
-- 
2.55.0.795.g602f6c329a-goog

