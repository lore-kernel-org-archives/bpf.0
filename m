Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F747C100;
	Fri,  9 Oct 2026 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545058; cv=none; b=DvnPpxjZ0YlYz/7O5xZVoRzF31ispsBNw9P6LYz/fUVITtyBfTFuL5D17ow4m+fC1+iFQ4D8xouUlMSep9N9DfT0tP5vOcLqIf3S81BNPlbBuyOwc/9nPRqQsyn/ETlRE3hEan0S3hNP7tHo4WUA1QFjcLLe0A3FBHWcCkYROjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545058; c=relaxed/simple;
	bh=tsAIpXw8M0f/mrkV2MS/A2Cg2Nq5hhKBfBaZ2yx2RX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lfx0jwp8F4ZgJgwxt+TQS147jFaVYPAD2DBAI59vL4ElSh5l3e6SOeQDNIP2wTgdF1EcrTu9ULaK31mRdASksD+v68FT9yD6HpDFdRmm71ok+GHqEOzRSkywVUY/kRDr23SKuXm+l2nPbUWLOrs6O4NNJYFV/wcqnMpcbilvIww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BYVwZ4yJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BYVwZ4yJ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698K9iqN3133456;
	Fri, 9 Oct 2026 11:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1iWXS
	pQHqJ9h7DJmeh8L5SeOPy4YGhP2NwgbG330KXA=; b=BYVwZ4yJQZAlW2/or3gQh
	qBMsnhrLfBwYLPIUTntQznr0prFknxgFKXm/NWzrL+dfPjHfq7eAsEfUeV1SOXBI
	KT1eODFAhwXcfOPUNdDgdkTo/WGWgZEXjU/7fyokfsziuFJSk0XTgyg7n+nwiAp2
	JpuCHozezWiZUA9LpFbsBOiRPwIzFwjdlttmmNb/SjuPbq3agc7bWIqR9eYYMcqC
	YN+xBbaqGtdePCWTuxLjO3OYzmj+b4zCoY+rbpcGrnmW6/yEhSwG6AUDbHbRYVhT
	oWvrtPN62yebwRFkWyN2dPkt6zSVi5WP/uVUcFrR27JR+UsZHmUTwos8FiXsFRoQ
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xefu2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLl40040067;
	Fri, 9 Oct 2026 11:23:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsndx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:42 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkY006543;
	Fri, 9 Oct 2026 11:23:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-5;
	Fri, 09 Oct 2026 11:23:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 4/7] btf: Preserve string relocation maps for split BTF
Date: Fri,  9 Oct 2026 12:23:21 +0100
Message-ID: <20261009112324.1442319-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX7hbKWRxHY9Ov
 iFLgWAJgXCyQjKlD50jZQwlITVSCQXtOVIwd6bRP0gHsVt7s2qwRNog5PqBcyh6XX9Ibm+48U3j
 6GReZSibS/ClMPvDZ8/gDzd/0oo15xsnRLOKXmfF6g6h9eUp85+G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX8PR6d93b4joR
 aHaxYrcOhanLzjIOkNjouSSI2ODQ1qxw25cfEiI9JToGvkta6KS7fMNLWXrv2jplQsYNH4FcXz+
 1M59CBfJ9BhV6oUtjBcCCKkWjTDJ36FnOsdzY2rnNKFsTG3Oua711y7ZQDd5Xo9rVak5eBeKMXA
 OD1fJ7GtIt3q3FKSZPstekaQAwGxtdo331TkJ8cWnyqQzjPra5ux+0ZikZjXOQKk9Rcw7eQhZYR
 VxKY3TH91V1yxauOhIy+YEqBXb2UpZIcrXqgetUrKOKDlQ5WUffnz7rnfh2GmmMaASJBFLpY9rg
 BLN6+ICTpX0Jesswy5jOk2by0KmdGocC/o2t6EYqCznyGjtacwRgaTMnruRIEzO27a82Bq5V5rV
 fJgrwfYZoVwV5q5zoUc7CN1rlG2+mOHCJimZ1mVnVTnXLPEOs6Z4OBxgGLETKNCeVbdyy+SFiDw
 KKQfmb+uG1yb/z7sX9ls2tVLtHTGjKtEbPONn4tM=
