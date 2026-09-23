Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FF59651D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202963; cv=none; b=BhY82I6r57zZKd27vyPrn3NN5beL5tY6qbXNjQEazuO2dWn/1wAbjzvuF38jna2K2UmGxF2sG2RqzuTpZia70ldmGQRy0aXrbkcKLrF6Reng3HkHDoZ2q2sTycclRk48WsrwZTfQejr81xWHvulfsKxYJI5SBPXKBL5TDmnpTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202963; c=relaxed/simple;
	bh=uW/V2kKz/69ZeY1Lhg5ZDeW4HEwOuPg9mgglxs/mQMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv9PscOFBBVKfYQuNvk4QbbldvVHvWqEk5MiA+eQtUfaIPTEYsmZl8pOjCp9mykiV42DyEJn0uiYXJnJwbCObLbWU0rPNOClpI9FMFcrjYdseOzF2est/dXLmPGvqXls1udm3ShYFYppngGUYsbejtl3HF5t+T8UBWLLetGI6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA0KjOSh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA0KjOSh"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f066d8so4875665ad.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202958; x=1790807758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=me4kdldxH/u+yKaMXtYlletDBpJshvl37KuAyUFleOo=;
        b=DA0KjOShEzU8Yr7EX8tjTbpUp4B5pEV92JveH4to/JkVtvNTjtGaVUFgz7xPc4lyyT
         6pu0IowCva+G7IlKS/jr67vRzNj409Xgxx8xK6zNiCZdZeprk+H93phEvcS1G8VMgX41
         O0SQDfjzPRZUCjSL4OQMnLwvLqbw4SBttC7HAaUiHsP7rNgXEguDFEvt3tFb0Nl/WNUl
         s+slGDezJniY/k3PxsZUOvW3d5V26Ue6sZwN0VpatcrFIr6Z7Nd4o3tqaFnBGqEPjyCN
         cSL/+Dtrb9WFuejdFPuk635be1kOZp5vvBW91L+VMOeGcwm26yBM58f2MgwOM8S0yFiH
         rynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202958; x=1790807758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me4kdldxH/u+yKaMXtYlletDBpJshvl37KuAyUFleOo=;
        b=0Qo1RyClboTbRHA6c2VEbojHY8Qxm8rYIQw+UcrIqdViGxIJt2wOzCa+vW4ak/H7i5
         a9Gornue8ZU+TKNX6qySDv8mOGSdl0ipGAGJwSwOhCSw/VuK1Ezml+dso3Pf4EVdzuuJ
         KkPWditAeSyOXe5Xf6BmiRulpGF2oBg537dIpsMzVIPL6nzK3TMJwpRDxo4h9YheCrpU
         C8sLTRzgZAkM+fZ7ypXuou/ebp1cpDpMTdXwfdlk4zPgNXgRGOpR0iuzBakjYsc06B3T
         Zs5Gf0WCSvJfGKkD88iT6ADmSljef5+37ewUbZ2xDAWvJZ5375WVKLPupQa4JKPYlveO
         blQg==
X-Gm-Message-State: AFuF++kdXc0xrJEMwnvYtCByMkP8T+sp54qh0PxH+ZNgmnIANhocj6Rf
	WmTE4aNGRm7wX7sqRXVu/zAkttAAhEpQOjtoIf3n4yKcs3mHZsuIBeeMl9Qv2A==
X-Gm-Gg: AYBFou16l9cJPt27C3piF2qwSUU3Ih+RrKq5EbPlLIhARKr0Mdy7JjtAl/wjcHll7cA
	t/ZQ7PG9UDyAdtfuEO6ejL+OnY/hceYZIW1g/GDoDiNFB7W+qtLcjElR0SDhU/a+XENn3UksciB
	c3ZpjcBP5GsIxGeuPClahLG9PstiCeFR8TOp3I6XCD2Bkb4ZwcbPqiG3+rmg1bfa64zexSKqksm
	3408hxU4CHC1TOgCgNCzsAxzl8pdWXfQvzJDL9bsV6x1IOgYWhvsTGaOkBgbK1Sode/2HEMoWTr
	HzpCSfZULXri89u6C3DvWaE6QLSxNAWcqgwWxTe/2l/77hFeIbaGxfXl9xM89klZT9OqiTjdj7D
	bPKPIvqcxWgNuQqlVAdSocwmuFrZtgw1YVzjY70avJ+OqtQ5mY8XeikMPQ5B1zdiwi+Iqg0OqBC
	RAlnNV3phD4VyZ0eOpYQlKlHJBavVyZPdTqSpPVx3GPPlqRwKONdjPvlroezqQ7Cc0nHPzeuX16
	P+RJPh7LWS5qZgmR8oCfK13OQCHHBqtKMM4bQ5yhzjAxXoePQvc7d1hi+ZW9MoDkE8XdYO0IMfP
	30k2mir5dFiX9oseSxgj2ydM/cUeQ+tnZwDCzX99UUA=
