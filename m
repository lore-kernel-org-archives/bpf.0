Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4273AB262
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667482; cv=none; b=TZ6uEYaJcbZYuf9AXn4XTPKe3I6w2OUoOpHO3a6VEmTZihpNhRZiBWw5q25V+plzJEX1FFAGoS6aEVS8zIvglrq+EezkxhoY2SnSmaJD/GQ+6t6j7pA41hKKf2C1ybratnwYuoyEjmy+YtpvcrsbtbNDM4mpCQRADKXU1aTbXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667482; c=relaxed/simple;
	bh=xEF5LvtyRUwN9VseYA2I4NUSQgAy87IRQ2StV51M4vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUiqlRo9cdlMftuz8atdKw9VUZt5doojQqknW4qyViAbgLPdq3FO4CCY8rTT46lz8IWliR9nyVrU74/hAKvdj80Gpws5HGcjsnysrrpQhLBzPaw5rTmxnCQqvzxL6Y43kZ8/lnVqc8ok3TPWyJwQ0AR5IqE3IGe2ZtffxFYhvyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G3V7IBuX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3V7IBuX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638DMPqf725743;
	Wed, 8 Apr 2026 16:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=++XMv
	TAVReZRsuTvXd1lo5K+BVjKWrpQiuYDmN8dKNE=; b=G3V7IBuX6Z0sdEtl/mDSp
	kkKqX3dV6MPn3pQag3pXgKb04QHjLpt2YWwe9SKp6u40OEQLtRAPS/tqtr4frUrU
	+KZENrgO3t8s2FUkQJ8/+Wj+LtngLPlHmE/xQt2B2e+SBy5K2844ioW6AM00FqmJ
	R111DzaNmcFn/pUpc3uvsm9YKYhh3pC2MjzUS0hixZv+hMnPAj5cqA7+BjJCnd3a
	/C/tFZYM6Zc4jVkercklhGda6SU1xSMMeGqr4mIbW1atJwWZqX/d7jh3noxUrlvF
	FxDd1dkq98F3aFk0pHpS5PJh2qatL5VCE3qTPRIloNXlITKC2+og61hPxWyZL0pk
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqebvkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638F9wAi026134;
	Wed, 8 Apr 2026 16:57:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmebhqtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638GvboC025438;
	Wed, 8 Apr 2026 16:57:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-176.vpn.oracle.com [10.154.48.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dcmebhqmb-3;
	Wed, 08 Apr 2026 16:57:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add BTF sanitize test covering BTF layout
Date: Wed,  8 Apr 2026 17:57:35 +0100
Message-ID: <20260408165735.843763-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260408165735.843763-1-alan.maguire@oracle.com>
References: <20260408165735.843763-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080157
X-Authority-Analysis: v=2.4 cv=MtJiLWae c=1 sm=1 tr=0 ts=69d68906 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=uTUuzrmDwOiJP4hIRfUA:9 cc=ntf
 awl=host:12292
X-Proofpoint-GUID: eBvBUnspgW6AJu7FYOYp7gLOX52KqDur
X-Proofpoint-ORIG-GUID: eBvBUnspgW6AJu7FYOYp7gLOX52KqDur
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NyBTYWx0ZWRfX/qFR1UkPIrCO
 owmloZLprsTOQaocWomxChzdoljtUC4gn0tPT17DkcdbQZcAW/Gpl9S8/8TQ2U1mmVJ6iDK36nY
 Mz/BBdy612QDJ3dLs/nTBTCpoIrC9tKkaKMjr6gbg+5sCDdFMDDuGwyOskwsBama0GhFL8pf4hM
 CuPhPYjkZc7kwVTANq+79wO1kr+KQlju1vwnBv+gUHFcyoGBMbWeZwXXwTNKVcDu/triqW63KK+
 wBlQvKEfR/t2WK3CwCaZxUPosHUktsUwGMi3Hw3IRvqGU3tjhRBicpLxGivc33vUsJxDDse3iyw
 ewLjcyisPT1RkUa1syJkngis6IbESuPnrVheCbae84bA8SX3UWWixgLYc7l+gwLkqZTYfku/Rrs
 fsG5dEwMYLZnHQGpt7RsQph4VxoHfJY0oren4tyyTpOZ1tafzFU8A7Sx7QVMTnMCFGsPWnF13mE
 6qrjnN0j3Yv2wFsNgMmZ89P8S/5ONhDaGhwa/wQs=

Add test that fakes up a feature cache of supported BPF
features to simulate an older kernel that does not support
BTF layout information.  Ensure that BTF is sanitized correctly
to remove layout info between types and strings, and that all
offsets and lengths are adjusted appropriately.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
new file mode 100644
index 000000000000..652b51efafc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+#include <test_progs.h>
+#include <linux/btf.h>
+#include "bpf/libbpf_internal.h"
+#include "../test_btf.h"
+#include "kfree_skb.skel.h"
+
+#define TYPE_LEN	(sizeof(struct btf_type) + sizeof(__u32))
+#define MAX_NR_LAYOUT	2
+#define LAYOUT_LEN	(sizeof(struct btf_layout) * MAX_NR_LAYOUT)
+#define STR_LEN		sizeof("\0int")
+
+struct layout_btf {
+	struct btf_header hdr;
+	__u32 types[TYPE_LEN/sizeof(__u32)];
+	struct btf_layout layout[MAX_NR_LAYOUT];
+	char strs[STR_LEN];
+};
+
+static const struct layout_btf layout_btf = {
+	.hdr = {
+		.magic		= BTF_MAGIC,
+		.version	= BTF_VERSION,
+		.hdr_len	= sizeof(struct btf_header),
+		.type_off	= 0,
+		.type_len	= TYPE_LEN,
+		.str_off	= TYPE_LEN + LAYOUT_LEN,
+		.str_len	= STR_LEN,
+		.layout_off	= TYPE_LEN,
+		.layout_len	= LAYOUT_LEN,
+	},
+	.types = {
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+	},
+	.layout = {
+		{ .info_sz = 0,          .elem_sz = 0, .flags = 0 },
+		{ .info_sz = sizeof(__u32), .elem_sz = 0, .flags = 0 },
+	},
+	.strs = "\0int",
+};
+
+void test_btf_sanitize_layout(void)
+{
+	struct btf *orig = NULL, *sanitized = NULL;
+	struct kern_feature_cache *cache = NULL;
+	struct kfree_skb *skel = NULL;
+	const struct btf_header *hdr;
+	const void *raw;
+	__u32 raw_sz;
+
+	skel = kfree_skb__open();
+	if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
+		return;
+	orig = btf__new(&layout_btf, sizeof(layout_btf));
+	if (!ASSERT_OK_PTR(orig, "btf_new_layout"))
+		goto out;
+	raw = btf__raw_data(orig, &raw_sz);
+	if (!ASSERT_OK_PTR(raw, "btf__raw_data_orig"))
+		goto out;
+	hdr = (struct btf_header *)raw;
+	ASSERT_EQ(hdr->layout_off, TYPE_LEN, "layout_off_nonzero");
+	ASSERT_EQ(hdr->layout_len, LAYOUT_LEN, "layout_len_nonzero");
+
+	cache = calloc(1, sizeof(*cache));
+	if (!ASSERT_OK_PTR(cache, "alloc_feat_cache"))
+		goto out;
+	for (int i = 0; i < __FEAT_CNT; i++)
+		cache->res[i] = FEAT_SUPPORTED;
+	cache->res[FEAT_BTF_LAYOUT] = FEAT_MISSING;
+
+	bpf_object_set_feat_cache(skel->obj, cache);
+
+	if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_LAYOUT), "layout_feature_missing"))
+		goto out;
+	if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC), "other_feature_allowed"))
+		goto out;
+
+	sanitized = bpf_object__sanitize_btf(skel->obj, orig);
+	if (!ASSERT_OK_PTR(sanitized, "bpf_object__sanitize_btf"))
+		goto out;
+
+	raw = btf__raw_data(sanitized, &raw_sz);
+	if (!ASSERT_OK_PTR(raw, "btf__raw_data_sanitized"))
+		goto out;
+	hdr = (struct btf_header *)raw;
+	ASSERT_EQ(hdr->layout_off, 0, "layout_off_zero");
+	ASSERT_EQ(hdr->layout_len, 0, "layout_len_zero");
+	ASSERT_EQ(hdr->str_off, TYPE_LEN, "strs_after_types");
+	ASSERT_EQ(hdr->str_len, STR_LEN, "strs_len_unchanged");
+	ASSERT_EQ(raw_sz, hdr->hdr_len + hdr->type_len + hdr->str_len, "btf_raw_sz_reduced");
+out:
+	/* This will free the cache we allocated above */
+	kfree_skb__destroy(skel);
+	btf__free(sanitized);
+	btf__free(orig);
+}
-- 
2.39.3

