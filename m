Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BA3B6BFA
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524879; cv=none; b=dHrFdmUHiVTpdTHE1/wcWq23KaMjb1K8yBXWXbvD5WeSR0WT5QgFAAqpGOXoV5F90IiKt0A+5QWiM4c3lNlYoZM6he9bQt0nSfXG2YF8ZWjYy+oSm0ahG5WJZvNDxklHczAiEXTLHB4YVhtEQsHDoTQKa638W57U7Y3HkyTRrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524879; c=relaxed/simple;
	bh=aNPClSW0KD4vnTENZN2NBRjQphWEYemEUDNTv1YwrNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lX0TIutxTRYurVXOwLCDvNH6BYx4dlhxtbKmIctqpN5IpxVxEeLRpB+WfEejjN2a1GLfcrIa8fzp1IFiV2laXco/AXOFCquuC0S2JVAg3auJc0AbHrWnLDkpgNijP39KQ9p1MerIDNIQHRX7WZmkeBm5aQTydaf4mkNpG6OiaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvaUw/XD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvaUw/XD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1544660a91.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524877; x=1786129677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUMoVN62tCQqEIo+FmH9lHI6aVVrkC2otX1DrIeg5Fc=;
        b=SvaUw/XDMa9VwqpvuerQaVFzL6KxI/hCGwK58WCVeMKYlsUp8b2HtqAjqCWsqPrWzI
         ttsHLnm/1tRKr64b229uAieHPQM2JiiiYtA5PddtpMTOnJczwNud8w6YcTTI6vQLGhJv
         eMlwIzyxK2WkB6nX/tYIoIa+6jGO2nvGPpcXDk4hhW+j0bdYcgtyUYhhC7nQ7tftoEFs
         3r2fq3iAmMKK6kkYnu9lX6MiQhqalGZVLKzVM5WdyGVg1fNFlQprRzMNHJ0hLOnCueBR
         Zkw+vBQZZA/xIiwngRafnyVtaSG2aSnLtybmMfGCdRHXKhEF/wYxsn7kCV8tBMnThIT8
         FClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524877; x=1786129677;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pUMoVN62tCQqEIo+FmH9lHI6aVVrkC2otX1DrIeg5Fc=;
        b=qSyJXo601h5ZLju9ifVdPW7s6wwwEFwL355yaI+nKbj0soIwrWE6MZvw+2Cypt1JMP
         T7q2QUbok6W45anuLx78cDSDX3fa8lBeGPb4Sz4KBzqxtx8mP+6wdTmZO6vM+CohvpkV
         8ypBlkhgBiuB+1sQciYNh7RAChgM/fN9gpa1QN0f5jOj522EX+71/iuyeddxWMWIIXay
         GyABSwX6kq1HTfuRjN590bJxG5PdaxH29b+dofNpsG5Md07Lv/7OvEWNnpgTZECG+18q
         6ZBfARCbX1Ag9kHxxMdXl5vyG23Ml9RRqQxVGD98mMi6za55gZldoNdP7rQCJblI/J2a
         RD6Q==
X-Gm-Message-State: AOJu0YxfqbscVK+x4ldrAN/oLNY16PysjKcc/ioPghxaGY+3NzDKFw5e
	Eb8ihc+3bRp4ho1t7pcJxi67gBBPrCc+3VgCo/Sub+Gy/S+FrLs4vYNSB7UpMUgQ
X-Gm-Gg: AR+sD13Wg8mvrTdzMdqE1FPJ3GFUGbtQgo4k9pOW0YZwRom6Oqzn2XuQcJY6Z5s7YbJ
	r/W5XsV+ROnuiMxzKmnXZmv8JJCvh0rPdfw+ZAHVikB3/E+aTZRVA7FzwNEj0NZTxFqgxuQfSXv
	T7xtQO/GbbZCWZXQH4w1t3ig+H3ZPPRrXG9aBq34ZYgAsF4Zs8QnKL4ak8nwAckynZCDVYs95VS
	1cl8S1kAgFM7TVD7qHBbJkil2SG58QsCWjbXcH1osIhHqy36lVDezgGpx79hAp2EAxZ+roq5xpJ
	VTdnBnbar8fbQxouf/1QLTQfi3nbmGoOq++MQdzLTm4D/fkqKWr7eqfsF1gbt4PXxt6TOeGrIVY
	HLnBJIIb6Cstvrw43oa0yIoi+RPMRbT0faWBNvfOuV6zlV8OXhS5gHF2QaQpFFtssJug63a4UX1
	+EFKsx3aNzif1svh07n5R5GXijbL2ArJ+shaGMH1QKKXoGxByZ/JWv0uOu7zTbRSLpeh0BHZQy/
	RSi8f0YpT/tnqqT073GNJ+tpTxWBojmkd1UmR3U6J95QfTjf3XFsZI=
X-Received: by 2002:a17:90b:3944:b0:38e:b3fd:d582 with SMTP id 98e67ed59e1d1-38fbc53bf8bmr811210a91.39.1785524877151;
        Fri, 31 Jul 2026 12:07:57 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:07:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com
Subject: [PATCH bpf-next 0/5] bpf: infer zext_dst based on static register liveness analysis
Date: Fri, 31 Jul 2026 12:07:41 -0700
Message-ID: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
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

---
Eduard Zingerman (5):
      bpf: do not print a newline after disassembly in bpf_verbose_insn()
      bpf: track upper 32-bit register halves' liveness in compute_live_registers()
      bpf: infer zext_dst based on static register liveness analysis
      bpf: simplify the bpf_is_reg64() signature
      selftests/bpf: verify zext_dst annotations for various instructions

 include/linux/bpf_verifier.h                      |  10 +-
 kernel/bpf/backtrack.c                            |   1 +
 kernel/bpf/disasm.c                               |  68 +++---
 kernel/bpf/fixups.c                               |  19 +-
 kernel/bpf/liveness.c                             | 139 +++++++++---
 kernel/bpf/verifier.c                             | 150 ++-----------
 tools/bpf/bpftool/xlated_dumper.c                 |  10 +-
 tools/testing/selftests/bpf/disasm_helpers.c      |   3 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 260 ++++++++++++++++++++++
 10 files changed, 433 insertions(+), 229 deletions(-)
---
base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
change-id: 20260731-static-zext-938cd128273c
