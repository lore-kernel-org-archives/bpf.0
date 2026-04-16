Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052831E82A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350400; cv=none; b=KYCbMl+ZSaAuRmD1pfZMOsg6T0wras4IIzNfF+oMrJjH3VwmafPjkwWD4Kee5AuTOEZUAdOQkHSzg9dm4bnXj+ilTrkSiHj4lo3vPEHmLSgvY0sBmXExlJEez7+WzFAx7qZ9t4xU6eTa8YrRvPYtgZwyX7DpVO3BTDf5xqVz6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350400; c=relaxed/simple;
	bh=eGDr6P5GctIBCvB1z0AHYvwijEEDuEcwrCAFDkNggUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adhNg2BF5/o7j2tdj6TYoxxSQPwDsMdVSkCY9aylmtuf0N284XZg8V/G0qSIxGElqzSsM6wRyso99LbOY+L0Sn/g2sSxyUGHZgOrLGmvrtNfA0umw+85C4y5lCfowT0AOzkJZ200PmnCE4zMNd9lcdbU+gO8ZVkD3McBkAv7TDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U74gU3R2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U74gU3R2"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6lZ3B2136522;
	Thu, 16 Apr 2026 14:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=BS2U+
	t7bdIJqUrlg/RpVjklvWn+G4KCrFkMO8OG//AU=; b=U74gU3R2lYLm9cRpE//Zv
	lTWgPsWTEk6FFFeWlURI6At5xFFzwVSFmNJCkZQRm0H1HytfDKW54ttzPlmU1UQR
	UvGtQmVqCt4UjYlFnkIn/QndhofZ9xOUm0PpEt905fUs7LlONSdkCqoRS7H71op2
	QMPJSNH0pPnSxYQiYzncRgwhi1CDGHy2NPMZf7szgPTOQuWjYOIt61FlRqP28tLh
	iTfXsb16OcdJ6Sot6t6FhVoneSarY9pSvveVJKy4xrM9TQfHydFYRxJqyEVzKiv/
	AZkljeDzm86wFuX3Sf21d0aPIhy7qhnTDGsrCMS+SEZAgVVXvUjBbDY9khOAuYLm
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh8687rn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdSJI017914;
	Thu, 16 Apr 2026 14:39:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:41 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXaZ018534;
	Thu, 16 Apr 2026 14:39:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-4;
	Thu, 16 Apr 2026 14:39:40 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 3/8] libbpf: Add feature for kernel extended vlen/kind support
Date: Thu, 16 Apr 2026 15:38:59 +0100
Message-ID: <20260416143904.1220662-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfX5ET8D6gtL//c
 kEDHnhroqKouLy/w0RfZxJyGx7rb9X509jjzUm98yPBwd4y8lmgX1dYu5VnamYc79R8zZgECGPn
 uIDBCQpQ26ImVV5rfdUC1Fpg9zv21L+cHqs9k7TXHOcHIw249Y4NHTXxNVdqs8IN5yf+fDR3Q4E
 6gxcidG/iU+xg/1NKONsRB56AXSSeGu1jdOwGEw42wY0VK6Klj/AzgTHCgEyBJfReA3cFf61yTF
 6TathIZ9et9WK/Y4MA7q04DnXkifVHBHxRXlB78odBTlJXRcNVkJf2+i9uv733niWXs7IQ5g+K3
 fOORZkHPdIwIR/CKpKQZgjt169WsLfoTrPfE7CLbpf7Bk3ItwFTbZ0i1FAKVhZKzBGkePAiMc+B
 ZTDW/0Mnc82wbENXU9KzMm6ZpQre+XIbSvi1PrAUeM5Bh0dq/AhC07/LK8LYxV8mAUSqZjnfAqT
 z0r4iyGNKoBhvDaMmaEhXXVxAtEe46m6xlqq5d3c=
X-Proofpoint-GUID: ZvoezZS3oC865Hj-VNAOYzF9XGjTsNLA
X-Proofpoint-ORIG-GUID: ZvoezZS3oC865Hj-VNAOYzF9XGjTsNLA
X-Authority-Analysis: v=2.4 cv=JY6Ma0KV c=1 sm=1 tr=0 ts=69e0f4ad b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=uV4W3spB8yPNDTg_6iAA:9 cc=ntf
 awl=host:13825

