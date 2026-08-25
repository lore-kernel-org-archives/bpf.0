Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFF3F0AAC
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651405; cv=none; b=AMi+BW40j0KLtNN2lVfSOryuX8nap0OikCtmZk2w+/4V9bgJha4PrP3GXvq5CJwvO8ZXhm2/arihp97yahNWj9rMTwUL4+am4urGmyainEpTIqSUmr+or+LpYe9EII1oh/Mc2G/eEUSo9uJK4n4nlllKR/GAqe2oV0EIPcZBfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651405; c=relaxed/simple;
	bh=rx0AYvNEzfUTPUbC7Osq3TBYhgxON1ZZbLpVus7LB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fsl+Peb6c+wLrAKjSg2EXsTJicdfUoI3pIJ7dOAxePL5YRJ1IaUh1/ros8pcs+VmEFDtxEC2ip+3JcwAWN84dQs4duMP73Xt8lJ895avHIRRceSKoC0LMaterk2cXR0e0++6a9tZz33ik+GYsJ/WmrXqE4prAK2DgOrkWo34ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiJUHbiL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiJUHbiL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso39423805ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651403; x=1788256203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jS+uTmL4/n2oCk1Ir9FwlvlGrc3IhtV0tpJIZb77O8=;
        b=AiJUHbiLOFm+BW3wki7LpygNelvdrjSKgvTLC3QMayOuoghR2XI6Zf0sl3dKwD15aP
         0Sd8l7c4QEI5XO4D7yig5EPPrNJ//Iv1MHJSvfZqGuv3z4uOPj6d4FExXO2crPR9VvzH
         BUgRoQ1csHPgNef0i6gyutVmjTmptmRlxmwebCZgiw67Ghjg+1QGDUET0esm0DUHLkgm
         gO1IQhsjOLKpAalNMtKJbWw2RWGDZVi87rIamXXLEvaaz3oSjpZCoxK1qNQ779/fSSJj
         9jUiEfEJEgjxfYllmnuUT5Mg7nHLzWkbhxBLgePcgZMKLnHFBrdMLgwooYyjIa+JIFLI
         tFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651403; x=1788256203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jS+uTmL4/n2oCk1Ir9FwlvlGrc3IhtV0tpJIZb77O8=;
        b=KpMXe2bsRcFIt1Lox8BNACOi75sY9qOx1wXe5dv+ovPMCZivsbXdbmPJ5kOCQhknt+
         zadvRYJeluVdCmP6E9uZeW80NHWSGjkV5U5QlGQd6F4qM5eaLIzoLtpv73kAyaOL6ED5
         IPVfEA4CXNOAarp1ac0Z4giGh9fbAbLMfiK837BiFk42uxRiJFAy+enW2wDDZolgQyui
         7Wc2pmmZd6qHXM2m3mzVLLJM6LBWgkYaWNO2A5f7WaG66DrPib7/siJdPf739lWLQYAW
         BegHEKpkS/F8tmqN58EVtdioccAZhXw6F27eMahlVTVkxLJxRCczpuTq0tN6xpjs01dr
         f3eQ==
X-Gm-Message-State: AFuF++m0T+rgKUgXMr9MP2CG/PA3NykDfSSRC+/9DVIm7aVmM5u3BeGe
	V+NMsXRVr5FbjtUHhyNz6QJsDbQu4T5+UcncDXq5DpbcI/yET8SZ1yPEBQKBmcqZ5z0=
X-Gm-Gg: AR+sD11kG2PaRIJ3G8tg9whnD9VKPAetZ3VX7jCqSp78QfBVbiXvi7r2fv+2ct9hO4N
	9ScY4Mf/hfQLhNZ+g60OwRqhEt3lzZie+IEaO6P9//9vyqC2lnU7HJD87bCDkdOcDLGTJ/z99RS
	90UcGOyigeDvkw05WOG/1+P1Xn5pbi755QtTBRoa151Dg+RHMUgpOwBhscjW6EVmW2AVYfiOL9H
	DffBQzWjuoVc2m5QncNZvmHv4c8+WPjtwLh9LR7+AtYvy8pRxPKLZHg62aGWoRzXcv+2MuExoft
	tMPZLQGQ1h47eBwyVWfAi2DiYffwbaDn4LO91hNMQiQmsOeOugrez00RNumCPDt2XmkwUJNjL8a
	tgAIGruANL3jMFdsVCXdx51Yr0Djw5o9fKJFWz2DrtmyHG0rkYyQTuoTz+0N4fnUhOdeHRgEv0j
	gJ55OQ0jUHxEdEj/ztmUyKAHWM5vUPp4uWQGgWXJnD87S3VwoJt3Aj1Jrd2TX213sQOFIXFfPkb
	Xa29PcYezmHWjHo5M8u6eBSv5w2Cmv2Cf4H
