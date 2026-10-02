Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F937206B
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945276; cv=none; b=tSQsFq8qVgzgTfYFB9dj0NerXH9+rcJ2KlHaaPhjekn+T4VXjrtDYKvXq+voiet/FViFcPUCmJgjqfOIcjJRNqJGccPjbTIFdKqzrjMssl6tUZYvT/WWqxr0oKymEns2PdoBpkUEOOM3a3/8FTiFO2Fs7MPg7QKjnTZIjIJM/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945276; c=relaxed/simple;
	bh=yr86RTdh1rgt2rL22iWsuPZkHWJ2noaA5avEB0q3ei8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVJMiDGmH17Y+SY2vZELJFNiV8EuULjU4EqpD+zwwMU6KGZcy4l88eFJC8S0RKWoWCHflmqI+bOowqoo2CB+wdD0DfatE6z6laDgzPAYADa2FOPaJLLCnU9MdTAMwawmLQPhJH8taWDR+6cQFZfLCVfy5jz+AgVpyCOCHjGTMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njp1vUsV; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njp1vUsV"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso4452580a91.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945272; x=1791550072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mdv+Cu3/0oQDwWaDwxumKjHGm7IyKRnBqB8xRQ2aJsM=;
        b=njp1vUsVopXHZWi7eE0Uox2+oBUvxpFq7GFCoQ6D3ri7XxxZIA6QZaa1AV5n509v8j
         aLRhgPp1XAtnBEA6X3YAhoa5O3dGveISQox0K8wGNfCQJ3OExOFBvm8fLVJ3oQGDhXsO
         x10hkqadatlGQGYFwsc0Zq+wApI9CEAzCZRlV7PtF47+tjxmbLy6WIo+060IY3HUpDoN
         A0iBOsB/luGnP8JB6K7+ts/u3q3PJQ9eUNsyS1cqhw/Q3dICa5H4r074x5ZOndVvFg08
         0WG8IRBjbbJgkoNkP4hqFaUaWIt85IXAelucpf2bW7GYKOXRWYnH/4bUC51Ow4LO805J
         zksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945272; x=1791550072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mdv+Cu3/0oQDwWaDwxumKjHGm7IyKRnBqB8xRQ2aJsM=;
        b=AP1yvVQUpuj5wH9C8XIhAZfPnprpJudGFzB3v2M9JnsCfc7g1ReKHF86Pvh9bQOevp
         KHccLj+0CCAd6E7OaKF5keD3pQ4OqxYWJXMI3om3wATHnMWm/Q9q04eMFTw6jDKDAFr0
         J3RPZR9hHE7217QGJbaoIqFhU+IXxKrFdxvqhDDLDswWjFfRBUaKGM2N+lK0jqA6cO/z
         tHEXhAnakzE9I0KzFppE1Rpc3Xp2D8PJWhdeXiW/T7czQ3Z8+AomwSI9CoOqxVBVvbE7
         sElFCfoLNe/RVYP8dcRtFQbTRO4U0JfCUJrFEJoC/OXGZ8tiOG94t3zQ2IiN49MZTE2V
         URIg==
X-Gm-Message-State: AFq9FYIpltnvgpgJpJh8pY5aVEDpWsjcaFloOMypeql/Rn23HF1rB0gv
	BYHsbFk5q2VCcHjiJv32ZUfKSTnYPiTYZxVWswWKVWw7IxIUHDX4+KqfMwMYdfdGrME=
X-Gm-Gg: AYBFou29dDrf5EADNwAC3aMPpwmwzE/pwjuXwXeKNMez+1H+kwgEsu+GYIF2tHFuam8
	Mt0le1nkNXpi4YXB97CCV0ZpfvOtv1PnW0EhggS1fRS4b2SSnpHfeF6n5nLUoPVeVlc2y8V6fuG
	ybt2VOuWfWUWwTJMg+yyXIvwH5EHT9dfj5byY8A4c8Q+Gm9JL1mhjleQQwFLu4baNaGSyynZrxZ
	I+Kd+rL43XiR8uLfZH7M/YDyNQ4iVTHf+2s6jApzd+0b8qYZQf3dZH7kGzSNSNg6mw5eRULQU7V
	lgB63ZYnTWIXMCERVk3BfKW3ja0jPWbb3/KigHVI+k0leBYGSeMjreM4NPe3aIhhzFCI1xZnIzE
	wg8LSL2++PcUP9tanr7RYQcW46whxDaFyrWVDsnrP+6O5QXSBjYrYdeQAYXVa7/2g/PVDsCYC+T
	yRmimwqCQHuRvD01c15Z/F3O/EQ1RcWabG17Ezy124fbOKnqbxga/xUpS5Wx/owEeyphM+En44C
	VgyMCktWzVgLJDwUJ+/pSj+11pImvLYRaD3gwSMzSKJDhM0pYNO8atI5bxNOe5lTkmQ4DtX+ST+
	Q/V14OETg5gsjfAlnOB11Ep/BA/DiFUWMZ34R6M1eNo=
