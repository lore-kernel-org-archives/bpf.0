Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AE3CB2FC;
	Wed,  3 Jun 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484780; cv=none; b=vE7nGXePM0Hp4PHv8sUatPlcHsxggeUlUIl0GtIC8BUICZfdXW75sF+gR+T92T+CYzSns9WWGslm7obhW/c0U/Ug8mSov0BZACFGPgF6Y/jaxhPQmcQ9iiLv9esNmdcXnc+3qL+bxLtnhtZGX6/Zl7aCDGTISSRs19mRQc2FXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484780; c=relaxed/simple;
	bh=/P2aVMbllhpSCTKcJh4LAYY1a4fWv1WtEKnVEagpoRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMYw3l6b8D3USPOoMh3DViWHJ9AsNWa9OjqN3Utm5f8m6KmqsDndOizyaigi2scwl4NIXZzP8uyt+eKNkf+DoDJfiVANPRpC40pn+Zaw9q4D5CSZur857nARloQ0whydm2z6IDCm1bo1tQGU31saRnWatcNXrEY1i5c3C1isIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip5+kpgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip5+kpgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82FC1F00893;
	Wed,  3 Jun 2026 11:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484779;
	bh=DUViLivnhr22tZzVIR0cUlh7NZY4GvFWtdOine1stqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ip5+kpgjToyeFomIIyWi/zsRH4Nt1Tufqksz06zM5oz7JarLrOEGwhK4dNA/bjJAs
	 N1VrfEbAGwJApkJ//RS6XzbxQuxAaipJScocWN/WWIhX7x6j+4XK7f4eRTCKdxgnZn
	 nyjH6w2LnURRWiIsTYPWLXzVwi+gmAG2Ai6WckoeU5Uvd2FXFW+pYjdA5gHqq+U2eN
	 EtyRRbSa8ITTaqrs8Fb7yR+Jw9PKyMxmGWG+wpSSgPy4wrHwa4Etin2unfdejYzNU6
	 LzYSvlTWkzm8mhi/PCwjzZEO/vxtnBlce5rIydvS0/k8qmYL/RgTnXR48w0/ChDDJg
	 NtJEoU0kUQEQA==
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
Subject: [PATCHv7 bpf-next 02/29] ftrace: Add ftrace_hash_remove function
Date: Wed,  3 Jun 2026 13:05:26 +0200
Message-ID: <20260603110554.29590-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding ftrace_hash_remove function that removes all entries
from struct ftrace_hash object without freeing them.

It will be used in following changes where entries are allocated
as part of another structure and are free-ed separately.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02c24bf766ce..b55ec9b25bb3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+void ftrace_hash_remove(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57ab01fd00bd..45548b0200eb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1249,6 +1249,25 @@ remove_hash_entry(struct ftrace_hash *hash,
 	hash->count--;
 }
 
+void ftrace_hash_remove(struct ftrace_hash *hash)
+{
+	struct ftrace_func_entry *entry;
+	struct hlist_head *hhd;
+	struct hlist_node *tn;
+	int size;
+	int i;
+
+	if (!hash || !hash->count)
+		return;
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hhd = &hash->buckets[i];
+		hlist_for_each_entry_safe(entry, tn, hhd, hlist)
+			remove_hash_entry(hash, entry);
+	}
+	FTRACE_WARN_ON(hash->count);
+}
+
 static void ftrace_hash_clear(struct ftrace_hash *hash)
 {
 	struct hlist_head *hhd;
-- 
2.54.0

