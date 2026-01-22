Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F5344D94
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105025; cv=none; b=erThO3L8g83CAbLx1prDVx9WJt0ORD9rKMtiRuVpkQ6CzPkFaHlBw4m7EV9+jZpBToVLNwZZ0NYn6DJ7onSxO0PiifNJ9jq9TuSLdlUF8igUqNJRNI8VzONCkWYFX3lolRl8nTPOY579bCNgpYX7zEI9XZslKJAXTNil8vn4IlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105025; c=relaxed/simple;
	bh=USL78qAJ3Lm44O0H4a6e2qzHduDY/Bi7UVnr9jGRahE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eq9Zb8Ax0xAcbsVxgnYIMS4YJLdV4ScLSiAhlblV0ESjTtZI/zUoriLw0+aOg7Z5xYsHcHwUj7BWyJDQWVwEQVMbppUt2PR21Y1JoIQdjJVjYwSZy04ctlOmJgcyeCL7mZtIc0MU9Ypns5DUhSHf4KkV5bEFxFXFDZ1umNDAD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUnLikSI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUnLikSI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so1096701f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105015; x=1769709815; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUwMbRGyh08YJmW5R0bfe5Ly7fktsXWYmyQS/5HQGSY=;
        b=IUnLikSIC0NWmpMSlzzNV7m9sEH/mUClc5Iz+J+zngwrWXQW63k8ZfJY5UncRE5JaE
         T6ZxKWRzOGHoIWi/3TckQWUxXPGI4y9uL03SXpoc+HAa4gXheuPgEF+H3nAHBdPijt/e
         KP9xj238G+chxyQGEcJuxdMyyIdH395zAdrVxylinGojlSVlPHU9pvla6anKIuMW8RbW
         ZVjgjkLQI5zwS9h24hbwYtVGrGFj5vsP334pkmBjefZdcXNPciId66GTXSTajDFl/gqx
         a6ME/0IdDodDv4pUS9kpFU5zx1sNLhB8jEvNzNPlhvWCNigkA/e+32K3Xg42IonbBK04
         gZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105015; x=1769709815;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUwMbRGyh08YJmW5R0bfe5Ly7fktsXWYmyQS/5HQGSY=;
        b=F5+MUFyXp/GWPTANZeE4KQsnS9/rF66hHxmAKKlXscQemSjptpv8RoUtcvMg736nGQ
         45SHwevkas31pe8N+KHXYMpcZqRfpu1GnV9Anp4BwXuSYlCf5pBjGuqJSdXp9z9YoRqX
         ERIFci5+XNOGoeeWIUtAgs5taH0nnEG7rNji37G5PzOd45M0elvc+7h+4PA5Kyajyo8a
         4AlOoSPbbrPDDVYuXNWKSC02/0LxDvJ1y7fyN6/mGvSURt+tRSkamFsk/8k6Fp+uKNzC
         LGF+WDOzfRyfsmH1rtEuQqzSv2V6FFuNjoV9ainvw1UyS2HW3/ztz4iO5wmZ3eDrihpr
         MCCw==
X-Gm-Message-State: AOJu0YyhiNUdKztJnYiX5yxDw6Ae1uAP1hSdhTMPecpwnGwT9Us6kOPn
	OYaqRyEk6zG/te1Y/c4zsATeVrEnnbGq6qyzVOyVCngnU8Gwi5aCQXkI
X-Gm-Gg: AZuq6aI7AgEd5oIxaG1Km3cqQNJ0Eo9iTLi1frG5lP93FpwKcOGjQMNg6oHQZbx5hQ/
	28OyK4D1ug45o7QyEXCySLkh1DQ2Ucx7x4ScIXEygd03iulSCIHm5Pkoq7tC8qmZ9CP9go6f6sA
	xc0IrfJT5drFJJd5htjjg+avZIvSy50/AS4oMuszvs116/nU5EmTNxgfYNkxpkiSG8Tf/jSzMv9
	nKbMjZTmv2qhBCa/U1VodMLdZ05oUR1K6t/sYe3rRAKdV5ciVdLzCZCHgFBWVjQQftWYNgNx81s
	1HZnyJM5C3hZxl7FykZB+f/b0bLZXg71A8YT42KCG8vxu2q9V6h/ivGZdIeV33sPTFan5xMZ8kO
	nzaNuDhhvpLy9EtLaZk12Pk4s1pQZIa3Rwnr4KyuEwdz1psljd4bS+9YGZQqsSDZnoKtNo82ux1
	pARI2GigY/snyi
X-Received: by 2002:a05:6000:288c:b0:430:fc5a:40ac with SMTP id ffacd0b85a97d-435b160615emr774256f8f.54.1769105014904;
        Thu, 22 Jan 2026 10:03:34 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7474csm310447f8f.37.2026.01.22.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:34 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v7 0/8] bpf: Avoid locks in bpf_timer and bpf_wq
Date: Thu, 22 Jan 2026 18:03:13 +0000
Message-Id: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13O3UrEMBAF4FdZcm1k8jNJ65XvIbIkzYwbtO3Sl
 rLL0nc3VMSay8PhOzMPMdOUaRYvp4eYaM1zHocS/NNJdJcwfJDMqWShQaMC3cgl9zSdh/Fr7D6
 lRc8Y2xRCR6KQ60Scb/vcm4hXlgPdFvFemkuel3G673dWtfc/k0b9n1yVBBnB2UAWTOT42tMSn
 rux33dW/WcVYGV1sUa7tkkRmsihsubXOlDgK2uK9RaSoc4QcltZe7DKVtYWy8EZREbFwVcWj7b
 +GYtVSCYQaw8mVdYdrIbKumKdB+aUfOOjPdht274Bpg04od0BAAA=
X-Change-ID: 20251028-timer_nolock-457f5b9daace
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=4491;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=USL78qAJ3Lm44O0H4a6e2qzHduDY/Bi7UVnr9jGRahE=;
 b=AdUF3Pii56PjolQmtjxeCrJoZ0rvikVHtIy2+fLThc52ctFgftosxLpChkgRGAeeHhhYd0JbC
 9HOnO25KjIDAYHJgCzMAS2BtBdyH5GRQCRM7/Ql2sSu3fPEFM5zU6/8
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

 kernel/bpf/helpers.c                               | 447 ++++++++++++---------
 kernel/bpf/verifier.c                              |  75 +++-
 tools/testing/selftests/bpf/prog_tests/timer.c     | 250 +++++++++++-
 tools/testing/selftests/bpf/progs/timer.c          | 118 +++++-
 .../bpf/progs/verifier_helper_restricted.c         | 111 -----
 5 files changed, 657 insertions(+), 344 deletions(-)
---
base-commit: ba335bf3a5b8c5f47d56e9be3f96e0989dad5346
change-id: 20251028-timer_nolock-457f5b9daace

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

