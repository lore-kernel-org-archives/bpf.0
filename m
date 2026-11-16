Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794849504;
	b=1kv5Y0nPH/TRLpHTYdigkoAh6ZoS2BDhLNOtPi7Pti3RDmT27hSEeakyqOnG9DHNS8LV
	 xBSLCoQRyf03f5StGKHEjNFTDMZ0uxF32iAeFOfQWoMlqCr4RHYnalXnSDIAvU9iffsQB
	 ALLkiAL8Kl7OXmJvcOjtUQ7BnmstUMWuSfuR5OnpWTFzVH6Gqz24TkTNbq732lMHQKJtF
	 oKzaD3vMwUevd+LT9uzTlWTN0YEiGY+4cOShW1GkqChsSOJA2nwaYoZhwVN3kNmwin08u
	 ZkE/MNPs9foNGlAwAnEwY/axCXGfRFnsQmspsAOKUARUi3dvDcdcKWWDF/56LPfetcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849504;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ECQhVmZDCTZ18LrkN+4UXxf3K+pV7oph72pciH7StM8=;
	b=J1qo7suawT8GGn+rRkRH0tfd44OmAZWUSLg+C/3x1IhtK0lqJChq1wn7Dfo/xEe1qBHs
	 oLrPCWfExlQOYUgFwYs9iqsdIGXEGSpbykVDSId/VlWpcxo5BtzuQhKwSdHGWxdYV0Hj2
	 wOf5W3pzHUI1dgOM3nyAJPGbaMyJ5/nVhB0GG/EHG3G+shjbY0Y6avHJMb47a17kx2Xzm
	 eONS0QcX6YcX6y7dJSkuJhdIrzNSbllKMLAmc8JpAFy2mz6JmcGxAtQk9T/jR1eYZjIpb
	 a1ldKj3Xwa50i6vDhJguueHOc3mUkh5YKNlVQ9gIh4UqPkcNO7zuh0qcSA1CRbphJkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3Fh3dos;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810C606A31C;
	Mon, 16 Nov 2026 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3Fh3dos
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794849504;
	b=YJYs941+4wzGTU5IjnuZcKkFnYIB644yJQ60CjR4qMaLi58oSXsCoduJO5Kh8qbM2tbi
	 idMNmij9PA6xAYjRJmF4RldnudqCPK+zkXv3grmwAaD5RK4q2ZrDRNWyBDtrdoFNPyXnf
	 0UyrUZtHAWPi4JhgTr1egrtFvVLBYznVFB/mRYs9fvvZ3f5Sn3ldpNzc6ehNrPg9JAji4
	 vX4jJUtalwQyklAdvRvn01tVOOfkxX2e1zNHj07lhxvR+HADurN05yRFbgSLdZYw1IF4T
	 n1jBvdEwIzmzaHACJdRgg6+z+PcwQe7KfZ2zja91HqYt61L6M2V+sRANUwyAEZxjZdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794849504;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=ECQhVmZDCTZ18LrkN+4UXxf3K+pV7oph72pciH7StM8=;
	b=cIFZQ/swM4ayBG/g1p8qe6xBUGrxMtpQuTK+4CpvVVkUC7C/gVlHiFcBfVfgOFZ+cPUJ
	 IVLLIAbiAt3v9YKaJMpsJp0uYIRg2yqbi0fWOoRi6MgC/ZOgtXJ3sUnkjbzHEUtM/TbbR
	 j4SS5wwTUWJZ+pZMuGX9doeQm9POPFDVxWO6Yz5s5fxklvdJp0LfZcnWCyF88TRgo6+CK
	 BfV4E1yoSxL98KRP0AAo81d30wJI27hKpi/AGHS4aelYy1BF70T9oTT/XAGeoF2vy8ZMr
	 9vfpkxpiHFl8ln0DOtgxyVGVlVsfXlN4ilh7OsY9/2fEnMbdLCpC5F1X6i61ARA/qKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D85641F000C4;
	Mon, 16 Nov 2026 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849504;
	bh=ECQhVmZDCTZ18LrkN+4UXxf3K+pV7oph72pciH7StM8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=J3Fh3dosXZewdBiWx0d64TGofKZnmORwj+PAvi6vfRh184NJ1PtRW02uYp6DsTBHp
	 qhI0Wd098/QXZ3shb8deTYWu/oUzV5wDMh2yKxcWGGCBi8zXbHlqdwWEWw7j3cozLp
	 oFZ8tN2O3K2M+giYrwCzJC6SiqkS39E2PwoY5iMDssEPuAIp+/NGXDX+5iC2rmnBHW
	 bu6jUoIMV0ErfaZbQRePDYp2Q3csULiArmvWUI9b6fKpOzZv7tkTI/FRoSzo8PedeD
	 EAldrvSnAYybwZXuOhpvQeVdLQusZsiPOiboY+orl7UaDzqcJubvbi5qYNkkevd/Cg
	 CJ6ffNJlIciyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 555ED4A506;
	Mon, 16 Nov 2026 17:18:23 +0000 (UTC)
From: Mike Bazov via B4 Relay <devnull+mike.bazov.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 19:18:18 +0200
Subject: [PATCH bpf-next] bpf: Disable preemption while a raw tracepoint
 regs slot is in use
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
X-B4-Tracking: v=1; b=H4sIANk6+2oC/x2MQQqEMAwAvyI5GzAedOtXxEN1UzcHa0mLFsS/2
 /U4AzMXRFbhCEN1gfIhUXZfgOoKlp/1K6N8C0PbtB0RdTgHh2pPTAGV14hBmbeQkFzfkDEfY2c
 DpS7eSX7PI/wjzznBdN8P/zFbfnMAAAA=