X-Received: by 2002:a17:90b:4f42:b0:39d:f247:bab with SMTP id 98e67ed59e1d1-3a6ce5fa392mr2381300a91.6.1790945271821;
        Fri, 02 Oct 2026 05:47:51 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5ddb51sm3901787a91.14.2026.10.02.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/15] libbpf: Keep global data in arena when the object has .arena.data
Date: Fri,  2 Oct 2026 12:47:11 +0000
Message-ID: <20261002124714.180012-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

All memory of a Rust program is arena, global data included. There are
no address spaces in Rust to say so. LLVM also drops bounds checks of
indexes into constant tables of core that it proved, so the verifier
can't check the access as access to map value.

The object asks for it with a section named .arena.data. What is in
the section doesn't matter:

  #[used]
  #[link_section = ".arena.data"]
  static DATA_IN_ARENA: u8 = 0;

or in C:

  char data_in_arena SEC(".arena.data");

There is nothing to tell to libbpf, so bpftool, veristat and other
loaders work with such objects as they are. When the object has the
section:
- .data, .bss and .rodata sections are appended to arena data after
  __arena variables, at the alignment of the section. Like __arena
  variables the data is at the end of arena.
- relocations of insns against the sections become relocations against
  the arena map.
- array maps of the sections are not created.
- when the object has no arena map libbpf creates one that is as large
  as the data. bpf_object__find_map_by_name(obj, "arena") finds it and
  bpf_map__set_max_entries() makes room for allocations. __arena
  variables still need the arena map to be declared.

Read-only sections that stay frozen array maps:
- .data.rel.ro and sections that have relocations in them. The kernel
  recognizes pointers to functions in them by value for callx.
- .rodata.str*. They hold const strings for __str arguments of kfuncs.
  A copy of them is in arena too.

The program dereferences pointers that it loads from data, so pointers
to data that are stored in data become addresses of arena, wherever the
pointer is. The arena map is created ahead of the other maps then, since
its address goes into their data. A pointer to .rodata.str* points to
the copy. A pointer to a section that is not in arena fails the load:

  sec '.data': pointer to 'tbl' at offset 8 can't be resolved:
  sec '.data.rel.ro' is not in arena

So does an arena that is pinned or reused. libbpf doesn't mmap it, so
its address is not known.

Programs of the object are loaded with BPF_F_ARENA_SCALAR, since they
access the data through plain numbers.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 433 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 413 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fdd69aac39bd..cb09ded90773 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -552,6 +552,26 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+/*
+ * An object with this section keeps its global data in arena instead of
+ * array maps. What is in the section doesn't matter. .data, .bss and .rodata
+ * sections become a part of the arena map of the object, like __arena global
+ * variables are. If the object doesn't declare an arena map libbpf creates
+ * one that is just large enough for the data. bpf_object__find_map_by_name()
+ * finds it by the name "arena" and bpf_map__set_max_entries() changes its
+ * size before the object is loaded.
+ * Read-only sections with pointers to functions and sections with constant
+ * strings stay frozen array maps. A constant that a helper or a kfunc takes
+ * by pointer has to be in such section.
+ * Pointers to data that are stored in data become addresses of arena.
+ * The load fails if such pointer points to a section that is not in arena,
+ * or if the arena is pinned or reused.
+ *
+ * It's for programs written in Rust. There are no address spaces in Rust,
+ * the program accesses arena through plain numbers, so programs of the object
+ * are loaded with BPF_F_ARENA_SCALAR.
+ */
+#define ARENA_DATA_SEC ".arena.data"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -607,6 +627,13 @@ struct bpf_map {
 	/* pointers to functions in the data of an internal map, see obj->func_ptrs */
 	struct func_ptr *func_ptrs;
 	size_t func_ptr_cnt;
