Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B14F4CE8
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416175; cv=none; b=Gn+8EmTXW4H9LrUnMLVdrO71u0kNJhn3bBdJq4ETi2qLUn3oWSb4uLUEqm4kzrLs7Qen2BJDGZdI1W16qgKBZwFpKJkb4+vXgwuUm9UQ6y+Hx5JnFpRsoKzw6E+7Y6o16b+hpnRX1WKwdtelenYB02LeB+QjkQQKQ/mHER+bPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416175; c=relaxed/simple;
	bh=MjVlsS67ogCYGtQh0quK89bo1+H9rlJHIjszXdfjJKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqLH3biCvAfjcyuendXUhGfbcKwlTl21t6+E5dAyazDQ53rVliG8j9WOQDa3GhQ/bd9OsiDiEeR14jLcmIGcjLVakbzOe58nbPfNez0lbXIrNF+dbCuK3J8l9cUSQn3ZrEfyxAkprX2cCWorufZI9aFFKD3RFJt7HL7hDrQoX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbPlhpcx; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbPlhpcx"
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-7041a4d7108so672679eaf.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416173; x=1793020973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fa84feS2jAGyKmyjjQIHpyrgjwO+euWJsFjV2K0lZro=;
        b=WbPlhpcxSb0o4VVhFediDqlWeHuWWlSRMoNjyYBc6Xaw/wlFk6Qnd2eBrRvWXJ9Mex
         n778mNJilGWYx1rdJCaYr2679KvmIWRtB8eiYq9Y8+c8KuXs0/yFIB727nWvmFhxrxbk
         ShuPB56qmB9h5YCbufqVFuHwh0/+aC4h3e24IlNq6ov3dPyBGPbnPc13VnjDhlLvvqrW
         klMEgRqRK+Ol1lUZK4vc+WB8aeFbJj7RGbIKTmgHfOF65jaQzmyxD1PaioogPmqk6IHl
         IbhLc9RAxH3L4G+bMaBcC0bmNiOK74cS5Yqjjk/GarQIqlBzJbPa7sgO8Os6ioylKf7M
         ozkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416173; x=1793020973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fa84feS2jAGyKmyjjQIHpyrgjwO+euWJsFjV2K0lZro=;
        b=RNFo2i1/WSxgHUeqoZqMcSJgqUKzFAzJ+peU2KiTC6oaLaIpc9hY41BeaqiW4tc9JF
         KG7j9eY0N6IcOWFo8tVs6yPLAAElEvUFMY8ze5XLE87xJUuhqvko6po3DGmxZbXqskBy
         KMmt7aVN7yEhb/6ai3PDbZzdnV6kq+W75mut6/L0JZly+5Td1mXheziAyCR2wyrfZU3W
         1eDaTaDwdRRft6vOzuWi0WZbhwKoGM3lGB1foWotw+y6lonmfVpDiSmsqr1ZilztEZkU
         HA6f4DdFLy5zuFvTr7z2xFGTnaPbfC/BtHLQPblrTAOWQ4mWanU/zjm0V5lDTRAswudd
         GNEQ==
X-Gm-Message-State: AFq9FYIRObmZJ8dud0IJNnmc76bai6qmtJrQlNkIlEPLxCBSAZXhA5zy
	LGnH0xuvcA+2C/BocRoPsrpUkgyHVi3q4cWggxNitn2XVmqhpg1lyQVR7aoSuppckFU=
X-Gm-Gg: AYBFou1W44jzp1gl0Mk0fegyW2s5JEWhY/wetzebMmsUb0TD/ooFsulqAoJEj8w2UmR
	t60yOX1zIggArfaoWp5HGufpeiuiooYmyRUJlJE+Hq8xdokY9ViofyD5pW18KYmwkOPYGAFs67K
	eF9ybXCXavyfE4I9lImgritaS9YBZpFLhBWlr33S7BfdAh5t+0Ta61ssTQcnOPoMGoFbscyqzCL
	JF/g0UYSlvpBwb5vlF3atcmaV63CDv3LX6rZvyimXzlQwEuVxoOeWVACncQQYyiZdvByGp4PBaO
	6iF18VsnEXQQzszmJDe0Jl3xVA94JiUMKtnUvo9tN7AS5xgmBVhXgfNDncMP2A5e+BFUr7/rUbH
	FW4BGQ4ITMooj44oAxq6A5MCVOCEnwf9ULU4b9C4K86mGFq9/5eIwOC6rDn/2q14AG7LGOnHQUl
	Cw+8Z4c46zQtnYSlDN6SKcaytCsBKddRRuELr6JFwzqRhFGaP7kSDUww7PJpSff3vATVVIlZIpS
	W7SN/rWWzXbvd8piFeANv6x9UTftYk2pHr94d3T+SmhA0aYzcFNsTx+jZP1AkLFgf0jmj5rvYDx
	bk8Cjg==
