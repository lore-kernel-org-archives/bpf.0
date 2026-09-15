Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60A41D637
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488909; cv=none; b=AMhWDlW9L4e8IAkyZBnLVvjh+03LNaOOln1RBFCcoLQtDeYbmDIHNxvqzsY6LsO1ITF50ND17IDKEIMw08e9kYfnfl4GUfcJn1ezcgztC61/Fs8ZbSpVVn3xOy5aVzwIpGCemsQNVhEa4kYi5eE/+UpPjSfFpCFpD0n8N4bKUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488909; c=relaxed/simple;
	bh=KzneAssyJ6Hnv8qhaceSpKRPnn0woZNbDSSUjQCSuog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gk1CPWGXSgDyJVplFdImNYdEfjmc+5yv+l0kyFLDFMECocz/zJ1En97aYAo5Ok1qGIFBcYBNvDs31bFt8NsoxSOsM5HflA9NkYdAFCd/3E7HjA/ZqSbr12xqO2qDQCSoWKpFOUBZpG9QbwZL1dZYwFRjO8rBWE1h24/8tyrMqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqIcwQi5; arc=none smtp.client-ip=91.218.175.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqIcwQi5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KzneAssyJ6Hnv8qhaceSpKRPnn0woZNbDSSUjQCSuog=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789488903; v=1; x=1790093703;
 b=RqIcwQi5WKgGlfM/1HOVEdu4f29oslW0pztSza+B81aJE3oW12y23P7DjyXK6DFjRU7dxQOV
 Kz9gwiQGWqzVVLqfzzNJSuadHmiLtKBZDQRtUfDEwzRLOQqOGqmG1J9kbF7qx53DzmdZlC84ptK
 pfgv9Jp2wLZHbGyWkgubhwiw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6173dd8524c751d9;
	Tue, 15 Sep 2026 16:15:03 +0000
X-Mizu-Trace-ID: 6173dd8524c751d9
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v3] bpftool: Compute map size of light skeletons at runtime
Date: Wed, 16 Sep 2026 00:14:50 +0800
Message-ID: <20260915161450.96249-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftool rounds memory-mapped data map sizes to the host page size when
generating a light skeleton. The generated code therefore uses a 64K
mapping size when bpftool runs on a 64K-page host, even if the skeleton
runs on a 4K-page target. The target rejects the oversized map mmap(),
causing failure of loading the light skeleton.

When try to run 64K-page selftests on 4K-page VM, the error message does
not provide the reason about page size.

 test_atomics:PASS:atomics skeleton open 0 nsec
 test_atomics:FAIL:atomics skeleton load unexpected error: -12 (errno 22)
 #15      atomics:FAIL

Pass the original map value size and max entries to the generated code and
round mmap size to the runtime page size in the user-space light
skeleton helpers. This keeps generated light skeletons independent of the
build host page size.

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v2 -> v3:
* Hoist 'sysconf(_SC_PAGE_SIZE)' and the inner 'roundup()' in
  skel_map_mmap_sz(). (bot+bpf-ci)
* v2: https://lore.kernel.org/bpf/20260914153326.72498-1-leon.hwang@linux.dev/

v1 -> v2:
* Pass max entries alongside value size.
* Use the computed mmap size for mprotect() in userspace's
  skel_protect_map_data().
* Round up the mmap size to page size with keeping the original
  multiplying max_entries logic. (Andrii)
* v1: https://lore.kernel.org/bpf/20260911145914.23676-1-leon.hwang@linux.dev/
---
 tools/bpf/bpftool/gen.c       | 26 ++++++-------------
 tools/lib/bpf/skel_internal.h | 48 +++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521..ee680f7c2116 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -500,16 +500,6 @@ static void print_hex(const char *data, int data_sz)
 	}
 }
 
