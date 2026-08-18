Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5D39A7EF
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046995; cv=none; b=i7W1yGxMywvb1JTzs8unraGLNtHDbNGrXHOYS4EBGW0RsWTXlVvrkdsLGMBCw7DOdvL/8WmhGbwwn/NNZ9ErN1bdLxLNqZ+vn8as3pCP+bw3Po1cK7/4+ktMEVBW4qv2eJfX4MLG2fq9gznWbIuUl7lB+rRTktZZihRL5XN9L4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046995; c=relaxed/simple;
	bh=7ibTghDomdFK+AuRMk66RXL/ZL3+I70CKoequsSTJ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKFeVV4L/bOhHAacpXx6BNNogQXLCsBIad6cWv1OE9kY43v05UWDZJ7tddeWXGnagK/Ae0SxskSQiEB0wajKyUSFQx75+KZ7WcZJnQ+RopXA3YuxaN9pPKLxMIU+oXc4Ob4SP5wKm7GKYvmtTsnyCDy7LZqDruf366CcpJMgEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=Fw7sjZAb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="Fw7sjZAb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f84023916so4207305f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787046992; x=1787651792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fXTVcuANg8HG1Ctn5Fy42Q/TSh5wfRVcnMZYRYvZPA=;
        b=Fw7sjZAb/Psmzxp+ewF4YVgm5lyY/FyXUmT6DTcnsR/Rf3yOrmq4oFDXOo2GQUfV6A
         A5IKQpnp4AM+uvXRmHWuwxMmSxZqTmh/kvchNpbmjV+3ynAlKdsy94lePD0cZ121x8ZA
         k1s2nSsYQWFh5K7Ji24+Qri7141s1VyZGu3IfeMJ6VmeeynPgmjVvmoK0PqpU2CnkkvG
         +ZCJeuUcnnG2tGWpK56467QDJc4IN5hRPrFPcx9sndsl5FFHtFyUAjRTgE5PDUHCyoOS
         rHINOzHP0a4dCeHlx9hmDxn/GiBHcCV4T+1ixjEUKsrFL9C/8YRYDqm7381dmUyEfhXX
         VeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046992; x=1787651792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fXTVcuANg8HG1Ctn5Fy42Q/TSh5wfRVcnMZYRYvZPA=;
        b=nbkuHqNq5wgr0Qli7nZ0TU+6wAx9ihNaFOMFyCTixa5YdruPppwf8KGsQqaw2qSFeP
         THYg4GEbLT/JF4lbM7XtbEMo1d7Mz5/SuxtRnhoVjQ7tUmjbbAcuj2bY9+Fs0jM+3TpR
         LRKFD4AikYPqCaNFBfnLOA4m0RfWIgWiYY+9NSwplToFs4V7epfMJWrdI+KNiSHBGevX
         aUAThbjuiEqTpjDipgRhk8nf4E+gmQMwUatwFHQc9T0/t/5UpNeYGAmqjA/Uvs+7mW8/
         qDlRyX1qFHsJfyhXurCuyMbFkiDJfjhRU+08udZtlKZLO5xfo6G+7IIwQgUjWS1tCDp4
         L6VA==
X-Gm-Message-State: AOJu0YxU9MN5Qty0ghwmIWRwofj7KDc+dBsDig5ATLVgTRFhokFA8qhT
	zH3jHTczHCTQdsq4nOv0P+iK7iq9whvtkEagZmJhhD0JXMVaaq5rvcTyYaGGRINNeqWvyAjB4v3
	XlOpnRZuO9A==
