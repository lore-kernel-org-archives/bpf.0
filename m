Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBA38657C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610452; cv=none; b=VKOseChJMlYvVlqNgrRkRQSGbgeobjhD3EnmbV9UA3uObGrmjx+Je3g2irXCBJoZoXtNmblIyZHAlxNTFJz55XuAlnslfTkKpeCVnS+sGvH+EG/j4Wv3inMF2v/QT8KBokW68FaZZ80DpRlkpNNShcERGaW1QmUtaRDPaDYUzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610452; c=relaxed/simple;
	bh=6RIg3+xlc56a9TiATGgbmkLKt/1FmZfcHuoKSyt/chw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW58I7+tmiXmAmPyNAcjAPe+JO3KcFx6Noiu8FdXZqkI6vuLeuu1dcdLLyqlBTpZFUZtikOIsnrQ4m1ZgYwTttowqNFfzuZW1JUxsTffwBUZPgB25/OY+zuR3P7NUEEV/IYOyFFJJ/WYW6MPcn3EUQj8EPywLICNGZHQuHV6ZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNP3pDQl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNP3pDQl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3496400a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 23:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610446; x=1773215246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ugG+Q6CRrXfDVHr7sdXkPMCc63GqTD3eiVmBzfzheY=;
        b=nNP3pDQlHa0AD2Z3QzLIf7NljbzABm10nlytc7vp9yxz53wgzeWTCV7GMyc0rfko9T
         xk7Yk6wmIIP9qgDh7FRZASMGD+j979z8KxMtZS5JnOEIjwQDssr+ws5flZV+jkzUSWSf
         t+Yiyf5FYZEwG7XtPxP9/YgBsEMxa9kypdMhM1N650hGKlQ/pFK1FUqjAINQIA1fa7rq
         yN3evzG9uW0tdL5a18zNQx/VVKTwLHQlMlF6jv2vaKwo4CoQ/GA1ByXtNUUB8vJKYYhB
         PZvdjkV6WMV/s7cD98bnkPKTpj+UP97jE9wY4vdmMlsVKYT9F0O00yE3fWzrKQ6pWXPC
         8s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610446; x=1773215246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ugG+Q6CRrXfDVHr7sdXkPMCc63GqTD3eiVmBzfzheY=;
        b=giW0T3eWMEPNF2HUzKhJZ6OpcNBSPEtlG9YA1rJBSUaAQc3BCavGRRpthz58JMwPlJ
         MS6Gbg0sW4GxSZqUtNZ2y4YEPpdt0en1Dynr4xbH3biqqDZvIDPrCEP8UVs7agSC/6k4
         y4iqt5pjpvP16FosULFBgpBuYkCjjElGnF6UkB07NXCpK5f8QCvKFgsIZCOBm2AWR/5u
         A6hG/ml721rMkmjQdasHsoWqALQ9nkb20iGeYDLxfMbNISGiGfxueV7+bLeGm+V75A8W
         Nc1KJKQtVwrz3CgP3OwvRmYLZ5dcgpwsXiXToCp3eFLNAQCuAbjM1wahiVSJiIkjgm0b
         OiJw==
X-Forwarded-Encrypted: i=1; AJvYcCXGQY1aKLcVkASVoXWjZ2XuvxLWe4q2KhenaMmmgtav7U5JcKJTJvCNQMn+l+lu+Y8qssY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9l4dVeuZRophEsGbrvSwtrlUZU2XibtjqHCoR/1J/94cd79x
	Q5PFLQz8T2d/M0EdtWzKZHHNNk5ysP0bkoMjQRRQJYCissZckGvQJMTZ
X-Gm-Gg: ATEYQzyFpCaxaglEJFuWBAGvtYHd0Xqf2DgBdYF6u4MaMkRpNT1/dahfJIe4VtKYDke
	KolLxGZ85CSfsn6d6dRH9VRzsT0m6PMz02RM80lLDguth4oOe0rE+NcGh8Wnb3BpeUYP5wx9UF8
	WqaWF4U5qYtxSjBeDqwwABl6GTuWpQGXe+Z4IWXlywyW4eonCFMIefEk49wTZVdoPG1bQdAHYiZ
	TB78PcqvRR2TX7aJ0S+4cSkZFCAxNAORa36ecKfDlysSTl2Io94FXhbRiGuyhqaHXDiujGbKvev
	/xWP/4vBI/p0KSqRA+stahOcIkcuDb/Lo6BU8o+4vrGWK1oeGWpj8zrPrzFJ9ZG0OkqesOV5+JX
	6uzdNY2qQNOg0cj1U3slG8J538OpWDP7Jtg86G6cB/5Mt4QZ0OAL6J0f+HhSxWLDWkqqL+75lIP
	5251DTqoCXCcy0fNnWngbqr0ANwUgFmneXwAfKFiORnraFkf4FJxoJyXAnx4kzhA==
