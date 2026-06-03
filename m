Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244C408017;
	Wed,  3 Jun 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481097; cv=none; b=WRljN7JRvvbqc32umqM6+UTydz9KbDJ/Yhwo42JjrnNc5xenyvzT3iIg3Y9xpYiI5g6oz8v8g1SRzSLcYAIhwYjW1P995OAe1ti4rucvKjy3Xmk4F/Y+cIgkHG7hHhixfYaOgHXlp0FRs0rSQHJvxx4B4FTDN0LCcoc+ou53bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481097; c=relaxed/simple;
	bh=/YzRxPtyjok9PsnmOI8CV75pZfOVegy0tZbhTlLhtsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUTUzHvw7uifwpjPfEXncku3Ku8gEXaT/1aElFw0RievObw6ftEsYYzSounIQgENIEJAzhE3gL4IeTPnDZ5LXJduBjpAi9TqsobC4YqIgaZXl4wrtCFNzRKYkIOwuZYdNWIseej2pMpMKYGPidfGOZynp8omJm1ZBsvLJUx2Mdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a8020e8a5f3311f1aa26b74ffac11d73-20260603
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:35f185bb-dba1-494d-99ff-e4da5c49648c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:35f185bb-dba1-494d-99ff-e4da5c49648c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:8dcb0368938d3ca5a6cc1e29c047e3d4,BulkI
	D:260603180450X0JPP73L,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8020e8a5f3311f1aa26b74ffac11d73-20260603
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.160.128.85)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1099556123; Wed, 03 Jun 2026 18:04:49 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] LoongArch: bpf: Use amswap_db for BPF atomic xchg
Date: Wed,  3 Jun 2026 18:04:35 +0800
Message-Id: <20260603100438.2177817-2-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260603100438.2177817-1-zhaochenguang@kylinos.cn>
References: <20260603100438.2177817-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the Linux Kernel Memory Model, value-returning atomic RMW instructions
imply a full barrier. On LoongArch the plain amswap.{w,d} variants do not
provide that ordering; emit amswap_db.{w,d} for BPF_XCHG instead so scalar
atomic exchanges remain sequentially consistent regardless of kptr inlining.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h | 2 ++
 arch/loongarch/net/bpf_jit.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 76b723590023..636cfc524b02 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -783,6 +783,8 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
 DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
 DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
 DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
+DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
+DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)
 
 #define DEF_EMIT_REG3SA2_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..f071d913e054 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -482,11 +482,11 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
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
-- 
2.25.1

