Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF73815FC
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270802; cv=none; b=lRuuPSa5E8OpRgXtTkNddC7jmC/adgWrod3nRx0YLAD3rHqxUm0wGwGYpyWsZambxGrbeMsH0rLkGdkpkDhieGDHzPVoaoeecTsobJ+3f2/iaBiiDcaVFBTAS7peAPFtULGaO8CWMVnweDNJFf5PHbzb/extMHdFyzvTzAZV0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270802; c=relaxed/simple;
	bh=I29KYns+3V8NZNZTTMf6JPThoWhIOTarBn/LbxeDCiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9llN2I+Bg+y2uSCheXdseCsVQzZBJ9L57vzR/NM7PJXDnXxj0hw/YjsOigzNaH+rD0rC9SEX+HquQ+vyhtegHY2ELMq6coWpr006DTJkEv2MJVu7iULyJKHlOSIDQmxdclMKabG2LDa1tB4wlUrCG5/aenIHBFhurYCHor1/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hjQNawfk; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hjQNawfk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772270799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxewyvr0s1VxeZ03ELEr26G8sNLhbE2InXvijDekoLs=;
	b=hjQNawfkGYwMKZgG3ZKwDs6jN4Be/0d0HHurwH74mcMEhAf9MWApzA19PEjQiz+JNZnxPl
	ABEgXUA0gXKE+RwIImZkBeE/CgksJjO9f0vJzDw/sjmYGufG1VetVNz+SCy/o+GIjxazj+
	6L5t+6k+Fa9kpkEWKw9xjXK5h7YnUWk=
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Check bpf_mem_cgroup_page_state return value
Date: Sat, 28 Feb 2026 17:25:55 +0800
Message-ID: <c6b0c44062f614ddeaae26b17e3a4f1876a9f9ed.1772270591.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1772270591.git.zhuhui@kylinos.cn>
References: <cover.1772270591.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

When back-porting test_progs to different kernel versions, I encountered
an issue where the test_cgroup_iter_memcg test would falsely pass even
when bpf_mem_cgroup_page_state() failed.

This patch adds explicit checks to ensure bpf_mem_cgroup_page_state()
doesn't return -1 before validating the actual statistics values.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cgroup_iter_memcg.c       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index 88fc3e83d2b7..9eadfbd3fdb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -53,6 +53,8 @@ static void test_anon(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->nr_anon_mapped, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_ANON_MAPPED");
 	ASSERT_GT(memcg_query->nr_anon_mapped, 0, "final anon mapped val");
 
 cleanup:
@@ -88,6 +90,10 @@ static void test_file(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup_map;
 
+	ASSERT_NEQ(memcg_query->nr_file_pages, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_FILE_PAGES");
+	ASSERT_NEQ(memcg_query->nr_file_mapped, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_FILE_MAPPED");
 	ASSERT_GT(memcg_query->nr_file_pages, 0, "final file value");
 	ASSERT_GT(memcg_query->nr_file_mapped, 0, "final file mapped value");
 
@@ -119,6 +125,8 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->nr_shmem, (unsigned long)-1,
+		  "bpf_mem_cgroup_page_state NR_SHMEM");
 	ASSERT_GT(memcg_query->nr_shmem, 0, "final shmem value");
 
 cleanup:
@@ -144,6 +152,8 @@ static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
 	if (!ASSERT_OK(read_stats(link), "read stats"))
 		goto cleanup;
 
+	ASSERT_NEQ(memcg_query->pgfault, (unsigned long)-1,
+		  "bpf_mem_cgroup_vm_events PGFAULT");
 	ASSERT_GT(memcg_query->pgfault, 0, "final pgfault val");
 
 cleanup:
-- 
2.43.0

