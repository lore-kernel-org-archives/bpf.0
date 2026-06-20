Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00391F0E25;
	Sat, 20 Jun 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967890; cv=none; b=EZS7StEFTYcOhBvlh6vvlogIZ9C+m6mUwscGGm3bXS42IM33ioxHiAUKPrHZVvUHnesxIodk40h8NpWO1N+N7no+Z7WdY+gyLMNdv2iwHHyaP2wS17UGa5egYOpvCNqoQjMG+lLqbful6KJlvpn7cHhj4hvhjfrHBdMzuDzph0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967890; c=relaxed/simple;
	bh=jboENMkeQOyag39Zz7CgNumvfeYAlwgJKMLMlLJ42c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQY96nc5ghbFUL9TFU9Srtvyy+j1CoocMxrpgWB/JJq1MoTCz7q10oCq5w3WUnDcwZ+gMTTd5PzNoHf/G8G50A4ZVQgd7R2X2+HcLnjMBJJJIXvBT4cWZUUSfzdF9u47PdvDt9wm4RMgZdce1SHfr4rxoXmPjCMM9Fi3MKFXqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ly8VjhY4; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ly8VjhY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3tWc6RBtSO/C4HtKYouP7MxhDiDSeZ0CAW
	4Mq1Vo5tc=; b=ly8VjhY4p3WkO0N0cMkTfiSjUWXRqXUgP5wsYaVv0KT7pwYmOl
	zVR8pwlIsdATPjBS61N3dvVWjb7sCyrmoy1KqABviGHdSt/4R2qMyxVTtn9T6LYQ
	J7h1UHVfq0lFon1lqt7WMfe7pr9sE2TkC8vrVByJbMy0AKsj5lDcr/+ac=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBnep_zqzZqVGBnAg--.37531S4;
	Sat, 20 Jun 2026 23:04:29 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover refcount acquire node offsets
Date: Sat, 20 Jun 2026 15:04:18 +0000
Message-Id: <628953593f122ed70c6f4e894db982a9a2d67c95.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBnep_zqzZqVGBnAg--.37531S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1kKF15tr4fKw17Zr1kXwb_yoWrAr45pr
	40ga45AF48J3yxury0yayDZrnaq3W8XrWrG395Cw1fAr9rZ3s3Xa1xZFyjvFyrJr4xKrnF
	qr4jgFW7ZF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW5WwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sR_18BUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add regression coverage for bpf_refcount_acquire() on graph-node-derived
pointers.

The rejected cases pass popped list and rbtree node pointers directly to
bpf_refcount_acquire(), which must fail because those pointers carry
non-zero fixed offsets.

Do not add a positive container_of() case here. Existing refcounted_kptr
coverage already exercises valid base-pointer acquisitions, and this patch
only checks the rejected offset forms.

Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../bpf/progs/refcounted_kptr_fail.c          | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 7247a20c0..5ec392e72 100644
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
@@ -93,6 +114,62 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+__failure __msg("dereference of modified ptr_node_refcounted ptr R1")
+long refcount_acquire_list_node_offset(void *ctx)
+{
+	struct node_refcounted *node, *base, *ref;
+	struct bpf_list_node *list_node;
+
+	node = bpf_obj_new(typeof(*node));
+	if (!node)
+		return 1;
+
+	bpf_spin_lock(&lock);
+	bpf_list_push_front(&head, &node->list);
+	list_node = bpf_list_pop_front(&head);
+	bpf_spin_unlock(&lock);
+	if (!list_node)
+		return 2;
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
+__failure __msg("dereference of modified ptr_node_refcounted ptr R1")
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

