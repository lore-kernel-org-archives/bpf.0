Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE303DD87B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219488; cv=none; b=thThyl8Plcw7V92aMjVxMrf2weA8ApV+iMKcpsreB0plOlaJzaQk2s1rJVhOBWMeLuOpqtis52ohTTq+U5tPFYLuIh5qv3Gc9S2GowakTgrihC48wA8dcV6knEaLTm6vjl9lFqGECNAYtmXqVrj9y62o3HJNaZUpQKponLnBSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219488; c=relaxed/simple;
	bh=x9uPoa99AdNKdAnNxhzx7F50pu9/GoUGe9U7E7dnqIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYLlzgMQ4qAQqZZDcTiboBTvDPwKEvjV3uKG9b/oboF4sDDCOjkfe7My5qgQIOkRsU3hgA93MFWIx/x7tFEC0jLneWX3AFEkUTSXxSpWZNAj0nLAbnxvZXh2xLYXaUO1/3xqASM1fqD1NvB1aYQFstfe6/LQcfiApBc8nwVNoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDunHv0K; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDunHv0K"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso1098979a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219486; x=1790824286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YU2AOvLhGM8UZJzn+Af9FH90g1x//vJe1qeM1rRHzTM=;
        b=gDunHv0Klw7TlS6z36ddFFZMN+ef0zG9pKqQbLqnv/ueFVVRsiFsIMYpLl4mJeZ4z/
         PKwReQ8HzjPzzxT0ghWT35IalMlNX4ciRB2wCSYb//jMIC0KBUHm/fzVMq/XiD7dXOHP
         Dsp5JTTT9acyr3ElayBDjUEnwK532SGxjHeV5TWWHx61audimx6yG1BRMmFs6WSoUsSs
         zEcgcBtEOGIldgK6nJqN+hvzlP8DtdKWKBCygzZNJs08iBgnTluuMNn9IsHxe19fpLmZ
         WcG/3I/VxX8pWR2zy8yAXwCg0FNP0hqKomGPnLTjQltU1RZLxI8ChMozIUVefaB6ECx+
         dj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219486; x=1790824286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YU2AOvLhGM8UZJzn+Af9FH90g1x//vJe1qeM1rRHzTM=;
        b=qrupfVXuQ/N2DbGvIPxKYvLlhQSohit4sLP+5raIIz1IKjyr8AkuH+mfn0PoQlwITT
         IX3O7HX7J1+lrCg3IejVXTUQ7xrwZeZzlWu6jI5Z/ga82ZZrSJysDqEmRv0WjI6+L/NQ
         MY98gUgEJsEg5igYLsF2KMVyu8ArBHoeWmucP6vsz6uJiUKd2Gq1Uf+hd6/vqUZsNbXh
         ebLNc/n4WfbsAuivBn9AJh6zX3e0qbEtbc266mtf25uUFV940bg57v06VdUEYP1QbhdQ
         JIDeXgbz8e/dsL1oYfXLr7PDMPGG/pLdqhtFbiOZuSdDyv97iwapSXbfU5hpj5H2W3JC
         SXtA==
X-Gm-Message-State: AFuF++ngst95JwlhosYJF0VQ1WhNRjlMosltus+YNvQ2UxG50L9qEHTG
	DhSbzBYoEc1fZHFWhQ6d2xvz1mwzSVE+zZYxLfFXQEjqweQsaZAQ/3L/qxrBWg==
