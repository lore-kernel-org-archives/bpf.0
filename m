Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E914746C5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728759; cv=none; b=ig7+rlj/yWEiqlejtb82885LZnOdFinHjKje264x8hF9rTx4XDaAyeclFi+hFGinuwsl3fLQ0GmoAwi3TRkQ5oinqOB5aV/P8B8cVgDYHHuYtkP0sHrmAkO7LfDCoYLIzmaPt+50mSVDTk/tZMD4i9Z/3HHkdMsG4W0hL7kO0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728759; c=relaxed/simple;
	bh=8DyJgJaFAAzSQWBUiH5tqERwNtu2XZrEmgsC9jS+1/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju1K6Minn89AnxQGQzI98IkXjjokXNoKFq7a4bFq1DPlyN+LBQMmPGKWnuFgFxUXvGsx0+62G4VSyV8Uv7AgB6yeGirIrLc8Whqa0a7PBaKWABU/jw0WxjPnPF2//EETpgcDScF20hUIg/qHS9EtrXuuwDPBsLpdbwLjhmrnsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vUdzjTue; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vUdzjTue"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8DyJgJaFAAzSQWBUiH5tqERwNtu2XZrEmgsC9jS+1/k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728754; v=1; x=1787333554;
 b=vUdzjTuefnkQ1RECmB8KrwUB9X6r6UharQN03h7pErfVUM5sW4wE7Woe6WmWB7Uhyt9zmqhK
 Tly4/dQectg0t3tgjbsDs0n4XWm1Zt3oOXQsL5XaGGrfj0Dt6yRVv58Nl/D4uephXeRV6L0uyUu
 EOVjFZG3oDHryPcZe/WBVsYI=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id dcd964c90c59db3d;
	Fri, 14 Aug 2026 17:32:34 +0000
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/5] libbpf: Avoid unnecessary mmap resize for percpu data maps
Date: Sat, 15 Aug 2026 01:32:03 +0800
Message-ID: <20260814173206.93082-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
References: <20260814173206.93082-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use array_map_mmap_sz() for PERCPU_ARRAY like ARRAY in bpf_map_mmap_sz().
This lets bpf_map__set_value_size() skip mmap(), memcpy(), and munmap()
when the old and new value sizes occupy the same number of pages.

Fix some typos btw:

* mmapble -> mmapable
* satisified -> satisfied
* relocatin -> relocation
* atach_btf_obj_fd -> attach_btf_obj_fd
* len_secnd -> len_second
* precendence -> precedence

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/libbpf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e574870fb716..b749c01742ee 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1841,9 +1841,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 
 	switch (map->def.type) {
 	case BPF_MAP_TYPE_ARRAY:
-		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
-		return map->def.value_size;
+		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
 	case BPF_MAP_TYPE_ARENA:
 		return page_sz * map->def.max_entries;
 	default:
@@ -1951,7 +1950,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 		return false;
 
 	/*
-	 * The internal PERCPU maps are not mmapble because the underlying
+	 * The internal PERCPU maps are not mmapable because the underlying
 	 * percpu_array maps do not have mmap support.
 	 */
 	if (map->libbpf_type == LIBBPF_MAP_PERCPU)
@@ -2831,7 +2830,7 @@ static size_t adjust_ringbuf_sz(size_t sz)
 		return 0;
 	/* Kernel expects BPF_MAP_TYPE_RINGBUF's max_entries to be
 	 * a power-of-2 multiple of kernel's page size. If user diligently
-	 * satisified these conditions, pass the size through.
+	 * satisfied these conditions, pass the size through.
 	 */
 	if ((sz % page_sz) == 0 && is_pow_of_2(sz / page_sz))
 		return sz;
@@ -6989,7 +6988,7 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
  *    +-----------+------+------+
  *
  * At this point, we relocate subA calls, then go one level up and finish with
- * relocatin mainA calls. mainA is done.
+ * relocation mainA calls. mainA is done.
  *
  * For mainB process is similar but results in different order. We start with
  * mainB and skip subA and subB, as mainB never calls them (at least
@@ -7936,7 +7935,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		prog->attach_btf_id = btf_type_id;
 
 		/* but by now libbpf common logic is not utilizing
-		 * prog->atach_btf_obj_fd/prog->attach_btf_id anymore because
+		 * prog->attach_btf_obj_fd/prog->attach_btf_id anymore because
 		 * this callback is called after opts were populated by
 		 * libbpf, so this callback has to update opts explicitly here
 		 */
@@ -14219,7 +14218,7 @@ perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 		if (((void *)ehdr) + ehdr_size > base + mmap_size) {
 			void *copy_start = ehdr;
 			size_t len_first = base + mmap_size - copy_start;
-			size_t len_secnd = ehdr_size - len_first;
+			size_t len_second = ehdr_size - len_first;
 
 			if (*copy_size < ehdr_size) {
 				free(*copy_mem);
@@ -14233,7 +14232,7 @@ perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 			}
 
 			memcpy(*copy_mem, copy_start, len_first);
-			memcpy(*copy_mem + len_first, base, len_secnd);
+			memcpy(*copy_mem + len_first, base, len_second);
 			ehdr = *copy_mem;
 		}
 
@@ -14251,7 +14250,7 @@ struct perf_buffer;
 
 struct perf_buffer_params {
 	struct perf_event_attr *attr;
-	/* if event_cb is specified, it takes precendence */
+	/* if event_cb is specified, it takes precedence */
 	perf_buffer_event_fn event_cb;
 	/* sample_cb and lost_cb are higher-level common-case callbacks */
 	perf_buffer_sample_fn sample_cb;
-- 
2.55.0

