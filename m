Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795164276;
	b=UM61Bzp1TVXmnTrvj5ba+lnBz775cHVzmz16DYFK1UOxYSQQYq+1SY+i9SvJ08d3tUm5
	 uSfkFdaW17KvnenarrD4BrCfLTyEyK5K+IYKkleSTYwxjuqL/QZCTyBXz+zhcdyTnxmZr
	 K0Vhj+WFzBxjr8ZCNNFm9EKfvw5bumqdoyFeid7WOnMUNSMllPFCO9TqBKJMiE9G+8IGB
	 5Bx3/IMT+GUSaggyMEh6Xs6ojc2S+i/q8smgOLhq8xG1omFUSSYMKBbHiq3EYi2vOzqGa
	 sIgQjVc0MdKsK3Btf0lqAZ0UaWqXMNl/0bHcV/TO+IcJdKuGncuxBc9z9AfBL3+rO4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164276;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vnHkIsLxTap6PDAEihPAF/hMw6HkeMh5fdayIMgroaM=;
	b=sdGh9pbF1DSf95IERl+nk9xNDM+2GRlE+stXKu4iqZpdWlVZvLjOZarBXc3WbLf/gQm7
	 mGlktS7C9It7HHv+CA8xEIzLvK4AlUrvS6eS/StqMOndUXAZkdHgXy1H6Kx+JS8wWDnbf
	 9l5uFruaG+3xtj+GQGswrnXGHVVRtKnjj91Gzp/zm4qm/j4iYIf9SwFsDSuTNuRIoxxDB
	 ZZ6yFnUyEZ2f9yh0DTd+qVT0GnPnmDJ9a3rWM1zeO9SH9NsqltckAWa9Sgs73M+Ik7kQ2
	 xyTMgIVQpG48FefdlqIxQHQIUi3H77VD7Xb2RDTzybdvt1ikSZJYbq7EN8ppYngxpxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiUDTPG3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FD606A7F5;
	Fri, 20 Nov 2026 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiUDTPG3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795164275;
	b=HT1SW3hww+8sgLB/+97F5wWBg2tc8EPgh6a3yqJ9LNj7yiGiBaECy9BkRLVBEzEjoQSE
	 XskuuIuJJkLdi0pe3qOBFNCdLP+Dtk1GEimlwuIx8uCPTQt+5jNiLzCShl/Og+QQLBrTt
	 HewBMyLcC/k/Or0MzqNmVMIrqaat0adCZgz+ri2IwDT47mlesSU3SdwzINN1RUmHRBMmd
	 67tsZ+Is8rnMgSVjByUISO5rpaYASlwkS59tCwBJVTwNrJnIKqCnLwuwa8V9YceRoSDnf
	 sXle7E5SDL2HbsAnDK3kHReKT+kLi2DunyGJMsJJzPLxA2qgYnlK6YZqRHWnu0/ufEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795164275;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vnHkIsLxTap6PDAEihPAF/hMw6HkeMh5fdayIMgroaM=;
	b=cBONckJkDCgwBbfZJJ6tp8TKBdY49uHYgdfs6GA+258Hex3JdJO3zk1riKNlI/vepQJr
	 7ahSTKfxLumD6LVFr71NqajW1bj2cK2BjehfTsXGPHbXv1pCcs0zw7tRC5reoItIK5o+R
	 DFExaOVFBdq+t+kVn2n9/5wkzZ4Ju/1bFPedMdkUd/j4zdJxDRorxtEld8Gy5W5CQg93j
	 4UH+N3BN1d8RlcXYPrcK3nQ22UbRsyPrjrLI2jv6lv56NXSP8f9M+c1SKU4Z7H9o318hg
	 f4RNuL+GfqtaS8TC58kG+mxmQH7vW9lPogl/sUBa/pJS+9OQ4wQH6RQA411HPPs12SQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E9D41F000D1;
	Fri, 20 Nov 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164275;
	bh=vnHkIsLxTap6PDAEihPAF/hMw6HkeMh5fdayIMgroaM=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BiUDTPG3kZmMwtuQcLR4+7sONO+JEjcyNy+2wtE8BV0lp+BqNdQnXma8IaxalPT/i
	 p4d97m18SBCwY69KMvT0HeYemwe3xb5E7kRUDbGmxu8SlGTL8gOO1IqXFvDOqsl/9j
	 kJkhXOlaxRT4MJSjw0FDVVvOVoS/mkvLsnLgLM/F4RRLC1ev9lpZUhCZ+5+5OJn+AH
	 vHMsyazDiwSJD/iLCrs8YGGjwLIkmaFUbdncCtqbRpCm7NLAQScOgpKmbyORd16SBK
	 2hAhNIxyVJ1SyMUWEdmhbeRqPEpcFBF5rrO0tOL+4PNdc4mmZo7tYMgCA+m4OkbCvS
	 4latatNEnfsqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8B253497A9;
	Fri, 20 Nov 2026 08:44:34 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Subject: [PATCH sched_ext/for-7.5 0/2] sched_ext: idle: Don't stack a sync
 wakee behind a higher-class task
