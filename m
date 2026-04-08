Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2F1A262D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645636; cv=none; b=eFonP2Y8fmIAFGEC5pmNT5+WAqi+OgO5pcBNQfJHIV4PuvTZnQ2f8LqfUpV+TK8zAZIuysPAlk0+yaqnLCAPxxktUNQvjwkGoKEYLnF0bZSvLsfig0mVDOSthnsDYuvUha50ADggNQvqJ2FStzamU/NT30HUppRic5jTPxbWmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645636; c=relaxed/simple;
	bh=cO7l1VjcswbJxsumvgNmm3i3nPbrSYi3NLHX7rDnq6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POgBPjY+AMikaXcKQTW29iQP2Y5+2jBluFaTZBc4zS+sz6w40VuA2rsK5o2lzOD5GGFrWwOLTXpBRcgSPwmnigKDGIda5FjU0Vss3C9FdLtGwP37Eyk7XA2eOUr877ndyi3nFv/PED2+qUqdxGVQXpa5FBPryarDGwDfiMFotS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dBt+7uzR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBt+7uzR"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386gAYE3638129;
	Wed, 8 Apr 2026 10:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=naKEM
	qG+r2k2D+R9TVVsuhDgx+Z7DmQ3sqPOtcCjzhU=; b=dBt+7uzRcSdqfRq/Agvva
	2yeV4rnQdbY7439cj0Rq/B5qGfXyuASMt57j3dwBeP1s3EpoW9bBiPGR6PNkdYqX
	DlsgxRvf2CEfIjVxADvz5He4D4biYmWz3AWMJN8tsZwq28k4P92xu0MHKuR44vgR
	48A1jasiTNvUc+sZR/g0lxcbd56uo2K3NBWJ8qIgT7duxoE2eok/6pvOroStI+G5
	en9jsuoMCXXsmJ+7xRHhGy8kNC/huyrZkrxM+1IWKI2McJJ3FVvUG++Smn9RiyWl
	G6u+uzmnXV0+pEiJw1EhLA3sA0qwSJyr80tpauFnpV1qG8UyJFmW9dJHcCQmVPJ3
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqakbrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638AJUtQ011583;
	Wed, 8 Apr 2026 10:53:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrcsns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 10:53:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638ArW9u039263;
	Wed, 8 Apr 2026 10:53:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-223.vpn.oracle.com [10.154.55.223])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dcmnrcsgj-2;
	Wed, 08 Apr 2026 10:53:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: Allow use of feature cache for non-token cases
Date: Wed,  8 Apr 2026 11:53:23 +0100
Message-ID: <20260408105324.663280-2-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: 45Q2rNvKUnwehDGMzjh-_Kn8Y5yuyU4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA5OSBTYWx0ZWRfX7qNxRCOpB3U8
 cB6J/jquFEg+mz7ts2zau1QE9y48Ozcg1EKNGDuh98p+BigC5QEbG03kXOp0YQs4+ooScQcaQy7
 cny/6/MRcAx9Aw3bYrT7nd9LZ+jUMlGQMTQ2SPkHSz6fbSxYW0PPYhbip+fb5yTaBdxE1JLFDM1
 5PRzY8mmzgerzHvyYNM//u81zB/WkAt5JJBPQlD/qNjKWYd61surzRgCDVzVPK2MbTTIgnz9eE2
 6T71p0sYgTAav8wVXF4r/MJJ9U2x30FzdvLHu3IgBlMmZ4aZpzw7oaUc1uIYBVSuZlnwaBj5vzk
 unS85Cd4BDtsePNQwIkN3rLslwahIyhq5Nl9TaZlCipoiL3BQJ7pvu9N1/uaXQkOKOcX0ifxajs
 mwfQQFFjbwlzo8R7R4Slu+iGIAQbymbtvnns7xfnSdixZ0O3t14pluCvS/nHvwa9Zk8XwyclLd6
 l13htH/SkO65yQLHmug==
X-Authority-Analysis: v=2.4 cv=AsTeGu9P c=1 sm=1 tr=0 ts=69d633b0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=s5iUJX_GEmEhW97rA0IA:9
X-Proofpoint-GUID: 45Q2rNvKUnwehDGMzjh-_Kn8Y5yuyU4f

Allow bpf object feat_cache assignment in BPF selftests
to simulate missing features via inclusion of libbpf_internal.h
and use of bpf_object_set_feat_cache() and bpf_object__sanitize_btf() to
test BTF sanitization for cases where missing features are simulated.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/libbpf.c          | 12 ++++++++++--
 tools/lib/bpf/libbpf_internal.h |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 42bdba4efd0c..b7b636786d38 100644
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
+void bpf_object_set_feat_cache(struct bpf_object *obj, struct kern_feature_cache *cache)
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
index cabdaef79098..3781c45b46d3 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -414,6 +414,7 @@ struct kern_feature_cache {
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
+void bpf_object_set_feat_cache(struct bpf_object *obj, struct kern_feature_cache *cache);
 
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

