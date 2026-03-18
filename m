Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1E33123F
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873613; cv=none; b=etlk/LPPkNUDsSQYljGJgk9EACPw0JiqQZH1EhwfdLxwSbVV/aqfqEZ1T5qpf6xRbHs/rrRjEFZVhXYht+vrr3xjsHo5Xyao+VZ2rYjaFRAvw5eyOC8H2/SwwpOKIpfKZaVcZ4+kFfankPewM9QAP5olIdtxp1hIZiVsO3OX7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873613; c=relaxed/simple;
	bh=SyR6K48Kx4ry5LBUMZVt4P7PCF0EpPqAGfqi90dhSog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxEnLPT6YIf3DEwoK32L6hIugJ7I9Qx+ftmGa0ztNbuAWiFMQK3dFodBULS4iPMCEz9IhdRnx4W9elG+cJNZ2ZNQGhtBfeAJD/eaXEiidmou7WE/TtJUKRFTbv6zII4BmdF5AXDXdJEJeDqnLgEmyoEkskWnLoJCZjbgL4YjGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm/0sm8K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm/0sm8K"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so677678a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873611; x=1774478411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2avT3ZSOWP8XaqlQ5jAF1i0oz6Ry0CVZl1ydx1EhzE=;
        b=Wm/0sm8K8OLmfGCMnQHh45zXO6LWlEU5aw54bA5oKT86iqWUDG/+amUfZ3nOIkeWuP
         BnQZLM8FV/3lxJ6dzLOvjB7XdD+bb6FdoxWtWrUsH9oVXLD+XzRSwTsVDaaBI7aj0yfL
         SKofjvzoJMmVLY+E7JWGcWXAgo6lKoeJjg3SYhbMWe8cIHqnDrWy3nDzg2y/48PtduXT
         HaGEXGtOfrtkANUFKgOnLU19F6xwaEQ9wD4oQRiUWeF57zGnCTxZb6VkxxzwnnRyazXG
         FKnpOItTlkmAqWP8tc/gZ6lC/lrqS9l5ErOzcqun6AzpObtpJLwthkbUvI6dXydVzAJh
         YKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873611; x=1774478411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2avT3ZSOWP8XaqlQ5jAF1i0oz6Ry0CVZl1ydx1EhzE=;
        b=VvW4/gOt3Qg+pUeTg6CokZeb5JNCsuxtPqRDhKVfJFqd1PVCRNCXi4tUELHiVb4f/u
         +g+NGrCCou8GXBD3PE2ClBgS5sw7RDgqMjh8l2ovE1BvClLN6GzOIwUpzNs+7BG9o7bz
         I1wsTCzgIa5FHEEWQ0RWCSqz9pRPYeFJPMCppCnq7eNjJWT3uWaAoGy1RG5qnT/wKlSM
         3Ep563YrkOgvFbCZJcP1HcYduE5HqaHiFeyVA9daujbWWvhHiivfDL1lLmbX/8N8nJ50
         o39/59/JNO37m9bvtl/dKNCxWLF3NZIF5dIgmueoLPPhMTb2laUGl2SidXjImTErBty2
         dhSQ==
X-Gm-Message-State: AOJu0YwnYk8nLHj3KZnIQpofNrGjafXa41UHNBmsZsDUta55gJRe+rnW
	o/kn0cP14tbV/R/2EfrJLcd+s3VQ6Xg6zyuqIdUkNF81dYxIv5zwB+wY6YK/vA==
X-Gm-Gg: ATEYQzyYJtFslR6s5C2Nj7IHLUjYiIQk586wsBfzIkJKzbPcXlUBJmFCHOvgS7fz17j
	JV7bhdeBLBI996SORdirR9eeQlyDWYwNLVMRY7v9n0eesdL7A24yTPqSEgow7zJEJTwCPz+T3PA
	XL0nhcWlvUgPLseoNaWxs6yq3LzyV4pzBaf+/FXg2vnk3TNS4vsR1r+a0uGG3OuPbESY2FnkJqi
	gFMOROOLV+SiUBeY64Ula5qd5fvWDU0KoyadtiO6nGEGas+t+CPY8FXA5HUzyFslVCpYiED/5lB
	mwQEX9NCnAEpFW041aHtSN1cqd7wFfD7sjn5Yng/UjUc6MnAZD5rEpyib/rKYmb0sdpnkkIhhvl
	a+77JaAcQNawJI5FXXmHQepR8B3U3+90kq1Chu6x8NDGQlq8PuuHphXnDdE2p+2lV8yFT7cJwNj
	vy0qdConU2JtSGwA==
X-Received: by 2002:a17:90b:3b4f:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35bc602891emr700717a91.8.1773873610737;
        Wed, 18 Mar 2026 15:40:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm624975a91.17.2026.03.18.15.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:40:10 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	paulmck@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/1] bpf: Do not allow deleting local storage in NMI
Date: Wed, 18 Mar 2026 15:40:08 -0700
Message-ID: <20260318224008.602158-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, local storage may deadlock when deferring freeing selem or
local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
in NMI or reentrant. kfree_rcu() and call_rcu() have always been unsafe
in NMI. call_rcu_tasks_trace() only became unsafe when it switched to
call_srcu(). Since deleting selem in NMI is an unlikely use case,
partially mitigate it by returning error when calling from
bpf_xxx_storage_delete() helpers in NMI. The check is only added to
bpf_selem_unlink(), which is used by helpers and syscalls.
bpf_selem_unlink_nofail() is fine as it is called during map and owner
tear down that never run in NMI or reentrant.

The long-term solution requires _nolock versions of call_rcu. Another
possible solution is to defer the free through irq_work, but it would
grow the size of selem, which is non-ideal.

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 69bb2a7a71bc..cad17ca8552f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -393,6 +393,9 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	unsigned long flags;
 	int err;
 
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return 0;
-- 
2.52.0