+	/*
+	 * Data of the internal map is a part of arena data at arena_off.
+	 * The map is not created, unless it's a copy that is in arena.
+	 */
+	bool in_arena;
+	bool arena_copy;
+	size_t arena_off;
 };
 
 enum extern_type {
@@ -775,6 +802,17 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 	size_t arena_data_off;
+	bool data_in_arena;
+	bool arena_mapped;
+	/* pointers to data in the data of internal maps, when data is in arena */
+	struct data_ptr {
+		int sec_idx;
+		size_t sec_off;
+		int targ_sec_idx;
+		size_t targ_off;
+		char *sym_name;
+	} *data_ptrs;
+	size_t data_ptr_cnt;
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -1600,6 +1638,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
+	obj->efile.arena_data_shndx = -1;
 	obj->kconfig_map_idx = -1;
 	obj->arena_map_idx = -1;
 
@@ -3081,6 +3120,136 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	return 0;
 }
 
+static bool map_is_const_str(const struct bpf_map *map)
+{
+	return map->libbpf_type == LIBBPF_MAP_RODATA &&
+	       str_has_pfx(map->real_name, RODATA_SEC ".str");
+}
+
+static bool map_data_goes_to_arena(const struct bpf_object *obj, const struct bpf_map *map)
+{
+	int i;
+
+	switch (map->libbpf_type) {
+	case LIBBPF_MAP_DATA:
+	case LIBBPF_MAP_BSS:
+		return true;
+	case LIBBPF_MAP_RODATA:
+		break;
+	default:
+		return false;
+	}
+
+	/*
+	 * Const strings that kfuncs and helpers take have to be in a frozen
+	 * map. Pointers to them that are stored in data point to a copy of
+	 * the strings that is in arena.
+	 */
+	if (map_is_const_str(map))
+		return true;
+	/*
+	 * Read-only data with pointers stays a frozen map: the kernel
+	 * recognizes pointers to functions in it.
+	 */
+	if (str_has_pfx(map->real_name, DATA_REL_RO_SEC))
+		return false;
+	for (i = 0; i < obj->efile.sec_cnt; i++) {
+		const struct elf_sec_desc *sec = &obj->efile.secs[i];
+
+		if (sec->sec_type == SEC_RELO && sec->shdr->sh_info == map->sec_idx)
+			return false;
+	}
+	return true;
+}
+
+/* Returns the offset of the data of the map in arena data that is sz bytes so far */
+static size_t map_arena_off(const struct bpf_object *obj, const struct bpf_map *map, size_t sz)
+{
+	size_t align = obj->efile.secs[map->sec_idx].shdr->sh_addralign;
+
+	return roundup(sz, max(align, sizeof(__u64)));
+}
+
+/*
+ * Make .data, .bss and .rodata a part of arena data. They follow __arena
+ * variables of the object, if there are any.
+ */
+static int bpf_object__init_arena_data(struct bpf_object *obj)
+{
+	const size_t page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t sz = obj->arena_data_sz;
+	struct bpf_map *map;
+	void *data;
+	int i;
+
+	if (!obj->data_in_arena)
+		return 0;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+		if (map_data_goes_to_arena(obj, map))
+			sz = map_arena_off(obj, map, sz) + map->def.value_size;
+	}
+	if (sz == obj->arena_data_sz)
+		return 0;
+
+	if (obj->arena_map_idx < 0) {
+		/* bpf_object__init_user_btf_maps() didn't look: there is no .maps section */
+		if (obj->efile.arena_data) {
+			pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
+				ARENA_SEC);
+			return -ENOENT;
+		}
+
+		map = bpf_object__add_map(obj);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
+
+		map->real_name = strdup("arena");
+		map->name = strdup("arena");
+		if (!map->real_name || !map->name) {
+			zfree(&map->real_name);
+			zfree(&map->name);
+			return -ENOMEM;
+		}
+		map->sec_idx = -1;
+		map->def.type = BPF_MAP_TYPE_ARENA;
+		map->def.max_entries = roundup(sz, page_sz) / page_sz;
+		map->def.map_flags = BPF_F_MMAPABLE;
+		obj->arena_map_idx = map - obj->maps;
+	}
+
+	data = realloc(obj->arena_data, sz);
+	if (!data)
+		return -ENOMEM;
+	memset(data + obj->arena_data_sz, 0, sz - obj->arena_data_sz);
+	sz = obj->arena_data_sz;
+	obj->arena_data = data;
+	obj->maps[obj->arena_map_idx].mmaped = data;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+		if (!map_data_goes_to_arena(obj, map))
+			continue;
+		sz = map_arena_off(obj, map, sz);
+		map->arena_off = sz;
+		memcpy(data + sz, map->mmaped, map->def.value_size);
+		sz += map->def.value_size;
+		pr_debug("map '%s': data is in arena at offset %zu\n", map->name, map->arena_off);
+		if (map_is_const_str(map)) {
+			map->arena_copy = true;
+			continue;
+		}
+		munmap(map->mmaped, bpf_map_mmap_sz(map));
+		/* make bpf_map__initial_value() and bpf_map__set_initial_value() work */
+		map->mmaped = data + map->arena_off;
+		map->autocreate = false;
+		map->in_arena = true;
+	}
+	obj->arena_data_sz = sz;
+	return 0;
+}
+
 static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 					  const char *pin_root_path)
 {
@@ -3173,6 +3342,7 @@ static int bpf_object__init_maps(struct bpf_object *obj,
 	err = err ?: bpf_object__init_global_data_maps(obj);
 	err = err ?: bpf_object__init_kconfig_map(obj);
 	err = err ?: bpf_object_init_struct_ops(obj);
+	err = err ?: bpf_object__init_arena_data(obj);
 
 	return err;
 }
@@ -3987,6 +4157,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		if (!sh)
 			return -LIBBPF_ERRNO__FORMAT;
 
+		/* the second pass has to know it when it sees relocations of data */
+		name = elf_sec_str(obj, sh->sh_name);
+		if (name && strcmp(name, ARENA_DATA_SEC) == 0)
+			obj->data_in_arena = true;
+
 		if (sh->sh_type == SHT_SYMTAB) {
 			if (obj->efile.symbols) {
 				pr_warn("elf: multiple symbol tables in %s\n", obj->path);
@@ -4103,6 +4278,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, ARENA_SEC) == 0) {
 				obj->efile.arena_data = data;
 				obj->efile.arena_data_shndx = idx;
+			} else if (strcmp(name, ARENA_DATA_SEC) == 0) {
+				/* the marker, see the first pass */
 			} else if (strcmp(name, JUMPTABLES_SEC) == 0) {
 				obj->jumptables_data = malloc(data->d_size);
 				if (!obj->jumptables_data)
@@ -4127,6 +4304,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			 * have pointers to functions.
 			 */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
+			    !(obj->data_in_arena &&
+			      (!strcmp(name, ".rel" DATA_SEC) ||
+			       str_has_pfx(name, ".rel" DATA_SEC "."))) &&
 			    strcmp(name, ".rel" RODATA_SEC) &&
 			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
 			    strcmp(name, ".rel" DATA_REL_RO_SEC) &&
@@ -4878,6 +5058,10 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	reloc_desc->insn_idx = insn_idx;
 	reloc_desc->map_idx = map_idx;
 	reloc_desc->sym_off = sym->st_value;
+	if (map->in_arena) {
+		reloc_desc->map_idx = obj->arena_map_idx;
+		reloc_desc->sym_off += map->arena_off;
+	}
 	return 0;
 }
 
@@ -5096,6 +5280,9 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
+	if (map->in_arena)
+		return libbpf_err(-EOPNOTSUPP);
+
 	map->autocreate = autocreate;
 	return 0;
 }
