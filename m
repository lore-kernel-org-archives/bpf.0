Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BA2749C7
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769914448; cv=none; b=fS0HDRTjdHuGep+Say7I9UzbJDNKMyVo1MjXJ+pesavyXQWzrEYlmgNTFGw1IPyN32skB9GGh0UMLdCh07aEYcYrc52fyj0d6GrUBumPkXyDOfcfypeSrvgYlv2ECiORdhDTvdZPLwgsjNqbs7mgw2BNdWbd6rO0QOXgk+OTx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769914448; c=relaxed/simple;
	bh=fZuXa+7XsLp9rN/S3/8Vrg8fwxqUO7e3Js9TuPo/gqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8Z8wjc+uj9MRrbDEK3mPnxc1G5gcLC50o65h4ogrqg8A8ahLRnyJ1pcfrTPuBDjhuHSBWdePtRJ0UaYi6TzBncMo5Im7OBysdp49i/cd/WdEQkroGC2iof6/4xdwNmYQUtPaP6sT6+dfmKJurz+OSNEeiesKLZ8FCHkp2iAUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6ebPjW0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6ebPjW0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823c56765fdso441017b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 18:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769914446; x=1770519246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THol884nG+d9xEv2aMZupLFd8wYM+lvDMKYAomDS7sA=;
        b=K6ebPjW0vnDPAm0DpzXGVZHccstPCY5JQtvfFN3/25PFuLMXsiCm+8bHqKSUyow6nP
         //Rrefg5kARqQTP5soERLCbYL9o1RN34OD8R8j9XA/1biI716fuCr4iatusx/wh108DS
         YpLhFSvxzAZAiMOBOBVbHEtgDgI6HGbLswFboKE+/YK3L3KnCW+6aNdEubNCuFqjQEdY
         6iN+UHdNDK5UO6HI9hX1PG46Rq1J1j9Z/6ZDxZK23j8a+hAwcGpfTkutEx2UPG0KPq97
         VmP9MVt2/GPNngDHwFPuvpxQ4wqfnahqQ/4EBYlzd1r9JrQfkRheohoVwQVJdC6Uf/FI
         qGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769914446; x=1770519246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THol884nG+d9xEv2aMZupLFd8wYM+lvDMKYAomDS7sA=;
        b=buoUbPYDDnpmnVE5TQsYbpxqaiFBLFugmjiytziddDc+YPhYXR+KOPCPsntquQB8+w
         vACFN08ApjJj0/HQlym/rfU4veOX/VkU3zlut4rFrheKkQYI8LCzwcXzcH00zjw3GsCL
         BleX+2OhscMsTeyyww+CAnB8AnlLYsA+zJkGXUA0WRtWug85WUBkDpjW/tR3Fsi0Jx9e
         5u0L+M6C4iokZ4dswNHjAyvxPxZEcKDgnGe+197QwnKNHhUhO38Dlw8qZuqcl0zYA8Pv
         O/DzCRCoiTBWdbnKGch+RwN9Tr1ji6fL0Jqf+E0BJjLBmxY9pPbSk/NaUScl5aoJ2XMD
         1zeg==
X-Gm-Message-State: AOJu0YwJEAdaWDtRwxIEJGgc5gQmOJbeM4OQ0lQwJSs1nlKgJ45QKoQe
	cJxZe43MQB3D9iTAP3vrN1+3fba91XB+SW+OQ5Jgz5ZAOEhBPGChXY5+nMoFNQ==
X-Gm-Gg: AZuq6aIM39EbiWxXUUcWI7tNgNm3QuLWBJ885E87jFx833EXoQu32Br+o4PKgZMkQQc
	kf9ZBVRsZ2453kgs0+g0lODItzYeJ6ojCczE/1zWzKrfOyDjr1e5CmCu7b5syaKmSaI3nzxcaZQ
	ir9bRYII6W68kLC++NKIG0FoT1/KkwlpLCBQneZlH9P0nFKvQj7x7rXy5ZTAWFwX5kI8rfm/T45
	O6Ku0EqDorW/JLgDEbHfZJ1fsGJZkIi3QPO5NDxjmB8fA2WcpFzD5hXqHzywq6K08Yp2MCMWZT3
	BtCFCcdfaC4WXw1XcYW4mYNovOWPpelF5vw2ttlGmsRfiO9dQcp8kxOlT2CHUXM6uPGzvham78z
	GIv9M8qpM9Ng0gIt+54tAfiMgPOBLeOkf1z5Zh6YbNIaSIWNlcky5Rzi229IsV8fbPIfaX4qoT1
	0P/Iq1O2S7gclGwPOabNvc8bgs1I+kLqcXCB1ogPPnLEViiyqPrEXxh9mRz+R9R81mU3hddfdgZ
	z8ok3jBE8/ZnKWy0Wrz70CCkRJ6GyO5t/WfFu0FbyVdc5k1pA==
