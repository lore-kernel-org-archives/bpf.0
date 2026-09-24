Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722623ACA4A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248530; cv=none; b=qyEWBupoPZ0d3totsU+W2/RiS+54Tu1q40wAPcuWePzePkw6sIafL8FkJvUiDDUWn9eGdJozGzm23Orojm7X1Dg5MKuQj5z7r5LREVck3hInmt4qX0dxnbU1VgEc1Mn55x/Qa4NZtzCT2MW4WNOtHXrvziuL4cOaV7/ws0TTXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248530; c=relaxed/simple;
	bh=Lb9clhU+mbAvuaB+jjaBLlXOyq/66sAEuE8H3lmpVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUbZ31AijynfVZ9I7UhXo4hlz5QNNo2TxF89hP0+EvvUjzxvVdjPlBkfEcQdW02ECxcj+ZCirlwNJpD2GaMIGV+b23NnB634spz1POKZmuMyOWAjjQaXUQEWFUBDW1zhQV7s4y0dWyKaHVs/sn0LacnkGzAJlTqkUNgZFsz76YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojgEpDIQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojgEpDIQ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CTFN4017028;
	Thu, 24 Sep 2026 11:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6XHUP
	aMCcPUof0XT8AsmdkUZsBY939a40xnqJs8RPEA=; b=ojgEpDIQWcYkZDg0hmsRg
	H1vmlDOwEYE1WcF1vSPoVdD7ph3+5OVuD+vKQ/ofEKS1PYeNz0Xg8j6gdJ2+BkJA
	xM5tMHni3E/6v5O97ooW0ssipDjKtqmPfjWLGo45ks73uqOwl2MEbq5meU3u78dI
	gdRITgyGD5OD8idcnMYz+CZnQwmbOchGtw4CLWTRyJEqI+KJ75q4XlSWvubpYD78
	uSGAyjASbkfg/XmPNzvs2gts8iyVO6jzR0EA8m4n1kylq2oPpk2vuNMlm+bkWALL
	2Nd8ySG1vpqcTlr0UoIfwGvSvvmXBQdNdszqf/zWLk2gpE9XwHAgRMMIqwPrEyWN
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk0xqcbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5XoX013060;
	Thu, 24 Sep 2026 11:15:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119mce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:04 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuN002821;
	Thu, 24 Sep 2026 11:15:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-10;
	Thu, 24 Sep 2026 11:15:03 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
Date: Thu, 24 Sep 2026 12:14:26 +0100
Message-ID: <20260924111428.75957-10-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=F/bC5ahN c=1 sm=1 tr=0 ts=6ab50638 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=yZBaggXs3P0iMMGHVJAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX1BuTq3PH1UTx
 UoZ2MTmOfk+iHjTy4rn/rIOe57BEPVKHMTn8qUTuRz3VaDZiHofy6A54DLYoqGT6IvnPS30N9X/
 hkIOONonYaq+ZB3A5XFouUcp/1luKlPosi2RU7iBu8AigR67doiP
X-Proofpoint-ORIG-GUID: 2nwVRGVSsvadInvxZqj1RZlHbQRr_t6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX6Z6RQG0nCT6v
 o1Cq+zgnLsoewvdyFRQz4UcOasjLBIjCm0+2gGMAlUEe7lpVfAIqkjsshTdgb4t25X4SkqiaTF7
 M5JTMbhA9cBYaqSz2Nrf9obctSjoFQsyVBteBpg37FpDozSnWYsSwzOCn4fZ5u1z6nzTWv4O1RH
 rs+nU1rqfoMcSDBNIaidPqAOduakffX//G+5KgeBnWSuSoA72ZhP5yJERTgOIkekCMNJs+NGp5A
 vvSxVEpriWHft5FA/Dh2HaYOFWwdZrOUmG6e7JKXZhBBaKoQSAuAw5Zzn9kKkGy3Z8+vD/sgMpI
 IxTdC8D8vNgRbLziggtCnbrp5d/z0boClm7bHzq2SQpgdcJsfYuqhAAYEPzMQykNb3PZ95LHwNM
 8dJ2DpOI+2wy9d/efcaR+BGt+PzIOvoWyLYU8a6VN+oUf5vxRVCGh4MlJDDHuqFIcMCyDcWlUb4
 M6RdEObe1YRg8u9i2AvkZ8UNg0/q/7FyAkqE58OI=
X-Proofpoint-GUID: 2nwVRGVSsvadInvxZqj1RZlHbQRr_t6X

