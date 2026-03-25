Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BE34B676
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464958; cv=none; b=DSuq62w9YubCJHrXql6kGlZFzISre+7CeJYsG9jCAeDX2ZAmHvg5KEB7ScQeZ1YrIuU35XOSgfZVyLQgae3h+H/L1Yx3XhUWnuUdnObSXH9nvDnTi2PRNygYCREk0zkPanTe6fH74UVHflMb3+hnYUZ8aq57GGQLSOaUJUOkvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464958; c=relaxed/simple;
	bh=7odeiR1UxXUFLeAlkeetnQnDRYwtHRETAUycz5qrZoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fkbo9wUA9S2YbD3e1o/fSMIedH9TTc9SXsPx0GNSN1M8ojx+FOj2nGnKAjVB0uxl0XYCxIMKZu+qyPZ62Fy8+PNZ2Klphgb4YI46ogUCJGK37jyJg8zlAgkdzBRe6thFokWcAMgAEzYz9VpWixk+ndBTgMtEDC61eXCtGznW4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQoeLcUP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQoeLcUP"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483487335c2so2487015e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464953; x=1775069753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ff+RoIi18nAXCB2Qy0aYaoHJgg6rTK0tFPRDjjhVwO8=;
        b=lQoeLcUPHofs056qzWzxfMbhOknqh4ngZhCfM3iO5VL9c5D5gC/gboZ+WQruM4yc8L
         2xod7uy1EW1k+r5QKzPAWI9bBZ7HabAii0pP131SfQxyn56WQOgPBqC8wgeS7MLiW45h
         +5a6ur7lIFTVZiI+Ms/iLKkPY86y6Dh8/WTF2kDDmCavjWHjGrv9IpARzEWJZtX91itH
         q8s0uHGIPcIuexAkRrmIMLXoGBcy8yVqCXDxtKBAX9Nx74gk4u5Hky8EMNvJ6NsV9U56
         g44+tWUF4bqBNxhi0cS9+TNgDUdRLS1dVkYV9TGVtbqpuhQz494LxEUMaVlDL98EK1+T
         L6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464953; x=1775069753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ff+RoIi18nAXCB2Qy0aYaoHJgg6rTK0tFPRDjjhVwO8=;
        b=JacUzFtdD3swoYNXLwrcNjVwAwKwEICdM1Zf8hsFPISQc6p0eZjv9hMLhsJ1gPtUCH
         S8///SBqKvyP+4cjjqZq33VxnNPn3e3/99KX/BIgeFEejGaC6l4pD9FH9gP6USAIvEr7
         Sh8/ncfZg4BdHJnvwLP1cTdYSh2LAJKLVlJWYCNDxeiE88krqiW99RBJEmWZBgXzaWG6
         1aCQYWNQlwjymWc689gNMTa7fuMh4H15ZuLpovklV8JtaLwuBfSwWnatKLqodMV6iG58
         U8fisjJ20/xQOZFxTB6HmEkwa9qQFCc6mrKm4DeOaCiMpvUz4OoXE0P8igaFm4vRggTt
         9m1A==
X-Gm-Message-State: AOJu0Yza/j44TomrO0DH6aGCT7baBCqMCqa0TxOv5uUNNuFJtClx/YZt
	Govr6fCeOcargNpXvgrFWqvkM+YsG7OG2hc6bB/ZaG8XHV2JTrJVv5i/uJHmIWzX
X-Gm-Gg: ATEYQzwTIgSeKvrnU5PbDsEx+pT8oLz0tRsUIe9aJZGAhd/1mG4JtdBQCzz6NGB4KER
	4NfJ4hYOBEXd0GjFfWCrMPinZQFXYdXdO9ofqTyVnlrsTzt03UHPxj8Pguk/iCtapIb9oLho5q1
	jpqXWiHYUvIlptzBSMaVv7f9+uGmPHbzoSSttcqDv3l7wUIVzKwIyszzYDG0sUZ6fZWnz9p3OWI
	ILk8zON0/4QdMd1Qm+NJ4L+adK6gK9on0VqicrVN7snje/swxkVUtbnZZz3pl6RhmVoqUt6nwnu
	SqOfsKi1/WuuLPnwegYkuikf5ca6H/RIrKJ5+bhlAz5gwc9yeg/M5z10JzjBCm+hhZAIFpdc+3s
	WEOjPSPSDXKdDG1v0IRNdJzqosmBUEY00ihPEEi8VBcNLdrdITd2pF/erMMCno4EOWxy1Pey7JK
	FpHW1yhv2VbjKX
X-Received: by 2002:a05:600d:d:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48715ff7846mr56730695e9.15.1774464953301;
        Wed, 25 Mar 2026 11:55:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb7f50csm124755e9.17.2026.03.25.11.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:55:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 11:55:18 -0700
Subject: [PATCH bpf-next v6 1/6] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-sleepable_tracepoints-v6-1-2b182dacea13@meta.com>
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464950; l=2943;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=+s11TjBolpyRuRq19qEAJV6o79MDjAh8c1ZgBdTFe0I=;
 b=FAXpYbiNfvmKrvpCS25TGBaH5oool1mpbQE0CEfTXRtbDBCkAalRWu4GYFlt4t3jqsZn+bC5O
 6/5/mkqNs10DhIOWpIzYoBya7HlBE96WvF9syiiHFLQlqeEFMnpAK4J
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rework __bpf_trace_run() to support sleepable BPF programs by using
explicit RCU flavor selection, following the uprobe_prog_run() pattern.

For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
protection with migrate_disable(). For non-sleepable
programs, use the regular rcu_read_lock_dont_migrate().

Remove the preempt_disable_notrace/preempt_enable_notrace pair from
the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
migration protection and RCU locking are now handled per-program
inside __bpf_trace_run().

This prepares the runtime execution path for both BTF-based raw
tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
sleepable BPF programs on faultable tracepoints (e.g. syscall
tracepoints). The verifier changes to allow loading sleepable
programs are in a subsequent patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/bpf_probe.h |  2 --
 kernel/trace/bpf_trace.c  | 20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 9391d54d3f12..d1de8f9aa07f 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -58,9 +58,7 @@ static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
-	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..8066249e4ba2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2072,11 +2072,19 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
+	struct srcu_ctr __percpu *scp = NULL;
 	struct bpf_prog *prog = link->link.prog;
+	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	if (sleepable) {
+		scp = rcu_read_lock_tasks_trace();
+		migrate_disable();
+	} else {
+		rcu_read_lock_dont_migrate();
+	}
+
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2093,18 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	(void) bpf_prog_run(prog, args);
+	(void)bpf_prog_run(prog, args);
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+
+	if (sleepable) {
+		migrate_enable();
+		rcu_read_unlock_tasks_trace(scp);
+	} else {
+		rcu_read_unlock_migrate();
+	}
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.52.0

