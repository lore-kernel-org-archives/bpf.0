Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039623EC6BE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356185; cv=none; b=LalQNI4JvnaHtlOOBHxrXz/jCs7FoYa3CMwbBIQ126evo8UjmN5LH+qTiWHHCbfKf0oL+bqEFR0jmFegGq/u/Z2LhbBQ5TD8yIvyO3iMuKdboUDlJAWLwGJMkMdpmAQ77hCV9QEMAMz7fsmDZlGpT6XDyODTBsa6jmnxfnr1TgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356185; c=relaxed/simple;
	bh=eJm+U25eVDUlWrDSf2VDHbHAYLENiiHdeKvCiTE42Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVfZMhvp+sCWZlWrbiOpj4mfYWv57sIW4QxtntTZ3JzFsEa68530xwvg7/R5dZf5pzNRWVXpuw+ZUs5HpdoLvyNbLW2Y8Yz/N5nQj29HSPeQDVs+BooPjirVzQwSdZsXbTjtx7M6gUYoWapKirrTtASMcwOTDhRuesZIq6zhWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/vJmxY4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/vJmxY4"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBor53837178;
	Fri, 25 Sep 2026 17:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7ilQC
	B8UyfiaN2ClslHOk2Zk6G7aEkI48A+MAc+HbTU=; b=I/vJmxY4h2ATLAl0+86yU
	lhzsKRknzen+05B5R0f60c9hVID2fw7EgzR/w5K6IEX7CK9RUD85yQxI+QrvPjZd
	WdeOXQUKFFK39Mk/UYaUbE7UXj/E6bpxYj9cfa6Rm1fxCHUFKRKvCorEdL/yQ2Tt
	+11/reZ4QSH7w453g5n8ePm81n/XTI77SFefSgNlrp5eDiL6LLI1IGNozfXWZnOi
	pA/u1HTfFVLTRDb0poyE/DSkuOlX4226+BtehudCcyCUTZHXl8VEErScoW+LepHF
	73y6d0jOdYoHeQtbUtWWgp3h6L+T7nNQyI3lbP+stGr93UTjhdPI+70vBN/LPCrQ
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhs8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PGa3HT023185;
	Fri, 25 Sep 2026 17:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepteu1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 17:09:03 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PH8v8m008030;
	Fri, 25 Sep 2026 17:09:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gteptetwn-3;
	Fri, 25 Sep 2026 17:09:02 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 2/3] bpftool: Update func representation to include function signature
Date: Fri, 25 Sep 2026 18:08:53 +0100
Message-ID: <20260925170854.1240637-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925170854.1240637-1-alan.maguire@oracle.com>
References: <20260925170854.1240637-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250066
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX7u105PMZXSfl
 4PzPtV0YS/w5RokqEbCc57bHdu9TWbd23F8w4e7cvaXkI/gSg9tpDoZvFEeNDXlSRRI0gOYuuiH
 r1ZetYZAFlz014JPME4Np2ofA/ADkeuPANYlcueK/819t44b+u5v
X-Proofpoint-ORIG-GUID: iNPnhjkl7kShSS0RVtPCrQAb4RWKsDKX
X-Proofpoint-GUID: iNPnhjkl7kShSS0RVtPCrQAb4RWKsDKX
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6aab1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tJdW8KGdDQ_x1OklaOkA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2OCBTYWx0ZWRfX2VC9knCEM1hJ
 J7oggm0ePmbz0d6q8lEo6q02A0MhjI6EEqCErI6iJVTPFb5VSYeOxzE0ps6+ttyXzAHfgzFYP9z
 D8vpofYHdbaptCqGILEvdWU7UI+XmqXRfiQfN8mjx3PzZTnhQaeOradKNvRfkIaX5aIC0wwoD2o
 QZmMdFcTidDF+d4bHEyq23AHbedEbQ0+yMyqP0qInycfUfVewF2nNTrquNjIuopB0Ccc1S8NotK
 xqa5BATn/VRt8lnWEvSfVrIhWhqYAROZH73XJcrk/R3VbQ2VE8xQQ/Uvdgs0LEbDybDO7gB7+w9
 t6DjRHeg4vET5SX2w7T16lx/1uDhmVer057ERJIwEpKj7yyq2xpWF9lIDvcfbxYRMf4mpN14cY1
 LD3JjWuYbayXWwJih2OKXvOeIoRWP/LrlRrIph8S1y+GfAsGIT9PAj4kfayuDXiUsVZ17DLhvzV
 /26k2CezmQZx+/Rx80QT2HZouAGPXyAOzxaNG+SM=

Augment func= output for LOCSEC entries to include a mapping from
function signature to where parameters are stored; for example:

