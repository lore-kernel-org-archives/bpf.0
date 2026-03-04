Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1D37B3E9;
	Wed,  4 Mar 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662923; cv=none; b=t5noboi+FlQXdUDB+/ondkuXOCd0zqrkMDjN0n7CYqovlag51A+UDq5ELzZxcC7v+0FSq6fJ7tWUL0iGYEoZpejaP4flW4KQ0BYyWx6eGaHKrx5fv9YM31Wf9u0cOtf5m3II5TGcpKJEf5jSuUZTHQu1eDpXfsqwZ0GTh7z37XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662923; c=relaxed/simple;
	bh=aCx9nYwYoFkehWh2kV0p2iR8Ox0MhBy4YtXW6CgslVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KU6beCGI1eNooyDopE9u2qlLvbkbS4hMEX7PccqmwUmkRBdQxjHxvwmBgOGn30a+2vE8HVatMBlXXxExh0jM6WE2T2u/cGO9Fkyyi7p+hNASLNIm0we1qaviPJ9pLmExmQV0bZxPgLWaJAbsDQ69OBCm6DDCXS26fAIXaZyqKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyJa2hlk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyJa2hlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB775C4CEF7;
	Wed,  4 Mar 2026 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772662922;
	bh=aCx9nYwYoFkehWh2kV0p2iR8Ox0MhBy4YtXW6CgslVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyJa2hlk+KnFSuNHEFW92lXtWq6ZIigeB8F6EYyTzrkkvHtTSQISUfKZlXV4XbgJe
	 3Fx0k9L+rGwGvU0PgM+SOjvgAtzdI/wsgNdG2rON/4TVbbPpybfq6m87+SLLAx9KrX
	 K7pFR/8P3b0i9Zgkw/DioJOxQQ5CIOHIH+3xz5uh4NMXSY6054GPQ1yJWDMhAg0317
	 NAA9e+uh71XqHHhqRbNcSUcSCjF59wsyfuL3humFS+XUgXJAV2W29kdLKqPfaRwgN2
	 OuNk3h338VFoGyLQYWqa70XoWk50IXlTZsubq9kYcriIgShT0GFheh6BtpWL7AygZi
	 t0ELgBa3DbuhQ==
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
Subject: [PATCHv2 bpf-next 01/23] ftrace: Add ftrace_hash_count function
Date: Wed,  4 Mar 2026 23:21:19 +0100
Message-ID: <20260304222141.497203-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
index 8baf61c9be6d..ac06bf17caaf 100644
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

