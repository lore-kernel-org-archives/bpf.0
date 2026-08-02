Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A026F2B0
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702273; cv=none; b=N+/yofDQXlEcW/usytqGSCaG6NBekoAs4V1ym7rU9eJCvfIfM1omvndsI+Wnb4uHQM/U6IqraJ1ep7oLgP6KBIknkWRuNrJaZjSH6A9Q3YfgWTqnmN3OxljwHFrbphzbCwtvjByhMyB+IL6b2VRFw8tPmh5pNL7r6yFTHkCg6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702273; c=relaxed/simple;
	bh=sYsCCfL6UMYrBHz1sV22oENc8UFJHlaKGOYh+IOGRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQZck0vOimrJ90lfw1/cuq1nqSkYqa5NQk4sVEZN/wmMtHvpzZHR69ZDEY+I2/0Q3s2iXXwlfP0+jnz2JGeKcO92AYumEIaXbOYwgaV6YLVauh5s6JbYKhDUFRI3i4UeY8Bmj6oLxQGI9/uZ/hVAgUlmYSNE10w29q/1Rube5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtNx086X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtNx086X"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caf228a910so19262265ad.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702272; x=1786307072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftHvTt+2tvLAmeIMGMfO9UKF0rE4izTx+qYXoiZmRE8=;
        b=LtNx086X62VvjLGrKipT2VYZpLsaDA9TNAhGkE6IAn9Ok7mC2l4gSzE7/eirAuYc//
         x9jbiuroMj5ABNHwIGog8Tu5UoWmSy4SFyE/h/zhVys3IIZIShQjLXBXUWbVtw0Sw6N8
         muTqwtLULISjRmNUoH4/dP+jkIBlbIQK9qWquF1DQvSxCig9fOX/t0JKmFYDIT/73B5J
         zICzNnoYk1tXEIbiLd1IMOnSEAnEwqajft7Vy1C/i5NICBwmk+AmOoq95gZj77NJRm8q
         9KLDJNfq8hhE+zN+RcWsybqMxSmitQnBpKoCOnG6MxfRrskKirw9cwNQ82XFi3u+5tJ1
         efHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702272; x=1786307072;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftHvTt+2tvLAmeIMGMfO9UKF0rE4izTx+qYXoiZmRE8=;
        b=ZJsd1qrbA0jh/9IXP3ycM5qwd1s630LGnlB7fh/KOOGoPvP/XQGgywAXy0XJBXNMBT
         O1zHfNmAIPrc9zIREUnkhpHkKymu5AqT5TPFZbdNvnawDi9qEuFMd1oyGOIIaQdazPQt
         CnnU7WwVQaZEKvN/uZZcI6+gQjrIlZwk16FlisElJrX5PSWE98+Om6zaeUQLhI+KpnMO
         DGv39YO+MKJhPFijGza71Iepjbep8aRTD9V/v1rDphX02GkB7SU+Yj0PdQdEFSrAngC3
         d7p/HMBRPk9RkTiMoF23CVsTuT2JUMqDRlmR0HlPdY11HZDWGxhLhak1JBAh2ZYn7AB7
         Oh/g==
X-Gm-Message-State: AOJu0YxytFRlZEeplrIqulytZMKLW/wixCXvPVjlC0OgtM8DS3frBOo7
	tVGLnNhY4gRom3SpSqmcKvEbXqF+gkfBnkUlRh0L0DnNPHcv9t2ziA1hUrNnHA==
X-Gm-Gg: AR+sD13PETk63y36QSOE1U2wGtIc1c0sm24ggVI8Bo4lmkPuY7UIz7BTtYkhTJW5XSf
	kI9TEioLe+7kDDyly4rfmELsCkqY45DkSVA7AtB32HFCo1m76Ruumsoq7GPEw/AhfUycxPURrC+
	H5rBPo33CDUp1D/e3/hEFqqnpcgti5+RtxZuVuhpIYLRdVRSs4YU3akxF8UT8nZxRt42CxghxqR
	QBuhA8DmoKx5+E6Kup+504/k3h+4clVxJ/BEM6T3lF3TfLLDxLrJhFUnmEjYVz9pqFYz/SZLSc4
	kvJSb7KArYVs6y5h36etaylfmZRitv1rBKTTzkRITMBJq3Mf3K1Qv3veEvoMtZZb+9gHNWbFB0X
	updGt/XvRZMhLjS7NBr1uK7FQHH65Lr4rweGsDEheJ9MUvRVp/uv2C9SeGyN1aFytwq44QgDZc2
	O1JWtpOfIarzL7ncg0s71XMpywA2ezvHOc5gMw3+9arDaaPPGGXBEfBvcYNawOT57Whzby5pxNp
	YETLg==
