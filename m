Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E293D0BFB
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988861; cv=none; b=EjiWweVv/Z/6P0L2KCiNOsQb4L/OJRRMjc7o5EfNG7xpByOwTcncn3ScPRmMAQs6x0PS9MfmzARnCiZ6P4H7EtJN/ViQn3IZYJlrOxG4I5DrL5xqsN7Rnz1zbsksHcS+FKsOwFVnrU8u+P6DPE89T8m8u9xfw1lGBD6zd6wcsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988861; c=relaxed/simple;
	bh=ih/WFkHQ584rId30STWxtTkSWunNrrmDUCVGPyksHj8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YxUKgsyrThKFb5to1LMA0to5QymskaZBOwAo4JDoqLJVHLilD/JohhTMmRaEE+ChqYnW0aNaaJhSipFUjQhgOpZvJ7KDFrw/hfmMjd0oUketXjYtykkTGubD2YGAQ4WXsNrmngi9F9kX7F3YFCZohPugKUR6RE1CgSiKNmmDYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JP+hUxrK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JP+hUxrK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304dd917645so5128003eec.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988859; x=1781593659; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxckLdcG/zu0VSlVCoGLUc2yFYusbAIrF0yTwxkZNwI=;
        b=JP+hUxrKS5f9kEZf/4TiHpSHULrr702pRmmwcOXBRDpOV18vw56gGEANyrT22d4qGQ
         91LlezF/Ex5frtqhakKD8ZYec6zPJU1bwfUkrJ48PHehWTTFycvTCrLmJlSn5JpgGY3g
         SPckAyDaiDUR3XjtsHhm8x7iKIqnVcwlqcYw7R3RNv1ytWWdxcxlFcbfP1knRRyHovzQ
         4Q38+T4jP/BMHam5fk2G21rXtCnsIYar1VWGuYygFnVPMZA0WldjZJ0wMu+AUstBN3+P
         nYnKzVMxXaLZBO1V2HFxUKv8xLDp7NNhMfwNkfBBM5IZm8g4BeNt90K5+XqHDZanZVOD
         AXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988859; x=1781593659;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxckLdcG/zu0VSlVCoGLUc2yFYusbAIrF0yTwxkZNwI=;
        b=dzpflbgF/pfGgQiYK9zksbdU1npo+09NUUnuBChPkR/uv5szot5iPdM/byEkWjxOoS
         K2EutglkawG13/h9ogsTmLLc5yjivecw3NJbcvxfLp2yVe17IVYi4mWcF9YscsjU5QPP
         su4BUNReLsGejfucyI3D6N3ujw30IatAsu4WJrdSUHAbDpgE70zxF1xMmsbMvAhSxp0w
         5b3LTroyrvwNbnlAH/w+0CrPEsGTBlf/Uiu/aOwNUBFq9ArwRkrte0zKO7/gaLoggoVc
         Kh/Ix3qgCsSaaU5ioMGhBpZ8cO3JknE9a+6pj8H9D8UQFaDXPM8J/Yp3hgplAdaZuzHh
         LifA==
X-Forwarded-Encrypted: i=1; AFNElJ8+kmV75aecaS3Ah0x5RRfPAVCyJ13eSDPc3Jx5uhDhcWzvMaCS5LJYcRpm3uKQbok47M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23M5sacWkRDieuRAKKD5jjE1fdazbbdHOOix1PsWKachBBtxQ
	7NQXvvEvlmsqiZyAcqPoI9Em+ub8u2NGG5zZPW4y6uKsH18iay/CbtATpNCcwm6153lAkiJ3cVj
	V+X6M2mpP3g==
X-Received: from dlbrx9.prod.google.com ([2002:a05:7022:1709:b0:138:57f:8a4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6713:b0:130:c9cc:3395
 with SMTP id a92af1059eb24-1380673186dmr9484727c88.29.1780988859141; Tue, 09
 Jun 2026 00:07:39 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-1-irogers@google.com>
Subject: [PATCH v2 0/7] perf annotate: Add elfutils libasm disassembler support
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series adds a new `libasm` disassembly backend to `perf annotate`,
leveraging the `elfutils` libasm library. This allows perf to use the
widely available elfutils for disassembly alongside capstone, libLLVM, and =
objdump.

v2 changes:
- Patch 1: Added a note to the commit message acknowledging that older elfu=
tils static builds lacking `-lebl` dependencies in pkg-config are explicitl=
y unsupported, while intentionally retaining the feature check and API depe=
ndencies.
- Patch 2: Fixed `NO_LIBELF=3D1` build breakages by implicitly disabling `l=
ibasm` and removing the unconditional `#warning` in favor of silent fallbac=
ks or standard warnings.
- Patch 3: Fixed `libasm` block boundary tracking and corrected callback er=
ror/return values, preventing memory leaks and infinite loops in the disass=
embly extraction loop.
- Patch 5: Fixed script robustness in `tests/shell/annotate.sh` by ensuring=
 cleanup functions run reliably, `set -e` doesn't abort prematurely on grep=
 failures, and configs are properly restored.
- Patch 6: Refactored `jit_write_elf` to accept the `e_machine` parameter d=
irectly instead of post-patching the generated ELF file with `libelf`. The =
target architecture is now extracted dynamically and passed into `jit_write=
_elf`, simplifying the interaction with BPF and making it fully compatible =
with all disassemblers.
- Patch 7: Fixed a TOCTOU race condition when creating the symlink in `test=
s/shell/annotate.sh` by placing `perf.data` inside an isolated temporary di=
rectory.
- General: The cover letter now lists capstone, libLLVM, and objdump as the=
 existing disassemblers instead of just objdump.

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
 tools/perf/Makefile.config         |  22 ++++
 tools/perf/builtin-annotate.c      |  10 ++
 tools/perf/builtin-check.c         |   1 +
 tools/perf/tests/genelf.c          |   2 +-
 tools/perf/tests/shell/annotate.sh | 133 +++++++++++++++++++++
 tools/perf/util/Build              |   1 +
 tools/perf/util/annotate.c         |   8 +-
 tools/perf/util/annotate.h         |   3 +
 tools/perf/util/disasm.c           | 114 +++++++++++++++++-
 tools/perf/util/disasm.h           |   1 +
 tools/perf/util/genelf.c           |   4 +-
 tools/perf/util/genelf.h           |   2 +-
 tools/perf/util/jitdump.c          |   2 +-
 tools/perf/util/libasm.c           | 184 +++++++++++++++++++++++++++++
 tools/perf/util/libasm.h           |  27 +++++
 18 files changed, 531 insertions(+), 13 deletions(-)
 create mode 100644 tools/build/feature/test-libasm.c
 create mode 100644 tools/perf/util/libasm.c
 create mode 100644 tools/perf/util/libasm.h

--
2.54.0.1064.gd145956f57-goog
