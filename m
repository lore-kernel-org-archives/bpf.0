Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127809;
	b=greiJ7ZW5wYMtYFNFX1jEfsOzDS11gcrQPmhcinyqXiKjr2utWEZgbmiR83+PPpY/Z+C
	 JpPJHiCSVW2gMvkdxiULRdmeZsIpyT5RocFNhQPF6uz/jUwqRm9AwyDCkrcxFuuRnla4L
	 EiFNDzMjQThfvhpOqBwX4y4d03zyRU1ohHDPuL0dbA3DaCvtwDyT/OHC8Q5hEQlm6Of96
	 ojXp+BYlCUij9OqQ7bjuxlgCK3j53Vown4by+Ost3SIZKPJur1Tj7Dx5aCPXyuOnepw/H
	 e8hue7p3laLGEfuDD022DkItT8SJwsiq5EpFl109wKMfT3hv7mNA3Yo2JfpTy0ZKpfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UKEcIIF/q8IfLtSrEYdote0OsSNaZhSQlX9cxu7Shtg=;
	b=BjbmiQqiDCAuFUOvZqt2YVmfPHR+/6caUHLlVNZNk4OCeMeeGnjPx/9KKnYAUFb25t+N
	 IsUJN4npPlHmDrBkbcN2ANnhkpOM3GF6IEwIO6xY8vvBNFHOsZpksbVcXtw95QBx7JL9w
	 lNHp7z+c6gyyrOQSHSwcIxUrUi18M8qriEUz+Wmp3yVAypeBijM8FnmpFgin5whU1lPS2
	 RmGfpJ2cG9mvHi8NF1eiM6Lsws/b9wESwiQC1e20q2M0umRoZI8SiMnO2WFWjn0XTLJVg
	 QdVP+EqMLsubfdTc2fbPs3NvNe+aoss2ub+hiojM8ppF9kMYK2fx6Ku848ts4XzYTHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0uybvnui;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF76606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0uybvnui
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so127706a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127808; x=1793732608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKEcIIF/q8IfLtSrEYdote0OsSNaZhSQlX9cxu7Shtg=;
        b=0uybvnuiaRwR4qN2ntbigwtzIaO4k7ZsrabzB3ycv0JwZus8ZffqndiU/F1lOGNb0E
         /EMCCmJduU25Al4fpg8NTWonVASObtlhyXeWx0mmvTDt5XLATale9yvYWFUkfbyyvLqS
         vIgkKuaUpDkgcp17ybyFm/Zsyp45+cgSVR2kDvhL2MYOvc8AKN2+oKzHphGQyMs0aaZP
         9KzyGsshNQ7AKlVGYynykt5FSVYrOA6kmNgzBrDuI3foGdDxf7jUmAhj5AkhnwJS3LaS
         QQNLx9Vrt7rSAZck/RzZZID2tsGx8TE2zzRKNvYgUQ3pr2pLjJeBTrcaRq1A2okvLKc7
         ecMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127808; x=1793732608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKEcIIF/q8IfLtSrEYdote0OsSNaZhSQlX9cxu7Shtg=;
        b=riXYGKLKI3bhZVEpZrX9vYFM85s4VefchzePDmB0LNPS25ffmOyUi4nZtS9+L32lD0
         pOoZgiVZLM9ZmkMsK3ue3/Y+lsnIEXAu2hutAzzrLK+y+4rNkqIBPmGw0ADtEurQhFZ4
         yeNAU414yCETl8Q/JeqJuj1smrwcx2bq7UVlgc5/2MAw3YwWGEeZiKK5A9CXVyoTMNAT
         xrIr0/ZaQJnmITmkBdL6nW+nuivwiLZGqrcsSY8I8VCINxuBDg6NP17/d5UoPO8ow26a
         pwwEmpO6kl1kNhibOm7/axDFJfiHtZYdRltr+Ow/fNvVmUVJkUd4ISohGlajBhhAvIUm
         Uh5Q==
X-Gm-Message-State: AFq9FYJzh4E+23Tgu/U7MAKLSqcso+c6mm9Ya6J5gFnvwC12rxTF3q5q
	KIiVbZDtbNn9WKufCYeDW+1ky0TE65V9r3/Qfb4ujFDcWMzln7FfoYI/aAgohg==
