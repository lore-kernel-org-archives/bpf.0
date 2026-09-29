Received: from mta1.migadu.com (out-128.mta1.migadu.com [95.215.58.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A43D565F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725600; cv=none; b=p/260u02dGLkuka93yHgAc3QjYFvkAEN0Tf/wt6cONVdPNvqLNraLYVJCG/mr7hb4qyU+SkaPFqDV99zEKAp+tBcxW/+iQn51RdY2UB6XsULu9Y4ofsOugAMrxoQIG74ch/JsyyGgMpOtGltx4+yDAsZfAsWWX4nAvqKQtPfBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725600; c=relaxed/simple;
	bh=ikmwqwL3/TPh/i98Ta/hcP6uanTK+UnCVMv4ObIUd+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WapP91f4WIPxFRyIOWzhuhD8MBtQLw2IpeJFJu3OUJXh6wmpexuK01EM80pmVyO+9/55FIaFj4uzTl3VTM2xdqtJ+WcA30OnFCEq8FiTDleVyNuePHlBblEjpxb1C/F2ofzV2K8hD0BK2XfQztL3Rlois+rBWB63hHrkeJTNvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jiDLlG0A; arc=none smtp.client-ip=95.215.58.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jiDLlG0A"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ikmwqwL3/TPh/i98Ta/hcP6uanTK+UnCVMv4ObIUd+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725596; v=1; x=1791330396;
 b=jiDLlG0A1RKx40nc6F0CaClIGBiLMepTxmF+hKAR6qXM8+NnTvwNl9H04ovi/782J8RVWFEf
 POclmBwG/WX13pPJ93kN+lWZeRQZAkSLqJwCGN8GpbVEBT54RkvuWleojTw43LE9V0TOMSlt6FI
 NeoP2p3UIQTioxBqgQg/7CtE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9620ec3aed19424f;
	Tue, 29 Sep 2026 23:46:36 +0000
X-Mizu-Trace-ID: 9620ec3aed19424f
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Show the tag kflag in the raw BTF dump helper
Date: Tue, 29 Sep 2026 16:46:08 -0700
Message-ID: <20260929234608.48503-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929234608.48503-1-ihor.solodrai@linux.dev>
References: <20260929234608.48503-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kflag on BTF_KIND_DECL_TAG or BTF_KIND_TYPE_TAG means the tag string
is an __attribute__ list rather than a btf_decl_tag()/btf_type_tag()
argument. fprintf_btf_type_raw() did not print it, so a tag added with
btf__add_decl_tag() and an attribute added with btf__add_decl_attr()
dumped identically apart from their type IDs.

Print " kflag=1" for those two kinds, only when the flag is set, so no
existing expected string changes.

Add a btf_write subtest for btf__add_decl_attr() and
btf__add_type_attr().

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/btf_helpers.c     | 10 ++++--
 .../selftests/bpf/prog_tests/btf_write.c      | 34 +++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 85a4d15d1dd1..e04b61c08cd8 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -114,9 +114,12 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_RESTRICT:
 	case BTF_KIND_TYPEDEF:
-	case BTF_KIND_TYPE_TAG:
 		fprintf(out, " type_id=%u", t->type);
 		break;
+	case BTF_KIND_TYPE_TAG:
+		fprintf(out, " type_id=%u%s", t->type,
+			btf_kflag(t) ? " kflag=1" : "");
+		break;
 	case BTF_KIND_ARRAY: {
 		const struct btf_array *arr = btf_array(t);
 
@@ -203,8 +206,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		fprintf(out, " size=%u", t->size);
 		break;
 	case BTF_KIND_DECL_TAG:
-		fprintf(out, " type_id=%u component_idx=%d",
-			t->type, btf_decl_tag(t)->component_idx);
+		fprintf(out, " type_id=%u component_idx=%d%s",
+			t->type, btf_decl_tag(t)->component_idx,
+			btf_kflag(t) ? " kflag=1" : "");
 		break;
 	case BTF_KIND_LOC_PARAM: {
 		struct btf_loc_param *p = btf_loc_param(t);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 5c84723cf254..3bed3a28c06a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -606,6 +606,38 @@ static void test_btf_add_btf_split()
 	btf__free(base);
 }
 
+static void test_btf_attrs(void)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_struct(btf, "s", 4);
+	btf__add_field(btf, "f", 1, 0, 0);
+
+	btf__add_decl_tag(btf, "tag", 2, -1);
+	btf__add_decl_attr(btf, "tag", 2, -1);
+	btf__add_decl_attr(btf, "member_attr", 2, 0);
+	btf__add_type_tag(btf, "tag", 1);
+	btf__add_type_attr(btf, "tag", 1);
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 's' size=4 vlen=1\n"
+		"\t'f' type_id=1 bits_offset=0",
+		"[3] DECL_TAG 'tag' type_id=2 component_idx=-1",
+		"[4] DECL_TAG 'tag' type_id=2 component_idx=-1 kflag=1",
+		"[5] DECL_TAG 'member_attr' type_id=2 component_idx=0 kflag=1",
+		"[6] TYPE_TAG 'tag' type_id=1",
+		"[7] TYPE_TAG 'tag' type_id=1 kflag=1");
+
+	btf__free(btf);
+}
+
 void test_btf_write()
 {
 	if (test__start_subtest("btf_add"))
@@ -614,4 +646,6 @@ void test_btf_write()
 		test_btf_add_btf();
 	if (test__start_subtest("btf_add_btf_split"))
 		test_btf_add_btf_split();
+	if (test__start_subtest("btf_attrs"))
+		test_btf_attrs();
 }
-- 
2.50.1

