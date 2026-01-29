Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31014352C54
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708320; cv=none; b=eXYbGx3mS5xYw9BpoRNVGl0eJpbNK03VqtBpeUEzSTBhDyPV9c8MgBX4E1W/twT7BhEIIzW+ZVWc2ivKRXU4niiGxC0qolGjZ+TvellSQYgYmMw58q+QY0kig6OZe0/PJQE6qiIC6B19M9z04jMpcXXQvkYof6iFJDukDYuaHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708320; c=relaxed/simple;
	bh=OzZ/Rl4B16kIhwazdmOp9dGJEKcdsYxxRfGIgjqVK9w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GDj0clDh6+yfbY1S0ThhU4ODcbetYJKFPvXgWTWYiJCZOoifx/BtGS1qbTSmzQZSXw2wWb9FGhp8nu/rRn24Y8O5F/UO9Meh5plf2wUMIDD8gL+lbC3iJ1AdNex/OxC6779d0S27Bszpa0lnMAlDq/9hVGbWtv1QHRJOiJn4T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwH9Uc4y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwH9Uc4y"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso11599825e9.2
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 09:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769708317; x=1770313117; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDFuVqT148/zanMCN6lpxrvH1rX+53u697C8qndqvBs=;
        b=iwH9Uc4yvGNMGb8/MNFqPL6zmGj3tNTEbYg7mVIw5xKoQSzn62qasuei7Bdy3wbXCm
         NO+ToIJ1sDFUm+sbti0JpGojLZveiov0LFE24RO1ZJZ2F9vdRgGNioQzONXgXH7mQm++
         tp3k6EddZgAtreVI7Nkh68rukDtLlaNCVyb4/0hJRaEQ9lI4/gzJZPQcT1XzTYi4pMl9
         Lh8u56tLNjHrqbt0Z/2HbrLL4TNKEGSKy9aQS1/kK5Z4akImqnKnWK3emz8MQkUua/AK
         Dm9vNhVTRTFDEpb5qFJCWDl4qZ60dt52B6G3CzfnwVfQLrqhgtSLcDjdlPiLFUj4R4iD
         0tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708317; x=1770313117;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDFuVqT148/zanMCN6lpxrvH1rX+53u697C8qndqvBs=;
        b=Bd8Gxcp0MUqgPnc9YM04YaeM6Q+/wP3fWi4unS4/Uy7QP/dNTfND3klZxWNhX2Q5La
         aNaWl2oj1R2tb6PL+qfdnnKJY4cmskYTipWo9uyNsc+fgX6ioA7tBWLYx4rdeWLOGAaQ
         0lQDIDj48rkNWx1uubXenHDEGoXAmlvK8YO3ufulTDk8hNH5kiU9KKBLrsVvtAdHIgub
         9ldDIKEydCnxDW+pWwGPdAdGpJT123wnsAoj4iJmt2KAuzNe7tL1YIPfgi9x3Daxnm+/
         QBj7Z6Py69Y8B/PrmwVa1MfbCdUzvU0h+xJfO1pP8kenmrFlvcOlIVAlGbsvsibQ/YxY
         Yc3w==
X-Gm-Message-State: AOJu0YwcdKfJtJKZXEPzBKAO+m/wnmyz7WifqAGxcNWEEZd60C/bcGd6
	Yot3SRfuJQNlJdXWDHpe8FWsSjww+5PiYLKB+w23GpspkFHPQ2rCdgxh
X-Gm-Gg: AZuq6aJHrld1nNqsCXMcbYaCU6Ug5SApaVS7b0YmP3ss44bqTYhzBSFleYtfWqB/QqN
	0XGxtqEGycw9+aux7cQ73cmpYFs4BQn2wMwBbkqX8Jj23l0m8Orr/asWZG9BIrjiiPQ3tkkfl0r
	MR5KdzQ7hrhRZwsVIaR/Kgj6VaCtPrEGs2oyrs/ssYQQAu86np3AcwAHwz39FIu6XGOc6uEPMHm
	GYvsex5HajquZk7wYwvTp2FyT1FJ6ZHrx1fkOkuowd61iTpEuht9mpExh7L6+LO9SxvbutXnhoz
	ocCHVD6L1sz3WJST6jfgE7+P0bGOU2fYKaK9Kht+gDe0KDPNbWYh6Lx8z4oDS3uoY3DvZttscWg
	XSwLWv0elOC0jH7wJdXlyje0bhi3XGdoVTeQbkgwiblYbnYJa9WtwlbMAWACarW8ZY0vFIOQ=
X-Received: by 2002:a05:600c:190a:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-48069c1c208mr127775125e9.9.1769708317377;
        Thu, 29 Jan 2026 09:38:37 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:48a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dab0a3b2sm104675e9.11.2026.01.29.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:38:36 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Unify special map field validation in
 verifier
Date: Thu, 29 Jan 2026 17:38:23 +0000
Message-Id: <20260129-verif_special_fields-v1-0-d310b7f146c8@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAArxL7naDSA7tKRFiutRAmbkgQ3T3pc
 2BmHmBMhAxD9UDCTExnKKDqCtbdhg0FucKgpe6k0kbk4vuZI65kj9kTHo5Fa4zteqdko1soaUz
 o6f63IyzRi4D3BdP7fgLQI7BwAAAA
X-Change-ID: 20260129-verif_special_fields-599a67d10425
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769708316; l=1580;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=OzZ/Rl4B16kIhwazdmOp9dGJEKcdsYxxRfGIgjqVK9w=;
 b=4NpHhtJABwx1vff6SVd++F7dqqgK1gT2dpQVUqhEGgdw+syQDtDAiVuMOwei/ualVUyv5hifz
 lhkP6s97DLXAr1jixehFcEa6ANDNcXja5ewvljeUJTCxDe2u0yg4sen
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

The BPF verifier validates pointers to special map fields (timers,
workqueues, task_work) through separate functions that share nearly
identical logic. This creates code duplication because of the
inconsistent data structure layout in struct bpf_call_arg_meta struct
bpf_kfunc_call_arg_meta.

This series contains 2 commits:

1. Introduces struct bpf_map_desc to provide a unified representation
for map pointer and uid tracking. Previously, bpf_call_arg_meta used
separate map_ptr and map_uid fields while bpf_kfunc_call_arg_metaused an
anonymous inline struct. This inconsistency made it harder to share
validation code between the two paths.

2. Consolidates the validation logic for BPF_TIMER, BPF_WORKQUEUE, and
BPF_TASK_WORK field types into a single check_map_field_pointer()
function. This eliminates process_wq_func() and process_task_work_func()
entirely, and simplifies process_timer_func() to just the PREEMPT_RT
check before calling the unified validation. The result is fewer
lines of code with clearer structure for future maintenance.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      bpf: Introduce struct bpf_map_desc in verifier
      bpf: Consolidate special map field validation in verifier

 kernel/bpf/verifier.c | 143 +++++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 95 deletions(-)
---
base-commit: ae23bc81ddf7c17b663c4ed1b21e35527b0a7131
change-id: 20260129-verif_special_fields-599a67d10425

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

