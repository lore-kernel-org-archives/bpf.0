Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE344C10F0E
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 21:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6DD2054F
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 21:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="erghLams"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfDRVdh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:33:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729198AbfDRVdh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Apr 2019 17:33:37 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3ILXYVg024702
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2019 14:33:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kEeO1sf7u7+geH2FxXfmUFdf50wrvTmZ9NT8DhDcdcE=;
 b=erghLamsAyqHTqRXb5GmL+kPkaai8gSZ1v52h0bHNd85FWAyd1PPCXf33jCLvOdPt3NR
 e84EAida/XCWFzQVEB4j2DdV33ag9rcEmSNXLKbWqW2Dl5nwGZmVKVxrK3F3QqtOIZ/c
 DvTVtdH5LF7d7xCvWSPultD7KwtRTDybEM8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rxqp0t6ak-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2019 14:33:35 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 18 Apr 2019 14:33:32 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8302C29432A7; Thu, 18 Apr 2019 14:33:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] bpf: Increase MAX_NR_MAPS to 17 in test_verifier.c
Date:   Thu, 18 Apr 2019 14:33:30 -0700
Message-ID: <20190418213330.225474-1-kafai@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

map_fds[16] is the last one index-ed by fixup_map_array_small.
Hence, the MAX_NR_MAPS should be 17 instead.

Fixes: fb2abb73e575 ("bpf, selftest: test {rd, wr}only flags and direct value access")
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 6cb6a1074fd1..ed9e894afef3 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -52,7 +52,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	16
+#define MAX_NR_MAPS	17
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
-- 
2.17.1

