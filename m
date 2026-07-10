Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFA383316;
	Fri, 10 Jul 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711803; cv=none; b=tnUx3m7xHfIG7Zyfc8dL1cA5J8SOCo6aI7C5SCt4cYLWxui91HzGI9doZPt2QuwedKZnYS7xvci7b1axZdtxs8yjK8I8stZBjnBLLge+awYrSV8VRGFyU7ZLFP3j58B87hPVvI3d/oDTau+k310C5F5MYYjkoEw1OgNez9J+JWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711803; c=relaxed/simple;
	bh=X/2lI+r7kwSXbHMEfVconOIzavnY8dn+lAxhoCdoMZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpYbpLzrzkOwrSh75865oIUrUPvmqGBM66pwS66Kqp8YPbb/JAz8gE81y7auKU9CgARIN1mHdi12y/6Xkc3VmctYOIS2u9YR+/qpIGLmC5VQBYeAvwouOcFg3PsMEt4uGbHQSl0IQky6YCmrctm3UoBezc4MBPPwv5LwiX4uf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYHoV66u; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hYHoV66u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783711796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hAfAs4EPp+5d8F7oUaEPnA2Lcnx6zxQAYFGiSR6ZIbc=;
	b=hYHoV66upsynngo/kTuxRBTZLu5vhBHW9WELdSrgo9B7DtPm6LbcLnEACTbuKxLg0tMUiL
	JxHX/+cBg3CVqp3h5nfUzmAUXpJ1Dz781i6LqKY1f0vTBbaXLgDLZJyRD2dAQUkNno3M9c
	OypNYm9wvuaqNS/m2Km3MJpR+OUMKtg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/2] bpf: Fix tracing of kfuncs with implicit args
Date: Fri, 10 Jul 2026 12:29:38 -0700
Message-ID: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Tejun reported an issue where a BPF program tracing a kfunc with
KF_IMPLICIT_ARGS can crash the kernel [1]. This is caused by a bug in
bpf_check_attach_target(): the btf_func_model for such a kfunc is
computed from a wrong BTF prototype. For more details see the commit
message of patch #1.

The second patch adds a selftest that can catch this situation.

The fix is a candidate for 7.1 backport.

[1] https://github.com/sched-ext/scx/issues/3687#issuecomment-4906694106

---

v1->v2:
  * Take a module reference in btf_attach_func_proto() around the
    btf_kfunc_accumulated_flags() call (sashiko)

v1: https://lore.kernel.org/bpf/20260710005902.2234832-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (1):
  bpf: Fix tracing of kfuncs with implicit args

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Cover tracing implicit kfunc args

 include/linux/btf.h                           |  1 +
 kernel/bpf/btf.c                              | 20 +++++
 kernel/bpf/verifier.c                         | 64 +++++++++++----
 .../prog_tests/kfunc_implicit_args_tracing.c  | 36 +++++++++
 .../bpf/progs/kfunc_implicit_args_tracing.c   | 77 +++++++++++++++++++
 5 files changed, 185 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c

-- 
2.55.0

