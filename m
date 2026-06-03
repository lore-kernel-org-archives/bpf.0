Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5D3D47DB;
	Wed,  3 Jun 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484771; cv=none; b=oDcEN6rK51htbeU+O1cbucgXXwX5v0gPQ8Al6N/92EcnV+HIWRCdtnarXTw0g9+UZz397KvE9ppCaVPDBuBihTbQndXWmi4bfeWB5fJxXPrB5OyBSW+IgQK/gfHGJjcdRtNElC5iO2x3ujl/NZyJA7LJBFuBIILN8Pjm9ts241I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484771; c=relaxed/simple;
	bh=Gm1YjL3NIm6QAcJCSpnmCHkuoBZzERW1SBRjVN1VFv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+il3cNXHsj1N60e+xmI3dRNs5HrGtEYid47hw/QL/gr3OGf6trwyYxAyLJSoKuKvxu5ltqg+KtNCLHv0YbBkUHAzk+Nn3cfDeCAa9r/tSye3hGKVwBIZ1jB+4rlg7QyO4UfGvTp+Apvz09tSFga1rQ2q0RfDik+3ZtWp1LKgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dia1jb4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dia1jb4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134931F00893;
	Wed,  3 Jun 2026 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484769;
	bh=hS5ddt6/55FvRCu2A9HPdN1Y65LX5/d6MK+aeT7ITVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dia1jb4fCk7MfsuHd86HpbnL9yd0422WNHUHgoIsQl0bZeb3Qu9YFhbrhYabJrWHv
	 ERnK5XrYBJIsiKslrQN/eS9VR9aai/RIcmcKYTZcVXkpE1E95uCoY+URmBKC2IgDCl
	 FxWquAdUJsdxkhf0EdUg3o4mVW/uzFGwyFiFOtyErJXj77MkfApKNIqRcIluRg3A4+
	 DkIy0W1NsmxAyz+l6lz94hNx9aXQTW03HhVlCJCyt27fzs+NGsHhJc5QslTpXVM9a5
	 hBdm+nAkHWfzsSB+jqHlhADxMEK2pvuUL1Q4e5JoN5m1AfHBen13p58X4mYfccRVuX
	 ZkMVQKM1sqkaw==
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
Subject: [PATCHv7 bpf-next 01/29] ftrace: Add ftrace_hash_count function
Date: Wed,  3 Jun 2026 13:05:25 +0200
Message-ID: <20260603110554.29590-2-jolsa@kernel.org>
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