X-Gm-Gg: AYBFou3mX+HCM1x59qREneuc3ay8A+UzPFOov8dDaUbNXOm5aeFzZSEuqdGlwd++cYe
	LLECt4VVl2iBH6yDiijw+XLJpWyagFfgKu8dqewJ18crtmVahgOXJ5DjPEhpy6aV0bVOytSBOHu
	GgHLLk0wlkbRxhis06Q27PEXbHBmA/FAFNz+bU8vEtL+q+HYOL+Ym46auM09UnwfPafXsM/NvH9
	CL3XB5m+B0RrbrIC7/MS2E98GkTV50pPWq9BnLZRsWe4vD31Rav3dAfeo8z0ifzx2xVGq42Ygij
	460fndq756SAFmxh9p3YfGOTrr7zFJFQKtTx6CLyNX4fiHSQnnVTNqaJEUdY2ybsRCbZVQNXwMF
	LUVwawKwDJAkD4gbln3mj+q1pe5mJBxk3HO7aPV/dmWBi7uPQfQOZBGkRn/9stRk/pTntHVM6Mm
	mT8LagHW011et5EqGaoard6fDjHvsL2ZnGXwQVFiigdat7RYoK1r0Ej+yN2T7yLd/HDe5arkafQ
	7nC3PGa81G2CHbYhPDlbSsLdlBd2K3uwdkryW63yrnxhpq0pcPUXg+wH1us1BPsC+6FSVpFf6Pm
	zqQvZ4MwLICVG70G0frsZns5A73aNZTh6LteNOF5qU1AXmm5Q9oXTUVpRY1FDgLcLCCh1rP4Kju
	Da/mc3RWT9Ugee47TN9oRdU6h
X-Received: by 2002:a17:90b:1647:b0:3ab:c674:d83c with SMTP id 98e67ed59e1d1-3ae58101012mr2555a91.27.1793127808239;
        Tue, 27 Oct 2026 12:03:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae574ec466sm157370a91.1.2026.10.27.12.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 02/19] libbpf: Remove .arena.data
Date: Tue, 27 Oct 2026 19:02:57 +0000
Message-ID: <20261027190314.1440199-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Rust has no address spaces. Thus a global variable cannot have the __arena
attribute. The .arena.data section was a workaround. It told libbpf to do
two things:
 - Move .data, .bss and .rodata into arena.
 - Load the progs with BPF_F_ARENA_SCALAR.

The compiler must select the location of a variable, not libbpf. libbpf
already puts the .addr_space.1 section in arena. The __arena variables of C
are in this section, and LLVM can use it for Rust too. Until LLVM does
that, the global data of Rust progs stays in array maps.

This reverts commit 8ab58ed42b08 ("libbpf: Keep global data in arena when
the object has .arena.data"). libbpf 1.8.0 does not have the section.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 433 ++---------------------------------------
 1 file changed, 20 insertions(+), 413 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..fb8a1f07c5b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -552,26 +552,6 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
-/*
- * An object with this section keeps its global data in arena instead of
- * array maps. What is in the section doesn't matter. .data, .bss and .rodata
- * sections become a part of the arena map of the object, like __arena global
- * variables are. If the object doesn't declare an arena map libbpf creates
- * one that is just large enough for the data. bpf_object__find_map_by_name()
- * finds it by the name "arena" and bpf_map__set_max_entries() changes its
- * size before the object is loaded.
- * Read-only sections with pointers to functions and sections with constant
- * strings stay frozen array maps. A constant that a helper or a kfunc takes
- * by pointer has to be in such section.
- * Pointers to data that are stored in data become addresses of arena.
- * The load fails if such pointer points to a section that is not in arena,
- * or if the arena is pinned or reused.
- *
- * It's for programs written in Rust. There are no address spaces in Rust,
- * the program accesses arena through plain numbers, so programs of the object
- * are loaded with BPF_F_ARENA_SCALAR.
- */
-#define ARENA_DATA_SEC ".arena.data"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -627,13 +607,6 @@ struct bpf_map {
 	/* pointers to functions in the data of an internal map, see obj->func_ptrs */
 	struct func_ptr *func_ptrs;
 	size_t func_ptr_cnt;
-	/*
-	 * Data of the internal map is a part of arena data at arena_off.
-	 * The map is not created, unless it's a copy that is in arena.
-	 */
-	bool in_arena;
-	bool arena_copy;
-	size_t arena_off;
 };
 
 enum extern_type {
@@ -808,17 +781,6 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 	size_t arena_data_off;
-	bool data_in_arena;
-	bool arena_mapped;
-	/* pointers to data in the data of internal maps, when data is in arena */
-	struct data_ptr {
-		int sec_idx;
-		size_t sec_off;
-		int targ_sec_idx;
-		size_t targ_off;
-		char *sym_name;
-	} *data_ptrs;
-	size_t data_ptr_cnt;
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -1644,7 +1606,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
-	obj->efile.arena_data_shndx = -1;
 	obj->kconfig_map_idx = -1;
 	obj->arena_map_idx = -1;
 
@@ -3126,136 +3087,6 @@ static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
 	return 0;
 }
 
