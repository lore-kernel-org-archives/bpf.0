Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718B313550
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196275; cv=none; b=Ua2AeaZXSHNE8FBieXaHZAJX3KnscTaWeLcHlgz+lQlLVRALmQm6D4zw4K0HCCyNhaiT/vyQTqd64TXVNf0jiZjASFNwe2AcGtg4NhwgJLmRH3jPCfitBgx7z/Z9rgszUC3agIhXIuz7GE97Bx/znciEPHI9Aa+WK69O1TbKq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196275; c=relaxed/simple;
	bh=NX9Z7bzueT1X6cF7H9glIo/pyzkzJ8vnRxMn2sECCnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxCnRga/ZvmsUJzCGeeobe660q6Gn5W6xHyltK/UDlM3U543ODMSbv2a+uL4fLvyKaaZio+zbSIqwKd2PnIkise5gbJCVhbb4OvmriTQC2nekbVzYb+U/6r4QlrievDn0u2zH8BDgWTvQxeVC2gFYJr8WoqxJlWxRF7c0zT7RFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WTT1KOcA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WTT1KOcA"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EEikHp1734697;
	Tue, 14 Apr 2026 19:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k8wRN
	/Ag8yvzMMz5AaZDFFHv6eRcT+Qb9neYvHXM+yE=; b=WTT1KOcAe2Cxm06A8ILvm
	JEhL7lgOkElf4GKldbTGkFEWqWT4zV0xp6F0rEQKimFc9/g4N5gyMMZTgUzQ/HLA
	/mne7MFgu4MjYkGl34sL4uyAo3oLZmBqiPwCszSL4f5ssk7OQ8tZaWXqJays8its
	A+UrUMEc1L6lGr/BWLFSWqB/Umz0ODBOfH9iS6tbVXUIV0d/xz4xFYHsm6zRkxn5
	4FcHfZcf6krjonBbkQA+D09ym5G/lqjP+/xTDXKLB0m3y3V4tI6RxS5n74k/WZCQ
	OktDMVo6etnHacdfpgEsoI6OffkDiNCfkdKmrkDrRW04lnSvE1e2jiYbT9md10tE
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qbqv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnPsF025492;
	Tue, 14 Apr 2026 19:50:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpghs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:39 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5X030710;
	Tue, 14 Apr 2026 19:50:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-6;
	Tue, 14 Apr 2026 19:50:39 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 5/6] selftests/bpf: Test BTF sanitization rejection for invalid vlen
Date: Tue, 14 Apr 2026 20:50:18 +0100
Message-ID: <20260414195019.684531-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260414195019.684531-1-alan.maguire@oracle.com>
References: <20260414195019.684531-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604140185
X-Authority-Analysis: v=2.4 cv=d77FDxjE c=1 sm=1 tr=0 ts=69de9a90 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=97RuO_97fH7yRW6j-SgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfX5CHmkXymIPow
 UZa2qSLORAcZmEGeSuGkhxg61+HK3UDHBZpLOaX3hVTpbfnw8EuLQvnosDiLHTKEduY2D2jkgWY
 Gd3sxbtkURIVKk2qUJKjws63lC2zdHFUP4jAqIGQsA/z3fZcQkgSluTe2EXDjy1MVJsGEn9lS7K
 w72YLBt12HlRryXcMxfxNCHWEO7SQvAPjkebTrzN92TsinEhfxZ4QoNdMhLhUctCLM6QOAPghKM
 zrV/lgZT7UxgPb7hm7o5ZqLMEEi7S/vSSso/rLzMrxdX9MEZyeoQnIQfjZl97aUURU2UQ4uGAyK
 E9umyP1x1dV8DNtoj/1znEE59PrcTeK9/KPZa/18GEMWY/IHbUfuf3wjRP5j/4WkQd/oSJ4c9y4
 /6+y38IAW3Mltgpubj/uZ94QJ+LX6S5HDtzYCsN5RYwqf4e9ZvPezHSOcwaTJxrATCAMMLs0eTb
 UhjZZP5+0iwqMgT00xQ==
X-Proofpoint-ORIG-GUID: GnTaAR0JfRWTn5cF-eZiM0p69YFu1esk
X-Proofpoint-GUID: GnTaAR0JfRWTn5cF-eZiM0p69YFu1esk

For kernel that does not support extended vlen, BTF should be
rejected.  Simulate non-support using feature cache and ensure
BTF with extended vlen DATASEC is rejected.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
index 652b51efafc2..f41cea5a769a 100644
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
@@ -95,3 +95,65 @@ void test_btf_sanitize_layout(void)
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
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_var(btf, "var1", 0, 1);
+	btf__add_datasec(btf, "datasec1", BTF_MAX_VLEN);
+	for (i = 0; i <= 0xffff; i++)
+		btf__add_datasec_var_info(btf, 2, i * 4, 4);
+
+	/* Sanitization should fail here as vlen surpasses unextended limit. */
+	sanitized = bpf_object__sanitize_btf(skel->obj, btf);
+	if (!ASSERT_ERR_PTR(sanitized, "bpf_object__sanitize_btf_should_fail")) {
+		sanitized = NULL;
+		goto out;
+	}
+	/* Now switch extended feature on and ensure success. */
+	cache->res[FEAT_BTF_VLEN_KIND_EXTENDED] = FEAT_SUPPORTED;
+	sanitized = bpf_object__sanitize_btf(skel->obj, btf);
+	if (!ASSERT_OK_PTR(sanitized, "bpf_object__sanitize_btf_should_succeed"))
+		sanitized = NULL;
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

