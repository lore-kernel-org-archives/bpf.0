Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755474;
	b=HrX5vU/FCLjQRzGOMhu4GCx0/+qHEZ9ZEmvZDXTy6gPsl330SBYvo0aSzh9pUMj8yrkz
	 ksBwl/uFNMiEbwVb8wL6rmi5VVmaV/NToJhR6/ggcAVeK77NKKnpwaDuCFAe3QDtBbhr3
	 EQXIEsPpybxMQEJpsdUaotSIiwKoLfnvEpTs+HoOJftxopQtdDiqmw4hIciPzyk6A9Lsh
	 F+XOWoQq3TXwcE18A2nIt5QjxTUArZ3P1KdLuCorwEVbQcUHYrkD9G4mold5LQZ92ysOB
	 2HME/K0i9iDVLaodlQ477dPRHmnNYrqu4mwABuZ+tG4+srYsE0VSKFIJsRxtbtjuktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
	b=YEPTrPsB6W1Bpz8KiQFm29O0fj2jrqm7SHdkynuvvBN5JT1M2GvO9XLzScJP6EfJjCDy
	 f+JUmXaHBKjPQz2Qy/O4UiQ+SSxOzD0FekevwUEU28QCt5mh2XqI7y+xLLPE42Kq7TKU6
	 BZadUmd9uUSMwN93/nsLnYjuG8LMXBslCPynZKKgmy0CCWCtKewuMDaKGG6dxGzp3QxiG
	 vrvqjUe8DQJQSK4PLNjXR2DoignisBGe3XEfj4F05mLnFgmwuREy7CgQq6WwnUNI9cnqz
	 zgS1l1tnoLw/vckiznLCnHRtROVXv74Ein1ebPbVbT7BBpL3Y6fuGMMl/sE6vUAAC9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzJtd1jO;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7E606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04E7E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzJtd1jO
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so155420a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755473; x=1794360273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
        b=SzJtd1jOZ4ddQmwabGK8El4d6q4jeG85Q9mwVQgbpJ1dGPvn5UC1dCBrqm7D3DYsNH
         M7l2g+f/msLxPW3VlLLpsn3VMTxFryugpieOhdtCcwwO+KKQZI+WBmtwSdTDjqgvlQnz
         egkxe6sVndjBQ8zZzyCJlm6xqgdfTOxjKLRiEqhiNGbzgk6KW+DSoZZbB0svPmoveECA
         dm4F8xBdwqzQcbl7WfdUJvL6qUt2n+bvYJrzRTqSEkSO2PmjWoNuvLAcMwU61oWCmywC
         PquH5qU7mZ305Zr2FPIbIPIYxlEYjlB3I4rI2nb6p7NjjNQxjC7fUlOKa0OW7exO3+Xl
         nqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755473; x=1794360273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p5x8IXgXiMkB43z1JNweq9LrGIr5jvc46lg4dgU1OJM=;
        b=BclcaVmWvs4yt2gSa211u4Tb78MitHdlV7kPOgGmLWB0Mo7Eg4xa6RmRCuuH95iuz5
         PgrcYd6krMmZemxZNnQORIOdjIHz42rkOMMr9g8EzrhnsdC+14+QMsem0KduylyH7eeF
         aQNaxCeB/iypQbDA3L6tkjfGqt+Up8r5UihQxYkp4kunKTiZAE0KixTyWDiG8Tcbfk1y
         koo64XrNfJx5L5mc/b6V/GlsRwri0M7kM5C+ju2Fj9Fs2Gmiff7N1NPpSSNtQvEkJNY1
         zDyVPAtHFvlwGBnrD2gAQzCEJ3htjekksAC6W2tYk2ow3OS/vQ9QDUgMHxMxVgBDVEkQ
         M1ZQ==
X-Gm-Message-State: APuU4Z9MsYfGfCZ2iBwgm01DBl2L+nWAMvNG8yVrbpFb7Iuwu6araxqS
	aCKF2LeTD55zFvLQdn9yp28QvPHs9dsS+mPAwBN/wyiuqmHHAh7yCQoUjEK22w==
X-Gm-Gg: AYBFou2FioYQPBGMn4Nqgkxt+5pzpreM0Kpd7s8cwu2yEku8bpcsjQFxipzQauDJUwH
	an9ZtPDD6yJbLpcJWB+P+2XTCCZK1O31LH09ntCqxqhqqGxBUuWnLtW+W1Oq/po88lixxZzkuea
	kdCKReuIzM9XHbGyeA+vxsGAVmIqgpnpDO69VI/z8csAVayONJJ74gWXQeQRsO7oGpXp9fRm5NY
	3E9ab5Rw2pZ1wGZGy5jS+G3Hpgn2pDSGm7mW7BIUBbMELfEBcL76qKJ2BFiephxwZIQCWTGc5av
	UGiP4GjdIm/3byM5e7aWJauZF66lMpQ8vylo7Dx7PqdVdxRUr1i4Y0ba8YQtqJkEfyN4w5yh1U4
	hbbK4ERoHn18vMMayfWbLuWohomgvOMjRKdC6tfS+kvA7vZrFjSSoQIOvBS2EeIq/6vI3gDjnOl
	QfCwZyNyWdVgqZ38+d5vbyn3Eg7UyBv6kua4kbPHktQSKuzAx9peuJvGbc5/15EmV8/jkpvmEVd
	JOXOAkYwyKmOZpUpvK9fmkU+gkrdxw8bRfnb6VbhzSfqOIp7x5wwWqW/aoDkAXNMvm64l/5vmBr
	uOc59iuxw7B1KTX04zFQTuhn+Rh41w2VlOzMcYpvLyJS4KOFn3hgsJdttcWjtFd7TjSOZm3EzlB
	/FdnxEFfI3lo3KUzNu1zyw2WpaNmoB0Ng03Q0ct3jrbGBBC2B7tjXDB0JIbHf8ySZIijx4A844m
	Q=
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ae8984ec60mr11956846a91.51.1793755473050;
        Tue, 03 Nov 2026 17:24:33 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b72d5asm393202a91.4.2026.11.03.17.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 05/14] libbpf: Support .bss.addr_space.1 section
Date: Wed,  4 Nov 2026 01:23:51 +0000
Message-ID: <20261104012401.1354861-6-alexei.starovoitov@gmail.com>
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

