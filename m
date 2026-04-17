Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9E3B19BA;
	Fri, 17 Apr 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453925; cv=none; b=NotiEdX6kpxBOq3AcbTAZUcjiL3JMS9vFNC6Wn4tLfzLBzbmMmsn+sQZDVv1DnTlPOC544ohJjQcjsTwPlHqT8KLcFNHzs33691jhsaQ+re0129PZncD+At1vRcnAniDltPYpMaWZNfFAGJjZP1+J7T+TaqCGW3U8C/n9iSjoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453925; c=relaxed/simple;
	bh=Tr+qsomKsAUhZRC1jOhhI0YEmiqugw6bD4AFTYAChpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6s7PhzCnBb1pqDBDaWBqLi4DaDyhhxyL+UGsP+dG93kxkoKZ+sABr+4Y/hP1g6P61/k/pdG/rpWiDveDLg1kiW4ba9TSdISFuNGB+eEJTGl9QtVpIu7U1LeUS6CAHnvZERsf438MhG6h5GMPWAdDix75Yov0v4dWU+11cHatXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyUmkTtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyUmkTtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D951C19425;
	Fri, 17 Apr 2026 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453924;
	bh=Tr+qsomKsAUhZRC1jOhhI0YEmiqugw6bD4AFTYAChpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyUmkTtELMCyxQ0qT94FfpGj6kS8W7u8OWVDue1h9JmMM5CCes497DybIEr4QljxW
	 2tfRT4bRIQ0jLBwV1EVBLe1/rG+r1IqEY4MvGQ/b0/ENVEILsBy0PQhAT495uVa24L
	 wFt7Pa18fg/Nwy9AuV/L7Pqa1WykXOTD3jPChghcZLmT/+A4fvS3tJ+MCCitMazFRW
	 hfebPo+n414aCAdAn262/hI6XC2SXcnoT6WpwnVGhUzWBh9DBtJzGRPF9rb/LspzG7
	 ETrQKKIsIUkKruZX+92ZKwSBkvhyDwLeJ5Y48DBYLRO6E0j0Yhws9QxlMLPjej8xNW
	 23OzKrVGldRCg==
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
Subject: [PATCHv5 bpf-next 01/28] ftrace: Add ftrace_hash_count function
Date: Fri, 17 Apr 2026 21:24:35 +0200
Message-ID: <20260417192502.194548-2-jolsa@kernel.org>
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

Adding external ftrace_hash_count function so we could get hash
count outside of ftrace object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h | 1 +
 kernel/trace/ftrace.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c242fe49af4c..401f8dfd05d3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -415,6 +415,7 @@ struct ftrace_hash *alloc_ftrace_hash(int size_bits);
 void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
+unsigned long ftrace_hash_count(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
 struct ftrace_ops_hash {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 413310912609..68a071e80f32 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6288,11 +6288,16 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 
-static unsigned long hash_count(struct ftrace_hash *hash)
+static inline unsigned long hash_count(struct ftrace_hash *hash)
 {
 	return hash ? hash->count : 0;
 }
 
+unsigned long ftrace_hash_count(struct ftrace_hash *hash)
+{
+	return hash_count(hash);
+}
+
 /**
  * hash_add - adds two struct ftrace_hash and returns the result
  * @a: struct ftrace_hash object
-- 
2.53.0

