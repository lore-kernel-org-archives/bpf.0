Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311B37701B
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455281; cv=none; b=KF+5MRz1EiGXcbHpL2Q/BW/iJboZZ0NASIzn67+cbDD0kYHrGJtqOlR8F6CB9R1dPyFZOV0EWTYCEVfNp/CClujo76rivUit8HUlmwaq2YgLflXZQoMJNSehVws3OVE47fLR0c0CIAm5ZpmZu+xU2NGeRDdl9hgk1/OwPqdbqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455281; c=relaxed/simple;
	bh=2pc+l+8zW6c1fnoyVeTRp6x7p+qsm1qsJPaPbldYX2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEyu3j+/FAnt0hWenF0lMdNtdF94JEUDA4mWygO9mFrE8K7XBHs69MdSAfdp5cx+NY/LgrLLbjnF/wiPQh8aPSeYGhv85KGyeccRsbx5wWUwoIHNlmRFIpP6qmhoyEmkPUeDxoBjNkgp2w5gNEJ++2ey0/7LkCAsoHKLJlSOVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jR9tBpKj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR9tBpKj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ab232cc803so20994915ad.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772455279; x=1773060079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQj9PZXDyoiFhstulTRfahJNDAtfPbHGLUSOWnLuMe0=;
        b=jR9tBpKj8cRU6K9RpXtRAuQEyhSV9jqj1exq8LFo4CkRZREXMMEdMU30MhOpF9Ht0z
         zdI8LC5yeYrOBHX9wsi3FsuAu8xIw5WHtzIZWzDlwWCmYBAwtyIukzrWsjTWipHf/ksL
         BYiNXVFF1AklWLUWwNOYPCqPTMA0OzYRGKENI2rvaucmiLaqjhDazhEW4IktCLAyJly/
         KKyrq0DVzuyMA5Em+P8uwcbDndL+j17B1EjMvUaDsTzWcPfrtD+onmUv7kvbl++dLPXR
         demAhesCeF3Z3cDVWZILuWKaEjrgfdKgASPcMA2Ko7t5TyFcUpo0eKIsAv4XSyUQ+FR+
         ww+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455279; x=1773060079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQj9PZXDyoiFhstulTRfahJNDAtfPbHGLUSOWnLuMe0=;
        b=XndTDuUQyD1ueR736Od9z4RvHkj9RHscLtmlcDyEU3JNz/wgS3aYbnaJp20BE2nBdL
         jSdaMHtfEr52JLUzDiPJUNzWY40Kx78TJnvEp4t9xTCpBthUED8upahEQyn+snsDMWba
         OiMODh6sz+2ie/PbWUz1weGdrUpktF43HMqr9LuZuphHKezRBAGJmI+nGS0pS4Fu2VUj
         ESDslrlnVt3NGvi3cPVoExsOl8c0Bel22eC5AUN0V5rZ4ODw8d0Q/Re43GBziTeZhq+K
         y57sgkvyDDLdbdB3cCnbMY2DiaKM61NncZ/7mjhFlF68EWYM6hVla13sSZcAxB76V8CG
         yhSw==
X-Gm-Message-State: AOJu0YwwVAbdeNidhHaFY0vHZgkZOx29Y+haOzF8+rhBc7eOPUloVE5X
	DxhJbhJH1INggsYqW2hl0XQHtflhmkfpaOtihEBCw1CiPcDQ4o+oEAlu
X-Gm-Gg: ATEYQzxBT5GlQHuttd1VpEGnrTosjihhHsNrwO/hs/vfb0MSV2DaVRY2TSPuhhBM8C/
	9PFNrSNj5VgsZF2X+ifRD563npBVE0poLMUdJmHFcexHuymLGqDTzeHu4qAOhsr82TNwUx6SYBR
	ip0jo1D2S0A/Ehuw/2NSZNuEOjRPBs7v+RCjm2y2QHnAZV+0Lj0BDy4qmEA/h6iqaAxYHKX826a
	RfKeh1DLLZnbWViq3GEvdlyyj05ZNwNUyctDY+PwBe4VR/9xzkLOraRsO64C/0Mc+PJd2etDeDO
	tkQcaqd40VA+6wfqRXDaHiGcE72a38Jw8vv+F+pOkQCUrZ4FYZh8bKZOXmaiY9W/acxKw69jnm+
	oVxtzD1qOJ+MH8XMvBL6mV/Ab1qjnq9GFGF8wJEiBCoCjN4ErDweGVbuD7st1p3vIpOIF1wglGO
	EjwWR3+sXFg7eaMRbgTAzHN5YrxNmDbZwxn1VVaJTLODCkzMvqnLO9tg==
X-Received: by 2002:a17:903:35c6:b0:2ae:54b2:27d1 with SMTP id d9443c01a7336-2ae54b24ab8mr21528065ad.44.1772455279208;
        Mon, 02 Mar 2026 04:41:19 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1956absm67910225ad.14.2026.03.02.04.41.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 04:41:18 -0800 (PST)
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
Subject: [PATCH v3 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
Date: Mon,  2 Mar 2026 20:40:27 +0800
Message-ID: <20260302124028.82420-6-pilgrimtao@gmail.com>
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
index d212962d4ed6..ada14eca58ab 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2528,6 +2528,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_node *prev,
 	return __bpf_list_add_after(p, n, meta ? meta->record : NULL, off);
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
@@ -4598,6 +4636,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
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
index f5ee11779a5c..1c36b0938da7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12454,6 +12454,9 @@ enum special_kfunc_type {
 	KF_bpf_list_front,
 	KF_bpf_list_back,
 	KF_bpf_list_add_impl,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
 	KF_bpf_cast_to_kern_ctx,
 	KF_bpf_rdonly_cast,
 	KF_bpf_rcu_read_lock,
@@ -12516,6 +12519,9 @@ BTF_ID(func, bpf_list_del)
 BTF_ID(func, bpf_list_front)
 BTF_ID(func, bpf_list_back)
 BTF_ID(func, bpf_list_add_impl)
+BTF_ID(func, bpf_list_is_first)
+BTF_ID(func, bpf_list_is_last)
+BTF_ID(func, bpf_list_empty)
 BTF_ID(func, bpf_cast_to_kern_ctx)
 BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rcu_read_lock)
@@ -12992,7 +12998,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
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
@@ -13115,7 +13124,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
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

