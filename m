Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708354;
	b=wzcTfxT4sdWN1u2wq8JyYkAtkS+KoXO5JJvg4iEB8/AlfzajO/s0R5OHFBDPNsM7B+6c
	 3E7FOWdOUzrh3OmKH4+t0hTlkHcqG3piICVr7/WM67hFMop6+w/73JsWyhZ5cxhXTa/DJ
	 uirOmAiD939TPIwbg3P+F/lBg2J7GeiBFMQCZZxoZxWuPib4Krjmgh8rJPe/Bipc8EhpV
	 1899TFeOVAExFlf+LiNSEQ3JKay2FsrXalGqChhXa6JJLs9OYBvrzPvVyFksu6UmHKLh1
	 wiYpEmpBW0ccyLRPYoY36eTit+416TB9s2yRn0RixirrgmTpg+McdUFmvPWHnf+z/Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708354;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IqqdtCgnJ5af21YABUwhJpdJSJa4PNd7lsiGEzKyQ0s=;
	b=ewvfzKXARNrUZleyFuoe0rW8Nm91xPI2KKBaqUs4w01lcc6yGqfarf2SuHE3zqXcNP+M
	 jbT5J33Stf482OEIRVUhB9mJesE/jHaHwNv4JiynDa4DmJq9CAhbKpA5+Tay/9R0yKvPO
	 ob95ay2QU98BtbkmKJiQJmKeccYrynOBkDvyqxmNDVYN+VGwnSYsFh09auBP3uadLxTZv
	 vuYoQ/yeZ1Pms0ggYne/J2An9jrI7AIx0YjQ12THc9yHTN6dU48uQrX4gusbfsKzD6MHs
	 yoK7k8uRfYhKBYUoh9OquAj34U0gzU/5eECpipQRAh4BRJaBTDwFhg05zA1Un+UwG1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=muJH+cJw;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF3606A322
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFF3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=muJH+cJw
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHMjI23482995;
	Thu, 22 Oct 2026 22:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=IqqdtCgnJ5af21YABUwhJpdJSJa4PNd7lsiGEzKyQ0s=; b=muJH
	+cJww8wjhwT8cKwJdJt0NoRPk9qzxaAqMnyws7st98lF86h7d1UqYrXxYObVmf6Q
	dmX1fhds+VOPfJOA967cO5u3FVoPoWzP95YTxhQy4J2G9A36worP+6cBPG/Qx0pB
	wDyxdTMCAaNyF49n+prKpqkHfipY5Zo5p9YYVDdH+8zc1naA89kfbMGDERbQZf0l
	G/Bqwxfpch87B4/O2jRKU6AOw3rlSANzortFzXC6gVoHV3qRkAzC//+3P+ZJJfRO
	GJtdy42Cwq2nbl0S9QAeTXbkF1LEPecmjxN7vyHvy3ci8exbmcJ26jTial2hrgnR
	A5/iHgvvPgKuYKgMGQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hf97kvjya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:18 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:16 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 3/7] libbpf: BPF programs manual loading and attaching
Date: Thu, 22 Oct 2026 18:32:08 -0400
Message-ID: <20261022223212.1217849-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
References: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH015.crowdstrike.sys (10.100.11.67) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: ggTGxyQlLcaR4DBbJhkJoPj8J1Tn_21A
X-Authority-Analysis: v=2.4 cv=Q7dHcI2a c=1 sm=1 tr=0 ts=6ada8ef2 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=pl6vuDidAAAA:8
 a=DXphi_zH5SVEUbXBll8A:9
X-Proofpoint-ORIG-GUID: ggTGxyQlLcaR4DBbJhkJoPj8J1Tn_21A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX4G++1NjbUkdp
 H1NKLgsl1+a7Wp0bkG7Gh/S+LAqYU/zyRW0Se6mXVX16l8k0shGOleJmB+0AvUI3u1hqYJBwK5x
 n5WzVfeCLnjvabF3PK/IS845IYEWni2UifDzmdz0l0qQfffjQsVbaCy+dEPIzlpnDRKBizLUpgW
 bkRiBFdfCF/0Jzrv5QlmcyBK/+EuyXVT1zLc66Hm5IZYFbcwB3uBxvZW84IStezPOou0DrBHgYj
 PB5i08scx2zR2dDcvKkbjMMiuMCAuuuVjlw0cOlPDzEoToFQUwd85Aqo1N3oLGtd3ulD1CExkzL
 UpLu2Xi/KQFTNVcR1YG+TLxuaAgeGpZRvDUWFEMXAkdTWi3+jy6Bh5ip95YyzXrHzHqbMFsbeQM
 u7GDs0tF+jIEoRHsJ5XVNJ0BAFzcUilLnGlJDsx5+TgeLMPYFn4rx/mEt0PW02dBIKAZSvhGP6P
 SNx1282wM/jGXdD52jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX+4lODoIGKG7r
 byeJNWg0rr1+Hd849duY/mZaFli0IXLOjzElRwABSUs3yvJSY4U4S6s0PNX2/WW1nSZ4/cyI7sw
 5pNAnXs7q8wXeiVMc3re2Qj/qMMlgkBxtPmoGSfmfCTGKEBgzczK
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220089

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

