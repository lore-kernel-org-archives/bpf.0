Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755480;
	b=1YzUzWlSy0UX6y3rSAZqFKaDQo2WhlMhJRO2GruM/MLe3SCkyBG5Br66jPvYnM4WRF1A
	 Ukpj+g5Pc5b1a5otUe49rf65mJiXKH9DQNrLjg52Bl3IlDqIMXLUkKlezcLsgN04/Y1U8
	 l7YnD4rBnxeqq/e/bLXplyMgF2GcMrxkKuSOpws3fCbpNHb3YjV4ES+5Id53icZ3E1i1r
	 cuRciKsk4rFMzCMvhf16E/ZiF4uPfFsAHSY/VURbFu3fXq6UvRHvEQ5Bu2Jtycx1tZYGm
	 q72IfckV8a2c/TC3w8BfhJK6w5hi/jN+2B3glLNdQ9KgooLCn35zw4HQ87IIgNTxlvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
	b=hCsbSHVhhAy6xUYWRqs8YWvHW/7PGOZiAnchyY5PZqtMvHM0eRII9sN7RTQnbIwjmBNy
	 9resBnj3D3bEjJyhcj0e/gvyQPKm5bLRvrumPTYR0blcSgCU409ZOfRUfUBmKToCY8Rd+
	 tCd9MXXAI630UbblQu5/qpPwBnyVqktopUrvqQyWjcfHSwsWHp+89I+JpVC56yYYdPAmQ
	 +dGq/mzOkQpf7Nd65cRae9x+/nTXIsH0rCfDI8V373fId4lM4HvkSaZE7q6DqLSouExg0
	 GMLvC0jH7GMmzye+5fv6ZxZyW4m2qI2rBLUP+8Bd3SCIICbyrEmEmcN3Plfd63jfwew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=frubd9Mm;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FD606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D04FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=frubd9Mm
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e98798cbddso778985ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755479; x=1794360279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
        b=frubd9MmJY31RjJjNH2Wqec2LNKtzyRtLtZ9DmDf6TUhq+MeXN4eZ6Gz4a10AyzrPW
         2vzBOHhVaKOXG2prA9a9vXrajji4qeq15GyAkeDbwDhBJwkcp2w7iFr67JD63eHwSXiF
         I9NEyHGuqUFNDS4fHOHd0fz4pf3ZVrZ+Gc8kMt/0AKk5MW2ktNYVEKXpAXy2ihABjmZ5
         22RzI5bnsLgFfKL8EPzFKLRh9I9efRf0QQ/vFSTTbrMJZ9Q3cWjJtHWfNWJ/HzZQ+qcD
         1k+WRkJNBY0YkGgm4JgL9Vrgut/VbLzG2pVfilL5zhc3IXm/7SNk2joeZm+9YrS4Amlk
         Mriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755479; x=1794360279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
        b=12TafUGADmtJ5/VnLU6q+hwMQ7QYB22PkYhQkmXmr5eKgA7TjyTBgwchVRcKNqJ2yh
         3YRqDzml6t/ia6KvtNNQYGHwTXU5tVCKQ0f6X/VOHB6lr7iYog4sA9ycB3+WubSO0KbE
         RaUDk8AnR1zgOgwTSXTl2flcdursYTRQO5n07Q4sGaD8icq/ZU3C1Nm1wJdzs/0+vNJ4
         6FQCkbAChS/+a/lkmAAAUmqHCv59bo29OdqB6lxMnjU3SD2duGD2j6ka+lWTRRa/RqxP
         cujtdsk0yF4git1adhg+ugzMj+ih6jAYE9Oia8wBReAje5lPnahNmo+z8OGEQvcGjWBw
         4MoQ==
X-Gm-Message-State: APuU4Z81EuaOLX3GSF3yeu8WCaX9+CiaV/i9ipRP/v/tEyWjmcrjJTq5
	8QO3i2ybN7y6JaHgQVelBY29TnD/GVvjc4dFaAx8j8K72EJD7uSxLkcm8MYppA==
