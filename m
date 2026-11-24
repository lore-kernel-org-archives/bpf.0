Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560515;
	b=J+jKBx9q5lp5PWAPQZ9AKqqv2gYjRtza/si2IqV9a85ETd7h1I3EWsiqEmrAZcat9p1w
	 wnWlkMdrzLM9NodggA78Q0fd8FwKhIf/MnCrzB+y1XvjuDoiBgQSsMwvieN9IV5jFjzyj
	 sWvEjqNJuoTMpPrgIDZ8hWADdd8ynPLaTfEGMWRV6s5Q4YbRKXejr6r3TahCXT1Dk9swC
	 3GYmUl1JCCFiouUTUHIeM6TdMJEX/nAyCZWcjqLkHGEslKT+IP6CoptI7/+BJIehHKBhH
	 KtYR0GKNGrhtJoDaw6zBa09opmlcGLydRGlWHt0jdzGbvLk23HdpPbFjG67WSCERtZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560515;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PYamhRQOUAMH4IpUvyw7uO6fx6sGOnTA1LN/Gj4PzBE=;
	b=umS2xHIyOwedhDzAb1NnrGodLX6KfEQVhHdMr3OYowAcKlAVZ8701WbKykn5HVZHbUQc
	 Euwu8j8ALFDqXZFNL6/5lUb8qtirMcD5nGkeaspBQ4x90WbncmoSBTVkCwoCivWmzsBsh
	 58EFpZWBktYIW4pvJvK90qitAf3Wy+CZlR/lp3iUQ4PPojzf6MoPu5DQZsXHVdccTZpSZ
	 z/ociDvuuEuFRznsyVVQ2CF7/BY/etnhC3x4sUzvwJfljYK87gd0ZKIsZGZj6SWoA3Fzb
	 VQlyfIiOkFAuKB1FC+frlb28vWUTh0fn3cRHArvPwN7CS3HsOSBgefzAs3mgRWN7X6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fYPB+wp1;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4283606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4283606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fYPB+wp1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VZkDnUf7VacUM36nrmY/9dr6ql3Gg9+A7nyy5as6cwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560512; v=1; x=1796165312;
 b=fYPB+wp1MomSblCJgxR+GY0HwhoRNrALCNStFFA5ytFU5L5TQZdzkbTRLmIXFW7+cnFFxYTK
 bLO6P/SoCQ0X27ia9uMGAaLW2tq2PHDI/pK1c977mIbkkgiKbNprxQ5lDXq5edJFdhr5x6UY55M
 ieILtGPw1JKEb6RZoWu0JRg4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4160e48562f50284;
	Tue, 24 Nov 2026 22:48:32 +0000
X-Mizu-Trace-ID: 4160e48562f50284
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 3/6] libbpf: Resolve kfunc variants by prototype
Date: Tue, 24 Nov 2026 15:48:08 -0700
Message-ID: <20261124224811.16134-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124224811.16134-1-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
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

libbpf resolves a kfunc declaration by exact name, after dropping its
last ___ suffix, and only then checks the prototype. The name alone
picks the kernel function, so the kernel can't serve both prototypes of
a changed kfunc. For example, vmlinux.h declares:

  bool scx_bpf_dsq_move_to_local(u64 dsq_id);
  bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags);

libbpf resolves the second to scx_bpf_dsq_move_to_local() and rejects
its prototype. Keeping the old prototype as ___v1 and giving the new
one the unsuffixed name would break old declarations the same way.

Select a kfunc in two steps instead:

  1. Collect the functions in vmlinux and module BTFs with the same
     essential name as the declaration, as CO-RE does for types. The
     "bpf_kfunc" decl tag is ignored.

  2. Resolve the candidate with a compatible prototype. If there is
     none, a __weak kfunc stays unresolved. More than one is an error,
     even for a __weak kfunc.

The prototype check is stricter than bpf_core_types_are_compat(). It
also compares the names of structs, unions and forward declarations,
ignoring ___ suffixes. Members aren't compared. Typedefs and qualifiers
are skipped. For example:

  typedef struct foo foo_t;

  void kfunc(struct foo *arg);
  void kfunc(struct foo___local *arg);
  void kfunc(foo_t *arg);

are compatible, but not with:

  void kfunc(struct bar *arg);

