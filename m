Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901624;
	b=Q9bSs4Z8Ia7Mvp5EEiC2885FdlDmG65kfRJFyooS/Km2FdPzcnz57LPCg1jK2CPR3jwC
	 vBYC+sx3HjIXLTz3lI7avETCVpXkpjJ/mlJKyafaP8zOLoMoJodv/4MBDTxFzDvattBh+
	 424bdDSHHaVEMQXCx97VUhsz4NmOPQjoDLqxVJrSsVIXQ7AYaFvhWdIdG3TFRZlkRofKV
	 j3NLowoKxENro3wIPgeW4TDr2+nEuMtZKX4a+vvhxjgX28M+d4YH8SWzY2Pp8fz6WCYqD
	 s57USfW73U6Bj3hrsENfJkoc2TsCVlKtbTEasCjJgowHC8DPsXoL3JVx95i7tgVGhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901624;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4QKs2QF+ftghn2qm6IhPcnHEau9iZVT/ILBYI6rBZJU=;
	b=a6qKghHkdULjGCFHeYQfVLXUyzAnJqbCLF4MT8J8GnCTFJ6URM4W2UQU+tT6+EloA0Bv
	 XczxX4r8rC8iRiZOt4cpSLvQxUT40OoTS7E/cNr8VNlzW9tbJG3B+puL++vdnJeRRtHyH
	 aTOWgEYppojtPZqetnMd1xP3y7hhg/GemTRmc4o7fBM46Ltfo7RG3uFOz5raArcJqKg9c
	 AhYCuxqu65Zz+1QbJoosvJSv6/XTQaKgtl6Wg9Ov3bpbT7QE6LKRWXunY4P/Ntc8y13VF
	 4xQKUsCVantBYR8rt6pfzCeHCNIEHHQGWRhqv7c5kcw/7MfARvWj1k43QKd3O4wojTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QOroEtoZ;
	arc=none smtp.remote-ip=95.215.58.67
Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6E606A334
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB6E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QOroEtoZ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Zaw/aEBkaqaNKM8HltGI6LduPDtXoazLgqovnzNCy+U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901621; v=1; x=1794506421;
 b=QOroEtoZVorej4YpuK6564RZTbAm4sa5Q9ztKg/PcpkYXgoXjQgO7n8OUUOQARyRBo04np5s
 u6eeM4N6egSOtupn2ivMLHZOinpEgjNuzMpQYfd3bxFKoZUnBSJFSfuiCuK5Z4DMxnzOj5YEZPY
 4TJv3ltK96l0Sn99RBJ3Xi1A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15ee34f056b9fc17;
	Thu, 05 Nov 2026 18:00:20 +0000
X-Mizu-Trace-ID: 15ee34f056b9fc17
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
Subject: [PATCH bpf-next v4 09/17] selftests/bpf: Cover legacy arena type tags in bpftool C dumps
Date: Thu,  5 Nov 2026 10:58:37 -0700
Message-ID: <20261105175845.30357-10-ihor.solodrai@linux.dev>
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

Older kernel BTF tags arena pointers in kfunc prototypes with a kflagged
"address_space(1)" type tag. bpftool prints such tags as the complete
attribute specifier.

Add bpftool_btf_dump subtests that dump a minimal BTF with an arena
kfunc in the legacy encoding, alone and as the base of a split BTF with
an arena kfunc of its own, dumped with -B as module BTF is. Check that
the C prototypes carry the complete specifier.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 106 +++++++++++++++++-
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 0cfff1b96666..a0f801fcaa47 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -93,6 +93,58 @@ static struct btf *mk_hdr_extra_btf(void)
 	return ext_btf;
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
+static struct btf *legacy_arena_base;
+
+/* Module BTF over legacy_arena_base, with an arena kfunc of its own */
+static struct btf *mk_legacy_arena_split_btf(void)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty_split(legacy_arena_base);
+	if (!ASSERT_OK_PTR(btf, "new_empty_split"))
+		return NULL;
+
+	btf__add_type_attr(btf, "address_space(1)", 1);
+	btf__add_ptr(btf, 7);
+	btf__add_func_proto(btf, 8);
+	btf__add_func(btf, "arena_mod", BTF_FUNC_GLOBAL, 9);
+	btf__add_decl_tag(btf, "bpf_kfunc", 10, -1);
+
+	return btf;
+}
+
 static struct btf *mk_loc_btf(void)
 {
 	struct btf *btf;
@@ -180,7 +232,7 @@ static int btf_to_tmpfile(struct btf *(*mk)(void), char *path)
 	return err;
 }
 
