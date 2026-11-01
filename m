Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502343;
	b=pCl7T9Z28WcHw8ad5SCnR/RK+72h7mEsMj1qQi8JwZ5N++zTbgYGlPEMRnwdDwQkvkwR
	 NdKlsD39Iog7JtaDDV3wM4SUZu/2RbIl/aKwMPJS1rMQiwXq9y88lJdDTEBkmDbb4bHHm
	 knx9g0KfQidi09J6gEZdlSYp6x0I5lOOgECTZ/5Rukcbzzh74/EZjoXtepuMkH3i993jp
	 3zoUXQKakVwqDgFWa6CykqWFKb16/ITpGgDaFNBIJR9+driVWaDxn8dAF5gPEEWhTx6YG
	 ZJf2esCt4YUtMYIsAn+RTvWsgL1QZkYqtjwm3dYmsTamHso4fJf7WsixZPgc1PI6G8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
	b=nLLrTbE+lenAO7lAfIf2c+XO0BjCKNwK9Hm2BDCZFcUgePGmQ8DwnDspxF3UkdmIIUDM
	 3WLyskIFviv1j+rrHd6I9P7fjLjBHdQHLFrDWF6+yDTsMERvOrF163edzKV9Gm6f8mUaM
	 sgHAzYc1w96EEwFwIwJxENCXoyBzUYmLIMawum4o2GLsXe7QGA7m0NtdUGL7lnS+T5uni
	 qg4tCa4tf0fE4tGxLWfsAnSdcUeViv2DX0KrXIEAyrFw7cdqK2z7X7fdujb+FElfnJd7O
	 ovtmYwurteQzc+nWCIrMzoc3aMYaetlMETJR5NrOjjibY+ca0pQZlXLFt0MgltqkwNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCMUcuNj;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFC606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13EFC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lCMUcuNj
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1279099a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502342; x=1794107142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
        b=lCMUcuNjAC4IxpLoNf7dLLLsX8b4But5Y//A7weABlrbJMJI422Awp4URYHX6/J3O+
         r/s4XzrgFA4/hMBNJ3DY2xx+36M5G086R5x/SeFQivkZlUuyGjP+Pgya0ucx5tcHWB1s
         d7Q+tDqq3ewtAGGrFbdnrKdM++IghnpPrqMFQxkWdZzplrGGTvVjBVmbt7mEH2VVeaMQ
         6apCX9kpL09X3TsaITojwsb51PDeqmzWOZi11+pogxkbmBdoiWCQDxOYaTvtkBKB71nN
         7LHbfZIeiNV4wnrG99hwUjghGy7t743aHIi3PvZmcS5yHV8tOHDcjp6wcDFfvfTkDes4
         E3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502342; x=1794107142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
        b=H1Qh2mZ7/AikAMDm8XgNljyYY4mCjFh2CjGiqwImIYCOg+B+gxT/CkJq0vnSaZ3sPf
         1yMFJ26z3eUWFnA4chxj/lFbWfPoSchdsYiJmUuPsSfMfgiUjRey/9YghATIgZzLHZhl
         WBDJhY6XvQ6A//yJXE5XOhF9a403PrO+yzN3LpYGhx/0NQQenLsoOj8cvwa3fL+wBeSp
         IPz3/aorJlGjSzpVzG0DEXyhPiFvLklTiu5K8USNgXEnC09Y3Iu3vkarFDWhiNgnYRl1
         i//XpSz5T5fXrTc5G2lNQmRhcN+0u3Jky5P0+CyebbSdkKcpW7tq6UUn1W3dyGfKC2DW
         5tmQ==
X-Gm-Message-State: APuU4Z/g5Ko+3mMKpHyYDcsybA1Flv/ZW1RxvZC6KIJSg1dHrtX8U9o3
	fsmptUEQQJI79C/tqnzRcrt5tcrAPD1gNlCzyPYoexy+apVgE8oHSoZPKGiVOw==
