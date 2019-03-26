Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBFDC10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFCB2087C
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="aHJ172on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbfCZSGn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39465 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732463AbfCZSGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so15489336wrn.6
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvAm5TEZ+vRy41nPiPaxm/BGWkzUCYm1nHQ0A4AYs+k=;
        b=aHJ172onZnRdHTfpnTtS4Dsu3xSs9VcQvlHvuIW2Vo2fUNCLsvT4AAx/46M/9ceY1F
         g4YyZH0rlPJ3sq7kTfecGDyOU8f25uMwVQbCfuX8y1WPiAN1zQTS62Ni/6eNUHQX9Qj2
         6DzRlaUUUL+2pvJgmOPOw07c/zbE+rZS4Y+CDlnUIJGn3FvhoSEepO5ghjwIf+Ceztpn
         KynEM0n8Bu8hzO7aYVw0xlsztnPxMt+CY91bFWq8zJZ8QQDatGA5PKnBd/r92k7Fv+L3
         BNN4NZwINk/g/giDkjfPoDuSmdFl0vs6nrUF1eQLHl2NWXFtMo8p685TAPB1w5JYjc0J
         k1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvAm5TEZ+vRy41nPiPaxm/BGWkzUCYm1nHQ0A4AYs+k=;
        b=A3mfYCz5JZPaKSt28NuHEN3aleAfYnlZy99cN5CmC28W3JDu0Kn0K04Iv81oj6Z7gy
         +qp6eZT9qIA0L5tDiPo5omIi4a0R6N5/N1+MizfgIEBzxUM4ZwHOMdhk2Wylvy0/86MT
         +/fhFwnesaIERH/bOJlaYDKrZqInrDUywc1agGHV3G0Q9EMpaRHrKXiU76uQa+3wVeqP
         ftDjKPFKMSMX6SJ013R5IJFYqj8iagkK8VGW4i7I5Xl0o/iSiqQw1VsHqG1HLU/mF4xI
         9N8yk8olsdaMf66k0bMEGKbfujap2vyBHrE+g1Y4QeQZlVoKWiJKgwbAuLu1wfK4yMvm
         8BbA==
X-Gm-Message-State: APjAAAXF4ybk68myx/tbaONzMINikt25zbs8qLkWlDPs3MfW7uUXk0Vx
        WSmjRU5cpZ5y0ftVw7xWseSUsg==
X-Google-Smtp-Source: APXvYqyxtwWcUPusevaIYQWg1q+tg0uYksQLLM8nh54cOqVn52EJLuTY+K9BOTQe1xGCrujlzxrNsg==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr536622wrq.43.1553623600470;
        Tue, 26 Mar 2019 11:06:40 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:39 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 05/16] bpf: reduce false alarm by refining "enum bpf_arg_type"
Date:   Tue, 26 Mar 2019 18:05:28 +0000
Message-Id: <1553623539-15474-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf.h   |  3 +++
 kernel/bpf/core.c     |  2 +-
 kernel/bpf/helpers.c  |  2 +-
 kernel/bpf/verifier.c | 19 +++++++++++++------
 net/core/filter.c     | 28 ++++++++++++++--------------
 5 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f628971..5616a58 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -190,9 +190,12 @@ enum bpf_arg_type {
 
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
index ff09d32..8834d80 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2065,7 +2065,7 @@ const struct bpf_func_proto bpf_tail_call_proto = {
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
index 66e5e65..83448bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2398,7 +2398,9 @@ static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type == ARG_CONST_SIZE ||
-	       type == ARG_CONST_SIZE_OR_ZERO;
+	       type == ARG_CONST_SIZE_OR_ZERO ||
+	       type == ARG_CONST_SIZE32 ||
+	       type == ARG_CONST_SIZE32_OR_ZERO;
 }
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
@@ -2416,10 +2418,12 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 	if (err)
 		return err;
 
-	/* arg_type doesn't differentiate 32 and 64-bit arg, always zext. */
-	mark_insn_zext(env, cur_func(env), regno);
+	if (arg_type != ARG_ANYTHING32 &&
+	    arg_type != ARG_CONST_SIZE32 &&
+	    arg_type != ARG_CONST_SIZE32_OR_ZERO)
+		mark_insn_zext(env, cur_func(env), regno);
 
-	if (arg_type == ARG_ANYTHING) {
+	if (arg_type == ARG_ANYTHING || arg_type == ARG_ANYTHING32) {
 		if (is_pointer_value(env, regno)) {
 			verbose(env, "R%d leaks addr into helper function\n",
 				regno);
@@ -2442,7 +2446,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
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
@@ -2536,7 +2542,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
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

