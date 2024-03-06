Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CE79DE
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695177; cv=none; b=Ksg5OFqEyRtI5aBmrM/nuexRf+q9KAXjFBRDVU5q/+qle/SkJiBfq/rPZvzwswECpM6lr8NNc+e8azT6Il0qp8sGMte3xbRQUnFyBEEadCQD8rrgrjue8/zVyCxCM1ciR+XOH5iubjJDw1hEv6oDbeXvFfdDUxhXovyhDfsC3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695177; c=relaxed/simple;
	bh=PPavpl5C4yt/DMm7OaXCpRlPeLyXEQoTep+tmIH9XT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1W00LVRakLbi4WCPg+92GT1qFoW/Khg2uUtfgFOH1jDItNtRv6on2MX/+eJVCyOWrwwCHVEJg03mC/VoygNvrjIBhmnb0k0gVAox4MlPirYdK/amIHRaY7lySKYH1hUPVF3wtitwNBi44PNMmLAYwTjRydP76BSLhJm5K6wiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBE1e401; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBE1e401"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc96f64c10so58611665ad.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 19:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695175; x=1710299975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiWWFwBuLkkHJB3lRAj/d3ZjwgtL5eBIjchvCep6YI=;
        b=DBE1e401Sz5cNJAXjMjlh1k+1is5Kd4zC883tJ9kF/X/dxM2laR0TXLme7HJOdsNON
         q5nZ4g/oAIQPDqrC/GbQl1Nndspy2dviRtt2btle/pVgdJlr0H3tpPAFFkvur/IJvinC
         SZISf4K02FOu404GuLUoQleYlNop7ff18lSU6oMYqASCpnQdIY+mIKrlrqL1MkMGJfuv
         tSJeSkw5gJFj7iVN6UWhDHb31Jv5ZIOkMDtO7LB0+emGc5knOlxuS3164gQwlw+Kh9vG
         WcUwCoNMsDqAokdJgqythT+3QVCwkmKkAKw8Dw9eXj0WyQoCcZ5ug1nigOVsqKD9XawD
         HHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695175; x=1710299975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWiWWFwBuLkkHJB3lRAj/d3ZjwgtL5eBIjchvCep6YI=;
        b=bo7ayGJFUH3unAvY03yZiJeWrszwvTBd7ZjzWyJVc9ORstZ9OLDzfGEL2tNPC2RKVp
         gRFWUoMTfsMS5V8w9uRvbjsjCUbtwmytBhDg07FMEsg4EH1LdeJB0B6KWdMz8Wa7PzEz
         QossYZ4VQ9cxbjuiaPDk8ZRYJyB9Y2n/4njAuDBoL/k38XlBi6uc/2YzqtGn6xgPb3eR
         g8CxtxTHNQttL224uyVIJxIsTWa8LpZqLD1wUuMu74oYG0kNhSGtZEkybDoqzZKxGSo0
         OzigVY59beM+vCxLi6/inuL114N0Uw4Z10yIxm7VLg3eEWg7ViB1T64mTwP9KjH+RkcN
         HnXg==
X-Gm-Message-State: AOJu0Yz/olmOg0BmNTbsK83JQEvu09srr4Bvrz7MYPbDIZu8b+bv2IQO
	zc/dBvDwFoQuQQkb1LVERRRWaRYAYmqCpAvi2YEtnybFnHmkqRJnQafobpzK
X-Google-Smtp-Source: AGHT+IGFKZqmrefQZkI2C9+uvpmfCCSbQj9bhr5o9rOem1IeJUtDnktvQh6G2OV1zbCf+uAMwrusxA==
X-Received: by 2002:a17:902:d50b:b0:1dc:d773:ac with SMTP id b11-20020a170902d50b00b001dcd77300acmr4234579plg.7.1709695175044;
        Tue, 05 Mar 2024 19:19:35 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:52ad])
        by smtp.gmail.com with ESMTPSA id mp5-20020a170902fd0500b001dcc8c26393sm11394840plb.225.2024.03.05.19.19.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:19:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v6 bpf-next 0/4] bpf: Introduce may_goto and cond_break
Date: Tue,  5 Mar 2024 19:19:25 -0800
Message-Id: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v5 -> v6:
- Rename BPF_JMA to BPF_JCOND
- Addressed Andrii's review comments

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
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/core.c                             |   1 +
 kernel/bpf/disasm.c                           |   4 +
 kernel/bpf/verifier.c                         | 212 +++++++++++++-----
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../testing/selftests/bpf/bpf_experimental.h  |  12 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 103 ++++++++-
 9 files changed, 292 insertions(+), 53 deletions(-)

-- 
2.43.0

