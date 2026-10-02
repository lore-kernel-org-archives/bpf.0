Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E3496D5A
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956451; cv=none; b=FXB+VqcarYAmSDwXuSoGCT8svzUxtIi/Cco9W4xPlrypMVZHivBdTEqO/4ZZnOLNQQVDvOSysHOC1gkeG9L7gw31vRldZVzq0oBVPCGytwHnPNqTMSe8d0/UKAoIZK4tfd5C2BVZFCS15Yn8DyVlzs4s02OEGdpZmQf1ogMPVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956451; c=relaxed/simple;
	bh=UrJNMJCctvQ1Jn0RVEivMMg70EXY0gbc132xAwL3HpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhlUhanrw/3wv1b6R0hcathgD6MUI0kg6Hf/pLC50DDAHDomNUiJ/4h6Hc40fW6uixZlCc/MEQDu1RPuLNlS8IipbH/leuj6tIGfL2msAWOddFzo0h0DnIKvEYC4oC77H+9m8zhjvC2Asu7xwSDdBOs5ewt9JgN9kxs5wrE+/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbxFtmHX; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbxFtmHX"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso5873359a91.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790956445; x=1791561245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D81ZMFysfyLfU1ne8B9rWhavLRnTwYR1GpOUeU0mXqM=;
        b=bbxFtmHX2K/mADAzUXxERuGsfWu8XsWR7Z00rURHd2f0PYSNxQFlwW7jo8kivcY5BE
         xkJr9ar9xvCGt3D8U7QaKsas7yz6FV4H8s6g20g9DM3HKG3NOVlIiATZsL5Bm2QYLkLw
         EDenBnjZWgdfnl35DnjHObTYw44thbOYDTf3zjEBmb7S+goczLU+qHyg6SQXKApOTFMU
         xCN7j1dX6c1Azd6KhKrEwYfLAlpGIUhzuDb2FM7GYx04AmDkbNJtlsaa0q+t8N/+xUAu
         9O6MyfQ4axyQISAxZvAxTGgwsJAflPcPRI4NME8F0mT6JP/s6yObTbTJOHEUsByhFBam
         qi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790956445; x=1791561245;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D81ZMFysfyLfU1ne8B9rWhavLRnTwYR1GpOUeU0mXqM=;
        b=YixHD5deSRfwdnvCNkv7lDqEvQjf4OH1qKqj3WZt7gRjlds8cd4+mDM1G7z8JNgskq
         V3WPjP3Igr7K8ieF9CZhR/CFPG7N7gAO+kfgRvQFH070qB8YPvHRiwgy2SPJQTWIuLC8
         8gw+clIcYfbty3Axr2l7QYMqBJ8iNOPqw4sWxr5anJ+6OUhQVJ0QwlUqaCumL6nKk33P
         AszkxBbnKXUGMjVwAKbrjWRAXKY3pnngTTb6ONjd3bq/Jco6VK1UzajGF4/Cuhvqtonq
         OSWnrnmg+J0NgoL+GIVaIkh2muppdv/BnE/9Yb6n1cuCGrqj3R9oOhkB2nii3K8T7BGB
         h/0w==
X-Gm-Message-State: AFq9FYIxEH/Y8iRu7plcgdw7TmoIrVBTptMD8A/KmW3wAZAfeZID0lnV
	9yg+xJV21CTh5knH2bMtrsTg6nrnH6pJxoktQectuyX2cMLEDglu9ijU
X-Gm-Gg: AYBFou19xpaG3ZmdvGCZwX63IFP98MbRXfCrVV9i5FJ3XCzRV8g+R/GPw21U/FoLR8d
	amRqKM2QNGboAKlkL0I5nxe71ZX9EYmzjkxA9XDtMtZ8Z47UqlCnukBGnqHYtMlGXhRzDIMus8G
	cKve7iOrozqSCSCYEmyxDb0x63qJrFsYHD6B1TBD4LOpbz2wsLoiQjcwGYKwf753jIa5fSndWmD
	KE5qXysnURJA9hYtM/ZE/nihM7FQ/Z7+5rN4CTwI2MUL34g/fjQr6g81YdDJZGkrwEZEqXasOm7
	ImnzAQVQDg6udOVAMAn8S81PkL4jExJWKt5gJTecYM2E2L42zhScJsbJ+6nstPhRHSBfzmQ9qoe
	kVmlbuW48ga2R9+NxMTv9KqKsd1o9jqhNIlpjWJltbeczTt1kOctml3uoHZy+98MPE6dWz9zxoX
	sEvsHUhvfZSjkpRMmfqqQy6Dim94R42ax1SO3QtXRFnl0EpNZXl9I2Y7zvCdYnIQ7bTz6I+IMYh
	f5vP4Ji8vPMs8afLNhZrbijkJB9B5HmKZw6/kH4s5nMQwvhlFRNTqA1FWugZKNQXAF3foUW7YOx
	FnIqAC/wf0T9TSECSiC7gvjzHCeehAFf2wOPmtm6Bgr/