-static bool map_is_const_str(const struct bpf_map *map)
-{
-	return map->libbpf_type == LIBBPF_MAP_RODATA &&
-	       str_has_pfx(map->real_name, RODATA_SEC ".str");
-}
-
-static bool map_data_goes_to_arena(const struct bpf_object *obj, const struct bpf_map *map)
-{
-	int i;
-
-	switch (map->libbpf_type) {
-	case LIBBPF_MAP_DATA:
-	case LIBBPF_MAP_BSS:
-		return true;
-	case LIBBPF_MAP_RODATA:
-		break;
-	default:
-		return false;
-	}
-
-	/*
-	 * Const strings that kfuncs and helpers take have to be in a frozen
-	 * map. Pointers to them that are stored in data point to a copy of
-	 * the strings that is in arena.
-	 */
-	if (map_is_const_str(map))
-		return true;
-	/*
-	 * Read-only data with pointers stays a frozen map: the kernel
-	 * recognizes pointers to functions in it.
-	 */
-	if (str_has_pfx(map->real_name, DATA_REL_RO_SEC))
-		return false;
-	for (i = 0; i < obj->efile.sec_cnt; i++) {
-		const struct elf_sec_desc *sec = &obj->efile.secs[i];
-
-		if (sec->sec_type == SEC_RELO && sec->shdr->sh_info == map->sec_idx)
-			return false;
-	}
-	return true;
-}
-
-/* Returns the offset of the data of the map in arena data that is sz bytes so far */
-static size_t map_arena_off(const struct bpf_object *obj, const struct bpf_map *map, size_t sz)
-{
-	size_t align = obj->efile.secs[map->sec_idx].shdr->sh_addralign;
-
-	return roundup(sz, max(align, sizeof(__u64)));
-}
-
-/*
- * Make .data, .bss and .rodata a part of arena data. They follow __arena
- * variables of the object, if there are any.
- */
-static int bpf_object__init_arena_data(struct bpf_object *obj)
-{
-	const size_t page_sz = sysconf(_SC_PAGE_SIZE);
-	size_t sz = obj->arena_data_sz;
-	struct bpf_map *map;
-	void *data;
-	int i;
-
-	if (!obj->data_in_arena)
-		return 0;
-
-	for (i = 0; i < obj->nr_maps; i++) {
-		map = &obj->maps[i];
-		if (map_data_goes_to_arena(obj, map))
-			sz = map_arena_off(obj, map, sz) + map->def.value_size;
-	}
-	if (sz == obj->arena_data_sz)
-		return 0;
-
-	if (obj->arena_map_idx < 0) {
-		/* bpf_object__init_user_btf_maps() didn't look: there is no .maps section */
-		if (obj->efile.arena_data) {
-			pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
-				ARENA_SEC);
-			return -ENOENT;
-		}
-
-		map = bpf_object__add_map(obj);
-		if (IS_ERR(map))
-			return PTR_ERR(map);
-
-		map->real_name = strdup("arena");
-		map->name = strdup("arena");
-		if (!map->real_name || !map->name) {
-			zfree(&map->real_name);
-			zfree(&map->name);
-			return -ENOMEM;
-		}
-		map->sec_idx = -1;
-		map->def.type = BPF_MAP_TYPE_ARENA;
-		map->def.max_entries = roundup(sz, page_sz) / page_sz;
-		map->def.map_flags = BPF_F_MMAPABLE;
-		obj->arena_map_idx = map - obj->maps;
-	}
-
-	data = realloc(obj->arena_data, sz);
-	if (!data)
-		return -ENOMEM;
-	memset(data + obj->arena_data_sz, 0, sz - obj->arena_data_sz);
-	sz = obj->arena_data_sz;
-	obj->arena_data = data;
-	obj->maps[obj->arena_map_idx].mmaped = data;
-
-	for (i = 0; i < obj->nr_maps; i++) {
-		map = &obj->maps[i];
-		if (!map_data_goes_to_arena(obj, map))
-			continue;
-		sz = map_arena_off(obj, map, sz);
-		map->arena_off = sz;
-		memcpy(data + sz, map->mmaped, map->def.value_size);
-		sz += map->def.value_size;
-		pr_debug("map '%s': data is in arena at offset %zu\n", map->name, map->arena_off);
-		if (map_is_const_str(map)) {
-			map->arena_copy = true;
-			continue;
-		}
-		munmap(map->mmaped, bpf_map_mmap_sz(map));
-		/* make bpf_map__initial_value() and bpf_map__set_initial_value() work */
-		map->mmaped = data + map->arena_off;
-		map->autocreate = false;
-		map->in_arena = true;
-	}
-	obj->arena_data_sz = sz;
-	return 0;
-}
-
 static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 					  const char *pin_root_path)
 {
@@ -3348,7 +3179,6 @@ static int bpf_object__init_maps(struct bpf_object *obj,
 	err = err ?: bpf_object__init_global_data_maps(obj);
 	err = err ?: bpf_object__init_kconfig_map(obj);
 	err = err ?: bpf_object_init_struct_ops(obj);
-	err = err ?: bpf_object__init_arena_data(obj);
 
 	return err;
 }
@@ -4163,11 +3993,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		if (!sh)
 			return -LIBBPF_ERRNO__FORMAT;
 
-		/* the second pass has to know it when it sees relocations of data */
-		name = elf_sec_str(obj, sh->sh_name);
-		if (name && strcmp(name, ARENA_DATA_SEC) == 0)
-			obj->data_in_arena = true;
-
 		if (sh->sh_type == SHT_SYMTAB) {
 			if (obj->efile.symbols) {
 				pr_warn("elf: multiple symbol tables in %s\n", obj->path);
@@ -4284,8 +4109,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, ARENA_SEC) == 0) {
 				obj->efile.arena_data = data;
 				obj->efile.arena_data_shndx = idx;
-			} else if (strcmp(name, ARENA_DATA_SEC) == 0) {
-				/* the marker, see the first pass */
 			} else if (strcmp(name, JUMPTABLES_SEC) == 0) {
 				obj->jumptables_data = malloc(data->d_size);
 				if (!obj->jumptables_data)
@@ -4310,9 +4133,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			 * have pointers to functions.
 			 */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
-			    !(obj->data_in_arena &&
-			      (!strcmp(name, ".rel" DATA_SEC) ||
-			       str_has_pfx(name, ".rel" DATA_SEC "."))) &&
 			    strcmp(name, ".rel" RODATA_SEC) &&
 			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
 			    strcmp(name, ".rel" DATA_REL_RO_SEC) &&
@@ -5064,10 +4884,6 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	reloc_desc->insn_idx = insn_idx;
 	reloc_desc->map_idx = map_idx;
 	reloc_desc->sym_off = sym->st_value;
-	if (map->in_arena) {
-		reloc_desc->map_idx = obj->arena_map_idx;
-		reloc_desc->sym_off += map->arena_off;
-	}
 	return 0;
 }
 
@@ -5286,9 +5102,6 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
-	if (map->in_arena)
-		return libbpf_err(-EOPNOTSUPP);
-
 	map->autocreate = autocreate;
 	return 0;
 }