In raw mode ensure we can dump new BTF kinds in normal/json format.
BTF_KIND_LOC_PARAMs are rendered as strings, for example a
const value of 0x2a and a dereference of %r10 + 0x20:

  [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
  [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(reg10 + 0x20)'

LOC_PROTOs render the associated values of each of their
LOC_PARAMs for easier readability:

  [14] LOC_PROTO '(anon)' vlen=2
  	type_id=12 value='0x2a'
  	type_id=13 value='*(reg10 + 0x20)'

and LOCSEC shows function name associated with site:

  [15] LOCSEC 'inline.text' vlen=1
  	name='foo' func_type_id=5 loc_proto_type_id=14 offset=64

Registers are displayed in an architecture-neutral form;
'regN' where N is the DWARF register number, or 'fbreg'
for the stack frame base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 224 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 65e8a29277e6..e29c8a84e224 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -29,6 +29,7 @@
 
 #define MAX_ROOT_IDS		16
 #define MAX_BTF_FILES		64
+#define MAX_LOC_PARAM_WORDS	8
 
 static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_UNKN]		= "UNKNOWN",
@@ -51,6 +52,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 struct sort_datum {
@@ -117,6 +121,137 @@ static int btf_kind_safe(int kind)
 	return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
 }
 
+static void btf_loc_param_reg_str(__u32 reg, char *str, size_t sz)
+{
+	if (reg == BTF_LOC_PARAM_FBREG)
+		snprintf(str, sz, "fbreg");
+	else
+		snprintf(str, sz, "reg%u", reg);
+}
+
+static void btf_loc_param_raw_str(const struct btf_loc_param *p, __u32 vlen,
+				  char *str, size_t sz)
+{
+	__u32 i, nr_words = min(vlen, (__u32)MAX_LOC_PARAM_WORDS);
+	size_t off = 0;
+
+	if (!sz)
+		return;
+
+	off += snprintf(str + off, sz - off, "raw=[");
+	for (i = 0; i < nr_words && off < sz; i++)
+		off += snprintf(str + off, sz - off, "%s0x%08x",
+				i ? ", " : "", p->values[i]);
+	if (vlen > nr_words && off < sz)
+		off += snprintf(str + off, sz - off, ", ...");
+	if (off < sz)
+		snprintf(str + off, sz - off, "]");
+}
+
+static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
+{
+	const struct btf_loc_param *p;
+	__u32 i = 0, vlen;
+	__u64 value;
+	__u32 value_size;
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
+			btf_loc_param_raw_str(p, vlen, str, sz);
+			return;
+		}
+
+		switch (nregs) {
+		case 2:
+			btf_loc_param_reg_str(p->values[0], regs, sizeof(regs));
+			snprintf(regs + strlen(regs), sizeof(regs) - strlen(regs),
+				 ", ");
+			btf_loc_param_reg_str(p->values[1],
+					      regs + strlen(regs),
+					      sizeof(regs) - strlen(regs));
+			break;
+		case 1:
+			btf_loc_param_reg_str(p->values[0], regs, sizeof(regs));
+			break;
+		default:
+			btf_loc_param_raw_str(p, vlen, str, sz);
+			return;
+		}
+		i += nregs;
+	}
+	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {
+		switch (vlen - i) {
+		case 1:
+			value_size = sizeof(p->values[0]);
+			value = p->values[i];
+			break;
+		case 2:
+			value_size = 2 * sizeof(p->values[0]);
+			value = ((__u64)p->values[i + 1] << 32) | p->values[i];
+			break;
+		default:
+			btf_loc_param_raw_str(p, vlen, str, sz);
+			return;
+		}
+		i = vlen;
+		if (p->flags & BTF_LOC_PARAM_SIGNED) {
+			/*
+			 * size describes the represented parameter, so it
+			 * describes a constant's signed width. An offset
+			 * is determined by its value words after the register
+			 * number.
+			 */
+			__u32 size = p->flags & BTF_LOC_PARAM_OFFSET ?
+				     value_size : t->size;
+			__u32 bits = size * 8;
+
+			/*
+			 * Since we represent constant values in hex, we
+			 * need to determine if the value is negative so
+			 * we can prepend a "-", and also fix the value
+			 * to be positive so we can have - 0x<value>.
+			 */
+			if (size && size <= sizeof(value)) {
+				if (size < sizeof(value))
+					value &= (1ULL << bits) - 1;
+				negative = value & (1ULL << (bits - 1));
+				if (negative)
+					value = size == sizeof(value) ? -value :
+						(1ULL << bits) - value;
+			}
+		}
+		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
+			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
+	}
+	if (i != vlen) {
+		btf_loc_param_raw_str(p, vlen, str, sz);
+		return;
+	}
+	if (num[0])
+		op = regs[0] ? (negative ? " - " : " + ") : negative ? "-" : "";
+
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
@@ -415,6 +550,95 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
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
+			printf(" size=%u flags=0x%x vlen=%u values='%s'",
+			       t->size, p->flags, vlen, param_str);
+		}
+		break;
+	}
+	case BTF_KIND_LOC_PROTO: {
+		__u32 *params = btf_loc_proto_params(t);
+		__u32 i, vlen = btf_vlen(t);
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

