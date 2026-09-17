Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672754DEC39
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677051; cv=none; b=oynIbcFkNIjKqqwgdRnSRDU3cqhP64UEO5+Z+Ylgdz245fl+O66RGZBbaQV7cgSCQ2Q5ggMSKTmae155nOF4wc8AE3pKhIZeEe0HBpwtN9r8KvsxR4suClmQm6lIsITn0v6W8OJ935ACsG42Ia+USUnAC//ez37Nsf0+ArofuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677051; c=relaxed/simple;
	bh=+8aJTlAQfsNd7BZF+z0Pv2Z7VnomcAuqmXpF+LqSV2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bP63OqsqDmsLyVKI5pAr6aVQCdDeselqpkx6LcdhhUTZ0BP/DcC36qc5SiOpLSpbztpP/sUErNh1lq8407pa2016UGgxM4U9wF6tkozDrSaMcz4QuOzKPCuH5sWWdZa17P/gtBoLeZ6gTB6viG8hKc4LbjOR5qPNY1OkiiFsHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=QMD51lHv; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="QMD51lHv"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHxRPV3369834;
	Thu, 17 Sep 2026 20:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=R6i+yHX0L5OTTkq3D8YwLe/F3GFuYF4B/opOPDDYlmE=; b=QMD5
	1lHvQ8Pn9SuxtgcJ24nCjqPb0t+Q4zpMXIYv89rnFdEV6AhwTfueQYGOn9PRKttQ
	9YyLorNOzEoRwIcz5KndpS5wvFx2h6czlhfqoPNDK5xOZzslztkdHuOvGY6YJgpV
	HUCXDaOvKB39R7tKd1QOtSK6B1XFuJKn8kM+jEAPmI9V7HHxAmygaSUlMiykJxfr
	aTzo6n8rOymVc4nJqc2+wH0ZQT5mmVF5lDOSfTctOcxjki7lubRG7TeO1rdvfXu7
	XUwos6wN0LeOvIJwNvGvRImDz99yG8eZGo8t4RK8oYdAoddxxusKOnABHtDJvOUg
	so/p8C//LNBhhc9u3w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gr3dpmbv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:45 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:43 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 2/6] libbpf: BPF programs manual loading and attaching
Date: Thu, 17 Sep 2026 16:30:36 -0400
Message-ID: <20260917203040.3150212-3-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: ZjCLzY3fInNoRM_wef3Ul42gqVGsg-HG
X-Proofpoint-GUID: ZjCLzY3fInNoRM_wef3Ul42gqVGsg-HG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX6XTHt4u38wgN
 LNW06iukVqHBQTvAdtgAoXnSGHw73IkdlqgIrPsCLKef2xVoJTm1n/WDMu5o95gQVPjCLBKqcnA
 GMzD6wee4kM/tt8C0U3wGAfiCe05Xs9GEGf4tV8sf/ifMCXmbigC
X-Authority-Analysis: v=2.4 cv=UerE26SN c=1 sm=1 tr=0 ts=6aac4df5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=enU31hWeM7-UbnoPe7IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX0bcyJRryz8jj
 FAwqYd3m8RTY5rI+SOk1qSQyy4oOyc5iVuH7BwirDTBilB18XHUTZmY1/ulwcFYWlWCHoaqBWhw
 KmpjAMumogu26NKX29taQ2MTHQUn+ABusUWib6clYuryWxeg8kNN3shB9VPlx2c8NNuIOGoNCPl
 yRVk0X5n0ZIJHD5pOsnyZvi06x7wi7E94WEYf9W8LRb2oE1wehY6n0qrn71XzmO4hujdxLfB4HE
 S0hXSyofTq0syiJQUzvRIZ1wGQAr/qMtFp7i0TutogyGFRwszATpSBQfl6e8yhH/t9yjWVr+fDw
 1RYWfXGD0O2wK7X3pPRnHyTql0lcC1MWIA8S5S0zRU0ZCYvMCJruqAqJYmAaK1L7D8VTelmRlDN
 ZxOJaxgUWWH0sXlsgda+ooyt9h8m35rlKve3AHehv+ncHByHKfmG6Iu1LtuyMrhQDc7+uOhqrGU
 6ksffGof21x3/RWRufw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170294

From: Slava Imameev <slava.imameev@crowdstrike.com>

BPF programs designated as manually loaded can be loaded and
attached independently after the initial bpf_object loading and
attaching.

These programs can also be reloaded and reattached multiple times,
enabling more flexible management of a resident BPF program set.