So a declaration with an outdated struct name no longer resolves. For
example, commit 8740156ad33b ("bpf: Require a BPF cpumask for
bpf_cpumask_populate()") changed:

  before: int bpf_cpumask_populate(struct cpumask *, void *, size_t);
  after:  int bpf_cpumask_populate(struct bpf_cpumask *, void *, size_t);

Each declaration now resolves only on a kernel with the same prototype.
A stacked suffix, as in foo___v2___compat, no longer resolves foo___v2,
because its essential name is foo___v2. compat.bpf.h now tries foo___v2
first.

Module BTFs are now loaded for every object with kfuncs: 0.5 and 1.4 ms
for 8 and 32 small modules in a VM. Lookup cost per kfunc:

                        before (hit / miss)   after
  sorted, 23 modules    0.14 / 0.65 us        0.8 us
  unsorted (v6.18)      0.1 / 0.5 ms          0.7 ms

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c             |  99 +++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.c          | 112 ++++++++++++++++++++++----------
 tools/lib/bpf/libbpf_internal.h |   2 +
 tools/lib/bpf/libbpf_tools.h    |   2 +
 4 files changed, 178 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index a4bf01403a43..71cba0b9bbfe 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1140,7 +1140,7 @@ static void btf_check_sorted(struct btf *btf)
 }
 
 static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *name,
