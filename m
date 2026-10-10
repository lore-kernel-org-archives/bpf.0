Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143F395AC3
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643847; cv=none; b=jXp4S7R4vu6MEZ3xRYbh19DjJ/ff0Y2DLYfT923c0IXbbzVZ2iF0jBhXL21KPeZIRo+ieKhtdcZSPlgSsT+SM27LXABx2MYPrgX6xHUJGfl/d7ApsCAfxzcpdxgNZdD7A71W9HnyvvUJGJKF91cNjMIAWAn12LX0oWUI13MyGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643847; c=relaxed/simple;
	bh=j9LrG19uDDS3s8xSiZbsbx3pjlQsutLzKJWVK65Ta58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vf+VAg6nNZ07OfTNabms/dzG6CMRUB3zrusxIzDTK9WgUPRvl3sZ6ntvvsveB70Tf5NdYnqe7QM+qyDWcmrE5G+SJIvQmfVaJp0Lz0JmpsuuO+A8LQy8Gif5O9yR6D1y2IUab3o1CLCYqwlKO0axLMxpwIpNoSMht8hlieIwzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kz+obIr9; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kz+obIr9"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKm8H2198634;
	Sat, 10 Oct 2026 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=xtLXaZsU+Qp+snuus/3IZZ3rTx9GQ6PVcOKS1BzbDCQ=; b=kz+o
	bIr9AK+MHLtdCIrKeFDy1Z03t4akbneEYkhNE4My4IOKRI8lmEQVBAezuM8phMMR
	yhd1RPaEPHgikzBNIAbicgQ2EB0yOVDhd5VbqP1bw/U2dkmjyTBH+1GxAIQNqE6B
	E8Wm0Xle1GYrrAYdv4qFjXjr+9kLcgrfixx5kp32xTJEf8uOD9QpFEC20PF/HIZE
	ZZR/z8lPkxhmsr57OXxOa44aByO19HT4UGOQEqnssqqS/8UoS2aIUnpMrRvMRIEq
	txVDadt3vBmXS4xfRz2k97+jJTvc2d8dezXuVEO/ODHh6pSb5rfj4CB//ty1Y0iN
	ehvisLZgS8feFSw7MQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74ujtjjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:01 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:31:59 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 2/7] libbpf: BPF program load strategy enum
Date: Sat, 10 Oct 2026 10:31:51 -0400
Message-ID: <20261010143156.379864-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6aca4c61 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=9FqMP2l-1xbnh21W5mUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfXzZaZgvd6gYXO
 NSSCohUnANbFLhhmaoBTeCLXKcrKnT+eRTtaFkGMmntsIw6sSOpPU3z+q8kQjZGu5On7mrUaHYI
 TrDctmFXtT2i703f44Hdp900pTEti8DpYiQvY9m42gHHg4kUO+HT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX+FCO2NZ+s4hG
 xvh0D7sBQ2wLJ9SjwBUHe84RVsLjEygFBSCR2R+jd0ZtGq8WrHa20lYBrAEeDsGRJBk3wbAKjJv
 J36ExiPntX2frjQYH4BjMdC6MJIu/OK/74GSszLZhcW0rw3V8R+0XIWn8xvi41Tj2nDB8VcSYfO
 e7SE8DGMLsPnIPNAxPP3wC9OzU46tFkOjOeVcKpCMiNH+ZP22uKntY5d/wJ05lL/hpEsgWRsIox
 R9l38DHo0WH5T5pVb4fCef2cbSHrRcWOIz3emAsAjy5d/TinIE/yvZlGelMWB5GVT+SxduSptxf
 cACrjc785fcb6ymsPSKbsIiVGEzrXyJ47Kok+CkwxDBb965fXLW+aVKELIvmALefHixyFFJ5GeH
 9Lzps53CcD9jqCnjXnq8wD21W4np8KrUK8zczc9HUFoYPdqY374cesnzHj6g2Vpdr8VSPuuQgpe
 cImflnOzu14V37WNBuQ==
X-Proofpoint-GUID: Rtv5Fdr3JzwF_1j0MOGwOv-N2LdDmzSx
X-Proofpoint-ORIG-GUID: Rtv5Fdr3JzwF_1j0MOGwOv-N2LdDmzSx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100057

