Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AB2F693D;
	Fri, 30 Jan 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760985; cv=none; b=B2v0mHxTsUkMiLHYj76NBoW/B3htJ0jgj9TqCK43xQIxaG9GYo6UVvvLU2vS3ic5MEIm7Tl0zbuthFPv7FRLiK0roRbz85Iu1jCpEjEySDiJLcQQuo46x4SAgiu4SBgr0MzVSXchmYJnLTCP6DzCBV/mvCksq3YS2N8UvCUwLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760985; c=relaxed/simple;
	bh=bQgJs7xXB9wJEWGv0DCOwRjYBdIIvmuBsk1OUdnj5OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MB/YrBkQSx5ZYeR32xR2eA9RgW+LlVPEcXHNQ/veBlN3YPLRLETo++6SzM3giG1KJ0qjIEjqGrV96rW7ungWepMf8n20goKKr5CvEsZ+A04JsK+PDd9K0FQu4RryP8f5XwVJY4/CDzRHbYhbayNt25QgFatdyfM9CGtSFlGXykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VFTjrjD/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VFTjrjD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=I9
	cXRVbYTYQg+Wkpqq+koy9h/2i/DlkR8kash0wToOs=; b=VFTjrjD/c48xU0MdAr
	Op2GnauYTOSqrUF1NW+dJHgtqfrwBJOtPAI7p4wAfNEvsv7O54NYROGqu1KBPLEO
	2aDNsYeWaqDkxfWqGmVgQbeypKW8U+/PwGolL7ktpHHpI8S7QVMsaca/dtrbel9H
	4kZFjC6apktD5dyu15/qIp4V4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCXfeiYaHxpkfQXJQ--.7978S2;
	Fri, 30 Jan 2026 16:15:22 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next] bpf: Add the missing types in the logs
Date: Fri, 30 Jan 2026 16:15:20 +0800
Message-Id: <20260130081520.59713-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXfeiYaHxpkfQXJQ--.7978S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJF4DCw1xXFyxCrWxJr4kCrg_yoW8JrykCo
	Z7KF98ZF13C3yxA39rAw4rtryxW34DCryrW3Z3WFW5u3WUCr1Yyry8Cw4fXry2vrWFqa4D
	Zas2k3yFvF97Gry5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU76wZDUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hu5Mml8aJvMwgAA3K

From: Feng Yang <yangfeng@kylinos.cn>

Add the missing types to avoid such uninformative errors as shown below:
R1 type=ptr_ expected=ptr_

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v4:
- Added a part that was accidentally omitted before, please ignore the v3 version.
Changes in v3:
- Fix the self-test failures caused by this patch.
- Link to v2: https://lore.kernel.org/all/20260129073614.113380-1-yangfeng59949@163.com/
Changes in v2:
- Group together those for which only 0 or 1 can be selected. thanks, Mykyta Yatsenko.
- Link to v1: https://lore.kernel.org/all/20260128085842.145057-1-yangfeng59949@163.com/
---
 kernel/bpf/log.c                              | 53 +++++++++++++++++--
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +--
 .../selftests/bpf/prog_tests/spin_lock.c      |  6 +--
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
 .../selftests/bpf/progs/linked_list_peek.c    |  2 +-
 .../bpf/progs/local_kptr_stash_fail.c         |  2 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |  4 +-
 .../selftests/bpf/progs/rbtree_search.c       |  4 +-
 .../struct_ops_kptr_return_fail__local_kptr.c |  2 +-
 9 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce..c7d08b1ba96f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -432,6 +432,44 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
 
