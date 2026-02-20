Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55923373D;
	Fri, 20 Feb 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582036; cv=none; b=tMOddw6o5CxjhIMSZCraUdIzwvvoynVIVOBjdNvq+LUnD/uHfYDqxtO1lhRNuT1kExKQX8gaWtir0k9XVBsdPFh9KY6uCPd93ISVvO0mDb8IFqjiss7YW3i7BuT47EabesSIjuVqODSu0SDH73VKynQvjAlVryZGYyGk20Ec8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582036; c=relaxed/simple;
	bh=KxDz3h523nv40MBpfPVEzEu0k65BxaB/Q6Im9CTJMxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8nS56E99IsOLOt7WMd8lI7DMg8QJwaHA/S079y3nzfWlTqJpN3kDeXTipn6iKBOqdc4qTSyjEOoc/+YXlGaH3HGZRFYxbsLErwKBeIapWvcwVdLSjhJK3Vb5NDdn3ZYC/cnVzIhtBFDpkm7Gh/uDy/f5EJ00v4txldBH2aZY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvi8niWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvi8niWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E2DC116C6;
	Fri, 20 Feb 2026 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582035;
	bh=KxDz3h523nv40MBpfPVEzEu0k65BxaB/Q6Im9CTJMxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tvi8niWHHo5Bz5/ZYIB6d56RhOq4jYssZoO5vOV0QpSe/6HtxIBtohzg3BpPOrfpl
	 +x3peMWiB/kUgDkXA8DAOKHMgLxmuxMOUhLZAHJ9DwpoaRQKvj9XywvFSoQSt90wr6
	 DSeCXEGkUuzvCFBVmwsDJjLQLrWxzO3iFDb+UJ4nWHkJaV/UpwHYtdo6RTlN0nBJ+/
	 ftaI3u8T8wxq7OEVvYYIod23/hgBHpO6BrEryJJODrAEXCM0yp4u4MQj+bjAJ3s2Jq
	 EYMKS+HVlnktW16Fy6SEpD+PuuBL4Z3fu1BehEfeql3wOoUL+0GjiMuchssSQBEX9U
	 uteFo61HQJIIg==
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
Subject: [PATCH bpf-next 01/17] ftrace: Add ftrace_hash_count function
Date: Fri, 20 Feb 2026 11:06:33 +0100
Message-ID: <20260220100649.628307-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
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
index 1a4d36fc9085..a1ea6ab29407 100644
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
index 1ce17c8af409..dd1844f882cd 100644
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
2.52.0

