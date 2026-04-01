Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F63890EF
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051488; cv=none; b=NiE293vwn5AKUWvtRLzI0JuQ/rCljRa6LVmSdxhuqj2Aoi9eomLpvfjDUxbNmvtREAl/VuqnDx67nppTnwd0F2g9uraeEwHpzFAPWHkDd/OUVXWal/8vKRu92lPLkULMAaomLUAMHHkDYQc/9hjAIS+sZIyp32EQUyuh5gCUoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051488; c=relaxed/simple;
	bh=mgj3L/M2oxQ6hFkshLH2op1RXqCwnpDv9khD6QIzHJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fQ9siCqC5L+LKnggi3vn5uGhqmWH9Sm31OzI9L4A8Zqe91EiWegBb/tkA8fj68HcvsTt6eWZbjoFpD1XQB0AOxdkgAndPtlpuLunGsDcdOF0SpF56XvTyjW7/hQhr1jzKiwk6rVA5aBO38gfIE6WKUUnM1ErBy5K9T8sJ7jjuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmlmLYZJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmlmLYZJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so11103215e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775051486; x=1775656286; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aA+vEFaotvGtmvAkTC38FuKWLRVYBFw2klJkTv2jQs=;
        b=QmlmLYZJNkMqOEZ37lmavFB9uI+dJQimwumiG/cfEmPNV700nz5EuAbw1G2Wn7K4DT
         vGVoy9NWUxcXTJpucus4j0zqN5Kya+WrOnOZ9H0yJ0aj1a5Zs4us4aA/CMw6wBVUu+BH
         qyv1Sjgl4zNWifA76UaVYeHYqtwXGxq4qVMwuO/HyukPOe39w2tyedWGobgq7fEBmDzH
         uIGFexL4IhZvLd24XUYtkMlpSpnoJ7zqvKT4HGoc7Azm3Qyp3D2Fyj4HK5VWh2Q/DTuI
         +dW105utepxY1l4PuIIiVPQd6DmJhx+O5ab1cSyEFLVe/k7yu1jADVJyn8mrrQRLK8YV
         MqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775051486; x=1775656286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aA+vEFaotvGtmvAkTC38FuKWLRVYBFw2klJkTv2jQs=;
        b=HFeuEqO4RQ3iCFJ/ePrOoyKTxWgUhQ5h3c1f0qbx4efTEg2+X0HbgAwSXB6YfC+L8x
         yYPEu2Ql2+VL/HbAbmApfLRvgHqeFePJCWtVXVWs20KRc2PtTKpdXTz/7t6cXW/87AEP
         8j1/TlA5KYFGyT1mFE3yh+lcfk7JFqJcW0lcTONx84MgvcvFvJx2BaqCUevaOGWvpT6O
         Lw6Xkh6WwccRTBnoZtlvAUpEywHbVvXj8g6jdz8d71/upLqcr41d+C9zjbbkBmr8yMCa
         XIFKc5F1eTYJdfpEIPEorOkPCzeu8qot4tIuouVlLbdADjowfRMi3yzCoFifhuH3ybSk
         SLJg==
X-Gm-Message-State: AOJu0YxryytLQT1u3gLnXs4fzek7GMyzWA/InYNq+1dj3zwSTDGL52jD
	5PweeusS6KbbghVaZ8eKiHKaMHUz4eOVVP0wo3t6i7L2KRSyZBW13cn4
X-Gm-Gg: ATEYQzzQhFo7sjlcNuqHf81iILLZ/Q+ZgEZASRRGPWwJPqeju3P4KHMZuyjkIhowhR6
	nnxg6TjtLXQwu1qb6JO9ru6Ov1FHLEjvU4j6bIRZkqqJc3hT6booq726ymqBlRqhjbxiFBtjRjI
	7I48wkDhOzy4yIogOf9hzEsofSpzxLuT+S9fiIt9gw3t+JCmRetJxh0mumrpHWrEEBqeyCoqvSO
	5jMZrY4VXqU/M+/ECSwd9/ykczmu0rWKzOad621zLSW1Vw0m54/5w6/iID8X6YXHznRo4zSaaiP
	pmkqQXSjZ16Wq3ZnmpofT9B4uoDcjURAjj4045xdpu37qMUnHVJG58uWHM8V4a0DkBWfslbifTq
	HIjrQi+Llj8B7EA5a2HLffLQgve8wKi4QhvJipghfmKVka644PHXLA957xtjEqa08k5FW9TMwOA
	uYYL1/nsNrwJVI
X-Received: by 2002:a05:600c:e40b:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-4888355df67mr46300795e9.4.1775051485307;
        Wed, 01 Apr 2026 06:51:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a62616dsm1032225e9.3.2026.04.01.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 06:51:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH 0/2] bpf: Fix torn writes in non-prealloc htab with
 BPF_F_LOCK
Date: Wed, 01 Apr 2026 06:50:35 -0700
Message-Id: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKwizWkC/x3MWwqDMBAF0K0M99tATFRKtiISfIztfDSGidiCu
 HfBs4BzorAKFwQ6oXxIkS0hUF0R5s+Y3mxkQSA46zrrfW2mvMbvmOO+aYo/lZ2L6VwzLf7Fbm4
 tKkJWXuX/rP1wXTci/v8SZQAAAA==
X-Change-ID: 20260331-bpf_map_torn_writes-624bd38e2c50
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Aaron Esau <aaron1esau@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775051483; l=1384;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=mgj3L/M2oxQ6hFkshLH2op1RXqCwnpDv9khD6QIzHJ4=;
 b=zvL2xlt+t4du6oUpjE8pS3n0C54mnXaLwu3nmPXuY8HSiwlwDT8yBYiJp1XahTtYgM8iYfj5w
 AEe+IVqO8BWDS92b4GvyI6jAvMR8ZzxWeTpDxrcOB4tvuXQloZw/wG2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

A torn write issue was reported in htab_map_update_elem() with
BPF_F_LOCK on hash maps. The BPF_F_LOCK fast path performs
a lockless lookup and copies the value under the element's embedded
spin_lock. A concurrent delete can free the element via
bpf_mem_cache_free(), which allows immediate reuse. When
alloc_htab_elem() recycles the same memory, it writes the value with
plain copy_map_value() without taking the spin_lock, racing with the
stale lock holder and producing torn writes.

Patch 1 fixes alloc_htab_elem() to use copy_map_value_locked() when
BPF_F_LOCK is set.

Patch 2 adds a selftest that reliably detects the torn writes on an
unpatched kernel.

Reported-by: Aaron Esau <aaron1esau@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      bpf: Use copy_map_value_locked() in alloc_htab_elem() for BPF_F_LOCK
      selftests/bpf: Add torn write detection test for htab BPF_F_LOCK

 kernel/bpf/hashtab.c                               |   4 +
 .../testing/selftests/bpf/prog_tests/htab_reuse.c  | 169 ++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/htab_reuse.c     |  16 ++
 3 files changed, 188 insertions(+), 1 deletion(-)
---
base-commit: 11c7d8e8ad8eed1304b65c42bf5fde9df947a9e6
change-id: 20260331-bpf_map_torn_writes-624bd38e2c50

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