X-Received: by 2002:a05:6820:4de5:b0:702:3405:dd86 with SMTP id 006d021491bc7-70357a91937mr4396115eaf.74.1792416173022;
        Mon, 19 Oct 2026 06:22:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:11::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a53d8a52sm9306450a34.11.2026.10.19.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 15/16] selftests/bpf: Test the address space rendering of the arena type tag
Date: Mon, 19 Oct 2026 15:21:57 +0200
Message-ID: <20261019132203.3034698-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3287; h=from:subject; bh=MjVlsS67ogCYGtQh0quK89bo1+H9rlJHIjszXdfjJKY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxDH99SfrO2SlS4/diOIWKq1N4si2af35nadWccHjD+er 1lR3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJKJowMp9VLd+udmnd7A/vJM4Un30 2adF9boLKe45LZ4Zy4J7J1bgz/k1nlZ3nMmHQ6ZqHrwe13BE3mHlzrckEvSPJl+nQvjY/tDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an arena-tagged pointer member to the type tag dump test and expect
the address space attribute in front of the tag. The struct_ops test
that mirrors the previous rendering now describes it as the output of
an older libbpf.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/btf_dump.c  | 16 +++++++++++++---
 .../bpf/progs/struct_ops_arena_member_render.c   |  8 ++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 17fa44cb9c91..35f214e254da 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -604,8 +604,10 @@ static void test_btf_dump_type_tags(void)
 	 * struct s {
 	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
 	 *   void __attribute__((void_attr)) *p2;
+	 *   void __arena *p3;
 	 * };
 	 *
+	 * The arena tag is rendered with the address space it denotes.
 	 */
 
 	id = btf__add_type_tag(btf, "void_tag", 0);
@@ -618,17 +620,25 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 4, "void_ptr_id2");
 
-	id = btf__add_struct(btf, "s", 8);
-	ASSERT_EQ(id, 5, "struct_id");
+	id = btf__add_type_tag(btf, "arena", 0);
+	ASSERT_EQ(id, 5, "arena_tag_id");
+	id = btf__add_ptr(btf, id);
+	ASSERT_EQ(id, 6, "void_ptr_id3");
+
+	id = btf__add_struct(btf, "s", 24);
+	ASSERT_EQ(id, 7, "struct_id");
 	err = btf__add_field(btf, "p1", 2, 0, 0);
 	ASSERT_OK(err, "field_ok1");
-	err = btf__add_field(btf, "p2", 4, 0, 0);
+	err = btf__add_field(btf, "p2", 4, 64, 0);
 	ASSERT_OK(err, "field_ok2");
+	err = btf__add_field(btf, "p3", 6, 128, 0);
+	ASSERT_OK(err, "field_ok3");
 
 	test_ctx__dump_and_compare(&t,
 "struct s {\n"
 "	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
 "	void __attribute__((void_attr)) *p2;\n"
+"	void __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\"))) *p3;\n"
 "};\n\n", "dump_and_compare");
 
 	test_ctx__free(&t);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
index 23fc2b927793..09b4c740bdca 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -11,10 +11,10 @@
 char _license[] SEC("license") = "GPL";
 
 /*
- * The module types as vmlinux.h renders them: the tag is an attribute on a
- * pointer in the kernel address space, so the program has to cast the member
- * to the arena address space before using it. That is what a program built
- * against vmlinux.h sees for a kernel struct with an __arena member.
+ * The module types as a vmlinux.h generated by a libbpf that does not render
+ * the arena tag with its address space shows them: an attribute on a pointer
+ * in the kernel address space, so the program has to cast the member to the
+ * arena address space before using it.
  */
 #define __arena_tag	__attribute__((btf_type_tag("arena")))
 #define __nullable_tag	__attribute__((btf_type_tag("nullable")))
-- 
2.53.0-Meta