X-Received: by 2002:a17:90b:1b03:b0:3a4:7d7c:1866 with SMTP id 98e67ed59e1d1-3a6cecf77a8mr3003990a91.61.1790956444679;
        Fri, 02 Oct 2026 08:54:04 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f402dfbbsm9622721a91.0.2026.10.02.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:54:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [GIT PULL] BPF fixes for 7.3-rc6
Date: Fri,  2 Oct 2026 15:53:57 +0000
Message-ID: <20261002155400.661252-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 5fc5768c7ca92895ccd1de94dc521e5a55ae7896:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2026-09-24 08:25:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to de020dc8049bfb2b22e3b6d99c031feb2e22d112:

  bpf: Fix missing migration protection in __rhtab_map_lookup_and_delete_batch() (2026-10-02 11:34:15 +0000)

----------------------------------------------------------------
- Fix overflow of backward jump offset in constant blinding
  (Alexei Starovoitov)

- Fix packet range of packet pointers sharing an id when var_off
  tightens umax of one pointer and not the other (Alexei Starovoitov)

- Fix objects stuck in free_by_rcu_ttrace list of bpf memalloc
  (Alexei Starovoitov)

- Fix use-after-free of progs detached from busy trampolines: wait
  for an RCU tasks grace period before freeing trampoline progs, and
  patch detached progs out of trampoline images that are still in use
  (Florent Revest)

- Hold map BTF for the memory allocator destructor record to fix UAF
  in deferred bpf_mem_alloc destruction (Kumar Kartikeya Dwivedi)

- Fix missing migration protection in resizable hashtab
  lookup_and_delete batch operation (Ömer Mete Kaya)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (7):
      bpf: Fix overflow of jump offset in constant blinding
      Merge branch 'bpf-fix-use-after-free-of-progs-detached-from-busy-trampolines'
      bpf: Fix packet range of pointers sharing an id
      selftests/bpf: Test packet range of pointers sharing an id
      bpf: Factor out __do_call_rcu_ttrace()
      bpf: Fix objects stuck in free_by_rcu_ttrace
      selftests/bpf: Add a test for objects stuck in free_by_rcu_ttrace

Florent Revest (Anthropic) (3):
      bpf: Wait for an RCU tasks grace period before freeing trampoline progs
      bpf: Skip detached progs in trampoline images that are still in use
      selftests/bpf: Detach a trampoline prog while a task sleeps before it

Kumar Kartikeya Dwivedi (2):
      bpf: Hold map BTF for the memory allocator destructor record
      Merge branch 'bpf-fix-objects-stuck-in-free_by_rcu_ttrace'

Ömer Mete Kaya (1):
      bpf: Fix missing migration protection in __rhtab_map_lookup_and_delete_batch()

 arch/arm64/net/bpf_jit_comp.c                      |  37 ++--
 arch/loongarch/net/bpf_jit.c                       |  60 ++++---
 arch/powerpc/net/bpf_jit_comp.c                    |  45 ++---
 arch/riscv/net/bpf_jit_comp64.c                    |  56 ++++--
 arch/s390/net/bpf_jit_comp.c                       |  46 +++--
 arch/x86/net/bpf_jit_comp.c                        |  26 +--
 include/linux/bpf.h                                |  45 ++++-
 kernel/bpf/core.c                                  |  10 +-
 kernel/bpf/hashtab.c                               |  19 ++-
 kernel/bpf/memalloc.c                              |  57 +++++--
 kernel/bpf/syscall.c                               |  19 ++-
 kernel/bpf/trampoline.c                            |  85 ++++++++--
 kernel/bpf/verifier.c                              |  10 +-
 .../selftests/bpf/prog_tests/bpf_ma_ttrace.c       |  60 +++++++
 .../selftests/bpf/prog_tests/bpf_mod_race.c        |  34 +---
 .../selftests/bpf/prog_tests/tramp_prog_detach.c   | 188 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c  |  50 ++++++
 .../selftests/bpf/progs/tramp_prog_detach.c        |  56 ++++++
 tools/testing/selftests/bpf/progs/verifier_align.c |   6 +-
 .../bpf/progs/verifier_direct_packet_access.c      | 178 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_meta_access.c     |  30 ++++
 tools/testing/selftests/bpf/testing_helpers.c      |  28 +++
 tools/testing/selftests/bpf/testing_helpers.h      |   2 +
 23 files changed, 975 insertions(+), 172 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_ma_ttrace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tramp_prog_detach.c