X-Authority-Analysis: v=2.4 cv=AewkjHXG c=1 sm=1 tr=0 ts=6ac8cebf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=WqRZOxPutuYdU_N9530A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-GUID: mr2X8slknx3WWHQgcxLhBxrx1_RG8Apc
X-Proofpoint-ORIG-GUID: mr2X8slknx3WWHQgcxLhBxrx1_RG8Apc

Make btf_relocate() optionally return the string-offset map it builds
while relocating a BTF relative to a distilled base. A subsequent split
BTF object can use that map to rebase references to base strings.

Also account for the accumulated base string offset when assigning a
new BTF base. This is required when the base is itself split.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: OpenAI Codex (GPT-5.6)
---
 include/linux/btf.h             | 5 +++--
 kernel/bpf/btf.c                | 4 ++--
 tools/lib/bpf/btf.c             | 2 +-
 tools/lib/bpf/btf_relocate.c    | 7 ++++++-
 tools/lib/bpf/libbpf_internal.h | 3 ++-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f731c7a5f14c..b66e20a18c54 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -608,7 +608,8 @@ struct btf_field_iter {
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids,
+		 __u32 **map_strs);
 int btf_field_iter_init(struct btf_field_iter *it, struct btf_type *t,
 			enum btf_field_iter_kind iter_kind);
 __u32 *btf_field_iter_next(struct btf_field_iter *it);
@@ -682,7 +683,7 @@ static inline void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 }
 
 static inline int btf_relocate(void *log, struct btf *btf, const struct btf *base_btf,
-			       __u32 **map_ids)
+			       __u32 **map_ids, __u32 **map_strs)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 592b71a83841..22dd123450c3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1936,7 +1936,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf_nr_types(base_btf);
-	btf->start_str_off = base_btf->hdr.str_len;
+	btf->start_str_off = base_btf->start_str_off + base_btf->hdr.str_len;
 }
 
 static int env_resolve_init(struct btf_verifier_env *env)
@@ -6994,7 +6994,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		goto errout;
 
 	if (base_btf != vmlinux_btf) {
-		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map);
+		err = btf_relocate(btf, vmlinux_btf, &btf->base_id_map, NULL);
 		if (err)
 			goto errout;
 		btf_free(base_btf);
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 512b3962f75f..d2ff6f5d6d5b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -6640,7 +6640,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
 {
-	int err = btf_relocate(btf, base_btf, NULL);
+	int err = btf_relocate(btf, base_btf, NULL, NULL);
 
 	if (!err)
 		btf->owns_base = false;
diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
index df5fa4bd87d6..e55dd75f6c95 100644
--- a/tools/lib/bpf/btf_relocate.c
+++ b/tools/lib/bpf/btf_relocate.c
@@ -441,7 +441,8 @@ static int btf_relocate_rewrite_strs(struct btf_relocate *r, __u32 i)
 /* If successful, output of relocation is updated BTF with base BTF pointing
  * at base_btf, and type ids, strings adjusted accordingly.
  */
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map)
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
+		 __u32 **str_map)
 {
 	unsigned int nr_types = btf__type_cnt(btf);
 	const struct btf_header *dist_base_hdr;
@@ -512,6 +513,10 @@ int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map)
 		*id_map = r.id_map;
 		r.id_map = NULL;
 	}
+	if (str_map) {
+		*str_map = r.str_map;
+		r.str_map = NULL;
+	}
 err_out:
 	free(r.id_map);
 	free(r.str_map);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 546f65b95cf4..4e45dfacb548 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -249,7 +249,8 @@ const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
 const struct btf_header *btf_header(const struct btf *btf);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
-int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map);
+int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
+		 __u32 **str_map);
 bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
-- 
2.43.5

