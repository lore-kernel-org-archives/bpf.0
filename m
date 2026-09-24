Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B23F38F64D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228187; cv=none; b=U/sDNu7GRU9OhnBNwQAMRvR5aAh9qxwynqIQZ5FFqjYxxUJU0YX0yr1xEXMWdez2ubPhMY3zhGDLX1HFG9mUx3/swQ96lhpV2mviBHdVISxODR4sZkxo5u2Q4YVpC/4V5apF2C9j96FYmnVHrdJuICbFn5Iik7/KGkTkST9m6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228187; c=relaxed/simple;
	bh=8g9bYq9tV4EqGc83AooHY4ON0NaFAOGTF+vCnfrk2s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6kuAUMgFwCGrQZku9iS5h31ZcvvaFoc6XJF1GBdl8ToLDk5xerG7lMA7O5YPP4c3RkmkDocNA6MSb3JJuTFxlsyqVrmFjiEfjev9jGHMU2nUPLSajGS7KcDwKuMNvcWWZPDL/Y3fUxUISRGVj6nPP9Bh+J6OaUEEMNe+lh/fBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mh3lQTwS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mh3lQTwS"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so16121815ad.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790228185; x=1790832985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPCJhswtnE/rixrwT0nRTsTEmzGkM/a7VZXkKGgIsqI=;
        b=mh3lQTwSKPs4lBk/q+pXJp31RCAWVc5qkG+dA/mTZrRl3A3xSvrYCyGfLwtfRdge+4
         ggdzKsvnT5PvS8uonuzOz7p9PxXL6pu9Mps/O8sEWpLtxThI893CIR23d2cRx3qeLkJo
         B6HlDTivSQLEjBhxb3uo9MPGn209/EHkBrQGeVVBsHxoui409Me5wiwgR681DQ1Mcnzp
         tCZA50vK1ifCi3/g3YMGV2+bFy9smrVlYPSnA+npBW97PcKia8Nkp8lB1hAw1IqfOQQX
         j+zrugw7rLx7+TF/scQ101px9Bwe6/+npcqDpxqQ6wJzdAHtTqhJmelBPJxm0mDHIwS7
         Lzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228185; x=1790832985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPCJhswtnE/rixrwT0nRTsTEmzGkM/a7VZXkKGgIsqI=;
        b=arpY4qpoGweOFgnzBMMij+DEG8sSiAueRU6s+MhenQjQ/AG++K2HWw/MyGIjd5YPEf
         /AojyLnjE8gzZbNNLaIXkpdQsALg2G3ZC+WOismfV7JNhztcuMVzsJ8V5rhPtnrynqzz
         22rBM9mvqQ3eDM/UWSnzhRHHB//W1lrl2QkONRb3PrRH8hAhI8gbtLv0VhebZDJj/9Yf
         iFs3VKG+QJJ3Aqk//0Ywtrr4PUBDCbyKIr0AKY3cHlisWbMJz+kJYMzcytFxV6QWkRx2
         /TxrFzXjZWtBf1mcocF8wa3LZrrx00DsiECW6ck6po/zFdXuMJ5scDntulrXR58wVX/d
         6wGA==
X-Gm-Message-State: AFuF++mmskSTJZkd2ecC0ZWjf4SZmwtdQLAuIQ8MO0Hrzx9otZnWAxnP
	RIgRWE6RYZzb+F8hnOwIoSjUnBRqpJZaxUxabYFY0I0GYkIIrp6a9NLlBHwc7yV2Ks3lQxCQWcA
	J81gT1E01TQ==
X-Gm-Gg: AYBFou33O3PxgqVi/DjsSVK/qlERWUyMMQaD1Ga2bZle0KbHuWo07L7VLGWk2ZlEIfu
	fE+XXKB6jKbpB8aFWIDgDldlSA0h3c0LwiqSzOVnQchmZSq7jKinRgoYd2T04yqA3NKxJLqVg1u
	/za+aYGZpYjnuZ+8jQpLAA6a+TUTOMAuWTvqnBESozHUx/mj80WigYGsHk0gBEo3Qv19qujtrlX
	UhfFe988geJBPAeq0Q504zy75azJ6/vc//jMAy4s+1gDeD48jP3djZ8KROdcBxvCvIAHCqS6ZDl
	dJhyrfuIbb1SR+lY938kRfmCADxDpz9MHV9jTTY/5ywPUucR/6gxuynDYj2U0wXrHumaIV+ebEN
	ggZqLwSKmRd64rEomrZZ+oMoqWb4a9L2n/zWLOyKrWCNEc0gNQl0CXxp+KAomSUDZnWOdVXeLQq
	D2aI6Ya1J2kKySqhmidnvlFC7MmjAoXzCfj1XcvNPbV8IkqbS36w22Z89v7NHGra7ShKF8xI1lE
	L7ocmqhvzPOT34G+GZcHjjWIFYuldMBo24xRwI3RPo=
X-Received: by 2002:a17:902:f791:b0:2dd:c100:a5e4 with SMTP id d9443c01a7336-2df7dd82ab7mr12812475ad.56.1790228185069;
        Wed, 23 Sep 2026 22:36:25 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a4997sm20511265ad.27.2026.09.23.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:36:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 0/2] Make sleepable arena paths use sleepable alloc_pages
Date: Thu, 24 Sep 2026 05:36:19 +0000
Message-ID: <20260924053621.7076-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Make a separate
sleepable code path that implements this logic within
arena_alloc_pages().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

Emil Tsalapatis (2):
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users

 include/linux/bpf.h                           |   6 +
 kernel/bpf/arena.c                            | 123 ++++++++++++------
 kernel/bpf/syscall.c                          |   8 +-
 .../bpf/progs/verifier_arena_large.c          |  59 +++++++--
 4 files changed, 141 insertions(+), 55 deletions(-)

-- 
2.52.0

