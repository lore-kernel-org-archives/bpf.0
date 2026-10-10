Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC883603DD
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643906; cv=none; b=YzKW7hvayBUv4MQVKlEmShvs06BoZtkbpj7dqCQBMW0eN4huvLdpXray3pzfjcw92l4cxoivZ9m6bizwajI2MJ/fYa4kvQuXP0vccCGJQwYAZXVWHBdB1BNDBGJycglj9iBypykobfHM9dZGNHsj/IMP7Ona1PyUU5NEV06/NTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643906; c=relaxed/simple;
	bh=BGUlmhC/EanR88KT1d1VCtX3DG7plu6ivNFcIV2Ky7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrLiCiekiSdZ1eT8muRPGIYkPu4ybsWl+jHpiqs43fq6WgfnXRHR6qLwn6BhQWoYopRMMOe1I5Wb6HhnppSOa/BH51R49w2SJm8RKYXNMNuEAjOk1isG+2b1TsBuGFuh9HILOh7H0qdiaDOC3W4PAW3IkEL0xRa5LUtAAMyosXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ThtHjrJY; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ThtHjrJY"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKm8I2198634;
	Sat, 10 Oct 2026 14:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=+vNhlbFmrfmFIVYf7RYqfEIFl0pGDpzCQ7s0atlxkvI=; b=ThtH
	jrJY2eqhTvGhfUj635uqleYWc2zeU2zLjZYpDQqyjmawCcnzcZZOgrAsRvLNFKqu
	wIkMxOc1QNMMs1nbLn/4zwjafN66GqVTciZihB2Z0t694WkfB6qiDaeXe7KUdpJT
	LTUwAnKrpg4c8VKQjWIr7sC4uENRsP/2I8EdSS7YI4Eme0wExllgfVhnZdLr/f2p
	BD2bR6fQDWbvSYMcpHz3MsMqX44xaEJ2x4sGHbJJx64I+LMQGsJM8XCcix55z14e
	q+Fjl3tmtYzCLMGvbd3+FGuUtNhiB5X9k/IIrhZ0M02gmMgO3z4+riAkAmc05Eyg
	NGIgYav+18sacuMkcA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74ujtjjv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:01 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:32:00 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 3/7] libbpf: BPF programs manual loading and attaching
Date: Sat, 10 Oct 2026 10:31:52 -0400
Message-ID: <20261010143156.379864-4-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6aca4c62 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=ggV7upndeWQL3uEtfI4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfXytsdiz/jC0r9
 JS9qxPKc6PyiwR/TaHrZBfADkKmB03QbiTuO5OpkJiJ0/5F8pLs7/dkd03naoewwkWfmvv0lyRJ
 WZ08FQ+KSeWOrD47fqgQiDkv3joE25nuAQtKsBa07Xc9pJFMAoch
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfXwMTVD/Rl8JQn
 mwRt/2/BpspzWIDOL1jhy8HwS/IzWtdIo66OO3iLhSvUHjkk1+v3Nq5r7IiVnCDEN0Qa7sv4/ps
 cZ8D+wqJHkhwnqf+YVuY93D0Fl5dS2Qtx4if+q5F/rN+qkhYeA5pmZdIZ3mzBDn7whIhVtHT8G8
 wx82O2lMK5lYCmqTXNFjR1+FyuzdoOi0poqtLzLPVG1sbU357e90ISE7b8jDPHSxDKEDHwcZH/Y
 6+pZPuMDUzexeSpC5JIpL8Z0n9Vm3+rWxBOQN1ZCvfeHxSuHCpguyoEDXFp6gP4+xkfC51jH4Hy
 I9x7i5uvRZkHpvWutna7RWCeznd6Nn/9uwab+sWo0iX7JTMUrhWUfG0qH0zh/jrPG+aFRiZ52Wm
 t1UJGh3zRuCrhjxx8y1Vj1uHyeVr+sKt/bZpVD2uK/zwbujfkJCTyX+7Eic/QmPmeb+9Vd61CcM
 d5hUFw7osTdUhFWmkdA==
