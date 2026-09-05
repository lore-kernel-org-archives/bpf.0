Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627E1D63E4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597263; cv=none; b=ogxpi1CgMoLq6DSqELWjoYgzcdMJSOi5hmsKm3eMDGB4yhtqsc6grxppQijr0Zu4OQsovH02pz1Z5xb3+xLudiMtRKUZoILP20cKMZY0oVYY4nlqhEeIlQamIc1G0Eghq7LKu2LfzJiHP/6vyO/SAXPyingHxp9TsLvPT2PY4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597263; c=relaxed/simple;
	bh=6bqzQcP/Y/+W/swGuxFZt8AcTmiPdYdtRCJq5GXWQgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3Ig3qg7+ZuPrkl0EHdmfDYyKVxOu6rUSXRX4gNCxeaMg/4Z5mnM4m4n1iBBwQ8yz5Qa4Sts9RyBcE3nSUKpogWxi45TZtNyWPqXph8xtd94L18gZQ1iUxDJiKMkLbH+56c7rK+Q1kP6r8xTMaTKoEyiH0Nb5uJvpEx4672Tk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU3fRZ/j; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU3fRZ/j"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so3384845e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597260; x=1789202060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=13Sc+Bvib+rFvfbPOyhv+8lh5zduMRAqWbbvuFCjR9c=;
        b=jU3fRZ/jYzHbG+LOy3S5hGR4BE16b9Nh+RIB5XR3M/CPyCdAUi6+1MPJbXC014qpwi
         KzDUNqN8rlnOoUUBWcFNRJJRS58cU6HgE3qdGqshMauNx41KqY8qGpU6JQgWljr42l0e
         SxXv4otFnryQh+zyJBamkfoMKZT33KPMQSBo4PPsyWzdqzZM9qPTlELGdoeWGYxn9JQN
         MwrD8WdFqrr4Z3DGlCfO162pYxO4ytyPGrgtHnFsOduezjV4q9Vgc2rsyX/bhwNvfj8Y
         Ha8PmqFUJ/40WV3yHIUj5YqaBUf7g9MnsnAjM56fx3p4jPAggc5nNAYLlkZvr8o1sDtN
         5/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597260; x=1789202060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13Sc+Bvib+rFvfbPOyhv+8lh5zduMRAqWbbvuFCjR9c=;
        b=DUiejjdQAGwFxAnDQH6cW88ibmTrMUlcZK+Q9M5wF8XLd6bzFvFKKoMRp+wjJTkww3
         W6pE8fX+mNfmoXS80z9AKjvm0KLTwncd7mXZhgpFx8vMhTq/cWOYdkRoO007iJ0chR0X
         OYzEYC5gdtMHx2armioyNueRFNbLtZaNI3gLoMR+TLfNZPRhVASvxBWM3vTfBoDDqSnh
         LJTuvRlKWmT7haA958l7TukqnVRmHzT/xDrPhJPSMWXHWaGClu/vaJTIYJCkCzxeJjFY
         +LSjSjrFgIy9kRV+Em2Yt/i6Rx9CUj/BGME4mXJiMPZQUbh9iD33eZDbCoeR/X+sG6Ut
         cJaQ==
X-Gm-Message-State: AFuF++mKZSdHnZ0EM0Z3oWX8hgOgRFG6TpnYc+RcQRyTuRDGSwYMmnBh
	fuk9cTVp0QVWAjMORGCBdPqesnWETAKojG4tDJlLbncAiUhR3Q4xATf3OsjNpQdG
X-Gm-Gg: AYBFou01HsyeuXAtOvQblaYlmdI5pvB3kbfaYWosxZ2256BfRdHTijUiPqCCpxKH+jc
	9eYAYcY8pUGjlAc1YvYwv+9Pn+oUF7FhYQs4S2VAn973NsRNwn4WmqZF/+4fvhi1Ysmz2M/xCBH
	gwTeuDQBzb2Hb3P6UKvyfmxeJ2n/f7pnr4PnyJzt3+KpdKTQjPZGsBXLqrbyfUPGvNG6jQAA9wO
	9hraFFIM/458XmfkhZewVgGT1CWHotmTWtOGoliAQeST9Lwfifq04v7yHIYiL3jagw/YxOV9AXa
	S4Ez5e7CSzianINwk176ImeLgneP7BU7z+1al5Idgkq0g93PS9cAuks8LlCtkZ16/A1jTwgSLew
	28s1khAuBj0IyHMuPccVhQVrj8D8ZXAF/O7RdeiSyxHlqP9wlZrL2R40nT/1dYSRgAQTYVfsgwV
	6bngfZfbhf4mAkRhdMSH5RTqm99L1lFQFTFnjQjjvckrrxZMv47eyQ0Olk34gk+DpdXtzu/I2T6
	BJSrcjDh9xpanqD3t2W7bS2Ty2Um9WFoE1WJQDcc0RIWTVVLn5JbAIpGf6j9ktLG4AcyaVF+J+k
	sTU2khuN8+nlGj6r2JAEJbCR3AR4uleBm5EjAQ==
X-Received: by 2002:a05:600d:8487:20b0:49c:cee0:e7c0 with SMTP id 5b1f17b1804b1-49cf8261bf0mr160570985e9.16.1788597260112;
        Sat, 05 Sep 2026 01:34:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm9602452f8f.4.2026.09.05.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/7] Misc bug fixes - part 5
Date: Sat,  5 Sep 2026 10:34:08 +0200
Message-ID: <20260905083418.3723623-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=memxor@gmail.com; h=from:subject; bh=6bqzQcP/Y/+W/swGuxFZt8AcTmiPdYdtRCJq5GXWQgM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pezPt/uu7LEV2tulJ7r5U+rvyXlXGvIbNNbHPvT7s umg57UJHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhI5jFGhsa3TWzLvQSLbusG fAjhEln5Isbjg2bI2Tn1nJvcHiTaWjEyPLXwuMVzeOpzna+fRDraLO81sqwRmCJSIBtuvjRquxc TEwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260905070003.3193366-1-memxor@gmail.com

 * Address inner map corner case for callback map value patch.
 * Drop patch 2 since the test can be flaky.

Kumar Kartikeya Dwivedi (7):
  bpf: Make post-verification instruction rewrites killable
  bpf: Preserve packet pointer class displacement in regsafe()
  selftests/bpf: Test packet pointer class displacement pruning
  bpf: Reject fall-through across subprogram boundaries
  selftests/bpf: Test poisoned subprogram terminator
  bpf: Assign lock identity to callback map values
  selftests/bpf: Check callback map value lock identity

 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/cfg.c                              |  21 +++
 kernel/bpf/fixups.c                           |  21 ++-
 kernel/bpf/states.c                           |  42 +++++-
 kernel/bpf/verifier.c                         |  39 +++++-
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 113 ++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_callback_lock.c        | 121 ++++++++++++++++++
 .../progs/verifier_xdp_direct_packet_access.c |  44 +++++++
 9 files changed, 399 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callback_lock.c


base-commit: b75a000f2ac15f4778ddd6d9298d60b24ad776fa
-- 
2.53.0