To: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
 Matt Bobrowski <matt@bobrowski.net>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mike Bazov <mike.bazov@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794849502; l=4672;
 i=mike.bazov@gmail.com; s=gmail-20261116; h=from:subject:message-id;
 bh=UzSSLc393SFgDdsvt18pcI0fmb0CrVnIVQAxJGAGphQ=;
 b=GAaY2hAzCna3cUR6yb/ptwCvXlNZZpMOdEud5eOwnnXQGAMSvuhEv67Lifu1O9VSPVnxIgyvp
 K4RpB9ZFgbMBpw2s5+w+zg8VGN24RO/Q9/4brbIap9OuxqdeVa+jz+u
X-Developer-Key: i=mike.bazov@gmail.com; a=ed25519;
 pk=Rr9fagn0pNA+bs8tgc6DXZpRAhl/maU6BeqkttIR7DA=
X-Endpoint-Received: by B4 Relay for mike.bazov@gmail.com/gmail-20261116
 with auth_id=1544
X-Original-From: Mike Bazov <mike.bazov@gmail.com>
Reply-To: mike.bazov@gmail.com
Content-Transfer-Encoding: 7bit

From: Mike Bazov <mike.bazov@gmail.com>

bpf_perf_event_output(), bpf_get_stackid() and bpf_get_stack() of raw
tracepoint and tracing programs have no pt_regs, so they fill in one of
three per-CPU slots, picked by a per-CPU nest counter:

  get_bpf_raw_tp_regs()   level++, use regs[level - 1]
  put_bpf_raw_tp_regs()   level--

That only works if the users of a CPU leave in the reverse order they
came, as a task, an interrupt and an NMI do. These programs run with
migration disabled but preemption enabled, so tasks can leave in any
order:

  task A              task B              task C
  get: regs[0]
  <preempted>
                      get: regs[1]
                      <preempted>
  put: level 1
                                          get: regs[1]
                                          fills in its regs
                      uses regs[1]

B sends a sample or a stack trace with the registers of C. Profilers and
tracers then attribute it to the wrong task, and nothing reports an
error. The per-CPU recursion counter of a program doesn't prevent it:
the slots are shared by all programs, so it takes two of them.

Disable preemption from get to put, as the two other users of this
scheme do since commit f2c67a3e60d1 ("bpf: Disable preemption in
bpf_perf_event_output") and commit d62cc390c2e9 ("bpf: Disable
preemption in bpf_event_output"). Nothing in between sleeps: the
sleepable bpf_get_stack() of these programs doesn't use the slots.

The cost is small: the helpers already disable preemption around most
of their work, the unwind in bpf_get_stack() and bpf_get_stackid() and
all of bpf_perf_event_output(); this adds the few instructions around
it.

Signed-off-by: Mike Bazov <mike.bazov@gmail.com>
---
A reproducer, x86-64: two raw tracepoint programs on sys_enter call
bpf_perf_event_output() once each, with the program's number as data.
Two threads make syscalls on CPU 0, and a SCHED_FIFO thread preempts
them every 20us. The IP of a sample is regs->ip of the slot, the return
address of the helper call. The reproducer reads that address for both
programs from their JIT images and checks every sample.

Without this patch, 7 to 18 samples per program and 10s run have the IP
of the other program, out of 1.4M. With it, none. bpf_get_stack() and
bpf_get_stackid() in the same setup return an empty kernel stack
instead: the unwinder looks for the other task's sp on the current
stack and doesn't find it.

5 runs of 10s, debug config, CONFIG_PREEMPT=y, preempt=full, on
bpf-next 0fb18ce8a2e9:

                                     without     with
  bpf_perf_event_output, wrong IP    7-18        0      per program
  bpf_get_stack, empty stacks        362-535     0
  bpf_get_stackid, empty stacks      168-364     0

The bpf_get_stackid() case with bpftrace, whose kstack calls it; @a[]
and @b[] count the empty stacks:

bpftrace -e '
  rawtracepoint:sys_enter /comm == "dd"/ { @a[kstack(1)] = count(); }
  rawtracepoint:sys_enter /comm == "dd"/ { @b[kstack(1)] = count(); }' &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 dd if=/dev/zero of=/dev/null bs=1 &
  taskset -c 0 chrt -f 1 perl -e 'select(undef, undef, undef, 2e-5) while 1' &
---
 kernel/trace/bpf_trace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b4ff9d4e8..eb3daf2bf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1639,11 +1639,17 @@ static DEFINE_PER_CPU(struct bpf_raw_tp_regs, bpf_raw_tp_regs);
 static DEFINE_PER_CPU(int, bpf_raw_tp_nest_level);
 static struct pt_regs *get_bpf_raw_tp_regs(void)
 {
-	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
-	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
+	struct bpf_raw_tp_regs *tp_regs;
+	int nest_level;
+
+	/* The slots nest: a task must not be preempted while it holds one */
+	preempt_disable();
+	tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
+	nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
 
 	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
 		this_cpu_dec(bpf_raw_tp_nest_level);
+		preempt_enable();
 		return ERR_PTR(-EBUSY);
 	}
 
@@ -1653,6 +1659,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
 static void put_bpf_raw_tp_regs(void)
 {
 	this_cpu_dec(bpf_raw_tp_nest_level);
+	preempt_enable();
 }
 
 BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,

---
base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
change-id: 20261116-bpf-raw-tp-regs-preempt-1f7019989ab9

Best regards,
-- 
Mike Bazov <mike.bazov@gmail.com>


