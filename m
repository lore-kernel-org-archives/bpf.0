Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA1388371
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791710; cv=none; b=X8KQa+4StEFa/54tNJ/ElUsJ5UNDfhCj7CjDQJPsaA7nuncdzs9zZs3KPGpMl08Wka5vUjMCzol5vIyOPPlxytsqc16EUyQla8Fa6WjxZcSD6S3LInwv1D/npOl68RczToJKQpQQeKxi2VihJ95vKVxqd+HB1bs/uhc+efFWJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791710; c=relaxed/simple;
	bh=XWddeoSwc8HfvRr5fmlxdGUJ/ehsWzVbhtVhfGxaQB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0FqFQi8ZBTR16Ssfk7ZeEJu5TDqeTqFUGw7gQYEdSAOHy9xB1pKRWeTnSAdOWOoL531m9eUjkhq0wjZglkjeUMLPwpD5tcJnrMPqPw9hGewjJznd3AVtpLy6QUmwCNk90SYNMu7gs0629FwDTXDt8Zh50vjuWToN320zUoYGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqLOS22L; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqLOS22L"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfce3a195so2701254f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791707; x=1777396507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAj3O/5L31LTKKcYOG4RF6i8aNfBvjZVnLaJGYqD3oY=;
        b=BqLOS22L08cn0YZW7Ob+2gPAlOIiXAMQXvwx8bBV/YZWRNue1USscZpB0uC1cKxpzG
         cvY6/1kq2iXTTEp54ATlwGOR9YvIA4/oYZEf3rfN3FMW/fkcILWLdtuG3WLF/GtIxwwN
         L9Ew22vZzVErw6bXxOQu7IefezWYDo1ZAF4HS/g6HX5X1Jzszw7l680ETiNz4zrYx1/l
         k1BWw49cn4neNmPWHJvVrQY2OCFKhIzLhDXpdp5e1mrJoOWeHWMJYBiIqGpUfW+Nw0Go
         cpTNHGl0+8ZhnxQOGsYktjYXqXC0LF+3fC7yUGzohLVy5XI6oxLDGXYXhgHitAfEqZzk
         8W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791707; x=1777396507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hAj3O/5L31LTKKcYOG4RF6i8aNfBvjZVnLaJGYqD3oY=;
        b=NKBLAOBgA2ir4R9zkoUx6e7zvlw8K8yQQnavNsKwBybMJdX6LLhZh7Byedmwt67kFt
         rjJN21IdsLJjUvFWYh+mcF6YjGG0gdfVMOliP/CGxqGJ0AxLvL0ugJjiSYhBrw2d1Ybp
         ScPEeRlRV4OUECD9QZH9iKa27Py1RToitolG9ggErzzH04fmniQ9FAJ7Fn03iYxsnJyo
         xQeBiFr5JE5cEtrzyFyJogeBG8dK+wEf9w3BL5uRiu2ByVc1hOfBBfbYuur1wTMzQlby
         8zoeqKF7SLSSGJ2efKQxNtVeHWiEtaSAvzh8QuSaGI8uo6lm+/mIrrA8s7ieXJOLkuIP
         1ucg==
X-Gm-Message-State: AOJu0YxUXaknEpI3szQ9RCjgUcijgB0OSMf/MdH5oySuk8x4acbYNVS1
	IKkELC2CuHxtIanY99ly+6iPsOYdGl9/IAmTBXtT1je//hrPVk1d3Lta
X-Gm-Gg: AeBDietHx/wWqOB8Rlkt39txnlUdDJ8c4Fz/ZUaClYhV/98vERCfCfprqsn9mwsLTmT
	Ikv7JF9s6BegMMotjs4VR2ROV+PjtBOfLJoB1JBNx2UCXW+SNOj9oachQ/4nqT5KeQ2LjPw/ONm
	AE/jJiK/9xc413R3BsyAwZDSIMxvZMdu9GEXOzg6+BWjuN1MJc3tcX6EtZRJAvuWWOExVhxlVIz
	R9FmNmSTb8Jr45ybXyyfeMV/RV9fnuLteGA+lx0Si+efsnpcuN6J3GKOglD9MFXJ6lZGOdC9L3u
	CKGKIrF2QROc3yBw0M7Lt+8hMKTBPo8prro9rYm2Aka1Fkv7pYlIDO15AXhrN1Mk3mZkubEPAba
	CF/W/eFBNsINqk+M01hqVMh34s0IJDYPInfDDtoYaUA0WegvY6Np61ZNyvgujF6/Z38O0vSuYzJ
	kOFE/a+9hh/J++2BpdIY15XIw=
X-Received: by 2002:a5d:5cc4:0:b0:43f:e430:e6df with SMTP id ffacd0b85a97d-43fe430fc09mr21040836f8f.1.1776791707267;
        Tue, 21 Apr 2026 10:15:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm43077031f8f.29.2026.04.21.10.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:15:06 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 21 Apr 2026 10:14:18 -0700
Subject: [PATCH bpf-next v11 2/6] bpf: Add bpf_prog_run_array_sleepable()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
In-Reply-To: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776791702; l=2651;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=7RBwvgzWD4FCca/A7yTia5TPEw2bH5uCrOjWqQ1Vbm0=;
 b=joceEFzmGuP02plunV1dNwCfQWEYopDPez0kv60o6uc48GGTwPwYJ9VK8qiJSbuWQeQOMHo2R
 vGOJTChSNKnAYLUiY7BdmQdVLyjagxNBcFtFSmzO7B7rWNgcKGr6X/p
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add bpf_prog_run_array_sleepable() for running BPF program arrays
on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
includes per-program recursion checking for private stack safety
and hardcodes is_uprobe to false.

Skip dummy_bpf_prog at the top of the loop. When
bpf_prog_array_delete_safe() replaces a detached program with
dummy_bpf_prog on allocation failure, the dummy is statically
allocated and has NULL active, stats, and aux fields. Identify
it by prog->len == 0, since every real program has at least one
instruction.

Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..b6e96c939846 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3079,6 +3079,61 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
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
+		/* Skip dummy_bpf_prog placeholder (len == 0) */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (!prog->sleepable)
+			rcu_read_lock();
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			if (!prog->sleepable)
+				rcu_read_unlock();
+			item++;
+			continue;
+		}
+
+		run_ctx.bpf_cookie = item->bpf_cookie;
+		ret &= run_prog(prog, ctx);
+
+		bpf_prog_put_recursion_context(prog);
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

