Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B861DBB3A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571296; cv=none; b=U3/Siy9euBZAGyGqnf8ynpkv61ebdQyU+DG7TAaKFlmFDlk3hAYcOjSwSZAt9Pd4+PZ2RW3PzF11F5WOks2Tww60J5nTXuOgSB6QpLID9AVdcxBH5QirrxRZ6aoCphVn0kV/3bkO41QFn1HZ7+6CRe7IOvuOz1KPQ1ysPKgwCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571296; c=relaxed/simple;
	bh=fJS9W+zeuwNgB25ejwsQ54771mdLSicS8/Orb8ws/84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBW/YxZSXK3DkFuQC/YeepEpnp4C/it6T85TqJfPEmCbs1kknXvUQFGBWZutkpy9Ci/CQmZa+1cUYA/GizYMIyMvxiA88BnFqnvxn5DK5Hofgphqjgqv06Z388T1bf1WvjQAxODQ6eE5PMMumeR4edAUnNggiKBoOO2OY/XLoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L1eHe9lv; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L1eHe9lv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774571292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9joWJlumx2b97oal16aDRH9ns5elX6YCDMifmLKe2U=;
	b=L1eHe9lvesFT1Qe2VSWvoZBS8gT/50DAvH7WwzqMZcbY8LajL5HOm58bFdq9i//zSN76Kt
	FYT05MWqQNZn9qobtBtiyPxY8TKoARf4rKb5eeOJEfK4O9DqwqZ181TuTZg9dmSGqbercj
	InpxBFzaP2MCHHHAouH9dKkXl0ek26c=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Update kfuncs using btf_struct_meta to new variants
Date: Thu, 26 Mar 2026 17:27:59 -0700
Message-ID: <20260327002759.4033863-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
References: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
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

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 156 +-----------------
 .../selftests/bpf/prog_tests/spin_lock.c      |   5 +-
 .../selftests/bpf/progs/kptr_xchg_inline.c    |   4 +-
 3 files changed, 9 insertions(+), 156 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 44466acf8083..2234bd6bc9d3 100644
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
+/* Convenience macro to wrap over bpf_obj_new */
+#define bpf_obj_new(type) ((type *)bpf_obj_new(bpf_core_type_id_local(type)))
 
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
-
-/* Convenience macro to wrap over bpf_percpu_obj_new_impl */
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
+/* Convenience macro to wrap over bpf_percpu_obj_new */
+#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_new(bpf_core_type_id_local(type)))
 
 struct bpf_iter_task_vma;
 
@@ -167,9 +22,6 @@ extern int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
 extern struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it) __ksym;
 extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
 
-/* Convenience macro to wrap over bpf_obj_drop_impl */
-#define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
-
 /* Description
  *	Throw a BPF exception from the program, immediately terminating its
  *	execution and unwinding the stack. The supplied 'cookie' parameter
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

