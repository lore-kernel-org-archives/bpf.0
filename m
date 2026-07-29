Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8A33C18E
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292201; cv=none; b=I++BdXmL+jXiPe+37oLQ4qJMpldmfZqCRlDgzoUSZysuoqNVycUv4QeOM9agwBBKJwBKXmy2ON+H7lFth1/dIVaqqBXvWfWEneSTpNZG6Vmx9gLl2eb983L9fwSsPsIsV+m35w298tWTTPwb4ZEDtPAMF3LLs6pathJDfPGUNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292201; c=relaxed/simple;
	bh=SHY2RuEb+tAR+YEk4DRlMdf7fQkiOG8EuL/hWBOsJmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POjNOseLL/H2JiK/J18MgtH2tDaPNn5N4iH1keIbTqOZpjOYftFnNiSquzpFbiimLWyuIyKq7r6R+drbIaIGdm6R5K9IMUBG1YUE078CycfAfbJLpIq+AKNuaotA6wruVjluBwQAOzEF5nUH70bPbUpUOePN1q1rzioYdk2Y4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTFdhvOB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTFdhvOB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785292196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQmyIkXVm5kvnpynC6ug45MiM192bJtXQr+DFmsIE7w=;
	b=RTFdhvOB86q3Wu0nptRAXj5yAwYvaCr+woechY7WEqkvEz4s+HgnppbEdCS3drB04hcfGU
	fL3MaSgE6vw80o5WHQQ/RdD5/pZgZhc/vlMgOhGaQfMQ0LMOgHb4mox7eYNR8+HjrEpv/o
	V4n+MfT0zqi4YLCTiXvtCuvc4zwR/jY=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
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
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v4 1/4] LoongArch: bpf: Fix memory ordering for value-returning atomics
Date: Wed, 29 Jul 2026 10:28:34 +0800
Message-Id: <20260729022837.355549-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

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
index 29c281bef28e..5417a5624327 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -8,6 +8,9 @@
 #include <asm/asm-offsets.h>
 #include "bpf_jit.h"
 
+/* dbar hint for ll/sc completion ordering, see __WEAK_LLSC_MB */
+#define DBAR_LLSC_MB	0x700
+
 #define LOONGARCH_MAX_REG_ARGS 8
 
 #define LOONGARCH_SAVE_RA_NINSNS   1
@@ -433,7 +436,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amadd.b instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amaddb, src, t1, t3);
+			emit_insn(ctx, amadddbb, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
@@ -441,39 +444,39 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
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
@@ -485,7 +488,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 				pr_err_once("bpf-jit: amswap.b instruction is not supported\n");
 				return -EINVAL;
 			}
-			emit_insn(ctx, amswapb, src, t1, t3);
+			emit_insn(ctx, amswapdbb, src, t1, t3);
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_H:
@@ -493,15 +496,15 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
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
@@ -524,6 +527,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
 			emit_zext_32(ctx, r0, true);
 		}
+		emit_insn(ctx, dbar, DBAR_LLSC_MB);
 		break;
 	default:
 		pr_err_once("bpf-jit: invalid atomic read-modify-write opcode %02x\n", imm);
-- 
2.25.1

