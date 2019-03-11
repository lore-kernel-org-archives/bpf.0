Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C3C10F03
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D62620652
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 00:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZAbBZf4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCKAoW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:44:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36214 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfCKAoW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Mar 2019 20:44:22 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B0c3K4022173
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=C0Wk7jHEZ4FzxaP5ltLI2FYi6Q4gma5Zqx2py/MQkwo=;
 b=ZAbBZf4FVsVGfgDOL6j5w4oQv7t72ZnqKFsAEjPbz6AWmpOBCJaFmDMYAn0c5wAqaESE
 u43ud5a+c3FMlHlCnSpdjnuHID6My90CiB2AYDg1NC17qa52cNh0e1RAUK1VeLA/gj3U
 JQIy5VoajkBquf1eGw+PlMS1C/UFt+d5QH0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r59f80d93-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2019 17:44:21 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sun, 10 Mar 2019 17:44:19 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id D0E73861444; Sun, 10 Mar 2019 17:44:16 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 2/2] selftests/bpf: add fwd enum resolution test for btf_dedup
Date:   Sun, 10 Mar 2019 17:44:10 -0700
Message-ID: <20190311004410.3896503-3-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311004410.3896503-1-andriin@fb.com>
References: <20190311004410.3896503-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_20:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds test verifying new btf_dedup logic of resolving
forward-declared enums.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/test_btf.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
index 38797aa627a7..23e3b314ca60 100644
--- a/tools/testing/selftests/bpf/test_btf.c
+++ b/tools/testing/selftests/bpf/test_btf.c
@@ -5874,6 +5874,50 @@ const struct btf_dedup_test dedup_tests[] = {
 		.dont_resolve_fwds = false,
 	},
 },
+{
+	.descr = "dedup: enum fwd resolution",
+	.input = {
+		.raw_types = {
+			/* [1] fwd enum 'e1' before full enum */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 4),
+			/* [2] full enum 'e1' after fwd */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 123),
+			/* [3] full enum 'e2' before fwd */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(4), 456),
+			/* [4] fwd enum 'e2' after full enum */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 4),
+			/* [5] incompatible fwd enum with different size */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 1),
+			/* [6] incompatible full enum with different value */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 321),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0e2\0e2_val"),
+	},
+	.expect = {
+		.raw_types = {
+			/* [1] full enum 'e1' */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 123),
+			/* [2] full enum 'e2' */
+			BTF_TYPE_ENC(NAME_NTH(3), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(4), 456),
+			/* [3] incompatible fwd enum with different size */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 0), 1),
+			/* [4] incompatible full enum with different value */
+			BTF_TYPE_ENC(NAME_NTH(1), BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4),
+				BTF_ENUM_ENC(NAME_NTH(2), 321),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0e1\0e1_val\0e2\0e2_val"),
+	},
+	.opts = {
+		.dont_resolve_fwds = false,
+	},
+},
 
 };
 
-- 
2.17.1

