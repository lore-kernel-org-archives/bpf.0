Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502349;
	b=yZ6JuiFnSqyDOLTlNJgvl/+ilxakzbFMaLZ3T6+I7Bnh1kqUduXRHn2CVyIiSB2STCTv
	 qYehcCq1IZ4Pz73Yd6CXy03xwAHeMC+qJjFi84/uk1Q2MfSdyRjzlLVYWab8ybGz5gB8G
	 HtqZINwGonHMQELSIEu4C47VQwYGCrxPR/3loBFglk73rvwYalqGZXMqZVPufXOsaz77P
	 RT306Y30/C3IEabAzg2vUMkUOARln6AmTD5pGEa2p+FFYYdkP783zgNQ3jZbrLVpISMVO
	 0ZHc2uptMKi7BRgL6AqAvqIvI/RPHBz2BnZjeSCuzv9w6aiHCSuIVEW477+VshwH7xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
	b=tx52ILSfmtI823kqVgsFPcQl25jz2L33HCQYGlUO6yTSVXo54fx+nPtFnuJb8cfGDUa0
	 MpXx5hRg2GoMRXEs47FJAAUGQ68ODJrXCF8Q+CVaY4YaXiOpAaNotVU/S8gRhvawXM0T8
	 AWfg68ANxe6MDSdvBSYkhrvf8ZM06mdqGHidVNptkF1F2f35Q0CEAHwgCSfVrWQSWY0PP
	 Qln6T3AzIoHaREEZ1CoG2kbBip9EtUs1Ta4srWk3whnCA+0E1Ypmq9xGi3jG3pUl2eREw
	 iE1TbG2I6d3vsADHNsqw0TtRiM7U0P7Eb478NLalb2CnJfAtWqpu4HLL52nPOGRxSNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1bzBVHU;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A7606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 219A7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1bzBVHU
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8b20a899fso13373615ad.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502348; x=1794107148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
        b=c1bzBVHUjSUWe1gzeSvaG5EBhLex3z7zYPvGjlQ2+mM/8i6P6eXy42T2WQnHAiuml3
         EPOLIuqF2fvgp2FEMUhmi/flrbnRGOAUoGLW6noRXYibI65Vwk9mua+qJwzqqROKqPUo
         OJ9Q9j5TYxalATPBvVYKrrLF0Hw3a7peuYjh1OCkszCJDr8htiv+4zfWHTgbL9Lj6keW
         nRjdrDMwn6cTkXorXG5rSKqkTwDipotLUXXlzOYgGLSj1+XaxyTBpzB1mMcBG3OPU9LY
         ywzuxYdTadz+du/SpjTB2qAo3vFhFcoVioqcRO9fS3rHUGFpfBYJqlxGSncr0eFpIghK
         nLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502348; x=1794107148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DBiMWG/JxvW22JGMQQRBhU95ba6t/rF6J+qCWDzSqko=;
        b=XqFY8NXJWImy+E/k9SjY2oKtZDBh+O18NmLNtree51030WS4ZG+T6Q0QX3xDLezTUW
         KeH/gsI2hIDaKg3VGIFsNxKnzPsyYcdFxAARzUYGQwHUkF+dHNnrl/vqA1PdrPWqK1N5
         AnjEWq02QNEC4tdpADTT3cm6b23XxxCs0quIirILGHLKpBWzuEqowUE+Fi4CP9I0e4sv
         UW+07TGZjtMZFZT+xJgzQOxcjFw4JVmoT5nhWEEKzbplzd10O2UH+z007i9jaBhuMbYc
         HzqrdiUe5yCTsc8t8eOUsOJNMyCDH9R7ydmhW6CnOOIVGKdw5fvC9D26gXFCNtKH5g7K
         GLQg==
X-Gm-Message-State: APuU4Z+NRdpGsfVDQnl0RrhwqRqrfF8O8UEFkmaihDGiXB+ugL2NdQM1
	rBM2zcoWfsW7QLbQdeGOwMC/B87ATtSdWEugEoc8rnn1uuP5RaUoVzy77RgmaA==
X-Gm-Gg: AYBFou0TWKZyV2jmtP6zJaqS8gXahEnmxd+2VUevIk3dpIOo4i/3FVPR2I+rS05CjAk
	kz7R7OJDN0+aFEqUy17rAnh4oxh1+/IMg6zCgG3+grT3RiE2owff7IypxEk/WjTts3gE0VpHVN2
	4ov8DnJqdfDjZnJM8rBFePvK8rNLHZW3oPocn6iS7O0aLYr8QJH61n3sOou0jxkK6Vx98X/XVrv
	rIQRvwXp4h/orVqpAHyFW+27gvb8TyDE0fWuLxiHenrSmnbkYSfoTHSSg0jhPmw8GYecrYu/gtW
	CTVA/OD7rwON4TsxsVh7nIFtJtHLkaGcVsOsoF0mmxRYcFfSqYnMHoRVsNZMfIaVHI6ppMLwhTd
	ej/eKfDsGI5XTKzK9lbcg7M5KzVKt9vmOeyx7EomfbksEJTmZpalRvHATox+hVuDJPXm2vNhSl6
	c1uTXW56RGpywFErJTWo5sDTEuFQez8EFqSSKLJdJEO2TCvSDXRwZ80qeO4Tt7MIlAi77T0JHF5
	O/o9YNV8LRpafAnKAfSQ9jHIb8QL5j/G/d6kwVgSeJTCqQSMPwh1yfQh6BjhYDadkyvK/H7y1f0
	eN7il1oIlFLkwdoyff8qH5sZfH1Quuetw6D8DUqHvyHbf02MPV5L7L1zveS9E3DSpwf+ENdhwh8
	NURS5JTNbwZhTtGDJNVm2SPgxChogDxTgx/1qE0JE3kqkCVcyAt59FdwNBWyjkIwEM9KjdIcAiQ
	==
X-Received: by 2002:a17:90b:380c:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ae89749415mr5128768a91.29.1793502348357;
        Sat, 31 Oct 2026 20:05:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc8942e0sm108465a91.7.2026.10.31.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 06/14] libbpf: Relocate pointers that are stored in arena
Date: Sun,  1 Nov 2026 03:05:02 +0000
Message-ID: <20261101030511.1578690-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

