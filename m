Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C091B652E
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649601; cv=none; b=fjYyEcNYKe/ThF1m+cKQ5zgcWu7V/8AB6MPJBTyxo7VS27m8mGSXVTUoRw9ei7yTzvmPzpFw+z8u8bCJTPCYfw5QO8VVdV59GnalmwTl4WC7JOextRNuFdF5Ce0NyZ2xfMtpreqb/ftbuoCtvQxiFU/qOyRqKH6I+BIKBEaLKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649601; c=relaxed/simple;
	bh=D66adXG808kKvHGFjYUqA4tig8Dw+saSez0dVHfHggk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3BV6rIwRbQ1QQn9pnYQrMpumqQ2WhBP5jdaTLPUwMTB6qbUvu4VUQlknZHuobVowK/+2SUMD9vL+GnIZ8tHx/wuwEy1MOzeoyBdps7BQVlfmA7ZjS/cVBjQGxeEF67eYJJ9kFbnH/5LP4WUORrEgwX68N9Y24ldQxfj+MeNQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdJ+K1Fl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdJ+K1Fl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3816904a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649599; x=1788254399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcMaA8k4079NSaoa9TVIZnwrsvuZMFF/q9SWhIvUUQY=;
        b=KdJ+K1FlRxA4Hbfi44eznk+5FdwxOgFhBStC0evXcsJH4cr5G4fOtpypHa6eIQFFaC
         jtNGegI324eXNP6IqSHm54yioMCjI/aUhx+ObaZVS2xbsjOuR9AfYtZcJrPPMZO4mcyS
         w6YC1fnUAuCxGixSVlVh4wH23sr+XfZSywWCHMvE6mM1xbshXE5SNhQ0YvtkidVykwPo
         FIML5W9JmLRPtvLP16EB1k/Wp4jBF2nISGzdGSLt03W2V4mqoTZK7dmFuiUi6Kz6AAxB
         tct+YAHP1lxdK8Vph6LEXhGwdXCR7T4pF2lD5QeB6qU74rJdfK8n+8ojVLaQS7Zr50V+
         Tuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649599; x=1788254399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcMaA8k4079NSaoa9TVIZnwrsvuZMFF/q9SWhIvUUQY=;
        b=Mf3ozb/NzSuUPeRWV7qsE4QUi4HugUlPJ5CsqnOKozYdG6NBpZA3IuJUF5EGGJTOtC
         d9IHlcff1sJ2UonP45b79pv6k9ljHxPm+M/KoVTBG84PDA52Rfx2CEJAz3UgJl/JwB4Z
         drhbG9EhrcNxQL7bbfzF3Aaw0EijJeOj78hI+pnlNuRFkNJ05M7C/izbZdSaKRAOIJuc
         YQzHR9hJNogRBAMS5RhzVdeSGbvT6BNYfRKhTD6ROsbPrrnWaG7UQMZ5N9cLUv9RPBbT
         3F8Qzk2SdIdU3EJAYSckziuJstGKaFPS35lM37H2NXxOgngRfei9jcwLTnSKPhMYGD9f
         vlDA==
X-Gm-Message-State: AFuF++mDp9y3BI202bjtkCuVmWK+Bj7UIxHVH0n+Rn7GZHFQA4NLjj3l
	vXU/uRI+S7Ddjd8bI6LS01A+0BILYxRmkHiI1t3AjVibFI9fs19X9znJPFnBXESIv9U=
X-Gm-Gg: AR+sD12Rx/Q1wSZVrRu/Fjc7KcxU5OLbljJ6xMdIVrdt/+GfN6V2Mmfe8z0rrJ2btd0
	gyXUmwYTVwxoFR4opMNlRbgSoTI4yf/wOIcNj0MMhe7P229lJDz51uOcQ3SBxMLc9+M0JUgPWtk
	kmHJYaPeeMCJmfphDxpZZj1WELAiER8XgcN2hnfYxA9kqMnWBdOo1qNfICwtn5tP3tlg4su8HZs
	tQt8VkLCiEIrsr8atT65d2f3n6I50yN9Ctkgr76xpFLF4IGmreB0m9I/smuzHacwvBPJ4lNBUqG
	vYZWWpqQg/RTpRISI6TGucnCSxFel9KCstXBOlKUR1BFadS4EgkTmxsHkZ6tCahU2NHkqH8LgiT
	gtiM6sI2rbpYLUnB51nM3Qo+VPdBLjOPLIG2ML0LdoT5b5SA0k4WZEsWRaCPUjhxOF9FyXlsWyI
	oAxV6YpWXFZnTJLR2iPJ6EyBt53vjl+KjaVo1jNA1LCn4bOo+0vOOhYFE++ZdkQzcrj58NCOuWB
	xebd86G/VzCw+3JG+M=
X-Received: by 2002:a17:90b:1d50:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-395df29b3c5mr51331801a91.12.1787649599247;
        Tue, 25 Aug 2026 02:19:59 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm5386163eec.30.2026.08.25.02.19.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:19:58 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH bpf-next v6 0/4] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Tue, 25 Aug 2026 14:49:48 +0530
Message-ID: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes an issue where accessing a valid BPF arena page under
memory pressure (e.g. hitting a cgroup's memory.max limit) incorrectly
results in a SIGSEGV crash rather than invoking memory reclaim or the
memcg OOM killer.

Problem:
========
arena_vm_fault() previously performed page allocation while holding
arena->spinlock (with interrupts disabled). This restricted the allocation
path to the non-blocking alloc_pages_nolock() path, which cannot sleep,
reclaim memory, or invoke the memcg OOM killer. When the cgroup's
memory.max limit was reached, the allocation returned -ENOMEM, which
arena_vm_fault() converted to VM_FAULT_SIGSEGV, killing the process on a
valid virtual address.

Solution:
=========
1. Introduce bpf_map_alloc_page_sleepable() using BPF_PAGE_GFP
   (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NOWARN) for sleepable
   contexts.
2. Rework arena_vm_fault() to preallocate the page outside arena->spinlock
   with bpf_map_alloc_page_sleepable(), allowing reclaim and OOM handling.
3. Use a lockless probe (vmalloc_to_page) before allocation to avoid
   redundant allocations in the hot path.
4. Replace misleading VM_FAULT_SIGSEGV returns with VM_FAULT_SIGBUS for
   non-recoverable internal errors, reserving SIGSEGV strictly for true
   addressing violations under BPF_F_SEGV_ON_FAULT.
5. Add a BPF selftest (arena_memcg) to validate fault-in behavior and
   proper OOM handling under cgroup memory.max constraints.

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
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 7 files changed, 340 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.54.0 (Apple Git-157)

