Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F413D6685
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264592; cv=none; b=FHSMg/SEdtsSv/W1ySfYIgncFFFuqeHhRlslpvL2WntUG0IhP9hZpBVepxLSn8AKtyLMdeqI2izjUjvxTKPV/QBzfEdgjjdBd99VybCMO0egweKb2+Q8dldJJucZ0SMwiH6KLWM1uqx0SUhBa5r5OcWihWLRDPc2QenhuDJqVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264592; c=relaxed/simple;
	bh=g58oXC0yOB9ZgmWEU14zCZDEq4P/ycU14Mj3fmXOt90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZ5PVmabYd+PHimd0WILCzZv3yUQg8OeXyfiYTQk2IP0xnNPHtVsCPC36FYYU0EkHLHXwqJghFLMaSa3M2DlU/0CDoPaCk5hDoIYnV6TDBVnGcmMMfFy9SrupYo0lNPqSDI58tEKKDD4hMUb7gx7Xn0SRWSXTqQU4wia+S12fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8EXvlWU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8EXvlWU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d572f7437so4394908f8f.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264589; x=1776869389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVV+Ky9W12AgoQ4sF7xbhKNxNphwh0RN9Kn+Yw/MQT0=;
        b=L8EXvlWUR8UZafX/k516YMLsCU1fQc9WeuhnWn+Mrgc4QFJnrRNP0qEE68k3YNNKco
         VYkdwGP7EIDserQEAJRmXhPfDRJOCIxrsQNAdRfZ2qQbOYBkv8ohj12DoaBLc1C3aRAz
         qfzD6xr1UWG2ad8Uyew8lQJtStqqFdGHzK8Ly5dGX+T8P+F7xvv9z4hJidJxXUYF8XFF
         91gvH+jndAiM5ZVvkwE+95RKmPUCRddZzIJS7ABXeaaN/+L3M3ijiCX4OVg70uddxItm
         LoT4GmPkRE7bdVMqX/wCJorhWRY8hQhF/DIQbEsZ9dk/vvKXfmcG2tm8pTfcowVQZa5p
         /V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264589; x=1776869389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVV+Ky9W12AgoQ4sF7xbhKNxNphwh0RN9Kn+Yw/MQT0=;
        b=cNwMQPye2macBjao+iCKG/JNwTiKCxzWCQ1PZMklVRvmg8GehzgVl+kJB/RBxgPjr5
         5umqWpUkMLQnZI2lSLIsOKQn8Ozl57lVxpltGWObiTJNDLXZtrD0FRPQaxKaHMS7P6PW
         1Onb6tQysVBq4dQuJZ3ub72jghJ4nJeHDhgsQlZxQJFlLAAOEfwqS8Q+oQQQyZgeYAqq
         7lptWwAyWnILaF9WBA/Ad34fI6N7W+7fZ1FlrDOd+musfWdEmPxqvKRb7hyskkiI2epn
         4ewkrr6VVf7QBXxk5FI0ELMQSTb9W2JELY6/OZ7HKvIcKuLSBvSPwQAhbv9//U8tkDNm
         US3g==
X-Gm-Message-State: AOJu0Yw9ULg8IQqZaRF96YQ80e8JsnolRoWZ13DyodepDojJio1WwklN
	4uYlSfHeGJa6GAAo2a54vsdE2VLM8IIkLdmw7+gfeyt+CwiCosgTqdB8
