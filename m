Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB5374738
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660565; cv=none; b=tnJDUWJgaaIo81Eke3N2X6ibMk2MMw3yPGSkvFXqekOzu4PYjymmVvmPTwOiIhVxmLFVZIcd7dCOJ3BJrnRQ/rtBPbUQZWNvBCFd3gQpOfXVCNe1wxmpgiOVqsHF4xQ0hckhf7Wh1SrOPYyvima10EbGMcOkwanR7eaY+SSnEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660565; c=relaxed/simple;
	bh=NqfU9bo52FgrDZTokYHoNf2PxzwuddES9W5iZTUFhMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWOGJjb+CtxZKmSeH05OYGFkDOoWcgdlIxxR4AV65K8NSi0UyL64AAlc13paW+lgHW3VmjUO43it3hFwjJybaHudeDfNjZ6V4f4YQQCqetKhGDFVBs0OhpkzOKUhZag01PTs2htGsCsgESbvCihbxEqPkdKfI1GAruNs3Leqa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBtz2wHK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBtz2wHK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1654686a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660564; x=1774265364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOOxYXSdyRk2XDewcy/Jq7LBl3oSgedlPl85DwcVZpI=;
        b=MBtz2wHK6Qjfc4JaYc0KYGQKJrAOORzHKxDwHHQqsseo+RvD2s2HgDcdUKQsng2egO
         ZaiQFDKUGcgGu99CNd1eNoo3cTzC6phsbHuQ1f+PvQSLPqo9NteDGmENAuaO2YIo/xIS
         qPx91AQ9OkgOi1tsvqsoPYor4aG2Mh42pNdzvEObNpTrqMSXGJrRcFWS+DFCCPP+BkO9
         dBHwODAZl57pTe6WEoFSFVndq0LxpJtnG0XTiXRN3Fkl+cP4TGGhqIvmdnM+hjDCYd32
         H+yHcXk5JVRd8TXUWRVXWuJTq0w2mbOm9kUx2WQ/kbWL12KpIf/N1sFnjA75zsZ8jV44
         Mc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660564; x=1774265364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOOxYXSdyRk2XDewcy/Jq7LBl3oSgedlPl85DwcVZpI=;
        b=PQkAEZQEAEz3c/Z5Be60bW7j8j5PPyOmeGiIPdbOmsvwBb7UgqnM9k0BU1e0t3gYnq
         j4h4Mufwsc2MHwhN+vYw9oFgAgdaTfAV4/OJVEiCfuL2pXnsE20zhKmUAUB5/yOqiwSE
         7NGgDqFdo4M1aSEXDi5164CLFg+Qz8lT8C/kQ+KGMycQm54qYfGgOX9xta2iXUSAJc5W
         fgMRq57U+731+7UJ3EVSk7p/m3sJYSFkl8yQ/nZAFW0+UWSx/uij9V7ZVW/hvoXjZUnv
         4jU1yagRbEmAp+jal/aMalajymO/AIKbqaTqWwDb84RKEJSyqQ1gYt+YMAVBfrdExM0v
         4Ucw==
X-Gm-Message-State: AOJu0Yw6FKYcFLurJweDLogGHCvvH03z62w4MYrWFZFxj36OgyfXBx6f
	6LbFn1sdc6A8c80vaZEEIMzmowBKIQnXFq4NZGyeLUpNOhiWY0PakpFX
X-Gm-Gg: ATEYQzyzTTyIizuTKr0Aj8TOlqxCfx2ChE0HMTy7KCMimz3ywLUkW5I/C/cUYdxG3+A
	E9LUmY3XZIFR8HN1Ai7wOygqdWE0Iq+v8htYo65h27jSJXQU3jCP5A76UjfI6G4D7mt4S1NkRU5
	umEyw7vOjDKyIkb5bC/JbG6g0Lme8lLP/rBYZkWUXzq2f9XB7zpbe1nQenM4/QkVG8SVTrjs/yp
	UCO38kQKcxkWwsLVxuA5+AlESyr6+W4DwKLqFIfIOwoi8YoF1EuWhGKq+p7Bbe1N6azTRPlBC0F
	iBW3lgoxor0irnjmj1I7n+F1bwnJgwjGai00O447cg+ZYANKFSVack9ypkT1gQ+syT7rm99x6VX
	hxkFMIPMwVAtr/ICZnWxehPOmeEJpArUCa+bdFKsmGeyLHixBrB3WN3Fu5smVReFY7n0OIWntm9
	Sy7BogkBqfc6oggad8me47ulSUkn7WyESynUstW2YYNlRfuxRVFYCQ1LcPo6QNBX9Oyg==
