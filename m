Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203B3E8666
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253381; cv=none; b=EuoNhSLBD7zW+2eV98wdpWq0e3vrBFJiDqcPJKG52Emz2Kvq6ZKSZoHImNAYcQFZNpLRsUfaKLXXbUhBZw0CxsORZcheMgl2PDFNRAokv2diHVD4TYPL8GgdIVXXeqw+ltCoWuN/6Tc3l2FqbJBYOyuXTOwlQ+P1mPzyv+Gx5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253381; c=relaxed/simple;
	bh=kCB+GX7ZmNJGv3/I9BJh+wd+2M83/R4NNgUM1XtIZLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psYK75MofdipST/bXcIogiKZfMl4eu7DE+ltVMtldA1OHS+G8Ixw7F1bpNqeXZMHHgegZnmOKred8gKpwWINOimFft4dUln3LwVYObbt5+xfaN1j0iYVYRevnv25yhhTN1eYPRquOCN0T9H35YWKxsSPiaZyC2w+dMkQxQWySX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys30c58b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys30c58b"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso1488005e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253379; x=1773858179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgKVDKvIfp1CViyJmAe2HbU9rOOWE4OkC2H5gC1Gz70=;
        b=Ys30c58beYwvCIhuuYrG+XJ1Ad7iuD2nuqRkMEAR2aNnrvEkyFeLSdeLvl+svxt5JW
         Qs5KQqnYSa1nGEHn/demFLTW4Qp7ZgKZXE9fH1WE0Ta/LVY/d0gs9acKPhsXfRoQg7JS
         iwnquYjiO4n1hQ45TG3Zv2rWmbXtdoUnwcRRmbrH09MwemmIvygMQVep9Q6ge4/2xLUL
         j31gkUjVgozRb/iP85XjM1qSZ8CxXQNfPvRIyRZOvrobC1bzszZ9crcwkCYTuYFt0B7X
         I+ELGoK0+H30wK5iqNEp8GtfKzWknP8YRjGOC/nLW31vedfQr+0QCGfb3L9XI7cTdKyE
         ALZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253379; x=1773858179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sgKVDKvIfp1CViyJmAe2HbU9rOOWE4OkC2H5gC1Gz70=;
        b=jHFRXbGbs0XO6hkgCLW62s0GNxOiau6ZAhuavbeCfy5LWtJf0e2Q9BHVGV8nJU5qDZ
         Q61u97rkWZZMhh4Y/1OrzmGC5Q5hdqEESIqQxV8NeJKn1XW7ZNxeCphUn9qZGTOOtduU
         p7x0B7Pr0BuUxuj1kvJSWhr02XFwYcuq72wRIbP67v9/hDsA7aq+jctT3c5xE3H5UuQK
         bQTYT7Y85nKSUNcS4aFvGwe/OR9q1kDLOlv+jkUWgR6pyqiXUWuN59zgGxBohczO8sJg
         rypzJkUVrEIHh7O0Ywy8zPp1YFFa8xeD+74nm46uh3/V5hdGkFmj5EnP6M3piB0Lsl3O
         /52g==
X-Gm-Message-State: AOJu0Yw/xXZAUREyaoAcMex2ifu1xrKGxTuq37E54jBPqftHXk2a01Ba
	Euy/4fFxhPR7XGR5IYehueAKpA7KAOD1nEBu0qeRgbtWzlrU8h1lFPcL
X-Gm-Gg: ATEYQzx7CIssK/S07ep57JixMkOOzVDV/3HA9ScpUN223v3EKd4rDYSSyP0H3xOT84p
	yKGzkfKDBdHguVuEkhLtSYKD4W6Pxxhyvw03D9y7sMyV/qmMs1+CrCMBw+lk89LjeLtECeU31mj
	56xuPc9CaPwTNHpT0fD/aAaDIhM2B6ynLe2c4XK2nVbLkDnzSn9Z9ThC05BRgORdEJ8ww0kaa05
	K8+frvqEV5S+ZkWDbJuVidv+wGy7iXocrTabXzW0Ix415o+pKlRz8CmjKCEHZMLDYcBxf8BrYeB
	vDlUno0QD0RmeJV1ZcPCbs2zKE5pzmZ8yOhxaDYM85qEEvoxD8fVoSORkn8MLtZ1tRUk0dLh/Xe
	B3QdkG0CEsJ9bH82E+togn4KS3Gn0eHru0lko1U8ONg6NDpI0rxowBj3Y32KzWiWfCcQ6JOQe8s
	VrAeCY9iMnPmMOhvh3
X-Received: by 2002:a05:600c:444e:b0:480:3ad0:93c0 with SMTP id 5b1f17b1804b1-4854b1219cfmr60925815e9.23.1773253378758;
        Wed, 11 Mar 2026 11:22:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19b936sm1391051f8f.5.2026.03.11.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:22:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 11 Mar 2026 11:22:49 -0700
Subject: [PATCH bpf-next v3 1/4] bpf: Add sleepable execution path for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-sleepable_tracepoints-v3-1-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773253375; l=2653;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=72+IfeqfOuwAb7uDX6Q4yoOsICSL5VT8NGgG81WZLxk=;
 b=ybMyz+agEBIX35hDT7OgYUziZE/ycSHmmKVZuL9cQ9d1t2b4mkLGQS42wiruFp1BnWLTrnovr
 +O0srxT54XlBhVAErQzTH6ZFlqQiA2Yc7btLRRfo59gcqsJM6mngV2v
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Modify __bpf_trace_run() to support both sleepable and non-sleepable
BPF programs. When the program is sleepable:

- Call might_fault() to annotate the faultable context
- Use migrate_disable()/migrate_enable() instead of
  rcu_read_lock()/rcu_read_unlock() to allow sleeping while
  still protecting percpu data access
- The outer rcu_tasks_trace lock is already held by the faultable
  tracepoint callback (__DECLARE_TRACE_SYSCALL), providing lifetime
  protection for the BPF program

For non-sleepable programs, rcu_read_lock_dont_migrate() is replaced
with explicit migrate_disable()/rcu_read_lock() pairing.

Remove preempt_disable_notrace()/preempt_enable_notrace() from
__BPF_DECLARE_TRACE_SYSCALL. Per-CPU protection and RCU locking are
now managed per-program inside __bpf_trace_run().

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/bpf_probe.h |  2 --
 kernel/trace/bpf_trace.c  | 13 ++++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index 0b040a417442..3688a7e115d1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2076,7 +2076,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	migrate_disable();
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2085,19 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	(void) bpf_prog_run(prog, args);
+	if (prog->sleepable) {
+		might_fault();
+		(void)bpf_prog_run(prog, args);
+	} else {
+		rcu_read_lock();
+		(void)bpf_prog_run(prog, args);
+		rcu_read_unlock();
+	}
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+	migrate_enable();
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.52.0

