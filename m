Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692791;
	b=VIa2/t4XxjTBZZ5rrExMwSVVME36VsTUzu81gJgFUnFG+85J+f5VQLQdzdQVIgyFIGR/
	 y1hb/hbVlFIcVxUcR4qwqJKaBEqQ7iFbw6at5Akx/sIhoMPl94tJ5dkBoz6f96iKoSSUy
	 udxb/Mbchs8KWSJNEKuu/PmyUpQJBY34OaZ0aoxumOPwmDR3f90CFOw2Y6iJJ9kdNBbIS
	 FQcIM06bGLC1xbv79LDRBTtT37ojQO5Hv1Jg2VzhRTZ8G0QXZi4rAw2ZI4vf2/sk1RV0A
	 uWC5CMll0NqHv1x2DsfXmwViTfojGOs+Hkw/mo/10lZaF25mLtL4upYpSgZ9prpN1XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tjipW30n5WfXiCHIuo/tN0yoEdsPNYs9uCjpwtKDyuw=;
	b=BSVObdXJgrvWt8BmTOdc4tHbvlL1nF1auWpVQ5545Ebi8yqDeSSc9UchyXrrUOi3lzTb
	 ggjwjXaB33CewKG9nyPyxHDN0MVLDFchM/Lc2q8LTYgVskTqYoOB0Dv2RXvbOGnbVDkbe
	 L5HaZbSM1Nkv7tsBXmioDy689Iuia3ihtQwwumH5p1WSTjUeuhDJBXRUgRjN2DYWaZpO6
	 nbyxMHswqMDL/G6ZLDvpWQnstGGJ+WT/CSKe8140hq78pkQTbQoT26qoJZPHRz83OTX9F
	 ivmYqBQVKM0NCbH87QfCeDOvUVAdiVSzxdqklo2C374FSmF+aoAO/2aR5z7PDk9NMgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHFeiPcQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6E606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHFeiPcQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF501F000C1;
	Tue,  3 Nov 2026 07:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692790;
	bh=tjipW30n5WfXiCHIuo/tN0yoEdsPNYs9uCjpwtKDyuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHFeiPcQQW/94MTxexMAYrUW9Dyut4aq1JgGRW7bzCtKowXs88bTOQLOOwkAmjREi
	 +Ot1cEToqtExLUQonQP5Sorjb9jMK0QkuyD8VClVuA3Gz1IRmteHZT4vpvZ8Tdc++H
	 hdJSQMYfoH9YqsmH1n1DTUjSsO+eQANHI1op1JmW97+y6eD3pzABQEVaXQRRkwc/xg
	 +sNhns7OeXVPbXrsmVir2YaI039WN5gedz2vPSrupYJLMMEVGBvSpkbIjX8zJ1QWzI
	 p3IRoPcf8dxWG/a3YM5+baiH89cWQ1LALEk91SN2dUZE0DivZyx36nwdW3VioRp/eW
	 vO1AwEOp+7ZWg==
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
Subject: [PATCHv2 bpf-next 3/8] selftests/bpf: Add get_procmap_info helper
Date: Tue,  3 Nov 2026 08:59:10 +0100
Message-ID: <20261103075916.100050-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075916.100050-1-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
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
2.43.0