X-Proofpoint-GUID: zw9vItwuEqW-Nm-Vi7tvXoZKNRo3NY-p
X-Proofpoint-ORIG-GUID: zw9vItwuEqW-Nm-Vi7tvXoZKNRo3NY-p
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100057

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

A manual-strategy program is loaded via bpf_program__load()
and unloaded via bpf_program__unload(). It only requires that
bpf object is already in PREPARE state (BTF loaded, maps created,
relocations applied) rather than requiring a full bpf_object__load().
Manual programs are skipped by the object's own autoload pass.

A few key changes described below:

gen_loader is rejected if any manual program is present since
this loader is finalized during bpf_object__load()
and so it will miss any manual programs loaded later.

To support veristat conversion from clone to manual loading
a few commits later, several changes to libbpf had to be applied:

2 program log related APIs were relaxed to work post OBJ_LOADED
state to fix regression where verifier logs were lost in case of
bpf_object__prepare failure. It makes sense to relax those for MANUAL
programs as they can load post OBJ_LOADED state so the log buff still
can be set at this point.

Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in several
places code related to struct_ops logic was altered to take into account
struct_ops program with MANUAL strategy set. The general idea is to reject
this type of programs for manual loading since those programs cannot
load/unload independently of each other per a given struct ops.
SEC("!...") style declaration is rejected for them. On the other hand,
bpf_program__set_load_strategy() accepts them because otherwise
veristat is rejecting them.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 218 +++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h   |  38 ++++++-
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 233 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb0512e5facf..42fb687a9795 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -758,6 +758,7 @@ struct bpf_object {
 
 	bool has_subcalls;
 	bool has_rodata;
+	bool has_manual_progs;
 
 	struct bpf_gen *gen_loader;
 
@@ -864,7 +865,7 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn);
 static Elf64_Sym *elf_sym_by_idx(const struct bpf_object *obj, size_t idx);
 static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx);
 
-void bpf_program__unload(struct bpf_program *prog)
+static void bpf_program_unload_full(struct bpf_program *prog)
 {
 	if (!prog)
 		return;
@@ -876,12 +877,30 @@ void bpf_program__unload(struct bpf_program *prog)
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
@@ -1222,6 +1241,15 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
 			continue;
 
+		/*
+		 * We avoid this for MANUAL programs to allow veristat
+		 * conversion from clone() to MANUAL loading. Setting AUTO
+		 * for a program would cause it to be rejected during manual
+		 * loading.
+		 */
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			continue;
+
 		for (j = 0; j < obj->nr_maps; ++j) {
 			const struct btf_type *type;
 
@@ -5868,6 +5896,20 @@ static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
 			continue;
 
 		targ_prog = map->init_slots[i];
+
+		/*
+		 * Be careful about manual progs, reject if they weren't loaded before
+		 * this step to not insert invalid FDs into the map, otherwise we will
+		 * get a much less clear rejection from the kernel on the element update
+		 * below.
+		 */
+		if (targ_prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL &&
+		    targ_prog->fd < 0) {
+			pr_warn("map '%s': slot [%u] prog '%s' is MANUAL but not loaded\n",
+				map->name, i, targ_prog->name);
+			return -EINVAL;
+		}
+
 		fd = bpf_program__fd(targ_prog);
 
 		err = bpf_map_update_elem(map->fd, &i, &fd, 0);
@@ -9271,6 +9313,8 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			obj->has_manual_progs = true;
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9297,6 +9341,21 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
+		/*
+		 * struct_ops programs declared SEC("!...") are rejected
+		 * here at declarative parse time for manual loading.
+		 * bpf_program__set_load_strategy() does allow MANUAL for struct_ops
+		 * via its imperative API, but only as a narrow accommodation for
+		 * veristat, which needs to verify each program in isolation
+		 * without ever calling bpf_object__load().
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
@@ -9497,7 +9556,7 @@ static int bpf_object_unload(struct bpf_object *obj)
 	}
 
 	for (i = 0; i < obj->nr_programs; i++)
-		bpf_program__unload(&obj->programs[i]);
+		bpf_program_unload_full(&obj->programs[i]);
 
 	return 0;
 }
@@ -9888,7 +9947,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 	return 0;
 }
 
-static void bpf_map_prepare_vdata(const struct bpf_map *map)
+static int bpf_map_prepare_vdata(const struct bpf_map *map)
 {
 	const struct btf_type *type;
 	struct bpf_struct_ops *st_ops;
@@ -9904,16 +9963,32 @@ static void bpf_map_prepare_vdata(const struct bpf_map *map)
 		if (!prog)
 			continue;
 
+		/*
+		 * Manual struct_ops programs don't get along well with manual
+		 * loading: all the progs belonging to the same struct_ops must
+		 * load and unload together, which is the opposite of the manual
+		 * load concept.
+		 * Still, we allow manual progs here as long as they were loaded
+		 * before this step ast this still will work.
+		 */
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL && prog->fd < 0) {
+			pr_warn("map '%s': struct_ops member prog '%s' is MANUAL but not loaded\n",
+				map->name, prog->name);
+			return -EINVAL;
+		}
+
 		prog_fd = bpf_program__fd(prog);
 		kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
 		*(unsigned long *)kern_data = prog_fd;
 	}
