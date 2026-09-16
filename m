Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D293E0C6F
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544544; cv=none; b=Zv1M7x13XmvJu7pgUNcGlymGt27GibwAzo1aV4Rdbr32+wZR4IYHo4nQ5C3nBf4JASSkfn8NVloRpb8lC3gFbQbjCJakvYGV7jzDIdglxtoL+hd1WS9cyDXFvL93Dndk8IkgqI7l1oyf2SnaeDWnlD2b+rhpsVg/d2yGgSCpcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544544; c=relaxed/simple;
	bh=680eKdZ4fFxlxiBOQyfbfugXjs59fIwCyadpLJr39V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqVkpBcf+nVLmv/qwYrofZnuIhbKlvUSnxn5v9LeOLV6PYXKB9GgIaXgACCozsN0HHUoq7apC0rWt0eI3tgBuqPP2PBvJtv9jxDrP/ZGud3a6AwwAxxFq2jmTTz7fBeT5KXPr7sFZWAJk3ocs508lUOcX5KHBRpZCDeAIZ8MbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WuMd1xoK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WuMd1xoK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLX4sf525001;
	Wed, 16 Sep 2026 07:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=pO/UY
	us4D2L84tvfErLMZqUygLSqwtqtYCJboHyqWG0=; b=WuMd1xoKebtZQZ7riuQXU
	dracOHXna87yIrYe9VFNp/9P+AM34nzzGn3y1PRpVUb9amTeCJVg7aVnpVnrcPGZ
	f+pq4DXPsb9ETJAF0mYT624XQYIDbll+mE2hhIsAttfc6p+XCA6FsiHoj2xjiB/V
	cMB34gr640lftOm40hfUnjvSV3enGwq+l9cwFFueuYjTpdRHiMFsHSUf/pfrrWhe
	t6CUwW2MXCq+Mj54XtxPykGLjtLP0kDCb6afL/wW6TnDioOijbu44xasL61gfXVj
	0UzNbhs3vZ4QFBy0aFH04949Cxyl+RXccQfCjxN+uSKbYQtSdZRwcIXknrB2fYWk
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmy9rw28b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e3f5014802;
	Wed, 16 Sep 2026 07:41:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au4y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:34 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPl020284;
	Wed, 16 Sep 2026 07:41:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-4;
	Wed, 16 Sep 2026 07:41:33 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 03/11] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
Date: Wed, 16 Sep 2026 08:41:10 +0100
Message-ID: <20260916074118.1007116-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-ORIG-GUID: jl0SbFR0BT02YRCPlvXFgE1wSzkghB3i
X-Authority-Analysis: v=2.4 cv=MuvHeGae c=1 sm=1 tr=0 ts=6aaa482f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=JUHwxbf9eekX7852FFMA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfXxP0qdMpM1aFl
 DNGwZUJW5iIGvPOOhBzbC/Wj0PH6zqS4DlO3VxHbRkO5i01z86rXaFY0GaKBrSWywNOjPRQF32m
 DlUYVaeEO83Z7ul4Fuk77B6P/lKHRMKfraX1nDGTbE/k68wWP+F9
X-Proofpoint-GUID: jl0SbFR0BT02YRCPlvXFgE1wSzkghB3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfXwLL3svWmAjeW
 Lw09ykEHvKjvcSNafDT8Cir0UPr5F2NbXJDz4MRY47ZVMoDaM0EHRSReiPf4NU3vU0O8Hzy6yNP
 e4A8t9KbVsuTeQ5yYaJP/nSmyYtFrS3NRMoL8tcmJdRyzPkVKLaWNJglb/1fjDDqdiP9uJ+2uBX
 zC6Y2H2EKfzpaQB/wYvykNkuu0iV2P0XvO29dpIeml6UuJaY4SoiDSfLQl3Sy/BwmyI4H94Xt0E
 HtXJHhGFfu2r4rRuI0EWdCfB592XoHj6TjtQLRn3gJPCIpIl0pTxzlHonjRVxM4DZ/QOcgKPqsv
 Jsvsj5ufQtOH/Dw29Ls+cMajK2gPaUpJ1xbcWWcVDUfvA7XoAoGafd8NUnVXhGmFuOKIfrSNqYG
 J82Ks03B4FIUMcwy8No9c6NrZZO/MfcbTf+dkmZ8Bbmj0rOeM9BRUI7Wav6h/NqwWezdzV5+W22
 OJtQqt9kGuU+pxJOKAA==

