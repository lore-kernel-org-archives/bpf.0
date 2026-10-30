Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403279;
	b=ASJNyQCd0rDvqDnmvhzLO25q0WGEKb/Xg77AlqCFmcz+woYH0vg1ZXNGi4AH2UOJV+qJ
	 TC/rgIZO6kGoiAAngBFWJj2EcjUhYP+ArCkff03+HSrCjuk486tKl/OrQOT0oPARKvKHU
	 OlHs3WMYp0XguLZb/JrQPc1kfk4kLCwXxfLmEx4t03ztM5xtzcauZW92A+zdohwvtvz34
	 l8G2yEhSeBOV3Bw51RiC1fQDV1J5eU6E9mVFKfVgU6ksYSpNoCjGNBnuSNi8Ylq1l+zGw
	 0i6N7l/HibNFJuix19g1/AXSrUQz/IBnEjBiwEDhdbsj/JldSMHDn2sf89AZor9VHUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403279;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G3YFAaaxl0Inr2/H53xz8FfOpWErwcq/FMtfYO1jp6U=;
	b=kMEWezvfXuL11fU/g1uKREct4cra2/SATMo3h7l9hult/2RQI6prblPMYSUEplRqmK74
	 EfEXf2fOyUpkjkFr51oSeSpQM7NdKMMq2UYLKcEsj2bI1fdPlFHINFP07402C5tIE77Ce
	 fkwfcTagit8NYqm9Jg8lFqeziLHUM8wVoTvwyPefnOCGXBwdFcIT4By+qP2pDKdcXngtQ
	 92mwmoRSOXP5ynzSsO10JyXqmJ7IZjjgYn/wklhQkylPT7bSju7n78XmU68mClQBewst0
	 n2RSd2L4670kYcWp1xq9JFQ1WoEEX3NdYBY9qSkOzMAYZaCbYpiPaIxnuJHARJNsGSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X2Ek2HkO;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BA606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X2Ek2HkO
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QwsJ5AyRpbL/65NQ5weSQJ5m3J9xoPU4+GfbGvNUP7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403276; v=1; x=1794008076;
 b=X2Ek2HkOCEKsSPhXpxtqDvTnw5jTLicnlM+j7vaxfW4rFjxxp3PPBZdZnDPXvylmcxAWOe9B
 5kKMoXGeh9dszOVM592Y3FiID6jNL+UeMi+pq9KuCyt7LWUQ9C12B9brgkGCT33c6p8ireg14jz
 rcvwD3jmB1uSSnMBFdlecPvc=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 657d2b4e2f082f61;
	Fri, 30 Oct 2026 23:34:36 +0000
X-Mizu-Trace-ID: 657d2b4e2f082f61
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
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 07/13] selftests/bpf: Cover unknown BTF header-extension bytes in btf dump
Date: Fri, 30 Oct 2026 16:33:49 -0700
Message-ID: <20261030233355.1836749-8-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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
 .../bpf/prog_tests/bpftool_btf_dump.c         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index e66e686e4e12..3bfbd185a74d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -57,6 +57,42 @@ static struct btf *mk_btf(void)
 	return btf;
 }
 
+/* mk_btf() with a nonzero byte in an unknown header extension */
+static struct btf *mk_hdr_extra_btf(void)
+{
+	struct btf *btf, *ext_btf = NULL;
+	const __u32 extra_sz = 4;
+	__u32 hdr_len, sz;
+	const void *raw;
+	char *ext;
+
+	btf = mk_btf();
+	if (!btf)
+		return NULL;
+
+	raw = btf__raw_data(btf, &sz);
+	if (!ASSERT_OK_PTR(raw, "raw_data"))
+		goto out;
+
+	hdr_len = ((const struct btf_header *)raw)->hdr_len;
+
+	ext = calloc(1, sz + extra_sz);
+	if (!ASSERT_OK_PTR(ext, "alloc_ext"))
+		goto out;
+
+	memcpy(ext, raw, hdr_len);
+	ext[hdr_len] = 0xA5; /* any nonzero value */
+	memcpy(ext + hdr_len + extra_sz, raw + hdr_len, sz - hdr_len);
+	((struct btf_header *)ext)->hdr_len = hdr_len + extra_sz;
+
+	ext_btf = btf__new(ext, sz + extra_sz);
+	ASSERT_OK_PTR(ext_btf, "btf_new_ext");
+	free(ext);
+out:
+	btf__free(btf);
+	return ext_btf;
+}
+
 /*
  * Older kernel BTF encodes the arena attribute as "address_space(1)":
  *
@@ -328,6 +364,12 @@ void test_bpftool_btf_dump(void)
 		unlink(path);
 	}
 
+	if (!btf_to_tmpfile(mk_hdr_extra_btf, path)) {
+		if (test__start_subtest("hdr_extra"))
+			test_dump(path, true);
+		unlink(path);
+	}
+
 	if (!btf_to_tmpfile(mk_legacy_arena_btf, path)) {
 		if (test__start_subtest("legacy_arena"))
 			test_legacy_arena(path);
-- 
2.56.0

