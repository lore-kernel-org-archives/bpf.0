Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA782EE611
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772517271; cv=none; b=cKo/MQP7P/TYhAQnwKGqWP2t7nE0z6b7Qd4NfMXOeHwpuPQpbfQRZhMuBxL7BdgZce1aOJym/rGDZcEMzgfAazqwrCH/QZ4SwQsh785ZpIUD0TfVHNzpiQpF9bmed9nEDIvhrWvOR5GzRzk5waQ2DKSQ4BIDcK5SvKz8roGwGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772517271; c=relaxed/simple;
	bh=6qzHlh10MApeXv7yMNlEmX5cSN6GyQGLqmitHm1kE4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ33RwYx+j634kGCN/CsmoKLoBZmBzbsrrWg+v7wCOKu+3GwV5FEGpz5aT0Erkb2N7AeaNMNZ0sg9FM93/mzHIAbBCFFs5n+QmOsWuDeofKh8HfYmuNigIOasubE5a+AldcPkvMF+z1B4dHCa5geGtpgEzdkO3+NRLyHKmX5IOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iqW7blNx; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iqW7blNx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772517268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6eJEYFrb9LvZqYh0Q45H8GvoxLpNshzFBYH4l9HNuk=;
	b=iqW7blNxfgMMwNnwuepiufW6U7e5cTFabi7kyBfFiPesIN6hDT91skoAwlY4cZ8ekKRc+o
	K5QrgLyiwFzkvMBCd2RQLWQNjheKc5eUVoyG68nIoMG+jCQemLoGPj/kEn1XDjaYkI6Eud
	aRJ/G5foVMSVgcFnUTneZ68dOf+qxmo=
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	JP Kobryn <jp.kobryn@linux.dev>
Subject: [PATCH bpf-next v5 2/2] bpf: Use bpf_core_enum_value for stats in cgroup_iter_memcg
Date: Tue,  3 Mar 2026 13:53:09 +0800
Message-ID: <ca6eb1a1a4fd7a17ffe995acf52c9a4ceb7bac13.1772505399.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1772505399.git.zhuhui@kylinos.cn>
References: <cover.1772505399.git.zhuhui@kylinos.cn>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
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