-					   __s32 start_id)
+					   size_t name_len, __s32 start_id)
 {
 	const struct btf_type *t;
 	const char *tname;
@@ -1152,7 +1152,7 @@ static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *na
 		m = l + (r - l) / 2;
 		t = btf_type_by_id(btf, m);
 		tname = btf__str_by_offset(btf, t->name_off);
-		if (strcmp(tname, name) >= 0) {
+		if (strncmp(tname, name, name_len) >= 0) {
 			if (l == r)
 				return r;
 			r = m;
@@ -1164,6 +1164,99 @@ static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *na
 	return btf__type_cnt(btf);
 }
 
+/*
+ * Set [*start, *end) to the range of own type IDs that may match the
+ * first name_len bytes of name. For unsorted BTF, include all own type IDs.
+ */
+void btf_name_prefix_range(const struct btf *btf, const char *name, size_t name_len,
+			   __u32 *start, __u32 *end)
+{
+	__u32 i, n = btf__type_cnt(btf);
+
+	if (btf->named_start_id <= 0) {
+		*start = btf->start_id;
+		*end = n;
+		return;
+	}
+	*start = btf_find_type_by_name_bsearch(btf, name, name_len, btf->named_start_id);
+	for (i = *start; i < n; i++) {
+		const struct btf_type *t = btf_type_by_id(btf, i);
+		const char *tname = btf__str_by_offset(btf, t->name_off);
+
+		if (strncmp(tname, name, name_len) != 0)
+			break;
+	}
+	*end = i;
+}
+
+static __u16 kfunc_type_kind(const struct btf_type *t)
+{
+	if (btf_is_fwd(t))
+		return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
+	if (btf_is_enum64(t))
+		return BTF_KIND_ENUM;
+	return btf_kind(t);
+}
+
+/*
+ * Return 1 if the types match, 0 if they don't, or -EINVAL if a type
+ * can't be looked up or the types nest deeper than depth.
+ */
+static int kfunc_type_match(const struct btf *a, __u32 a_id,
+			    const struct btf *b, __u32 b_id, int depth)
+{
+	const struct btf_type *at = skip_mods_and_typedefs(a, a_id, NULL);
+	const struct btf_type *bt = skip_mods_and_typedefs(b, b_id, NULL);
+	__u16 kind;
+	int i, ret;
+
+	if (!at || !bt || !depth)
+		return -EINVAL;
+
+	kind = kfunc_type_kind(at);
+	if (kind != kfunc_type_kind(bt))
+		return 0;
+
+	switch (kind) {
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION: {
+		const char *an = btf__name_by_offset(a, at->name_off);
+		const char *bn = btf__name_by_offset(b, bt->name_off);
+		size_t name_len = bpf_core_essential_name_len(an);
+
+		return name_len == bpf_core_essential_name_len(bn) &&
+		       strncmp(an, bn, name_len) == 0;
+	}
+	case BTF_KIND_UNKN:
+	case BTF_KIND_ENUM:
+		return 1;
+	case BTF_KIND_INT:
+		return btf_int_offset(at) == 0 && btf_int_offset(bt) == 0;
+	case BTF_KIND_PTR:
+		return kfunc_type_match(a, at->type, b, bt->type, depth - 1);
+	case BTF_KIND_ARRAY:
+		return kfunc_type_match(a, btf_array(at)->type, b, btf_array(bt)->type, depth - 1);
+	case BTF_KIND_FUNC_PROTO:
+		if (btf_vlen(at) != btf_vlen(bt))
+			return 0;
+		for (i = 0; i < btf_vlen(at); i++) {
+			ret = kfunc_type_match(a, btf_params(at)[i].type,
+					       b, btf_params(bt)[i].type, depth - 1);
+			if (ret <= 0)
+				return ret;
+		}
+		return kfunc_type_match(a, at->type, b, bt->type, depth - 1);
+	default:
+		return 0;
+	}
+}
+
+int btf_kfunc_proto_match(const struct btf *a, __u32 a_id,
+			  const struct btf *b, __u32 b_id)
+{
+	return kfunc_type_match(a, a_id, b, b_id, 32);
+}
+
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __s32 kind)
 {
@@ -1185,7 +1278,7 @@ static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 
 	if (btf->named_start_id > 0 && type_name[0]) {
 		start_id = max(start_id, btf->named_start_id);
-		id = btf_find_type_by_name_bsearch(btf, type_name, start_id);
+		id = btf_find_type_by_name_bsearch(btf, type_name, strlen(type_name), start_id);
 		for (; id < nr_types; id++) {
 			t = btf__type_by_id(btf, id);
 			tname = btf__str_by_offset(btf, t->name_off);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..dadf446daa0b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -641,7 +641,6 @@ struct extern_desc {
 	int btf_id;
 	int sec_btf_id;
 	char *name;
-	char *essent_name;
 	bool is_set;
 	bool is_weak;
 	union {
@@ -4446,7 +4445,6 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 	struct extern_desc *ext;
 	int i, n, off, dummy_var_btf_id;
 	const char *ext_name, *sec_name;
-	size_t ext_essent_len;
 	Elf_Scn *scn;
 	Elf64_Shdr *sh;
 
@@ -4498,14 +4496,6 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 		ext->sym_idx = i;
 		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
 
-		ext_essent_len = bpf_core_essential_name_len(ext->name);
-		ext->essent_name = NULL;
-		if (ext_essent_len != strlen(ext->name)) {
-			ext->essent_name = strndup(ext->name, ext_essent_len);
-			if (!ext->essent_name)
-				return -ENOMEM;
-		}
-
 		ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
 		if (ext->sec_btf_id <= 0) {
 			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
@@ -9513,41 +9503,96 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 	return 0;
 }
 
+/* t is a FUNC whose essential name is the first name_len bytes of name */
+static bool btf_is_kfunc_candidate(const struct btf *btf, const struct btf_type *t,
+				   const char *name, size_t name_len)
+{
+	const char *tname;
+
+	if (!btf_is_func(t))
+		return false;
+	tname = btf__name_by_offset(btf, t->name_off);
+	if (strncmp(tname, name, name_len) != 0)
+		return false;
+	return bpf_core_essential_name_len(tname) == name_len;
+}
+
+/*
+ * Search vmlinux and module BTFs. Return:
+ *   - a BTF ID for a unique match;
+ *   - -ESRCH if the family is absent;
+ *   - -EINVAL if no candidate has a compatible prototype;
+ *   - -ENOTUNIQ if more than one candidate has a compatible prototype.
+ */
+static int find_kfunc_btf_id(struct bpf_object *obj, const struct extern_desc *ext,
+			     struct btf **res_btf, struct module_btf **res_mod_btf)
+{
+	size_t name_len = bpf_core_essential_name_len(ext->name);
+	int kfunc_id = 0, nr_cands = 0;
+	size_t i;
+
+	for (i = 0; i <= obj->btf_module_cnt; i++) {
+		struct module_btf *mod = i ? &obj->btf_modules[i - 1] : NULL;
+		struct btf *btf = mod ? mod->btf : obj->btf_vmlinux;
+		__u32 id, end;
+
+		btf_name_prefix_range(btf, ext->name, name_len, &id, &end);
+		for (; id < end; id++) {
+			const struct btf_type *t = btf__type_by_id(btf, id);
+
+			if (!btf_is_kfunc_candidate(btf, t, ext->name, name_len))
+				continue;
+			nr_cands++;
+			if (btf_kfunc_proto_match(obj->btf, ext->ksym.type_id, btf, t->type) <= 0)
+				continue;
+			if (kfunc_id)
+				return -ENOTUNIQ;
+			kfunc_id = id;
+			*res_btf = btf;
+			*res_mod_btf = mod;
+		}
+	}
+	if (!nr_cands)
+		return -ESRCH;
+	if (!kfunc_id)
+		return -EINVAL;
+	return kfunc_id;
+}
+
 static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 						struct extern_desc *ext)
 {
-	int local_func_proto_id, kfunc_proto_id, kfunc_id;
 	struct module_btf *mod_btf = NULL;
 	const struct btf_type *kern_func;
 	struct btf *kern_btf = NULL;
-	int ret;
+	int kfunc_id, ret;
 
-	local_func_proto_id = ext->ksym.type_id;
+	ret = load_module_btfs(obj);
+	if (ret)
+		return ret;
 
-	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
-				    &mod_btf);
-	if (kfunc_id < 0) {
-		if (kfunc_id == -ESRCH && ext->is_weak)
+	kfunc_id = find_kfunc_btf_id(obj, ext, &kern_btf, &mod_btf);
+	if (kfunc_id == -ESRCH) {
+		if (ext->is_weak)
 			return 0;
 		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n",
 			ext->name);
 		return kfunc_id;
 	}
-
-	kern_func = btf__type_by_id(kern_btf, kfunc_id);
-	kfunc_proto_id = kern_func->type;
-
-	ret = bpf_core_types_are_compat(obj->btf, local_func_proto_id,
-					kern_btf, kfunc_proto_id);
-	if (ret <= 0) {
+	if (kfunc_id == -EINVAL) {
 		if (ext->is_weak)
 			return 0;
-
-		pr_warn("extern (func ksym) '%s': func_proto [%d] incompatible with %s [%d]\n",
-			ext->name, local_func_proto_id,
-			mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_id);
-		return -EINVAL;
+		pr_warn("extern (func ksym) '%s': no compatible prototype in kernel or module BTFs\n",
+			ext->name);
+		return kfunc_id;
 	}
+	/* an error even for a weak kfunc: ambiguity isn't absence */
+	if (kfunc_id == -ENOTUNIQ) {
+		pr_warn("extern (func ksym) '%s': more than one compatible prototype in kernel or module BTFs\n",
+			ext->name);
+		return kfunc_id;
+	}
+	kern_func = btf__type_by_id(kern_btf, kfunc_id);
 
 	/* set index for module BTF fd in fd_array, if unset */
 	if (mod_btf && !mod_btf->fd_array_idx) {
@@ -9579,8 +9624,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 	 * {kernel_btf_id, kernel_btf_obj_fd} -> fixup ld_imm64.
 	 */
 	ext->ksym.kernel_btf_obj_fd = mod_btf ? mod_btf->fd : 0;
-	pr_debug("extern (func ksym) '%s': resolved to %s [%d]\n",
-		 ext->name, mod_btf ? mod_btf->name : "vmlinux", kfunc_id);
+	pr_debug("extern (func ksym) '%s': resolved to %s '%s' [%d]\n",
+		 ext->name, mod_btf ? mod_btf->name : "vmlinux",
+		 btf__name_by_offset(kern_btf, kern_func->name_off), kfunc_id);
 
 	return 0;
 }
@@ -10441,10 +10487,8 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
 
-	for (i = 0; i < obj->nr_extern; i++) {
+	for (i = 0; i < obj->nr_extern; i++)
 		zfree(&obj->externs[i].name);
-		zfree(&obj->externs[i].essent_name);
-	}
 
 	zfree(&obj->externs);
 	obj->nr_extern = 0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 8e6f15e2f1bf..389c48548222 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -215,6 +215,8 @@ struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
 		 __u32 **str_map);
+void btf_name_prefix_range(const struct btf *btf, const char *name, size_t name_len,
+			   __u32 *start, __u32 *end);
 bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
diff --git a/tools/lib/bpf/libbpf_tools.h b/tools/lib/bpf/libbpf_tools.h
index 5c8d6d0d2fdd..cd9137376d44 100644
--- a/tools/lib/bpf/libbpf_tools.h
+++ b/tools/lib/bpf/libbpf_tools.h
@@ -52,6 +52,8 @@ struct bpf_core_cand;
 struct bpf_core_cand_list;
 
 const struct btf_header *btf_header(const struct btf *btf);
+int btf_kfunc_proto_match(const struct btf *a, __u32 a_id,
+			  const struct btf *b, __u32 b_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
 
-- 
2.56.0

