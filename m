Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500244;
	b=VRIGvdyfpO8Xg96ZLAdjZAdjTc7rZE+AqxavNI3Vb5InjImCyaQEkbnUxUXIsKM98LAT
	 J/FwHgX9yRBJg9Re4L0mSeph2jfp5ZDUtjYqeUlWqShUHdISs+CcNqkoyV2VUCnecMOJ+
	 77FYUyvfDYKY0wPVkMLuzXhOZ1jqWBWFwug8kp06N+Cm2SqiE9j/kiWpqctVowXhOaxlI
	 KsTKsx1vwSV07tUzi3fxUccTKAx2UH2QpciM2hph6gMyaz4aXG6zb76TSCpRWouPv0BeF
	 TrgEG8o8Hz2n4k0xINgcz/a3sc8E9/nExpQIMcIjJaMhDwrjtgXo/7i8795J/HElSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CZLbDNzMabVN7KHk/I04b5Jq/BM2bGCSumT8JlDjLdw=;
	b=pXJLsvD3q+wG4z0lH2emD6ONWACL3mF92L5wgZW475axk0zitMwNkDgnxLzGWr9Fdz6R
	 khB1c6aCrEAoSkU9PZp6Sf0btSqCZ9e8ec9vhe6qk8hqG8ZaTix61Nedz7qPa/fjMeCDh
	 WoYBLdP/GvmKZ552cao9wSXGBC9mas5bdw4Nu7zOb0gbDUyIUdq9eI7B+Ep7mJyh9Lglw
	 KJncotAQ+GeWwecw5t+qjxkYENiYQQgW0ky+wO/abEobk5xmDPWKkZtiK/LITGue/D6WA
	 XQGzP/M4RFsPyxDpHbhCciXD0lrY79xvpoloEWxYiSkw7bIsZdAi56KOmIcc38WieYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=JNuIkS6v;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9B606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD9B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=JNuIkS6v
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f04244c3d0so34109195ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795500243; x=1796105043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZLbDNzMabVN7KHk/I04b5Jq/BM2bGCSumT8JlDjLdw=;
        b=JNuIkS6vosJ+7+ggJ9Q6/px4Yo9nIt0bW9eCmWxTu/IwKa21CYO9X22ZAuOQtqranu
         qWThE9IWqjKY52jClYVufKCtkkBxtCtzadrrOaXfYNaoApGBn39kXBIxYYhKiKtAdQN/
         Y4WfFkr63keCa+tUGEHbG6sKwpzibRt3MksoNhUhEUAp6cRambFAeg6gWnpvhT13bP5c
         GSKfoVpxDXV8OvDNV6bOnYqRyNbCq0BuK0X2lE7AafXNreOgCL6DlM17z/jQtg0Vj0mE
         TQvyOYcPahrRm7QnLvgNEzjCGGzmMezehPlmd3J3q5AauJ6HDkY59dpXlYSSYorfSjY8
         io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500243; x=1796105043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZLbDNzMabVN7KHk/I04b5Jq/BM2bGCSumT8JlDjLdw=;
        b=QI1ZwsdOXMGXAaLs5GScTfAL0+WFASigVgQm7T4MudarN/NgFk+5YBlrQ+Kn5kldrt
         sPzpiNNBmJCUCMoMLCzGoLEPRy8JNGED5YVYjg9l5kT1sN3I/M1X/XAL5ZAdIBE+tzcJ
         M2Lk5mrwa/FI1ew+zKBO0DTgpHWkzxW1xH9X/86Usv7+ss50ndQ4kW9hFdw+6tu/58vn
         DuXt/qNDtkNO7zlbZcJ/w3TzvvzWC9CL9J2IIymnaZhRK0pb/P4bz0Nnbk9cwiE3I/qt
         /7MmQNOwEnO8zBdUTQKvyFkKfXwNM2jPi4MG6t2hEq1x0cQ7RN/6lltRtt16sVQZ8067
         kJOg==
X-Gm-Message-State: APuU4Z8GpFr22bxSCVo+4+I/PhL9MLRHA79dBQrMwewRc5f2yXtdkdEV
	V/Yk9+ulrlNpcDnaEVmOZWPhW1k20ApwMrMhEh1yX/vpdYn1SzFOJxsbgb6Ar/3b5owMLq4zw3Z
	SmjAkM3s=
