Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504C175A6C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429452; cv=none; b=Sa+JgRFizEltSrK4p2MTzxXZKcY5bVFf9cvcy2ep/enV0nOmBDMiz8AnXVBNHmfpl6uMC0D1cLF0i64VPag0jTpfIAQUNhh3up3f97RcpiDaEhBMeJbysz64WxuWT3etJKmMFDHSfOSb0h6/qWvKIPve9uiW902aAWiFLlDfuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429452; c=relaxed/simple;
	bh=hSlcltwX/gTUqir1vGAHsYx5mAeS9xhWXRzsm5Im5D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teDORnUwQqtz3TM5PB8TW/JN/cHRI9O0M/b9vZv1kS8lOg1vsT4D5KjPgsQdWMCHi4Lb2RmI1Vc3mFflSLDQpwZhFUTp6GYSXeetrGdFmBMezTryzXt7MHx4usOtT3SNe3NYTd46FtOrDd5s0ah82dPNFYKkGmER7B1Eh5GTNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnS9oAzZ; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnS9oAzZ"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so2476265e9.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429449; x=1791034249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ojBPBkhL5Jc0n5dPNdsgITK4l+rLeg8PO1T1tFs40nU=;
        b=NnS9oAzZXaIbKqqHROEyvwEpSKdZ00Sucua6ayGopDDN3zS7YxD5BH9BqCFttfy3pG
         bsGA2Kk7qgWsmIxvUxWMQtCLakc3C6Lp6NzegFQxgIir8nD8gVbgWNoV0l+gNFdXevUv
         UnOWV47DSyFOABG3C750xQB81r+soVxA/kwCkg78KzbyRFRhO1vYSHyz1pgbL47OmsYY
         O1aGik2CQ3nnXkw9yVe1Oplluz6+g5fJSFP2q56ZUyXPYRBUuxwYPEF5Uuv0J2xC1gxT
         C5JUB0cHX3QXTRzBvOiT/KsPplekCrvgnVvmpWt6lNggzcrjCU2dBrj/YhaTrW04quo4
         V6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429449; x=1791034249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ojBPBkhL5Jc0n5dPNdsgITK4l+rLeg8PO1T1tFs40nU=;
        b=uy9D/1AeixIUNocUmgVjgXXf+GeaZs1MeGdQjjmlw/5nQypBvVDJjJug8UG8SeoyGv
         oBpiLbSUXuUuyanFhO66dMb6SL2V4f54evk2bwwWtDEes6O3FZ6P1DO2vCAKZQ1TVLwM
         ANuvxRsongBH4/EXT99vsLmMWwMtoId4Ym7iBMF14Oul/ivjDmqrE/kk4uIpMFH2VBFe
         OYz7ZYRcvHpGUSbwClQWdkhWKvu48H0tnyT6jcbX2NC8dkH/fdpuy1wCAnkeXxPhd9zE
         ansRV2V1K1EeX4uSCE00Agk7itfJ2xlTvWDrK+DVXZ7ZUtrZUe9gx0zYCiQnOhSoey9M
         kO6A==
X-Gm-Message-State: AFuF++mZAPNMquCw2JkaJRDXOBYmfUmQkx7An3lB4QbwrGcRkp+1nWcS
	LXWDMZYZTkBc4ugbkD8+G/CPKQWHbYNKOjA5edrB7dZElUgbRXbW3zE2kAuMlJzw
X-Gm-Gg: AYBFou0V/G2iUcXCLm1H1g//zYZgi3Tc1za+S5GJ4LIxUwED0hjQ6d/REAFU24aflQO
	hUD85jgZ5lXhmO1YrVrYL1QZaAjE+K+h1eRfe+AVb9Ia4+UnaaWpNEBm2ytCFgv57Mhst5+iIm5
	rx0vJ2tMbEI+AAf3SQE/mWD6kKnxJCvsX6XEsGwLfqXE4CXeQR5MciwzuGDqsDyomHGk7Qw497s
	Srk22Bmfg39vWo80t97hBx2c1CPDzcfgM9JGRWS4GOgyOvOnFqcVVlWjDZUBD/td8b3GLcUOmDm
	6cd76rgYl50SbFQB8cbGZOJ/AlTRlFFYEAZSUn7foCl3ROPffTdBLP3eFd2UBIxXUgDDWz/y4Lf
	IwBm+xE5ubB5Qm22a3a8sRESmwLDfTaTdBLFSic3Oruwg2nfQlKVt1sAajlgRY4OUWFc/8dW+kv
	/8YDAk5h3fXGvl2rqeB1HyL6wH2Q9y2S2vcFu8MKinuts3h1Lasiji7tlR2uKU21lgR0IQeODav
	geRMmkrQrmKfoZic50Wrj4GQiMbgSUtNnMZYfjyMfHTxUol+A2gu1IeQH9te9IIPHYFvqqMVY8D
	LfCXHz9xU3d4tKwMWPGLKoFz2b38RT4onFIwJ9I=
X-Received: by 2002:a05:600c:1f95:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-49fe66f1aa8mr149337545e9.19.1790429449237;
        Sat, 26 Sep 2026 06:30:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef4fc959sm122021985e9.2.2026.09.26.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:30:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 0/3] Follow ups for verifier errors set
Date: Sat, 26 Sep 2026 15:30:42 +0200
Message-ID: <20260926133048.2962553-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3585; i=memxor@gmail.com; h=from:subject; bh=hSlcltwX/gTUqir1vGAHsYx5mAeS9xhWXRzsm5Im5D4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv7iceZdur9b74E1vOGWD/Luder/uTJnT3Vvk9KFv8tL evnK1vcUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm4WTEyfJqa6/FofRf/ovzb Zz8qyGpt6HpgN9GM/0Z9frvpZt/MOEaGVwIxJxhSlm59xpSxkqlgd9SBOnmFgoIj5gw6W4obtUq ZAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some follow up changes based on comments from Eduard, Sashiko, and BPF
CI Bot. See commits for details.

Patches 1-4 of v3 were applied to bpf-next. This is the remainder,
rebased on the current bpf-next/master.

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260924170646.2366016-1-memxor@gmail.com

 * Drop v3 patches 1-4, which are already applied.
 * Rebase on the current bpf-next/master.
 * State in the Program Structure patch that CO-RE relocations stay where
   c26e97721b17 put them and only func_info and line_info validation
   moves ahead of the layout checks. (Alexei)

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

Kumar Kartikeya Dwivedi (3):
  selftests/bpf: Test non-sleepable kfunc context
  bpf: Correct Program Structure diagnostic context
  selftests/bpf: Test Program Structure diagnostic context

 kernel/bpf/cfg.c                              |  2 +-
 kernel/bpf/verifier.c                         | 54 +++++++++++++------
 .../selftests/bpf/progs/preempt_lock.c        | 26 +++++++++
 .../selftests/bpf/progs/verifier_cfg.c        | 40 ++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +
 5 files changed, 106 insertions(+), 18 deletions(-)


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.53.0

