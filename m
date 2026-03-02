Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5206375AB3
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455288; cv=none; b=VuAavfisxqbNmUIRXAMnjejzE6KgvwZ+SoOiVSeZtm9nA5lbtp1N7zm3OvTn8GCSb4/dh2iX7DxWy5KCPV4zRAgKNLesr4K3XOtqPwj/199WXFgXzmTrv5sh6Ml7CQ+/01pZDuv3zu7CDfl2s04N2/pe3Ytp2e+3eI7U8VvQbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455288; c=relaxed/simple;
	bh=7sRo4nVSCezbQYCJvvf3hIL9zJ9NiAOafmugyoPklZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1ED91aV3ZHnHH0UOC+/HDixsJBdlW3UT1ioNOyKKXUiXusmEHHay06tKtZ9K7plHAJePUnd4XmacJ8PnZDXLwD550y9myEF2RN/nknZPP+3o64FmWcO5+YEczI3O9G1vyHh7aEhQwoxtD8hpCZnsaTv4itRQr6cv0VW5ppuWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq6iNcMw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq6iNcMw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad4d639db3so19928255ad.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772455286; x=1773060086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWf2v8BqqxkSzBu1cxjzyfYlLbJQrEJW5Zx/O8qgXUk=;
        b=Tq6iNcMw2e6aKqPi21Jz3tBpnP7q2rxyoK0WIKF23o5ZIDIv/HT3oYT3IRRxo6sMvM
         SrL0vDbXdkQTDN/EAKPJsRHJrA8pco+LIuimKgJTjSy/3NlVdX8ytlhax9XJtBQ8ktch
         bxSrQEI8s3kOuD0/+FDJjn7UfAXKJPz85mgABK7b1ZHgDPRgew8R3gpa1/s8L/Lw9gsN
         WV/TuY3OeSLXxX41H4KZU3uG8X4qgt12qXXX117G/V+42k3FVVbmfdE+l+9bnAXPOJBQ
         Xk3ObOlo4hHt2wWExAL3Uvv9WqSKEgbkOjr8CjtCZOGi2dBIA5MtRVBxW0LQO4KTx9ew
         VB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455286; x=1773060086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWf2v8BqqxkSzBu1cxjzyfYlLbJQrEJW5Zx/O8qgXUk=;
        b=xOIPaHB84Umyfj+90bA6zhWrLjPyMTF6/ZZKU6UZhPSZsO8rzJbt8AHjYoOGrbwQq/
         qXTHinzSNuzKeLfc6fNzNBWmJ34AEqD2JLaiYsoAe448BNkX/396Oj+p62/ayi8aLEcR
         H74QEf/3/Zainq4f2doZ6gx7wFAqAF5zUUfD7AzNNDSi4ysws/Dd0c9GSj6oDMYlEHEt
         nGC1VHASTgm8ICfffzt7juJHna2eLetO4g57kzRpqhA9xNtwdiDFEELIn4na+uLTX/w5
         MDkyT95RWXm8UP0GDg/9qsexYNJZ4TL5+UpTR8VDQ6eYPK5nd6vexvSZSUAOgTNdMQ/t
         OhbQ==
X-Gm-Message-State: AOJu0YwTlVDIfMwpEedd3nUhiBCJHfGB1jRXb+Bdia/NwWLjt7WqxN0d
	JZ9rghqNmPdsky6cQgq49VW2PPMA8MaVfQGX9nYRRz7cX5a6qbv6yRsT
X-Gm-Gg: ATEYQzwO1JBny/H8P/9UkkNref2ryH+3p44dL8AwWmLsmPVQcZdqgEJD6/B15xacS8D
	x9/zbOFtMpNQs4+zskL6xtaTWVzRe5WARDIpKmvGH9ybF76YyttJuDgoyg+Zbu+ZbRfKsit1xw4
	q1xQ9ggznlSMDDwdv6W33YJSaa45+kjCwB6JhepLhw6WpN+knqejYNhrbnnPK7yFFt2Tt9YsdYS
	sG53BXhXZ5+vQxiuFRUovk0JNfZLB1JzuwioxfZ5TayS93Csa6FsyQKtavvhq2HIYBWYY/+OMa1
	WVT9tNgv3tExcBTN5U4sdYPlLJTe/IXswSavKrbuov7g6iO4vUl9e1IoBTIKA4Kxtn3dcEdbrFo
	bq7uIQQvsayOSryR13V0xZgjQVxQ0vEWvlMbR/638iCTRRClxBo6yUmwo1L3TyXMA5OA/CDlTv7
	qqu/selReHjV51vHV7NxN/U97K0edZgDdAx850j6F3/nylvZUKVUNhj0y3EwqKxoJS