Two program log related APIs were relaxed to work post OBJ_LOADED
state to fix regression where verifier logs were lost in case of
bpf_object__prepare failure. It makes sense to relax those for MANUAL
programs as they can load post OBJ_LOADED state so the log buff still
can be set at this point. Also add proper documentation to the setters.

Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in several
places code related to struct_ops logic was altered to take into account
struct_ops program with MANUAL strategy set. The general idea is to reject
this type of programs for manual loading since those programs cannot
load/unload independently of each other per a given struct ops.
Hence, SEC("!...") style declaration is rejected for them while
bpf_program__set_load_strategy() does accept them to allow certain
flexibility in the API future usage.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 205 ++++++++++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.h   |  56 +++++++++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 240 insertions(+), 22 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e4cdbc2f467d..1d5d59b95c4e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -758,6 +758,7 @@ struct bpf_object {
 
 	bool has_subcalls;
 	bool has_rodata;
+	bool has_manual_progs;
 
 	struct bpf_gen *gen_loader;
 
@@ -870,7 +871,7 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn);
 static Elf64_Sym *elf_sym_by_idx(const struct bpf_object *obj, size_t idx);
 static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx);
 
-void bpf_program__unload(struct bpf_program *prog)
+static void bpf_program_unload_full(struct bpf_program *prog)
 {
 	if (!prog)
 		return;
@@ -882,12 +883,30 @@ void bpf_program__unload(struct bpf_program *prog)
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
@@ -1228,6 +1247,14 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
 			continue;
 
+		/*
+		 * If the user set the load strategy to MANUAL, don't guess it
+		 * from map autocreate: a MANUAL program is loaded explicitly
+		 * with bpf_program__load(), which rejects any other strategy.
+		 */
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			continue;
+
 		for (j = 0; j < obj->nr_maps; ++j) {
 			const struct btf_type *type;
 
@@ -5874,6 +5901,20 @@ static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
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
@@ -9330,6 +9371,8 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
+			obj->has_manual_progs = true;
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9356,6 +9399,18 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
 
+		/*
+		 * struct_ops programs declared SEC("!...") are rejected here
+		 * at declarative parse time for manual loading since those programs cannot
+		 * load/unload independently of each other per a given struct ops.
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
@@ -9556,7 +9611,7 @@ static int bpf_object_unload(struct bpf_object *obj)
 	}
 
 	for (i = 0; i < obj->nr_programs; i++)
-		bpf_program__unload(&obj->programs[i]);
+		bpf_program_unload_full(&obj->programs[i]);
 
 	return 0;
 }
@@ -9947,7 +10002,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 	return 0;
 }
 
-static void bpf_map_prepare_vdata(const struct bpf_map *map)
+static int bpf_map_prepare_vdata(const struct bpf_map *map)
 {
 	const struct btf_type *type;
 	struct bpf_struct_ops *st_ops;
@@ -9963,16 +10018,32 @@ static void bpf_map_prepare_vdata(const struct bpf_map *map)
 		if (!prog)
 			continue;
 
+		/*
+		 * Manual struct_ops programs don't get along well with manual
+		 * loading: all the progs belonging to the same struct_ops must
+		 * load and unload together, which is the opposite of the manual
+		 * load concept.
+		 * Still, we allow manual progs here as long as they were loaded
+		 * before this step because this way they do work.
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
@@ -9983,7 +10054,9 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 		if (!map->autocreate)
 			continue;
 
-		bpf_map_prepare_vdata(map);
+		err = bpf_map_prepare_vdata(map);
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -9999,10 +10072,19 @@ static void bpf_object_unpin(struct bpf_object *obj)
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
@@ -10019,15 +10101,42 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 	obj->btf_vmlinux = NULL;
 }
 
-static void bpf_object_post_load_cleanup(struct bpf_object *obj)
+static void bpf_object_post_load_cleanup(struct bpf_object *obj, bool force)
 {
-	/* clean up fd_array, and the slots handed out with it */
-	zfree(&obj->fd_array);
-	obj->fd_array_cap = 0;
-	obj->fd_array_used = 0;
+	/*
+	 * The fd array, and the slots handed out with it, are needed for
+	 * manually loaded programs, so defer freeing them in that case
+	 * to the end of the object lifetime.
+	 */
+	if (force || !obj->has_manual_progs) {
+		zfree(&obj->fd_array);
+		obj->fd_array_cap = 0;
+		obj->fd_array_used = 0;
+	}
 
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
@@ -10039,7 +10148,8 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 		return -EINVAL;
 	}
 
-	err = bpf_object_prepare_token(obj);
+	err = bpf_object_check_gen_loader(obj);
+	err = err ? : bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
@@ -10122,7 +10232,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, false);
 	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
 	if (err) {
@@ -10590,7 +10700,7 @@ void bpf_object__close(struct bpf_object *obj)
 	 * bpf_object__load(), we need to clean up stuff that is normally
 	 * cleaned up at the end of loading step
 	 */
-	bpf_object_post_load_cleanup(obj);
+	bpf_object_post_load_cleanup(obj, true);
 
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
@@ -10599,7 +10709,6 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
-	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
@@ -10925,7 +11034,13 @@ __u32 bpf_program__log_level(const struct bpf_program *prog)
 
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
@@ -10944,7 +11059,8 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 		return libbpf_err(-EINVAL);
 	if (log_size > UINT_MAX)
 		return libbpf_err(-EINVAL);
-	if (prog->obj->state >= OBJ_LOADED)
+	if (prog->obj->state >= OBJ_LOADED &&
+	    prog->load_strategy != BPF_PROG_LOAD_STRATEGY_MANUAL)
 		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
@@ -13730,7 +13846,7 @@ static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *
 	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
 
 cleanup:
-	bpf_object_cleanup_btf(obj);
+	bpf_object_cleanup_btf(obj, false);
 	return err;
 }
 
