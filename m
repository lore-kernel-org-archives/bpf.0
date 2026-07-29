Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB33B3C1B
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314371; cv=none; b=K6WAChX2lToq+pODj69fY3IWHiAkjDxI9ntDJbGavVMdp/1R1ITxHP5PYdKLTnzfAZE94amW9LfKOnRvCMBdLg1Zsp24aA5b54uH9JyeXc34n3dT/Mws5JZTCtwb7GJzUu7y40Rpminvt+DSx7mXtymofDbfWd0hR2qP5fjxF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314371; c=relaxed/simple;
	bh=sWlylSRr+Bye87BIeOl4bVtrPXDsWMSBoB6iGpqQPZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQVettljMc8uIsIoZ16Icx9YAy9Eh0Fz9f7/NGsf5Sd0FucG1vlEsfKOs/8kKmzafc2g/KGpgFf7610jR0Ho8Ny+dflVgrKecoGm6/N3bEYm70Oqg2clTKrJO3zKcy8CGC1DJkQLBGGoGDxJXjNB6TemCO0e1qqJtLKU80IZ/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0TWjlke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0TWjlke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF351F000E9;
	Wed, 29 Jul 2026 08:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314370;
	bh=KO4ga/2yVBAkymDx0ToTFRddI8luYZj8Pq0JF1WBuWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0TWjlkerJraGLCgcOI1jy5gaRoKt24FC1ej99NBmoiNmXdrh+WvAPNsnCZAoblIw
	 HCX8WLvCmwm4qlYBAjQYpskEYtA3JK+qPOpjw7PnS19Rnv/s8eOdanwxFFQvwNAKWv
	 R4+ilhlVjvhFrOtWzMUL4q+eOapKeWVq4ktGpamGf2OCVyjjjxLe3yZvtBbX1Rqy0j
	 9wbirQPLavmgLuDxqPVbUg3CZ0hY9OfSaip12yuSuxRP7+WW7SeC1I3hXT4GlQ5LPs
	 QBmdeIHJQjG72OMFoIQfdkEhTimPQb0epNqqqhF+Bs5PbSXCEQricm0tit2JAqkijR
	 raJkijJsA8ePg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 08/11] bpf: Restore trace->nr value properly in bpf_get_stack_pe
Date: Wed, 29 Jul 2026 10:38:04 +0200
Message-ID: <20260729083807.1588544-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bpf_get_stack_pe The __bpf_get_stack call changes trace->nr value,
so both kernel and user path need to restore its value back.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 05269f2a9e08..875f530f3597 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -942,9 +942,9 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 	struct pt_regs *regs = (struct pt_regs *)(ctx->regs);
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	__u64 nr, nr_kernel;
 	bool kernel, user;
 	int err = -EINVAL;
-	__u64 nr_kernel;
 
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
 		return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false /* !may_fault */);
@@ -962,15 +962,12 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		goto clear;
 
 	nr_kernel = count_kernel_ip(trace);
+	nr = trace->nr;
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
 		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
 
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -981,12 +978,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 		err = __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* !may_fault */);
 	}
-	return err;
 
+	/* restore nr */
+	trace->nr = nr;
 clear:
-	memset(buf, 0, size);
+	if (err < 0)
+		memset(buf, 0, size);
 	return err;
-
 }
 
 const struct bpf_func_proto bpf_get_stack_proto_pe = {
-- 
2.54.0

