Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BF290DBB
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697612; cv=none; b=KJ50MIv1bOIj389q8IWXIeeC+lt3WrkDS8SHawbCLLk++b5FmEgV6ph/HMhQOcHSLARCjcPzZjkFlTfkgwIS8OHw9e2c87X9tPuVM2yaJDzmLxSiF2vEAYKcCaByfYif/00P8q6Oy5K/HJvlRYjmcx2XvBOaCUMc1pIJxDQxvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697612; c=relaxed/simple;
	bh=pO7dOrRKKE6EBj9fgOOjonSWpvbrnPXRzUXLQxRqp0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgFy2GaoT3izDfD7dhGxWVG38lljK9kDo9RxFJ04n1rYBNsx0vTfV9LOz5sFGsd2TFS2lNn0vSHCFveVgLAzfp7+sNVh4xEtlBPjPuOrcwiPXvIJQYas6JNxGMikwGb3SkKFJuF75BEtnJiIkHODejCuZ4Y9kUrOi07GQLlO0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMPw1qqX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMPw1qqX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so41441115e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697610; x=1774302410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiIpHPH/LiRFI0zTQ2AfMR2nbX64gpX4hcFEAoEXaGw=;
        b=hMPw1qqXmcEvD5k6wOJc/0nj5a3A609rVAaX5puLtPeju2zXDHI0PjcAOQDFNLiAO+
         x5RJtKcdKLlQ2vMC1YXN8gVo1vVR2qua9T1vkNfOgD7ehPjoG8L0t/o9gKzGe1azMjqL
         Fnq6swSsAt1WaIwA76HkJ0brHyXd9mN1m9TYj5buGMKBJEBN93rLyXKvJBB6ljRN/RXd
         C0piNVu6mm+GEfEam5i1JqzQwLaWoZK0gwtGG51EyQ8W23BziP/cTG8s75DXNM2VzZcM
         28TLbOqSRQDfoAtkdTOZRXePoODKfJB5U29+xNiD0CoJDiprWTP+7GwSwWi0uMpvKdTi
         sv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697610; x=1774302410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uiIpHPH/LiRFI0zTQ2AfMR2nbX64gpX4hcFEAoEXaGw=;
        b=jMgX1GX4hiANI+fTmn/3ChQ4r7SrXv/Fd+nSW/DKtyKmhdl5lcVkjESUnr5JFeOAjQ
         A0uv+YzBzBQANvQNmBK6GnRt5rPj5yQmUx4vRfA8rWAeQa5lhC7sbU5SnddZmQA/s8RG
         QBOTz0TcElT+Ig3Tty5AZbhnL5ZObN5CAV7rzobqd1nGdgZKy/qRpvx+2VPBeaVvhuug
         oG0fYysDWL3qNEvEIi/xQ1jYzUyjZt0fHDTMHDsOtO/pv6tkNM+MEDBOZAhjbS3vuBoN
         wEpuU9AqTSCoBTkttW3a0TjA70kb+BqWk5Msw1Mdtl+NK7d2l7Py056UKBgOBE2BHkEG
         1Tug==
X-Gm-Message-State: AOJu0YzcU3H3zDG0c7GXif2BQBqBju3d9Q+LcKaz1IQlD4AjPEItuNdp
	mnIf7s4HpTkN1j3fNH2l+nNiKdiZWl0kxjzxVEtc4WN3X56JOonmw7mg
X-Gm-Gg: ATEYQzwwfPkbZBhkRVY+GFDzIXZVaqsKQfw30XEt448dy9Fzw9p5BWWXYDzp//9exRr
	IJUsQVuILLIYGLPvtWbHJcm/9w1Xq93JH6Np6K9Ns1X6S1YABVZFfGxvNEy7TvWTh4pQSFIR26+
	eH15gA2JyG/pEo3v8LFMX+6Kp02QdHE3vXGYLseIYdUaDcK2D+5aEmtd4vb0RQge06N3PWzTz8k
	vxp59haOjmbnCZUxKWXicfuCw8uw+4UZCE4giKRAhmmA1Deyg4X2mCEpmTgwUOUtQOIPzgJW261
	P9e1E420svboTdQhhjpdBL67dG3DsA0iUwcsNYUsV+NIyO4JI2UOS5hmqHmcKBm1QMjkgTCBGC6
	E6Vc+nIGp9jjJNscJ6D1zuG4ztnKpXfCoOcciiosGFjWYLZ7cPbmeUjolkIreoVZMvYmFsJ+L8j
	wP+LFLCyBa8HjmQQ==
X-Received: by 2002:a05:600c:a011:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-485564981e5mr253121645e9.0.1773697609661;
        Mon, 16 Mar 2026 14:46:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaa39cesm33632625e9.10.2026.03.16.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:49 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:46:44 -0700
Subject: [PATCH bpf-next v5 1/5] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-sleepable_tracepoints-v5-1-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697606; l=3133;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=sgw3eFcmzTkbqJiL3ixcm2e4dPpiTPw+0A8Mk5nCcc0=;
 b=2vNyu6ctnD3wTkyqEYrpL/dNuhVV2GuWgljLdawzlH5jsuOF5xPe+WNDYwSOsDe8G/fJggjTX
 /jRV+DmU5N/AA2DkZLyk98laBYN4UG1PzFXLT9cAXRMSegVhdyOsxaa
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rework __bpf_trace_run() to support sleepable BPF programs by using
explicit RCU flavor selection, following the uprobe_prog_run() pattern.

For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
protection and add a might_fault() annotation. For non-sleepable
programs, use the regular rcu_read_lock(). Replace the combined
rcu_read_lock_dont_migrate() with separate rcu_read_lock()/
migrate_disable() calls, since sleepable programs need
rcu_read_lock_tasks_trace() instead of rcu_read_lock().

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
 kernel/trace/bpf_trace.c  | 21 ++++++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

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
index 0b040a417442..35ed53807cfd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2072,11 +2072,18 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
+	struct srcu_ctr __percpu *scp = NULL;
 	struct bpf_prog *prog = link->link.prog;
+	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	if (sleepable)
+		scp = rcu_read_lock_tasks_trace();
+	else
+		rcu_read_lock();
+
+	migrate_disable();
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2092,20 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	(void) bpf_prog_run(prog, args);
+	if (sleepable)
+		might_fault();
+
+	(void)bpf_prog_run(prog, args);
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+	migrate_enable();
+
+	if (sleepable)
+		rcu_read_unlock_tasks_trace(scp);
+	else
+		rcu_read_unlock();
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.52.0

