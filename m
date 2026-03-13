Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDB3803F5
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435898; cv=none; b=o7WftLoY/xwJS4aKWPWBJqNXfdA2TIcBPDF/f+Wzgphf4sfVjSxftyyfdu3K9L87QNuGeqery4/DK8uFCMU3x28l2iY5vI58dc0P7pb2taJVlJapfOXvj+HGn3go0kHk5P8/ciefAeXDbY/MoTtiqGGKEhocnSKJvA03UaLNOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435898; c=relaxed/simple;
	bh=s4z/RaSixjDVUmmGvFbkOa/JLXYNrlttxL78axTXf0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXd8gjBUx4qAUZjb6EUmnDKi9yIK/C8Huzghh0kwHGxjLa54WR4eo6gKiqYmlci9f5n58qiNc/Lq8nMrX1vnWea/rm/3L+JaZLhfYdDLgTgIKmlF9Bt5hn7bOe45GJgTczzQK5lAuiSTh9EvDaMvlarQi7r6F4CLuOYAqIK+dKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCNjQ31p; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCNjQ31p"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so22339875e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435895; x=1774040695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL1dKiD0sgwPn5Y68uuCx0eo0fhKTL+ZaiT8ZPXAdNU=;
        b=CCNjQ31pOgymOCOgfFvuNBwUIJCjieNOnEzkydTpjfjajlBkoUqk72Ay8jr2N2+jol
         cIRBlowXkK/RifQA/qaRMeX+TJuQ/nW+ZbMaPhg5hgUftDq1iSwu5cVgr+BJ9Ax3Bh3x
         +dZqh/bdoQIueaVgTjq+XZbRU5cohvtNKwlgAG5fYv3G+kRRFOKj2qaEfam/C4vT2YmM
         fYyPipUhaGO29VbZycOAuhL7/GHIwO4sdnyzGrroQm+xkfpSmgjAYTFzd+ZF6yxNxE8Q
         enMPxc+FVbGDmOS+3myklQeeL9jxvNGFDGo2RkeYNtIH+aKrJrGpsIB1SMXfvWu4dIXy
         lJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435895; x=1774040695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YL1dKiD0sgwPn5Y68uuCx0eo0fhKTL+ZaiT8ZPXAdNU=;
        b=akW9g7C4ZbZeqfeC5W9QKyqkk79a2ccyRK+F+6h7kUPlZOo+Q03JI+leFBbAKPmlP1
         uEsKVD6qZsqu18BR/lVyew4Dq6pIMew+uZZFnZ7yrHcH44LtkK8ElNcLryXQGPkXV3lK
         4Dg0YPzlQgFNRUYdKLs3FqJ9VgYLNnpmUPMBn6g4anaqw7ySP1mR7GoYPl9IxewTbxSx
         TtDIe0H4gL3oTU6+9CJG2e6Lf7w+5kjqHKXXCkHtlbX9mc9dfrNm50z9USbrjDqI9Fo4
         kIrNXfzcVo/Sy4FtzkOf5ZdVTUW/40vKgq19z1pRgvDL+SVTUbMhFsuaptiLAisCqzgM
         1qwQ==
X-Gm-Message-State: AOJu0Yxw72nm7Y3/is4WPfrKemgPyuXATTa3YINLXNAEHRuji8RjkpPP
	Lwi5egyTgQ2WgaD5H87d3kEikn1MpBuHlV51gWkwTxoUBP+4uOMrWz3H
X-Gm-Gg: ATEYQzx8hPt+lPjBpkHD82XfgnYccI7899vqvMCPR97pLqSMUq2sbHg9lbm1N8de270
	aZ/MlRl9xfpbiJKMBw+DhAKqtLuRG9mzexD4kL3dPDFlIP3II2sdyiNKRZVVfnqUiS8oye0sJPw
	U8uYZrMOpTdSgwFMCl0MyffA064sHHo5ALmAmRoXkFe9OC3ci89FNNVMODjAjHxTpdwTBaiYYnr
	61AMYoq3pqc06ZYAT33QTZOyAumGWOECAggUowTVM8iElRRD4CLnHkNttTqLOP1y+iwI/E5J/0x
	fnKwehYpAsUFpFIMhC44UNGamUj4zOjlP2geyO/D7zBoJMZucvGk7uZOGvEJyTBuPgCBmCaAytn
	3sRf05hqaDu2b54eV1UY6aVnWsVp5gAcZdB1ZKm0SUrfF699aLYa+1T9nalrcU8eY4WrKwBRBMt
	3SDxwsReksy4Ck3M/E
X-Received: by 2002:a05:600c:3b14:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-485566d6e54mr78347095e9.9.1773435895167;
        Fri, 13 Mar 2026 14:04:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm20401847f8f.38.2026.03.13.14.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:04:54 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Mar 2026 14:04:21 -0700
Subject: [PATCH bpf-next v4 1/5] bpf: Add sleepable support for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-sleepable_tracepoints-v4-1-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
In-Reply-To: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773435891; l=2864;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=bFypBJkOh4p0qnsRP2XalC2DIErH7JqkXZiQSZRMO/E=;
 b=/OIPGcWFsAgYqNyg8JiXEkVMfd7xaiCNvHM21qmceiAOIKFakZ7PugmLdXTnNeAu1DlFBlh9e
 7umF8ZrRf7OB14RBUHFV4wKqUMqJvM3ETS9MVGMgvEPmyiHxP7nfPc7
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rework __bpf_trace_run() to support sleepable BPF programs by using
explicit RCU flavor selection, following the uprobe_prog_run() pattern.

For sleepable programs, use rcu_read_lock_trace() for lifetime
protection and add a might_fault() annotation. For non-sleepable
programs, use the regular rcu_read_lock(). Replace the combined
rcu_read_lock_dont_migrate() with separate rcu_read_lock()/
migrate_disable() calls, since sleepable programs need
rcu_read_lock_trace() instead of rcu_read_lock().

Remove the preempt_disable_notrace/preempt_enable_notrace pair from
the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
preemption management is now handled inside __bpf_trace_run().

This enables both BTF-based raw tracepoints (tp_btf.s) and classic
raw tracepoints (raw_tp.s) to run sleepable BPF programs when
attached to faultable tracepoints (e.g. syscall tracepoints).

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
index 0b040a417442..8e76306b46a5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2073,10 +2073,16 @@ static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
 	struct bpf_prog *prog = link->link.prog;
+	bool sleepable = prog->sleepable;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	if (sleepable)
+		rcu_read_lock_trace();
+	else
+		rcu_read_lock();
+
+	migrate_disable();
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2091,20 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
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
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.52.0

