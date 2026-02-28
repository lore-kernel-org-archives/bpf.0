Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C23612FA
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262712; cv=none; b=P4uucZf51UBj26Yjhga///XiI1OXjXHLfbjxysx5X0XDEur05rMgvlbLbIj8bIMG7F16xZlFMqq0y8iGaGxxqaEJkvm0NF5lZhew3YzqvH7jiNznkxiXkEYA3YiLrtJhxB80uzSrH/rOPcT8Cy7wS7E4OkRe/FKmOXV4s0AfR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262712; c=relaxed/simple;
	bh=ydcvMtndpU/OxsEtSVhVCNWCIxu5kvEi13B73r/hsw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4JRQl3fcSt7oWUpSD71CkFD/8frSfYnDXG8Y9b3+5dgcq1gAYOnQPa9UkIWX8Ck7FgD8iVYdfc/qROPY3h8QiUzxk4C0RcX0u8xDD0a9Np8TCI6HObzuTeiAn82CxQtgaHyjWvjKXVPb7BuW8A3/1QXCy4plW2egi/cpX+K6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SadWynVw; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SadWynVw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772262709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djwKlAEgY6ee2weS/mkLRpx1tbGzO35/OAf7bR840yA=;
	b=SadWynVwrc5gWMkyHXmI9Qp+c7/4T+flVRtgaACq2kX5iXuETqL8jmyUpwNKz3oiw1WBju
	TW0ZHdsmezIZ70aU8Ul5c6AiMCRtexySJN/KLhiQhnrgQ/NFDNFO7MTjNNN+33+5eqHcDB
	PhMTnpdoY10SQWmcneyhMTRkCnFHhGk=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Remove kmem subtest from cgroup_iter_memcg
Date: Sat, 28 Feb 2026 15:11:21 +0800
Message-ID: <bb9c8fe74aba9dc8c3d803ea6caf6610e981d79a.1772261955.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1772261955.git.zhuhui@kylinos.cn>
References: <cover.1772261955.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

When cgroup.memory=nokmem is set in the kernel command line, kmem
accounting is disabled. This causes the test_kmem subtest in
cgroup_iter_memcg to fail because it expects non-zero kmem values.

Remove the kmem subtest altogether since the remaining subtests
(shmem, file, pgfault) already provide sufficient coverage for
the cgroup iter memcg functionality.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  2 --
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 28 -------------------
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  1 -
 3 files changed, 31 deletions(-)

diff --git a/tools/testing/selftests/bpf/cgroup_iter_memcg.h b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
index 3f59b127943b..ff20ec537164 100644
--- a/tools/testing/selftests/bpf/cgroup_iter_memcg.h
+++ b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
@@ -9,8 +9,6 @@ struct memcg_query {
 	unsigned long nr_shmem;
 	unsigned long nr_file_pages;
 	unsigned long nr_file_mapped;
-	/* some memcg_stat_item */
-	unsigned long memcg_kmem;
 	/* some vm_event_item */
 	unsigned long pgfault;
 };
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index a5afd16705f0..88fc3e83d2b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -126,32 +126,6 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 	shm_unlink("/tmp_shmem");
 }
 
-#define NR_PIPES 64
-static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
-{
-	int fds[NR_PIPES][2], i;
-
-	/*
-	 * Increase kmem value by creating pipes which will allocate some
-	 * kernel buffers.
-	 */
-	for (i = 0; i < NR_PIPES; i++) {
-		if (!ASSERT_OK(pipe(fds[i]), "pipe"))
-			goto cleanup;
-	}
-
-	if (!ASSERT_OK(read_stats(link), "read stats"))
-		goto cleanup;
-
-	ASSERT_GT(memcg_query->memcg_kmem, 0, "kmem value");
-
-cleanup:
-	for (i = i - 1; i >= 0; i--) {
-		close(fds[i][0]);
-		close(fds[i][1]);
-	}
-}
-
 static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
 {
 	void *map;
@@ -209,8 +183,6 @@ void test_cgroup_iter_memcg(void)
 		test_shmem(link, &skel->data_query->memcg_query);
 	if (test__start_subtest("cgroup_iter_memcg__file"))
 		test_file(link, &skel->data_query->memcg_query);
-	if (test__start_subtest("cgroup_iter_memcg__kmem"))
-		test_kmem(link, &skel->data_query->memcg_query);
 	if (test__start_subtest("cgroup_iter_memcg__pgfault"))
 		test_pgfault(link, &skel->data_query->memcg_query);
 
diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
index 59fb70a3cc50..12f79a44133e 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
@@ -30,7 +30,6 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
 	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
 	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
 	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
-	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, MEMCG_KMEM);
 	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
 
 	bpf_put_mem_cgroup(memcg);
-- 
2.43.0