@@ -5569,45 +5382,6 @@ bpf_object__reuse_map(struct bpf_map *map)
 	return 0;
 }
 
-static struct bpf_map *bpf_object__sec_map(struct bpf_object *obj, int sec_idx)
-{
-	int i;
-
-	for (i = 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_internal(&obj->maps[i]) && obj->maps[i].sec_idx == sec_idx)
-			return &obj->maps[i];
-	return NULL;
-}
-
-static int bpf_object__mmap_arena(struct bpf_object *obj, struct bpf_map *map)
-{
-	int i, err;
-
-	map->mmaped = mmap((void *)(long)map->map_extra,
-			   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
-			   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
-			   map->fd, 0);
-	if (map->mmaped == MAP_FAILED) {
-		err = -errno;
-		map->mmaped = NULL;
-		pr_warn("map '%s': failed to mmap arena: %s\n",
-			map->name, errstr(err));
-		return err;
-	}
-	if (obj->arena_data) {
-		memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
-			obj->arena_data_sz);
-		zfree(&obj->arena_data);
-	}
-	for (i = 0; i < obj->nr_maps; i++) {
-		struct bpf_map *m = &obj->maps[i];
-
-		if (m->in_arena)
-			m->mmaped = map->mmaped + obj->arena_data_off + m->arena_off;
-	}
-	return 0;
-}
-
 static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
