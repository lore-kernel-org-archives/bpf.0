Return-Path: <SRS0=EAyC=ZA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E2C5DF60
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 06:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6C21D6C
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573195271;
	bh=o1DX6LKBtZz9SG9LmSf0DWMEN+Rn/+WQDj4etxnPyh0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BVJXAIPQ+77o5GYQ/9iD3QD6UrD0I8Ath6hkqE3AmE0YhLmOoZBc5soGs3Pz0jqBf
	 NdXDitcB6ZRVdLKnYpDdpG8D8AuD/mMeLNdGJH6rDC8TM6QLLNeCpo4J2Oa0XttZOS
	 bQGjkndkMkcV9XPDLpF4V13/9BDEeTI3gIbIq754=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfKHGlD convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 8 Nov 2019 01:41:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730047AbfKHGlD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Nov 2019 01:41:03 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA86Y343024079
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 22:41:02 -0800
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41vy1w3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 22:41:02 -0800
Received: from 2401:db00:2050:5102:face:0:3b:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 7 Nov 2019 22:41:00 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id C857D760F61; Thu,  7 Nov 2019 22:40:59 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 10/18] selftests/bpf: Add combined fentry/fexit test
Date:   Thu, 7 Nov 2019 22:40:31 -0800
Message-ID: <20191108064039.2041889-11-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108064039.2041889-1-ast@kernel.org>
References: <20191108064039.2041889-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-08_01:2019-11-07,2019-11-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1034 mlxscore=0
 suspectscore=1 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=855
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080063
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a combined fentry/fexit test.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/fentry_fexit.c   | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_fexit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
new file mode 100644
index 000000000000..40bcff2cc274
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+#include <test_progs.h>
+
+void test_fentry_fexit(void)
+{
+	struct bpf_prog_load_attr attr_fentry = {
+		.file = "./fentry_test.o",
+	};
+	struct bpf_prog_load_attr attr_fexit = {
+		.file = "./fexit_test.o",
+	};
+
+	struct bpf_object *obj_fentry = NULL, *obj_fexit = NULL, *pkt_obj;
+	struct bpf_map *data_map_fentry, *data_map_fexit;
+	char fentry_name[] = "fentry/bpf_fentry_testX";
+	char fexit_name[] = "fexit/bpf_fentry_testX";
+	int err, pkt_fd, kfree_skb_fd, i;
+	struct bpf_link *link[12] = {};
+	struct bpf_program *prog[12];
+	__u32 duration, retval;
+	const int zero = 0;
+	u64 result[12];
+
+	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_SCHED_CLS,
+			    &pkt_obj, &pkt_fd);
+	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
+		return;
+	err = bpf_prog_load_xattr(&attr_fentry, &obj_fentry, &kfree_skb_fd);
+	if (CHECK(err, "prog_load fail", "err %d errno %d\n", err, errno))
+		goto close_prog;
+	err = bpf_prog_load_xattr(&attr_fexit, &obj_fexit, &kfree_skb_fd);
+	if (CHECK(err, "prog_load fail", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	for (i = 0; i < 6; i++) {
+		fentry_name[sizeof(fentry_name) - 2] = '1' + i;
+		prog[i] = bpf_object__find_program_by_title(obj_fentry, fentry_name);
+		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", fentry_name))
+			goto close_prog;
+		link[i] = bpf_program__attach_trace(prog[i]);
+		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
+			goto close_prog;
+	}
+	data_map_fentry = bpf_object__find_map_by_name(obj_fentry, "fentry_t.bss");
+	if (CHECK(!data_map_fentry, "find_data_map", "data map not found\n"))
+		goto close_prog;
+
+	for (i = 6; i < 12; i++) {
+		fexit_name[sizeof(fexit_name) - 2] = '1' + i - 6;
+		prog[i] = bpf_object__find_program_by_title(obj_fexit, fexit_name);
+		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", fexit_name))
+			goto close_prog;
+		link[i] = bpf_program__attach_trace(prog[i]);
+		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
+			goto close_prog;
+	}
+	data_map_fexit = bpf_object__find_map_by_name(obj_fexit, "fexit_te.bss");
+	if (CHECK(!data_map_fexit, "find_data_map", "data map not found\n"))
+		goto close_prog;
+
+	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "ipv6",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	err = bpf_map_lookup_elem(bpf_map__fd(data_map_fentry), &zero, &result);
+	if (CHECK(err, "get_result",
+		  "failed to get output data: %d\n", err))
+		goto close_prog;
+
+	err = bpf_map_lookup_elem(bpf_map__fd(data_map_fexit), &zero, result + 6);
+	if (CHECK(err, "get_result",
+		  "failed to get output data: %d\n", err))
+		goto close_prog;
+
+	for (i = 0; i < 12; i++)
+		if (CHECK(result[i] != 1, "result", "bpf_fentry_test%d failed err %ld\n",
+			  i % 6 + 1, result[i]))
+			goto close_prog;
+
+close_prog:
+	for (i = 0; i < 12; i++)
+		if (!IS_ERR_OR_NULL(link[i]))
+			bpf_link__destroy(link[i]);
+	bpf_object__close(obj_fentry);
+	bpf_object__close(obj_fexit);
+	bpf_object__close(pkt_obj);
+}
-- 
2.23.0