X-Received: by 2002:a17:902:f687:b0:2d6:dfaa:c26a with SMTP id d9443c01a7336-2d6dfaac5f4mr85362225ad.8.1787651403253;
        Tue, 25 Aug 2026 02:50:03 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32827662702sm5923062eec.10.2026.08.25.02.49.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:50:02 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next v6 0/4] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Tue, 25 Aug 2026 15:19:51 +0530
Message-ID: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes an issue where accessing a valid BPF arena page under
memory pressure (hitting a cgroup's memory.max limit) incorrectly results
in a SIGSEGV crash instead of invoking memory reclaim or the memcg OOM
killer.

Problem:
========
arena_vm_fault() performed page allocation while holding arena->spinlock
(with interrupts disabled), restricting the allocation to the non-blocking
alloc_pages_nolock() path, which cannot sleep, reclaim memory, or invoke
the memcg OOM killer. When the cgroup's memory.max limit was reached, the
allocation returned -ENOMEM, which arena_vm_fault() converted to
VM_FAULT_SIGSEGV, killing the process on a valid virtual address. Hitting
memory.max is routine (e.g., page cache growth from reading a large file),
so this killed innocent processes.

Solution:
=========
1. Add bpf_map_alloc_page_sleepable() for callers that know they are in a
   sleepable context. can_alloc_pages() is a conservative guess for BPF
   program context -- notably it is always false on PREEMPT_RT -- so going
   through bpf_map_alloc_pages() there needlessly picks the non-blocking
   allocator. The new helper uses BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO |
   __GFP_ACCOUNT | __GFP_NOWARN) directly.

2. Rework arena_vm_fault() to preallocate the page outside arena->spinlock
   with bpf_map_alloc_page_sleepable(), like do_anonymous_page() does, so
   it can sleep, reclaim, and invoke the memcg OOM killer instead of
   turning a routine memory.max event into a spurious SIGSEGV.

3. A lockless probe (vmalloc_to_page()) before allocation skips
   preallocation when a page is already mapped (e.g., allocated by the bpf
   program), so the common case wastes no allocation. The rare race where
   such a page is freed before the lock is taken falls back to the
   non-blocking allocator under the lock.

4. Return VM_FAULT_SIGBUS for non-recoverable errors (lock failure,
   range-tree and page-table failures) instead of VM_FAULT_SIGSEGV;
   only BPF_F_SEGV_ON_FAULT, and a scratch-page hole under that flag,
   is a real user addressing error and keeps VM_FAULT_SIGSEGV.

5. Add a BPF selftest (arena_memcg) that joins a child process into a
   memcg capped 64 MiB above its post-load usage, faults arena pages
   until the budget is exhausted, and verifies the child is OOM-killed
   (memcg oom_kill event) rather than receiving SIGSEGV.

v6 vs v5:
  - Fixed redundant #include <unistd.h> inside #ifndef PAGE_SIZE guard
    in the selftest (the header was already unconditionally included).
  - All patches carry both original author and reviewer Signed-off-by.

Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>

Jiayuan Chen (4):
  bpf: Add a sleepable page allocator for map memory
  bpf: arena: allocate the fault-in page outside the lock
  selftests/bpf: Add read_cgroup_file() to cgroup_helpers
  selftests/bpf: Add a test for arena fault-in under memory.max

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arena.c                            |  90 +++++++---
 kernel/bpf/syscall.c                          |  21 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  67 ++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 157 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 7 files changed, 339 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.54.0 (Apple Git-157)