@@ -5968,10 +5742,6 @@ bpf_object__create_maps(struct bpf_object *obj)
 			continue;
 		}
 
-		/* see bpf_object__relocate_data_ptrs() */
-		if (map->def.type == BPF_MAP_TYPE_ARENA && obj->arena_mapped)
-			continue;
-
 		err = map_set_def_max_entries(map);
 		if (err)
 			goto err_out;
@@ -6009,9 +5779,22 @@ bpf_object__create_maps(struct bpf_object *obj)
 				if (err < 0)
 					goto err_out;
 			} else if (map->def.type == BPF_MAP_TYPE_ARENA) {
-				err = bpf_object__mmap_arena(obj, map);
-				if (err)
+				map->mmaped = mmap((void *)(long)map->map_extra,
+						   bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
+						   map->map_extra ? MAP_SHARED | MAP_FIXED : MAP_SHARED,
+						   map->fd, 0);
+				if (map->mmaped == MAP_FAILED) {
+					err = -errno;
+					map->mmaped = NULL;
+					pr_warn("map '%s': failed to mmap arena: %s\n",
+						map->name, errstr(err));
 					return err;
+				}
+				if (obj->arena_data) {
+					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
+						obj->arena_data_sz);
+					zfree(&obj->arena_data);
+				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
 				err = init_map_in_map_slots(obj, map);
@@ -8026,81 +7809,6 @@ static int bpf_program_fixup_func_info(struct bpf_object *obj, struct bpf_progra
 	return err;
 }
 
-/*
- * Turn pointers to data that are stored in data into addresses of arena.
- * The arena is created here, ahead of the other maps: the address has to be
- * known before the maps that hold the pointers are created.
- */
-static int bpf_object__relocate_data_ptrs(struct bpf_object *obj)
-{
-	struct bpf_map *arena, *map, *targ;
-	__u64 addr, val;
-	size_t i;
-	int err;
-
-	if (!obj->data_ptr_cnt)
-		return 0;
-
-	for (i = 0; i < obj->data_ptr_cnt; i++) {
-		struct data_ptr *p = &obj->data_ptrs[i];
-
-		if (p->targ_sec_idx < 0)
-			continue;
-		map = bpf_object__sec_map(obj, p->sec_idx);
-		targ = bpf_object__sec_map(obj, p->targ_sec_idx);
-		if (map && (map->in_arena || map->autocreate) &&
-		    (!targ || (!targ->in_arena && !targ->arena_copy))) {
-			pr_warn("sec '%s': pointer to '%s' at offset %zu can't be resolved: sec '%s' is not in arena\n",
-				map->real_name, p->sym_name, p->sec_off,
-				targ ? targ->real_name : "<?>");
-			return -LIBBPF_ERRNO__RELOC;
-		}
-	}
-
-	if (obj->gen_loader) {
-		pr_warn("pointers to data in data are not supported by light skeleton\n");
-		return -ENOTSUP;
-	}
-
-	if (obj->arena_map_idx < 0)
-		return 0;
-
-	arena = &obj->maps[obj->arena_map_idx];
-	if (!arena->autocreate)
-		return 0;
-	/* libbpf doesn't mmap an arena that it didn't create, so the address is not known */
-	if (arena->reused || arena->pin_path) {
-		pr_warn("map '%s': pointers to data in data are not supported with pinned or reused arena\n",
-			arena->name);
-		return -ENOTSUP;
-	}
-
-	err = bpf_object__create_map(obj, arena, false);
-	err = err ?: bpf_object__mmap_arena(obj, arena);
-	if (err) {
-		pr_warn("map '%s': failed to create: %s\n", arena->name, errstr(err));
-		return err;
-	}
-	obj->arena_mapped = true;
-
-	for (i = 0; i < obj->data_ptr_cnt; i++) {
-		struct data_ptr *p = &obj->data_ptrs[i];
-
-		map = bpf_object__sec_map(obj, p->sec_idx);
-		if (!map || (!map->in_arena && !map->autocreate))
-			continue;
-
-		addr = (__u64)(unsigned long)arena->mmaped + obj->arena_data_off + p->targ_off;
-		if (p->targ_sec_idx >= 0)
-			addr += bpf_object__sec_map(obj, p->targ_sec_idx)->arena_off;
-
-		memcpy(&val, map->mmaped + p->sec_off, sizeof(val));
-		val += addr;
-		memcpy(map->mmaped + p->sec_off, &val, sizeof(val));
-	}
-	return 0;
-}
-
 static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
@@ -8123,10 +7831,8 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		size_t mmap_sz = bpf_map_mmap_sz(arena_map);
 
 		if (data_sz > mmap_sz) {
-			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global %s of size %zu\n",
-				arena_map->name, mmap_sz,
-				obj->data_in_arena ? "data" : "__arena variables",
-				obj->arena_data_sz);
+			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global __arena variables of size %zu\n",
+				arena_map->name, mmap_sz, obj->arena_data_sz);
 			return -E2BIG;
 		}
 
