Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672E545C706
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544556; cv=none; b=A5VzP5AHWsZ5JKN0CVWlwxOcxXdeL/nG4hvxOa36HyYBdpb+e6bGMv+7nCFa2z1Q3+wqSK4zi3GNovCJS1f+jLaU3RQ6peGk8Jr2ImXa+jdchTuNyER8ni5D9U/gGJmrKmSvYGeoag9CSL2iKSwx5ea/1UGh43DO+GkiPSon6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544556; c=relaxed/simple;
	bh=wjxhM+DhghcwY579L427MBm5v3t+1in5ApXtidKPyo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLSazevhthZfW0BbmtpXWkDJrRw3T7MchDCvfJQCfFwR7qp9nhKdHA7xijGaFySUACJFbqrqx3oQo2CWJHKOBnznMKvWIbpobOixm5ioztxV4v743nUltTWXYzWLvIZtMgUrf4XiLzMUtE5+uoXI9DzOIe10rUnCKv17aF/CcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IKKVvDUw; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IKKVvDUw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLWdvr622953;
	Wed, 16 Sep 2026 07:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=wUxVt
	L1IOW5xzgJZuokT5VEotZmghYd+2mBBXRfWDhM=; b=IKKVvDUwkEW5s7dzuqNH8
	VrJGHgvjZFNV270JuhR8MaMxw9aK06oAzj6qlaooOKQVQBb30yyZgsYSAu8XsBk2
	VaFrykfQIZRkGA9R0h/Sxcg3HvBqDi73NSZjrTp4HDbkaedX1MAR0Kuqhf1u0Me6
	QNk9Btmn172dmUIVCXOuVqM/l2oKwc/Y66nLqibgIkZg9dAq+d1w+y9JKMAui13S
	CQ+eXtilCKB5qT3WsEeqNCAhA0nOznFNXFhQhnl0G3sMkmD0zG/HturEGtNj1tOH
	51UJyXk+ZqvaXUrxTFVhj0owrEzbREfJnXeL3T/p5uKDiT9hBZPYmt+G6Obd0qnE
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwh1n4r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e21H014736;
	Wed, 16 Sep 2026 07:41:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au56k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:56 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPx020284;
	Wed, 16 Sep 2026 07:41:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-10;
	Wed, 16 Sep 2026 07:41:56 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
Date: Wed, 16 Sep 2026 08:41:16 +0100
Message-ID: <20260916074118.1007116-10-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX1VeySQLLEnvy
 EOTHjFNuvXtHBorLN4XcTgivrdmsx/JURU9aUgGukuCzDugmd59HyhBK4yLhtF+PWhSp2KNY+Mj
 QxgzPMjZ8/cdESJv1CfJP3vnqgZEolVsKj8T718wE7GsPy4jgIhfBjstkvWzvrpRUcY+O7ZtEPy
 jxONtgJKYt9cq5P7K6ZTKALJXZay3m2F0/+wdUgmITNpxfpK97sYFlGlEk3QffRpjrtvVbg9vFL
 V4E5AMdyZjbN3w6NSYA0gTWF23kDUCB4gKZE3MaLffQIujQ591nmOEqbrmiigLMHN43m6Z8mkms
 gDlq/gC6xwDjLPuZM3O+GNl9eZR467vS3+MJlx+VhDCTcKJxqKzqiLosjMe8IZBFg+wBqGdiRTn
 ZDlSCmYWnxVabaYQylNNsBNbOzHdXp4Yh3yBhGP4A3yFpANWk6+/p4tpSx6seQYo3C1jV8OGSvd
 p2KGEYPIbVXD7dq8wSw==
X-Proofpoint-ORIG-GUID: _H5A-Cx9zUfK124yppx883O410Tqa4-v
X-Proofpoint-GUID: _H5A-Cx9zUfK124yppx883O410Tqa4-v
X-Authority-Analysis: v=2.4 cv=HPhWhYtv c=1 sm=1 tr=0 ts=6aaa4846 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=NuPAbe9WOZ0DXPof7ZcA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX6A6SMmUcBYVk
 8HmSUp5EMLt8B505NTZwAcDXnpo343RjFaxz7O4/Wl0jkbP6OcSddsL5GraL61DiCOLVlrZsMi/
 xm/zMbaayvYIKuZkeGg9yEzam9kkf+7545YfyCRlwKBAxGZcuuvP

