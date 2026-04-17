Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BE3B27EF;
	Fri, 17 Apr 2026 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453937; cv=none; b=dyq7YUgnRIZiqRa7iWDafbiMBSi2I5/VvYo48z5qhMS4W7SpZ3jBACByz9C51BZT/4GL+cB6qPV2SOob3nc32SqpDno3IgJR/ttXMy44B0EhBw2qvM7FZYSLi96SyOwQQRhWNrK9Lp/G5ZypkAr9859eSkSRi07bU8POWiCCbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453937; c=relaxed/simple;
	bh=BBX5R7/sEkKqidYSMwmeS2dV0RFyXFs7wu0SlEDJNts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioMKcbPlBav9DKJcqtW8JJgPz9+cV6czWX50KcibeMQkjNxLw6wuYlHxrwaSWaknBoIXLo2bM5fh+Ep3HY9b5z9CJM8Bf3B6wPUlUoMiW/skkEqHw/bZQ29yTf8y8YUEUB1NXZLH6Y0I0x+zQcmjz84zC74CP9WwVS85xOrj9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLh65sEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLh65sEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC0DC19425;
	Fri, 17 Apr 2026 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453937;
	bh=BBX5R7/sEkKqidYSMwmeS2dV0RFyXFs7wu0SlEDJNts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLh65sEe7o515Si02f1VwMwbT6UOUx73PSuclK7WwrgxDjNopYGFpZHxspfDlEMCL
	 N3c4fc//4/CIJvdAFG8IVBr9oFEocMYq3B5z1k1fQB+DAtAejpxO0sFa5HFbv/cd8E
	 RCIwbCMoGjs2K8JxqRxNLre+EYhvSqpIoNQOga5BDwZrEs1m8MRHVaEhJEpmyRY9XU
	 8fX7tvkkc8d6ZEfoO6FufwbCVbQsgBfEVYGnafSXM1K6wz2u/I8HmRpGOkWuMRF+lr
	 WCz0nfHWhCNZMozMP61s1GNnig7w53SGzibOrwa+0BLRUF/BJLv7Xkz58mB33kNiLG
	 JO0Z2v6LHFrlA==
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
Subject: [PATCHv5 bpf-next 02/28] ftrace: Add ftrace_hash_remove function
Date: Fri, 17 Apr 2026 21:24:36 +0200
Message-ID: <20260417192502.194548-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
index 401f8dfd05d3..dc93dd332b07 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -416,6 +416,7 @@ void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
 unsigned long ftrace_hash_count(struct ftrace_hash *hash);
+void ftrace_hash_remove(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 68a071e80f32..5119d01ef322 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1249,6 +1249,25 @@ remove_hash_entry(struct ftrace_hash *hash,
 	hash->count--;
 }
 
+void ftrace_hash_remove(struct ftrace_hash *hash)
+{
+	struct hlist_head *hhd;
+	struct hlist_node *tn;
+	struct ftrace_func_entry *entry;
+	int size = 1 << hash->size_bits;
+	int i;
+
+	if (!hash || !hash->count)
+		return;
+
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
2.53.0

