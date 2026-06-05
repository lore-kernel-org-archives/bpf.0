Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6940B6F1
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641264; cv=none; b=hh6ItK5QVQ5kcA+iH2EceJwBI4fSzhb6Q3/EbrHMQky7rNzTT4DPJ0zTg0QERj3AQFFntGIOfyDcCliA1ggG3gNn8V+snvuNVE/6ZvVQwF1nH2ZCaxvA+9m6CPVFZxat29isQqqdFroyu6B5SL1UvhsrDtHVE3WDCsmPZuQjoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641264; c=relaxed/simple;
	bh=2DYoHIJkXgzAeLI6nin93ONDtEeHRGMNd6NefMAqzLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5jt1xCtDuMVdqez7G4ZytpFlWsVfhYCVL/kvl/ABrFVd+qq5A7D3GVmbB8cUMfbckFAbYCKqpZ5E5BhXkvk6nhTHVZAYQgR5hh0OcmvoAhfaUm8cD4uZdpfwmcrzRGKTf0pIv0Nj1QzHevm+c7xzuwxY7uPh/qm0tmgNdlQg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2glXLhN; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2glXLhN"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b3637b90so13040425e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641260; x=1781246060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INyc47Eq2GksfFVNMEef/3R1eygdJqBAO6jNY/Qy/T0=;
        b=I2glXLhNbwaZl94FU2cteugpTArrA63kYl5ctahXuSCH5JRkXhXtaqLl1hHhW2Ya4C
         UqjeL8bW74QBdnrmqfxig3yrJBxI4X7NP3zgzGtz6I9b9/hpgWU8T5Ys+1hPn0B0vxo3
         FLOakikS+haL/KIEM7PkvpwLAq5Zq5jKwyVuUd+8fWb2RqiJR2qLfrSqpO4f/LtBqDig
         zknIS24sZvQfeNp4l9DbQHwB9b4v/VN8GAEY/VCzKYGrbXb2SlpX+1NvrEtjDxCxnQip
         nli+D7k4pgO5ep59Fp9Szo09AVveieQiXKiu2t9graqtMPnnNVnJChKXSEMIpHgqZEgJ
         7vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641260; x=1781246060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INyc47Eq2GksfFVNMEef/3R1eygdJqBAO6jNY/Qy/T0=;
        b=sSPWZ5S+tPFebcJ+/zUp/2s7fVE5FGXJJ1+6j0Jja/TlyQCdl2IukI//L6FIT0IbhJ
         6kgyy++SfcHRa2BYECYxcySJHnHZJKTCff0YxxkUqhXFdfM8twc+ceM9TcgGKgyeTsoq
         afFo3nIB4MED+hlda236aCJjGqHuoyEakk6NDT2hB6LEF7DKQb4j5YRHKjsA8ikQYh5I
         PlXfLsG/cG3p3H4LOcwBsXu5BwkRqtdKzgBH4VNTlLq0fY/lUZr2RVsIu1D/M76oWFEV
         2njQcUkUocUEY/+qBu6h9zR4y/+5yDxyiiqZSssmWKmEl9rdp3nD4B7fmI2sTwdYLm5p
         CNrw==
X-Gm-Message-State: AOJu0Yzw3O0ozCmyOO1mukiU9JYc+iL6PVBdgorelmTHshAr3kR2L1Nv
	2M48Dfd9uNbAA1ZFswbTXEFO5Sy5C132MgItO3+C0WLc9us9po2UHtoOGluh9Mrv
X-Gm-Gg: Acq92OFOQL+pm+Mql6fsD+cn4kjQpkP1aTSScojkVIDJMXlS4IF1F3iFXlmKVj+hbsE
	s3webac4Tk1yxa3riy8yEKsHa1CykpYpIoBXswgN0VfvUNavp4r5d4S8HACE1SGHjRsjtOzDN5o
	YvXKLu0xjED0Xm068skDcA9hBmZW7SOTmxQ3PVOkJfnzY/xMtiKeYZgMemFHktT8RVpvFuPJ1UK
	Un7+M2kue9K1dKI+s1tPDpQYjgo2q2xtovSlkFMh8yPXtSUIAWNsjFPQEFJ4GtG+xBhao2M+11X
	nXm3BGN68csgbJZcfZPegImkewZkHsjSvGCnqJVL6p3KB/T0RxsWw2cBUlwkViFVUr8Y4Q74yHs
	UGyXNBG/StTFs6/8BwBcirEeG5jSL2d417yRDGb1ZKTRQadCfc6b3BoKw09WgWTE1mgcCl3rKGj
	A/nh4u4tvhvDoCxa5EpCXPJlEsfC9Wq4conSt47NWT3SQx9Kyf+LaJMmNPVPGEQCrYOisKmRXdN
	zwpJ+wuQCFJKEqGQK3iOpJug92NPAZv+brE4WTD3ygebf1GbqJTxXbpZ/0GdzJQKeHpm/r+hc0R
