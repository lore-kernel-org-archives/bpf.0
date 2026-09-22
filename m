Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11918364EBF
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039653; cv=none; b=ZNGoMZvrygvTJcZuHqLr513G8PPGWDquvPu+zU5x/gsiiav/43+MJW/AWkjWmQEBsVb3eYz1NCxfPhF1FZMiOwF6k9Ho9dCZRy0ZmncvbdUur+7vYbw2732mTtHXZtgDnQGRO1sCQZX7Shmp5Lj4AuQW/lvHR/b5EbfVSzJ6jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039653; c=relaxed/simple;
	bh=+ncWOSGiPAk3T9xYN2qKqjxmQ86dJRmkFBCwiGNp9mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt5Y9kShGTYVIR9wmJynYOIAa6i2VCEcLMsIa6YkouGbK0OH7bV6IHNEbQ+6R8HPhYrBPLIfFvZxmSxmUCEqKD/RS+9YgjqUBXi3RqHTczQAIWfgry1YeaVXliLTzTqp6iPrSZ8pcRWetq/J6P2/bROI/OCACkwS15Reka5r5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp1VjKHS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp1VjKHS"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so3278611a91.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039650; x=1790644450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/17dMkUtlGWbStX4p1G7fOP1EcRjexqhEECtt1XgnA=;
        b=Xp1VjKHSUAicvbDAgjsy2GLUtGkRXuBuKbxNhh7UQnVfZryRJYkX4/SIm7iEV5oq68
         EIcStY6Bkf2m42D4USjfYLa96sSilVEOwcN4Kig4m2N/3Xmu2t+aqFbwI6VwywPfEDAx
         rvv2e+vR5YIOui78ceAP1ng6jrQ2oHFUYy7mg8OpAha9Sgo9eocpMQ4O2su1RZNkaGKM
         IRI8hUIbSQA1siz16tCWSgkvi+/KJstpYTKi4ZCQJkNXqZHx7yX4nj+ppCubSvo7D4MV
         KOpe43j/UqvIVF1vOytQc8/RPkieZGz7kKnLqoTtOgBIosdAj6QiUmd41VVkrhshoojN
         mYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039650; x=1790644450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/17dMkUtlGWbStX4p1G7fOP1EcRjexqhEECtt1XgnA=;
        b=zQu+Phz5gmNZum+AllVd5CsLMEG6uNKWhry40lDwcU8UDQD3FhAspaxKrG2Sl+aFA0
         JzwZ8Ld4cYl5itpKFYHZJwUcyWOdO982qbRo+UOqfUdmXhfHI16H7YduTgEhTq/z+cn8
         ST0K+M4MvzvARoXlXrlvh0TA56MmNtaMWVb0pgoDfPF6+6N/ZVygDiDGzDN/tHr6/APk
         E35qJNNSRXuoBwKGnooNgGqDcgaoATiYQR5BRurRh5ZHsrI02jcfFaXhKzomkq6NDTbK
         T3cTQQqgJ9XhOoMSdPfVd32PNN/TinrdRTzgIoPdw3LMQWGiLcCV+7406XB6DYaRzFpM
         0oOg==
X-Gm-Message-State: AFuF++myToWhjZY2zbsya/CvoPoRLSLbdjcM6MYE/K/4BoS3gCin0f28
	cqanmOTIeLajM4Jqovn/ciuKjZdU29wCK9q1JVurT/bibb1k2C5h4v6tfy+mIA==
X-Gm-Gg: AYBFou0ryl6zNcUsR1ldXwNX8PFxkNPdLHqJRHp0R95t5HypBuCYxzU2FSZOm7CYC8V
	APvb3THMBciRSvAJVtkS9NQOtouVED1dPyEp2h+gyaZfhXz10cE3fmttas5w6h1VUSF3zf66Ow8
	azWb0bs7IENU2uX5J3gZHo2iEbccpDEjbA3QZT+OKB5RTEA2O9P06Ie4t+degQTB6RSF4e7fObm
	N0Y2UbFDXvazEhJxZ7VYqqNVFTNbH8sA68Xsip1QTgM82ISy6rWgE/PUyVUXQ56/gS5lYbyOEdj
	qSH8BDbri42ur03ybZvaUXV+JYdtRZCyNkD5iSM+hxfvZ7zqetlbBI/jxFQvr1x7pP1ql4IQO6L
	4kHcS97A8doD35AFTXns3RMy6kXMtiAMc5NGSBZrMfMtvzOZlxF6/qq8RrhXrOl6zWkbgdDkqUQ
	1owg531wzRsf+J4+8EsetYjtN14DCmptG2GgGxptS0XCiIVtPlUqyh87iKK55Zl4ICtsdVRnKb1
	em3qGXkFkOQ7RSnj3m43wOcfyWLK3kAKI+9FkgV31zKUM7TQ1C18boe8t79vuQLES2hPGOv/OnY
	KiajdAJMAS6IKOZDmpTkvBlirCj9IJaaIJK8FYObibI=
