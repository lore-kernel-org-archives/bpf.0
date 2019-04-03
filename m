Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D5C10F0C
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E1D2133D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDCSXe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:23:34 -0400
Received: from www62.your-server.de ([213.133.104.62]:55450 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCSXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:23:34 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBkXm-0006E4-Qw; Wed, 03 Apr 2019 20:23:27 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, joe@wand.net.nz, yhs@fb.com,
        andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 11/15] bpf, libbpf: add support for BTF Var and DataSec
Date:   Wed,  3 Apr 2019 20:23:02 +0200
Message-Id: <3e11c35828b37947428b07056581bc0cb3b3c66e.1554314902.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds libbpf support for BTF Var and DataSec kinds. Main point
here is that libbpf needs to do some preparatory work before the
whole BTF object can be loaded into the kernel, that is, fixing up
of DataSec size taken from the ELF section size and non-static
variable offset which needs to be taken from the ELF's string section.
Latest upstream LLVM didn't fix these up since at time of BTF emission
this information wasn't available, hence loader does take care of it.
Note, deduplication handling has not been in the scope of this work
and needs to be addressed in a future commit.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/btf.c      |  97 +++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h      |   3 +
 tools/lib/bpf/libbpf.c   | 150 +++++++++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h   |   4 ++
 tools/lib/bpf/libbpf.map |   1 +
 5 files changed, 235 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 87e3020..0f9079b 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -24,6 +24,8 @@
 		((k) == BTF_KIND_CONST) || \
 		((k) == BTF_KIND_RESTRICT))
 
