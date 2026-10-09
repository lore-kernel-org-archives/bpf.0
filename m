Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4393264C2;
	Fri,  9 Oct 2026 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512722; cv=none; b=CxlU/Y2IskQL9kqtkpcjvCtxf/ULlfBSMJr/WcVC68rMLg3BAEBhlWXfEHa1+2R2B9McFipxTjPYazhoTIpdjDwec37F5UApk4XsOIWywTajqfzyJb8IjkO2TkxLOsgOPYboWZfwulxE3F3VOi7qkJskVQl3oBiCJagjGFbV+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512722; c=relaxed/simple;
	bh=+kgzwJLXtNYuinTXgM5BIMh3ahPWu6TJGtbmxw62iF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfMmHsep/jo1AeHKLwJJwggBJPmCvfOEY9Uxon4cy+pvflt1haLvjPOxCo8DO8xMw5jvKb/YrnpV/DDrGsVMxDlKTutf1lweVzHT/WJ0+m3SGBo3eIeSiBdQwpVojTzHey/IgejWrzEvuqNOwmCLPDyiZCug6d0eGtWSS2F9NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JrmXsnBk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JrmXsnBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zu
	odmoDna2YP5TZPTMiSatU0+irviWPiLxuftQFzhoI=; b=JrmXsnBkda06bp+YB7
	36WIW4tmum8N+IMC8YbYwxi+nzXx//o7iemJw8duhJq8TkVlMkodrfQ00L0GkwV1
	wgfz+mJStsGsu554YdTv5xUkn3AbEx6MNTfVcXqyTdPLaMVHkaaDK8IvEXC4UgG2
	gJJEjbw9gTHENqX0jXWQYcg4s=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHr41jUMhqi4mXDQ--.14934S2;
	Fri, 09 Oct 2026 10:24:36 +0800 (CST)
From: Yuan Chen <chenyuan@kylinos.cn>
To: daniel@iogearbox.net,
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
	alexei.starovoitov@gmail.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH v2 bpf-next] bpf: Claim the per-CPU send_signal irq_work before filling it
Date: Fri,  9 Oct 2026 10:24:27 +0800
Message-ID: <20261009022427.968304-1-chenyuan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DLUBI6OS1J07.Z498VKY5084C@gmail.com>
References: <DLUBI6OS1J07.Z498VKY5084C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr41jUMhqi4mXDQ--.14934S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFy3Xry3Kw4kKrWUWFWUCFg_yoW5Zw17pF
	ZxX3s5Cw4kJw4v9rnrWw4ku34Sk3Z5XrWUKrs5G34fKF45Xr1I9ry7tFy2vw1rJrZ2qas8
	Zr4jvrW7Kr4Uur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbR67UUUUU=
Sender: chenyuan_fl@163.com
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQT5t2rIUGQ97wAA3P

irq_work_is_busy() cannot see the per-CPU send_signal_work while
it is being filled: the check only matches after irq_work_queue()
has claimed the work. A concurrent caller therefore passes it, both
callers race for the same irq_work, and the loser's signal is
silently lost along with its task reference while the queued work
runs with a mix of both callers' fields.

kprobe, tracepoint and perf_event programs exclude each other on
the same CPU through bpf_prog_active, so for two callers to meet,
one of the programs has to be a raw tracepoint or an fentry one.
And since commit 87c544108b61 ("bpf: Send signals asynchronously
if !preemptible") this path runs with IRQs enabled too, so a hard
IRQ can interrupt the fill as well, not only an NMI. Found by code
inspection and reproduced with a perf_event NMI program racing an
fentry one.

Claim the work through work->task itself: cmpxchg() it from NULL
to the target task before touching the other fields, and set it
back to NULL once the callback has consumed them. A context
finding the work claimed returns the documented -EBUSY.

Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
Changes in v2:
- Drop the irq_work_queue() return-value handling, which is dead
  code: irq_work_single() clears IRQ_WORK_PENDING before the
  callback runs and the claim is only released after it, so the
  queue cannot fail while the claim is held.
- Use work->task itself as the claim gate, cmpxchg()ing it from
  NULL and back, so no extra field is needed.
- Describe which program pairs can actually race and that a hard
  IRQ can interrupt the fill since 87c544108b61, not only an NMI.
---
 kernel/trace/bpf_trace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 195f78db9bda..5465e7eba238 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -823,6 +823,7 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
 
 struct send_signal_irq_work {
 	struct irq_work irq_work;
+	/* The claim: NULL marks the slot free for the next caller. */
 	struct task_struct *task;
 	u32 sig;
 	enum pid_type type;
@@ -842,6 +843,8 @@ static void do_bpf_send_signal(struct irq_work *entry)
 
 	group_send_sig_info(work->sig, siginfo, work->task, work->type);
 	put_task_struct(work->task);
+	/* Release once the fields are consumed. */
+	smp_store_release(&work->task, NULL);
 }
 
 static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *task, u64 value)
@@ -885,14 +888,14 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (irq_work_is_busy(&work->irq_work))
+		if (cmpxchg(&work->task, NULL, task))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
 		 * to the irq_work. The current task may change when queued
 		 * irq works get executed.
 		 */
-		work->task = get_task_struct(task);
+		get_task_struct(task);
 		work->has_siginfo = siginfo == &info;
 		if (work->has_siginfo)
 			copy_siginfo(&work->info, &info);
-- 
2.54.0