X-Gm-Gg: AYBFou1d7VuBY3cyq38QtoMkVCkCVCa4KPPbV3ubB44bjp7+l8xxzkj1ZPEiJZJAI1e
	kEA9BbfKx6BjJZEu6681x3mBtkXHTETLRiCxGZGmMdVG166uJ0Kw4/AA8IiYBh+Wmmx5291dye8
	RtU+whXRsavBzBX5F46SZbhaLp6fCvYr4p6KneXqp0+pVmL7myGQ8Rs1ZGjj4En5HzfWn7KXWsG
	caROYPw3+TK+IJh9PE6qzUwe/o939/U5Bw400s/5C1movIPBrIVLh0lN6yKku6MzV+YqyPtfL4M
	i939S6uurtwOIRx6bhMtPObmeIo2Wl/PCiSoJB4Iye+1KkGBFQb2S27hcFNeebkDuFXrS6LbYDW
	NkH2t6iUgRwWbpgOQo92/QBhryqe6/1yzFVSPv4k28vCNqq99Evp2doDXAWy9UEDA34gFX3TW2E
	erpV3yB9MT9A1RYt2GkNJTTV/UEV0WZNBzyWUpejYGcp2Agd11duV5MvOaZwXIFS4XCQU5jzCB7
	wpdNqhQtvsYEHPh71oFoeIBq2cwylX1f7hqhzQhBPaVPy5WfxPxtvw44Nschyyx8ZN4RKeF6CCB
	rfHFEl6XDrMmhbZ3xWoRiOWKnvBBYZ8meLPwllPjU2YoxjyLVQ4xYw==
X-Received: by 2002:a17:90b:3f4d:b0:3a0:28b0:9459 with SMTP id 98e67ed59e1d1-3a0986077d7mr1091378a91.27.1790219485398;
        Wed, 23 Sep 2026 20:11:25 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0812a1eb2sm2890709a91.4.2026.09.23.20.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:24 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/17] libbpf: Resolve pointers to functions in read-only data
Date: Thu, 24 Sep 2026 03:10:37 +0000
Message-ID: <20260924031042.1690890-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The kernel recognizes a pointer to a function in frozen read-only array
map by value: byte offset of a static function in the program.
Make it work for tables of functions, struct ops, vtables in .rodata:

  static const struct shape_ops square_ops = { 1, area, 10, perimeter };
  ...
  return ops->area(x) * ops->scale;

is compiled into

  r3 = *(u64 *)(r1 + 8)
  callx r3

where 'area' in .rodata is R_BPF_64_ABS64 relocation against .text.

- Collect relocations in .rodata* that are aligned pointers to
  functions. Relocations in data were ignored. The rest still are.

- Append all static functions that the section points to, since any
  of them can be called, if the prog refers to the section and has
  callx. callx cannot call global functions. Don't pull them in. Such
  pointer is NULL.

- Functions have different offsets in different progs, so create a copy
  of the map per prog and store the offsets there. The kernel replaces
  them with addresses at load and the prog must be the only user of
  the map. The map of the section itself is left as-is.

- Progs without callx cannot call them and the kernel doesn't look for
  pointers in their data. They keep using the map of the section and
  nothing is appended to them.

- The kernel treats any aligned u64 that matches an offset of a static
  function as a pointer. Warn if data has one that isn't.

