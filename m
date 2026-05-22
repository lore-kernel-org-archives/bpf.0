Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41BB37418C;
	Fri, 22 May 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470547; cv=none; b=YoMmNu4FzhVbFXAi6fetbOYbJn8aV4FQbT2olSoYxulQFLCBY0r8gVJqGo19mnAY0xO/a8LOhy549cUc5lbjdFtdRxc/Hgmh5sVQkYCXUSNtr1WFYQNiR13roPWpn0nIWE5dLyUNHX6SnWptFv6A1oC5uUgqj+yEienbjj3G5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470547; c=relaxed/simple;
	bh=xLMpuULhE50WLvYfq+YFqn7p7F8PYDLxPc64udyrmVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6hIICaUtCcuD8VK1gLC/dL5hpkYhMsh6+R89WXMvuqzYcXHoIMmLfoBQlPIul33CkIGffzKzjEjSjyJqVGewX/gHNq2cOU3Wjh7GjBCA0Zp3WPTcnV/kuz7RKyXnkEMQSzQdhjliSiuq/FryBgQJBdrss16gXYO/8j40kqDIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHkuq/3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHkuq/3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C931F00A3D;
	Fri, 22 May 2026 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470545;
	bh=zm3BzxzciLeqiOYKZgLYww3y6avzhR84hmtwyjfLNMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CHkuq/3zZYu/tRxaWyme0lClSoZ0f6h5jg484VOcpHXU30VoknM2GFr4KTyBJOCg0
	 pODNVlk82hBzz+B/IkrEooAig0AaETfYG/V2xQXvehxL/amJMLboo4FRDSPj0s41Eo
	 WYggiBT3FzncTdEWCwMeyjR/KkpllOwXPPldaepFhHrqWcprNjHxsH5/eYNQd7lNRc
	 15oqbf0wLQ+y4HXrMQ0NcdN2Oy6zEZChEQqb9q2j0yUcK8LEeZD2KqJlkgW+/VmNvt
	 ZGu/cIlP5U+auQscBl37W+uJpTUdDzGuiXjeBLc3n9CQFxLNcz6zzcrRJJNB8ui1PH
	 93VAkSA7bstCw==
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
Date: Fri, 22 May 2026 07:22:16 -1000
Message-ID: <20260522172219.1423324-6-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
References: <20260522172219.1423324-1-tj@kernel.org>
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
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

