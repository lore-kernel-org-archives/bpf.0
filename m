Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97503DE431
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350409; cv=none; b=t84+s/5UHeJwwdX4N84qiJ/ksiFswHPBPdX0qz8VO2e9CBYnDPdOz4YGShkmADLBSikJQrisXst6avNTCKuJTqA9NK5FKax9/jBfWpIQNeQahldEwWJ2eNYWCBo4kZ8RjBI1kDuw1Cc90XOUXW27NvfIUVL191mjCcj3GpFQ7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350409; c=relaxed/simple;
	bh=WUbbhCkeqYsp+0ljn1ZyG3jePFNVFaXDPCOaxCL8WAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbhBQtrh9j1tFw3al//LIv2CcSms7PdRSSJ5wpXaABaB7eJ7kIsoSBoi0Hg3j0zaD46wj4M/9hvX67cQ6TZ2A+ICG0PJ3M040iwQQZqBRBGWYqiSIQJruE4PmBr5h0p+bBo6Vdhdm44T/2Rln7nopLXFvX/qmLOHGa2z8DQsnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lCv5F2m4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCv5F2m4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5Ul0p582988;
	Thu, 16 Apr 2026 14:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bDG9x
	+CcgxA/xa0R6V3kr4O5Rw+xtr1a/SJ2JGHnBZg=; b=lCv5F2m4R15SC6u7LyWCf
	5vgofD+EoFosTiRtuKmVQ1bmStpDx5TlEKi34X1D8u8+Gkxj94/+syVjzjHI0164
	M8VyBUAmv35CErIQ9ofe0VwYD5+dYRLLUADh8OV06ky7FJcAf3O2yhIo5yUXEuD/
	wqQfaTVITcBIct+lzWiWqSbhOdHO2VcRO9GWuOnPkZAee/l+j0aUJQErGztMrInN
	4OgVtkxLlYP7Wl5nxO3H1eCea3t3dEwJ88eTEQ3s35+I8sSB8Gaivv3EM/mP1yuL
	mQ4bLzQmuDUgACjL0SGbgLHS1YowhARVsfaDsq3PFRnPB87q53x7SS/sXuhyvfCc
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qfppx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdRE8017774;
	Thu, 16 Apr 2026 14:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:45 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXad018534;
	Thu, 16 Apr 2026 14:39:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-6;
	Thu, 16 Apr 2026 14:39:44 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 5/8] selftests/bpf: Test BTF sanitization rejection for invalid vlen
Date: Thu, 16 Apr 2026 15:39:01 +0100
Message-ID: <20260416143904.1220662-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260416143904.1220662-1-alan.maguire@oracle.com>
References: <20260416143904.1220662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604160141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfXwqMZJpqbaX6t
 HxwkGbjijUUTFAb9IrWD7v4d2TQRMU4l8oGSFMfT5ePZCeDFeVcMWCfF4FgqLTolYEIzrb5i5Hv
 kxuLzmpU/e2EKkiI134hhnMHn0LRs+e9JIqo2Qunzi9/pCkpHWgZAY+YJ2NbB72AB/4DdrQuBYv
 3LSfdpUp4GLYpwBeNiBVl3yvGsvgqkg28oybVkv52deKT6+ZFT90c3RBqZv716FrATZy8S/mkPF
 pCkcr8lVwdvgUmkTvsWP/2uZhl6n1V+MM6RTqLyx5Kq5cSm7tDsLf38zlsgmTDFaxlMAT8tprYi
 R1Hcd0wpbuNit4Splwnbv8BU0pf+FxvmmEacwCzG3AI5YTGRbUPii5AtFDn3Y+h9xnkLQkopDAx
 4kbhL6UysOPYNYG+McPC4T0BELkPU8wlK7/97i5YjQWFlhW3AJ/OLCoC8c1u45ud0LvWbnCEYDr
 lpiprqPMG/GmAVRQgTqMBdjGhDlQtuJuGmo9d4bc=
