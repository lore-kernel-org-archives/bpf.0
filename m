Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37137AA9E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756387; cv=none; b=G5tCPpxLCXdApbmqzcYBPjQbhbj5vBvNtBn0LmBt9ZnA/GVZ1OsnxQ2olDR+jLQx2D+dehgZBoEwIUqosEcsWCzmfBvFZjyjEGlJcT6s8aORmvnt2tBDfhm+hOOFPAlL5hVLU6qe8aPVdQZ3D5kd7UHo2ModdJNS+BuH5hzCpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756387; c=relaxed/simple;
	bh=XN6BU+NVfeOEmDLa5oq7IDpFLWCZu4p8gv5vLXIr/js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGvKgmyWtjsSr1E5Lz84Nj0RQGmpP95s8Kl0W6ZHVGmpnYAIRTaGY1OC3pMRCuJLL89koJteGN5YOdVIQ5pb5oPHFloqB07PT/BySaBG7qD4b3focxQaePCkQOWRfqFWsvlcO+0V+hciwsZ3u08oNQTNDHMdTsWaXC+Pc7zT/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaQZUaMw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaQZUaMw"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1985227a12.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756385; x=1786361185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lH0F3T54HTSbmzuGVWeeRMO3sDzo5N/5G6no4LNJnCc=;
        b=UaQZUaMwM04FLlJFydnmtJHUrZAYknmSz3ANxZoDFu0h6jqHgf1v9+sQxpmEfsoKKh
         Xw/Sfv4D4azDcmEzlaFbJvNqFeW7L4FSmAS+WP+uy4l+je9egfQho0uVBNhXmITzCUsJ
         Avd/mkU+YydTR3Yooj+RCO9vEKeVr/nWdFYQT/m/x7k4nh7Uvxu8WeWlpg2BNo8jBJh+
         ycSdtWpsYhjYsPhqJaB73RmOKBXBa44W2KUYFhAHdzYSIcc0sXn24Eh215jpsvfxHVaS
         W0FRBGh6/gKPb3vLhYYH75spQitWwwsxNAjEao+cqJQ19T2F6XpDp2MmZ0V9NOg+NDE3
         hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756385; x=1786361185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lH0F3T54HTSbmzuGVWeeRMO3sDzo5N/5G6no4LNJnCc=;
        b=pz7kBI7qACUZy3a6kv+uCbwWdjZMz8+s2lB6dIoropZwLN62pc7FFI72bbkc9xRmKz
         mfA21BaY5C4Z2Qw20w6JSyY3JflmQ6duEIKrAqEBPydiV4WKjrK2Z/ygv5Tutkmcb6nd
         umT4SHeB6OyT4SShJP4xN0bNa32PZB9bXR4ZVcZRxaCP2ZsmvqqqcU527NvD6sMNebXp
         dM+STSJ/7W/YWIQx+csAkXeUnm+cv/1No43rhfO1AB7mnBQqHWtCGlYRB9VA4GM38vyF
         jwjlrNvw58b7IzcUWxXl9aREj3mC/1AOnxLDLaonExugYQs2aPGndYfUel8GDg2u2jBb
         mfcw==
X-Gm-Message-State: AOJu0YxecnEXI4oZrkJw6SIR8fTUjNubSBpEuAiAOi8jdmz5iiP2HCBd
	I0druj63o2rfsrd8abzYgAphOfo/W+dBQzpiUjub6eUs/1mN6AX8hklKoKh21w==
X-Gm-Gg: AR+sD10OinF6YOZyr1Fsatq+tGRdnGPh9n0+4BqNhhIiAAs3NRwAo9/YteahjYBkvPX
	WQG/QUfT+JAxLCrTnd7JKuMRLD+LHQSQWLOB1xLDDSLeCohZw92o0GL2fE5jNEGUoNI35+hBCeu
	3qdriJLUTbeSnyRNb9UzJVnk++UCJTDXfsickDWHvxnlc3iqbf7o86VZDJK70pYUnjb1s0VIkKI
	cr/VIUNGk2ST/XvMc4Tf78ZVYVLP9Sj3i0w+cVnXpcpWescGykbXHdhNRUipo+sPm39/8vQOV6E
	Wl/tfs3hr8fjg6J5kS3t2zXmaZ3Ni7W30uSNrlEZ8h1AGQZV20uG2Lh14cYf8oGv1q6JyQw1Ioe
	8WpYUJG5ZcMsnAybRdtRR2AJzwkwlt+VQS9/gZjVQZH70r3SQUZ0TxqE8FD4c2oREdkV7tXVtS3
	QQABWzvxF78z/xS6HsgYO3Qn4k0SFgLqJPhbM1fSdtHHCooaunjIXdNhf/Q5ztzP9GbyT6pvHSu
	1IKc/YVGHmgApR7/YhfRwP7auB0QNv4wMy4sRA=
X-Received: by 2002:a05:6a00:428d:b0:848:498b:e0d4 with SMTP id d2e1a72fcca58-84ee493e79fmr8426993b3a.38.1785756385332;
        Mon, 03 Aug 2026 04:26:25 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2a8223sm3494930b3a.28.2026.08.03.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:26:24 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after final spin unlock
Date: Mon,  3 Aug 2026 04:26:07 -0700
Message-ID: <20260803112615.3362122-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a sleepable BPF program, a spin lock can provide the only RCU protection
for a kptr. The final spin unlock ends that protection, but the verifier
leaves the pointer valid. Another CPU can then free the object before the
pointer is used. A capability-limited runtime PoC triggered a
KASAN-confirmed task_struct use-after-free.

Patch 1 invalidates RCU-protected pointers only when an unlock leaves the
final RCU-protected context. Patch 2 adds a negative sleepable test and
positive controls for non-sleepable and explicit-RCU contexts.

Testing used fresh QEMU/KVM guests with KASAN enabled. The patched focused
test passed all three expected outcomes. The full task_kfunc test passed
all 39 subtests, and the selected RCU, refcount, and spin-lock group had no
failures.

---
v2:
  - Rebase onto bpf-next commit 60781269e26c.
  - Target bpf-next and split the fix from its selftests, as requested.
  - Add positive controls for RCU contexts that remain valid after unlock.

v1: https://lore.kernel.org/r/20260802231248.2781334-1-dingning04@gmail.com

Ning Ding (2):
  bpf: Invalidate RCU pointers after final spin unlock
  selftests/bpf: Test RCU pointer invalidation after spin unlock

 kernel/bpf/verifier.c                         |  5 ++
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
 .../selftests/bpf/progs/task_kfunc_common.h   | 12 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 24 ++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 48 +++++++++++++++++++
 5 files changed, 91 insertions(+)


base-commit: 60781269e26c786de2bb93fb1e697a5c32ccee48
-- 
2.43.0
