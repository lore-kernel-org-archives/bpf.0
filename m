Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149E3B8D75
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358971; cv=none; b=JoWcRmJx9oD6D4+9TVeWXrQCT6SeOYW+U/CD+o6PySks4xI6fQ3FCFFfLtBUHyeyrwJ8bE8JcnANYbScjOdWI4Uyq0AJCKWFLeng2dSgHQLGQ29HpB+yWSVP+wNUwXIF8EuwnicA0FUtAEiCp4vmfyy+KiPm92A2JYiXmBs7m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358971; c=relaxed/simple;
	bh=1bXXrtSdgM1s/hQXcN07a5SaY5dQCi2VLwSRFLAgnyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT1WxRTxsxCpmTsEj+2gBltbd0vFAbq/3mnE57X9eckwC2uR0wEQOtdz/Xv0mHvXXb9z1h8A0au2lfr8yszN8ZQa1ItMqIHfGfd6oj4++eJlhu3Ohbo61MS2/1X2vcSS0Vz2QsIrVBGpi9Pv2g6mATnzZIXNMW092L7lML0pEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPFe6xcU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPFe6xcU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso35887085ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358970; x=1783963770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaKPPu+uapNzE87fPkc2eZcHacA/RCNosarv8Ol2nys=;
        b=nPFe6xcUlnIt2Ty8RSWPVJ/tnnZmnRAcCnz+RcAWmaqDflLejyqm42Y789hTVwLK8I
         qMEwotzX+nFgm6MnPGelF+G0k/a8dOYBtgplAI2XbrUNKJiJWVFRv2F+tMGRaLFlr4jy
         J+f51rRZ7BI45QWj/kZum1IY52FZaNLV8oILFhbFlnmYKKdHHW662sbm/SpDIev2ocrT
         1xRLFj4XEXF/ZWAMetBM43225nqyaPOk1635v8ZgjujszmWKhr8RLRrMTKRtwBkzLATc
         po0GUkawKicVt1dGCFveGucB50I3gzyWSG1xadu4ZDfJN+aZ8V9WfBBaHgsYA/cKLlq5
         DqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358970; x=1783963770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaKPPu+uapNzE87fPkc2eZcHacA/RCNosarv8Ol2nys=;
        b=YDNbIgOk1Jxf3b+9Ud1jQLXGrrRFn4P6OSw05e5LdiQFvBFxCTo2QLUsBIL7ccdnJl
         9gD2zwZHPbBDcd4wELHox4cImbwSlOsUaIUs+1+ZbM8s4uvmDhZ3ipuyK9zL0Oq6KG90
         qlHtDc7TaGFcIe8KFhq4RN0Iq4rJ+9AgsZKuWc32IE3dw+5+YnDy+/JKtbMCEwfmHpRz
         usqcT8u0LpfEFnYA+0QwnwoeW/R1SsE9R57sEplnAyDvs3x+H1YMJE+ziI0AuTKOEsNb
         6Z5CKlBjs2KnQ8W+JC+o0jQXDr3dm3I/o+Rzk8LJFYFhOFEYtPEwYOiKqocdHTiB2fV2
         ogtA==
X-Forwarded-Encrypted: i=1; AHgh+RpCiUtA7R/Km7f+fMp/vi218l8A042l6H50tn4Nz5iivpat790BvSldoXy++hnPOVmCJGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMHp9HPvAPvh4JIKgNUTT3pP/0y4lHH6z51DEWGN0XR7DNhf8
	PS89bsWPjlAOEkek/3RiPZtiO30DYxkuPfWE/CJkoHtfuWOtNhWxk+9i
X-Gm-Gg: AfdE7cnd4V6sBqVUPZBxU1T3g9ZRXQUrxJx3IAsqlGezcoxW+5RZzsAK1BILdCfaB8M
	1Yen7eD8HJRTBNpXm6F5QKK+ys+jJ8zNDP9jNR5w102YpseJdgh25O/xfvuWCTA/yUbFHg3HtHi
	526NgTbkPqqcLwFbOYrb127oFI9JF4vDtf1qV8M+8rnl5WoW786PHH3zuLMQaLRrLGZY9EVkg/s
	KQQTXX2CDtVLgEmuVS4iWI9thSz0uRIbKJ25FD4YVbtkwvhyR1QBcsyt59cDQ9RFgSXHplszESo
	JGCkD9SQebuDdPVgu1eaOU2PBpIXsULdjsjM0NGxuRQiGZ7oz6D6TmX26bClqLeD5h5OtJjjhmp
	WnHxccnJUT3m/XYLTu4BGdWTCkHkzh/9bPkCtJbgD/xbY/Feagg4Un/ozVgjZYIiOMnRPQh2s98
	59xIXWLlUmc3KWcJvmKrb3+pFg3KZE3pV3nOHw/KB+xqkNiJv/wgsIyOpR5CAulYz1qGMs3AaJQ
	HuJmxS9nkUH
X-Received: by 2002:a17:902:ef44:b0:2ca:cee0:e172 with SMTP id d9443c01a7336-2ccbee24250mr15173245ad.30.1783358969895;
        Mon, 06 Jul 2026 10:29:29 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e54sm54667005ad.2.2026.07.06.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:29:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/3] riscv, bpf: Add 32 bit atomic operations to RV32 JIT
Date: Mon,  6 Jul 2026 17:28:46 +0000
Message-ID: <20260706172846.3876436-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706172846.3876436-1-visitorckw@gmail.com>
References: <20260706172846.3876436-1-visitorckw@gmail.com>
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
index 39e2b0b907dc..bf3fb971294c 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -874,14 +874,58 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
 	return 0;
 }
 
-static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
-			  struct rv_jit_context *ctx, const u8 size,
-			  const u8 mode)
+static int emit_bpf_atomic(const s8 *src, const s8 *rs,
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
+		emit(rv_amoadd_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		emit(rv_amoand_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		emit(rv_amoor_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		emit(rv_amoxor_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
+		break;
+	case BPF_XCHG:
+		emit(rv_amoswap_w(fetch_reg, lo(rs), RV_REG_T0, aq, rl), ctx);
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
+			if (emit_bpf_atomic(src, rs, ctx, insn))
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
2.55.0.rc2.803.g1fd1e6609c-goog

