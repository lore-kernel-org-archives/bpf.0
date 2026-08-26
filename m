Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5338A701
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768351; cv=none; b=EP3+N9bkBcXdYn+7DOQkVPNMAImXqxYiRX6XCo9po8UEXvzx04g5UgmU6DnSyxupA+FTPxpdHMApZVZ8vVfVz97hbc5o9wswtxs0FBRrqUUyN3yd8ErnBtl8foyxN4vl0uEHIqH2ugSnkhKpx2vMcsjenC800Cir/D4+uAQvhyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768351; c=relaxed/simple;
	bh=u4R6Z3nKfLHO6808uIeLR37s4q68Whe6XPckIhjLL4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bzh0LWzAlKPWVcs0yrjX+CMYStGp3rlSn6kE0oE1BFK+CNPVvPLKvOwKDdtrC+P/20rnRFRcyWZDH6aG15+UcmE3UvwroEIDe/MeX52CI025slV6mtcdUPbsTQ4TMNNYXVAeDOULTiRPi0N0yk7tL0GsqO9NS3XNPqmDDTISc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=vbrfQedz; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="vbrfQedz"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHMWNq012752;
	Wed, 26 Aug 2026 18:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=YeZ3GW3BBHdbd7rqjlkD8TZ41amGk/jCpyb/M8gnv0k=; b=vbrf
	QedzsoRj23gUxpawvkUNjApfkrbSQ1Cs1XIwXEbUVTSmkEJiV0AuPDTwa0cJ5k49
	c5Rh6am4MPwIiabj5jotlLXWeP/26vwKHoaNm/NgyOXlf6GMrTmWs9XwwGveU9pw
	Zh2+/X225SD06LXIKjiO0NxL0tMBdgsYF1DDyYuqKGq2sMdNZeyXlUXA2h5Aib25
	pz5eCsTq2z2gbzR5tsbBicqVCQ8aGrVQkCyzqqkhRsnVIpcqgGBjxAMOA6A+WVRg
	g/Tr19jTBxz49tuETawlKeWp553aY3NzgIZFxQDSPm5c/jUPBNhFqT2HFLjiTtRW
	LyUXDPrk9ipmAIX/OA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ga4g3ges7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:32 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:30 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 4/5] libbpf: Support declarative dynamic load via BTF decl_tag
Date: Wed, 26 Aug 2026 14:18:24 -0400
Message-ID: <20260826181825.1826541-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: -ug7gwI4cP6eHTu-dSAVvr7IgPEnmzCu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX6brRXVd2Z/7V
 i+mOdlrVq24oq8taG/+0qdyaFrz63AtM88nebc0lvM0GCGwlYMZNTUoTLH2ccioWjZ8XP1pPq9e
 FlZyLwGWjUtXpOGX/+qjIh8IePUfWS3UZ3SazHg3/H5FxC4262ILbb8yovkglRmNwpw1FhHcVAP
 V+Dtbu/vRAyeT3IG9PnsQxlW1ip5rI33ck+kDsueJdv8eCPEuQxS9UZfONUdTSgOJhxCH7mhofJ
 x76KYJd8hwZz0Xb3n5dxniwQFuSd2Oy3DN5yaS5NiJ7Xd4OGlIBJKHmdg1ct5LsoJXx4jV2dgKj
 fZrUrlK3xUkSy7d7Imj2bEGO4HwwEmRGhAOoIWTerpDBb/nJ7DxWQRmGCzYaShKB7ed2fp4c3R4
 OSKuEHUDMcjcKqWsJfaao4Bn9k4xiQuqOpcqj5tWk6CPr65BWCj32cdCp4EdM4qVL0W5dbIxWKH
 eobTbxolx0J+h6cW6Kg==
X-Authority-Analysis: v=2.4 cv=V4xNF+ni c=1 sm=1 tr=0 ts=6a8f2df8 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=YVyfxG655UJ4A4sugG0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfXxohK23IeQk6W
 JEMa+daAfftF+buHjNEQHkbi3oHPOdu9DK8yRkG8NlIGPM9boAconsPd3jzcPL0ZjORFeCDI+vz
 M6O4Z7r/FWS6NReCgQqt33SsDFb8WHwLsfvuxXgdY6iobukYw/iD
X-Proofpoint-GUID: -ug7gwI4cP6eHTu-dSAVvr7IgPEnmzCu
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260153

