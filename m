Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC8402448
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061849; cv=none; b=R9U3s38/QxAykErcxW4CimxXx/e+aXxHM+/OF4mhHDno/VAZkjfSCQKf6f0J7QebqbSwdpBNraKlUMOLSUFHvHMEYH3najwCDBKXefg+I5rVIQSpExnyMTSKoqoYSOsBmRLOIJvs0UAK3bvmG9aMc8bVQ6ZQPpcrX81IMuJ35vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061849; c=relaxed/simple;
	bh=AkqQFiLsjvcjls8ZvFGTwSvHv+8xmtrzZfkhj7dowdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1in9JAPk1jgbhL36YRmNVg/21saobH4bVms5FyX/2o3vX1yQPdn31vhrjFIhnxzts8qEmUY8E3yUlM9nuoAg/OddQTkiR2Ij1m5fhX8OLCEZ2wWfO4GXCsXp4KrmkkxQ+Pa+xCBGYxI470eq1JoJ01VdQ0lpZXi9oYYXMK0i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MLN2nWvb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLN2nWvb"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631ElrFD2305180;
	Wed, 1 Apr 2026 16:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1AzBG
	BV5OktWE6FccZtapWTusWgqsoyMHBZihzu9ELM=; b=MLN2nWvbDBrG0B5TZwlU8
	oKRH0D3m8dCAoJWzh+c1G40//05Wdbu6hOGpHAlM3eVnB3EBJoSjuMdp1YSC3TX2
	mHNKmVpxU1dOv6tii5I9mVuMTRuYUKPaTJV6RANCLAdB5utnK8ZXbipDhPS5hjLQ
	5BoHkfBneeJFG6hZ6VSlHJs1q3Id0kj7YceB5DaD5If162JYOOovLCpFGDMxSoyi
	oEEgOaQjOiCxDeUleKIhMsXd+W/GPSNbc/qpBA0b5Eg3McCHxj/nmTpjQQGoG1g+
	qLiU+oUpR1MD8MZVAsXlBcb6u1griV1yZD51ct+uoYTageoqCqMsFQM47c4PEIcv
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65w7f1qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631GAxct027620;
	Wed, 1 Apr 2026 16:43:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ebmfyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 16:43:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 631GhO1B001782;
	Wed, 1 Apr 2026 16:43:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-129.vpn.oracle.com [10.154.55.129])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d65ebmfqd-2;
	Wed, 01 Apr 2026 16:43:26 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/2] libbpf: Allow use of feature cache for non-token cases
Date: Wed,  1 Apr 2026 17:43:01 +0100
Message-ID: <20260401164302.3844142-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: vLXMxzdidlU1llRoyGzyOSyhF6NUCk8X
X-Proofpoint-ORIG-GUID: vLXMxzdidlU1llRoyGzyOSyhF6NUCk8X
X-Authority-Analysis: v=2.4 cv=DKSCIiNb c=1 sm=1 tr=0 ts=69cd4b30 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=s5iUJX_GEmEhW97rA0IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE1NiBTYWx0ZWRfX5alNhzYSf/R8
 CB9P8OsvBwuojIrLj+6Hjar+YxQI+WvtUjXh8L3hEQIeG7ppWahWIStVLa7PLNlxnBOjozJHY2H
 bgD22e24vyLNcX7kBRbfkj9h10pPM87Fs5flNI+bkdU6Oh/5f1SCgx2D07O0Ii8ZKZFO2OP15wJ
 JtpFgMqzSs2ZFLZ2CgtEjgC+nFt4o3Ka3BuwHckmoqv1R2poPDVvyES86ESCpf+rVdjbVaMYXrX
 CGTmmpexGMYe8nFnZeOpS3ktFgzmlAt+gX/mPCGsHwelP74+csiKx93/AULYoWcZcNKF7xlA57E
 MfUQ5/ck8D/qYg3/4d6wjxxbTj4kGwv/9s2dfn+qQ5PPD/t4GDUFreQbL03KMX+ZIRZ9ESJMVjD
 UhVc6yTGsk3yW40Y+jn2YuY0wGfYRBHPqmotteRfFgxyd3qWkVJ9LQSSVrhRn+2mnlIu6R5dXAM
 qMnsp2l7l1Q/qZcVx4A==

Allow bpf object feat_cache assignment in BPF selftests
to simulate missing features via inclusion of libbpf_internal.h
and use of feat_cache_set() and bpf_object__sanitize_btf() to
test BTF sanitization for cases where missing features are simulated.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/libbpf.c          | 12 ++++++++++--
 tools/lib/bpf/libbpf_internal.h |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..9e4acda1f58f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3145,7 +3145,7 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
 	       !has_layout;
 }
 
-static struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
+struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
 {
 	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
 	bool has_datasec = kernel_supports(obj, FEAT_BTF_DATASEC);
@@ -5203,12 +5203,20 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 		 */
 		return true;
 
-	if (obj->token_fd)
+	if (obj->feat_cache)
 		return feat_supported(obj->feat_cache, feat_id);
 
 	return feat_supported(NULL, feat_id);
 }
 
+/* Used in testing to simulate missing features. */
+void feat_cache_set(struct bpf_object *obj, struct kern_feature_cache *cache)
+{
+	if (obj->feat_cache)
+		zfree(&obj->feat_cache);
+	obj->feat_cache = cache;
+}
+
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index cabdaef79098..540d62d45989 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -414,6 +414,7 @@ struct kern_feature_cache {
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
+void feat_cache_set(struct bpf_object *obj, struct kern_feature_cache *cache);
 
 int probe_kern_syscall_wrapper(int token_fd);
 int probe_memcg_account(int token_fd);
@@ -427,7 +428,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 int libbpf__load_raw_btf_hdr(const struct btf_header *hdr,
 			     const char *raw_types, const char *str_sec,
 			     const char *layout_sec, int token_fd);
-
+struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf);
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
-- 
2.39.3

