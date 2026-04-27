Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E83B6C08;
	Mon, 27 Apr 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287073; cv=none; b=aod6AOQR5C5uho9mbbo8IKDdupUlVkSJbHmFvHoeug7uITADYOfjqeBogL83O71os3pkxfHVKM7xPB+Wwv07OcnERRjcSa8o2f2gPlTcxgGuRN2dR5tpQLm4NCTCcqPX29XYTPeozLzZylugFB7zs9tvOEAjnqLXIaJNci3aje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287073; c=relaxed/simple;
	bh=b2fq//u3p9ewYQc5NETlGyD7c4FijBKzPZVbLqGfOYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA7rRYeFfNYrOkLvK5ibokhJI3eXgKMZUW/mVbl9LOK5f1vm/Yy37G9vVgu9sh8Dq7vsDA+UgaZzCBcIZBAAiapDEcvGpSUUTXZU9wKZa6Z4EwGGKetMR7nVUjF30Y7CFuK7Xtt6nZ3xoR96g7PWnAJMr8vsqcfLYkrozxSnCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7hfvzEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7hfvzEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A16EC2BCB4;
	Mon, 27 Apr 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287073;
	bh=b2fq//u3p9ewYQc5NETlGyD7c4FijBKzPZVbLqGfOYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7hfvzEvHIWlF7qYru2wUYyuPeYMsFSIPsXd8ZetgSdqnUN5+rJSIYHCs4sfl9wXP
	 dPrbOzVNOtW+DfSngWP4odLKgFXkwWH59X6ziFTC3xMO3lxG1G5V7PLzKwYjOaJcUj
	 eGJe4Q5ARKR0EXG9uaCfLa4HP0q/O2UBRPZ+wTJgJDetAowB+UhRG8g2g5eKBvAR8Y
	 5/tOeUKNeeHXz56cZiItq1zF3Jqj2NT4/aYo6wLvG7BXlfgVjWfVxorZByZ/QcwZz8
	 DUPU/sR4SeCUOkjzvTpoJE62iZAUA/d8nwh0UzLOub4bK6NsWvrxhBzicYn79jfEv7
	 v0pQSxpPUNCKQ==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/9] bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
Date: Mon, 27 Apr 2026 00:51:03 -1000
Message-ID: <20260427105109.2554518-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105109.2554518-1-tj@kernel.org>
References: <20260427105109.2554518-1-tj@kernel.org>
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
index 0136a108d083..af54705611d7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -678,6 +678,8 @@ int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
 					  u64 flags);
 void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt);
+void *bpf_arena_alloc_pages_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
+				      u64 flags);
 #else
 static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
 							int node_id, u64 flags)
@@ -688,6 +690,12 @@ static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr
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
index 4e480c2f3786..73e43617761c 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -947,6 +947,19 @@ void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 pag
 
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
2.53.0

