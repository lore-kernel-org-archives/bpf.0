Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8A6C4332F
	for <bpf@archiver.kernel.org>; Mon, 21 Mar 2022 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351934AbiCUSBs convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 21 Mar 2022 14:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351927AbiCUSBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 14:01:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25515BD36
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:22 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LEDdfx030300
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:22 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3extxgt309-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 11:00:22 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 11:00:18 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 7918D2DBF271; Mon, 21 Mar 2022 11:00:15 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next 2/2] bpf: fix bpf_prog_pack when PMU_SIZE is not defined
Date:   Mon, 21 Mar 2022 11:00:09 -0700
Message-ID: <20220321180009.1944482-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321180009.1944482-1-song@kernel.org>
References: <20220321180009.1944482-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Z-dSHpcc9rTeR_tz1oIaDWJ9uF9HgWum
X-Proofpoint-GUID: Z-dSHpcc9rTeR_tz1oIaDWJ9uF9HgWum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_07,2022-03-21_01,2022-02-23_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PMD_SIZE is not available in some special config, e.g. ARCH=arm with
CONFIG_MMU=n. Use bpf_prog_pack of PAGE_SIZE in these cases.

Fixes: ef078600eec2 ("bpf: Select proper size for bpf_prog_pack")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f6b20fcbeb24..13e9dbeeedf3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -840,12 +840,23 @@ static int bpf_prog_chunk_count(void)
 static DEFINE_MUTEX(pack_mutex);
 static LIST_HEAD(pack_list);
 
+/* PMD_SIZE is not available in some special config, e.g. ARCH=arm with
+ * CONFIG_MMU=n. Use PAGE_SIZE in these cases.
+ */
+#ifdef PMD_SIZE
+#define BPF_HPAGE_SIZE PMD_SIZE
+#define BPF_HPAGE_MASK PMD_MASK
+#else
+#define BPF_HPAGE_SIZE PAGE_SIZE
+#define BPF_HPAGE_MASK PAGE_MASK
+#endif
+
 static size_t select_bpf_prog_pack_size(void)
 {
 	size_t size;
 	void *ptr;
 
-	size = PMD_SIZE * num_online_nodes();
+	size = BPF_HPAGE_SIZE * num_online_nodes();
 	ptr = module_alloc(size);
 
 	/* Test whether we can get huge pages. If not just use PAGE_SIZE
@@ -855,7 +866,7 @@ static size_t select_bpf_prog_pack_size(void)
 		size = PAGE_SIZE;
 		bpf_prog_pack_mask = PAGE_MASK;
 	} else {
-		bpf_prog_pack_mask = PMD_MASK;
+		bpf_prog_pack_mask = BPF_HPAGE_MASK;
 	}
 
 	vfree(ptr);
-- 
2.30.2

