Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2437A486
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793171; cv=none; b=FjiR89zJ4v4HkwJ9fQAuidge9P0CfgTGxii9PGdlIOFgz37pQEduJCc9sLR+TzoWIHoYjlY2jfBewElVZ+mcMP/6bnERm9WHQoeVMHeyuUc2bA7c+qNkyFK3f5lPiV+0YihEzUBRn6jlBqCtMMwmVJoPqTUSM5a+DdmJ5CUwgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793171; c=relaxed/simple;
	bh=PJGK20G/EyaqmP1Vc9CVFdFypEO545O2570T0iwtLEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsucE3bAU6DKnMCQsd6bgzkCrZABzM5xBX9R5DpQAUcHWNNvuLo1SsIIc6vY9yUX8UH5J9Hc5ah2EKdERj/ZAJ5xGqNM8Ae35UdKIMr4GZFyWQu3AsdXTdKPXUmxuoMc2C5oWzAPWGr9oCqJnXMhdllFR2zP4PGulrXupGvVjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHkXOTrE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHkXOTrE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so1756311a91.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793170; x=1775397970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEXeG5kJjdDQbEYeMVL6/LNMSdciV0H1QuI3w9LhyDw=;
        b=rHkXOTrENKwiy9WklIkCf2zrc7DOhw3wkHUaNSNPlUDXiT0cpJgHUfefMDBtQhqzMA
         lGf/6ibMq8nZBl4jSTQDo/H6HaO7TUMDnHk1telNES9f5uYhEnP9eZv8pVKc00NjPHTu
         dXgb8OpIDf5KtevFNr7nNqdgQnNithTQIKZMYUL5Wyj4g6l7GKc00wV+2dRgayj69b1m
         1TO8wlecinEdHHIfFtu3YGlrVv/sX6uzp6kmh+2O4EgSxQvnIM38GFDWHlpwscXjaOni
         Ghl/6NRC/IVGioTWPkbUFR6zKJK79nJ887hJcdGOJSV0E+tG27h21tTETxyBx+NWAEd0
         M04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793170; x=1775397970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEXeG5kJjdDQbEYeMVL6/LNMSdciV0H1QuI3w9LhyDw=;
        b=Cw9LAmmy4xsrpU1CFpyl8tPQSqZ8QgcyDq5i3qXkYxYDkp44oqLbOYw15TzOOaPrzs
         wtW3PcpU2zSS1VPLfVlwRYD+c+c0gAtlglxKp9rZdvecaNl8ylyXNl/C96YSivvniVbB
         sJ41350+CY7ZRihKstlOgWwk+snkqZfihG+MYddDtQxbT2vIlS/8/EO70EloOotepxDC
         JAOaG3pxnUGgbL5OGUHrVW7zbSqzsH9GqukF5HtFdb1NNxRHdLZmzvhL4Nf058SZSR6z
         o+tvvazxKLihOMkBe6jX29TjxtdAr0ipDWbTKLGUOlzqUTel0vZNjfxG2cLdEoCmLU3w
         4Blw==
X-Gm-Message-State: AOJu0YyHXJBnA1bEdwi6b4FuvhI+WXvW5CrMHcSlgjsQQoFdodffkZ1q
	5kH+iZo5MFKxc8ilenqJK2jMqpTDwaKNVqXk4y7f013I9HVteQFT3u5S
X-Gm-Gg: ATEYQzzVUvTfKCKo41YdtiRA6Uh+QRT/XD7FWuUjlMSHFiT10bl5uXXjGhiVIg2yPpr
	s+MJbTnHFm99tqGVazGsAhvxV/Ilqxi83/JMDXi4hh3aTFuTPAbmfmgh3vEbj4ScoIo1rgj0WDN
	o/IMP8jjSEMfyvcRzgybSVqDvI3vuBNl6ElYKREXSfGK5zXTkS+uS1CFS7Vu5iH0RDfzHsbVmcn
	0HYdzfg6zn3ofzack6FQDqrVcTywTaNiOgs82syhPpu+JZb2PajRigNVbXmYTU/ApRjtHzfjTCC
	bzfPFMiLzngVc0YiueLGfSTYxOInEXLW5Xh1hHQHRtSofUHpzhJtQ6g6LBc7jhdOGRTGOWPXj78
	5KbpBS9DUtN/iVRxN2JJGfIHaZOlcuHfCB5rAq+0MHFHksIcMEhq/J/CCwX8VacL+GgyvBTPUeO
	AfVXKMxSLGoFMK65s0TB9oiLSBwNvC6Q1PDYuOjK5dXiSXiGlNZbskajHCEddup1N1
X-Received: by 2002:a17:90b:3141:b0:35c:936:d4cc with SMTP id 98e67ed59e1d1-35c3002fd1fmr8949840a91.14.1774793169987;
        Sun, 29 Mar 2026 07:06:09 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.06.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:06:09 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 8/9] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Sun, 29 Mar 2026 22:05:05 +0800
Message-ID: <20260329140506.9595-9-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329140506.9595-1-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Add three kfuncs for BPF linked list queries:
- bpf_list_is_first(head, node): true if node is the first in the list.
- bpf_list_is_last(head, node): true if node is the last in the list.
- bpf_list_empty(head): true if the list has no entries.

Currently, without these kfuncs, to implement the above functionality
it is necessary to first call bpf_list_pop_front/back to retrieve the
first or last node before checking whether the passed-in node was the
first or last one. After the check, the node had to be pushed back into
the list using bpf_list_push_front/back, which was very inefficient.

Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
check whether a node is the first, last, or whether the list is empty,
without having to first retrieve the node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/helpers.c  | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 49 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 743341aae5c0..5f778da2e560 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2529,6 +2529,41 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
 	return (struct bpf_list_node *)h->prev;
 }
 
+__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+
+	if (READ_ONCE(kn->owner) != head)
+		return false;
+
+	return list_is_first(&kn->list_head, h);
+}
+
+__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *kn = (struct bpf_list_node_kern *)node;
+
+	if (READ_ONCE(kn->owner) != head)
+		return false;
+
+	return list_is_last(&kn->list_head, h);
+}
+
+__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
+	 * called on its fields, so init here
+	 */
+	if (unlikely(!h->next))
+		INIT_LIST_HEAD(h);
+
+	return list_empty(h);
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4599,6 +4634,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_add_impl)
+BTF_ID_FLAGS(func, bpf_list_is_first)
+BTF_ID_FLAGS(func, bpf_list_is_last)
+BTF_ID_FLAGS(func, bpf_list_empty)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 514a0aab93b8..33fae482cd56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12489,6 +12489,9 @@ enum special_kfunc_type {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12551,6 +12554,9 @@ BTF_ID(func, bpf_list_pop_back)
 BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12630,6 +12636,9 @@ static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
 	KF_bpf_list_del,
 	KF_bpf_list_front,
 	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 };
 
 /* Kfuncs that take a list node argument (bpf_list_node *). */
@@ -12638,6 +12647,8 @@ static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_add_impl,
 	KF_bpf_list_del,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
 };
 
 /* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
-- 
2.50.1 (Apple Git-155)

