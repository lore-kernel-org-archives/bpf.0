Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB2485CC7;
	Tue,  1 Sep 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281924; cv=none; b=UNiBZfZUQNXJWcA57z1sbL724gODRlaOOs/P/LMgJYH0oFRk+z+AAUBcYEIovjPHjmd5BavRx4nFRM3TZMwHkLZzMDMvesvsNzlc8W1sV/Xn5PkFbgFHIwOCZ1iCYmhRkjVdZtk6IbeSseM0ugH38ZDINeP2AtR29aNWcDl8n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281924; c=relaxed/simple;
	bh=M+VUKla1aFLb9DU+flm+y4QlXA6GIG3k3p47zn1YabU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZYj14V31tOImqHU1N93GMJJrADL+c5iWcJ2EJKGJiwne0ci2aMO09Ue1bOMv8GzOu032dOBTQR1UoPIIzqREeFmLy4IMGNTJpcPwy5WL5/gDCkfXvKRmuP8HoVSzaNenTF2U9vbmk3fVas62i0C8HPGr5CdNyfUaL+Z4gvr6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D31XG5e9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D31XG5e9"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQbVn3963545;
	Tue, 1 Sep 2026 16:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MGemU
	8ZWjHiQGc2UuqqAckOQxao7N37IvDNMH3W4Tw8=; b=D31XG5e9h0kjIyD+ndeEm
	ZjDxW8ooxqF6ChzMPubRl/Cqb9AhA77tc1Ku36H2V+9wcb2hJH2AjcTLGpAaRTwh
	WVuTPK7AReantGC4nmTNRl35nijNN6Aw0s5FPHFu/Mb8/k2iAge2E8YxIXVA1AiQ
	k1oR9q2VOfQWmGftbk8CXkKieQ9Pzr4TWJ//6fdWzV1PU8A6CmCs0ygP9A8elm8h
	5xfYrknH00HgUp27w621zHS7oUE06UUDVOJMsVEtdaJR5NgJ1MDeOi9tYBYWBWTw
	6lgmLI9xELpxxPDjJMGDvg6HapOp/iT2PYXqffaHPrWro0BljzgtNpYWinr52765
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrw3ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWCI002082;
	Tue, 1 Sep 2026 16:58:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:16 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1Vx011129;
	Tue, 1 Sep 2026 16:58:15 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-5;
	Tue, 01 Sep 2026 16:58:15 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 04/18] selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
Date: Tue,  1 Sep 2026 17:57:43 +0100
Message-ID: <20260901165757.801449-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX4LEl7K1Dt4rf
 d6NRXjJjUfZXwwYkKuDdw0x2Mh2TeT9kWl6I5webhVjEC1pcdNgNAEUdDMobqBSIoCh7QLcVpQU
 UjgyqG5g6MH719MpZ9Eh8wjxCnwYi81WZqBB2aRcXD8ZPpk6RD5tdaGQ93Woj5WBdaN3R5D/hlf
 oGhCFpRkRV+yT7jOvv9KSwW2cRpuUHIXkJlmvxJAI92rjmnIcIrgw+L0+klsReTxND9v3wBwuhk
 8fKKb3ilKHKx1yLUwceOfXZBxVT0+o8sU6EKCZn7bIdvVYGwn0xESJQ4VO0aY0Ep43M5Zqe9nMZ
 RqxoSG5NHdCmlG8nD2wcXrGq4EVcpowzR3k29sgUanvFP+xLVmLkRyZD9GDrTYS9lvErZM8cb2n
 H2AMlVf104imY8QVWzknvjSsoFE4iHmzcEJQ/2MVa+mL74JA/9PkXSfQeOpoMFczwUB2UDpUJbC
 s57EA7Qm8qKReCxyqQu2JxjYY1GRMyZypIMkCBns=
X-Proofpoint-ORIG-GUID: dTVGctSWWyZQvUp6uPZUM5tZ91Wfaxz6
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a970429 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=JUHwxbf9eekX7852FFMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: dTVGctSWWyZQvUp6uPZUM5tZ91Wfaxz6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX1PrnQQKb1mTO
 P2Ke4ZG3OzSaYbs2XqhEbNXxts0FdeB58rbUrfIobsuWM+untv2R0dKndLKDK775XH2p5ldq1Sd
 qWb9cjXd29Ri+cBEa1uu/1goG9SG/txs+HlQHCjAnHsb3eV893IH

Add support to dump, encode and validate new location-related kinds.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/btf_helpers.c | 36 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/test_btf.h    | 16 ++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 1c1c2c26690a..6065ee4ba00a 100644
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
+		fprintf(out, " size=%d flags=0x%x vlen=%u", t->size, p->flags, vlen);
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
+			fprintf(out, "\n\tfunc_type_id=%u loc_proto_type_id=%u offset=%d",
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

