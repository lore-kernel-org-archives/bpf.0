Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735213148B4;
	Tue,  3 Feb 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111521; cv=none; b=oeaMF4ZWw844jqI6pV6MuKpT+dzUNrhZTxUR6Mjy1J9PMKtodG+sULDL5+dKKYGaMDzZokmDelqoXLSJsL6UpThLxJ6BzpdlCNT8Woh5rV/XHybcvxCQGD9QyFw9LP735h2UkeqriLtbm0xSjLx3ksZBiPvvPPkxQWYwkx6MrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111521; c=relaxed/simple;
	bh=Jf9n6glm1Rnx06H2cE5z0LTr6QQfYz4idS+eXNgTfws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZq5Dx3OfOCZ3vGIvKwCqQ4XFqv2WbATp9Kj/iWZkhuflz5movEdtYTccH++MwlbLlceCOeS7LENF5+elseP0qNiiOuOcwK4PRR1V1ld0pBCZsKcBnc8XpXhSXifCQlGDEqrjdYShJgA9gejcDqsPOybqBQgR6tErqt2aoNgSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+kWjx93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+kWjx93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84069C116D0;
	Tue,  3 Feb 2026 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111521;
	bh=Jf9n6glm1Rnx06H2cE5z0LTr6QQfYz4idS+eXNgTfws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+kWjx93MqAaiJA/tLPokRJtlLghJ6UH9PvuisAJlMgGvhEWqTeLfnSGbz1wIIh7d
	 s9AsrjlvSIMKzVZv4zW/Kp/mKPRk3xlKTx0C63DHo2RpF9DcrypJPSgR1X8KUJG8Ja
	 uA8ocUcUT50xGsa8YePlD2PL6twEUdjBm2MNHGrZyQdhLEn9sSlmcUUycOe17mbs47
	 FmExxZoIjFXodK8do1DkZ1QJ5uqO22GOtHmx/67NPy9cDAQG+lrYD++cpX0gS9a1Yh
	 RwtqQgr2SinHv+BYGCDBlojdhmOMaMCwYoEyfIYa2q6Orqr4peCxF858RlDHHBs12B
	 lUJZ6oWNCQhPQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 01/12] ftrace: Add ftrace_hash_count function
Date: Tue,  3 Feb 2026 10:38:08 +0100
Message-ID: <20260203093819.2105105-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding external ftrace_hash_count function that replaces hash_count
function, so we can get hash count outside of ftrace object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 705db0a6d995..6dade0eaee46 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -413,6 +413,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+unsigned long ftrace_hash_count(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b12dbd93ae1c..be9e0ac1fd95 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6284,7 +6284,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
-static unsigned long hash_count(struct ftrace_hash *hash)
+unsigned long ftrace_hash_count(struct ftrace_hash *hash)
 {
 	return hash ? hash->count : 0;
 }
@@ -6302,7 +6302,7 @@ static struct ftrace_hash *hash_add(struct ftrace_hash *a, struct ftrace_hash *b
 	struct ftrace_hash *add;
 	int size;
 
-	size = hash_count(a) + hash_count(b);
+	size = ftrace_hash_count(a) + ftrace_hash_count(b);
 	if (size > 32)
 		size = 32;
 
@@ -6345,7 +6345,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	int size;
 	bool reg;
 
-	if (!hash_count(hash))
+	if (!ftrace_hash_count(hash))
 		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
@@ -6362,7 +6362,7 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 
 	/* If there's nothing in filter_hash we need to register the ops. */
-	reg = hash_count(old_filter_hash) == 0;
+	reg = ftrace_hash_count(old_filter_hash) == 0;
 	if (reg) {
 		if (ops->func || ops->trampoline)
 			goto out_unlock;
@@ -6480,7 +6480,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	unsigned long size;
 	int err = -EINVAL;
 
-	if (!hash_count(hash))
+	if (!ftrace_hash_count(hash))
 		return -EINVAL;
 	if (check_direct_multi(ops))
 		return -EINVAL;
@@ -6493,7 +6493,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 
 	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 
-	if (!hash_count(old_filter_hash))
+	if (!ftrace_hash_count(old_filter_hash))
 		goto out_unlock;
 
 	/* Make sure requested entries are already registered. */
@@ -6580,7 +6580,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	unsigned long size, i;
 	int err = -EINVAL;
 
-	if (!hash_count(hash))
+	if (!ftrace_hash_count(hash))
 		return -EINVAL;
 	if (check_direct_multi(ops))
 		return -EINVAL;
-- 
2.52.0

