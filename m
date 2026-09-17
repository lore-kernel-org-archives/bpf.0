Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73AD36AB46
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608070; cv=none; b=LUUiOa9maS4KGEpWwHLW+8brfrcSO80P/8doqe02Z+n3ewoh+rZoptlIUX8oZTpCfKj4iOrBum2E/ZlcUpakf7w2KFn1OAeojdZNPiaFTqjWIncByW8P79FXUEIFlwtRtRDT9dHDUtLjwcGpYhokFhLOvoPMFn5GqIUtYGz6P0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608070; c=relaxed/simple;
	bh=fLZMF/OdIboKk9rANyKEffq/LtgShX5PLHlTbGI1bzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ilt8Fh6X2XVfgwk2wAAR+poEFvGNucCSyzdVSXsIHTClGDrjk1QIrkFJ0cKRRIFlY7jevmnsbmv94q4J8p5TFGmibc7gDZwb/tgtadQ4u25/Czu+miY0t+ypfsuNYqmbDpnn4fB0Yh9OgosPKb6zOs+hoFxIIst6NdVTIT9gEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wt3xLd1j; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wt3xLd1j"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fLZMF/OdIboKk9rANyKEffq/LtgShX5PLHlTbGI1bzs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789608065; v=1; x=1790212865;
 b=wt3xLd1jUA3hnLzLs/JzkOTjb6HycbP7RuYWwRMm1JFsPS+ElpiBPUKmjZl+oje1Ms/rIoNz
 fjie/IwK+rs4hYJpi3b75PobFMbn5QOIRdY1cCgzF+lMD/kQ915RJ/DlQjiTeMLX76gBggovgOG
 MZCAqZ7eUFa4tk2tQqsdn/+c=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e4257e3bd888e3f0;
	Thu, 17 Sep 2026 01:21:05 +0000
X-Mizu-Trace-ID: e4257e3bd888e3f0
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Show the tag kflag in the raw BTF dump helper
Date: Wed, 16 Sep 2026 18:20:37 -0700
Message-ID: <20260917012037.1396254-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
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
---
 tools/testing/selftests/bpf/btf_helpers.c     | 10 +++-
 .../selftests/bpf/prog_tests/btf_write.c      | 60 +++++++++++++++++++
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 1c1c2c26690a..6956dffb4f56 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -111,9 +111,12 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
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
 
@@ -200,8 +203,9 @@ int fprintf_btf_type_raw(FILE *out, const struct btf *btf, __u32 id)
 		fprintf(out, " size=%u", t->size);
 		break;
 	case BTF_KIND_DECL_TAG:
-		fprintf(out, " type_id=%u component_idx=%d",
-			t->type, btf_decl_tag(t)->component_idx);
+		fprintf(out, " type_id=%u component_idx=%d%s",
+			t->type, btf_decl_tag(t)->component_idx,
+			btf_kflag(t) ? " kflag=1" : "");
 		break;
 	default:
 		break;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 5c84723cf254..7ddda9348e4f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -606,6 +606,64 @@ static void test_btf_add_btf_split()
 	btf__free(base);
 }
 
+static void test_btf_attrs(void)
+{
+	const struct btf_type *t;
+	struct btf *btf;
+	int id;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return;
+
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "int_id");
+
+	id = btf__add_struct(btf, "s", 4);
+	ASSERT_EQ(id, 2, "struct_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "field_ok");
+
+	id = btf__add_decl_tag(btf, "tag", 2, -1);
+	ASSERT_EQ(id, 3, "decl_tag_id");
+	t = btf__type_by_id(btf, 3);
+	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "decl_tag_kind");
+	ASSERT_EQ(btf_kflag(t), 0, "decl_tag_kflag");
+
+	id = btf__add_decl_attr(btf, "tag", 2, -1);
+	ASSERT_EQ(id, 4, "decl_attr_id");
+	t = btf__type_by_id(btf, 4);
+	ASSERT_EQ(btf_kind(t), BTF_KIND_DECL_TAG, "decl_attr_kind");
+	ASSERT_EQ(btf_kflag(t), 1, "decl_attr_kflag");
+	ASSERT_EQ(t->type, 2, "decl_attr_type");
+	ASSERT_EQ(btf_decl_tag(t)->component_idx, -1, "decl_attr_component_idx");
+
+	id = btf__add_decl_attr(btf, "member_attr", 2, 0);
+	ASSERT_EQ(id, 5, "member_attr_id");
+	ASSERT_EQ(btf_decl_tag(btf__type_by_id(btf, 5))->component_idx, 0,
+		  "member_attr_component_idx");
+
+	id = btf__add_type_tag(btf, "tag", 1);
+	ASSERT_EQ(id, 6, "type_tag_id");
+	ASSERT_EQ(btf_kflag(btf__type_by_id(btf, 6)), 0, "type_tag_kflag");
+
+	id = btf__add_type_attr(btf, "tag", 1);
+	ASSERT_EQ(id, 7, "type_attr_id");
+	ASSERT_EQ(btf_kflag(btf__type_by_id(btf, 7)), 1, "type_attr_kflag");
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
@@ -614,4 +672,6 @@ void test_btf_write()
 		test_btf_add_btf();
 	if (test__start_subtest("btf_add_btf_split"))
 		test_btf_add_btf_split();
+	if (test__start_subtest("btf_attrs"))
+		test_btf_attrs();
 }
-- 
2.55.0

