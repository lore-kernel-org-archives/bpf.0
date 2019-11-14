Return-Path: <SRS0=h7mW=ZG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1128C43141
	for <bpf@archiver.kernel.org>; Thu, 14 Nov 2019 18:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BE72071B
	for <bpf@archiver.kernel.org>; Thu, 14 Nov 2019 18:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573757892;
	bh=odyGhZy7Gn7aCg3XJKdHGR9aDD/W4XRMfcyZKyowjrE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVH4K7+c3lQ78AVIVtzfd3oSV9G7I3Rw8K3lt/bqiB/nCaoit3s2I+8u9ghs5MNEH
	 E5npKMiIjdv5cDBbZTzrYQudwC9qehOCJNCrl89wv1i9DDXeUSrR/+fn9Jc+36cnrM
	 DtYT4VfM5FoTLL/HAwRGb8Yd488GNtDcyJf4VBIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKNS6L convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 14 Nov 2019 13:58:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17330 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbfKNS6G (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Nov 2019 13:58:06 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEIdSUj001183
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:58:05 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w90t83j0c-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 10:58:05 -0800
Received: from 2401:db00:2050:5076:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 10:58:03 -0800
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 0B90C76071B; Thu, 14 Nov 2019 10:58:02 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <x86@kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 bpf-next 20/20] selftests/bpf: Add a test for attaching BPF prog to another BPF prog and subprog
Date:   Thu, 14 Nov 2019 10:57:20 -0800
Message-ID: <20191114185720.1641606-21-ast@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114185720.1641606-1-ast@kernel.org>
References: <20191114185720.1641606-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 mlxlogscore=781 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test that attaches one FEXIT program to main sched_cls networking program
and two other FEXIT programs to subprograms. All three tracing programs
access return values and skb->len of networking program and subprograms.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 76 ++++++++++++++++
 .../selftests/bpf/progs/fexit_bpf2bpf.c       | 91 +++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
