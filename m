Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DDC4332F
	for <bpf@archiver.kernel.org>; Wed, 21 Dec 2022 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiLUSBU convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 21 Dec 2022 13:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiLUSBG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 13:01:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F16E92
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:01:05 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHog59019916
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:01:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mk23et1a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:01:04 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 21 Dec 2022 10:01:03 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 786DB23D3469D; Wed, 21 Dec 2022 10:00:51 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: start v1.2 development cycle
Date:   Wed, 21 Dec 2022 10:00:49 -0800
Message-ID: <20221221180049.853365-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bUm_gYAAOy7bB_WcbHnNd3A7tl0aF3-l
X-Proofpoint-ORIG-GUID: bUm_gYAAOy7bB_WcbHnNd3A7tl0aF3-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bump current version for new development cycle to v1.2.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.map       | 3 +++
 tools/lib/bpf/libbpf_version.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 71bf5691a689..11c36a3c1a9f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -382,3 +382,6 @@ LIBBPF_1.1.0 {
 		user_ring_buffer__reserve_blocking;
 		user_ring_buffer__submit;
 } LIBBPF_1.0.0;
+
+LIBBPF_1.2.0 {
+} LIBBPF_1.1.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index e944f5bce728..1fd2eeac5cfc 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 1
+#define LIBBPF_MINOR_VERSION 2
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.30.2

