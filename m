Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B13CB54D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312143; cv=none; b=sQLkM6EJrutcO2XNdLyyw86sf/fd15xQ9c8HxJWpJmSSdK2Qy4n4VWnMW8ndc7hNBIfAobEp5QRB5dnHK329RwsvGpvSbtkLI7UXfxqaVclSgM5KXLYXWaFbgTgw3dHaSZSXyPCn0P6jnEAaw7MIlTRof430YDETYMUTBpQ1imE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312143; c=relaxed/simple;
	bh=UTAwjI33y82Nyg8S74IbnqBQsRTTHk+BFrgB/a8875s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBx+dgZVhkA8u3L7ZUgDKZB9zbfdZh3YOxGgBWov3st9FvAfvfpfda9lyAua6ou3KVRC70ZBTUP0DZrux7gZmgTj5q5PqwO0o856Up5Tb0/aa/AsM1aZGzL/LWDuoKDbtBD2OoJ8INJWfRq0d3WhF9Jb7d4/YCoR1MoglwBDJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfleyCX6; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfleyCX6"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so1196675e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312139; x=1790916939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4kD3vrx+dH2vIaH8Mv2OVK/4Iwq/JzY5hqrTZfFTmk=;
        b=KfleyCX64KeGwgMe5OXZo+g3M7b17+yo7/IatNCC1so9Ygc/AX12VBOzLrDp74I6N3
         QJhCd0Hy3wEQOepa7MqSvKut2Sba+e1zJ7aJQTEFsQjzHwjPGwfqRR3BlCnuMSG5/iJd
         8F7g2f289jXXSddKPhLu0P5pYoDJxaRocnZD/lTXW+CsSeSDryxNm5zFXIHY64qxJnuB
         RX0am5QZl3eVAVVKT6TGAdX5m5nKz0KPFsdWmNufkPcKEy+LfwW1WSLjvsVcQjQ5mAmY
         1IQWNIa8qQrssCkhyv1AhrL8a/SKtSgg8WjnccY1al3XlGvOVz4LzdCn5QGEod9IO/eX
         P3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312139; x=1790916939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4kD3vrx+dH2vIaH8Mv2OVK/4Iwq/JzY5hqrTZfFTmk=;
        b=p6iaLsDIq2sD+1VqI2am3yQBvxmZtfZP771f5diAufkOUge7r/DTRGN+QxpQcbIYlu
         cbWLXEi6LqP7zpQzCg2Eug4q1wiUTVueTp1WyUyDfiY8b5dRixsRHnu7BXhEvXDw6GzF
         beiolzQ1/1Av2fvOlPFA0KEnje5DhEb+DoQ67l5ihboMDrNDiwhtu4KTjLqUOoUuyQlB
         oTTkCSDsSOKha3AwiQMfG7gZwgCwq+ATbxM4ElEU6jTTdVZDJeUGvcF3/LMAp57Q3NNR
         n3geCMn4L65J0Ql7gK0Y1+ExeleBqDzZzfCQDWBbRBwvfTrLbjfK8NON4EijL+7qDnMV
         umCw==
X-Gm-Message-State: AFuF++mVDE+zMHCIP2ZyGwMqJ9hXiegnyNFe7i8CwV9NjoU5xy1WJKcV
	bwcw/UgkjmdP72zU1R7In4v4msBXDyY2Wzm73qCsVtse0Zg7MQNsvNNBxqCUfc9Gg6w=
