Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CDC10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBB02084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="GWmFLhj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLWAP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40023 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfDLWAM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so12734204wmi.5
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbG4IZ70X0LLzHsqgrSvIlZXhNJfGsbmDOFJF5Yt8us=;
        b=GWmFLhj47R4tm6VuIQuYcTSjVTg2jfy3X4y6L+cQmBeKmoi6bx88LMk9W6aKvai9BB
         VyyzS266nDl/yAVaAMDtpx3N50qF5ek1ax5Hp8Ee5TLRGG6YPrLD6573K1b+0k8K+N3a
         yC3YAX66k6460y07ksCBqYD80MVN4oKJzSUQn0nGby8ghVGe0jlAdO61bx3ca6J0v1TI
         FBGCy4J6pdMaJeaoIJbkCTN8qL5Ywj4X1iIqUGWumfFrpXikqoaupbFlRCGadxFaOxav
         9u+/VKQVk7dLIkhrLhCwek1aEaAJsytwfDDRW5b5RGxCo38jQxO7i/mJ+eE149mnt8ul
         jEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lbG4IZ70X0LLzHsqgrSvIlZXhNJfGsbmDOFJF5Yt8us=;
        b=WDMWvqiAo5WfT8/gKTVBpezE61uNcMvbfWzsFXq+71RFJEOG918Z+NXpqwZXMuyk/R
         b+jDuGbYiV2OaB+Unk2sibr49solZ8uK2i03mT4EjfyAIiodKjuiCifdTof658zm+V6G
         Q9v7mUZdtWr36hj2/4VmWkus6B1Kfl17vJTw+NL3pgHCDzovUa8qC1aFdnug+tgMELlp
         l2Lt4Fsh1d/K2de6Pl6dcMss3KJozPo15AGwjq9mJ/cKYLgnmQM7RgoHo5JbLoSe+rfs
         sUNFA7rwPbP+YY+ZL1vyfTeqjEtUtfoEB6dHXnqI275iuWmeVYDZjo2wGLAxlPaWTJlz
         CK6Q==
X-Gm-Message-State: APjAAAVmjbnUshUgFaUh4/721+vbnKlU0Rsko2G9eYOTWsTqt9gyPdDF
        a0BvyIyy4xBsE5q/GCIDJO0V1w==
X-Google-Smtp-Source: APXvYqzZCmlsz7s1JH7zrdjFABsDPfz6j1TNqYDJkbEDLeFlbZ+l6kGqV6kfolZH0Gach5GCGFdsrg==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr12349019wmj.83.1555106409892;
        Fri, 12 Apr 2019 15:00:09 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:09 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 07/19] bpf: reduce false alarm by refining helper call arg types
Date:   Fri, 12 Apr 2019 22:59:40 +0100
Message-Id: <1555106392-20117-8-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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
index f15432d..884b8e1 100644
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
 	ARG_PTR_TO_INT,		/* pointer to int */
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
index 4266ffd..039ec8e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -221,7 +221,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg2_type	= ARG_CONST_SIZE,
+	.arg2_type	= ARG_CONST_SIZE32,
 };
 
 #if defined(CONFIG_QUEUED_SPINLOCKS) || defined(CONFIG_BPF_ARCH_SPINLOCK)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bcbd9b..83b3f83 100644
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
@@ -2576,7 +2614,9 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
-	       type == ARG_CONST_SIZE_OR_ZERO;
+	       type == ARG_CONST_SIZE_OR_ZERO ||
+	       type == ARG_CONST_SIZE32 ||
+	       type == ARG_CONST_SIZE32_OR_ZERO;
 }
 
 static bool arg_type_is_int_ptr(enum bpf_arg_type type)
@@ -2610,7 +2650,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 	if (err)
 		return err;
 
-	if (arg_type == ARG_ANYTHING) {
+	if (arg_type == ARG_ANYTHING || arg_type == ARG_ANYTHING32) {
 		if (is_pointer_value(env, regno)) {
 			verbose(env, "R%d leaks addr into helper function\n",
 				regno);
@@ -2633,7 +2673,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
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
@@ -2733,7 +2775,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
 	} else if (arg_type_is_mem_size(arg_type)) {
-		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
+		bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO ||
+					  arg_type == ARG_CONST_SIZE32_OR_ZERO);
 
 		/* remember the mem_size which may be used later
 		 * to refine return values.
diff --git a/net/core/filter.c b/net/core/filter.c
index 95a27fd..d3c7200 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1694,9 +1694,9 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
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
 
@@ -1725,9 +1725,9 @@ static const struct bpf_func_proto bpf_skb_load_bytes_proto = {
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
@@ -1876,7 +1876,7 @@ static const struct bpf_func_proto bpf_l3_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -1929,7 +1929,7 @@ static const struct bpf_func_proto bpf_l4_csum_replace_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -1968,9 +1968,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
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
 
@@ -2151,7 +2151,7 @@ static const struct bpf_func_proto bpf_redirect_proto = {
 	.func           = bpf_redirect,
 	.gpl_only       = false,
 	.ret_type       = RET_INTEGER,
-	.arg1_type      = ARG_ANYTHING,
+	.arg1_type      = ARG_ANYTHING32,
 	.arg2_type      = ARG_ANYTHING,
 };
 
@@ -2929,7 +2929,7 @@ static const struct bpf_func_proto bpf_skb_change_proto_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -2949,7 +2949,7 @@ static const struct bpf_func_proto bpf_skb_change_type_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 };
 
 static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
@@ -3241,7 +3241,7 @@ static const struct bpf_func_proto bpf_skb_change_tail_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_ANYTHING32,
 	.arg3_type	= ARG_ANYTHING,
 };
 
@@ -3837,7 +3837,7 @@ static const struct bpf_func_proto bpf_skb_get_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE32,
 	.arg4_type	= ARG_ANYTHING,
 };
 
@@ -3946,7 +3946,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_PTR_TO_MEM,
-	.arg3_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_CONST_SIZE32,
 	.arg4_type	= ARG_ANYTHING,
 };
 
-- 
2.7.4

