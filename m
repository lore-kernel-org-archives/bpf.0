Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6734D915;
	Mon, 16 Mar 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647522; cv=none; b=o5kt4SKvv1qIi4Ec2jiAskmsnKvFWBTFPFlctUF1nOZUFcFjSLc6uFtDPMB9OaQw5NwAdipzPRVL8HBlTVUKNTJoJnGnsKzS/0fzjzk86LlUTNaXrEMKfL3IDOtyC0HSDb5vKSl9eyi/MHAwO2DTbhbjzd4v5xe+JwnFKsEhi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647522; c=relaxed/simple;
	bh=/PvUGG+Vw5NlAjSA6SNWd4t0xw9KAZftAY1gV2nxzvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZRIG6MQuh/2fD1hAFmt95mVnZQhdLcclQ19K1mQcMeYu9pDp9RUhCc75bpx9rTFb/SoN+L2MDCxiiF8QC2cwCtJ5FjX9k6hc4nr2cCnxCvZ7T+8PC0ak6opnPM6u3E7e+4TzS1oW+V7jCJIenZhp5DlWaZngWHT3WOe4gNdrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHMohGfI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHMohGfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDFC19421;
	Mon, 16 Mar 2026 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773647522;
	bh=/PvUGG+Vw5NlAjSA6SNWd4t0xw9KAZftAY1gV2nxzvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHMohGfIT7lMWEh3giiK8JqeGVVCWi790FPOJJPpUYqzd9h38QStjZNKWMO7oQbZJ
	 +QSAfKgGc6EbiRM/BuzOXF/159KfiNyiE+qGzXtHh20dITkFXYpVym9EySzGs7IwlY
	 TEKmFDvWl88ZnOjCb3pVBmq7+PfbPqs8qAkIpontBWCqPXM/0minHq9P6tr/6nxJG7
	 ehAG4QrEf9V+3lQ8TL0U34uWsXHeLfeXtgM55ujDcNhldS4oS7oiLHIvSfKtk08BM8
	 QH3QO25mSL4GhFiRPAvpYQU52vJxB6rftlle0qAYrpwdsNaUv1iIvNyiddQSdKTCr/
	 8aOIZ+zZ78MwA==
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
Subject: [PATCHv3 bpf-next 01/24] ftrace: Add ftrace_hash_count function
Date: Mon, 16 Mar 2026 08:51:15 +0100
Message-ID: <20260316075138.465430-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316075138.465430-1-jolsa@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
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
index 71dcbfeac86c..2240c38e7216 100644
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

