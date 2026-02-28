Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971A3921EB
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772270798; cv=none; b=OBKfMgvqndZ/ItTJbOe6X/9g1EVVosa+4qk3emycyKayeKzZp7Ej2GPW1vPGijhoWUwmPKg8zJSIKuIjhaCvvBm4IrPVKB5y7j1WsF4cpk9kiH1fgt+FiKPNAU/P/50jiDqetx2WJJ1C7ne4mitf1S/CUHA/SwdS3SBfqpwQm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772270798; c=relaxed/simple;
	bh=tVZDQij/6zXgwkcp+82ybX8VsjDe2at6v6mgRMGN0BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4PuIDzQP5Q81KlnsUJDR7l13LUgfxZBTYcb+51qnZfTRVT6gjrD6s07seWjRXpdBsHtkXoXeh5U8i4ZGxoiyLOpoBdcT+SHYXCpWXAp2dMlMHjpAZa9c0svS/IA+muiYc409UzC7FCvYVT/mkXtCxbJ1bEXrBoGAS2kEBrpMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OltYUCyO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OltYUCyO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772270795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JoNpdyP4g61Uwkgai/ODumcE5sjDqITd0hCVij5GPS0=;
	b=OltYUCyOnb9Jl9e5ZtZQ0prqvGDdKbHSDI+fmGJPi12CIUnnPjRIyj+Zf7CE4kabUirRL5
	jLpjYAVnvCDaXWMlUeetonAzPwhzQ/jKN1QB/TSrG5XzVLMj1JVS1HrTwK1Vibw7st4bKJ
	Rz44pDAZOwVvf8sBmgpIMElyZ67gTA0=
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
Subject: [PATCH bpf-next v4 2/3] bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
Date: Sat, 28 Feb 2026 17:25:54 +0800
Message-ID: <0831b50f85b4b00e698ef0b5fff6acd196dd1265.1772270591.git.zhuhui@kylinos.cn>
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

Replace hardcoded enum values with bpf_core_enum_value() calls in
cgroup_iter_memcg test to improve portability across different
kernel versions.

The change adds runtime enum value resolution for:
- node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
  NR_FILE_MAPPED
- vm_event_item: PGFAULT

This ensures the BPF program can adapt to enum value changes
between kernel versions.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 .../selftests/bpf/progs/cgroup_iter_memcg.c     | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
index 12f79a44133e..06a385c9d85b 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
@@ -26,11 +26,18 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
 
 	bpf_mem_cgroup_flush_stats(memcg);
 
-	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED);
-	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
-	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
-	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
-	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
+	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(
+		memcg,
+		bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));
+	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(
+		memcg, bpf_core_enum_value(enum node_stat_item, NR_SHMEM));
+	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(
+		memcg, bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES));
+	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(
+		memcg,
+		bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED));
+	memcg_query.pgfault = bpf_mem_cgroup_vm_events(
+		memcg, bpf_core_enum_value(enum vm_event_item, PGFAULT));
 
 	bpf_put_mem_cgroup(memcg);
 
-- 
2.43.0

