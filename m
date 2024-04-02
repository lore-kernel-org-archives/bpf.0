Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9F258AB2
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054787; cv=none; b=Ei/6HMGlUYRRMsH4Gr8LSmIvhoAZx47XCJY3hWFkdZnQd8Wyp6QzLoNMfnDBwASrFt9yVSLKb5nAIUrHMeEIHbl43hkXB6nopw8QTxW7c8QosOZLk4yAD+2yG0WAuAShXVof8rMkEkLFCJNQQY/VIYERt4fiP5lmUgVmYa54vP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054787; c=relaxed/simple;
	bh=a4x5CfomU36qJDm28YUJczEo/IKK9GxkHsyKpqEFbtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdjLNmdA1wSNNH8/f33Tlo9hwK7jEigpVWezE27LOLPmgEVuMDw8x7UrBMZvMb0nkmmAADwqMuvx1q9j9avKTrxXTF0CAtE5rN1UiG1yxC1ISLMXbH2ein39Y5F6ZYL604aRCIuwEtWpMBRplg9h7CfI8DiwEJ6c8ELfB2X9me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=amt/SM6Q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="amt/SM6Q"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466fc8fcccso629886666b.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712054783; x=1712659583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3HwOQm2QT2sV95LcMqWAOOKr4NlLIHjYeX2vrN7lg4c=;
        b=amt/SM6QFAmW9dB6Cv4PZARUaMhVffvwZs+roDbIDmshnLYJeJVKwxS0yXDUZeob9Y
         R/DpuBTqP8HkETdYNQo6YzT9AYsQWT3FT2gSr8cPhxiMGLdfYX4Uu16whKNoDd0D+FFi
         yxqt5NZ8FqKYX3s006D6RoDDvA+0TwdDUT573ZFkVKboV3PcpKt36tmHoYIKi9OcdCDQ
         wAz1BLX9NyGRM5hMg9ZgPg/zj0TOXUqJ7GQN9zxkdgth68HPpFeq4SL5/iZLGFdG4+dK
         3y9Ouq7QPHrIbSh6PySrmYlFRVgSdDVIECCC+yMfBZt6BVA6gVlJyQE8t7QOXwG3xXr3
         5S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054783; x=1712659583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HwOQm2QT2sV95LcMqWAOOKr4NlLIHjYeX2vrN7lg4c=;
        b=qiZ5VRwKr29W8Vue92JP3jV1Np4Xv9dUZvf3QfdP+E1jCQXjWEmkrQqt1yDBk+l3Ws
         /8WCDtbHgPz8+ha3gkTkkKQIEyiefnMzkNCS6VCUk8RsXXKgB2kCBeVlsP4m0uRde36y
         jc25+h1nQ/6B8QI1FvfnCt050srrSjTsfvCc9QDf2uHhOttQqCCQ4ujhlEqvwmuNCo33
         X5yNU4I0guck2y0VxaxMoCvWM5c+OnjJrJBwRfDhMTC2QnKT7CnwAhhmWHqhtgAluML2
         cLp8r58CF/dCRt/+dQH5VXw0kBHaU2ok46eUc3tGOXHk0G7brPnk2pRv/YLp/MR+/PXi
         GOhw==
X-Gm-Message-State: AOJu0YxptawTwVj879FsQB3Osd2yRzu+tNrNxFpktloq43wkLrI5P/9n
	zuM21yq9TNyAeG20NiBCR7xz4x02j0sCy8CIcIsslqglpK8+Qx3BTIIogSe+2KEW4nAIyD+eezg
	q
X-Google-Smtp-Source: AGHT+IEXTMyfRcLzPfwri3XrvvIXecjUm2Huax5dBU7LBSpiv1p4D8HJoK0+qYZYri/9VWGbgrOnTw==
X-Received: by 2002:a17:906:bcf7:b0:a4d:f927:f747 with SMTP id op23-20020a170906bcf700b00a4df927f747mr7174006ejb.4.1712054783029;
        Tue, 02 Apr 2024 03:46:23 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:17e])
        by smtp.gmail.com with ESMTPSA id zh11-20020a170906880b00b00a4e48e52ecbsm4129404ejb.198.2024.04.02.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:46:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	kernel-team@cloudflare.com,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com,
	syzbot+d4066896495db380182e@syzkaller.appspotmail.com,
	John Fastabend <john.fastabend@gmail.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf] bpf, sockmap: Prevent lock inversion deadlock in map delete elem
Date: Tue,  2 Apr 2024 12:46:21 +0200
Message-ID: <20240402104621.1050319-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller started using corpuses where a BPF tracing program deletes
elements from a sockmap/sockhash map. Because BPF tracing programs can be
invoked from any interrupt context, locks taken during a map_delete_elem
operation must be hardirq-safe. Otherwise a deadlock due to lock inversion
is possible, as reported by lockdep:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&host->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&host->lock);

Locks in sockmap are hardirq-unsafe by design. We expects elements to be
deleted from sockmap/sockhash only in task (normal) context with interrupts
enabled, or in softirq context.

Detect when map_delete_elem operation is invoked from a context which is
_not_ hardirq-unsafe, that is interrupts are disabled, and bail out with an
error.

Note that map updates are not affected by this issue. BPF verifier does not
allow updating sockmap/sockhash from a BPF tracing program today.

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Reported-by: syzbot+bc922f476bd65abbd466@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+d4066896495db380182e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4066896495db380182e
Closes: https://syzkaller.appspot.com/bug?extid=bc922f476bd65abbd466
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 net/core/sock_map.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..8598466a3805 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -411,6 +411,9 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	struct sock *sk;
 	int err = 0;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	spin_lock_bh(&stab->lock);
 	sk = *psk;
 	if (!sk_test || sk_test == sk)
@@ -933,6 +936,9 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
+	if (irqs_disabled())
+		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
+
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
-- 
2.44.0

