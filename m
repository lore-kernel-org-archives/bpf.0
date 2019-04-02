Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191AC43381
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4291B20857
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 04:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179283;
	bh=jT3FWoy0+yGm/NyqnesiQ/XSF5/d+eDLFqKb1dKmqZk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qUb8wK+viWDM+2HVQjz0W7vpNsOvRuiCXq+FZAAev4S0xxcnjSSEkjuL1YCgqgrMm
	 m9o9xciceO4PkkQOoUP1V1CuOepCVLwgOQHEJYpgnFtGTw3MbhVRMpd4tAuvoUJDhd
	 WSz/S9FZhTkeIYpEMpVT8y8pdNOYJOItKa6orRd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfDBE2C convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Apr 2019 00:28:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbfDBE17 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Apr 2019 00:27:59 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x324NNme013788
        for <bpf@vger.kernel.org>; Mon, 1 Apr 2019 21:27:58 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2rkuvyrse0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2019 21:27:58 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 1 Apr 2019 21:27:58 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id B6FAD760E11; Mon,  1 Apr 2019 21:27:57 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 04/10] bpf: convert temp arrays to kvcalloc
Date:   Mon, 1 Apr 2019 21:27:43 -0700
Message-ID: <20190402042749.3670015-5-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
References: <20190402042749.3670015-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Temporary arrays used during program verification need to be vmalloc-ed
to support large bpf programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94cf6efc5df6..ad3494a881da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5313,13 +5313,13 @@ static int check_cfg(struct bpf_verifier_env *env)
 	int ret = 0;
 	int i, t;
 
-	insn_state = kcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_state = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_state)
 		return -ENOMEM;
 
-	insn_stack = kcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
+	insn_stack = kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL);
 	if (!insn_stack) {
-		kfree(insn_state);
+		kvfree(insn_state);
 		return -ENOMEM;
 	}
 
@@ -5417,8 +5417,8 @@ static int check_cfg(struct bpf_verifier_env *env)
 	ret = 0; /* cfg looks good */
 
 err_free:
-	kfree(insn_state);
-	kfree(insn_stack);
+	kvfree(insn_state);
+	kvfree(insn_stack);
 	return ret;
 }
 
@@ -7898,7 +7898,7 @@ static void free_states(struct bpf_verifier_env *env)
 			}
 	}
 
-	kfree(env->explored_states);
+	kvfree(env->explored_states);
 }
 
 static void print_verification_stats(struct bpf_verifier_env *env)
@@ -7994,7 +7994,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 			goto skip_full_check;
 	}
 
-	env->explored_states = kcalloc(env->prog->len,
+	env->explored_states = kvcalloc(env->prog->len,
 				       sizeof(struct bpf_verifier_state_list *),
 				       GFP_USER);
 	ret = -ENOMEM;
-- 
2.20.0

