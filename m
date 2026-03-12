Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504173C0612
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314812; cv=none; b=koebHRBPDpII/arG4vFeFjUjvqkZXF0siy+C6DsJ4vQXn0Z/SxU8DfjFAjNkAbnssiW7ZvQCgjLDWwOlyMz7UHg7SNAIuYRQgVxjPQSiC42ygsqbReMj3tpznSvocqCgCQ/p/C6EJz+RcNb2O85ijfRajRKhRXkbEpRO5wiYreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314812; c=relaxed/simple;
	bh=TWIq0z4GWylUVn5wm6+r8beKQ4KvINJeMaKCoovR70M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irJFIwHd1bsXyka4n1Q8y2myyVOlefVTpurpCu/fIAmVDhWdB5ZJcm/LQqp1DiMponQLEhLVjLMuVUsrQN5hVPMlPZ37MmxE+ewk9B2leP0S3GCEK70G8LpMzAIccFWXWjsLnL9LHzoJF2DGP8n/4lgAjKhNCj5FyByBrtkihqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPfxJvzH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPfxJvzH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso29076a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773314811; x=1773919611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKiht1HOWsUIF7UMFiu7a3cTZu1zFYNyLF7tT1esP5U=;
        b=mPfxJvzHG8uIkP5VwQbnq3RSL+8Pcamof5tSZtlvXpdj6WB/5QBpZ27PcxRquWNZ+u
         QwixmUxmXdcRmifyh4a0oYchwdrdMyMXKi/c9sBi0OAXH8YdTpe3LmCSOMXzANH4EWhS
         mYqCSLO2uOu87IlxfPpILRbMtv4aTteQW9YFVt+8D856VnCP4+lhGkPanxviMMswOa+h
         WvDefCzjls3E28618k4kSEVFZgZB/ypM80ebhI2v31Oy39lSvkjfrji0R6gf/zbrx3S6
         mNdL0eRctLMEY++twRIB4kb0s/WHR5Nwo7xMoivCrmtTkC5Sb8UO2qZtDCR989oxJtu4
         XZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314811; x=1773919611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKiht1HOWsUIF7UMFiu7a3cTZu1zFYNyLF7tT1esP5U=;
        b=GA2Ez1Z1/9yiCp7gyknrqZV8OHNIvjx6vM5WKRERn8rE/cx/D4Oe0iayBBqyY3fSI2
         YkzSsW6eNO2tjgIxJbH7Sl/B37BQEi0J0VHsg5vmLlwCPrD38gxkPnmRw1cwC45foPaD
         fkDP5MJnijRXrASI/3yxN7TGaKPrYdWDQ5ZwGxRnHD9w4qE2I4k87AVNDTBEyt2Fd44d
         hlG52ONZMgWQd5BhrHCp6UyKQabesaRZXpAwO9eL5QlfNy5b0sZjfnfkbpZ7yAwSGrQa
         u2GHht++IKvNrrHXre381boG0KHFkSqfkO5mRrv36OApeZbYW4KmUSf7zby4n4ozv8m3
         YG+g==
X-Gm-Message-State: AOJu0YwbKMzBFLyTfo97/6qLYG3CmtRpXh1M/pYxCLTzzzdwIs9CdmCJ
	MF5sDfIST3lDPTUT9RbEzRHDyyuRPVoc916NpxDtoThICjvy4ryw34XadK33VJt7skc=
X-Gm-Gg: ATEYQzwLzKDF92Q6rie7ZhXUEc0jM0LknIfAlV6j0EFmp6QnIOD5Wt4eEBSMwhmPrex
	qEKaNlNHg9Y7Vluf681h9Er+tFdMJoiD4nmABZY7iFvJ5PIneJ20HgGDKujG0/RVl+Q0rIsd4hl
	cEnj089Fl3+BtZGbuUZWcfe3eg78GgM2jqewfD+Y/5CKG9u1cIlO/KlN7xkCmGxviWhb4ntlpzS
	0cYDwmUsPQVloKcJV8wGcBI5wNxM00B6Y2eRxQKDJsKE/AWdFAI01U3d1zIVR3EyAPrxFazBoOR
	bQrJdFKOzG+s21eCrrsm/21mXeMi0dAt96ZyMSg8SmInEPpJWDWUGWh3rT+4jnlXg3MVlzj0uTr
	t5l8fERIqFnz3vz2NL+eypWSm5/z5O7v4RSinJFEVYSr3wm24m4fOz3kXXraRH7BphrRqKPQSJa
	rul3nPWnqEdXCigh4BfEzG0b0tZuV/BVEUC0KHAGNDqWaGpFOztH34LhRwf2dlbIZ8l2eAL/5bK
	wVJ/UtpLA==
X-Received: by 2002:a17:90b:530c:b0:359:fecd:1cd3 with SMTP id 98e67ed59e1d1-35a0135ac60mr5404710a91.23.1773314810601;
        Thu, 12 Mar 2026 04:26:50 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03005f7fsm5220579a91.15.2026.03.12.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:26:50 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Fix unsound scalar forking for BPF_OR
Date: Thu, 12 Mar 2026 22:26:41 +1100
Message-ID: <20260312112643.22659-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() unconditionally sets the pushed path dst register
to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K == 0),
but for OR it is wrong (0 | K == K, not 0).  This causes the verifier to
track an incorrect value on the pushed path, leading to a verifier/runtime
divergence that allows out-of-bounds map value access.

v2: Instead of passing the opcode to set the pushed value conditionally,
    use push_stack(env, env->insn_idx, ...) so the pushed path re-executes
    the ALU instruction and naturally computes the correct result for any
    opcode. (Eduard Zingerman)

Daniel Wade (2):
  bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
  selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling

 kernel/bpf/verifier.c                         |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

-- 
2.43.0

