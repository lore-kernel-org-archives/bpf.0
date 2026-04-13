Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FB38E120
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110218; cv=none; b=NuWFJtsX1ZliwSUJhu4hnsUfncjasDAO0pLPQis1h04bO1kQU1JNyO+Fij05mrve5FycXrIWQ6vkoBvMBkUUMaKUoWcZeTn2EA0e06qePTTP6cLWCgrntB3htURIufIIaCz1KrnjNptGgyNXYTSgB72FIpjR4YCFt2TRhDKpTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110218; c=relaxed/simple;
	bh=NLawiKjpKHFwZKxs4+OV+s4vBkqMZq/acOI01vvzyII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qh/f1rb6dHFb+yRiFnfnucMqFEsj2xKxhKqTVSjr/e3chvj7U+TsW6lBjwSw3XTbRmnfFa/rnIcIrZ/16M355nA1DORQ2AETcTujbwfR0qoF6ekS6JKrpUmXHZ2kcE1BpGYCdCpze9IdN3qfUCWDfprPdaaWA1TQTadSxzp3zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx8r1noD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx8r1noD"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1882871a12.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110217; x=1776715017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSledROg2JYcZffN+q4G88X6Tz1z4U29j0cFpm4bY5g=;
        b=hx8r1noD80M9LMboIezCdN4CJqzgB4t7qsepXQM7M7mZsXxIPnST8pu2zHF3B6bIKh
         sIF1zUuJA9IXyVAJmwP0bfhxRwKXKurm/VPGvqSmxH1iaprKfBelbsGpx/pRzmZr2xe3
         IgCwzJulMJ3TTrc8LEgxt4IiEfKGdE1KjGaizDcLAkemLlIzhIY9gvegUIcjfnLCj+sI
         ncA0f1dZoWEjRQd/MfxKWPigOYYt7/nF3sYuPnFfo6BqbUluPjhlDA0Iu37DugnEyQov
         ieGPb/N4D2ivN7ZtIrAJl0cWzQFBUYkdYjlJWSA3ruyO0KdMGn9LgLU9w7eHa1hky8Su
         tiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110217; x=1776715017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSledROg2JYcZffN+q4G88X6Tz1z4U29j0cFpm4bY5g=;
        b=GCg23hrhlx2O1UETQ5udgVbo0X6Pav1gBpC9//VtB9kjOydzqo/5CrjPTrw3RE452W
         d2PgbKFp5SyfeM8/e3reyqZmmOFwWOlGmdVfvgfy2SbUIi8UYAeFE89nL8Fsr/0ZC3kN
         GM7pTEJpzfUrwPHrlrFvwt8Cbs++k5RojLSZBPxUuzcMl6ZD6DArYN1n6iHIfPyx5OtK
         8VhgkOvzj7fHsYctDVqNb4okXWl+yB/OU4I24GIE3YHjzOAQ610NByDYaPYu/cAAbhOc
         kZsT15VfmxJWQXZf8JM7stzOTsDetj23C6q3Rdeg08a01BmDHzkGXNItwoU1LdXPUlyf
         q7/g==
X-Gm-Message-State: AOJu0Yz6C/fSwBIflpQDVOWqLqjOgw1KCW2rwDdbfv/xgUT7wXwYfB0H
	mpNH9pmvqni8clRi/gdQ/3Q4sOQx71p5aESA4HqQ1xUz+yhUcgaz1JGC8LT5Bw==
X-Gm-Gg: AeBDievoP34PdFpPvuTYBMqXdD//BwEzRtBxWS9M63iZQJ4tQ+7q+gLpSQ19/PiAt9O
	O+hrs3NDsBMh1KBx30rlYiwux4uO+PCMW5QnB0vs9MH0myTaHeT41IBKu8rcyjCQNcogI84UCQz
	+Fi7fFbxOaRWGtdeA0aCWo5CddE3BM8/uajxma16rf49dWvruTyxrc/uFuVXV4UNrYqj0hULVIF
	aTtuPL6vg0UxaIQREYUrIsYut/6Yqpe2R5q6A4YqETIeNib7Tz5yaDNo+YTNpS06xfPCVS9NlHj
	j9O2gkQ03wbe0E3uyQ5N0mypwnBgeNHBidI8kXqJkQOMPhk3jA5Uq7JbrYDGJomHhdwAAmzJ2PL
	5MVxC2JSrrNmYKr4IWaPlcdH2M03p1mqlUuUaO0VzGb8YBniNk9p7tmEqLuFYPrJkQRqAF6xsbJ
	MMSHAR3O12pNishhhA7lnSRRp2Oh01n2hmb3b3lIwDy2aR7DS84RqULlVPoBmdLjHZv2s=
X-Received: by 2002:a17:90b:1d91:b0:35f:b57e:7f33 with SMTP id 98e67ed59e1d1-35fb57e8053mr3979660a91.14.1776110216789;
        Mon, 13 Apr 2026 12:56:56 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3512f41bsm16452599a91.9.2026.04.13.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:56:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 0/3] bpf: arg tracking for imprecise/multi-offset BPF_ST/STX
Date: Mon, 13 Apr 2026 12:56:38 -0700
Message-ID: <20260413-stacklive-fixes-v1-0-9f48a9999d6e@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260413-stacklive-fixes-42e258cf0397
Content-Transfer-Encoding: 8bit

When the static arg tracking analysis encounters a store through a
pointer with imprecise or multi-offset destination, it must use weak
updates (join) instead of strong updates (overwrite) for the affected
at_stack slots. At runtime only one slot is actually written; the
others retain their old values.

Two cases are addressed:
- BPF_STX, handled by spill_to_stack(). It was gated on
  `dst_is_local_fp = (frame == depth)`, which missed ARG_IMPRECISE
  pointers entirely.
- BPF_ST, handled by clear_stack_for_all_offs(). It delegates to
  clear_overlapping_stack_slots() which unconditionally set
  `at_stack[i] = none`. Change to `at_stack[i] = join(old, none)`
  when multiple candidate slots exist (cnt != 1), so that untouched
  slots preserve their tracked values.

No veristat diff compared to current master when tested on selftests,
sched_ext, cilium and a set of Meta internal programs.

This addresses issues reported by sashiko for patch #7 in [1].

[1] https://sashiko.dev/#/patchset/20260410-patch-set-v4-0-5d4eecb343db%40gmail.com

---
Eduard Zingerman (3):
      bpf: fix arg tracking for BPF_STX through imprecise ptrs
      bpf: fix arg tracking for BPF_ST through imprecise/multi-offset ptrs
      selftests/bpf: arg tracking for imprecise/multi-offset BPF_ST/STX

 kernel/bpf/liveness.c                              |  67 ++++---
 .../selftests/bpf/progs/verifier_live_stack.c      | 194 +++++++++++++++++++++
 2 files changed, 232 insertions(+), 29 deletions(-)
---
base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
change-id: 20260413-stacklive-fixes-42e258cf0397
