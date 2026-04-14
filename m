Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0C3E715F
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173109; cv=none; b=rF17iAK0YmH94vzGXR5+9PgWuLqqXJYiTX6wKLtZF440259FsFtiG9+t4aZ/g95nxQRfiKnVv3bmvfkj322gxlzFuLZc8AAq3FzlddO45eC0z/s6y7UWPLZgFsAYhwynRohvYne9OV1Tmuc4uuGOXtxRftttGaZRGLh7pc/A3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173109; c=relaxed/simple;
	bh=sFZ29FoVS24JlBs6RMnz/GbcBzZht+9TK5z9WeNw2i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY+Dl0BIcXr6fGS09D9s3V0eS81B4ZiR1aOwr3taZ+jBF1ZQ1XcpwDfrJ9EtBYwppkYA0b3gmkLfS0TUS77wwQwdJ4w1oV3BSWVx/AKo2Wlcuc5SMtQiOUTOOUxckDzN1jRepwEN1pLPAo2QzfmnpLBclJuMiczTsFbxM0LMXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZXAaA+gT; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZXAaA+gT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKLk3gJsh38gzHXJLflgR1l3duYhanEOHG++zDKMSpk=;
	b=ZXAaA+gT9w1bJ8DMZD0GGq4T0Wgg3GtqisnWSIAcu4sBrURBIJJMFv4ZR6IY7MWZ2FNLWw
	b7G8FSIrwMq3VVksInGp2OErVDnvts7k8xSehT6Kgax0RPXj3uGlmj6CL3+whtWAlnBvOR
	8t0gZLL29BUMn8NqGYBWkh3rGj+ctmU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 4/8] libbpf: Add support for global percpu data
Date: Tue, 14 Apr 2026 21:24:16 +0800
Message-ID: <20260414132421.63409-5-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add support for global percpu data in libbpf by adding a new ".percpu"
section, similar to ".data". It enables efficient handling of percpu
global variables in bpf programs.

When generating loader for lightweight skeleton, update the percpu_array
map used for global percpu data using BPF_F_ALL_CPUS, in order to update
values across all CPUs using one value slot.

Unlike global data, the mmaped data for global percpu data will be marked
as read-only after populating the percpu_array map. Thereafter, users can
read those initialized percpu data after loading prog. If they want to
update the percpu data after loading prog, they have to update the
percpu_array map using key=0 instead.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf_gen_internal.h |  3 +-
 tools/lib/bpf/gen_loader.c       |  3 +-
 tools/lib/bpf/libbpf.c           | 67 ++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 49af4260b8e6..5ea8383805d3 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -66,7 +66,8 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			enum bpf_prog_type prog_type, const char *prog_name,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
 			struct bpf_prog_load_opts *load_attr, int prog_idx);
-void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size);
+void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size,
+			      __u64 flags);
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cd5c2543f54d..3374f2e01ef2 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1158,7 +1158,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 }
 
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
-			      __u32 value_size)
+			      __u32 value_size, __u64 flags)
 {
 	int attr_size = offsetofend(union bpf_attr, flags);
 	int map_update_attr, value, key;
@@ -1166,6 +1166,7 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	int zero = 0;
 
 	memset(&attr, 0, attr_size);
+	attr.flags = flags;
 
 	value = add_data(gen, pvalue, value_size);
 	key = add_data(gen, &zero, sizeof(zero));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..576b71a28058 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -536,6 +536,7 @@ struct bpf_struct_ops {
 };
 
 #define DATA_SEC ".data"
+#define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
@@ -550,6 +551,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_PERCPU,
 };
 
 struct bpf_map_def {
@@ -661,6 +663,7 @@ enum sec_type {
 	SEC_DATA,
 	SEC_RODATA,
 	SEC_ST_OPS,
+	SEC_PERCPU,
 };
 
 struct elf_sec_desc {
@@ -1834,6 +1837,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	switch (map->def.type) {
 	case BPF_MAP_TYPE_ARRAY:
 		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return map->def.value_size;
 	case BPF_MAP_TYPE_ARENA:
 		return page_sz * map->def.max_entries;
 	default:
@@ -1933,7 +1938,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 	struct btf_var_secinfo *vsi;
 	int i, n;
 
-	if (!map->btf_value_type_id)
+	if (!map->btf_value_type_id || map->libbpf_type == LIBBPF_MAP_PERCPU)
 		return false;
 
 	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
@@ -1957,6 +1962,7 @@ static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	bool is_percpu = type == LIBBPF_MAP_PERCPU;
 	struct bpf_map_def *def;
 	struct bpf_map *map;
 	size_t mmap_sz;
@@ -1978,7 +1984,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
+	def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
 	def->key_size = sizeof(int);
 	def->value_size = data_sz;
 	def->max_entries = 1;
@@ -1991,8 +1997,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (map_is_mmapable(obj, map))
 		def->map_flags |= BPF_F_MMAPABLE;
 
-	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
-		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
+	pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
+		 map->name, is_percpu ? "percpu " : "", map->sec_idx,
+		 map->sec_offset, def->map_flags);
 
 	mmap_sz = bpf_map_mmap_sz(map);
 	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
@@ -2052,6 +2059,13 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 							    NULL,
 							    sec_desc->data->d_size);
 			break;
+		case SEC_PERCPU:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_PERCPU,
+							    sec_name, sec_idx,
+							    sec_desc->data->d_buf,
+							    sec_desc->data->d_size);
+			break;
 		default:
 			/* skip */
 			break;
