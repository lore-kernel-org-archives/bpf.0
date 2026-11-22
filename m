Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795346952;
	b=hbsR0RbZHS+yRqC90q2OXKBAHngMbpAOWV2QWbnJaADNXc6FkJdsAw8Tu75gw6rTRmZP
	 EILYY8iFQ4uMGLawC/XCfpbKe4AXuUH93rUsvopbEMLfLMEWukKLpcmI3WD6zsi89UpO2
	 bD6De2iTPLNaX8ccKj6WwHq115lpVUlQTkBCvMscu+pk0s77ICIshWeSlmCAMGobALnWe
	 JToirDg33UtAY5ClWD8X5MPPcpSqg/S1odMMpMTvc5J0UFjqUEuZjXGjxj3mperj5NDFD
	 TjtaIDfXlEL4L65XiVqdkmdwPf+O0Wr23UryKZU1DTmdiGa5KkTDtPneNPVIGbQHIag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795346952;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r2E3AjrzdjT8sbFS2JSKFrk/TFYMjueoTuzNBj2umHQ=;
	b=1/B/rdfyqJ1OPkkyi5gIc1AEPjHhsnYgmER6giE9rZBFt43orLM7mbeyyY1aaN2kDCcs
	 /uHy2EWDdHSVAZELCAjOPdU5Ztvzv0VLi1xUAf2Z+YuvpuubNVdm+P65AerJGvT17biRP
	 v7bFPJI4sIFRJTta9A2ftfgwUqKmEKJ0jJgzQvi+y60+StFbJwS0VMal9c0ikKfuOtSWW
	 zsZxEw/iHUi66yS1koXr8+hvVmBII0Q3CHfhHGFw3ZrVg+LID1aUo6e+nCh473ABZEnmY
	 LjHzDVfxQUT2T+QXPPGQ8RaYTXHfYiGEJu5IUqCKIguvwjn2irWYcKZKYxPhKszywdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csgf3uf3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50A606A339;
	Sun, 22 Nov 2026 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Csgf3uf3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795346952;
	b=k+WlbJCxu9By9ILRdq6yCa/zXgd3mAh1GNlDFH+G6kRb9j4XgQcq5ZHFlP4zHFeSmv1x
	 3jGjOIXV+zT1Tbgpa/S53hiB1VL5dRtQMwht71kCAKMlwl60C8C2+UiUtppgzTF6B3jmT
	 wvxfCDIuVNMcXwtydap43bmAUKrfb2a3+0Ueq4legGsGkjaR8wMIE5lzJ07ZAa53uf3gn
	 DQnzYopmVj7FuUCyDbNaQ7j9GVI4dh4cJRIHZv9fioijT0HVCWR9L99GgEc8ESSv4CzhI
	 myzVtkJitQ+WjsmyHR4/FNQrBoD6/4F6ANvBzs9d9G9aTws4q7zkm//8Qjx6/W0c7sw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795346952;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r2E3AjrzdjT8sbFS2JSKFrk/TFYMjueoTuzNBj2umHQ=;
	b=njijVfE9jY/85Wdv1zaF6tIDp0QeCq3U6b6Y81Hj/P5kTEO4wTQsLsE9YFrJYup+9182
	 qSdo5gD62L/HVaEp9WW/+/a7DaXeNKlHoBMcnZZirhjekSfClyjzCA044JUyrNedH5ug4
	 rt9ZvmWTk1HTdGG9yKBHms6wGuGVy2YwJrAQrpivEka+cEJTQjKtUEidwJzpEIhAqvJuF
	 DBURnlTjXs0FAXDdDBFgip1GuemHJIe3SyqEErUcWJ2AZwEzERSMlZAX2lwCN4FYapY29
	 t4hJehhWQZ+Y169RM35sQHg0SeV71XbhnB5g8+JomF22EXNbVeNEx4Qq3oirkFRtWUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9599A1F000CA;
	Sun, 22 Nov 2026 11:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795346952;
	bh=r2E3AjrzdjT8sbFS2JSKFrk/TFYMjueoTuzNBj2umHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Csgf3uf3kTLCf4A8G1EPsSE9A4ciJ2rjEFIJ1k6o2kC+aHnUWn5RSt7Z473+EIRXp
	 68TR7wzZ1pY4RirEAZVzHpjqmUA+s13YSxHBjxE2Iin5Je+1Fnf9dr3H5K9H17nSrM
	 Jd/YVQQbQTZ7CPVmbBypAMBcl62dupPHLJ6CIr0FDrLGL6S4aHhx0YPfkgI52hQszN
	 YoOEnKBKuK0N3YbqKibq6O3mYlFl0Yh0jQbJa3wPEuaZfveq4jiUNvWGzFCl23JVPJ
	 nhKpAaIbudDCmuGw2Cjkx6ci8xvUMBoGz1Hebc5qZE+uzII/W8BkWS02drJd3Y+yqH
	 aVUxHrLVH6kUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1EE094C008;
	Sun, 22 Nov 2026 11:29:11 +0000 (UTC)
From: YanXin Li via B4 Relay <devnull+fadouse.pm.me@kernel.org>
Date: Sun, 22 Nov 2026 19:28:36 +0800
Subject: [PATCH bpf v3 2/2] selftests/bpf: test arena allocation after a
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
Message-Id: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-2-1f94ae9a884a@pm.me>
References: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me>
In-Reply-To: <20261122-b4-03-bpf-arena-vmalloc-oob-v3-da2dc21683c6-v3-0-1f94ae9a884a@pm.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795346949; l=4570;
 i=fadouse@pm.me; s=b4-relay-20261122; h=from:subject:message-id;
 bh=WJ8aXCi1+iUyH4McpRDagd4qctth2VlhQkByhvjsEx4=;
 b=d2jg2htmvcEYhnHVgmTFYiziolnJacK1EUNbDFp5ePWthNmxSwUK3aTzSNmvuP9/qR3hZqisr
 6AoBSizMJWND7MidFcTp26cBG38wFPvuFe5JFX9Tl431H7O57snQ7DJ
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
 .../testing/selftests/bpf/progs/arena_mmap_alloc.c | 32 +++++++++++++
 2 files changed, 85 insertions(+)

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
index 00000000000..3854afbebc4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_mmap_alloc.c
@@ -0,0 +1,32 @@
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
+	/* A successful allocation at offset zero can return a NULL pointer. */
+	bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
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


