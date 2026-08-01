Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8A305677
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546605; cv=none; b=DeQn3swe+zpt/OUq3WstA0YV7FHRJvWSf0EESRZGjCvP5HEQsYJeztWWu+r4dy1yLa8o6AOSd8WshQzS3kYaPRNhQpSHs1G7k0RceKzOe7cdY6Mhgwg5Ok9F5xWy6nHYqr8DegXeys9dEe1EYujBZ8/5h+2GUmBOu9e5p/UOBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546605; c=relaxed/simple;
	bh=ueLCZ+CaQEm/qYlscWIvAgQk/sj8KEkHeQ642dURBO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIQG7wO9zZM6SpfTn49pHRSxRVZylpEW9gdnwQKF1ZvxyxDjMKsD/jUDcmdXBbXjb6A/y47WQ0io/3tiUn/wAyy3d3nJesAx8mYgfv1EWV+yYEJqcs/tXY6PAjHXGHjIWyH0hGAKK2tG6jT4Jj5mZla80cYGafXEoIeAYF0xlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYfONHmM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYfONHmM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso918699a12.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785546604; x=1786151404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/vMWwbw+c4thc5tXp3YuAYrmckO4hHQ4DGZPIz3tLg=;
        b=CYfONHmM1UkRuyDPm1326cLQIAb1SXc4q31Ux8tqxPiR2JtYHeUCLegDVhdmMmonY3
         ov6c2c+LBUiwQXKXMqTt4Hz4uzdLdawRxseBPoXox5ORJ82RMZDlgXz3V/mF2JQRZUmq
         6t8XvdHNx5+1HRmn/chY29YOIblPFFJi1hSiAA8O8EZ1bEf5PMjfZDLaywPIbu8CFexM
         F4iSJBo0AfkNFDkHURmDgVmbpfFsH7ypD2pWBdzuEEXS4p6t/HMEF3XPzcBkZ6eCxZHM
         6gAyoSmJTZ2SoMpnwVwRKPOsGh40VO43GWTWBsEi2eLsR2CH4leBeiISxbFIHEgaDGqA
         QVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785546604; x=1786151404;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z/vMWwbw+c4thc5tXp3YuAYrmckO4hHQ4DGZPIz3tLg=;
        b=pGGRMKpP7kx0zOF36BJiZWxmXFBiGtU9mre+8xSMumnla7KJmFazgIGvZm78yjFqfI
         cCVIUCpaE8gWxX9rZSQknvZEK3mHg0Wws8M440pW7VzDNQq9C2Px9hJ5TAaWWfPir01O
         EvZp+V86txWjIsc9p/+9/ZfQgBHJBTgRJVYLLCjY3t46L2X9re50DA3tWzDES41ur+pI
         4pybbuwIKsz7F8EGN7x3+4ysYuM+OMzdbiV2qxm5kqHMfj52T9LWkXVxmX+JpvUuw8Sf
         1pZ9M3SXI1JKDlNKhXLnZpJ5rZFGb9J6NHoN3vv9fPlUR+pCzewAkoApsLfXrxXTLEs6
         OIyg==
X-Gm-Message-State: AOJu0Yw12oZbtEuc0Vh/OXmE4VgLRotMkwoOZj3zz/XDUGvQ14s+7Wza
	SmmJIFAYzAuzQFqVDEIGaKwj7RnDTdho5b9ihBXpfTFj7LVT2bJSemEIoLBkUyMz
X-Gm-Gg: AR+sD127pjaHW3uQdBi4ThuBr2lWiN/Cza8RbIWUC3H4otJVqf5odaqUKgTYohObBi4
	flNT8x7INVT/BAaqfaFDZ95d19W1T+ZqzHBSD+J/JGjt6eUjCAVghVgI//d8HrVvi3IZI+VpVCF
	pTLQP4icJ3mcKFKxhK/afDe2Ox61RQMmBaxv8SgvIZyB+Kmiuc9DvGZWxONLJ6P3Avv1RIHhhws
	j6KDOXiSiZEtD9vtFFSnvsTmncN59GBewcJ35GNs7XMqYLr82i8UsvzSUTMdoIyGMzOZCaSMoWa
	M4rJ7ty2qbzJHyWfQhMPmJWaiyuN9bb25prxPra9UkAbxtEd/7QYUG/ilaOgKnmbmDYsSsvyEJ7
	xTCkvIjDkkWtHYVvxSQrX8Q3icMB4z6gHiRrhNu3CiK8CQp9PsALa8DwXYDBByMeZpsoV/DcLm3
	WamqdC8xP+WPnn/Y9VTdFfmcCzOWyS3mktbYVkGR4beQ1NdYmjipDMAYsVOl3WpmtG1kbXT5mFK
	CdGNpG2oxvtdEm5rh3aSj56PVB7ID5EM/17z2aPjTRS6vCtQ2gwruwQ
X-Received: by 2002:a05:6a21:4514:b0:3c3:a529:1e44 with SMTP id adf61e73a8af0-3c92a8d6802mr1788671637.57.1785546603655;
        Fri, 31 Jul 2026 18:10:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm11234052eec.31.2026.07.31.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 18:10:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/5] bpf: infer zext_dst based on static register liveness analysis
Date: Fri, 31 Jul 2026 18:09:48 -0700
Message-ID: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
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

Changelog:
v1 -> v2:
- fixed BPF_JMP32 handling, these no longer for zero extension (sashiko)
- removed dead code in print_insn_for_graph() (bot+bpf-ci)
- reworked bpf_is_reg64() to drop dead code (sashiko, bot+bpf-ci)

v1: https://lore.kernel.org/bpf/20260731-static-zext-v1-0-98a4dc73e94b@gmail.com/T/

---
Eduard Zingerman (5):
      bpf: do not print a newline after disassembly in bpf_verbose_insn()
      bpf: track upper 32-bit register halves' liveness in compute_live_registers()
      bpf: infer zext_dst based on static register liveness analysis
      bpf: simplify the bpf_is_reg64()
      selftests/bpf: verify zext_dst annotations for various instructions

 include/linux/bpf_verifier.h                      |   9 +-
 kernel/bpf/backtrack.c                            |   1 +
 kernel/bpf/disasm.c                               |  68 ++---
 kernel/bpf/fixups.c                               |  55 +++-
 kernel/bpf/liveness.c                             | 144 +++++++---
 kernel/bpf/verifier.c                             | 201 +-------------
 tools/bpf/bpftool/xlated_dumper.c                 |  19 +-
 tools/testing/selftests/bpf/disasm_helpers.c      |   3 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 315 ++++++++++++++++++++++
 10 files changed, 519 insertions(+), 298 deletions(-)
---
base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
change-id: 20260731-static-zext-938cd128273c
