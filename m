Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559232A3D7
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269611; cv=none; b=U7SBnCUq+NWYsQpDhcOZOzBelwdnT7QZ/Y3BwdiQtFNCue69ia/+TBBMfn38N8yOei2MhJ+T5st8MTKiO1JXOKPNE+u5LQpL7SDYrTRwn7Z9PgzkjHSLy2Ud3cCDZQZB5TKRdUE4kIgLwVWp4np9JOwFzWFEJY018PsA+rj0U8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269611; c=relaxed/simple;
	bh=VLCpuGnJjcM6EeU/OsgtRa36LRqoTbxaMy3UTCvXcRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jieJEsTHMqWCr7Pk5CAzwOmJ9o3KTXoKx6zIIfo69J4JKGG8hIuffYehEPNmsV+AmgpqaRZKVTKMPaL4LFvnbsRBj82ikQ18JcY2i4rJLS5ss1yQHBLSc6A3Qt7dZlVWjO9Bm0Qxws+eqKpeWKTnDFjUNNkDeisncyNM5ddyOUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLe2n69X; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLe2n69X"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887965533eso9449f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269608; x=1790874408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCzhBXLJNvoJAbFBgzVyLvh1V5XdKpMLcdYh+Z6IFOQ=;
        b=kLe2n69Xs2L+cbYi7Li3nUQnqEXX0PJCx6r4Pdq5nTebwcq1YAjbefnXwS1orbAJFp
         JRk1AnHQ6LlBK1Z3q7XTaGuQJXyi7EiKZezDxmWkVLKiT24tNtb8+siVyMSgutucAWtu
         58AsAAXpicji8qAn1aM7mEMulHXLP2PUS0EN8/35GRjrajWzIRl/WqnwJTVGsZcRbWaz
         h2f7Hrk7y815kI40cP9CBPfopTuSzinYv2RoCsTN5q0/9q6TSg2z1xcW7YInq0guNY28
         XhUY51OhHSKAaDgkNimhXyo3GyqPgNllvyJQ1rSxWLtqPl5Ezo3AEXfMnYIOcC8qGIns
         icDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269608; x=1790874408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCzhBXLJNvoJAbFBgzVyLvh1V5XdKpMLcdYh+Z6IFOQ=;
        b=ticoo4y+3SPAjF7v7euoG9UUDTOX6lxZBKlgqqZ/eFrrSJN7Hr5mzHizfzWmCTzloO
         Ptr6A5cwz7mo0y3VkpxBuTQbElzhYMp2bnPyURKPoDfFyyI/wbOVwzn51A2BzKPAZt3w
         HVwJeCTmFPQ52PoCUaQLZBP6Q/eplZdskiq03sMKj3P24OWOlwwuKoQf+aHEsMMvM/Tp
         C6H4QiGKl4uSq3TXGeXtf6aookBnN22PgP89YQH7F8AwpuA2ykmfzNe4frv90cLzEd8h
         ISVk5p1U51qFr3WYGRw+wtBxsM4eapLl+LqpcwCqlYZsRik6ZRof9Kzk2jjLtBEY++k3
         pDEA==
X-Gm-Message-State: AFuF++n+fIfdcHwBFxuOmcsZSeR4qciry7n7wD2OTTvJNNT78SEu3Eic
	BUb5agfBX09o924JsXyC1BMHD6P8SsLFIEJe49J8G6BqMolZQQFDsYsCi4+8uFcC
X-Gm-Gg: AYBFou0i0/TDoA18d/zCm14lVcLzgh22PdcvZ2wmsG1D5CrgwvmtCNsw7SprJXKH0zg
	g/XVkKPGnS4bW6F9Z6URKPINOKx1uDW/GXXAB90eYcAYnyQUp8BLqtO23C/VJ2Jjx64/qdXW8hV
	sRJ4zpSlzrtF/RzkExyZuJI1QKlhhq+liHYYHb1+pxZo4GO6kZvAn1guDN1MGK3BdX8KcvmstFS
	DDEkfyz1tZoPwfe0nwVG6/CpqiIALi0FY9oZRuDHPfd3m7X67WNQ4G0ai+DECspnC6Ox1B+SerP
	xEvh2Nh3+sIS/EMLKqWCYeuWe9ZV/9HwEhXY30qU48pIW/RD7r8Mp92wvAP9FYc5bxv2gIgafKX
	0I8jFRdaU+IsK/pGD3cX33ymdJsYn9k+Wu6Npaf7bvmjq1qZRe0Tre5rMJZFaLcM7nYv9t9KLVI
	QB9LsTNmW9vqyjrZwC208M+4509FrmSZJwHEQ/LDLApe7kY+kNElNfpsfAmBtubWZo9DRnzdRK9
	SG8lbPNsK40aUKcqbWOgpDq9CoMFXPsWJUKe6yG5yw7BBikDGq3iNL/SgW56qBW58B/aryHHfvO
	kKp8CQaa3L0J13jlKj6IXaZ/mS0TsgKZkPlgHA==
X-Received: by 2002:a05:6000:3c4:b0:487:8ba:8aa4 with SMTP id ffacd0b85a97d-4887169fae2mr6349404f8f.38.1790269607854;
        Thu, 24 Sep 2026 10:06:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm420406f8f.12.2026.09.24.10.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/7] Follow ups for verifier errors set
Date: Thu, 24 Sep 2026 19:06:34 +0200
Message-ID: <20260924170646.2366016-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3658; i=memxor@gmail.com; h=from:subject; bh=VLCpuGnJjcM6EeU/OsgtRa36LRqoTbxaMy3UTCvXcRE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRFGB6f7ojAfnAue7OV9tNawyYed+4XE/+M6zl4KcM u7/J67sKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET6DBj+WS4vSOHZ9y6mpVch jrGfuSVW4UnYk8Ps8eHfr/nu4pTdw8gw/UsQV0BBypy+Lbv5d4c+mCuRGfq9W0hK5MNK3mOud/Y zAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some follow up changes based on comments from Eduard, Sashiko, and BPF
CI Bot. See commits for details.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260924092941.3174809-1-memxor@gmail.com

 * Rebase on bpf-next/master, which now applies CO-RE relocations before
   subprogram discovery, and only move func_info and line_info validation
   ahead of the layout checks.
 * Drop the truncated final LD_IMM64 relocation guard and its test, as
   bpf_check() now rejects that form up front and core_reloc_raw covers it.

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
 kernel/bpf/diagnostics.c                      |  24 +--
 kernel/bpf/verifier.c                         | 179 ++++++++++++------
 .../testing/selftests/bpf/progs/dynptr_fail.c |   3 +
 tools/testing/selftests/bpf/progs/irq.c       |  13 ++
 .../selftests/bpf/progs/iters_state_safety.c  |   3 +
 .../selftests/bpf/progs/preempt_lock.c        |  26 +++
 .../selftests/bpf/progs/verifier_cfg.c        |  40 ++++
 .../selftests/bpf/progs/verifier_gotox.c      |   2 +
 .../selftests/bpf/progs/verifier_spill_fill.c |   2 +
 .../selftests/bpf/progs/verifier_xadd.c       |  27 +++
 11 files changed, 250 insertions(+), 75 deletions(-)


base-commit: 44e4e52c11d97a9076c611270e52c6965e3255ee
-- 
2.53.0

