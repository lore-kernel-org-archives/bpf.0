Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E721A453
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011697; cv=none; b=EWEj7j40zJiajcvvS8ywsMtAMka2vrvUyZE6gtmuWef/QZ/mF5zERwkAy4nl6SsrBIbyl3Qxj2/OXYDQSMQeWMptN4L2IWL/Swf4LmVaDjHjHEvudb2HJ/Y2gRHmaSoJ1pMb53UIj8quvMXlIvCYiDXaoRrFdzxYgB7qZiNhKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011697; c=relaxed/simple;
	bh=TUkrUM5RCj94MKh5jKoSSPGDxsIxViCDTq4/BrGFtiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff5N8xW2DMkYpMz1FyTkSGpBhnsGgrgT8SBbIDnit9YwNAaPNQ8JCGu58Hm04b8iOd54yLUbqiziwXPPT7rf5xHRjF5fv+7BIRLCRFUfDvn5YNspacHjjCY+qsn9E/Z8m17pdP3/iNoTBQMFmXDtecvx0x7LRAsSseAiWfYWqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJZ6UwZT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJZ6UwZT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-358fb86de36so873788a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011694; x=1772616494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGuc+6wfePsL6aB6sAwQhLsZz/tjnZCJ1WumwwWFEEU=;
        b=DJZ6UwZTyMr0W95Lb1AuEzuqv9N/ofOUmirFuomUadNy69TSoZ4MdslSzSX+UJsc12
         I2KR1hjsVkrW3mrPbt7eBdm5yE5Spyj5QnTvqVIoxt/Lh4HA1kTBsfxjl3OjvPe93qE3
         BDfD71rTDtaf+0nl3lJYji7Ta07jaXXgr935EwJOIks7jmi9fkVXhYSOKk+gaVSZxwar
         lYJ9sgMgFjEoXJqlydV0go1S+c0eyhYAOfUV4Y70tOLCyjZeprvFFPdXaEFX3UwW2DAy
         8rRHYaLyYWKlek9433FyakUkV+UlUylVcnOCeCaoASRwUjczfLND2JeUJhcrUOP2vcuq
         A65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011694; x=1772616494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGuc+6wfePsL6aB6sAwQhLsZz/tjnZCJ1WumwwWFEEU=;
        b=NRszjxBuv6/ccoWpNoXXvz1YVY7D1hQolkSFCwFF2Dc3FbsdT+LXf3t6K3orwikzw0
         ZCOWdoV5dt0Ey3O/5z1Ytjh+2dXI9kzDiQnpNy+u95nsF6s7BJ5FTK7AA+GW3ZDbZQ7/
         9Rp64WnI/ZHDf6QlRFwaT2aNrN83mQrxq8B2ILzBqSMBUSBti9YcBNvl/tANZu5xqxrU
         uNRU+UbH1+NWIFjOSbvU/Ydk+8M76MWNdwZuqJLtV324m+FalzwGXplqQCyQVKrqtEQn
         bjBAOm+H8mbbmfDWfquO7VVQ7ccft2c/c64SpZPyfm+h24ZXkO82M5wp/ds59ia/n6pb
         0ALQ==
X-Gm-Message-State: AOJu0YzSq5F/c9539AbRd7/7vTiC7JR0NtvojT1QYfKfrZa9wcXS1jgB
	O/5SBu253oQiLfoW9ne759vNxNdkZdlDfBLhtGyAYTzefnYq/BNLLsn0
X-Gm-Gg: ATEYQzxQJ7b3udU1Ltrv3oaTSuEBhJpoZ5yYCxhIwXLpm9X2vXJX77Fis1ULloHEURz
	a3QE2l+yrVF376gyZsFMnt8r4/PdpFj6NCqmWcPOWGg2bOE1yzXd5BWqyzOdVW7vT/kKrREShdM
	+sHUyV2XGJ75llPwmIIZD+5okrVm7fusfZ71dqBW1+H6h1afjAowTvhs+VjhMLfzMa22/xLKZYI
	G1N1g9VslhHUum3sONNZSJdBf52KUA2svsYPl5gs5tQnpVhZTIofSQ+863pPV51R57MCCPTZ8D1
	z/nRJxEUobC1IQu6Z89I3hq7/r21DHFM2FOj+pPMT2ih1BaI4MNtskdII3JUh0GazKeL42igLD4
	QPMwzvFmUdfgQkRQdpib9nzF4YRZD/o47SI2U4xSrko1+rPoZUM0tQExx8hK6rorJOehYkKJEI0
	TnZ9F/ruWwSwAwKAY8f09AtANKovjNpCkfsl348a6sGRyzYRF4hjASHA==
