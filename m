Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C735C1BA
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546010; cv=none; b=F6EY6bfJE3wwQse9TYPrTxg5fk+dqhJiR30WjRii1BRaPrK47+DLdphtZ7MHBUsLWHM8irJjzDyyKOCuuoPOtv6FMRu4h/1pjO1EDUDF6a5oxpuLAHfEbX67FBUkgrFPmiaVd3PitzvCTGJESVsHZyxpaYqYWJH5rpsXzxkhEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546010; c=relaxed/simple;
	bh=wxWIwJi2U61Y4j1uCGoff+dbH9Ura67jjy6+JYedFtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGDG94X+wvRn1KxyOQQYR9wHgkEvwX5YXjWXfdp4AqWwvVM+BrIoHFEYF1OfM1ag0WSt6mowtEzs0ZoduGiDVe0DA9a9fdJ5L1bMCy7zHizKcPcXX0USK8fpJVZU1UE2bnsvOOLu+80fBJwrLeNKdUgiK+y5DVZWf8CBEYLUF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuOu1iOK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuOu1iOK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823c56765fdso2876199b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546008; x=1773150808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H27Cg5uH76XKjjIH1pPEtY296Pssk09ysV1ForE3RSo=;
        b=iuOu1iOK7vL7sQ34bJQXbd9zkJvhrZfftCPOFozsM5alPXaPihU/lVGi44AIviKWK+
         E1hE5dZd1Am3XWPntnUbOzLlI/67rqYaQWThPzLcj1PySt9Yw+4HIQ0wNSNDOAh1wLkI
         m0K4WF2+NedgGNPtbSNbKp/FJmdpoUIZSFQBHvJk068aG4JFHpz4wioc7aENPnVS1g5k
         df8M7Y14K2RpGq/hxmMxoWmYF67fXlqNxVaocKNvdxAJYt6/cATcS5rJ1RhOwqSvhIxJ
         sSrAB33xeCQFz/eAhbu3ZxDC/lSnN4kEQNTjDeaJ/v0ZMoe4NUrCbC1yWomwECjxkh17
         ZmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546008; x=1773150808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H27Cg5uH76XKjjIH1pPEtY296Pssk09ysV1ForE3RSo=;
        b=P2Y8rkzJOdCzqPGBY/sxIYuxl4f8VjCJuBZyUgN/LaVe6hxPjos6/EG1TVBnhDXI26
         6ya5bSgLggqQCrCGbrhnYsPHb7w4GRsT0QJ1JpLQ6M6qWpeBbYB4HO2j44/r2bmJ6pu8
         +Zbn5aqSfnXq93nd9BLLfXZRIJALTRV4aoPVrWztqVM4RkyTvk1B4sRFg4pw92PNgFtb
         HoCfjd3d8Q3S/GMi0paqm5kSj3eirbL1N6Bey0k42xQe0wZA7cIY+hUsBPks0V2FpMxr
         bixzQF1wGdz0AqAyoPQJUZAbeLM0HpDbPGIDae5efronD9K0onxc0fQxR2WdFjWzUXmV
         K/WA==
X-Gm-Message-State: AOJu0YwlU0Jct8rfjGxwRbPXoDxANHIAN2G4dGbdr61wUwHxpuUDgIy+
	603EPGACgOXnTYZGDQAM0JP6+3qf5uqQcX7cWn9h+hxr10fgV3QbXvNx
X-Gm-Gg: ATEYQzxESZg7vLSgpsHh7eE3UBDLgrIpzAEeJDA0ETLGLqHPnxWQhyjzYh8HomUyQ7R
	0l4sdfN+N1+41KI1woI2AMXi7DMudYndJLrSam06OlzsdKmyOg2e1ECkNOI4u+XaNFWUsBf59wf
	g5/X9cmqQ6Tu143Uay0jbzczT0hs22EHMVIH/a23EnV/6MW6eynlrj/lJwkjEVFonBzaqq3H22V
	GNGck9XiPinpI7THPHE8I8lAf1bh6/+E1HVOu2QApqpkx5R4beGQ+nxe8ZTvNyDAYqqa4bg0ukE
	SxleU7HwnF6sv+iw5Brhy58+kknIQB28YWEhQPDjWRqe7noxdSkERrmfd9QpHubBkNxzNbq2CES
	rSQhqWqOGsAyEG95sPbFXHD91edcNTbdPPZitwKrW+MMgqeb2Sh1jn9+PyGXzrNRe069wJZlROi
	mfSQqNjg49h15zbmErOi9SWBmAXt14Yoajn5tAU3IRKPIcjirX
X-Received: by 2002:a05:6a20:db09:b0:394:6023:a0fd with SMTP id adf61e73a8af0-395c3a7110amr14894176637.29.1772546008110;
        Tue, 03 Mar 2026 05:53:28 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.53.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:53:27 -0800 (PST)
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
Subject: [PATCH v4 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Tue,  3 Mar 2026 21:52:18 +0800
Message-ID: <20260303135219.33726-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303135219.33726-1-pilgrimtao@gmail.com>
References: <20260303135219.33726-1-pilgrimtao@gmail.com>
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

In previous versions, to implement the above functionality, it was
necessary to first call bpf_list_pop_front/back to retrieve the first
or last node before checking whether the passed-in node was the first
or last one. After the check, the node had to be pushed back into the
list using bpf_list_push_front/back, which was very inefficient.

Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
check whether a node is the first, last, or whether the list is empty,
without having to first retrieve the node.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/helpers.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 15 +++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 488810da8f30..3a64a9bab06b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2523,6 +2523,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
 	return 0;
 }
 
+__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
+
+	if (unlikely(!h->next) || list_empty(h))
+		return false;
+
+	if (READ_ONCE(n->owner) != head)
+		return false;
+
+	return h->next == &n->list_head;
+}
+
+__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
+{
+	struct list_head *h = (struct list_head *)head;
+	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
+
+	if (unlikely(!h->next) || list_empty(h))
+		return false;
+
+	if (READ_ONCE(n->owner) != head)
+		return false;
+
+	return h->prev == &n->list_head;
+}
+
+__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
+{
+	struct list_head *h = (struct list_head *)head;
+
+	if (unlikely(!h->next))
+		return true;
+
+	return list_empty(h);
+}
+
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
@@ -4593,6 +4631,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
index 6dfd4afff1cf..78652ccd2a89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12465,6 +12465,9 @@ enum special_kfunc_type {
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_list_add_impl,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_list_add_impl)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
 	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
+	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
+	       btf_id == special_kfunc_list[KF_bpf_list_empty];
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
@@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
+		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
 		break;
 	case BPF_RB_NODE:
 		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-- 
2.50.1 (Apple Git-155)