X-Received: by 2002:a05:600c:4f0b:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-490c25c1e32mr27219415e9.15.1780641257252;
        Thu, 04 Jun 2026 23:34:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ea37sm40091395e9.0.2026.06.04.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/17] bpf: Track verifier branch diagnostic history
Date: Fri,  5 Jun 2026 08:33:54 +0200
Message-ID: <20260605063412.974640-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8966; i=memxor@gmail.com; h=from:subject; bh=2DYoHIJkXgzAeLI6nin93ONDtEeHRGMNd6NefMAqzLg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt2gCw0z1wD1mJ+YsCeK7EFJk3ip/r3TmI71WzRm+W 76cEpXuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERSfjL8j/bw3ygRuiFzps70 Rbvza9juVN89rxPq4Xvjb5m7j1ltMcNfkXuHn56P+Tx15YInW+Y7Lq8WOB799az09/0G74+zmXm x8QIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add bounded diagnostic history to verifier states and copy/free it with
normal verifier-state lifetime management. This history is separate from
jump history because it is ordered for user-facing diagnostics instead of
precision backtracking.

Record conditional branch outcomes as true or false so later reports can
show the path that reached a verifier error. If no visible events exist,
print a generic fallback from the history renderer itself.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |   5 ++
 kernel/bpf/diagnostics.c     | 128 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h     |  24 +++++++
 kernel/bpf/verifier.c        |   7 ++
 4 files changed, 164 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c248ff41f42a..55921b8a5d5c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -437,6 +437,8 @@ struct bpf_jmp_history_entry {
 static_assert(MAX_CALL_FRAMES <= (1 << 3));
 static_assert(MAX_BPF_STACK / 8 <= (1 << 6));
 
+struct bpf_diag_history_event;
+
 /* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE + \
@@ -521,6 +523,9 @@ struct bpf_verifier_state {
 	 */
 	struct bpf_jmp_history_entry *jmp_history;
 	u32 jmp_history_cnt;
+	struct bpf_diag_history_event *diag_history;
+	u32 diag_history_cnt;
+	u32 diag_history_omitted;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 652d4627c2b0..50cc50a394ca 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -5,6 +5,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/stdarg.h>
 #include <linux/string.h>
 
@@ -518,3 +519,130 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 							 label, msg);
 	}
 }
