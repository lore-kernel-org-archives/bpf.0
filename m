Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82427C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4378320820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UAMKuXC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDJTv2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDJTut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so4363121wrn.6
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NlPoGKLapOA094jH5RaXWl2m1CpdKBwMGl/CNr+Rkc8=;
        b=UAMKuXC/brrvhsXqVdvgzuv0kznGyJTltWHHwL5pbQhUF/vIIteF1aVA1aecPdTVdI
         0wYOh/aiSSsHB3/jdCWP0hQs/UaJuBES81Da97qxeiAFww3+a53/JyoY9ACayggVAanG
         ZGg1Hkod17cYWh8alVmb51BXoBPMVm5QQ9zcajlqg6qIj3OWb/pKx89pRPAs9574Z/5/
         V/rlItavvbYUz+DxI+QlrzGub1GH3isc/NXPANDU33QKVvqyFn3kQQsoDM+cMF+38UuJ
         gJ01hcJk5Iy9csKQpuRRfu2DiPlueSG+dscm+N+GBPwNdzIwQbU2jbo5s13txLg+U1gA
         Alpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NlPoGKLapOA094jH5RaXWl2m1CpdKBwMGl/CNr+Rkc8=;
        b=tCN1sFhkoBiJMcxoHSm5Zz7LTzpyi/QK7LJB+g804aUGcQ22/Z3e/+8fu2aZ00V7XX
         IvxcH/Pq3ajAi0l8KpjESZYjWNsNmCttLwVJBzpf2g0Cj7gH1ccNgVUmdGZ6usfRMeJM
         VlvEQFc7QFttaqvQByX69qWtdar/hX0mETpTHBh2a238yTJeghEmP8cJJFgZwpWrSeyG
         X8bFkBomTIyRUDOzMgOcn06mYJTosHztgy5Jqc6m5KHBCorfFQQBkhJbIvsJ8B3OMK93
         mCueeyffd56BqzsKhidwE7R92cFn05DhEssCo/QlZpgrPlHpOW30aT5/UzsO7q/6AJKl
         AoBA==
X-Gm-Message-State: APjAAAXp98mneo8UF1F/LUML1iSzNwJc80WPrM85gYLKXVfRTrLWl4DM
        QRNUx4Wr+RPthGqPSdcRvAIaIg==
X-Google-Smtp-Source: APXvYqznRfgJgsqo1f54xhUgbQU3y7miXhQnX1088CH1D4cHIF8dr50R2Pi/76zrmp7nAH7pxfayhw==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr13003060wrq.279.1554925846818;
        Wed, 10 Apr 2019 12:50:46 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:46 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 07/19] bpf: reduce false alarm by refining helper call arg types
Date:   Wed, 10 Apr 2019 20:50:21 +0100
Message-Id: <1554925833-7333-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Unlike BPF to BPF function call, BPF helper call is calls to native insns
that verifier can't walk. So, verifier needs helper proto type descriptions
for data-flow purpose.

There is such information already, but it is not differentiate sub-register
read with full register read.

This patch split "enum bpf_arg_type" for sub-register read, and updated
descriptions for several functions that shown frequent usage in one Cilium
benchmark.

"is_reg64" then taught about these new arg types.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/core.c     |  2 +-
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
 net/core/filter.c     | 28 +++++++++++------------
 5 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 65f7094..42f3345 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -197,9 +197,12 @@ enum bpf_arg_type {
 
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
+	ARG_CONST_SIZE32,	/* Likewise, but size fits into 32-bit */
+	ARG_CONST_SIZE32_OR_ZERO,	/* Ditto */
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
+	ARG_ANYTHING32,		/* Likewise, but it is a 32-bit argument */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 };
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ace8c22..2792eda 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2067,7 +2067,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
-	.arg3_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING32,
 };
 
 /* Stub for JITs that only support cBPF. eBPF programs are interpreted.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a411fc1..6b7453e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -218,7 +218,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_CONST_SIZE32,
 };
 
 #if defined(CONFIG_QUEUED_SPINLOCKS) || defined(CONFIG_BPF_ARCH_SPINLOCK)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b478b90..431fca9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1174,12 +1174,47 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static bool helper_call_arg64(struct bpf_verifier_env *env, int func_id,
+			      u32 regno)
+{
+	/* get_func_proto must succeed, other it should have been rejected
+	 * early inside check_helper_call.
+	 */
+	const struct bpf_func_proto *fn =
+		env->ops->get_func_proto(func_id, env->prog);
+	enum bpf_arg_type arg_type;
+
+	switch (regno) {
+	case BPF_REG_1:
+		arg_type = fn->arg1_type;
+		break;
+	case BPF_REG_2:
+		arg_type = fn->arg2_type;
+		break;
+	case BPF_REG_3:
+		arg_type = fn->arg3_type;
+		break;
+	case BPF_REG_4:
+		arg_type = fn->arg4_type;
+		break;
+	case BPF_REG_5:
+		arg_type = fn->arg5_type;
+		break;
+	default:
+		arg_type = ARG_DONTCARE;
+	}
+
+	return arg_type != ARG_CONST_SIZE32 &&
+	       arg_type != ARG_CONST_SIZE32_OR_ZERO &&
+	       arg_type != ARG_ANYTHING32;
+}
+
 /* This function is supposed to be used by the following 32-bit optimization
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
  */
