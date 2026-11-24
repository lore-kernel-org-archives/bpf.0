Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550100;
	b=AZ79j+oGBhbUnAPZTpU9pepMBn6BYA0I76h03cGilGDEeLXtGzUjfgvCocRza33w0VaZ
	 TN/7pDQT2+OANPkf4PkG2vPO4KhyvYyQ31cNAz2R29YY/1/XNljTnsVi0x4+4C9jyfWYB
	 LVV0EnvE5t6dp9Ne8PVHicEWTdELJ/EHmocyW6P+gmXvpTq9a/T0ymi43ekMyO8VlCJhY
	 TbaHRv0P+YwwcW0m8VWPmrDsVkgp4YTeeegXwgX1Co0J0vHcDBD3zWJ7lOaQbFrTafz66
	 tF4jmafNfSbI2wbU6Nf19uajVtdvEs9M7wQk7/rybOxryzl64jwWZsEYKssnZRdjb2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=7whKGxelO0nBlI0mq2f4o+9M/PlTKmfmDxnyfAyTMd8=;
	b=KVxshPQOy4w8UCM84SeUrWyXNW5A1Q6JozpqgZSOwaQJbD3cLBSM0BsLPNLOYLNBsDsW
	 S5XEHaBxvvzRBOHhK51NeH1Ep4wYjRN3sP0Uzvtaj0dXy3m+FLEJGoXarwloo02XOtUnk
	 r/9FPSt9PMIpA/r7VBOyPV+bIN1bmhJpXgGdphbuejwK7tT7jq0OzTDzPu9nIPvVOg2CV
	 Ck57tgvlwSbDLxUcwOOA6QDhbiLyw2/dvppuSwLbVEP4JadH4EsnFC8+u+iboZJ7G5SqT
	 koI5vJAruPBSpDJm4EhMBAKf4drSPoym3LGYg22lP3OXUz1ojJ0GUbH3wv0e3p0ILtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWntAbQY;
	arc=none smtp.remote-ip=74.125.225.133
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC2606A32D
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DC2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWntAbQY
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so16766805e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795550098; x=1796154898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7whKGxelO0nBlI0mq2f4o+9M/PlTKmfmDxnyfAyTMd8=;
        b=RWntAbQYs5UKDIgxzIThMNOqPSGgM1mHJQPAQSycw64HnGru3SljQnDFIa3nikovFT
         MVD1QFwvEKjsph7vPkr3dud2Lgt7QkK3G8UMvhiXiK/uV+Zot/neA6GvtNhFX8/Kyaiy
         34RICwjXC/Ro0fT0WcvO7ji0IfGq+DbdSrDyIgsLotp9JsU0gQm9hzjj+yiAsbGKnZZM
         zf82+yRQKBXcIeOXs/eALZJTyqORbEE+jou+FRx6fcE/rXf/+yUrcxdqxobABjLe2kte
         /m5hJD73GRS7DzF7bdVQBs6WA1zlQPJBeSfaN6vZOHtoKnrSdqgh0nX3ZHCSPwh1bl7i
         DbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795550098; x=1796154898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7whKGxelO0nBlI0mq2f4o+9M/PlTKmfmDxnyfAyTMd8=;
        b=C0T2CTYFxAxKF0B3wAcfzY+XSVPy2IBum9ypB+eI8qEby1hzDGA/cZ1iBaKcNnKK94
         B2yLwGpifUVQitHM/9HbvXLwhWtxVT3MVU3maXsAKhuTG595Vwt6UiyiNe03vHPKieOl
         OMQ2mjWtwB3zt15r7vxVDrUurbnAjiSrGhT/RU2viekvuzLm3tDT3LxtTC0Rl4u5VHyJ
         idyaU2H6Mxh2A+mBgTvQCcUHFDy7fwec4nFLEo97uxzpFkdNP6aaht28Wy94Qh0/ouQW
         AMu6AoGETbr6pCve3Oj2M/SDvpccSNzg2uUbncNRDkwiyASE/4fAERJ4ieu0+v66jyT5
         bZGQ==
X-Gm-Message-State: APuU4Z+aARBzuAuQrKXaCIX6pUDC56uQg5anCTyV7lLXsGvwT41cf5Gr
	jUUY+BncL30JwmKSUm93QMEhniVQmWeyLJHrL7ktGLILJpJ5g0honu68+UJqFbMuL7s=
X-Gm-Gg: AZFdTZdfQWdtv9E+pULTWCYwyNZQaw8g+Ywvp9KvEpABBa2yLZoZgu1w3wQM7htoPXZ
	bBsYrmC41RF0cJuRsmJeATU8lBaRpz00lodQu5eFJ6lqdW04UUtbRKlwKDYNVbVtkrG+H6b2aCu
	i15eG18zSujlQ/cCc+yUXsBPTcEHegr1xsXjU+3ymzsNvkVhsK55GvwnR8MC7ZzsEKTMFIRWrLH
	lI13UFR8LE5zEiH0HyGdPjRnmY7ly+fxyheuXkP+pW7SyVqfKQc3YGyb/M97HIZ7XnfKCWdQV00
	Z13SKcudXNJRJqoGBLcoJgnHtI2fK34x/sHpfSxpmfGAS45xuuyhsmW8FBJNx+VZj7hReYvt1fr
	7cETKv5RE6jxe2tOLtm3KHz0ZMCkGV5LKJIs7Yw92FXYkmIIPWjC6a+w0o26jmM4t8JFn9szzJ9
	QcAWb24aXkSxOb+xI9BPc/t8h3ahmHkoBLhwVmv8lRCcdUYziD7n0GB1ujrRYTWcNkL3Ood/1nu
	SUxu+EtTraDO5FAwq5MXdXZdQ+rBAJDxNVNfr3zY/AR14uBUnSzdkh0btUNBSpmxj8ge+0GeG2o
	qMqehuK6cLS3lB+E2Q5OLRdokNXVTy9HYQDXwS+qcZPE/GnkHA6hpRicAyH1ddmm24VP+QGPUcO
	LHXNlPRboBUU+IWacS9b7RGKJYbxgyzKphzjcRIA3PWd6Y7kpKgClfQGnzxbLHEnHeE6B6T7AZm
	2zc5BAwIlCl7xT4w==