@@ -5376,6 +5563,45 @@ bpf_object__reuse_map(struct bpf_map *map)
 	return 0;
 }
 
+static struct bpf_map *bpf_object__sec_map(struct bpf_object *obj, int sec_idx)
+{
+	int i;
+
+	for (i = 0; i < obj->nr_maps; i++)
+		if (bpf_map__is_internal(&obj->maps[i]) && obj->maps[i].sec_idx == sec_idx)
+			return &obj->maps[i];
+	return NULL;
+}
+
+static int bpf_object__mmap_arena(struct bpf_object *obj, struct bpf_map *map)
+{
+	int i, err;
+
+	map->mmaped = mmap((void *)(long)map->map_extra,
+			   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
+			   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
+			   map->fd, 0);
+	if (map->mmaped == MAP_FAILED) {
+		err = -errno;
+		map->mmaped = NULL;
+		pr_warn("map '%s': failed to mmap arena: %s\n",
+			map->name, errstr(err));
+		return err;
+	}
+	if (obj->arena_data) {
+		memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
+			obj->arena_data_sz);
+		zfree(&obj->arena_data);
+	}
+	for (i = 0; i < obj->nr_maps; i++) {
+		struct bpf_map *m = &obj->maps[i];
+
+		if (m->in_arena)
+			m->mmaped = map->mmaped + obj->arena_data_off + m->arena_off;
+	}
+	return 0;
+}
+
 static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
