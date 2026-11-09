Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254206;
	b=YrwaXQxZ9tr8aeTsXyPm6dHCrCE9QpEu393pes0fkXmO3EZYRTke+VX7NuDYFxi++SQq
	 bJ866PMsBB/GhpvOdUqZgqoxisqYFtizIt5FvSpaJLcqGmlmZv1gVTqNWt6HyhtdAlJTq
	 Rw6Q94bt7aNTl2Uc3ZM1RYjWyHakTSbJXLB4tg0CvHHVnon720GfIpIw5NFn2DO3A/G52
	 2LmoMVLu6jYAVGTWY/ChFMefbVmHIzuSGs4/uQyh3C+dSl8M3tEh+JL496mPExZ0fDoNK
	 0FW+h1ecMh1r6UCnyLVTZ4sZ0O74Di1UdVxuFBT9wEl6Qt0V7Ia5cRQbUHEhGMNpBIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254206;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CX1ZQ/SXOCJl59w5aaPyU1PjDQvonYT/BDKqMcqwHk0=;
	b=s3+otp1dut3DIi0zHCJ1rTGHPdpyENkgI/sVKUzM7L+5651Np42r7FuQN66tTNnUxWwN
	 qSTS5MzWO0eYk4/+g+JFan/pSusth6/+W/kFAIH8vDkVniyZfvhuUdAiE+nW267sPQR9x
	 TXqMqZG8Zwm4ajIwwb8YG3ADAgF40+wgE32frw7alR/YAigooubE6QG5nL5d9g8VK8wqa
	 9vmcJJISn5IJiVy6yIAdW/zLeUx+bAoiJCmBsCWQ5tmRqvWpshiODESpkB4tOAigIhLlR
	 xK3xEdo+g+oRPosgMGeyvLmrreCUtV4J7hzleKoQpMpJfVEIAPiLE+SvCrNetd62p+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlteXObd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE1606A31C;
	Mon,  9 Nov 2026 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlteXObd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE551F0089F;
	Mon,  9 Nov 2026 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254206;
	bh=CX1ZQ/SXOCJl59w5aaPyU1PjDQvonYT/BDKqMcqwHk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlteXObdY+iVSYguCPjptZBRit83o72MMO+WDd7davSZpaE4dt9/sq8gfkIdNX/lS
	 T7I3OsltFxjduDxUlGaKh4ph4dbBeLM0G6ozJ2pNUCUJyI9ej0MjLk8NhdDT73MAnk
	 V8O5a5piNcq8MMmJS7ZFnIAADcNWEdoe/kaZgFwOXHQvAqpW/UEebhUX0UqQzViMbC
	 CMLMLpGc7/25N6/tILwiqLh7UF5Gb/JxE65zNZeuiS/c/ulLMAe++kLD/gqur4vEwz
	 yqqp9fd8dljKKOXhMtq+qp0HXbCn21a+UWnTIrnAKhoS663cmy63PR2nfBRWfEyUZu
	 /JNceTYpdvGTA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 06/13] kprobes: Add an address iterator for probe lookup
Date: Mon,  9 Nov 2026 20:56:40 +0100
Message-ID: <20261109195640.1091059-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kprobe_addr_iter_start() and kprobe_addr_iter_next() to look up
probes at nondecreasing addresses while retaining the next candidate
in the range iterator.

Provide for_each_addr_kprobe() for callers that advance the address
in the loop body. Return NULL for addresses without a registered probe
and require kprobe_mutex to remain held during iteration.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/kprobes.h | 10 ++++++++++
 kernel/kprobes.c        | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index bdba893cc0b2..30d0de29ceb5 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -394,11 +394,21 @@ struct kprobe *get_kprobe(void *addr);
 struct kprobe *kprobe_iter_start(struct kprobe_iter *iter,
 				 unsigned long start, unsigned long end);
 struct kprobe *kprobe_iter_next(struct kprobe_iter *iter);
+struct kprobe *kprobe_addr_iter_start(struct kprobe_iter *iter,
+				      unsigned long start, unsigned long end);
+struct kprobe *kprobe_addr_iter_next(struct kprobe_iter *iter,
+				     unsigned long addr);
 
 #define for_each_kprobe(iter, p, start, end)			\
 	for ((p) = kprobe_iter_start(&(iter), (start), (end));	\
 	     (p); (p) = kprobe_iter_next(&(iter)))
 
+/* The caller holds kprobe_mutex and initializes and advances addr. */
+#define for_each_addr_kprobe(iter, kp, addr, end)			\
+	for ((kp) = kprobe_addr_iter_start(&(iter), (addr), (end));	\
+	     (addr) <= (end);						\
+	     (kp) = kprobe_addr_iter_next(&(iter), (addr)))
+
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bbd51e0fab7e..6655c24bb66f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -477,6 +477,31 @@ struct kprobe *kprobe_iter_next(struct kprobe_iter *iter)
 	return kp;
 }
 
+/* Address iteration retains the candidate in iter->next until addr passes it. */
+struct kprobe *kprobe_addr_iter_start(struct kprobe_iter *iter,
+				      unsigned long start, unsigned long end)
+{
+	iter->next = kprobe_iter_start(iter, start, end);
+	return kprobe_addr_iter_next(iter, start);
+}
+
+/* Addresses must be nondecreasing; return NULL at addresses without a probe. */
+struct kprobe *kprobe_addr_iter_next(struct kprobe_iter *iter,
+				     unsigned long addr)
+{
+	struct kprobe *kp = iter->next;
+
+	lockdep_assert_held(&kprobe_mutex);
+	while (kp && (unsigned long)kp->addr < addr) {
+		kprobe_iter_next(iter);
+		kp = iter->next;
+	}
+	if (!kp || (unsigned long)kp->addr > iter->end)
+		return NULL;
+
+	return (unsigned long)kp->addr == addr ? kp : NULL;
+}
+
 static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
 
 /* Return true if 'p' is an aggregator */
-- 
2.43.0

