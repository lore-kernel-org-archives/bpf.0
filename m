Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DD383AD
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103152; cv=none; b=dXt2/9kv6W7TeaZEaJtP1SnAMWkbocU665uJwUMD1FbMj9+mMbifoWF9AYvqvkZ6L/aEphx1V6qEPt9V22eV0kUi9rFoQ8BRRLjRiANAaF5yPjLdJ7IY+G/iYbIzNV/O05PbFOVGI+y5nOYOe9TkEsL1BWwet1lAlXRDoj97EW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103152; c=relaxed/simple;
	bh=Opqmuk6bckqd7N0oftFf1hf68anb3cUpwXcL6t3kWDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JTBc3M+sbsNkqA1Rv1zLiSPcm9ETEQwRLx3nvC0qvCjkcjWqbF9y9N2oWxHR8PSYTyT/gilBBIhnc7LJk3fnLzlSvC8i7O18vQWcC/bMQ2HPEQdP9z1FWXeeK1+HfitfcPwWTRis62QYcG+JZaZxKPGDUbN99uAKX6nUSBxk0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JQXB4ZRE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQXB4ZRE"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YfeH000995;
	Fri, 22 Mar 2024 10:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=ykF4p+1Swqh9R9Gi+eUnerr6VHE+gCQCUGiG+Rmil6o=;
 b=JQXB4ZREPSA18hlmNG7oHbaqKHTbi2wT3XU2t7tNKn3u6aagCpwp3rtAuARKCSt0Gy4T
 tKgBGjCA1yfubXZg4cOLDlSe4ZvRpDokpSRFRLWGMbXGMMhiIy9+D61dv/RCMxlBjL5q
 5ewYmgsZ/OjO9kOIAMATO625I94sTdOQtDtdP9WKFbKhFOf3dpfyn9wR1qRxUGgQohq9
 JJnXuMzk4wDniPhBbcIDK3vtMkxCSlLIy1ZoJD5ur6rbFqZy5n+ivW28mMNgOB2ukkx2
 YmpGonlvi7dYmKZVEiKTZ6USP/TPI0wpXnzu7MYy9540Gmb7BXh+KTCSiMxIZiFDL2cb 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvpgs6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MALIo9014360;
	Fri, 22 Mar 2024 10:25:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2hkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kX030399;
	Fri, 22 Mar 2024 10:25:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-6;
	Fri, 22 Mar 2024 10:25:26 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 04/13] libbpf: add btf__parse_opts() API for flexible BTF parsing
Date: Fri, 22 Mar 2024 10:24:46 +0000
Message-Id: <20240322102455.98558-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: LFmqcxCqtO02BQ38gFCqbnJcLG1DmKU4
X-Proofpoint-ORIG-GUID: LFmqcxCqtO02BQ38gFCqbnJcLG1DmKU4

Options cover existing parsing scenarios (ELF, raw, retrieving
.BTF.ext) and also allow specification of the ELF section name
containing BTF.  This will allow consumers to retrieve BTF from
.BTF.base_ref sections (BTF_BASE_REF_ELF_SEC) also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c      | 24 ++++++++++++++++++------
 tools/lib/bpf/btf.h      | 32 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index f02477af3d79..d43c3eba27e0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1084,7 +1084,7 @@ struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
 	return libbpf_ptr(btf_new(data, size, base_btf));
 }
 
-static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
+static struct btf *btf_parse_elf(const char *path, const char *btf_sec, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
 	Elf_Data *btf_data = NULL, *btf_ext_data = NULL;
@@ -1146,7 +1146,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				idx, path);
 			goto done;
 		}
-		if (strcmp(name, BTF_ELF_SEC) == 0) {
+		if (strcmp(name, btf_sec) == 0) {
 			btf_data = elf_getdata(scn, 0);
 			if (!btf_data) {
 				pr_warn("failed to get section(%d, %s) data from %s\n",
@@ -1166,7 +1166,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	}
 
 	if (!btf_data) {
-		pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);
+		pr_warn("failed to find '%s' ELF section in %s\n", btf_sec, path);
 		err = -ENODATA;
 		goto done;
 	}
@@ -1212,12 +1212,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 
 struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
 {
-	return libbpf_ptr(btf_parse_elf(path, NULL, btf_ext));
+	return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, NULL, btf_ext));
 }
 
 struct btf *btf__parse_elf_split(const char *path, struct btf *base_btf)
 {
-	return libbpf_ptr(btf_parse_elf(path, base_btf, NULL));
+	return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, base_btf, NULL));
 }
 
 static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
@@ -1293,6 +1293,18 @@ struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf)
 	return libbpf_ptr(btf_parse_raw(path, base_btf));
 }
 
+struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts)
+{
+	if (!OPTS_VALID(opts, btf_parse_opts))
+		return libbpf_err_ptr(-EINVAL);
+	if (opts && !opts->btf_sec)
+		return btf__parse_raw_split(path, opts ? opts->base_btf : NULL);
+	return libbpf_ptr(btf_parse_elf(path,
+					opts ? opts->btf_sec : BTF_ELF_SEC,
+					opts ? opts->base_btf : NULL,
+					opts ? &opts->btf_ext : NULL));
+}
+
 static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_ext **btf_ext)
 {
 	struct btf *btf;
@@ -1307,7 +1319,7 @@ static struct btf *btf_parse(const char *path, struct btf *base_btf, struct btf_
 		return btf;
 	if (err != -EPROTO)
 		return ERR_PTR(err);
-	return btf_parse_elf(path, base_btf, btf_ext);
+	return btf_parse_elf(path, BTF_ELF_SEC, base_btf, btf_ext);
 }
 
 struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index f2a853d6fa55..c63043520149 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -18,6 +18,7 @@ extern "C" {
 
 #define BTF_ELF_SEC ".BTF"
 #define BTF_EXT_ELF_SEC ".BTF.ext"
+#define BTF_BASE_REF_ELF_SEC ".BTF.base_ref"
 #define MAPS_ELF_SEC ".maps"
 
 struct btf;
@@ -129,6 +130,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const char *path, struct btf *base_b
 LIBBPF_API struct btf *btf__parse_raw(const char *path);
 LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_btf);
 
+struct btf_parse_opts {
+	size_t sz;
+	/* use base BTF to parse split BTF */
+	struct btf *base_btf;
+	/* retrieve optional .BTF.ext info */
+	struct btf_ext *btf_ext;
+	/* BTF section name */
+	const char *btf_sec;
+        size_t:0;
+};
+
+#define btf_parse_opts__last_field btf_sec
+
+/* @brief **btf__parse_opts()** parses BTF information from either a
+ * raw BTF file (*btf_sec* is NULL) or from the specified BTF section,
+ * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
+ * *base_btf* is specified, use it to parse split BTF from the
+ * specified location.
+ *
+ * @return new BTF object instance which has to be eventually freed with
+ * **btf__free()**
+ *
+ * On error, error-code-encoded-as-pointer is returned, not a NULL. To extract
+ * error code from such a pointer `libbpf_get_error()` should be used. If
+ * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL is
+ * returned on error instead. In both cases thread-local `errno` variable is
+ * always set to error code as well.
+ */
+
+LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opts);
+
 LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
 LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 3d53b1781af1..e9a7cb9c3c5b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -415,5 +415,6 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf__new_split_base_ref;
+		btf__parse_opts;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
-- 
2.39.3

