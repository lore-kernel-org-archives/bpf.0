Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797043368BC;
	Tue, 24 Mar 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340350; cv=none; b=nJMDEUBhWEjgkQLmJ2OWmwyhwZCZKV0V4tnGqeLIeMlpDsuYiHjwh7fxWOH2+okKkXw2AbI5qHlneCZThhYa0cSi9filQSlCJKqe2zD7iEO3MgHslojcj04p5YvVZb+FYo4Qds0VN9t3RDQIi9Iwse+xNMIwVdGDUOEvVBno8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340350; c=relaxed/simple;
	bh=Tr+qsomKsAUhZRC1jOhhI0YEmiqugw6bD4AFTYAChpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmQSBVDQv/pcDYXL65nzQv1ghN8/t/tlMvHT4QE66OU3WR+pl6MvHVDr4JpFrsxVvoqDVqqBpMuEXTzAz2qJU6cCEYFnhbGlEcyoBSuGNW95BVQ9upx7GooZCPYCB9103bj1bt66NnyIXV+1hAx6AJgidTCp0ZPCjGTImyFZy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfyou8Hs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfyou8Hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB9DC19424;
	Tue, 24 Mar 2026 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340349;
	bh=Tr+qsomKsAUhZRC1jOhhI0YEmiqugw6bD4AFTYAChpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rfyou8Hs2CNeyUnNbuxi+NJwzmCMzMxsG4syT7hqySHRfvnRJh/2e9Oui0VPCbBAe
	 kKY40ibX8VehLCMwltH42yoc18DYaEwe/rbcbOEDQ9s60myJhDEy3ztx/kqzj3Pi7T
	 6ITAX82UpnXLQfL8z/KOsbZAKgvDRvPa27knaqlpE8VSKioCE+TXxiLpw4kT0M9x74
	 nYpIp5DlTt2XAfJgSWMBKYTrTHuMM1j28N1AwqgmmpEfM0WVaG1lzrGDYDKk1TND3O
	 j/mUi00NgODTtKpRFPzKmA8XNoIXe12jtTbSmSRVhTEndLGEjvZvaogEdL5ZnX3Oin
	 VVnUWbMNtuuOg==
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
Subject: [PATCHv4 bpf-next 01/25] ftrace: Add ftrace_hash_count function
Date: Tue, 24 Mar 2026 09:18:22 +0100
Message-ID: <20260324081846.2334094-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
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

