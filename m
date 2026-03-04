Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F4386545
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610455; cv=none; b=IeU+5rNrmV3OXW6ymclPQXx3V+OvWwdxE9XU6b65/mY2WCrhg0JtzmtTNGLQ49znS3lUDDeovCAEeAesQv3Hci7onzkp+UfT7u+43mpBZqSl0fjJLz7XKSj7CovH2P5l/IGmhszLz0uBWoxELdOfP9S5c/fy9ybvdn/IvOyStDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610455; c=relaxed/simple;
	bh=xij/w7IGsHGa0OZ+mD8D9GCI3hfE/hii5pckeZ7EKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O20o9BdANTIrCWt/4fC0FOEgiGehZrzU9oqzqU+jZTvoItk30nfVTgbm6BqJA7E8BZjvZgbdDiFa95VxWOpE+zkKqB7wNFohuI6PnazPG0OMgk0PKP9ycbT9+oVpk7lJNLkRdAYfMW68MgvbVh2KGm40BOX3594Pq8zEznIF0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH9TtQTB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH9TtQTB"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2890794a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 23:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610450; x=1773215250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAdqO2lKtYGLna+N0CaieqoPJ8dofo0McAImpjYXR8=;
        b=QH9TtQTBc7urRW59mULbeHi3KLE5EFNv1YX9TriWcYeHNJfGddaLGBT4UDTGL1VNdI
         /aRPPZP54PgzdaFoEs9dXbexfOgctqotpnZzOD0Sa5iKs9wJ49oNnb6aFiaVTf2L+rBe
         labLFM3yK+9ulTrwDE3fHvSxFHojth2ibpl9up5jQBXtSEGW5CbRFJaOad1Nan1pdygx
         clXrzaOYkc7Ugb1tqCcSo4u9TQbdSl/c/uVeCuPExw2srqFUknLfTwFCRgNqpA0XTJ1+
         57ywf6/wly7qSXauH95f6kf+u/nor4AYXAIvcDc67AvLKyyu7M3TwZVNSoCZx8aETRwm
         2e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610450; x=1773215250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4RAdqO2lKtYGLna+N0CaieqoPJ8dofo0McAImpjYXR8=;
        b=wTl5NOzmkNjCYDxk2vktV1kT9TganbjvT1izV1G1OGB6gr+IA/maXOsKJp4l2Y7Qgo
         CZtk42yt2xvg5XHoGOWFQKI+nq6jRUgRF9Hnc3KY0wvLk71i6iVDJIZVNKncHMR8KurC
         6M7qHJphadWCqwNguNMfD8MchCrhHpnaIFW1sNZJ0jOorAKaMyY2FXqwFJFRnRfAemfj
         cWUfyU1QLhTZ125CvbTMUUrAOnnSyptNmn5kRSkJxOL9w2siowDcIa3XFqDlQoIoLgDz
         ofWRMd7a+4kVx4aN048uztVl24xHMGE5scX2j2ooYULw64nj4yPs/oEHjDrnasMP1McR
         V3eA==
X-Forwarded-Encrypted: i=1; AJvYcCWpQoiZNUTM3XhlOHmoPNsuqIwYTam4QDMYFuzGF9NWLb4U5hhfkH4ZIGeFKiu1iQ3Kfs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cIXpiOV49/vGd8S0x4k0oytg63dkO9ZnJd20i4pdaru3U68q
	4RdwHuvpKiPoicPcfkpizipYRQAYklykf2dykIKbwEplJunF1HBK2vez
X-Gm-Gg: ATEYQzzLmA/n2b+dYh1AALzAuB56eJELhCN/tNlbElYKvKR0Ix6F9f/wcq7i6RU4St5
	PgdLfagR+CX3rOV6ltVtOLpC4ltLsQiyuXzcHzhV220+WHZfcnJjC2GQa2NjnivqLBnQt/i2FXM
	8lGiizX8EdJR4Ek4G0jq62WO3jIRkAcevC4Kvw00l7UFe1kGJgHJEN0ckkgD9bfiTl+G+vsVJd3
	mWjMSUKF5MpmUVwgeevIQdBRMQrT9MfvlXxMQdlNzZA1pD6OicxuiFF3DJK7hCDJKAVfUjfYQJm
	d6jjtCLNHc6Dbl/lRq2j/bCq/hdpRupjYWhRqlP/5n0I2eidh+ktb91gNUCMf16z39eQmPK5DSp
	9DGT4fcyYW2aABkCtUkiCSiRJOUiUijh5UnOLtmAcu/EwiOapGes4X5Cy1gPnh8HTksANznyCkg
	Ri4mEYzgjgfCn2N3uFt+Fsu1yrgj6OmtlnQHFpWf2g2g4jowB1X2F5gHPrAzq1Qw==
X-Received: by 2002:a17:90b:3c90:b0:359:8c89:96cd with SMTP id 98e67ed59e1d1-359a69dae40mr1105809a91.12.1772610449953;
        Tue, 03 Mar 2026 23:47:29 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1ba6:a29e:d73:6202:f71f:51b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm4352078a91.12.2026.03.03.23.47.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 23:47:29 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 2/2] ftrace: disable optimistic spinning for ftrace_lock
Date: Wed,  4 Mar 2026 15:46:50 +0800
Message-ID: <20260304074650.58165-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304074650.58165-1-laoar.shao@gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mutex_lock_nospin() is used for ftrace_lock to selectively disable
optimistic spinning.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/ftrace.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..b8cca4f76118 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1284,7 +1284,7 @@ static void clear_ftrace_mod_list(struct list_head *head)
 	if (!head)
 		return;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	list_for_each_entry_safe(p, n, head, list)
 		free_ftrace_mod(p);
 	mutex_unlock(&ftrace_lock);
