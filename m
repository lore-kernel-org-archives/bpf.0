Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3535F5ED;
	Mon, 22 Jun 2026 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112378; cv=none; b=o8RLQzU8yikVW57EUbTeRTNbNx4LXSLKGuc5IrCQmdyt+Z3BZunsqjk6w+zPr4ycCaxroCLlpxoAwA1V4uBeh4T5jGc7mQck7WgMj+sGLPSBEXAnxadD93O4zRlxxuCofR3sqW+NwJyHtIkvjp80u+jhoBgtqgZoXK6znrTHh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112378; c=relaxed/simple;
	bh=gCMNCsuX7LLIx6UZ1vNjcVV1/11+/zg6GicFiw/cq4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVyc+JArlo73ER2hzFrjKa1LMo++hIWl7RXmJsxHFMsUDuIjwaW32znE6G/915e6WgqFgtno4ZBWbjuiwL8wLvM0jkbHMDztR34Wtc5bI5k5mJCQjGFHcCmJAJs/I1pDlbGeGuuloXS3OdnFhpsvHgrhsSMADA58rQRb8s1eL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c778c42c6e0911f1aa26b74ffac11d73-20260622
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:72f27921-7277-4eeb-b9b9-de9a21ae43ac,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:72f27921-7277-4eeb-b9b9-de9a21ae43ac,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:068d26126d057da9de5f13aa83da78eb,BulkI
	D:260622151253V3UKHCTX,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c778c42c6e0911f1aa26b74ffac11d73-20260622
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 551382056; Mon, 22 Jun 2026 15:12:50 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v3 1/4] LoongArch: bpf: Fix memory ordering for value-returning atomics
Date: Mon, 22 Jun 2026 15:12:31 +0800
Message-Id: <20260622071234.1410830-2-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
References: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the Linux Kernel Memory Model, value-returning atomic RMW operations
must provide sequentially consistent ordering (a full memory barrier). On
LoongArch, plain AMO instructions and bare ll/sc loops do not satisfy this
requirement by themselves.

Update emit_atomic_rmw() to emit barrier-carrying instructions for all
value-returning BPF atomics:

 - BPF_FETCH (ADD/AND/OR/XOR): use am*_db.{b,h,w,d}
 - BPF_XCHG: use amswap_db.{b,h,w,d}
 - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
   __WEAK_LLSC_MB in cmpxchg.h

Add the corresponding instruction encodings and emit helpers to inst.h.
Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.) are left as
weakly ordered, consistent with LKMM.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h | 18 +++++++++++++++++
 arch/loongarch/net/bpf_jit.c      | 32 +++++++++++++++++--------------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 76b723590023..bdbc17d07110 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -199,6 +199,10 @@ enum reg3_op {
 	amswaph_op	= 0x70b9,
 	amaddb_op	= 0x70ba,
 	amaddh_op	= 0x70bb,
+	amswapdbb_op	= 0x70bc,
+	amswapdbh_op	= 0x70bd,
+	amadddbb_op	= 0x70be,
+	amadddbh_op	= 0x70bf,
 	amswapw_op	= 0x70c0,
 	amswapd_op	= 0x70c1,
 	amaddw_op	= 0x70c2,
@@ -783,6 +787,20 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
 DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
 DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
 DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
+DEF_EMIT_REG3_FORMAT(amswapdbb, amswapdbb_op)
+DEF_EMIT_REG3_FORMAT(amswapdbh, amswapdbh_op)
+DEF_EMIT_REG3_FORMAT(amadddbb, amadddbb_op)
+DEF_EMIT_REG3_FORMAT(amadddbh, amadddbh_op)
+DEF_EMIT_REG3_FORMAT(amadddbw, amadddbw_op)
+DEF_EMIT_REG3_FORMAT(amadddbd, amadddbd_op)
+DEF_EMIT_REG3_FORMAT(amanddbw, amanddbw_op)
+DEF_EMIT_REG3_FORMAT(amanddbd, amanddbd_op)
+DEF_EMIT_REG3_FORMAT(amordbw, amordbw_op)
+DEF_EMIT_REG3_FORMAT(amordbd, amordbd_op)
+DEF_EMIT_REG3_FORMAT(amxordbw, amxordbw_op)
+DEF_EMIT_REG3_FORMAT(amxordbd, amxordbd_op)
+DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
+DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)
 
 #define DEF_EMIT_REG3SA2_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..47707579e61c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -7,6 +7,9 @@
 #include <linux/memory.h>
 #include "bpf_jit.h"
 
+/* dbar hint for ll/sc completion ordering, see __WEAK_LLSC_MB */
+#define DBAR_LLSC_MB	0x700
+
 #define LOONGARCH_MAX_REG_ARGS 8
 
 #define LOONGARCH_LONG_JUMP_NINSNS 5
@@ -418,7 +421,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amadd.b instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amaddb, src, t1, t3);
+			emit_insn(ctx, amadddbb, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
@@ -426,39 +429,39 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amadd.h instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amaddh, src, t1, t3);
+			emit_insn(ctx, amadddbh, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_W:
-			emit_insn(ctx, amaddw, src, t1, t3);
+			emit_insn(ctx, amadddbw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_DW:
-			emit_insn(ctx, amaddd, src, t1, t3);
+			emit_insn(ctx, amadddbd, src, t1, t3);
 			break;
 		}
 		break;
 	case BPF_AND | BPF_FETCH:
 		if (isdw) {
-			emit_insn(ctx, amandd, src, t1, t3);
+			emit_insn(ctx, amanddbd, src, t1, t3);
 		} else {
-			emit_insn(ctx, amandw, src, t1, t3);
+			emit_insn(ctx, amanddbw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 		}
 		break;
 	case BPF_OR | BPF_FETCH:
 		if (isdw) {
-			emit_insn(ctx, amord, src, t1, t3);
+			emit_insn(ctx, amordbd, src, t1, t3);
 		} else {
-			emit_insn(ctx, amorw, src, t1, t3);
+			emit_insn(ctx, amordbw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 		}
 		break;
 	case BPF_XOR | BPF_FETCH:
 		if (isdw) {
-			emit_insn(ctx, amxord, src, t1, t3);
+			emit_insn(ctx, amxordbd, src, t1, t3);
 		} else {
-			emit_insn(ctx, amxorw, src, t1, t3);
+			emit_insn(ctx, amxordbw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 		}
 		break;
@@ -470,7 +473,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amswap.b instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amswapb, src, t1, t3);
+			emit_insn(ctx, amswapdbb, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
@@ -478,15 +481,15 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amswap.h instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amswaph, src, t1, t3);
+			emit_insn(ctx, amswapdbh, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_W:
-			emit_insn(ctx, amswapw, src, t1, t3);
+			emit_insn(ctx, amswapdbw, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_DW:
-			emit_insn(ctx, amswapd, src, t1, t3);
+			emit_insn(ctx, amswapdbd, src, t1, t3);
 			break;
 		}
 		break;
@@ -509,6 +512,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
 			emit_zext_32(ctx, r0, true);
 		}
+		emit_insn(ctx, dbar, DBAR_LLSC_MB);
 		break;
 	default:
 		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n", imm);
-- 
2.25.1

