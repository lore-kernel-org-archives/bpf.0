Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983711;
	b=QIsDU4ZlA/uNxewd0t3LZRILqpwOSYHzU2QCI4FEGNfadb5Rk0tknOSysSRWSGjDG/GH
	 8VVsYa91wGJ9Jnt86xIW0TjZdBa2vLLE9TojO18J1C2ADlqRYlmGgVweWprnvl6bTLQML
	 ZLzMgMCZ58VzYx5wbGRVEkzRw3cC1YNtjpVLK32ky0vGlgmUaOMmpzh+5snC2i5q5H2sW
	 gjgmhEC++LEQdfu36mcQqVb9MaBKRPD2rQygks/Q+PmDaUZmXPWAE8rrdB60mdiZIOYBx
	 DZv64VKMvmA2Qsg18xHtPKkJTQ5B/UXXy7Q4x84Gl4V8JgkTAq54CY6iNrkmlA5AVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yP2PzbTWq6OuIWSOKTMTMrNX5Hot8fZACdbPnRwlFfc=;
	b=v8eBX8qGj+jDSW/aRsv8tZxt7QFs5i+qjzL51UnsfIQh1mhN7xd1iDQGhzZ+EA4euiPN
	 XCKfxbksuCW9Sq7lgYi0y+c42Gym2BycrJHyOFDxRde1ghIr6aAdm9arCRXQuh3oyYAUm
	 upQLPkeaQYGeOLhKrr+Fi5YmFwhCMhzRzq/iBzy2gOwvj4jm/ieABzYPn2RoLJ8h35wDW
	 gFk4QXmr91u+Q3yrfXcAYqe/U25IzhSN/OH+aDoybJT7IzVh5n7txnEaJBd8LZ0jUxu7X
	 Q5RIW0yiVk3tpHeGhUGd/HrETaDNMLmgtu1HWo9ujqJgyDBmsYob0INu6cw1jWpno/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqqwGW1Y;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065A606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C065A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqqwGW1Y
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1484140a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983710; x=1793588510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yP2PzbTWq6OuIWSOKTMTMrNX5Hot8fZACdbPnRwlFfc=;
        b=VqqwGW1YKMehx7rrwV6bLzp24mUFWJAhBvsTCY5C/UXd7OK3It9PS0KxqYuPjzGjIu
         23uDn/JaXCltg3J4gtXefwETOjZbsv3/qWqf7JbaqcKT1gFtFSdjghJzrWgULY5pQ9JN
         liqiSEUFKGU/gcI5IW2IBxY0nbjRIVcFqmSptct9n9Z7Zjo7dYW4sQIfW6pggOZ7o31T
         d3LV1+/1vDdw2OQyyCDN4MI55Z7cEiuLGftrlKAk21X98aC3uqyUcWZzmgd+EZ/A57pk
         4o1zEj713pWAk6v7vcM0RvDbOjWx3fcCG3ePnuINClHlB+kkFV8EAeqlVltBvT+dCw4U
         TzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983710; x=1793588510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yP2PzbTWq6OuIWSOKTMTMrNX5Hot8fZACdbPnRwlFfc=;
        b=Fuzow96Aa9AI1sLVfdP8a3mkOMMzUX/5EbTHpOQOhVhlDyDW92um0OSll7zSOP+O7X
         Dm7p/6wPjQzKWihYNRQh2UIFH/gs+Spw0Hu6+zuQ9PzqJNM3/pvNozMGKsWXnat0KY+h
         87hZf7qYWLC9JeMmzQxmpBJqrKtsC1EqPHsap4IwDafi7h7YvGkcK7CBQ9yQPM+RVPRd
         /Fm2BRJCBPZIV4ZRJ2bQv5l4PWNqNAhsQhkVF/HIvrBjdSVJCV7zcIAjVY/ZggqeJtUo
         pldpHDs/7HZtT38w3S0bit14zp6bMf/jYPNfVMVsXf4AE7zjfMmvrZLP5vevKQID/jjX
         C0zA==
X-Gm-Message-State: AFq9FYKMTJC6OtODerQS2HAHgGPhTL/zDIbikIICsr3C/Bi+tZBxlmHy
	6la6gdQtVsuNiKaOXRylm/Ah/FDxnzyRSM0zeXUBqOFwrLa+vMC06a9D4aO2iw==
X-Gm-Gg: AYBFou0wftp+1v1KNRNl2ybsCphOkWf9oWlWAkVD0HD1CSYUNHGDg98s0jG0Zs+W2kV
	uvk/3fnMd0yNGwYPRMqoOMAGdtw7aOsdbW/QiMJGtbwULKWT3eDTwnr90rxt2P9hQ1uSasDk+RO
	8BYkRK76TR8h6HDpvmjpjuJ2G5orULgtDaAfMfTI3uk4TevuMAPBICs3Z1sKT7QPc/4ktOsYo52
	iQMkZqnWTot1WlsOZkDJEsX7/id3rUeyB+sLckMi8p98QzyZSn4VaOktxoVhbDJ37N0cEeorKn2
	9mSEP2goYzPTmdESFTZ/LX9qb6ii7ws8ZNCNhAqOF6wPsXBPC9BNebVpj/8VjMNs7e1RluKcDk5
	FU5HdcJAgbc5/AWO+CcimqNcyDOmjGT6cCOi1eOMWupqqwy5/pvrYPsSRPLTc4rFRNvJ4k9pMPM
	E1IXMh5a4vZAQGmYusrI/8v6BheQYES6jgf2e2L6m2uKwEZPUPtUm3VJJuL6vagDPcafe/1xCNf
	m5IIlT8RGCmRVuGjtrIGTUH8i+CWDF2Gijzk0G1vxlOejWr3pKazgVdPbBGrMmZaEc1o48KHt8l
	tD288ZeApMPagJ29agc1/rO0umkUz5ff+JGAXty6cMWZ1478vsSE21am8i2Id8Ryu705ZpQnX0/
	qpcIkhkMjjm9nQAMIXRY2FjKxtdPIRtYjo6xQtRE/Bu1FlA==
X-Received: by 2002:a17:90b:17c9:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3adeaae62d3mr4888777a91.11.1792983709889;
        Sun, 25 Oct 2026 20:01:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm6246941a91.4.2026.10.25.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 21/81] libbpf: Relocate pointers that are stored in arena
Date: Mon, 26 Oct 2026 02:58:42 +0000
Message-ID: <20261026025943.404450-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 83 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 78ff9d653191..cc4a7d1f10da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -796,6 +796,12 @@ struct bpf_object {
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
@@ -4154,10 +4160,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 
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
@@ -5413,6 +5420,21 @@ bpf_object__reuse_map(struct bpf_map *map)
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
@@ -5825,6 +5847,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 					memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
 						obj->arena_data_sz);
 					zfree(&obj->arena_data);
+					relocate_arena_ptrs(obj, map);
 				}
 			}
 			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
@@ -8184,6 +8207,59 @@ static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
 	return 0;
 }
 
+/*
+ * Collect pointers that are stored in variables in arena, like
+ *   int __arena *p = &var;
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
@@ -8224,6 +8300,8 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
+		else if (idx == obj->efile.arena_data_shndx)
+			err = bpf_object__collect_arena_relos(obj, shdr, data);
 		else
 			err = bpf_object__collect_prog_relos(obj, shdr, data);
 		if (err)
@@ -10275,6 +10353,7 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->token_fd);
 
 	zfree(&obj->arena_data);
+	zfree(&obj->arena_ptrs);
 
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz = 0;
-- 
2.55.0

