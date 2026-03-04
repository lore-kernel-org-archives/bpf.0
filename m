Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD43C2FF
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594197; cv=none; b=IJvNURVyn69uRDbQ9U1ZVAJkQna0y+RvuIe2D28ilpq/SDULQGBDRrD3bE9tl01287rxqDepH4UUDTeKj940M71lCPbvkRqVFBty6QtJTTJsP13k1ybLM1cLm22GWsgfe3U/6bZ1f52j59mdoLtl3DbXxKa1OsIPCBb1qBTZk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594197; c=relaxed/simple;
	bh=5k3B4Ygo1wjsDMA1EPhJXyhhcMiqhAMzgiy+JUuepVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRF0cNDtvpnpesHxMZOyYZ4zN51BAW+8/obhElna6+NZ0Qq1kn6H/xuWgyBPH+PyfyFJ644Nd8Zh2Wd3a0nWVrZ8lO6j12jd8MrAX7rVKBvZnj9rOoDYsWEZmEp5jxPvwbTCY3McHc+BXlo5wZfOrOICK8w/9z99kPYwOnfHPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXiXYnWq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXiXYnWq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35990245493so1755068a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594196; x=1773198996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yrYqqdL3L32jfs4+IGyGROm0lZBENJH7/3+fmtOXxw=;
        b=cXiXYnWqyt0MpL47jDycvNwUCu6830PNR2bgK+QA59NNxdSFC+vyKzDouKjF6HuiBV
         nVCXnDNu50UzfiAFiTOSHkq9P7A8xYDR4L9QJg5zbHauE410nlObPXBocoAyspx/lT/W
         8DJc0RkFOwwffgq92CwiCncrGoyOquh+wB+1BzXt82OHt5TtckOlTo1xjyUEvD8Y1sob
         6v3Ub4JoXfWapPDBYH12dqa5V1GFl5ZVdkryw5H4Oy3xcfzm45K0CBEr2+umCk5NCd5Z
         xuJpnUar+QK3CpE/Ixyv3r0E04yf9iKaYnqLwZADMfFHrscnIrRRnn+7u2SgPogEjIsF
         Jf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594196; x=1773198996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yrYqqdL3L32jfs4+IGyGROm0lZBENJH7/3+fmtOXxw=;
        b=VzK5QEpXrwtzFHZxryqCWlCPpwRS+xs/5jcAGRZOo1NgOqxCiFj1J8mxyr/l8vbLHy
         CsIJsUebNbfqedriah2761kIEOijgyTccRcbEA40ZPUJ4nPvQ3Glw/6SOoPP8o5skweG
         g5EHJU4j1h2Zq2ayJ1OPg3iNX/XMPgRiGLCb3FQam+XJ94SXnihd8ua4IvIpJmN7qx1A
         cNgaaUf82Xp5a/NhuTCLQ4156xiHynKIUrcukwCP9j+yrGMJ/GFj9xPShA0zqdTDl3w6
         ngnGk1Vyxv9+VTIEJfd4sqMPOFz9LqYv503zmd2Hq2sOPZ7JfAjAUsN6tM4tcZiaRIN4
         h9HQ==
X-Gm-Message-State: AOJu0YwtlSGaTDHxbsI4UGyI74P76aSkxlWdge2Y28XyYb5Elxtb7+92
	OWfUgYmhq0uuPsXvuUZn7SJ+JZ5RbhFGnl56UqDc1B1peI2XUE8AgOkf
