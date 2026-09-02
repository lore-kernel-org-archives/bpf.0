Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D331282F;
	Wed,  2 Sep 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788310276; cv=none; b=tJorZJ4u9N4If4SloMoYhRGN8G3ZEmvcIlHYC7jHRaPlday+KWooFToAQXUw91Flc9DcGKVIS8PyeVbXWW07e1RnJBlyEJRy/w5VlI18tp85DxXF1/6uU58gupdQlYIpleAwaN1Nu+t7k9mFblhITA0SYgJWrwsTNf96YjQEoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788310276; c=relaxed/simple;
	bh=3sk8wsg7t8H/SOjzCsxK+qHeAwoNibV2wJYyuP3kWGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxTVtSlonEaId1FKKx7bs5BTUOjbl+/37cHJIhJ5WVdQZhLk0tApOWUMgUIIaFH9QJeO3w+cndGvDC4+E2fiWPGilGoXy6+AWt4lm+w8B004fmwnzzTMDQAXb9Bj/Ipq7scsuhf6BIryE+zkcmhaMJ7eavA8o9ZEkgycRirKDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Ax39L_cpdqMZQHAA--.21143S3;
	Wed, 02 Sep 2026 08:51:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxtMz7cpdqMT8ZAA--.26027S2;
	Wed, 02 Sep 2026 08:51:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 RESEND] bpf: Fix timer_lockup deadlock using atomic_fetch_inc()
Date: Wed,  2 Sep 2026 08:51:06 +0800
Message-ID: <20260902005106.22187-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxtMz7cpdqMT8ZAA--.26027S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCrW7ZF15Kw4Utr13Ww4Utrc_yoWrAr4DpF
	W3Cr47Kr48XF48Xw1kta1Uu3Z8Z395Cay7Wr4rKryUZF15Kr12yF1jgr1agFW7Aw4kJr1a
	va10q3yFyF1UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5fHUUUUUU=

When testing the BPF selftest "sudo ./test_progs -t timer_lockup", there
is a kernel lockup and panic on LoongArch:

  watchdog: BUG: soft lockup - CPU#1 stuck for 8s! [test_progs:39601]
  Kernel panic - not syncing: softlockup: hung tasks
  ...
  Call Trace:
  ...
  [<9000000000c40e98>] panic+0x44/0x48
  [<9000000000e8b000>] watchdog_timer_fn+0x500/0x520
  [<9000000000dfd9a4>] __hrtimer_run_queues+0xc4/0x530
  [<9000000000dffe90>] hrtimer_interrupt+0x140/0x320
  ...
  [<9000000002ad9e4c>] _raw_spin_unlock_irqrestore+0x8c/0xc0
  [<9000000000dfe9e0>] hrtimer_try_to_cancel.part.0+0x70/0x350
  [<9000000000dfed58>] hrtimer_cancel+0x38/0x80
  [<9000000000f6d944>] bpf_timer_cancel+0x94/0x1e0
  [<ffff80000200fad0>] bpf_prog_108ab87b32f22e44_timer_cb1+0xb0/0xfc
  [<9000000000f6b838>] bpf_timer_cb+0x98/0x170
  [<9000000000dfdaac>] __hrtimer_run_queues+0x1cc/0x530
  [<9000000000dfde94>] hrtimer_run_softirq+0x84/0xd0
  ...
  [<900000000271d9e0>] bpf_test_run+0x1c0/0x5c0
  [<900000000271f548>] bpf_prog_test_run_skb+0x6e8/0xe20
  [<9000000000f39940>] __sys_bpf+0x1690/0x2c50
  [<9000000000f3af28>] sys_bpf+0x28/0x40
  [<9000000002ac2d68>] do_syscall+0x108/0x5e0
  [<9000000000c6a850>] handle_syscall+0xd0/0x170

In bpf_timer_cancel() of kernel/bpf/helpers.c, it explicitly notes that
"Need full barrier after relaxed atomic_inc" to ensure global visibility
of the cancelling state before performing the lockless dependency checks.

However, on weakly-ordered architectures such as LoongArch, the current
combination of a relaxed atomic_inc() followed by smp_mb__after_atomic()
fails to guarantee the physical store-load ordering because the latter
currently expands to an empty compiler barrier rather than a hardware
data barrier on LoongArch.

This allows a subsequent read to bypass the prior write due to store-load
reordering, enabling concurrent CPUs to simultaneously bypass the software
deadlock detection, enter hrtimer_cancel(), and then trigger a severe ABBA
deadlock in the hrtimer core.

Instead of relying on arch-specific macro implementations which may vary
in strictness, fix this issue directly in the BPF core helper by replacing
atomic_inc() and smp_mb__after_atomic() with a single atomic_fetch_inc()
to provide full ordering natively.

This ensures that the BPF core satisfies its strict store-load ordering
requirement in a self-contained manner to eliminate the deadlock under
weak memory models, and also hardens the defensive programming in the
BPF core, making the lockless deadlock detection logic immune to any
platform-level barrier interpretation variations.

With this patch, the BPF timer_lockup selftest was stressed for 10000
consecutive loops on a physical LoongArch machine without encountering
any further lockups or warnings on LoongArch:

  for i in {1..10000}; do sudo ./test_progs -t timer_lockup; done

Reported-by: Vincent Li <vincent.mc.li@gmail.com>
Closes: https://lore.kernel.org/loongarch/CAK3+h2xOSEZUHhou7N2cRL-aGrZCNSm45g+P7thObMe+fpgYCA@mail.gmail.com/
Fixes: d4523831f07a ("bpf: Fail bpf_timer_cancel when callback is being cancelled")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
Resend due to
"Can not connect to recipient's server because of unstable network or firewall filter."

 kernel/bpf/helpers.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b3cc5c8fc875..7d89dc143883 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1591,9 +1591,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	 */
 	if (!cur_t)
 		goto drop;
-	atomic_inc(&t->cancelling);
-	/* Need full barrier after relaxed atomic_inc */
-	smp_mb__after_atomic();
+	atomic_fetch_inc(&t->cancelling);
 	inc = true;
 	if (atomic_read(&cur_t->cancelling)) {
 		/* We're cancelling timer t, while some other timer callback is
-- 
2.42.0

