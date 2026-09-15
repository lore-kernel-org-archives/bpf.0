Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE741D112
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478273; cv=none; b=OHXlxm/AFY+U1ZOY4M2MdI5vE82eVoDa+c0DpRFklqg1UEjqekwrZPYPewC8kJ3BfXp0qUjA7iWmEfrj/ePEpMn8QWKXB5lq8gsJYUtkhk2GlqKJ4AfFZgxtaW06OzjEUX5dV5Dx2yVXuSzwgWapb/p/kJLAYIz0VnMnzuhXsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478273; c=relaxed/simple;
	bh=WoSDn4ZEoocgxJI9vrvXQ3qPnrz/LPBQsbDWUONxsf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlN0DLcjXn7LHo/OljYsotwYpMraImr2f1pvWWXNsNYdkb2BJ31S8x5JY9aS5TynkBcSu0WwIQVEKH4gkU277O8t3Wcc1iQRs1Blp4dFlSIPqdyVHuXhXDgzAOO58wIkYk1wXXJgkpiXcYkPLXWTxcgABM5PO1mkwFwxg0GFYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Xn2+ghIO; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Xn2+ghIO"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c3e6b1so119269685a.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478270; x=1790083070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVf/c/k7gzeyhXD1Q6M+2DLwLNI40n7fXEqvG2ZQN0k=;
        b=Xn2+ghIOGJQnxTFU4k7M4tehgpkLkE74C02xa/6Qm999RKmWt7cr/eHmoFg5fLnXpa
         9KGuLZrqm7e9PZ8sNDG0951m0z87Niq8Ofvg63Q4X/hSE4a3U6JNIndtF1ZlNKDIcSQL
         RWQJgPDCX3DcGBklT0gXmZhT3a+htmLxQBxKUa1uRBJk6VWwm/nfRFQMln41HISK0Rac
         qQynBSkjBGkllS/sW7aVc0+JNT6yoApMKpRiyAS+wywTmi1QDp2vwVZ53drz0i1qQ29T
         EpwLJo2zE+U8KCg5Qs6lcXVw02ezT1Z+/S//aFWwghcztsBzIAfs09GOWqb2wZVCBKfG
         Zmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478270; x=1790083070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVf/c/k7gzeyhXD1Q6M+2DLwLNI40n7fXEqvG2ZQN0k=;
        b=a43G7MliP+QjEn+h8ogStP2Xgec+QbGc1FKSM7wmcmSfjKkfVa9N3Ph1MiDnNgijZJ
         8l9NR8QVqEScE7PDZHhTJRcTn8Jm6Pl75m3TNzLyHyrOhvjvpSEX72x+14/RW8aYEdW6
         n3umo0qLvOnh+YcSKOmhbCwW9VEXhpoXWbFUf5JyCPex7JZbPt33n061zXog3vKqQFzb
         cS3bNmglnJjhLfDJi6/ONbGQMda4XZRwMzSFncb/jaLHN93cl6CSwHzTsDZEYK5jJCBX
         qN0lJEv0jbTX+ha+WAPoCrLNeGhYYtSE81mmA7WbIijFSmWqgorCwEyd1aejcwE99PLQ
         7jSw==
X-Forwarded-Encrypted: i=1; AKwUvBxLLMVYB4QBCkjFvFzsBw9UNKWG0aFNqdFj+r4KtA1pNz3VbZM1Qezxs2RmnRKPA7oTX6U=@vger.kernel.org
X-Gm-Message-State: AFuF++nui5+7nnBSpr/957KV763FgGY6rPko0SweDUSN3mWZ7FHKZaXJ
	oHpO5b/pXZepe7UhGbTRWZ29FbHm4bnKXXvdLuK9HnYK85//Pc6TUjsh6xI6L13zP/s=
X-Gm-Gg: AYBFou042rWdPSw3K+59KtA9iHlWvqXTrL9ilEn2bUx87uEskdHOGID71O2319iSpmh
	TJJhD5Nkw9UBKeF7Ql0SW08HnqDgXGXVsu+fI3afBci4JZJ5zOIEB3LsD8KrDk74ExwNSo84eTt
	kLBXbcpeLVKcspILkBrL1BU9un/o3rZBlABIW5nFQWsPtOI+X4tAjs2e7NEivkz3QIAEsuH1O6X
	hPD3GTcPr1gGXfD3Tupv9XrRpwwveAiIsed2dfbgBwnI2cEg7IffRfIIqTD23BycGMmJ6Trsbpi
	Nse8Yh3bFlORGCNzQJn+ZK/+7LOPz1J1fPfP+/wlSOEPNtGFqnCcpzpqErbzc4dksMyJQfrn+x8
	aIAiBuwMBaybfqK91eWnoE/yDschoY7icG3EJpl3ikRq4LtqvUvMttsDeQqBkWCXCYqNhHmODUp
	P2RloXOfNFBDkt6agvyKtdVftWk3LQ22yyE/IbHAT9qRynnRazXpcjEGAeBtS54HxQwEfxcWrGc
	gb9vA9dlw3U+qFN1hn4FsDhreiKvI6Oy9P/EDAtiV3DChfPeShKBLJU
