Return-Path: <SRS0=D/lL=2J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C42C43603
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 02:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B835222C2
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 02:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Rgnm0rYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSCQQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:16:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLSCQQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 21:16:16 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ2AkxQ021604
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:16:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=5X9LRnjdkkrXUHEHOCaug0AmzLD5X276vieUOyAxS1c=;
 b=Rgnm0rYHTwjFAlSKBH6uOU7agNARfEIXwZ791VDS7EMcuJGYCSGcqmivh/pBBSiwWwC2
 dxEaoTQivbmIDlI5FdDNWUVwC9zZo6MZrPLB7e5r/gNNmDRGBm/AMb+BcZ2b563fZbg3
 RB6ljpdmnu+Mz/Y8XzdU3Q6EFWgC4IvSjSY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wyqv4jmcw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:16:15 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 18:16:13 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 16EDD371053A; Wed, 18 Dec 2019 17:56:47 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in cgroup_attach_multi
Date:   Wed, 18 Dec 2019 17:56:03 -0800
Message-ID: <31ac56887591418c2c098fabc14ad00de008e603.1576720240.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576720240.git.rdna@fb.com>
References: <cover.1576720240.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=228 mlxscore=1 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=13 spamscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190016
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test replacing a cgroup-bpf program attached with BPF_F_ALLOW_MULTI and
possible failure modes: invalid combination of flags, invalid
replace_bpf_fd, replacing a non-attachd to specified cgroup program.

Example of program replacing:

  # gdb -q --args ./test_progs --name=cgroup_attach_multi
  ...
  Breakpoint 1, test_cgroup_attach_multi () at cgroup_attach_multi.c:227
  (gdb)
  [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
  # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
  ID       AttachType      AttachFlags     Name
  2133     egress          multi
  2134     egress          multi
  # fg
  gdb -q --args ./test_progs --name=cgroup_attach_multi
  (gdb) c
  Continuing.

  Breakpoint 2, test_cgroup_attach_multi () at cgroup_attach_multi.c:233
  (gdb)
  [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
  # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
  ID       AttachType      AttachFlags     Name
  2139     egress          multi
  2134     egress          multi

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 .../bpf/prog_tests/cgroup_attach_multi.c      | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 4eaab7435044..2ff21dbce179 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -78,7 +78,8 @@ void test_cgroup_attach_multi(void)
 {
 	__u32 prog_ids[4], prog_cnt = 0, attach_flags, saved_prog_id;
 	int cg1 = 0, cg2 = 0, cg3 = 0, cg4 = 0, cg5 = 0, key = 0;
-	int allow_prog[6] = {-1};
+	DECLARE_LIBBPF_OPTS(bpf_prog_attach_opts, attach_opts);
+	int allow_prog[7] = {-1};
 	unsigned long long value;
 	__u32 duration = 0;
 	int i = 0;
@@ -189,6 +190,52 @@ void test_cgroup_attach_multi(void)
 	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
 	CHECK_FAIL(value != 1 + 2 + 8 + 16);
 
+	/* test replace */
+
+	attach_opts.flags = BPF_F_ALLOW_OVERRIDE | BPF_F_REPLACE;
+	attach_opts.replace_prog_fd = allow_prog[0];
+	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+					 BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "fail_prog_replace_override", "unexpected success\n"))
+		goto err;
+	CHECK_FAIL(errno != EINVAL);
+
+	attach_opts.flags = BPF_F_REPLACE;
+	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+					 BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "fail_prog_replace_no_multi", "unexpected success\n"))
+		goto err;
+	CHECK_FAIL(errno != EINVAL);
+
+	attach_opts.flags = BPF_F_ALLOW_MULTI | BPF_F_REPLACE;
+	attach_opts.replace_prog_fd = -1;
+	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+					 BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "fail_prog_replace_bad_fd", "unexpected success\n"))
+		goto err;
+	CHECK_FAIL(errno != EBADF);
+
+	/* replacing a program that is not attached to cgroup should fail  */
+	attach_opts.replace_prog_fd = allow_prog[3];
+	if (CHECK(!bpf_prog_attach_xattr(allow_prog[6], cg1,
+					 BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "fail_prog_replace_no_ent", "unexpected success\n"))
+		goto err;
+	CHECK_FAIL(errno != ENOENT);
+
+	/* replace 1st from the top program */
+	attach_opts.replace_prog_fd = allow_prog[0];
+	if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
+					BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "prog_replace", "errno=%d\n", errno))
+		goto err;
+
+	value = 0;
+	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
+	CHECK_FAIL(system(PING_CMD));
+	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
+	CHECK_FAIL(value != 64 + 2 + 8 + 16);
+
 	/* detach 3rd from bottom program and ping again */
 	if (CHECK(!bpf_prog_detach2(0, cg3, BPF_CGROUP_INET_EGRESS),
 		  "fail_prog_detach_from_cg3", "unexpected success\n"))
@@ -202,7 +249,7 @@ void test_cgroup_attach_multi(void)
 	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
 	CHECK_FAIL(system(PING_CMD));
 	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
-	CHECK_FAIL(value != 1 + 2 + 16);
+	CHECK_FAIL(value != 64 + 2 + 16);
 
 	/* detach 2nd from bottom program and ping again */
 	if (CHECK(bpf_prog_detach2(-1, cg4, BPF_CGROUP_INET_EGRESS),
@@ -213,7 +260,7 @@ void test_cgroup_attach_multi(void)
 	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
 	CHECK_FAIL(system(PING_CMD));
 	CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value));
-	CHECK_FAIL(value != 1 + 2 + 4);
+	CHECK_FAIL(value != 64 + 2 + 4);
 
 	prog_cnt = 4;
 	CHECK_FAIL(bpf_prog_query(cg5, BPF_CGROUP_INET_EGRESS,
-- 
2.17.1

