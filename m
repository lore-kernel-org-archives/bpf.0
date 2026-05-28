Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E382F5468
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985086; cv=none; b=t2hqH8E46B2Uf5Ds3IScIBfKvXu0tlbt+ICCZ6nquZtaTiwELo5f/08rW9qDdAq2N47sZ+i00sKoOWQrA7Et5uugauWArpraDml3K6jiAO71rQFqK0mrP4G9/V3pen8Ol3M8NStssmNgzLmPP7M7Rzwb1bhgcEcixOJhB+V3K0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985086; c=relaxed/simple;
	bh=SpX/qxjfuzpQX6JY1gjSWoALbWIspWNCIhmm/ATRtUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXH+qu/cF6JMMAScG7xrk//H7GM64kFAnDGG/bizI0XKYhW+Npeym0uuQfPX1ugA8IyIBKpK7W+qIzJisb8KekQEDuviolZRFqxQwLCkPn02hjqjYse5OhAzAKo+wzhGeuohwxXxrPBVm5JpCas7ID6YsZt1OcSBa7xfobAr76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzCiPbSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzCiPbSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C51F000E9;
	Thu, 28 May 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779985085;
	bh=uBkuRsS+rErMRAlS6K+s/SZuTdHmBlHVgvNB3VgULIE=;
	h=From:To:Cc:Subject:Date;
	b=PzCiPbSI+wQAsHCg5hnpbNRPphANWT6Bot+H8muCKNrpMiNln5SRsgTl4+kIWIaMp
	 sXa5IGzXc0UP9m/ddpaQS3g8tiIrQ6riAhllFoBVFqJC5dUQSzPpWxVBM7pnevLdFX
	 7+EmzORjZQchfX6UiIx29w9UDII16yuU48mjJO9TLUu5Lhb+HkTjaak9rkiJHdp4Ib
	 G/JKNkXeXzrulnGavxLwTwwKbESS1oMopGKL4ENiWCyfxTAje7pZgkwZN8A/inK8Qw
	 MKW0aWVm5M4aQkitU8mGtXV7R6JfNkxIANWoqyCCvkneGMMZKTE/LM+Y4cyqIE0BXW
	 QYADqjoIl01FQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	"Yonghong Song" <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 0/2] bpf, arm64: Stack argument fixes
Date: Thu, 28 May 2026 09:17:46 -0700
Message-ID: <20260528161750.1900674-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 fixes a redundant MOV in the arm64 JIT's
emit_stack_arg_store_imm() and clarifies the stack layout comments. This
is not a bug fix but an improvement.

Patch 2 bumps the stack argument tests from 6-8 args to at least 10 so
they actually exercise the native stack on arm64, where x0-x7 cover the
first 8 arguments.

Puranjay Mohan (2):
  bpf, arm64: Fix redundant MOV and clarify stack arg comments
  selftests/bpf: Use at least 10 args in stack argument tests

 arch/arm64/net/bpf_jit_comp.c                 | 12 +--
 .../selftests/bpf/prog_tests/stack_arg.c      | 30 +++----
 tools/testing/selftests/bpf/progs/stack_arg.c | 90 +++++++++++--------
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 24 ++---
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 25 ++++--
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 11 ++-
 6 files changed, 115 insertions(+), 77 deletions(-)


base-commit: e42e53ae23b7d41df22ccd7788192bf578f24da2
-- 
2.53.0-Meta