+
+	return 0;
 }
 
 static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 {
 	struct bpf_map *map;
-	int i;
+	int i, err;
 
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
@@ -9924,7 +9999,9 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 		if (!map->autocreate)
 			continue;
 
-		bpf_map_prepare_vdata(map);
+		err = bpf_map_prepare_vdata(map);
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -9940,10 +10017,19 @@ static void bpf_object_unpin(struct bpf_object *obj)
 			bpf_map__unpin(&obj->maps[i], NULL);
 }
 
-static void bpf_object_cleanup_btf(struct bpf_object *obj)
+static void bpf_object_cleanup_btf(struct bpf_object *obj, bool force)
 {
 	int i;
 
+	/*
+	 * Module BTF fds and btf_vmlinux are still needed by
+	 * programs that have not been manually loaded yet, so defer freeing
+	 * them to the end of the object lifetime, unless the caller forces
+	 * immediate cleanup.
+	 */
+	if (!force && obj->has_manual_progs)
+		return;
+
 	/* clean up module BTFs */
 	for (i = 0; i < obj->btf_module_cnt; i++) {
 		close(obj->btf_modules[i].fd);
@@ -9960,13 +10046,38 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 	obj->btf_vmlinux = NULL;
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
+}
+
+static int bpf_object_check_gen_loader(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+
+	if (!obj->gen_loader)
+		return 0;
+
+	/*
+	 * gen_loader only records programs loaded by bpf_object__load_progs(),
+	 * which skips MANUAL ones.
+	 */
+	bpf_object__for_each_program(prog, obj) {
+		if (prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
+			continue;
+		pr_warn("prog '%s': gen_loader does not support manually-loaded programs\n",
+			prog->name);
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
 static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
@@ -9978,7 +10089,8 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 		return -EINVAL;
 	}
 
-	err = bpf_object_prepare_token(obj);
+	err = bpf_object_check_gen_loader(obj);
+	err = err ? : bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
@@ -10061,7 +10173,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, false);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
@@ -10529,7 +10641,7 @@ void bpf_object__close(struct bpf_object *obj)
 	 * bpf_object__load(), we need to clean up stuff that is normally
 	 * cleaned up at the end of loading step
 	 */
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, true);
 
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
@@ -10538,7 +10650,6 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
-	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
@@ -10864,7 +10975,13 @@ __u32 bpf_program__log_level(const struct bpf_program *prog)
 
 int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level)
 {
-	if (prog->obj->state >= OBJ_LOADED)
+	/*
+	 * Here and below, OBJ_LOADED is not a relevant restriction for
+	 * manual programs as those can load after the bpf object is
+	 * already loaded.
+	 */
+	if (prog->obj->state >= OBJ_LOADED &&
+	    prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
 		return libbpf_err(-EBUSY);
 
 	prog->log_level = log_level;
@@ -10883,7 +11000,8 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 		return libbpf_err(-EINVAL);
 	if (log_size > UINT_MAX)
 		return libbpf_err(-EINVAL);
-	if (prog->obj->state >= OBJ_LOADED)
+	if (prog->obj->state >= OBJ_LOADED &&
+	    prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
 		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
@@ -13663,7 +13781,7 @@ static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *
 	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
 
 cleanup:
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, false);
 	return err;
 }
 
@@ -16220,10 +16338,41 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 
 int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
 {
-	if (prog->obj->state >= OBJ_LOADED)
+	struct bpf_object *obj = prog->obj;
+
+	/*
+	 * obj->has_manual_prog is set once in bpf_object_prepare_progs()
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
 		return libbpf_err(-EINVAL);
+	}
+
+	if (strategy == prog->load_strategy)
+		return 0;
+
+	switch (strategy) {
+	case BPF_PROG_LOAD_STRATEGY_DISABLED:
+	case BPF_PROG_LOAD_STRATEGY_AUTO:
+		prog->load_strategy = strategy;
+		break;
+	case BPF_PROG_LOAD_STRATEGY_MANUAL:
+		if (prog_is_subprog(obj, prog))
+			return libbpf_err(-EINVAL);
+
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		break;
+	default:
+		return libbpf_err(-EINVAL);
+	}
 
-	prog->load_strategy = strategy;
 	return 0;
 }
 
@@ -16231,3 +16380,32 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
 {
 	return prog->load_strategy;
 }
+
+int
+bpf_program__load(struct bpf_program *prog)
+{
+	int err;
+	struct bpf_object *obj = prog->obj;
+
+	/*
+	 * This function cannot be called before OBJ_PREPARED -
+	 * Program's data is initialized on object prepare.
+	 */
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
index e7255bd4247f..8dbed8ec3789 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -473,6 +473,17 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
  * @return 0, on success; negative error code, otherwise
  */
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
+
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
@@ -1050,9 +1061,12 @@ LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 flags);
  */
 LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
 
-/* Per-program log level and log buffer getters/setters.
+/*
+ * Per-program log level and log buffer getters/setters.
  * See bpf_object_open_opts comments regarding log_level and log_buf
- * interactions.
+ * interactions. The setters return -EBUSY once the object is loaded,
+ * except for BPF_PROG_LOAD_STRATEGY_MANUAL programs, which are loaded
+ * independently by bpf_program__load().
  */
 LIBBPF_API __u32 bpf_program__log_level(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level);
@@ -2122,21 +2136,27 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
  *
  * - BPF_PROG_LOAD_STRATEGY_DISABLED: the program is not loaded.
  * - BPF_PROG_LOAD_STRATEGY_AUTO: the program is autoloaded when the bpf_object is loaded.
+ * - BPF_PROG_LOAD_STRATEGY_MANUAL: the program is loaded and attached manually.
+ *   It is skipped by the skeleton's auto-attach, whatever its autoattach
+ *   setting is.
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
+ * Can only be called before the enclosing bpf_object is loaded for
+ * non MANUAL-> non MANUAL transitions. For manual it only
+ * before bpf_object is prepared.
  *
  * @param prog BPF program to update
  * @param strategy new load strategy for the program
- * @return 0 on success; negative error code if the object was already loaded
+ * @return 0 on success; negative error code error.
  */
 LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
 					      enum bpf_prog_load_strategy strategy);
@@ -2150,6 +2170,16 @@ LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
  */
 LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
 
+/**
+ * @brief **bpf_program__load()** loads a MANUAL BPF program. The enclosing
+ * bpf_object must already beprepared.
+ *
+ * @param prog BPF program to load; non MANUAL programs, already loaded
+ * programs and subprograms are rejected.
+ * @return 0 on success; negative error code otherwise
+ */
+LIBBPF_API int bpf_program__load(struct bpf_program *prog);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 689de28fe436..9835e660350b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -464,6 +464,7 @@ LIBBPF_1.8.0 {
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
 		bpf_program__clone;
+		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
 		btf__add_loc_param;
-- 
2.34.1

