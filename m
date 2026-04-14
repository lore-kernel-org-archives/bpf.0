Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B7309EFC
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196254; cv=none; b=oUIS+pM04o4z/044XBaPm4bq3JIHkBnaDuKepMse1pLYLfefn3iytsZ6rLRyTxjdnzgll6UVEMDOvhKnljdbMypgcY7eNT4I9NNhTjNRXD0Jz28aFtIezWtLgXRzYnk6RFw+gJTnL3nJlQr57A/j9pgST7crSeQNxClj7FjUweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196254; c=relaxed/simple;
	bh=fK3dfzVILegA1SX4SG3rgiJH2MwILmCSs1mcweWqW6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyBSPsnm9bZoAmgECf1HYhmjYR9HeKpX/JrCGM3sEQQe62JNy40xJU0YBgzPZ4PaxVbhJz5HfYyqRAd5c+bcdZGTxnAuM/esVC2BVqQ174UfXm3vOueaD60BlThYrhg+urEMQoHm+dDmkjH2x2tOQK80UXa7bcxUeY00ugRsyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GhEqVM01; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GhEqVM01"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGV9ab3851340;
	Tue, 14 Apr 2026 19:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=wU82+
	J535niy9aGzAeaiY/UqDWOKK+cKNBKiucOnVCg=; b=GhEqVM01W/5Hw8DCylA/o
	iWGcvWNTGBxnG1w7rB3Ln3FoarqMtTkXvzE5EHKzJ1unjy65QmwdmaweqTbWmr8Z
	5xCPabU3d03APIjJZjPmMBErG5iSNNr2w7E5TTVp0oucYox+sHDDJSk1+flhstGU
	jElHr7gFxeprV4ORT/Oby+Pc027whWKLemxW2bOVQVFeNe9T22Y9QhXqsGEkXQcV
	l8sThhepytH0Y0Ktyofa8zsks8KFebJyYEjTIDC0wsMoBuOhtxO40lio24bYJpJc
	9QWamUPonmlPmmwOlUK9xQn/KSyQBam3UAPxudvCvT8IaBmAB1oxJ6F1znuUF7MF
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87mbjt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnPdb025461;
	Tue, 14 Apr 2026 19:50:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpgdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:34 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5T030710;
	Tue, 14 Apr 2026 19:50:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-4;
	Tue, 14 Apr 2026 19:50:33 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended vlen/kind support
Date: Tue, 14 Apr 2026 20:50:16 +0100
Message-ID: <20260414195019.684531-4-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=69de9a8a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=uV4W3spB8yPNDTg_6iAA:9
X-Proofpoint-ORIG-GUID: nKe3EjK7L3_5yVjnv54iq9Srnewfi3vP
X-Proofpoint-GUID: nKe3EjK7L3_5yVjnv54iq9Srnewfi3vP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfX2h/U0f/7g1mH
 Cy9PrzI4ocHZcRxEPZBBjELehYFF3cePdB2StACjhYodRRFrt76xScFJ3oqAH2VAaq6vpEX9Snv
 rKDrSoNqsCd4tpgNCQ0C2zGWmgUQQyqcNCamDslA0AsWa6z+oV1PxcD7sl/6Y0khAnv5tLoNO3g
 IgeE+LoT8cJ23G2lAgCzCXbEMTKUe90KFB9B6Zyx4CPikcLB7X+yTfroHPTXsd+zI0RAxbUeact
 GIw5IgRiUPOOaM0jyKIHlYzGzDTuzSyCKfcsaxxZnozVZPI9odkf5v7ZHhv+2Nmxk9XbP9NrjZQ
 521bfR/Om0donlgjGn6Es1ucbtmXUUcJwq/b/kzhWBX7fUkECbG56X/6CTZGse5JZKSNaqfcZcZ
 rpFalv07TrK4jQY5CX0fiSLE+aYmMpclECKeyd3Mp9QBwghR8yWnj0rxc76Nfc6/DfO0TN/Gkv3
 Q19I+lKcsmbg/+pqefw==

Add feature check for kernel extended vlen/kind support, and reject
BTF that uses extended vlens/kinds if the kernel does not support
it.  There is no reasonable path to generally sanitize such BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/features.c        | 39 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 17 +++++++++++++-
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4f19a0d79b0c..4a75d6717bbb 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
 						 (char *)layout, token_fd));
 }
 
+static int probe_kern_btf_vlen_kind_extended(int token_fd)
+{
+	struct btf *btf;
+	int ret = 0;
+	__s32 id;
+	int err;
+
+	btf = btf__load_vmlinux_btf();
+	err = libbpf_get_error(btf);
+	if (err)
+		return err;
+	id = btf__find_by_name_kind(btf, "btf_max", BTF_KIND_ENUM);
+	if (id > 0) {
+		const struct btf_type *t;
+		const struct btf_enum *e;
+		const char *name;
+		__u32 i, vlen;
+
+		t = btf__type_by_id(btf, id);
+		if (t) {
+			vlen = btf_vlen(t);
+
+			for (i = 0, e = btf_enum(t); i < vlen; i++, e++) {
+				name = btf__name_by_offset(btf, e->name_off);
+				if (!name || strcmp(name, "BTF_MAX_VLEN") != 0)
+					continue;
+				if (e->val > 0xffff)
+					ret = 1;
+			}
+		}
+	}
+	btf__free(btf);
+
+	return ret;
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -699,6 +735,9 @@ static struct kern_feature_desc {
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
index 3781c45b46d3..8ef1fc96b73a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -398,6 +398,8 @@ enum kern_feature_id {
 	FEAT_UPROBE_SYSCALL,
 	/* Kernel supports BTF layout information */
 	FEAT_BTF_LAYOUT,
+	/* Kernel supports BTF vlen > 65535 */
+	FEAT_BTF_VLEN_KIND_EXTENDED,
 	__FEAT_CNT,
 };
 
-- 
2.39.3

