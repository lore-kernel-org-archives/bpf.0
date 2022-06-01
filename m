Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63459CCA477
	for <bpf@archiver.kernel.org>; Wed,  1 Jun 2022 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiFAR6L convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 1 Jun 2022 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbiFAR6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 13:58:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1256A034
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 10:58:09 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2517dJix009366
        for <bpf@vger.kernel.org>; Wed, 1 Jun 2022 10:58:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge3wk3jf4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 10:58:09 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 10:58:07 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 79B608603CC6; Wed,  1 Jun 2022 10:58:02 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>, <jolsa@kernel.org>,
        Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 1/5] ftrace: allow customized flags for ftrace_direct_multi ftrace_ops
Date:   Wed, 1 Jun 2022 10:57:45 -0700
Message-ID: <20220601175749.3071572-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601175749.3071572-1-song@kernel.org>
References: <20220601175749.3071572-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zfgD3V0iUUK1i6Am_eKQleFEjyAJoekO
X-Proofpoint-ORIG-GUID: zfgD3V0iUUK1i6Am_eKQleFEjyAJoekO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_06,2022-06-01_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This enables users of ftrace_direct_multi to specify the flags based on
the actual use case. For example, some users may not set flag IPMODIFY.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/ftrace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2fcd17857ff6..afe782ae28d3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5456,8 +5456,7 @@ int modify_ftrace_direct(unsigned long ip,
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
-		     FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
@@ -5547,7 +5546,7 @@ int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	}
 
 	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
+	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 
 	err = register_ftrace_function(ops);
-- 
2.30.2