X-Received: by 2002:a17:903:fa6:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d05219bb62mr78107725ad.10.1785702271821;
        Sun, 02 Aug 2026 13:24:31 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea128sm28590865ad.40.2026.08.02.13.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:24:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/5] bpf: infer zext_dst based on static register liveness analysis
Date: Sun,  2 Aug 2026 13:24:16 -0700
Message-ID: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260731-static-zext-938cd128273c
Content-Transfer-Encoding: 8bit

Min-gyu Kim reported a bug in 32-bit operations zero extension
handling [1]. The bug was introduced by the commit [2].
The tl;dr of the bug is that the verifier does not carry zero
extension marks across pruning points. The detailed mechanism is
described in patch #3.

Fix this by reworking zero extension logic to avoid main-path based
subreg_def tracking, and instead extend the live registers analysis to
track upper register halves' liveness.

As noted in the commit message for patch #3:

  There is one notable drop in precision: whenever a BPF subprogram is
  called, all 64 bits of parameter registers are presumed to be used.
  The assumption is that such a drop in precision would not inflict
  noticeable performance penalty.

Ilya, could you please help with testing this conjecture?
Min-gyu, could you please test the proposed fix against your
reproducer?

Side note:
Patch #1 is a small refactoring for disasm.c, as patch #3 adds a new
location where bpf_verbose_insn() is called and there as well I have
to wrangle with the newline added by the disasm code.

[1] https://lore.kernel.org/bpf/CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com/
[2] commit 107e16979905 ("bpf: disable and remove registers chain based liveness")

Changelog:
v1 -> v2:
- fixed BPF_JMP32 handling, these no longer for zero extension (sashiko)
- removed dead code in print_insn_for_graph() (bot+bpf-ci)
- reworked bpf_is_reg64() to drop dead code (sashiko, bot+bpf-ci)

v2 -> v3:
- fix for proper s390x calling convention all call parameters are now
  zero extended if necessary (sashiko)
- fix for PTR_TO_ARENA alu operations to set zext_dst when needs_zext
  is set, in order for such operations to be zero extended (sashiko)
- updated bpf_is_reg64() to handle BPR_PROBE_MEM{,32} loads in order
  to avoid a false positive from sashiko.

v1: https://lore.kernel.org/bpf/20260731-static-zext-v1-0-98a4dc73e94b@gmail.com/T/
v2: https://lore.kernel.org/bpf/20260731-static-zext-v2-0-da4aa161e8c5@gmail.com/T/

---
Eduard Zingerman (5):
      bpf: do not print a newline after disassembly in bpf_verbose_insn()
      bpf: track upper 32-bit register halves' liveness in compute_live_registers()
      bpf: infer zext_dst based on static register liveness analysis
      bpf: simplify the bpf_is_reg64()
      selftests/bpf: verify zext_dst annotations for various instructions

 include/linux/bpf_verifier.h                      |   7 +-
 kernel/bpf/backtrack.c                            |   1 +
 kernel/bpf/disasm.c                               |  68 ++--
 kernel/bpf/fixups.c                               |  66 +++-
 kernel/bpf/liveness.c                             | 109 ++++--
 kernel/bpf/verifier.c                             | 205 +-----------
 tools/bpf/bpftool/xlated_dumper.c                 |  19 +-
 tools/testing/selftests/bpf/disasm_helpers.c      |   3 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 388 ++++++++++++++++++++++
 10 files changed, 568 insertions(+), 300 deletions(-)
---
base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
change-id: 20260731-static-zext-938cd128273c