-static bool is_reg64(struct bpf_insn *insn, u32 regno,
-		     struct bpf_reg_state *reg, enum reg_arg_type t)
+static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
+		     u32 regno, struct bpf_reg_state *reg, enum reg_arg_type t)
 {
 	u8 code, class, op;
 
@@ -1201,9 +1236,12 @@ static bool is_reg64(struct bpf_insn *insn, u32 regno,
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return false;
 			/* Helper call will reach here because of arg type
-			 * check. Conservatively marking all args as 64-bit.
+			 * check.
 			 */
-			return true;
+			if (t == SRC_OP)
+				return helper_call_arg64(env, insn->imm, regno);
+
+			return false;
 		}
 	}
 
@@ -1283,7 +1321,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	}
 
 	reg = &regs[regno];
-	rw64 = is_reg64(insn, regno, reg, t);
+	rw64 = is_reg64(env, insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -2575,7 +2613,9 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
-	       type == ARG_CONST_SIZE_OR_ZERO;
+	       type == ARG_CONST_SIZE_OR_ZERO ||
+	       type == ARG_CONST_SIZE32 ||
+	       type == ARG_CONST_SIZE32_OR_ZERO;
 }
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
@@ -2593,7 +2633,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 	if (err)
 		return err;
 
-	if (arg_type == ARG_ANYTHING) {
+	if (arg_type == ARG_ANYTHING || arg_type == ARG_ANYTHING32) {
 		if (is_pointer_value(env, regno)) {
 			verbose(env, "R%d leaks addr into helper function\n",
 				regno);
@@ -2616,7 +2656,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 		    type != expected_type)
 			goto err_type;
 	} else if (arg_type == ARG_CONST_SIZE ||
-		   arg_type == ARG_CONST_SIZE_OR_ZERO) {
+		   arg_type == ARG_CONST_SIZE_OR_ZERO ||
+		   arg_type == ARG_CONST_SIZE32 ||
+		   arg_type == ARG_CONST_SIZE32_OR_ZERO) {
 		expected_type = SCALAR_VALUE;
 		if (type != expected_type)
 			goto err_type;
@@ -2710,7 +2752,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
 	} else if (arg_type_is_mem_size(arg_type)) {
-		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
+		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO ||
+					  arg_type == ARG_CONST_SIZE32_OR_ZERO);
 
 		/* remember the mem_size which may be used later
 		 * to refine return values.
diff --git a/net/core/filter.c b/net/core/filter.c
index 22eb2ed..3f6d8af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1693,9 +1693,9 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_PTR_TO_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_CONST_SIZE32,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -1724,9 +1724,9 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg4_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_CONST_SIZE32,
 };
 
 BPF_CALL_5(bpf_skb_load_bytes_relative, const struct sk_buff *, skb,
@@ -1875,7 +1875,7 @@ static const struct bpf_func_proto bpf_l3_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -1928,7 +1928,7 @@ static const struct bpf_func_proto bpf_l4_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -1967,9 +1967,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
-	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg2_type	= ARG_CONST_SIZE32_OR_ZERO,
 	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
-	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
+	.arg4_type	= ARG_CONST_SIZE32_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
 
@@ -2150,7 +2150,7 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 	.func           = bpf_redirect,
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_ANYTHING,
+	.arg1_type      = ARG_ANYTHING32,
 	.arg2_type      = ARG_ANYTHING,
 };
 
@@ -2928,7 +2928,7 @@ static const struct bpf_func_proto bpf_skb_change_proto_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -2948,7 +2948,7 @@ static const struct bpf_func_proto bpf_skb_change_type_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 };
 
 static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
@@ -3236,7 +3236,7 @@ static const struct bpf_func_proto bpf_skb_change_tail_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -3832,7 +3832,7 @@ static const struct bpf_func_proto bpf_skb_get_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE32,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -3941,7 +3941,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE32,
 	.arg4_type	= ARG_ANYTHING,
 };
 
-- 
2.7.4