X-Gm-Gg: AYBFou3PoURAlPOUTYl1fOQekXqN1VI7FEyO6k6x5E/kAr5UqxMolwlkQkmBd+6TcKR
	k6el32q9fk/YKa5MvqOz7prPXWTQhXKvEg5y/IoMCTZo8LiAw8FRnvKTMmLrXFjBiZLipS1p1DA
	AazgKrxcJc8sUslpfxOzgjnM4M9H2wxCH7iYO7E4hmIxFxadMI1lSJaYC5QoA2XV5uln4XOn+5x
	KTWmOycFfka9n0ONx6erF9QMEyBo4CP0EYmzR+ad1i4auzXY498ZP2HElfXKQNn4wK9kmLMfqj4
	Xne+OTUYKIwWTnq0p1sQrzuEqI/iscmS+N+lg5zqIX4CryoMwL5hInxoFoVABidcp8BUoZ45VtR
	pHrUk9G4zKkt6pw45B8yzEJiysNE0wgXCQz5i8BNb9Q7zq3/31ESAhdihW95OTH7wcRmj0BzLKs
	Tud3qO450X0Ic7mIWcDqKjY8yB8EZ2eUdHjtoN7qYHU1RjZHMOprew8dB65UsVPHQ5zbcO5wb3t
	cCFkiqGkQA8YAWP9HOGC8MXWo9x4DH8uDNzJx7OpHCT1H/b0f7gRzZ8KAERm17O6GJpD31bvxpP
	8+WJiglbVroiq4Pu9mj5CX0peWjakt6TOjB/80U9XWpozQuXi+9bVN+vAdKBvbtooy08nxR5rIk
	Fvn28eWzweugLXn5hG9EdF9qXVoBoQmm9DH67ZVSn0PIN5EbE92ch9kMvDOrQcHsBBJ7Ggti9sA
	9aQPW51P6aLqdgaVpY2A0=
X-Received: by 2002:a17:90b:4a4d:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3ae89542f3dmr3697238a91.3.1793502342352;
        Sat, 31 Oct 2026 20:05:42 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm9349060a91.13.2026.10.31.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/14] libbpf: Support .bss.addr_space.1 section
Date: Sun,  1 Nov 2026 03:05:01 +0000
Message-ID: <20261101030511.1578690-6-alexei.starovoitov@gmail.com>
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

Global variables in arena are in the section .addr_space.1. Its type is
SHT_PROGBITS. Thus the variables that are zero use space in the object file
too.

Support .bss.addr_space.1 as the .bss of arena. The name starts with .bss.
Thus compilers make the section SHT_NOBITS, and it has no bytes in the
file:

  long __arena big[8192] SEC(".bss.addr_space.1");

An object with 8 Mbyte of zeros shrinks from 8410296 to 21696 bytes.

A declaration in a different file needs the same section:

  extern long __arena big[8192] SEC(".bss.addr_space.1");

Without SEC() the compiler puts the declaration in .addr_space.1. The
static linker took the index of the variable in one section for an index in
the other section, and it crashed or wrote incorrect BTF. Make it report
a section mismatch, as it does when the definition comes first.

libbpf puts the new section after .addr_space.1 in arena and fills it with
zeros. It adds the offset of the section to the relocations that refer to
it.

Only the file becomes smaller. At load the new variables get pages in
arena, as the variables of .addr_space.1 do. The layout of skel->arena does
not change, and the new variables are not in it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 41 ++++++++++++++++++++++++++++++++---------
 tools/lib/bpf/linker.c | 11 +++++++++++
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 76d22a739e00..a7c53dc5b91d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -552,6 +552,11 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+/*
+ * Variables in arena that are zero. The name starts with .bss, so compilers make
+ * it SHT_NOBITS and it takes no space in the file. It's placed after ARENA_SEC.
+ */
+#define ARENA_BSS_SEC ".bss.addr_space.1"
 /*
  * The size of the arena map when max_entries is not set: the largest one.
  * It's in bytes: max_entries of arena is in pages and the size of a page
@@ -697,6 +702,8 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *arena_data;
+	Elf_Data *arena_bss;
+	size_t arena_bss_align;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -707,6 +714,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int arena_bss_shndx;
 	int jumptables_data_shndx;
 };
 
@@ -788,6 +796,7 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 	size_t arena_data_off;
+	size_t arena_bss_off; /* from the start of arena_data */
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -1629,6 +1638,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
+	obj->efile.arena_bss_shndx = -1;
 	obj->kconfig_map_idx = -1;
 	obj->arena_map_idx = -1;
 
