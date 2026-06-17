Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5C3D410D
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688986; cv=none; b=eBNKx8O68G97rSTvXl8K+A2gtXMcV1ys6kdlCmEHOROfAm2v7tMQNlqM5rl43+mSxOGbCEgdo1X3lUvGTBf6Vn/N5AiySTBnA/RVKxub2BDzR7xS5yQ55zvyi6edggDu5MHjT+OAYjUZiT5b1SQlViF4I+gq2zfCUp+1kGcAkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688986; c=relaxed/simple;
	bh=GWPzChxssxZOZZc16sSu79iLhuD8mO4BYO8UX0Bsfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLJDDEmkN0uix5TFmILOnvj1kHwZgjiJ/P1yIifAo/4j5PztdzRnGHUlFPNjU6tawg65pIfumlw82Oy/WccUtZDM2aGdl9ePA9TO0D/Ppl9bfTB+s898Y6K4DxlbE3EfL5oHIec+TBeX3z7E+ghLcWnOKSNQvdzO8DL0U2u8bS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQZXW6Qk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQZXW6Qk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84531988438so45273b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688983; x=1782293783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qntz5nm5yQBkXOVak+SMgSBWDeLqTSwFLoQFss37lnc=;
        b=HQZXW6QkEni9oUS2HrmMWKAVOqywvv4fc05+eN1VjACgPlPM+21udefw+vlzxwWadS
         JpZUeJH6GYNm2iI0ZxKZT8Z0H/mB6uYleZmNJZ8s1hubC5fQHkHFmXmJEqHA+5K7y0T1
         1XGxrRkV3XgaZ79DJDUmieBoLzw1tqwjaoS7E/ALD3bQVDbSQBu1Sl8ssu63TM9qcEo1
         H9NOJ6VUzNP4Vuz8E4QW35NnEkKpuJdK+aqLaUIIyXnElDYAR90r8DiONIf7cfVr63Yi
         tQVrgQa++6TJyEAzJg+LFh23XcTy0tkVFEvptdaI3g66v5bsudelKRFWcP0oYSW9LfvO
         YtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688983; x=1782293783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qntz5nm5yQBkXOVak+SMgSBWDeLqTSwFLoQFss37lnc=;
        b=bHifFWyaRx/MRSq41ZbfNjDTtAgD2NUEVoDJ01P7/EPC3sC9ohtU209mH9B5L4C4V8
         YlEf5bsIHwZ95lGeZ48Jmn2gGNnnlYmimznBeyF/vQ/cQxyC5wvZ8VMOPX6R4lv+ANxd
         XY1bSJcMWmeX+np+V7pbfnf5sVKz7xTh0iTsbY5xmjSN/YhD2s4w+6taQ8xaoQIeO/Jn
         ljctTHOQwtLAnpEaRUG2/xQS+DCau2mB0iedA0c95dFpfWsakHomc+48QyWCcxhjU1N+
         4FSNV8bq2nMk4tKYhAKG2C/bck3L1XcidC2BDz2NTIXdei0uG68ib7qot7zg47fpkwLg
         rtTQ==
X-Gm-Message-State: AOJu0YyiWUroZIRID7DQzYwZWY4ol4VoTxVcDY86wp8mlhtxLmC/H10i
	wGBsu/0xr/m82clt4OOJoenqX50WbeUl7MJLpjf3pTMAodCxMjBqEslQM/OJFh9Wt2M=
X-Gm-Gg: Acq92OHYukz0O8M/M+LsugqpqAYvcqAHDN51XGttTyMgbtSuvKPLknc0PyE4QZLUI8A
	eExTfVn7n/5k773NkaS1Yv52ekSsO7RVq/ZCGF4OKPUxgSHpWvXQ1WwvWD4gUoPuPLgzfr7cwf0
	ji4cqCPnQuZxONvBGDYKXH17IsxU1yJ+jkvSAusbB9cI9ez+LetO9qGYs/+Qh07oR5sHAyhR8wL
	yMIMZ921+HcjXnCA+WjxtbNeZZZqNwJIP9EA/aVPiLX2tGsG/mj0B/h/EgP0rvwBA6JnPNbcJTa
	NsqLj1rhHd8i5C8ULaz3SSB9c6dKgPTG4qhJ6VvYqY05+cNNztyqIQGAeT1l01LIAXRUutS7576
	WfFMidjAHGIqoCiZEixdvtQt8A+NBQqcQiUYKr4Ik/+CX8py4nxm3UO5JJCawLt+8HdXzLo/oJ+
	f+FjpETDJkjLP99DPOHNlzVlQ98Lhsf/G4FHsKxy8truENnnF3IiaM
X-Received: by 2002:a05:6a00:a809:b0:837:735b:826f with SMTP id d2e1a72fcca58-84526b9c3cfmr2072767b3a.32.1781688983521;
        Wed, 17 Jun 2026 02:36:23 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::206b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm15521653b3a.48.2026.06.17.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:36:23 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 0/2] Fix partial copy of non-linear test_run output
Date: Wed, 17 Jun 2026 17:35:55 +0800
Message-ID: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF_PROG_TEST_RUN returns non-linear output and userspace provides a
short data_out buffer, bpf_test_finish() can return -ENOSPC before copying
the packet prefix or updating data_size_out.

Fix this by deriving the linear copy length from the packet layout rather
than from the already-clamped copy_size. Add selftest coverage for both
non-linear skb and XDP frags paths.

Changes in v3:

* Keep the fix patch minimal by leaving the existing offset declaration
  unchanged.
* Drop unnecessary memset() calls from the new selftests.
* Keep the pass-through TC program and larger test packet for the skb
  case. pkt_v4 is too small once the short IPv4 input check is accounted
  for, and the existing packet-access program fails before reaching the
  partial copy-out path with such a short linear area.

Changes in v2:

* Fix the Fixes tag to point to the commit that introduced the shared
  non-linear copy-out logic.
* Drop skb-specific wording from the fix commit.
* Move the selftest from skb_load_bytes.c to prog_run_opts.c.
* Add XDP frags coverage in addition to non-linear skb coverage.

v2:
https://lore.kernel.org/bpf/20260616093103.471444-1-sun.jian.kdev@gmail.com/

v1:
https://lore.kernel.org/bpf/20260615073856.152479-1-sun.jian.kdev@gmail.com/

Tested with:
  ./test_progs -t prog_run_opts -v
  ./test_progs -t skb_load_bytes -v
  ./test_progs -t xdp_pull_data -v

Sun Jian (2):
  bpf: Fix partial copy of non-linear test_run output
  selftests/bpf: Cover partial copy of non-linear test_run output

 net/bpf/test_run.c                            |  8 +--
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 3 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.43.0

