Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1C33E37D
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344166; cv=none; b=G44vSHBHvhAIFkcSUg5/F1H5OUl69jsVnW9gcqtg4D9DGucHNEs0TlONDOdjRiI0jegPoAAJmeZtyYn2uz4DVIBW0sM07C+0bKhhb7QbcM2fCudXIqDPZ8RwRm1jRoEIJm5da9Sk1vEIyBvwCeQaoHgo/jSGbDghq6+Iyty1r+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344166; c=relaxed/simple;
	bh=l4LrQtMwmtq1DT00FoXIZiMkmwGJCZArMZkG8tJKxFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfdlPFwAS71BVSMjVkVbTgxOShKvaSRp3Ka3xDldPcz5QwAn2ykQOUV5IYwMcWMimcI12mtKnQPNWqGEg9y6jn7jlM9KFEbSG+9Iq/PVXM8ifPPfC1W39H/6zIuFisbj9qsAGf5cOdUYZxp9flDZOfJl415IY9hynyTMdBpKMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kIMjTmxq; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kIMjTmxq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773344163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7+sAZAKIOX+TYlDRz3IXFvSUZiKoQ5ietwHi5DyMbU=;
	b=kIMjTmxqcGB82xTVY3WRL9XxK0QBN5SPdkQZB6qMjBR+HJIe5X7BDoyjRhdHy78jKTOYWc
	Hl4dx94pyXmHquxuW//86jchpim4JpvnnJBn/WJ1UmZsgg8n5Birj7D9SO0b23oSQmtl1y
	j8gA45STYyYyPCjFpNiEAUGi8Tp4Z1M=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Update kfuncs using btf_struct_meta to new variants
Date: Thu, 12 Mar 2026 12:35:46 -0700
Message-ID: <20260312193546.192786-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260312193546.192786-1-ihor.solodrai@linux.dev>
References: <20260312193546.192786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update selftests to use the new non-_impl kfuncs marked with
KF_IMPLICIT_ARGS by removing redundant declarations and macros from
bpf_experimental.h (the new kfuncs are present in the vmlinux.h) and
updating relevant callsites.

Fix spin_lock verifier-log matching for lock_id_kptr_preserve by
accepting variable instruction numbers. The calls to kfuncs with
implicit arguments do not have register moves (e.g. r5 = 0)
corresponding to dummy arguments anymore, so the order of instructions
has shifted.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 151 +-----------------
 .../selftests/bpf/prog_tests/spin_lock.c      |   5 +-
 .../selftests/bpf/progs/kptr_xchg_inline.c    |   4 +-
 3 files changed, 8 insertions(+), 152 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 44466acf8083..d874b9cbded5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -8,156 +8,11 @@
 
 #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
 
