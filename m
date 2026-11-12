Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489005;
	b=sQ3hClPvFTPC5ztknO0vefFXp8aK5y86IaLwtiqSudSSDaYUmHwDbi4MtCFCasqC5xZq
	 8AvrzBmUpVqorrhZAA3Hm4Jq5DOrrAv/rCdz8WcyAD4iFkYfV25IYQ+yF7BH2jShj8wfQ
	 BwUUrs2eRyF3/0ChjjHObu7WTexCFjWm0Vfmgne5oyqGLxeayJtl8cxo0s0NXNYFamdvr
	 rT83KAc+hUJFdu4t8AMQVgV8F0hiHvubouym/jPWoas4R5NZhwLepGh7OdtQvHP0FGwCf
	 A9JTAYy10FQFpMgWcKDlNJ08jqiehSQ+ZhcEwo4DpI7Mp9hmmKzX7oZAjhf0GEVtZtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489005;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PkhB7N72lsb6VkiCQm485DylgVp4F6QNfvuw6ggAbJI=;
	b=WAfEaAYYDQys3Ly+FZbm/ZC5odjdN2LtWfPSfoXyzJ1MPdrjBwFak59AZZSDvCtYLD2W
	 5VXjdY0h4FqKzitSoIQPT0qhSk2a0JUhr+QdZZ+L4Y7CBLkzMlFahNBAx5WMF8sY4eq+V
	 cDO945WozMXHAgbLHUh/Gv/GpQkZ2NdpCAYqRy/fv/dRnjS//Uq5rMVEPUAk5Cbe0ZbqD
	 Yp4ZLEmi3Fs8+QYIkwpa8d+ebN92Vk4rTpXGuy5cQfznG3f7aN3Yihb3NwD+xARdeBsP9
	 ZMH53ITWK1Z/RMhLzBhq22jk1sh6KkH+6Z2BXjt7MvbCwOKW+WhhuJjsxz5C/VNsgmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wDqbg94j;
	arc=none smtp.remote-ip=95.215.58.251
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DE606A89F
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31DE606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wDqbg94j
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tTg4Ftlr3+mzKsKjq40xt8Ey6Nx9uO7sfn51pYZJ8iw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489002; v=1; x=1795093802;
 b=wDqbg94jhgqETmCRc1QoSIaJ9wCYSVCl5yWt6QW6t8Bf3+T88i0V+d2pIJWRx/U+Tg6qdqqE
 f4in3yBSZtpOATTvKTG+SRVTFG5O9SccSz8J+9Op/QrkwYtYdH8hqeoxoTmvnGP40q8wyinCrkf
 f75Pzq3BMeZ6SDnUMCr/82lc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e6d0a9f2e3ed8e4;
	Thu, 12 Nov 2026 13:10:01 +0000
X-Mizu-Trace-ID: 1e6d0a9f2e3ed8e4
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/6] sched_ext: fix kfunc, sub-sched, flatcg and idle-mask issues
Date: Thu, 12 Nov 2026 21:09:28 +0800
Message-ID: <20261112130934.563321-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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

From: Tao Cui <cuitao@kylinos.cn>

Hello,

This series fixes six issues in the sched_ext core, the scx_flatcg
example scheduler and the CID helpers. The core.c fixes travel as a
separate series.

The DSQ iterator kfuncs bpf_iter_scx_dsq_next() and
bpf_iter_scx_dsq_destroy() take the user DSQ's raw spinlock but stay
callable from tracing programs, so a tracing program running while
that lock is already held deadlocks the machine. scx_bpf_cid_node()
is documented to return NUMA_NO_NODE for an invalid cid but aborts
the scheduler instead. A sub-scheduler can declare
ops.cid_online()/cid_offline() and read its own caps from
ops.init_cids(), but hotplug callbacks are only delivered to the root
scheduler and the caps storage isn't up during a self-read, so the
callbacks never run and the self-read kills the scheduler.
scx_flatcg strands a cgroup off the rbtree on the ENQ_RACE path until
the watchdog kills the scheduler, and the built-in idle masks aren't
cleared on hotplug, leaving an offline CPU advertised as idle.

0001 rejects the two iterator kfuncs for tracing programs. 0002 makes
scx_bpf_cid_node() a benign lookup that returns the documented
NUMA_NO_NODE. 0003 returns -EBUSY from a pre-init self-read instead
of killing the scheduler. 0004 rejects the hotplug callback
declaration on sub-schedulers at load time. 0005 waits for the picker
to resolve on ENQ_RACE instead of stranding the cgroup. 0006 clears
the built-in idle masks in handle_hotplug() and gates the claim path
on cpu_online().

All six are verified in qemu with A/B runs against a stock kernel.

Based on sched_ext/for-next (5b740a72b55c).

Tao Cui (6):
  sched_ext: Reject DSQ iterator kfuncs in tracing programs
  sched_ext: Make scx_bpf_cid_node() a benign lookup for invalid cids
  sched_ext: Return -EBUSY from a pre-init scx_bpf_sub_caps() read
  sched_ext: Reject cid_online/cid_offline on sub-schedulers
  tools/sched_ext: scx_flatcg: Don't strand a cgroup on the ENQ_RACE
    path
  sched_ext: Clear the built-in idle masks on CPU hotplug transitions

 kernel/sched/ext/cid.c           | 10 ++++++++++
 kernel/sched/ext/ext.c           | 24 ++++++++++++++++++++++--
 kernel/sched/ext/idle.c          | 21 +++++++++++++++++++++
 kernel/sched/ext/idle.h          |  1 +
 kernel/sched/ext/internal.h      |  3 +++
 kernel/sched/ext/sub.c           | 19 ++++++++++---------
 tools/sched_ext/scx_flatcg.bpf.c | 17 +++++++++++++++--
 7 files changed, 82 insertions(+), 13 deletions(-)

-- 
2.53.0
