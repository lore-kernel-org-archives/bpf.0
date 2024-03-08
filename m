Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE912232B
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860135; cv=none; b=F/PZzc94tS4zishLk3LqiYRbFqupQ24Asd1FR7ZGNR/gI3QMhDSe+DEio44Ii8x8SkMpwhw1uGQtTR7wNMyjGqgw4GXt7KIgwojyI8dLw7dIdFPkEKWtvwcGBnxPwHzqdFjHZC5cu+0Evj1rSwCZZ25FVvBvxQqxjZLK7RlkUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860135; c=relaxed/simple;
	bh=myIqAR1BGiyuWpXXLwVDdiHFu8HxbOiLKLH6+gz41vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3hl9nKUMvXl/7ZEGfWzUvqkbiSgv5IX6K+b7zsCRGUwsAssTQmzWNd8zgVxFwzYZGh5lpXFkXzI5+A3qtH/RAuge7r0lYQrt7QDia6ATB8EwzDkXvpuRTMw0WsSC4bM5rk3FRCm5L1CIb/QPJx/JnBQKepwiGKU5v6qn43s/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilp1V272; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilp1V272"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2218b571776so457683fac.0
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860132; x=1710464932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7lXpHC57ayxXaTvpi197+QGAClRaCdsRNe+5p0Q2fQ=;
        b=ilp1V272OeMfcumLXeCT0o6ED0jNp8aAyb832LF3GariqqZ8xar2wfprrNVUmal9AW
         ryDA6M8c9HyTjU8s1H2WAQWj8mnVh1TVlBW48QOAeISb/W0nb20mn7uY+GUjRmMWZq6H
         qjSdN4YRARg+tr58TsbVCoZiXyml4wCF0epDbEHD6ERVj+aWt55ccsN/Y3mBN58rHmML
         BZmm9VNbXQh9voIyEDS3fPKpOfaG2rRzoR3VZiGS7S9L2cCVHe5N8LgVxuuDVIhCryNR
         cZqU+aDzIPEzEIXVlGiu39E7dbgpTYyiRHqdMf+SqbAenPIK+QiwcnF2OqmNrI8AluYp
         HZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860132; x=1710464932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7lXpHC57ayxXaTvpi197+QGAClRaCdsRNe+5p0Q2fQ=;
        b=DRPZ533oiNtoOCak85Zqs5e7rDL+IdGigQibOMo3EldrYWstCIP9R3CGiH3sxN0MeE
         /1BzrJ89x2UyOhONJvBJe4W4TFmHIVeUYxs46K7VlmTptfgWPlI86a0HsiaHEhNRrfcY
         OXVCV3uqfUEtmB80vNGJDnJQP4Sz3CGRuaHR0gRDYUnC+a2fYXtuK5Gct49SavuHVbcZ
         xZMQp17U2goJMQCmmfBf0IyMq4zGXLodcS5JclJN2ue9wwWVmfFCrVoHsfP+j9CrWDJI
         cU3Tz+TjbfBIUqNRrYBDm0SnK2uuwgQLp2noaqtfQObxvOOTmdO6WK2Cz2sTMv3kkqA5
         PXTA==
X-Gm-Message-State: AOJu0Yzcy+wYrSHmRo3IhzFEStTncpU7FhA40i3hxb1H1rDcqKqNgxi/
	P3cfOwYkPHB2r5jiUizfibv64BNOf6Lk6O+F8PvvJ7xbOwMFv8euKZjHw/Hy
X-Google-Smtp-Source: AGHT+IFQEdUWPrQMBQX/VBbNPPzQ2kdo4j343JE6T2kPfVHXSGQJn4GnQwFQEXkkpxIdC+h/s2HzWQ==
X-Received: by 2002:a05:6870:d24a:b0:21e:cd2a:4504 with SMTP id h10-20020a056870d24a00b0021ecd2a4504mr1424636oac.20.1709860131655;
        Thu, 07 Mar 2024 17:08:51 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id fa6-20020a056a002d0600b006e632025bcdsm6196540pfb.138.2024.03.07.17.08.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 10/14] libbpf: Recognize __arena global varaibles.
Date: Thu,  7 Mar 2024 17:08:08 -0800
Message-Id: <20240308010812.89848-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

LLVM automatically places __arena variables into ".arena.1" ELF section.
In order to use such global variables bpf program must include definition
of arena map in ".maps" section, like:
struct {
       __uint(type, BPF_MAP_TYPE_ARENA);
       __uint(map_flags, BPF_F_MMAPABLE);
       __uint(max_entries, 1000);         /* number of pages */
       __ulong(map_extra, 2ull << 44);    /* start of mmap() region */
} arena SEC(".maps");

libbpf recognizes both uses of arena and creates single `struct bpf_map *`
instance in libbpf APIs.
".arena.1" ELF section data is used as initial data image, which is exposed
through skeleton and bpf_map__initial_value() to the user, if they need to tune
it before the load phase. During load phase, this initial image is copied over
into mmap()'ed region corresponding to arena, and discarded.

