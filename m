Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313248;
	b=0gGBhPtRDtIIYqGcTdIIQBTNm/OLgOIxzHBmCeBrDDR0Lzp/dFSIf5DLgP+0lxeErBgM
	 oH+iZwsaiKzNGt2beM0CabhdiL5/8/y0KlXdAcp6Dukphb8T6jg6YISxmuM9qvKsC0l27
	 D+RE5nmTC9ZFp8R5J0jIYyxwf7/SZ530xf72GViLjRLMwWHsTBnNx1KUTbBUYveXw+BMk
	 0KJNdN/tX9hoyUWdbEy2v6J1zgD4HAIqpOjlIUsIFgbQPoh5kqsiUCkiXCEM2tr0p6Jt3
	 y0uZU2LBo5M7AUU6hCM3qFOih/LPdkutHBw1CxAGCAx09BhVc4ZvFVcZ0lm4GfsndHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313248;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZFTIpArA9pIcW0spJV29/G7L772J77apBxWOtlr8oIk=;
	b=W7yS02Zzc3EJdxLm+wQ2niQVvN1YgAcudrkax+JPRk53vKkQhQEuV8TDcF08VIgkhmz0
	 Aeey0qA5AVnANpO+7tjPghfbaKSInXKEXwgyBabTwbwMQQaOR/F6PF9iUI5Jr5iG1Il5h
	 wMlEJYyE1L1xNQ1THD86iacr+mqmTyg1/8CJjVMGVATHad1Skhk59JkJIAceqBgcr0TAT
	 h87tsqaniXVk28DM4sfxfroajaxD1ywbiX6/zRgNBD0OrPuEHf576fE4qGCMGREMw6dPr
	 fYQd1tuYVD8Bi1et2x55x0ez1yG58GGhDUsJJAQybKZlZpGOEFPxvaugPSi76wCQ/VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=oyclFuUU;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E04606A327
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E04606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=oyclFuUU
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXPID2716225;
	Thu, 29 Oct 2026 22:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ZFTIpArA9pIcW0spJV29/G7L772J77apBxWOtlr8oIk=; b=oycl
	FuUUa4Fsb7qNVxD6nNr+FMn8KZ4sHez6OVnBvzVi5YKf+lRM3OX9wv1cfns6LCWm
	NfSuFEzqtVENEXpIfAMxk21pLNOe+LN/OzHriRVSVsA4F+/SY688Pv7NNKFSR/Av
	11AhHusajFD6N1MN8EsMnHHD7NUYlziHO5AI8J8EJl7gWezHtQtsw2WImplhPXGe
	91wGCC5pSU3dUBJbcNfSCgv8MzFnPnz3mDtAxXg2rIalN2JP2ut0Jpb6hjO4kV0N
	w+rar1C9UXnJ3S5q0UZGV6bSKwbhuIJwqKLy9VayH3CKKneXBa40Iye/x46uV8Vo
	yNAYA1Gm9nw+Xrg7Ow==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n85hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:54 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:52 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 3/7] libbpf: BPF program load strategy enum
Date: Thu, 29 Oct 2026 18:33:44 -0400
Message-ID: <20261029223348.3730738-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: uJEBCbARyl7lUb4OGW6ysQx4Unv-hmRA
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3c9d2 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=9FqMP2l-1xbnh21W5mUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX5KEc3flI8dZj
 gs4mjMNxtEt8GFYYxQaG5wGNonh+8rH3ZgiRK1cPr5PDHoYGikXliWLKT4TB/FEQUPoGOeqQTPk
 bV8zIPYPjnrDi9rcl+7nV0/u+yu6Mp1lNIDH3toQj1xeVdM+44rzC9Qt5ByKrVBEMPqjWQ1Vb3J
 f6TbupkvYoTyc9Amg/c63ibOuYEx8+wVa/DiGfhUtsgFyqkLNMvpmPUkUX2uI5fQ1RU3J93uGKB
 JoHPXWnonLSD0x29IMBWQnTSVOG7DbvuvQTSYdytfvybdzBuOLdmNCV/4RAkHojoNWotYVJ7QWw
 fu60BvO2PfweE1Et9ciVlCMw1Xt/kAFYzYjBL2YqzdrHeJYK4U1G1VrWpZBoRXKn4cnLB1rHEqr
 enavhwII21IZ3DG9bHcJHfG0MyhbCxFhyqGMhNju1R4KjgVXNYCA2O24mUkXGZ9jG3du9zeDDcQ
 NpyBuV5/r6R0eJ9hDRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX6EQyrxv6GNia
 vpwPVVCgJDelYmjNmL9mvG83Dm8tAB9YSZWE28z6iBYD/INWg2mUpNci5De+8/hJvcYKsSvzXPl
 9CvwmCpPrxEcuBNbK6C3oW1rxpmYf7wYO1LpdF0q/3pHz+dZLqpj
X-Proofpoint-ORIG-GUID: uJEBCbARyl7lUb4OGW6ysQx4Unv-hmRA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

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
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ff04718d47c1..e2cea1bca1d2 100644
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
@@ -956,11 +956,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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
@@ -1247,7 +1247,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_strategy = should_load ? BPF_PROG_LOAD_STRATEGY_AUTO
+				: BPF_PROG_LOAD_STRATEGY_DISABLED;
 	}
 
 	return 0;
@@ -1338,7 +1339,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1376,7 +1377,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3811,7 +3812,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6500,7 +6501,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -8171,7 +8172,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -8207,7 +8208,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -9299,8 +9300,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
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
@@ -10092,7 +10093,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			    prog_has_callx(&obj->programs[i]))
 				text_has_callx = true;
 		for (i = 0; i < obj->nr_programs; i++)
-			if (obj->programs[i].autoload && !prog_is_subprog(obj, &obj->programs[i]) &&
+			if (obj->programs[i].load_strategy != BPF_PROG_LOAD_STRATEGY_DISABLED &&
+			    !prog_is_subprog(obj, &obj->programs[i]) &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
 		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
@@ -10776,16 +10778,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
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
@@ -16174,7 +16173,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -16284,3 +16283,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
+{
+	if (prog->obj->state >= OBJ_PREPARED)
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
index 03f794f4adb0..a91e43cbba20 100644
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
+ * Can only be called before the enclosing bpf_object is prepared.
+ *
+ * @param prog BPF program to update
+ * @param strategy new load strategy for the program
+ * @return 0 on success; negative error code if the object was already prepared
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
index eeba4072a5da..c06fc6b68efd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -475,4 +475,7 @@ LIBBPF_1.8.0 {
 } LIBBPF_1.7.0;
 
 LIBBPF_1.9.0 {
+	global:
+		bpf_program__load_strategy;
+		bpf_program__set_load_strategy;
 } LIBBPF_1.8.0;
-- 
2.34.1

