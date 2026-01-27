Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8036EA92
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542303; cv=none; b=hrMZQ1zaUXtCkbKyUyh3G7JM++/rD6bQY1fNJ+0VDUsuIsXrk9/xHOrrW02Q4lI9W1+tJyJwCLZ8pemmllgdF9HJXt/s2faXdOZpaIS7b/CMZbbiI2PHfXvG04/Jgg/LMVK49oHVFx9IWhd7HG1fJGH7P3sRqqORGYF//BdGW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542303; c=relaxed/simple;
	bh=FEun4FkTzs/vGaWi1GCOQ541ZbdY7xZ7u+BU+IXUiAc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b88S4GLzcvaxIIqHoGHgxEkfjcwM8cbFtfev90rqNv0roCFFnzuhqfc78dt69N+JXhMGOP/b3M8saq1q/WVXKSLEVjAIF6fwz8uKQ5rxWgjgpWhmuBxweugGIu9HplWc+fp6pbJtDL3i3jUGvnNl/1xFJh0RjyWOF5Kg1l3+xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/6eY6Su; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/6eY6Su"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43590777e22so3773693f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542300; x=1770147100; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koZKK4ItZWV6mI+8jXBt2cRm+pV5T+CMwOgEYI2VNvo=;
        b=H/6eY6SusE8sr6NFu6Lo1f5IxCwq/BeJKgx4rBEI9PzNKbe4L3foTfR+xfzsoveMy4
         RU8ZqTCZ+NwQ3Mt0jZN+arA67q2H6xalu2n7fiCI6+xfqg+lHbfZa8RD0be0lM+AJph5
         U3CBuyC+qXhK40R/Ce8wGusjZs3Sl1g7giOTJ0rrwHDoLSEjvbLDiZuFovNTgU6HALUU
         9EIey12drumG70pJLUazOS/UXphVEIqcjlCzBGq+58tyyVBG2eKEzuiZs30sULTHP5Dg
         Nit1D7f27+y+bhERmaLqeharxcf9WzLAIJZCFE5Ka/MplTWA1tgutZsZXNH3fy88Tpx2
         IKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542300; x=1770147100;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koZKK4ItZWV6mI+8jXBt2cRm+pV5T+CMwOgEYI2VNvo=;
        b=IRlVA4SBhdlNzQAm5WDG8LhVGWAJWX441anhtOzuF98jF+TSca9fXaL9DuM+NTd1hW
         s3M/DaMDH9VgMwo3JceWmBnU/dYSXX/jv2QvETsRbZva/ETWV7iiuMqxXMNgNjlJILvI
         jCMI58TAlY//E/gpkehin8RDVkSxoMNgBwnwgRh6YGwcm5kSPJOjHJiUL1tg6huAxxe4
         0osPSC9G0xLL3rbWrMDrLRl3LpMhTZyj6CBzR1nI5LUXTsN7WadmNsAAHNooiGi7JI9s
         QyFHUGyygBWjS1ZZcVb/xKjHmIhukiiwSOxYCS6GT2SgWQ2A+ARuUqvl/vG0RM5LMt6g
         Le/w==
X-Gm-Message-State: AOJu0Yzn0S5Xm+fF4RZfqRBQvB7B254VY6KxF6sUvt4/VAU6Ik1+vUvX
	H5E8mjc5eB/esc07kUN56u8uGhFacyU3N+Ath7CGLnXDbx1Ove5o34Q4unLSdVVB
X-Gm-Gg: AZuq6aL30h1Bss1ymwW5iJVaPrUqwVTN96eMVaPrF2pYROwimBinH2bzmMaTm3G42A7
	DTAwB/J0cIl/2W5+R7o63/+B41UtEHJ7n5YEh2cac7eFQ4lV0Jk2l6LTf67/Mr0wmEK1PyA9R4x
	GeSOyRcKVBxl7usTxkTMkIVlMqSL7jucm9+8FZrTjAeCFTXAskIO8PT0fTZ2BTqcmEFAj+KumM+
	kAY573GjbuZUHG1SigT60l0pEOAhVXWbK+oBF0HPkriPonU1SGeIYNBwFTt0AcLSLE+WM7YMIIE
	eH0q5cpVcdrZpi7pI2n7L43MzUqSQExE9yF9ZcmLogodkVkcfcCdMgIiI97KVJ4V7hX9w32C08l
	V+bpTOLV+jtdb8bPqXxVZimCZ+3zAGsJ7Z6VW6Ebs2kEh3UcTzd+H82cvqS/LoU236UrKuUi8JV
	3qUN1EWYthpjDAwtP1VwFZF0sk28K9sQ==