X-Received: by 2002:a17:90b:5808:b0:3a0:3673:dbc0 with SMTP id 98e67ed59e1d1-3a03673ddbbmr8223665a91.49.1790039649816;
        Mon, 21 Sep 2026 18:14:09 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5cb445sm246132a91.15.2026.09.21.18.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 12/17] libbpf: Resolve pointers to functions in read-only data
Date: Tue, 22 Sep 2026 01:13:18 +0000
Message-ID: <20260922011323.1298619-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
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

- Append all static functions that the section points to to the prog
  that refers to the section, since any of them can be called. callx
  cannot call global functions. Don't pull them in. Such pointer is NULL.

- Functions have different offsets in different progs, so create a copy
  of the map per prog and store the offsets there. The kernel replaces
  them with addresses at load and the prog must be the only user of
  the map. The map of the section itself is left as-is.

- The kernel treats any aligned u64 that matches an offset of a static
  function as a pointer. Warn if data has one that isn't.

Light skeleton is not supported yet.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 372 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 369 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cd1ea1bb53cb..9538a21f0db4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -601,6 +601,9 @@ struct bpf_map {
 	bool autoattach;
 	__u64 map_extra;
 	struct bpf_program *excl_prog;
+	/* pointers to functions in the data of an internal map, see obj->func_ptrs */
+	struct func_ptr *func_ptrs;
+	size_t func_ptr_cnt;
 };
 
 enum extern_type {
@@ -780,6 +783,29 @@ struct bpf_object {
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
@@ -845,6 +871,17 @@ static bool insn_is_pseudo_func(struct bpf_insn *insn)
 	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
+/*
+ * ld_imm64 that loads the address of read-only data with pointers to functions
+ * is marked by bpf_object__relocate() before the code is relocated. Compilers
+ * leave src_reg of other ld_imm64 zero and it's set by
+ * bpf_object__relocate_data() later.
+ */
+static bool insn_is_func_ptrs_addr(struct bpf_insn *insn)
+{
+	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_MAP_VALUE;
+}
+
 static int
 bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		      const char *name, size_t sec_idx, const char *sec_name,
@@ -4068,8 +4105,14 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -6471,6 +6514,137 @@ static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struc
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
+	data = malloc(value_size);
+	if (!data)
+		return -ENOMEM;
+
+	/* the content of the map is final, it's frozen already */
+	if (map->mmaped) {
+		memcpy(data, map->mmaped, value_size);
+	} else if (bpf_map_lookup_elem(map->fd, &zero, data)) {
+		err = -errno;
+		pr_warn("prog '%s': map '%s': failed to read the content: %s\n",
+			prog->name, map->name, errstr(err));
+		goto err_free;
+	}
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
+			if (map->autocreate && map->func_ptr_cnt) {
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
@@ -6835,6 +7021,51 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
 	return 0;
 }
 
+static int
+bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
+		       struct bpf_program *prog);
+
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
 static int
 bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		       struct bpf_program *prog)
@@ -6851,6 +7082,20 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 
 	for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
 		insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
+		if (insn_is_func_ptrs_addr(insn)) {
+			/*
+			 * The code that loads the address of the data might
+			 * call any function that the data points to.
+			 */
+			relo = find_prog_insn_relo(prog, insn_idx);
+			if (relo && relo->type == RELO_DATA) {
+				err = bpf_object__append_func_ptrs_code(obj, main_prog,
+									&obj->maps[relo->map_idx]);
+				if (err)
+					return err;
+			}
+			continue;
+		}
 		if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
 			continue;
 
@@ -7541,6 +7786,9 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 			/* mark the insn, so it's recognized by insn_is_pseudo_func() */
 			if (relo->type == RELO_SUBPROG_ADDR)
 				insn[0].src_reg = BPF_PSEUDO_FUNC;
+			/* and by insn_is_func_ptrs_addr() */
+			if (relo->type == RELO_DATA && obj->maps[relo->map_idx].func_ptr_cnt)
+				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
 		}
 	}
 
@@ -7757,6 +8005,98 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
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
@@ -7779,7 +8119,9 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
 
-		if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
+		if (obj->efile.secs[idx].sec_type == SEC_RODATA)
+			err = bpf_object__collect_rodata_relos(obj, shdr, data);
+		else if (obj->efile.secs[idx].sec_type == SEC_ST_OPS)
 			err = bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx == obj->efile.btf_maps_shndx)
 			err = bpf_object__collect_map_relos(obj, shdr, data);
@@ -7789,6 +8131,25 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
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
@@ -9749,6 +10110,11 @@ void bpf_object__close(struct bpf_object *obj)
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

