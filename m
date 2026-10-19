Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A95449B12
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380307; cv=none; b=AsxlrEsPRl0Lf5O1XHziPEFx2c0HphhHnhM5OOazEI5NRA4+se7Io7szWsZ9U9Wu5NVc7urW0N/wcQwo6jBrjgM1Bp3IM3PuFPhgiskAX6geCvgv4Eohr4O9teUF5t3LkxLo7VjG5GZ59cC6TGR4E7IcoTzIwHKNnByRJr2K/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380307; c=relaxed/simple;
	bh=MjVlsS67ogCYGtQh0quK89bo1+H9rlJHIjszXdfjJKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR6Uo2wDmuDVx7RzB/EjXxyoeVvJL66OC+GZBgy3lBLMVzczT5gY5pJi75YkYNKVn3RbEVg28sCrDLturk69lwn4y0x1Q5kDcAjdkQgzOHdPyDlw27CemRj3viDHzVlTkpiv+5r5lp0W3geosHxjPcT8i1yaEUAktvxvszqwjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2VLKwJS; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2VLKwJS"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-703478630a2so1131106eaf.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380303; x=1792985103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fa84feS2jAGyKmyjjQIHpyrgjwO+euWJsFjV2K0lZro=;
        b=O2VLKwJSEwb0C0DGMSsXCd7Yct0MINE19BKGCcjVYxGlmGjBAgPrz0ZLmjYW8Dt+O/
         RGCSJDzJIcuHJ862tOoa8/T1RgRnPaUcLddfnFSl5RzfS7f7LHGrseRPkcuN0L9XwgsP
         qvXXTRuL4sf1rQUZaPRToToKRTeFVfLFMX/9Uv7SeAo8uS1Zo6hQeD2J2KJwK22GXDFA
         kehHyBPjrGdY3EUQveZVCwEHyxtRJURu+0lGEbMfheFpTLZaeEUi5J+ykYiVEVsTzOgM
         PTN9ZWzcRRzwYDZmBPMajAe4oRNngfYkYn30bSn5SillAuzUdChCeJumIcXVjzrt1XcK
         AhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380303; x=1792985103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fa84feS2jAGyKmyjjQIHpyrgjwO+euWJsFjV2K0lZro=;
        b=RqmGprSoqBDGJLH3dPzcxjEAoBIXye0EZPSIjLHPSkNrnOBLpKuQHw4RmPuoWMef4I
         G8U6LrnEt0lZWapavLmTtsjiEgMtyaFhSoGCw+m15rb1xLL3ovZQubV4IjEfQyr6SzT5
         zvob5kdOCJdy8FKi74qWfw4PA1XipGI84t3bXu30nOizbw6/Hj6bsLe8A8p8hqpvCJWA
         FO6Y2dNbAijc3lu0fiJ6IY37+iEMfuUx8zmzNr3qYq5rIN3GfIdE+xAUjaLBmRMZxHMs
         gcSCcU5qhllUvQXsot3WQGx5SXLMSV6+z44AIDfyDP5EbTN1nYr76uGrytCxtlcPvtiz
         g41w==
X-Gm-Message-State: AFq9FYKmQwS2wupTf0kaZG4u1tkYVkQTYd1A03nMIw7Jf/1LECTjEkEt
	6uj/gcaKYTd7VZC6iMa/K+ekZxsC3wOZN+I9GHHX1krB4NkTJscPjWViJp8KQmGus74=
X-Gm-Gg: AYBFou0CPtrAsdPsWdr/a6r45rQvk/1n7x5pAxqNgJeeUGcnuOhaRuNrQeYZcKw3Ok6
	tSofvoz8ifJeUCWGB919NT5QoLwwYdlL1cypkKSn1A8XUoG9MW5QCQEwZbQHIlVpTtUF0U04KDd
	Fh9VUC7/sj/jGEIn0GRIUWjGVQIafbzdmV1vO/r9rcrT33TbKKsWWIMHpFAVjZYw5bnvF2t8+6T
	xiivTUcDBG2Ag9mZaVN7xR+QoF8gtwja+t95CC1p6M+yAJcuB9PuhwSTXW8RFNysHBWXszZH3kQ
	KqfGdbqqjd6eM5F4jOQXqKYhgt52XMZ9j3+sbx819jaMS9D5lnestQ2WQeRJ/895/0/Z94Gyq8K
	rdQmGTF/e5mcfQXpGEkwUsDntL+YRKlkqHCLkJLK//QPhaiDYjYFJ8wf5/EA0LGQ26qlCQCS0ms
	7MP2mZU8lim/jLmG27rL+HWHS9utTR+6iJRggwBGumznO2QEfnZKFpc3lQgB433kXrxPP7K9DTk
	U3BpqkWoEXQBOLurmNjp8ilTCuCJi7ClnQiywzaIlMIpUjDNZ1dRufpYyauWoIQ7WaCZ6EvKrkp
	jlf6sg==
X-Received: by 2002:a05:6820:1ca7:b0:6dd:5306:d1a1 with SMTP id 006d021491bc7-70352297e25mr4862910eaf.3.1792380303557;
        Sun, 18 Oct 2026 20:25:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8438ce16e37sm8379958a34.13.2026.10.18.20.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:25:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 15/16] selftests/bpf: Test the address space rendering of the arena type tag
Date: Mon, 19 Oct 2026 05:23:55 +0200
Message-ID: <20261019032401.2302823-16-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3287; h=from:subject; bh=MjVlsS67ogCYGtQh0quK89bo1+H9rlJHIjszXdfjJKY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr57++pP1HbLSpcduRHELldYmcWTbtP78zlOruODxh/NV a6o7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMBGx1Qz/a18ue2uy9LXsK03V+dpfXb TUeVP7Mlxrw7ddDCoJXVo1k+Gv0EmRVe+uPJZjL/mk1LPwwc8/3ewFOooZ/LsORPeuebWWCwA=
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