X-Received: by 2002:a17:903:190d:b0:2dd:ad73:5b59 with SMTP id d9443c01a7336-2df7e26bd7amr3209265ad.20.1790202957997;
        Wed, 23 Sep 2026 15:35:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c16f6sm17001115ad.35.2026.09.23.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/8] bpf: Verify loops without walking every iteration
Date: Wed, 23 Sep 2026 22:35:46 +0000
Message-ID: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

This is RFC, but without RFC tag. See patch 6 for numbers.
I can clean it up for core idea looks good.

bot time...

The verifier walks a bounded loop one iteration at a time. The work is
proportional to the number of iterations, and the loop with too many of
them is rejected with "BPF program is too large" no matter how simple
it is.

Verify loops the way open coded iterators are verified. The state that
comes back to the loop head is either within the state that went around
the loop, and then there is nothing new to see, or its scalars are widened
and it goes around again. The range of the counter ends at the constant
the loop compares it with, so that a loop like

  for (i = 0; i != 1000000; i += 4)
          sum += *(u32 *)(val + i);

is verified in two trips around the loop and 24 insns.

The loop that is verified this way is not known to terminate:
 - if no state leaves the loop the program never leaves it either.
   Such loop is rejected as before.
 - otherwise the verifier adds may_goto to the back-edge. When may_goto
   is out of budget the program ends with bpf_throw(). Loops that go
   through may_goto or iterator already, and loops that are walked to the
   end are not touched.

Patch 1 trims range ends to var_off members. Without it the loop above
doesn't converge: the range of 'i' is [4, 1000003] after 'i += 4' and
'!=' cannot cut it.
Patch 2 marks loop heads.
Patch 3 widens states at loop heads.
Patch 4 detects loops that never exit.
Patch 5 adds may_goto.
Patch 6 turns it all on.
Patches 7 and 8 are selftests.

Widening gives up precision and bpf_throw() cannot be called everywhere,
so patch 6 walks the program with widening first and walks it the old
way when that fails. Nothing that is accepted today is rejected.
veristat for selftests (5251 programs):
 - 4 programs that were rejected are accepted: loop3/while_true,
   verifier_cfg/conditional_loop, verifier_movsx/mov64sx_s32_varoff_1,
   verifier_search_pruning/short_loop1. All have may_goto added.
 - 163 programs have different stats. 126 programs are walked twice and
   have the same stats as before.
 - insns processed in programs accepted before and after:
   5569499 -> 4774715 plus 88708 in walks that failed (-12.7%).
   loop1/nested_loops 361349 -> 135.
Patches 1-5 alone don't change stats of any program.

Not done:
 - pointers are not widened, only scalars. The loop that advances
   a pointer is walked every iteration.
 - constants that the counter is compared with come from 'if rX op imm'
   only. The bound in a register is not used.
 - may_goto is added to every loop that converged, also to the one that
   is bounded by its counter. It is a few insns per iteration.
 - when the program is rejected or has a loop that cannot have may_goto
   all of it is walked twice. The second walk of the rejected program
   can take 1M insns.

Alexei Starovoitov (8):
  bpf: Trim range ends to var_off members
  bpf: Mark loop heads in check_cfg()
  bpf: Widen scalars at loop heads
  bpf: Detect loops that never exit
  bpf: Add may_goto to loops that are not walked to the end
  bpf: Walk loops with widened states first
  selftests/bpf: Adjust tests to widened loops
  selftests/bpf: Add tests for widened loops

 include/linux/bpf_verifier.h                  |  31 +
 kernel/bpf/cfg.c                              |   8 +-
 kernel/bpf/fixups.c                           | 153 +++++
 kernel/bpf/states.c                           | 144 ++++-
 kernel/bpf/verifier.c                         | 609 +++++++++++++++++-
 .../bpf/prog_tests/bpf_verif_scale.c          |   4 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cfg.c        |   4 +-
 .../selftests/bpf/progs/verifier_loop_widen.c | 344 ++++++++++
 .../selftests/bpf/progs/verifier_movsx.c      |   2 +-
 .../selftests/bpf/progs/verifier_precision.c  |  29 +-
 .../bpf/progs/verifier_search_pruning.c       |   3 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   5 +-
 13 files changed, 1306 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_widen.c


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.55.0

