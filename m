Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8D145B27
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982293; cv=none; b=oh3aU4zD8ZdL76M/3mUPOiZBTHYaJ3bxsMBMwSG0IxT39QHsdLBJxud9zlF2eNoNZVBJzwy9D3DXuWHQL7sna1ETDP7FPOpwqfZ0iEl0uc90OlE2RXrQ89MHo70fXTS701AkKnmFGm96uw5wWjLC8RMXD37MKWQS4H9L3NoYkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982293; c=relaxed/simple;
	bh=ly36mi9Ry4l1tnU+CFGk8VU4+PoHJGLA1jzQDwEq9yw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NYsfZuPNS3nuTysmyWfwx98YxaE4dnPdjgudFCrDbSlA3FxibdrIAMJsVo6vcppsl+3hKhogoQYwxaW8brM89ovXbIi7VP6wSM1T4HFqzATdQydFNeUgYkfaLVpszowoH4G4phAyA9m/efyKoE1ge8CdjIV+L4fMF/RvomYxU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBO3MHVw; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBO3MHVw"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137f3465368so6737545c88.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982289; x=1781587089; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f2tj+D+v92R1/NmUXvRDCck4SYHcAarG3cEOzBbZ/BM=;
        b=nBO3MHVwpvcRpkG0U5JW0tIUh1nN5yeDs1ha4BOfORPdHCRMlsM0VKtVTRntkRxEg0
         LES/2kXOch5EDu21cKwlBoPdQ7D3GGtQpUWf5RcTlxmlUGAHkqMMh31I9Pu5xJJs+OYu
         yvgvGPn6id8TIsY+kLqGu7T1UEVbqb8Hs0/DNjIGsShumifrK3VDb3NSLEFvDJ3j9ENJ
         zWRoE2PZv9VK7HbpwOZjRgzsyjmlqSOQKx4lCJscVtE5fCbCG30/d9tvJsXXEhiou1fI
         REARohHODfgIah3Qi/uWt5PKRLdwGWEuJngR6RML59Ul13ZN8gnRi2Y2iooPTpPJS9Mu
         MCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982289; x=1781587089;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2tj+D+v92R1/NmUXvRDCck4SYHcAarG3cEOzBbZ/BM=;
        b=Ho5HePUHppzglRA0b4I2nkpnUIyKxj92Q3JYKDyFzeRyiloVoLxOse5blfEmEcLPHd
         J9RmoouQSDrXpHQivrAQYytx9ySi4qM+s43IIaZuoQA7PUwH3RnUlteH/vpi/QfcEcxd
         valuIU5JR8iIYiBvf0PufYE9wQdrC0lv8bxXd4yEes5JHUOQMXjf4rq74wByXTAGRqU6
         5pf/2Cs/p3MdeokE+93jeR4jKhKfZeQVT1wWq/tE0/Gq9rCS5CrKvRvEv2QwfWvTQ9+h
         Ot4A5FCPMZ7g5CISBs0YY0TrInJ7WFbdYorU2NYUup1BiuiqG2e4smzc/Ka7sv9ao75Q
         JJhw==
X-Forwarded-Encrypted: i=1; AFNElJ/ti1z6i7zvV1wnOsq0jtn9fFSL1Xkh0jEjEdSf4WWPpQJ8NHj+X3qdR5AC8Bd/UUhZfjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeNVEwamSaIPH3IyCFr+Qem9At/Ld1EaIgzqTRJ3rdZFWAPU9
	S5iUW3j5xMOlrYS+6ZgrVnY7RFfOxSs3xhoBj8DG6JyCv8G81R4DBkPcr+xAhbWOsKW2HT8jUwX
	D9o5HamNz5Q==
X-Received: from dlak14.prod.google.com ([2002:a05:701b:290e:b0:137:f4ec:29fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:605:b0:138:1569:6f1
 with SMTP id a92af1059eb24-13815690804mr7185554c88.11.1780982289091; Mon, 08
 Jun 2026 22:18:09 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-1-irogers@google.com>
Subject: [PATCH v1 0/7] perf annotate: Add elfutils libasm disassembler backend
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series implements a new native disassembler backend for `perf annotate`
using elfutils' libasm.

Currently, `perf annotate` defaults to invoking an external `objdump`
process when native disassemblers like Capstone or LLVM are either
not compiled in or unable to handle the target binary. This fallback
incurs significant overhead due to process forking, output parsing,
and external process management. It is also inherently fragile and
complicates environments where `objdump` might not be readily available.

This series integrates `libasm` directly into the perf tools to parse
instructions natively without any external process dependencies,
providing a robust native alternative to `objdump` using elfutils.
It adds:
  - Build checks and detection for the `libasm` elfutils library.
  - A comprehensive `symbol__disassemble_libasm` implementation.
  - A `--disassembler=<name>` flag to explicitly choose between backends
    (e.g., `libasm`, `objdump`, `capstone`, `llvm`).
  - Temporary ELF file generation for JITted BPF programs to allow
    `objdump` and `libasm` to decode them gracefully.
  - Full system-wide test coverage in `perf test` that validates normal
    ELF execution and BPF JIT output across all supported backends.

`perf annotate` will continue to seamlessly prioritize the available
disassembler backends, but `libasm` now provides a robust, native fallback
for standard environments using elfutils.

Ian Rogers (7):
  tools build: Add feature check for elfutils libasm
  perf build: Add build support and capability for elfutils libasm
  perf annotate: Implement elfutils libasm disassembler backend
  perf annotate: Add --disassembler command-line option
  perf test: Enhance annotate test coverage and isolate config
  perf annotate: Support BPF JIT disassembly via genelf
  perf test: Add BPF JIT annotation test coverage for all disassemblers

 tools/build/Makefile.feature       |   2 +
 tools/build/feature/Makefile       |   9 ++
 tools/build/feature/test-libasm.c  |  19 +++
 tools/perf/Makefile.config         |  23 ++++
 tools/perf/builtin-annotate.c      |  10 ++
 tools/perf/builtin-check.c         |   1 +
 tools/perf/tests/shell/annotate.sh | 125 ++++++++++++++++++++
 tools/perf/util/Build              |   1 +
 tools/perf/util/annotate.c         |   8 +-
 tools/perf/util/annotate.h         |   3 +
 tools/perf/util/disasm.c           | 110 ++++++++++++++++-
 tools/perf/util/disasm.h           |   1 +
 tools/perf/util/libasm.c           | 182 +++++++++++++++++++++++++++++
 tools/perf/util/libasm.h           |  27 +++++
 14 files changed, 513 insertions(+), 8 deletions(-)
 create mode 100644 tools/build/feature/test-libasm.c
 create mode 100644 tools/perf/util/libasm.c
 create mode 100644 tools/perf/util/libasm.h

-- 
2.54.0.1064.gd145956f57-goog

