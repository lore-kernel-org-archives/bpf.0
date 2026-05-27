Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A63F9267;
	Wed, 27 May 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882027; cv=none; b=nxCVx1Nd041vKyi5scNUmfMUo7zC90ch0ERVyVIDdAQAOxMaaGaPIKzaIvos+WuEWIi4YEgwjQVh+AzRsoeBibpJgZWc/A1jY3jF/fD39JFTIL7BVJLnwg5Q0ueegZPevmfCSkHAkW0Fj7eXt2hry4RrEwNCQZdBwT4qA03prw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882027; c=relaxed/simple;
	bh=CBCMAhARh0E9QW7GyU/1z0/BjBRdapfKnJiQCAts60E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CArucWiEousYR9poJcLlEdTnpK+TjOFDjkRC9C8aFgZENNPRJBR8SW7Edgo8CSuaeQhBeFSFQ8yiwFfQP0Q39rz/577PfVaIQ1g6yZC+kHOQ/V0w89GHvbP0zkFa/fQ7QgrqdCMOopJVEXMCoYtMe88LON4cW1f2rikjl3NURZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i13wJeNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i13wJeNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF941F000E9;
	Wed, 27 May 2026 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882022;
	bh=i/xhcIUvvyeRMBN76zLp4VFmvDy6+BgwR4mkrfAxvdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i13wJeNV9I5sZK5YS4yItMxsZGVsMzL+gZUmgz160Y540PEBBFx0m+YxhR8ouPxEK
	 TqlUz5YioFT8uGXOwIJrTy0mNNOyDKf4F5fbABBBlaAT7HBXZy3n01ivlV3GhomS0l
	 XQekcnCuEOKsLPkFKfYGFBYbAVcVAES0ST394CZ8Q0riaPZ431aGCqJ4NeJjpC0qwi
	 fdfhiM0APihortgj0IKN39ND6eDyATvpjqkN6ZNcWNyC3NHhL7hbGay0qMVXApV0B3
	 O8ygHYkaxhbe1JgDu5Inxo3Ke3yJIAizp3FqQb7wDoOe2sdTDZk/eAq1H6iaok7YbZ
	 dYfxDC2suWFmQ==
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
Subject: [PATCHv6 bpf-next 02/29] ftrace: Add ftrace_hash_remove function
Date: Wed, 27 May 2026 13:39:24 +0200
Message-ID: <20260527113951.46265-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
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
index 282da661f131..d3acfac4f8a7 100644
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