@@ -8135,10 +7841,6 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 			obj->arena_data_off = mmap_sz - data_sz;
 	}
 
-	err = bpf_object__relocate_data_ptrs(obj);
-	if (err)
-		return err;
-
 	/* Before relocating calls pre-process relocations and mark
 	 * few ld_imm64 instructions that points to subprogs.
 	 * Otherwise bpf_object__reloc_code() later would have to consider
@@ -8371,85 +8073,12 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	return 0;
 }
 
-/*
- * A pointer to data that is stored in data. When data is in arena
- * the program dereferences what it loads from data, so the pointer has
- * to be the address of the target in arena.
- */
-static int bpf_object__collect_data_ptr(struct bpf_object *obj, const char *relo_sec_name,
-					int relo_idx, size_t sec_idx, const Elf64_Rel *rel,
-					const Elf64_Sym *sym)
-{
-	Elf_Data *scn_data = obj->efile.secs[sec_idx].data;
-	const char *sym_name = elf_sym_str(obj, sym->st_name) ?: "<?>";
-	struct data_ptr *ptrs;
-
-	if (ELF64_ST_TYPE(sym->st_info) == STT_SECTION && sym->st_shndx < obj->efile.sec_cnt)
-		sym_name = elf_sec_name(obj, elf_sec_by_idx(obj, sym->st_shndx)) ?: "<?>";
-
-	if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
-	    sym->st_shndx >= obj->efile.sec_cnt ||
-	    (sym->st_shndx != obj->efile.arena_data_shndx &&
-	     !bpf_object__shndx_is_data(obj, sym->st_shndx)) ||
-	    rel->r_offset >= scn_data->d_size ||
-	    scn_data->d_size - rel->r_offset < sizeof(__u64)) {
-		pr_warn("sec '%s': relo #%d: can't resolve pointer to '%s' at offset %zu when data is in arena\n",
-			relo_sec_name, relo_idx, sym_name, (size_t)rel->r_offset);
-		return -LIBBPF_ERRNO__RELOC;
-	}
-
-	ptrs = libbpf_reallocarray(obj->data_ptrs, obj->data_ptr_cnt + 1, sizeof(*ptrs));
-	if (!ptrs)
-		return -ENOMEM;
-	obj->data_ptrs = ptrs;
-
-	ptrs[obj->data_ptr_cnt].sec_idx = sec_idx;
-	ptrs[obj->data_ptr_cnt].sec_off = rel->r_offset;
-	/* __arena variables are at the start of arena data */
-	ptrs[obj->data_ptr_cnt].targ_sec_idx =
-		sym->st_shndx == obj->efile.arena_data_shndx ? -1 : sym->st_shndx;
-	ptrs[obj->data_ptr_cnt].targ_off = sym->st_value;
-	ptrs[obj->data_ptr_cnt].sym_name = strdup(sym_name);
-	if (!ptrs[obj->data_ptr_cnt].sym_name)
-		return -ENOMEM;
-	obj->data_ptr_cnt++;
-
-	pr_debug("sec '%s': relo #%d: pointer at offset %zu to '%s'\n",
-		 relo_sec_name, relo_idx, (size_t)rel->r_offset, sym_name);
-	return 0;
-}
-
-/* Collect pointers in a data section that went to arena */
-static int bpf_object__collect_data_relos(struct bpf_object *obj,
-					  Elf64_Shdr *shdr, Elf_Data *data)
-{
-	int i, err, nrels = shdr->sh_size / shdr->sh_entsize;
-	const char *relo_sec_name;
-	Elf64_Sym *sym;
-	Elf64_Rel *rel;
-
-	relo_sec_name = elf_sec_str(obj, shdr->sh_name) ?: "<?>";
-	for (i = 0; i < nrels; i++) {
-		rel = elf_rel_by_idx(data, i);
-		sym = rel ? elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info)) : NULL;
-		if (!sym) {
-			pr_warn("sec '%s': failed to get relo #%d\n", relo_sec_name, i);
-			return -LIBBPF_ERRNO__FORMAT;
-		}
-		err = bpf_object__collect_data_ptr(obj, relo_sec_name, i, shdr->sh_info, rel, sym);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 /*
  * Collect pointers to functions in a read-only data section. They are
  * R_BPF_64_ABS64 relocations against .text section, where the offset of
  * a static function in the section is stored in place. Relocations in data
  * sections were ignored before pointers to functions were supported. Those
- * that are something else, e.g. pointers to data, still are, unless data
- * is in arena.
+ * that are something else, e.g. pointers to data, still are.
  */
 static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