+#define IS_VAR(k) ((k) == BTF_KIND_VAR)
+
 static struct btf_type btf_void;
 
 struct btf {
@@ -212,6 +214,10 @@ static int btf_type_size(struct btf_type *t)
 		return base_size + vlen * sizeof(struct btf_member);
 	case BTF_KIND_FUNC_PROTO:
 		return base_size + vlen * sizeof(struct btf_param);
+	case BTF_KIND_VAR:
+		return base_size + sizeof(struct btf_var);
+	case BTF_KIND_DATASEC:
+		return base_size + vlen * sizeof(struct btf_var_secinfo);
 	default:
 		pr_debug("Unsupported BTF_KIND:%u\n", BTF_INFO_KIND(t->info));
 		return -EINVAL;
@@ -283,6 +289,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
 		case BTF_KIND_ENUM:
+		case BTF_KIND_DATASEC:
 			size = t->size;
 			goto done;
 		case BTF_KIND_PTR:
@@ -292,6 +299,7 @@ __s64 btf__resolve_size(const struct btf *btf, __u32 type_id)
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
+		case BTF_KIND_VAR:
 			type_id = t->type;
 			break;
 		case BTF_KIND_ARRAY:
@@ -326,7 +334,8 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	t = btf__type_by_id(btf, type_id);
 	while (depth < MAX_RESOLVE_DEPTH &&
 	       !btf_type_is_void_or_null(t) &&
-	       IS_MODIFIER(BTF_INFO_KIND(t->info))) {
+	       (IS_MODIFIER(BTF_INFO_KIND(t->info)) ||
+		IS_VAR(BTF_INFO_KIND(t->info)))) {
 		type_id = t->type;
 		t = btf__type_by_id(btf, type_id);
 		depth++;
@@ -408,6 +417,92 @@ struct btf *btf__new(__u8 *data, __u32 size)
 	return btf;
 }
 
+static int compare_vsi_off(const void *_a, const void *_b)
+{
+	const struct btf_var_secinfo *a = _a;
+	const struct btf_var_secinfo *b = _b;
+
+	return a->offset - b->offset;
+}
+
+static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
+			     struct btf_type *t)
+{
+	__u32 size = 0, off = 0, i, vars = BTF_INFO_VLEN(t->info);
+	const char *name = btf__name_by_offset(btf, t->name_off);
+	const struct btf_type *t_var;
+	struct btf_var_secinfo *vsi;
+	struct btf_var *var;
+	int ret;
+
+	if (!name) {
+		pr_debug("No name found in string section for DATASEC kind.\n");
+		return -ENOENT;
+	}
+
+	ret = bpf_object__section_size(obj, name, &size);
+	if (ret || !size || (t->size && t->size != size)) {
+		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
+		return -ENOENT;
+	}
+
+	t->size = size;
+
+	for (i = 0, vsi = (struct btf_var_secinfo *)(t + 1);
+	     i < vars; i++, vsi++) {
+		t_var = btf__type_by_id(btf, vsi->type);
+		var = (struct btf_var *)(t_var + 1);
+
+		if (BTF_INFO_KIND(t_var->info) != BTF_KIND_VAR) {
+			pr_debug("Non-VAR type seen in section %s\n", name);
+			return -EINVAL;
+		}
+
+		if (var->linkage == BTF_VAR_STATIC)
+			continue;
+
+		name = btf__name_by_offset(btf, t_var->name_off);
+		if (!name) {
+			pr_debug("No name found in string section for VAR kind\n");
+			return -ENOENT;
+		}
+
+		ret = bpf_object__variable_offset(obj, name, &off);
+		if (ret) {
+			pr_debug("No offset found in symbol table for VAR %s\n", name);
+			return -ENOENT;
+		}
+
+		vsi->offset = off;
+	}
+
+	qsort(t + 1, vars, sizeof(*vsi), compare_vsi_off);
+	return 0;
+}
+
+int btf__finalize_data(struct bpf_object *obj, struct btf *btf)
+{
+	int err = 0;
+	__u32 i;
+
+	for (i = 1; i <= btf->nr_types; i++) {
+		struct btf_type *t = btf->types[i];
+
+		/* Loader needs to fix up some of the things compiler
+		 * couldn't get its hands on while emitting BTF. This
+		 * is section size and global variable offset. We use
+		 * the info from the ELF itself for this purpose.
+		 */
+		if (BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC) {
+			err = btf_fixup_datasec(obj, btf, t);
+			if (err)
+				break;
+		}
+	}
+
+	return err;
+}
+
 int btf__load(struct btf *btf)
 {
 	__u32 log_buf_size = BPF_LOG_BUF_SIZE;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 28a1e1e..c7b399e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -21,6 +21,8 @@ struct btf;
 struct btf_ext;
 struct btf_type;
 
+struct bpf_object;
+
 /*
  * The .BTF.ext ELF section layout defined as
  *   struct btf_ext_header
@@ -57,6 +59,7 @@ struct btf_ext_header {
 
 LIBBPF_API void btf__free(struct btf *btf);
 LIBBPF_API struct btf *btf__new(__u8 *data, __u32 size);
+LIBBPF_API int btf__finalize_data(struct bpf_object *obj, struct btf *btf);
 LIBBPF_API int btf__load(struct btf *btf);
 LIBBPF_API __s32 btf__find_by_name(const struct btf *btf,
 				   const char *type_name);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9721ba9..486bd1d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -663,6 +663,112 @@ static bool bpf_map_type__is_map_in_map(enum bpf_map_type type)
 	return false;
 }
 
+static int bpf_object_search_section_size(const struct bpf_object *obj,
+					  const char *name, size_t *d_size)
+{
+	const GElf_Ehdr *ep = &obj->efile.ehdr;
+	Elf *elf = obj->efile.elf;
+	Elf_Scn *scn = NULL;
+	int idx = 0;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		const char *sec_name;
+		Elf_Data *data;
+		GElf_Shdr sh;
+
+		idx++;
+		if (gelf_getshdr(scn, &sh) != &sh) {
+			pr_warning("failed to get section(%d) header from %s\n",
+				   idx, obj->path);
+			return -EIO;
+		}
+
+		sec_name = elf_strptr(elf, ep->e_shstrndx, sh.sh_name);
+		if (!sec_name) {
+			pr_warning("failed to get section(%d) name from %s\n",
+				   idx, obj->path);
+			return -EIO;
+		}
+
+		if (strcmp(name, sec_name))
+			continue;
+
+		data = elf_getdata(scn, 0);
+		if (!data) {
+			pr_warning("failed to get section(%d) data from %s(%s)\n",
+				   idx, name, obj->path);
+			return -EIO;
+		}
+
+		*d_size = data->d_size;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+int bpf_object__section_size(const struct bpf_object *obj, const char *name,
+			     __u32 *size)
+{
+	int ret = -ENOENT;
+	size_t d_size;
+
+	*size = 0;
+	if (!name) {
+		return -EINVAL;
+	} else if (!strcmp(name, ".data")) {
+		if (obj->efile.data)
+			*size = obj->efile.data->d_size;
+	} else if (!strcmp(name, ".bss")) {
+		if (obj->efile.bss)
+			*size = obj->efile.bss->d_size;
+	} else if (!strcmp(name, ".rodata")) {
+		if (obj->efile.rodata)
+			*size = obj->efile.rodata->d_size;
+	} else {
+		ret = bpf_object_search_section_size(obj, name, &d_size);
+		if (!ret)
+			*size = d_size;
+	}
+
+	return *size ? 0 : ret;
+}
+
+int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
+				__u32 *off)
+{
+	Elf_Data *symbols = obj->efile.symbols;
+	const char *sname;
+	size_t si;
+
+	if (!name || !off)
+		return -EINVAL;
+
+	for (si = 0; si < symbols->d_size / sizeof(GElf_Sym); si++) {
+		GElf_Sym sym;
+
+		if (!gelf_getsym(symbols, si, &sym))
+			continue;
+		if (GELF_ST_BIND(sym.st_info) != STB_GLOBAL ||
+		    GELF_ST_TYPE(sym.st_info) != STT_OBJECT)
+			continue;
+
+		sname = elf_strptr(obj->efile.elf, obj->efile.strtabidx,
+				   sym.st_name);
+		if (!sname) {
+			pr_warning("failed to get sym name string for var %s\n",
+				   name);
+			return -EIO;
+		}
+		if (strcmp(name, sname) == 0) {
+			*off = sym.st_value;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 static bool bpf_object__has_maps(const struct bpf_object *obj)
 {
 	return obj->efile.maps_shndx >= 0 ||
@@ -905,6 +1011,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 	Elf *elf = obj->efile.elf;
 	GElf_Ehdr *ep = &obj->efile.ehdr;
 	Elf_Data *btf_ext_data = NULL;
+	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	int idx = 0, err = 0;
 
@@ -948,32 +1055,18 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 			 (int)sh.sh_link, (unsigned long)sh.sh_flags,
 			 (int)sh.sh_type);
 
-		if (strcmp(name, "license") == 0)
+		if (strcmp(name, "license") == 0) {
 			err = bpf_object__init_license(obj,
 						       data->d_buf,
 						       data->d_size);
-		else if (strcmp(name, "version") == 0)
+		} else if (strcmp(name, "version") == 0) {
 			err = bpf_object__init_kversion(obj,
 							data->d_buf,
 							data->d_size);
-		else if (strcmp(name, "maps") == 0)
+		} else if (strcmp(name, "maps") == 0) {
 			obj->efile.maps_shndx = idx;
-		else if (strcmp(name, BTF_ELF_SEC) == 0) {
-			obj->btf = btf__new(data->d_buf, data->d_size);
-			if (IS_ERR(obj->btf)) {
-				pr_warning("Error loading ELF section %s: %ld. Ignored and continue.\n",
-					   BTF_ELF_SEC, PTR_ERR(obj->btf));
-				obj->btf = NULL;
-				continue;
-			}
-			err = btf__load(obj->btf);
-			if (err) {
-				pr_warning("Error loading %s into kernel: %d. Ignored and continue.\n",
-					   BTF_ELF_SEC, err);
-				btf__free(obj->btf);
-				obj->btf = NULL;
-				err = 0;
-			}
+		} else if (strcmp(name, BTF_ELF_SEC) == 0) {
+			btf_data = data;
 		} else if (strcmp(name, BTF_EXT_ELF_SEC) == 0) {
 			btf_ext_data = data;
 		} else if (sh.sh_type == SHT_SYMTAB) {
@@ -1048,6 +1141,25 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
 		pr_warning("Corrupted ELF file: index of strtab invalid\n");
 		return LIBBPF_ERRNO__FORMAT;
 	}
+	if (btf_data) {
+		obj->btf = btf__new(btf_data->d_buf, btf_data->d_size);
+		if (IS_ERR(obj->btf)) {
+			pr_warning("Error loading ELF section %s: %ld. Ignored and continue.\n",
+				   BTF_ELF_SEC, PTR_ERR(obj->btf));
+			obj->btf = NULL;
+		} else {
+			err = btf__finalize_data(obj, obj->btf);
+			if (!err)
+				err = btf__load(obj->btf);
+			if (err) {
+				pr_warning("Error finalizing and loading %s into kernel: %d. Ignored and continue.\n",
+					   BTF_ELF_SEC, err);
+				btf__free(obj->btf);
+				obj->btf = NULL;
+				err = 0;
+			}
+		}
+	}
 	if (btf_ext_data) {
 		if (!obj->btf) {
 			pr_debug("Ignore ELF section %s because its depending ELF section %s is not found.\n",
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e6aa3d3..d9344ae 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -75,6 +75,10 @@ struct bpf_object *__bpf_object__open_xattr(struct bpf_object_open_attr *attr,
 LIBBPF_API struct bpf_object *bpf_object__open_buffer(void *obj_buf,
 						      size_t obj_buf_sz,
 						      const char *name);
+int bpf_object__section_size(const struct bpf_object *obj, const char *name,
+			     __u32 *size);
+int bpf_object__variable_offset(const struct bpf_object *obj, const char *name,
+				__u32 *off);
 LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *path);
 LIBBPF_API int bpf_object__unpin_maps(struct bpf_object *obj,
 				      const char *path);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0dd9c19..967b70f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -162,4 +162,5 @@ LIBBPF_0.0.3 {
 	global:
 		bpf_map__is_internal;
 		bpf_map_lock;
+		btf__finalize_data;
 } LIBBPF_0.0.2;
-- 
2.9.5

