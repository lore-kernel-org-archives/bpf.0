Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983705;
	b=XOW4xq1NFg0X9U82Q/nZTDMHisXIwLKVPY/ehvYr7dTU0Kesj+jJ8/61HJbXsP/RN+NY
	 +xuUYgAXkAotX5WYf7gQQRxDW59cl56VvcIg2YnM3Y92dr7CdKqIYGy3PMqllLRgTJ03S
	 3KsVQ8Jh47utzrL+6nnXipKzEKMt1s+ep7usjlMx/vey64113+kwC8wCrB09Zes+PnWZ0
	 hVYtEv0AK7P4RZ8xjgV62MKeMFqG9TESniGkuPJcoGexPNwpk2ZroyqgoH9HuQq5gimxN
	 peQrvSMeXIIe2QcVesQSix5pofYV2d7eBq3hIhBqAmnxyZYPPBNhmMshPVG14+jOnnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HVs8rHwInYILMtSO51iS0zdZ+BEfHwHMeP+lPVbbmJY=;
	b=nfIYI/EI0UAXpKA8XBSDenLphCh5dmcoOBzFhCYWNIt6IZmE88Phg07Zjsda+xSwFJwt
	 f6rqT3RuC5tXgg1PdOGgwcltJfpicGVF+Ie8i6TXF7tL5Xz0qjHXlMFTiWnc8NGhTNf7p
	 V7xjJdW+TFuylH2Z7M7Hd742M4dYkxfOWry5OYlsyh8xjJ3c2xwFPC40tLMtZ8HzgfNYe
	 nVBhxFSDH+u76IsLd+h+t4ar2Veh2tuU4nP7uKkZUt5tQrwFci36zV6AFrNx9QtICLx6Y
	 T5YZUrzKVy9x6NmyMiZZou42nz3dCWORbZSv1LyMSFRUvS62qbGM5/utW3EvtfNPEUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGjGpOrD;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FA606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hGjGpOrD
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e5fb79ce82so15850585ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983704; x=1793588504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVs8rHwInYILMtSO51iS0zdZ+BEfHwHMeP+lPVbbmJY=;
        b=hGjGpOrDuG/HwcApJXLBuy2qkX17uCyN0g+dh9bmrCFOZXuElRbpKMYsBq5+rArSoZ
         zRN1BvUl7dMb78UzxMINSa1rS1d7N73GXN+9xGvgwB6ZdbJ1fRuPfVo7sSPLD//ILMAT
         xYdggh77gArhl2F1tZ7uplPJfcaa14naiJ3JpFO06SYdYORulWE7ozQhN+8CbmLKAGoH
         qLj0g4b2JepN+OecfH3xX+4aIg05GNi1bP/jOpmbYqHTLumPBA/oLr1KAe7p+x4jn33d
         MzqQFYHLX6hPDFj0wOPhcoT3X4Dplk1bntr0cLgketj2PO0pd/rLHgXcJvkQB6r5bpon
         rUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983704; x=1793588504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVs8rHwInYILMtSO51iS0zdZ+BEfHwHMeP+lPVbbmJY=;
        b=a45uIT3jSpdACjcNrfjD9os98MD3tYItBp6vgrKu3ym5ZI6P7O5lIg68KH4FC3Vtpf
         jzQtYRj5u97zNtew6tr2m0wAdHj8ZPkm4/UhlSAO8FHT1bnXNOd3NMu827KyxFkWICQP
         36OhzNn9UKYMyX59MckAhP2vgpEuaCNuDzCSL1iwo2P/NOt7pwCX5YNtHrX0j2PzYlBo
         p96hB0Tidl3QDtalQLoJQ5f6kYlV51+jeLI/HydPshUVZG+qq9aIH8JZjNaKRNIOR820
         Kat9bN/7SgiBJ+7twRWC+gBBY9aTLlRvq73Nzvbg1mkt/vCBjdPFW8EsUudRfL1F/iLt
         iMww==
X-Gm-Message-State: AFq9FYKTT60djr4rhdvSrik5gFbfJld5rAALXpY8FQQ8y7sURfgS6F8y
	0hx1GWms0dSkCnQCb/dnq5bQSNcnXf3NSypnkro24RIkYUqGbVj8RS9T6D3DkQ==
