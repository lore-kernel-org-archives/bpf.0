Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A845BFB
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614345; cv=none; b=ZH8XaVNFx9oa2JlZtIG6u7/UpDeFJyurqGR9T8YTX0E0nTj9psZVDer6X/QztvDgn7qVjQcKscpy65/Q58AalZSpiOhBSNPPR3Hgx+99jvoNbpL8LFuUgBQjbwDoUUj5VqMXT0gRgYtEFINRkpXexZzVJg62lX3KmAi/TCrJ7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614345; c=relaxed/simple;
	bh=pE9csr5/5K1yA8W9aDbQ5DC5/JmFrTq7sXDf2rgaTYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pcHgk8n17S/8NxWwrXSglRsQiMzg1Pfz8v7KOt/9W5jkvcrNHi+NcG19JL5JIX5/lTsNaPpiSeNflzKR60OeFIufgyk6ccEP81XmMBBjR2e4txMebMtPo2SvjU/pnb5OyZbsEUDHtR9hR/BFcjkW9+Q6CzlXQHnLoueln1zRSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXBmXpiz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXBmXpiz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dca3951ad9so50429195ad.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 20:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709614342; x=1710219142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Xi8pt+V+xEEa9rhmsVKs/G1+W2rpdlyZN+HVdnZk4=;
        b=dXBmXpizq/WdOZJuqJHilo+0BBuciAmPhDBhAQnJ3hn0n/WIg9cwhFumqmYuO2EIlH
         wTiYpwqFYEw+k1GjotHcr2G2i3vAcsAUEw9C+h0mDpsJIDJK0GkW5WvxaB3PD2LsOKeO
         iZKDWxQREyjrzu9HS2OnWjVp/9NI97AjyG9Nd+LLwYowALHW9k7EDXJ4CP6xY/IqIKBq
         JjVTgTtlFWJl0o3FE2TUJfD3+KK0yuk7WZDTGahoDAUad6k5cW7kWsmUho9cy42fGR4w
         w76siYLPblhGEpoC0msBhg9l/SsBahcNUy6QSpywXnrDbsEhmL/rw9e3HEDPVSeccSVY
         nylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709614342; x=1710219142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5Xi8pt+V+xEEa9rhmsVKs/G1+W2rpdlyZN+HVdnZk4=;
        b=p+rWDCe+g/Z9VJT8678KqtHCQN830orKLKycAeSjQ2ClNUqMn2MBL3QIt7rc79wfpk
         8k1KUU9mC5NGxO2UQixIciGzszqKFcJYwhwX46bW7tQQw14tooq6xfQt04kYxHzbYzwv
         jb1glJQwULJRhMrJYCP1uU3PWYJCz+hVqjkmF+Sf1eBBdv57Dq/DKl2A11MOswLot5Iq
         5zJmQHbicsvsQM4u2Xmu/skJsAAq+k1iXwe1imdh3SWmJ1uy4Sa6b6DQDzAZTj74x3hG
         bZ3Xhkmt2CBsKIbf5FIX3dSgR8DZuy9Z4sxyg78W6JD785pWiV9dcntbEw0GX1n0AH2E
         +gng==
X-Gm-Message-State: AOJu0YxIGRwJIN9hrRJT7AnzhPDZ16ZgLP+c9bqMHUm/hyGjxHKR8Jeo
	6wmSPfXOMlWpgbiK0qFJa+QLO3Lip7qk8S+TeGvjiRCPqKXvrIrrsSHd9icG
X-Google-Smtp-Source: AGHT+IEO7XXcQQrZMQhPgJoNxv9M+IfuVK58O4KlwGObMrIBIDhhzsOYpjIoTnb9wZNIXc4YMzWsNg==
X-Received: by 2002:a17:903:2443:b0:1dc:b308:db44 with SMTP id l3-20020a170903244300b001dcb308db44mr1035748pls.45.1709614342191;
        Mon, 04 Mar 2024 20:52:22 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001db45b65e13sm9435443plb.279.2024.03.04.20.52.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 20:52:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Date: Mon,  4 Mar 2024 20:52:15 -0800
Message-Id: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v4 -> v5:
- rewrote patch 1 to avoid fake may_goto_reg and use 'u32 may_goto_cnt' instead.
  This way may_goto handling is similar to bpf_loop() processing.
- fixed bug in patch 2 that RANGE_WITHIN should not use
  rold->type == NOT_INIT as a safe signal.
- patch 3 fixed negative offset computation in cond_break macro
- using bpf_arena and cond_break recompiled lib/glob.c as bpf prog
  and it works! It will be added as a selftest to arena series.

v3 -> v4:
- fix drained issue reported by John.
  may_goto insn could be implemented with sticky state (once
  reaches 0 it stays 0), but the verifier shouldn't assume that.
  It has to explore both branches.
  Arguably drained iterator state shouldn't be there at all.
  bpf_iter_css_next() is not sticky. Can be fixed, but auditing all
  iterators for stickiness. That's an orthogonal discussion.
- explained JMA name reasons in patch 1
- fixed test_progs-no_alu32 issue and added another test

v2 -> v3: Major change
- drop bpf_can_loop() kfunc and introduce may_goto instruction instead
  kfunc is a function call while may_goto doesn't consume any registers
  and LLVM can produce much better code due to less register pressure.
- instead of counting from zero to BPF_MAX_LOOPS start from it instead
  and break out of the loop when count reaches zero
- use may_goto instruction in cond_break macro
- recognize that 'exact' state comparison doesn't need to be truly exact.
  regsafe() should ignore precision and liveness marks, but range_within
  logic is safe to use while evaluating open coded iterators.

Alexei Starovoitov (4):
  bpf: Introduce may_goto instruction
  bpf: Recognize that two registers are safe when their ranges match
  bpf: Add cond_break macro
  selftests/bpf: Test may_goto

 include/linux/bpf_verifier.h                  |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/disasm.c                           |   3 +
 kernel/bpf/verifier.c                         | 193 +++++++++++++-----
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  |  12 ++
 .../bpf/progs/verifier_iterating_callbacks.c  | 103 +++++++++-
 9 files changed, 268 insertions(+), 49 deletions(-)

-- 
2.43.0