X-Received: by 2002:a05:600c:1c0e:b0:4a1:ddaa:571e with SMTP id 5b1f17b1804b1-4bb88824f38mr372437115e9.15.1795550097830;
        Tue, 24 Nov 2026 11:54:57 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm552044135e9.6.2026.11.24.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:54:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Save irq flags on the stack when freeing a list head or rb root
Date: Tue, 24 Nov 2026 20:54:56 +0100
Message-ID: <178849392dfb8ddf82d7ba4259be6113349bdc2e.1795550092.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4139; i=memxor@gmail.com; h=from:subject:message-id; bh=xm4C2MNFyl53jGfVa8VfyYPqqKE7aqVyS4AAR+BTtqM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZv1dW+J+MbQ03xTb+XHPZy7rMyzp2GF3PMvWRze328+t VBl/FXeUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcKWH4XyfouuUeQ2iP5kct g8onnSsbGZQSbAQz+0oTTpw4vtQmlpFhE2uhmsAaXp/HuR8FFW4bvQ1/Nb/znGO9p4DNwV1euwW ZAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_spin_lock() saves the irq flags in the per-cpu variable irqsave_flags,
and bpf_spin_unlock() restores them from there. One word per cpu is enough
as long as a cpu takes no second bpf_spin_lock before it releases the
first.

bpf_list_head_free() and bpf_rb_root_free() take a second one. They lock
the list or the tree that they free with __bpf_spin_lock_irqsave(), and
they can run while a program holds a bpf_spin_lock of its own.
bpf_list_add(), bpf_list_push_front(), bpf_list_push_back() and
bpf_rbtree_add() drop the node when they fail. The drop frees a node that
has no other reference, with its fields, and the node can have a list or a
tree itself, like struct foo of the selftests' linked_list.h:

  bpf_spin_lock(&glock)               irqsave_flags = on
  bpf_list_add(&ghead, foo, prev)     prev is not in the list
    bpf_list_head_free(&foo->head)
      __bpf_spin_lock_irqsave()       irqsave_flags = off
  bpf_spin_unlock(&glock)             restores off

The program returns with irqs off.

Keep the flags of the two functions in a local variable, and take the lock
with __bpf_spin_lock(). Both functions unlock before they drop the nodes,
so nothing else runs between the save and the restore.

A failed add drops the node since the commit below. Until bpf_list_add()
existed, an add failed only for a node that a list or a tree still owned,
with a reference of its own, so the drop freed the node only in a race
with the release of that reference. bpf_list_add() fails for any node when
@prev is not in the list.

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..bc0dd36a2799 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2302,6 +2302,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock)
 {
 	struct list_head *head = list_head, drain, *pos, *n;
+	unsigned long flags;
 
 	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
 	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
@@ -2313,7 +2314,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	 * section, and end up doing map ops that call bpf_list_head_free for
 	 * the same map value again.
 	 */
-	__bpf_spin_lock_irqsave(spin_lock);
+	local_irq_save(flags);
+	__bpf_spin_lock(spin_lock);
 	if (!head->next || list_empty(head))
 		goto unlock;
 	list_for_each_safe(pos, n, head) {
@@ -2325,7 +2327,8 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	}
 unlock:
 	INIT_LIST_HEAD(head);
-	__bpf_spin_unlock_irqrestore(spin_lock);
+	__bpf_spin_unlock(spin_lock);
+	local_irq_restore(flags);
 
 	while (!list_empty(&drain)) {
 		struct bpf_list_node_kern *node;
@@ -2362,19 +2365,22 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 	struct rb_root_cached orig_root, *root = rb_root;
 	struct bpf_rb_node_kern *node;
 	struct rb_node *pos, *n;
+	unsigned long flags;
 	void *obj;
 
 	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
 	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
 
-	__bpf_spin_lock_irqsave(spin_lock);
+	local_irq_save(flags);
+	__bpf_spin_lock(spin_lock);
 	orig_root = *root;
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
 		WRITE_ONCE(node->owner, BPF_PTR_POISON);
 	}
 	*root = RB_ROOT_CACHED;
-	__bpf_spin_unlock_irqrestore(spin_lock);
+	__bpf_spin_unlock(spin_lock);
+	local_irq_restore(flags);
 
 	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
 		obj = pos;

base-commit: cbaaeff649b7aa09170cb31db001e5468c2726c0
-- 
2.53.0