In raw mode ensure we can dump new BTF kinds in normal/json format.
BTF_KIND_LOC_PARAMs are rendered as strings, for example a
const value of 0x2a and a dereference of r10 + 0x20:

  [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
  [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'

LOC_PROTOs render the associated values of each of their
LOC_PARAMs for easier readability:

  [14] LOC_PROTO '(anon)' vlen=2
  	type_id=12 value='r1'
  	type_id=13 value='*(r2 + 0x10)'

and LOCSEC shows function name associated with site:

  [15] LOCSEC 'inline.text' vlen=1
  	name=foo func_type_id=5 loc_proto_type_id=14 offset=64

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 169 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index bbe8f9ea144f..5e0cb5862811 100644
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
@@ -117,6 +120,83 @@ static int btf_kind_safe(int kind)
 	return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
 }
 
+static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
+{
+	const struct btf_loc_param *p;
+	__u32 i = 0, vlen;
+	__u64 value;
+	bool negative = false;
+	char regs[32] = {};
+	char num[32] = {};
+	const char *op = "";
+
+	if (!t || !btf_is_loc_param(t)) {
+		snprintf(str, sz, "<invalid>");
+		return;
+	}
+
+	p = btf_loc_param(t);
+	vlen = btf_vlen(t);
+
+	if (p->flags & BTF_LOC_PARAM_REG) {
+		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
+
+		if (nregs > vlen) {
+			snprintf(str, sz, "?");
+			return;
+		}
+
+		switch (nregs) {
+		case 2:
+			snprintf(regs, sizeof(regs), "r%u, r%u",
+				 p->values[0], p->values[1]);
+			break;
+		case 1:
+			snprintf(regs, sizeof(regs), "r%u", p->values[0]);
+			break;
+		default:
+			snprintf(regs, sizeof(regs), "?");
+			break;
+		}
+		i += nregs;
+	}
+	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {
+		switch (vlen - i) {
+		case 1:
+			value = p->values[i];
+			break;
+		case 2:
+			value = ((__u64)p->values[i + 1] << 32) | p->values[i];
+			break;
+		default:
+			snprintf(num, sizeof(num), "?");
+			goto done;
+		}
+		if ((p->flags & BTF_LOC_PARAM_SIGNED) && t->size &&
+		    t->size <= sizeof(value)) {
+			__u32 bits = t->size * 8;
+
+			if (t->size < sizeof(value))
+				value &= (1ULL << bits) - 1;
+			negative = value & (1ULL << (bits - 1));
+			if (negative)
+				value = t->size == sizeof(value) ? -value :
+					(1ULL << bits) - value;
+		}
+		snprintf(num, sizeof(num), "0x%llx", (unsigned long long)value);
+	}
+	if (num[0])
+		op = regs[0] ? (negative ? " - " : " + ") : negative ? "-" : "";
+
+done:
+	snprintf(str, sz, "%s%s%s%s%s",
+		 p->flags & BTF_LOC_PARAM_DEREF ? "*(" : "",
+		 regs,
+		 op,
+		 num,
+		 p->flags & BTF_LOC_PARAM_DEREF ? ")" : "");
+}
+
 static int dump_btf_type(const struct btf *btf, __u32 id,
 			 const struct btf_type *t)
 {
@@ -415,6 +495,95 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		}
 		break;
 	}
+	case BTF_KIND_LOC_PARAM: {
+		const struct btf_loc_param *p = btf_loc_param(t);
+		__u32 vlen = btf_vlen(t);
+		char param_str[256] = {};
+
+		btf_loc_param_str(t, param_str, sizeof(param_str));
+
+		if (json_output) {
+			jsonw_uint_field(w, "size", t->size);
+			jsonw_uint_field(w, "flags", p->flags);
+			jsonw_uint_field(w, "vlen", vlen);
+			jsonw_string_field(w, "values", param_str);
+		} else {
+			printf(" size=%u flags=0x%x vlen=%u values='%s'", t->size, p->flags, vlen, param_str);
+		}
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
+			const struct btf_type *p;
+			char param_str[256] = {};
+
+			if (*params) {
+				p = btf__type_by_id(btf, *params);
+				btf_loc_param_str(p, param_str, sizeof(param_str));
+			} else {
+				snprintf(param_str, sizeof(param_str), "<unavailable>");
+			}
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "type_id", *params);
+				jsonw_string_field(w, "value", param_str);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\ttype_id=%u value='%s'", *params, param_str);
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
+			const struct btf_type *f = btf__type_by_id(btf, locs->func);
+			const char *name = "<invalid>";
+
+			if (f && btf_is_func(f))
+				name = btf_str(btf, f->name_off);
+
+			if (json_output) {
+				jsonw_start_object(w);
+				jsonw_uint_field(w, "func_type_id", locs->func);
+				jsonw_string_field(w, "name", name);
+				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
+				jsonw_uint_field(w, "offset", locs->offset);
+				jsonw_end_object(w);
+			} else {
+				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
+				       name, locs->func, locs->loc_proto, locs->offset);
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

