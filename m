Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A02413791
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267206; cv=none; b=b++uzpYEN1aerRGrrOB+XZBeD1Mbfm1ITBQ1zAEvGLvJVGmilkrCO4tF/iTRGQnVxwhUg057guyucqdJY8Zw3fTqZRHri+2fipN75DftlqBX2n7PgdeL4bq470JyruX3K8lnRi3hFYGZnfNdkQu8BHreuRPfoUne9gOrbyM/bRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267206; c=relaxed/simple;
	bh=A9T8tx2LGTgmjPowI7gr2kzUCsECwdxuLVr9w6ZVhVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVEHGgAr7NmOfpovitiek+VVZtQt14eC3F8OS9zT+Z60un4ARveDvQvZVDe2WW3rhBdXlZtmuCwx7z0hv85rrC3gsmfHe+fIoNF3AHN+cAW1b5QzXBlDZDPVwPm9x958i0YZI+X2Jf8hI60yO1HnB+DxWRpKHvDE6PJ0sUH8fjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yym9EI5C; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yym9EI5C"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so59115e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267203; x=1790872003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0wcdDf3H6cjE1fTqwJWYamdCSGqHinpi0Fsldpr96o=;
        b=Yym9EI5CW8WPpvfP0/9GnbFt37RIYmGFjlBKx2O32EuZq5rjAd6KEg9cqvlL8hskfz
         lcqydGMnbQ+zw1RVvOsLmM9ppBUbOuXC5XTFXJNb+rAIZ/6kwGsTwae/SMIu2plx+EQD
         cP0uIp9yALSpqWcQWl6/zd/qr68LHkqMrkU5nH3JT8Uc85v20K198ys63w27S5c+Dh0O
         JUxT6IDai9Kv816DCVKhChjV7rj88rXNxq8+M8WazHUiUuLrInkeZaXoDSSz05jkL6yl
         KGphuuDTRiyhJmaNZS0a9pnFn4r8+RblDlmqZX7k3IsSTPNkuGEIAfd4HaAX+8u5DZDC
         0bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267203; x=1790872003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0wcdDf3H6cjE1fTqwJWYamdCSGqHinpi0Fsldpr96o=;
        b=UpmVlEiRwGhE7LIumtWHmlNBi2F9MV7xuJXtVatu1XUosokrl8zePFKJtsqpVEVuMS
         kg5JreD87PTTgHzgdrgCYEy4nM6F9a/gD44/T3uArEMsS1olIpKwZVpZAnslzdAVgpeN
         GBC7TlD4wcEtmMhXkO0YfdaXmmhY3rl3rXK0mf6s6cTT0we725JCLmNWtusko76M8Lio
         ICRhAYeMEJTu/bD6PngvQSs1cYsDtgEBZ7orkR1ihFRwXjVqYoq+HTSz23C5G56Iv8b/
         l8uyj/8OKAeAyOFQowuhiLr6aQ7XNi1YF6iEtXbjhWGMdOlDLAJE/f/FMsGMxbKmmJor
         DEuw==
X-Gm-Message-State: AFuF++lPIxoNO2RfexYAFdphSvpogWxAJc93wBcKutizFMkQaK0lX65M
	u1WckCyMoq+UQwu6lVgFqtt3pSfw8VgT3G7YlRGcid1KYaKLSwfagDLUfUgMkmIX
X-Gm-Gg: AYBFou0tnrh4ur1bSMnjaGRBEciJ40d6b6ZfFnSC89UJlx4QRnZflgWZHA+X8811cId
	aB1jg6d/CGyZmzUMhMPEEayxDT+hfc10ISyBzL91/p3TTw6EnDYW48f0OxbF6jqBF2vmT18nb+s
	9quI5kwakf8AaoespLTU7s2OlvjIWyBY7sbsvONRrDnIkrTwgpj/fSsBV9FF69ANDG/UfDDDNp3
	+3uXGiRMELMUVTwz+TugUCDwAq8z0yOzPB759Lq5e0q71GHQSdsCYfuaCiORkk2vGbxNYrPSezp
	ZQwk3NGBK/Cs/2bbqD0JsZ5NbsTT5OSn/a0TZuJkWN/POS0UtgTgsw4rikhZc9nEouDWmkR2mx+
	Nx8beJJaJ4ZC4jMZMYHxnAnK9C1kBm5Qd1ultOC2gIjd2vhGXiH1V0zTCMR9PG1jH+rZZFAfSx9
	v7D5B/Mr9UatFQFd0RgxWFTNIHxLuMNaHMPaXYxSddJ8Iu1Gt4Y9MPXr4TBlIWzbZ2LFV/PWUYr
	F8+AYuTd61sF7acPlec1ibrf2Nl6xjue5kGLEkaEezcXkMlmAUugTHKbdRKVbJxGHpDwB+AAYdp
	KTKHEblO1rx1zOqsEoWNMJ3x0kc7QwBg2SNxhg==