A key motivation for this feature is to reduce load times for
utilities that include hundreds of BPF programs. When the selection
of a resident BPF program set cannot be determined at the time of
bpf_object loading and attaching, all BPF programs would otherwise
need to be marked as autoload, leading to unnecessary overhead.
This patch addresses that inefficiency.

A manual-strategy program is loaded via bpf_program__load_manually()
and unloaded via bpf_program__unload_manually(), gated on
bpf_object__prepare() having already run (BTF loaded, maps created,
relocations applied) rather than requiring a full bpf_object__load().
Manual programs are skipped by the object's own autoload pass.

Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 159 +++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |   7 +-
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 142 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bd510a4e4941..acb8caffa442 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -496,6 +496,7 @@ struct bpf_program {
 	int fd;
 	enum bpf_prog_load_strategy load_strategy;
 	bool autoattach;
+	bool saved_autoattach;
 	bool sym_global;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
@@ -725,6 +726,7 @@ struct bpf_object {
 
 	bool has_subcalls;
 	bool has_rodata;
+	bool has_manual_progs;
 
 	struct bpf_gen *gen_loader;
 
@@ -8058,7 +8060,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 			log_buf = prog->log_buf;
 			log_buf_size = prog->log_size;
 			own_log_buf = false;
-		} else if (obj->log_buf) {
+		} else if (obj->log_buf && prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL) {
 			log_buf = obj->log_buf;
 			log_buf_size = obj->log_size;
 			own_log_buf = false;
@@ -8405,6 +8407,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
+
 		prog->log_level |= log_level;
 
 		if (obj->gen_loader)
@@ -8430,6 +8433,8 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			obj->has_manual_progs = true;
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9063,33 +9068,50 @@ static void bpf_object_unpin(struct bpf_object *obj)
 			bpf_map__unpin(&obj->maps[i], NULL);
 }
 
-static void bpf_object_cleanup_btf(struct bpf_object *obj)
+static void bpf_object_cleanup_btf(struct bpf_object *obj, bool force)
 {
 	int i;
 
-	/* clean up module BTFs */
-	for (i = 0; i < obj->btf_module_cnt; i++) {
-		close(obj->btf_modules[i].fd);
-		btf__free(obj->btf_modules[i].btf);
-		free(obj->btf_modules[i].name);
+	/*
+	 * Module BTF fds may still be borrowed (via fd_array,
+	 * attach_btf_obj_fd, or baked into relocated instructions) by
+	 * programs that have not been manually loaded yet, so defer
+	 * closing them in that case to the end of the object lifetime,
+	 * unless the caller forces immediate cleanup.
+	 */
+	if (force || !obj->has_manual_progs) {
+		for (i = 0; i < obj->btf_module_cnt; i++) {
+			close(obj->btf_modules[i].fd);
+			btf__free(obj->btf_modules[i].btf);
+			free(obj->btf_modules[i].name);
+		}
+		obj->btf_module_cnt = 0;
+		obj->btf_module_cap = 0;
+		obj->btf_modules_loaded = false;
+		zfree(&obj->btf_modules);
 	}
-	obj->btf_module_cnt = 0;
-	obj->btf_module_cap = 0;
-	obj->btf_modules_loaded = false;
-	zfree(&obj->btf_modules);
 
-	/* clean up vmlinux BTF */
-	btf__free(obj->btf_vmlinux);
-	obj->btf_vmlinux = NULL;
+	/*
+	 * The btf_vmlinux data is needed for manually loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (force || !obj->has_manual_progs) {
+		btf__free(obj->btf_vmlinux);
+		obj->btf_vmlinux = NULL;
+	}
 }
 
-static void bpf_object_post_load_cleanup(struct bpf_object *obj)
+static void bpf_object_post_load_cleanup(struct bpf_object *obj, bool force)
 {
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
+	/*
+	 * The fd array is needed for manually loaded programs,
+	 * so defer freeing it in that case to the end of the object lifetime.
+	 */
+	if (force || !obj->has_manual_progs || !obj->fd_array_cnt)
+		zfree(&obj->fd_array);
 
 	/* clean up BTF */
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, force);
 }
 
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
@@ -9164,7 +9186,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, false);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
@@ -9632,7 +9654,7 @@ void bpf_object__close(struct bpf_object *obj)
 	 * bpf_object__load(), we need to clean up stuff that is normally
 	 * cleaned up at the end of loading step
 	 */
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, true);
 
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
@@ -9641,7 +9663,6 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
-	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
@@ -9817,9 +9838,13 @@ bool bpf_program__autoattach(const struct bpf_program *prog)
 	return prog->autoattach;
 }
 