X-Received: by 2002:a05:620a:2b8f:b0:936:d00a:4947 with SMTP id af79cd13be357-93a345745demr474274385a.2.1789478269641;
        Tue, 15 Sep 2026 06:17:49 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f19f94a1sm1137880185a.42.2026.09.15.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:17:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:29 +0000
Subject: [PATCH RFC v3 02/13] rcu-tasks-trace: Inline rcu_read_lock_trace()
 and annotate inside the reader
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-2-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=5472;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=WoSDn4ZEoocgxJI9vrvXQ3qPnrz/LPBQsbDWUONxsf4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOqgtWORMkFCOHo3WLOy6WMvyvf/Bd/PX1OTaW4H8LYu/zuiatDpxAZC81QUixDJwPnYFE7C1UL
 57TTusaQZdwg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcu_read_lock_trace() calls rcu_try_lock_acquire() before it has
entered the SRCU-fast reader, and rcu_read_unlock_trace() calls
srcu_lock_release() after it has left it.  rcu_read_lock() and
rcu_read_unlock() do it the other way around, annotating strictly
inside the critical section, and rcu_read_lock_tasks_trace() already
follows that order on the lock side.  Make the trace variants match.

Also make them, and the __srcu_read_lock_fast() and
__srcu_read_unlock_fast() they are built on, __always_inline like
rcu_read_lock() rather than leaving it to the compiler, which does
outline all four in KASAN/KCOV builds.

Besides consistency, this means the first thing a caller of
rcu_read_lock_trace() does is enter the reader and the last thing
rcu_read_unlock_trace() does is leave it, with no out-of-line call on
the outside.  A later patch relies on that for callers whose own text is
protected by the reader they are about to take.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/rcupdate_trace.h | 22 ++++++++++------------
 include/linux/srcutiny.h       |  4 ++--
 include/linux/srcutree.h       |  5 +++--
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 273c59a03251..4035054309d7 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -93,22 +93,20 @@ static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
  *
  * For more details, please see the documentation for rcu_read_lock().
  */
-static inline void rcu_read_lock_trace(void)
+static __always_inline void rcu_read_lock_trace(void)
 {
 	int n;
 	struct task_struct *t = current;
 
-	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
 	n = READ_ONCE(t->trc_reader_nesting);
 	WRITE_ONCE(t->trc_reader_nesting, n + 1);
-	if (n) {
-		// In case we interrupted a Tasks Trace RCU reader.
-		return;
-	}
-	barrier();  // nesting before scp to protect against interrupt handler.
-	t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
-	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
-		smp_mb(); // Placeholder for more selective ordering
+	if (!n) {
+		barrier();  // nesting before scp to protect against interrupt handler.
+		t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+			smp_mb(); // Placeholder for more selective ordering
+	} // Else we interrupted a Tasks Trace RCU reader.
+	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
 }
 
 /**
@@ -120,12 +118,13 @@ static inline void rcu_read_lock_trace(void)
  *
  * For more details, please see the documentation for rcu_read_unlock().
  */
-static inline void rcu_read_unlock_trace(void)
+static __always_inline void rcu_read_unlock_trace(void)
 {
 	int n;
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
+	srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
 	n = READ_ONCE(t->trc_reader_nesting) - 1;
 	if (n) {
 		WRITE_ONCE(t->trc_reader_nesting, n);
@@ -137,7 +136,6 @@ static inline void rcu_read_unlock_trace(void)
 			smp_mb(); // Placeholder for more selective ordering
 		__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
 	}
-	srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
 }
 
 /**
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index fbcf13bc12d1..a43bae11c81c 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -101,13 +101,13 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
 	return (struct srcu_ctr __percpu *)(intptr_t)idx;
 }
 
-static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
+static __always_inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
 }
 
-static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+static __always_inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 	__releases_shared(ssp)
 {
 	__srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 75e54e4f963f..fdb42ab50301 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -286,7 +286,8 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * on architectures that support NMIs but do not supply NMI-safe
  * implementations of this_cpu_inc().
  */
-static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct srcu_struct *ssp)
+static __always_inline struct srcu_ctr __percpu notrace *
+__srcu_read_lock_fast(struct srcu_struct *ssp)
 	__acquires_shared(ssp)
 {
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
@@ -309,7 +310,7 @@ static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct src
  * Please see the __srcu_read_lock_fast() function's header comment for
  * information on implicit RCU readers and NMI safety.
  */
-static inline void notrace
+static __always_inline void notrace
 __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 	__releases_shared(ssp)
 {

-- 
2.55.0

