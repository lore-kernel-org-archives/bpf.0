Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E0288505
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510922; cv=none; b=kY5aPPjcgKsiNMblOf8yZmPWWx4EG1jeUx8gg5gST+m777+pGfZbbL9l43KL+wMETVRYJGcknJaCh3CQ7+oR47Lscc+vVt7a+XbNqdCSUGCNuPuPl3yl0KzeTNg25T2hjd3IY41ndeZeY400WH4wctYMEvRu1+Vd909jfCU6l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510922; c=relaxed/simple;
	bh=AwdGNDHK4sE6S0LTqGxSFi9rN4HSnfvPmIEOOp1ZtHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cc7u0+7GOYokm1Fi19VTFkiNZil2E8nNtHq3tGiZ7xI4SlrUYOEAtUVKrZX5sX3sqa3ObUOF/K82zUQ5dxJIJCwY8R17f5loX857CLafz4qhiDT0CzT216sK3l8J7tBeY2XZq2+mnLhT6OGXcEUYUEBxHRyBClAtykTzA4ynB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=D2u1MGdd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="D2u1MGdd"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so807856a91.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1786510919; x=1787115719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=waGO7W7vIGNoZfGpyZ1AmQiCYt6p+ShqYaoREcQ4Cqo=;
        b=D2u1MGddSayVhGLR1xqJ+rYjugRbwwIWhFkmu9aaorQ/YuSvGbtRd+DEx3GcRjNbVH
         TsWC1/O3Oib47C2EYcM7st0Z3usuk/Qh4RaerdKO5WejcEA7jY9fvu4NGYfNrRd7wJur
         cGDo8ifQPV612fJmSWEsTtT8uH1iWowVz2jj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786510919; x=1787115719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=waGO7W7vIGNoZfGpyZ1AmQiCYt6p+ShqYaoREcQ4Cqo=;
        b=bysoWN3dOaATzwHM0GR9Yl9RR9NyOzv2eXnEW47Xm3X4lnF7fT4cTKHZ7nV5shxQNJ
         /pBwRAzxJXD49ZTJijgVZk1Zw5i47YKd2Wc63528NdoMoiKAUXn/i4X0cz7GuulGoTcq
         dtcecBwhhn/Kj5Cecnxz2AyTEebtBYOHvD1zlAcHfgeERrTTRGX5GtvX6yK7OiAJRFDC
         jBMQc1V5+9QE/wnvewRC1GSiroQM4eWhX2W8GTljENNknLx4+hOAyMAEyIV3qYuBmgM4
         kOJ8jQs+rDzn4bmZ/w6Y95oQJ/9EXbVXA9inD3o+rguU4WoXe13WajRfvyQjvUzL7aNP
         TO8A==
X-Gm-Message-State: AOJu0YwTTBUiv9RFlsscCqjjmJW0vENlrQ4bq6eYxplqrjNOa9iDA4gf
	3gh7z+Ta4OveOX3vDqOQe5jMxJzLSJCHqeei+dmhy85mJVBX5D1OpswUsMm+3zgkthcO/wCQ5Au
	Nnp5xxwAItQ==
X-Gm-Gg: AR+sD12WZ13rfTw+Iwootm+CKr73CeJ0WMD6eWL6nXP+Kj4G5uKv9sZ7EDPkPOYQK7B
	AndKYmtWvjpqHCgCg/ZLkjW6eTDXrUCuVoXCpxGSW0g57WldMwQnVdVqg3izSEhW/0etbGf7wqo
	MgumBYxI6e7LaX1ZOg21r+M5JfCOxe8LUOCJgpKAbP5TOnp9jE4I3n5SBtAuA6PXNEfmff4N4aB
	io8fUGYnoUeq51pg3RWZBfifynHLNiC2Q2K5FysIbNHCZhCU9rryX897lvkLfj3l2TvRXf93fbJ
	Yckkh8PiTo6O9XPVCixthqebnWzENIkjcexJaOCSeKnagYH1yVNtFfzkL3fs0EJE2l4Kg5zN+h3
	nfdv0iQRgLbCC14ZWbv6tJV9oARL/1Cw+nWmjAlApcyurI+7wpU3TpULoSanHpqDlaMawHMgZh2
	ncg6HQR7QYhIS/qvd2Yvsjcghoi27X3279nzyEOQo5IulV0xTeGv7HqdQTuMfUdA056IxoXQ==
X-Received: by 2002:a17:90b:4a89:b0:381:26f:8f05 with SMTP id 98e67ed59e1d1-393011de88fmr2675133a91.3.1786510918649;
        Tue, 11 Aug 2026 22:01:58 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8893709sm2053403a91.4.2026.08.11.22.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:01:58 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	rhkrqnwk98@gmail.com
Subject: BUG: bpf: task hung in tcx_link_release
Date: Wed, 12 Aug 2026 14:01:38 +0900
Message-ID: <20260812050138.812504-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following hung task was found by a custom fuzzer developed
by Sechang Lim <rhkrqnwk98@gmail.com>:

  INFO: task syz.0.604:4415 blocked for more than 123 seconds.

Unfortunately, we haven't found a reproducer for the hang yet. We'll
inform you if we have any update on the hang.

Detailed crash information is attached below.

Thanks,
Kenneth Lee

---
- Kernel version:
7.1.0-rc6

- Crash Report:
INFO: task syz.0.604:4415 blocked for more than 123 seconds.
      Not tainted 7.1.0-rc6-dirty #34
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.604       state:D stack:27816 pid:4415  tgid:4415  ppid:2655   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x1f31/0x2e80 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x167/0x360 kernel/sched/core.c:7283
 schedule_preempt_disabled+0x15/0x30 kernel/sched/core.c:7340
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x60a/0x1380 kernel/locking/mutex.c:820
 tcx_link_release+0x6e/0x4b0 kernel/bpf/tcx.c:177
 bpf_link_free+0xec/0x4a0 kernel/bpf/syscall.c:3273
 bpf_link_put_direct kernel/bpf/syscall.c:3326 [inline]
 bpf_link_release+0x7d/0x90 kernel/bpf/syscall.c:3333
 __fput+0x454/0xa70 fs/file_table.c:510
 task_work_run+0x197/0x210 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x10f/0x550 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x306/0x480 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x551c0d
RSP: 002b:00007ffec2926448 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00000000007d7da0 RCX: 0000000000551c0d
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00000000007d7da0 R08: 0000000000000009 R09: 0000000000000001
R10: 00000000003fd15c R11: 0000000000000246 R12: 000000000002e6bb
R13: ffffffffffffffff R14: 00000000007d5fa0 R15: 00000000007d5fac
 </TASK>
INFO: task syz.0.604:4415 is blocked on a mutex likely owned by task kworker/u8:42:1561.
task:kworker/u8:42   state:R  running task     stack:27016 pid:1561  tgid:1561  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
