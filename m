Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE353921DE
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121989; cv=none; b=KLbd+ppUAyQU+8j4akECJkIJ5mOlFy9Suh6nd8zjoPNP2dvgYLlUSPCrUOthEIqTXy03yLioPRfck9SQbENDEF9ZgmMjcKf3jfZxI+PL+FyeSy7zNP7YFOFv4wF/SLC+s1B9Eqazq95eWEFn0yDxVRYtcfCztSqoaoQaRnx55ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121989; c=relaxed/simple;
	bh=4ECgb/AfeI/g65ADzXXjhXc34kvosRuBpZwZRATvnTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcSiBC0PRZQGNU9QSlXAl6f2Z2VjjU5ZH3bsYIi02cEwFhUl+NjD35LVz0zM1hSBAqMf8uE+F89LuDgP+MzWNyK8slVFk3qufozTr7ck7rQFMSRLdLETLVUqz5hbTcPIP0EA1wvR+ZvpdXTZ2Tv7j433bXznPbCKOpFljK6vkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK7aYTF2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK7aYTF2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c238f1063so393745a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121982; x=1775726782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJn/mu9tI/GhEXXW9g1aC2S5Xq1EhBmi8P2sfsvCv7U=;
        b=PK7aYTF2nKbGhR80fVoxFVk22YR5yod0PSzWIb3AzHJgjIksMRbn02SaHf4aoIDKXi
         AOyBoWjEhaSFB3ynLqe+0EcAvJeW+GZgqx9M+yF3PC0c2G1tcEDr6QV1PvLNT2eygfsL
         O6lYgU6Uqn1fDjijkiup2AAVfB/qOry1PZ5WUWMilS6Fhj6AtX+4aZ2sijMC0NQLwmIT
         wWOyEn9Aawj3BQjq65DWW0epcftQsbhCv3t34WKIKC4YueVGBAH94JolYW6bXDYsNKc2
         PWf+f2H+QUcAc1SqmP64zRsDnNCBd3aSL64+DqFIo0DX6e2HuOHodcHXkkPXHuKvu69a
         K6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121982; x=1775726782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJn/mu9tI/GhEXXW9g1aC2S5Xq1EhBmi8P2sfsvCv7U=;
        b=XwElZlhLL6GHxwNmuM/lu1L8EpIgC2ncYxSXQ5VD1b5nidbUMUG0sLF3X+mMlfz241
         AinelZIQDbneaPBf2lnUomZzMJbzS/FHKqUspuT+dFkuSYb7SHziKGDacBAF/NXtwiMB
         p4NwySbeSF9CFpmDw9MEXOgvgDavbegLFT9FSiTphhtlDwSe8ieOQhgefDYDPQSXyxt4
         6vm4evl7J+o67n7+ooIyDVvz43VzdbL2kp3WrW+YPcdjI7EjwGM+T6vaac84DVgtmCaE
         I+5sTB3HExg2op/IFWK1yIN9V2Fig+ZQy20gtJO2vuDAZK46eqNaHfYQKeox3PVA2Ue8
         RgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn98S/5HTo54FAG3cHsFoKPhCEjK0xeAAZ9R1ydbQ4ooPxP0nc9PL1CRIkAfDyKhzq0XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWDIeCTYJR6ju3wS/0jyp+DXwh5bxiP7A2/20UlyxAvgfjAmY
	yqjuD1rWZ+8pVDaiRFBH8WZvCWo5avPR62zo+oBxSaeoOc1Q7UgX9dCZ
X-Gm-Gg: AeBDieuJa7c7vj1G8NJhzKBKbsK3M9c/lIpk2n1nFhmMSNGoqWFKznDODMAu05K90eT
	rzKvyCosvrCmNv8TdcddHdhJb5zRqNJkk1jWfvx5SQo4Bsy9ZtKslsfh2laZcmMsLidNRGha6yt
	6zGXI38F79m+X7gE65lQdlVbye+SY3FNpcP+KPoKYvuMp0HpesSB3j7MtRYnVX7r0KuaIxsVpgo
	3Eo3qSdI48CR1WxSV7rPpjb+ZYt/hfgnEzYzOVZm6plGgm1qDxLfqlGninFTiJrOHdjbDlgOUv8
	dKI0e/IbQQLt5ue6nnwo5YHhIqcTpzwD33wkh6S+mG2DEGuN8NNkRNr6KHyTusgVV8jM3xChtjX
	A9e9JCFVPiTTnabdesdnROyTavW8gljCjQKmU8JTt1Cdl83zCAdHgCaYVfVSa3TrPR7gy+hJjYh
	wJ8v2GReZdStsQoQrdJUAYz/Qm07acsXUj4IF9gIc6Og8U
X-Received: by 2002:a17:90a:c107:b0:35b:a656:a5fe with SMTP id 98e67ed59e1d1-35dc6e77dcemr6086211a91.3.1775121982115;
        Thu, 02 Apr 2026 02:26:22 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding for livepatched functions
Date: Thu,  2 Apr 2026 17:26:03 +0800
Message-ID: <20260402092607.96430-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Livepatching allows for rapid experimentation with new kernel features
without interrupting production workloads. However, static livepatches lack
the flexibility required to tune features based on task-specific attributes,
such as cgroup membership, which is critical in multi-tenant k8s
environments. Furthermore, hardcoding logic into a livepatch prevents
dynamic adjustments based on the runtime environment.

To address this, we propose a hybrid approach using BPF. Our production use
case involves:

1. Deploying a Livepatch function to serve as a stable BPF hook.

2. Utilizing bpf_override_return() to dynamically modify the return value
   of that hook based on the current task's context.

A significant challenge arises when atomic-replace is enabled. In this
mode, deploying a new livepatch changes the target function's address,
forcing a re-attachment of the BPF program. This re-attachment latency is
unacceptable in critical paths, such as those handling networking policies.

To solve this, we introduce a hybrid livepatch mode that allows specific
patches to remain non-replaceable, ensuring the function address remains
stable and the BPF program stays attached.

Furthermore, this mechanism provides a lower-maintenance alternative to
out-of-tree BPF hooks. Given the complexities of upstreaming custom BPF
hooks (e.g., [0], [1]), this hybrid mode allows for the maintenance of
stable, minimal hook points via livepatching with significantly reduced
maintenance burden.

Link: https://lwn.net/Articles/1054030/ [0]
Link: https://lwn.net/Articles/1043548/ [1]

Yafang Shao (4):
  trace: Simplify kprobe overridable function check
  trace: Allow kprobes to override livepatched functions
  livepatch: Add "replaceable" attribute to klp_patch
  livepatch: Implement livepatch hybrid mode

 include/linux/livepatch.h   |  2 ++
 kernel/livepatch/core.c     | 50 +++++++++++++++++++++++++++++++
 kernel/trace/Kconfig        | 14 +++++++++
 kernel/trace/bpf_trace.c    | 14 ++++++---
 kernel/trace/trace_kprobe.c | 49 ++++++++++++------------------
 kernel/trace/trace_probe.h  | 59 +++++++++++++++++++++++++++----------
 6 files changed, 139 insertions(+), 49 deletions(-)

-- 
2.47.3