@@ -1648,6 +1658,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
+	obj->efile.arena_bss = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -3095,13 +3106,20 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 	return 0;
 }
 
-static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map,
-			       void *data, size_t data_sz)
+static int init_arena_map_data(struct bpf_object *obj, struct bpf_map *map)
 {
-	obj->arena_data = malloc(data_sz);
+	Elf_Data *data = obj->efile.arena_data, *bss = obj->efile.arena_bss;
+	size_t data_sz = data ? data->d_size : 0;
+
+	if (bss) {
+		obj->arena_bss_off = roundup(data_sz, obj->efile.arena_bss_align);
+		data_sz = obj->arena_bss_off + bss->d_size;
+	}
+	obj->arena_data = calloc(1, data_sz);
 	if (!obj->arena_data)
 		return -ENOMEM;
-	memcpy(obj->arena_data, data, data_sz);
+	if (data)
+		memcpy(obj->arena_data, data->d_buf, data->d_size);
 	obj->arena_data_sz = data_sz;
 
 	/* make bpf_map__init_value() work for ARENA maps */
@@ -3174,14 +3192,13 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 		if (!map->def.max_entries)
 			map->def.max_entries = ARENA_DEFAULT_SZ / sysconf(_SC_PAGE_SIZE);
 
-		if (obj->efile.arena_data) {
-			err = init_arena_map_data(obj, map, obj->efile.arena_data->d_buf,
-						  obj->efile.arena_data->d_size);
+		if (obj->efile.arena_data || obj->efile.arena_bss) {
+			err = init_arena_map_data(obj, map);
 			if (err)
 				return err;
 		}
 	}
-	if (obj->efile.arena_data && obj->arena_map_idx < 0) {
+	if ((obj->efile.arena_data || obj->efile.arena_bss) && obj->arena_map_idx < 0) {
 		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
 			ARENA_SEC);
 		return -ENOENT;
@@ -4176,6 +4193,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			sec_desc->sec_type = SEC_RELO;
 			sec_desc->shdr = sh;
 			sec_desc->data = data;
+		} else if (sh->sh_type == SHT_NOBITS && strcmp(name, ARENA_BSS_SEC) == 0) {
+			obj->efile.arena_bss = data;
+			obj->efile.arena_bss_align = sh->sh_addralign ?: 1;
+			obj->efile.arena_bss_shndx = idx;
 		} else if (sh->sh_type == SHT_NOBITS && (strcmp(name, BSS_SEC) == 0 ||
 							 str_has_pfx(name, BSS_SEC "."))) {
 			sec_desc->sec_type = SEC_BSS;
@@ -4826,7 +4847,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	sym_sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));
 
 	/* arena data relocation */
-	if (shdr_idx == obj->efile.arena_data_shndx) {
+	if (shdr_idx == obj->efile.arena_data_shndx || shdr_idx == obj->efile.arena_bss_shndx) {
 		if (obj->arena_map_idx < 0) {
 			pr_warn("prog '%s': bad arena data relocation at insn %u, no arena maps defined\n",
 				prog->name, insn_idx);
@@ -4836,6 +4857,8 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
 		reloc_desc->sym_off = sym->st_value;
+		if (shdr_idx == obj->efile.arena_bss_shndx)
+			reloc_desc->sym_off += obj->arena_bss_off;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f3f71c452f00..dba88f4fd6cd 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2123,6 +2123,17 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 		if (!glob_sym->is_extern && sym_bind == STB_WEAK)
 			return 0;
 
+		/*
+		 * The symbol has an entry in the DATASEC of a different section.
+		 * var_idx is an index in that section. linker_append_btf() reports
+		 * the same when the definition is first.
+		 */
+		if (glob_sym->var_idx >= 0 && glob_sym->sec_id != dst_sec->id) {
+			pr_warn("global '%s': section mismatch %d vs %d\n",
+				sym_name, glob_sym->sec_id, dst_sec->id);
+			return -EINVAL;
+		}
+
 		/* At this point, new symbol is strong non-extern,
 		 * so overwrite glob_sym with new symbol information.
 		 * Preserve binding and visibility.
-- 
2.55.0

