Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C424336D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108858; cv=none; b=sUEUmP45mP8XCKy7B6EFQO7Rz8vshw/oYP2l17Pa1P1HC0huHDkoQHyBdh9g1q2nYc4mi3C3mJ+bJYe0+c764kJ+wvdUzkEJk1M2KvZh44V/sI4XTNyFPXaFQlgQ7mRXDxbVWcON9N/X/T3wGgmwaAA9vK8mVN5ZiAbK2dga1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108858; c=relaxed/simple;
	bh=G2+IUDy8673k/kbHpMQY5gxm/ffx9qGTVTzH4ALcoWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeQIExVdi8UwEx93OEpL/2GOa85xx4U27+/6TQ6K2sXcRnLEDQJ08/tjQVZqHck9rAgPeSproeuJl7UR3+IPfptB29UWsP5zqUtpG3UCyjBj0OE/j+MjfbzH7/7vPqQUNIXOAItuAbim+a0c4gXqvQvPXcLniHkId2iVMWSA5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JeAioSIx; arc=none smtp.client-ip=95.215.58.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JeAioSIx"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=G2+IUDy8673k/kbHpMQY5gxm/ffx9qGTVTzH4ALcoWA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108854; v=1; x=1792713654;
 b=JeAioSIxCCf3l2zNaCh1a5ifWM9LsiOOUHZGY8A48Md18Sdx7L4KeRlAWkVx3NjKudcsRU5m
 BWI0A6q+vFmu5e2zMwJVaBGIjTP+p91uiuC2EWg7luRYml6QuLmIwB7sd8vNsXnUVD8er8UtmnJ
 muJRpwMARTrB+8Tkmw5JKhe0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 2df58a9dde94a004;
	Fri, 16 Oct 2026 00:00:54 +0000
X-Mizu-Trace-ID: 2df58a9dde94a004
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
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v1 5/8] bpftool: Emit __bpf_core_pso on verifier-rewritten context types
Date: Thu, 15 Oct 2026 17:00:09 -0700
Message-ID: <20261016000012.2232059-6-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier translates accesses to some UAPI context and socket types
into accesses to kernel structures. These accesses require an
unmodified base and an immediate field offset.

Leaving preserve_access_index off does not stop the compiler from
merging loads at different field offsets into one load through an
adjusted pointer. The verifier rejects the resulting program.

preserve_static_offset, available since Clang 18, preserves static
field offsets in load and store instruction immediates. Apply it to
the 13 types that need static offsets through __bpf_core_pso.

Eduard introduced PSO in Clang and proposed annotating BPF context
types in 2023 [1]. His v3 RFC [2] left pt_regs annotations in
architecture headers unresolved. However since commit de6c7d99f898
("bpf: Relax fixed offset check for PTR_TO_CTX"), program types without
convert_ctx_access() accept fixed offsets from modified context
pointers. pt_regs can now keep PAI, while PSO on bpf_perf_event_data
covers its regs member.

PSO creates no CO-RE relocations, so BPF_NO_PRESERVE_ACCESS_INDEX does
not disable it.

Clang 18 through 23 crash on __builtin_preserve_field_info over a PSO
record, including bpf_core_field_*() and the CO-RE bitfield helpers.
-D__bpf_core_pso= can disable PSO for affected programs.

[1]: https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
[2]: https://lore.kernel.org/bpf/20231220133411.22978-1-eddyz87@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/bpftool/btf.c                          | 16 ++++++++++++++--
 .../bpf/bpftool_btf_dump_sorted.expected         |  8 ++++++++
 .../bpf/bpftool_btf_dump_unsorted.expected       |  8 ++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 30f30314ec29..fff2ea0a5c7e 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1203,12 +1203,17 @@ static int btf_c_annotate_records(struct btf *btf)
 
 	for (i = 1; i < cnt; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *attr;
 
 		if (!btf_is_composite(t))
 			continue;
-		if (test_bit(i, no_pai))
+		if (!test_bit(i, no_pai))
+			attr = "__bpf_core_pai";
+		else if (btf_c_needs_static_offset(btf, t))
+			attr = "__bpf_core_pso";
+		else
 			continue;
-		err = btf__add_decl_attr(btf, "__bpf_core_pai", i, -1);
+		err = btf__add_decl_attr(btf, attr, i, -1);
 		if (err < 0)
 			goto out;
 	}
@@ -1251,6 +1256,13 @@ static int dump_btf_c(const struct btf *btf,
 	printf("#define __bpf_core_pai\n");
 	printf("#endif\n");
 	printf("#endif\n\n");
+	printf("#ifndef __bpf_core_pso\n");
+	printf("#if __has_attribute(preserve_static_offset)\n");
+	printf("#define __bpf_core_pso preserve_static_offset\n");
+	printf("#else\n");
+	printf("#define __bpf_core_pso\n");
+	printf("#endif\n");
+	printf("#endif\n\n");
 	printf("#ifndef __ksym\n");
 	printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
 	printf("#endif\n\n");
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
index 02c8fe8b4859..7da4df1da207 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_core_pso
+#if __has_attribute(preserve_static_offset)
+#define __bpf_core_pso preserve_static_offset
+#else
+#define __bpf_core_pso
+#endif
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
diff --git a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
index 9b6589d2bda3..f082da51d630 100644
--- a/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
+++ b/tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
@@ -9,6 +9,14 @@
 #endif
 #endif
 
+#ifndef __bpf_core_pso
+#if __has_attribute(preserve_static_offset)
+#define __bpf_core_pso preserve_static_offset
+#else
+#define __bpf_core_pso
+#endif
+#endif
+
 #ifndef __ksym
 #define __ksym __attribute__((section(".ksyms")))
 #endif
-- 
2.56.0

