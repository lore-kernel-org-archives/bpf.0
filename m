Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006B38E5C5;
	Tue, 23 Jun 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195120; cv=none; b=DBTTu5mFe32fHLACAQJO0KEPCmFLuVcervTzjltEbNLVw8ddJ4o4Fr7k0fYxhh0AzK6bL7E2sM6RNFaVNaJFdTy7KB86f9arn8JQNIBdBSYbFdIytghrZF0lZg3JSmeaChixuV/vgxLaEI56jjrIeYeX0K7gs0blDYAIJ8SePeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195120; c=relaxed/simple;
	bh=EqejjFPKBOmUcFQOJ5jvSSPGnliBOLNbER/4+6efYrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPrjhPG4WsgEutWW/SO+/wET8gku4i/XH+TRlw6NWLiONn9IioClNwCjSQvJA4vpgI022l+rD6Dg7iByA9ilVkw+88KVCh+FPlH9XfRo2f0l4AbblvRbawY3606bSut2JbfJ7TKeFjPzgi7Qd1XYpNxYDg5DsiOz4OrykNXEdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=BQg8Gw0Q; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="BQg8Gw0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=n+siKkGJ0vSpYZfcy5MVOH01se/8i2/fIl
	oUaI66qNw=; b=BQg8Gw0QFGZZ3t2b7qnZuD8TCWVwqRwm1bZCrELkBd8OVlPniO
	d/iaAjJlx+flijW+A4EVzch+rHKxk2qAm5xXDQxHnbEOsYBwpIAYoY3o1O5UHHpi
	4b7IRxn3HfvcXRJXU3UDqRJeo+SgRVGcfn2Eky8Gpzp+cvV9KE51aS9tY=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQAXKJ1_Izpqkgx3Ag--.57670S4;
	Tue, 23 Jun 2026 14:11:27 +0800 (CST)
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Cover refcount acquire node offsets
Date: Tue, 23 Jun 2026 06:11:10 +0000
Message-Id: <bf2a2033ced272106292de4465b8ef3fb991c912.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAXKJ1_Izpqkgx3Ag--.57670S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5AF48Kw18tF4rtF1kZrb_yoW8Kw1Upr
	40g345AF48X3yxua10yayUurnaga1kXrWrC395Cw1fAr9rXas3Xa1xCFyUuFyrJrWxtwsr
	Zr4jg3y7uF4kZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GF1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_2Q6JUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add regression coverage for bpf_refcount_acquire() on graph-node-derived
pointers.

The rejected case passes a popped list node pointer directly to
bpf_refcount_acquire(), which must fail because the pointer carries a
non-zero fixed offset.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../bpf/progs/refcounted_kptr_fail.c          | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 7247a20c0..024ef2aae 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -13,12 +13,20 @@ struct node_acquire {
 	struct bpf_refcount refcount;
 };
 
+struct node_refcounted {
+	long key;
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
+private(B) struct bpf_list_head head __contains(node_refcounted, list);
 
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
@@ -93,6 +101,32 @@ long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
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
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("function calls are not allowed while holding a lock")
 int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
-- 
2.34.1