+static const char *dynptr_reg_type(enum bpf_reg_type type)
+{
+	if (type & DYNPTR_TYPE_LOCAL)
+		return "dynptr_local_";
+	if (type & DYNPTR_TYPE_RINGBUF)
+		return "dynptr_ringbuf_";
+	if (type & DYNPTR_TYPE_SKB)
+		return "dynptr_skb_";
+	if (type & DYNPTR_TYPE_XDP)
+		return "dynptr_xdp_";
+	if (type & DYNPTR_TYPE_SKB_META)
+		return "dynptr_skb_meta_";
+	if (type & DYNPTR_TYPE_FILE)
+		return "dynptr_file_";
+
+	return "";
+}
+
+static const char *trusted_reg_type(enum bpf_reg_type type)
+{
+	if (type & PTR_TRUSTED)
+		return "trusted_";
+	if (type & PTR_UNTRUSTED)
+		return "untrusted_";
+
+	return "";
+}
+
+static const char *rw_reg_type(enum bpf_reg_type type)
+{
+	if (type & MEM_RDONLY)
+		return "rdonly_";
+	if (type & MEM_WRITE)
+		return "write_";
+
+	return "";
+}
+
 /* string representation of 'enum bpf_reg_type'
  *
  * Note that reg_type_str() can not appear more than once in a single verbose()
@@ -439,7 +477,7 @@ static const char *btf_type_name(const struct btf *btf, u32 id)
  */
 const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 {
-	char postfix[16] = {0}, prefix[64] = {0};
+	char postfix[16] = {0}, prefix[128] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "scalar",
@@ -473,14 +511,19 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 			strscpy(postfix, "_or_null");
 	}
 
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
-		 type & MEM_RDONLY ? "rdonly_" : "",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s%s%s%s",
+		 rw_reg_type(type),
+		 trusted_reg_type(type),
+		 dynptr_reg_type(type),
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
 		 type & MEM_PERCPU ? "percpu_" : "",
 		 type & MEM_RCU ? "rcu_" : "",
