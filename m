Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95C35C18C
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546019; cv=none; b=fBMrwXQXRYeDJBqcypwLBIOYCiuZF03MCqE86Sm4T9zCKm1ue8tUuT2B8wkOnbtWt7sj3TCrx5PUgxmRTudbF1tahssv9Rbt74pZnl+YlGJ9/1lHrQwoKMgavHS9xPgCqwOQNc00rg0TxUfhCvGMutkIl9sP4DsTu6T1x9SWzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546019; c=relaxed/simple;
	bh=3C6ttGuLl8L64Q1LnoiZLd+0O95EfQxJe16UcmlcmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjuaJNC58XXqM+AO520VxxUUEl6hSfXxp18eyPNl26pKCMFSKwIJB+zedYqWV+jE+jfpadPjCd+OlfCDc4EjA5sz7HJ90IP4Qk+RcSg0ahuoPpfvCIuHN896+WKX3In6rgMz/nuQSDzAhx6MrEhSaHanXegXD1q9JM7/oY1m6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpfqORez; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpfqORez"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8249fc726e9so3133381b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546017; x=1773150817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c4HiRtc5xaPbrfb39uLULAmMTx7Jx7ULuDedQkQ4YU=;
        b=SpfqORezinC1+itMhON7mLIoZjh6QB2tqVtwZ7cLcxllrvfXIxfDJwPjUX7Qvvggn1
         S707OjdF541jjdVS52mUl005NJaOxX9zp1gWv2vOKF4aeKhTUF5i/Y01JKmXUfmtqsMK
         il8d0hs2RkrzL0MGDlVtKHsW3YYxBUIMO/LCirlbOKGiR2Ilayyui1iYhhxL7v0++dax
         UqYwvuECz+ZSDB9FGi7J1iwKo+z04/1rQ+g+LFxEfnEe3M9zi7Wt3mYHWpsh5nu5PF4y
         axaFxooO76NwbE4xFy7L1WldbKmkarxyINTXzqAyBEuFh5uJigrukza3jai+I1XwIJft
         tT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546017; x=1773150817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c4HiRtc5xaPbrfb39uLULAmMTx7Jx7ULuDedQkQ4YU=;
        b=V/7IFQRcX3WlGGfyls+IllF7Ox3M4GQhZG3z4IWjcY06neqhnrPK1WETPj4k50WXF2
         Cgm8tNbwt/lzjvZbe36/tsoMHfiy4j5P8Gzeqd6cMgDTrUAtiVE1OBHPit97a7LD2wKi
         BhIRpFNelx6Vtr3aLFSLrkaeuukJBHFclgYquuL/1rdhOh4dtH8xSRNRyUIp3qePqO3k
         +2JatnoC3oQmqXEN2EyuLJ0CXu7lgXGW6LZfUTzmd5rXglVmzNT406WM5PVoou5kKdoq
         xRnhEfDZKZQC19G7NRPB+QLmtnU1Em0qG28vgGhzv1C6o42kBEmyxeA2JcMiv7/0FQRe
         ybgA==
X-Gm-Message-State: AOJu0YwpLaTUFohrwyIjZVv8g3vnILm2avCGBnNhTO9gZZAuRucovbnW
	mLpjmcPRicoG+/bug1QSeyETO8MdqmNCTJZotMP/T7LsnX9Dbl0931SQ
X-Gm-Gg: ATEYQzzAw2SaxEQajmYILGpjk2sPmMVw/GsqkHOt2mkbus3OJ6WLBmAugPwZQO8LnPg
	73npyTcEgmzQaaCzMAnAtPL5+fMU2JIwIUUH+kLMaomTtRyGnUC6Qj5KT/auXbrRbsj7HGBuLvY
	rK5+Jx0/8ftU7hgcpCDBd41uhe6+/Km/f38CwiugMCIgoy/bSH5d1ogzNOyZ3cRRC9sy+xT+ZoT
	6DySjrwS0GMBWAjW3QuVl+AAwDAvBiKGNRbUIUZT0G2pcPEMOzOlc5MRnpqaoOAcKCsXLeIpv30
	OTwlTSHW5/LJ5wx3RKp9H1fvRmz5OT8A6kh3abhTjvvlQRNGUWgje2ZWN7wBTTQgFEl+hZikzW+
	aUEA6smpZA28fAo5ywFPLHMba/4u/UK2FEGl+2PUWQM703j7AG56z7AD0fOz8zHe0KGd6Xh5+c1
	unv65PVvxw8KbW5FyUYeZEcroFdTlNcIhff3CUFr7ycqF7cwy3
X-Received: by 2002:a05:6a21:1f8a:b0:394:593a:eea4 with SMTP id adf61e73a8af0-395c3b0f750mr14569718637.57.1772546017520;
        Tue, 03 Mar 2026 05:53:37 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.53.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:53:37 -0800 (PST)
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
Subject: [PATCH v4 6/6] selftests/bpf: Add test cases for bpf_list_is_first/is_last/empty
Date: Tue,  3 Mar 2026 21:52:19 +0800
Message-ID: <20260303135219.33726-7-pilgrimtao@gmail.com>
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

