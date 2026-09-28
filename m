Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E246D56E;
	Mon, 28 Sep 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583162; cv=none; b=Nr3yLE3dNGXJ4Ke7EGitUBQJ+J3nxJe7BsFwjW6bYbJdY/+qJs6witNyieBoPUnfgFJlWoRkasJYQ3X9glPuUinSqeSzBzqvzLFDYhKGdgXxEaQJ8E3CaaXzJqBfgeW1fmlvHOZJgw4vsK1w5LERWRFrXDITjumO9eShlEygtE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583162; c=relaxed/simple;
	bh=DJg7qrSQLpUIylA65DFiLzQuISQk6VYJnGsMA/ft0pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=down32F2B6GB+tBalT3jIjtMRbHarYlzT2SSETQ4ZuDVcjvMl4T82DILoeeB0FPJo5sQkpnIX44+B5GurLOULoIBPfOPhG1feQO9EJVFbww+oqYh3w+f6a43mYlcL+QFnBdBQIPaKehaXteJPDgTS0u/dOj0IPC/53jbMopFgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QduDBK8C; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QduDBK8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2+
	bx5+w9qWHeU9nlycB8XjinIN8UVu3ZqdBzS/ofTQM=; b=QduDBK8CItG+35PkJJ
	NfY3RIFIfRuGblkNShpVldRGzqm8HlypkMEmEkjLoG6jBltOFn4/WgemyN/Mdt4l
	oHrDiEvETWOPLZeB/4BknWXSq28vLbx9+mlQX05WdedwsyqxIoXxNWpuojMDsiNL
	aBhONvLoTbzZb06GM7H18Jm+0=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHpnpGIbpqfB48Bw--.29622S2;
	Mon, 28 Sep 2026 16:11:51 +0800 (CST)
From: chenyuan_fl@163.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: yonghong.song@linux.dev,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] bpf: Claim the per-CPU send_signal irq_work before filling it
Date: Mon, 28 Sep 2026 16:11:44 +0800
Message-ID: <20260928081144.207908-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBHpnpGIbpqfB48Bw--.29622S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWDuFWxCFyfJr43XF43Jrb_yoW5Gr1DpF
	s8J3s7C3ykJwsFqrnrAw4kur1Sk3Z5K3yUKr48G3sakF1Fqr1fuw1xtFy2vw4Fqr97WFnx
	Zr4j9rZFkr4Uur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQijYWq6IUgz0QAA3Q

From: Yuan Chen <chenyuan@kylinos.cn>

irq_work_is_busy() cannot see the per-CPU send_signal_work while
it is being filled: the check only matches after irq_work_queue()
has claimed the work. An NMI interrupting the fill therefore passes
it, both callers race for the same irq_work, and the loser's signal
is silently lost along with its task reference while the queued
work runs with a mix of both callers' fields.

Claim the work with an atomic gate before touching any of its
fields and release it only after the callback has consumed them. A
context finding the work claimed returns the documented -EBUSY,
and the return value of irq_work_queue() is now handled.

Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/trace/bpf_trace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 891897f8a1b3..03552637aab9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -823,6 +823,8 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
 
 struct send_signal_irq_work {
 	struct irq_work irq_work;
+	/* Covers the fill-to-run span which irq_work_is_busy() cannot see. */
+	atomic_t claimed;
 	struct task_struct *task;
 	u32 sig;
 	enum pid_type type;
@@ -842,6 +844,8 @@ static void do_bpf_send_signal(struct irq_work *entry)
 
 	group_send_sig_info(work->sig, siginfo, work->task, work->type);
 	put_task_struct(work->task);
+	/* Release once the fields are consumed. */
+	atomic_set_release(&work->claimed, 0);
 }
 
 static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *task, u64 value)
@@ -885,7 +889,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (irq_work_is_busy(&work->irq_work))
+		if (atomic_xchg(&work->claimed, 1))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
@@ -898,7 +902,12 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 			copy_siginfo(&work->info, &info);
 		work->sig = sig;
 		work->type = type;
-		irq_work_queue(&work->irq_work);
+		if (unlikely(!irq_work_queue(&work->irq_work))) {
+			/* Unreachable while the claim is held. */
+			put_task_struct(task);
+			atomic_set_release(&work->claimed, 0);
+			return -EBUSY;
+		}
 		return 0;
 	}
 
-- 
2.54.0

