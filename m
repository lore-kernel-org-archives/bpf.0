Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8429C35A
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785711133; cv=none; b=JGm6rngY39ia8alBZKP+YTRzr/i3QW8/LIpEqvLNBqoqkYxU9zISBJv5wm6vgR4ro7lqJvdjE7+vURCeuNKKvCtE/+P5kygiOLR0aaz/qQi5mhp5ZO5Ddg26rDkARvVXLZ7A4YxYLpXwZUNKU+Fha389ziEq1pM7EZXFF/ug81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785711133; c=relaxed/simple;
	bh=2Ie6Tc+daqXc9lWNzWs2UECFqalPOJIGOSaDr6qJotE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuFPwQbXni+QzHEM1hiFfrDuYhxmqGROlEoEOjl4zL/7wul9EryqOnoEtPPOwpABrsUCD20BssFuDiAYQfNddeclEYvV52uJJXjM4ZJcMSpmMtz9ojf8uehj+k1fK1/R4VC6SBZSjTl113wg3ebzGfolDe4CSuNzuz/+6j7F0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi2HBriD; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi2HBriD"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso4844315e9.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785711130; x=1786315930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CL4hRxa/gfQr8GTGJSeS4vmV/jQAwaQ5XDEGNXS+nL0=;
        b=Pi2HBriDW5zQnRYMfnHp7CAsW9KIsa9qroWxOeWP6hleDLbxQNZGzwbGVQPiur+JMv
         gtvzest0npyh5WjaTIBHZ/cHG+FD0BnvwnS1DFXOXKBCxNC3hLPafO7fft+sqxeMQa+L
         qO54gA2ecW+1ag7MXgVPfWjHTvYMeLwq+LVEHIxzEMANfgzQcD6x7/VgNvkusRwloZF0
         luOiECrCcW4huWo8f9ARuxOK1N3D7PwN3vS6hnknK5Zw2bx0qfBDLsplR5krOb15fP65
         0puCsTFLimB1RSq2V5VuoM+AWpklwDuBjAiLiOO7kYjV/bh5taMu389/Q4gRWCePoIbl
         sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785711130; x=1786315930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CL4hRxa/gfQr8GTGJSeS4vmV/jQAwaQ5XDEGNXS+nL0=;
        b=sesF081oT41HxyFaiz54ik1tKJG1hxQtm7ERSWxrsyRTMgMJ2qqQJW8vzHa23zH5wS
         uVUMlPi5VDfnQ1DB1g5+BuSqF1sRsxniWVOQDHFip0MzSg0aW1e5lWChG8UHxs4j6+ER
         j4qXr+8lwhkTWiRMaaO2H/yN+eLiIREcXy1wryanSUQ8BQtRyf95b+F2EC30/cL3cD5F
         HKZUV3f1xIeXDpcp1AmzCL/vxTydfKS19WVcewKV/wEFD60PgALwDqSP6EJNWOASESou
         VZcH1YrKLiHBYBEUiNVCQYiRj0wN0bynQMUNLMI5c8YU8Umc+YNqewHVeE8s+7IciQld
         4H9w==
X-Gm-Message-State: AOJu0Yyk98P0A/6KrDlrMC0d7ZZf1Jv6hKeNLGneLUMBjuT/Yv2BdLra
	rOi6rM+7YR+qfKfCZUY8YSnuW5hBFx3FRHWtdQ5Lk48R5+cTzFzvyrczSnxFuCqa
X-Gm-Gg: AR+sD12ol/7vkKvY+QiGjp4NjCu5DJhK+z4pQlZdGoe6Ism1huhIu2K6DrIKQO1yp9S
	6/A3gZg+EctZM+xcZ8LEOKF/Gj4mCe/bT7Cl7vGB8aKr11Dpcp21/ycxiwTAkhDkd8FQZaPGZJW
	OvUzzzdficmPvtiVUBw4u05N4wUyBywY+91srVREB7FrI7OFjEhAEioh9xUQTwp3DozAJdUiwNt
	o+MAhPQJkZ4o0LHdGY8+Q88gPsORXvIMCqr2TfItYIbxrg2DyWriSPjiuccK6x5LZSK9+7X+jpi
	qlZ0DwSgofSfRMSaXneJg9/0ch65PstYAKJjGkEsH9C5+sCnvsqeFUJiab8MyfDv6k7BRmBIFsn
	TBjfJFtOF4FX8re7ivIndLv5QvtsehjZ19yLnx/R8scKQBy1/RI6gAV2kT3QZzkIujg1RCQsnbJ
	9lEDGAwwQAxhR87tyclVSeyuFv/VwQvHLq0ob4VLx43vxgXJdspTqkVfTP7TCipiZIPf8O7yLbI
	9wccz0O1CAjf3zo9F+xUJPBxrK0nhM8ukh2khRqgcqrQFSwJYV1KMzGoWRgDUoMM5D6KDeAqldS
	siAjJBzQVwsLSxFh2dAA0rxUsHTcpQxcHwjljRyLt5+XszQLsA==
X-Received: by 2002:a05:600c:4747:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-4980c674a20mr136572805e9.16.1785711129958;
        Sun, 02 Aug 2026 15:52:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a5csm241112525e9.4.2026.08.02.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:52:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Improve stack depth verification stats output
Date: Mon,  3 Aug 2026 00:52:04 +0200
Message-ID: <20260802225209.2511758-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=memxor@gmail.com; h=from:subject; bh=2Ie6Tc+daqXc9lWNzWs2UECFqalPOJIGOSaDr6qJotE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv/5H+95Pr81+ueyv490Nm9eO3ej1wR3HdST082u5rxt vFq5s4ZHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjINXuGf2Z7jC/s/TTrI3+e faeZw+NrS3rcPzOez3rconI1QMas7wAjw9/0HyIZC83eZB68WPgi59U5+2O1fJxy68Ms2A1UXp1 z4QYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com

 * Use multi-line format. (Eduard)
 * Adjust veristat to work with old and new format.
 * Adjust selftest log_level without new option. (Eduard)

Kumar Kartikeya Dwivedi (3):
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names

 kernel/bpf/verifier.c                         | 13 +++++++----
 .../bpf/progs/verifier_basic_stack.c          |  4 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 23 ++++++++++++-------
 .../bpf/progs/verifier_private_stack.c        | 15 +++++++++---
 .../selftests/bpf/progs/verifier_var_off.c    |  4 ++--
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  6 ++++-
 tools/testing/selftests/bpf/veristat.c        | 16 +++++++++----
 8 files changed, 58 insertions(+), 25 deletions(-)


base-commit: 8f876c773b79ed66dadc9507f50dbff39c6a9ec7
-- 
2.53.0

