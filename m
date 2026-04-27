Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EF3B6362;
	Mon, 27 Apr 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287079; cv=none; b=lidpK71jO9/7VNOunbypY6qO1+xIvxq3wF9HZLiems+pLFCrxSO1+kIrD+eXwbiIbXTSLzMngoTmhXBRQn1vFXq6+AuSd6P9Fgd0f2fww+dDgaPd1DXVohjCY4iuzCzxu/sBCNIkVmzjRRlvu58T++gAaYiaYIuneXF/ItrKXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287079; c=relaxed/simple;
	bh=krkDGHCsuOWceSoEWbgMlL9Rq3jZimHTEyp9LReL3Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX1Z1HxHG3ZF4m8qkDBKVRokVypcJKG59ig6ZfHjuQBnDz93S1tdR44Xsvcci7V8RWPFzrbOXFEB23CVqO2OAkNpBLfD9S5efsTlUnsTAYk300bAtYMfXI4UiivSpdSMCiW0+ChWQoo3Ne6x2++fKbxxPyITmjwutyh0b2JkuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJPgv4pP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJPgv4pP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8062CC2BCB6;
	Mon, 27 Apr 2026 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287078;
	bh=krkDGHCsuOWceSoEWbgMlL9Rq3jZimHTEyp9LReL3Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJPgv4pP72qDdQ5qddvta2RZa7zvafVzDH1Vvf/DaYEGAzuQUX4NwTaX9jmixSpQP
	 gmdSvypu+jFmnSxwfpKoog8x9zDVd7sVZU3BJyvmNeCaTOX+Gf28j8X1/4t3aKnqSV
	 s5bOVDC2d7Chni7hPTKx0cZ/gGvCZ5z3TNtL23Kwr6bueguI0Iud6HGXIdpErpYAzr
	 iiIhyqiQWVShmRWRoeYiFJZ+OE/SXyq1V/+MNij/jRxhMjq5QAkllALoExIlvRosRA
	 8sel8uHJnJKMnxjkzfi1orIpXv+RG2dol/EYaoGkK2IbcRXIWjNf4NsyD7rzlp9AE8
	 cKSjLXOXSAPug==
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
Subject: [RFC PATCH 6/9] bpf/arena: Add bpf_arena_map_kern_vm_start()
Date: Mon, 27 Apr 2026 00:51:06 -1000
Message-ID: <20260427105109.2554518-7-tj@kernel.org>
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

bpf_arena_get_kern_vm_start() takes a struct bpf_arena *. The struct
itself isn't exposed, so callers outside arena.c that hold only a
struct bpf_map * (e.g. struct_ops subsystems handling an arena map fd)
can't reach it.

Add bpf_arena_map_kern_vm_start() which takes struct bpf_map * and
container_of()s to the arena, with a type check. A sched_ext follow-up
needs this to translate kern_va <-> uaddr for arena pages it claims.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/arena.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 587e5ff387bf..1614af65a2d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -617,6 +617,7 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 		      struct bpf_spin_lock *spin_lock);
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena);
 u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena);
+u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 73e43617761c..d67a6000221d 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -85,6 +85,19 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
+/**
+ * bpf_arena_map_kern_vm_start - kern_vm_start lookup by struct bpf_map *
+ * @map: a BPF_MAP_TYPE_ARENA map
+ *
+ * Return @map's kern_vm_start, or 0 (with WARN) if @map isn't an arena.
+ */
+u64 bpf_arena_map_kern_vm_start(struct bpf_map *map)
+{
+	if (WARN_ON_ONCE(!map || map->map_type != BPF_MAP_TYPE_ARENA))
+		return 0;
+	return bpf_arena_get_kern_vm_start(container_of(map, struct bpf_arena, map));
+}
+
 static long arena_map_peek_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
-- 
2.53.0

