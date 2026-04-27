Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE011370D75;
	Mon, 27 Apr 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287080; cv=none; b=esQtwU82zNyJPY/yQpRWhED3dP5EgwNtZmFbo3bjALXUNU1JJNfx9HqpPKg/mdScGY/CliGGO1EZKkG9HKAMNX1UKQKZFBYOKwdDgbbwkeNc5SQkJZwb4m5QJDv7UpBQ9Nueim/n2ovxrZ6PhTFjsxyh7+nq0D/9ftqYdlEshpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287080; c=relaxed/simple;
	bh=fSyRHcRm5yJIRIePMpBdAMcbUArDSPsYizQfgpQEnUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn7kzDrHHzgObTDNYqKgdCHqqPb5oxO+ZWjDz9WY+3WEKm+UNNKO4snSHA/Nxj//PToIcoUoYeTEYMi5ZNLDPZuLqu7QBkCDa0id8VxxrnRQZf3u/nCd8Vg/xDqARy3qd5GQqonW8yGlaC9krtJSt6diKbZZPlNRapZd93fl0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUwKi4qS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUwKi4qS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CBDC19425;
	Mon, 27 Apr 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287079;
	bh=fSyRHcRm5yJIRIePMpBdAMcbUArDSPsYizQfgpQEnUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUwKi4qSux7D8HqI+FBPguYT+eM4XZgRi5DiGqNj3084TkKIEeL6zFwOSV4t/O8SO
	 XPVLvy3RZIl8ZWbb3nCgKkUzkXfjwFYa89B3bm0S66CfwjBOaNrEEyre5XdJ1vqzop
	 APNIkaGUYpANP64MQNjsjfHk0LFJW0GyVq3M7VGt1cMCWi2tDjuc3obbBuQuiSwHpG
	 SW1RNrosZ4PLEcTj5tEqvc7zmjCob7uqIFqdEqmdtA+0UXwKmjLMVVcreVo+d7xes2
	 JUVf4drbRpjYgR9tuFGBr45v3YgZg0QwImNIGXizQh1UqjCB/v5BwJghNfbncSSicB
	 lPikXNfmekkAA==
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
Subject: [RFC PATCH 7/9] sched_ext: Require MAP_ALWAYS arena for cid-form schedulers
Date: Mon, 27 Apr 2026 00:51:07 -1000
Message-ID: <20260427105109.2554518-8-tj@kernel.org>
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

Upcoming patches will let the kernel place arena-resident scratch
shared with the BPF program (e.g. per-CPU set_cmask cmask) so the
BPF side can dereference it directly via __arena pointers, replacing
the current cmask_copy_from_kernel() probe-read loop. That requires
each cid-form scheduler to expose its arena to the kernel and to opt
into BPF_F_ARENA_MAP_ALWAYS so kernel-side stores never fault.

bpf_scx_reg_cid() walks the struct_ops member progs via the new
bpf_struct_ops_for_each_prog() helper and discovers the arena from
prog->aux->used_maps. It requires exactly one BPF_MAP_TYPE_ARENA
across all member progs and rejects if BPF_F_ARENA_MAP_ALWAYS is not
set. The map ref is held on scx_sched and dropped on sched destroy.
cpu-form schedulers (bpf_scx_reg) are unchanged - no arena
requirement.

scx_qmap adds BPF_F_ARENA_MAP_ALWAYS to its arena map definition.

v2: Defer sch->arena_map = cmd->arena_map consumption past
    scx_alloc_and_add_sched() failure points so an early kzalloc/kstrdup
    failure leaves cmd->arena_map set; bpf_scx_reg_cid() then drops the
    ref via the existing cmd.arena_map cleanup.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c             | 59 +++++++++++++++++++++++++++++++++-
 kernel/sched/ext_internal.h    |  9 ++++++
 tools/sched_ext/scx_qmap.bpf.c |  2 +-
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a078cd4225c1..835ac505f991 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4916,6 +4916,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	if (sch->arena_map)
+		bpf_map_put(sch->arena_map);
 	kfree(sch);
 }
 
