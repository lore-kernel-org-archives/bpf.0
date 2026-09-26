Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D03A9627
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465738; cv=none; b=O6Rm3mrV/OZlHAsS9Q0qIiRJvDKrfNkHXpa8VxXCZ+XggIQ2FODSxF/SP3gq9vLEv0tc/zRn3WDCPXAAYAcMN40CeQwDPFCXTPc458XlHUo5+IpiQmdXL5/k74VOFzh1dIZcIwNyGU/pg2/9AC2irh64c85l2dZewbbGIlirIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465738; c=relaxed/simple;
	bh=izyu816hEm6aBwMSZbeohjzP4SZZ1loYS4E/LucrD48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AohbsgbA7Agbfi9XUuh7JtOypZRDwKIiUb6Wk5io1PresMuD+y4k00zduFAzyivd98bwKXGCpgrUlhso1ueGB1bftASzdTsH5VCstRylx+IZnwM3ie+dhn/Y203huC9mCmMtfpYP2R/q+E3El/n5eO/SpFF4uz8ZD5FzC/JyJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCcC3Aly; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCcC3Aly"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-485ac0c75b9so859366f8f.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465734; x=1791070534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IN5sCbZhY09FYsAWejqOVFgTJE+UzDl7C5wFY5MxvGc=;
        b=UCcC3AlyfL6z1uXtaf6evo1IX18ViHhuyRCSZK2DqyZ0VkDipNZd8RuhIP1dsSzEuW
         BOqXiYf0Qut/VCq4O4Uv9bVW7ItSOSAvkUrBAIaMU2uc/9RSHBTDKPUCvy+bm5Ly1jkL
         xikZJpBPHxgqaxhdZNSmRr05KSBTpdZ4QUW6r/5McXRM63mdq83LBV00+Xs6mc6dzdkw
         d9/77P/SH/omfPAi7h3fi5Cr9yEgEmcfvgVeV7O7tfVjfrE5+CXB8aj4tpc7kKY+iCs0
         ylPicL/Jy+dpbk0oOsLpj3J9HNgEo0inhDYvNP1FDroCHPKr3wZqbY1Hl0+5Rgr/kDAf
         hXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465734; x=1791070534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IN5sCbZhY09FYsAWejqOVFgTJE+UzDl7C5wFY5MxvGc=;
        b=NapWzXur/47T7kYzk4536tOtiXmjSb1vnJcX7stym2uBPDmazTO42gLr8gSV9MpkLS
         tfhw5pEGgG+MwyfVeZ1FXoHR30BXVx+4efKPGFwPJb3y4MU4NBTF+THBFzF/M6AlzXYV
         WZK8ux9LCqbHmF45sqj5xb0Ivxcrav88iM7Zxe9Rfr9yvPKJeyrpnyHZST1NniRHdYZX
         Pz3K8ZBCqrZBSz/w2ixstj/91lVe5p8lwLO0Krn0GShy/sYRPZWujrggfSWvcWlgTZZ+
         xhQDtHMRV8mYO/7DKTnyimibSXVti7uCmc75YWiVKr+zJatvHLdOSirne+iSwoQdrNhz
         0xTA==
X-Gm-Message-State: AFq9FYIVeDorUGJDzC28cJUp+frofXP2eRUpkx9fHr6IRgtIgLe5pcrQ
	9IAZhxyt+V0Cg+GFecPrJrlAtn/FcjaW+xuRyqr3qBML6h9nl0QCRsSn0j+62GRR
X-Gm-Gg: AYBFou0/Nv+/zhW5HGHaVqRq6F5WjG/BPzVJcOvq5Ab/i3ZTeKOsszuLefyEJyO0r13
	UDsSmD2slYx1fXhI4EYqt9PoXBfXgWQo0EQttOHUIXGU9ZN6DTdE92f+I1Waebh+IywNnWF0Bla
	8AFOVjlYscfCS7mpMuLd647uzGml2qUbl9tnwzh+FCccwAULEYz5GJgx4GM7/euACqDMRG0fqQd
	Hm/nGmrWVrcLm3EG6XcgKqJuf5Ymw/R/+izRgZtj77zghixBn4KZdR0lGKHFKFtf5aHt0nxCd0U
	tC9oLB88mMcZZTW276oqpV7waebh0PsSoghSnaTtwdOjh3z1uWne4cT3MhEoMDMnsbY95a+hRg4
	AVpDJDyECwcH5AOQxfP1VicSf3jlbXVtczmClIW4BxNxTW8BoW1U58KSspYOycJIH1IWUJQOORH
	dHQKVgwOGRdE8d8zUVb/YN+5XUjW8ofgqD/mvBEPzCwVCoKDQt726xbqspDWoL4PY7Jch1QkH7/
	Dv7gFhyTIuaHCc6FrECfb+bgspdq+dLNtSp6KpX9XFdfqhF/Yktn/sC8A3tRTQmtrDgpWzBVF3N
	nUlrqUW24Gfyf0aCDuhGWdOQGTKW8V6p1BEvrQ==
