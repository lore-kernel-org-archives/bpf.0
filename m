Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190137B014
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263224; cv=none; b=lAHsLG7Htx/ZhNHQuq7qlcMTFdQktIhGdHJMWIwAHXcN1Sb3RgOwJmHthWLySph5w7SlLW/TmRpdXSuoLo4ce6GcnSWP2tc/wgvJ9vFixAPsDuKS1YcVlsnDdAZj+IWUR3rSfXl/zhqc7PhnE27/eIch2UxKDHYyp8UTz/hgQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263224; c=relaxed/simple;
	bh=dFwwbddi436lZ04xBgAScK+cVA2/cK0wHX5M8zZf6Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJeuYikn5eBn66lWCSeH5lUDk4BGUlaRem8T43N5HkoqIhDlMyL7321sdn1Muz94jLp/zNxslvXTXRmEJRKao1qXyioclTZkNjnVvdTh5+4VHLv4gGPql4e1Z9JEOYrIrBklAG9mtapitPEpG54hM9klLXdsQ5K0SMMMD5M1B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=akVGgWEc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="akVGgWEc"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15f020a223so975199266b.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263219; x=1784868019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V99zj7iq8MUudw2Yr6Iyox0msy4Zs+nzuYqOJgmh9Ho=;
        b=akVGgWEcG5/SPfuoMpVGhbwXJIelrjH9E91vapfYN8AM6/Dv12MG6yH38zmbXgNgiR
         qjB9l0AQmUln5BfGzs5HkobLrhf5h9Nm7fHTjoXjQx5C9othEhd7qcx30L51zcJz3XA4
         NbptXRJRq/GruLeeuu2uvcuXgSGz7pLtTvLwjyE4wdsXkV1OtVosfn8tTAqBvaQLQM65
         Y2FLvMggkwb5S/izlVBU+9WfVMDUYklTxe0fH8JiDWFOnwl/VQ3g4NqrABYoUyld5GaU
         abg//dmopvKNQcSYkOQ7DWw5WhXkrvBoNwy4ScVICY/Hzi2hyFkx5FnAXalnNaAU1oul
         zGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263219; x=1784868019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V99zj7iq8MUudw2Yr6Iyox0msy4Zs+nzuYqOJgmh9Ho=;
        b=GH65RtGyzN+XvSRdokplThVGcVAe2k+xte0VbdE5fuWC8mdsAn8IC5/6l1oUCGH34w
         xQqbCM5GwjS1TbX05T7bUvP/qyQTeCW1+JRmMYfct2/FhdnwcFtAuwoLcvocLEtBhQUS
         FJoDe6fVrCeMtQY8MlVwM44Zt44S+wLc6cnv/4C9RQ0KL9OyYE/lfeyI+DK2vDos+i3v
         kqp3cFiK1sxFVBTrMxMT5XOGIUOP9kcZy4yTajgH8BZ8p/4130Ei8z7nlqZOdDogLLco
         64zXBGx5rucUQ8+tGOoeRttF0GaI5R5XqBzNSqWX2IszB8xCNAfLwEqZHeTD+nOIaSzR
         LQUw==
X-Gm-Message-State: AOJu0Yyowz7VswntD8H6nRAb+ZahgfNa1in81UcgbZTMW4HTeu1n1WFR
	LapmXO8i+/iT9PCEldIRaV/EictwtcSxjbj/aDUNm/RpNB9/LBxYXGDV26zArzf5XzFN7ZzNSrx
	EVRxu
X-Gm-Gg: AfdE7ckjStozrh3aJZS7eEBKLDkegj52PbRRh9y3Bq8VJGjD4JQlT7SgzL1LIoKLmxP
	iaE6FO591Jv7dh5G+Jdohz1Rme1T0H+P0eQKfS3AQcxzbT/aUp9v6P6AC5kbY3yJhT2B5dYT2Cl
	Dk5KuWnAkuXjPoLIMPxymTyH7lBc5j4TLnKUZDy2E7vueXPZpiOCBKLJLLPjSh1MZh4z7qxM3f1
	S0B5WtZ4k8Hm0NSSJx6/aMYc1FHDFPAbxoY8JdGo52byFdWFuzi8Q4NqmbPP+Xhq7QxDFCHbQg0
	AnAVo4VQVEbopL1E4GP8+s5ZedSgkL5EHdPMwY6nLQYdLFsX39DbBp1Ed++9P8y35PBo1z3Q+oF
	KVavqhE+SNmc8xwSYXKtGHtm4Eo+GqMURTLeK+h9fUz/jPUG1hil2PzrNLZk36vf1Qf5Rg+PjCP
	Wn0ju7rTfziTZt7Bqqge9CfDjpBJrrsR0=
X-Received: by 2002:a17:907:3c85:b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c16b46abda6mr27628166b.12.1784263218854;
        Thu, 16 Jul 2026 21:40:18 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b879sm227781b3a.7.2026.07.16.21.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:40:17 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and fixes
Date: Fri, 17 Jul 2026 12:39:59 +0800
Message-ID: <20260717044009.120224-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset mainly aims to backport upstream commit 1b327732c846
("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
tests for stale delta leaking through id reassignment") (patch 6). While
doing so, I find that a BPF selftests patches are missing as context, so
backported them along to import coverage.

The full list of patches that were backported are:
1. "selftests/bpf: Add tests for stale delta leaking through id reassignment"
2. "selftests/bpf: Add tests for delta tracking when src_reg == dst_reg"
3. "bpf: Clear delta when clearing reg id for non-{add,sub} ops"
4. "selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation"
5. "selftests/bpf: Add tests for improved linked register tracking"
6. "selftests: bpf: Add test for multiple syncs from linked register"

I have confirmed that after this patchset is applied, BPF selftests
(test_progs*, test_verifier, and test_maps) still passes on x86_64[1] and
aarch64[2].

1: https://github.com/kernel-patches/linux-stable/actions/runs/29553646000/job/87801246946
2: https://github.com/kernel-patches/linux-stable/actions/runs/29553646000/job/87801246917

Daniel Borkmann (4):
  selftests/bpf: Add a test cases for sync_linked_regs regarding zext
    propagation
  bpf: Clear delta when clearing reg id for non-{add,sub} ops
  selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
  selftests/bpf: Add tests for stale delta leaking through id
    reassignment

Puranjay Mohan (2):
  selftests: bpf: Add test for multiple syncs from linked register
  selftests/bpf: Add tests for improved linked register tracking

 kernel/bpf/verifier.c                         |  50 +-
 .../bpf/progs/verifier_linked_scalars.c       | 556 +++++++++++++++++-
 2 files changed, 580 insertions(+), 26 deletions(-)

-- 
2.54.0