X-Received: by 2002:a17:90b:1a92:b0:356:7b41:d348 with SMTP id 98e67ed59e1d1-359a6a3d157mr1010057a91.20.1772610446311;
        Tue, 03 Mar 2026 23:47:26 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1ba6:a29e:d73:6202:f71f:51b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm4352078a91.12.2026.03.03.23.47.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 23:47:25 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Date: Wed,  4 Mar 2026 15:46:49 +0800
Message-ID: <20260304074650.58165-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260304074650.58165-1-laoar.shao@gmail.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
on the owner for specific heavy locks. This prevents long spinning times
that can lead to latency spikes for other tasks on the same runqueue.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/mutex.h  |  3 +++
 kernel/locking/mutex.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index ecaa0440f6ec..1e488bb24b57 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -189,11 +189,13 @@ extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
 extern int __must_check _mutex_lock_killable(struct mutex *lock,
 		unsigned int subclass, struct lockdep_map *nest_lock) __cond_acquires(0, lock);
 extern void mutex_lock_io_nested(struct mutex *lock, unsigned int subclass) __acquires(lock);
+extern void mutex_lock_nospin_nested(struct mutex *lock, unsigned int subclass);
 
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
 #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lock, 0)
 #define mutex_lock_killable(lock) _mutex_lock_killable(lock, 0, NULL)
 #define mutex_lock_io(lock) mutex_lock_io_nested(lock, 0)
+#define mutex_lock_nospin(lock) mutex_lock_nospin_nested(lock, 0)
 
 #define mutex_lock_nest_lock(lock, nest_lock)				\
 do {									\
@@ -215,6 +217,7 @@ extern void mutex_lock(struct mutex *lock) __acquires(lock);
 extern int __must_check mutex_lock_interruptible(struct mutex *lock) __cond_acquires(0, lock);
 extern int __must_check mutex_lock_killable(struct mutex *lock) __cond_acquires(0, lock);
 extern void mutex_lock_io(struct mutex *lock) __acquires(lock);
+extern void mutex_lock_nospin(struct mutex *lock) __acquires(lock);
 
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2a1d165b3167..03d3b0749882 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -290,6 +290,14 @@ void __sched mutex_lock(struct mutex *lock)
 		__mutex_lock_slowpath(lock);
 }
 EXPORT_SYMBOL(mutex_lock);
+
+void __sched mutex_lock_nospin(struct mutex *lock)
+{
+	might_sleep();
+
+	if (!__mutex_trylock_fast(lock))
+		__mutex_lock_nospin(lock);
+}
 #endif
 
 #include "ww_mutex.h"
@@ -443,8 +451,11 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
  */
 static __always_inline bool
 mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
-		      struct mutex_waiter *waiter)
+		      struct mutex_waiter *waiter, const bool nospin)
 {
+	if (nospin)
+		return false;
+
 	if (!waiter) {
 		/*
 		 * The purpose of the mutex_can_spin_on_owner() function is
@@ -577,7 +588,8 @@ EXPORT_SYMBOL(ww_mutex_unlock);
 static __always_inline int __sched
 __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
-		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
+		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx,
+		    const bool nospin)
 {
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
@@ -615,7 +627,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 	if (__mutex_trylock(lock) ||
-	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
+	    mutex_optimistic_spin(lock, ww_ctx, NULL, nospin)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)
@@ -716,7 +728,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			 * to run.
 			 */
 			clear_task_blocked_on(current, lock);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			if (mutex_optimistic_spin(lock, ww_ctx, &waiter, nospin))
 				break;
 			set_task_blocked_on(current, lock);
 			trace_contention_begin(lock, LCB_F_MUTEX);
@@ -773,14 +785,21 @@ static int __sched
 __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false, false);
+}
+
+static int __sched
+__mutex_lock_nospin(struct mutex *lock, unsigned int state, unsigned int subclass,
+		    struct lockdep_map *nest_lock, unsigned long ip)
+{
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false, true);
 }
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true, false);
 }
 
 /**
@@ -861,11 +880,17 @@ mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 
 	token = io_schedule_prepare();
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
-			    subclass, NULL, _RET_IP_, NULL, 0);
+			    subclass, NULL, _RET_IP_, NULL, 0, false);
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
 
+void __sched
+mutex_lock_nospin_nested(struct mutex *lock, unsigned int subclass)
+{
+	__mutex_lock_nospin(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+
 static inline int
 ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-- 
2.47.3

