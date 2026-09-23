Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA13D3301
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206201; cv=none; b=JQp03QGWQqAXjAJRmHHGr1dCv/8VdAr08louQpDJiqejgI7vm7Akl+Zubb1HdrPuEURwPmDOo2zBeHtOiwTaBj9mGu0X7XAfb/MiC4h8hrET7gdL5EIOpeAQ+ucWb51KQww62XYzjOtis49A94yyhQdiNxnyrXNzVe3ZFm/oqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206201; c=relaxed/simple;
	bh=k6ZTdxR4iGNyADxWQprZjWENA9KbpzofliTKg4ojAP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBGr8YpkzkxJtxQjgEmKLZlX57ZkR6abyfWW38Y3S00zHCHhXD4GgMwei1cXRtEqXghZcAQ7P3JVrvUXHyA/IoQ8Cwderxgr5IwA1kONSjzRoOaNAPSr7kybBAGPuV8x15bSgQHHEuJjwOjLxp5UcKaqxvbEFEx2h7zrJaM5664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ihItzU3Q; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ihItzU3Q"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKm4Fg858067;
	Wed, 23 Sep 2026 23:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ZHmnguMgQt0+iaQGa7LcMiRDcr6irjW4HCqtfGjVpes=; b=ihIt
	zU3Qu+G5lXMHmZVjUVXIo+SjM3+fWOQX4h3h7QpY43cv3OP1pFfW93U0IFTW+0iU
	BOeo8x42g90bnl1sLD7spjQpzrrZLqkxyvZTifjSqwup4ziiORZ9zK872H+DSnpr
	zF73yWm3+6B38kcSijDJdsh/LQJd3vVqQiGgNZNFfDCaqqRYwDiL1eQgXk/JFivO
	Lny90urfzSdK7Jev7icoOjtorq9nxsmbyBVctMV05SCis7jfLUvC7EdalyZdNI3D
	TmWsSHFovq1t5VC/3d/c8qc7WaPCTettC/Nxk1HG7m5NA3ZjK0WDCuBeCoQsUaEV
	YYSEzR+5xOaFuZ/GKQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gvp4ggck3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:43 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:41 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
Date: Wed, 23 Sep 2026 19:29:33 -0400
Message-ID: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX4+dw9MhddAyM
 HEMBwiRuMGaMTA/tMzsvmEX7nc47G4jPhptLPIcE5XHYFDnBY0mN2YBBFQZ8gTcrw0egmUY/tJX
 QAJPQGgxeowjINmPqpuzsNLUXC+y7wy3M9oaW/QQ/ewLUfC+zZOh21cjl6jgFJr4C3PtUv8TsGz
 ZyFBE/Z0/mJ0YDoa+cE1IO/Xl4IjdHD16vaWh2BT69znerIqBAgNDKYkk0M//8dT9/aCJs8qIOs
 XXVkk5oPhVn07hPAjm7e3mO38O83UomUg6jk7DUnW/oSaokaKjMmraUdNZGB5KeaHI2iW43Omh+
 6JRO1XHbLBT+0keuqBfgEObauMaVPkNsFy6gd4zB9O4InjWpeEoonS8MvGUF1L9l8HFVpXZ37P1
 PvULX78WkI8febfusDHaAorDt6TnjaBGBaS5azqURxYOmzO2xnRPTopX6jmdIBKAVfM6g6/hKTd
 DNdIU1I5rAQrKqgXSqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfXwb/vYrbJG2ni
 yQuF4eRxo3kMFhko+UEzt1lBUCKG8/U6l05NE/ZouhwoHlKvf7sncE6El3fLXpTuCshynyY38Tg
 LZe4ka+RzqXv0TQ1jcKaU8ZZXxt1B9NzNLWbitCUcrXKrFgdrAKF
X-Authority-Analysis: v=2.4 cv=Edpd0/mC c=1 sm=1 tr=0 ts=6ab460e7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=40n9pdhONQV276rFn2UA:9
X-Proofpoint-ORIG-GUID: gfIsTMrnqFUVIIaLT24W9HxFTuq91xa5
X-Proofpoint-GUID: gfIsTMrnqFUVIIaLT24W9HxFTuq91xa5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230095

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
 tools/lib/bpf/libbpf.c   | 200 +++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |  32 ++++++-
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 204 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3085847cb97..939f0d6378e3 100644
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
 
@@ -797,7 +799,7 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn);
 static Elf64_Sym *elf_sym_by_idx(const struct bpf_object *obj, size_t idx);
 static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx);
 
-void bpf_program__unload(struct bpf_program *prog)
+static void bpf_program_unload_full(struct bpf_program *prog)
 {
 	if (!prog)
 		return;
@@ -809,12 +811,30 @@ void bpf_program__unload(struct bpf_program *prog)
 	zfree(&prog->subprogs);
 }
 
+void bpf_program__unload(struct bpf_program *prog)
+{
+	if (!prog)
+		return;
+
+	/*
+	 * MANUAL programs retain their data here so bpf_program__load()
+	 * can reload them later; object teardown paths call
+	 * bpf_program_unload_full() instead to always release it fully.
+	 */
+	if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
+		zclose(prog->fd);
+		return;
+	}
+
+	bpf_program_unload_full(prog);
+}
+
 static void bpf_program__exit(struct bpf_program *prog)
 {
 	if (!prog)
 		return;
 
-	bpf_program__unload(prog);
+	bpf_program_unload_full(prog);
 	zfree(&prog->name);
 	zfree(&prog->sec_name);
 	zfree(&prog->insns);
@@ -8438,6 +8458,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			pr_debug("prog '%s': skipped auto-loading\n", prog->name);
 			continue;
 		}
