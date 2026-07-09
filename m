Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D08370D62
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565604; cv=none; b=nR7/LS1bS4QWMqyQQKhGDz9qhvnZbm9KMTl6D5/GYT52ccmJ4gU0Z1eiYNcXBMDjjViq1BtQy341ipFd54H+me/7lmRI/Pr728neGn7xZHDimWU2d2+YvQqoukjN1igRutjO6z4OhymGvowewovvxZe0a3e7URZk5Mch+2aYTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565604; c=relaxed/simple;
	bh=5pZ+YuyuM7Yjk+r19WhuLEs5UFb6GJ58XFUaujmihhM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bHDS/e0kzyCeQARCLnfp6D5oL95Hqh0Zua9nG/JBsA6fgaYPU2XF/UovnzyDbGwp8y5gxvI/RyjDQE9n15MYzCxHhiUIVmd3H8J/h+MFApmlYKAW28vPyrdTcNXkcV+hsv7zEpFEXFYRBjhG1C7j4P8Gp14KE8dvPDxoVZDZpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZiWwTSVw; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZiWwTSVw"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69848bef5c7so1146855a12.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 19:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783565600; x=1784170400; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGxX7t30+eOuWF7lBVPJq4zfidhv7pByizuoriYai6Y=;
        b=ZiWwTSVwxt7P4i+73qdCxJisA9PPCWkY+ca5yklVJDUbzC87Qusx+U94/JJhYWOCAP
         GnLh6dMvW991dkeJA9gFfjZyn4yZ91LMrjYMhX6rVDf2RtR0xMwmteaHnG/+gWVJ6Vj/
         UbRkNnokQXnSOm2VYPTTPkjU1bsg845gZ/da8CHy8zTvmNRFGEmwvatQisYylnDeK29G
         D56XFLCL/2ry90hvsnvxhseEW1JwOc8GniqSDByBk0neIgoOonWs4GK49jSQwe1YYjxJ
         kESkb6I2ET61JeI+BN/rTYWLH2dPFJrT+sAguk/1I/HoOPxAtvzUN4hHoVUj49xNKn27
         /8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783565600; x=1784170400;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGxX7t30+eOuWF7lBVPJq4zfidhv7pByizuoriYai6Y=;
        b=fCCJfjYcdKYi53XFwe8rwWD2kwc1WmpRBNZYOTSWXiXpmcgZU0RroYnY6H0dpHpe5c
         bEIPN6re4SbzNbqsN3QrO8rVM1F0jni1ovMHYtjwNkUIxj6HicY6hs2NZ1TuuJzZcz3W
         QRBPHoBuP/uUD0wsS9huhuhLrpwn24zlSO27q9aiFLEdODKloPD+FIQL+yh/5VNQN0w5
         aZmPFYCwuPAciu49t01No/gt3+lt4KsI3VAWRBI1Ry+vKORLKEFwF4KU2z2+3xocbY0a
         AU0fGjhqww2hVxSUflKIB5Bi/SUQ+/EujIek3ROrlbYnThsocgAUbreDeK86BwiGaE54
         STww==
X-Gm-Message-State: AOJu0YyDO6EhvXfiHliilmJVIqIBlblMZS+Oi3hI0ObkdnnduLG8cMvm
	xqb+x87R3jlOnjhH+FA8QJPieNXjXSx9NwRWz3Rt1Fd7Hpx9k2mOwgE2Bw7dqxLhClry8a7H6Jy
	oUQMja0VnFC4GZCVcyiDVoYwHNXOnIRHCou52OlG9olERNQ/uW3/4Sd8C3nSkQCc3gOXP7wDCt2
	mJBA+VVleGp1M72cUBUyKWuqxENDPy33jpVxvDI5jDPqzdbKv7js9zqAIM5GT3UvIc6+gLmQ==
X-Received: from edk3-n1.prod.google.com ([2002:a05:6402:4043:10b0:692:efc2:c022])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2b8a:b0:698:351c:97a4 with SMTP id 4fb4d7f45d1cf-69ab44614b6mr1959474a12.14.1783565600046;
 Wed, 08 Jul 2026 19:53:20 -0700 (PDT)
Date: Thu,  9 Jul 2026 02:53:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709025316.999913-1-mattbobrowski@google.com>
Subject: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, jannh@google.com, 
	Matt Bobrowski <mattbobrowski@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to recent commit 9b51a6155d14 ("bpf,fork: wipe ->bpf_storage
before bailouts that access it"), sk_clone() performs an initial
shallow copy of the socket field ->sk_bpf_storage via sock_copy() for
the cloned socket newsk.

If sk_clone() bails out early (e.g. if sk_filter_charge() fails) prior
to calling bpf_sk_storage_clone(), newsk->sk_bpf_storage still points
to the parent socket's BPF local storage. When newsk is subsequently
freed via sk_free(), the deallocation path (__sk_destruct() ->
bpf_sk_storage_free()) destroys the parent socket's BPF local storage,
leading to a use-after-free (UAF) on the parent socket.

Fix this by resetting newsk->sk_bpf_storage to NULL immediately after
sock_copy() in sk_clone(), and remove the now redundant initialization
from bpf_sk_storage_clone().

Cc: stable@vger.kernel.org
Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
Fixes: f12dd75959b0 ("bpf: net: Set sk_bpf_storage back to NULL for cloned sk")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 net/core/bpf_sk_storage.c | 2 --
 net/core/sock.c           | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index ecd659f79fd4..1d295a8769fa 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -158,8 +158,6 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
-	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
-
 	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 8a59bfaa8096..498a57f34f5b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2492,6 +2492,9 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 	sock_copy(newsk, sk);
 
 	newsk->sk_prot_creator = prot;
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
+#endif
 
 	/* SANITY */
 	if (likely(newsk->sk_net_refcnt)) {
-- 
2.55.0.795.g602f6c329a-goog