-		 type & PTR_UNTRUSTED ? "untrusted_" : "",
-		 type & PTR_TRUSTED ? "trusted_" : ""
+		 type & MEM_UNINIT ? "uninit_" : "",
+		 type & MEM_FIXED_SIZE ? "fixed_size_" : "",
+		 type & MEM_ALLOC ? "alloc_" : "",
+		 type & NON_OWN_REF ? "non_own_ref_" : "",
+		 type & MEM_ALIGNED ? "aligned_" : ""
 	);
 
 	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 14c5a7ef0e87..141c611de1cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -69,7 +69,7 @@ static struct {
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
-	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
+	{ "new_null_ret", "R0 invalid mem access 'alloc_ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=" },
 	{ "use_after_drop", "invalid mem access 'scalar'" },
 	{ "ptr_walk_scalar", "type=rdonly_untrusted_mem expected=percpu_ptr_" },
@@ -87,12 +87,12 @@ static struct {
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=48 in struct foo, "
 	  "but arg is at offset=0 in struct bar" },
-	{ "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_node_var_off", "variable alloc_ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
 	{ "incorrect_node_off1", "bpf_list_node not found at offset=49" },
 	{ "incorrect_node_off2", "arg#1 offset=0, but expected bpf_list_node at offset=48 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
-	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_head_var_off2", "variable alloc_ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
 	{ "incorrect_head_off1", "bpf_list_head not found at offset=25" },
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
 	{ "pop_front_off", "off 48 doesn't point to 'struct bpf_spin_lock' that is at 40" },
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index 254fbfeab06a..b365010e47c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -13,9 +13,9 @@ static struct {
 	const char *err_msg;
 } spin_lock_fail_tests[] = {
 	{ "lock_id_kptr_preserve",
-	  "5: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2) "
-	  "R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
-	  "R1 type=ptr_ expected=percpu_ptr_" },
+	  "5: (bf) r1 = r0                       ; R0=alloc_ptr_foo(id=2,ref_obj_id=2) "
+	  "R1=alloc_ptr_foo(id=2,ref_obj_id=2) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=alloc_ptr_ expected=percpu_ptr_, percpu_rcu_ptr_, trusted_percpu_ptr_" },
 	{ "lock_id_global_zero",
 	  "; R1=map_value(map=.data.A,ks=4,vs=4)\n2: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=map_value expected=percpu_ptr_" },
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f2ae9640886..b497e61a3224 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1090,7 +1090,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
+__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
@@ -1111,7 +1111,7 @@ int skb_invalid_slice_write(struct __sk_buff *skb)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
+__failure __msg("R{{[0-9]+}} cannot write into rdonly_dynptr_skb_meta_mem")
 int skb_meta_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr meta;
diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
index 264e81bfb287..60f3f9e4d3a8 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_peek.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
@@ -100,7 +100,7 @@ long test_##op##_spinlock_##dolock(void *ctx)			\
 	return !!jiffies;					\
 }
 
-#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+#define MSG "call bpf_list_{{(front|back).+}}; R0{{(_w)?}}=alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
 TEST_FB(front, true)
 TEST_FB(back, true)
 #undef MSG
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
index fcf7a7567da2..ae6cf9efab5f 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -40,7 +40,7 @@ struct {
 } some_nodes SEC(".maps");
 
 SEC("tc")
-__failure __msg("invalid kptr access, R2 type=ptr_node_data2 expected=ptr_node_data")
+__failure __msg("invalid kptr access, R2 type=alloc_ptr_node_data2 expected=ptr_node_data")
 long stash_rb_nodes(void *ctx)
 {
 	struct map_value *mapval;
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
index f2b8eb2ff76f..87154ca70bb4 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -60,7 +60,7 @@ int BPF_PROG(test_array_map_1)
 }
 
 SEC("?fentry/bpf_fentry_test1")
-__failure __msg("invalid kptr access, R2 type=percpu_ptr_val2_t expected=ptr_val_t")
+__failure __msg("invalid kptr access, R2 type=percpu_alloc_ptr_val2_t expected=ptr_val_t")
 int BPF_PROG(test_array_map_2)
 {
 	struct val2_t __percpu_kptr *p2;
@@ -84,7 +84,7 @@ int BPF_PROG(test_array_map_2)
 }
 
 SEC("?fentry.s/bpf_fentry_test1")
-__failure __msg("R1 type=scalar expected=percpu_ptr_, percpu_rcu_ptr_, percpu_trusted_ptr_")
+__failure __msg("R1 type=scalar expected=percpu_ptr_, percpu_rcu_ptr_, trusted_percpu_ptr_")
 int BPF_PROG(test_array_map_3)
 {
 	struct val_t __percpu_kptr *p, *p1;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/testing/selftests/bpf/progs/rbtree_search.c
index b05565d1db0d..f060d7ae22fa 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_search.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
@@ -189,10 +189,10 @@ long test_##op##_spinlock_##dolock(void *ctx)		\
  * Otherwise, the test_loader will incorrectly match the prog lineinfo
  * instead of the log generated by the verifier.
  */
-#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+#define MSG "call bpf_rbtree_root{{.+}}; R0{{(_w)?}}=rcu_alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
 TEST_ROOT(true)
 #undef MSG
-#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=rcu_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
+#define MSG "call bpf_rbtree_{{(left|right).+}}; R0{{(_w)?}}=rcu_alloc_non_own_ref_ptr_or_null_node_data(id={{[0-9]+}},non_own_ref"
 TEST_LR(left,  true)
 TEST_LR(right, true)
 #undef MSG
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
index b8b4f05c3d7f..f9836e8fd100 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -13,7 +13,7 @@ void bpf_task_release(struct task_struct *p) __ksym;
  * reject programs returning a local kptr.
  */
 SEC("struct_ops/test_return_ref_kptr")
-__failure __msg("At program exit the register R0 is not a known value (ptr_or_null_)")
+__failure __msg("At program exit the register R0 is not a known value (alloc_ptr_or_null_)")
 struct task_struct *BPF_PROG(kptr_return_fail__local_kptr, int dummy,
 			     struct task_struct *task, struct cgroup *cgrp)
 {
-- 
2.43.0

