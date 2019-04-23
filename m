Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B812C10F03
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437B2218D3
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 22:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfDWWqP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:46:15 -0400
Received: from www62.your-server.de ([213.133.104.62]:51120 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWqL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 18:46:11 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJ4Az-0003mY-8J; Wed, 24 Apr 2019 00:46:09 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 1/2] bpf, libbpf: handle old kernels more graceful wrt global data sections
Date:   Wed, 24 Apr 2019 00:45:56 +0200
Message-Id: <8d1fd7e29c51e37200c1b13e24922123b978e633.1556059361.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
References: <cover.1556059361.git.daniel@iogearbox.net>
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
References: <cover.1556059361.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25428/Tue Apr 23 10:00:55 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii reported a corner case where e.g. global static data is present
in the BPF ELF file in form of .data/.bss/.rodata section, but without
any relocations to it. Such programs could be loaded before commit
d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections"),
whereas afterwards if kernel lacks support then loading would fail.

Add a probing mechanism which skips setting up libbpf internal maps
in case of missing kernel support. In presence of relocation entries,
we abort the load attempt.

Fixes: d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
Reported-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/libbpf.c | 99 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d817bf2..85315de 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -126,6 +126,8 @@ static inline __u64 ptr_to_u64(const void *ptr)
 struct bpf_capabilities {
 	/* v4.14: kernel support for program & map names. */
 	__u32 name:1;
+	/* v5.2: kernel support for global data sections. */
+	__u32 global_data:1;
 };
 
 /*
@@ -854,12 +856,15 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 	 *
 	 * TODO: Detect array of map and report error.
 	 */
-	if (obj->efile.data_shndx >= 0)
-		nr_maps_glob++;
-	if (obj->efile.rodata_shndx >= 0)
-		nr_maps_glob++;
-	if (obj->efile.bss_shndx >= 0)
-		nr_maps_glob++;
+	if (obj->caps.global_data) {
+		if (obj->efile.data_shndx >= 0)
+			nr_maps_glob++;
+		if (obj->efile.rodata_shndx >= 0)
+			nr_maps_glob++;
+		if (obj->efile.bss_shndx >= 0)
+			nr_maps_glob++;
+	}
+
 	for (i = 0; data && i < nr_syms; i++) {
 		GElf_Sym sym;
 
@@ -971,6 +976,9 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 		map_idx++;
 	}
 
+	if (!obj->caps.global_data)
+		goto finalize;
+
 	/*
 	 * Populate rest of obj->maps with libbpf internal maps.
 	 */
@@ -988,6 +996,7 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 		ret = bpf_object__init_internal_map(obj, &obj->maps[map_idx++],
 						    LIBBPF_MAP_BSS,
 						    obj->efile.bss, NULL);
+finalize:
 	if (!ret)
 		qsort(obj->maps, obj->nr_maps, sizeof(obj->maps[0]),
 		      compare_bpf_map);
@@ -1333,11 +1342,17 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
 		if (bpf_object__shndx_is_maps(obj, shdr_idx) ||
 		    bpf_object__shndx_is_data(obj, shdr_idx)) {
 			type = bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
-			if (type != LIBBPF_MAP_UNSPEC &&
-			    GELF_ST_BIND(sym.st_info) == STB_GLOBAL) {
-				pr_warning("bpf: relocation: not yet supported relo for non-static global \'%s\' variable found in insns[%d].code 0x%x\n",
-					   name, insn_idx, insns[insn_idx].code);
-				return -LIBBPF_ERRNO__RELOC;
+			if (type != LIBBPF_MAP_UNSPEC) {
+				if (GELF_ST_BIND(sym.st_info) == STB_GLOBAL) {
+					pr_warning("bpf: relocation: not yet supported relo for non-static global \'%s\' variable found in insns[%d].code 0x%x\n",
+						   name, insn_idx, insns[insn_idx].code);
+					return -LIBBPF_ERRNO__RELOC;
+				}
+				if (!obj->caps.global_data) {
+					pr_warning("bpf: relocation: kernel does not support global \'%s\' variable access in insns[%d]\n",
+						   name, insn_idx);
+					return -LIBBPF_ERRNO__RELOC;
+				}
 			}
 
 			for (map_idx = 0; map_idx < nr_maps; map_idx++) {
@@ -1496,9 +1511,67 @@ bpf_object__probe_name(struct bpf_object *obj)
 }
 
 static int
+bpf_object__probe_global_data(struct bpf_object *obj)
+{
+	struct bpf_load_program_attr prg_attr;
+	struct bpf_create_map_attr map_attr;
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, 16),
+		BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 42),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret, map;
+
+	memset(&map_attr, 0, sizeof(map_attr));
+	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
+	map_attr.key_size = sizeof(int);
+	map_attr.value_size = 32;
+	map_attr.max_entries = 1;
+
+	map = bpf_create_map_xattr(&map_attr);
+	if (map < 0) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warning("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			   __func__, cp, errno);
+		return -errno;
+	}
+
+	insns[0].imm = map;
+
+	memset(&prg_attr, 0, sizeof(prg_attr));
+	prg_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	prg_attr.insns = insns;
+	prg_attr.insns_cnt = ARRAY_SIZE(insns);
+	prg_attr.license = "GPL";
+
+	ret = bpf_load_program_xattr(&prg_attr, NULL, 0);
+	if (ret >= 0) {
+		obj->caps.global_data = 1;
+		close(ret);
+	}
+
+	close(map);
+	return 0;
+}
+
+static int
 bpf_object__probe_caps(struct bpf_object *obj)
 {
-	return bpf_object__probe_name(obj);
+	int (*probe_fn[])(struct bpf_object *obj) = {
+		bpf_object__probe_name,
+		bpf_object__probe_global_data,
+	};
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(probe_fn); i++) {
+		ret = probe_fn[i](obj);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int
@@ -2100,6 +2173,7 @@ __bpf_object__open(const char *path, void *obj_buf, size_t obj_buf_sz,
 
 	CHECK_ERR(bpf_object__elf_init(obj), err, out);
 	CHECK_ERR(bpf_object__check_endianness(obj), err, out);
+	CHECK_ERR(bpf_object__probe_caps(obj), err, out);
 	CHECK_ERR(bpf_object__elf_collect(obj, flags), err, out);
 	CHECK_ERR(bpf_object__collect_reloc(obj), err, out);
 	CHECK_ERR(bpf_object__validate(obj, needs_kver), err, out);
@@ -2193,7 +2267,6 @@ int bpf_object__load(struct bpf_object *obj)
 
 	obj->loaded = true;
 
-	CHECK_ERR(bpf_object__probe_caps(obj), err, out);
 	CHECK_ERR(bpf_object__create_maps(obj), err, out);
 	CHECK_ERR(bpf_object__relocate(obj), err, out);
 	CHECK_ERR(bpf_object__load_progs(obj), err, out);
-- 
2.9.5

