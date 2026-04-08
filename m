Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F73BADAC
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645637; cv=none; b=atYZczqc0lgRQAst1GkZOhMQpnJZOiXcGUwGfo8A2jn57sfhh1XPy9vbESfpBhIL7EuALd21SIqshgU07CNe3cT9vODo9DLq02vtw26OzwPuPdoTyTtFeogAQcA0A9ZPcYujrW99sMLmHx3cUroPFgNji8/Ci1/zDBXbsvtLNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645637; c=relaxed/simple;
	bh=/35TEMNroy4ecVg8X9h79yEUc8P4usoWpQgfWXMKqmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLdwtG1X+B9wVN7BFuf4UI1rZqIuq8n2X2jK9URVcue5lInYZZT8e0NCEvsAcmNxFPabzts/rwBRJPFyWne6dtDxNBEq53aL0gDlNG7/QDvm6JjmCy46xITMfZbVl4EKSKNYbk8glKS7pvI7HJzw/IPgAsRN0ABxcLbqqI7Po+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rvbKS7ys; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rvbKS7ys"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638891nE1227705;
	Wed, 8 Apr 2026 10:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iFDhZ
	h5+finOoYu0T9cjz6YHOxOl4fvGz/AtaaGnGEA=; b=rvbKS7ys8y1Psh7q+51DC
	4GSxN+ElhkcxcHVDHuyCUu3DCfBKBDZ94otGac0vfWq6+fsndN+8xKeSQrmuRGaB
	R8k2v4y1Zk/ifQfMyZMTsJvQPylqvMmFwWdcZHlkFCC6QlpL+sA5jtAP1+WuMTsl
	7ijfC3Qm4/t8Rb/rv6+HiqyVxwsYCTaJisKL8wwgZCmPlKk2KNsI7AzrL3AispGI
	fSe+m7MhgyhdN+x7QRekHyPJV60scD6mtYmYPOW4b1pd5QjUunA9cdofsEvWuCQ8
	t569olvVjnxslEWfhP2xNx20yJIXpd2TmXrGJJFvvHLLbiHZrGg9ReMWZwmta4On
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmq9uamm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6388v1iv011613;
	Wed, 8 Apr 2026 10:53:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrcsq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638ArW9w039263;
	Wed, 8 Apr 2026 10:53:38 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-223.vpn.oracle.com [10.154.55.223])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dcmnrcsgj-3;
	Wed, 08 Apr 2026 10:53:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add BTF sanitize test covering BTF layout
Date: Wed,  8 Apr 2026 11:53:24 +0100
Message-ID: <20260408105324.663280-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260408105324.663280-1-alan.maguire@oracle.com>
References: <20260408105324.663280-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5OSBTYWx0ZWRfX5S2m3dJUZHcX
 n4v1kyFess9BU1Xz1Bm3XTkemJk+K0s2to7pinQJbauHALTjFD/uIhD+TzdqaIW9nG/YMOjTBY0
 bWowiYtD4nkaav0+L384YprkA6tOSbw5DK0Cq0ZzaaZE5aR5ZiAYwKS8cVJ5J+Anz7y90QOD2lt
 sPUDnY0Z0jSg0NOM7Ze/KJxc3+CeAaDvS2xkwIW3GJG31p4ls7yvX/kwIctfMQkUlvzY1nxW0W2
 XhonIawsdpA0RDPRahb/9Ama2dDEkWsWJhhUcVvVoQ1GJt7Jd2GZGJo7wpO+DFxwDrxDIiZgpAL
 Zs6P2OF54U9Mi+hiw3g1GRyJt/WH0TihypnnbFL/UQUY0Ve+92c0SEFNizRSRUPx+f9h52cr9mR
 CIUh0bNiRNWOelHzEjN4t91JW/SVfSyNmSkVM9ghAqZ6staPOb7uWX0t/F/O4S+MTNXgwiN5lEc
 YZw8m83WuLQko+OoDHw==
X-Proofpoint-ORIG-GUID: cOA5KYslsswebkKldY_0aj3IbiXoK6in
X-Authority-Analysis: v=2.4 cv=MaJcfZ/f c=1 sm=1 tr=0 ts=69d633b3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=uTUuzrmDwOiJP4hIRfUA:9
X-Proofpoint-GUID: cOA5KYslsswebkKldY_0aj3IbiXoK6in

Add test that fakes up a feature cache of supported BPF
features to simulate an older kernel that does not support
BTF layout information.  Ensure that BTF is sanitized correctly
to remove layout info between types and strings, and that all
offsets and lengths are adjusted appropriately.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
new file mode 100644
index 000000000000..470b29298cbc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
@@ -0,0 +1,100 @@
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
+	skel = kfree_skb__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
+		return;
+	orig = btf__new(&layout_btf, sizeof(layout_btf));
+	if (!ASSERT_OK_PTR(orig, "btf_new_layout"))
+		return;
+
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
+
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
+
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

