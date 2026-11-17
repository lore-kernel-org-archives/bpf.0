Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943329;
	b=LEDgDJ9lHJ1lc8CS32yVmAWH36D4rbhBVIswF3LP+/ro8CePUy0Z91R6CJ0NtamqdsF/
	 Hbp/OW84Xy/NModCMrXDYVoN/lA3MDmOM7imgJu4HCRieBy2IbmQi6rDrrsq7ueA1pb48
	 vV9bsHnc0sjOR03ebNckIUSwJlItNzkUw8TdvxFRtGzP4ZSCDcDi8r9U/EyKMlb68t7s2
	 fsUvtLDm745xNWWtYqPTahe3vSQjE0YaAbScedYnag4mZ/45oIwovHDxZy2EyKEURFghB
	 /GIdCY3ty/eyoPn30V/JRe7ij3xDzQ4djk3xr2H9eQ4mEzvE2T1qC3bhEevZflOH9Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943329;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+qxp1esyIUrBFvVUQXu4Fp0WugiEP0FEew9x0QA2Wgs=;
	b=slOVZSrYLVUYcZvYyjVctrdv/SnkQOHdGh6IKdG0biQl/2rnGXja94lL3hK+5BdWjJSX
	 bNPJX/7Wki4dv0IuR8GcdsORmck0v8FpXUXtt2kE/N/Cri+a+r4LnYmyiGdJNsRH6jKN9
	 z+yTlRBP5xkeinXlIuPhOWmG5QsGMrZeVd7+clKGwa1Q2ocWeNQXxMYFdv9XdNLc0215e
	 /RvNS1ExlpSB7SJdGmeeZA0pq/WACFPKzLDXwf/HEqEOfOOhiX3JZzZcDPOcmGWyKn0tg
	 oBl4WHp5iP6EKorV8P6nig9+/yUijrBwRsoXLodOsAhBdFj+mYBWWXs8NvFoPiS33jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Lv8z0Wqu;
	arc=none smtp.remote-ip=95.215.58.159
Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C60606A337
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C60606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Lv8z0Wqu
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mAKwi96oY/q+eQn01d5OThbyg3FcYSu5b7y3y9Tyctw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943325; v=1; x=1795548125;
 b=Lv8z0WquneSYFHHFwhc0jtOowb21mNFlHFqhESpwEn5QG9wWBBIQjkomDr26CkaK/QM8WlEL
 rKOhHl8IbNa5QADR+o7LX7c1S4mJUNIZISHeXtyFYvxzZAldDbeWUjwIrHQhijRovPu0oGbNIRX
 akRmVGV6L/zOlu6AS2beB/Wo=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8aa539796b05af36;
	Tue, 17 Nov 2026 19:22:05 +0000
X-Mizu-Trace-ID: 8aa539796b05af36
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
Subject: [PATCH bpf-next v1 1/4] libbpf: Fall back to kernel ___ flavors when resolving kfuncs
Date: Tue, 17 Nov 2026 12:21:50 -0700
Message-ID: <20261117192153.3384031-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

When resolving a kfunc, libbpf strips the ___<flavor> suffix from its
name and binds the kfunc with the resulting name if its prototype is
compatible. So when a kfunc foo changes its prototype, the kernel can't
keep the old one available to existing BPF programs as foo___v1: they
declare foo, and libbpf never looks at foo___v1.

sched_ext worked around this by giving the new prototype the name
scx_bpf_dsq_insert___v2 and spelling it scx_bpf_dsq_insert___v2___compat
in BPF programs, so that the stripped name matches the kernel name
exactly. That leaks kernel naming into BPF programs, and calling the
kfunc as vmlinux.h declares it fails: scx_bpf_dsq_insert___v2 strips to
scx_bpf_dsq_insert, whose prototype is incompatible.

If the kfunc with the stripped name is missing or its prototype is
incompatible, look among the kfuncs named <name>___<flavor>, in vmlinux
first and then in the first module that has any, and bind the one whose
prototype is compatible. Only FUNCs with the bpf_kfunc decl tag are
candidates. More than one compatible flavor is an error even for a kfunc
declared __weak: ambiguity isn't absence.

The lookup of the stripped name comes first and is unchanged, so
bindings that work today stay the same.

Print the name of the chosen kfunc in the debug message.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c             |  26 ++++++
 tools/lib/bpf/libbpf.c          | 140 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   1 +
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index a4bf01403a43..9eb13c8a95a5 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1164,6 +1164,32 @@ static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const char *na
 	return btf__type_cnt(btf);
 }
 
+/*
+ * Set [*start, *end) to the IDs of btf's own types that can have a name
+ * starting with prefix. On BTF sorted by name these are exactly the ones that
+ * do, a contiguous run found by binary search; otherwise all own types.
+ */
+void btf_name_prefix_range(const struct btf *btf, const char *prefix, __u32 *start, __u32 *end)
+{
+	__u32 i, n = btf__type_cnt(btf);
+	size_t len = strlen(prefix);
+
+	if (btf->named_start_id <= 0) {
+		*start = btf->start_id;
+		*end = n;
+		return;
+	}
+	*start = btf_find_type_by_name_bsearch(btf, prefix, btf->named_start_id);
+	for (i = *start; i < n; i++) {
+		const struct btf_type *t = btf_type_by_id(btf, i);
+		const char *name = btf__str_by_offset(btf, t->name_off);
+
+		if (strncmp(name, prefix, len) != 0)
+			break;
+	}
+	*end = i;
+}
+
 static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 				   const char *type_name, __s32 kind)
 {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..9089e9c55dfd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9513,6 +9513,130 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 	return 0;
 }
 
