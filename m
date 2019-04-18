Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A15C282DA
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E077120821
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 01:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555550825;
	bh=4H07oVe5lny00hSzjy70rrzncasGY+Ava2ginz9cR1Q=;
	h=From:To:CC:Subject:Date:List-ID:From;
	b=H6lZPF61aoAv2sWn7m+TiQHRNGRBD9SWsu61CxQRyMolm/V5ari2G+7Pf1Ji4Zis/
	 wJp1pzhjFpywRO/A8pRmpHMq5rmNReaCHuT0xr1faWH2aXizlIwLpWCDg8jmywJIh/
	 as1UsgmKPpJchs7ebWCGb0ihIiVPu4cFQrfxyKMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfDRB1E convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 17 Apr 2019 21:27:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38512 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbfDRB1E (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Apr 2019 21:27:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I1DSuI024705
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2019 18:27:03 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx0t2u6ra-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2019 18:27:02 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 17 Apr 2019 18:27:01 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 709C7760C44; Wed, 17 Apr 2019 18:27:01 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: document the verifier limits
Date:   Wed, 17 Apr 2019 18:27:01 -0700
Message-ID: <20190418012701.2965338-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document the verifier limits.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/bpf_design_QA.rst | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
index 10453c627135..cb402c59eca5 100644
--- a/Documentation/bpf/bpf_design_QA.rst
+++ b/Documentation/bpf/bpf_design_QA.rst
@@ -85,8 +85,33 @@ Q: Can loops be supported in a safe way?
 A: It's not clear yet.
 
 BPF developers are trying to find a way to
-support bounded loops where the verifier can guarantee that
-the program terminates in less than 4096 instructions.
+support bounded loops.
+
+Q: What are the verifier limits?
+--------------------------------
+A: The only limit known to the user space is BPF_MAXINSNS (4096).
+It's the maximum number of instructions that the unprivileged bpf
+program can have. The verifier has various internal limits.
+Like the maximum number of instructions that can be explored during
+program analysis. Currently, that limit is set to 1 million.
+Which essentially means that the largest program can consist
+of 1 million NOP instructions. There is a limit to the maximum number
+of subsequent branches, a limit to the number of nested bpf-to-bpf
+calls, a limit to the number of the verifier states per instruction,
+a limit to the number of maps used by the program.
+All these limits can be hit with a sufficiently complex program.
+There are also non-numerical limits that can cause the program
+to be rejected. The verifier used to recognize only pointer + constant
+expressions. Now it can recognize pointer + bounded_register.
+bpf_lookup_map_elem(key) had a requirement that 'key' must be
+a pointer to the stack. Now, 'key' can be a pointer to map value.
+The verifier is steadily getting 'smarter'. The limits are
+being removed. The only way to know that the program is going to
+be accepted by the verifier is to try to load it.
+The bpf development process guarantees that the future kernel
+versions will accept all bpf programs that were accepted by
+the earlier versions.
+
 
 Instruction level questions
 ---------------------------
-- 
2.20.0

