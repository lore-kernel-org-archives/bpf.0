Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE30C74A5B
	for <bpf@archiver.kernel.org>; Thu, 30 Mar 2023 04:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjC3ESM convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 30 Mar 2023 00:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjC3ESJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 00:18:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2CA5B8E
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:08 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKZgxK025004
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:08 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvg5a963-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 21:18:07 -0700
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 21:18:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E70092C6766D1; Wed, 29 Mar 2023 21:17:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>, <lmb@isovalent.com>, <timo@incline.eu>,
        <robin.goegge@isovalent.com>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 3/8] bpf: avoid incorrect -EFAULT error in BPF_LOG_KERNEL mode
Date:   Wed, 29 Mar 2023 21:16:37 -0700
Message-ID: <20230330041642.1118787-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330041642.1118787-1-andrii@kernel.org>
References: <20230330041642.1118787-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Pi3Zgdi6uvRXNNmml6yuiHtdBuwn7D4A
X-Proofpoint-ORIG-GUID: Pi3Zgdi6uvRXNNmml6yuiHtdBuwn7D4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_16,2023-03-28_02,2023-02-09_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If verifier log is in BPF_LOG_KERNEL mode, no log->ubuf is expected and
it stays NULL throughout entire verification process. Don't erroneously
return -EFAULT in such case.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e121c6c13635..82a5876940aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18789,7 +18789,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	bpf_vlog_finalize(log);
 	if (log->level && bpf_vlog_truncated(log))
 		ret = -ENOSPC;
-	if (log->level && !log->ubuf) {
+	if (log->level && log->level != BPF_LOG_KERNEL && !log->ubuf) {
 		ret = -EFAULT;
 		goto err_release_maps;
 	}
-- 
2.34.1