X-Gm-Gg: AR+sD10enivzM7KuFz3DaN5edOvIHRQ5mKm2BlT4u8SOe13Pd+gBj0U2bbrJM3l1jVF
	uaglBeDR8ZZoG7CtIAce/HzSgzjo8kALkGg3V/OzHSCricq1SnBFlt0jKwTZWZ7DL2twJLmPPKD
	fli51iGB4Z1Z9GzIxETkBQxP0CGx5hN5kgf3sbkHqLSPCdq22i0StLzOHiAvuhet97VO2YSNbLn
	fkZcfHNHjS+AF6CTopYfH45YVFZ9DrClV/BtDXiQAHiSi/St26cD8r1gvVQW+ZFT99AVan8fsgc
	rRibTVdj0c4XA0N3ebmAbVWnLN1hf2PvhDBJ124tdIp37WHp+7ZZQT4vXZ5Hfz1WAgM6ucZ2bKv
	46pQBsUyY7enPH0ItuOf7dhP4ZPyInGd9Wmddm7sjlDlXU9lvGBXQgnBMsvPbXHv1zBSACn7uJS
	L2yM4xoFdioiIeefxkoHYhGIar7ctzrhFJnxWnaR7mC9xdL2xiRyqbR1I7zVPJXGQdNin2i3OTU
	oJb8qY5HkUw+A==
X-Received: by 2002:a05:600c:848e:b0:499:8156:cd3f with SMTP id 5b1f17b1804b1-4999fb3f78bmr120150495e9.8.1787046991876;
        Tue, 18 Aug 2026 02:56:31 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:508:9a18:a3aa:3270])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81748sm10780123f8f.37.2026.08.18.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:56:31 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: guard classic uprobes against private-stack corruption
Date: Tue, 18 Aug 2026 10:55:39 +0100
Message-ID: <20260818095545.314358-1-simon@swine.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eligible BPF programs use one private stack per program and CPU.
bpf_prog_run_array_uprobe() uses migrate_disable() to keep an
invocation on one CPU, but another task can still preempt it and run
the same program on that CPU. The second invocation then reuses and
can overwrite the first invocation's private stack.

Protect each real program invocation with the existing per-program
recursion context. When the program is already active on this CPU,
account for the missed invocation and skip it. This matches the
private-stack protection in bpf_prog_run_array_sleepable().

Skip dummy_bpf_prog before acquiring the recursion context because its
active pointer is NULL.

Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
Closes: https://github.com/open-telemetry/opentelemetry-ebpf-instrumentation/issues/3056
Cc: stable@vger.kernel.org
Signed-off-by: Christian Simon <simon@swine.de>
---

This is my first contribution to the BPF subsystem. I reproduced the
failure described in the linked report and would particularly appreciate
review of the recursion-context handling.

I have a reproducer, that this patch fixes, I am also unsure if this is
something that should be part of the selftests.

Tests: https://github.com/simonswine/beyla/commit/20c9912a02c5d5924c992faf7ee353c7d71c9fa0 


The analogous uprobe-multi path appears affected but is not addressed by
this patch.


 include/linux/bpf.h | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..11e3d7f00543 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2572,12 +2572,20 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
+#ifdef CONFIG_BPF_SYSCALL
+void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
+#else
+static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
+{
+}
+#endif
+
 static __always_inline u32
 bpf_prog_run_array(const struct bpf_prog_array *array,
 		   const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
-	const struct bpf_prog *prog;
+	struct bpf_prog *prog;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 	u32 ret = 1;
@@ -2635,15 +2643,30 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	item = &array->items[0];
 	while ((prog = READ_ONCE(item->prog))) {
+		/* dummy_bpf_prog has no recursion state. */
+		if (unlikely(!prog->len)) {
+			item++;
+			continue;
+		}
+
+		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
+			bpf_prog_inc_misses_counter(prog);
+			bpf_prog_put_recursion_context(prog);
+			item++;
+			continue;
+		}
+
 		if (!prog->sleepable)
 			rcu_read_lock();
 
 		run_ctx.bpf_cookie = item->bpf_cookie;
 		ret &= run_prog(prog, ctx);
-		item++;
 
 		if (!prog->sleepable)
 			rcu_read_unlock();
+
+		bpf_prog_put_recursion_context(prog);
+		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	migrate_enable();
@@ -3208,8 +3231,6 @@ static inline bool has_current_bpf_ctx(void)
 	return !!current->bpf_ctx;
 }
 
-void notrace bpf_prog_inc_misses_counter(struct bpf_prog *prog);
-
 void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
@@ -3538,10 +3559,6 @@ static inline bool has_current_bpf_ctx(void)
 	return false;
 }
 
-static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
-{
-}
-
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
-- 
2.54.0

