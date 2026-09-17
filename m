Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33664E9C1D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677049; cv=none; b=QL462SLJELlwIQwhM0661cknC/rxdfjnyvpmzxOQZUgsJAeO7ZELUl5L3+toCXu0k6HEmTB5asu72Uf+C3g0HxlqzbjDPz+JcKnh7jhScaP/Hj7f+YD7/w4hw0fmrAEYY9vQAXm4EByOchVtSsBAnh3TwwZUirIQMqtP9Z705VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677049; c=relaxed/simple;
	bh=OIFgXd2ZgjXEBRC0Nej01Xm2A3gMlw5dPkGHMuB68mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7RzTDBqG6gDAVSnodfiihIoNSIXxLOSy++i+vfQV3Say94j0utTfXyVnKAFvS5b4/5+M1fFt+NVSUJeW+9CtciOROsgVosd8FcomjWgYvrb6i6Xjajmv0LV+qRBBz0okgeLXjfCCyKtF5gCzZpL17sfVhldVcWW8vexMmV/iV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DbQ4xrwY; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DbQ4xrwY"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHZRs3271760;
	Thu, 17 Sep 2026 20:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=EI1eSXNgoFPTUwR5FLdI85PFiPQ9vFFOm0BRtASVxl0=; b=DbQ4
	xrwYw3cZX8m4AdoGHpNPBmuPG7Ahhm0zkJYOthU5cxitKg34na3iWL6ezngimtSC
	C/YL4pHMoE8axQ6xMSgZ+A36SOPdKCpA0XWUOhoLyhLouJQd52HP5tSXrEqiWl2n
	JdaOHUq5pyFHFCkfm/Q5y6CBztx+KoM1lKQXLz9e5lhyk/NII5mm1UqDlGHiVDzN
	xkm5k+jfM1sgU+ZRX6MO5rP4RgROypdB7Ex6pLs0WFh19JZiJBG/nvvxx2SCRYPh
	NT5CFnde0Vyd/4F03hQL9VbiJgi6W+3bZvxWy1DD61h/vrXZMWPLCmXxRslEkmvh
	wbPgNnhwY0O2X3qyNQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4grmr60rk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:44 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:42 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 1/6] libbpf: BPF program load strategy enum
Date: Thu, 17 Sep 2026 16:30:35 -0400
Message-ID: <20260917203040.3150212-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX/MJrSGGpXup+
 s/ZG771UJGoP14po86KWrs7zkUvV0fsD0g1iOE0TMSr0Etm60+tRdV3FCw0Y/WnHr8LqDp8QqKf
 7hp+fm4FLQDJdXyXLSHApLVCEziiGx1P1czI53Kp9WpVtUHKPtjM
X-Authority-Analysis: v=2.4 cv=OcQNnRTY c=1 sm=1 tr=0 ts=6aac4df4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8
 a=2A3Asy7NaOYSI4mtEPsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX4OUmE9QS9/O3
 DCyFe+HQLVo7PonOyTBzvV0cY0UM0pV/avH40b9cRuwbtc6Vxhjr1YX6a04OeXhcFrtdRf7/lTC
 TjXoz4Tab+0kAhanWKraMn/27sqFIOy9Gr1m2jtDhtbiptie/xm/LbSqGp1WKmh5yoxkN3HDRvk
 YoERvRZh7Bsi4grACOPF6+6WWiRvBKQL5SXy9MBUYH+G+S8kkbtFm7PdhwH0ctXdjYomfL6Ht1+
 dJBRnPE7+GnFtyLAe8rKekNbnS+EVpYkpn9jnEkA3KwNBm5HuFj+1LzQW+NzepZWjBQ0h1FfFAP
 c14w7vM7zX7ndd8mz4DvQiDG2FKuv84A7+VlRN42p/XEyGax1DLPvgdskcNZNr2aoDoTK6a6GgD
 +8ru6Sii7qL9N90GakUs4lyD5a4Qgww6/sJNQyngyHhk1+s9t2RJ92fP8Y1iP6hC+oiFWlWoaTw
 gN6/0Vd5Aw32CZrwoPA==
X-Proofpoint-ORIG-GUID: 64FltaMkEPqyBZTviw5zA0p050EIbaEI
X-Proofpoint-GUID: 64FltaMkEPqyBZTviw5zA0p050EIbaEI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170294

From: Slava Imameev <slava.imameev@crowdstrike.com>

Replacing the boolean field with an enum simplifies the addition
of new load strategies. Currently, the bpf_program structure defines
the autoload behavior using a boolean field. This field is now
replaced with an enum, allowing new BPF program loading strategies
to be introduced by extending the enum value range.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 50 +++++++++++++++++++++++++---------------
 tools/lib/bpf/libbpf.h   | 33 ++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 613afae26519..bd510a4e4941 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -494,7 +494,7 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	enum bpf_prog_load_strategy load_strategy;
 	bool autoattach;
 	bool sym_global;
 	bool mark_btf_static;
@@ -872,11 +872,11 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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
@@ -1163,7 +1163,8 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			}
 		}
 		if (use_cnt)
-			prog->autoload = should_load;
+			prog->load_strategy = should_load ? BPF_PROG_LOAD_STRATEGY_AUTO
+				: BPF_PROG_LOAD_STRATEGY_DISABLED;
 	}
 
 	return 0;
@@ -1248,7 +1249,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 				 * then bpf_object_adjust_struct_ops_autoload() will update its
 				 * autoload accordingly.
 				 */
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 				st_ops->progs[i] = NULL;
 			}
 
@@ -1287,7 +1288,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * if user replaced it with another program or NULL
 			 */
 			if (st_ops->progs[i] && st_ops->progs[i] != prog)
-				st_ops->progs[i]->autoload = false;
+				st_ops->progs[i]->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 
 			/* Update the value from the shadow type */
 			st_ops->progs[i] = prog;
@@ -3587,7 +3588,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
 			return true;
@@ -6181,7 +6182,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			/* no need to apply CO-RE relocation if the program is
 			 * not going to be loaded
 			 */
-			if (!prog->autoload)
+			if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
@@ -7525,7 +7526,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
@@ -7561,7 +7562,7 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
-		if (!prog->autoload)
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_DISABLED)
 			continue;
 
 		/* Process data relos for main programs */
@@ -8400,8 +8401,8 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
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
@@ -9802,16 +9803,13 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
 
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
@@ -15125,7 +15123,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		struct bpf_program *prog = *prog_skel->prog;
 		struct bpf_link **link = prog_skel->link;
 
-		if (!prog->autoload || !prog->autoattach)
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_AUTO || !prog->autoattach)
 			continue;
 
 		/* auto-attaching not supported for this program */
@@ -15235,3 +15233,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
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
index 48266e752223..cdf300443f19 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -2100,6 +2100,39 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
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
index a811a1b3a085..f0bf6a846149 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,6 +462,8 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load_strategy;
+		bpf_program__set_load_strategy;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.34.1