Light skeleton is not supported yet.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 381 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 377 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd1ea1bb53cb..fc9b7540aca6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -497,6 +497,8 @@ struct bpf_program {
 	bool autoload;
 	bool autoattach;
 	bool sym_global;
+	/* the program or a function that it calls has callx */
+	bool has_callx;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
@@ -601,6 +603,9 @@ struct bpf_map {
 	bool autoattach;
 	__u64 map_extra;
 	struct bpf_program *excl_prog;
+	/* pointers to functions in the data of an internal map, see obj->func_ptrs */
+	struct func_ptr *func_ptrs;
+	size_t func_ptr_cnt;
 };
 
 enum extern_type {
@@ -780,6 +785,29 @@ struct bpf_object {
 	} *jumptable_maps;
 	size_t jumptable_map_cnt;
 
+	/*
+	 * Pointers to functions found in read-only data sections: tables of
+	 * functions, structures of operations, vtables. Sorted by section
+	 * and offset.
+	 */
+	struct func_ptr {
+		int sec_idx;		/* ELF section that contains the pointer */
+		size_t sec_off;		/* offset of the pointer in the section */
+		size_t text_off;	/* offset of the function in .text section */
+	} *func_ptrs;
+	size_t func_ptr_cnt;
+
+	/*
+	 * Read-only data with pointers to functions is different for every
+	 * program that uses it, because so are the offsets of the functions.
+	 */
+	struct {
+		struct bpf_program *prog;
+		int map_idx;
+		int fd;
+	} *func_ptr_maps;
+	size_t func_ptr_map_cnt;
+
 	struct kern_feature_cache *feat_cache;
 	char *token_path;
 	int token_fd;
@@ -845,6 +873,16 @@ static bool insn_is_pseudo_func(struct bpf_insn *insn)
 	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
+static bool prog_has_callx(const struct bpf_program *prog)
+{
+	size_t i;
+
+	for (i = 0; i < prog->insns_cnt; i++)
+		if (prog->insns[i].code == (BPF_JMP | BPF_CALL | BPF_X))
+			return true;
+	return false;
+}
+
 static int
 bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		      const char *name, size_t sec_idx, const char *sec_name,
@@ -4068,8 +4106,14 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			    targ_sec_idx >= obj->efile.sec_cnt)
 				return -LIBBPF_ERRNO__FORMAT;
 
-			/* Only do relo for section with exec instructions */
+			/*
+			 * Only do relo for section with exec instructions,
+			 * struct_ops, maps, and read-only data that might
+			 * have pointers to functions.
+			 */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
+			    strcmp(name, ".rel" RODATA_SEC) &&
+			    !str_has_pfx(name, ".rel" RODATA_SEC ".") &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
@@ -6471,6 +6515,136 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
 	return err;
 }
 