@@ -5736,6 +5962,10 @@ bpf_object__create_maps(struct bpf_object *obj)
 			continue;
 		}
 
+		/* see bpf_object__relocate_data_ptrs() */
+		if (map->def.type == BPF_MAP_TYPE_ARENA && obj->arena_mapped)
+			continue;
+
 		err = map_set_def_max_entries(map);
 		if (err)
 			goto err_out;
@@ -5773,22 +6003,9 @@ bpf_object__create_maps(struct bpf_object *obj)
 				if (err < 0)
 					goto err_out;
 			} else if (map->def.type == BPF_MAP_TYPE_ARENA) {
-				map->mmaped = mmap((void *)(long)map->map_extra,
-						   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
-						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
-						   map->fd, 0);
-				if (map->mmaped == MAP_FAILED) {
-					err = -errno;
-					map->mmaped = NULL;
-					pr_warn("map '%s': failed to mmap arena: %s\n",
-						map->name, errstr(err));
+				err = bpf_object__mmap_arena(obj, map);
+				if (err)
 					return err;
-				}
-				if (obj->arena_data) {
-					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
-						obj->arena_data_sz);
-					zfree(&obj->arena_data);
-				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
@@ -7803,6 +8020,81 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 	return err;
 }
 
+/*
+ * Turn pointers to data that are stored in data into addresses of arena.
+ * The arena is created here, ahead of the other maps: the address has to be
+ * known before the maps that hold the pointers are created.
+ */
+static int bpf_object__relocate_data_ptrs(struct bpf_object *obj)
+{
+	struct bpf_map *arena, *map, *targ;
+	__u64 addr, val;
+	size_t i;
+	int err;
+
+	if (!obj->data_ptr_cnt)
+		return 0;
+
+	for (i = 0; i < obj->data_ptr_cnt; i++) {
+		struct data_ptr *p = &obj->data_ptrs[i];
+
+		if (p->targ_sec_idx < 0)
+			continue;
+		map = bpf_object__sec_map(obj, p->sec_idx);
+		targ = bpf_object__sec_map(obj, p->targ_sec_idx);
+		if (map && (map->in_arena || map->autocreate) &&
+		    (!targ || (!targ->in_arena && !targ->arena_copy))) {
+			pr_warn("sec '%s': pointer to '%s' at offset %zu can't be resolved: sec '%s' is not in arena\n",
+				map->real_name, p->sym_name, p->sec_off,
+				targ ? targ->real_name : "<?>");
+			return -LIBBPF_ERRNO__RELOC;
+		}
+	}
+
+	if (obj->gen_loader) {
+		pr_warn("pointers to data in data are not supported by light skeleton\n");
+		return -ENOTSUP;
+	}
+
+	if (obj->arena_map_idx < 0)
+		return 0;
+
+	arena = &obj->maps[obj->arena_map_idx];
+	if (!arena->autocreate)
+		return 0;
+	/* libbpf doesn't mmap an arena that it didn't create, so the address is not known */
+	if (arena->reused || arena->pin_path) {
+		pr_warn("map '%s': pointers to data in data are not supported with pinned or reused arena\n",
+			arena->name);
+		return -ENOTSUP;
+	}
+
+	err = bpf_object__create_map(obj, arena, false);
+	err = err ?: bpf_object__mmap_arena(obj, arena);
+	if (err) {
+		pr_warn("map '%s': failed to create: %s\n", arena->name, errstr(err));
+		return err;
+	}
+	obj->arena_mapped = true;
+
+	for (i = 0; i < obj->data_ptr_cnt; i++) {
+		struct data_ptr *p = &obj->data_ptrs[i];
+
+		map = bpf_object__sec_map(obj, p->sec_idx);
+		if (!map || (!map->in_arena && !map->autocreate))
+			continue;
+
+		addr = (__u64)(unsigned long)arena->mmaped + obj->arena_data_off + p->targ_off;
+		if (p->targ_sec_idx >= 0)
+			addr += bpf_object__sec_map(obj, p->targ_sec_idx)->arena_off;
+
+		memcpy(&val, map->mmaped + p->sec_off, sizeof(val));
+		val += addr;
+		memcpy(map->mmaped + p->sec_off, &val, sizeof(val));
+	}
+	return 0;
+}
+
 static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
