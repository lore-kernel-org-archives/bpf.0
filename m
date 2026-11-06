Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958230;
	b=kJIoSE2UIrI48qklzv2pVFWfX7hy+ZZU/xleubv4VxRbU608NVaL7UM7Tp78EBfh8d5r
	 RRg801BoW2jYPCM6ph/iMK40IsQSsUQk9xff4LMKVr73YPy+FEWZ5jWZGhnihpHGB/lNy
	 jcywKw9lCEtTkqfmz2tTDMhgE2MAxRWp1eB42aXgze3ISW2ubipzMsov41O1UVp5IhesV
	 qg96xukyYwCWbJsFbXYxIbcsStGqCsZTj7rITeQ3heK7G4+uMNAulzgSA3BjGPNDGSCb7
	 DA5o6qvkvSN4MiAszX/LChQtymFJ9WGSNV3iBLdD1lTv4tEYF/wfnd2+IrO2m9Cd5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
	b=KxxQx2DW52xPbshetiQ9zCx9VL8VTbPKvsu5pHtNtUkumFtheVcXuo5YQowZzNqVsVYN
	 oG3sLy5f231719Guz7SdOIpgPg/15wNjYUSmi4ZOfgezGseH8Hphx1RHkkORDkwASdIHv
	 czYmeOaflLwkbbpLwP0G2ygCxgWbQCtdvmlasT2h4/V3UIM3OTrdhVfmQI5jDHXFEdjoI
	 D6fau6k9n+8jA4mrknW9OvyXrBg0WLSzkZED9LJamyQBQEjARohvLnh+Mo56GL+GB7v5q
	 3hjVTBJl1/KskiEq7mdhyzAS+62YROkoS8O0B7G25b5+OkvuyFiSh2kkai8SSgY09UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRSkcGXm;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67C606A33B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C67C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VRSkcGXm
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49376eb635fso34566f8f.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 01:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958228; x=1794563028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
        b=VRSkcGXmLwvrHtHpJJJlWVI/08GXMuhPKL3EN1d5kq9AQt5dVg7QZGTKNPOki5F6wq
         gXRJT4Lh/VZ8k9k9VsQ8oawMhdjOVA983eXv15fSpmmyHSel4IhToGxmNwno6HQ4RFmo
         50b0hhEu4aSNyQitKgIMPRB6jRr6+wSLSG6kSlm8lEpKsKoUk6uVWCArKJCcmpo9vjl8
         y1yzWnhgUyLBqia7e0jp6a71cuj0VPXCDvzaZMvBFO3w/rRbHqhm7dLvWby3Y0qOo0co
         RH/LnR7+K/A7GxU7aCFqhXtXxYsKxkfZ/kkPUeJyaHUUB211VAohk+ChslMp24Dd1nil
         mOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958228; x=1794563028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmDBfgrakA2SCIvOPfJqKnMNUKn5sx6kjpDscY55NnI=;
        b=TMbKVIoKeDj9ZlFUy2U/RS9b62o6jMtgISD8tCM7xKWgJDRJvuAgO8uod4lDx/4RdG
         Ccld7vIvooyeTPer/SxClQa0FTWshSG1pRxbLNY5OVu8J0p37F02ktY/1ucJxLwtOtir
         6EFRxw92cGLD3QFauHVNiDtcfDf1Ko4Udv+bYFvm9wT6cnVGkEw8Fu2rI/HXchBUtWOj
         +Sy9UixC5ejM5uAw8ElgLQ/XaDK7RnkxmBBFcAQjE2Kfsj4JUQ1yxfQS1peePMgLzD8U
         UKwBG3EKHzSHnQEiMU3+3ErLbwHzChcvzlgysE8QTU5ZvRMCIhc0k8azHrTpV7lE+InE
         VSWw==
