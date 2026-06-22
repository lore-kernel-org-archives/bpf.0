Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDE3AFD16
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139074; cv=none; b=nlWWa/fpXtS9chkmoAU9c7IDnM6lSsr+AQ5kqCeESQcucqOOjkLvVkQj7P0SzZnR+XRSbGDU/Rgv40XWkIOXCz5vDhTTvGlo6quVULBkmC6pFvH4r+4SQ5SpybA0ivRis9Ar7PowN8GbpAR4AruBfD7HOxbpelT5A+lRPWuW7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139074; c=relaxed/simple;
	bh=721RJucMZVja3f2/78SJ3YsiNxGl6KFT8QrGf/fap40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai4OF7tXlN4dImR/8o1mwEXiaykjQ42UqWGfJByG9YDBmSTQSSze5TQ6nsxJEXeNL20ukvz7Vyih07kZkb8TOQb+0YN3gJ56c5T+DVBOrXIjO+SoTLR7CZeHlFdNnXo3kcjGTnQQFvz3/jrRJ15LceXir9cZndQpWT5+75mEjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXc1CsDK; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXc1CsDK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782139069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QP46oDj+m3aNlLwfNzDDE050nCPuj8E/Khl3XbBbK0=;
	b=qXc1CsDKQfVa+665uiOLb+vys6qRZHGPxoCNgusQtgS6F3r53BpQMb1IMZbopPd/MnXBWB
	XLJhvCuUhqp/iEjfRpMFq3j0G5sXcgeiSv7EuRkuK2NRDTJVFFmPIwFRVIFqQLwzTpJ2vO
	QCh0xWSworUc/8yX8NRvPilQXVhbZlU=
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
Subject: [PATCH bpf-next v7 07/11] bpftool: Generate skeleton for global percpu data
Date: Mon, 22 Jun 2026 22:35:53 +0800
Message-ID: <20260622143557.22955-8-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-1-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
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
 tools/bpf/bpftool/gen.c       | 43 +++++++++++++++++++++++++++--------
 tools/lib/bpf/skel_internal.h | 24 +++++++++++++++++--
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6ae7262ebe0c..2200ab004d2b 100644
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
@@ -254,6 +254,11 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
 	return NULL;
 }
 
+static bool bpf_map_is_percpu_data(const struct bpf_map *map)
+{
+	return bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
+}
+
 static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 {
 	size_t tmp_sz;
@@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
 		return true;
 	}
 
-	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-		return false;
-
-	if (!get_map_ident(map, buf, sz))
-		return false;
+	if (bpf_map__is_internal(map) &&
+	    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)) &&
+	    get_map_ident(map, buf, sz))
+		return true;
 
-	return true;
+	return false;
 }
 
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
@@ -343,6 +347,9 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
 			continue;
 
+		if (bpf_map_is_percpu_data(map))
+			continue;
+
 		sec = find_type_for_map(btf, map_ident);
 		if (!sec)
 			continue;
@@ -669,7 +676,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (bpf_map__is_internal(map) &&
-		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)))
 			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
@@ -850,6 +857,20 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
@@ -1740,6 +1761,8 @@ static int do_subskeleton(int argc, char **argv)
 
 		if (!is_mmapable_map(map, ident, sizeof(ident)))
 			continue;
+		if (bpf_map_is_percpu_data(map))
+			continue;
 
 		map_type_id = bpf_map__btf_value_type_id(map);
 		if (map_type_id <= 0) {
@@ -1863,6 +1886,8 @@ static int do_subskeleton(int argc, char **argv)
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

