Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345834251B
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756330; cv=none; b=Oj5q7o17AcBzDUk+ZsivPl25TxcM2jrjnMpQ/QM7JL12XrxsiILYNpYHF2assW6NDM4lVDWMY9wZWtW422wFtNSytgnnDjX3ozCiImZL3VfLsjPDQjq3MNyu3exQre3hKGBss23ySb+2nJr24fiAyQi1FxRyU3VtZvkMz8wdrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756330; c=relaxed/simple;
	bh=o9w+XRZkB8Z9THjwP9EBPcysOJkhYIcBAHpiusrp6LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhwFlHdstO7Qs83Jn4G4WjhuNiwWpIMGFblFQCUQPu27raVfaRT6veP5lNGrk6cdJX5+yqqUAfKg47ffuWYTQavrGL3+QzkY0I1qQ7D7KVhiR2LxeeIA123U4MpcN0VAXSXimziTgRJ2fXnvuxvQggjtfaInncHworz3mO1VYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INM1rm2t; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INM1rm2t"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfff5f88dbso36119515ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756328; x=1786361128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8dOUiIc5xBl3gDxpPfriL1PfyJELAWmVwdEdmJehScM=;
        b=INM1rm2tHsiSvOhRvPukmnphcfwrCyzfqA4UaQ4/DXUuybDN9SrgGLcJ0NqABOhb+7
         1OBlanKbcXErC+LiwYF3QrdAHGhLFHT7hboXVZhk3+yWeitzEFaS3IbsjuRiwUsD2Edz
         d3be3QCnVDqWbTlyAVFS78iRymGM/d7GydcNkaF5Y51wVJ9idPPXrSaffDwCqkKGpdYt
         +ej7ROUH83Mf2+h2h+mysgHo5jAADZKKawvoO/+s+ySBIvUJDFpqOKovZmVIiMqEgVKZ
         22CVx9pb6AJ9wFaFpzovl/Qa6C02hsS6FHGD36e+36Oq+9JLELaP2HGA3rrdzN6E4/sg
         dH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756328; x=1786361128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dOUiIc5xBl3gDxpPfriL1PfyJELAWmVwdEdmJehScM=;
        b=B9b7e5cz/jo76Zfj/vnA+Tepm/xtUCIGzUzT5u6fyDUqx1KWd5zcyizBSy81h/x2Ps
         +tKWiuPMPhpxGdfvIH0sIixBcALhR3i1F3ciSzIyoL9fcupsNP1VyEvmuptzEBYvBePy
         1lXl0wyjVN9s9ERPhlbqDzSEp5OJEqSAhBhJLxWuiuFRGIhRok+haSCOAwnUFbn/TojZ
         zNosojuGk+EtjJmKMzVlQwy+f5ekXYznCYDNIGxiam6wwa71D7JfvY6PjRszO44f4pGa
         D4apLoRyZ7UD8KByBPoqAqV+8Hp7vGjYBrxcEOD+MHRpbHLpv9a8uRsJIyPT1WUzXWGT
         k9nw==
X-Gm-Message-State: AOJu0YwSt/w5Y2zyMh5w0hPlsUXVQj3X8kH1HeBI/oYnaVDJfkIgpski
	h+gTHXp6JMWVbxURBMpAIqzFy205LA6zsL07Sjn2gaSIw+GHU8XzYk+7buBuWw==
X-Gm-Gg: AR+sD11V2l3V4L9vMzwBUHtL9itJkX3EDYGuJjqPMWmlHneMJVhljBdCKz3TCM+qcaI
	uxsVEP8fVVztvWQ12lj8Zn1wDYU/MRZ33jeu46aOGopTxiwRppcuoB25LuSPp62N81LG7JEs9gW
	6fCcowBZWfr6spR2M0wcWe9/ksJUkxBxTCokqYIo0BXUeoBu8wHaDcuvCQnP8ex6J1r3H2eGq3S
	Fd4zkN9GAQwl/WGN0HZEWprNLsQG0oTvGRdMz5+nupdsLYlJuIMqJsrJ1deH+7+0EmRZnMsY1Fp
	NXzs1pAa6KnnsWWMJtoNnlnHwskyfINKuBQWsrPPQ8KIyggt20YCa5faKP/OSXOTbb2R8aBMdGQ
	HMDPvNbnn5EVjdUXE1mvuHxXzNP625ZPwrxvunyn6Edexjd9jBWDeNRO2LefZJypcaEWNBhJFYR
	JXuPWKsb5mEoeGlETB6w0dfLec0gqnamcbpRoTe1L7fY5VoNkj2WeRNheOCeqw/oeS5G5xiGKvL
	GQMlJJ3O6p0b9Ir
X-Received: by 2002:a17:902:cf09:b0:2cc:5f9f:54ed with SMTP id d9443c01a7336-2d0523f9ef0mr95227265ad.27.1785756328163;
        Mon, 03 Aug 2026 04:25:28 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:27 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf v3 0/4] bpf: Fix refcount_acquire handling for borrowed kptrs
Date: Mon,  3 Aug 2026 04:22:07 -0700
Message-ID: <20260803112218.3361213-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two verifier bugs involving bpf_refcount_acquire() and map kptrs.

First, the verifier can mistake an RCU-loaded map kptr for an owned
reference and assume bpf_refcount_acquire() cannot return NULL. The kfunc
can return NULL after the last reference is dropped, so passing an
unchecked result to bpf_obj_drop() can crash the kernel.

Second, type_is_ptr_alloc_obj() accepts PTR_UNTRUSTED pointers. This lets a
pointer that is no longer protected by RCU reach bpf_refcount_acquire(). If
the object was freed and its address reused, the verifier may acquire a
reference through stale memory.

Patches 1 and 2 fix and test the return-value nullability. Patches 3 and 4
reject untrusted allocated-object pointers while keeping safe
BPF_PROBE_MEM reads accepted.

The series is based on bpf commit e5fd3f514e27
("bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()").

Testing used fresh virtme-ng KVM boots with KASAN enabled:

  pre-fix graph write:       accepted, as expected
  post-fix focused cases:    8/8 passed
  full refcount groups:      47/47 passed
  related list/rbtree groups: 167/167 passed
  skipped or failed cases:   none
  KASAN/Oops/panic markers:  none

---
v3:
  - Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED, as suggested by
    Kumar Kartikeya Dwivedi.
  - Add a separate helper for the BPF_PROBE_MEM read path.
  - Add read, refcount-acquire, and direct-write verifier tests.
  - Add Cc: stable@vger.kernel.org to both fixes, as requested by Greg
    Kroah-Hartman.
  - Split each fix from its selftests.

v2: https://lore.kernel.org/r/20260726235030.1152542-1-dingning04@gmail.com
v1: https://lore.kernel.org/r/20260726015330.705259-1-dingning04@gmail.com

Ning Ding (4):
  bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
  selftests/bpf: Test refcount_acquire return nullability
  bpf: Reject untrusted allocated-object pointers
  selftests/bpf: Test untrusted allocated-object pointers

 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/verifier.c                         |  10 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 161 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |  74 ++++++++
 4 files changed, 253 insertions(+), 3 deletions(-)


base-commit: e5fd3f514e27db1f05fbd72ba615d74941e23c51
-- 
2.43.0
