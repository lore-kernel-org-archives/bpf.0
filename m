Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB313D5642;
	Wed, 20 May 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321061; cv=none; b=iB10nJ70blfjBTs2fTg44ViCKk8J5BMOyinqjEyxM1A3eJRPJfdVj7EsSsYxRwQ2ekJ3DKC8plL/a3juOLw6ztrOqgu4QFrs3wdc8E1Q0sBTwIPZmuUhQqW9oFPpdZrDF+n3JGWRIsLxt6lNMlD6TsNT5avG3F8EQObUpdRYofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321061; c=relaxed/simple;
	bh=QWwQgVh96VCUpsX47ExcVfnVGC9kfcIxNuNG1PsbXrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JokUYlFT9YrvzwPMWJUtgK4QDLHSKimdW/hY6NKfPUTb5QH54b3gzS7B3P1PAP4Q6M3YbtorOB5sY31XyLL0sVE7bA58Ka7f+i1dqp97Qsm8z6jd8Io9/BmhjbQwnuJX8g8RZC5gStwNO7YB7+aT4/OkFUjcEf6oVkPdvd6FKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CarpkMgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CarpkMgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350261F00A3D;
	Wed, 20 May 2026 23:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321058;
	bh=C5B01WmAERz0FAb+2U36sWTc4ic5I5yhwvS5EjBXihQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CarpkMgwagcPzBChV2WOC+aDWnTKcWssSXw9EDJxPeAftz6tZwWo0Hee4ZFSXUQ3I
	 HnhTDCKYTNW7RWkzmNZVWawH18BBPDqse6XoOT5OlE+jn8MKg5ZDLp/2vZgiCx/QyK
	 0+Zdj+kKCM7BbZXKYq4DduZ7FP+WaMchuCP6MkeEudGYAoY262qZ3w8acPGyMpAHyN
	 7RtOIxSsW3gI171HgViaiKPiVljtkUNyF99FHCszdkRNsZqP5T8csPiBfFRiVnfwfc
	 f9lmVHGPx7XdDcAvI89S4O65OlQCXdZF9tKGfQ+h4e5Jo3EOpm5Um6rBY2kWgKGPeF
	 ezXYZohGzAvlg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Date: Wed, 20 May 2026 13:50:49 -1000
Message-ID: <20260520235052.4180316-6-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520235052.4180316-1-tj@kernel.org>
References: <20260520235052.4180316-1-tj@kernel.org>
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
index a811cf6170fa..51b9ae36feb6 100644
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

