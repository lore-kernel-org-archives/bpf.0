Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914E486E53;
	Tue,  1 Sep 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281949; cv=none; b=ERUdoqiS5M/K5U2XqbJq1fhcTjh+WgHKvuqEDmCAlktL9L9fqRhMYG+IiKPqGCEy7kTylC5gf+5JNCKpS7SkneegQaWFk/eVHJ64l7YAoDYg1r8jBAt5MjYyUBHqcxxOJrwEeZEDuAv2vgC3yLFKt6OTBA/ZB/qUHvc39LHYJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281949; c=relaxed/simple;
	bh=EChn7g8X4z008n4uZNbLttDmnYpBO5wFBMMHs+br4NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD/j9CTuY2NrS1nqfLwLPRdcU6hm1ghT+RMGEcxt/KzoCjhK3oL888WRR+fIYI/bIbvV0w12RmhFu1Apd8Wiz1pierAq9xVDTjTI+oNWqmCcpossv4Srk5AB5eli8KrB7RP+rqGfGcGXFHlYWakm5EgT5Xv1LcadVLu3BLaH64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bv3gvGfQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bv3gvGfQ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBsU231372;
	Tue, 1 Sep 2026 16:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rxL1y
	Zn/n96KXa6wn7mfE0rlmuRE5GaX0xOgIwSRR/M=; b=bv3gvGfQAT8phY+SNWyfN
	/ipUfI5JZszAxjwtdnXOMG0PU082bWF1Mji+opOtpdNzf46baFS1p7Cn+uC/ZLoc
	3GGjS3CvCZ0or4JNrWs6ji3wbjxKXTUY6pvXozzzaDOHjJMT9Hf/34bReZUC0b7R
	eVSlZ2rZPCeT0D7vXNchX+NM22Z1JmWtOUMmpldNrbqfGEchyYDEmBwzKZrPk7MG
	Yt2m4KegBAMvKd+wF8G7TPEW1ryS/dV0jvuuYlGc1qT8J4xfI+V1UFlAgspntp5I
	loghTx6AN7R7HLW2MhnI38t7HI2YVVg8GI4Okcp5cJVfFzC2+qR3KSLt2x4uGwjg
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjVSc001934;
	Tue, 1 Sep 2026 16:58:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg92t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:42 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WD011129;
	Tue, 1 Sep 2026 16:58:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-12;
	Tue, 01 Sep 2026 16:58:41 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 11/18] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
Date: Tue,  1 Sep 2026 17:57:50 +0100
Message-ID: <20260901165757.801449-12-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX++GHiqVnF1RU
 jKo/vJhpr9FMR0elQPCr5pXN1vjFS10hnz1hnYXlyn54r6j2V8LxzMjRugyPM50AipyeZb9YG0d
 3drX6G3eAx/HbD/BtjIz3siUZQwJ/vTAlL7d4eDg7zOrf0NAC2sb
X-Proofpoint-GUID: n2dlHF6KR76cvKh7tDmP0XMp4Qx0XHGf
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a970443 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=TblKfjyjCiCVDvRAm5kA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: n2dlHF6KR76cvKh7tDmP0XMp4Qx0XHGf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXzmQFXx+ptuKX
 lYPrBQguQngwoFsUAaoG/6vvHisas4t/NbSXF1j/DXagGv9dqkEvbgvr8vFkPxM2zPtTDf36OGR
 5j+OgHSzWK4Rw0UhHID8ygT2MsbgBvOEeFWRUJSRxHhbfzYeuaU+GXtSUCyknkeJK+YDO1MTCmS
 +Mj+mgtnwo//tU7Qwd5X+btCaA7dOquaOiHJr/HK4lKNHYl5cXUfbUI1/tBSLsc+ASpFDLw9PWe
 1X+VmQi8GD9BlE/wBtHGwQxPRh2IY8x2/lTcIHNNAbj5RH1wFpGdwH7HSL+593rtnUBJWFkIbPn
 +CFOqEc/HQCPOYJWldlHVuEAosCE5kqDDyIp9KZdHigb8YYhZQh/gepjHjxKlAmRma5NpkuBF07
 N2ca4LOdUcHvf7LK+HUFr6ykaThFBpzbGjXcqJ6yi8jTdY8Rf/kZ8ViGGkk6kGV6aHhY2damcNG
 tauhiWivUIqotTMapzpOOUs516h+b+J3B1NF25bk=

In raw mode ensure we can dump new BTF kinds in normal/json format.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index bca0a3982f09..4d8991c99b48 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -51,6 +51,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 struct sort_datum {
@@ -415,6 +418,88 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		}
 		break;
 	}
+	case BTF_KIND_LOC_PARAM: {
+		const struct btf_loc_param *p = btf_loc_param(t);
+		__u32 *v = (__u32 *)(p + 1);
+		__u32 i, vlen = btf_vlen(t);
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "flags", p->flags);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "values");
+			jsonw_start_array(w);
+		} else {
+			printf(" size=%u flags=0x%x vlen=%u", t->size, p->flags, vlen);
+		}
+		for (i = 0; i < vlen; i++, v++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "value", *v);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t value=%u", *v);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *params = btf_loc_proto_params(t);
+		__u16 vlen = btf_vlen(t);
+		int i;
+
+		if (json_output) {
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "params");
+			jsonw_start_array(w);
+		} else {
+			printf(" vlen=%u", vlen);
+		}
+
+		for (i = 0; i < vlen; i++, params++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "type_id", *params);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t type_id=%u", *params);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
+
+	case BTF_KIND_LOCSEC: {
+		struct btf_loc *locs = btf_locsec_locs(t);
+		__u32 i, vlen = btf_vlen(t);
+
+		if (json_output) {
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_name(w, "locs");
+			jsonw_start_array(w);
+		} else {
+			printf(" vlen=%u", vlen);
+		}
+
+		for (i = 0; i < vlen; i++, locs++) {
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "func_type_id", locs->func);
+				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
+				jsonw_uint_field(w, "offset", locs->offset);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\t func_type_id=%u loc_proto_type_id=%u offset=%u",
+				       locs->func, locs->loc_proto, locs->offset);
+			}
+		}
+		if (json_output)
+			jsonw_end_array(w);
+		break;
+	}
 	default:
 		break;
 	}
-- 
2.43.5

