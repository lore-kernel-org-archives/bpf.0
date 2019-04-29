Return-Path: <SRS0=6T6/=S7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB7C43219
	for <bpf@archiver.kernel.org>; Mon, 29 Apr 2019 23:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673D215EA
	for <bpf@archiver.kernel.org>; Mon, 29 Apr 2019 23:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lN3kRjA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfD2X7n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:59:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47522 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728844AbfD2X7n (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 29 Apr 2019 19:59:43 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3TNq4fV018148
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 16:59:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=2wMCErr0sND7f1nPIJ6IsOlqNybTQX/QdARsf/EQBJc=;
 b=lN3kRjA2thGLKMsFbOc9bQWSFmQtDxG2DKXFw14xvE+RksJe1GpCi/wa0gK5U2Vcr+9+
 Q/WhOJDPyTgt1j/AkXdrhsBSAeg1M6zOSDGviTt0aZzTj82q2W1FlfBApDZU1iPIX8ja
 H8YM6uM39bpBJq0t5npHorE3drt90ZyERk0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2s4jrcf5g0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2019 16:59:42 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Apr 2019 16:59:41 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D51373702EE7; Mon, 29 Apr 2019 16:59:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: set RLIMIT_MEMLOCK properly for test_libbpf_open.c
Date:   Mon, 29 Apr 2019 16:59:38 -0700
Message-ID: <20190429235938.392833-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=699 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904290155
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test test_libbpf.sh failed on my development server with failure
  -bash-4.4$ sudo ./test_libbpf.sh
  [0] libbpf: Error in bpf_object__probe_name():Operation not permitted(1).
      Couldn't load basic 'r0 = 0' BPF program.
  test_libbpf: failed at file test_l4lb.o
  selftests: test_libbpf [FAILED]
  -bash-4.4$

The reason is because my machine has 64KB locked memory by default which
is not enough for this program to get locked memory.
Similar to other bpf selftests, let us increase RLIMIT_MEMLOCK
to infinity, which fixed the issue.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/test_libbpf_open.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_libbpf_open.c b/tools/testing/selftests/bpf/test_libbpf_open.c
index 65cbd30704b5..9e9db202d218 100644
--- a/tools/testing/selftests/bpf/test_libbpf_open.c
+++ b/tools/testing/selftests/bpf/test_libbpf_open.c
@@ -11,6 +11,8 @@ static const char *__doc__ =
 #include <bpf/libbpf.h>
 #include <getopt.h>
 
+#include "bpf_rlimit.h"
+
 static const struct option long_options[] = {
 	{"help",	no_argument,		NULL, 'h' },
 	{"debug",	no_argument,		NULL, 'D' },
-- 
2.17.1

