Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37202571C7
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977675; cv=none; b=MmtyhukooQ3pnnkdraX2Wo9hq+wEo5OhB6K/TKbLF8sN+H7qPSEAkDD2SQDB79FdK6XnPRi5z7UZXG9+gppFDg3EHHqSreziOKdwW/5lmNyWmz9BjEB5yYcXN8LQfz1T+288/IWhf6DpnbDCBXHTUHWzW76FSzC6zOe+Owd0EkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977675; c=relaxed/simple;
	bh=Zw6ImnSf6lR/+yeVgzkNmTem6QdcwnLp6DHs2X5E5qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m42VmCkB8Z26wM1MLHxBVQOsDJH7gBuIKO/xiczD11rjaROrs5ehIcSUDfeI05geoWZI3HJLJW5Il/qEibQAbk2l1XnxHpUq19zx2oWy7vHy/3RqENvU/N/LkAoNK/XUOMz6jYgxavLIsn6a0GPg3Zz1oRtVDow3DC7k/F6+P7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgij0Y4L; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgij0Y4L"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829865a8471so3533217b3a.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977672; x=1773582472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNkJj3izrk8VdKqI7b13r9RBEyjaruaTSc4dC/sIOZs=;
        b=Tgij0Y4LmHt0UGkjj+6F8Xs8IU15gzIZSkyIpnMhEcvq1QAPo/iu1Da1Ot3MEMkdUP
         Ko9MUOhROb2hqmrjOtJ9Xdqg6ppAoeE0HOOyJxnsPAbsdoymGi9ctrOaqulxaMvjLxhp
         dbMr0oOCy83r6KHYWJKK1UuIFvhemI0sl1ukTG2v60NUFhKSkHUDz12iHRbZ75XyJFdB
         HnkYoLVTj3jyFtBWpzHvkeoAYWnHR0VixurK1x00Os2Axh+kwbLzTJupwCoeYS5hIrgl
         OEYgzbbFL9FdrioeWDLbkDpvLV46Jm/8rhBbeXPhK3orVVh3YZdCyveMdD+gTLmTovmn
         Im0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977672; x=1773582472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eNkJj3izrk8VdKqI7b13r9RBEyjaruaTSc4dC/sIOZs=;
        b=Dc/gxG8HiB61kIrmcfLp5FHcUZYXS/dNn2v0Xat3Pwfk8Ur0mypnzRN+rj5oL5Cq65
         EO6lLCqYMsPLBzVPVBxlepL6sjxGOQhlyfP50dKuyWig33ceWbvI43FO3ZMUY5rjhvCB
         Mf3VMLnxy9mEcu1pnoegyn8AHmWB+fcSPFWi6t4Dtf/SgbD3Ix3MNNJTFoID1i/5smMy
         QNVFLHNrslt8lNJxtMdN8/FecLj8sz33aiVQUBui6ecWUgHbsqGzAlux7ITx6qJlHa2F
         bydsV4D0RVvdcKUJOhsDMoACVQbz0VRcXuLU0GdbxGY5ugA8mT5JOBQelnnnSJdMmyse
         QLJQ==
X-Gm-Message-State: AOJu0Yxh4SkpfyixYQjOa4aq6w52vgO3Rk4MN/jXPkOA8mm3k9YvEG7Y
	+WY3hal+8B0B1DCcURPletlzcg0yQEz1JL+e/urPUZDg0g9pMJlhrkvj
X-Gm-Gg: ATEYQzwJqTnvPaVsS036VBcnRDdIQKFetLvEdKrbH9y4AK9cwapQjufRYYbkFD5cq5B
	vwqbOiBEvUxn9FBezpyLEZc/Kv3GY6WTfHU8m/+zMhKz80xTicMHN5lz7AmgvYDBQZ9TShso8rx
	wvXpx6BdrhLlAqq/+4FBTAYKy9pEw0avNOInBJiXD29pJdAaeUGPWH8wUVQFGXoT1Kdw7+Jkapy
	yY0O8bEJnp4hQdfFaCHd9R7VQRfPwGpNMQPwjMprK9prRrrHE8pbMFv8aFatIGCQDB6/7HsPmMw
	0D5e26aE0dVoO1f2HuveuOy+n6Y5VvFKecZW4sckJ6VjKro3JKE8rngAuu+lNhL4LYUSDPZHyBp
	WraKOmg4P6UHKemIO+Cpo4IIpDVY6C43CwPZcnYY+Q7ivpGgKEDEI/LXLLWM0QC+D2n6Shq8/jC
	15jTvtEXHR4UCgcbr24cqIMNaP0mHmZAf2wQrAgyTb/z87Vijc
X-Received: by 2002:a05:6a00:f0e:b0:829:8ac8:ea35 with SMTP id d2e1a72fcca58-829a2f6f491mr7428397b3a.51.1772977672416;
        Sun, 08 Mar 2026 06:47:52 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636968sm7095056b3a.9.2026.03.08.06.47.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 06:47:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 5/5] bpf: refactor kfunc checks using table-driven approach in verifier
Date: Sun,  8 Mar 2026 21:46:14 +0800
Message-ID: <20260308134614.29711-6-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260308134614.29711-1-pilgrimtao@gmail.com>
References: <20260308134614.29711-1-pilgrimtao@gmail.com>
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
 kernel/bpf/verifier.c | 97 +++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e32e02429c4..853716f599ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12602,6 +12602,62 @@ BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
+static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
+	KF_bpf_list_pop_front,
+	KF_bpf_list_pop_back,
+	KF_bpf_list_del,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
+	KF_bpf_list_empty,
+};
+
+/* Kfuncs that take a list node argument (bpf_list_node *). */
+static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_add_impl,
+	KF_bpf_list_del,
+	KF_bpf_list_is_first,
+	KF_bpf_list_is_last,
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
@@ -13002,27 +13058,14 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 static bool is_bpf_list_api_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
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
@@ -13040,10 +13083,8 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 
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
@@ -13132,18 +13173,12 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
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

