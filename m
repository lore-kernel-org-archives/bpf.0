Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1574DC55F
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621701; cv=none; b=ATt/mnmNG2VMhB3Stjb3x+KlUjQVg1RyXhF86YxwQ0S5AJ9Fz2l3dVkJjq/OAH9AfWhwDLfb1tqdBfhPuq731SGhYaN3ZCnjIh0/h4MXBCLTvdLaQBKqCbZswQRP/IfVuexQvrzWDoS6YoU+B+iK4IYTuX6FCjgkXJNwHNAGYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621701; c=relaxed/simple;
	bh=50Wjn1H7SmZ4qc2K0sSC2vd4RngDK0mz2nYLLmXWJA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZLN49+zAU0cz26uH1Nw9LtkQ467UoJ4f6dfsCe6o2pytOZMvFr77hU6qiZRczKLHwOD+6JLjwk5YsNxYA6OMpKTsJBX25m99QB6RIr2BtKL3OmJ/VBivc/gd0n9b0dOch48sylNSf9KbHdCMweUHTDwuJa1fv2RqkQgV3/5HKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyEP/pUU; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyEP/pUU"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7353fc917e2so47499137.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621697; x=1784226497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfvOR67GhSzSQwd3yk2SQbsKhR6LSWv2OrkrLacBwig=;
        b=QyEP/pUUfh/Brvm6VL404nvRoUfsUg22Dwl4ct16zKp315CnRT3059RyTA4NotorFo
         xlLSCA1kRa66uKFog0m26q1tpvhiirNun9ycsANI38ouu0G0Qmh7zB0H19HaDc61Yv8e
         Ys4n5UU7qY7CHwip/hCxVVlOwFC/tD3+jUmcyKE/5lr7ITXmdSJafuOXZehL+gtfM72V
         LyVict4BfaKAEgxEE/pvBLi62BPLse5DTZwxURrthr71h5eT+ReH7oYOlsQgUyuVj3cF
         rv1WDIjH0bYq7KhnDdX9EV9zeKYiShSbgxbWFNPuM/tc0mVovlYTMmpCIf47QBuk/FLr
         4Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621697; x=1784226497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfvOR67GhSzSQwd3yk2SQbsKhR6LSWv2OrkrLacBwig=;
        b=BQdLkssBhesMMUXMZ8aDiK9nHaYNpdSeGVp4iENKiy0IlEGMLr9eQviXnfVXIRWOvX
         ipzODxNofBUd/ww3HN06St59tEg5yynqN2c6TYyKBEHCDs41jR7/iDm3kZMs3mouIyUA
         lobwx9rgsARh9PEs347GE/vSMKcnGqfj/QdWL/EpZHL9EusnK3IbeKLYSc3vYksSXoi8
         1mT1wynRykGwRzyTAUhyUYp4d0zhnqL1oy4uXH4oDtTh+8vGZ1e2g3vKzA/WUKByq3NV
         Vh5ZDc63MHonmbhCFMrzZk/+ALdeI+cP58TAylmWZtq4o0T6lyQfxy7QpS7AduoN1FQK
         mFiw==
X-Forwarded-Encrypted: i=1; AHgh+RrOtlxVn5hhSQ57/1ryJ2qNe5BLR2mTIp/pWdxP2F6I+7fEa8t+k8eaMUMKA7mbtKXsghM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFRlAiBN4KcED+kNe3wV1nkngGPrF9da49JtWvFs2mGpeLTKk
	9thZDblX/qzGgj99/06JIc3DSgZK2uRRePCNcG7mLIJUzVOIv9flcw/p
X-Gm-Gg: AfdE7cnURZMdp0PAou9dOELS2pwd9OEWgUWEBEn0L69sbyvP4jKZCd980r6oZJJ/W6L
	cShCjIPSx1m4DqwGrUW+ceft/H8esX8jQ71QLMty1BQP/+0PHCjhYYNeU+NmsgT5uRtOcESEiG0
	tj7Xsk+2I4e9gz2qTtxRafCHqe/bqwueZZm46AkTIvgqNmZI4Q5j7iN0S4iJxISxr+2guamoD+U
	HcY86tCVk+FGd7ggY3H4iwIGGLi4pFeCTOOeN1J0Uc/k55vDQ+bAkaSJvoW+vmxpJ7FT8DHj5I2
	307mrVFIAmZ7b368q57Q4B4oGcuR8/rn/qIzUhpDUFj9H6yftTVm246FY8n3JLDGaZHrVnmFZ++
	kS6vqQXGGTguWxksju+r3e4yLJaYHrSyqpjWeN2IriCExIMYEnIxGZzbXltfTumyaHwpl0fE0KN
	Gs2eFpDdUt3x4x77arScE=
X-Received: by 2002:a05:6102:5e96:b0:737:61e9:4116 with SMTP id ada2fe7eead31-744dfed3b3dmr4579404137.22.1783621697194;
        Thu, 09 Jul 2026 11:28:17 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm3437743241.1.2026.07.09.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:28:16 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for bpf_cpumask_populate()
Date: Thu,  9 Jul 2026 14:27:58 -0400
Message-Id: <20260709182800.2037938-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() writes its destination with bitmap_copy() but
types it as struct cpumask *, so the verifier accepts a borrowed,
read-only cpumask (for example from scx_bpf_get_online_cpumask()) as a
writable destination. Fix it and add a selftest for coverage.

Changelog:
----------
v2 -> v3 (v1/v2 were a private report to security@kernel.org)

 * Split the fix and selftest into separate patches.
 * Target bpf-next instead of bpf.

Nicholas Dudar (2):
  bpf: Require a BPF cpumask for bpf_cpumask_populate()
  selftests/bpf: test bpf_cpumask_populate() rejects a borrowed cpumask

 kernel/bpf/cpumask.c                          |  6 ++---
 tools/sched_ext/include/scx/compat.bpf.h      |  2 +-
 .../selftests/bpf/progs/cpumask_common.h      |  2 +-
 .../selftests/bpf/progs/cpumask_failure.c     | 23 +++++++++++++++++--
 .../selftests/bpf/progs/cpumask_success.c     |  6 ++---
 5 files changed, 29 insertions(+), 10 deletions(-)


base-commit: 36ffa86c42f91c8a57071e024afc4ffb51a8958f
-- 
2.34.1

