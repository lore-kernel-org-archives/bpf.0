Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F71220F49
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872462; cv=none; b=WKzsGgABpJYNCKG6FdeeBEt2fcj244qhxyOHV8PIPK96zFyZ1KSZRRz3qsKB92r1abfztd0TxiHXKkcBjG511gL14TIkYDNHsDcua3/wqj5Jgc6v8fj0KKp/DfBTrddKpijIveOUN5FqyC4EGC9qjWsXkmV7byZAS0leQiQDOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872462; c=relaxed/simple;
	bh=y1rD/Xlz+H3Uk2xCBv6acb5+esgcxvfwhin9b/OMVpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVkMcdOZAhwxY4+shVDX4PlRex28kxEE1X7WwF2WUhvvwVjrTTXuGRNFy8d73KT1dHUNUn9ys9m9C+nsV6WHAShfgDipymr4xep8QCR0pJ2S+WeoSt6dhD7piVsOtjB/ho8UiT4evoK2btmGTStm/wr6RsPLfm7kWKqYssiFQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCxjHN9z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCxjHN9z"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296dabef74so2931122b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 18:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872460; x=1776477260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7aAGf7fMkZUFikXqLf4oYNOgRDcgvC7Fdq638y84n0=;
        b=KCxjHN9zPIxlmdnWGbYKW+Z3bVHOhaliJPLC2BQuzlY+j3RmTxBv0VsSdeUbEO3VBD
         wWbHy+kgseEGbP0GkNDEZesBi/nfYM5WzyOIFe6Pw8jMHuAHu0X6zc0EZAfI8VIbKU7d
         Sdx4Atd3binH4k5vYgF5qCUqFe5gMb1hghln22borSNffkGB1CQ4N4mysH5PwgGmcZEZ
         vw0T58pZ740O4d2hZbhPFrTVgTjcm7hXELsIwP4nbA+CN5mard9L9nNvVif9ddXh45+D
         jAWFYcZJNTManet8Z5+BrrhqSc1TgVpT36hqECQAniKKiowCfasqvznOVlzIsVMfOt/+
         MPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872460; x=1776477260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7aAGf7fMkZUFikXqLf4oYNOgRDcgvC7Fdq638y84n0=;
        b=UN6KXElYmRdcvuKC8ougzfgx5XY7zTst2Wl5RDGsiQNTruKmCJgSL2wBx5+0AuUeF7
         PEGoPy0//fjIgE4CHalZ5jYqDU0ZJuRncMo6K3MlQLEXGj7mQJg1yE98DUvd74/KxTMb
         XGF1DTttkqCV+56fm7yCu1LAqgtVck19w84oI0QVB9//te9FnIqBglN6U6R5bTEacwc8
         FYTKf7T0Ptn7yKzwOxMkZRrNS25zvQuVduEio4nYsc2s/7nViRUcnnzv0NSe0ZjWvl9H
         uOIsMzK4iiiYajiSXr+7nr1ne/TUYGEgJm4Md10JBPjN2AdScy8BmX5z1CvfTPJQvHmC
         7r5w==
X-Gm-Message-State: AOJu0YyOH8ZKaz1exeh5EVWhMzvsztfF8D+nmGQQdrH6SAJtgvC0HCbj
	oXxbRE3ENT9wj/LthOutBUI3tHqnPCx6ul6Z4+CLXiWt0RXq/TDSoLXJQnsARA==
X-Gm-Gg: AeBDieumeAjNwUiHv/a32KAVOohIGVlk1wjZkftDI3Foobaztc7/8nA5UIJCiFIk8Xw
	MGOoaKLhD1BmfuhuVT/Nk5+g5km8yTo1mG4OQzWn8s6i2/hW7mZLiDJNoqzGAsXIjrPGyfvt6R2
	eI8/JwrnRuME96UbT46aSbcOBd0Yk2XV1LACvKKtw9yq4FAB0VuvXEy13+lJ336ogsIBx5qrPs+
	MsMnURCabUILL64H8nOMYjS7MpLuaJ4SkaUHsK9SX0En0qTbQclK8WfWAaM9ZWdmk4kPjY/2DSc
	pDTd/u/Mz6R3e079ujBzLQkwhQpY7sXMFh6EPNTOMjzLDNB7yTUdvyAS+p7DhU+dUyNxWOloSKC
	Gveg/fuAERJW0Fi0jmUZAssrE+a69AW7/ysgfePI2eSA3PhUiiL1L0teB/BvuAdULyBSPgiFcOS
	xWZSjo2afViVRXTQ==
X-Received: by 2002:a05:6a00:3907:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82f0c29fed7mr5926596b3a.25.1775872460343;
        Fri, 10 Apr 2026 18:54:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4dd37asm4244318b3a.42.2026.04.10.18.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Use kmalloc_nolock() universally in BPF local storage 
Date: Fri, 10 Apr 2026 18:54:15 -0700
Message-ID: <20260411015419.114016-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Socket local storage did not convert to use kmalloc_nolock() since there
were observable performance degredation due to kfree_nolock() hitting the
slow path and the lack of kfree_rcu()-like batching freeing. Now that
these concern were addressed in slub, convert all remaining local storage
flavors to use kmalloc_nolock().

v1 -> v2:
  - Fix build (CI, Alexei)

Amery Hung (3):
  selftests/bpf: Remove kmalloc tracing from local storage create bench
  bpf: Use kmalloc_nolock() universally in local storage
  bpf: Remove gfp_flags plumbing from bpf_local_storage_update()

 include/linux/bpf_local_storage.h             |  15 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  11 +-
 kernel/bpf/bpf_inode_storage.c                |  11 +-
 kernel/bpf/bpf_local_storage.c                | 146 +++---------------
 kernel/bpf/bpf_task_storage.c                 |  11 +-
 kernel/bpf/verifier.c                         |  26 ----
 net/core/bpf_sk_storage.c                     |  23 ++-
 .../bpf/benchs/bench_local_storage_create.c   |  21 +--
 .../bpf/progs/bench_local_storage_create.c    |  11 --
 9 files changed, 57 insertions(+), 218 deletions(-)

-- 
2.52.0