-static size_t bpf_map_mmap_sz(const struct bpf_map *map)
-{
-	long page_sz = sysconf(_SC_PAGE_SIZE);
-	size_t map_sz;
-
-	map_sz = (size_t)roundup(bpf_map__value_size(map), 8) * bpf_map__max_entries(map);
-	map_sz = roundup(map_sz, page_sz);
-	return map_sz;
-}
-
 /* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
 static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
 {
@@ -686,8 +676,8 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 		if (!get_map_ident(map, ident, sizeof(ident)))
 			continue;
 		if (is_skel_data(map, ident, sizeof(ident)))
-			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
-			       ident, bpf_map_mmap_sz(map));
+			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$u, %3$u);\n",
+			       ident, bpf_map__value_size(map), bpf_map__max_entries(map));
 		codegen("\
 			\n\
 				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
@@ -771,13 +761,13 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";							    \n\
 									    \n\
-				skel->%1$s = (__typeof__(skel->%1$s))skel_prep_map_data((void *)data, %2$zd,\n\
+				skel->%1$s = (__typeof__(skel->%1$s))skel_prep_map_data((void *)data, %2$u, %3$u,\n\
 								sizeof(data) - 1);\n\
 				if (!skel->%1$s)			    \n\
 					goto cleanup;			    \n\
 				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
 			}						    \n\
-			", ident, bpf_map_mmap_sz(map));
+			", ident, bpf_map__value_size(map), bpf_map__max_entries(map));
 	}
 	codegen("\
 		\n\
@@ -871,14 +861,14 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			codegen("\
 		\n\
-			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$zd);\n\
+			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$u, %3$u);\n\
 			if (err)					    \n\
 				return err;				    \n\
 		#ifdef __KERNEL__					    \n\
 			skel->%1$s = NULL;				    \n\
 		#endif							    \n\
 			",
-			ident, bpf_map_mmap_sz(map));
+			ident, bpf_map__value_size(map), bpf_map__max_entries(map));
 			continue;
 		}
 
@@ -890,11 +880,11 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		codegen("\
 		\n\
 			skel->%1$s = (__typeof__(skel->%1$s))skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n\
-							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
+							%2$u, %3$u, %4$s, skel->maps.%1$s.map_fd);\n\
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
 			",
-		       ident, bpf_map_mmap_sz(map), mmap_flags);
+		       ident, bpf_map__value_size(map), bpf_map__max_entries(map), mmap_flags);
 	}
 	codegen("\
 		\n\
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 1f3f332dffbe..9e16b8e8cb7c 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #else
 #include <unistd.h>
+#include <sys/param.h>
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <linux/keyctl.h>
@@ -127,7 +128,7 @@ static inline void skel_free(const void *p)
  * either bpf_probe_read_kernel() or bpf_copy_from_user() from initial_value
  * depending on bpf_loader_ctx->flags.
  */
-static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+static inline void skel_free_map_data(void *p, __u64 addr, size_t val_sz, __u32 max_entries)
 {
 	if (addr != ~0ULL)
 		kvfree(p);
@@ -138,18 +139,20 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
 	 */
 }
 
-static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+static inline void *skel_prep_map_data(const void *val, size_t val_sz, __u32 max_entries,
+				       size_t data_sz)
 {
 	void *addr;
 
-	addr = kvmalloc(val_sz, GFP_KERNEL);
+	addr = kvmalloc(data_sz, GFP_KERNEL);
 	if (!addr)
 		return NULL;
-	memcpy(addr, val, val_sz);
+	memcpy(addr, val, data_sz);
 	return addr;
 }
 
-static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, __u32 max_entries,
+					   int flags, int fd)
 {
 	struct bpf_map *map;
 	void *addr = NULL;
@@ -172,9 +175,10 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 	return addr;
 }
 
-static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t val_sz, __u32 max_entries)
 {
-	(void)sz;
+	(void)val_sz;
+	(void)max_entries;
 
 	kvfree(p);
 	*init_val = ~0ULL;
@@ -193,25 +197,39 @@ static inline void skel_free(void *p)
 	free(p);
 }
 
-static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
+static inline size_t skel_map_mmap_sz(size_t val_sz, __u32 max_entries)
 {
-	munmap(p, sz);
+	const long page_sz = sysconf(_SC_PAGE_SIZE);
+	size_t mmap_sz;
+
+	mmap_sz = roundup(val_sz, 8) * max_entries;
+	mmap_sz = roundup(mmap_sz, page_sz);
+	return mmap_sz;
 }
 
-static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+static inline void skel_free_map_data(void *p, __u64 addr, size_t val_sz, __u32 max_entries)
 {
+	munmap(p, skel_map_mmap_sz(val_sz, max_entries));
+}
+
+static inline void *skel_prep_map_data(const void *val, size_t val_sz, __u32 max_entries,
+				       size_t data_sz)
+{
+	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
 	void *addr;
 
 	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
 		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	if (addr == (void *) -1)
 		return NULL;
-	memcpy(addr, val, val_sz);
+	memcpy(addr, val, data_sz);
 	return addr;
 }
 
-static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, __u32 max_entries,
+					   int flags, int fd)
 {
+	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
 	void *addr;
 
 	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
@@ -220,11 +238,13 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
 	return addr;
 }
 
-static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
+static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t val_sz, __u32 max_entries)
 {
+	size_t mmap_sz = skel_map_mmap_sz(val_sz, max_entries);
+
 	(void)init_val;
 
-	if (mprotect(p, sz, PROT_READ))
+	if (mprotect(p, mmap_sz, PROT_READ))
 		return -errno;
 	return 0;
 }
-- 
2.55.0

