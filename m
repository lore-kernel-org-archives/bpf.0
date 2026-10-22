Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634236;
	b=4XE0bmMAHW4RNn4v3Kre4VUQwSlY7jD3MKX0lH+NAMgxNE98B4ATDVCuOJv+aQRsrdEj
	 p6Ua5IEQDN+qa1aVECHh/ZydZB1Jq+MS2RxArkxLxmLkFYvSU3aDdgrmUaHTWzn/nWJBi
	 +4pTdQFnRZLOLb3kkUpxDOOUG+SIeigZxyWoDZprKVykBXU1whbqIb2xE6phjZb1rBHuJ
	 xB47TPy7vpYsksbYY+PCEwtI2GTaF/6yiZPAVsboOJUvD3KQyqifCuz+fS2yHWMNaro1x
	 jamLNfQqLtMhmHSitJlx3xv4do2DLJ/C4kyv4BMx3cahz4EWR5PudjOPpULDRpho02w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jDvqirGSK7roV0OwhESQvxR+V4XuKQKeS3pYEmaAuqs=;
	b=Uo+D/nIShDY9CNjEBvbrHpVfwpyjnj08SAowEJyCIV+I0Iovw/pIehzwLBpCNYI3zSq5
	 do+YAQj8usS7A+PdkfVA45iZ58Vq6tF6onY5sb6qjbBczCgbxjvNMp0YyTPwBPvzl1kEe
	 wdQsJDTbB93IROe26Pvo4XtvNWjZ2UkZplDp5QkxSwn7ro8erJogolBWQwmQsCni/NLJC
	 SaS/Jg5Q0Gw/bkZy73tu5WIndLQhCOlsSVntBMBnGsKm9ShNA3zwh9k5LUIbNPuCh+o2s
	 pJ0qVx+pyoNdWGlGV1o3mxUOnoM4vo/jSLCwcCTSoFvSDF3WeorRxqxaJUDO0EVNBmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G+1LWwBp;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EF606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2EF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G+1LWwBp
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06c60065fso871857b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634235; x=1793239035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDvqirGSK7roV0OwhESQvxR+V4XuKQKeS3pYEmaAuqs=;
        b=G+1LWwBpOgMOZ8HbZpfC7grGyIlYmSp+qoBv3SfE1ODmH3HHtPJL4bo6AgKogLa49b
         qW724hfjp5QlrGBmXDjLEVsFzhoOa3kpfvAhWfTc2BLc3l9apiERkdackT2/FBLPP7xc
         FITW0WpnqlsZbRjzjvyVjPJQqnSwiRkWfLqECt4QOwraGHDjXjnQwwcZ4bs1CNF8RdGo
         hFDRAznOHctS3esTtUtpsCsinXZ59akUq6QKrEBbUZ45W4hFXIn/0jGCyIwRQ6N9cIgo
         3a3tVL8IypEwcVjCkcaYPLg3NhJz7ayAbLhdeT6bJE+GCRAQCf9MmhqgLzm0hZbK4Y6s
         Qc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634235; x=1793239035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jDvqirGSK7roV0OwhESQvxR+V4XuKQKeS3pYEmaAuqs=;
        b=XeZxvusy6kczifJeCdJD7W/Q3MLesA8tmNz4ejcfbo98Jd1NfYcKut6ADjI5md+wiV
         DzLCVT0J1V4enhkJe5wOxgWCc5IVssa7eVrVf7mfmx2ZeiSFJNoxFjlnMdDR02HWXrCc
         K8IgS9s32sQ0rGQJGNSpB9B91yr/lK4x7OBCEi1J7rgMJRhF5ntIQTdej4oFBn1M+MLu
         llzCeJDqOVCWwg+MKjVbaTB3/cyZ0krOYvCjmtk5m/GhHNseCIxoZr3JJEogPjq9xXWs
         nLs+EaTFp/z3LPbV3w1egZQA/3Rfg8LIiP20PI5fZgLn/g2ThgE4/O+69yRINpmqOACX
         AXYg==
X-Gm-Message-State: AFq9FYLlPt2npWTcH2H58byJEk6q2SAcDCSPMWGLrN/j2Xkd9zitskmQ
	Uy/TSXWJCQcwDLQCRw0AY28lz4DWjLmUt44fOoS6kDytB2Z9VtWGfOs+GmyFvw==
