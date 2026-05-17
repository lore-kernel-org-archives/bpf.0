Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B302E318EF0;
	Sun, 17 May 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779052359; cv=none; b=JKTskf1kQFDuzlDWnjHcKBJSQF+RgPmeT6eJKcXdR6IGkmoAUEzlGim/yskkd9nIf9sa7UI85jAJtBBpcwYnalB6VsL8DHOKgstRmIa6oRMsIhqAlEiA6qJd9MWGxjLHI7bhTTEaCGuHks+bhASDceAuAZwGHBTAFNXp+MBfGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779052359; c=relaxed/simple;
	bh=FaQAuO2nj9X9q8AZMI9N/o/VYWh89imS0v4TwbR5loU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjo4mO9ftPIunVuqsL48ZYQPtffoaLoO21D+0vCVl4I4/mwa7hcLQngJp/tMTR7CoTYqdk0R3La7Tes/Wpmn1aNJGcEEdmJC3xijy2d16MfX4QY2Kfp2T7jxtQ2Og/eUy0uAvEkYeM5KdZTPLYrXkZTgw2/3sfv0rI4mEIEcH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGO9lDi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGO9lDi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C6FC2BCB0;
	Sun, 17 May 2026 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779052358;
	bh=FaQAuO2nj9X9q8AZMI9N/o/VYWh89imS0v4TwbR5loU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGO9lDi9gvWVVueWifEgkQq7PmvNpDizNrHcRnLWG6O7GYNO/KkjBYkl9qEnxV7h5
	 GZwQa0pU36wiGpqNQeYyUeE2fvlu5l9TDf4hwrNag7bh5RoRz+KX8gw0ESGwXK6JXn
	 Rs2cwVuuxCqzvKevvzZ6ebgmDATGIyz6kGf0abvOOoGEBmqxw1WvK5zIqUzSudlXl/
	 52nhUz6CC09Lt8j8qZwwGMqYFUvUvXZ+X+AiLdHh//g/HIVRuR2l/qYCPEKV59OYCN
	 SlgKt2g2APVK9xHfm8rK4stFJiwoB4slUjReS4vejaWLzV0/v7VuFDTPsZuV52AxHh
	 2azCz7ZIMOMvA==
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
Subject: [PATCH 5/8] bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()
Date: Sun, 17 May 2026 11:12:29 -1000
Message-ID: <20260517211232.1670594-6-tj@kernel.org>
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

struct bpf_arena is opaque to callers outside arena.c. Add two helpers
for struct_ops subsystems that need to reach into an arena:

  bpf_arena_map_kern_vm_start(struct bpf_map *map)
    returns @map's kern_vm_start. A sched_ext follow-up needs this
    to translate kern_va <-> uaddr.

  bpf_prog_arena(struct bpf_prog *prog)
    returns the bpf_map of the arena referenced by @prog (NULL if
    @prog references no arena). The verifier enforces at most one
    arena per program. Used by struct_ops callers that auto-discover
    an arena from a member prog and need to take a map reference.

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/arena.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5b99d786e98c..e1ba57c10aaa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -618,6 +618,8 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		      struct bpf_spin_lock *spin_lock);
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
+u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
+struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 8eb7b95f4999..5a82d39e1916 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -84,6 +84,32 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
+/**
+ * bpf_arena_map_kern_vm_start - kern_vm_start lookup by struct bpf_map *
+ * @map: a BPF_MAP_TYPE_ARENA map
+ *
+ * Return @map's kern_vm_start.
+ */
+u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
+{
+	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, map));
+}
+
+/**
+ * bpf_prog_arena - return the bpf_map of the arena referenced by @prog
+ * @prog: a loaded BPF program
+ *
+ * The verifier enforces at most one arena per program and stores it in
+ * prog->aux->arena. Return that arena's underlying bpf_map, or NULL if
+ * @prog does not reference an arena.
+ */
+struct bpf_map *bpf_prog_arena(struct bpf_prog *prog)
+{
+	struct bpf_arena *arena = prog->aux->arena;
+
+	return arena ? &arena->map : NULL;
+}
+
 static long arena_map_peek_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
-- 
2.54.0

