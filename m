Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795350982;
	b=csPT4eHNeK5l9yAim4XMpGLmT5xA8p6erTLbS7UMY7gSnzsWdE/LRDRR4xKn1EbLIJEG
	 MnpsSgcPLsW0eDBMHAxUShhZROmcadSoOKMlIP76CbexteGl3CulUoYn31ggIN27AnL0f
	 LwIIDEkZI3t5L3c0/ZENERdH+dDYx5NatuzvADXgKfwgyffsD4/fyVrwGnWvuiXQoEDer
	 PelVC/CyuUKXN8s3bA3VLDX21YGXVGFyRLnVsdcIhmyLPs6NZE+xnqKbWc02djdrNrFDV
	 PfaYhnb78IE5UgS/SgZ7fsAzh5fPGmdCOYT564s7RI25jX3uLn9n7mQIfM9JWTKivpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795350982;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FfDO0f0KQSC409TsDN1PUSGBpdCVQz7p/HXZoa5TnKk=;
	b=wzZyCpcWdATPlQOY9zR2+HQj1bC8oxq3uXN/UNNresF+TjtzcUN4DPaku4BRyfSCIBXH
	 hOULy7hxzV8McHljaXecmp7gQKndB1fO9eVUcCR7ixBT6fVR7NF021dWycbniSAjGpLuu
	 n/C7tTe4vXHNfHRE6+tFeROuk6Jrtydt7y635dezp9gtBent3eguMGsj2ILotsj4M0e9+
	 s3k5lIWgSTyihS+lAlCf1rUq1QMT8Gz3ZGqr8TVMzrWI6JwHGfKQxL/MCO7MQ3cXTkhzQ
	 d2S5Ye/IRGmQHt/kb1IVNtXAL3BOwjKeHaWMNuTNJjnQxhh01vvZxlMDjN5651KPSxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWiCJGp4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DC606A331;
	Sun, 22 Nov 2026 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWiCJGp4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795350982;
	b=UdInRKuZy4DUluSrE1AtQVBuqfMH4qjUTQzmWegj4PbnHDhI4z9UEhZPpssWYeVNAwQy
	 pCh8XAHEUfkmuOIGIbl30YFI01KplJJiIgUW2wy8pehYpOujgngLdxpmfLeJ1xgfNGpxW
	 eezjPgUMyYzYaWnGso5it/eBcyt29MwYB7er1a2xCzUI9HpgC9hWNO9RsRrUJJe4zEVUo
	 n6ypqio+aSe3VKtgNkSA1iBBoTP7oaHudEAiLBzz4AgLM9jkIy2f7UFraOdQzgzbCdxGN
	 hd/2BAMrkUNAVn9ZMbiBla/hO6teIHUDes1IpLAguuPWNfosOCHFqZZ1cIQzEVCpIjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795350982;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FfDO0f0KQSC409TsDN1PUSGBpdCVQz7p/HXZoa5TnKk=;
	b=nEe2aqcTAVjJr4Flam5TLFjezct/UB5n439LyED6g8ZxrD5cVNN+iA9JJeUtc+BqXwzq
	 /BXtqOhydCUWxrnQf6g6gsyHnr73LrC0rTAyAakyngV4BWwHo7Wzi6JUnMQeG+54wwSuN
	 3XItPhGbIPHquAXjod6abqW2JTJj3p/5iudk7gWI+MPJxXkjx3l3ng5OKg2dvPvMIwJf2
	 FQwfxhg7NSlOb5zYeCGbfK6Uqx1Ox/DNwvNcFGNlmaw/qLHh99wck6cPQh1tOed4BTLT6
	 N2FQnuvg4RsreX33XYwtkbuz+zl0v8ZzYHgnDqi+lKwOF8vXAIIRvOfV96dFJp/4sdQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F1191F000CA;
	Sun, 22 Nov 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795350982;
	bh=FfDO0f0KQSC409TsDN1PUSGBpdCVQz7p/HXZoa5TnKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mWiCJGp4ZRzmH3YDFJyOy/blOIV3y9S6ztuAoHfIzN1fDeoJdJWghGAmydNeHFPch
	 6FLI9JwM5J6NuLMjV1efvPt9AOsgU6044R49mPkpj8r4D68STX6x/6Ym/ZSGjGy60o
	 v5Mp3OYVM9Bd7g/bOwjjaPE8fLHW3t0nECQYomYmHaaMWS9zW4OnYvsVEHXWRaCrk9
	 880F1fa3U5vsKO7O7nxVjZt+PESKC8XM6mEijnm1oklDfYRXar4cNT9uPlcDNZ8C6z
	 eW+N2ghEC4YaZjQx2VWzkWxjf4i2kTRr5nwhzl44hgpoON++YGDEalRfdAUELjRsvi
	 Dclffx3P7cyFQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 27E474C039;
	Sun, 22 Nov 2026 12:36:12 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 20:35:37 +0800
