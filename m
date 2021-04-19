Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DFFC433ED
	for <bpf@archiver.kernel.org>; Mon, 19 Apr 2021 23:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C469661354
	for <bpf@archiver.kernel.org>; Mon, 19 Apr 2021 23:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhDSX6F (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:58:05 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36241 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhDSX6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 19:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1618876656; x=1650412656;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=sJXxVXx4KCMJyv3wNLapHiDM+z+uwVIJUTlM2adv4g4=;
  b=JawrN/FYadVYZh1TnaA/Zb9VqLy/XWqX+SjfCTqB8h4rIwMxtoeB1Bbv
   mdhQV8l5VywnV/LmcCY89M+nnJ9hGbdj8YchZih3RSjTYlOQ1hG80RtWW
   YkntuG5PfaCRHEZ9Q9mZ3idS7mfiIBemtzRQO2lvcJZ8AiGgTpGXEoCli
   g=;
X-IronPort-AV: E=Sophos;i="5.82,235,1613433600"; 
   d="scan'208";a="128968883"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 19 Apr 2021 23:57:35 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 2397FA1BCA;
        Mon, 19 Apr 2021 23:57:32 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 19 Apr 2021 23:57:32 +0000
Received: from u87e72aa3c6c25c.ant.amazon.com (10.43.161.253) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 19 Apr 2021 23:57:31 +0000
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>
Subject: [PATCH] bpf: Fix backport of "bpf: restrict unknown scalars of mixed signed bounds for unprivileged"
Date:   Mon, 19 Apr 2021 16:56:41 -0700
Message-ID: <20210419235641.5442-1-samjonas@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D46UWC003.ant.amazon.com (10.43.162.119) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The 4.14 backport of 9d7eceede ("bpf: restrict unknown scalars of mixed
signed bounds for unprivileged") adds the PTR_TO_MAP_VALUE check to the
wrong location in adjust_ptr_min_max_vals(), most likely because 4.14
doesn't include the commit that updates the if-statement to a
switch-statement (aad2eeaf4 "bpf: Simplify ptr_min_max_vals adjustment").

Move the check to the proper location in adjust_ptr_min_max_vals().

Fixes: 17efa65350c5a ("bpf: restrict unknown scalars of mixed signed bounds for unprivileged")
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Reviewed-by: Frank van der Linden <fllinden@amazon.com>
Reviewed-by: Ethan Chen <yishache@amazon.com>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c3a9302be93..9e9b7c076bcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2204,6 +2204,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				dst);
 		return -EACCES;
 	}
+	if (ptr_reg->type == PTR_TO_MAP_VALUE) {
+		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
+			verbose("R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
+				off_reg == dst_reg ? dst : src);
+			return -EACCES;
+		}
+	}
 
 	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
 	 * The id may be overwritten later if we create a new variable offset.
@@ -2349,13 +2356,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			verbose("R%d bitwise operator %s on pointer prohibited\n",
 				dst, bpf_alu_string[opcode >> 4]);
 		return -EACCES;
-	case PTR_TO_MAP_VALUE:
-		if (!env->allow_ptr_leaks && !known && (smin_val < 0) != (smax_val < 0)) {
-			verbose("R%d has unknown scalar with mixed signed bounds, pointer arithmetic with it prohibited for !root\n",
-				off_reg == dst_reg ? dst : src);
-			return -EACCES;
-		}
-		/* fall-through */
 	default:
 		/* other operators (e.g. MUL,LSH) produce non-pointer results */
 		if (!env->allow_ptr_leaks)
-- 
2.17.1

