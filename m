Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7448EADC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242186; cv=none; b=fOw2rLZJVO1lB92FnV1bbNU6UHKis6xWCgzh96AwMkWo6nm7mOmZLdXt7gTWYt48af0auwILaNI7pt0Ec1PLgE09YS8TlyRksbHovgKQtvrAJ75HqNuEAZBJK/wm5v1EDp7mcqDmj3MrfRKAd6+ysjPH1ivbSGRtPzwdo6Gj0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242186; c=relaxed/simple;
	bh=fXVV5/tuy864p+6xlb+ifF36KN+G7i+/Zbt7HrbIRdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7lqSHIAcbIBlbUED88Wr7KwYkNcEBy9nXeAg9rnapKKkcEnLbDsOZQX5S4GGwNoFvX/u2jYH3mL8mjbu7qaYC27csu9tiS3sh9ZSd2QlNoDrM6drQSWVe5i2mz65eRlVYKqSR+wpHSRNfxwwdgdRXxoT3J7isHD8Az0D74rCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH37BUl5; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH37BUl5"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so3266825e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242183; x=1790846983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KLfxilP5rarlm4dCVN1SqcmnDVgyEQL0fFgZklpGicA=;
        b=nH37BUl5H0LSmebUd6Q3EBuy90MbOoTelwx8rzVdCJKqKq0hXLUUwuuCC1XsvcKXf1
         77RvolV2Oq1+MGqN+luJov81SokUMKrwiXD26cAMiDr8fSPlYJFAMFxiY74jdNSSpQD2
         3rH3mLNMzAJ3sU8EygWw1HnC4dsU6UIKpsXQ17zF+hxQcI6M4kmoWk4FVLtY9vt/eppF
         QuKkFtVfJ6EkIM5yzVnxTCKX7cCxIiJzJQDWleADFls9naNAr4cohwIIWEDCfcxVlRhJ
         AtD3uHzBmmewbaYE+GotJEIVuxM+b7gerwzTorPm5RkbShFqvH95d5eiGrl6zpmZZDTZ
         krrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242183; x=1790846983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLfxilP5rarlm4dCVN1SqcmnDVgyEQL0fFgZklpGicA=;
        b=E6b34g2vtnbfyoIewibYF5h8UzRksvXeps5Cj6xSJGGhHaU/+4cwzrO8pfsSBa0XEi
         ypXq/Fb7r+LEDQdBwbz/EaMNh+ggb4BqplYdDgrfN8bHbw2txzgp6Hh6lvUsrmSexIST
         Iau/ksI5pkUua+SRSUL9Emp3spURD/QbMYIGpPLGCWcfTlvgc/UEmdFipoovTydxbXpy
         dW+rUW2vdILEinMWEUDgUn/j118d/VHDfYqtmVrbXQJrHZG7KYmdOOOWAaD9jkcMEHoK
         rMr/EZvTO1psKfwvy7TB/oMcp196LlmWQQRGdeTJPKxNGxD5EVamV+lW86PXeI0OKwCq
         4UPA==
X-Gm-Message-State: AFuF++mrb75HaDd6PX7MLEGLpBSdFmr9f9Y4SGFS9w3VTMt965Jm+Aos
	C8jqvv58Hm8RHMdVv443QSERJ706mWdueYdUxpBhVIeGWPctZ/Hx0SJ/w6PSq0LF
X-Gm-Gg: AYBFou3Ae1v26+6nigwPEEU1mL2Lq8c4mUcxBq3BwWJfxo0iJuZ5KmxEu5iaQGfBWk+
	bo9t1lV70SPU+txDkxWu2hngToqg51ROO0MzQSX00kk1zc6qvBCKIvUM20UHQnCiSTc4LeSQFRF
	LQpqUnhP64Lz0hkQ4LOguY8EJSaBrpEO62qO5JnnGsdl5fUHS+G7/CLvaCcacZKU+fMTOdQNq58
	0jfFd35dkt+iN9TotTaern825irOsPRiQy4gLiu0zWT3nPb172nMdfcdwiF7sQYCFUEYnhDkRgK
	SiiyVecJn5nowtiGF+JHbDWXKlMhk/2YEc2kMNkAZxcMX83q7zkR3/+ECXnzRCmVJuSVNOX5cUs
	PTC47zrrXCXRGQXYF/F92BV66lk2lEXyd1nVcpZHzkey0JMJ19DiE+NJvy5CMV03D8Eu4hNpS+6
	x9IasDDCq8TpTABwtxb/9EGnJ5xam6LmqaaHs4ioZou/OFgOyHEgvzF4ziqXiJltS+x08dV03ag
	fVok0+CKmSVSmxhieAmSxsGfMhJJTOTLdtnomB9rmOF7uD9YtE1pWHiK7n5SuMKB10ew1PGqcYG
	aaHucvT9w5I5yWfRSE6MaCw82drh2+oH/ajhew==
