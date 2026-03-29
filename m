Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE773603E7
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793153; cv=none; b=EwlfZETzpqCAD3p5SDQjL7rZM+lNZf/3NTRHg+eMy0U4I+y9hR8qlxUtZtRinj+NmN7c4oN4XpX/IBMrrm4A48+lOMkiiWRdS0b8DNz1fxBE1JKKLdwmCYkIuzgindkLrOXz5K+tjj/auIDRC7cpcTCKfJHYL8fjjsd4N+LheUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793153; c=relaxed/simple;
	bh=m4Dp/QO1CQwIaQ7zOXjACVsoK8KivPGSGTVahKCzCOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr+2YyvRIlo+JId29MusDkLrDrPeVOgB7/F69DqejmQYwj04LZJ/eDIiA/uKzq+yTDpgvx78RpV+8dYZcWK3ALll4F/12P4gLTjhnvnpkR+5b0gNIS9qT9SoN1FXSJATphjSvT/cWAah9y8ijVl0QcFmSrzyhXaCG77IPbbvGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfMv6AxA; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfMv6AxA"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-358ed696623so1640439a91.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793152; x=1775397952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38DTT79mtCXKXJ8Z/5bB5pjQPLerUM4+fkGr6yskgL4=;
        b=pfMv6AxAxDbMNVnjgOEadQHLR8OA1E5im8YgJTmUjR4QcXZm0C4froJjGFHhsQiFhr
         1r/sFhu784VbykkK8IpvC4umPnpUL8EfHIzrRuWg5rXZc2EM820GnNcTZHuKTjG7QdJF
         dg5/UI5Oh3BTMFoixYZXYs49+D/ADEv2uG6yqgIF2y/gJuP2gbDO/UHbG38DLsCOTcES
         zp88WxyglGBSjcbkjBOrtU2oaHyRjkXgl6tO+yHzkCHS2ppRpz6G339OkmjG+NnZaPbj
         EmIjQ/DlJQIvLN75YOM1TbohXXDyd+l5RzHgEyL1RHvOjdXtn1JYKAdYscq6Nx4aIhxa
         /mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793152; x=1775397952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38DTT79mtCXKXJ8Z/5bB5pjQPLerUM4+fkGr6yskgL4=;
        b=ANbhHJJ/A2EClYWTMl73XPxntE2EoCBlPA8rdqGVtR7VcAspiEm1mFWOJ+eXdWacMB
         a3bz0n3r+eyALyFjACZsV6MEE39mFrNueshT6H/N3ZwbJ9q2dGTDZ2NVhBHZBslanqzf
         fraMIUiCOS7YvmTh+9jYYTPsBZYNqp3a4yX63moOr9OeHMXs57hFkLns+8o5vD4QfL1k
         49hl618erE0K5tHOjBEY1742eVXOXnbdqrFt4w6n2Po69TBL6ezY1KFGonpHusKq+6X9
         eVgz4l5LvE8scHk5fZHqTtID4L3rgQ4M64F0MJbsX934xRNW1KZNB5J5SPhGd2EXhGB2
         yhVw==
X-Gm-Message-State: AOJu0Yz/Lb7dUnVv5QP0/QUiW2ahtoQNKuOYHTPaoWidPrd3R+enOnNZ
	OKtjugpkc2uO058smbZxuGtMcT7nRF3u0fE6rkNZELArctrrCNLSb3ev
X-Gm-Gg: ATEYQzyG8kp+GL9YETJMcIQLxVDaIWIVMSqMIsangyKeK2QMs5pkkqBAQmm3bbaQ2XH
	d7mxclKnAgN5cn69OiQV8keCVQhhSrCjpqxtihS+9jkCCAHxHXJ+lfx5Ls2O0/lLkKhzq9wa8ry
	Z1srVEOuveDOoSCNwupfdg+MF2zjZf3/Rr3+JZZ6+/rIsOExUh8uMHSZbT/u+WKeelT6KdFRoQB
	5z9bP23yXaVQYR6AL8Z6z4txkAWKDm/Ial3LCOF+86+s5ykmypvmPbbSYHx2Typ7UZxthappCwh
	tbamdZ3uWfyYpyuskmrt2PPNKsEdtLioOQnH/OvLLa26YdU+dmmNz+4PYG3P0kAe89NjMESJtLe
	wqWcv5feYwahEJj3rr3nG6zlh7O5JbB3CAJ/ZY7eNt+c/ymQe1MQk2jNErNAB7VPgHZJn3dLuu0
	JRcucbn7jCwlbJ1Av6RC8Bn1wc05oIWuQFQ4wvOWn9+uvrFEjsJWnxMQ==
X-Received: by 2002:a17:90a:1009:b0:35d:9560:3efc with SMTP id 98e67ed59e1d1-35d9560431dmr3049031a91.14.1774793151838;
        Sun, 29 Mar 2026 07:05:51 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:05:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 5/9] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
Date: Sun, 29 Mar 2026 22:05:02 +0800
Message-ID: <20260329140506.9595-6-pilgrimtao@gmail.com>
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

Refactor __bpf_list_add to accept (node, head, struct list_head **prev_ptr,
..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr after
INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
head was 0-initialized (e.g. push_back passes &h->prev).

When prev is not the list head, validate that prev is in the list via
its owner.

Prepares for bpf_list_add_impl(head, new, prev, ..) to insert after a
given list node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6dddb2377047..669e380746a6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2386,9 +2386,11 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 
 static int __bpf_list_add(struct bpf_list_node_kern *node,
 			  struct bpf_list_head *head,
-			  bool tail, struct btf_record *rec, u64 off)
+			  struct list_head **prev_ptr,
+			  struct btf_record *rec, u64 off)
 {
 	struct list_head *n = &node->list_head, *h = (void *)head;
+	struct list_head *prev;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -2396,19 +2398,31 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
 
+	prev = *prev_ptr;
+
+	/* When prev is not the list head, it must be a node in this list. */
+	if (prev != h) {
+		struct bpf_list_node_kern *prev_kn =
+			container_of(prev, struct bpf_list_node_kern, list_head);
+
+		if (unlikely(READ_ONCE(prev_kn->owner) != head))
+			goto fail;
+	}
+
 	/* node->owner != NULL implies !list_empty(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
-		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec, false);
-		return -EINVAL;
-	}
+	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON))
+		goto fail;
 
-	tail ? list_add_tail(n, h) : list_add(n, h);
+	list_add(n, prev);
 	WRITE_ONCE(node->owner, head);
-
 	return 0;
+
+fail:
+	/* Only called from BPF prog, no need to migrate_disable */
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	return -EINVAL;
 }
 
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
@@ -2417,8 +2431,9 @@ __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
 {
 	struct bpf_list_node_kern *n = (void *)node;
 	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, &h, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
@@ -2427,8 +2442,9 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 {
 	struct bpf_list_node_kern *n = (void *)node;
 	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
+	return __bpf_list_add(n, head, &h->prev, meta ? meta->record : NULL, off);
 }
 
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
-- 
2.50.1 (Apple Git-155)