@@ -6588,6 +6590,7 @@ struct scx_enable_cmd {
 		struct sched_ext_ops_cid	*ops_cid;
 	};
 	bool			is_cid_type;
+	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
 	int			ret;
 };
 
@@ -6751,6 +6754,15 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		return ERR_PTR(ret);
 	}
 #endif	/* CONFIG_EXT_SUB_SCHED */
+
+	/*
+	 * Consume the arena_map ref bpf_scx_reg_cid() took. Defer to here so
+	 * earlier failure paths leave cmd->arena_map set and bpf_scx_reg_cid
+	 * drops the ref. After this point, sch owns the ref and any cleanup
+	 * runs through scx_sched_free_rcu_work() which puts it.
+	 */
+	sch->arena_map = cmd->arena_map;
+	cmd->arena_map = NULL;
 	return sch;
 
 err_free_lb_resched:
@@ -7676,11 +7688,56 @@ static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 	return scx_enable(&cmd, link);
 }
 
+struct scx_arena_scan {
+	struct bpf_map	*arena;
+	int		err;
+};
+
+static int scx_arena_scan_map(struct bpf_map *m, void *data)
+{
+	struct scx_arena_scan *s = data;
+
+	if (m->map_type != BPF_MAP_TYPE_ARENA)
+		return 0;
+	if (s->arena && s->arena != m) {
+		s->err = -EINVAL;
+		return 1;
+	}
+	s->arena = m;
+	return 0;
+}
+
+static int scx_arena_scan_prog(struct bpf_prog *prog, void *data)
+{
+	return bpf_prog_for_each_used_map(prog, scx_arena_scan_map, data);
+}
+
 static int bpf_scx_reg_cid(void *kdata, struct bpf_link *link)
 {
 	struct scx_enable_cmd cmd = { .ops_cid = kdata, .is_cid_type = true };
+	struct scx_arena_scan scan = {};
+	int ret;
 
-	return scx_enable(&cmd, link);
+	bpf_struct_ops_for_each_prog(kdata, scx_arena_scan_prog, &scan);
+	if (scan.err) {
+		pr_err("sched_ext: cid-form scheduler uses multiple arena maps\n");
+		return scan.err;
+	}
+	if (!scan.arena) {
+		pr_err("sched_ext: cid-form scheduler must use a BPF arena map\n");
+		return -EINVAL;
+	}
+	if (!(scan.arena->map_flags & BPF_F_ARENA_MAP_ALWAYS)) {
+		pr_err("sched_ext: arena map requires BPF_F_ARENA_MAP_ALWAYS for cid-form\n");
+		return -EINVAL;
+	}
+
+	bpf_map_inc(scan.arena);
+	cmd.arena_map = scan.arena;
+	ret = scx_enable(&cmd, link);
+	if (cmd.arena_map)		/* not consumed by scx_alloc_and_add_sched() */
+		bpf_map_put(cmd.arena_map);
+	return ret;
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index e5f52986d317..bcffbc32541c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1102,6 +1102,15 @@ struct scx_sched {
 		struct sched_ext_ops_cid	ops_cid;
 	};
 	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
+
+	/*
+	 * Arena map auto-discovered from member progs at struct_ops attach.
+	 * cid-form schedulers must use exactly one arena with
+	 * BPF_F_ARENA_MAP_ALWAYS to enable direct arena access from kernel
+	 * side. NULL on cpu-form.
+	 */
+	struct bpf_map		*arena_map;
+
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
 	/*
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 2ffea8a93217..edce734c3019 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -83,7 +83,7 @@ UEI_DEFINE(uei);
  */
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
-	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_ARENA_MAP_ALWAYS);
 	__uint(max_entries, 1 << 16);		/* upper bound in pages */
 #if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
 	__ulong(map_extra, 0x1ull << 32);	/* user/BPF mmap base */
-- 
2.53.0