X-Received: by 2002:a05:600c:1546:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fe66f4f59mr31846215e9.23.1790242183048;
        Thu, 24 Sep 2026 02:29:43 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4d12sm49669605e9.4.2026.09.24.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/7] Follow ups for verifier errors set
Date: Thu, 24 Sep 2026 11:29:29 +0200
Message-ID: <20260924092941.3174809-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3369; i=memxor@gmail.com; h=from:subject; bh=fXVV5/tuy864p+6xlb+ifF36KN+G7i+/Zbt7HrbIRdk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL2+wnosw6xdP7L3ZuK7sWuG5dW2hvA+/R3xOMgo9G3 /sd2V7YUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm4T2b4p+Ei13vsu0m1vPun yWlTS0WvVe451G8U0KXYmbjRbX2jDcP/kqID78ztd1v9EfEtuH4xVdecrzuu61pe98E6P6OSxmQ uAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some follow up changes based on comments from Eduard, Sashiko, and BPF
CI Bot. See commits for details.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260816015746.2632990-1-memxor@gmail.com

 * Drop v1 patches 3, 5-7, 11, and 13-14 because they are already present
   in bpf-next.
 * Use instruction-neutral wording for variable-offset stack accesses
   rather than inferring an atomic operation from value_regno == -1. (Eduard)
 * Update the variable-offset assertions and cover the retained
   uninitialized stack-read diagnostic through the existing CAP_PERFMON-less
   read inside the allocated stack. (BPF CI)
 * Keep v1 patch 4 unchanged after confirming that the write filter is
   reachable for lineage-preserving ALU operations with unchanged
   diagnostic snapshots; only its spill arm is impossible. Say so in the
   commit message. (Eduard)
 * Consider active critical sections only for sleepable programs and let
   non-sleepable programs reach the existing no-active-context fallback
   instead of adding an early branch. A non-sleepable program can still
   hold RCU, preempt, IRQ, or lock state, so the fallback alone would
   keep blaming the region. Keep the "non-sleepable prog" description.
   (Eduard, BPF CI)
 * Select the helper and global-function suggestions by cause, matching
   the kfunc site. (BPF CI)
 * Split the kfunc coverage into a non-sleepable program case and a
   sleepable program inside an RCU read-side critical section. (Eduard)
 * Scan subprogram properties with nested loops and drop the partial
   recursive-edge details together with their assertion. (Eduard)
 * Reject CO-RE relocations targeting a truncated final LD_IMM64 before
   applying them, since BTF validation now runs before the subprogram
   layout check, and add raw CO-RE coverage for the rejection. Add the
   Fixes tag. (BPF CI)
 * Rebase on the current bpf-next/master and let the new property scan
   also set the callx marker that check_subprogs() collects upstream.

Kumar Kartikeya Dwivedi (7):
  bpf: Correct verifier diagnostic attribution for stack reads
  selftests/bpf: Test verifier stack-read diagnostic attribution
  bpf: Drop dead spill diagnostic condition
  bpf: Report non-sleepable kfunc programs accurately
  selftests/bpf: Test non-sleepable kfunc context
  bpf: Correct Program Structure diagnostic context
  selftests/bpf: Test Program Structure diagnostic context

 kernel/bpf/cfg.c                              |   6 +-
 kernel/bpf/check_btf.c                        |  15 +-
 kernel/bpf/diagnostics.c                      |  24 +--
 kernel/bpf/verifier.c                         | 179 ++++++++++++------
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 172 +++++++++++------
 .../testing/selftests/bpf/progs/dynptr_fail.c |   3 +
 tools/testing/selftests/bpf/progs/irq.c       |  13 ++
 .../selftests/bpf/progs/iters_state_safety.c  |   3 +
 .../selftests/bpf/progs/preempt_lock.c        |  26 +++
 .../selftests/bpf/progs/verifier_cfg.c        |  40 ++++
 .../selftests/bpf/progs/verifier_gotox.c      |   2 +
 .../selftests/bpf/progs/verifier_spill_fill.c |   2 +
 .../selftests/bpf/progs/verifier_xadd.c       |  27 +++
 13 files changed, 376 insertions(+), 136 deletions(-)


base-commit: 24629aac43d2884109ae47a993fd51b504e2b09b
-- 
2.53.0