new file mode 100644
index 000000000000..15c7378362dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+#include <test_progs.h>
+
+#define PROG_CNT 3
+
+void test_fexit_bpf2bpf(void)
+{
+	const char *prog_name[PROG_CNT] = {
+		"fexit/test_pkt_access",
+		"fexit/test_pkt_access_subprog1",
+		"fexit/test_pkt_access_subprog2",
+	};
+	struct bpf_object *obj = NULL, *pkt_obj;
+	int err, pkt_fd, i;
+	struct bpf_link *link[PROG_CNT] = {};
+	struct bpf_program *prog[PROG_CNT];
+	__u32 duration, retval;
+	struct bpf_map *data_map;
+	const int zero = 0;
+	u64 result[PROG_CNT];
+
+	err = bpf_prog_load("./test_pkt_access.o", BPF_PROG_TYPE_UNSPEC,
+			    &pkt_obj, &pkt_fd);
+	if (CHECK(err, "prog_load sched cls", "err %d errno %d\n", err, errno))
+		return;
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+			    .attach_prog_fd = pkt_fd,
+			   );
+
+	obj = bpf_object__open_file("./fexit_bpf2bpf.o", &opts);
+	if (CHECK(IS_ERR_OR_NULL(obj), "obj_open",
+		  "failed to open fexit_bpf2bpf: %ld\n",
+		  PTR_ERR(obj)))
+		goto close_prog;
+
+	err = bpf_object__load(obj);
+	if (CHECK(err, "obj_load", "err %d\n", err))
+		goto close_prog;
+
+	for (i = 0; i < PROG_CNT; i++) {
+		prog[i] = bpf_object__find_program_by_title(obj, prog_name[i]);
+		if (CHECK(!prog[i], "find_prog", "prog %s not found\n", prog_name[i]))
+			goto close_prog;
+		link[i] = bpf_program__attach_trace(prog[i]);
+		if (CHECK(IS_ERR(link[i]), "attach_trace", "failed to link\n"))
+			goto close_prog;
+	}
+	data_map = bpf_object__find_map_by_name(obj, "fexit_bp.bss");
+	if (CHECK(!data_map, "find_data_map", "data map not found\n"))
+		goto close_prog;
+
+	err = bpf_prog_test_run(pkt_fd, 1, &pkt_v6, sizeof(pkt_v6),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "ipv6",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	err = bpf_map_lookup_elem(bpf_map__fd(data_map), &zero, &result);
+	if (CHECK(err, "get_result",
+		  "failed to get output data: %d\n", err))
+		goto close_prog;
+
+	for (i = 0; i < PROG_CNT; i++)
+		if (CHECK(result[i] != 1, "result", "fexit_bpf2bpf failed err %ld\n",
+			  result[i]))
+			goto close_prog;
+
+close_prog:
+	for (i = 0; i < PROG_CNT; i++)
+		if (!IS_ERR_OR_NULL(link[i]))
+			bpf_link__destroy(link[i]);
+	if (!IS_ERR_OR_NULL(obj))
+		bpf_object__close(obj);
+	bpf_object__close(pkt_obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
new file mode 100644
index 000000000000..981f0474da5a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+
+struct sk_buff {
+	unsigned int len;
+};
+
+struct args {
+	struct sk_buff *skb;
+	ks32 ret;
+};
+static volatile __u64 test_result;
+SEC("fexit/test_pkt_access")
+int test_main(struct args *ctx)
+{
+	struct sk_buff *skb = ctx->skb;
+	int len;
+
+	__builtin_preserve_access_index(({
+		len = skb->len;
+	}));
+	if (len != 74 || ctx->ret != 0)
+		return 0;
+	test_result = 1;
+	return 0;
+}
+
+struct args_subprog1 {
+	struct sk_buff *skb;
+	ks32 ret;
+};
+static volatile __u64 test_result_subprog1;
+SEC("fexit/test_pkt_access_subprog1")
+int test_subprog1(struct args_subprog1 *ctx)
+{
+	struct sk_buff *skb = ctx->skb;
+	int len;
+
+	__builtin_preserve_access_index(({
+		len = skb->len;
+	}));
+	if (len != 74 || ctx->ret != 148)
+		return 0;
+	test_result_subprog1 = 1;
+	return 0;
+}
+
+/* Though test_pkt_access_subprog2() is defined in C as:
+ * static __attribute__ ((noinline))
+ * int test_pkt_access_subprog2(int val, volatile struct __sk_buff *skb)
+ * {
+ *     return skb->len * val;
+ * }
+ * llvm optimizations remove 'int val' argument and generate BPF assembly:
+ *   r0 = *(u32 *)(r1 + 0)
+ *   w0 <<= 1
+ *   exit
+ * In such case the verifier falls back to conservative and
+ * tracing program can access arguments and return value as u64
+ * instead of accurate types.
+ */
+struct args_subprog2 {
+	ku64 args[5];
+	ku64 ret;
+};
+static volatile __u64 test_result_subprog2;
+SEC("fexit/test_pkt_access_subprog2")
+int test_subprog2(struct args_subprog2 *ctx)
+{
+	struct sk_buff *skb = (void *)ctx->args[0];
+	__u64 ret;
+	int len;
+
+	bpf_probe_read_kernel(&len, sizeof(len),
+			      __builtin_preserve_access_index(&skb->len));
+
+	ret = ctx->ret;
+	/* bpf_prog_load() loads "test_pkt_access.o" with BPF_F_TEST_RND_HI32
+	 * which randomizes upper 32 bits after BPF_ALU32 insns.
+	 * Hence after 'w0 <<= 1' upper bits of $rax are random.
+	 * That is expected and correct. Trim them.
+	 */
+	ret = (__u32) ret;
+	if (len != 74 || ret != 148)
+		return 0;
+	test_result_subprog2 = 1;
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
-- 
2.23.0

