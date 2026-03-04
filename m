Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419153659E1
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594227; cv=none; b=tKaimhYaJA4QLACuDHCS10FFZWi7PP3fTwd/Q0BlijhkgoQxtXWdSmpvTZaCEaSA/I/Wy3PD0pwAXIUj87XKvdZ5quLHnd3ZZTJ7wJ7X0AKgxyyJ/hEVhPoEystDZeLl/mAyfNXE8HFAeNA/ShUu4RtJU+lUP88gWHeu0Qr8Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594227; c=relaxed/simple;
	bh=3C6ttGuLl8L64Q1LnoiZLd+0O95EfQxJe16UcmlcmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M69N6dt5ZqDBG9TUNoLHSBieIHSBve8B2hXdC0iGWyQMI2EOgGvekVz7xV+etP5cL1UzhD0VKHWH05IGUboQompsRgAl7eK56MNAAc17yv6xvZRJIgkZC6xabTmC1RL2YvySvP7kUtLNY4dKQ5yrJMx8X0lfAXwPuotmiCbNjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5nFKaYU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5nFKaYU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so1430236a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594225; x=1773199025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c4HiRtc5xaPbrfb39uLULAmMTx7Jx7ULuDedQkQ4YU=;
        b=P5nFKaYUXZnKDRygbS9+3yClcPvCz7DHQjZXzi5OycrqrU5iB1AJ4NUTXYFwrESchr
         7FkjJtAHowjHD4t2eL84nGWVYYaM4Xpra9FCzxbzyU5Z/VPjzbNmHmoO0JlB8cfqFj2C
         1ymixHbiJDTj04hw2XcUu3RlxP0SSWCWq+rN64mAkl1KKCBw2bHng9SQd/U0dg0P4aMh
         hXsAelmIikCbdWI9PUzYFPc0I+tLwP/FO4T3ak92LwyK03JaJ5uO4M6N3Vi4ZSyH63Yw
         3vuusVDcoqT/ve/9T701wLf9RGyGUazZkXq9J8iR1awzzQoQ0rfmSNEDADZyVW/r8gYN
         W1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594225; x=1773199025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c4HiRtc5xaPbrfb39uLULAmMTx7Jx7ULuDedQkQ4YU=;
        b=ZS9iUlghVLnIh1/vMMzki53zlJlTD8ndJVOO7bor3yQ1alGEFycieBO6GirdRL5c8/
         Nw09yExuJKiMhQWVWjpq4J28h6qiYykYJVVzSwUjFgtyI1u3B3HkJ+MqN+cfGfcc0Vx+
         NPydWGCgiCrP5ffvtdlrIZ1K36ytlc9pteR1tlz0x7Dh92UMVcv4hwOpnfwGp4FrHMKA
         kbirdBCG8iGmyg3V9O/D6gjsspmpy/yd71KfbFvbvIKb17yfiIyGyXuD6cY70Nstley9
         N061TQ91gN4Fl0SOa/D7ecBBDoZmFr0lH94I+xjklnAD647DzTGISwzYeR0XCfcIQz69
         2eoQ==
X-Gm-Message-State: AOJu0YyJ1Q2PCmBPal6GDWpiQIo4jwexKCVNgkaa7vfWqF4l32L1mDoL
	GYgPSlKTeYKNsX/i5DVPpapcFFIF9geIR4Ck7Ln6THgbOI61xXJ53tRK
X-Gm-Gg: ATEYQzzqxsLAXktoDkhkjHFxk0R2FW/illUJQ3uTU2U3+HITzMpuD+ok0IKCBLki85L
	yYGvFEBxZv+rK2XMOZHvDSALQH0QaZPORu+4ovStN4lTcQj43Y9nlchfWHH+DKvvSzoSdo2/zo/
	Tw/a02gwLkhqlPMpn/sF8wnp4fX8tH0MANbCZQMCoC8DpGxvH6kW5GfASV9ZriXYA2BhpAqF4+L
	sRI3/t2/xqlkKo8B3hwa+BHyBmZq5cKLP0iyOlj+msnbD3AgsZ17jQKeykJcuOMu1DlY1szrUkv
	o1/e4p5pu15hyUizINk3uVKSXkXxRsNJwYcUQrmmMKna7EHiY0OIWKDAgDqlfS0qaZKK7cFN/yh
	ReJS2Pvmi1sPr5NAzT4pXSSi6XepZ0G51+fHppWsxakvTv5CPLRI+Pz2Pnz2sdGdhoaG2RUWyzu
	EOQKpwZOVPt3H04DkbN1ZsVxV4It41X8lOEfWxtXNwB0wxmbynlA==
X-Received: by 2002:a17:90b:2f87:b0:352:d933:5574 with SMTP id 98e67ed59e1d1-3599ceb537dmr3681684a91.9.1772594225603;
        Tue, 03 Mar 2026 19:17:05 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:17:04 -0800 (PST)
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
Subject: [PATCH v5 6/6] selftests/bpf: Add test cases for bpf_list_is_first/is_last/empty
Date: Wed,  4 Mar 2026 11:16:06 +0800
Message-ID: <20260304031606.43884-7-pilgrimtao@gmail.com>
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
index fdcc7a054095..056b2de19b06 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -126,6 +126,21 @@ extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_list_node *n
 /* Convenience macro to wrap over bpf_list_add_impl */
 #define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, prev, NULL, 0)
 
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
index 5a83274e1d26..1b119fe16f5a 100644
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
 	l = bpf_list_del(&head, &n->l);
 	l_1 = bpf_list_del(&head, &m_1->l);
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

