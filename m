Received: from mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226A1DED42
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108845; cv=none; b=t7ymXBInkQQORD10l1pfvJNs+/0zZrJ9rn8qL/BmJeBNHwPygPz/+H3s0McYY6lgP3okyTuTmAZXuTZ3evr3i4EnkG3LzM5DuwYte79eP3xqwaYQA42saVyL3m3UAV/GrKI+SbvDoS7qy2jJIy+DfSLbdiAngWs7Tgil6hRvHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108845; c=relaxed/simple;
	bh=vZa/xrWs9QoQ6aT53YrWKgOl/YAIzzcX6eNpuC6TPLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P38Vr4aY5U3fR0Psjn+wpW4y1HvegHTi/SBGwb9VC24HETHTsgYQftYN+y3oHcNPYecvoYAQAMWdR8RJblGn4GGbbp0VBnw6o4G3J22Uzjk4bebsbshU/sG9SPIH8YpqTDcXl42a0gC1JgVMUu1FTOn7mzxOjJ5/7VI2ZO6Tl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K/PFVT3p; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K/PFVT3p"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vZa/xrWs9QoQ6aT53YrWKgOl/YAIzzcX6eNpuC6TPLo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108842; v=1; x=1792713642;
 b=K/PFVT3p6zXB0kPAxLc3A0WkDOnJKlB3Bn1F+oPL55Rtxz9HFUlEtYmZzjpFnL8ypG33m+tp
 2g3uj08zq2G3k+vuiTqJ6AaJwGDwVSzRlGDMio06+4qIxnRriFArdym2/w3CW6vmZy3laAF+NsG
 lGt/W5U+lx9aJzKvOufSHvsU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 4bb065713b7707c9;
	Fri, 16 Oct 2026 00:00:34 +0000
X-Mizu-Trace-ID: 4bb065713b7707c9
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 2/8] selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
Date: Thu, 15 Oct 2026 17:00:06 -0700
Message-ID: <20261016000012.2232059-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf can parse BTF with a header carrying unknown nonzero extension
bytes, but refuses to modify it. bpftool dumps C from a detached copy
so that it can modify BTF before dump.

It is expected for a C dump of a BTF with extension bytes to match the
dump of the same BTF without them, but there is no test for this.

Add a test case to bpftool_btf_dump to cover it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 55 ++++++++++++++++---
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 534aa79a4278..9104c059a315 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -109,17 +109,11 @@ static struct btf *mk_loc_btf(void)
 	return btf;
 }
 
-static int btf_to_tmpfile(const struct btf *btf, char *path)
+static int raw_to_tmpfile(const void *raw, __u32 sz, char *path)
 {
 	ssize_t written;
-	const void *raw;
-	__u32 sz;
 	int fd;
 
-	raw = btf__raw_data(btf, &sz);
-	if (!ASSERT_OK_PTR(raw, "raw_data"))
-		return -1;
-
 	snprintf(path, PATH_MAX, "/tmp/bpftool_btf_dump.XXXXXX");
 	fd = mkstemp(path);
 	if (!ASSERT_OK_FD(fd, "mkstemp_btf"))
@@ -135,6 +129,18 @@ static int btf_to_tmpfile(const struct btf *btf, char *path)
 	return 0;
 }
 
+static int btf_to_tmpfile(const struct btf *btf, char *path)
+{
+	const void *raw;
+	__u32 sz;
+
+	raw = btf__raw_data(btf, &sz);
+	if (!ASSERT_OK_PTR(raw, "raw_data"))
+		return -1;
+
+	return raw_to_tmpfile(raw, sz, path);
+}
+
 static char *dump_c(const char *btf_path, bool sorted)
 {
 	char args[MAX_BPFTOOL_CMD_LEN];
@@ -262,6 +268,39 @@ static void test_loc_dump(const char *btf_path)
 	free(dump);
 }
 
+static void test_hdr_extra(const struct btf *btf)
+{
+	const __u32 extra_sz = 4;
+	char path[PATH_MAX];
+	__u32 hdr_len, sz;
+	const void *raw;
+	char *ext;
+	int err;
+
+	raw = btf__raw_data(btf, &sz);
+	if (!ASSERT_OK_PTR(raw, "raw_data"))
+		return;
+
+	hdr_len = ((const struct btf_header *)raw)->hdr_len;
+
+	ext = calloc(1, sz + extra_sz);
+	if (!ASSERT_OK_PTR(ext, "alloc_ext"))
+		return;
+
+	memcpy(ext, raw, hdr_len);
+	ext[hdr_len] = 0xA5; /* any nonzero value */
+	memcpy(ext + hdr_len + extra_sz, raw + hdr_len, sz - hdr_len);
+	((struct btf_header *)ext)->hdr_len = hdr_len + extra_sz;
+
+	err = raw_to_tmpfile(ext, sz + extra_sz, path);
+	free(ext);
+	if (err)
+		return;
+
+	test_dump(path, true);
+	unlink(path);
+}
+
 void test_bpftool_btf_dump(void)
 {
 	char path[PATH_MAX];
@@ -278,6 +317,8 @@ void test_bpftool_btf_dump(void)
 		test_dump(path, true);
 	if (test__start_subtest("c_unsorted"))
 		test_dump(path, false);
+	if (test__start_subtest("hdr_extra"))
+		test_hdr_extra(btf);
 	unlink(path);
 
 	btf__free(btf);
-- 
2.56.0