+/*
+ * The kernel recognizes a pointer to a function in a frozen read-only map by
+ * its value: the offset in bytes of the function in the program. It makes
+ * callx work for tables of functions, structures of operations and vtables,
+ * where pointers are mixed with other data. Functions have different offsets
+ * in different programs, so create a copy of the map for the program.
+ * The kernel replaces the offsets with the addresses of the functions when it
+ * loads the program, which has to be the only user of the map.
+ */
+static int create_func_ptr_map(struct bpf_object *obj, struct bpf_program *prog, int map_idx)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RDONLY_PROG);
+	struct bpf_map *map = &obj->maps[map_idx];
+	__u32 value_size = map->def.value_size;
+	size_t i, j, cnt, sec_insn_off;
+	struct func_ptr *ptrs;
+	int map_fd, err, zero = 0;
+	__u64 val;
+	void *data, *tmp;
+
+	for (i = 0; i < obj->func_ptr_map_cnt; i++)
+		if (obj->func_ptr_maps[i].prog == prog &&
+		    obj->func_ptr_maps[i].map_idx == map_idx)
+			return obj->func_ptr_maps[i].fd;
+
+	if (obj->gen_loader) {
+		pr_warn("prog '%s': map '%s': pointers to functions in data are not supported by light skeleton\n",
+			prog->name, map->name);
+		return -ENOTSUP;
+	}
+
+	/* the map is not created yet, what it's going to have is in mmaped */
+	if (!map->mmaped)
+		return -EINVAL;
+
+	data = malloc(value_size);
+	if (!data)
+		return -ENOMEM;
+	memcpy(data, map->mmaped, value_size);
+
+	ptrs = map->func_ptrs;
+	cnt = map->func_ptr_cnt;
+	for (i = 0; i < cnt; i++) {
+		if (ptrs[i].sec_off + sizeof(val) > value_size) {
+			err = -LIBBPF_ERRNO__FORMAT;
+			goto err_free;
+		}
+		/*
+		 * Static functions were appended by bpf_object__append_func_ptrs_code().
+		 * A global function is in the program only if the code refers to it.
+		 */
+		sec_insn_off = ptrs[i].text_off / BPF_INSN_SZ;
+		for (j = 0; j < prog->subprog_cnt; j++)
+			if (prog->subprogs[j].sec_insn_off == sec_insn_off)
+				break;
+		if (j == prog->subprog_cnt) {
+			pr_debug("prog '%s': map '%s': no function for the pointer at offset %zu, it's NULL\n",
+				 prog->name, map->name, ptrs[i].sec_off);
+			val = 0;
+		} else {
+			val = (__u64)prog->subprogs[j].sub_insn_off * BPF_INSN_SZ;
+		}
+		memcpy(data + ptrs[i].sec_off, &val, sizeof(val));
+	}
+
+	/*
+	 * The kernel takes any aligned 64-bit value that is equal to the offset
+	 * of a function for a pointer. Tell when it's going to get it wrong.
+	 */
+	for (i = 0, j = 0; i + sizeof(val) <= value_size; i += sizeof(val)) {
+		__u32 k;
+
+		while (j < cnt && ptrs[j].sec_off < i)
+			j++;
+		if (j < cnt && ptrs[j].sec_off == i)
+			continue;
+		memcpy(&val, data + i, sizeof(val));
+		if (!val || val % BPF_INSN_SZ)
+			continue;
+		for (k = 0; k < prog->subprog_cnt; k++) {
+			if ((__u64)prog->subprogs[k].sub_insn_off * BPF_INSN_SZ != val)
+				continue;
+			pr_warn("prog '%s': map '%s': value %llu at offset %zu is the offset of a function, the kernel will treat it as a pointer to it\n",
+				prog->name, map->name, (unsigned long long)val, i);
+			break;
+		}
+	}
+
+	opts.token_fd = obj->token_fd;
+	if (obj->token_fd)
+		opts.map_flags |= BPF_F_TOKEN_FD;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, map->name, sizeof(int), value_size, 1, &opts);
+	if (map_fd < 0) {
+		err = map_fd;
+		goto err_free;
+	}
+
+	err = bpf_map_update_elem(map_fd, &zero, data, 0);
+	if (!err)
+		err = bpf_map_freeze(map_fd);
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
+
+	tmp = libbpf_reallocarray(obj->func_ptr_maps, obj->func_ptr_map_cnt + 1,
+				  sizeof(*obj->func_ptr_maps));
+	if (!tmp) {
+		err = -ENOMEM;
+		goto err_close;
+	}
+	obj->func_ptr_maps = tmp;
+	obj->func_ptr_maps[obj->func_ptr_map_cnt].prog = prog;
+	obj->func_ptr_maps[obj->func_ptr_map_cnt].map_idx = map_idx;
+	obj->func_ptr_maps[obj->func_ptr_map_cnt].fd = map_fd;
+	obj->func_ptr_map_cnt++;
+
+	pr_debug("prog '%s': created a copy of map '%s' with %zu pointers to functions\n",
+		 prog->name, map->name, cnt);
+	free(data);
+	return map_fd;
+
+err_close:
+	close(map_fd);
+err_free:
+	free(data);
+	return err;
+}
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6508,7 +6682,19 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			if (relo->map_idx == obj->arena_map_idx)
 				insn[1].imm += obj->arena_data_off;
 
-			if (obj->gen_loader) {
+			if (map->autocreate && map->func_ptr_cnt && prog->has_callx) {
+				int map_fd;
+
+				/* the program gets its own map with pointers to its functions */
+				map_fd = create_func_ptr_map(obj, prog, relo->map_idx);
+				if (map_fd < 0) {
+					pr_warn("prog '%s': relo #%d: can't create a copy of map '%s' with pointers to functions\n",
+						prog->name, i, map->name);
+					return map_fd;
+				}
+				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+				insn[0].imm = map_fd;
+			} else if (obj->gen_loader) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
 			} else if (map->autocreate) {
@@ -6944,6 +7130,75 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 	return 0;
 }
 