X-Gm-Gg: AYBFou2zMGZ6wbGsWnO0RQp0/5ZLx3fnYSK1h0rkltxXDkTT8/g2aJB5CQJCbMowsVi
	BRvDeaIgoXgjMMeuwiYs1bKgGUGnO2fg46yIi+jrOGau/XXIRpE5/WijJnTMR/qyY+f4cIGj0yA
	NgacGl6c9FgLUdGU0Ku3s8Gc7cqN0weRc5rfa8+ngKzTFhcDTffSs8wOBH1b1mUWQINawZR+A54
	pc035bE4QRBL/ExqMlGAkbbiH79oIaYA+ZRZJ7P5CPfY3cCYyzEmXWYa337onxCv3kHnUd0fhQQ
	/jDajed4pnGGXaH7d5CrUvasQ1zw1tau5zEXK2z9xzJV6TRDMRB7agClUirV8Oj6qvgI2K6V63S
	IDuABCDZhckLD2Rs6ufBBXTrO6BD1LSJeDx1nWSAoOYfUqKoD80rqWRJktXvqCyEGhFSGoxB9tG
	L/85k8H5qB8fVX782Wz/DTG+bdGBAG4q6AJtOJczWZXqwDy46717dAwljJ/8aDS456tC/o+6aiO
	rS1zZ55OnZy82xtAov8QRRub17iEt3ddz8pVSOjpybryTnVDdkFwJ7TO+0ie7NBjDyS0ujnBDbY
	UGgzIVLOX8WZTldqt3Y4zV15LltyPlgS9i7w/3P0cYEogpUpwIcyJQyOwe9HzNCMNFSL9OjqXRf
	gpufFtjds6SLbsvdkVqFkyFfzR7/rI1kEFZA5f6zRjvHNVNoyqUgkawK0P8u/55D3kEodvcr1BA
	==
X-Received: by 2002:a17:903:3848:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2eb364ddf03mr127084075ad.47.1793755478940;
        Tue, 03 Nov 2026 17:24:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe1e4dsm772315ad.21.2026.11.03.17.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are stored in arena
Date: Wed,  4 Nov 2026 01:23:52 +0000
Message-ID: <20261104012401.1354861-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

A variable in arena that points to a different variable in arena gets an
incorrect value:

  int __arena x = 42;
  int __arena * __arena px = &x;

The compiler emits an R_BPF_64_ABS64 relocation for px. libbpf ignores the
relocations of .addr_space.1. The object loads without an error, and px is
0.

The address of x is not known until libbpf maps the arena. Thus libbpf does
the work in two steps:
 - At open it records where each such pointer is and which variable it
   points to.
 - At load it maps the arena, copies the variables, and adds the address of
   the variable to each pointer.

The pointer gets the address in user space. The prog can use the same
value, because an access to arena from a prog uses only the low 32 bits.

A pointer in arena to a variable that is not in arena has no correct value.
Fail the open.

For a pointer to a static variable the relocation refers to the section,
and the offset of the variable is stored in place. The static linker
rejects such a relocation in a data section. Make it add the new offset of
the section, as it does for pointers to static functions. All pointers in
the arena data of Rust objects have this form.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 83 +++++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/linker.c | 10 +++--
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a7c53dc5b91d..1172fe7992bf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -797,6 +797,12 @@ struct bpf_object {
 	size_t arena_data_sz;
 	size_t arena_data_off;
 	size_t arena_bss_off; /* from the start of arena_data */
+	/* pointers to variables in arena that are stored in variables in arena */
+	struct arena_ptr {
+		size_t off;	 /* where the pointer is, from the start of arena_data */
+		size_t targ_off; /* the symbol it points to, from the start of arena_data */
+	} *arena_ptrs;
+	size_t arena_ptr_cnt;
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -4171,10 +4177,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 
 			/*
 			 * Only do relo for section with exec instructions,
-			 * struct_ops, maps, and read-only data that might
-			 * have pointers to functions.
+			 * struct_ops, maps, read-only data that might
+			 * have pointers to functions, and arena.
 			 */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
+			    strcmp(name, ".rel" ARENA_SEC) &&
 			    strcmp(name, ".rel" RODATA_SEC) &&
 			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
 			    strcmp(name, ".rel" DATA_REL_RO_SEC) &&
@@ -5430,6 +5437,21 @@ bpf_object__reuse_map(struct bpf_map *map)
 	return 0;
 }
 