X-Gm-Gg: AYBFou0b1jOwNOH7oakx99Qt7jbtMKsi9hIg7UduUxQrjK2peYIsq3tjcAwJTPxsPSU
	7Y3lBFqW0DW/05D9TAMre3TnFQsvsH8FXlE+Qq9CJ/FOXeFVUuJl2YLwYVtsJRZKMI3QXwo57Zt
	2ey9ghcpOBvHrmt2d2SsGoVgIHJamhgFVGkxIog3lQs7U+FFNK5a+V891WWGDudm9d+T6dfMVn3
	J/OSbuJHlCU2FHal//UxwoMZ0pyU/zEWmW9awTCRJFA+5JO72s06h20ih2bATMFUQhb+pYMMVL8
	lhXLMoc580xHrIksnvz6uGhDg4rjoWOcr2DE2Bk/KIgi0KdS+D793z4GOeqMzHpvAppzSEOXfXR
	vzW41/HoiOBRV9oBWaCGeOyRFTMBvTtVaBWQgv/1fLxY12YUUaeJEfBeXG+l88TLMWqeePw99X/
	mmnV10MM3Wj7RRs2h3XfuHohIpTnG95+32ftBr+74Sj6uZNEcZE+/zYwX8/WlHzR8ZR5OXm5gMk
	9PlZhFDwkgCdAfz46hQuZ/W5T54PL4hUvjefNrqx9L2n4K9u7iOC7QzlVutFon6SXLcNqxz2Llm
	yt8bWHM/LzIW3jlUgFL9Qs0dI4OQjfygZfhkydvFBsA1s23Kewgbt0xS/zPDq1XKLEg/TX7kfBq
	oggLKsrvKLPh+paCaFrVmZT8b
X-Received: by 2002:a05:6a00:1493:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8a089d7c431mr2804454b3a.59.1792634235101;
        Wed, 21 Oct 2026 18:57:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a089614ce0sm1426295b3a.55.2026.10.21.18.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/9] uprobes: Don't stall fork() when mmap_lock is busy
Date: Thu, 22 Oct 2026 01:57:03 +0000
Message-ID: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

uprobe_register() and uprobe_unregister() stall every fork() in the system
when some process keeps its mmap_lock busy:
- register_for_each_vma() sleeps on that mmap_lock with dup_mmap_sem held
  for writing.
- fork() of that process sleeps on that mmap_lock with dup_mmap_sem held
  for reading. The next register_for_each_vma() waits for it, and other
  forks wait for the writer. The process doesn't have to map the file.

We found it the hard way by using uprobes in production. uprobes were
attached to libraries and binaries that many processes map, on a large
number of hosts. On some of them every fork() was stuck for minutes while
uprobe was being registered.

Patch 5 fixes the first one. Patch 6 fixes the second one. Patch 1 is
a helper for them and patch 9 is the selftest.

The rest fix old bugs that patches 5 and 6 make easier to hit:
- Patch 2: exit_mmap() runs under dup_mmap_sem.
- Patches 3, 4: x86. The removal of optimized uprobe that failed half-way
  is never finished, and SIGKILL triggers WARN_ON_ONCE().
- Patch 7: the child loses the breakpoint of an inherited perf event.
- Patch 8: the tracer that is killed leaves its breakpoints behind.

A process loops over mmap(4G, MAP_POPULATE) and munmap(). Another process
calls fork() in a loop. The longest fork() while uprobes are being attached
and the time to attach, in msec. 32 cpu VM, HZ=1000, no debug options,
median of 15-45 runs:

                                       fork()          attach
                                    before  after   before  after
the busy process maps the file
  uprobe_multi, 1 uprobe               201   0.25      217    232
  uprobe_multi, 4 uprobes              422   0.34     1483   1558
  perf_event, 4 uprobes                421   0.47     3150   3322
it forks and doesn't map the file
  uprobe_multi, 1 uprobe               198   0.07      212    9.6
  uprobe_multi, 4 uprobes              203   0.08      213   13.4
  perf_event, 4 uprobes                419   0.08      630   12.3
nobody keeps mmap_lock busy
  uprobe_multi, 1000 processes        1.93   1.83     4.24   4.49
  uprobe_multi, 5000 processes        8.88   8.60     8.33   9.23

I don't care which tree it goes through. It targets bpf-next only because
BPF CI will run the patches, including the new selftest.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (9):
  mm: Bring back mmap_write_trylock()
  uprobes: Don't run exit_mmap() under dup_mmap_sem
  uprobes/x86: Finish an unoptimization which failed half-way
  uprobes/x86: Don't WARN if an optimized probe can't be written
  uprobes: Don't sleep on mmap_lock under dup_mmap_sem
  uprobes: Don't sleep on mmap_lock with dup_mmap_sem held in dup_mmap()
  fork: Let the new task point to its mm before uprobes can find it
  uprobes: Don't leak the breakpoints if the unregistering task is
    killed
  selftests/bpf: Test uprobes and fork() with busy mmap_lock

 arch/x86/kernel/uprobes.c                     |  23 +-
 include/linux/mmap_lock.h                     |  12 +
 include/linux/uprobes.h                       |   5 +
 kernel/events/uprobes.c                       | 260 ++++++++--
 kernel/fork.c                                 |  13 +-
 mm/internal.h                                 |   3 +-
 mm/mmap.c                                     |  33 +-
 mm/nommu.c                                    |   3 +-
 .../selftests/bpf/prog_tests/uprobe_busy_mm.c | 447 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_busy_mm.c      |  22 +
 10 files changed, 766 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_busy_mm.c

-- 
2.55.0

