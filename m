Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901566;
	b=sgYkCZZhfSGSqL5rbAV0AIu0Y0Zjg8RfuNl/klqqyasyO8EV7v+/h8G04Y9HQmdKcIyz
	 2QRIjCwLyUh7t08Fn+h2taS8BH4SU3NThPHA4XBBRzk/i8/Z2xYmMf2VVmEzfc2E9iEdw
	 o3s9U0sODCVwis5uuvPEAgEPnc9EuCo5/IvjQ7MVbMvIfaOEfQErIXAWbNBMYnLijtReD
	 Y5kbPhATFxTU9WIUH0usM4cwcQlVFnJNrUS/xg5bgwgxvFB49MCWhLZk23WOIPQ1VTD23
	 LcLSEYuWv8I5A39gPl4dJXbFC0fTbeX9A5ifd9C0c+0GZkTzN/MFLqzmEczYUSR5pfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901566;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E+raqM/4V1WHQq2iTjQxhY0ypQqDl24WA6fWAf2kWUU=;
	b=4Lv/+s0s5lj4S0lEqvCMOn1xwgappiS28BHkmL0oWFqkrotioK2AcMIviwE2szk0E8nL
	 0wr9/oZsn5d5GGq97GKm4U2QhzN2k8YliTvAloBXl3sYX9TQwF1YjewzgZu+Ghr0LrzM6
	 WGO+6WGi+kn0RZtuvjb5HBE4KES+byg7HbpBXkAH+oOVFQuqpa40vsm0S9ggcJwARnQyL
	 a1aFDCVuKab6GFvEdHb2snXMTuv2GX7CxJUkGxMkRj19K2ILOzMm2UZ0LWzTAwTh6ZaxR
	 1sTuGG5ZXydURhr+MsBccspbQ/lJv5HPsS5y4MTVAFV6bP5fwlDbbFLj2fMr5jKNF2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Bu1jz+mB;
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3769606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3769606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Bu1jz+mB
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PhiFCrUvXOQTfn/Mz4WQQoPcM9CG2c7diXYGMJzui5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901563; v=1; x=1794506363;
 b=Bu1jz+mBDR5dqMRWvzuz52nOgNJr2f8HUNA9DGxtlcKYDohUHx6IWZPIZvjGzU9L32/3mAox
 SuQjxEBM6z+CVXkJb+3ehgjNPBae1JSQvRX/mIfV6koieS5KmKuTNL0h7K3Jge5jnQR/SKG2wUP
 qtCRfaK1ozrUacXR6PRnKySM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5615fc889fdfe2ac;
	Thu, 05 Nov 2026 17:59:23 +0000
X-Mizu-Trace-ID: 5615fc889fdfe2ac
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
Subject: [PATCH bpf-next v4 01/17] Revert "libbpf: Render the arena type tag with its address space"
Date: Thu,  5 Nov 2026 10:58:29 -0700
Message-ID: <20261105175845.30357-2-ihor.solodrai@linux.dev>
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

This reverts commit 7418d9291c57ea563b5fa706dea0883effe5d295.
This reverts commit 31ef8ab6dfc7152e4b64bcae19a3e07b10dd8fea.

The commit made btf_dump print the plain "arena" type tag as
__attribute__((address_space(1))) followed by the tag, special-casing
one tag name in the generic renderer. How a kernel type tag is spelled
in a generated header is up to the tool that generates it, so render
every plain type tag the same way again.

No libbpf release contains the reverted change. libbpf v1.8.0 is
synced up to commit acff58e30517 ("libbpf: Fix cleanup on invalid
CO-RE relocation offsets").

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

Later in this series bpftool spells "arena" as __bpf_arena in the
generated vmlinux.h, through decl tags in its own split BTF.
---
 tools/lib/bpf/btf_dump.c                         |  3 ---
 .../testing/selftests/bpf/prog_tests/btf_dump.c  | 16 +++-------------
 .../bpf/progs/struct_ops_arena_member_render.c   |  8 ++++----
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ea9a34db4c00..ad43bbd3b442 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1595,9 +1595,6 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
 				btf_dump_printf(d, " __attribute__((%s))", name);
-			else if (strcmp(name, "arena") == 0)
-				/* the tag denotes a pointer into the BPF arena address space */
-				btf_dump_printf(d, " __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))");
 			else
 				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index dbef014f75ac..5a5ee001ac8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -604,10 +604,8 @@ static void test_btf_dump_type_tags(void)
 	 * struct s {
 	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
 	 *   void __attribute__((void_attr)) *p2;
-	 *   void __arena *p3;
 	 * };
 	 *
-	 * The arena tag is rendered with the address space it denotes.
 	 */
 
 	id = btf__add_type_tag(btf, "void_tag", 0);
@@ -620,25 +618,17 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 4, "void_ptr_id2");
 
-	id = btf__add_type_tag(btf, "arena", 0);
-	ASSERT_EQ(id, 5, "arena_tag_id");
-	id = btf__add_ptr(btf, id);
-	ASSERT_EQ(id, 6, "void_ptr_id3");
-
-	id = btf__add_struct(btf, "s", 24);
-	ASSERT_EQ(id, 7, "struct_id");
+	id = btf__add_struct(btf, "s", 8);
+	ASSERT_EQ(id, 5, "struct_id");
 	err = btf__add_field(btf, "p1", 2, 0, 0);
 	ASSERT_OK(err, "field_ok1");
-	err = btf__add_field(btf, "p2", 4, 64, 0);
+	err = btf__add_field(btf, "p2", 4, 0, 0);
 	ASSERT_OK(err, "field_ok2");
-	err = btf__add_field(btf, "p3", 6, 128, 0);
-	ASSERT_OK(err, "field_ok3");
 
 	test_ctx__dump_and_compare(&t,
 "struct s {\n"
 "	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
 "	void __attribute__((void_attr)) *p2;\n"
-"	void __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\"))) *p3;\n"
 "};\n\n", "dump_and_compare");
 
 	test_ctx__free(&t);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
index c4e134e14f87..253ffdd86d32 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -11,10 +11,10 @@
 char _license[] SEC("license") = "GPL";
 
 /*
- * The module types as a vmlinux.h generated by a libbpf that does not render
- * the arena tag with its address space shows them: an attribute on a pointer
- * in the kernel address space, so the program has to cast the member to the
- * arena address space before using it.
+ * The module types as vmlinux.h renders them: the tag is an attribute on a
+ * pointer in the kernel address space, so the program has to cast the member
+ * to the arena address space before using it. That is what a program built
+ * against vmlinux.h sees for a kernel struct with an __arena member.
  */
 #define __arena_tag	__attribute__((btf_type_tag("arena")))
 #define __nullable_tag	__attribute__((btf_type_tag("nullable")))
-- 
2.56.0