@@ -4254,7 +4254,7 @@ static void *t_start(struct seq_file *m, loff_t *pos)
 	void *p = NULL;
 	loff_t l;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	if (unlikely(ftrace_disabled))
 		return NULL;
@@ -4362,7 +4362,7 @@ static __init void ftrace_check_work_func(struct work_struct *work)
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	do_for_each_ftrace_rec(pg, rec) {
 		test_for_valid_rec(rec);
 	} while_for_each_ftrace_rec();
@@ -5123,7 +5123,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	if (!new_hash)
 		goto out; /* warn? */
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	list_for_each_entry_safe(ftrace_mod, n, head, list) {
 
@@ -5159,7 +5159,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	if (enable && list_empty(head))
 		new_hash->flags &= ~FTRACE_HASH_FL_MOD;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
@@ -5465,7 +5465,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 		return -EINVAL;
 
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
 	list_for_each_entry(iter, &tr->func_probes, list) {
 		if (iter->probe_ops == probe_ops) {
@@ -5540,7 +5540,7 @@ register_ftrace_function_probe(char *glob, struct trace_array *tr,
 		}
 	}
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	if (!count) {
 		/* Nothing was added? */
@@ -5619,7 +5619,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 			return -EINVAL;
 	}
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	/* Check if the probe_ops is already registered */
 	list_for_each_entry(iter, &tr->func_probes, list) {
 		if (iter->probe_ops == probe_ops) {
@@ -5679,7 +5679,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 		goto out_unlock;
 	}
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	WARN_ON(probe->ref < count);
 
@@ -5943,7 +5943,7 @@ ftrace_set_hash(struct ftrace_ops *ops, unsigned char *buf, int len,
 			goto out_regex_unlock;
 	}
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, hash, enable);
 	mutex_unlock(&ftrace_lock);
 
@@ -6205,7 +6205,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6625,7 +6625,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
@@ -6980,7 +6980,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		} else
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
-		mutex_lock(&ftrace_lock);
+		mutex_lock_nospin(&ftrace_lock);
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
@@ -7464,7 +7464,7 @@ void ftrace_create_filter_files(struct ftrace_ops *ops,
  */
 void ftrace_destroy_filter_files(struct ftrace_ops *ops)
 {
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
@@ -7571,7 +7571,7 @@ static int ftrace_process_locs(struct module *mod,
 	if (!start_pg)
 		return -ENOMEM;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	/*
 	 * Core and each module needs their own pages, as
@@ -7868,7 +7868,7 @@ void ftrace_release_mod(struct module *mod)
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	/*
 	 * To avoid the UAF problem after the module is unloaded, the
@@ -7938,7 +7938,7 @@ void ftrace_module_enable(struct module *mod)
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	if (ftrace_disabled)
 		goto out_unlock;
@@ -8267,7 +8267,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	/*
 	 * If we are freeing module init memory, then check if
@@ -8686,7 +8686,7 @@ static void clear_ftrace_pids(struct trace_array *tr, int type)
 
 void ftrace_clear_pids(struct trace_array *tr)
 {
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	clear_ftrace_pids(tr, TRACE_PIDS | TRACE_NO_PIDS);
 
@@ -8695,7 +8695,7 @@ void ftrace_clear_pids(struct trace_array *tr)
 
 static void ftrace_pid_reset(struct trace_array *tr, int type)
 {
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	clear_ftrace_pids(tr, type);
 
 	ftrace_update_pid_func();
@@ -8713,7 +8713,7 @@ static void *fpid_start(struct seq_file *m, loff_t *pos)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	rcu_read_lock_sched();
 
 	pid_list = rcu_dereference_sched(tr->function_pids);
@@ -8766,7 +8766,7 @@ static void *fnpid_start(struct seq_file *m, loff_t *pos)
 	struct trace_pid_list *pid_list;
 	struct trace_array *tr = m->private;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	rcu_read_lock_sched();
 
 	pid_list = rcu_dereference_sched(tr->function_no_pids);
@@ -9057,7 +9057,7 @@ static int prepare_direct_functions_for_ipmodify(struct ftrace_ops *ops)
 			unsigned long ip = entry->ip;
 			bool found_op = false;
 
-			mutex_lock(&ftrace_lock);
+			mutex_lock_nospin(&ftrace_lock);
 			do_for_each_ftrace_op(op, ftrace_ops_list) {
 				if (!(op->flags & FTRACE_OPS_FL_DIRECT))
 					continue;
@@ -9106,7 +9106,7 @@ static void cleanup_direct_functions_after_ipmodify(struct ftrace_ops *ops)
 			unsigned long ip = entry->ip;
 			bool found_op = false;
 
-			mutex_lock(&ftrace_lock);
+			mutex_lock_nospin(&ftrace_lock);
 			do_for_each_ftrace_op(op, ftrace_ops_list) {
 				if (!(op->flags & FTRACE_OPS_FL_DIRECT))
 					continue;
@@ -9153,7 +9153,7 @@ static int register_ftrace_function_nolock(struct ftrace_ops *ops)
 
 	ftrace_ops_init(ops);
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 
 	ret = ftrace_startup(ops, 0);
 
@@ -9200,7 +9200,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 {
 	int ret;
 
-	mutex_lock(&ftrace_lock);
+	mutex_lock_nospin(&ftrace_lock);
 	ret = ftrace_shutdown(ops, 0);
 	mutex_unlock(&ftrace_lock);
 
-- 
2.47.3

