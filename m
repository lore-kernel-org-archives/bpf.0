Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5823B7B80;
	Mon, 27 Apr 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287075; cv=none; b=pGzSCnxoQD3/aWpJ1EkjxmtH/PUeDnrimlfljAUWsPGvT/wd09bm9FWcWzLQZW7oYLRvdqQapdc1SpyNoiti/QIrSLb+DGTKEZx4Shfsx0tcg5RNkDi+2VEExH4sMo+N51DuR4Y0ksY9apgRYkgjCsvB4eKEW7cSp0eq6wIjL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287075; c=relaxed/simple;
	bh=Gp8+TdrhpXcco/Wb0LGIcih10W1SsNl8/Gn277i6Qd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giMAvsZ8Mgsfx3LMtBVvjjipvZuQ3qw90qFBbvzGEppIzA7ohyBpCfj8eZCpw52FhHFNDUNO2DZlqA4mZvtST9QY+bolhZZSFEWEg4uC2FicSWF4F9Qiw0tOtZ0s59ed1/hAWM4muJZtdr3rVFtUxxhY44nSenbCL2MP/QfY3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrxYwWjR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrxYwWjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C63C2BCB6;
	Mon, 27 Apr 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287075;
	bh=Gp8+TdrhpXcco/Wb0LGIcih10W1SsNl8/Gn277i6Qd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrxYwWjRiNjevPby2mP/gxq6tc3nu9kmwXAa79KluCnf5t2MCN8l12I6HaKilGWU/
	 4cFYykdDZ/s3Lvbzygn4pr5pQZJ6nisI+TBbsNtnAzHeCqmg8/JCBHungegeOcs2Oz
	 B4sRSpI5+wpfVRo6JZK0AZLdk7uCs3pVsUw106IObU6ihSC6EDyjOCFjtGwT7+3OWo
	 88g3DfVd2we5dA8RreIxZW1zEvZbigHiaIM1eIScxiLEbINdHMPdU4ef6y6sYvoj84
	 5pdgHrsy90OGgpdAo4FWa4PX3E3tmuuA4CSNOZh+ouIGw6A/VljO284oVvMlnJUD/1
	 x3q5OA8ceFJNg==
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
Subject: [RFC PATCH 5/9] bpf: Add bpf_prog_for_each_used_map()
Date: Mon, 27 Apr 2026 00:51:05 -1000
Message-ID: <20260427105109.2554518-6-tj@kernel.org>
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

Wrap the prog->aux->used_maps[] walk and its used_maps_mutex behind a
helper. Existing in-tree callers open-code the same lock + iterate pattern
(e.g. bpf_check_tail_call in core.c, the verifier and syscall paths); a
sched_ext follow-up needs the same loop and would otherwise reach into
bpf_prog_aux directly.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h |  3 +++
 kernel/bpf/core.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f4e4360b81f6..587e5ff387bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2338,6 +2338,9 @@ static inline bool map_type_contains_progs(struct bpf_map *map)
 
 bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp);
 int bpf_prog_calc_tag(struct bpf_prog *fp);
+int bpf_prog_for_each_used_map(struct bpf_prog *prog,
+			       int (*cb)(struct bpf_map *map, void *data),
+			       void *data);
 
 const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
 const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 066b86e7233c..aa590a817176 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2510,6 +2510,35 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 	return ret;
 }
 
+/**
+ * bpf_prog_for_each_used_map - Invoke @cb for each map @prog references
+ * @prog: BPF program whose used_maps to walk
+ * @cb: callback invoked once per map; non-zero return stops iteration
+ * @data: opaque argument passed to @cb
+ *
+ * Holds prog->aux->used_maps_mutex across the walk.
+ *
+ * Return 0 if iteration completed, otherwise the first non-zero @cb return.
+ */
+int bpf_prog_for_each_used_map(struct bpf_prog *prog,
+			       int (*cb)(struct bpf_map *map, void *data),
+			       void *data)
+{
+	struct bpf_prog_aux *aux = prog->aux;
+	int ret = 0;
+	u32 i;
+
+	mutex_lock(&aux->used_maps_mutex);
+	for (i = 0; i < aux->used_map_cnt; i++) {
+		ret = cb(aux->used_maps[i], data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&aux->used_maps_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(bpf_prog_for_each_used_map);
+
 static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 {
 	bool select_interpreter = false;
-- 
2.53.0