X-Gm-Gg: AZFdTZfkdYz6E8gpGD/7/plH5IPaaVaJg4rGBneoiFsznhfEK2QUVMNa6vI51wAto4n
	SkjjkaEhGQytwLPxAIOiLeI7ivmBXoSZx5hYNzGhdHaRDr1DWgosdadUY6xiC6ENLYKefJNoQhP
	AZUa8BemOo5cnzlekfY/3ZT7EUmXPiISNqd1X6vyU0K/vrBRjyO58GyOl+o0TaWkfZTNod3ZIhC
	8J2JLS3W8bWtOE4srdeH/rTV4k43ZR4+uT0wkxgnJY4UPbPYuA2oe17ovKoYmpLG5IXPBEvbjnq
	4wr1aNWN53Pwy5/Iw+9oWB4gG12kG3zOPx1zbtmzvTmY5XV/VcuZKpxwIrq4XDG/J5r3mGHV7uA
	mA1pzwWdCbiNmVz0szUxpACuLu6cLPIAAN1RUgkW6FMWKSj2umE02Gwn1ebuhOIT+Fzx6EVyBxd
	Gujh9hoEzegfT4np3z4IYN1ok+OvqSGgBqWMluBjH/Sb+/U2ZU9Q5y1Qr+gLt7PhorrA71RdFrg
	PSnIykIhotmDI0pmARk1qShzG6qeuBuqqMI1y6xPR+nlToxcoCApJ6YDEpz6HEDFHIUlb+WifR0
	ttzWAac2pGoV0Mn5zImGJcGu3KsK49fcWHGmGwXk9Ap57VeJDwjWs6Fi+HpAvS7JWGcUdDR3SQ/
	3fFZYY2BmKZCqie6xyD91pN+BEcw=
X-Received: by 2002:a17:902:eccf:b0:2e9:77c0:c7ab with SMTP id d9443c01a7336-2f03f1277f8mr132813155ad.29.1795500243500;
        Mon, 23 Nov 2026 22:04:03 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm64215985ad.23.2026.11.23.22.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:04:03 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 0/4] bpf: Use kmalloc for local storage if possible
Date: Tue, 24 Nov 2026 06:03:53 +0000
Message-ID: <20261124060357.11700-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Local storage currently only goes through kmalloc_nolock() to allocate
new memory. This is needlessly restrictive, because the calling context
may allow for spinning on the zone lock, or even sleeping. Exclusively
using kmalloc_nolock() has the downside that the call may fail where a
different variant would succeed, e.g., under heavy contention on the
ZONE_NORMAL zone lock combined with high hugepage usage in the system
draining ZONE_DMA32 below the watermark where a ZONE_NORMAL allocation
can allocate from it. This scenario has been observed in production
environments.

Add more granular context checking during local storage allocation, and
do either a GFP_KERNEL kmalloc sleepable allocation, a GFP_NOWAIT
nonsleepable kmalloc allocation, or a kmalloc_nolock() allocation. This
requires plumbing the aux metadata of the program through the local
data allocation helpers, and inspecting at runtime the context's
preemption/nmi state along with the sleepability of the call.

The logic is effectively:

  if (aux && bpf_prog_can_sleep(aux->prog)) {
          ptr = kzalloc(size, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
  } else if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
             size <= KMALLOC_MAX_CACHE_SIZE) {
          ptr = kmalloc(size, GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_ZERO);
          if (!ptr)
                  ptr = kmalloc_nolock(size, __GFP_ZERO, NUMA_NO_NODE);
  } else {
          ptr = kmalloc_nolock(size, __GFP_ZERO, NUMA_NO_NODE);
  }

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (4):
  bpf: Add call for selecting kmalloc or kmalloc_nolock at call time
  bpf: Plumb local storage context
  bpf: Add sleepable local storage
  selftests/bpf: Test kmalloc variant selection for task storage

 include/linux/bpf.h                           |   8 ++
 include/linux/bpf_local_storage.h             |   3 +-
 kernel/bpf/bpf_cgrp_storage.c                 |   9 +-
 kernel/bpf/bpf_inode_storage.c                |   9 +-
 kernel/bpf/bpf_local_storage.c                |  53 ++++++--
 kernel/bpf/bpf_task_storage.c                 |   9 +-
 kernel/bpf/syscall.c                          |  27 +++-
 net/core/bpf_sk_storage.c                     |  17 ++-
 .../bpf/prog_tests/task_storage_sleepable.c   |  94 +++++++++++++
 .../bpf/progs/task_storage_sleepable.c        | 126 ++++++++++++++++++
 10 files changed, 319 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_storage_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_storage_sleepable.c

-- 
2.52.1