Add feature check for kernel extended vlen/kind support, and reject
BTF that uses extended vlens/kinds if the kernel does not support
it.  There is no reasonable path to generally sanitize such BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/features.c        | 43 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 17 ++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4f19a0d79b0c..f835931f4afe 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -615,6 +615,46 @@ static int probe_kern_btf_layout(int token_fd)
 						 (char *)layout, token_fd));
 }
 
+#define EXTEND_TYPE_LEN	((3 * sizeof(struct btf_type) + sizeof(__u32))/sizeof(__u32))
+#define EXTEND_VLEN		0x10000
+#define EXTEND_SECINFO_LEN	(EXTEND_VLEN * sizeof(struct btf_var_secinfo)/sizeof(__u32))
+
+static int probe_kern_btf_vlen_kind_extended(int token_fd)
+{
+	static const char strs[] = "\0int\0foo\0bar";
+	__u32 types[EXTEND_TYPE_LEN] = {
+		/* int */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
+		/* var */
+		BTF_TYPE_ENC(5 /* "foo" */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		/* datasec */
+		BTF_TYPE_ENC(9 /* "bar" */, BTF_INFO_ENC(BTF_KIND_DATASEC, EXTEND_VLEN, 0), 0),
+	};
+	struct btf_var_secinfo *s;
+	__u32 *types_data;
+	__u32 i;
+	int ret;
+
+	types_data = calloc(EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN, sizeof(__u32));
+	if (!types_data)
+		return -ENOMEM;
+	memcpy(types_data, types, sizeof(types));
+
+	for (i = 0, s = (struct btf_var_secinfo *)&types_data[EXTEND_TYPE_LEN];
+	     i < EXTEND_VLEN; i++, s++) {
+		s->type = 2;
+		s->offset = 4 * i;
+		s->size = 4;
+	}
+
+	ret = probe_fd(libbpf__load_raw_btf((char *)types_data,
+					    (EXTEND_TYPE_LEN + EXTEND_SECINFO_LEN) * sizeof(__u32),
+					    strs, sizeof(strs), token_fd));
+	free(types_data);
+
+	return ret;
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -699,6 +739,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_LAYOUT] = {
 		"kernel supports BTF layout", probe_kern_btf_layout,
 	},
+	[FEAT_BTF_VLEN_KIND_EXTENDED] = {
+		"kernel supports extended BTF vlen/kind", probe_kern_btf_vlen_kind_extended,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..5f19d8ac17a9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3139,10 +3139,11 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
+	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float ||
 	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
-	       !has_layout;
+	       !has_layout || !has_vlen_kind_extended;
 }
 
 struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
@@ -3156,6 +3157,7 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
 	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
 	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
 	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
+	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
 	int enum64_placeholder_id = 0;
 	const struct btf_header *hdr;
 	struct btf *btf = NULL;
@@ -3217,6 +3219,19 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
 	for (i = 1; i < btf__type_cnt(btf); i++) {
 		t = (struct btf_type *)btf__type_by_id(btf, i);
 
+		/*
+		 * If BTF uses extended vlen/kind and kernel does not support
+		 * it, there is nothing we can do.
+		 */
+		if (!has_vlen_kind_extended) {
+			if (btf_vlen(t) > 0xffff || btf_kind(t) > 0x1f) {
+				pr_debug("Unsupported %s for id %u\n",
+					 btf_kind(t) > 0x1f ? "BTF kind" : "BTF vlen", i);
+				btf__free(btf);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+
 		if ((!has_datasec && btf_is_var(t)) || (!has_decl_tag && btf_is_decl_tag(t))) {
 			/* replace VAR/DECL_TAG with INT */
 			t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 3781c45b46d3..9ca0796210d2 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -398,6 +398,8 @@ enum kern_feature_id {
 	FEAT_UPROBE_SYSCALL,
 	/* Kernel supports BTF layout information */
 	FEAT_BTF_LAYOUT,
+	/* Kernel supports BTF vlen > 65535, kind > 31 */
+	FEAT_BTF_VLEN_KIND_EXTENDED,
 	__FEAT_CNT,
 };
 
-- 
2.39.3

