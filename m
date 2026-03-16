Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F921FF38
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660545; cv=none; b=aEFej21cfTZNFvJdrRB05RvuTU1eTkMsMiCEdWftbbKYQzGeVAAMrcr5/JbVNlhIztvzk48/CZpHUFny5h06H4TLeIwlEjP0TZMIXxjKUUr5GBWwfKIffitFRcWj4z3ZJWBfET14jHNmYKnWnl/Vg9QYVjS9eSZqTyIZv513AzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660545; c=relaxed/simple;
	bh=qRnnF/d9ao+ix7V4nQlSqXFAnI53UccsqHirYypmr0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFNxo5+hiZaufsyEQrXFPeP02vg7JAqUn9r8SLr3xokDUYKsYuYY/TFeB7amKhMzi5CiIVZnCRzcxjluO6LvqQA8eWDeWDALBM5F+3jlc2JMzexir6fCZyiUJGdAPfIUwie/eedvs/ONDZ82CQQf5zuBobv3+yCOCWL3dHQ5Or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2CapIAX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2CapIAX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2943354a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660543; x=1774265343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxXRm33amG5I2paW33zzs2AvrNuv3vxVlJtBFRjkyIk=;
        b=a2CapIAX4AC4yyZJZ1kNSUXcjU3XlYiK9J/6m1BwZD18azY8N3PySNJxqwclrsA6hT
         rgCKwZPIWNlRT5/AfHw9FrtYgJNmgrWiLda6bDeGp+LNS6ij3kUVFmWLYvA9Ed/El9sL
         fzjXOLexbLkoX2yJ+cE3weQcpe69kwuk+oYvLzp7ZTqCETkpxecSYrNDRkOJoA2r9xbs
         N0YNkt2fe0i8VX3SXvfXjvVJ3UCBdyn+2A41XpO+5LA1DjxRGQsxJkgEIZYz9K/Wn7zi
         EJcXSChuTJ/bfhpA8O3jjGW6Zo4EsELFn/SnPLrr3lodYuUHcZDQXhBrvK4bN+3UqS5m
         NENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660543; x=1774265343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxXRm33amG5I2paW33zzs2AvrNuv3vxVlJtBFRjkyIk=;
        b=T6lphYlRikE0DQMJ8nZTaf0EG9jMpXfIVeiOFfZxLqkgr9h/E0DY+ipa8r7TsB6g2i
         4/AeRqSfze+gQ95hqfBR7Cect8o1MiZXmfQkPnboXyL9zdiMclNZLgmicfwvi2mARHI/
         L2hVAHaciTSZP3KnRLMkGkQ+1++UwH43wWoRUlL7+RB9dXXt4rzDZqXwsfXAESxHFVag
         3HeMKeHBviTM4TE96qGBLoDShoPglJWHRZ3UmqvvLyVe0N9nS9e/IELCDhdHmTibA2s5
         BhthbpHDVTgg0Yso7k1SGtpNqit6NEoEnzvTM3NlWXCIdfHJTwDP5SmY1/yB1Vz6Caz5
         sJQQ==
X-Gm-Message-State: AOJu0YxbOaV8U+z1ete8prWuP9hcIAxwBs5n+nfAxGVnJovTMttNjxgY
	S+WWHtN1FflDYljcMhouB4TN0Y4Q9TwFnSrmhdWqTUOBzHDGFSQscWnN
X-Gm-Gg: ATEYQzyrLbKA/+3Ik6yDNmqh+bg1PSeUCHYLzUZPqw4gUpVQvaIb0nu77o4mDYrgFB1
	EuBk2WxUZ+Om/nT6onPkbVaBnu6Ks+tXYLeXQUpDlY5ycS0F0W/poX4ziuvZ6U9MpfZKHHG3X6D
	WrnWYKn8TEgFzCKTc+KpbBfeDkclex6RtrUvUfRVOJ3CH/CARzLqjDHT7TRb/YmfmZIbxGRBLMQ
	CbC6lnaSYFMEYZ19QRbUy90hWAgu3b3wUoGodHfxThHbvA5LndPQtiGUby++SIKvgMzO0ZiGHcj
	PUSk6jiVmdU10AHZPWbAgWH3xS/hI6EQOx29jw0fXJ5iuAJ5XvVP+y/6iyOz49u2Mx3JCwkw26k
	dEl6PN+9oWOJWIfzT3Zijv9XoCLsARFR0zUV0rg3Mxv9m6ycoF3Nhc4tpPUGZqRVEkQQ+Awjb6P
	stBKPNgFJq6zspIZNCi58EHLIdhMVDmgVSMa4f4FzOG7RnCcHySkAz8Vo=
X-Received: by 2002:a05:6a21:3388:b0:398:a306:d64f with SMTP id adf61e73a8af0-398eca9d7ebmr11676718637.30.1773660543229;
        Mon, 16 Mar 2026 04:29:03 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.28.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:29:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 1/8] bpf: refactor kfunc checks using table-driven approach in verifier
Date: Mon, 16 Mar 2026 19:28:36 +0800
Message-ID: <20260316112843.78657-2-pilgrimtao@gmail.com>
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

Replace per-kfunc btf_id chains in list/rbtree/res_lock and graph node
checks with btf_id_in_kfunc_table() and static kfunc tables for easier
maintenance.

Prepare for future extensions to the bpf_list API family.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 79 +++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbacd2149cd..64c1f8343dfa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12639,6 +12639,53 @@ BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
+static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_pop_front,
+	KF_bpf_list_pop_back,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
+};
+
+/* Kfuncs that take a list node argument (bpf_list_node *). */
+static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+};
+
+/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
+static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] = {
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_add_impl,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
+};
+
+static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] = {
+	KF_bpf_rbtree_add_impl,
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_first,
+	KF_bpf_rbtree_root,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
+};
+
+static const enum special_kfunc_type bpf_res_spin_lock_kfuncs[] = {
+	KF_bpf_res_spin_lock,
+	KF_bpf_res_spin_unlock,
+	KF_bpf_res_spin_lock_irqsave,
+	KF_bpf_res_spin_unlock_irqrestore,
+};
+
+static bool btf_id_in_kfunc_table(u32 btf_id, const enum special_kfunc_type *kfuncs, int n)
+{
+	for (int i = 0; i < n; i++)
+		if (btf_id == special_kfunc_list[kfuncs[i]])
+			return true;
+	return false;
+}
+
 static bool is_task_work_add_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
@@ -13038,22 +13085,14 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back];
+	return btf_id_in_kfunc_table(btf_id, bpf_list_api_kfuncs,
+				     ARRAY_SIZE(bpf_list_api_kfuncs));
 }
 
 static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
+	return btf_id_in_kfunc_table(btf_id, bpf_rbtree_api_kfuncs,
+				     ARRAY_SIZE(bpf_rbtree_api_kfuncs));
 }
 
 static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
@@ -13071,10 +13110,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 
 static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
+	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
+				     ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
 }
 
 static bool is_bpf_arena_kfunc(u32 btf_id)
@@ -13163,14 +13200,12 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_node_api_kfuncs,
+					    ARRAY_SIZE(bpf_list_node_api_kfuncs));
 		break;
 	case BPF_RB_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_node_api_kfuncs,
+					    ARRAY_SIZE(bpf_rbtree_node_api_kfuncs));
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
-- 
2.50.1 (Apple Git-155)

