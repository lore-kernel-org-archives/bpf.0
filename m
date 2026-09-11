Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7735C6A5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138773; cv=none; b=QPITyHk+TMSv4POYjMKUfz6kuJ+ZmClXlOMlGfaf69axV1Zxn7Nw38mB4LmKtfJNbwp9IuUp1OXUjb/S7Va52qu5hu03rvAA8ujKhAuqLw1xtskNjNt3giV3EtAihMU1gXD47V5dw13SHdi5A6dO4kvMRnFC6umwZGkRmqlxLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138773; c=relaxed/simple;
	bh=IJ6M84jik/6WzHAEWYe3FHbzr4F2HaPJlKu+3Hyckm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4FYeW6/GnKePwlJ0qKqmNHpyLI+lO7HI5Vw2LUdU8vmEyXOBxxQHck6TjEvfRLzVBuJjuBPcQ2v1yNhY0K52jDtvVMrMpgUffQUibxhl5kusxOt0u3AZChKes9FZOWkuFO9/nKOKsOmbKWNwtRbQCIQn+u3DBtyPRb/IVyAKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q7/1WOra; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q7/1WOra"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IJ6M84jik/6WzHAEWYe3FHbzr4F2HaPJlKu+3Hyckm0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789138766; v=1; x=1789743566;
 b=q7/1WOrajip27fGWJXOM0u7YkK9TRzuhKxFj1hmLMYy4eY13pL8Jv11+dEvmPLetnBNMlQWl
 lkKNHRr7uRrb+8OLWLr1NKmPlGgAiqRI812gsl6TL4+XGDa/SyV0SEJ+ggDzSq1INZpnmxBvqU4
 T8+TIM9k3dVfsETfEIzr9yJ8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e1490bb8f087fe33;
	Fri, 11 Sep 2026 14:59:26 +0000
X-Mizu-Trace-ID: e1490bb8f087fe33
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
Subject: [PATCH bpf-next] bpftool: Compute map size of light skeletons at runtime
Date: Fri, 11 Sep 2026 22:59:14 +0800
Message-ID: <20260911145914.23676-1-leon.hwang@linux.dev>
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

Pass the original map value size to the generated code and round it to the
runtime page size in the user-space light skeleton helpers. This keeps
generated light skeletons independent of the build host page size.

Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog load" and "gen skeleton" command.")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/bpf/bpftool/gen.c       | 27 ++++++++-------------------
 tools/lib/bpf/skel_internal.h | 18 +++++++++++++-----
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a50540ef6521..77f04c28fee9 100644
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
+			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$u);\n",
+			       ident, bpf_map__value_size(map));
 		codegen("\
 			\n\
 				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
@@ -771,13 +761,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";							    \n\
 									    \n\
-				skel->%1$s = (__typeof__(skel->%1$s))skel_prep_map_data((void *)data, %2$zd,\n\
-								sizeof(data) - 1);\n\
+				skel->%1$s = (__typeof__(skel->%1$s))skel_prep_map_data((void *)data, sizeof(data) - 1);\n\
 				if (!skel->%1$s)			    \n\
 					goto cleanup;			    \n\
 				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
 			}						    \n\
-			", ident, bpf_map_mmap_sz(map));
+			", ident);
 	}
 	codegen("\
 		\n\
@@ -871,14 +860,14 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			codegen("\
 		\n\
-			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$zd);\n\
+			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$u);\n\
 			if (err)					    \n\
 				return err;				    \n\
 		#ifdef __KERNEL__					    \n\
 			skel->%1$s = NULL;				    \n\
 		#endif							    \n\
 			",
-			ident, bpf_map_mmap_sz(map));
+			ident, bpf_map__value_size(map));
 			continue;
 		}
 
@@ -890,11 +879,11 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		codegen("\
 		\n\
 			skel->%1$s = (__typeof__(skel->%1$s))skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n\
-							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
+							%2$u, %3$s, skel->maps.%1$s.map_fd);\n\
 			if (!skel->%1$s)				    \n\
 				return -ENOMEM;				    \n\
 			",
-		       ident, bpf_map_mmap_sz(map), mmap_flags);
+		       ident, bpf_map__value_size(map), mmap_flags);
 	}
 	codegen("\
 		\n\
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 1f3f332dffbe..5787911f17f5 100644
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
@@ -138,7 +139,7 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
 	 */
 }
 
-static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+static inline void *skel_prep_map_data(const void *val, size_t val_sz)
 {
 	void *addr;
 
@@ -149,7 +150,7 @@ static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t v
 	return addr;
 }
 
-static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, int flags, int fd)
 {
 	struct bpf_map *map;
 	void *addr = NULL;
@@ -193,13 +194,19 @@ static inline void skel_free(void *p)
 	free(p);
 }
 
+static inline size_t skel_map_mmap_sz(size_t sz)
+{
+	return roundup(sz, sysconf(_SC_PAGE_SIZE));
+}
+
 static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
 {
-	munmap(p, sz);
+	munmap(p, skel_map_mmap_sz(sz));
 }
 
-static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t val_sz)
+static inline void *skel_prep_map_data(const void *val, size_t val_sz)
 {
+	size_t mmap_sz = skel_map_mmap_sz(val_sz);
 	void *addr;
 
 	addr = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
@@ -210,8 +217,9 @@ static inline void *skel_prep_map_data(const void *val, size_t mmap_sz, size_t v
 	return addr;
 }
 
-static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int flags, int fd)
+static inline void *skel_finalize_map_data(__u64 *init_val, size_t val_sz, int flags, int fd)
 {
+	size_t mmap_sz = skel_map_mmap_sz(val_sz);
 	void *addr;
 
 	addr = mmap((void *) (long) *init_val, mmap_sz, flags, MAP_SHARED | MAP_FIXED, fd, 0);
-- 
2.55.0

