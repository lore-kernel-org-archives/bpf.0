Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794447;
	b=AoWczJyNx8w3vY097QbIIEOAqWeYYqvs7uqoTLUqD7G7Mu02Ttm/ipCSyWyizkh4nSIb
	 cubyx/KbJFIQz4gC/b6O8D0x+g7onsNPmeEwzc6nrtYW69k+HGrSwDPsxLlaYm+AS+R67
	 a7yHu4VYXnHqo9y/RJZMEkdfKoNR5+p7gmrlK6JfEyU47mfS8LGxf00hZcLRkhhKGGobp
	 ktmWK3NBUWxFKfVDGESFEWS/SPUOAiHsefLLFB8jh+ti1QndRY2mog8sOWPW16gVpUIhC
	 KRRB4/6vZlOlQokt8ppVKzGxeYh0JhwJf8KAiHErxNS5pemSJix+F0fCYJSseY7guoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794447;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LFYL4E9LqM0EHpQKQmKEgdTpvOQQnQGSxzNySVSz7BE=;
	b=jyNH1yfdUNEjVzHUdtXQ2ueWO323mDkTuC4JqMtqto/jFlFF7NPOgiW0rqMdJ0KNu9tm
	 JVWxZQZjl8iS7dK7eVpygPViUsK+ZjeUGzMGBqn/Vx9qUJaAFIoV7MyINKss5LwiM9jQe
	 AwqFwOTspT732Wm86CY8oHO2B2lAUxe/mitU0f6kmOVtuu4pu63v11l44sCRkO0KeZ02s
	 OK+c9Lw8jGltVEegk4Pw92enhLpdpbpj3CRFyKV9GZUpgyy54whzfEwjOsJobjgAB0LUM
	 HskU75BxQ1dbkxzJhNnOEi/e8Dr3+sqH1TPE4ysPjbv+HeykYEv3ElTCOj7sEuyXdSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="j2d/TxVd";
	arc=none smtp.remote-ip=91.218.175.172
Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE49B606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE49B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j2d/TxVd
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zyPqRdPYoD4kVIuDIZ26sgnfEPq9s+M9WKNd7HvJ3no=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794444; v=1; x=1793399244;
 b=j2d/TxVdmo45q7ClCPTWmUaA6bsgBQKELUEj/9mM0tLYyJSaoDM4JABBHKzYDisf7OWYEomM
 3suGRkhfHmAWoNFrNdhe1q6lo5fsQbUTDkm81rKIfQYF1xItwBkIpT5bxlnjbher+yRRpu43nZO
 kYqm+o6wbC5A9yrSorZWlaAU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id bf4000ac44c457d1;
	Fri, 23 Oct 2026 22:27:24 +0000
X-Mizu-Trace-ID: bf4000ac44c457d1
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
Subject: [PATCH bpf-next v2 2/8] selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
Date: Fri, 23 Oct 2026 15:26:46 -0700
Message-ID: <20261023222652.3927736-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
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

libbpf can parse BTF with a header carrying unknown nonzero extension
bytes, such as BTF from a newer kernel, but refuses to modify it.

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

