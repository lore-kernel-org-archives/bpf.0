Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0864445ACD
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107737; cv=none; b=dE77JlCGdfZsek2Us6d4xosij/T5kB1D0JoXzRNjKLasLkfnnfMWiDz4r0bSYzbRBPN55EiNzcenzFFBTYJujIu69lvcVRsSBh+ppUIMHi9vawIIHsls6vx3vwTbeIYRYstGTuT5iL9PWgU1DmfGjLIXTyiXxU4tnZjcZ+mHw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107737; c=relaxed/simple;
	bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hh8eEvmTVRJY24GYNoF9WaMOE4iqwrxKakC7K0NGJOxljSjHjfC4iChFAg/ZsxfXDA86mjP+uLoihkKI1AISNqx4QneuUTw4JsifKaiQdtF/wiX7GsO/4l/UenfVxWUYI4Pz0NrGCabu9T28O6D2lqryDRyyy1OHZO89YuuW7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSZbqoe0; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSZbqoe0"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4a24c19feacso1049683fac.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107734; x=1792712534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=LSZbqoe0jQ44UUJErGjGmRuSI+2LHJC2gjAyPuk/bPjP9l3fL7qD450uCcV0baMqk1
         kYd8vosdAsKisqkCgqsfKjPv8o5U1PpX0dNZ47ppQYpWbu/QyKVfHqQWYJBMvwGg1k2A
         YlAYFsbL2H6mAxOpWpLbfVbz099WZofSsvRX3gbAfGJVH31iMrqa8lvT570uR08b5i7G
         98qyU1PFUnj7ORQhdxW7oPXH2lWzM4ueeYDoUyvBwhZQJHXf4IBmqcoDoKY7HmUUpxjo
         yAzkncU64c3QPQVJemXuhSf7+jOsiV0uVkyze+FUkM0uPKvXWCbrgS+HmfFVPC16+rDn
         zsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107734; x=1792712534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r4uxcpqzoCYXzxkPycLMto70rE8ihdCaQWlgESJLQYs=;
        b=JsmV1xygFiWH7tU5QwQTbXFljfenv8llOSUCo628c34anQdvFKG+92lbRDjqWIXwn+
         kpXhuEehyOeP0obphrBkgmOW/BmKHCk8CmO9FcTXr3Csa0A0kaZ81WKMJ4HRRlQcwJtc
         y2Zd2/tYrRsevRhzBS/SxxqbkM4jg57U8WXetUUNmofLGzapSV80JVCwzPusxCPGgj0/
         xKYaI8tM1Px2Os5hWFRk4eDS3YawqhezLyB+4y84u5ZQBpL4xb5iMyAv7ZEidU75FeAz
         B9eswX1f5+Lwm1s9iBor3bPPyOfk7Jjny2LAFhTYz94ZXM/4UKJk5GvOgQOl/+DAyBd7
         y2Dw==
X-Gm-Message-State: AFq9FYI+EF5SRhhotnildzu4/3AQZmV+E3w6dMUh6DEH1aNL3EjMZApl
	9FInEZhzvo4SgDShdQb3+o6djB7uVZ6HBpM4GLa/M35W69UiDXMrYvgXQPXo38VV3l4=
X-Gm-Gg: AYBFou3qv+e2DnUenoh4O7nC06P5BtjE9gSkO68gA/b8JX6v7/QW/iQstIc5BCkNU4c
	ozRO8GcomCHSuhm1y7JXBoMAcRoz4w5pZloCLRMb5uUC9yFlWltB5PDpJdZTygQ2oypj7PAdYE8
	zXzbqpGp/d3V2ofUbjRuMquuSMrYmLTuDl7BlSwCch9Oggfk9VfQ8t1RQTaNOX3PawQ5Cjc8rkc
	fneb5whZ3MJy/I6CANTrSYY0LyZgsGBetS4LX94ELxIxz+So/gXNxEaNHis2urvdjwZAVbIPKTn
	LLBj3KDO+1hSZrlhdpTtq75vXRcYc3i7xO4jiXrhKJ7dLVfSg1OZT7Mr1iXI3WbaAymy6qAvTFG
	DPq0c0/Nyg0RR/w4HS/Y3EHbsNqbf0ClCWJ1w6WhvUN6nQmmP+fhXMPH4/+P/O2ZlEVn0GFmkU6
	YS5dUrDMr7vQ8qxpxfKtE5IHwl8eEipWecvBjZWbtAU8NiZsdCKvfG3PCvhS1Ex3p6FrEhJ+Yin
	qCJux0kf69sAdlemiBqSzgw9VeTOr6j7u6Bds017YfSq6xQA9JTsnFWD4x7ocrvWf73FVKrNgo+
	Z4ZaoA==
X-Received: by 2002:a05:6870:8244:b0:493:d7c8:c71f with SMTP id 586e51a60fabf-4a2a8a8c543mr16581889fac.27.1792107734580;
        Thu, 15 Oct 2026 16:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b7e2cd4sm347696fac.18.2026.10.15.16.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 14/15] selftests/bpf: Test the address space rendering of the arena type tag
Date: Fri, 16 Oct 2026 01:41:20 +0200
Message-ID: <20261015234125.3152346-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3254; h=from:subject; bh=Jc5EEPQ/8zXWI2/X55Hrp9kfIhkmanjQX6X2dPaQiFo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Ju+zA2a8xpTNmu7vbHcbmlc+CH1iuk094sbVAM/Lt76 7de2jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE5g8jw7L4jjLGn/a+qxynZJ/8f0 Gz18/z6IUn6d80z+xQYrjc842R4a3L49gNtf9Nzz5YJqTvd1qq7Oo5c7XJx7rvSr0SvFo4iwkA
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