Add a loadtype:dynamic BTF decl_tag, exposed as __load_dynamic in
bpf_helpers.h, letting a program declare itself dynamically-loaded in
its source instead of requiring an imperative
bpf_program__set_load_type() call. The tag is checked in the existing
per-program loop in bpf_object_init_progs(), right after prog->sec_def
is resolved, and routes through bpf_program__set_load_type() so it
inherits all existing validation. An explicit set_load_type() call
before load still overrides the tag.

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/bpf_helpers.h |  5 +++
 tools/lib/bpf/libbpf.c      | 90 +++++++++++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9d160b5b9c0e..52978f0e0453 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -218,6 +218,11 @@ enum libbpf_tristate {
 #define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
 #define __arg_arena __attribute((btf_decl_tag("arg:arena")))
 
+/* Mark a BPF program to be loaded dynamically instead of autoloaded,
+ * equivalent to bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC).
+ */
+#define __load_dynamic __attribute__((btf_decl_tag("loadtype:dynamic")))
+
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd1d00c47841..5d58dbf25234 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1126,9 +1126,10 @@ static bool is_valid_st_ops_program(struct bpf_object *obj,
 }
 
 /* For each struct_ops program P, referenced from some struct_ops map M,
- * enable P.autoload if there are Ms for which M.autocreate is true,
- * disable P.autoload if for all Ms M.autocreate is false.
- * Don't change P.autoload for programs that are not referenced from any maps.
+ * set P's load type to BPF_PROG_LOAD_TYPE_AUTO if there are Ms for which
+ * M.autocreate is true, or to BPF_PROG_LOAD_TYPE_DISABLED if for all Ms
+ * M.autocreate is false.
+ * Don't change P's load type for programs that are not referenced from any maps.
  */
 static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 {
@@ -1244,11 +1245,12 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 			if (st_ops->progs[i]) {
 				/* If we had declaratively set struct_ops callback, we need to
-				 * force its autoload to false, because it doesn't have
-				 * a chance of succeeding from POV of the current struct_ops map.
-				 * If this program is still referenced somewhere else, though,
-				 * then bpf_object_adjust_struct_ops_autoload() will update its
-				 * autoload accordingly.
+				 * force its load type to BPF_PROG_LOAD_TYPE_DISABLED, because
+				 * it doesn't have a chance of succeeding from POV of the
+				 * current struct_ops map. If this program is still referenced
+				 * somewhere else, though, then
+				 * bpf_object_adjust_struct_ops_autoload() will update its
+				 * load type accordingly.
 				 */
 				st_ops->progs[i]->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 				st_ops->progs[i] = NULL;
@@ -7156,6 +7158,50 @@ static int bpf_prog_assign_exc_cb(struct bpf_object *obj, struct bpf_program *pr
 	return 0;
 }
 
+#define DYNLOAD_DECL_TAG "loadtype:dynamic"
+
+/*
+ * Check whether a BPF program is annotated with the DYNLOAD_DECL_TAG BTF
+ * decl tag, requesting that it be loaded dynamically after the object load.
+ *
+ * Returns 1 if the tag is present, 0 if it is not, negative error otherwise.
+ */
+static int prog_has_dynload_tag(struct bpf_object *obj, struct bpf_program *prog)
+{
+	int i, n;
+
+	if (!obj->btf)
+		return 0;
+
+	n = btf__type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
+		const struct btf_type *tag_t, *fn_t;
+
+		tag_t = btf__type_by_id(obj->btf, i);
+		if (!btf_is_decl_tag(tag_t) || btf_decl_tag(tag_t)->component_idx != -1)
+			continue;
+		if (strcmp(btf__str_by_offset(obj->btf, tag_t->name_off),
+			   DYNLOAD_DECL_TAG) != 0)
+			continue;
+
+		/* a decl tag's type field points at the entity it decorates */
+		fn_t = btf__type_by_id(obj->btf, tag_t->type);
+		if (!btf_is_func(fn_t) || btf_func_linkage(fn_t) != BTF_FUNC_GLOBAL) {
+			pr_warn("prog '%s': " DYNLOAD_DECL_TAG
+				" decl tag must be applied to a global function\n",
+				prog->name);
+			return -EINVAL;
+		}
+
+		if (strcmp(btf__str_by_offset(obj->btf, fn_t->name_off), prog->name) != 0)
+			continue;   /* tag belongs to a different program */
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct {
 	enum bpf_prog_type prog_type;
 	const char *ctx_name;
@@ -8401,7 +8447,10 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		if (prog_is_subprog(obj, prog))
 			continue;
 		if (prog->load_type != BPF_PROG_LOAD_TYPE_AUTO) {
-			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
+			pr_debug("prog '%s': skipped loading, load type is %s\n",
+				 prog->name,
+				 prog->load_type == BPF_PROG_LOAD_TYPE_DYNAMIC ?
+				 "dynamic" : "disabled");
 			continue;
 		}
 
@@ -8467,6 +8516,22 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 				return err;
 			}
 		}
+
+		if (prog_is_subprog(obj, prog))
+			continue;
+
+		err = prog_has_dynload_tag(obj, prog);
+		if (err < 0)
+			return err;
+		if (err > 0) {
+			err = bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC);
+			if (err) {
+				pr_warn("prog '%s': failed to apply " DYNLOAD_DECL_TAG
+					" decl tag: %s\n",
+					prog->name, errstr(err));
+				return err;
+			}
+		}
 	}
 
 	return 0;
@@ -15248,10 +15313,9 @@ static int bpf_program__set_dynamicload(struct bpf_program *prog)
 	 * to gen_loader. For this reason, prevent calling
 	 * bpf_program__set_dynamicload when gen_loader was used to
 	 * generate a BPF object loader.
-	 * A gen_loader implementation is being called for autoloaded
-	 * programs and defines its own model for loading BPF programs.
-	 * To pass a BPF program to gen_loader, set the program's load type
-	 * to LD_AUTOLOAD.
+	 * A gen_loader implementation is being called for programs with
+	 * load type BPF_PROG_LOAD_TYPE_AUTO and defines its own model for
+	 * loading BPF programs.
 	 */
 	if (obj->gen_loader)
 		return libbpf_err(-ENOTSUP);
-- 
2.34.1

