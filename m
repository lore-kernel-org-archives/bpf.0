Received: from mail-oa2-f29.google.com (mail-oa2-f29.google.com [74.125.231.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97341A55D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586827; cv=none; b=NZMqBu7no3LejRICwUcPEyiVTDV6OJRET4zt57XZXM/nE3/2gpiLt2H+t5K/DzS9em0El1nl6McifAnKVyUkPYy225Pm1LDqnH8Cq/In2tP+au9zqfF9UEOeSJgruCbiqj6gje+ucUkpjQ6lnC+HsCruSoDNRXUBgfjKRCUS29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586827; c=relaxed/simple;
	bh=uHxoCue9yEjP+CuVjjBHAhEX25AFdNQf4CaDmpZCBSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bC1dVksvYowNQp/y3O50HgAE+a3TT3hv2yyofsq3w8aqKWBcNUBL9sobWFXAEvN+ay8XoBhyhv1mY6QZnRNpHXfpaDnxQ48P/aUA/cnbA2PBRxF6FQBN7VJvsX+yNUTs1I1B0qSZ2akEezId9s8WgtPWs+2Kek4VqIk40lZ5TEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6gCxMLx; arc=none smtp.client-ip=74.125.231.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6gCxMLx"
Received: by mail-oa2-f29.google.com with SMTP id 586e51a60fabf-466cc9b4b63so125468fac.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586813; x=1790191613; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nTKcbixeYZXxuqI3d8/9YP3Pagv0RfMTxMxDvyP9+m4=;
        b=d6gCxMLxWaZNw8uyT/153opXFG8dxn+UjM2YV6cuDsqX8RVvp9WlbZo+r3GjFsl89v
         qykH+IyXLWrMwRoCdcpdSimtWJKCGrbmgwGcvMxp0uGVt+ldxDw+Zr33NJUoe+/Wp5dw
         GpEY7+P7Xf82ovD423+0SM/5atWcWqlz93uGnGyynmR0lVlM/+quq86vpTL9p/QVgJP+
         s0mdyaQSq/Lo5Z+zlCZ4ru1smcTZva1TwCEk0Z4jhn74IF8xG+nhb8Sxh1feXU9GbjGJ
         GPKWj8EQeKyPS7Pm10ispUfzunD6U7meoFcnJXW46nYkuJFXyG0t0JFsmlh0NVCDmEOO
         6AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586813; x=1790191613;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nTKcbixeYZXxuqI3d8/9YP3Pagv0RfMTxMxDvyP9+m4=;
        b=F2/T14J+gt3khg1NeMLkuFqn43QGezNiqzteLvyyZ5CoWLPA2trDQtnClbOylKrLPZ
         vxIQ3NBJR6v76kgwyAKqbCvowsEeEFwLFdBB4B5/BrIbAJomOBCjX/xIhZbo8hoSLdwM
         4iRxvfDFGy/rBbEhkr0blHs76ZNIq3IkCNwHgld3HjYAD3udEEtoh+pwNMT7mV/Yuc0b
         6+mjiIn2jY31Rbt6DwHgzWtVxe8gxdyARuYlTMk+ngQULhUUGv4tHYPHkV8dt8BthtzJ
         i708milWUxhGaU9ZbJJv04UN54EpXMaCROOrItjUbyAdP6Ral5nLEtJMrb6ZMITQolo0
         l/ug==
X-Gm-Message-State: AFuF++kIbBGN8w6obWgy371X3TommpAit73mbx9DpMi83x8R+RGwyjjK
	ytmFP/Yx9WAM7qHR8cX/kDZo+D06a+Q9h925BMpQRe7Z9jA8YNWEE57F
X-Gm-Gg: AYBFou3KRg+Ajbmq8woNVSEThidKi0jsahUKGcyyFwZmAKzxfo9VmKB79lCKn8ZNqx3
	3fhpWoac7sQhQVbw4rYLYAa16NZtlUiAB6mo6wTSd3MpBkpyWj94XPvuQAwsnP6aP8eE7tYmyF3
	0IJ6p84SsqdHFyEtO8lq4POvnxMT1Jr+R7nnEsSEkq4g8vFybgQOi74d6KQe23di9qohI8yvvR4
	+lks0ur+RY+w0nwb5xvnhk5RZhCIoa/tz8dtY2GUpOhXF3xZlfIGDTJ8c+bBRnps4OE8Hk1kwN1
	BixkRA1jyq/87al1pvDbKmT1ZuPPeQl2AF8wHMQqFnnSBFisnBudOlooQKtwqt36KjTwmzLUWqX
	JxKpllcJ9APwF8uY/OCtTVoUbadN7GArWhuMXH0vxl/v2CQoAqQU7h5oaXcVOCrV6jII9yI9fkZ
	TZ9IZ/WGyzvFR6xwNcr9o5oYoDHtxTNHYizyR8AFqY+E4SkTHNV/VOO2Kbl5t3
X-Received: by 2002:a05:6820:618:b0:6c2:f818:332b with SMTP id 006d021491bc7-6c8fc1c070fmr521598eaf.4.1789586812696;
        Wed, 16 Sep 2026 12:26:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f727fe99sm670000eaf.12.2026.09.16.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:26:52 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v4 0/3] bpftool: Improve perf counter reporting
Date: Wed, 16 Sep 2026 12:26:39 -0700
Message-Id: <20260916-bpftool_cyles_per_run-v4-0-f2de02c480d5@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/tqmoC/4XOzYqDMBSG4VsJZ+0p+amJuup9lEHM8WQaaI0kj
 rQU733AzZRCmfUHz/c+oXCOXKATT8i8xhLTBJ04VgLoMkzfjHGEToCW2spGO/RzWFK69vS4cul
 nzn3+mbA1yraBvJHeQSVgzhzifXfP4OeAE98X+KoEXGJZUn7sh6va93/sVaFC50bnAxmStj7de
 BkOlG47uOo/pJX6E6JRoad6VMdhlMTtG2JekeYTYlCildzYYHRN5rVk27Zf5uJ7qk0BAAA=
X-Change-ID: 20260827-bpftool_cyles_per_run-93169fcb30b7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789586810; l=1652;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=uHxoCue9yEjP+CuVjjBHAhEX25AFdNQf4CaDmpZCBSo=;
 b=NCAbkH/jly24KK0c5hbGjHTikwXwgRGNO2eVA478O/umxgo3h7Ql+bkDt9XyOf7M8jpftGItK
 O382+xDrbV+BqAaNatPthJMb4FrPE2mc/mNA371tkmJfTfRfJd0fddj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

Accept valid perf snapshots whose counter is zero. Group selected metrics
per CPU so derived ratios cover the same scheduling intervals. Scale each
per-CPU counter before aggregation and report cycles per program run.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v4:
- Use enabled time to recognize valid zero-counter snapshots.
- Build and enable each CPU's complete perf event group in one pass.
- Keep run_cnt as the total count, drop run_cnt_valid.
- Link to v3: https://patch.msgid.link/20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com

Changes in v3:
- Keep the JSON value field raw. Add value_scaled and run_cnt_valid.
- Use the same CPU set for all metrics.
- Move snapshot state tracking to a separate patch.
- Link to v2: https://patch.msgid.link/20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com

Changes in v2:
- Scale all counters.
- Use an enum for metric indexes.
- Link to v1: https://patch.msgid.link/20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com

---
Mykyta Yatsenko (3):
      bpftool: Accept zero perf counter snapshots
      bpftool: Group profile events by CPU
      bpftool: Scale counters and report cycles per run

 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  11 +-
 tools/bpf/bpftool/prog.c                         | 209 ++++++++++++++---------
 tools/bpf/bpftool/skeleton/profiler.bpf.c        |  21 +--
 3 files changed, 148 insertions(+), 93 deletions(-)
---
base-commit: 847b984213626bee356d550dc1a8df12e683e50f
change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

