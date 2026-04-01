Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049891F3B8A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009800; cv=none; b=fniiXgYOI9pgGXByBauS8nCdmnM/pb6WdeoDENBbxqIyctTXusCHFrbXZxIXaHxflVrq2dIGZm79TP2KnmdgVkHP5fMEF8CIdXZ5Hmsler187IS0+BXpcor9LurQSLxW4yYIeCSiZ9becnG/jw7/cTjnukighCP+OIvH+SJRJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009800; c=relaxed/simple;
	bh=QOjvkpPnVdnNPqRn6t5aV8OfzKb8VmN3Sc9q1q3PMoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBhB9fR11dUxLvkCgVDqiBEehYh+JEvmE8v/momkRrNpVpSq+qCg1yIlBS3MEaiioO0+psM0L2HrYSgzDDmEJlwEN09DLwXD5eumrkfZfg0Hubjc00WdYL5CzQn1wYb3DKNZqjvmcjaBY4U1wTUrw3UIG/xs9JO0CnA21NbqQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6qGLzG6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6qGLzG6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82a67ce6969so4504285b3a.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009798; x=1775614598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6yh3YFRTa5fOoF0dNQ15cc8J+/d03d+MAZpaXTbClI=;
        b=d6qGLzG6h9N6gbTJanxKhxGDGs2HOVAOO61PaTkCEWfPK/bxpZEdbC0xV2Vo3G5D3Z
         Tv0A6KOJcmjmKs6a7asV1Gji/fGA2uiYj/smvVt0xkwuBkRfqqMeVBKDHjkuZTgh5XmG
         CSx36PzlRKOFeHBbTm5AEb3B4++RheO64NSTBhKkFRtdr1XoMR9z3tQEKkf3xKpCgOlm
         daCeV8MnnQtNNPCmlU+K/DxpT0TnDOS/DR2sOC4uXf6MgGBOmiPHuDw5Q2cbrgHzrKc7
         LFFfMRrgLUXds4lj61RzsNwOyneDlP52vyuyWGnJL9cOIeg9LVyazPdIi22F7f8xg/Cl
         K7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009798; x=1775614598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6yh3YFRTa5fOoF0dNQ15cc8J+/d03d+MAZpaXTbClI=;
        b=sPJtqPUnxYMOe+NMZ+lJStC0nU3k2Uh6A77Tp1JdR5xuqaWlfT5UgaR0EeKUokoe+r
         AVrnweheT1m7jqx8k1ln0GK/Ps/RLCl+BaspFWlddLHn8wZb3YaU4OKE5LyL1sVzL3Xd
         jrztiqLX/F29LkpcvDoXhrIEZ8ZTkm3cGgXP8T6tCRdGkWVglLObTwv60HnMyaWNxd2d
         nY9OLxD9OhTXJje7aeH7RzFsVG7dguBpuOVdvO94puRzfJfBKka6e3QSS5YJiZUFsZiK
         CVgaNVILDsMZNX7bdU2yL1u2kvhrXV6Caetc+sZ/acgBnYGkJNfvTVhWXr9J9ArSzgz0
         5eJA==
X-Gm-Message-State: AOJu0Ywj5nNsD5N/Qc0mDWgA9dhzDvdiVe9isthDN963sJQc26m2PUiR
	e47Dp+SoA9799yUOlnPLBNr9V4GmdJ9eop+kYpyvZ09+uFC5XVM5mnSJ/zoIyA==
X-Gm-Gg: ATEYQzzQHjNHqdfUdPDKm7ntr362fyXLZwAlRbbCGW8dpyiYDk/NUzpBLShauc4QICV
	+wsj/MptySE7YZE3ZW9zxlECJ9GeiINkBMMZeTpEOSMrTHyyemiSZ84jB/8RDebdQ5HgIw/dlvK
	5rt4raMvKDbMlBTPlPbtXw83wqpk2JacVzgi20X4At43qFFsQzkKNkW5wu+/A4sWJHJvYnNSBPU
	GimGOtZbEv6R8L+wMihVZq9b7Toa/f1EeoNiBIEV7Fn9a7O5VwIBkRH8ZifFhtqCVPk6QDRhZW5
	8wMLnge8Dedu1w96iR05wpt+Yj5gAX7oypmY49ShLHIr8VBUvqF3s3boRzDuT4Xz4o4p3vcjxEf
	eP1qjqlZmkNoQn82GgSqiJHBMyQyBfhbb74VleplCNIoMYmZxi5IwM75RdjNiGJnyso/uKdLj3b
	05rOZ4S2TKtqf4AcS42rSoZpjE9+kGTBLGE8qsW+0Bw4IoI0fNKzV0xxnkMMHzp+AZ2mVwjzCWz
	geAyQyiWsnK/if4quPn0tI4AxNfzawmbyxcMNZUP3HuksZ/pO41r0hhdtsMmA==
X-Received: by 2002:a05:6a00:3390:b0:82c:d8c4:35d with SMTP id d2e1a72fcca58-82ce88e013dmr1869516b3a.14.1775009797943;
        Tue, 31 Mar 2026 19:16:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d60c3sm10949907b3a.32.2026.03.31.19.16.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 0/6] bpf: Prep patches for static stack liveness.
Date: Tue, 31 Mar 2026 19:16:29 -0700
Message-ID: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

First 6 prep patches for static stack liveness.

. do src/dst_reg validation early and remove defensive checks

. sort subprog in topo order. We wanted to do this long ago
  to process global subprogs this way and in other cases.

. Add constant folding pass that computes map_ptr, subprog_idx,
  loads from readonly maps, and other constants that fit into 32-bit

. Use these constants to eliminate dead code. Replace predicted
  conditional branches with "jmp always". That reduces JIT prog size.

. Add two helpers that return access size from their arguments.

Alexei Starovoitov (6):
  bpf: Do register range validation early
  bpf: Sort subprogs in topological order after check_cfg()
  selftests/bpf: Add tests for subprog topological ordering
  bpf: Add compute_const_regs() and prune_dead_branches() passes
  bpf: Move verifier helpers to header
  bpf: Add helper and kfunc stack access size resolution

 include/linux/bpf_verifier.h                  |  61 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/const_fold.c                       | 385 ++++++++++++++++++
 kernel/bpf/verifier.c                         | 373 ++++++++++++++---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 .../bpf/progs/verifier_subprog_topo.c         | 226 ++++++++++
 7 files changed, 1000 insertions(+), 69 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

-- 
2.52.0

