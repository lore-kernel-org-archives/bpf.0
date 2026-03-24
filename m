Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA430DEB5
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379034; cv=none; b=ntRGKdUVUyjhDmO5JKweCvuHbw/l4/Hc4FurLTvcKDSFQ946Mp5AGHjLPgV24fNCvROHVPNYB76fgd7hAeomWp7Xz2iOM7s4eKEzu7+2s857bgEdYJSsOTdCLqUznsnu6BzQkQ4SAwHBokGNvfnfsoD5zMBWV3t+7GJuBM6bXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379034; c=relaxed/simple;
	bh=pO7dOrRKKE6EBj9fgOOjonSWpvbrnPXRzUXLQxRqp0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTuJdBJJ4LFlO2eUZMbwU3fHQPAfEPwYtfVixNxQaX3yWBVfp2hxEiO2OKkWeN88qxzVQP1ruGScJAEWsBZCmEL66BWyksNNnzwNZxh8Bbq1JBMSEehqhbmzGT2zVHf9A62iMFAWY8Sjh3qPy7W3LUustQ6QfC3j5gVGXeJA9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXfRWyym; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXfRWyym"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so43260725e9.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379031; x=1774983831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiIpHPH/LiRFI0zTQ2AfMR2nbX64gpX4hcFEAoEXaGw=;
        b=PXfRWyym1l+ihrkdaRU1airif1x5Tvat74kdKEbzcemXVLRB5KFJ4QY0vrBrVQ42q8
         /iV1w0nZI3tMQgcariWVihxJ01LzvUQ6h00u0jQcRCifqftUr5MUuFkYuN/+OeWJeNXg
         Q0LoXUz3RhCSTkR4xPGOc2T4VGfHBvwRCF+h03NGSqlWIXneW67COp9560KjY8eG332q
         fP7wHlvNXbyJ1agwq5x2hzfTQjcD9MuziVg3dd8JyZn5PAtv83zfGgRD2a1hZ/Ylpken
         hykkYNmBwYa9l5+QSt+ChJ7D9qellIcuQy4tSMsJoEZUYrTaBfKst311Qc5Xq0ie+R7X
         ubvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379031; x=1774983831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uiIpHPH/LiRFI0zTQ2AfMR2nbX64gpX4hcFEAoEXaGw=;
        b=O8EosfelwudCYt/0ZgPdPMmP2NfVZGRLuY/rI5I9jO2xiQYTUZVoV4n5rveJCYa7VV
         fbCHZEDgA38uuJxyHYklTtzcbttB6+JK7P1b4nq/Ip1s+yvBTi74PHzN9oCBVUtSg5r6
         d1i1efAnBx3QVNw0QfnxBM9BXYndTM5a/2tQUs3kLO40Sy1J1Cs/j63vS3dMRTzJgvn6
         nDRUZh+s9sBYNTTvgmK8gEehC2a+QNnbZO9gATWQa/QfnPnVNp/lMi5Xm+4vUdW4HRv+
         9t430Fm26J2edpDN/voF13zzH62H/1S6r+Suqj3IjzVmPchEfH9QBBFkorQP7Uum+2U4
         R49g==
X-Gm-Message-State: AOJu0Yxxq7nY0WsPHm3InNI7dth2OzPxlJeTDeKeooMEjzR/WnMHBMWc
	t8I6lk3Ftb0f1QakDJh4mr5xAzGvmaVnMn5WY56i3M/UiFzllCj4TnNf
X-Gm-Gg: ATEYQzz3usixCz4lLR2FfAUkzIYmj7A5v6+ISt72Wl6WGKF4DNRj5AB9VJq+zHMzZ/G
	ucYBfzKeLobDIdaGIj9vFiW6bRlqgtDfhxrBbah8QU4ZMK2vH6s/qrT+AuwDWOo/ves/kWSzerB
	kd5uLicov5io4CtiU/InCJmppEff+c494JJtGRsPUoznAoMsTiPx2tvQFrb9mS93FYGCNqrqad5
	5MII9xecX0hkncphY77YAeZSKOWs/+Pymb8BORoQhHFZcM0/qEBg8wgTvN0md9JaIn+hsvpV+TW
	nKYdoy7Tls4Xp72MUMugj4jvBIvoTK4eW+V75hhzLSL2w7q0u7Us/MRWnEYVk2RHhUHV+8/q30G
	QYplVt9h7y/ie9YIw4YaMx8PqdBI0xuXyjhYUCBgGwR8A0i3wbAhUlOaRvY03xH7/nyyNuw3dM2
	Z+F8NnMctBxlCb
X-Received: by 2002:a05:600c:3f07:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48715fea9bbmr12750855e9.12.1774379030999;
        Tue, 24 Mar 2026 12:03:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716547814sm5455025e9.0.2026.03.24.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:50 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Mar 2026 12:03:39 -0700
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
Message-Id: <20260324-sleepable_tracepoints-v6-1-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379027; l=3133;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=sgw3eFcmzTkbqJiL3ixcm2e4dPpiTPw+0A8Mk5nCcc0=;
 b=4MK1Elbs0x6QxvZBFkPnHt2OV/iuGkV885be9GMZOf5Mu+cr0xjdRs9+mXzwQWvPcWWVRFBjO
 jE2qtXgmhneBoqUGtkrpkvJJoiqXuRH0ZPqFHS44IUM9aKukoRY7yuV
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

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

