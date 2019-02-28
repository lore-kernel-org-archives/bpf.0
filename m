Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C01C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B68F20830
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VIhuLsgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfB1Xbo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731684AbfB1Xbn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 18:31:43 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SNUl7Q010662
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Hjm+nav2XKcsjHNzDeGspPZAHnnk3L/rZd88etbaJtA=;
 b=VIhuLsgbxd3iRn1kGK2nu5aSe9MeR4iy0fypUfwP0Widvk1S8QQNRnboJDWygHjFA6Vn
 ugNXeiShVlyskE8OLCbERY2tLCxsnzgwSWnKoWNw6tTpxL/Ma2CFu8Z/U6cft4l+uzV9
 R8cNIpbNapZPasuGcdja1zpOFUe/oGhgi4E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qxqu30b1a-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:43 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 28 Feb 2019 15:31:27 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id C6C30C155DDA; Thu, 28 Feb 2019 15:31:26 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
Date:   Thu, 28 Feb 2019 15:31:21 -0800
Message-ID: <20190228233125.1013080-2-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228233125.1013080-1-andriin@fb.com>
References: <20190228233125.1013080-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_dedup testing code doesn't account for length of struct btf_header
when calculating the start of a string section. This patch fixes this
problem.

Fixes: 49b57e0d01db ("tools/bpf: remove btf__get_strings() superseded by raw data API")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 tools/testing/selftests/bpf/test_btf.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e47168d1257d..3b74d23fffab 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -14,6 +14,7 @@ feature
 test_libbpf_open
 test_sock
 test_sock_addr
+test_sock_fields
 urandom_read
 test_btf
 test_sockmap
diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 02d314383a9c..1426c0a905c8 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -5936,9 +5936,9 @@ static int do_test_dedup(unsigned int test_num)
 	}
 
 	test_hdr = test_btf_data;
-	test_strs = test_btf_data + test_hdr->str_off;
+	test_strs = test_btf_data + sizeof(*test_hdr) + test_hdr->str_off;
 	expect_hdr = expect_btf_data;
-	expect_strs = expect_btf_data + expect_hdr->str_off;
+	expect_strs = expect_btf_data + sizeof(*test_hdr) + expect_hdr->str_off;
 	if (CHECK(test_hdr->str_len != expect_hdr->str_len,
 		  "test_hdr->str_len:%u != expect_hdr->str_len:%u",
 		  test_hdr->str_len, expect_hdr->str_len)) {
-- 
2.17.1

