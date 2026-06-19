Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3F351C3B;
	Fri, 19 Jun 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856028; cv=none; b=H9HFbdIS7sNAsIJkHW/1oyjnz07U89Wf/XFjybrmlIqfpmbB08q37FXx7dgMRXfIqzCeZ2bodmJTBkrGEPqI3EtXsy81hezciPNivvmaQzGFkCFOKS3ug+l19JHsxVrwPFnSAkJZtf6ZvRJyZsLBBm2pZjb4OBXcUKDFdh/gdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856028; c=relaxed/simple;
	bh=vyAk2ECky7Myx6rskWD6k74o5a7QYMM+dnMMc1amnn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ViGA2p+tQcNfc/t7zfiSEW6exn7BjhFb2v4Y6jct7pm7Q9+MwqhY7VcFYuyjIXZf/l/ImfT0YqlYeSgrGkb9yt2yMMmroYzxjXVCX9THJvl5RXp8USSf9stVgrUr7ZekNHULWKL8WVu2RgMKWr5Y1QzQ/4gos05v16VmaxSX0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=J1sD7lws; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="J1sD7lws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=XnEDMmuGczioRYbILvmY0RPWeT06wjdkjC
	Q3qZCMIng=; b=J1sD7lwsElouv48vB830uXX+yHaJtdqiiWPrA4Wp3C7ZMCxyDA
	9VHxrSFxKKVKUB3rCnY/iYkaIhg1V4C1AdvK7VoJHyqmsgKmg52Qo97fK2RlqNzF
	WMPYVaEglTbqqkkym7m3BUggkhS7G3QVw5/oEhJ5Wx3Vj6crtHz7URNLE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAX85r79jRqhz5nAg--.64298S4;
	Fri, 19 Jun 2026 16:00:09 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover refcount acquire node offsets
Date: Fri, 19 Jun 2026 07:59:54 +0000
Message-Id: <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAX85r79jRqhz5nAg--.64298S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWrKr4rCFyxtw1kKw48Zwb_yoW7Cr15pr
	4jg345Ar4vq3yxury8tayUZr1Sgw18XrWrG395Cr1fAFn7X3s3X3WxAFyjvFyrJr4Igrsr
	ZFWjgFW7ZF4DZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GFyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREeHq5UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add regression coverage for bpf_refcount_acquire() on graph-node-derived
pointers.

The accepted case pops a list node and normalizes it with container_of()
before acquiring a refcount. The rejected cases pass popped list and rbtree
node pointers directly to bpf_refcount_acquire(), which must fail because
those pointers carry non-zero fixed offsets.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/refcounted_kptr.c     | 33 ++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 84 +++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 61906f480..7955a9973 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -741,6 +741,39 @@ int list_push_back_uninit_head(void *ctx)
 	return ret;
 }
 
+SEC("tc")
+__description("refcount_acquire_list_pop_container: acquire normalized list pop")
+__success __retval(0)
+int refcount_acquire_list_pop_container(void *ctx)
+{
+	struct node_data *node, *base, *ref;
+	struct bpf_list_node *list_node;
+	long err;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return -1;
+
+	bpf_spin_lock(&lock);
+	err = bpf_list_push_front(&head, &node->l);
+	if (err) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(node);
+		return -2;
+	}
+
+	list_node = bpf_list_pop_front(&head);
+	bpf_spin_unlock(&lock);
+	if (!list_node)
+		return -3;
+
+	base = container_of(list_node, struct node_data, l);
+	ref = bpf_refcount_acquire(base);
+	bpf_obj_drop(ref);
+	bpf_obj_drop(base);
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
 long list_del_without_lock_fail(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 7247a20c0..f6cb084af 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -13,12 +13,22 @@ struct node_acquire {
 	struct bpf_refcount refcount;
 };
 
+struct node_refcounted {
+	long key;
+	struct bpf_rb_node rb;
+	struct bpf_list_node list;
+	struct bpf_refcount refcount;
+};
+
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
 
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_acquire, node);
+private(B) struct bpf_spin_lock lock;
+private(B) struct bpf_rb_root root __contains(node_refcounted, rb);
+private(B) struct bpf_list_head head __contains(node_refcounted, list);
 
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
@@ -31,6 +41,17 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 	return node_a->key < node_b->key;
 }
 
+static bool less_refcounted(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_refcounted *node_a;
+	struct node_refcounted *node_b;
+
+	node_a = container_of(a, struct node_refcounted, rb);
+	node_b = container_of(b, struct node_refcounted, rb);
+
+	return node_a->key < node_b->key;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=4 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
@@ -93,6 +114,69 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("R1 must have zero offset when passed to bpf_refcount_acquire")
+long refcount_acquire_list_node_offset(void *ctx)
+{
+	struct node_refcounted *node, *base, *ref;
+	struct bpf_list_node *list_node;
+	long err;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return 1;
+
+	bpf_spin_lock(&lock);
+	err = bpf_list_push_front(&head, &node->list);
+	if (err) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(node);
+		return 2;
+	}
+
+	list_node = bpf_list_pop_front(&head);
+	bpf_spin_unlock(&lock);
+	if (!list_node)
+		return 3;
+
+	base = container_of(list_node, struct node_refcounted, list);
+	ref = bpf_refcount_acquire(list_node);
+	if (ref)
+		bpf_obj_drop(ref);
+	bpf_obj_drop(base);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("R1 must have zero offset when passed to bpf_refcount_acquire")
+long refcount_acquire_rbtree_node_offset(void *ctx)
+{
+	struct node_refcounted *node, *base, *ref;
+	struct bpf_rb_node *rb_node;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return 1;
+
+	node->key = 1;
+
+	bpf_spin_lock(&lock);
+	bpf_rbtree_add(&root, &node->rb, less_refcounted);
+	rb_node = bpf_rbtree_first(&root);
+	if (rb_node)
+		rb_node = bpf_rbtree_remove(&root, rb_node);
+	bpf_spin_unlock(&lock);
+	if (!rb_node)
+		return 2;
+
+	base = container_of(rb_node, struct node_refcounted, rb);
+	ref = bpf_refcount_acquire(rb_node);
+	if (ref)
+		bpf_obj_drop(ref);
+	bpf_obj_drop(base);
+	return 0;
+}
+
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("function calls are not allowed while holding a lock")
 int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
-- 
2.34.1

