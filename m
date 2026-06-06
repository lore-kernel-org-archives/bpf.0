Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E4207A;
	Sat,  6 Jun 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749612; cv=none; b=QhrE3GGc4UgL/tv/1Vorq1WzRaVcCZT9QshLQ38LUO3GYHBATh8TZiifUtOlST0io59QnSioIsYQGSL97D++KJ7TtYyJF9290v89iIVO7OiKR59maIoDFSe0bqNKJlxG7MjKokExnN6m8qIAQ/BIZHLkjrdw1Nqb0EzuFJTiuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749612; c=relaxed/simple;
	bh=Gm1YjL3NIm6QAcJCSpnmCHkuoBZzERW1SBRjVN1VFv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYbAChJPNCGSWFGKJYJ/QJMHdmnOdVNQ3e624ckK1zMVoCG54UTZLjb1PjHWoNdkIYgBVh2IQf5ShyEAedHTfWufiBWtZioViW7o2VnAm4CEeqRjH4Y/1owAuTatQ9S2adYuLbQsuiYrbptigIY4SGKpSgOdVBFXIn1D+IdQUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W84tX2er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W84tX2er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ED61F00893;
	Sat,  6 Jun 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749611;
	bh=hS5ddt6/55FvRCu2A9HPdN1Y65LX5/d6MK+aeT7ITVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W84tX2erFnJBx79UmXZdHE3QS4BaiIVYwmcNB7aERc/h3k43S1jXz+Rqx+/SrFXk9
	 nYkAbJ8LJmaXUmmAgQPc8I3koFjV8qfJwIte6eexdA80TAnFGb1dZRnukYWkn/qjoj
	 H+jpxUZl9WF0EgiUcemdr/daHIDygD0x//mHH6kflH7besM7AlfV43k+BYgnEvmg/V
	 xZUxRsuoEFa7diJBvUek4jDNuD2rvgGMCY7WK6cVguzj9EhUepIRTOQeyXeoh4JqlO
	 mBAPuf6Nu/0a17rYAdOGTFGIytpzC3w2xiSl5V5RzUWPrsETpTBs9v45Gloyh7wkDU
	 YycWk5MVErMUA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Date: Sat,  6 Jun 2026 14:39:26 +0200
Message-ID: <20260606123955.345967-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
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
 include/linux/ftrace.h | 7 +++++++
 kernel/trace/ftrace.c  | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 28b30c6f1031..02c24bf766ce 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -551,6 +551,8 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 
 void ftrace_stub_direct_tramp(void);
 
+unsigned long ftrace_hash_count(struct ftrace_hash *hash);
+
 #else
 struct ftrace_ops;
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
@@ -590,6 +592,11 @@ static inline int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace
 	return -ENODEV;
 }
 
+static inline unsigned long ftrace_hash_count(struct ftrace_hash *hash)
+{
+	return 0;
+}
+
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b2611de3f594..57ab01fd00bd 100644
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
2.54.0