X-Forwarded-Encrypted: i=1; AL+hErHoKiDWJzKFctk7mXJWL6+cebUKUARBUW7bPiYqJGcX8ddzzBV5L7AJBNfSiXGWeUZsQoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z89v8Hon5ZKkZ7WrT6IYbAQqgxZhd6Ka+aMolJ2wjHX/g4F0O8z
	78vwMS7MqdMrOV4iU3MN4t02PnZFS1QjL4Tq59OeiayO1DXrS9cBBLnm
X-Gm-Gg: AYBFou2pqOBHsUkCes7/VhMCF61CpirvxPrfGOCWVFmkxnTfIMak+EwJLGsrs4aEHap
	bhxo5XQnHv11P/VHqTLSbFN14MwFlKJyhbSVIBreXWHqCBT4Vnr4ys/6X31NKRLQSQHCk+CRj8B
	QL4HbJsLzDYnuDlfsnNUz7/cj3+6+BUELOlP2WAkiVBpgivF0eJzZEV1IoljMEgP+c+oz5REl4/
	4/Z0AyVK/pOFxJXswxW7Ud6zXoboyZbIgcpVvd8wVmIUdgcCXxwQUbFX9rdsTch4HRGFKbTRFWO
	929rkpgtkwaGo/lRVRrrwnUjYtBugp6GZNrzz7FIsqJLe9OX/Qo3IsO5aOP+Ob3ZITLIDG59p23
	esO5h4RmrWbbF2w/P4MmjFNQHiq3Td1Pumz3gULZBwRcZCZtwktw13CNPPA0tLvujIe/HBG9zJR
	kuJeckKMofqcIqQjzcVReOzaz3GPoZIMXnWwU3MgEFHcMWw18UdtBWZ98CsqqWuRXos08zkKiKh
	6AmvSRMBa2qXwMGmXe0htY2eMo+XDH5ymvDzD1szmFuyRE8X1XJf9rVXaYPuVKcQJsP9q5xZla9
	pv1oVrYQPizmylA22LKaSiOEGcAaXL8RtlZOf9HfVSRWrV8cRbG2H6jPpizL4tCCanfzuD47h8r
	KNw==
X-Received: by 2002:a05:6000:455c:b0:48e:932:af0b with SMTP id ffacd0b85a97d-49276c57fa5mr2571846f8f.32.1793958227477;
        Fri, 06 Nov 2026 01:43:47 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492fc80e017sm2228205f8f.34.2026.11.06.01.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:43:47 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tj@kernel.org,
	tglx@kernel.org
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	frederic@kernel.org,
	anna-maria@linutronix.de,
	bigeasy@linutronix.de,
	joshdon@google.com,
	haoluo@google.com,
	brho@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] softirq: fix idle accounting for an interrupted idle task
Date: Fri,  6 Nov 2026 09:43:41 +0000
Message-ID: <20261106094343.174905-1-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tick_irq_exit() decides whether an interrupt that just finished ended
inside the idle loop, and it asked sched_core_idle_cpu(), which is
idle_cpu(): false whenever the run queue is not empty. But a CPU can be
in the idle loop with tasks queued on it - forced idle under core
scheduling, and any task a sched_ext BPF scheduler holds back while
leaving it runnable - and every interrupt taken in that state skipped
tick_nohz_irq_exit(). The fix asks is_idle_task(current) instead, which
is the question the function means to ask.

Patch 1 adds the scheduler that holds the state open long enough to
measure, patch 2 is the one-line change.

Measurements:

One thread spinning 10 ms in every 100 ms in a cgroup, pinned to the
CPU the scheduler holds it on, 20 s windows, three repetitions per
cell, arms interleaved, on one 16-CPU KVM guest booted with
"no-kvmclock tsc=unstable" - which is what it takes to get an unstable
sched_clock in a guest, because mark_tsc_unstable() clears sched_clock
stability only when using_native_sched_clock(). Two kernels from this
tree differing only in patch 2, booted in turn.

