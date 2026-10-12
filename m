Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915C37B036
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812274; cv=none; b=VUNvOMWLTGTtrGH/n8S4qtv/pWCsuWGkgfrk9IHFFYMKTNiOSa3kpq3eHIaAvDvzOaPe6U8Zi1I/DilpAZTQFy00PDSyNQ3f0sfjLaPn/c7xMb4TeyT8YGre7FaA4dgtGU+gr2Uwde+yxiKHJaByLLqMX+0Qh62OS4aDxlbJfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812274; c=relaxed/simple;
	bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzG3rEwmTICdWhZlneKXdg8HGsPakG0sdeOFEu21twlKpovXFEwf9pEqsPfjMtPNznr4gagZq7GkEnMWOlU9Yr4boX3tQ3OP6wQ4JRxG4THG5F00iEk6tiYJuEWmQguVwRA2PHmjXsiMJ16HBUygtTqx+WhkySu29F6Hw7CyUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa1hN+mW; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa1hN+mW"
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6deba5f82ecso380730eaf.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812272; x=1792417072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=Aa1hN+mWvwbthBOwNHYWCS9qAAK/7q36EJHLU3apApbrVDhRwLjRvXATiDJTTS8YNw
         c7KltGP3QDQzWUptMiRWD8r7+Yap4D60Vdjs0i9ySqLJn562lz6uXg4M1Ec0wgv/dYke
         7VxPvB879cM48P0yVvXSrBu9qCb4d8AzqkJ3wYB1s5ERS8m0Pxp3cD9g8Lv5rG/8JVqC
         3hMQ+TJdhyXkkRl101iagRcNxpJoa/UrqBm0NqwN0vNPaEYLSoFIJ4WeHPAmPyOYCeyX
         pdv0rEBQI5JTq08tUZVT0AUPdsXJlwSbw9ZzTJZibgsFQ2q6H+vvvoBsHrjfaRxqwAJA
         HYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812272; x=1792417072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=eDmfT6Xg9Z+0L4DVadVPcQTOPf+MiY0J7TsnCq7UewXiKz8Nd4EA2lsouitS+cqeT6
         xqjm9yWmg62je2VebNMeB7Mmqg+HNOc1OsozkaeQC43c7GHMjyInO1nkaAixfCEl8WI3
         QHfMYXlZEOpEX92vSL7MaYt9LaqixXVNjx5GKjurifR5CYRt7RTZQAAdc84vn94Ok7TU
         z3+cXhacPP40bzSsdkFExrOpc8JhxkgKvKYEgTe2E1Ok5uHcJ9yJXbuynnAXoTxblnx3
         Ohn2LlWbDxx9+DqY87o+NZSnUX4Ek0vRhchNmoBL1u5blYf4kAlb8Q9KfsiGK7BAJe2C
         Xi5A==
X-Gm-Message-State: AFq9FYJbvTuYbZ7bo54E7T7l4lnGjwHynHM604hGUiFiaiiLr2yxwCHH
	9vC34tEQbFaR77BhdcXWYdJ3xRPMfAlS0gn5r5HBKEuPqv8gQXmEIXbELx4XFkWE7JM=
X-Gm-Gg: AYBFou26dTKpzKMAdkfWYXw0sE0i8/p/3okgx+lIzCtoHYmkGweMh6atfPpwDeCEXyj
	4co0TVAZGMpFYQC9TSZFApOyk4ZdMyd/cuvVelK8YD5gSOsJXKyHOvlB42VVgGroc4MSJWAIrxz
	iq/tA9AgyCnQyUfe9Wvg0GvqBAvZTJhnOPYOd3AiP9BpPEmAmIe/JtJLQ6vgD2inD/EfBYPrG5s
	hTbTZlaO/94Bwc+vA+UuBlZNZPoWG7IDMmhVrOBrpJtRHMY7MxFL2J1P2ev0HtOLRacXM3qyBWz
	VRu2wmh/CGePvTWzu/GvOKp7mJc+9wWUJ8zD7BdbVJM78XnLJn2LGnhQzYQhrkcIbEu3JfS+5Bt
	7V//VwUMkdzKxP+/w/qumkHDB7wDEgdkogi4mFho9/hYHyMOAbnZs4z6TZgF2dpolvffK5ehC36
	KBWEC1oQItnJZ+LM8j6C+5h8mlD6uoWSVXKmtAEyFOq2OKiFBzM8wZV3KQ6JxhHWptvP8xqT2/b
	4Agjxlxt2VsIvGymViQviHoK7O7WbKByuKYdKAirOxuvpt0d7PT7rahj604kXvtjzK77i5WU/08
	SYW38NM=
X-Received: by 2002:a05:6820:c2cf:10b0:6f6:55c5:3597 with SMTP id 006d021491bc7-6f655c5385amr1213270eaf.77.1791812271880;
        Mon, 12 Oct 2026 06:37:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f51138ea6fsm3273191eaf.6.2026.10.12.06.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 10/10] selftests/bpf: Test the address space rendering of the arena type tag
Date: Mon, 12 Oct 2026 15:37:07 +0200
Message-ID: <20261012133711.4030594-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; h=from:subject; bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7V9mRs05zWmbNZ2e2O53dK48EPqFdNp7hc3qAZ+XLz1 269tHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI7u0M/8uXzJY/ebNq5VIOyROT+t t7M+eI3d+SEBcruFjVuk6RYRsjw9L5DnePGTnL/bp9/kVK4hkPFcmUaRlFbRf3nYlUMXyfygwA
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
index 0a6b7c5f494b..58516fdc1351 100644
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
 struct bpf_testmod_arena_member_args {
 	__u64 __attribute__((btf_type_tag("arena"))) *ptr;
-- 
2.53.0-Meta