@@ -4011,6 +4025,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
+			} else if (strcmp(name, PERCPU_SEC) == 0 ||
+				   str_has_pfx(name, PERCPU_SEC ".")) {
+				sec_desc->sec_type = SEC_PERCPU;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
 				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
 				   strcmp(name, "?" STRUCT_OPS_SEC) == 0 ||
@@ -4539,6 +4558,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_PERCPU:
 		return true;
 	default:
 		return false;
@@ -4564,6 +4584,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_DATA;
 	case SEC_RODATA:
 		return LIBBPF_MAP_RODATA;
+	case SEC_PERCPU:
+		return LIBBPF_MAP_PERCPU;
 	default:
 		return LIBBPF_MAP_UNSPEC;
 	}
@@ -4939,7 +4961,7 @@ static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 
 	/*
 	 * LLVM annotates global data differently in BTF, that is,
-	 * only as '.data', '.bss' or '.rodata'.
+	 * only as '.data', '.bss', '.percpu' or '.rodata'.
 	 */
 	if (!bpf_map__is_internal(map))
 		return -ENOENT;
@@ -5292,18 +5314,30 @@ static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
+	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
+	__u64 update_flags = 0;
 	int err, zero = 0;
 	size_t mmap_sz;
 
+	if (is_percpu) {
+		if (!obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_DATA)) {
+			pr_warn("map '%s': kernel does not support percpu data.\n",
+				bpf_map__name(map));
+			return -EOPNOTSUPP;
+		}
+
+		update_flags = BPF_F_ALL_CPUS;
+	}
+
 	if (obj->gen_loader) {
 		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
-					 map->mmaped, map->def.value_size);
+					 map->mmaped, map->def.value_size, update_flags);
 		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
 
-	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
+	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, update_flags);
 	if (err) {
 		err = -errno;
 		pr_warn("map '%s': failed to set initial contents: %s\n",
@@ -5348,6 +5382,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			return err;
 		}
 		map->mmaped = mmaped;
+	} else if (is_percpu) {
+		if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
+			err = -errno;
+			pr_warn("map '%s': failed to mprotect() contents: %s\n",
+				bpf_map__name(map), errstr(err));
+			return err;
+		}
 	} else if (map->mmaped) {
 		munmap(map->mmaped, mmap_sz);
 		map->mmaped = NULL;
@@ -10705,16 +10746,18 @@ int bpf_map__fd(const struct bpf_map *map)
 
 static bool map_uses_real_name(const struct bpf_map *map)
 {
-	/* Since libbpf started to support custom .data.* and .rodata.* maps,
-	 * their user-visible name differs from kernel-visible name. Users see
-	 * such map's corresponding ELF section name as a map name.
-	 * This check distinguishes .data/.rodata from .data.* and .rodata.*
-	 * maps to know which name has to be returned to the user.
+	/* Since libbpf started to support custom .data.*, .rodata.* and
+	 * .percpu.* maps, their user-visible name differs from
+	 * kernel-visible name. Users see such map's corresponding ELF section
+	 * name as a map name. This check distinguishes plain .data/.rodata/.percpu
+	 * from .data.*, .rodata.* and .percpu.* to choose which name to return.
 	 */
 	if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
 		return true;
 	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
 		return true;
+	if (map->libbpf_type == LIBBPF_MAP_PERCPU && strcmp(map->real_name, PERCPU_SEC) != 0)
+		return true;
 	return false;
 }
 
-- 
2.53.0