+
 		prog->log_level |= log_level;
 
 		if (obj->gen_loader)
@@ -8463,6 +8484,8 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			obj->has_manual_progs = true;
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -8489,6 +8512,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
+		/*
+		 * struct_ops programs are incompatible with manual loading
+		 * (see bpf_program__set_load_strategy()); reject SEC("!...")
+		 * here too, at declarative parse time, since that check only
+		 * runs on the imperative bpf_program__set_load_strategy() path.
+		 */
+		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+		    prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
+			pr_warn("prog '%s': struct_ops programs do not support manual loading\n",
+				prog->name);
+			return -EINVAL;
+		}
+
 		/* sec_def can have custom callback which should be called
 		 * after bpf_program is initialized to adjust its properties
 		 */
@@ -8689,7 +8725,7 @@ static int bpf_object_unload(struct bpf_object *obj)
 	}
 
 	for (i = 0; i < obj->nr_programs; i++)
-		bpf_program__unload(&obj->programs[i]);
+		bpf_program_unload_full(&obj->programs[i]);
 
 	return 0;
 }
@@ -9132,33 +9168,50 @@ static void bpf_object_unpin(struct bpf_object *obj)
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
+	if (force || !obj->has_manual_progs)
+		zfree(&obj->fd_array);
 
 	/* clean up BTF */
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, force);
 }
 
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
@@ -9233,7 +9286,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, false);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
@@ -9701,7 +9754,7 @@ void bpf_object__close(struct bpf_object *obj)
 	 * bpf_object__load(), we need to clean up stuff that is normally
 	 * cleaned up at the end of loading step
 	 */
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, true);
 
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
@@ -9710,7 +9763,6 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
-	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
@@ -9892,9 +9944,13 @@ bool bpf_program__autoattach(const struct bpf_program *prog)
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
@@ -12818,7 +12874,7 @@ static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *
 	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
 
 cleanup:
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, false);
 	return err;
 }
 
@@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 
 int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
 {
-	if (prog->obj->state >= OBJ_LOADED)
+	struct bpf_object *obj = prog->obj;
+
+	/*
+	 * has_manual_progs is snapshotted once in bpf_object_prepare_progs()
+	 * and never recomputed; once the object is prepared, no transition
+	 * into or out of MANUAL may change which programs are MANUAL,
+	 * regardless of direction. AUTO<->DISABLED transitions never touch
+	 * MANUAL and keep the looser, pre-existing OBJ_LOADED gate.
+	 */
+	if (strategy == BPF_PROG_LOAD_STRATEGY_MANUAL ||
+	    prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
+		if (obj->state >= OBJ_PREPARED)
+			return libbpf_err(-EINVAL);
+	} else if (obj->state >= OBJ_LOADED) {
+		return libbpf_err(-EINVAL);
+	}
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
+		/*
+		 * struct_ops programs are incompatible with manual loading:
+		 * bpf_map_prepare_vdata() bakes each member's fd into kern_vdata
+		 * automatically during bpf_object__load(), before a MANUAL member
+		 * could ever be loaded, and nothing re-bakes it afterwards.
+		 */
+		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+			return libbpf_err(-EINVAL);
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
 
@@ -15386,3 +15501,34 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
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
+bpf_program__load(struct bpf_program *prog)
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
+		pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
+		return libbpf_err(err);
+	}
+
+	return 0;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e7255bd4247f..faea42f75847 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -392,7 +392,7 @@ LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog)
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
-LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
+LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
 
 struct bpf_insn;
 
@@ -473,6 +473,16 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
  * @return 0, on success; negative error code, otherwise
  */
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
+/**
+ * @brief **bpf_program__unload()** unloads a BPF program, closing its fd.
+ *
+ * If the program's load strategy is BPF_PROG_LOAD_STRATEGY_MANUAL, only the
+ * fd is closed and the program's data is retained so it can be reloaded
+ * later via bpf_program__load(). For any other load strategy, the program's
+ * data is also freed and it cannot be reloaded.
+ *
+ * @param prog BPF program to unload
+ */
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
 struct bpf_link;
@@ -2122,21 +2132,28 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
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
  * @brief **bpf_program__set_load_strategy()** sets the load strategy of a
  * BPF program, controlling whether and when it gets loaded into the kernel.
  *
- * Can only be called before the enclosing bpf_object is loaded.
+ * Can only be called before the enclosing bpf_object is loaded, except when
+ * the program's current or new strategy is BPF_PROG_LOAD_STRATEGY_MANUAL, in
+ * which case it can only be called before the enclosing bpf_object is
+ * prepared.
  *
  * @param prog BPF program to update
  * @param strategy new load strategy for the program
  * @return 0 on success; negative error code if the object was already loaded
+ * (or, if the program's current or new strategy is
+ * BPF_PROG_LOAD_STRATEGY_MANUAL, already prepared)
  */
 LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
 					      enum bpf_prog_load_strategy strategy);
@@ -2150,6 +2167,17 @@ LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
  */
 LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
 
+/**
+ * @brief **bpf_program__load()** loads a BPF program whose load strategy is
+ * BPF_PROG_LOAD_STRATEGY_MANUAL. The enclosing bpf_object must already be
+ * prepared.
+ *
+ * @param prog BPF program to load; must not be a subprogram, must have load
+ * strategy BPF_PROG_LOAD_STRATEGY_MANUAL, and must not already be loaded
+ * @return 0 on success; negative error code otherwise
+ */
+LIBBPF_API int bpf_program__load(struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 03c3d2bd15bf..8def5474885a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -463,6 +463,7 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
 		btf__find_by_name_kind_own;
-- 
2.34.1

