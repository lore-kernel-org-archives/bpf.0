Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB496202F70
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082520; cv=none; b=Hhv7H3N2cLCNqxO/u7bCoOPpEzvZThQP1C00cWcNnZ8qN1u06Psb7H/pc7QJchNOoaukdKW+uKHnvQtWd+o8x4zX0NY3cQ4ykN9xMMqeioOwcuQVp9yuJ9ICiphPdf/Mvt9ri8qEu265Hrlyd9844NV+e+Fe5zjKIjhCJjE+k1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082520; c=relaxed/simple;
	bh=1BPt39aB66AguyA3cxl9Bz/gj2B6jbrbxU24xJ2wOxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKfM88lP52by9m2hEZ+LA97EyhLvvSReNNBhFIPTaeSrk7xJ6H5Cp4FnFaoMIRiW/n7nXeZ0HetiDMxAM4dKy90nwQ1CIG9k6aEoiR+/roSgCEMmqXtEUik8vM7OauqnBkJHaBLFtDYlBj2Gfp5sA9JzVAQXXOzmyBMLQfpURTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5RKvUux; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5RKvUux"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49add2a23e5so10569805e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082517; x=1788687317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n73Be3BAyIAAKxfGUctICNhgd/zH1g2FOAK9Khnda2o=;
        b=h5RKvUuxkmTixzoD/xCbUYGCX2gn1d52/HVMp+WpNk2eqeL7hfX24AkdyJgAMNxDlG
         K+uzCm2FM6HIuroZUUo/wwBzD2+jpPW00j7mu0oFEeUwD9NnoL1aTt/9L3Id/P57mb9u
         tQyQWVZlFDCS+CbD2ZETvmxu5JmRh5/gZfZWuDwQ28y6mOP6gF4X5RuC3PaLEElfiRlF
         i7u+WLtZ/NsGl8obVK8rSmVEXtPNcdQ4VtUGNmwnwbt919OcWpXLR5esKy5gixhjdWF2
         WNVJz9Du0uqwnJixhEzKpHcQ399MR637TVV427kLShJRa+JI3ieyZhupjObVZ5kUT67w
         1wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082517; x=1788687317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n73Be3BAyIAAKxfGUctICNhgd/zH1g2FOAK9Khnda2o=;
        b=OszZOfE0pi0WYgnm8RX4DVi442d1rNKsH3GUBzau7cGxmXv4wBB+SiBCu/YwPyp6DY
         nuWs4+P5jUp0A6C8m5vgb6ptCysY6UcoEQGVquIBzMtgd1M2wpG3r84JCWnWroDlzZdz
         7g/LHDqwITI6v+/9c1ilq7mCx84mLc9NvFYtSf5SPNheyMUSkfXzMqsVWDGbkLWQNi/S
         jTjcHFYqFdZrlEXYPHSzKvmhoubPSPUW9Y0gFGTd+YYZ2E6Vm1zUt88ZDq3b963Ta+j7
         FnewzKG+8q0E7cp9jxMkmKMu7SIjMSnIiTtrKa8YixVkH6VOUeggIvjX/5Y0RE0ptS/d
         /HXA==
X-Gm-Message-State: AFuF++kgvO2E/4F2tBlRw5EMkGS/qrCoyCCUtP/8K56/D5xI+/LGlZo3
	2CmlrcYkHiDfBDYmexS3mPWDpUNxqzFQ+9sx8X16WF343CE+Bp67B1zoyBl4YvsAyu0=