X-Received: by 2002:a5d:5f53:0:b0:431:266:d134 with SMTP id ffacd0b85a97d-435dd1cec11mr4308976f8f.53.1769542299641;
        Tue, 27 Jan 2026 11:31:39 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm817871f8f.36.2026.01.27.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:31:39 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v8 0/8] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Tue, 27 Jan 2026 19:31:17 +0000
Message-Id: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13O3UrEMBAF4FdZcm1k8jNJ1yvfQ0TyM+MGbbu0p
 awsfXdDRay5PBy+M3MXM02FZvF0uouJ1jKXcaiheziJdAnDO8mSaxYaNCrQnVxKT9PbMH6O6UN
 a9IzxnENIJCq5TsTlts+9iHhlOdBtEa+1uZR5Gaev/c6q9v5n0qj/k6uSICM4G8iCiRyfe1rCY
 xr7fWfVf1YBNlZXa7Q7dzlCFzk01vxaBwp8Y0213kI2lAwhnxtrD1bZxtpqOTiDyKg4+Mbi0bY
 /Y7UKyQRi7cHkxrqD1dBYV63zwJyz73y0jfVHqxvrqwUbLCbEpEkf7LZt36nSP4YZAgAA
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542291; l=4761;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=FEun4FkTzs/vGaWi1GCOQ541ZbdY7xZ7u+BU+IXUiAc=;
 b=Cpw81L4wpMlMuw4P0fnw40fpGyC4RtnlZ5yV9KyDqmDcKh8LAK0S/rDnOneg+jEdeSoa+U923
 ntRMzitDxqnCRktpSKnQ4eLOqA4PeYFEQnv6WilfCS4TGUa+1s4eRnK
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This series reworks implementation of BPF timer and workqueue APIs.
The goal is to make both timers and wq non-blocking, enabling their use
in NMI context.
Today this code relies on a bpf_spin_lock embedded in the map element to
serialize:
 * init of the async object,
 * setting/changing the callback and bpf_prog
 * starting/cancelling the timer/work
 * tearing down when the map element is deleted or the map’s user ref is
 dropped

The basic design approach in this series:
 * Use irq_work to offload all blocking work from NMI
 * Introduce refcount to guarantee lifetime of the bpf_async_cb structs
 deferred to potentially multiple irq_work callbacks
 * Keep objects under RCU protection to make sure they are not freed
 while kfuncs/helpers access them (We can't use refcnt for this, as
 refcnt itself is part of the bpf_async_cb struct)

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
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

---
Mykyta Yatsenko (8):
      bpf: Enable bpf timer and workqueue use in NMI
      bpf: Add verifier support for bpf_timer argument in kfuncs
      bpf: Introduce bpf_timer_cancel_async() kfunc
      selftests/bpf: Refactor timer selftests
      selftests/bpf: Add stress test for timer async cancel
      selftests/bpf: Verify bpf_timer_cancel_async works
      selftests/bpf: Add timer stress test in NMI context
      selftests/bpf: Removed obsolete tests

 kernel/bpf/helpers.c                               | 449 ++++++++++++---------
 kernel/bpf/verifier.c                              |  75 +++-
 tools/testing/selftests/bpf/prog_tests/timer.c     | 250 +++++++++++-
 tools/testing/selftests/bpf/progs/timer.c          | 118 +++++-
 .../bpf/progs/verifier_helper_restricted.c         | 111 -----
 5 files changed, 659 insertions(+), 344 deletions(-)
---
base-commit: ba335bf3a5b8c5f47d56e9be3f96e0989dad5346
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