-static char *dump_c(const char *btf_path, bool sorted)
+static char *dump_c(const char *btf_path, const char *base_path, bool sorted)
 {
 	char args[MAX_BPFTOOL_CMD_LEN];
 	char *buf;
@@ -190,8 +242,8 @@ static char *dump_c(const char *btf_path, bool sorted)
 	if (!ASSERT_OK_PTR(buf, "alloc_dump"))
 		return NULL;
 
-	snprintf(args, sizeof(args), "btf dump file %s format c%s",
-		 btf_path, sorted ? "" : " unsorted");
+	snprintf(args, sizeof(args), "%s%s btf dump file %s format c%s",
+		 base_path ? "-B " : "", base_path ?: "", btf_path, sorted ? "" : " unsorted");
 
 	err = get_bpftool_command_output(args, buf, DUMP_BUF_SZ);
 	if (!ASSERT_OK(err, "btf_dump_format_c")) {
@@ -255,7 +307,7 @@ static void test_dump(const char *btf_path, bool sorted)
 
 	exp_path = sorted ? EXPECTED_SORTED : EXPECTED_UNSORTED;
 
-	dump = dump_c(btf_path, sorted);
+	dump = dump_c(btf_path, NULL, sorted);
 	if (!dump)
 		return;
 
@@ -270,6 +322,44 @@ static void test_dump(const char *btf_path, bool sorted)
 	free(dump);
 }
 
+static void test_legacy_arena(const char *btf_path)
+{
+	char *dump;
+
+	dump = dump_c(btf_path, NULL, true);
+	if (!dump)
+		return;
+
+	ASSERT_HAS_SUBSTR(dump, "int __attribute__((address_space(1))) *arena(void)",
+			  "arena_kfunc");
+	free(dump);
+}
+
+static void test_legacy_arena_split(const char *base_path)
+{
+	char path[PATH_MAX];
+	char *dump;
+
+	legacy_arena_base = btf__parse(base_path, NULL);
+	if (!ASSERT_OK_PTR(legacy_arena_base, "parse_base"))
+		return;
+	if (btf_to_tmpfile(mk_legacy_arena_split_btf, path))
+		goto out;
+
+	dump = dump_c(path, base_path, true);
+	unlink(path);
+	if (!dump)
+		goto out;
+
+	ASSERT_HAS_SUBSTR(dump, "int __attribute__((address_space(1))) *arena(void)",
+			  "base_arena_kfunc");
+	ASSERT_HAS_SUBSTR(dump, "int __attribute__((address_space(1))) *arena_mod(void)",
+			  "split_arena_kfunc");
+	free(dump);
+out:
+	btf__free(legacy_arena_base);
+}
+
 static void test_loc_dump(const char *btf_path)
 {
 	const char expected[] =
@@ -325,6 +415,14 @@ void test_bpftool_btf_dump(void)
 		unlink(path);
 	}
 
+	if (!btf_to_tmpfile(mk_legacy_arena_btf, path)) {
+		if (test__start_subtest("legacy_arena"))
+			test_legacy_arena(path);
+		if (test__start_subtest("legacy_arena_split"))
+			test_legacy_arena_split(path);
+		unlink(path);
+	}
+
 	if (!btf_to_tmpfile(mk_loc_btf, path)) {
 		if (test__start_subtest("loc_dump"))
 			test_loc_dump(path);
-- 
2.56.0

