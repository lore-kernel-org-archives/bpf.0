Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553583AE6EE;
	Wed, 25 Feb 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021715; cv=none; b=YPrAi0TuJRrocp8KU0vZUPeTOs8Sy3JdXc3vhVgaln2r1Xrzft9RLkxbvmkzasGDe7A7aoS3D3ykKH+bKqTMGAD3GGSaJYGFlenGMLzMYdBuiEU5fgNhr/UCDO2hYPt/en96gL3voms4qfp8z6gIOh/yEmQKexwyCHDNkAaLCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021715; c=relaxed/simple;
	bh=Arwks1ff8GOfyzUPys20K9SGFBqCpLNVNcvfw6l0Y4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQPsJg9MKvzRD2DrBKs78tPC20yXOTyDZF9gzNfHuO8ibywgERvjl+eFuQNQQX73i+O6Np5+U9Bz0Ji4efr3f1Q9ohLAcZIgxyhw4xsKR5B/ERtovHbszsled+aMtqY1uOGB0XQnzcTiUuNLpib2LqyYjJLWoC+gbXPf5WZLrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Riyrso31; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Riyrso31"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772021711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cDVEU4alCa0FN51QSy6qYpDYuYUQ/oaAPIOWb1jOY10=;
	b=Riyrso31lQ8MFxXxfWT1vttJ4dT6i973qf/u+Uh/w6P5w7yXJC1KXVt93Li8aetGXQ7xn+
	vu1AneXk04fOQ21p7c1ENA0mm/7/v0oqqXk4/oyp69QiPFeV+5v63x4EGrksv0H9dpSTST
	vknUXsyo6vKseswbeGBAadUCPLKBoOY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf v4 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue races on PREEMPT_RT
Date: Wed, 25 Feb 2026 20:14:54 +0800
Message-ID: <20260225121459.183121-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
(when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
preemption. This means CFS scheduling can preempt a task inside the
per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
another task on the same CPU to concurrently access the same bq,
leading to use-after-free, list corruption, and kernel panics.

Patch 1 fixes the cpumap race in bq_flush_to_queue(), originally
reported by syzbot [1].

Patch 2 fixes the same class of race in devmap's bq_xmit_all(),
identified by code inspection after Sebastian Andrzej Siewior pointed
out that devmap has the same per-CPU bulk queue pattern [2].

Both patches use local_lock_nested_bh() to serialize access to the
per-CPU bq. On non-RT this is a pure lockdep annotation with no
overhead; on PREEMPT_RT it provides a per-CPU sleeping lock.

To reproduce the devmap race, insert an mdelay(100) in bq_xmit_all()
after "cnt = bq->count" and before the actual transmit loop. Then pin
two threads to the same CPU, each running BPF_PROG_TEST_RUN with an XDP
program that redirects to a DEVMAP entry (e.g. a veth pair). CFS
timeslicing during the mdelay window causes interleaving. Without the
fix, KASAN reports null-ptr-deref due to operating on freed frames:

  BUG: KASAN: null-ptr-deref in __build_skb_around+0x22d/0x340
  Write of size 32 at addr 0000000000000d50 by task devmap_race_rep/449

  CPU: 0 UID: 0 PID: 449 Comm: devmap_race_rep Not tainted 6.19.0+ #31 PREEMPT_RT
  Call Trace:
   <TASK>
   __build_skb_around+0x22d/0x340
   build_skb_around+0x25/0x260
   __xdp_build_skb_from_frame+0x103/0x860
   veth_xdp_rcv_bulk_skb.isra.0+0x162/0x320
   veth_xdp_rcv.constprop.0+0x61e/0xbb0
   veth_poll+0x280/0xb50
   __napi_poll.constprop.0+0xa5/0x590
   net_rx_action+0x4b0/0xea0
   handle_softirqs.isra.0+0x1b3/0x780
   __local_bh_enable_ip+0x12a/0x240
   xdp_test_run_batch.constprop.0+0xedd/0x1f60
   bpf_test_run_xdp_live+0x304/0x640
   bpf_prog_test_run_xdp+0xd24/0x1b70
   __sys_bpf+0x61c/0x3e00
   </TASK>

  Kernel panic - not syncing: Fatal exception in interrupt

[1] https://lore.kernel.org/all/69369331.a70a0220.38f243.009d.GAE@google.com/T/
[2] https://lore.kernel.org/bpf/20260212023634.366343-1-jiayuan.chen@linux.dev/

---
v3 -> v4: https://lore.kernel.org/all/20260213034018.284146-1-jiayuan.chen@linux.dev/
- Move panic trace to cover letter. (Sebastian Andrzej Siewior)
- Add Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> to both patches
  from cover letter.

v2 -> v3: https://lore.kernel.org/bpf/20260212023634.366343-1-jiayuan.chen@linux.dev/
- Fix commit message: remove incorrect "spin_lock() becomes rt_mutex"
claim, the per-CPU bq has no spin_lock at all. (Sebastian Andrzej Siewior)
- Fix commit message: accurately describe local_lock_nested_bh()
behavior instead of referencing local_lock(). (Sebastian Andrzej Siewior)
- Remove incomplete discussion of snapshot alternative.
(Sebastian Andrzej Siewior)
- Remove panic trace from commit message. (Sebastian Andrzej Siewior)
- Add patch 2/2 for devmap, same race pattern. (Sebastian Andrzej Siewior)

v1 -> v2: https://lore.kernel.org/bpf/20260211064417.196401-1-jiayuan.chen@linux.dev/
- Use local_lock_nested_bh()/local_unlock_nested_bh() instead of
local_lock()/local_unlock(), since these paths already run under
local_bh_disable(). (Sebastian Andrzej Siewior)
- Replace "Caller must hold bq->bq_lock" comment with
lockdep_assert_held() in bq_flush_to_queue(). (Sebastian Andrzej Siewior)
- Fix Fixes tag to 3253cb49cbad ("softirq: Allow to drop the
softirq-BKL lock on PREEMPT_RT") which is the actual commit that
makes the race possible. (Sebastian Andrzej Siewior)

Jiayuan Chen (2):
  bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
  bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT

 kernel/bpf/cpumap.c | 17 +++++++++++++++--
 kernel/bpf/devmap.c | 25 +++++++++++++++++++++----
 2 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.43.0