Add support to dump, encode and validate new location-related kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/btf_helpers.c | 36 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h    | 16 ++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 1c1c2c26690a..972403f6a743 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -27,11 +27,14 @@ static const char * const btf_kind_str_mapping[] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 static const char *btf_kind_str(__u16 kind)
 {
-	if (kind > BTF_KIND_ENUM64)
+	if (kind > BTF_KIND_LOCSEC)
 		return "UNKNOWN";
 	return btf_kind_str_mapping[kind];
 }
@@ -203,6 +206,37 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		fprintf(out, " type_id=%u component_idx=%d",
 			t->type, btf_decl_tag(t)->component_idx);
 		break;
+	case BTF_KIND_LOC_PARAM: {
+		struct btf_loc_param *p = btf_loc_param(t);
+		__u32 *v = (__u32 *)(p + 1);
+
+		fprintf(out, " size=%u flags=0x%x vlen=%u", t->size, p->flags, vlen);
+		for (i = 0; i < vlen; i++, v++) {
+			if (p->flags & BTF_LOC_PARAM_SIGNED)
+				fprintf(out, "\n\tvalue=%d", (__s32)*v);
+			else
+				fprintf(out, "\n\tvalue=%u", *v);
+		}
+		break;
+	}
+	case BTF_KIND_LOC_PROTO: {
+		const __u32 *p = btf_loc_proto_params(t);
+
+		fprintf(out, " vlen=%u", vlen);
+		for (i = 0; i < vlen; i++, p++)
+			fprintf(out, "\n\ttype_id=%u", *p);
+		break;
+	}
+	case BTF_KIND_LOCSEC: {
+		const struct btf_loc *l = btf_locsec_locs(t);
+
+		fprintf(out, " vlen=%u", vlen);
+		for (i = 0; i < vlen; i++, l++) {
+			fprintf(out, "\n\tfunc_type_id=%u loc_proto_type_id=%u offset=%u",
+				l->func, l->loc_proto, l->offset);
+		}
+		break;
+	}
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/test_btf.h b/tools/testing/selftests/bpf/test_btf.h
index e7bc78108374..b99c04b4d26b 100644
--- a/tools/testing/selftests/bpf/test_btf.h
+++ b/tools/testing/selftests/bpf/test_btf.h
@@ -84,4 +84,20 @@
 #define BTF_TYPE_TAG_ENC(value, type)	\
 	BTF_TYPE_ENC(value, BTF_INFO_ENC(BTF_KIND_TYPE_TAG, 0, 0), type)
 
+#define BTF_LOC_PARAM_ENC(nvals, sz, flags) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC_PARAM, 0, nvals), sz), (flags)
+
+#define BTF_LOC_PARAM_VAL_ENCODE(val)	(val)
+
+#define BTF_LOC_PROTO_ENC(nargs) \
+	BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_LOC_PROTO, 0, nargs), 0)
+
+#define BTF_LOC_PROTO_PARAM_ENCODE(param) (param)
+
+#define BTF_LOCSEC_ENC(name, nlocs) \
+	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_LOCSEC, 0, nlocs), 0)
+
+#define BTF_LOCSEC_LOC_ENCODE(func, loc_proto, offset) \
+	(func), (loc_proto), (offset)
+
 #endif /* _TEST_BTF_H */
-- 
2.43.5