+/* The arena is mapped. The address of a variable is the same for the program and for user space. */
+static void relocate_arena_ptrs(struct bpf_object *obj, const struct bpf_map *arena)
+{
+	void *data = arena->mmaped + obj->arena_data_off;
+	struct arena_ptr *p = obj->arena_ptrs;
+	__u64 val;
+	size_t i;
+
+	for (i = 0; i < obj->arena_ptr_cnt; i++, p++) {
+		memcpy(&val, data + p->off, sizeof(val));
+		val += (__u64)(unsigned long)data + p->targ_off;
+		memcpy(data + p->off, &val, sizeof(val));
+	}
+}
+
 static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
@@ -5856,6 +5878,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
 						obj->arena_data_sz);
 					zfree(&obj->arena_data);
+					relocate_arena_ptrs(obj, map);
 				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
@@ -8223,6 +8246,59 @@ static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 	return 0;
 }
 
+/*
+ * Collect pointers that are stored in variables in arena, like
+ *   int __arena * __arena p = &var;
+ * They are R_BPF_64_ABS64 relocations. The addend is stored in place.
+ */
+static int bpf_object__collect_arena_relos(struct bpf_object *obj,
+					   Elf64_Shdr *shdr, Elf_Data *data)
+{
+	int i, nrels = shdr->sh_size / shdr->sh_entsize;
+	struct arena_ptr *ptrs;
+	const char *sym_name;
+	size_t sym_idx;
+	Elf64_Sym *sym;
+	Elf64_Rel *rel;
+
+	ptrs = libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
+	if (!ptrs)
+		return -ENOMEM;
+	obj->arena_ptrs = ptrs;
+
+	for (i = 0; i < nrels; i++, ptrs++) {
+		rel = elf_rel_by_idx(data, i);
+		if (!rel) {
+			pr_warn("sec '.rel%s': failed to get relo #%d\n", ARENA_SEC, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+
+		sym_idx = ELF64_R_SYM(rel->r_info);
+		sym = elf_sym_by_idx(obj, sym_idx);
+		if (!sym) {
+			pr_warn("sec '.rel%s': symbol #%zu not found for relo #%d\n",
+				ARENA_SEC, sym_idx, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+
+		if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
+		    (sym->st_shndx != obj->efile.arena_data_shndx &&
+		     sym->st_shndx != obj->efile.arena_bss_shndx)) {
+			sym_name = elf_sym_str(obj, sym->st_name) ?: "<?>";
+			pr_warn("sec '%s': pointer to '%s' at offset %zu: it's not in arena\n",
+				ARENA_SEC, sym_name, (size_t)rel->r_offset);
+			return -LIBBPF_ERRNO__RELOC;
+		}
+
+		ptrs->off = rel->r_offset;
+		ptrs->targ_off = sym->st_value;
+		if (sym->st_shndx == obj->efile.arena_bss_shndx)
+			ptrs->targ_off += obj->arena_bss_off;
+		obj->arena_ptr_cnt++;
+	}
+	return 0;
+}
+
 static int cmp_func_ptrs(const void *_a, const void *_b)
 {
 	const struct func_ptr *a = _a;
@@ -8263,6 +8339,8 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
+		else if (idx == obj->efile.arena_data_shndx)
+			err = bpf_object__collect_arena_relos(obj, shdr, data);
 		else
 			err = bpf_object__collect_prog_relos(obj, shdr, data);
 		if (err)
@@ -10384,6 +10462,7 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->token_fd);
 
 	zfree(&obj->arena_data);
+	zfree(&obj->arena_ptrs);
 
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz = 0;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index dba88f4fd6cd..d537388d495c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2291,12 +2291,14 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 					else
 						insn->imm += sec->dst_off;
 				} else if (sym_type == R_BPF_64_ABS64 &&
-					   (sec->shdr->sh_flags & SHF_EXECINSTR)) {
+					   ((sec->shdr->sh_flags & SHF_EXECINSTR) ||
+					    !strcmp(src_linked_sec->sec_name, ".addr_space.1"))) {
 					/*
 					 * A pointer to a static function in a data section,
-					 * which is stored in place as an offset of the
-					 * function in its section. Data sections are kept
-					 * in the byte order of the object.
+					 * or a pointer in arena to a static variable. It's
+					 * stored in place as an offset of the function or
+					 * the variable in its section. Data sections are
+					 * kept in the byte order of the object.
 					 */
 					void *ptr = dst_linked_sec->raw_data + dst_rel->r_offset;
 					__u64 off;
-- 
2.55.0

