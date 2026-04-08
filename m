Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1735B658
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667509; cv=none; b=WC0p8B9dICI4yRqSG1Nml/s/soeNvQ6WHUaMgg7yfqgWvee1ufMXfSRcWgABl2iPTC8cWvqSZWZwMAqB/DyX55GubCe4KyT2JnI6HTuYxl1pPIKIBGfCzlO7dq3wfVtjpW2qrC1UaXhNI6DWny/35L13HFkuBp2vFuoQ2QgfN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667509; c=relaxed/simple;
	bh=cqZP+pK/cBUxyRbaEVUaTlZWYdJjhz2BRcUk1AD9RXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbSM5wZpyQdgTbpZFdLYE0i+OpOibRgcNZa2YuXMjjqnsRPBCqItoMU62vnqsw6wWAhCg5m6+QsQkVpzn+865IzGNDVcEWZrSZoSdPjYjVVOr1/B1wMuw7yCKiIB6wns54yBn4vGmzZRVzGQ0bCJs/AQUcCVCkis3+hnZnUmnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tf85EWui; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tf85EWui"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6387bScj2599011;
	Wed, 8 Apr 2026 16:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=COIYH
	/ZJibn+l2NJOgGyiyUKlEpOS/dCbAuL/x1kwuw=; b=Tf85EWuiirEfifMh60XKU
	sAzdVadgUMTKlns7hRh2+QYE+vtC9XuKFLA++3JH7g549Zq0Tk2xSyej9nLfljG1
	H9geG3/0QPTHi14qOLjsJhsJHQ6tS/0gSzLQHTY6NYRFmDPA22BLy2HUJDyNchl5
	v8PZv94PD7baiShggRMh4fv2Fn+f5F/tH3kNW4GOWqo+GdItW8FPkgFIHUi9jQDX
	BUVTrsvvCrZ/whwnkUoHKPpxEaEM11b3NWrmXxyoeSPi3kU0OL8mzlskQxcETrZ8
	pveHmaJy4t1z4CY+SyRN6Mw8nFkxxvMot7IYuVMB9aq8vYw+WEGgm0PqvX4W+/8p
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqbkyb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638GkBU7027935;
	Wed, 8 Apr 2026 16:57:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmebhqrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638GvboA025438;
	Wed, 8 Apr 2026 16:57:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-176.vpn.oracle.com [10.154.48.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dcmebhqmb-2;
	Wed, 08 Apr 2026 16:57:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 1/2] libbpf: Allow use of feature cache for non-token cases
Date: Wed,  8 Apr 2026 17:57:34 +0100
Message-ID: <20260408165735.843763-2-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NyBTYWx0ZWRfX3dVbKwfgrIo7
 oV+pgEwCf7s9fH50fkNg9yCApbPP+Rmf3gT+GIszBtCi5BgKxUYZ311p1QuwbrfQ48Jp1UwbBh5
 BleV5sLzOV5z85LWA/K/HswruVn+AuFMcqEfVnGvzranefh8jaQEj/sKwRina8LyPn9Cd4N0DJR
 A28dV+GvceyseiBdI4a6f/glptMXWnxr9qTaFiaNLcryaL58BdFXXObEWww7jHdQYYYJWATFjFa
 QMX28pWrZIJWCxEkEtcz8KsrGqaDm43Ex9+0ufE2TT0dPTOh0oF1Whm/C3I78Xm2Xnv5Fm8D4tp
 ldkncyEukjaI1h9oecZdjyjNX4+gqgZyo6pOLsA1a4XKb1sCf6CNxVdX7EtLoaq6iapyDG6srZ+
 /tj2rl4n+xPu9gr4XcTgQXwhR7GRFX1q3sKvBsZ+0jW4ntgeGeRE0f1HYEye91lG/J8mwrVeFi+
 VJAt2cjQmLLmX6dt8VcWr2kjhvwlLyi+5/RAnjHc=
X-Proofpoint-ORIG-GUID: U4X9dyg7MQrv6PcUOq9oFN-ToCi02pBo
X-Proofpoint-GUID: U4X9dyg7MQrv6PcUOq9oFN-ToCi02pBo
X-Authority-Analysis: v=2.4 cv=KO1qylFo c=1 sm=1 tr=0 ts=69d68904 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=s5iUJX_GEmEhW97rA0IA:9 cc=ntf
 awl=host:12292

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
index 42bdba4efd0c..8b0c3246097f 100644
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
+		free(obj->feat_cache);
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