X-Gm-Gg: AeBDievYxOA2kOzhBQKlyKBqeo2Ms4QbCkSahEdcLhz9qcp3BFo2dj26IEAYtKp1kI3
	2qN+OkB7XHxjTLLAMhES4InD7Eq8HupDqFI4YiRhfAMmvv9Sy63uXtZBY9YwzpVWurbcehsJlTw
	b+sl+e1stXrj4C6SBl3iXjQ0/nHqD1Y601fJ/Y/WLgxLg8LI436hc0MTKMj/HqmO3G0lEpasYxN
	WxwhO0yC/GIu/gRrMVkZ60ncpAtqroGk9ova7sRpn9y7YLQ8YUtsberfXGBbb48kpoWvKIQde6X
	o8wMZy6BivIrmZDWgX6M9KSsxSzzqYS+LRg7CHVCpUi39irKZ/D3tj4pUN/IGqVHZDnmFkBUCLv
	BHYQ6FXoxMkZtHTiHiupo50H4DBHp9Y+7YNE0K7CNoquxim1hgOaAQ3FZlb7vFMoAGN4Ldf8f3F
	VWQqqnfeaclQDbzfo4K3YUL9A9
X-Received: by 2002:a05:6000:268a:b0:43d:7403:4b60 with SMTP id ffacd0b85a97d-43d74034c72mr22930441f8f.3.1776264587279;
        Wed, 15 Apr 2026 07:49:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:49::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d670sm6066587f8f.2.2026.04.15.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:04 -0700
Subject: [PATCH bpf-next v10 2/6] bpf: Add bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=3072;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=DoE0eG5rHj0KWifLqUl7ml8WiFhcY8jRI8nAChcG3E8=;
 b=Qa/vHTjDVkteGfOATXkWSj9TPUcNxrnJQiJdxBV7sMrR7wVxzkpyifKqwsTetmf1qs+rNnMYl
 xg98H3q4sS1DmSoL7DQUFc/3zaUjwANrEKRNCXiTE6pnlAs3bmtvbdj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_run_array_sleepable() for running BPF program arrays
on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
includes per-program recursion checking for private stack safety
and hardcodes is_uprobe to false.

Guard the recursion check with a prog->active NULL check.
When bpf_prog_array_delete_safe() replaces a detached program with
dummy_bpf_prog (on allocation failure), the dummy's active field
is NULL because dummy_bpf_prog is statically allocated and never
goes through bpf_prog_alloc(). Without the guard,
bpf_prog_get_recursion_context() would dereference a NULL per-CPU
pointer, corrupting per-CPU memory. This follows the same pattern
used for prog->stats in commit 7dc211c1159d ("bpf: Fix invalid
prog->stats access when update_effective_progs fails").

Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0136a108d083..f2c9520e11a8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3077,6 +3077,64 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 
+static __always_inline u32
+bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
+			     const void *ctx, bpf_prog_run_fn run_prog)
+{
+	const struct bpf_prog_array_item *item;
+	struct bpf_prog *prog;
+	struct bpf_run_ctx *old_run_ctx;
+	struct bpf_trace_run_ctx run_ctx;
+	u32 ret = 1;
+
+	might_fault();
+	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
+
+	if (unlikely(!array))
+		return ret;
+
+	migrate_disable();
+
+	run_ctx.is_uprobe = false;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		if (!prog->sleepable)
+			rcu_read_lock();
+
+		/*
+		 * Per-prog recursion check to enable private stack.
+		 * Skip if prog->active is not allocated, e.g.
+		 * for dummy_bpf_prog used as a fallback placeholder
+		 * by bpf_prog_array_delete_safe().
+		 */
+		if (likely(prog->active)) {
+			if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+				bpf_prog_inc_misses_counter(prog);
+				bpf_prog_put_recursion_context(prog);
+				if (!prog->sleepable)
+					rcu_read_unlock();
+				item++;
+				continue;
+			}
+		}
+
+		run_ctx.bpf_cookie = item->bpf_cookie;
+		ret &= run_prog(prog, ctx);
+
+		if (likely(prog->active))
+			bpf_prog_put_recursion_context(prog);
+		item++;
+
+		if (!prog->sleepable)
+			rcu_read_unlock();
+	}
+	bpf_reset_run_ctx(old_run_ctx);
+	migrate_enable();
+	return ret;
+}
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {

-- 
2.52.0

