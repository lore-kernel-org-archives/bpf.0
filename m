Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D4314A8E;
	Sun, 17 May 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779052356; cv=none; b=ge5CDe36M/7rjh/aApGGtibrU3FZC2Hz0sIxTw9zAUMo3n6E7dxAcdhXPN0I/rdZbnulgwSYFGQAuBWLmfMDbxOQ0zYkzUsuECYl9zv+MwtpgYusFShKCb/dESlTd8M8ccr8XN2CpHdXa3VGe6DNPhHkki9M4ne3fc625L3jdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779052356; c=relaxed/simple;
	bh=sa/XEbVus3j3++neSqYHZhHciwIeY/dNrzAJDzxWUxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK7vPqqmZcESUQYbPegp/BIkW0vw9JXm8zFzaNtPKGzKqo8C5gAJcZw2bzV9NN0OtxY0PGA2rJjmKteuIABoibHEzPObzu8htVPqLENjO/IHBIqMjAbUXgBwtaQXTfM6t7AQ57yg3JFf2zc9SKIvVG+/Uno92Ksk2Z2k7XwalEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1gJ4IlN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gJ4IlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AFDC2BCB0;
	Sun, 17 May 2026 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779052356;
	bh=sa/XEbVus3j3++neSqYHZhHciwIeY/dNrzAJDzxWUxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1gJ4IlNi4iOIT2mipUyACyecpQa+uIf+XnT7/qQ4vdyxGJ11zcsS17cyZrSj4rPO
	 6vfRZSw9RGeGwRCtlQljfXggM8dW45kuClZyEO+q9fpICwzamys3W1B05zYSgw6TA7
	 MexHFPn5D0tfyYajRXoFzEoZXB4AAyIcRDXUnd1fQZYM6pP/deUCVD/POZ7V2qnzWI
	 kvX0WgD81ybgApTydEkfXU70mtFxID4K6WOQM1hO0AtlHaDYw+mA7+EUbsqMzLA/9O
	 YCdzvRV6dfQfuAMgsBZr9b46TqC4AHRrwtYakUSDz0io38O+mX4zIKHTZRLcrBKnrp
	 yaQ7A8/Nqj86w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
Date: Sun, 17 May 2026 11:12:27 -1000
Message-ID: <20260517211232.1670594-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517211232.1670594-1-tj@kernel.org>
References: <20260517211232.1670594-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing kernel-side export of bpf_arena_alloc_pages is _non_sleepable
only - it's used by the verifier to inline the kfunc when the call site is
non-sleepable. There is no sleepable equivalent for kernel callers; the
kfunc bpf_arena_alloc_pages itself is BPF-only.

sched_ext needs sleepable kernel-side allocs for its arena pool init/grow
paths. Add bpf_arena_alloc_pages_sleepable() mirroring the _non_sleepable
wrapper but passing sleepable=true to arena_alloc_pages().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h |  8 ++++++++
 kernel/bpf/arena.c  | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 831996c411cf..64968ca6db51 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -679,6 +679,8 @@ int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
 					  u64 flags);
 void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt);
+void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
+				      u64 flags);
 #else
 static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
 							int node_id, u64 flags)
@@ -689,6 +691,12 @@ static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr
 static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 }
+
+static inline void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
+						    int node_id, u64 flags)
+{
+	return NULL;
+}
 #endif
 
 extern const struct bpf_map_ops bpf_map_offload_ops;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index bc696bef7104..8eb7b95f4999 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -937,6 +937,19 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 pag
 
 	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
 }
+
+void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
+				      int node_id, u64 flags)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
+		return NULL;
+
+	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+}
+
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
-- 
2.54.0