@@ -16287,10 +16403,26 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 
 int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_strategy strategy)
 {
-	if (prog->obj->state >= OBJ_PREPARED)
+	struct bpf_object *obj = prog->obj;
+
+	if (obj->state >= OBJ_PREPARED)
 		return libbpf_err(-EINVAL);
 
-	prog->load_strategy = strategy;
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
+
 	return 0;
 }
 
@@ -16298,3 +16430,32 @@ enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program
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
index a91e43cbba20..dd5380bc355e 100644
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
@@ -1055,8 +1066,39 @@ LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
  * interactions.
  */
 LIBBPF_API __u32 bpf_program__log_level(const struct bpf_program *prog);
+
+/**
+ * @brief **bpf_program__set_log_level()** sets the verifier log level used
+ * when the BPF program is loaded.
+ *
+ * Fails with -EBUSY once the enclosing bpf_object is loaded, unless the
+ * program's load strategy is BPF_PROG_LOAD_STRATEGY_MANUAL, as such a program
+ * can still be loaded afterwards with bpf_program__load().
+ *
+ * @param prog BPF program to set the log level for
+ * @param log_level verifier log level, 0 requests no logging on the first
+ * load attempt
+ * @return 0, on success; negative error code, otherwise
+ */
 LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level);
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
+
+/**
+ * @brief **bpf_program__set_log_buf()** sets the buffer the verifier log of
+ * the BPF program is written to when it is loaded.
+ *
+ * Fails with -EBUSY once the enclosing bpf_object is loaded, unless the
+ * program's load strategy is BPF_PROG_LOAD_STRATEGY_MANUAL, as such a program
+ * can still be loaded afterwards with bpf_program__load().
+ *
+ * @param prog BPF program to set the log buffer for.
+ * @param log_buf buffer for the verifier log.
+ * @param log_size size of @log_buf in bytes.
+ * @return 0, on success; -EINVAL if @log_buf and @log_size are inconsistent or
+ * @log_size exceeds UINT_MAX; -EBUSY as described above
+ */
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
 LIBBPF_API struct bpf_func_info *bpf_program__func_info(const struct bpf_program *prog);
@@ -2122,10 +2164,14 @@ LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_pro
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
@@ -2150,6 +2196,16 @@ LIBBPF_API int bpf_program__set_load_strategy(struct bpf_program *prog,
  */
 LIBBPF_API enum bpf_prog_load_strategy bpf_program__load_strategy(const struct bpf_program *prog);
 
+/**
+ * @brief **bpf_program__load()** loads a MANUAL BPF program. The enclosing
+ * bpf_object must already be prepared.
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
index c06fc6b68efd..a45666f546fa 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -476,6 +476,7 @@ LIBBPF_1.8.0 {
 
 LIBBPF_1.9.0 {
 	global:
+		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;
 } LIBBPF_1.8.0;
-- 
2.34.1