[290179] LOCSEC 'inline.text' vlen=524941
        func='task_pid_nr(tsk [reg0])' func_type_id=136691 loc_proto_type_id=136693 offset=2097226
        func='get_current()' func_type_id=136694 loc_proto_type_id=136695 offset=2097247
        func='arch_static_branch(key [address 0x2e275e8], branch [const 0x0])' func_type_id=136697 loc_proto_type_id=136700 offset=2097296

Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/btf.c | 118 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index e29c8a84e224..ce4c4036c279 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -150,6 +150,7 @@ static void btf_loc_param_raw_str(const struct btf_loc_param *p, __u32 vlen,
 
 static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 {
+	const char *op = "", *prefix = "";
 	const struct btf_loc_param *p;
 	__u32 i = 0, vlen;
 	__u64 value;
@@ -157,7 +158,6 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 	bool negative = false;
 	char regs[32] = {};
 	char num[32] = {};
-	const char *op = "";
 
 	if (!t || !btf_is_loc_param(t)) {
 		snprintf(str, sz, "<invalid>");
@@ -234,8 +234,12 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 						(1ULL << bits) - value;
 			}
 		}
-		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
-			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
+		if (p->flags & BTF_LOC_PARAM_ADDR)
+			prefix = "address ";
+		else if (p->flags & BTF_LOC_PARAM_CONST)
+			prefix = "const ";
+		snprintf(num, sizeof(num), "0x%llx",
+			 (unsigned long long)value);
 	}
 	if (i != vlen) {
 		btf_loc_param_raw_str(p, vlen, str, sz);
@@ -244,14 +248,106 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 	if (num[0])
 		op = regs[0] ? (negative ? " - " : " + ") : negative ? "-" : "";
 
-	snprintf(str, sz, "%s%s%s%s%s",
+	snprintf(str, sz, "%s%s%s%s%s%s",
 		 p->flags & BTF_LOC_PARAM_DEREF ? "*(" : "",
+		 prefix,
 		 regs,
 		 op,
 		 num,
 		 p->flags & BTF_LOC_PARAM_DEREF ? ")" : "");
 }
 
+static bool btf_locsec_append(char *str, size_t sz, size_t *off,
+			      const char *suffix)
+{
+	size_t len;
+
+	if (!sz || *off >= sz)
+		return false;
+
+	len = strlen(suffix);
+	if (len < sz - *off) {
+		memcpy(str + *off, suffix, len + 1);
+		*off += len;
+		return true;
+	}
+
+	if (sz >= 4) {
+		memcpy(str + sz - 4, "...", 4);
+	} else if (sz > 1) {
+		memset(str, '.', sz - 1);
+		str[sz - 1] = '\0';
+	}
+	*off = sz - 1;
+	return false;
+}
+
+static void btf_locsec_func_str(const struct btf *btf,
+				const struct btf_loc *loc, char *str, size_t sz)
+{
+	const struct btf_type *func, *func_proto, *loc_proto;
+	const struct btf_param *params;
+	const __u32 *loc_params;
+	const char *name;
+	__u32 i, vlen;
+	size_t off = 0;
+
+	if (!sz)
+		return;
+
+	str[0] = '\0';
+	func = btf__type_by_id(btf, loc->func);
+	if (!func || !btf_is_func(func))
+		goto invalid;
+
+	name = btf_str(btf, func->name_off);
+	func_proto = btf__type_by_id(btf, func->type);
+	loc_proto = btf__type_by_id(btf, loc->loc_proto);
+	if (!func_proto || !btf_is_func_proto(func_proto) ||
+	    !loc_proto || !btf_is_loc_proto(loc_proto) ||
+	    btf_vlen(func_proto) != btf_vlen(loc_proto))
+		goto invalid;
+
+	params = (const void *)(func_proto + 1);
+	loc_params = btf_loc_proto_params(loc_proto);
+	vlen = btf_vlen(func_proto);
+	if (!btf_locsec_append(str, sz, &off, name) ||
+	    !btf_locsec_append(str, sz, &off, "("))
+		return;
+	for (i = 0; i < vlen; i++) {
+		const struct btf_type *param_loc;
+		char param_str[256] = {};
+
+		if (!params[i].type) {
+			/* Handle varargs func proto, must be last parameter */
+			if (i != vlen - 1)
+				goto invalid;
+			if (!btf_locsec_append(str, sz, &off, i ? ", " : "") ||
+			    !btf_locsec_append(str, sz, &off, "..."))
+				return;
+			break;
+		} else if (loc_params[i]) {
+			param_loc = btf__type_by_id(btf, loc_params[i]);
+			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
+		} else {
+			snprintf(param_str, sizeof(param_str), "<unavailable>");
+		}
+
+		if (!btf_locsec_append(str, sz, &off, i ? ", " : "") ||
+		    !btf_locsec_append(str, sz, &off,
+				       btf_str(btf, params[i].name_off)) ||
+		    !btf_locsec_append(str, sz, &off, " [") ||
+		    !btf_locsec_append(str, sz, &off, param_str) ||
+		    !btf_locsec_append(str, sz, &off, "]"))
+			return;
+	}
+	(void) btf_locsec_append(str, sz, &off, ")");
+	return;
+
+invalid:
+	snprintf(str, sz, "<invalid>");
+}
+
 static int dump_btf_type(const struct btf *btf, __u32 id,
 			 const struct btf_type *t)
 {
@@ -617,22 +713,26 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		}
 
 		for (i = 0; i < vlen; i++, locs++) {
-			const struct btf_type *f = btf__type_by_id(btf, locs->func);
+			const struct btf_type *func;
 			const char *name = "<invalid>";
+			char func_str[1024] = {};
 
-			if (f && btf_is_func(f))
-				name = btf_str(btf, f->name_off);
+			func = btf__type_by_id(btf, locs->func);
+			if (func && btf_is_func(func))
+				name = btf_str(btf, func->name_off);
+			btf_locsec_func_str(btf, locs, func_str, sizeof(func_str));
 
 			if (json_output) {
 				jsonw_start_object(w);
 				jsonw_uint_field(w, "func_type_id", locs->func);
 				jsonw_string_field(w, "name", name);
+				jsonw_string_field(w, "func", func_str);
 				jsonw_uint_field(w, "loc_proto_type_id", locs->loc_proto);
 				jsonw_uint_field(w, "offset", locs->offset);
 				jsonw_end_object(w);
 			} else {
-				printf("\n\tname='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
-				       name, locs->func, locs->loc_proto, locs->offset);
+				printf("\n\tfunc='%s' func_type_id=%u loc_proto_type_id=%u offset=%u",
+				       func_str, locs->func, locs->loc_proto, locs->offset);
 			}
 		}
 		if (json_output)
-- 
2.43.5