X-Received: by 2002:a5d:5e83:0:b0:488:84bf:eedf with SMTP id ffacd0b85a97d-48884bff147mr5768439f8f.48.1790465733453;
        Sat, 26 Sep 2026 16:35:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm16783370f8f.36.2026.09.26.16.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:33 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 16/16] selftests/bpf: Exercise typed arenas at run time
Date: Sun, 27 Sep 2026 01:34:54 +0200
Message-ID: <20260926233503.3114147-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25809; i=memxor@gmail.com; h=from:subject; bh=izyu816hEm6aBwMSZbeohjzP4SZZ1loYS4E/LucrD48=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWKL85o2TTLievtz5bG3MvBDpxqJpvHv+9oqduvNub 1HyhIQtHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhI2G6Gf0oHjQy2nJFg8/op 6zgx4FYfS6GKn+GzGds0JDh8v5hsqWD4Hza1J+XkpL//Bab8SOAW3iP/iCdkdy6/3qlnmj6Wnuk uTAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Drive typed arenas from user space through a skeleton. Check that
registration at load is accounted in the map's memory usage, that an
allocated chunk adds its pages to it and a released one takes them away,
that a value written through one invocation is read by another, and that a
chunk is refused to a fixed request while it is taken. Leave a reference to
the test module's object in a kptr field, release the chunk, and poll the
object's reference count until the deferred release has dropped it, which
proves the grace period and the field teardown ran; then claim the same
chunk again and see it come back zeroed. Read an object nobody allocated and
see the dummy object, see the chunk it faulted in refused to the allocator,
release it, and poll until it can be claimed. Load the same object twice on
one arena map and check that the two program BTFs get distinct typed arenas
for the same struct.

Release the pages of one allocation one at a time and see them all come
back, since the worker walks every span of a batch. Fill a typed arena, ask
to release one page more than it holds past the address, and see the request
refused while a release of the last chunk alone goes through. Release a
chunk twice, the second time while the worker is waiting out the grace
period of the first, claim the chunk again as soon as it is free, and see an
object written to it survive the repeated request. Allocate more pages in
one request than the allocator's batch holds and see the whole range served
and returned. Allocate an object of two pages with a request for one and see
the whole object granted, both pages usable, and the chunk returned.

Carve objects out of an allocated page, link them into a list through a
typed pointer field and walk it with no cast: the sum of the values only
reads, a second pass writes through every pointer, and the NULL that ends
the list, dereferenced on purpose, reads object 0 of the slice.

User space hands objects around as opaque 64-bit values; converting one to
a typed pointer casts it, and any value casts to an object, so a small
offset names one as well as a pointer does. Programs that only convert
values they hold reference the arena map explicitly, since that is what
associates the arena with a program. The tests need a compiler that emits
the cast and are skipped otherwise.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/typed_arena.c    | 489 ++++++++++++++++++
 .../testing/selftests/bpf/progs/typed_arena.c | 354 +++++++++++++
 2 files changed, 843 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/typed_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/typed_arena.c