Subject: [PATCH bpf v4 2/2] selftests/bpf: test arena allocation after a
 short mmap
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-2-d542d1233623@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-0-d542d1233623@pm.me>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v4-8090cdc58ff8-v4-0-d542d1233623@pm.me>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795350970; l=4531;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=12pf/DDajqKWIUwZFygjYQjcysYQ35Yyf+7SvH1neXs=;
 b=fVfGRrZf0kiKVP2LKGaSIX/uR/eyOguX6/Qmruahgzv2FWL+SHwDe4d7mI/D2Pf/18F5CgN/J
 G8bWfg5VzBsDTJzawjXmrA6TQfeTyYdeFbs5rhQYyFXRAxCyCH7uFj4
X-Developer-Key: i=fadouse@pm.me; a=ed25519;
 pk=b4DyzHJDRd8853IHUSKPA5wwzChj8eF4MTnZuyPz1PQ=
X-Endpoint-Received: by B4 Relay for fadouse@pm.me/b4-relay-20261122 with
 auth_id=1597
X-Original-From: YanXin Li <fadouse@pm.me>
Reply-To: fadouse@pm.me
Content-Transfer-Encoding: 7bit

From: YanXin Li <fadouse@pm.me>

Without map_extra, the first mmap of an arena can be shorter than the
map's max_entries. Automatic allocations must stay within that VMA.

Create an eight-page arena and mmap only four pages before loading a BPF
program. Reuse the map FD so libbpf does not mmap the full arena. The
program occupies offset zero and allocates two more pages, leaving one
page within the VMA. A two-page request must fail, and a final one-page
request must succeed. Before the preceding fix, the two-page request
succeeds outside the VMA.

When JIT is disabled, arena map creation can succeed while loading a
program that uses the map returns -EOPNOTSUPP. Skip the subtest in that
case.

Signed-off-by: YanXin Li <fadouse@pm.me>
---
 .../testing/selftests/bpf/prog_tests/arena_mmap.c  | 53 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_mmap_alloc.c | 33 ++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
index f55d950720f..ff1fe0a6f22 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_mmap.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include <sys/mman.h>
+#include "arena_mmap_alloc.skel.h"
 
 #define ARENA_PAGES 8
 
@@ -34,6 +35,56 @@ static void test_refused(__u64 map_extra, __u64 addr, int pages, int flags, int
 	close(fd);
 }
 
+static void test_short_mmap_alloc(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts, .map_flags = BPF_F_MMAPABLE);
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts);
+	struct arena_mmap_alloc *skel = NULL;
+	size_t size = 4 * getpagesize();
+	void *area;
+	int fd, err;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena", 0, 0,
+			    ARENA_PAGES, &map_opts);
+	if (fd == -EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_GE(fd, 0, "bpf_map_create"))
+		return;
+
+	/* The short mapping must be the first mmap() of this arena. */
+	area = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (!ASSERT_NEQ(area, MAP_FAILED, "short_mmap"))
+		goto out_close;
+
+	/* Reuse the map so libbpf does not mmap all ARENA_PAGES on load. */
+	skel = arena_mmap_alloc__open();
+	if (!ASSERT_OK_PTR(skel, "arena_mmap_alloc__open"))
+		goto out_unmap;
+	err = bpf_map__reuse_fd(skel->maps.arena, fd);
+	if (!ASSERT_OK(err, "reuse_arena_fd"))
+		goto out_destroy;
+	err = arena_mmap_alloc__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out_destroy;
+	}
+	if (!ASSERT_OK(err, "arena_mmap_alloc__load"))
+		goto out_destroy;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.alloc_beyond_vma),
+				     &run_opts);
+	if (ASSERT_OK(err, "alloc_beyond_vma"))
+		ASSERT_OK(run_opts.retval, "alloc_beyond_vma_retval");
+
+out_destroy:
+	arena_mmap_alloc__destroy(skel);
+out_unmap:
+	munmap(area, size);
+out_close:
+	close(fd);
+}
+
 void serial_test_arena_mmap(void)
 {
 	__u64 page = getpagesize(), last = -(ARENA_PAGES * page);
@@ -50,4 +101,6 @@ void serial_test_arena_mmap(void)
 		test_refused(0, -page, ARENA_PAGES, MAP_FIXED, 0);
 	if (test__start_subtest("map_extra_last_pages"))
 		test_refused(last, last, ARENA_PAGES, MAP_FIXED, 0);
+	if (test__start_subtest("short_mmap_alloc"))
+		test_short_mmap_alloc();
 }
diff --git a/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c b/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c
new file mode 100644
index 00000000000..9c46a393eae
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 8);
+} arena SEC(".maps");
+
+SEC("syscall")
+int alloc_beyond_vma(void *ctx)
+{
+	void __arena *page;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page)
+		return 4;
+	page = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+	/* Only one of the four mmap()ed pages remains available. */
+	page = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (page)
+		return 2;
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	return page ? 0 : 3;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
Git-157)