X-Gm-Gg: AR+sD10MSVp200IHKQC8wRlDSA0Nxpeu7R9xGFKjV9eLl63AaXDBS9PzrrQrZemRZbj
	ftRY3D+fOMJnVj+F4Sb+pAyR5CJTOyeya2jZnoRlAwP8KaOqpyhQ0gUM9i+dX3StRPeHdhfSC55
	q2YJFwUoAkNX+s67LClTiH3nEDuJFShfL9Gl7G8R+O6fs4SoS/CnwEP8/lYgKgzP7wjyGcdI5hy
	yC42H9ODoF8JCTfBuZGGErixrCs0XTZqNc0DplxzxUFBqVgDxVQrskQT3tMnMqG4LdyiV8C0QfN
	SQOYqksGfMb6so2Vu0CZB1WKHHLzj1wTlDImSQzZzE5ncdErGeCJb/4C+k1ImrWGdWggunnvOFi
	87svd469Z4nJAOKrxQc1Qsa213NsHURd8BexkfNK+CIxJnIx2AvDLm1qq7RRXn03XAV/ZdRpsFK
	8izx1QD7HJJ6dCipjTZ7vuuVhtEvJwmSpztN1+GpWlTwFEsug3vXObknd+XqlVJA+zDuH7rAPrt
	x4taTHOipTPCJGZK78aQmqwaIzVf+qmzrupQGJTMTVfELcKoMVnjGoIuxAaMgy5ozmi0DDEif6N
	h6Wc0v66OezeLr09yVbeSO6Gh9g=
X-Received: by 2002:a05:600c:19ca:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49ccee0f3cdmr87554285e9.16.1788082516735;
        Sun, 30 Aug 2026 02:35:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b945816f2sm232804875e9.8.2026.08.30.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/6] File descriptor interface for BPF streams
Date: Sun, 30 Aug 2026 11:35:05 +0200
Message-ID: <20260830093514.4105972-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=memxor@gmail.com; h=from:subject; bh=1BPt39aB66AguyA3cxl9Bz/gj2B6jbrbxU24xJ2wOxw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyx402Ww4GTQv5zGC5Slj17c5bkROtONJ/WOocOZ5du 665OL+so5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMR1WRk+FW8PIrj3+r9ya+m KKWHbtBpfrv4a8LTG2Inb4rO2L0p1omRoWtTcM7B2VN4DQQ4tr3jSknc4cNn1HD5/6XdH6/Our7 sAB8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF program stdout and stderr streams can currently be consumed only
through BPF_PROG_STREAM_READ_BY_FD. This requires repeated bpf() calls and
provides no way to block for output or integrate with poll-based event
loops.

Add BPF_PROG_STREAM_OPEN to return a read-only, close-on-exec descriptor
for a program stream. Reads block by default, with an option for
non-blocking mode. poll and epoll report readable data and report hangup
when the program is released, while allowing buffered data to be drained
before EOF. Stream descriptors retain the stream storage without retaining
the program itself.

Expose the command through libbpf and switch bpftool tracelog to blocking
stream reads. bpftool falls back to BPF_PROG_STREAM_READ_BY_FD on older
kernels, where an unknown bpf() command returns EINVAL. The legacy command
remains supported.

See commit logs for details.

Kumar Kartikeya Dwivedi (6):
  bpf: Add file descriptor interface for program streams
  bpf: Defer stream file notifications from NMI context
  bpf: Separate stream readiness from capacity accounting
  libbpf: Add bpf_prog_stream_open()
  bpftool: Read program streams through file descriptors
  selftests/bpf: Test program stream file descriptors

 include/linux/bpf.h                           |  13 +-
 include/uapi/linux/bpf.h                      |  36 ++
 kernel/bpf/core.c                             |  13 +-
 kernel/bpf/stream.c                           | 180 ++++++++-
 kernel/bpf/syscall.c                          |  27 ++
 tools/bpf/bpftool/prog.c                      |  29 +-
 tools/include/uapi/linux/bpf.h                |  36 ++
 tools/lib/bpf/bpf.c                           |  19 +
 tools/lib/bpf/bpf.h                           |  24 ++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 376 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    |  10 +
 12 files changed, 733 insertions(+), 31 deletions(-)


base-commit: fbc547151dbcd9b5eee54d6b29e924c760039638
-- 
2.53.0

