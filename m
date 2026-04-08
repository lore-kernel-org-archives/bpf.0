Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992423D4134
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674934; cv=none; b=F+zN0JS8VnN6zTIdm6q1iHUyk/TIea5PRxOSIWdocozmw3dm9CtJbbkM54R7V5V8xYhHjKEfmg/l2NSWWzIpISjRid+S7qfNQz4nthkOkPZ6IfcBaqy7U94Uw2UsYr9ggM4RUVcRd2t9w5bJitqaAj2JMVq1+iNZW4rpXA0mHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674934; c=relaxed/simple;
	bh=1TRc0F+pxHZ7qBjE9nq3utn2aEfuFmKm3mLNbUw2pr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPE9gTLTIfYxosnpJ2mOnfkIoSFa1JOy/0O7HYNDzd7S3wXhZLP7tCNRyaTXAQpy18fhFDPM0EUhlabVNVrTDW+XuwsA3bPOZgdw6ZqCZDcaUN4gaqYyDLhk9iw7Ec3ZoXs8fwXvdBKvmheLD6sCY+b509TOlSq6biMey6DKbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXH7cr0J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXH7cr0J"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso132157a91.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674933; x=1776279733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nesqW8fDLklcjrRw63qDNiqcszXblDoKfTOnToW0Sg=;
        b=kXH7cr0J0qYWahH1YtFmpoHcxwPb1m6/aIYju/4B0AUIv0yIEDBGqawlfdOey6gUKZ
         5wN4EG6Zw9kSXTcbPJsw4iymyyafceTFf4+bCPcWREOrdmvOhdbusaGuIwh2Al6yCONb
         FHd4rCdt3XAMhWYMrxTf8Cjn8FCGf+hQvIa+4z2sl8LucXTJE8K6L0BkiRh9vD4Ub4sF
         NUVrzKpQoAgVqrU3xMKbU3kuE20fQHa59QRPz0OSylO/NbTgQM8PR84I1wxUlBon+NMX
         9ZYUxeMHF3WXoi4eAh+IiZvzFpE6xhsyA21pdEow9ft0PsbGSja01aoBmA3cyPwHiTo9
         UPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674933; x=1776279733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nesqW8fDLklcjrRw63qDNiqcszXblDoKfTOnToW0Sg=;
        b=kxep+FACBMxWJxfHFctQrmKlu1eUXaTn+62wiJNdZBimGLPV/+1HwjVpPDnecFUZoQ
         pLYuWNPLznt8NWVsU7jd3VTtuHQ2pwZlP6bwqyTp9ECYwBNuCPNuzwXzdne2tu0e1tf+
         GgI8ef25uNR4ln7JAEhvkaIBRaCKjFkYoorsMCv9EqSACx0Htaec7PChihn9eCEM76Ri
         NFFVJZd0++xrJKe651ZwynE4vYfRKP8CFj9UW5TFe3Rn1tRfJZEZPvpPy5PDdfoWrbHi
         0ccURvSF+c+k/aZmY1vZRWygqT9/TtR1FzHNy/th7jvnWBIIcrCJHiPGtdVuzLxDu+oG
         qSXA==
X-Gm-Message-State: AOJu0YyxzfkBBXM6Jx+2fIaq9sJ0mJp+ERDuvoMdrTE6Y10dW3tUz5NE
	g6W50YF6KOwyNhmSyG1HYChCNpk+LVvrOW/w0fb8P+NhgJRLnQajOZZN17aPYqawaB0=
X-Gm-Gg: AeBDiesQirq8bnod6cVi4U6sTptGWfSHJ6wKL2vXhnKoDod6mtHV6DzyhguN5oZZRE0
	SOXSGD7HY+eZuZJU0wt9rFKfME+as2iO5/4YdrZJ7PiJfmqwnv/selh9Ja7XoQp4l9Rnu0f5PFn
	lqxRFo6rgmfyxV1btF+w4/i8lSeJqSB6pEeAmejZ8sW6LW22Q5l9KUcsATKpiJa8CreiehlPInY
	IV23VvXohMo8UTDC7p2Q14nUmLnenwZWKHfQhtMK2RJwKhNH5VdVFuOZIr/rYcrSrIwDwkxrh8O
	nN/V/22VndEUa9tMj8/pwboa48qAwebgtEZKEgWp05hndCMOtnpqQMlQGzhHYugcoEYcBNnsoj5
	cCBY56+03NZeTw7nXZBxoGHJbn6Z6WkG6PPz8H8aubdzXtY0xJEFGv80PaJaYZP/2UfIiXYWL7t
	UydZRM+8RzjDk5BOoOdHRrvHItS9Rl81B93m+8cUfP7dVWkg4+A08XQpNsbfMuCuZKoQ5+jk1fS
	TuxjjU=
X-Received: by 2002:a17:90b:3811:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-35de68ebf53mr22776643a91.17.1775674932556;
        Wed, 08 Apr 2026 12:02:12 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34d0d9efsm143630a91.8.2026.04.08.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:02:12 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	leon.hwang@linux.dev,
	memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v5 0/2] Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:31:35 +0530
Message-ID: <20260408190137.101418-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix an issue where sleepable kprobe_multi programs
were allowed to attach, leading to "sleeping function called from invalid
context" splats.

Because kprobe.multi programs run in atomic/RCU context, they cannot
sleep. However, `bpf_kprobe_multi_link_attach()` previously lacked
validation for the `prog->sleepable` flag. This allowed sleepable
helpers, such as `bpf_copy_from_user()`, to be invoked from an invalid
non-sleepable context.

This series addresses the issue by:
1. Rejecting sleepable kprobe_multi programs early in
   `bpf_kprobe_multi_link_attach()` by returning -EINVAL.
2. Adding selftests to explicitly verify that attaching a sleepable
   kprobe_multi program is rejected by the kernel.

P.S: The first of these two commits has been applied to the bpf tree.

Changes:
v1->v2:
- v1: https://lore.kernel.org/bpf/20260401134921.362148-1-varunrmallya@gmail.com/
- Defective selftest added
v2->v3:
- v2: https://lore.kernel.org/bpf/CAP01T74YgnKop-dgwBToOcfg4_D44t1wUBopFYPMquirCmaLfg@mail.gmail.com/
- Selftest separated from change into different commit.
v3->v4:
- v3: https://lore.kernel.org/bpf/20260401191126.440683-1-varunrmallya@gmail.com/
- Selftest moved to test_attach_api_fails.
- Changed attachment symbol to bpf_fentry_test1 for stability.
- Changes suggested by Leon implemented.
v4->v5:
- v4: https://lore.kernel.org/bpf/20260408183549.92990-1-varunrmallya@gmail.com/
- fix the mistake of leaving test_attach_multi_sleepable after changing
  location.

Varun R Mallya (2):
  bpf: Reject sleepable kprobe_multi programs at attach time
  selftests/bpf: Add test to ensure kprobe_multi is not sleepable

 kernel/trace/bpf_trace.c                      |  4 +++
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 +++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

-- 
2.53.0

