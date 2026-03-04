Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AB378D86
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602657; cv=none; b=ut/12xPuTM/4uNqMFp811lTBc5LoxdC771nhHQrXWzNTB+GKTbKTlbbs9SVwEd4F+am8L1gUtgsSUpWCxA3UQu+2zAofhne1IPJHHTDrrisLt1cFJ7OY8cY81quZWbaCswbUJ8xUN+ClPbt1maLtKzsdm6owpwnbUOhVGwSjsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602657; c=relaxed/simple;
	bh=/uoLEWePp0ARLfd/KH35rK3IxnzFW8NVcj4sJHWD9mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzU1NL+KEYzOijPn7keWVED7iUGSECOILXYkJk6H4pjMOaR/4EHyjlU2AUx3hxar8f7PwrFXhydBfz3NAml846FiBGxJ3dmVHc2HEf4QvE//OYTIiLyK+ewKyB+HY5HG5nEL0TcFPsDOy34Ax4XpsA2zJCqK6fhiJvcIy3pmZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgANMFJf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgANMFJf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81df6a302b1so6976177b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 21:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772602656; x=1773207456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqzppm2nTsO1aV0gLTqfvQz1+uYtyuSrrfXq7ggJT8g=;
        b=RgANMFJfEiKJlEHAW4FCr1piwQdJep0AmiminBi5smacxavV5jpxB1l2p1GFZsM6A7
         262QYsEMR5JG67b7bKvUy9mLbw1W6ShejMBZNZWDSf2Y1SOJqpgNv8LOz10HhNyYJrJr
         0s6ipE00s6+HtCJ9EvTAjGIFW+ecALdNo6op3+sxRGH809fVmQDp6OOWWwTC2tCJ0MuE
         OixHcW4YkPbvebH81L8wihycZtmlYWo4b626T1+IZh2zT2krclC7PsC6uqHl4rYYCEMq
         T2N/M3Y+dZ6rg8UdQyKzF+kaG/LXRkouZiNlMeQB9ghOYKXoL3avTGxSCV9wmh2e8pP8
         iG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772602656; x=1773207456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqzppm2nTsO1aV0gLTqfvQz1+uYtyuSrrfXq7ggJT8g=;
        b=rFIRR0RocuVmniOqutCzSwhole/qt/MEsFvfEfLUpF3AirsaaGXJBzKbTaruSCnt/A
         WRWKkQhL1k59JA69DUFdGxZSj2kSLN/9oKyDSt5Q5d64YSfhG5m9y3RLtm+erdnV4zZ8
         FTgjCxKSJkLPjlresgtCC8kYWFdCZwiGpAnxddAwLAcpFEuecmUBhIrJKQvHj0X7omWt
         54cJ1/qZGFT3ygiq8DtX4+WSEULs85czzdJ7xgldQSeTl6xOOhrz/88uZzQ1kAH4yMW3
         yLDQeyVLKbE+2Q+dOnGIXSmoMHBGLxLVyAOzBY9/KMTKMVRA5wQrEQX9DaxlECSuWxBN
         N7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR32/xoEVVKR94CNw1T1JOcYElkckB9T1icgpxmV1PTtq2ic59BZdWpaDcleVrE+1t2ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqkOkOoomaEYjZCZ9PWUOr/nqeTalsTpDLPNILmbNhGMJmT0k
	dvXyparblsPza21LHA+YVmXJp1gw+lzHcJF/e7Zpuy3t8Lfj928AThem
X-Gm-Gg: ATEYQzwJKjT/Jj2p5hUVYOyCRSsKaGpIzQfsZm5+YNPeEhS5bcmho9P+vodMXGfxOF9
	fL5ghxwam8sOg1YkXoYAWEIyibhIU5koxzJ82e6IpaH2GZtjLNYjcBCvuaTe0jWN1ONA7Qyr9BH
	kw5ZLkyl53d6gDsGHfv1IbY1d5FdLIz1PBealJ3WJdw41GBe8czCiApywCvQbdW9d6BsyC6WvZq
	PofYoaFxpxVAI/97dnnLPx549Wdx5REs2jYjEgZAAtaw/qc5AlhYF8F09xzajVc6wx93ck516do
	ukPYOj0r8NNzltal28SpZH8o8mDqDnUp2KO1w1KaAuHwvlm2v+goxhEmBLkS59DZfnDr46ebIm8
	GNCZe6hpeZ1nM1ZxkCDG7c0hiUuMv27GT2ERsMIuBLwO9W9eThOsIE3XZ8EXHKFGHABWmPXjNDK
	ClNmcNC/Ii7N5WWGQWm7BVY/pWjLkKSNZg5ZVPmjsI2vxQnzJFQ86bbXP0fiiLFD6KBYg/a/GKU
	SA=
X-Received: by 2002:a05:6a00:3e16:b0:81f:3cac:38a1 with SMTP id d2e1a72fcca58-829729093fcmr852331b3a.6.1772602655946;
        Tue, 03 Mar 2026 21:37:35 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3ab8sm17496964b3a.27.2026.03.03.21.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:37:35 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update
Date: Wed,  4 Mar 2026 13:37:30 +0800
Message-ID: <20260304053730.557800-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_scx_dsq_new() reads dsq->seq via READ_ONCE() without holding
any lock, making dsq->seq a lock-free concurrently accessed variable.
However, dispatch_enqueue(), the sole writer of dsq->seq, uses a plain
increment without the matching WRITE_ONCE() on the write side:

    dsq->seq++;
    ^^^^^^^^^^^
    plain write -- KCSAN data race

The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain write leaves
the pair incomplete and will trigger KCSAN warnings.

Fix by using WRITE_ONCE() for the write side of the update:

    WRITE_ONCE(dsq->seq, dsq->seq + 1);

This is consistent with bpf_iter_scx_dsq_new() and makes the
concurrent access annotation complete and KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 576a9b13eabf..49af85a697a5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1137,7 +1137,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	}
 
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
-	dsq->seq++;
+	WRITE_ONCE(dsq->seq, dsq->seq + 1);
 	p->scx.dsq_seq = dsq->seq;
 
 	dsq_mod_nr(dsq, 1);
-- 
2.43.0

