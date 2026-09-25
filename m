Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55148A8CD
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329994; cv=none; b=BMS/MGKUHLW1etyrCr/ENu52aXdSzGWV4VSofUAHbDuWdJ1giyZ4qzSY8BImXxj/lRJqxFThcNu4V0rVG0xfF0JavLR+M4baR7cDzRI4woHhfcMRKPlX/Zka82QZB18zvM6U39vG8HNDilXKtR4rOCsQr3OuZFfhd6taD52Kaos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329994; c=relaxed/simple;
	bh=2fIzNWIGOLXmfU55wr1ij9ABm+XoXJ+6cSMmsbO2NBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twbPIv55OICA6SMF2PTMjURlg46W4cNNzox4wFnI3AjQIdLD4ogqQDnfy7siDozhUnCJk1p6UdRoiCxRxz0IWM1FH6/WnCv94BpA1dcZ3GswrudHHzmIeKQNly6Pm0bk7M9s+tzsakziOL2z+5oka5ZO3/du/o8YCPoRAqa5K68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qqAJmgpt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqAJmgpt"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OLMmgn3847269;
	Fri, 25 Sep 2026 09:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=St+4H
	rRHBecaa2TOEwc5qRWmL5Z2R+Jizea2yLND0F0=; b=qqAJmgptk1EfDCiya4vMZ
	rKG6svHk3iwwUmkgXqrW2+E/cnXSYGMAyZtI182a8t6bvqZYI+QomssDV1Gg/CTa
	Kwwowt9htCNuel+QJfuXB8HQqfAklrtreih+wFBNqDLvMPo1F7JTBLqMYxzJ9uTT
	bE1Mzz4xM1ee9htYnfx7P7dVuPVsoOgOGo6oCxTge1M69mugl7ixlwWOmty3XnAj
	JIozCFDnkk+OX0ISA4Apm8kgoRp3c0z4w6WFMQ76blFKFT6n20Suz4MSJmvHX7Nz
	go34ZV8d9LQGvQPyQ9X9j4zcP3B+cLXQi6r/zNY7E/rV/tHFBc/58PQdYK7Q4Rn9
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb95tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P9oQk1004610;
	Fri, 25 Sep 2026 09:52:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtept1dq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:40 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68P9mZYh001344;
	Fri, 25 Sep 2026 09:52:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtept1djn-3;
	Fri, 25 Sep 2026 09:52:40 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/3] bpftool: Update func representation to include function signature
Date: Fri, 25 Sep 2026 10:52:30 +0100
Message-ID: <20260925095231.879708-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925095231.879708-1-alan.maguire@oracle.com>
References: <20260925095231.879708-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXxSgHD9dBSuNd
 isZK1VgVFHSE4u4nPjDbR3S8AV324+t9c759VUIM1/YnSG2z9RQHEgjndsf4ntk9z77Nbghwfb8
 rMoCXcVy8R+x806yttVGrHFGLhWo3/SFMJyD1ptVzRIrQWLa4J5lUHzDMgzYXEPmHeRii3zhn5/
 +4CNIfbsuHY87qcEvAbGtM3KFw2WBi7Oy5NBAepp516PEjTvcHvrqkZyi/FAIng3GMjFGgV04xB
 EjRI+mupmGY9Bli53EeLSz38CRImx44PLPDM27YgHd5EJx+SplxGDSXPSPeMNBWcJ2l6CyfB4pT
 FT3GJdTF34PM1f3bqTfjkLmbooSgZj0Uvg8FyrXWF1EcCs466sd0D2utvP78OiXAJTaQPrTKRAa
 rKKHRMy7B7bTaO1tXXSvd+93Kwd7EOunfigAL/zXcv61yy7tJwV02Suyi+QwGx9o3bvG9veoW7U
 +9nvujJHsjdelRslryxLN1aKCfjGP4lfaGa4JnLI=
X-Proofpoint-ORIG-GUID: ig5bdjfLa5CuClLvyV___X41o6jNvhJW
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab6446a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=F8pM7ebFtbTfAefDE7YA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13532
X-Proofpoint-GUID: ig5bdjfLa5CuClLvyV___X41o6jNvhJW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfX1jrQYK1RLjPj
 3aDjqfzCdRRer5epsMdC43TiT7S5AOELuaZgLxrPuzUrSoWTZg9uGXjPo+XLi0+AOgdHPoHjSk5
 NvweHd+CqRX7mnSMU8XDVDXNPJ4X5Z6Gm/FT7uceaG7mZPtR3n64

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
 tools/bpf/bpftool/btf.c | 100 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index e29c8a84e224..6e569ace6add 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 #include <linux/err.h>
 #include <stdbool.h>
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -234,8 +235,10 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 						(1ULL << bits) - value;
 			}
 		}
-		snprintf(num, sizeof(num), "0x%llx%s", (unsigned long long)value,
-			 p->flags & BTF_LOC_PARAM_ADDR ? " (addr)" : "");
+		snprintf(num, sizeof(num), "%s0x%llx",
+			 p->flags & BTF_LOC_PARAM_ADDR ? "address " :
+			 p->flags & BTF_LOC_PARAM_CONST ? "const " : "",
+			 (unsigned long long)value);
 	}
 	if (i != vlen) {
 		btf_loc_param_raw_str(p, vlen, str, sz);
@@ -252,6 +255,87 @@ static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
 		 p->flags & BTF_LOC_PARAM_DEREF ? ")" : "");
 }
 
+static int btf_locsec_append(char *str, size_t sz, size_t *off,
+			      const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	if (!sz || *off >= sz - 1)
+		return -ENOSPC;
+
+	va_start(args, fmt);
+	ret = vsnprintf(str + *off, sz - *off, fmt, args);
+	va_end(args);
+	if (ret < 0 || (size_t)ret >= sz - *off) {
+		*off = sz - 1;
+		return -ENOSPC;
+	}
+	*off += ret;
+	return 0;
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
+	if (btf_locsec_append(str, sz, &off, "%s(", name))
+		return;
+	for (i = 0; i < vlen; i++) {
+		const struct btf_type *param_loc;
+		char param_str[256] = {};
+
+		if (!params[i].type) {
+			/* Handle varargs func proto, must be last parameter */
+			if (i != vlen - 1)
+				goto invalid;
+			if (btf_locsec_append(str, sz, &off, "%s...", i ? ", " : ""))
+				return;
+			break;
+		} else if (loc_params[i]) {
+			param_loc = btf__type_by_id(btf, loc_params[i]);
+			btf_loc_param_str(param_loc, param_str, sizeof(param_str));
+		} else {
+			snprintf(param_str, sizeof(param_str), "<unavailable>");
+		}
+
+		if (btf_locsec_append(str, sz, &off, "%s%s [%s]",
+				      i ? ", " : "", btf_str(btf, params[i].name_off),
+				      param_str))
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
@@ -617,22 +701,20 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 		}
 
 		for (i = 0; i < vlen; i++, locs++) {
-			const struct btf_type *f = btf__type_by_id(btf, locs->func);
-			const char *name = "<invalid>";
+			char func_str[1024] = {};
 
-			if (f && btf_is_func(f))
-				name = btf_str(btf, f->name_off);
+			btf_locsec_func_str(btf, locs, func_str, sizeof(func_str));
 
 			if (json_output) {
 				jsonw_start_object(w);
 				jsonw_uint_field(w, "func_type_id", locs->func);
-				jsonw_string_field(w, "name", name);
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

