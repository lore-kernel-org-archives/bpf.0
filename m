Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC46476043
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248508; cv=none; b=rPhmFTBMb83LwoXuIsA+Zg3WK4PMNm1poHXXy4VX6TcDuFZAN+X73uofZSj2X3qonnRqt864MdKUA2J4V6gRkFaph9JizMRjmvmvtHXc3V7JSbWLuaSV5Kj7qS7F8I0OAUovais4pnq7ZXU2PXV/nhItGfS9Pt04o++4ncfRS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248508; c=relaxed/simple;
	bh=58A3hVSykMetcwIPcV6GzMu/R6+f//vJ6US2uUeZ76k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP58W6wbRs40zTuJwezu4vpR+qmDhQjhUUiMQ2IgM31tXYp1yzv5dM8/q7stLPyuqX7xdkyspUzSMwQEXnfBYjy/pfAnchX3KrY4/ExgOqtDxDVXixb0z0GAALQ1WPH7cSGOTgtGS85GVCMUb/RhJzvGsaKvSG3sR+EDDdV+mNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UU+jJl7p; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UU+jJl7p"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6Cc1w1404039;
	Thu, 24 Sep 2026 11:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h1uZC
	sZGufqJRS28HjYmjV7Ux1nmY4uE1wnRx7MU5mk=; b=UU+jJl7pt+F4mH1JSRTF4
	JSURueC1eWDMJ7MZ2pwdvS9OJB83R2OrOP5Cn7qtQTKwxLNraqcw68fh06uRkm/P
	RiY9PoQR9MRhisjYl0o/z6DISYM/MvxP7mdlPyEPoM0gDYtnXSnqs/Wl8IoYQjcq
	iujOZdog7nueObh0cU6Nb20as1gIKKx3QPJhfQGAjXPaS9P8b8C93YEASes8wCwq
	ExB3sxm+qaT0LesSgnW8Qv9DEDhXpylQWSe+vcDA518w7Sicx2SDOcE9XiUXNsOA
	KgioQeD5yvjQq/DNwYvOvmuwNMHlCLIDcJtX40rW6MHMxkg06hZfN7jpIRNskfXO
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0h7fds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5XTu013061;
	Thu, 24 Sep 2026 11:14:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119kw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:43 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuB002821;
	Thu, 24 Sep 2026 11:14:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-4;
	Thu, 24 Sep 2026 11:14:42 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 03/11] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
Date: Thu, 24 Sep 2026 12:14:20 +0100
Message-ID: <20260924111428.75957-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX+kYA7a81fMqF
 HFCY0mWW9tqqFXEXGnh4Iz40vNNieeya4PGAszHlGjr3xPlA88c/p9ker8yiqvE5p7AQ8xugXRC
 KX9xTjEuhKCFxZMG8c3XAkQ1cJdZ6ohSYETY5AYcpq2XhU5q7LFI
X-Proofpoint-GUID: mw2IGadP9dqTITwq1yMvvU8AdSp7TYCp
X-Authority-Analysis: v=2.4 cv=CNa/zhrD c=1 sm=1 tr=0 ts=6ab50624 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=T7oBlgHB1dIKCFp4FSEA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfXzryTE99/6gn6
 IQk8eaUf1VbdEsXPowR1mFQ7oDRNMX+v4au5nYXhfTUGGOlLaRfbLuYeAaG89RXK6W5lSRDIQYd
 ePA0CcOzpS3LA/MwzTpruBrBFq+5RwjbF5Hjp74rQYjhF32EXaz+izSr3PgMGsd6KZLM7BzJw61
 OEgePl3w4EqIfvFIW1ZvTncRJV0xcceQSY5KeIIRpmYMZxcuzLqEfy+Px/eKtD5BXdB8bB8HtYe
 ZFlvYjXDZvR+Wieh1m5JGASfOuUbHV0YnS/Ua24b8EQ7hkI7+8tQCnzQuPhuaznZWMJv0d3OT+Y
 is/I4xTTx+Uy/MaL2r2JmWRxH8VDXdEnHOOl8IjAOLNVxp0axm2/xUkeWLjb3VjO2Vu6P5PH5uj
 W9whOh9YhHJ7FCyB6AbuCLY2CbFw2xWNG6/TkPNdsjgmqsqGSmiR1m0EFP5dmw5PV3fluICNpmb
 fV7Nkx+y2u6RRwE0o7c1bkLEzTyEywwtXn12CFBU=
X-Proofpoint-ORIG-GUID: mw2IGadP9dqTITwq1yMvvU8AdSp7TYCp

Add support to dump and validate new location-related kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/btf_helpers.c | 35 ++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 1c1c2c26690a..85a4d15d1dd1 100644
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
@@ -203,6 +206,36 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		fprintf(out, " type_id=%u component_idx=%d",
 			t->type, btf_decl_tag(t)->component_idx);
 		break;
+	case BTF_KIND_LOC_PARAM: {
+		struct btf_loc_param *p = btf_loc_param(t);
+
+		fprintf(out, " size=%u flags=0x%x vlen=%u", t->size, p->flags, vlen);
+		for (i = 0; i < vlen; i++) {
+			if (p->flags & BTF_LOC_PARAM_SIGNED)
+				fprintf(out, "\n\tvalue=%d", (__s32)p->values[i]);
+			else
+				fprintf(out, "\n\tvalue=%u", p->values[i]);
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
-- 
2.43.5