The number is the cgroup's cpu.stat usage_usec over the thread's own
CLOCK_MONOTONIC measurement of its busy time, which is an upper bound
on the CPU it can possibly have used. 1.00 is correct accounting;
above 1.00 the kernel charged the task time it did not spend.

  hold (ms)   without patch 2   with patch 2
      7            1.32            0.964
     13            1.21            0.963
     23            2.00            0.963
     37            1.69            0.964
     53            1.33            0.964

  control, fair class, no BPF scheduler loaded:
                   1.005           1.006

Nothing in the fixed kernel's figures varies with the hold, and none of
the unfixed kernel's is within 20% of correct. The three repetitions of
each cell span at most 0.04.

The unfixed kernel also understates how long it held the task, which is
the same bug seen from the other side: the scheduler measures the hold
with scx_bpf_now(), the sched_clock that is not being resynchronized.
For the 23 ms cell it reported a 5.1 ms mean hold where the fixed
kernel reported 15.2 ms for the identical configuration. So the fixed
kernel accounts correctly across holds three times longer than the ones
the unfixed kernel gets wrong.

What is not shown, and what was not done:

No loss in /proc/stat. The sum of that CPU's fields 2 to 9 over the
window stayed within 0.6% of the window on both kernels, so in this
configuration the kcpustat_irq_exit() half of what tick_nohz_irq_exit()
does has no visible effect, unlike the forced idle case that commit
548796e2e70b ("sched/core: introduce sched_core_idle_cpu()") widened
the gate for.

The mechanism is bounded rather than measured. A kprobe on
tick_nohz_irq_exit() filtered to the idle task counted 998 calls per
20 s window on the held CPU without patch 2 against 1321 with it, n=3
each, but those ranges overlap and the two kernels run the load on
different timings.

The forced-idle half of the problem is not measured here at all. Patch
2 changes the same gate for core scheduling, where that commit first
widened it, but every number above comes from the sched_ext path.

The figures were taken with an earlier revision of patch 1, before an
automated review of the tool found six defects in it. Four of them
cannot move these numbers: the per-task hold timestamp (only one task
was ever held, so the global it replaces was never overwritten), the
ops.dequeue() bookkeeping (the load never changes affinity or priority
while parked), the release timer's pinning check (a mispinned timer
fails the run loudly, and no run failed) and the userspace CPU
validation. Two could: @target_cpu now stays in the idle loop while it
holds something instead of taking shared work, and a %SCX_ENQ_LAST
enqueue of the tagged task is now held rather than put back. Both make
the held state wider, so both move the unfixed kernel further from
1.00, not closer. The load exhausted a 20 ms slice only if a 10 ms
burst ran long, so the second one was rarely reached. The test machines
are gone and this was not re-measured.

Open question:

The Fixes: tag. The sched_ext path this was found on dates from commit
f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class"),
which is what patch 2 carries. But the gate was idle_cpu() before that,
and what put sched_core_idle_cpu() there was commit 548796e2e70b
("sched/core: introduce sched_core_idle_cpu()"). Whichever of the two
you prefer, or neither, is yours to pick.

Tooling:

Both patches were written by Claude Opus 5 (Claude Code), including the
test scheduler, the measurement harness and these changelogs. The
measurements were run and the results checked by hand. The one-line
change in patch 2 and the reasoning for it are in Documentation terms
tool-generated content; review it as such.

Radu Toader (2):
  sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle
    CPU
  softirq: Treat an interrupted idle task as idle in tick_irq_exit()

 include/linux/sched.h             |   2 -
 kernel/sched/syscalls.c           |  12 -
 kernel/softirq.c                  |  12 +-
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/README.md         |  13 +
 tools/sched_ext/scx_tickbug.bpf.c | 534 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_tickbug.c     | 177 ++++++++++
 7 files changed, 735 insertions(+), 17 deletions(-)
 create mode 100644 tools/sched_ext/scx_tickbug.bpf.c
 create mode 100644 tools/sched_ext/scx_tickbug.c


base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