+
+void bpf_diag_clear_history(struct bpf_verifier_state *state)
+{
+	kfree(state->diag_history);
+	state->diag_history = NULL;
+	state->diag_history_cnt = 0;
+	state->diag_history_omitted = 0;
+}
+
+void bpf_diag_copy_history(struct bpf_verifier_state *dst,
+			   const struct bpf_verifier_state *src)
+{
+	struct bpf_diag_history_event *history;
+
+	if (!src->diag_history_cnt) {
+		bpf_diag_clear_history(dst);
+		dst->diag_history_omitted = src->diag_history_omitted;
+		return;
+	}
+
+	history = krealloc_array(dst->diag_history, src->diag_history_cnt,
+				 sizeof(*history), GFP_KERNEL_ACCOUNT);
+	if (!history) {
+		kfree(dst->diag_history);
+		dst->diag_history = NULL;
+		dst->diag_history_cnt = 0;
+		dst->diag_history_omitted = src->diag_history_omitted +
+					    src->diag_history_cnt;
+		return;
+	}
+
+	dst->diag_history = history;
+	memcpy(dst->diag_history, src->diag_history,
+	       src->diag_history_cnt * sizeof(*dst->diag_history));
+	dst->diag_history_cnt = src->diag_history_cnt;
+	dst->diag_history_omitted = src->diag_history_omitted;
+}
+
+static void
+bpf_diag_drop_oldest_and_append_history(struct bpf_verifier_state *state,
+					const struct bpf_diag_history_event *event)
+{
+	if (!state->diag_history_cnt) {
+		state->diag_history_omitted++;
+		return;
+	}
+
+	memmove(state->diag_history, state->diag_history + 1,
+		(state->diag_history_cnt - 1) * sizeof(*state->diag_history));
+	state->diag_history[state->diag_history_cnt - 1] = *event;
+	state->diag_history_omitted++;
+}
+
+static void bpf_diag_append_history(struct bpf_verifier_state *state,
+				    const struct bpf_diag_history_event *event)
+{
+	struct bpf_diag_history_event *history;
+
+	if (!state)
+		return;
+
+	if (state->diag_history_cnt < BPF_DIAG_HISTORY_MAX) {
+		history = krealloc_array(state->diag_history,
+					 state->diag_history_cnt + 1,
+					 sizeof(*history), GFP_KERNEL_ACCOUNT);
+		if (!history) {
+			bpf_diag_drop_oldest_and_append_history(state, event);
+			return;
+		}
+
+		state->diag_history = history;
+		state->diag_history[state->diag_history_cnt++] = *event;
+		return;
+	}
+
+	bpf_diag_drop_oldest_and_append_history(state, event);
+}
+
+void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_idx,
+			    bool cond_true)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = BPF_DIAG_HISTORY_BRANCH,
+		.branch.cond_true = cond_true,
+	};
+
+	bpf_diag_append_history(state, &event);
+}
+
+void bpf_diag_print_history(struct bpf_verifier_env *env)
+{
+	const struct bpf_verifier_state *state = env->cur_state;
+	const struct bpf_diag_history_event *event;
+	bool printed = false;
+	u32 i;
+
+	bpf_diag_report_section(env, "Causal path");
+
+	if (!state)
+		return;
+
+	if (state->diag_history_omitted)
+		verbose(env, "  ... %u earlier diagnostic events omitted by display limit ...\n",
+			state->diag_history_omitted);
+
+	for (i = 0; i < state->diag_history_cnt; i++) {
+		event = &state->diag_history[i];
+
+		switch (event->kind) {
+		case BPF_DIAG_HISTORY_BRANCH:
+			bpf_diag_report_source(env, event->insn_idx, '?',
+					       "explored as %s, goto %s",
+					       event->branch.cond_true ? "true" :
+					       "false",
+					       event->branch.cond_true ? "followed" :
+					       "not followed");
+			printed = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!printed && !state->diag_history_omitted)
+		verbose(env, "  no recorded diagnostic events on this path\n");
+}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index ba60cc3af548..1392ff5fb027 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -19,7 +19,24 @@ enum bpf_diag_category {
 	BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
 };
 
+struct bpf_diag_history_event {
+	u32 insn_idx;
+	u8 kind;
+	union {
+		struct {
+			bool cond_true;
+		} branch;
+	};
+};
+
+#define BPF_DIAG_HISTORY_MAX 1024
+
+enum bpf_diag_history_kind {
+	BPF_DIAG_HISTORY_BRANCH,
+};
+
 struct bpf_verifier_env;
+struct bpf_verifier_state;
 
 void bpf_diag_report_header(struct bpf_verifier_env *env,
 			    enum bpf_diag_category category,
@@ -33,4 +50,11 @@ void bpf_diag_report_source(struct bpf_verifier_env *env, u32 insn_idx,
 			    char marker, const char *fmt, ...)
 	__printf(4, 5);
 
+void bpf_diag_clear_history(struct bpf_verifier_state *state);
+void bpf_diag_copy_history(struct bpf_verifier_state *dst,
+			   const struct bpf_verifier_state *src);
+void bpf_diag_record_branch(struct bpf_verifier_state *state, u32 insn_idx,
+			    bool cond_true);
+void bpf_diag_print_history(struct bpf_verifier_env *env);
+
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..d60e1309957a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -32,6 +32,7 @@
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
 
+#include "diagnostics.h"
 #include "disasm.h"
 
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
@@ -1598,6 +1599,7 @@ void bpf_free_verifier_state(struct bpf_verifier_state *state,
 	}
 	kfree(state->refs);
 	bpf_clear_jmp_history(state);
+	bpf_diag_clear_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1624,6 +1626,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	if (!dst_state->jmp_history)
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
+	bpf_diag_copy_history(dst_state, src);
 
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
@@ -15933,6 +15936,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
+		bpf_diag_record_branch(this_branch, *insn_idx, true);
 		*insn_idx += insn->off;
 		return 0;
 	} else if (pred == 0) {
@@ -15948,6 +15952,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		}
 		if (env->log.level & BPF_LOG_LEVEL)
 			print_insn_state(env, this_branch, this_branch->curframe);
+		bpf_diag_record_branch(this_branch, *insn_idx, false);
 		return 0;
 	}
 
@@ -15980,6 +15985,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	other_branch_regs[insn->dst_reg] = env->true_reg1;
 	if (BPF_SRC(insn->code) == BPF_X)
 		other_branch_regs[insn->src_reg] = env->true_reg2;
+	bpf_diag_record_branch(this_branch, *insn_idx, false);
+	bpf_diag_record_branch(other_branch, *insn_idx, true);
 
 	if (BPF_SRC(insn->code) == BPF_X &&
 	    src_reg->type == SCALAR_VALUE && src_reg->id &&
-- 
2.53.0

