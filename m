Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403275;
	b=SVplRcdM7LocuqGr1YDfx2uBHYaLTnfmyTCMK8sAFMK6jmqtV2dv22BZXRsiMO/kY19l
	 kKIDVtFhGZUdnW3N7SdwgxNWIHS2tMkxMRJfNcbRPIaeZqMMK/jZqxswDt80+cAiVMiuF
	 S6OwgsrbFpGpLXJ8iDeLRTl+cMDsfggL3olcHsBi0DsEaUTlc4hYsw3rVcPWbk3TaI0OL
	 aPwHvgTLoAs2Nb46+iSF16CzSZitAkFeJ2orrSeiFeD4EOaSmoW4yqj8Lwvf8qUG56TLM
	 U/7LgEvnmmwCeFT/3nJQIZYUZ+8SZ+RbCwirzaTn6jhzPFPfSlDhU2YbWO19Tkfnh1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403275;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uGsegirvneLN+oPwS5M46TKzpsJLJlgUZkuHZXd++2s=;
	b=c3MuOMJA5Qq+gLJx8toRKoWLPpV20jKHWvbpd5M6eBy+8fBJAAF+x7w/xghBySh7MX3g
	 FMhvCy3UvUv8aewGTjeJUlXiTFLqA1LZ028WLeoB/jJpxLEHY40rNRoDbTkxBW7aZm/W0
	 WRnqMiYK5PyHUyAr2uI2NozCXP7MuPAUeO6MuyYUbzPV6ophcqcrcYGIjrcUSOjGL6qRE
	 plXbZjFVw2I7fH61wRC4/uWwf2RIOWdMPFzlBpU6DdB59V2CGvr+FjvMv8Cx9rGnh6Uuv
	 aGErzYF2b80TSRS6HQhet7mhMmbP0UF+oIrc4ZxRT4Kic/QGjPkklAk1nX74IMRvP/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SoLPffDI;
	arc=none smtp.remote-ip=95.215.58.10
Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D6606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 372D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SoLPffDI
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ogC6mtvWjMyRThpRlxxFVBsUROpjuaEhgLRLA1X3eUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403273; v=1; x=1794008073;
 b=SoLPffDIXzBg4YPS8Nhw7bdiZy71ZznjNSoNA+RvEL28pWGjOLtKd1nZH+59Ah4+JL/rrYs7
 gFbXopZkqL1F/OXNDoaCa3vCZHvSh/q/FFTanIyKc29hShdNJd/fOVOoU5/8c7Qs6/yRMx13njJ
 cqHcMmfiM7uxYBPJBFYJ+tA8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id edb194e944abea32;
	Fri, 30 Oct 2026 23:34:33 +0000
X-Mizu-Trace-ID: edb194e944abea32
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
Subject: [PATCH bpf-next v3 06/13] selftests/bpf: Cover legacy arena type tags in bpftool C dumps
Date: Fri, 30 Oct 2026 16:33:48 -0700
Message-ID: <20261030233355.1836749-7-ihor.solodrai@linux.dev>
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

bpftool rewrites kflagged "address_space(1)" type tags from older
kernel BTF to the complete attribute specifier before dumping C.

Add a bpftool_btf_dump subtest that dumps a minimal BTF with an arena
kfunc in the legacy encoding, and checks that its C prototype carries
the complete specifier, fixed up by bpftool.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 80e8e435d702..e66e686e4e12 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -57,6 +57,38 @@ static struct btf *mk_btf(void)
 	return btf;
 }
 
+/*
+ * Older kernel BTF encodes the arena attribute as "address_space(1)":
+ *
+ *	int __attribute__((address_space(1))) *arena(void);
+ */
+static struct btf *mk_legacy_arena_btf(void)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return NULL;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_type_attr(btf, "address_space(1)", 1);
+	btf__add_ptr(btf, 2);
+	btf__add_func_proto(btf, 3);
+	btf__add_func(btf, "arena", BTF_FUNC_GLOBAL, 4);
+	btf__add_decl_tag(btf, "bpf_kfunc", 5, -1);
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] TYPE_TAG 'address_space(1)' type_id=1 kflag=1",
+		"[3] PTR '(anon)' type_id=2",
+		"[4] FUNC_PROTO '(anon)' ret_type_id=3 vlen=0",
+		"[5] FUNC 'arena' type_id=4 linkage=global",
+		"[6] DECL_TAG 'bpf_kfunc' type_id=5 component_idx=-1");
+
+	return btf;
+}
+
 static struct btf *mk_loc_btf(void)
 {
 	struct btf *btf;
@@ -234,6 +266,19 @@ static void test_dump(const char *btf_path, bool sorted)
 	free(dump);
 }
 
+static void test_legacy_arena(const char *btf_path)
+{
+	char *dump;
+
+	dump = dump_c(btf_path, true);
+	if (!dump)
+		return;
+
+	ASSERT_HAS_SUBSTR(dump, "int __attribute__((address_space(1))) *arena(void)",
+			  "arena_kfunc");
+	free(dump);
+}
+
 static void test_loc_dump(const char *btf_path)
 {
 	const char expected[] =
@@ -283,6 +328,12 @@ void test_bpftool_btf_dump(void)
 		unlink(path);
 	}
 
+	if (!btf_to_tmpfile(mk_legacy_arena_btf, path)) {
+		if (test__start_subtest("legacy_arena"))
+			test_legacy_arena(path);
+		unlink(path);
+	}
+
 	if (!btf_to_tmpfile(mk_loc_btf, path)) {
 		if (test__start_subtest("loc_dump"))
 			test_loc_dump(path);
-- 
2.56.0