+/* Append to the main program all functions that the data of the map points to */
+static int
+bpf_object__append_func_ptrs_code(struct bpf_object *obj, struct bpf_program *main_prog,
+				  const struct bpf_map *map)
+{
+	struct bpf_program *subprog;
+	size_t i, cnt, sec_insn_off;
+	struct func_ptr *ptrs;
+	int err;
+
+	ptrs = map->func_ptrs;
+	cnt = map->func_ptr_cnt;
+	for (i = 0; i < cnt; i++) {
+		sec_insn_off = ptrs[i].text_off / BPF_INSN_SZ;
+		subprog = find_prog_by_sec_insn(obj, obj->efile.text_shndx, sec_insn_off);
+		if (!subprog || subprog->sec_insn_off != sec_insn_off) {
+			pr_warn("prog '%s': map '%s': no function at .text+%zu for the pointer at offset %zu\n",
+				main_prog->name, map->name, ptrs[i].text_off, ptrs[i].sec_off);
+			return -LIBBPF_ERRNO__RELOC;
+		}
+
+		/*
+		 * callx can't call global functions. Don't add one to the
+		 * program only because the data points to it.
+		 */
+		if (subprog->sym_global)
+			continue;
+
+		/* see the comment in bpf_object__reloc_code() */
+		if (subprog->sub_insn_off == 0) {
+			err = bpf_object__append_subprog_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+			err = bpf_object__reloc_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/*
+ * The program that has callx might call any function that the data it refers
+ * to points to. Append them. Programs that don't have callx can't call them
+ * and the kernel doesn't look for pointers to functions in their data.
+ */
+static int
+bpf_object__append_func_ptrs(struct bpf_object *obj, struct bpf_program *prog)
+{
+	size_t i;
+	int err;
+
+	prog->has_callx = prog_has_callx(prog);
+	if (!prog->has_callx)
+		return 0;
+
+	/* relocations of the functions that are appended are appended too */
+	for (i = 0; i < prog->nr_reloc; i++) {
+		struct reloc_desc *relo = &prog->reloc_desc[i];
+
+		if (relo->type != RELO_DATA || !obj->maps[relo->map_idx].func_ptr_cnt)
+			continue;
+		err = bpf_object__append_func_ptrs_code(obj, prog, &obj->maps[relo->map_idx]);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * Relocate sub-program calls.
  *
@@ -7046,7 +7301,7 @@ bpf_object__relocate_calls(struct bpf_object *obj, struct bpf_program *prog)
 	if (err)
 		return err;
 
-	return 0;
+	return bpf_object__append_func_ptrs(obj, prog);
 }
 
 static void
@@ -7757,6 +8012,98 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	return 0;
 }
 
+/*
+ * Collect pointers to functions in a read-only data section. They are
+ * R_BPF_64_ABS64 relocations against .text section, where the offset of
+ * a static function in the section is stored in place. Relocations in data
+ * sections were ignored before pointers to functions were supported. Those
+ * that are something else, e.g. pointers to data, still are.
+ */
+static int bpf_object__collect_rodata_relos(struct bpf_object *obj,
+					    Elf64_Shdr *shdr, Elf_Data *data)
+{
+	size_t sec_idx = shdr->sh_info, sym_idx;
+	int i, nrels = shdr->sh_size / shdr->sh_entsize;
+	const char *relo_sec_name;
+	struct func_ptr *ptrs;
+	Elf_Data *scn_data;
+	Elf64_Sym *sym;
+	Elf64_Rel *rel;
+	__u64 addend;
+
+	relo_sec_name = elf_sec_str(obj, shdr->sh_name) ?: "<?>";
+	scn_data = obj->efile.secs[sec_idx].data;
+	if (!scn_data)
+		return -LIBBPF_ERRNO__FORMAT;
+
+	for (i = 0; i < nrels; i++) {
+		rel = elf_rel_by_idx(data, i);
+		if (!rel) {
+			pr_warn("sec '%s': failed to get relo #%d\n", relo_sec_name, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+
+		sym_idx = ELF64_R_SYM(rel->r_info);
+		sym = elf_sym_by_idx(obj, sym_idx);
+		if (!sym) {
+			pr_warn("sec '%s': symbol #%zu not found for relo #%d\n",
+				relo_sec_name, sym_idx, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+
+		if (ELF64_R_TYPE(rel->r_info) != R_BPF_64_ABS64 ||
+		    !sym_is_subprog(sym, obj->efile.text_shndx)) {
+			pr_debug("sec '%s': relo #%d: not a pointer to a function, skipping...\n",
+				 relo_sec_name, i);
+			continue;
+		}
+
+		/* the kernel finds aligned pointers only */
+		if (rel->r_offset % sizeof(__u64) || rel->r_offset >= scn_data->d_size ||
+		    scn_data->d_size - rel->r_offset < sizeof(__u64)) {
+			pr_debug("sec '%s': relo #%d: unsupported offset 0x%zx, skipping...\n",
+				 relo_sec_name, i, (size_t)rel->r_offset);
+			continue;
+		}
+
+		memcpy(&addend, scn_data->d_buf + rel->r_offset, sizeof(addend));
+		if (!is_native_endianness(obj))
+			addend = bswap_64(addend);
+		if ((sym->st_value + addend) % BPF_INSN_SZ) {
+			pr_debug("sec '%s': relo #%d: bad pointer to a function at offset %zu+%llu, skipping...\n",
+				 relo_sec_name, i, (size_t)sym->st_value,
+				 (unsigned long long)addend);
+			continue;
+		}
+
+		ptrs = libbpf_reallocarray(obj->func_ptrs, obj->func_ptr_cnt + 1, sizeof(*ptrs));
+		if (!ptrs)
+			return -ENOMEM;
+		obj->func_ptrs = ptrs;
+
+		ptrs[obj->func_ptr_cnt].sec_idx = sec_idx;
+		ptrs[obj->func_ptr_cnt].sec_off = rel->r_offset;
+		ptrs[obj->func_ptr_cnt].text_off = sym->st_value + addend;
+		obj->func_ptr_cnt++;
+
+		pr_debug("sec '%s': relo #%d: pointer at offset %zu to a function at .text+%zu\n",
+			 relo_sec_name, i, (size_t)rel->r_offset, (size_t)(sym->st_value + addend));
+	}
+	return 0;
+}
+
+static int cmp_func_ptrs(const void *_a, const void *_b)
+{
+	const struct func_ptr *a = _a;
+	const struct func_ptr *b = _b;
+
+	if (a->sec_idx != b->sec_idx)
+		return a->sec_idx < b->sec_idx ? -1 : 1;
+	if (a->sec_off != b->sec_off)
+		return a->sec_off < b->sec_off ? -1 : 1;
+	return 0;
+}
+
 static int bpf_object__collect_relos(struct bpf_object *obj)
 {
 	int i, err;
@@ -7779,7 +8126,9 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
-		if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
+		if (obj->efile.secs[idx].sec_type == SEC_RODATA)
+			err = bpf_object__collect_rodata_relos(obj, shdr, data);
+		else if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
@@ -7789,6 +8138,25 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			return err;
 	}
 
+	/* sort by section, so that pointers in the data of a map are next to each other */
+	if (obj->func_ptr_cnt)
+		qsort(obj->func_ptrs, obj->func_ptr_cnt, sizeof(*obj->func_ptrs), cmp_func_ptrs);
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		struct bpf_map *map = &obj->maps[i];
+		size_t j;
+
+		if (map->libbpf_type != LIBBPF_MAP_RODATA)
+			continue;
+		for (j = 0; j < obj->func_ptr_cnt; j++) {
+			if (obj->func_ptrs[j].sec_idx != map->sec_idx)
+				continue;
+			if (!map->func_ptr_cnt)
+				map->func_ptrs = &obj->func_ptrs[j];
+			map->func_ptr_cnt++;
+		}
+	}
+
 	bpf_object__sort_relos(obj);
 	return 0;
 }
@@ -9749,6 +10117,11 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
 
+	for (i = 0; i < obj->func_ptr_map_cnt; i++)
+		close(obj->func_ptr_maps[i].fd);
+	zfree(&obj->func_ptr_maps);
+	zfree(&obj->func_ptrs);
+
 	if (obj->btf_module_allowlist) {
 		for (i = 0; i < obj->btf_module_allowlist_cnt; i++)
 			zfree(&obj->btf_module_allowlist[i]);
-- 
2.55.0

