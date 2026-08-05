Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9A3C7E1D;
	Wed,  5 Aug 2026 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902718; cv=none; b=PR42H/K++qnLqcsHpyBMfxLt588eAddSVNgumlsld+rFxhDw5DDxDOTKTYTeqS99gmQVnVRzEsno9ClrvpB2mJgJnU1HxSt1CRWXQNRQlJu+jMOzepqHwyZ6Cut0f6mxKbrerQGvEGOVzVAbIbtck5t1fZNydUaeELgHnQpRYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902718; c=relaxed/simple;
	bh=VJshfN0f2GhM35uVuDa+UMCpOWB/U95MkVkRlcMCKdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV3TIca99kacD8VXnbwPpzoP1QWPtEWDotjGqQATSkhQbDtT7Fn9clHtFDgq3IVuIC1y/xIQJqIciNBFXIqPzyZ6TV6sjtDIy1MLJwrB+UBYNIyG6Zff64MbHpLyTugsJ4gaDj/BpGdDpWFKg0MVeVUiLcKvN9K7I9Y2byYyuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BcP0BIMd; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BcP0BIMd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785902715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1MDUL8pgO9d7aOgyIh4zK7UhpDcJDYhUJ+F2MSyPzw=;
	b=BcP0BIMd0TKBmOW3AXk0SGsudPQxP8LX73ngCbLJK6HVRgVaUGiravhIGlrD06yU0uhlBV
	hZbGRrGFw36/fRj3Uns+OK9RniyDnZ5pq9eejUc+ls9sKkxju5E4LgAIT+Zfe1yLqtzMzF
	q+6RUIUZxkoJLG2QW1yFUk5Bh9/JOLQ=
From: "Hui Zhu" <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v2 3/3] bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failure
Date: Wed,  5 Aug 2026 12:04:08 +0800
Message-ID: <0e91fde8222bcfc0b318cfa2dcc3e06cc476c1a2.1785902527.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1785902527.git.zhuhui@kylinos.cn>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

If bpf_trampoline_update() fails in __bpf_trampoline_unlink_prog(),
cur_image is unchanged and still has node->link->prog's call baked
into it. All callers only WARN_ON_ONCE() the failure and then
unconditionally free the prog -- a UAF.

Fix: on failure, pin node->link->prog onto tr->cur_image via the
pinned_prog mechanism, so it outlives the link. This covers both the
multi (bpf_trampoline_multi_detach) and non-multi
(bpf_tracing_link_release, bpf_shim_tramp_link_release) paths.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 kernel/bpf/trampoline.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 7fac27374ece..6071261fd66b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -991,7 +991,25 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 		return err;
 	}
 	bpf_trampoline_remove_prog(tr, node);
-	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
+	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
+	/*
+	 * If the update above failed, tr->cur_image is unchanged, i.e. ftrace
+	 * (or the direct jump, for the standard ops) is still actually
+	 * calling into an image with node->link->prog's call baked into its
+	 * machine code, even though this unlink is being reported as failed.
+	 * Every caller of this function only WARN_ON_ONCE()'s a failure here
+	 * and then unconditionally frees the underlying bpf_prog, which
+	 * would be a use-after-free the next time that image is executed.
+	 * Pin an extra reference on the prog onto tr->cur_image so it
+	 * outlives this link, mirroring the fix applied to
+	 * bpf_trampoline_multi_attach()/bpf_trampoline_multi_detach().
+	 */
+	if (err && tr->cur_image) {
+		WARN_ON_ONCE(tr->cur_image->pinned_prog);
+		bpf_prog_inc(node->link->prog);
+		tr->cur_image->pinned_prog = node->link->prog;
+	}
+	return err;
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-- 
2.53.0

