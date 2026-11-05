Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901698;
	b=AW5NlH2mnqyRGvfDC3bMcegrmhPXsIRefc9azwKKDJdWjsS+Je0rzphkcTBh1wV2ALDc
	 tRfv48l9+LKX1y/+O365OhOH8JxHFdrPDhs9K5R7ZCrUKo8e0RruTEmuycSlVM1FUV5zJ
	 27CpeH3zDSlzpZP0P0kSbZmdwgC815IqPZxuh62N6ztI69SFuuXZQcsSGiW3ve7S5nuZg
	 bqOeUuEEH1uwv6aU68zC7EpEuC30+5romhZdJmGM4qEace9eM3i3IXtllsyOSBl2fcHTF
	 R5hGRLmafuotFCy74+5525gCTXN9cp+k+QMKfjCTDlki3eR+tLdA0cIlp5yuDvelkUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901698;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sqEUEcli8OB6SWq/5PaVdnfj8xHtNaRkRA7kSZ7Oob4=;
	b=PMBkOBRdj5RIpBkmmRPG346qwWiBjeLYmfCJ94leJinfo+HlfkISnay+LZA9IPd/8fot
	 dzmpEqWaVhEBsGinITXeVW5tHlnXD+jN/IJaohZLDDwMu8aRbjVuUQWBWEKvo+zk2ic6x
	 ZmiU1WOn5cbvIRV+TmRrq+eu41wZZk5iSlWgb21UmzaBkgbsovu8Ucx+nr+XZxv0mdsr5
	 BWZgZm4oCRDQD8P0IFEQ2MCBpABZxhqK9bzSvZPT/VdhGSOOc9XPKyLhaAlfq4AbX3tM9
	 /+MCsMQnVh5hbGCjipTyYE6wfjlZTPF887BTFBWl7tbt5K3aoTJ36HrYRxDTZxS/Acg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UBdLG8Mw;
	arc=none smtp.remote-ip=95.215.58.161
Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90F606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B90F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UBdLG8Mw
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kL+Hu0w+NgzE+OzVvJ7nDE0QHVuTSIWjZ4ZN4PXqMyM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901695; v=1; x=1794506495;
 b=UBdLG8MwImOFkv3EuiZ1cgd1CdJE89SgLt0KYsNeGUsoC+4B1PEcJd8UJBBpg10/4fDNf+zk
 HwLF0EnmUDMfH/nfY2Z14gTEpuN73NYQwsgilGghWzoYdRC/ynJsupMkOwsAAxw1SZQg2uQeVCa
 BHTcnKxAgIC+IkBOOJe6imN0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4cda5fb5e1a04436;
	Thu, 05 Nov 2026 18:01:35 +0000
X-Mizu-Trace-ID: 4cda5fb5e1a04436
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
Subject: [PATCH bpf-next v4 16/17] bpftool: Render the arena type tag as __bpf_arena
Date: Thu,  5 Nov 2026 10:58:44 -0700
Message-ID: <20261105175845.30357-17-ihor.solodrai@linux.dev>
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

Kernel structs shared with BPF programs mark pointers into a BPF arena
with __arena, which kernel BTF carries as a plain "arena" type tag
that the verifier relies on. btf_dump prints the tag as
__attribute__((btf_type_tag("arena"))) on a pointer in the default
address space, so a program built against vmlinux.h has to cast such a
pointer to the arena address space before using it.

Attach a kflagged decl tag to each "arena" type tag in the dump split,
so that btf_dump prints __bpf_arena instead. In the generated header:

  #define __bpf_arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))

So the program gets an arena pointer and its BTF keeps the tag the
kernel expects. Programs can pre-define the macro.

Use __bpf_arena to avoid conflicts with unguarded __arena definitions
in libarena and sched_ext headers.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst            | 6 ++++++
 tools/bpf/bpftool/btf.c                                    | 5 +++++
 .../testing/selftests/bpf/bpftool_btf_dump_sorted.expected | 4 ++++
 .../selftests/bpf/bpftool_btf_dump_unsorted.expected       | 4 ++++
 .../selftests/bpf/prog_tests/test_struct_ops_arena.c       | 2 +-
 .../selftests/bpf/progs/struct_ops_arena_member_render.c   | 7 +++----
 6 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index a3778f449d73..9fe035b80103 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -123,6 +123,12 @@ a type marked ``__bpf_static_offset``, including through ``bpf_core_field_*``
 and the CO-RE bitfield helpers. Compile with ``-D__bpf_static_offset=`` to
 use these helpers with an affected compiler.
 
+Pointers carrying the ``arena`` type tag in kernel BTF are rendered with
+``__bpf_arena``. This macro expands to
+``__attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))``,
+so programs can use the pointers without explicit casts. Define
+``__bpf_arena`` before including the header to override it.
+
 EXAMPLES
 ========
 **# bpftool btf dump id 1226**
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 1329745c5854..c06b01f2c5b3 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1103,6 +1103,8 @@ static const struct {
 } btf_c_type_tags[] = {
 	/* the arena attribute in older kernel BTF */
 	{ true, "address_space(1)", "__attribute__((address_space(1)))" },
+	/* __arena in include/linux/bpf_compiler_types.h */
+	{ false, "arena", "__bpf_arena" },
 };
 
 static int btf_c_annotate_type_tags(struct btf *btf)
@@ -1276,6 +1278,9 @@ static int dump_btf_c(struct btf *btf,
 	printf("#define __bpf_static_offset\n");
 	printf("#endif\n");
 	printf("#endif\n\n");
+	printf("#ifndef __bpf_arena\n");
+	printf("#define __bpf_arena __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))\n");
+	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
 	printf("#endif\n\n");
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 190cf16e49a2..0ecf53b29042 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -17,6 +17,10 @@
 #endif
 #endif
 
+#ifndef __bpf_arena
+#define __bpf_arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 1a0a7b016c50..24a8db96eab0 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -17,6 +17,10 @@
 #endif
 #endif
 
+#ifndef __bpf_arena
+#define __bpf_arena __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index e7580b9f0fc2..2e915b350cd2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -259,7 +259,7 @@ static void arena_autobind_excl(void)
 	struct_ops_arena_autobind__destroy(skel);
 }
 
-/* The same through the vmlinux.h rendering of the members, which takes casts. */
+/* The same through an older bpftool's vmlinux.h rendering of the members, which takes casts. */
 static void arena_member_render(void)
 {
 	struct struct_ops_arena_member_render *skel;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
index 253ffdd86d32..b6b66934266b 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -11,10 +11,9 @@
 char _license[] SEC("license") = "GPL";
 
 /*
- * The module types as vmlinux.h renders them: the tag is an attribute on a
- * pointer in the kernel address space, so the program has to cast the member
- * to the arena address space before using it. That is what a program built
- * against vmlinux.h sees for a kernel struct with an __arena member.
+ * The module types as an older bpftool renders them in vmlinux.h: the tag is
+ * an attribute on a pointer in the kernel address space, so the program has
+ * to cast the member to the arena address space before using it.
  */
 #define __arena_tag	__attribute__((btf_type_tag("arena")))
 #define __nullable_tag	__attribute__((btf_type_tag("nullable")))
-- 
2.56.0