X-Received: by 2002:a05:600c:858f:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49fec98f039mr13147185e9.33.1790267202673;
        Thu, 24 Sep 2026 09:26:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm115999695e9.3.2026.09.24.09.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] File descriptor interface for BPF streams
Date: Thu, 24 Sep 2026 18:26:32 +0200
Message-ID: <20260924162641.1922423-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4644; i=memxor@gmail.com; h=from:subject; bh=A9T8tx2LGTgmjPowI7gr2kzUCsECwdxuLVr9w6ZVhVI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7+5ufYn1jE/DdFzqDvJvKtKa9rrptbnuAdaQGzoJz YyfrizoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESETjH8L3z5y3Czo22w1vSm RadZBY3/rIjcns0y2VJ/knAL68GVZYwMl91ntBkfuqudviK47FH/66avFp7VZS0TZ9ftKvlTHOH ABwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF program stdout and stderr streams can currently be consumed only
through BPF_PROG_STREAM_READ_BY_FD. This requires repeated bpf() calls and
provides no way to block for output or integrate with poll-based event
loops.

Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec descriptor
for a program stream. Reads block by default, with an option for
non-blocking mode. poll and epoll report readable data and report hangup
when the program is freed, while allowing buffered data to be drained
before EOF. Stream descriptors retain the stream storage without retaining
the program itself.

Expose the command through libbpf and switch bpftool tracelog to blocking
stream reads. bpftool falls back to BPF_PROG_STREAM_READ_BY_FD on older
kernels, where an unknown bpf() command returns EINVAL. The legacy command
remains supported.

The first patch fixes a pre-existing issue where empty stream writes
allocate elements that escape capacity accounting; the readiness tracking
added later relies on every element carrying data.

See commit logs for details.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260830093514.4105972-1-memxor@gmail.com

 * Fold the irq_work and readable-counter patches into the interface patch
   so no intermediate state wakes waiters directly or derives readiness
   from the capacity counter. (BPF CI)
 * Accept only BPF_F_STREAM_NONBLOCK; BPF_F_RDONLY is no longer accepted
   since the descriptor is always read-only.
 * Allocate streams only for programs loaded through BPF_PROG_LOAD, not for
   classic BPF filters, JIT subprograms or shim programs.
 * Add a patch that skips zero-length stream writes instead of allocating
   elements that bypass capacity accounting. (Emil, Sashiko)
 * Report EOF only when the stream was already dead before it was found
   empty, so data published right before program teardown is not lost.
   (Sashiko)
 * Document that POLLHUP follows program destruction, not the caller's own
   release, and that it may lag the final reference drop.
 * Drop the llseek operation so lseek fails with ESPIPE like other stream
   descriptors. (Emil)
 * Drop the unreachable length check in the file read path; the VFS caps
   read sizes below INT_MAX.
 * Let __bpf_prog_free() clean up after a failed stream allocation instead
   of freeing the streams twice, and drop redundant zeroing of the stream
   counters after kzalloc().
 * Explain why wakeups are always deferred through irq_work and drop the
   batching rationale. (Emil)
 * Skip irq_work_sync() at teardown for streams that never queued a
   notification; on PREEMPT_RT it waits for an RCU grace period that every
   program free, including cBPF filters, would otherwise pay. (Sashiko)
 * Qualify the POLLIN followed by EAGAIN claim to a single reader. (BPF CI)
 * Handle SIGINT, SIGHUP and SIGTERM in bpftool so a followed stream exits
   cleanly, and document the follow behavior. (Emil, BPF CI)
 * Drop bpftool's program reference once the stream is open so following
   ends with EOF when the program is unloaded, and restore the previous
   signal dispositions afterwards for batch mode. (Sashiko)
 * Report bpftool read errors on the fallback path as well.
 * Test lseek rejection and empty stream writes.
 * Retry the NMI test write on a later sample if the first attempt fails.
 * Drop Emil's Reviewed-by from the patches that changed.
 * Rebase on bpf-next.

Kumar Kartikeya Dwivedi (5):
  bpf: Skip zero-length stream writes
  bpf: Add file descriptor interface for program streams
  libbpf: Add bpf_prog_stream_open()
  bpftool: Read program streams through file descriptors
  selftests/bpf: Test program stream file descriptors

 include/linux/bpf.h                           |  14 +-
 include/uapi/linux/bpf.h                      |  39 ++
 kernel/bpf/core.c                             |   8 +-
 kernel/bpf/stream.c                           | 211 ++++++++-
 kernel/bpf/syscall.c                          |  29 ++
 .../bpftool/Documentation/bpftool-prog.rst    |   5 +
 tools/bpf/bpftool/prog.c                      |  62 ++-
 tools/include/uapi/linux/bpf.h                |  39 ++
 tools/lib/bpf/bpf.c                           |  19 +
 tools/lib/bpf/bpf.h                           |  24 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 415 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  20 +
 13 files changed, 853 insertions(+), 33 deletions(-)


base-commit: 740eb74b8d2e3b7850e55b15257c8c0b0fc4a125
-- 
2.53.0

