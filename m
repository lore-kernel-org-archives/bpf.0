Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F713F0AB6
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061834; cv=none; b=kBbypWJDg2MkR7lIuFQpVhTJBADBY0EyDKoceCf2rogl0O+I3XEaVVxB8c3JGFlaJYExHjO9mpKB9CYPzgyaDw+u1+MVp0IeL050hScHCWw54D3crJ3a/gSXKLQwMycyiAWgckVjN4f7H2dcXfxaBVfL2sy0mlZgftziwpUN0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061834; c=relaxed/simple;
	bh=1Qj4TPFcc/s3H63jJbkA+lHkbTlsuedBWhnnCepIR1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDQYyVw5eT+gAXnXeSc1tl9I0hS/HN2PabUgmQFzYxI60in10Foux8zYc4Ea5SlwGPmBu/W4ZnBO1B/Y4NOQTVxhIcrQfW06eAEpzubu9drA0knkPJG7nuO5QFgkqxe7M8o2ys45HHCKKxrx52ggBD9IWOff+KcJJ1yR54M38bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W8oKzoW3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W8oKzoW3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Emvfm1294828;
	Wed, 1 Apr 2026 16:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=E0Pd0
	ly04evQbjTml2mJvme+idAClZn0paH+hHuiy0o=; b=W8oKzoW3AjqmxlCX3KJuU
	dzOJ9BLLc8QONuv6y/RIlSmCQCGcUrm76+Hs6ge/TLmXFsJ7rukNTMYjLx2rhpBK
	kQFNqRuw4ZleaZ8Vae0yfDUe9F+/NT1DuYFoktlOaQwPrg6b4e+nSy8B2uj2yBhb
	scNHSh6R7XMDGZVf2VK48dbj/A0L/HAYw+lpp63tQVEMTU/79PIL/uC/sXDYKvuY
	m6ulww3Vm1AvWO73YbUKBwKwIfdwPWA+bxh6/6agK6N84MBMStTDILyldvjI92K4
	BxQpnSqLGvSfP70CSaeKoy9rP50l7+M2f1AA9V9K6nKiXh7Ut4/XxCCcG9G9D+kD
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d67hqf0ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631EpqK8027484;
	Wed, 1 Apr 2026 16:43:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ebmg0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 631GhO1D001782;
	Wed, 1 Apr 2026 16:43:29 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-129.vpn.oracle.com [10.154.55.129])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d65ebmfqd-3;
	Wed, 01 Apr 2026 16:43:29 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add BTF sanitize test covering BTF layout
Date: Wed,  1 Apr 2026 17:43:02 +0100
Message-ID: <20260401164302.3844142-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260401164302.3844142-1-alan.maguire@oracle.com>
References: <20260401164302.3844142-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010157
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=69cd4b32 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=uTUuzrmDwOiJP4hIRfUA:9
X-Proofpoint-ORIG-GUID: xUCXrexPiYRjqrzQZbDRtR5UlYl-agsD
X-Proofpoint-GUID: xUCXrexPiYRjqrzQZbDRtR5UlYl-agsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1NiBTYWx0ZWRfX+hy/RkB8ACIr
 zFOu3Bf2EAoM5JsprwMbkgLC6ZPL1M8dAhbRj7w4cUZUJpFBOR8ViUrdwN8bKL28hnHRZSnjeNg
 pSKJ7Io5EkQPX4dt4Rx/VmdJcRq0fOmEcuvnziT8YOjFam7EYhJRPfUOBtUECbZfKikodPOjgQl
 y94qDbpQBpQ6XOIvcX3x3htrxZzf4lgqmXFmaE6t30DuwRaI1xFIWWylbUJcsygmz3fq39rbgHY
 zCJK/GfUIaDdBxjELB/Cfk+Fts9zRISJjS/SOSkcd7fCjuZFDJ0cMWMoicMud8eRajoP+UtCg2a
 rwMX8bwQH/3NWN2sscbMEwARxPClMZ+XqvuWXHxr9Uc0sCqtGUWRdzVjptI6NxdH1IgjrSY60VP
 y5ZXlmXJO/ra5V9xPQPCwh5v7T2vH84lD1LsvWf9Z3BcPsOWj9JyxGTCIv8uVCvqg/ccSmE8Yf6
 yQvhZKsul7HsORDVwKw==

Add test that fakes up a feature cache of supported BPF
features to simulate an older kernel that does not support
BTF layout information.  Ensure that BTF is sanitized correctly
to remove layout info between types and strings, and that all
offsets and lengths are adjusted appropriately.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
new file mode 100644
index 000000000000..c18e59f4a8b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
@@ -0,0 +1,103 @@
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
+} __packed;
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
+	struct kfree_skb *skel = kfree_skb__open_and_load();
+	struct kern_feature_cache *cache = NULL;
+	const struct btf_header *hdr;
+	const void *raw;
+	__u32 raw_sz;
+
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
+
+	cache = calloc(1, sizeof(*cache));
+	if (!ASSERT_OK_PTR(cache, "alloc_feat_cache"))
+		goto out;
+	for (int i = 0; i < __FEAT_CNT; i++)
+		cache->res[i] = FEAT_SUPPORTED;
+	cache->res[FEAT_BTF_LAYOUT] = FEAT_MISSING;
+
+	feat_cache_set(skel->obj, cache);
+
+	if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_LAYOUT),
+			  "layout_feature_missing"))
+		goto out;
+
+	if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC),
+			 "other_feature_allowed"))
+		goto out;
+
+	sanitized = bpf_object__sanitize_btf(skel->obj, orig);
+
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

