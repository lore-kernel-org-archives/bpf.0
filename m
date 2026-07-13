Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABE22222A9
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986760; cv=none; b=kYoBJf8tiM6FhHw9fBI0Nm5Av4Gk+2VPf8u6xIhljU0PIkWfGl1u+/pDqGYcYB26Vo+JgUYwoFbd3Fj5ujdzko0k6H68Z1+kFJNcEZ80bPUGzfU1mosHXd0z0bCscq/zpgNRTSmQelCvX8BuJhbViatH38b5I3J5m6r7JiaJNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986760; c=relaxed/simple;
	bh=+J3++JMkDbLiJM7fxPf6r4kJ34hj8oTMH32DAWToXGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWNm1vkiW81gdB2+G34cbzjmQZYLcqcEppm4QBGNcAyD+D+4AwDSd7KxB7zjdqqRnlwfq3j15+v70nI/L6vsaGJhshTeuPKHLrxbSgCa+Vallq98E2oHQHy8jP4PIuL0o3jItQgDlKjZQF2HrPwL07wrYQyhc5Eyt84GtZ2KF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tut9QRKt; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tut9QRKt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783986756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ILaIFjtY9Rwz9qWraFBYyKxx0ipey5snjKA1oOZlPII=;
	b=Tut9QRKtOMl7xYNRj/NzRrSyjP/f2+mAlcDZuUg8ygnupYCbPmwffByW5Zn95vMAZFhAID
	7Obs+hLhcA1YQJIQGk0wXhbNj1keJKGminOpM/c8WJJAYTYPY1rMRv6/VXNAyXxeSPpomA
	sRApMB8tyOmbKV8EyuKwtdUN1HwkREY=
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
Subject: [PATCH bpf v3 0/2] bpf: Fix tracing of kfuncs with implicit args
Date: Mon, 13 Jul 2026 16:52:21 -0700
Message-ID: <20260713235223.1639022-1-ihor.solodrai@linux.dev>
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

v2->v3:
  * Replace btf_kfunc_accumulated_flags() with btf_kfunc_check_flag()
    following a discussion with Eduard. Inlining the hook walk is a 
    worse option than a helper, because BTF_KFUNC_HOOK_MAX and co are
    internal to btf.c and exposing them is uglier.
  * remove reduntant btf_is_func check (Jiri)
  * formatting nit (Eduard)
v2: https://lore.kernel.org/bpf/20260710192940.3020280-1-ihor.solodrai@linux.dev/

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
 kernel/bpf/btf.c                              | 29 +++++++
 kernel/bpf/verifier.c                         | 66 ++++++++++++----
 .../prog_tests/kfunc_implicit_args_tracing.c  | 36 +++++++++
 .../bpf/progs/kfunc_implicit_args_tracing.c   | 77 +++++++++++++++++++
 5 files changed, 196 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit_args_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args_tracing.c

-- 
2.55.0