X-Received: by 2002:a05:6a21:a8d:b0:35e:8b76:c960 with SMTP id adf61e73a8af0-398ecd38ab4mr11422656637.48.1773660564045;
        Mon, 16 Mar 2026 04:29:24 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.29.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 4/8] bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
Date: Mon, 16 Mar 2026 19:28:39 +0800
Message-ID: <20260316112843.78657-5-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316112843.78657-1-pilgrimtao@gmail.com>
References: <20260316112843.78657-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Refactor __bpf_list_add to accept (new, head, struct list_head **prev_ptr,
..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr after
INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
head was 0-initialized (e.g. push_back passes &h->prev).

When prev is not the list head, validate that prev is in the list via
its owner.

Prepares for bpf_list_add_impl(head, new, prev, ..) to insert after a
given list node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dac346eb1e2f..a9665f97b3bc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2379,11 +2379,13 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 	return (void *)p__refcounted_kptr;
 }
 
-static int __bpf_list_add(struct bpf_list_node_kern *node,
+static int __bpf_list_add(struct bpf_list_node_kern *new,
 			  struct bpf_list_head *head,
-			  bool tail, struct btf_record *rec, u64 off)
+			  struct list_head **prev_ptr,
+			  struct btf_record *rec, u64 off)
 {
-	struct list_head *n = &node->list_head, *h = (void *)head;
+	struct list_head *n = &new->list_head, *h = (void *)head;
+	struct list_head *prev;
 
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -2391,39 +2393,49 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
 
-	/* node->owner != NULL implies !list_empty(n), no need to separately
+	prev = *prev_ptr;
+
+	/* When prev is not the list head, it must be a node in this list. */
+	if (prev != h && WARN_ON_ONCE(READ_ONCE(container_of(
+	    prev, struct bpf_list_node_kern, list_head)->owner) != head))
+		goto fail;
+
+	/* new->owner != NULL implies !list_empty(n), no need to separately
 	 * check the latter
 	 */
-	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
-		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec, false);
-		return -EINVAL;
-	}
-
-	tail ? list_add_tail(n, h) : list_add(n, h);
-	WRITE_ONCE(node->owner, head);
+	if (cmpxchg(&new->owner, NULL, BPF_PTR_POISON))
+		goto fail;
 
+	list_add(n, prev);
+	WRITE_ONCE(new->owner, head);
 	return 0;
+
+fail:
+	/* Only called from BPF prog, no need to migrate_disable */
+	__bpf_obj_drop_impl((void *)n - off, rec, false);
+	return -EINVAL;
 }
 
 __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
 					 struct bpf_list_node *node,
 					 void *meta__ign, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)node;
+	struct bpf_list_node_kern *new = (void *)node;
 	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, false, meta ? meta->record : NULL, off);
+	return __bpf_list_add(new, head, &h, meta ? meta->record : NULL, off);
 }
 
 __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
 					struct bpf_list_node *node,
 					void *meta__ign, u64 off)
 {
-	struct bpf_list_node_kern *n = (void *)node;
+	struct bpf_list_node_kern *new = (void *)node;
 	struct btf_struct_meta *meta = meta__ign;
+	struct list_head *h = (void *)head;
 
-	return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
+	return __bpf_list_add(new, head, &h->prev, meta ? meta->record : NULL, off);
 }
 
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
-- 
2.50.1 (Apple Git-155)

