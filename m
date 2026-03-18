Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46072344DA6
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855814; cv=none; b=YcrWTZhSxR9DhFfKs0b07oY7yjy/K+t9MX+B2nmNF9A30/EeqgrjZo/AyH/oVePBIpra9K2nx85w+qJhsRPf6h1ED+Rsjmz2m9/060RyVZFMofJvI15fcLPN+vkpnC7SIiHN97Tmproo2AD6LADMvy4uMVW6EAC3u6OR7xNYhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855814; c=relaxed/simple;
	bh=SNAmj3uoN3pVh94ZjPbR6A6BXiDQRcXOA/iEy2BGAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMuN8ntlV/M0rTda2PE1mYMrx1tu98zdKHjrafwefxkYh+qrzqrqDKNODH/AzMARCs2kTA+p8yyINPw4uokSagDwLWB3E3OdHjZHWwMj/gTFDU1kSlABP8lCX6Zftn0dkcM59Ff2jeIgibZMimpWYaCRI7ZPd2NIkNPL16+6d40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=notqW88h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="notqW88h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40C9C2BC87;
	Wed, 18 Mar 2026 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855814;
	bh=SNAmj3uoN3pVh94ZjPbR6A6BXiDQRcXOA/iEy2BGAbs=;
	h=From:To:Cc:Subject:Date:From;
	b=notqW88hZPKDhS587B7wVxZ8J5nx15cW1LPtwfFUaJmBUarvxnFUh/KLhqZPxTL3c
	 Hs8i92en3FL+74exNiplKlp0me/AkJFh08k1P4pYP+wOcGJOkpSPsl6brmqdu96yEw
	 unAZeCM0GqqP3b6rxGq1HeHPcqJ2HkPSeo3A7DY4yVbyn4R6JD5PLzK7ZSPhkH3Zpk
	 NswPJvdPNRc/Y83R1Wd9iSlI1MCQuOzdXqYEQ0FP6vHqxVeVkELUn5L+ZA1uukwi92
	 vZQMhyvVvX2azic0qI3Exc6FmIzuh1B8+OjroF+eASCkf7I7jTl83NPMq9ngbPFAiV
	 VYv4G0ITh5s+Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] bpf: Consolidate sleepable context checks in verifier
Date: Wed, 18 Mar 2026 10:43:23 -0700
Message-ID: <20260318174327.3151925-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF verifier has multiple call-checking functions that independently
validate whether sleepable operations are permitted in the current
context. Each function open-codes its own checks against active_rcu_locks,
active_preempt_locks, active_irq_id, and in_sleepable, duplicating the
logic already provided by in_sleepable_context().

This series consolidates these scattered checks into calls to
in_sleepable_context() across check_helper_call(), check_kfunc_call(),
and check_func_call(), reducing code duplication and making the error
reporting consistent. No functional change.

Puranjay Mohan (3):
  bpf: Consolidate sleepable checks in check_helper_call()
  bpf: Consolidate sleepable checks in check_kfunc_call()
  bpf: Consolidate sleepable checks in check_func_call()

 kernel/bpf/verifier.c                         | 91 +++++++------------
 .../selftests/bpf/prog_tests/summarization.c  |  2 +-
 tools/testing/selftests/bpf/progs/irq.c       |  4 +-
 .../selftests/bpf/progs/preempt_lock.c        |  6 +-
 .../bpf/progs/verifier_async_cb_context.c     |  4 +-
 5 files changed, 43 insertions(+), 64 deletions(-)


base-commit: 77378dabb50f593c756d393d8eacb0b91b758863
-- 
2.52.0

