Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1087136074A
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262720; cv=none; b=uZQnf7SQg3W1Skh0yWGINw82k8S0Q3VFJi1xQtvItrypOOqVvYYtnFu534aMuYRA+BL7au2/evsGPxiTBiqXMuRF73rKxjeWvN6kzHS3Y+cPnfn8H2ubOJ/6oPOmns/fXbEazIsMebcYbzFlpxg9S7JN03GyExmrRAW8VTxO5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262720; c=relaxed/simple;
	bh=2A5S3wswM8mKH9esHAH6T99t0dCgm8CjNU9Tq7xAU3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdj9icT2llKz6oLXLE/oTHtbS6yVgJ/7ditHDVvdRvoXxtTSi5kaDP6cPyUiIkuKHbdv/RoOKfW1xjMdD5KgAW5Vw+jwNLI9jdFryx0zIPPOvEabq8Ayk6TG8ciNGFcNDKfydt88eRqrYnXJBaSBMWPcBAZii29xdg+Pg4v/9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4zO90g9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4zO90g9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772262717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoC1/SGj9ZyMrYYvjzF+ZFkGqF6/FMZJGvqCL8S4uuA=;
	b=V4zO90g9wkZEUykIr39YFJ+ssYGocxjwQNkM7L7YyPFsTsBRytq1KA4UUp7hWwI3bcr5Dz
	KC04j0Mx7G6qJyJCv5ZInXYQiq2cZI1YkRYO+6tdlVgDipSWdaxEb3uuxKxneebC/l8zJH
	0kDqGwQOnsIbHUup9+bO17oNtOtvkdw=
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
Subject: [PATCH bpf-next v3 2/3] bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
Date: Sat, 28 Feb 2026 15:11:22 +0800
Message-ID: <3a788ec239e9f9590897b43d21995e3a3532d916.1772261955.git.zhuhui@kylinos.cn>
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

Replace hardcoded enum values with bpf_core_enum_value() calls in
cgroup_iter_memcg test to improve portability across different
kernel versions.

The change adds runtime enum value resolution for:
- node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
  NR_FILE_MAPPED
- memcg_stat_item: MEMCG_KMEM
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

