Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0F376A10
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944047; cv=none; b=DILKfkw94nHxzU2DdA7xZ8rgy1RDChnv6jOjiyLVFhifBdNm/kPn5PrwXJgvlj6c0uyuZFyOgJ5Z+gIvEBLPcY7OTwyddxEqsjYOG9WtubFYB8cdrkh8PzZ/If6R3JbwsVq9riiKd3TIINDTYSc0iopQibhBML5MbCBGhVxolYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944047; c=relaxed/simple;
	bh=Q867QdylhrILIZl7uwIyJN/YV4LNHOtgP0zdTrLDEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBjvM1KVoVCQNvU+Lsmw8ex6meXfsJcJgo8J7AJnP+JRFHGDKNzD+B3QAyQceFZtimuKlOW9RZApJbURi++WXyQvdKEKTAkATeAiSlP9dgCYbQLgUVjqxZK8aqFWPSJvpQiYn3Z5hOTNaxy8/6Ik69rPMqc0aGQKGktZkEh7TVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIkdqtfl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIkdqtfl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785944033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NMfeASp4Msjw1vMvRPi7MNiVqL+aI2n/OIGsp1byVBc=;
	b=aIkdqtflaUhpE2A00Mt0bPIcWwHMNiGqurNxvmppE3mbM/ArVuM0pKeME7m8dLcTMW7aLh
	W0hY9u4Yx2ARYHwn3ncpeOdcFrhqfmjD2rh5ufWb/8+3mACvJc/81/tfCn5ybbCvDJnK2p
	ZhaIxJYE/U8apn923Hh0AlGI65Mkx/E=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaitao Cheng <kaitao.cheng@linux.dev>
Subject: [PATCH bpf-next v2 0/3] bpf: Allow selected kfuncs under bpf_spin_lock
Date: Wed,  5 Aug 2026 23:33:37 +0800
Message-ID: <20260805153340.34776-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The verifier currently has a hard-coded allowlist of kfuncs that may be
called while a BPF program holds a bpf_spin_lock. This works for the
small set of built-in kfuncs known to the verifier, but it does not give
kfunc providers a registration-time way to declare that a kfunc is safe
in such a region. In particular, module kfuncs cannot be added to that
allowlist without changing verifier code.

This series adds a new KF_SPINLOCK_SAFE kfunc flag and teaches the
verifier to use kfunc registration metadata when deciding whether a
kfunc call is allowed while a bpf_spin_lock is held.

The built-in kfuncs that are currently accepted by the verifier's
lock-held allowlist are annotated with the new flag. This preserves the
existing behavior while removing the verifier-side category checks and
uses the same mechanism for built-in and module kfuncs.

The selftest coverage marks one bpf_testmod kfunc as KF_SPINLOCK_SAFE
and verifies that it can be called under a bpf_spin_lock. It also calls
another registered but unmarked bpf_testmod kfunc under the lock and
checks that the verifier rejects it.

Changes in v2:
- Rename KF_SPIN_LOCK to KF_SPINLOCK_SAFE. (Kumar Kartikeya Dwivedi,
  Leon Hwang)
- Deprecate the verifier's lock-held allowlist mechanism and annotate the
  relevant kfuncs uniformly with KF_SPINLOCK_SAFE (Kumar Kartikeya Dwivedi)
- Add selftests. (Leon Hwang)

Link to v1:
https://lore.kernel.org/bpf/DKG0YUDSTBUY.1X220287HT9V3@gmail.com/

Kaitao Cheng (3):
  bpf: Add KF_SPINLOCK_SAFE flag for kfuncs under bpf_spin_lock
  bpf: Mark existing lock-safe kfuncs with KF_SPINLOCK_SAFE
  selftests/bpf: Test module kfunc calls under spin lock

 include/linux/btf.h                           |  1 +
 kernel/bpf/arena.c                            |  6 +-
 kernel/bpf/helpers.c                          | 56 ++++++++++---------
 kernel/bpf/rqspinlock.c                       |  8 +--
 kernel/bpf/verifier.c                         | 38 +++----------
 .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
 .../selftests/bpf/progs/kfunc_call_fail.c     | 12 ++++
 .../selftests/bpf/progs/kfunc_call_test.c     | 12 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  2 +-
 9 files changed, 72 insertions(+), 65 deletions(-)

-- 
2.50.1 (Apple Git-155)