X-Received: by 2002:a05:6a20:3d19:b0:366:14af:9bd6 with SMTP id adf61e73a8af0-392e01aaba4mr8064430637.76.1769914445793;
        Sat, 31 Jan 2026 18:54:05 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3deasm116100415ad.57.2026.01.31.18.54.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Jan 2026 18:54:05 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v9 bpf-next 0/9] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Sat, 31 Jan 2026 18:53:54 -0800
Message-ID: <20260201025403.66625-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

This series reworks implementation of BPF timer and workqueue APIs to
make them usable from any context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Changes in v9:
- Different approach for patches 1 and 3:
- s/EBUSY/ENOENT/ when refcnt==0 to match existing
- drop latch, use refcnt and kmalloc_nolock() instead
- address race between timer/wq_start and delete_elem, add a test
- Link to v8: https://lore.kernel.org/bpf/20260127-timer_nolock-v8-0-5a29a9571059@meta.com/

Changes in v8:
- Return -EBUSY in bpf_async_read_op() if last_seq is failed to be set
- In bpf_async_cancel_and_free() drop bpf_async_cb ref after calling bpf_async_process()
- Link to v7: https://lore.kernel.org/r/20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com

Changes in v7:
- Addressed Andrii's review points from the previous version - nothing
  very significang.
- Added NMI stress tests for bpf_timer - hit few verifier failing checks
  and removed them.
- Address sparse warning in the bpf_async_update_prog_callback()
- Link to v6: https://lore.kernel.org/r/20260120-timer_nolock-v6-0-670ffdd787b4@meta.com

Changes in v6:
- Reworked destruction and refcnt use:
  - On cancel_and_free() set last_seq to BPF_ASYNC_DESTROY value, drop
    map's reference
  - In irq work callback, atomically switch DESTROY to DESTROYED, cancel
    timer/wq
  - Free bpf_async_cb on refcnt going to 0.
- Link to v5: https://lore.kernel.org/r/20260115-timer_nolock-v5-0-15e3aef2703d@meta.com

Changes in v5:
- Extracted lock-free algorithm for updating cb->prog and
cb->callback_fn into a function bpf_async_update_prog_callback(),
added a new commit and introduces this function and uses it in
__bpf_async_set_callback(), bpf_timer_cancel() and
bpf_async_cancel_and_free().
This allows to move the change into the separate commit without breaking
correctness.
- Handle NULL prog in bpf_async_update_prog_callback().
- Link to v4: https://lore.kernel.org/r/20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com

Changes in v4:
- Handle irq_work_queue failures in both schedule and cancel_and_free
paths: introduced bpf_async_refcnt_dec_cleanup() that decrements refcnt
and makes sure if last reference is put, there is at least one irq_work
scheduled to execute final cleanup.
- Additional refcnt inc/dec in set_callback() + rcu lock to make sure
cleanup is not running at the same time as set_callback().
- Added READ_ONCE where it was needed.
- Squash 'bpf: Refactor __bpf_async_set_callback()' commit into 'bpf:
Add lock-free cell for NMI-safe
async operations'
- Removed mpmc_cell, use seqcount_latch_t instead.
- Link to v3: https://lore.kernel.org/r/20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com

Changes in v3:
- Major rework
- Introduce mpmc_cell, allowing concurrent writes and reads
- Implement irq_work deferring
- Adding selftests
- Introduces bpf_timer_cancel_async kfunc
- Link to v2: https://lore.kernel.org/r/20251105-timer_nolock-v2-0-32698db08bfa@meta.com

Changes in v2:
- Move refcnt initialization and put (from cancel_and_free())
from patch 5 into the patch 4, so that patch 4 has more clear and full
implementation and use of refcnt
- Link to v1: https://lore.kernel.org/r/20251031-timer_nolock-v1-0-b064ae403bfb@meta.com

Alexei Starovoitov (3):
  bpf: Enable bpf_timer and bpf_wq in any context
  bpf: Introduce bpf_timer_cancel_async() kfunc
  selftests/bpf: Add a test to stress bpf_timer_start and map_delete
    race

Mykyta Yatsenko (6):
  bpf: Add verifier support for bpf_timer argument in kfuncs
  selftests/bpf: Refactor timer selftests
  selftests/bpf: Add stress test for timer async cancel
  selftests/bpf: Verify bpf_timer_cancel_async works
  selftests/bpf: Add timer stress test in NMI context
  selftests/bpf: Removed obsolete tests

 kernel/bpf/helpers.c                          | 456 +++++++++++-------
 kernel/bpf/verifier.c                         |  55 ++-
 .../testing/selftests/bpf/prog_tests/timer.c  | 250 +++++++++-
 .../bpf/prog_tests/timer_start_delete_race.c  | 137 ++++++
 tools/testing/selftests/bpf/progs/timer.c     | 118 ++++-
 .../bpf/progs/timer_start_delete_race.c       |  66 +++
 .../bpf/progs/verifier_helper_restricted.c    | 111 -----
 7 files changed, 851 insertions(+), 342 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_start_delete_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_start_delete_race.c

-- 
2.47.3

