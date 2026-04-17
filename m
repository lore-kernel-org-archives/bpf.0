Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97843AA4E4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414810; cv=none; b=HUBD+7oeaWLRRGrmVRxF6HjvxSRZsaHQwh0LTiEaVAV+hb7Fe/kqLZDL1Fkf/aCrt0AbuVhobiKQq8GfKJIt4exN7DWKG6vbsRccngcgLjCPpe+X5eVscXEMCmPJm8aXsQtFVZI9zhQeHQX/HwJuCJxsFjKra6IF5faiU21OL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414810; c=relaxed/simple;
	bh=tro7p1fxGtfztjIPDcoX3PawG8nL9YMnYcebcUHHzMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCHDtTQF9BrfYIp8jn7kutMtdNSKW9Gi57SzJxJXr0yEizOz5+d1gIrLXZ6aiUbNQs3wGbneEIqOeofc/J4bUUmmZ8EqmhVpwy4M5UA3gaGtukA0rZarU9qK14wxigCYMP++QWW0Z4Wak+YcOcz0rwCmzs9skOchfiaODoil6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eutFUJI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eutFUJI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D85C19425;
	Fri, 17 Apr 2026 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776414810;
	bh=tro7p1fxGtfztjIPDcoX3PawG8nL9YMnYcebcUHHzMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eutFUJI7Ff4z9GFi3dl9WI8zhLQ9KVoRN51EPplh7GgnJFK772uZo83GXRAT0qMy+
	 sHLs5PLsg1dC77oZ3Y6Nk41WVDvQIFlf9FXIne9MMlFNbLvpeDY6iQGVSA49kQyyrP
	 lUu8VK0lw/FTCZ66TycVUbdQd4BkGC2xHi0viU150sussuJDNjkB2xOtLhZMVqr6Vf
	 UNZ97u3cbRWWBMq3YrKTFdJC3DmXxdG2ZJUf9Is2+jr8UTvNP/N9ks0p0JbQt86pkY
	 n2FO1Xn49aXqT4wKGd9K7laUYtTWejh/VcXwFB0T3GR8oCtbMJvQ1fe76JdUdpamIA
	 vgmAUFiNSsn4g==
From: Antoine Tenart <atenart@kernel.org>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: Antoine Tenart <atenart@kernel.org>,
	bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: ensure typedef are deduplicated in split BTF
Date: Fri, 17 Apr 2026 10:33:18 +0200
Message-ID: <20260417083319.32716-2-atenart@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417083319.32716-1-atenart@kernel.org>
References: <20260417083319.32716-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a typedef is defined both in a base and in a split BTF, after
deduplication a single instance should be found in the base BTF.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Since v1:
- Added this patch.

 .../bpf/prog_tests/btf_dedup_split.c          | 48 ++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 5bc15bb6b7ce..0db7707ae90d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -20,18 +20,22 @@ static void test_split_simple() {
 	btf__add_struct(btf1, "s1", 4);			/* [3] struct s1 { */
 	btf__add_field(btf1, "f1", 1, 0, 0);		/*      int f1; */
 							/* } */
+	btf__add_typedef(btf1, "t1", 1);		/* [4] typedef int */
 
 	VALIDATE_RAW_BTF(
 		btf1,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
 		"[2] PTR '(anon)' type_id=1",
 		"[3] STRUCT 's1' size=4 vlen=1\n"
-		"\t'f1' type_id=1 bits_offset=0");
+		"\t'f1' type_id=1 bits_offset=0",
+		"[4] TYPEDEF 't1' type_id=1");
 
 	ASSERT_STREQ(btf_type_c_dump(btf1), "\
 struct s1 {\n\
 	int f1;\n\
-};\n\n", "c_dump");
+};\n\
+\n\
+typedef int t1;\n\n", "c_dump");
 
 	btf2 = btf__new_empty_split(btf1);
 	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