From: Slava Imameev <slava.imameev@crowdstrike.com>

This commit is in preparation for the next commit that introduces
manual program loading. Currently, the bpf_program structure defines
the autoload behavior using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading strategies
to be introduced by extending the enum value range.
New getter and setter API is also declared for this enum handling.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 53 +++++++++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h   | 33 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 647f205a354d..fb0512e5facf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,7 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_strategy load_strategy;
 	bool autoattach;
 	bool sym_global;
 	/* the program or a function that it calls has callx */
@@ -951,11 +951,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	 * autoload set to false.
 	 */
 	if (sec_name[0] == '?') {
-		prog->autoload = false;
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
 	} else {
-		prog->autoload = true;
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
 	}
 
 	prog->autoattach = true;
@@ -1242,7 +1242,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_strategy = should_load ? BPF_PROG_LOAD_STRATEGY_AUTO
+				: BPF_PROG_LOAD_STRATEGY_DISABLED;
 	}
 
 	return 0;
@@ -1333,7 +1334,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1371,7 +1372,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3806,7 +3807,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6495,7 +6496,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -8166,7 +8167,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -8202,7 +8203,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -9241,8 +9242,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload) {
-			pr_debug("prog '%s': skipped loading\n", prog->name);
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO) {
+			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
 		prog->log_level |= log_level;
@@ -10032,7 +10033,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			    prog_has_callx(&obj->programs[i]))
 				text_has_callx = true;
 		for (i = 0; i < obj->nr_programs; i++)
-			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]) &&
+			if (obj->programs[i].load_strategy != BPF_PROG_LOAD_STRATEGY_DISABLED &&
+			    !prog_is_subprog(obj, &obj->programs[i]) &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
@@ -10716,16 +10718,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
 bool bpf_program__autoload(const struct bpf_program *prog)
 {
-	return prog->autoload;
+	return prog->load_strategy == BPF_PROG_LOAD_STRATEGY_AUTO;
 }
 
 int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 {
-	if (prog->obj->state >= OBJ_LOADED)
-		return libbpf_err(-EINVAL);
-
-	prog->autoload = autoload;
-	return 0;
+	return bpf_program__set_load_strategy(prog,
+		autoload ? BPF_PROG_LOAD_STRATEGY_AUTO : BPF_PROG_LOAD_STRATEGY_DISABLED);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -16108,7 +16107,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -16218,3 +16217,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
+{
+	if (prog->obj->state >= OBJ_LOADED)
+		return libbpf_err(-EINVAL);
+
+	prog->load_strategy = strategy;
+	return 0;
+}
+
+enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog)
+{
+	return prog->load_strategy;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 03f794f4adb0..e7255bd4247f 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2117,6 +2117,39 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
  */
 LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
 
+/**
+ * The program load strategy:
+ *
+ * - BPF_PROG_LOAD_STRATEGY_DISABLED: the program is not loaded.
+ * - BPF_PROG_LOAD_STRATEGY_AUTO: the program is autoloaded when the bpf_object is loaded.
+ */
+enum bpf_prog_load_strategy {
+	BPF_PROG_LOAD_STRATEGY_DISABLED = 0,
+	BPF_PROG_LOAD_STRATEGY_AUTO,
+};
+
+/**
+ * @brief **bpf_program__set_load_strategy()** sets the load strategy of a
+ * BPF program, controlling whether and when it gets loaded into the kernel.
+ *
+ * Can only be called before the enclosing bpf_object is loaded.
+ *
+ * @param prog BPF program to update
+ * @param strategy new load strategy for the program
+ * @return 0 on success; negative error code if the object was already loaded
+ */
+LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
+					      enum bpf_prog_load_strategy strategy);
+
+/**
+ * @brief **bpf_program__load_strategy()** returns the current load strategy
+ * of a BPF program.
+ *
+ * @param prog BPF program to query
+ * @return current load strategy of the program
+ */
+LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 53b7b591325f..689de28fe436 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -464,6 +464,8 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load_strategy;
+		bpf_program__set_load_strategy;
 		btf__add_loc_param;
 		btf__add_loc_param_value;
 		btf__add_loc_proto;
-- 
2.34.1

