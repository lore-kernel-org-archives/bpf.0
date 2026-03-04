Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2E3B5315
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634968; cv=none; b=g7SCxdXmsbG3uhc8Fk9S7vI30jrd7pAS0TW6OkLO2C66BR8R9WdTPNcVQwlTV2g/USgOnE/9/b07yafA7fZGKuWNGrUJ+e4Jb/TujDpHX+zG8A6YXDw2aCgTYQvmeJwrPfiGUJHftj71JHAujj90v84YZc9fK1S2a1hMm4NRalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634968; c=relaxed/simple;
	bh=BqZXOAJGIKKd92V/RAYQDxNC6AlkoRpcSBFvvTkyrIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo/mi2AtT8StmdpdwjDOMp1n+IyXtFh3B5N+KByU1lzSMS/vStbxNTc9XjHdqnbuS49jlVO72VjDMhTg/2N3Cv0Ta+WpEInEHL+IoYyos4FWj0rS94L3xchtNBKRSyDI/r5zguOwNFuL31ddFru5yIG/dK6mGuhokVaVHrLEs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFT0B1eC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFT0B1eC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824a829f9bbso3257507b3a.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634966; x=1773239766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dc9SHoQTccjHJ9ny8JNU6itOYKrSyJ60RaW6+NKZF+0=;
        b=YFT0B1eCFTamUd2fHrTmd82K0Hg2jWgof/dUlkj1aGV9skjBGMqkGCuXJHSTngo7z6
         a+wrR78YQdIeLBJuK03VNpd3nXYZZwf2pnwyMOLCb/TspsdtphpCh6C6sJhyDlizWuHX
         XM95FTocNPIQ5J3KPsoKzjTAMLpVbhdNKa4KzvLKi7d77B8nLlxc8O9yrbtQLnyCUgKj
         8cGmP4WRTxYYbRNfnkSLCAGyCbsTye827oSsLu4VV4R+1VRn2BdKWefoFfJYVYkYVnJG
         72DyQlebzp/Ye9Ds9q7CA2Iizmk1jQNBDCA+eoL41gNzADsaEcpAeDZkiEyZTozG/SUO
         ooaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634966; x=1773239766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dc9SHoQTccjHJ9ny8JNU6itOYKrSyJ60RaW6+NKZF+0=;
        b=Vgl0vaF8T0CL/UMrMkcZ5zTagtjM+er+SDWLZCyz3HCcC5SsOjP7I8Bh6asUKZ6peM
         7AaTeCW1hm3wDIgd6612H+ME2hWrok7M8mTUWIiPRn3ct9M6J81/quMOcorbOhVLzJXX
         8wSSu7Pt92Pm4eDdSvXxaBUmvfR5qPVEpkwB+9DuYJF4Fsf1juwt9QBGA9HrcW7ZVqNI
         e0a+iK7pK7wZLtG/NdqjUBthWduEV/owuEDhh1Y3zw7djvPokOofZ7eyqTguQY14iG58
         eeq7dNQiTqzZO9qXeVJ6XMiTIaFhXgVjt4BDTiIZ1J8t5n1l9R+vjrPCm9TsuKAxda7S
         0JQw==
X-Gm-Message-State: AOJu0YwPlc9uZoGwRwlGv6J2tOcLJmoHN0H8/klvLknZpClwMyXg/Amf
	K/G4qmtFy7u/W8XrSL8VUUh6rGPgXUgNoNT7EPzDY4ndD45W64/k7/6q
X-Gm-Gg: ATEYQzx0y73OMoCRnmv8bXn4eRL60xrJ4N54MXajX8WC7Gn7bnOKeZlShkTcN+U1cSU
	z4az5yfhvptwfih2J1QV/R6qcCV3D97TNPkhKh25ASQUcs/b4Ru1erIIbkgijpQG2WnATB5tohl
	z4Hiqiq8j+45dCEuc2GG5aWXTc5nwOV4kc4TkikZt+EfqGl3k5lxqfxzS4hQyjbwuxBAmXIdwCj
	uNqRFps/Qy1hh8NbTUMCdfB/fyhEqsZODThLBuVltxnV/YT5MwGg9Ioyr7o1+6VyS2VW0wIjJ71
	bsjUpCj26twqeRtbTnl3aR3LlR/soyFjCeOvCVej8lMpaIlHpGPlfaoH9rvmUw5LaWmfXlPj8G/
	w2dpXYrBCMg1wyqtFL5hQ1CxiU1adzaCAMr0ershjlPnfliTYUXNSXD3KVtrQihmijnAVXh01vH
	hltuy1k9QEVuPonpshs4NYi5S1rU25n+3SksH1lfwSI0HzUI8wgZd1jA==
X-Received: by 2002:a05:6a00:218b:b0:824:9451:c1e9 with SMTP id d2e1a72fcca58-82972df1b4amr2144267b3a.62.1772634966159;
        Wed, 04 Mar 2026 06:36:06 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:36:05 -0800 (PST)
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
Subject: [PATCH v6 5/5] bpf/verifier: refactor kfunc checks to table-driven approach
Date: Wed,  4 Mar 2026 22:34:59 +0800
Message-ID: <20260304143459.78059-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304143459.78059-1-pilgrimtao@gmail.com>
References: <20260304143459.78059-1-pilgrimtao@gmail.com>
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

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 93 +++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d133d18aa0cc..25961cf83a67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12600,6 +12600,60 @@ BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
+static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_pop_front,
+	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
+	KF_bpf_list_add_impl,
+	KF_bpf_list_node_is_edge,
+	KF_bpf_list_empty,
+};
+
+/* Kfuncs that take a list node argument (bpf_list_node *). */
+static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_del,
+	KF_bpf_list_add_impl,
+	KF_bpf_list_node_is_edge,
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
@@ -13000,26 +13054,14 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_node_is_edge] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_empty];
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
@@ -13037,10 +13079,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 
 static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
+	return btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_kfuncs,
+				    ARRAY_SIZE(bpf_res_spin_lock_kfuncs));
 }
 
 static bool is_bpf_arena_kfunc(u32 btf_id)
@@ -13129,17 +13169,12 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_node_is_edge]);
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