X-Gm-Gg: AYBFou0CBPdonDaDi6vbUUyJo9gUqgOZDTSAW1ScsdsvdNhJmjEGI0eBIBp7v1IhMx5
	6Kbq1h5yk1LTA85PF/JaugSjqXhQyUEWnn+lRHz13TT0y9mdFRQ+JnuEdApqYI15S0aXdY3Oamf
	lvFbhCpcd66aCeJ39xMb3F8djWqBQd/DdSa4gHsIAns1xkTOzf/1CrrSHmi6LygwdYsYGNg9rZA
	zZpoNy62D/ggsfOGFrULhswet8Js87kmiDvrlIKPpfILOeLctHaxTQczaIjtawlsVNIiJO+X/AA
	z0ubDMVI3VUTkSclmSGgIYx6owCcExc071tVXfH6sotKs06bmvNsIB1NUZ0o05Zj/UtVNmMgHKA
	cjkrWY+Zq50J9W7VEfvReFnnWniItXKnRppcVKGxOns+ADG4raob5uVio+LY2ibzYOFrIYmJ6xb
	GfMrMM0fDYVV2JSgl0Vp2zdDM6AKw8GtQwhPxuaB2Kmw1eVAygnILkmzWooHPRqyM0EuenwZQYO
	DUrEryJrj+0AKu5cGbCUOKvIooS/YTZwAVG4p+mNqm1fDsae3h7+iGKw4fs+FL1c2QZPbDqsivz
	WOUxzDQBlYhuGDW3droGddFmLPlJ4vuyKsGVN/J3SflDb72W3OH9eWpEpZSIg+W5ejToDhvq+zo
	PxnGHdxQ0HZ0oLFQdJwEd/r1H
X-Received: by 2002:a17:90b:1811:b0:3ad:85fd:711c with SMTP id 98e67ed59e1d1-3adeae76405mr4617305a91.28.1792983704010;
        Sun, 25 Oct 2026 20:01:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6946dsm6246697a91.4.2026.10.25.20.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 20/81] libbpf: Support .bss.addr_space.1 section
Date: Mon, 26 Oct 2026 02:58:41 +0000
Message-ID: <20261026025943.404450-21-alexei.starovoitov@gmail.com>
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

Global variables in arena are in the section .addr_space.1. Its type is
SHT_PROGBITS. Thus the variables that are zero use space in the object file
too.

Support .bss.addr_space.1 as the .bss of arena. The name starts with .bss.
Thus compilers make the section SHT_NOBITS, and it has no bytes in the
file:

  long __arena big[8192] SEC(".bss.addr_space.1");

An object with 8 Mbyte of zeros shrinks from 8410296 to 21696 bytes.

libbpf puts the new section after .addr_space.1 in arena and fills it with
zeros. It adds the offset of the section to the relocations that refer to
it.

Only the file becomes smaller. At load the new variables get pages in
arena, as the variables of .addr_space.1 do. The layout of skel->arena does
not change, and the new variables are not in it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1d4f04aa35f1..78ff9d653191 100644
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
  * The size of the arena map when max_entries is not set. It's in bytes:
  * max_entries of arena is in pages and the size of a page depends on
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
 
@@ -787,6 +795,7 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 	size_t arena_data_off;
+	size_t arena_bss_off; /* from the start of arena_data */
 
 	void *jumptables_data;
 	size_t jumptables_data_sz;
@@ -1612,6 +1621,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.btf_maps_shndx = -1;
+	obj->efile.arena_bss_shndx = -1;
 	obj->kconfig_map_idx = -1;
 	obj->arena_map_idx = -1;
 
@@ -1631,6 +1641,7 @@ static void bpf_object__elf_finish(struct bpf_object *obj)
 	obj->efile.ehdr = NULL;
 	obj->efile.symbols = NULL;
 	obj->efile.arena_data = NULL;
+	obj->efile.arena_bss = NULL;
 
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt = 0;
@@ -3078,13 +3089,20 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
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
@@ -3157,14 +3175,13 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
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
@@ -4159,6 +4176,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4809,7 +4830,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 	sym_sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));
 
 	/* arena data relocation */
-	if (shdr_idx == obj->efile.arena_data_shndx) {
+	if (shdr_idx == obj->efile.arena_data_shndx || shdr_idx == obj->efile.arena_bss_shndx) {
 		if (obj->arena_map_idx < 0) {
 			pr_warn("prog '%s': bad arena data relocation at insn %u, no arena maps defined\n",
 				prog->name, insn_idx);
@@ -4819,6 +4840,8 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		reloc_desc->insn_idx = insn_idx;
 		reloc_desc->map_idx = obj->arena_map_idx;
 		reloc_desc->sym_off = sym->st_value;
+		if (shdr_idx == obj->efile.arena_bss_shndx)
+			reloc_desc->sym_off += obj->arena_bss_off;
 
 		map = &obj->maps[obj->arena_map_idx];
 		pr_debug("prog '%s': found arena map %d (%s, sec %d, off %zu) for insn %u\n",
-- 
2.55.0