-/* Description
- *	Allocates an object of the type represented by 'local_type_id' in
- *	program BTF. User may use the bpf_core_type_id_local macro to pass the
- *	type ID of a struct in program BTF.
- *
- *	The 'local_type_id' parameter must be a known constant.
- *	The 'meta' parameter is rewritten by the verifier, no need for BPF
- *	program to set it.
- * Returns
- *	A pointer to an object of the type corresponding to the passed in
- *	'local_type_id', or NULL on failure.
- */
-extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
-
-/* Convenience macro to wrap over bpf_obj_new_impl */
-#define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
-
-/* Description
- *	Free an allocated object. All fields of the object that require
- *	destruction will be destructed before the storage is freed.
- *
- *	The 'meta' parameter is rewritten by the verifier, no need for BPF
- *	program to set it.
- * Returns
- *	Void.
- */
-extern void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
-
-/* Convenience macro to wrap over bpf_obj_drop_impl */
-#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
-
-/* Description
- *	Increment the refcount on a refcounted local kptr, turning the
- *	non-owning reference input into an owning reference in the process.
- *
- *	The 'meta' parameter is rewritten by the verifier, no need for BPF
- *	program to set it.
- * Returns
- *	An owning reference to the object pointed to by 'kptr'
- */
-extern void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
-
-/* Convenience macro to wrap over bpf_refcount_acquire_impl */
-#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
-
-/* Description
- *	Add a new entry to the beginning of the BPF linked list.
- *
- *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
- *	for BPF programs to set them
- * Returns
- *	0 if the node was successfully added
- *	-EINVAL if the node wasn't added because it's already in a list
- */
-extern int bpf_list_push_front_impl(struct bpf_list_head *head,
-				    struct bpf_list_node *node,
-				    void *meta, __u64 off) __ksym;
-
-/* Convenience macro to wrap over bpf_list_push_front_impl */
-#define bpf_list_push_front(head, node) bpf_list_push_front_impl(head, node, NULL, 0)
-
-/* Description
- *	Add a new entry to the end of the BPF linked list.
- *
- *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
- *	for BPF programs to set them
- * Returns
- *	0 if the node was successfully added
- *	-EINVAL if the node wasn't added because it's already in a list
- */
-extern int bpf_list_push_back_impl(struct bpf_list_head *head,
-				   struct bpf_list_node *node,
-				   void *meta, __u64 off) __ksym;
-
-/* Convenience macro to wrap over bpf_list_push_back_impl */
-#define bpf_list_push_back(head, node) bpf_list_push_back_impl(head, node, NULL, 0)
-
-/* Description
- *	Remove the entry at the beginning of the BPF linked list.
- * Returns
- *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
- */
-extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
-
-/* Description
- *	Remove the entry at the end of the BPF linked list.
- * Returns
- *	Pointer to bpf_list_node of deleted entry, or NULL if list is empty.
- */
-extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
-
-/* Description
- *	Remove 'node' from rbtree with root 'root'
- * Returns
- * 	Pointer to the removed node, or NULL if 'root' didn't contain 'node'
- */
-extern struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
-					     struct bpf_rb_node *node) __ksym;
-
-/* Description
- *	Add 'node' to rbtree with root 'root' using comparator 'less'
- *
- *	The 'meta' and 'off' parameters are rewritten by the verifier, no need
- *	for BPF programs to set them
- * Returns
- *	0 if the node was successfully added
- *	-EINVAL if the node wasn't added because it's already in a tree
- */
-extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
-			       bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
-			       void *meta, __u64 off) __ksym;
-
-/* Convenience macro to wrap over bpf_rbtree_add_impl */
-#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
-
-/* Description
- *	Return the first (leftmost) node in input tree
- * Returns
- *	Pointer to the node, which is _not_ removed from the tree. If the tree
- *	contains no nodes, returns NULL.
- */
-extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
-
-/* Description
- *	Allocates a percpu object of the type represented by 'local_type_id' in
- *	program BTF. User may use the bpf_core_type_id_local macro to pass the
- *	type ID of a struct in program BTF.
- *
- *	The 'local_type_id' parameter must be a known constant.
- *	The 'meta' parameter is rewritten by the verifier, no need for BPF
- *	program to set it.
- * Returns
- *	A pointer to a percpu object of the type corresponding to the passed in
- *	'local_type_id', or NULL on failure.
- */
-extern void *bpf_percpu_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+/* Convenience macro to wrap over bpf_obj_new */
+#define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
 
 /* Convenience macro to wrap over bpf_percpu_obj_new_impl */
-#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new_impl(bpf_core_type_id_local(type), NULL))
-
-/* Description
- *	Free an allocated percpu object. All fields of the object that require
- *	destruction will be destructed before the storage is freed.
- *
- *	The 'meta' parameter is rewritten by the verifier, no need for BPF
- *	program to set it.
- * Returns
- *	Void.
- */
-extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
+#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
 
 struct bpf_iter_task_vma;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 254fbfeab06a..bbe476f4c47d 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -13,8 +13,9 @@ static struct {
 	const char *err_msg;
 } spin_lock_fail_tests[] = {
 	{ "lock_id_kptr_preserve",
-	  "5: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2) "
-	  "R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
+	  "[0-9]\\+: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2)"
+	  " R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n"
+	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=ptr_ expected=percpu_ptr_" },
 	{ "lock_id_global_zero",
 	  "; R1=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
index 2414ac20b6d5..ca5943166057 100644
--- a/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
+++ b/tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
@@ -25,14 +25,14 @@ __naked int kptr_xchg_inline(void)
 		"if r0 == 0 goto 1f;"
 		"r1 = r0;"
 		"r2 = 0;"
-		"call %[bpf_obj_drop_impl];"
+		"call %[bpf_obj_drop];"
 	"1:"
 		"r0 = 0;"
 		"exit;"
 		:
 		: __imm_addr(ptr),
 		  __imm(bpf_kptr_xchg),
-		  __imm(bpf_obj_drop_impl)
+		  __imm(bpf_obj_drop)
 		: __clobber_all
 	);
 }
-- 
2.53.0