Date: Fri, 20 Nov 2026 16:44:21 +0800
Message-Id: <20261120-scx-fix75-v1-0-254f782ff9b0@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X27LYmxVj8FSkSk2fdi5aslID47
 waPwwxzkCIJlPrqoIS/qGxrAVNXFBa/fsESC5NtrDPGNqwh8yy5a9m/nXfxZRAwUel/CUXcr4E
 0LIgj8v6ct8Tdo6XPeV6lfDYwbgAAAA==
X-Change-ID: 20261120-scx-fix75-a86a6d31eceb
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Shuah Khan <shuah@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>, 
 Hui Su <sh_def@163.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795164273; l=3044;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=+c5iTcPGpkwPWTC0M/a6nppfpfe0VFKGA2gyib/nlzg=;
 b=KW5iaCyxdPLwsuWYUfdcxn+/B/rhaa9ybvCDWxHbFnLzoMGK/ua2uAo1eyZbM26DtaqeMjoNT
 /RSr1OFRAP7C/J88aluS8E8yimXJKoTVA1UpY4PE5aTqlrBvdSYk7EW
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com

In sched_ext, the default idle CPU selection can put a sync wakee on
the waker's CPU, even when the waker is an RT or DL task that keeps
running. The wakee then waits there, sometimes for more than a second,
while other CPUs are idle. Patch 1 stops this for higher-class wakers.
Patch 2 adds a selftest that fails without patch 1.

Tested on sched_ext/for-7.5 (c6cc52a72055) in an 8 vCPU KVM guest,
non-debug kernel, booting each kernel twice:

                               before               after
  RT waker, pipe               16/16 on CPU 0,      idle CPU,
                               169 ms - 1.5 s       <= 0.6 ms
  same, ALWAYS_ENQ_IMMED       16/16 late by        <= 0.6 ms
                               16-483 ms
  partial, fair waker          16/16 on CPU 0,      <= 0.6 ms
                               half ~930 ms late
  sync_wake_rt, 8/3/2 vCPUs    fails                passes
  other sched_ext selftests    no change            no change

With KASAN and lockdep on v7.4-rc2, sync_wake_rt fails without the fix
and passes with it, with no warnings. If other tasks keep all CPUs
busy, the test passes on both kernels, because the shortcut is only
used when some CPU is idle. On bare metal I could only run an
unpatched distro v7.0 kernel, because of Secure Boot. It has the same
problem: the reader waited 168 ms or more.

The cost: after a sync wakeup from a higher-class task, the wakee no
longer runs on the waker's CPU. WF_SYNC doesn't promise this anyway.
In a pipe ping-pong between an RT task and an EXT task, a round trip
now takes ~9.8 us instead of ~6.5 us, because the EXT task stays on
its own CPU. CFS also takes ~10 us here. The difference can be bigger
on large non-SMT machines [1]. That series detects pairs of tasks that
wake each other. If fair adopts it, we could keep the shortcut for
such pairs.

There is no Fixes tag. The shortcut has been there since sched_ext was
added, and this patch changes where a task runs, not whether the
kernel works correctly.

Hui Su's patch "sched_ext: idle: Honor SCX_PICK_IDLE_CORE in CPU
selection shortcuts" changes the line just before this code. Whichever
patch is applied second will need a small rebase.

I used Claude Code to find the issue, write the patches and run the
tests. I reproduced the issue on bare metal and reviewed the patches.

[1] https://lore.kernel.org/all/20261021-b4-sched-sync-wakeup-v7-1-91995ba5b596@gentwo.org/

---
Hang Zhengyang (2):
      sched_ext: idle: Don't stack a sync wakee behind a higher-class task
      selftests/sched_ext: Test sync wakeups from an RT task

 kernel/sched/ext/idle.c                          |  11 +
 tools/testing/selftests/sched_ext/Makefile       |   1 +
 tools/testing/selftests/sched_ext/sync_wake_rt.c | 257 +++++++++++++++++++++++
 3 files changed, 269 insertions(+)
---
base-commit: c6cc52a72055ef9775b39937d02e39ca358ba042
change-id: 20261120-scx-fix75-a86a6d31eceb

Best regards,
-- 
Hang Zhengyang <hang.zhengyang1010@gmail.com>


