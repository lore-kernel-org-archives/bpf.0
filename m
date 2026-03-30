Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB423E1CF0
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909236; cv=none; b=ZyOFPYtECsTwuBDC2t0gFXTIlGGKgieg6Vcc8np6uHoq3kVUHAdn+LLiBwrqDAMjmPMR3k924T32MJcKM2J78LzCwErjlhRWXBrFS+v97LKgjELSozFUGVj8g4HgLkarQCZnMm1TnBnMwAtkr9mlMMoqSZkaJWyLZG+dKIzg5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909236; c=relaxed/simple;
	bh=4E8Oy/63tUfHZhR8J3fq+AEya8PF2+o15mikZUVDtHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhRz7Tc6qIUNvMAgZP45I+un+Xw0n5UGCEphQqcVHazez13m9HgUvq/0FkAN/HewKAaRask0ykzvpg6+qn7MlegB8mmpj9dDYxG5S/1j44bMKh5RZjFaAnETBcsbDGUMv73LP6GXyhl9c7N3AOWy5b64LTjjr78M1JoTMBzYThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH+ibUGy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH+ibUGy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1232472f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909227; x=1775514027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9CM8jVZNl5tymXv0oIiZYLsN+ZjE2v+QqUU/xwH/Kc=;
        b=YH+ibUGy+tL+1fqY+UvuzyLs+AEkyfc/UnrbFEvdJLGhfVt8v+K8eclyM4aZ4A1jSb
         8PTlroYvhTTK5gg9iLyoNma81i1wjg0+d8Gz2g3CgZcsGks0jX0Vh+B00mY7Lgtm/0z9
         XCUndswxIqDSft67VyFEOkDQeCZw6EQ8efO5jWtyTZg53ekzSO6AHY9y4XydcLbDe6gv
         YdCDrpGF3pGoSEDhKtDz4Ss6/Xr0QfI7DVFcmGLfsJqTrjtCTmc4OBWYuyASzaPCiYIy
         /0iSg8LYJAxptwXy4odgRV8dFAHn02ooyrv8T7EBIH7jW3paoAU0ctnBfiXUk0GzyD+s
         cBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909227; x=1775514027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9CM8jVZNl5tymXv0oIiZYLsN+ZjE2v+QqUU/xwH/Kc=;
        b=IiO0vKOwgRlT5ugVKsm5YvC0sOgDR45QneChV4izm8rvfDU+ch25g7bLifnVPatzXS
         GkLPVbNuqm/J9EOXZwxhKj4Odh6z7Cy2bhI9NeTNJxOvazuwJcTpx84w40sqoBPrnna1
         SdBITsUJ0VqBu0UTNpXdFSKmBvfWAgzYym2evZVjqAsFjAC71XfaRAUyR2Fkt8f+jC4X
         JVjdudy9fnVUOlcQFHTV3AXNUGOFjHzjaB9d1ic25KfysoDfiNoryE3krCag5l6bzPdm
         nuy5RLwIEjtX4zdJ0Ra2BDPSATYAhfxSXywwCOVzcXuXFMYksTsImeZPGkvvD2DIv8cg
         dkTg==
X-Gm-Message-State: AOJu0YzmF0SlZoqRSjrDlKEfwOaZ+pA8pZsDcl1hIq82CTHjNDWbOUyG
	Mk+5beHjll5iuTYD+QczZaoZ7hgcBGOvjL84sRyQiceEgX4i8Y37ImPn
X-Gm-Gg: ATEYQzx4wvwy1HJ4rtaIiGlF1v/pRxYrM+j2msvGdlKCLyRuJNkHibFm+1b5Hn9CxgV
	Ju5tkgXjtxR7/JpEob8/0yBU5E/xVhiZ6xaC08YThtDa1zuxzmzI9M5/kgy1xumNR0hdVp2wM4P
	wgVutiXyDRQNjga7JxfKUNW+wvPYGfHlxUV0F/eNnUU9q2b0cgmzDoD8i+1Bj+lrAAsYz6YJGQX
	eTLF0abZ1a3DfrdtrxRSGxnFoLpxSAfF0Y/ntScs+E9AZuyKpjWdQVQM0LB4ZaCDCN7pK1jluSh
	9zML6b/BIBJo8kf4ktlm6k3o1HSUHYfI8VRHKrRZo/oA2QkuH0j+MSKxJxfTsdk4mJdCTYygcFL
	wQFH1vjwhMfVz8R6vv44Py2qlQSE43RaywM/WJJFbl897XCbU4gaXrkzz7RgsiDS40zPz15EOB1
	AHKtii/hwhC4vrKZouPOX5766H
X-Received: by 2002:a05:6000:2311:b0:43b:4d37:cd37 with SMTP id ffacd0b85a97d-43b9e9d9566mr23888789f8f.7.1774909226991;
        Mon, 30 Mar 2026 15:20:26 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf257b72dsm22676545f8f.34.2026.03.30.15.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:25 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:25 -0700
Subject: [PATCH bpf-next v8 2/6] bpf: Rename bpf_prog_run_array_uprobe() to
 bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-2-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=2164;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=q+yGE2PCqaHcXDWfXwZ9MIc4TFEHQaRnH/P4Ow1utLY=;
 b=wwT1mkGl/YPMQmxwpTei1fH5HhMe+NJ9YQYxbRDgRhUkq0IQi4KABN60LQOZYM4i5Nc8MgqSo
 +FTbxp0y3JjDGNsq3oeOomzrD50RweZBvR4xFXBcYqXBG/yVfa1Pob9
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
to reflect its general purpose:
per-program RCU flavor selection for sleepable program support.

Add a bool is_uprobe parameter instead of hardcoding
run_ctx.is_uprobe = true. This flag controls bpf_get_func_ip_kprobe()
address resolution and should only be set for actual uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h         | 7 ++++---
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..9fe19ab21cfc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2487,8 +2487,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
-			  const void *ctx, bpf_prog_run_fn run_prog)
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog,
+			     bool is_uprobe)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
@@ -2504,7 +2505,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 
 	migrate_disable();
 
-	run_ctx.is_uprobe = true;
+	run_ctx.is_uprobe = is_uprobe;
 
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2cabf8a23ec5..eb4d78e689ac 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1402,7 +1402,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 		rcu_read_lock_trace();
 		array = rcu_dereference_check(call->prog_array, rcu_read_lock_trace_held());
-		ret = bpf_prog_run_array_uprobe(array, regs, bpf_prog_run);
+		ret = bpf_prog_run_array_sleepable(array, regs, bpf_prog_run, true);
 		rcu_read_unlock_trace();
 		if (!ret)
 			return;

-- 
2.52.0