X-Proofpoint-GUID: KhRuaIeS5iuhD3_eT4C3cpFj1w9iJ9tV
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69e0f4b2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=dclOvsuDVFqHvNWh5ZYA:9 cc=ntf
 awl=host:13825
X-Proofpoint-ORIG-GUID: KhRuaIeS5iuhD3_eT4C3cpFj1w9iJ9tV

For kernel that does not support extended vlen, BTF should be
rejected.  Simulate non-support using feature cache and ensure
BTF with extended vlen DATASEC is rejected.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
index 652b51efafc2..1349fc7b34e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
@@ -40,7 +40,7 @@ static const struct layout_btf layout_btf = {
 	.strs = "\0int",
 };
 
-void test_btf_sanitize_layout(void)
+static void test_btf_sanitize_layout(void)
 {
 	struct btf *orig = NULL, *sanitized = NULL;
 	struct kern_feature_cache *cache = NULL;
@@ -95,3 +95,71 @@ void test_btf_sanitize_layout(void)
 	btf__free(sanitized);
 	btf__free(orig);
 }
+
+static void test_btf_sanitize_extended(void)
+{
+	struct btf *btf = NULL, *sanitized = NULL;
+	struct kern_feature_cache *cache = NULL;
+	struct kfree_skb *skel = NULL;
+	int i;
+
+	skel = kfree_skb__open();
+	if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
+		return;
+
+	if (!ASSERT_OK(kernel_supports(skel->obj, FEAT_BTF_VLEN_KIND_EXTENDED),
+		       "vlen_kind_extended_supported"))
+		goto out;
+
+	cache = calloc(1, sizeof(*cache));
+	if (!ASSERT_OK_PTR(cache, "alloc_feat_cache"))
+		goto out;
+	for (i = 0; i < __FEAT_CNT; i++)
+		cache->res[i] = FEAT_SUPPORTED;
+	cache->res[FEAT_BTF_VLEN_KIND_EXTENDED] = FEAT_MISSING;
+
+	bpf_object_set_feat_cache(skel->obj, cache);
+
+	if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_VLEN_KIND_EXTENDED),
+			  "vlen_kind_extended_feature_missing"))
+		goto out;
+	if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC), "other_feature_allowed"))
+		goto out;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		goto out;
+	if (!ASSERT_GT(btf__add_int(btf, "int", 4, BTF_INT_SIGNED), 0, "add_int") ||
+	    !ASSERT_GT(btf__add_var(btf, "var1", 0, 1), 0, "add_var") ||
+	    !ASSERT_GT(btf__add_datasec(btf, "datasec1", 0x10000), 0, "add_datasec"))
+		goto out;
+
+	for (i = 0; i < 0x10000; i++) {
+		if (!ASSERT_OK(btf__add_datasec_var_info(btf, 2, i * 4, 4), "add_var_info"))
+			goto out;
+	}
+
+	/* Sanitization should fail here as vlen surpasses unextended limit. */
+	sanitized = bpf_object__sanitize_btf(skel->obj, btf);
+	if (!ASSERT_ERR_PTR(sanitized, "bpf_object__sanitize_btf_should_fail"))
+		goto out;
+
+	/* Now switch extended feature on and ensure success. */
+	cache->res[FEAT_BTF_VLEN_KIND_EXTENDED] = FEAT_SUPPORTED;
+	sanitized = bpf_object__sanitize_btf(skel->obj, btf);
+	ASSERT_OK_PTR(sanitized, "bpf_object__sanitize_btf_should_succeed");
+
+out:
+	/* This will free the cache we allocated above */
+	kfree_skb__destroy(skel);
+	btf__free(btf);
+	btf__free(sanitized);
+}
+
+void test_btf_sanitize(void)
+{
+	if (test__start_subtest("layout"))
+		test_btf_sanitize_layout();
+	if (test__start_subtest("extended"))
+		test_btf_sanitize_extended();
+}
-- 
2.39.3

