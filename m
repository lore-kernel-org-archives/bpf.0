Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877D30BF6D;
	Mon, 22 Jun 2026 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095196; cv=none; b=LsamH7KOgs2C0HhYhE31Qknlg62YHsXWIyPbcwQg2SvPZ15leuJXsl66Qwy4ag1OkiwD4TWrO0t65Nl4b4Gyaeg3cMm90nvgyEVozmHT/t+MBCuYQ5Ejg9peqLUhDVPhPSmHTxuX0kY4afGDnnWojlGyyxxnGscT5uX4niQmGu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095196; c=relaxed/simple;
	bh=21oQHF+/lIgWotzmxsqlDlg1xetFznJxeGdmAtt6W08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBIQ8PKzbe+I+4Pa0oByDnW5oYG2TfHjffhw1IlxJjJr+4qG5Z6kRPqtKoh6e/jYF3vh5lAm4nNsr32FGyALaUF132rBfm7q+GgFYI1rGzOvTlULyiAySaeygzA/GYbuqbx1t5bqeLXbLg0dYVHbLp6Q1YP/79X8zOrN+LYTzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Q0LWeVUr; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Q0LWeVUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=iUfKMHWzEuWYfUDM/wUw3ltrpuHWMEOMP+
	TGJ1nkcjc=; b=Q0LWeVUrwtpgWyoQpZuf5KGd9VF0lCm32g6n954+AJ2sKoJOEb
	+GNaqj63ugg/f7JBI/qNLKJqSxwxhmXpy75XY0FXAzmuXousChgdJs2p8ykqL44r
	Bm5M28cgZcxPkZMkS+I6Y4BKg+vK3QkIYu/JU9AtE6eo+DPg9tgCYQwvs=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQCHQcEynThqj7qZAg--.19827S4;
	Mon, 22 Jun 2026 10:26:14 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Cover refcount acquire node offsets
Date: Mon, 22 Jun 2026 02:25:52 +0000
Message-Id: <5c0605718efd58ae3b8c44f70637ad1bd5ebb76e.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHQcEynThqj7qZAg--.19827S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1kKF15tr4fKw17Zr1kXwb_yoWrWw15pr
	40ga45AF48X3yxury0yayDZrnaq3W8XrWrG395Cw1fAr97X3s3Xa1xZFyjvFyrJr4xKrnF
	qr4jgFW7ZF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gr1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi-eOtUUUUU==
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
index 7247a20c0..77cda5ca2 100644
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
+__failure __msg("dereference of modified ptr_ ptr R1")
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
+__failure __msg("dereference of modified ptr_ ptr R1")
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