-void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
+int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
 {
+	if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+		return libbpf_err(-EINVAL);
+
 	prog->autoattach = autoattach;
+	return 0;
 }
 
 const struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
@@ -12743,7 +12768,7 @@ static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *
 	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
 
 cleanup:
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, false);
 	return err;
 }
 
@@ -15236,10 +15261,48 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 
 int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
 {
-	if (prog->obj->state >= OBJ_LOADED)
+	struct bpf_object *obj = prog->obj;
+
+	if (obj->state >= OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
+	if (strategy == prog->load_strategy)
+		return 0;
+
+	switch (strategy) {
+	case BPF_PROG_LOAD_STRATEGY_DISABLED:
+	case BPF_PROG_LOAD_STRATEGY_AUTO:
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			prog->autoattach = prog->saved_autoattach;
+		prog->load_strategy = strategy;
+		break;
+	case BPF_PROG_LOAD_STRATEGY_MANUAL:
+		/*
+		 * Manually-loaded programs are not supported for gen_loader.
+		 * This is because bpf_object_load_prog is not called for
+		 * manually-loaded programs, so such programs are not visible
+		 * to gen_loader. For this reason, prevent calling
+		 * bpf_program__set_load_strategy(MANUAL) when gen_loader was
+		 * used to generate a BPF object loader.
+		 * A gen_loader implementation is being called for autoloaded
+		 * programs and defines its own model for loading BPF programs.
+		 * To pass a BPF program to gen_loader, set the program's load strategy
+		 * to LD_AUTOLOAD.
+		 */
+		if (obj->gen_loader)
+			return libbpf_err(-EOPNOTSUPP);
+
+		if (prog_is_subprog(obj, prog))
+			return libbpf_err(-EINVAL);
+
+		prog->saved_autoattach = prog->autoattach;
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		prog->autoattach = false;
+		break;
+	default:
 		return libbpf_err(-EINVAL);
+	}
 
-	prog->load_strategy = strategy;
 	return 0;
 }
 
@@ -15247,3 +15310,49 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
 {
 	return prog->load_strategy;
 }
+
+/*
+ * This function must be called after bpf_object__prepare (or
+ * bpf_object__load, which calls bpf_object__prepare internally).
+ * Manually-loaded program data is initialized on object prepare.
+ * Post-prepare initialization is not supported.
+ */
+int
+bpf_program__load_manually(struct bpf_program *prog)
+{
+	int err;
+	struct bpf_object *obj = prog->obj;
+
+	if (obj->state < OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
+	if (prog_is_subprog(obj, prog) || prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
+		return libbpf_err(-EINVAL);
+
+	if (prog->fd >= 0)
+		return libbpf_err(-EBUSY);
+
+	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
+				   obj->license, obj->kern_version, &prog->fd);
+	if (err) {
+		pr_warn("prog '%s': failed to load manually: %d\n", prog->name, err);
+		return libbpf_err(err);
+	}
+
+	return 0;
+}
+
+int bpf_program__unload_manually(struct bpf_program *prog)
+{
+	int err;
+
+	if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
+		return libbpf_err(-EINVAL);
+
+	/*
+	 * Close the file descriptor but retain the program's data to
+	 * support reloading the program if it is required again.
+	 */
+	err = zclose(prog->fd);
+	return err ? libbpf_err(-errno) : 0;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index cdf300443f19..5914e5001b97 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -378,7 +378,7 @@ LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog)
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
-LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
+LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
 
 struct bpf_insn;
 
@@ -2105,10 +2105,12 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
  *
  * - BPF_PROG_LOAD_STRATEGY_DISABLED: the program is not loaded.
  * - BPF_PROG_LOAD_STRATEGY_AUTO: the program is autoloaded when the bpf_object is loaded.
+ * - BPF_PROG_LOAD_STRATEGY_MANUAL: the program is loaded and attached manually.
  */
 enum bpf_prog_load_strategy {
 	BPF_PROG_LOAD_STRATEGY_DISABLED = 0,
 	BPF_PROG_LOAD_STRATEGY_AUTO,
+	BPF_PROG_LOAD_STRATEGY_MANUAL,
 };
 
 /**
@@ -2133,6 +2135,9 @@ LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
  */
 LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
 
+LIBBPF_API int bpf_program__load_manually(struct bpf_program *prog);
+LIBBPF_API int bpf_program__unload_manually(struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f0bf6a846149..401a8e268d33 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,8 +462,10 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load_manually;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
+		bpf_program__unload_manually;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.34.1