X-Received: by 2002:a17:90b:2250:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-3590f060ffcmr1820592a91.11.1772011694049;
        Wed, 25 Feb 2026 01:28:14 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm837901a91.1.2026.02.25.01.27.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 01:28:13 -0800 (PST)
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] selftests/bpf: Add test case for bpf_list_add_impl
Date: Wed, 25 Feb 2026 17:26:49 +0800
Message-ID: <20260225092651.94689-5-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225092651.94689-1-pilgrimtao@gmail.com>
References: <20260225092651.94689-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Extend refcounted_kptr test (test_list_add_del) to exercise bpf_list_add:
add a second node after the first, then bpf_list_del both nodes.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 13 +++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 51 +++++++++++++++----
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index c7c950e10501..dc3919deab89 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -109,6 +109,19 @@ extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksy
  */
 extern struct bpf_list_node *bpf_list_del(struct bpf_list_node *node) __ksym;
 
+/* Description
+ *	Insert 'node' after 'prev' in the BPF linked list. Both must be in the
+ *	same list; 'prev' must be in the list. The 'meta' and 'off' parameters
+ *	are rewritten by the verifier, no need for BPF programs to set them.
+ * Returns
+ *	0 on success, -EINVAL if prev is not in a list or node is already in a list.
+ */
+extern int bpf_list_add_impl(struct bpf_list_node *prev, struct bpf_list_node *node,
+			     void *meta, __u64 off) __ksym;
+
+/* Convenience macro to wrap over bpf_list_add_impl */
+#define bpf_list_add(prev, node) bpf_list_add_impl(prev, node, NULL, 0)
+
 /* Description
  *	Remove 'node' from rbtree with root 'root'
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 86f7f5f8e4c8..a3d5995d4302 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -367,18 +367,19 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
 INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
 INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
 
-/* Insert node_data into both rbtree and list, remove from tree, then remove
- * from list via bpf_list_del using the node obtained from the tree.
+/* Insert one node in tree and list, remove it from tree, add a second
+ * node after it in list with bpf_list_add, then remove both nodes from
+ * list via bpf_list_del.
  */
 SEC("tc")
-__description("test_bpf_list_del: remove an arbitrary node from the list")
+__description("test_list_add_del: test bpf_list_add/del")
 __success __retval(0)
-long test_bpf_list_del(void *ctx)
+long test_list_add_del(void *ctx)
 {
-	long err;
+	long err = 0;
 	struct bpf_rb_node *rb;
-	struct bpf_list_node *l;
-	struct node_data *n;
+	struct bpf_list_node *l, *l_1;
+	struct node_data *n, *n_1, *m_1;
 
 	err = __insert_in_tree_and_list(&head, &root, &lock);
 	if (err)
@@ -397,15 +398,43 @@ long test_bpf_list_del(void *ctx)
 		return -5;
 	n = container_of(rb, struct node_data, r);
 
+	n_1 = bpf_obj_new(typeof(*n_1));
+	if (!n_1) {
+		bpf_obj_drop(n);
+		return -1;
+	}
+	m_1 = bpf_refcount_acquire(n_1);
+	if (!m_1) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(n_1);
+		return -1;
+	}
+
 	bpf_spin_lock(&lock);
+	if (bpf_list_add(&n->l, &n_1->l)) {
+		bpf_spin_unlock(&lock);
+		bpf_obj_drop(n);
+		bpf_obj_drop(m_1);
+		return -8;
+	}
+
 	l = bpf_list_del(&n->l);
+	l_1 = bpf_list_del(&m_1->l);
 	bpf_spin_unlock(&lock);
 	bpf_obj_drop(n);
-	if (!l)
-		return -6;
+	bpf_obj_drop(m_1);
 
-	bpf_obj_drop(container_of(l, struct node_data, l));
-	return 0;
+	if (l)
+		bpf_obj_drop(container_of(l, struct node_data, l));
+	else
+		err = -6;
+
+	if (l_1)
+		bpf_obj_drop(container_of(l_1, struct node_data, l));
+	else
+		err = -6;
+
+	return err;
 }
 
 SEC("tc")
-- 
2.50.1 (Apple Git-155)

