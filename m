Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5543B3DD
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957257; cv=none; b=B5nLsX65DGGJlG27OnLaoiDneYpvVdCtLFPGsbDlLRtd4wiD+jmicmRUCNrsmVCBoGoC9QYg6+kH6LzcGL5/Z8if6pGA5V9811+hWQzweXR/BOAfjcav89PKjty40GpQhNVVAaHfN6z4y88FvA+oQpR/vo9NbVjp25dIy3WRZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957257; c=relaxed/simple;
	bh=ey2FkOYV0HOt9y84j/xH2sahyftxCCkR/7uwsK+DwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npiPNzxWRwcSss+ru7rvwaFrbalSmAPVtPTuEBRbulV2PUGL0CfCt2jGOprbX38YrQOoUxD4RHWRluAwU9IweoLi43oKtGUGmydEQMSY3705hTGLHTPNKEZfe2geUrLQ8CYvIFyAVHYwyVDhX4BW5rdqJdkxRawXQEm+znopk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JJxpda/D; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JJxpda/D"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783957253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlMlp2TY6xC+mBkDyBNDRqqCEjP22tcpGGOvHehlGgg=;
	b=JJxpda/DY0aLKpyvNKoYWCZuMhVopfZtmY2dxqQDiJYIIIdJoWB4DL8IZj1xjWbwjOLvWV
	DUnEfCrMpR4H42qtaxW8UffzpIJMuHakGmw3ZNAYbZTsfqRbofeUxupIIDbcbSo0XsmsgJ
	bgdkc0MoV5Anub2XIUOEBR1qyfmfAOY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v9 4/9] libbpf: Add support for global percpu data
Date: Mon, 13 Jul 2026 23:40:19 +0800
Message-ID: <20260713154024.30851-5-leon.hwang@linux.dev>
In-Reply-To: <20260713154024.30851-1-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
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
 tools/lib/bpf/libbpf.c           | 72 +++++++++++++++++++++++++++-----
 3 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 042569187752..6c5ad6c55e8a 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -65,7 +65,8 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
index 6e3dd5242761..af3a04f161ac 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1128,7 +1128,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 }
 
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
-			      __u32 value_size)
+			      __u32 value_size, __u64 flags)
 {
 	int attr_size = offsetofend(union bpf_attr, flags);
 	int map_update_attr, value, key;
@@ -1136,6 +1136,7 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	int zero = 0;
 
 	memset(&attr, 0, attr_size);
+	attr.flags = tgt_endian(flags);
 
 	value = add_data(gen, pvalue, value_size);
 	key = add_data(gen, &zero, sizeof(zero));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f88b7c8de304..e4104d18521b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -541,6 +541,7 @@ struct bpf_struct_ops {
 };
 
 #define DATA_SEC ".data"
+#define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
@@ -555,6 +556,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_PERCPU,
 };
 
 struct bpf_map_def {
@@ -666,6 +668,7 @@ enum sec_type {
 	SEC_DATA,
 	SEC_RODATA,
 	SEC_ST_OPS,
+	SEC_PERCPU,
 };
 
 struct elf_sec_desc {
@@ -1839,6 +1842,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 	switch (map->def.type) {
 	case BPF_MAP_TYPE_ARRAY:
 		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return map->def.value_size;
 	case BPF_MAP_TYPE_ARENA:
 		return page_sz * map->def.max_entries;
 	default:
@@ -1866,7 +1871,8 @@ static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz
 	return 0;
 }
 
-static char *internal_map_name(struct bpf_object *obj, const char *real_name)
+static char *internal_map_name(struct bpf_object *obj, const char *real_name,
+			       enum libbpf_map_type type)
 {
 	char map_name[BPF_OBJ_NAME_LEN], *p;
 	int pfx_len, sfx_len = max((size_t)7, strlen(real_name));
@@ -1907,8 +1913,11 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 	if (sfx_len >= BPF_OBJ_NAME_LEN)
 		sfx_len = BPF_OBJ_NAME_LEN - 1;
 
-	/* if there are two or more dots in map name, it's a custom dot map */
-	if (strchr(real_name + 1, '.') != NULL)
+	/*
+	 * Don't prefix the bpf_object name if this is a custom dot map
+	 * (containing two or more dots) or a percpu data map.
+	 */
+	if (strchr(real_name + 1, '.') != NULL || type == LIBBPF_MAP_PERCPU)
 		pfx_len = 0;
 	else
 		pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, strlen(obj->name));
@@ -1938,7 +1947,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 	struct btf_var_secinfo *vsi;
 	int i, n;
 
-	if (!map->btf_value_type_id)
+	if (!map->btf_value_type_id || map->libbpf_type == LIBBPF_MAP_PERCPU)
 		return false;
 
 	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
@@ -1962,6 +1971,7 @@ static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	bool is_percpu = type == LIBBPF_MAP_PERCPU;
 	struct bpf_map_def *def;
 	struct bpf_map *map;
 	size_t mmap_sz;
@@ -1975,7 +1985,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	map->sec_idx = sec_idx;
 	map->sec_offset = 0;
 	map->real_name = strdup(real_name);
-	map->name = internal_map_name(obj, real_name);
+	map->name = internal_map_name(obj, real_name, type);
 	if (!map->real_name || !map->name) {
 		zfree(&map->real_name);
 		zfree(&map->name);
@@ -1983,7 +1993,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
+	def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
 	def->key_size = sizeof(int);
 	def->value_size = data_sz;
 	def->max_entries = 1;
@@ -1996,8 +2006,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (map_is_mmapable(obj, map))
 		def->map_flags |= BPF_F_MMAPABLE;
 
-	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
-		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
+	pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
+		 map->name, is_percpu ? "percpu " : "", map->sec_idx,
+		 map->sec_offset, def->map_flags);
 
 	mmap_sz = bpf_map_mmap_sz(map);
 	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
@@ -2057,6 +2068,13 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
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
@@ -4016,6 +4034,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4544,6 +4567,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_PERCPU:
 		return true;
 	default:
 		return false;
@@ -4569,6 +4593,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_DATA;
 	case SEC_RODATA:
 		return LIBBPF_MAP_RODATA;
+	case SEC_PERCPU:
+		return LIBBPF_MAP_PERCPU;
 	default:
 		return LIBBPF_MAP_UNSPEC;
 	}
@@ -4944,7 +4970,7 @@ static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 
 	/*
 	 * LLVM annotates global data differently in BTF, that is,
-	 * only as '.data', '.bss' or '.rodata'.
+	 * only as '.data', '.bss', '.percpu' or '.rodata'.
 	 */
 	if (!bpf_map__is_internal(map))
 		return -ENOENT;
@@ -5293,18 +5319,30 @@ static int
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
@@ -5349,6 +5387,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
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
@@ -10807,11 +10852,16 @@ static bool map_uses_real_name(const struct bpf_map *map)
 	 * such map's corresponding ELF section name as a map name.
 	 * This check distinguishes .data/.rodata from .data.* and .rodata.*
 	 * maps to know which name has to be returned to the user.
+	 * Map name of the custom .percpu.* maps might be truncated to
+	 * BPF_OBJ_NAME_LEN-1 chars in internal_map_name(). Hence, percpu data
+	 * maps must use real name for their user-visible name.
 	 */
 	if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
 		return true;
 	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
 		return true;
+	if (map->libbpf_type == LIBBPF_MAP_PERCPU)
+		return true;
 	return false;
 }
 
-- 
2.55.0