X-Received: by 2002:a17:903:2289:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2ae2e4d6622mr132178515ad.46.1772455286289;
        Mon, 02 Mar 2026 04:41:26 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1956absm67910225ad.14.2026.03.02.04.41.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 04:41:26 -0800 (PST)
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
Subject: [PATCH v3 6/6] selftests/bpf: Add test cases for bpf_list_is_first/is_last/empty
Date: Mon,  2 Mar 2026 20:40:28 +0800
Message-ID: <20260302124028.82420-7-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302124028.82420-1-pilgrimtao@gmail.com>
References: <20260302124028.82420-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Rename test_list_add_del to list_add_del_and_check and extend it to
cover the new kfuncs: assert list non-empty after insert, assert
is_first(n) and is_last(m_1) after bpf_list_add, and assert list
empty after removing both nodes.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 15 +++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 27 +++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 48106ea5dda8..2eb107e771ad 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -123,6 +123,21 @@ extern int bpf_list_add_impl(struct bpf_list_node *prev, struct bpf_list_node *n
 /* Convenience macro to wrap over bpf_list_add_impl */
 #define bpf_list_add(prev, node) bpf_list_add_impl(prev, node, NULL, 0)
 
+/* Description
+ *	Return true if 'node' is the first node in the list with head 'head'.
+ */
+extern bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+
+/* Description
+ *	Return true if 'node' is the last node in the list with head 'head'.
+ */
+extern bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+
+/* Description
+ *	Return true if the list with head 'head' has no entries.
+ */
+extern bool bpf_list_empty(struct bpf_list_head *head) __ksym;
+
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 4d979f5ad9e8..6797c53f550e 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,14 +367,14 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
-/* Insert one node in tree and list, remove it from tree, add a second
- * node after it in list with bpf_list_add, then remove both nodes from
- * list via bpf_list_del.
+/* Insert one node in tree and list, remove it from tree, add a second node
+ * after it with bpf_list_add, check bpf_list_is_first/is_last/empty, then
+ * remove both nodes from list via bpf_list_del.
  */
 SEC("tc")
-__description("test_list_add_del: test bpf_list_add/del")
+__description("list_add_del_and_check: test bpf_list_add/del/is_first/is_last/empty")
 __success __retval(0)
-long test_list_add_del(void *ctx)
+long list_add_del_and_check(void *ctx)
 {
 	long err = 0;
 	struct bpf_rb_node *rb;
@@ -386,6 +386,11 @@ long test_list_add_del(void *ctx)
 		return err;
 
 	bpf_spin_lock(&lock);
+	if (bpf_list_empty(&head)) {
+		bpf_spin_unlock(&lock);
+		return -7;
+	}
+
 	rb = bpf_rbtree_first(&root);
 	if (!rb) {
 		bpf_spin_unlock(&lock);
@@ -418,6 +423,14 @@ long test_list_add_del(void *ctx)
 		return -8;
 	}
 
+	if (!bpf_list_is_first(&head, &n->l) ||
+	    !bpf_list_is_last(&head, &m_1->l)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n);
+		bpf_obj_drop(m_1);
+		return -9;
+	}
+
 	l = bpf_list_del(&n->l);
 	l_1 = bpf_list_del(&m_1->l);
 	bpf_spin_unlock(&lock);
@@ -434,6 +447,10 @@ long test_list_add_del(void *ctx)
 	else
 		err = -6;
 
+	bpf_spin_lock(&lock);
+	if (!bpf_list_empty(&head))
+		err = -7;
+	bpf_spin_unlock(&lock);
 	return err;
 }
 
-- 
2.50.1 (Apple Git-155)

