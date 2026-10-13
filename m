Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EB3B5835
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879662; cv=none; b=SvXnQ25LNkB8lNYyKb5yGXiYMb0Fuk63DVZ/YlVxWisvehdypCyS5+r4rVxjm0pIJkx0ft9+7P+9L2cR+6w0dY7EBXRNUKLlH5vUCjOwgIQZYN5a+gp9cpP/S0+a9WcNeOLHyEgIdU9WYExJ/RBo3XafTGuBqf1AHy34NBdRFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879662; c=relaxed/simple;
	bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxMCauiLQRU+OX/DUX+q+FzYPiQNwB5anrgLn87PIuH9dH6OUOvvHz3xZusqAYRHEj7LIigxcKvGZu+wcRH+6z/OPnBKOwDLnSP9ov0HW9V3UCi8Wdg0C/denvJNTk61aEGy9CHhCu5YjF0YYzzLIjHAbU4fEA6UZfDQPC/3Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR9ujdjW; arc=none smtp.client-ip=74.125.231.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR9ujdjW"
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-820ff812cd8so996649a34.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879660; x=1792484460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=lR9ujdjWZFr6e6lP4k+Et0uKxna66g0Yv5ZEyidQTyJ5W4iDkbh3CSsIGWKhSIJoGx
         TmshUaEXV/kk0/i6gebBDdFw8DYyBOhDFIWD/qAO35Q/Jz0vtBzqRNHMFJncBIHkzTVn
         6tAh2frtNKgmS/FkHCUxpGQV+od1wqFoF7IRSVr8JAlp7ovuwTyBEKNTE5ztJpktfqvD
         +PdlWPFpX+BrrACIP4XXg3Bs8uVr54PL4B+3H+cSTHOCcUkfQRxJZtkHeY58CoJJP72+
         U7NZnkY8NwhgZwv026txPA1Snl21IJx2y7zdy7cHL5K1mCkuGJrM9KnZlqjK9MO+eozn
         RZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879660; x=1792484460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=mhtoxVUzuj5a/gSwYsNrAQapnPkxINblgkvVmaXj4iRRCAxNticDg1Jeqf6dsRBt7G
         zA7dLSqy+HnM/bEgIakgXd7DWRSfKIILOeEwTHHVFMLxaE6l6LFcgAe/0AZpspOvkMkv
         fyChVSlR5XLqhigaZ9C47bYcUCWXO82MHSCi1i1P1S8BUj+Wh9PNySZiEg7aEI6+LTEQ
         ug6rgp7vwretwRiQ+oAPf2RpK8g+SzQzaWuPZqW68iisrl4RP2hV8jF+4Da1vLz6V2zn
         nBKZGBqPLDmR8VBVew8ERkdAJiCfOwmt8G1DVEwgJy93G/jIj7fE50q18AU8HcvmqBt0
         Cr1g==
X-Gm-Message-State: AFq9FYKLotDLlpY0n86DvTjqK+TevLyCAF6Y5BzMgmfKsRz2nMlH0RCr
	bSlyQ0HHQTdlrSOx/aL/4+FwsLToX/HrY3MlJGnNnxCfmcOdKHc9aZ+qR4aQD8DhOMQ=
X-Gm-Gg: AYBFou0z4y2+mHymFPfNfeGgYi3A8JYT0kAnCxsEh0Y2D8CiWbjq1bevyEG7m2TGNA4
	yr7kf5TAspinf4SqcxmopBcHkrVWqm37wD+5auzH0SrVs4C1G2jhSAjn8z3nFDKSR/aBmGyM6os
	zbdWFOfSef+7LcCsnVvj9F+rlL7JY8QnXWX5s6xwmFOKY1bX/IK/ikJvcaO6/P/XQZGSaev9exN
	t7xjy8mRR6YGc2ZRZok8DLSiprstF0MJzD+x5/4+yv7AyQ3+DCJA2FiITkID39lhNHwFdYC9r0o
	VxQLQRxcUpqwpMWfIzmx56h6xhHzfqIIu4CewJiMTTuYHkCZDIMzStrM+04eXxDok8z+svqTbWx
	KMTHM6mH0lPmOsAaeIDmbVPn8pxntEp9EjQkFLjNhcFkV62igc1bGbKaQyltCASTK8BKBRTcVKb
	2/SgJMyhF1sBlQkabpvzNu/41SFL38OSRuxRpRVCdmkA3EXa98pLCjgG9+O3GT7q5PBncGvAA+H
	zgnI0y8dZW3VETKu/+R/Hzg+l+HY4MR7/CeHC2ayXL6c60TzoGHnJIKT+PTRFgTgN350k+aNnnm
	Zw2t
X-Received: by 2002:a05:6830:2b0d:b0:812:c5fe:5e4e with SMTP id 46e09a7af769-83097e68102mr11955292a34.19.1791879660199;
        Tue, 13 Oct 2026 01:21:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9cb0sm12227191a34.4.2026.10.13.01.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 12/13] selftests/bpf: Test the address space rendering of the arena type tag
Date: Tue, 13 Oct 2026 10:20:07 +0200
Message-ID: <20261013082012.1107446-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; h=from:subject; bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy/l9mRs05zWmbNZ2e2O53dK48EPqFdNp7hc3qAZ+XLz1 269tHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIlFCG/zXX2p12sNX5Hj9bbcG/le FW9ZWlqqF3pUJmP1nokvtf1Inhr1yp4y79ScXN6ybE77x6JDD8d9Hfoh8FBZa3rqemi9vYsQAA
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

