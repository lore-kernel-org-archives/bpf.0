Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901592;
	b=n+6ujLLfwZnpOsSL8K9U8yRvb4SiiJPvvSdh2IpPyHl2Q7/iqLeICzHzBUrDgwY7lfU2
	 vePXaZAI5VGObMOU7En71OuRsrPmNFEMzoa6ypkmisa2C+kv/l+fPJfkOFKkhjm5lAY75
	 E9D1eeaL8ujlc/pmd42l4v4OqkAWls0aCNPIcSletIri3T7/yH3DkkyHKTM6SqGdxRf+m
	 qhAv8mE0jpjvnWAjPJTSQOeFObUHfSkH7z/UZvZk2FJYbbbC65C6T7boDGsjdjUIdtQ+K
	 FIAv4x//q+uladl7JIAruhjvQ7cw/ekJSjv4+rN34XbZ32+89lpJQd3j6FM+joN3oOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901592;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cw3Ipf0SAEfAdzcQRqDFX48791OBtoULkavj3jZ/+zg=;
	b=V3U+GLoxb3ILlJ1Rk6avkAkUaYkgKSsd4kb02VYkg0pgALM8iaqkbQEQE74VdL4U34z0
	 PpOKC1IKLiO8TD0RrcEKioxBL7p3BZ1Qvq8le8FcXhSstJQXldK/375OaphR+hyJfbdm3
	 NLDq4NaDAXSU0CaD7Vi/hsEhz6zNR6Ur1QTS0yqSBoIDfhH+n8kzIu0TioMbhImRJER/q
	 Xp1nx5VJoFs9dUFZMiqicdgTN1CsI8baxwq1MS3hBNewUZwEbxXqvURpBCl0Oukaq1bzO
	 OyBydn4H5uDlAGtB+0AJzwd5dDS4d3ROMUOwL2wBw8e7RnULyJ3LC8F2QwtbyfAy06Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BJRNfl4w;
	arc=none smtp.remote-ip=95.215.58.19
Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB6606EEA5
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FB6606EEA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BJRNfl4w
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TzDIjvwTc0VUWMiS7/2I8h/NTREkmi4XCKOK4I4+e2I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901589; v=1; x=1794506389;
 b=BJRNfl4w4CmMmAUH5H4XFED0JgsVPOI+otSjH4KmZ8MuMYGbGIgiMMcb7oceDO8Vv7YBclE+
 7MwkrxYmYpvyDMET/g14chkwmuMIWCuU4PCGBcH48NN4jkZE0c6dmnD4oHmbEUO2DBK4Yc0ew5m
 vrfkhIatHAGc419FWAG7VXOs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 52d1e1b1f3f95e3c;
	Thu, 05 Nov 2026 17:59:49 +0000
X-Mizu-Trace-ID: 52d1e1b1f3f95e3c
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
Subject: [PATCH bpf-next v4 05/17] selftests/bpf: Cover unknown BTF header-extension bytes in bpftool C dumps
Date: Thu,  5 Nov 2026 10:58:33 -0700
Message-ID: <20261105175845.30357-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

libbpf can parse BTF whose header carries unknown nonzero extension
bytes, such as BTF from a newer kernel, but refuses to modify it.
bpftool dumps C through a split BTF over the input, so that it can
annotate the dump without modifying the input.

Check that a C dump of such BTF matches the dump of the same BTF
without the extension bytes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 80e8e435d702..0cfff1b96666 100644
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
 static struct btf *mk_loc_btf(void)
 {
 	struct btf *btf;
@@ -283,6 +319,12 @@ void test_bpftool_btf_dump(void)
 		unlink(path);
 	}
 
+	if (!btf_to_tmpfile(mk_hdr_extra_btf, path)) {
+		if (test__start_subtest("hdr_extra"))
+			test_dump(path, true);
+		unlink(path);
+	}
+
 	if (!btf_to_tmpfile(mk_loc_btf, path)) {
 		if (test__start_subtest("loc_dump"))
 			test_loc_dump(path);
-- 
2.56.0

