Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428273D6CB0;
	Wed, 20 May 2026 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321063; cv=none; b=m6rzs3OtyKfc3Z9lWk/aD+pTDHPKS3MmjVIEDBD/doKakgUq0IXdPiLS1lM8DaaJ6xWPkZ67Mcp0GD+J8Rm+AKkVjwcVPHw8+9L9/B7M2ZMEBEcJuny+shlqm8ob3wELe/e2qzvDnpqP1iT1v450HrburXdxB9Sp5EDPJSkPrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321063; c=relaxed/simple;
	bh=gAhSm/A7m/KGNOlWACJ+UAUs88/KJw2C2PierBx6oAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzCmyBJ9DlGgdsc2j31tizNZ9YXbHutlszVw/Y8n6UQJGfjIMN1PdFduyu+H5+8sDH4+h89Crl33QtVviurg3WCZmQZvNhKO87inBe5QnRO/4mWRHj6suUCp1XN6yhUHexM5dvSF0eRUqZNi6uWhfTskT0FIarMqs7BTZEpOpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgSN/KdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgSN/KdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227501F000E9;
	Wed, 20 May 2026 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321059;
	bh=sbJzbEe9LMJc1rQzaTZ5LdfH3ajTdvTiiElyoPzYFs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgSN/KdVR3zq/TjNUrWd9YMKP6VkcMFw2GUc2tW72tCeXwq26TZ4WcFXlsRTdETyC
	 4VOhUynf/LNMzFHwu2oqgn7acvOFij/EyHIP239K02uOp+TRS3d9WF2PJ/PiWNOs4b
	 nbU50GHUlzPZLJbVZDV4dv5AgncLYxjL86iTv5J6QllaGh7iUpnTpqKm3SfwzuU524
	 6AnXUO73Me22oIUnFnD/wual9YdznUcYI76EHz6sQrCo6uNlLCJwWzKUc+xlwC8Igj
	 ILtFtu6fFiLlk3TGFj8v4oapfVV6IDSLe7UlbPtDkyg6HeQXqbo3pXixzmRBeHUN/D
	 GN1UQg7jR0bjg==
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
Subject: [PATCH 6/8] sched_ext: Require an arena for cid-form schedulers
Date: Wed, 20 May 2026 13:50:50 -1000
Message-ID: <20260520235052.4180316-7-tj@kernel.org>
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

Upcoming patches will let the kernel place arena-resident scratch shared
with the BPF program (e.g. per-CPU set_cmask cmask) so the BPF side can
dereference it directly via __arena pointers, replacing the current
cmask_copy_from_kernel() probe-read loop. That requires each cid-form
scheduler to expose its arena to the kernel. Kernel- side accesses are
recovered by the per-arena scratch-page mechanism.

bpf_scx_reg_cid() walks the struct_ops member progs via
bpf_struct_ops_for_each_prog() and reads each prog's arena via
bpf_prog_arena(). The verifier enforces one arena per program, so each
member prog contributes at most one arena. All non-NULL contributions must
match and at least one member prog must use an arena. The map ref is held on
scx_sched and dropped on sched destroy. cpu-form schedulers (bpf_scx_reg)
are unchanged - no arena requirement.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 56 ++++++++++++++++++++++++++++++++++++-
 kernel/sched/ext_internal.h |  8 ++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9c458552d14f..56f94ac32ba0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5003,6 +5003,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	if (sch->arena_map)
+		bpf_map_put(sch->arena_map);
 	kfree(sch);
 }
 
@@ -6746,6 +6748,7 @@ struct scx_enable_cmd {
 		struct sched_ext_ops_cid	*ops_cid;
 	};
 	bool			is_cid_type;
+	struct bpf_map		*arena_map;	/* arena ref to transfer to sch */
 	int			ret;
 };
 
@@ -6913,6 +6916,15 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
 
 #ifdef CONFIG_EXT_SUB_SCHED
@@ -7898,11 +7910,53 @@ static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 	return scx_enable(&cmd, link);
 }
 
+struct scx_arena_scan {
+	struct bpf_map	*arena;
+	int		err;
+};
+
+/*
+ * The verifier enforces one arena per BPF program, so each struct_ops
+ * member prog contributes at most one arena via bpf_prog_arena().
+ * Require all non-NULL contributions to match.
+ */
+static int scx_arena_scan_prog(struct bpf_prog *prog, void *data)
+{
+	struct scx_arena_scan *s = data;
+	struct bpf_map *arena = bpf_prog_arena(prog);
+
+	if (!arena)
+		return 0;
+	if (s->arena && s->arena != arena) {
+		s->err = -EINVAL;
+		return 1;
+	}
+	s->arena = arena;
+	return 0;
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
index 7258aea94b9f..d40cfd29ddaa 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1111,6 +1111,14 @@ struct scx_sched {
 		struct sched_ext_ops_cid	ops_cid;
 	};
 	bool			is_cid_type;	/* true if registered via bpf_sched_ext_ops_cid */
+
+	/*
+	 * Arena map auto-discovered from member progs at struct_ops attach.
+	 * cid-form schedulers must use exactly one arena across all member
+	 * progs. NULL on cpu-form.
+	 */
+	struct bpf_map		*arena_map;
+
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
 	/*
-- 
2.54.0

