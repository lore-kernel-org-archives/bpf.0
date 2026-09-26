Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3E383310
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445116; cv=none; b=GLkI4eHK/f1CY5UoqnhR9GxWYI3q/BsNWBckvWzIHzKHwwsHPfReWThrv0SoZr2qQTEAzyB3GD6I0nqe54fxlV3Y0VncP5fQD2b3SH0nU9xAdGaNBreqrfjXbJtiSVMNH9bWyFXAEdw2PtVlRzhYwAX2rsyd825f+2GUpoMfXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445116; c=relaxed/simple;
	bh=vhyIquZNTpDb1ZWg6SwnTWvDnogtcfYhN90b+jbj04A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVrzRxIYMHNhFLdk0f2dlRcGWwnf9eTrBbGvHwuk470N5RjvFXT5eD5O+r9ojZBtqpSD13UqnioZwGskYmC9tCHNojVbl+KepMzuW6laPEuS4UCeUZ+HeCxfXuM2mTTHNBpk2vPeylvHtITtUmbaLuol+vuSXLvbWQd9fHRW5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cx8lSG6O; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cx8lSG6O"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QHo2U51487809;
	Sat, 26 Sep 2026 17:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KXVwS
	McraASokJ3t4gmAqV9uIXOwQgQlyaaXf2paERY=; b=Cx8lSG6OiZNW/l6aBZCZQ
	eZtJ6wK8rPlXfVDxaLX+2JFIT7x2rhIZIKrIx3vVEmONcX6ZunRgcmSr6WumXPkI
	Nis9+8NzYCQvQkbiR/LnFYNJ8j35cv6RudxVDVLsXeFY0yAD/KM9IetGmQgmOD6V
	Xs7efu1udu7vANrce3eeBjIbCsi2Rf+QC5Rf84nAephb/CtRkRwvs/s6dNkPIoJj
	tIt6p12qd4Cnnw71IR7bG1iiOYEXZbee46lHEtHP8PrDVo7EMx2UHwtRXX8hJTSD
	8ziG5QZbmCWiUtCciRxPW1ugDwL7k/Knpqeq9JMmYV26I6kmfZPV0bDDgzKeACYR
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fb8bsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68QHo3SJ017905;
	Sat, 26 Sep 2026 17:51:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4g8nbfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:25 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68QHpHsZ020485;
	Sat, 26 Sep 2026 17:51:24 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-123.vpn.oracle.com [10.154.81.123])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gx4g8nbb1-3;
	Sat, 26 Sep 2026 17:51:24 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 2/3] bpftool: Update func representation to include function signature
Date: Sat, 26 Sep 2026 18:51:12 +0100
Message-ID: <20260926175113.2368566-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260926175113.2368566-1-alan.maguire@oracle.com>
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609260071
X-Proofpoint-ORIG-GUID: LX0eVedPVw5R93ZjfLsp39G7U_LGXBbr
X-Proofpoint-GUID: LX0eVedPVw5R93ZjfLsp39G7U_LGXBbr
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6ab8061e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tJdW8KGdDQ_x1OklaOkA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfXxkkVtMdeo/iv
 8Oow5wX/UvabRp00uELC0tB55qxxxjD4dl2GIIQ+yCQV5plSSvL/V5LrKhPCT77UfdKpy08shjs
 vSxiijf627bDXoBMdiv3fYZeLkb0az3dkJYwkDwtCZMhFCD6dJTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX1XL6wEiyWWCj
 VlPkfzk+eXa7ba3A2//QzRXiai7QQAVUU8fWl8dbjKGAz1GZcDsCeVUqIOQ3Qh9ydmBNwmFpHER
 BsbvtbamFwikAT7c/GDvbUGh/6fo2LmGXiEN4wQlh0oxhZ9v/luaA1Gq/X5eTkCmbVqHG6xrCYP
 /TcNp9sPnLeCbIfUB89HtmKu4tvEStFhpv66AWoDMSwEIlD5U00oumRHjk5KvpZOPN9o6D26j8G
 dEvE62NlAYgKr2y8T5XjT9zti02CIjrOyTo4hkdAbT0+VicecAvH6grBJ6g8LubWDRo37DAs9dl
 VSlHiaGwjHq0yWoaC+w39sqHQXW+tQu30lqWYLxwE7pgJe1psU6W4yCSh997e0CmSmg4BaX+/yO
 HGQlWPBzuOk3Km29dMeobO3kwweDxrbE3vMiiOvGlQhmSDimjwSW38SarbQLtlKkFrLi1F4qpcv
 eb4/Otjf2yP2F94VEPQ==

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
 tools/bpf/bpftool/btf.c | 123 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index e29c8a84e224..abd661db91e6 100644
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
@@ -244,14 +248,111 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
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
+	static const char nospace_suffix[] = "...";
+	bool space_left = true;
+	size_t left = 0, len;
+
+	if (*off >= sz || sz < sizeof(nospace_suffix))
+		return false;
+	left = sz - *off;
+
+	/*
+	 * Copy as much of the string as we can in remaining space, and
+	 * append "..." if we would have overrun.
+	 */
+	len = strlen(suffix) + 1;
+	if (len > left) {
+		len = left;
+		space_left = false;
+	}
+
+	memcpy(str + *off, suffix, len);
+	*off += len - 1;
+
+	if (!space_left)
+		memcpy(str + sz - sizeof(nospace_suffix), nospace_suffix, sizeof(nospace_suffix));
+
+	return space_left;
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
@@ -617,22 +718,26 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
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