X-Gm-Gg: AYBFou0ANQjqUaI1PfLkl47FDIH1sYaSZrv4j7caU1q91qrhYKUGrhzNjInbOmkpDAO
	aMVH+LL2icNkarchPnt1HiDa6Y1navK2QAH/hy6c0BGDlIl+GS+ILxDXJBpRhy6GI/whPTpePXI
	aJrhW/hpUef6E41ujx7/SM3eyXGtF6Cpweo1U2+sfMWi60+N7zrPNuXV+aznErwjlsJpCk2r47M
	ZVbfhmRIhuV2MgFngRmzIKkkiOsaZxadJ/DvGL1jk8HS8oIPj1aXYhn/dNV8N/8U5ql2E+cXnLv
	zEabbzSnSd0lXfxnTPicnRpvf9QF3CEWC9mZlUjW2uen5rXXN7NhaOprbBv4v89H82RkZIjcfrE
	1iSmi/kAPrTJ63XGzHUesVEQC5YK4VIoGC+1dLY1v3ruoER48YwlCsHvLZFZwaRcQiMzsk1tsY0
	lYn8FFvWoLU74wGIcQmGBB8/bZJ08ryg3toKwL39cPp6kg54/aM5tVz1lKL1U6UVrFKPV0iq/YB
	LCbfw7M8Tohank+Uyei/1OUAc2G/ATX4Gp6KMa3wXp8ITEOF18TmWZqY/L38+ntX0j5blAPvF1h
	qugHzR8aAs52rPS8QMsELAW0NW2NRGPPCum7Qw==
X-Received: by 2002:a05:600c:4e49:b0:49f:cc2a:f73a with SMTP id 5b1f17b1804b1-49ff06ed754mr16225105e9.25.1790312139126;
        Thu, 24 Sep 2026 21:55:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5debbf4sm143032515e9.9.2026.09.24.21.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:55:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/5] File descriptor interface for BPF streams
Date: Fri, 25 Sep 2026 06:55:27 +0200
Message-ID: <20260925045536.1480933-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6000; i=memxor@gmail.com; h=from:subject; bh=UTAwjI33y82Nyg8S74IbnqBQsRTTHk+BFrgB/a8875s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvrvymWltVeRRNaP7I4GxyuN/qr08vEP23lNsMrYV9mr r/P2zW/o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABORXc7IcMqzLdLE9Pa5UNm0 tuqsXeWPqhqzs3/cuNJu0bP+fxTPFkaG/o/v5r8oS77GNWvRRO1uXofXKzd5t+xj31VSLWtVVP2 eDwA=
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
the program itself. Waiters are notified through irq_work only when a
publication turns an empty stream readable, as bpf_ringbuf does, so a
program whose stream nobody drains pays for a single notification.

Expose the command through libbpf and add a -w/--wait option to bpftool
prog tracelog that blocks for new output until the program is unloaded or
bpftool is interrupted. The default dump keeps using
BPF_PROG_STREAM_READ_BY_FD and exits once buffered output is drained, so
existing scripts behave the same on old and new kernels. The legacy
command remains supported.

The first patch fixes a pre-existing issue where empty stream writes
allocate elements that escape capacity accounting; the readiness tracking
added later relies on every element carrying data.

See commit logs for details.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260924162641.1922423-1-memxor@gmail.com

 * Queue the wakeup irq_work only when a publication turns an empty stream
   readable instead of on every write, as bpf_ringbuf does. (Alexei)
 * Make waiting for stream output opt-in through a new bpftool -w/--wait
   option; the default dump keeps using BPF_PROG_STREAM_READ_BY_FD and
   exits as before. (Alexei)
 * Exit from the bpftool signal handlers like the trace pipe command instead
   of checking a stop flag that a signal arriving before read() blocks would
   miss, and drop the disposition save and restore. (Alexei)
 * Fail bpftool --wait with a clear error on kernels without
   BPF_PROG_STREAM_OPEN instead of degrading into a dump.
 * Test that output published after a full drain notifies an edge-triggered
   epoll waiter.
 * Rebase on bpf-next.

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
  bpftool: Add option to wait for program stream output
  selftests/bpf: Test program stream file descriptors

 include/linux/bpf.h                           |  14 +-
 include/uapi/linux/bpf.h                      |  39 ++
 kernel/bpf/core.c                             |   8 +-
 kernel/bpf/stream.c                           | 220 +++++++-
 kernel/bpf/syscall.c                          |  29 ++
 .../bpftool/Documentation/bpftool-prog.rst    |  12 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/main.c                      |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/prog.c                      |  62 ++-
 tools/include/uapi/linux/bpf.h                |  39 ++
 tools/lib/bpf/bpf.c                           |  19 +
 tools/lib/bpf/bpf.h                           |  24 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 486 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  20 +
 16 files changed, 946 insertions(+), 37 deletions(-)


base-commit: 51455305b0d6ab5a3432e0d7858f4e73f397cc95
-- 
2.53.0

