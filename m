Return-Path: <SRS0=I0lg=WT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71363C3A5A6
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 05:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB8A22CF7
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566539544;
	bh=Og/xt8BQU5dbgRIZodD/rQ6MT4K5IHGgMTwPGSoeFQk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EtkDQdQGXdj74w0GG8CpdnrjMyqA9rGYLRxpXJ+WOfOxexi/YsnX6xmHAiFaDekTg
	 Y2TfrU5a3po1yZMCAz0ZFGsae3kHxYeZ8U+cipyTRZ6ncOvcatv6ynX9QfoEtEjhvs
	 8EtHg5vhdmeeFNjkEcBVkHK2x2N0sTsh+GBYLHzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391856AbfHWFwX convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 23 Aug 2019 01:52:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61212 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391970AbfHWFwW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Aug 2019 01:52:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N5lW9O026454
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 22:52:21 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uj42k97fe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 22:52:21 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 22 Aug 2019 22:52:20 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id D0E7B760BEC; Thu, 22 Aug 2019 22:52:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/4] tools/bpf: sync bpf.h
Date:   Thu, 22 Aug 2019 22:52:13 -0700
Message-ID: <20190823055215.2658669-3-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190823055215.2658669-1-ast@kernel.org>
References: <20190823055215.2658669-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=624 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230063
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

sync bpf.h from kernel/ to tools/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b5889257cc33..5d2fb183ee2d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -285,6 +285,9 @@ enum bpf_attach_type {
  */
 #define BPF_F_TEST_RND_HI32	(1U << 2)
 
+/* The verifier internal test flag. Behavior is undefined */
+#define BPF_F_TEST_STATE_FREQ	(1U << 3)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * two extensions:
  *
-- 
2.20.0