X-Gm-Gg: ATEYQzxGFWn+kDfUg24iHWRAyT5uOsG0HXZAe9ANpxBxFuiaXmNlJziI1I3sDkX1y6T
	Y4c4lXHTBsyNUWNfiqmZmtgc1hNe6wsYhEC/LMNzB/90eelSPCqx733z5xmauRtMwJmY9fl5yZ1
	gBRsLP9qHD2EvllXAjSBp9kIJEJP7bkr16tJeS+IY+SJbH3vt8xvUkPeEIS+1AYtvYYp1YaGmwS
	PPR+R+FV5JdKDPdIZoGukDOAowuxrQcHHWAqf61+gShkGW+RLPQSaWM4mITukKJaBjOSLhDtR+2
	v1Vi6qn1P8Ku4/iCtaeyP/VcnfHiZwaZOpXczrbcK+evaDdfASawHYL8nvFTKEg7+DLOpdzmqFR
	LG6b7IS7mqlYVMvboSEVoU7YoX2U8aLlD2LPE/1NRbBNGsFEG5/21HcVPdwd5ux1hP9xPcQQ6SA
	4Oj6eX8o8nZO1e0GTD7sqEfT6p2R2QeQ5kLZQkFwF0NZYFtkCCfA==
X-Received: by 2002:a17:90b:1643:b0:356:24f0:af0c with SMTP id 98e67ed59e1d1-359a6a4d3famr830934a91.17.1772594195723;
        Tue, 03 Mar 2026 19:16:35 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:35 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] selftests/bpf: Add test cases for bpf_list_del
Date: Wed,  4 Mar 2026 11:16:02 +0800
Message-ID: <20260304031606.43884-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304031606.43884-1-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add a node to both an rbtree and a list, retrieve the node from
the rbtree, use the obtained node pointer to remove it from the
list, and finally free the node.

To verify the validity of bpf_list_del, also expect the verifier
to reject calls to bpf_list_del made without holding the spin_lock.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 11 +++
 .../selftests/bpf/progs/refcounted_kptr.c     | 71 +++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4b7210c318dd..54ec9d307fdc 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -99,6 +99,17 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
  */
 extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
 
+/* Description
+ *	Remove 'node' from the BPF linked list with head 'head'.
+ *	The node must be in the list. Caller receives ownership of the
+ *	removed node and must release it with bpf_obj_drop.
+ * Returns
+ *	Pointer to the removed bpf_list_node, or NULL if 'node' is NULL
+ *	or not in the list.
+ */
+extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
+					  struct bpf_list_node *node) __ksym;
+
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1aca85d86aeb..ac7672cfefb8 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,6 +367,77 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
+/* Insert node_data into both rbtree and list, remove from tree, then remove
+ * from list via bpf_list_del using the node obtained from the tree.
+ */
+SEC("tc")
+__description("test_bpf_list_del: remove an arbitrary node from the list")
+__success __retval(0)
+long test_bpf_list_del(void *ctx)
+{
+	long err;
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
+
+	err = __insert_in_tree_and_list(&head, &root, &lock);
+	if (err)
+		return err;
+
+	bpf_spin_lock(&lock);
+	rb = bpf_rbtree_first(&root);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -5;
+	}
+
+	n = container_of(rb, struct node_data, r);
+	l = bpf_list_del(&head, &n->l);
+	bpf_spin_unlock(&lock);
+	bpf_obj_drop(n);
+	if (!l)
+		return -6;
+
+	bpf_obj_drop(container_of(l, struct node_data, l));
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=32 must be held for bpf_list_head")
+long list_del_without_lock_fail(void *ctx)
+{
+	struct bpf_rb_node *rb;
+	struct bpf_list_node *l;
+	struct node_data *n;
+
+	bpf_spin_lock(&lock);
+	rb = bpf_rbtree_first(&root);
+	if (!rb) {
+		bpf_spin_unlock(&lock);
+		return -4;
+	}
+
+	rb = bpf_rbtree_remove(&root, rb);
+	bpf_spin_unlock(&lock);
+	if (!rb)
+		return -5;
+
+	n = container_of(rb, struct node_data, r);
+	l = bpf_list_del(&head, &n->l);
+	bpf_obj_drop(n);
+	if (!l)
+		return -6;
+
+	bpf_obj_drop(container_of(l, struct node_data, l));
+	return 0;
+}
+
 SEC("tc")
 __success
 long rbtree_refcounted_node_ref_escapes(void *ctx)
-- 
2.50.1 (Apple Git-155)