diff --git a/tools/testing/selftests/bpf/prog_tests/typed_arena.c b/tools/testing/selftests/bpf/prog_tests/typed_arena.c
new file mode 100644
index 000000000000..8fcb6bb6a51f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/typed_arena.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/user.h>
+#ifndef PAGE_SIZE /* on some archs it comes in sys/user.h */
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
+#include "typed_arena.skel.h"
+
+/* The sizes progs/typed_arena.c declares */
+#define OBJ_ARENA_SIZE (256 * 1024)
+#define WIDE_ARENA_SIZE (8 * 1024 * 1024)
+#define BIG_OBJ_SIZE 8192
+#define LIST_LEN 64
+
+/* The map's memory usage as the "memlock:" line of its fdinfo. */
+static long map_memlock(int map_fd)
+{
+	char path[64], line[128];
+	long memlock = -1;
+	FILE *f;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", map_fd);
+	f = fopen(path, "r");
+	if (!ASSERT_OK_PTR(f, "open_fdinfo"))
+		return -1;
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "memlock:\t%ld", &memlock) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_NEQ(memlock, -1, "parse_memlock");
+	return memlock;
+}
+
+static int run_ret(struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+
+	if (!ASSERT_OK(err, name))
+		return -1;
+	return opts.retval;
+}
+
+static int run(struct bpf_program *prog, const char *name)
+{
+	int ret = run_ret(prog, name);
+
+	if (!ASSERT_OK(ret, name))
+		return -1;
+	return 0;
+}
+
+/* Poll the module object's reference count until a deferred release has run. */
+static long wait_ref_cnt(struct typed_arena *skel, long want)
+{
+	int i;
+
+	for (i = 0; i < 500; i++) {
+		if (run(skel->progs.read_ref_cnt, "read_ref_cnt"))
+			return -1;
+		if (skel->bss->ref_cnt == want)
+			break;
+		usleep(10000);
+	}
+	return skel->bss->ref_cnt;
+}
+
+/* Poll the map's memory usage until it reaches the expected value. */
+static long wait_memlock(int map_fd, long want)
+{
+	long memlock = -1;
+	int i;
+
+	for (i = 0; i < 500; i++) {
+		memlock = map_memlock(map_fd);
+		if (memlock == want)
+			break;
+		usleep(10000);
+	}
+	return memlock;
+}
+
+/* Poll a fixed allocation until the release of the chunk it names has run. */
+static int wait_alloc_at(struct typed_arena *skel)
+{
+	int i, ret = -1;
+
+	for (i = 0; i < 500; i++) {
+		ret = run_ret(skel->progs.alloc_at, "alloc_at");
+		if (ret <= 0)
+			break;
+		usleep(10000);
+	}
+	return ret;
+}
+
+/* Objects persist across invocations, and chunks come and go around them. */
+static void test_pages(void)
+{
+	long ps = PAGE_SIZE, base, base_cnt;
+	struct typed_arena *skel;
+	void *p;
+	int fd;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+
+	/* Registration at load accounts the page tables and the scratch chunks. */
+	base = map_memlock(fd);
+	ASSERT_GE(base, ps, "registered");
+	if (run(skel->progs.read_ref_cnt, "base_ref_cnt"))
+		goto out;
+	base_cnt = skel->bss->ref_cnt;
+
+	if (run(skel->progs.alloc, "alloc"))
+		goto out;
+	ASSERT_EQ(skel->data->page_cnt, 1, "granted");
+	p = skel->bss->ptr;
+	ASSERT_EQ(map_memlock(fd), base + ps, "after_alloc");
+
+	skel->bss->value = 42;
+	if (run(skel->progs.write_value, "write_value"))
+		goto out;
+	skel->bss->value = 0;
+	if (run(skel->progs.read_value, "read_value"))
+		goto out;
+	ASSERT_EQ(skel->bss->value, 42, "persisted");
+
+	/* The chunk is taken until released. */
+	ASSERT_EQ(run_ret(skel->progs.alloc_at, "alloc_at"), 1, "taken");
+
+	if (run(skel->progs.stash_ref, "stash_ref"))
+		goto out;
+	ASSERT_EQ(wait_ref_cnt(skel, base_cnt + 1), base_cnt + 1, "ref_stashed");
+
+	/* Release drops the reference after the grace period and returns the memory. */
+	if (run(skel->progs.free_pages, "free_pages"))
+		goto out;
+	ASSERT_EQ(wait_ref_cnt(skel, base_cnt), base_cnt, "ref_dropped");
+	ASSERT_EQ(map_memlock(fd), base, "after_free");
+
+	/* The same chunk can be claimed again, and comes back zeroed. */
+	ASSERT_EQ(wait_alloc_at(skel), 0, "reclaimed");
+	ASSERT_EQ(skel->bss->ptr, p, "same_object");
+	if (run(skel->progs.read_value, "read_fresh"))
+		goto out;
+	ASSERT_EQ(skel->bss->value, 0, "fresh");
+	if (run(skel->progs.free_pages, "free_again"))
+		goto out;
+
+	/*
+	 * An object nobody allocated reads as the dummy object, and the chunk
+	 * it faults in is taken until released in turn. Any value casts to an
+	 * object, so a small offset names one as well as a pointer does.
+	 */
+	skel->bss->ptr = (void *)(7 * ps);
+	skel->bss->value = 1;
+	if (run(skel->progs.read_value, "read_unallocated"))
+		goto out;
+	ASSERT_EQ(skel->bss->value, 0, "dummy");
+	ASSERT_EQ(run_ret(skel->progs.alloc_at, "alloc_scratch_chunk"), 1, "scratch_taken");
+	if (run(skel->progs.free_pages, "free_scratch_chunk"))
+		goto out;
+	ASSERT_EQ(wait_alloc_at(skel), 0, "scratch_released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/*
+ * A typed arena belongs to the program BTF that registered it. Two loads of
+ * the same object sharing one arena map carry two BTF objects, so a pointer
+ * of one names an object in a different typed arena when the other casts it.
+ */
+static void test_identity(void)
+{
+	struct typed_arena *skel1, *skel2 = NULL;
+
+	skel1 = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel1, "open_load1"))
+		return;
+	skel2 = typed_arena__open();
+	if (!ASSERT_OK_PTR(skel2, "open2"))
+		goto out;
+	if (!ASSERT_OK(bpf_map__reuse_fd(skel2->maps.arena, bpf_map__fd(skel1->maps.arena)),
+		       "reuse_fd"))
+		goto out;
+	if (!ASSERT_OK(typed_arena__load(skel2), "load2"))
+		goto out;
+
+	if (run(skel1->progs.alloc, "alloc1"))
+		goto out;
+	skel1->bss->value = 7;
+	if (run(skel1->progs.write_value, "write1"))
+		goto out;
+	skel2->bss->ptr = skel1->bss->ptr;
+	if (run(skel2->progs.read_value, "read2"))
+		goto out;
+	ASSERT_EQ(skel2->bss->value, 0, "distinct_typed_arena");
+	if (run(skel1->progs.read_value, "read1"))
+		goto out;
+	ASSERT_EQ(skel1->bss->value, 7, "own_typed_arena");
+out:
+	typed_arena__destroy(skel2);
+	typed_arena__destroy(skel1);
+}
+
+/* Every span of a batch of releases is processed, not only the first one with real pages. */
+static void test_release_spans(void)
+{
+	struct typed_arena *skel;
+	long ps = PAGE_SIZE, base;
+	void *p;
+	int fd, i;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+	base = map_memlock(fd);
+
+	skel->data->page_cnt = 8;
+	if (run(skel->progs.alloc, "alloc"))
+		goto out;
+	ASSERT_EQ(skel->data->page_cnt, 8, "granted");
+	p = skel->bss->ptr;
+	ASSERT_EQ(map_memlock(fd), base + 8 * ps, "after_alloc");
+
+	/* Release the pages one at a time, so that the worker sees a span per page. */
+	skel->data->page_cnt = 1;
+	for (i = 0; i < 8; i++) {
+		skel->bss->ptr = p + i * ps;
+		if (run(skel->progs.free_pages, "free_pages"))
+			goto out;
+	}
+	ASSERT_EQ(wait_memlock(fd, base), base, "all_released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/* A release of more pages than the typed arena holds past the address is refused. */
+static void test_release_bounds(void)
+{
+	long ps = PAGE_SIZE, base, nr = OBJ_ARENA_SIZE / PAGE_SIZE;
+	struct typed_arena *skel;
+	int fd;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+	base = map_memlock(fd);
+
+	/* Fill the typed arena, so that a scan of its bitmap for a free chunk runs to the end. */
+	skel->bss->ptr = NULL;
+	skel->data->page_cnt = nr;
+	if (run(skel->progs.alloc_at, "fill"))
+		goto out;
+	ASSERT_EQ(map_memlock(fd), base + nr * ps, "full");
+
+	skel->data->page_cnt = nr + 1;
+	if (run(skel->progs.free_pages, "free_oversized"))
+		goto out;
+
+	/*
+	 * A release of the last chunk alone goes through. Once it has run,
+	 * anything queued before it has run too.
+	 */
+	skel->bss->ptr = (void *)((nr - 1) * ps);
+	skel->data->page_cnt = 1;
+	if (run(skel->progs.free_pages, "free_last"))
+		goto out;
+	ASSERT_EQ(wait_alloc_at(skel), 0, "last_released");
+	ASSERT_EQ(map_memlock(fd), base + nr * ps, "still_full");
+	skel->bss->ptr = NULL;
+	ASSERT_EQ(run_ret(skel->progs.alloc_at, "alloc_at"), 1, "first_still_taken");
+
+	skel->data->page_cnt = nr;
+	if (run(skel->progs.free_pages, "free_all"))
+		goto out;
+	ASSERT_EQ(wait_memlock(fd, base), base, "released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/*
+ * A chunk is released once: a second release of a chunk whose release is
+ * queued is refused, so that it cannot take away whatever claims the chunk
+ * after the first release has run. The repeated request is made while the
+ * worker is waiting out the grace period of the first, which puts it in a
+ * later batch; a request that arrives before the worker starts joins the
+ * first batch instead and is harmless either way.
+ */
+static void test_release_once(void)
+{
+	struct typed_arena *skel;
+	void *p1, *p2;
+	long base;
+	int fd;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+	base = map_memlock(fd);
+
+	if (run(skel->progs.alloc, "alloc1"))
+		goto out;
+	p1 = skel->bss->ptr;
+	if (run(skel->progs.alloc, "alloc2"))
+		goto out;
+	p2 = skel->bss->ptr;
+
+	skel->bss->ptr = p1;
+	if (run(skel->progs.free_pages, "free1"))
+		goto out;
+	usleep(1000);
+	if (run(skel->progs.free_pages, "free1_again"))
+		goto out;
+	skel->bss->ptr = p2;
+	if (run(skel->progs.free_pages, "free2"))
+		goto out;
+
+	/* Claim the first chunk again as soon as its release has run, and write to it. */
+	skel->bss->ptr = p1;
+	ASSERT_EQ(wait_alloc_at(skel), 0, "reclaimed");
+	skel->bss->value = 42;
+	if (run(skel->progs.write_value, "write_value"))
+		goto out;
+
+	/*
+	 * The second chunk's release was queued after the repeated one. Once it
+	 * has run, so has the repeated one, if it was accepted.
+	 */
+	skel->bss->ptr = p2;
+	ASSERT_EQ(wait_alloc_at(skel), 0, "marker_released");
+
+	skel->bss->ptr = p1;
+	skel->bss->value = 0;
+	if (run(skel->progs.read_value, "read_value"))
+		goto out;
+	ASSERT_EQ(skel->bss->value, 42, "kept");
+
+	if (run(skel->progs.free_pages, "free1_final"))
+		goto out;
+	skel->bss->ptr = p2;
+	if (run(skel->progs.free_pages, "free2_final"))
+		goto out;
+	ASSERT_EQ(wait_memlock(fd, base), base, "released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/* A request larger than one batch of the allocator is served whole. */
+static void test_batch_alloc(void)
+{
+	long ps = PAGE_SIZE, base, nr = WIDE_ARENA_SIZE / PAGE_SIZE;
+	struct typed_arena *skel;
+	void *p;
+	int fd;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+	base = map_memlock(fd);
+
+	skel->data->page_cnt = nr;
+	if (run(skel->progs.wide_alloc, "wide_alloc"))
+		goto out;
+	ASSERT_EQ(skel->data->page_cnt, nr, "granted");
+	p = skel->bss->ptr;
+	ASSERT_EQ(map_memlock(fd), base + nr * ps, "after_alloc");
+
+	/* The last page of the range is usable. */
+	skel->bss->ptr = p + (nr - 1) * ps;
+	skel->bss->value = 42;
+	if (run(skel->progs.wide_touch, "wide_touch"))
+		goto out;
+
+	skel->bss->ptr = p;
+	if (run(skel->progs.wide_free, "wide_free"))
+		goto out;
+	ASSERT_EQ(wait_memlock(fd, base), base, "released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/* An object of more than a page is backed and released as one chunk. */
+static void test_multipage(void)
+{
+	long ps = PAGE_SIZE, base, granted;
+	struct typed_arena *skel;
+	int fd;
+
+	granted = BIG_OBJ_SIZE > ps ? BIG_OBJ_SIZE / ps : 1;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	fd = bpf_map__fd(skel->maps.arena);
+	base = map_memlock(fd);
+
+	/* One page requested, the whole object granted. */
+	skel->data->page_cnt = 1;
+	if (run(skel->progs.big_alloc, "big_alloc"))
+		goto out;
+	ASSERT_EQ(skel->data->page_cnt, granted, "granted");
+	ASSERT_EQ(map_memlock(fd), base + granted * ps, "after_alloc");
+
+	skel->bss->value = 42;
+	if (run(skel->progs.big_touch, "big_touch"))
+		goto out;
+
+	if (run(skel->progs.big_free, "big_free"))
+		goto out;
+	ASSERT_EQ(wait_memlock(fd, base), base, "released");
+out:
+	typed_arena__destroy(skel);
+}
+
+/*
+ * A list linked through typed pointer fields is walked with no cast, read
+ * and written, and its NULL end dereferences object 0 of the slice.
+ */
+static void test_fields(void)
+{
+	struct typed_arena *skel;
+
+	skel = typed_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_load"))
+		return;
+	if (run(skel->progs.list_build, "list_build"))
+		goto out;
+	if (run(skel->progs.list_sum_values, "list_sum"))
+		goto out;
+	ASSERT_EQ(skel->bss->list_sum, LIST_LEN * (LIST_LEN + 1) / 2, "sum");
+	if (run(skel->progs.list_bump_values, "list_bump"))
+		goto out;
+	if (run(skel->progs.list_sum_values, "list_sum_bumped"))
+		goto out;
+	ASSERT_EQ(skel->bss->list_sum, LIST_LEN * (LIST_LEN + 1) / 2 + LIST_LEN, "sum_bumped");
+
+	skel->bss->value = 4242;
+	if (run(skel->progs.list_deref_end, "list_deref_end"))
+		goto out;
+	ASSERT_EQ(skel->bss->list_sum, 4242, "null_is_object_zero");
+out:
+	typed_arena__destroy(skel);
+}
+
+void test_typed_arena(void)
+{
+	struct typed_arena *skel;
+	bool supported;
+
+	/* The programs need a compiler that emits the cast. */
+	skel = typed_arena__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	supported = skel->rodata->typed_arena_supported;
+	typed_arena__destroy(skel);
+	if (!supported) {
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("pages"))
+		test_pages();
+	if (test__start_subtest("identity"))
+		test_identity();
+	if (test__start_subtest("release_spans"))
+		test_release_spans();
+	if (test__start_subtest("release_bounds"))
+		test_release_bounds();
+	if (test__start_subtest("release_once"))
+		test_release_once();
+	if (test__start_subtest("batch_alloc"))
+		test_batch_alloc();
+	if (test__start_subtest("multipage"))
+		test_multipage();
+	if (test__start_subtest("fields"))
+		test_fields();
+}
diff --git a/tools/testing/selftests/bpf/progs/typed_arena.c b/tools/testing/selftests/bpf/progs/typed_arena.c
new file mode 100644
index 000000000000..ed57ed4ee24b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/typed_arena.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 8);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+/* Tells the runner whether the compiler emits the cast, and so whether the programs below exist. */
+const volatile bool typed_arena_supported =
+#ifdef __BPF_FEATURE_TYPED_ARENA_CAST
+	true;
+#else
+	false;
+#endif
+
+/* 16-byte slots: a 256 KiB typed arena, 64 pages of 4 KiB, one word of the chunk bitmap */
+struct obj {
+	struct prog_test_ref_kfunc __kptr *ref;
+	__u64 value;
+} __typed_arena_size(256K);
+
+/* 16-byte slots: an 8 MiB typed arena, 2048 pages of 4 KiB, more than one batch of the allocator */
+struct wide_obj {
+	struct prog_test_ref_kfunc __kptr *ref;
+	__u64 value;
+} __typed_arena_size(8M);
+
+/* An object of 8 KiB, two pages of 4 KiB: its chunk is the object */
+struct big_obj {
+	struct prog_test_ref_kfunc __kptr *ref;
+	__u64 value;
+	char pad[8192 - 16];
+} __typed_arena_size(64K);
+
+/* 32-byte slots, linked through a typed pointer field */
+struct arena_list_node {
+	struct prog_test_ref_kfunc __kptr *ref;
+	struct arena_list_node *next;
+	__u64 value;
+} __typed_arena_size(64K);
+
+#define LIST_LEN 64
+/* Objects sit at slot strides, the power of two covering the struct, not at sizeof. */
+#define NODE_SLOT 32
+
+/* An object as an opaque 64-bit value user space hands back; any value casts to an object. */
+void *ptr;
+/* Pages requested; the allocator writes back what it granted. */
+__u32 page_cnt = 1;
+__u64 value;
+__u64 ref_cnt;
+void *list_head;
+__u64 list_sum;
+
+#ifdef __BPF_FEATURE_TYPED_ARENA_CAST
+
+/*
+ * A program is associated with an arena by referencing the map. Programs that
+ * only cast values they hold reference it explicitly.
+ */
+#define arena_bind() asm volatile("r0 = %[m] ll" :: [m] "i"(&arena) : "r0")
+
+#define TYPE_ID(T) bpf_core_type_id_local(T)
+
+SEC("syscall")
+int alloc(void *ctx)
+{
+	struct obj *o;
+
+	o = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct obj), NULL, &page_cnt, NUMA_NO_NODE);
+	if (!o)
+		return 1;
+	ptr = o;
+	return 0;
+}
+
+/* Take the chunks at ptr: 0 when granted, 1 when refused. */
+SEC("syscall")
+int alloc_at(void *ctx)
+{
+	struct obj *hint, *o;
+
+	hint = ptr;
+	o = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct obj), hint, &page_cnt, NUMA_NO_NODE);
+	if (!o)
+		return 1;
+	return o != hint;
+}
+
+SEC("syscall")
+int free_pages(void *ctx)
+{
+	struct obj *o = ptr;
+
+	bpf_typed_arena_free_pages(&arena, TYPE_ID(struct obj), o, page_cnt);
+	return 0;
+}
+
+SEC("syscall")
+int write_value(void *ctx)
+{
+	struct obj *o;
+
+	arena_bind();
+	o = ptr;
+	o->value = value;
+	return 0;
+}
+
+SEC("syscall")
+int read_value(void *ctx)
+{
+	struct obj *o;
+
+	arena_bind();
+	o = ptr;
+	value = o->value;
+	return 0;
+}
+
+/* Leave a reference to the test module's object in the kptr field. */
+SEC("syscall")
+int stash_ref(void *ctx)
+{
+	struct prog_test_ref_kfunc *p, *old;
+	unsigned long sp = 0;
+	struct obj *o;
+
+	arena_bind();
+	p = bpf_kfunc_call_test_acquire(&sp);
+	if (!p)
+		return 1;
+	o = ptr;
+	old = bpf_kptr_xchg(&o->ref, p);
+	if (old)
+		bpf_kfunc_call_test_release(old);
+	return 0;
+}
+
+SEC("syscall")
+int read_ref_cnt(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sp = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sp);
+	if (!p)
+		return 1;
+	/* the acquire above holds one */
+	ref_cnt = p->cnt.refs.counter - 1;
+	bpf_kfunc_call_test_release(p);
+	return 0;
+}
+
+SEC("syscall")
+int wide_alloc(void *ctx)
+{
+	struct wide_obj *o;
+
+	o = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct wide_obj), NULL, &page_cnt,
+					NUMA_NO_NODE);
+	if (!o)
+		return 1;
+	ptr = o;
+	return 0;
+}
+
+/* Write the value into the object at ptr and read it back. */
+SEC("syscall")
+int wide_touch(void *ctx)
+{
+	struct wide_obj *o;
+
+	arena_bind();
+	o = ptr;
+	o->value = value;
+	return o->value != value;
+}
+
+SEC("syscall")
+int wide_free(void *ctx)
+{
+	struct wide_obj *o = ptr;
+
+	bpf_typed_arena_free_pages(&arena, TYPE_ID(struct wide_obj), o, page_cnt);
+	return 0;
+}
+
+SEC("syscall")
+int big_alloc(void *ctx)
+{
+	struct big_obj *o;
+
+	o = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct big_obj), NULL, &page_cnt,
+					NUMA_NO_NODE);
+	if (!o)
+		return 1;
+	ptr = o;
+	return 0;
+}
+
+/* Write both pages of the object at ptr and read them back. */
+SEC("syscall")
+int big_touch(void *ctx)
+{
+	struct big_obj *o;
+
+	arena_bind();
+	o = ptr;
+	o->value = value;
+	o->pad[sizeof(o->pad) - 1] = 1;
+	return o->value != value || o->pad[sizeof(o->pad) - 1] != 1;
+}
+
+SEC("syscall")
+int big_free(void *ctx)
+{
+	struct big_obj *o = ptr;
+
+	bpf_typed_arena_free_pages(&arena, TYPE_ID(struct big_obj), o, page_cnt);
+	return 0;
+}
+
+/* A page of nodes, the first LIST_LEN linked in order with values 1..LIST_LEN, ending in NULL. */
+SEC("syscall")
+int list_build(void *ctx)
+{
+	struct arena_list_node *n;
+	__u32 cnt = 1;
+	void *page;
+	int i;
+
+	page = bpf_typed_arena_alloc_pages(&arena, TYPE_ID(struct arena_list_node), NULL, &cnt,
+					   NUMA_NO_NODE);
+	if (!page)
+		return 1;
+	for (i = 0; i < LIST_LEN; i++) {
+		n = page + i * NODE_SLOT;
+		n->value = i + 1;
+		if (i + 1 < LIST_LEN)
+			n->next = page + (i + 1) * NODE_SLOT;
+		else
+			n->next = NULL;
+	}
+	list_head = page;
+	return 0;
+}
+
+/*
+ * Walk the list through its typed pointer fields with no cast; the NULL that
+ * ends it is compared raw.
+ */
+SEC("syscall")
+int list_sum_values(void *ctx)
+{
+	struct arena_list_node *n;
+	__u64 sum = 0;
+	int i;
+
+	arena_bind();
+	n = list_head;
+	for (i = 0; n && i < LIST_LEN + 1; i++) {
+		sum += n->value;
+		n = n->next;
+	}
+	list_sum = sum;
+	return 0;
+}
+
+SEC("syscall")
+int list_bump_values(void *ctx)
+{
+	struct arena_list_node *n;
+	int i;
+
+	arena_bind();
+	n = list_head;
+	for (i = 0; n && i < LIST_LEN + 1; i++) {
+		n->value += 1;
+		n = n->next;
+	}
+	return 0;
+}
+
+/*
+ * Dereference the NULL that ends the list: it lands on object 0 of the node
+ * slice, marked with the value first through a NULL pointer held directly.
+ */
+SEC("syscall")
+int list_deref_end(void *ctx)
+{
+	struct arena_list_node *zero = NULL, *n, *m;
+	int i;
+
+	arena_bind();
+	/*
+	 * The compiler treats a NULL dereference as undefined and would drop
+	 * the store, the checks and the last hop; the barriers keep each
+	 * pointer opaque so that the store, the walk and the final dereference
+	 * are emitted.
+	 */
+	barrier_var(zero);
+	zero->value = value;
+	n = list_head;
+	for (i = 0; i < LIST_LEN; i++) {
+		m = n->next;
+		barrier_var(m);
+		if (!m)
+			break;
+		n = m;
+	}
+	m = n->next;
+	barrier_var(m);
+	list_sum = m->value;
+	return 0;
+}
+
+#else /* !__BPF_FEATURE_TYPED_ARENA_CAST */
+
+/* Keep the skeleton's shape without the compiler support; the runner skips the tests. */
+#define STUB(name) SEC("syscall") int name(void *ctx) { return 0; }
+STUB(alloc)
+STUB(alloc_at)
+STUB(free_pages)
+STUB(write_value)
+STUB(read_value)
+STUB(stash_ref)
+STUB(read_ref_cnt)
+STUB(wide_alloc)
+STUB(wide_touch)
+STUB(wide_free)
+STUB(big_alloc)
+STUB(big_touch)
+STUB(big_free)
+STUB(list_build)
+STUB(list_sum_values)
+STUB(list_bump_values)
+STUB(list_deref_end)
+
+#endif /* __BPF_FEATURE_TYPED_ARENA_CAST */
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