Few small checks here and there had to be added to make sure this
approach works with bpf_map__initial_value(), mostly due to hard-coded
assumption that map->mmaped is set up with mmap() syscall and should be
munmap()'ed. For arena, .arena.1 can be (much) smaller than maximum
arena size, so this smaller data size has to be tracked separately.
Given it is enforced that there is only one arena for entire bpf_object
instance, we just keep it in a separate field. This can be generalized
if necessary later.

All global variables from ".arena.1" section are accessible from user space
via skel->arena->name_of_var.

For bss/data/rodata the skeleton/libbpf perform the following sequence:
1. addr = mmap(MAP_ANONYMOUS)
2. user space optionally modifies global vars
3. map_fd = bpf_create_map()
4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
5. mmap(addr, MAP_FIXED, map_fd)
after step 5 user spaces see the values it wrote at step 2 at the same addresses

arena doesn't support update_map_elem. Hence skeleton/libbpf do:
1. addr = malloc(sizeof SEC ".arena.1")
2. user space optionally modifies global vars
3. map_fd = bpf_create_map(MAP_TYPE_ARENA)
4. real_addr = mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
5. memcpy(real_addr, addr) // this will fault-in and allocate pages

At the end look and feel of global data vs __arena global data is the same from
bpf prog pov.

Another complication is:
struct {
  __uint(type, BPF_MAP_TYPE_ARENA);
} arena SEC(".maps");

int __arena foo;
int bar;

  ptr1 = &foo;   // relocation against ".arena.1" section
  ptr2 = &arena; // relocation against ".maps" section
  ptr3 = &bar;   // relocation against ".bss" section

Fo the kernel ptr1 and ptr2 has point to the same arena's map_fd
while ptr3 points to a different global array's map_fd.
For the verifier:
ptr1->type == unknown_scalar
ptr2->type == const_ptr_to_map
ptr3->type == ptr_to_map_value

After verification, from JIT pov all 3 ptr-s are normal ld_imm64 insns.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c |  13 +++++
 tools/lib/bpf/libbpf.c  | 118 ++++++++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h  |   2 +-
 3 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a3d72be347b0..4fa4ade1ce74 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -120,6 +120,12 @@ static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
 	int i, n;
 
+	/* recognize hard coded LLVM section name */
+	if (strcmp(sec_name, ".arena.1") == 0) {
+		/* this is the name to use in skeleton */
+		snprintf(buf, buf_sz, "arena");
+		return true;
+	}
 	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
 		const char *pfx = pfxs[i];
 
@@ -250,6 +256,13 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 
 static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 {
+	size_t tmp_sz;
+
+	if (bpf_map__type(map) == BPF_MAP_TYPE_ARENA && bpf_map__initial_value(map, &tmp_sz)) {
+		snprintf(buf, sz, "arena");
+		return true;
+	}
+
 	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
 		return false;
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 34b722071874..efab29b8935b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -498,6 +498,7 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
+#define ARENA_SEC ".arena.1"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -629,6 +630,7 @@ struct elf_state {
 	Elf *elf;
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
+	Elf_Data *arena_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -638,6 +640,7 @@ struct elf_state {
 	int text_shndx;
 	int symbols_shndx;
 	bool has_st_ops;
+	int arena_data_shndx;
 };
 
 struct usdt_manager;
@@ -697,6 +700,10 @@ struct bpf_object {
 
 	struct usdt_manager *usdt_man;
 
+	struct bpf_map *arena_map;
+	void *arena_data;
+	size_t arena_data_sz;
+
 	struct kern_feature_cache *feat_cache;
 	char *token_path;
 	int token_fd;
@@ -1443,6 +1450,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	elf_end(obj->efile.elf);
 	obj->efile.elf = NULL;
 	obj->efile.symbols = NULL;
+	obj->efile.arena_data = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -1851,7 +1859,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	def->value_size = data_sz;
 	def->max_entries = 1;
 	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
-			 ? BPF_F_RDONLY_PROG : 0;
+		? BPF_F_RDONLY_PROG : 0;
 
 	/* failures are fine because of maps like .rodata.str1.1 */
 	(void) map_fill_btf_type_info(obj, map);
@@ -2843,6 +2851,32 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 	return 0;
 }
 
+static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
+			       const char *sec_name, int sec_idx,
+			       void *data, size_t data_sz)
+{
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t mmap_sz;
+
+	mmap_sz = bpf_map_mmap_sz(obj->arena_map);
+	if (roundup(data_sz, page_sz) > mmap_sz) {
+		pr_warn("elf: sec '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
+			sec_name, mmap_sz, data_sz);
+		return -E2BIG;
+	}
+
+	obj->arena_data = malloc(data_sz);
+	if (!obj->arena_data)
+		return -ENOMEM;
+	memcpy(obj->arena_data, data, data_sz);
+	obj->arena_data_sz = data_sz;
+
+	/* make bpf_map__init_value() work for ARENA maps */
+	map->mmaped = obj->arena_data;
+
+	return 0;
+}
+
 static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 					  const char *pin_root_path)
 {
@@ -2892,6 +2926,33 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 			return err;
 	}
 
