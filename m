Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F2282F38;
	Fri, 10 Apr 2026 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801504; cv=none; b=sPFLsb0suWhVsvRP6hSuqfJA4AliPqWaxsagHGBHQEtsQ2wqCINs42qgJmdBl45WU/BzAao/SkhmRg9+bn9dKi6VOzK6U4ufOlAhXbhAbYKQbR/WmyaYWZZTH6135jSruPNaH1jdsNopEWFl9cGm8izt5iqWjWWe9o9FfRJDjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801504; c=relaxed/simple;
	bh=SmZ7MFt0lU0hTb7QuryUOTa/eQxFajhgOeA4MBnaetk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9+0yIkphYQoWBwpBdFI9szXZQuNZ9Vbkifj8dw5DD04TMhI3VkoL2HDIo1OgOBoXtrV+Q+39KFEqHzK6lQV0+hK4ApheQX8Y7Vhm5MiJdW6H1wb0CCVyWFBCwJYL09ZMCLzf8KSpq2NT0Y+XRspoP4nX6vae45bHjEIWX/reuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FkPC1ha7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FkPC1ha7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=j1
	UJnhIO40iI9pDfTFXFTFqj1vxWq1Gu87ttIFITjJI=; b=FkPC1ha7O3x5Sst54d
	xQ7MzYA/TpSHuGgxtmKkru+U1s5jbevIyKN4CfZwOTcFStPxiT59ON993dtJ9ady
	6hYLjAeF67bZEX3087MBz2SEUHsavaqARuaMzfXfoGQcz4HGj/MPOL7AlBIELesQ
	ewRjmEyryJHdzNMvoS7nimAfM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn739elNhpd0HuZg--.6807S2;
	Fri, 10 Apr 2026 14:10:39 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Fri, 10 Apr 2026 14:10:35 +0800
Message-Id: <20260410061037.149532-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn739elNhpd0HuZg--.6807S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDZry5Kw48CF43KFW7Jwb_yoWfXFb_u3
	yFqa4FyrWxGFn8CFWakF4xGrWYya13KFyfAFnxta17ArsrXr4UKF4kXrn5XFW8Wr1fGrWa
	yF98Ca4ftr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjTmh3UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gDNRmnYlGB3mQAA3S

From: Feng Yang <yangfeng@kylinos.cn>

This patch set adds return value validation for fmod_ret
to prevent system crashes caused by incorrect return values.

Changes in v2:
- Add validation for fault injection and include selftests. Thanks, Jiri
  Olsa, Jiayuan Chen.
- Link to v1: https://lore.kernel.org/all/20260408094816.228322-1-yangfeng59949@163.com/


Feng Yang (2):
  bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret
    on security_task_alloc
  selftests/bpf: Add selftests for verifying return values of fmod_ret.

 kernel/bpf/verifier.c                         | 261 +++++++++++-------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_fmod_ret_return.c      |  60 ++++
 3 files changed, 229 insertions(+), 94 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_fmod_ret_return.c

-- 
2.43.0

