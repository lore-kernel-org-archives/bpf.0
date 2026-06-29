Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6740F8D6
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746723; cv=none; b=Wrz+LTdOFx6dg88EjXwM8gR+K0Z2jwWz8fM3eGSvIhsEhV1ISfjX04W0hIobNi4vzKM486+CcbXhpZ0YYA49eU3QZZjOA2NdYywYk0jkjrN+75zawvlsPJevkhArouOwprxf+nxHcIZTRyCvDFmV8qz1gqXIQRJYNNC9tS5z19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746723; c=relaxed/simple;
	bh=dkQgYdIq5wIg6UaqLuuJALh6xHkSwH3QPf0iGSDA6cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbVJRRE3jf/TLSmwEigXM9GwRvQn3KHNeauFXvoByGokxbFMfhdb2CpI+jfHgf6r8AchhXNVEQcGwDL0MCwm11RSFTu/C9Ryt0nswK7y/mSMlfwPdd/AqJqkbrZuSyoYivSnrlTmuwOuZkllH1A17Nh+AMAQFYJCnTuAZmCfZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ryR0X51Z; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ryR0X51Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782746718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaDQeMUDtBGrUwU4+hLDXPyMlrpsvOqE0Fkt1y1wkb0=;
	b=ryR0X51ZiZEgF/OwW3Oa8o+hVnajFZrkK7nXUa0Lwi9oEDjRew8981pExMWxEnElWXwRgJ
	+1KOOuXDaIf6X7/c8C7KjwgoxO6D/NTxRuWQFmcSr/Qow15ZWsVzPjUqEceadHagfzLJBn
	G1jJJr0nudZGF3xJK4t22LyTL1gK7VU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global percpu data
Date: Mon, 29 Jun 2026 23:24:02 +0800
Message-ID: <20260629152406.52582-6-leon.hwang@linux.dev>
In-Reply-To: <20260629152406.52582-1-leon.hwang@linux.dev>
References: <20260629152406.52582-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Enhance bpftool to generate skeletons that properly handle global percpu
variables. The generated skeleton now includes a dedicated structure for
percpu data, allowing users to initialize and access percpu variables more
efficiently.

For global percpu variables, the skeleton now includes a nested
structure, e.g.:

struct test_global_percpu_data {
	struct bpf_object_skeleton *skeleton;
	struct bpf_object *obj;
	struct {
		struct bpf_map *percpu;
	} maps;
	// ...
	struct test_global_percpu_data__percpu {
		int data;
		char run;
		struct {
			char set;
			int i;
			int nums[7];
		} struct_data;
		int nums[7];
	} *percpu;

	// ...
};

  * The "struct test_global_percpu_data__percpu *percpu" points to
    initialized data, which is actually "maps.percpu->mmaped".
  * Before loading the skeleton, updating the
    "struct test_global_percpu_data__percpu *percpu" modifies the initial
    value of the corresponding global percpu variables.
  * After loading the skeleton, "maps.percpu->mmaped" has been marked as
    read-only in libbpf. If users want to update the global percpu
    variables, they have to update the "maps.percpu" map instead.
  * For lightweight skeleton, "lskel->percpu" will be protected by
    "mprotect(p, sz, PROT_READ)".
  * For subskeleton, those variables of global percpu data will be
    skipped.

Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c       | 49 +++++++++++++++++++++++++++++++----
 tools/lib/bpf/skel_internal.h | 24 +++++++++++++++--
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6ae7262ebe0c..2e60296358db 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
 
 static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 {
-	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
 	const char *name = bpf_map__name(map);
 	int i, n;
 
@@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
 
 static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 {
-	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
+	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
@@ -254,6 +254,20 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }
 
+static bool bpf_map_is_skel_data(const struct bpf_map *map)
+{
+	if (!bpf_map__is_internal(map))
+		return false;
+
+	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
+		return true;
+
+	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return true;
+
+	return false;
+}
+
 static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 {
 	size_t tmp_sz;
@@ -263,7 +277,7 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+	if (!bpf_map_is_skel_data(map))
 		return false;
 
 	if (!get_map_ident(map, buf, sz))
@@ -321,6 +335,11 @@ static bool btf_is_ptr_to_func_proto(const struct btf *btf,
 	return btf_is_ptr(v) && btf_is_func_proto(btf__type_by_id(btf, v->type));
 }
 
+static bool bpf_map_is_percpu_data(const struct bpf_map *map)
+{
+	return bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
+}
+
 static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
@@ -343,6 +362,9 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
 			continue;
 
+		if (bpf_map_is_percpu_data(map))
+			continue;
+
 		sec = find_type_for_map(btf, map_ident);
 		if (!sec)
 			continue;
@@ -668,8 +690,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 	bpf_object__for_each_map(map, obj) {
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
-		if (bpf_map__is_internal(map) &&
-		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		if (bpf_map_is_skel_data(map))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -850,6 +871,20 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
 
+		if (bpf_map_is_percpu_data(map)) {
+			codegen("\
+		\n\
+			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$zd);\n\
+			if (err)					    \n\
+				return err;				    \n\
+		#ifdef __KERNEL__					    \n\
+			skel->%1$s = NULL;				    \n\
+		#endif							    \n\
+			",
+			ident, bpf_map_mmap_sz(map));
+			continue;
+		}
+
 		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
 			mmap_flags = "PROT_READ";
 		else
@@ -1740,6 +1775,8 @@ static int do_subskeleton(int argc, char **argv)
 
 		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
+		if (bpf_map_is_percpu_data(map))
+			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
 		if (map_type_id <= 0) {
@@ -1863,6 +1900,8 @@ static int do_subskeleton(int argc, char **argv)
 	bpf_object__for_each_map(map, obj) {
 		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
+		if (bpf_map_is_percpu_data(map))
+			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
 		if (map_type_id <= 0)
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 74503d358bc8..485b0cd17017 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -135,8 +135,10 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
 {
 	if (addr != ~0ULL)
 		kvfree(p);
-	/* When addr == ~0ULL the 'p' points to
-	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
+	/*
+	 * When addr == ~0ULL the init buffer has already been released.
+	 * For skel_finalize_map_data(), 'p' points to
+	 * ((struct bpf_array *)map)->value.
 	 */
 }
 
@@ -174,6 +176,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 	return addr;
 }
 
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+{
+	(void)sz;
+
+	kvfree(p);
+	*init_val = ~0ULL;
+	return 0;
+}
+
 #else
 
 static inline void *skel_alloc(size_t size)
@@ -212,6 +223,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 		return NULL;
 	return addr;
 }
+
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+{
+	(void)init_val;
+
+	if (mprotect(p, sz, PROT_READ))
+		return -errno;
+	return 0;
+}
 #endif
 
 static inline int skel_closenz(int fd)
-- 
2.54.0

