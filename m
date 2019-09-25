Return-Path: <SRS0=z77e=XU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1876C4360D
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 18:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C33A20665
	for <bpf@archiver.kernel.org>; Wed, 25 Sep 2019 18:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DNb1HrRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443214AbfIYSgW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:36:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437947AbfIYSgV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Sep 2019 14:36:21 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PIWROT014691
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 11:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Ear7GfKILach6yoGbb72lYTgVj5pCczuKiQlm5U2re4=;
 b=DNb1HrRzzairRl+htUL/TX+tJX6oNJbZTTosZJ63vNWeQ/Vk81zTi7hzmZzwytBhyHYW
 IPIvQRFCAvgMI53e7EBCqO/v2laSdHpc2evmh9yQwYRhrvLpuB3d6z2NTLaiBZ0U7B5i
 3uEulAUu85rOV3hHg0tifPjtiLO3yAY8BnI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v8abh94b3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 11:36:21 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Sep 2019 11:36:18 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 103E68619CB; Wed, 25 Sep 2019 11:36:17 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf] selftests/bpf: delete unused variables in test_sysctl
Date:   Wed, 25 Sep 2019 11:36:14 -0700
Message-ID: <20190925183614.2775293-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_08:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 suspectscore=8 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxlogscore=563 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909250158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove no longer used variables and avoid compiler warnings.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index 4f8ec1f10a80..a320e3844b17 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -1385,7 +1385,6 @@ static int fixup_sysctl_value(const char *buf, size_t buf_len,
 		uint8_t raw[sizeof(uint64_t)];
 		uint64_t num;
 	} value = {};
-	uint8_t c, i;
 
 	if (buf_len > sizeof(value)) {
 		log_err("Value is too big (%zd) to use in fixup", buf_len);
-- 
2.17.1