+	for (i = 0; i < obj->nr_maps; i++) {
+		struct bpf_map *map = &obj->maps[i];
+
+		if (map->def.type != BPF_MAP_TYPE_ARENA)
+			continue;
+
+		if (obj->arena_map) {
+			pr_warn("map '%s': only single ARENA map is supported (map '%s' is also ARENA)\n",
+				map->name, obj->arena_map->name);
+			return -EINVAL;
+		}
+		obj->arena_map = map;
+
+		if (obj->efile.arena_data) {
+			err = init_arena_map_data(obj, map, ARENA_SEC, obj->efile.arena_data_shndx,
+						  obj->efile.arena_data->d_buf,
+						  obj->efile.arena_data->d_size);
+			if (err)
+				return err;
+		}
+	}
+	if (obj->efile.arena_data && !obj->arena_map) {
+		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
+			ARENA_SEC);
+		return -ENOENT;
+	}
+
 	return 0;
 }
 
@@ -3771,6 +3832,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
 				obj->efile.has_st_ops = true;
+			} else if (strcmp(name, ARENA_SEC) == 0) {
+				obj->efile.arena_data = data;
+				obj->efile.arena_data_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -4400,6 +4464,15 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	type = bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
 	sym_sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));
 
+	/* arena data relocation */
+	if (shdr_idx == obj->efile.arena_data_shndx) {
+		reloc_desc->type = RELO_DATA;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->map_idx = obj->arena_map - obj->maps;
+		reloc_desc->sym_off = sym->st_value;
+		return 0;
+	}
+
 	/* generic map reference relocation */
 	if (type == LIBBPF_MAP_UNSPEC) {
 		if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
@@ -4940,6 +5013,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
 		return 0;
 	}
+
 	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err = -errno;
@@ -5289,6 +5363,10 @@ bpf_object__create_maps(struct bpf_object *obj)
 						map->name, err);
 					return err;
 				}
+				if (obj->arena_data) {
+					memcpy(map->mmaped, obj->arena_data, obj->arena_data_sz);
+					zfree(&obj->arena_data);
+				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
@@ -8786,13 +8864,9 @@ static void bpf_map__destroy(struct bpf_map *map)
 	zfree(&map->init_slots);
 	map->init_slots_sz = 0;
 
-	if (map->mmaped) {
-		size_t mmap_sz;
-
-		mmap_sz = bpf_map_mmap_sz(map);
-		munmap(map->mmaped, mmap_sz);
-		map->mmaped = NULL;
-	}
+	if (map->mmaped && map->mmaped != map->obj->arena_data)
+		munmap(map->mmaped, bpf_map_mmap_sz(map));
+	map->mmaped = NULL;
 
 	if (map->st_ops) {
 		zfree(&map->st_ops->data);
@@ -8852,6 +8926,8 @@ void bpf_object__close(struct bpf_object *obj)
 	if (obj->token_fd > 0)
 		close(obj->token_fd);
 
+	zfree(&obj->arena_data);
+
 	free(obj);
 }
 
@@ -10063,18 +10139,26 @@ __u32 bpf_map__btf_value_type_id(const struct bpf_map *map)
 int bpf_map__set_initial_value(struct bpf_map *map,
 			       const void *data, size_t size)
 {
+	size_t actual_sz;
+
 	if (map->obj->loaded || map->reused)
 		return libbpf_err(-EBUSY);
 
-	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG ||
-	    size != map->def.value_size)
+	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
+		return libbpf_err(-EINVAL);
+
+	if (map->def.type == BPF_MAP_TYPE_ARENA)
+		actual_sz = map->obj->arena_data_sz;
+	else
+		actual_sz = map->def.value_size;
+	if (size != actual_sz)
 		return libbpf_err(-EINVAL);
 
 	memcpy(map->mmaped, data, size);
 	return 0;
 }
 
-void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
+void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 {
 	if (bpf_map__is_struct_ops(map)) {
 		if (psize)
@@ -10084,7 +10168,12 @@ void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 
 	if (!map->mmaped)
 		return NULL;
-	*psize = map->def.value_size;
+
+	if (map->def.type == BPF_MAP_TYPE_ARENA)
+		*psize = map->obj->arena_data_sz;
+	else
+		*psize = map->def.value_size;
+
 	return map->mmaped;
 }
 
@@ -13573,6 +13662,11 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 			continue;
 		}
 
+		if (map->def.type == BPF_MAP_TYPE_ARENA) {
+			*mmaped = map->mmaped;
+			continue;
+		}
+
 		if (map->def.map_flags & BPF_F_RDONLY_PROG)
 			prot = PROT_READ;
 		else
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..7b510761f545 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1014,7 +1014,7 @@ LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
 
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
-LIBBPF_API void *bpf_map__initial_value(struct bpf_map *map, size_t *psize);
+LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize);
 
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
-- 
2.43.0

