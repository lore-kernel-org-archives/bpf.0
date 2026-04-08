Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905923D88F7
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673365; cv=none; b=Nu4IkjwEXZ3k6WMuAmGXSVBtV05+B9wSbfMCrS3QYenoNsb5tJypyBBkON6Q+IGbRMRarE9K8Ar3wVSl3UUzGyEDN2Z2psCvB+kT7/inqq/1aetcBNgBVluQb6UfLDXnsyWPN/+UjaYGuMU/seX6XT5kLctJH6fYOMyOx1+lSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673365; c=relaxed/simple;
	bh=QkNqJWdiHPGsG4cNBuwXpj/Znwg2gcVxzViiz/Qan1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bw2OfDxqEAtUx9MsJ9Fs92VNogeKtRyoW9U6pmqyKzRl2iXJTXdALsS1PkOOspPzbq7Bk3wSJ6ziE48TMCerjlCjyghuID0oSG68+pUQBkKvZmroIkBgQvOAxMp3SUObqocBvrNT48Sdx6hgxggTmG8y13moqNRrASIBk6viHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqpKOGHQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqpKOGHQ"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82d03827316so31506b3a.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673363; x=1776278163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/ARlU+1nW3k8dDz7lLQIusgUbHwPm589AVKJkGX+KM=;
        b=EqpKOGHQuYnzSkLz6Ru1tayxL4jeciq6Qg7ffvDGuNckPdVYPv8vsWLrbZ0JAaMdvb
         Q1lIRpbTUUueVcbLwdib1S+k5dzKactMHsG1cM16hNvkksp4L0YayrX1/Fw5F8xeA9xC
         GAtC6yJaKRVLSWx+xclaCATZXATI9AaCpnoql9MMe2kgl0bWdD0v2FAZr3ouH+qIJBkj
         9NNgFSQe43SkHwv/hSS9U34jJCMG/oCc4uNB/F6gcuxnjI+77aoa+grYOQbs3qSWLnVg
         47G6G2gXudCH9wBKi62qTEy9y5yTH8xdZxXWP8iPuQW+7KFxd//uC+OIrAkagl6CZu9S
         pt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673363; x=1776278163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ARlU+1nW3k8dDz7lLQIusgUbHwPm589AVKJkGX+KM=;
        b=XxGDcSEfjsBH0n0g4rHtGBWiWmdiXbN/ZUP7nPEbcon7vIJsC60HXw/T0A2vJgx7nD
         422BHyJGJ3Z9ebUUUvq/g1j3EyUNEb62Hr2yCcxxz/x6thio8+QK8H10F+0KgNgMdWXi
         +vKAOfwK5CXoaLYF0zzeyKSstiPH5nXNI1Oh3+QvlEdIrgFcbZfYAsYYy5HL86ICmPEs
         ue120aQyfEg3AoEJxy/9DY5psir9awGiGr9Ch+CQFf0BKET7BG5WCsWAj+FHIBfJQYRJ
         db6hW3YgVsq8P3KcvFoXwViNIr5g1NLon/sgym0D9LKMS5kyr12faB6ltp8B8oZlTLp9
         ISoQ==
X-Gm-Message-State: AOJu0YwHRKLPxHl+1IBuDlw333grJuVHjvhUZWzBCv6QMwIMrORTwvNa
	WcW1/ztBgnLaaADO4m3xywph1m8HbVIlTH9mFK6y7I6+qN61Rda+2y1SPcouHfkM0Wo=
X-Gm-Gg: AeBDieucyeToqv7MWSeFRJuELgIBP9sURTEtTU6PG7rfXZ1AtYJUPFuOwwdPsWp0SGw
	Kz+OlkUPDyscUpdMWpvNGjI2GPlYHQoVhiyTQdgkeakLX2fka4DXDt0h0lyUPIemunF0jfM/7lH
	8q1PMbJJWZCKcCacEwBvQRMkvboT7NJhp19qWpXCbula4tkzZ6Z9c+yW26yFmgSYVOQDdZ7feQt
	WpJnVFd36oZFGncROX7swdvVRLIM0KkI3CcVUUQjxqxJKcrZopJf4Kd0s7/anU7FNRb8ootI9ot
	BThxn1dlM1Pf/tuiHwxvlwUYhw8aA8zCfTfXAT23puVrF/a94sFhSu0Fr4XyFoL5DbY5ZLQjfEw
	ybTdvcS8vF37kWOEiCiLXw6MN+Ftcv5cDqhdHd7M68jkNHYPusV8SD1nf0WNACKLI6h88WdG9N7
	QRbQfWoaU1h9/Pg88j+NN/PHH2HXfYoQHXXUuxKT6PuftevCBQpEGzLt0zBCN2UX7dK/qO
X-Received: by 2002:a05:6a00:230a:b0:81c:5bca:8104 with SMTP id d2e1a72fcca58-82dd8b3a2bfmr488089b3a.24.1775673362420;
        Wed, 08 Apr 2026 11:36:02 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm23113251b3a.11.2026.04.08.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:36:02 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/2] Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:05:47 +0530
Message-ID: <20260408183549.92990-1-varunrmallya@gmail.com>
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

Varun R Mallya (2):
  bpf: Reject sleepable kprobe_multi programs at attach time
  selftests/bpf: Add test to ensure kprobe_multi is not sleepable

 kernel/trace/bpf_trace.c                      |  4 +
 .../bpf/prog_tests/kprobe_multi_test.c        | 78 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 ++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

-- 
2.53.0