@@ -7825,8 +8117,10 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		size_t mmap_sz = bpf_map_mmap_sz(arena_map);
 
 		if (data_sz > mmap_sz) {
-			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
-				arena_map->name, mmap_sz, obj->arena_data_sz);
+			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global %s of size %zu\n",
+				arena_map->name, mmap_sz,
+				obj->data_in_arena ? "data" : "__arena variables",
+				obj->arena_data_sz);
 			return -E2BIG;
 		}
 
@@ -7835,6 +8129,10 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 			obj->arena_data_off = mmap_sz - data_sz;
 	}
 
+	err = bpf_object__relocate_data_ptrs(obj);
+	if (err)
+		return err;
+
 	/* Before relocating calls pre-process relocations and mark
 	 * few ld_imm64 instructions that points to subprogs.
 	 * Otherwise bpf_object__reloc_code() later would have to consider
@@ -8067,12 +8365,85 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	return 0;
 }
 
+/*
+ * A pointer to data that is stored in data. When data is in arena
+ * the program dereferences what it loads from data, so the pointer has
+ * to be the address of the target in arena.
+ */
+static int bpf_object__collect_data_ptr(struct bpf_object *obj, const char *relo_sec_name,
+					int relo_idx, size_t sec_idx, const Elf64_Rel *rel,
+					const Elf64_Sym *sym)
+{
+	Elf_Data *scn_data = obj->efile.secs[sec_idx].data;
+	const char *sym_name = elf_sym_str(obj, sym->st_name) ?: "<?>";
+	struct data_ptr *ptrs;
+
+	if (ELF64_ST_TYPE(sym->st_info) == STT_SECTION && sym->st_shndx < obj->efile.sec_cnt)
+		sym_name = elf_sec_name(obj, elf_sec_by_idx(obj, sym->st_shndx)) ?: "<?>";
+
+	if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
+	    sym->st_shndx >= obj->efile.sec_cnt ||
+	    (sym->st_shndx != obj->efile.arena_data_shndx &&
+	     !bpf_object__shndx_is_data(obj, sym->st_shndx)) ||
+	    rel->r_offset >= scn_data->d_size ||
+	    scn_data->d_size - rel->r_offset < sizeof(__u64)) {
+		pr_warn("sec '%s': relo #%d: can't resolve pointer to '%s' at offset %zu when data is in arena\n",
+			relo_sec_name, relo_idx, sym_name, (size_t)rel->r_offset);
+		return -LIBBPF_ERRNO__RELOC;
+	}
+
+	ptrs = libbpf_reallocarray(obj->data_ptrs, obj->data_ptr_cnt + 1, sizeof(*ptrs));
+	if (!ptrs)
+		return -ENOMEM;
+	obj->data_ptrs = ptrs;
+
+	ptrs[obj->data_ptr_cnt].sec_idx = sec_idx;
+	ptrs[obj->data_ptr_cnt].sec_off = rel->r_offset;
+	/* __arena variables are at the start of arena data */
+	ptrs[obj->data_ptr_cnt].targ_sec_idx =
+		sym->st_shndx == obj->efile.arena_data_shndx ? -1 : sym->st_shndx;
+	ptrs[obj->data_ptr_cnt].targ_off = sym->st_value;
+	ptrs[obj->data_ptr_cnt].sym_name = strdup(sym_name);
+	if (!ptrs[obj->data_ptr_cnt].sym_name)
+		return -ENOMEM;
+	obj->data_ptr_cnt++;
+
+	pr_debug("sec '%s': relo #%d: pointer at offset %zu to '%s'\n",
+		 relo_sec_name, relo_idx, (size_t)rel->r_offset, sym_name);
+	return 0;
+}
+
+/* Collect pointers in a data section that went to arena */
+static int bpf_object__collect_data_relos(struct bpf_object *obj,
+					  Elf64_Shdr *shdr, Elf_Data *data)
+{
+	int i, err, nrels = shdr->sh_size / shdr->sh_entsize;
+	const char *relo_sec_name;
+	Elf64_Sym *sym;
+	Elf64_Rel *rel;
+
+	relo_sec_name = elf_sec_str(obj, shdr->sh_name) ?: "<?>";
+	for (i = 0; i < nrels; i++) {
+		rel = elf_rel_by_idx(data, i);
+		sym = rel ? elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info)) : NULL;
+		if (!sym) {
+			pr_warn("sec '%s': failed to get relo #%d\n", relo_sec_name, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+		err = bpf_object__collect_data_ptr(obj, relo_sec_name, i, shdr->sh_info, rel, sym);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * Collect pointers to functions in a read-only data section. They are
  * R_BPF_64_ABS64 relocations against .text section, where the offset of
  * a static function in the section is stored in place. Relocations in data
  * sections were ignored before pointers to functions were supported. Those
- * that are something else, e.g. pointers to data, still are.
+ * that are something else, e.g. pointers to data, still are, unless data
+ * is in arena.
  */
 static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
@@ -8108,6 +8479,15 @@ static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 
 		if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
 		    !sym_is_subprog(sym, obj->efile.text_shndx)) {
+			int err;
+
+			if (obj->data_in_arena) {
+				err = bpf_object__collect_data_ptr(obj, relo_sec_name, i,
+								   sec_idx, rel, sym);
+				if (err)
+					return err;
+				continue;
+			}
 			pr_debug("sec '%s': relo #%d: not a pointer to a function, skipping...\n",
 				 relo_sec_name, i);
 			continue;
@@ -8183,6 +8563,8 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 
 		if (obj->efile.secs[idx].sec_type == SEC_RODATA)
 			err = bpf_object__collect_rodata_relos(obj, shdr, data);
+		else if (obj->efile.secs[idx].sec_type == SEC_DATA)
+			err = bpf_object__collect_data_relos(obj, shdr, data);
 		else if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
@@ -8476,6 +8858,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	}
 	load_attr.log_level = log_level;
 	load_attr.prog_flags = prog->prog_flags;
+	/* the program accesses its data in arena through plain numbers */
+	if (obj->data_in_arena)
+		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
 
 	load_attr.token_fd = obj->token_fd;
@@ -8547,7 +8932,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 
 			for (i = 0; i < obj->nr_maps; i++) {
 				map = &prog->obj->maps[i];
-				if (map->libbpf_type != LIBBPF_MAP_RODATA)
+				if (map->libbpf_type != LIBBPF_MAP_RODATA || map->in_arena)
 					continue;
 
 				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
@@ -10111,7 +10496,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	zfree(&map->init_slots);
 	map->init_slots_sz = 0;
 
-	if (map->mmaped && map->mmaped != map->obj->arena_data)
+	if (map->mmaped && map->mmaped != map->obj->arena_data && !map->in_arena)
 		munmap(map->mmaped, bpf_map_mmap_sz(map));
 	map->mmaped = NULL;
 
@@ -10196,6 +10581,9 @@ void bpf_object__close(struct bpf_object *obj)
 			close(obj->func_ptr_maps[i].fd);
 	zfree(&obj->func_ptr_maps);
 	zfree(&obj->func_ptrs);
+	for (i = 0; i < obj->data_ptr_cnt; i++)
+		zfree(&obj->data_ptrs[i].sym_name);
+	zfree(&obj->data_ptrs);
 
 	if (obj->btf_module_allowlist) {
 		for (i = 0; i < obj->btf_module_allowlist_cnt; i++)
@@ -10556,6 +10944,8 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
+	if (obj->data_in_arena)
+		attr.prog_flags |= BPF_F_ARENA_SCALAR;
 
 	prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
 	if (!prog_btf_fd && obj->btf)
@@ -11562,6 +11952,9 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
+	if (map->in_arena)
+		return libbpf_err(-EOPNOTSUPP);
+
 	if (map->mmaped) {
 		size_t mmap_old_sz, mmap_new_sz;
 		int err;
-- 
2.55.0