@@ -8485,15 +8114,6 @@ static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 
 		if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
 		    !sym_is_subprog(sym, obj->efile.text_shndx)) {
-			int err;
-
-			if (obj->data_in_arena) {
-				err = bpf_object__collect_data_ptr(obj, relo_sec_name, i,
-								   sec_idx, rel, sym);
-				if (err)
-					return err;
-				continue;
-			}
 			pr_debug("sec '%s': relo #%d: not a pointer to a function, skipping...\n",
 				 relo_sec_name, i);
 			continue;
@@ -8569,8 +8189,6 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 
 		if (obj->efile.secs[idx].sec_type == SEC_RODATA)
 			err = bpf_object__collect_rodata_relos(obj, shdr, data);
-		else if (obj->efile.secs[idx].sec_type == SEC_DATA)
-			err = bpf_object__collect_data_relos(obj, shdr, data);
 		else if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
@@ -8914,9 +8532,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	}
 	load_attr.log_level = log_level;
 	load_attr.prog_flags = prog->prog_flags;
-	/* the program accesses its data in arena through plain numbers */
-	if (obj->data_in_arena)
-		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
 	err = bpf_object__bind_arena(obj, prog, &load_attr);
 	if (err)
@@ -8991,7 +8606,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 
 			for (i = 0; i < obj->nr_maps; i++) {
 				map = &prog->obj->maps[i];
-				if (map->libbpf_type != LIBBPF_MAP_RODATA || map->in_arena)
+				if (map->libbpf_type != LIBBPF_MAP_RODATA)
 					continue;
 
 				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
@@ -10557,7 +10172,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	zfree(&map->init_slots);
 	map->init_slots_sz = 0;
 
-	if (map->mmaped && map->mmaped != map->obj->arena_data && !map->in_arena)
+	if (map->mmaped && map->mmaped != map->obj->arena_data)
 		munmap(map->mmaped, bpf_map_mmap_sz(map));
 	map->mmaped = NULL;
 
@@ -10642,9 +10257,6 @@ void bpf_object__close(struct bpf_object *obj)
 			close(obj->func_ptr_maps[i].fd);
 	zfree(&obj->func_ptr_maps);
 	zfree(&obj->func_ptrs);
-	for (i = 0; i < obj->data_ptr_cnt; i++)
-		zfree(&obj->data_ptrs[i].sym_name);
-	zfree(&obj->data_ptrs);
 
 	if (obj->btf_module_allowlist) {
 		for (i = 0; i < obj->btf_module_allowlist_cnt; i++)
@@ -11011,8 +10623,6 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
-	if (obj->data_in_arena)
-		attr.prog_flags |= BPF_F_ARENA_SCALAR;
 
 	prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
 	if (!prog_btf_fd && obj->btf)
@@ -12019,9 +11629,6 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
-	if (map->in_arena)
-		return libbpf_err(-EOPNOTSUPP);
-
 	if (map->mmaped) {
 		size_t mmap_old_sz, mmap_new_sz;
 		int err;
-- 
2.55.0

