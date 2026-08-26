Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3196376BCC
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768335; cv=none; b=Xma26Lz6cWPUcO+MvUE7uBk1X6mhrelRwOz8f4CxLiHWy4gecMXrS2MFsfxFiapux1j0Ko5/suBOczHMsi1oFBfchGBa6eDdFz7Ul4hXy70UaGgx1mO9a5nYJTs8HOqQ5HQhMwluvAJjE7eouSpVi/SxZ6G4gl4pjEInYCyaPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768335; c=relaxed/simple;
	bh=VJ5QiUk2WgjsbwpYre8VqtVZgcBVvFm/w07s6NHhYtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6yVusChcD4Ir2iM9YEAlk0kwtZQCcHtkMnEBCA7hmmWYyLMZQ1I+2o3nD/hQ3xdLo8aO5nVEk41vDkxZ47PxfLoGMYrLZTDEEso6Tc8u4v06/SNu0nM3CBZ4zeIOl+KTPTc9NgQIbW8/pyvVCnpAR2gWPrU4kVK8NH6iYCZgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mD2IGIYC; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mD2IGIYC"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGuWOw4140136;
	Wed, 26 Aug 2026 18:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Q9j5EfwBRwIhzzDX/FW//4S7HR0D0fAky9sRTWKhOmc=; b=mD2I
	GIYCTJTlcUXMswbp1caJIOScplHec1dQt7NdMRXozDummjJ63oh1szck1CfRnx6N
	0ohd76qht6XrsP5HL1AE1yVycSohqRoiRUv2N0ktaPXmKCgtzuWQZZzHNl2lG/+s
	3GscMzZu58HOxyV8TZAGfKhKD84F2cwkN5Q2bts6K1zVwVTrZdzDvhJKaF11rUJT
	D9VCrtaTChYOIU85vG0ar5CJI0QP0UA3EMX1aLdmBda2CnCeh5CpiMK3m+b0p8LL
	7Ai6ohWaFESJXxBqDbZMdaxuuCgoRG1EGL4/ZJPZhu4fLj15MCQSqUYDxktIqCKr
	WlNTjZTwpM9K2yPwwA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4g9m7qbrc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:29 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:27 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 1/5] libbpf: BPF program load type enum
Date: Wed, 26 Aug 2026 14:18:21 -0400
Message-ID: <20260826181825.1826541-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX+SrHShoC0Cyz
 lS7gHzUvhAsNUvIOAqKa12u/0W98jDp3yh+5J2pQ8V1S4vzDabwtjWl1YkEQYRB0cwSS0I9J3OK
 jp9oLLJcT92WkqRmodyUvttvFtxM1w6km3sdAz+tY9cn6n2trswmpq6oUGyN7zmty++Tzlb6mmq
 7gJElD7jLc4H4Ng/EIdgjqw9XASeMlpZPJqVCZR3K0FnnN7BElXJmOwLgK8N2lnBqJRs66TM63e
 OS4TKoU0vhFjbkTwT1zbnvghDAzuw+5y22X9UaGxHSWSUBPl4G4ZnmFM6Q0h9juTzm3ogToOrVF
 g2FOyVtJCRjToKkiBOpeVbNvhzNQ2N5bEdgyMrzg1NViT6z77o0A9BY1+9aDVkYsWZhvNNxWHHs
 mxDbPUDMyg9Nk0eORKsw6VY8nAVZWiO7NP6AWCRyS1SJpWVIolcMIdjyHjjrvh1J6gDCCogpqmR
 oFIIf9KEOVIfVCSG/Ag==
X-Authority-Analysis: v=2.4 cv=BaroFLt2 c=1 sm=1 tr=0 ts=6a8f2df5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=jpiZ5Bf68AYXYWgi8RAA:9
X-Proofpoint-ORIG-GUID: bnC-q1RjqD3Mt0E8dOmD-em9SAKV6f8Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX2OTcazDZQWiZ
 u10s9uAQM9hJVT7LfahfrCKnhVhs71dG3fA7HGk7IfkFGca0CPhuG42GT6N/cZjROYmCRo7O5rP
 ZBgSlcgREll/CnH3dWYKKwdxaLv7Fk6G7QB+tWkQyr6fs0RfOsvH
X-Proofpoint-GUID: bnC-q1RjqD3Mt0E8dOmD-em9SAKV6f8Q
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260153

From: Slava Imameev <slava.imameev@crowdstrike.com>

Replacing the boolean field with an enum simplifies the addition
of new load types. Currently, the bpf_program structure defines
the autoload type using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading types
to be introduced by extending the enum value range.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 50 +++++++++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h   | 15 ++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..821d854d43a9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,7 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_type load_type;
 	bool autoattach;
 	bool sym_global;
 	bool mark_btf_static;
@@ -872,11 +872,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	 * autoload set to false.
 	 */
 	if (sec_name[0] == '?') {
-		prog->autoload = false;
+		prog->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
 	} else {
-		prog->autoload = true;
+		prog->load_type = BPF_PROG_LOAD_TYPE_AUTO;
 	}
 
 	prog->autoattach = true;
@@ -1163,7 +1163,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_type = should_load ? BPF_PROG_LOAD_TYPE_AUTO
+				: BPF_PROG_LOAD_TYPE_DISABLED;
 	}
 
 	return 0;
@@ -1248,7 +1249,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1287,7 +1288,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_type = BPF_PROG_LOAD_TYPE_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3600,7 +3601,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6194,7 +6195,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -7530,7 +7531,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -7566,7 +7567,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -8398,8 +8399,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload) {
-			pr_debug("prog '%s': skipped loading\n", prog->name);
+		if (prog->load_type != BPF_PROG_LOAD_TYPE_AUTO) {
+			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
 		prog->log_level |= log_level;
@@ -9799,16 +9800,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
-	return prog->autoload;
+	return prog->load_type == BPF_PROG_LOAD_TYPE_AUTO;
 }
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	if (prog->obj->state >= OBJ_LOADED)
-		return libbpf_err(-EINVAL);
-
-	prog->autoload = autoload;
-	return 0;
+	return bpf_program__set_load_type(prog,
+		autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE_DISABLED);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -15111,7 +15109,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_type != BPF_PROG_LOAD_TYPE_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -15221,3 +15219,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
+{
+	if (prog->obj->state >= OBJ_LOADED)
+		return libbpf_err(-EINVAL);
+
+	prog->load_type = type;
+	return 0;
+}
+
+enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
+{
+	return prog->load_type;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index b965ad571540..700634664e32 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2078,6 +2078,21 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
  */
 LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
 
+/**
+ * The program load type:
+ *
+ * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
+ * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
+ */
+enum bpf_prog_load_type {
+	BPF_PROG_LOAD_TYPE_DISABLED = 0,
+	BPF_PROG_LOAD_TYPE_AUTO,
+};
+
+LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
+					  enum bpf_prog_load_type loadtype);
+LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08ab2ea881fb..4d63dac8c3b7 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,4 +462,6 @@ LIBBPF_1.8.0 {
 		bpf_program__clone;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
+		bpf_program__load_type;
+		bpf_program__set_load_type;
 } LIBBPF_1.7.0;
-- 
2.34.1