@@ -49,39 +53,46 @@ struct s1 {\n\
 	ASSERT_EQ(btf_is_int(t), true, "int_kind");
 	ASSERT_STREQ(btf__str_by_offset(btf2, t->name_off), "int", "int_name");
 
-	btf__add_struct(btf2, "s2", 16);		/* [4] struct s2 {	*/
-	btf__add_field(btf2, "f1", 6, 0, 0);		/*      struct s1 f1;	*/
-	btf__add_field(btf2, "f2", 5, 32, 0);		/*      int f2;		*/
+	btf__add_struct(btf2, "s2", 16);		/* [5] struct s2 {	*/
+	btf__add_field(btf2, "f1", 7, 0, 0);		/*      struct s1 f1;	*/
+	btf__add_field(btf2, "f2", 6, 32, 0);		/*      int f2;		*/
 	btf__add_field(btf2, "f3", 2, 64, 0);		/*      int *f3;	*/
 							/* } */
 
 	/* duplicated int */
-	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [5] int */
+	btf__add_int(btf2, "int", 4, BTF_INT_SIGNED);	/* [6] int */
 
 	/* duplicated struct s1 */
-	btf__add_struct(btf2, "s1", 4);			/* [6] struct s1 { */
-	btf__add_field(btf2, "f1", 5, 0, 0);		/*      int f1; */
+	btf__add_struct(btf2, "s1", 4);			/* [7] struct s1 { */
+	btf__add_field(btf2, "f1", 6, 0, 0);		/*      int f1; */
 							/* } */
 
+	/* duplicated typedef t1 */
+	btf__add_typedef(btf2, "t1", 6);		/* [8] typedef int */
+
 	VALIDATE_RAW_BTF(
 		btf2,
 		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
 		"[2] PTR '(anon)' type_id=1",
 		"[3] STRUCT 's1' size=4 vlen=1\n"
 		"\t'f1' type_id=1 bits_offset=0",
-		"[4] STRUCT 's2' size=16 vlen=3\n"
-		"\t'f1' type_id=6 bits_offset=0\n"
-		"\t'f2' type_id=5 bits_offset=32\n"
+		"[4] TYPEDEF 't1' type_id=1",
+		"[5] STRUCT 's2' size=16 vlen=3\n"
+		"\t'f1' type_id=7 bits_offset=0\n"
+		"\t'f2' type_id=6 bits_offset=32\n"
 		"\t'f3' type_id=2 bits_offset=64",
-		"[5] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
-		"[6] STRUCT 's1' size=4 vlen=1\n"
-		"\t'f1' type_id=5 bits_offset=0");
+		"[6] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[7] STRUCT 's1' size=4 vlen=1\n"
+		"\t'f1' type_id=6 bits_offset=0",
+		"[8] TYPEDEF 't1' type_id=6");
 
 	ASSERT_STREQ(btf_type_c_dump(btf2), "\
 struct s1 {\n\
 	int f1;\n\
 };\n\
 \n\
+typedef int t1;\n\
+\n\
 struct s1___2 {\n\
 	int f1;\n\
 };\n\
@@ -90,7 +101,9 @@ struct s2 {\n\
 	struct s1___2 f1;\n\
 	int f2;\n\
 	int *f3;\n\
-};\n\n", "c_dump");
+};\n\
+\n\
+typedef int t1___2;\n\n", "c_dump");
 
 	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
@@ -102,7 +115,8 @@ struct s2 {\n\
 		"[2] PTR '(anon)' type_id=1",
 		"[3] STRUCT 's1' size=4 vlen=1\n"
 		"\t'f1' type_id=1 bits_offset=0",
-		"[4] STRUCT 's2' size=16 vlen=3\n"
+		"[4] TYPEDEF 't1' type_id=1",
+		"[5] STRUCT 's2' size=16 vlen=3\n"
 		"\t'f1' type_id=3 bits_offset=0\n"
 		"\t'f2' type_id=1 bits_offset=32\n"
 		"\t'f3' type_id=2 bits_offset=64");
@@ -112,6 +126,8 @@ struct s1 {\n\
 	int f1;\n\
 };\n\
 \n\
+typedef int t1;\n\
+\n\
 struct s2 {\n\
 	struct s1 f1;\n\
 	int f2;\n\
-- 
2.53.0

