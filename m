Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309187;
	b=XwMH22EP3M+IgqRa7hUfIu/vi4qrDwIYPaSDKGI8XynRld2KZFs/iaGgHe+ShfgPpsEB
	 4cr3qi9SSHZc3DMmMDQtov0V4Pz84c8rNKDO5GUtxxzjUiHJMNKZTmTc/8sFjAEiNzE0O
	 tRErpYyRhgsDj6D8zgU+MyDiIML55zE6kq1CmHTddACk+2WiYTYpvlpWfvruibNAtSfDX
	 SWDgi9TELN1ZJ0o8f2FgzANOIvYrqQGF71m18ElEghtq8mXCCgSwWcp6H8guzxqk+CDuk
	 X/xk8R/nGgzWjL0mvlNMPI8zSoJu8A/1jMPE2TSF29dThC+TusmtKJqIXrCQEan1KsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=N9mCBJUUCqs6IT2F5T2oWyZqbwvi6Ucfb+HOwsiw6Ho=;
	b=QBlJnCKmlewy+lJvJHhEHkPJTVZZVURFXKuDU5Hzjwzjbu7QQOY8vceep/vaJ322JxnI
	 CyhZGSADdnSsanLrUlpIhd4jYCYQv0ToQwQtRIz6V4KbR5ppHVbO7KMymKcGoNu/Y9LaE
	 clFjX++9kj0oV1lSdk3aY+BL6F6/hSaThueN5o0jL2bhwug2jwkQ8Ty/WcMJ3LnLC+Zpb
	 zA9OurHoio/JyYZnm925QdSEFjFPypVH13GDmpZQDWxyLVDkjxPDJVqhVsv9V9H1HOBE0
	 T0CsvupPT6jPlCLN/B6pLPDPijYrg1OvDHlyu4thiM+bwZqzTBZs9F8SGGM6fgJQA0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aeK2et/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59061606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeK2et/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4471F01816;
	Thu, 29 Oct 2026 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309186;
	bh=N9mCBJUUCqs6IT2F5T2oWyZqbwvi6Ucfb+HOwsiw6Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aeK2et/ioxvUdQdQI8JkeqiV15qJC8AdzGa7lYdRlpe2+NjG0LieAd699w0CLASvl
	 QzmbRNotAYc0wp4mLn6SpbwpXcT/uD3gy9/Gs+oFl0za96lCAZ/Q6TA9qFI+fuLua9
	 aBuKPBOh5jpPx0LkBeaUz3MpRh4dGOkZ/NnTSrFslgrU9Uh3kYnBuKcvFi2yJwG1TA
	 Y27GoHTapanIpRQce38JH+qYs2ulBMK309Y5nb/IXLfkQpVXAS9ILaSVu7rnV/kDFa
	 5uSvDy4VZqiwLgekenCa6aaq25z/xNuy3rT/JHZagEhJySY/O3GTovibuBeLTfkJTx
	 V6UvWlqo+FTzw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCH bpf-next 3/8] selftests/bpf: Add get_procmap_info helper
Date: Thu, 29 Oct 2026 22:25:46 +0100
Message-ID: <20261029212551.56964-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding get_procmap_info that queries the current process VMA range
and permissions through PROCMAP_QUERY. Extend procmap_query to return
the VMA end address and update its callers.

I don't think we need the search fallback, the PROCMAP api is merged
for some time now.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 38 ++++++++++++++++++---
 tools/testing/selftests/bpf/trace_helpers.h |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 6d7a4b8c4ab8..d2b2ff0ec2a4 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -286,7 +286,8 @@ unsigned long long module_get_base_addr_sec(const char *module, const char *sec)
 #ifdef PROCMAP_QUERY
 int env_verbosity __weak = 0;
 
-static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
+static int procmap_query(int fd, const void *addr, __u32 query_flags,
+		 size_t *start, size_t *end, size_t *offset, int *flags)
 {
 	char path_buf[PATH_MAX], build_id_buf[20];
 	struct procmap_query q;
@@ -325,6 +326,7 @@ static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *st
 	}
 
 	*start = q.vma_start;
+	*end = q.vma_end;
 	*offset = q.vma_offset;
 	*flags = q.vma_flags;
 	return 0;
@@ -333,13 +335,37 @@ static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *st
 # ifndef PROCMAP_QUERY_VMA_EXECUTABLE
 #  define PROCMAP_QUERY_VMA_EXECUTABLE 0x04
 # endif
-
-static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
+static int procmap_query(int fd, const void *addr, __u32 query_flags,
+		 size_t *start, size_t *end, size_t *offset, int *flags)
 {
 	return -EOPNOTSUPP;
 }
 #endif
 
+int get_procmap_info(const void *addr, size_t *start, size_t *end, char perms[5])
+{
+	FILE *f;
+	size_t offset;
+	int flags, err;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	err = procmap_query(fileno(f), addr, 0, start, end, &offset, &flags);
+#ifdef PROCMAP_QUERY
+	if (!err && perms) {
+		snprintf(perms, 5, "%c%c%c%c",
+			 (flags & PROCMAP_QUERY_VMA_READABLE) ? 'r' : '-',
+			 (flags & PROCMAP_QUERY_VMA_WRITABLE) ? 'w' : '-',
+			 (flags & PROCMAP_QUERY_VMA_EXECUTABLE) ? 'x' : '-',
+			 (flags & PROCMAP_QUERY_VMA_SHARED) ? 's' : 'p');
+	}
+#endif
+	fclose(f);
+	return err;
+}
+
 ssize_t get_uprobe_offset(const void *addr)
 {
 	size_t start, base, end;
@@ -352,7 +378,8 @@ ssize_t get_uprobe_offset(const void *addr)
 		return -errno;
 
 	/* requested executable VMA only */
-	err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE, &start, &base, &flags);
+	err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE,
+			    &start, &end, &base, &flags);
 	if (err == -EOPNOTSUPP) {
 		bool found = false;
 
@@ -418,7 +445,8 @@ ssize_t get_rel_offset(uintptr_t addr)
 	if (!f)
 		return -errno;
 
-	err = procmap_query(fileno(f), (const void *)addr, 0, &start, &offset, &flags);
+	err = procmap_query(fileno(f), (const void *)addr, 0,
+			    &start, &end, &offset, &flags);
 	if (err == 0) {
 		fclose(f);
 		return (size_t)addr - start + offset;
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 0f8d99746084..85b8f8e30232 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -59,6 +59,7 @@ int read_trace_pipe_iter(void (*cb)(const char *str, void *data),
 
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
+int get_procmap_info(const void *addr, size_t *start, size_t *end, char perms[5]);
 
 int read_build_id(const char *path, char *build_id, size_t size);
 
-- 
2.54.0