+/* t is the bpf_kfunc decl tag of FUNC id */
+static inline bool btf_is_kfunc_tag(const struct btf *btf, const struct btf_type *t, int id)
+{
+	const char *name;
+
+	if (!btf_is_decl_tag(t) || t->type != id)
+		return false;
+	if (btf_decl_tag(t)->component_idx != -1)
+		return false;
+	name = btf__name_by_offset(btf, t->name_off);
+	return strcmp(name, "bpf_kfunc") == 0;
+}
+
+/* FUNC id has the bpf_kfunc decl tag */
+static bool btf_is_kfunc(const struct btf *btf, int id)
+{
+	__u32 i, n;
+
+	btf_name_prefix_range(btf, "bpf_kfunc", &i, &n);
+	for (; i < n; i++) {
+		if (btf_is_kfunc_tag(btf, btf__type_by_id(btf, i), id))
+			return true;
+	}
+	return false;
+}
+
+/* id is a kfunc named <name>___<flavor>, where len is strlen(name) */
+static bool btf_is_kfunc_flavor(const struct btf *btf, int id, const char *name, size_t len)
+{
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	const char *kname;
+
+	if (!btf_is_func(t))
+		return false;
+	kname = btf__name_by_offset(btf, t->name_off);
+	if (strncmp(kname, name, len) != 0)
+		return false;
+	/* kname is <name> itself, already tried by the exact lookup */
+	if (kname[len] == '\0')
+		return false;
+	if (bpf_core_essential_name_len(kname) != len)
+		return false;
+	return btf_is_kfunc(btf, id);
+}
+
+/*
+ * Find the kfunc named <name>___<flavor> among btf's own types whose
+ * prototype is compatible with ext's.
+ *
+ * Returns the kfunc's type id, 0 if no flavor is compatible, -ESRCH if there
+ * are no flavors, or -ENOTUNIQ if more than one is compatible.
+ */
+static int find_kfunc_flavor(const struct bpf_object *obj, const struct extern_desc *ext,
+			     const struct btf *btf)
+{
+	const char *name = ext->essent_name ?: ext->name;
+	size_t len = strlen(name);
+	bool has_flavors = false;
+	int found = 0;
+	__u32 i, n;
+
+	btf_name_prefix_range(btf, name, &i, &n);
+	for (; i < n; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		if (!btf_is_kfunc_flavor(btf, i, name, len))
+			continue;
+		has_flavors = true;
+		if (bpf_core_types_are_compat(obj->btf, ext->ksym.type_id, btf, t->type) <= 0)
+			continue;
+		if (found)
+			return -ENOTUNIQ;
+		found = i;
+	}
+	if (!has_flavors)
+		return -ESRCH;
+	return found;
+}
+
+/*
+ * Like find_ksym_btf_id(), but for a ___flavor of ext's kfunc: vmlinux first,
+ * then the first module that has any. *res_btf and *res_mod_btf are only set
+ * when a compatible flavor is found.
+ */
+static int find_kfunc_flavor_btf_id(struct bpf_object *obj, const struct extern_desc *ext,
+				    struct btf **res_btf, struct module_btf **res_mod_btf)
+{
+	struct module_btf *mod_btf = NULL;
+	struct btf *btf = obj->btf_vmlinux;
+	int i, id, err;
+
+	id = find_kfunc_flavor(obj, ext, btf);
+	if (id == -ESRCH) {
+		err = load_module_btfs(obj);
+		if (err)
+			return err;
+
+		for (i = 0; i < obj->btf_module_cnt && id == -ESRCH; i++) {
+			mod_btf = &obj->btf_modules[i];
+			btf = mod_btf->btf;
+			id = find_kfunc_flavor(obj, ext, btf);
+		}
+	}
+	if (id > 0) {
+		*res_btf = btf;
+		*res_mod_btf = mod_btf;
+	}
+	return id;
+}
+
+/* ext's kfunc is missing, or kfunc_id's prototype is incompatible with ext's */
+static bool need_kfunc_flavor(const struct bpf_object *obj, const struct extern_desc *ext,
+			      const struct btf *kern_btf, int kfunc_id)
+{
+	const struct btf_type *t;
+
+	if (kfunc_id == -ESRCH)
+		return true;
+	if (kfunc_id < 0)
+		return false;
+	t = btf__type_by_id(kern_btf, kfunc_id);
+	return bpf_core_types_are_compat(obj->btf, ext->ksym.type_id, kern_btf, t->type) <= 0;
+}
+
 static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 						struct extern_desc *ext)
 {
@@ -9526,6 +9650,17 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
 				    &mod_btf);
+	if (need_kfunc_flavor(obj, ext, kern_btf, kfunc_id)) {
+		ret = find_kfunc_flavor_btf_id(obj, ext, &kern_btf, &mod_btf);
+		if (ret == -ENOTUNIQ) {
+			/* an error even if declared __weak: ambiguity isn't absence */
+			pr_warn("extern (func ksym) '%s': more than one compatible kfunc flavor\n",
+				ext->name);
+			return ret;
+		}
+		if (ret && ret != -ESRCH)
+			kfunc_id = ret;
+	}
 	if (kfunc_id < 0) {
 		if (kfunc_id == -ESRCH && ext->is_weak)
 			return 0;
@@ -9579,8 +9714,9 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
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
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..c84521ea562e 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -248,6 +248,7 @@ struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
 const struct btf_header *btf_header(const struct btf *btf);
+void btf_name_prefix_range(const struct btf *btf, const char *prefix, __u32 *start, __u32 *end);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id_map,
 		 __u32 **str_map);
-- 
2.56.1

