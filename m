Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC75432E88
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655794; cv=none; b=Ndj4sz0ijZj5m55KurOFJS2+K2ImzwcOG9aYQf2pubcBgMiVDFEpnC3T0uwuT4y1nOm8gykSsDK5JMO52MtQyki88HuMCiMtTG8cNr/BGoJPWhWweCBkKpuqhVtqioaKp8vXx2AJICJIrftdo5cUwPFqN0wLUvcaP/BCJTolp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655794; c=relaxed/simple;
	bh=pG3IomqbApnIbnas9uW8fDdWBloAGqTfkUEnpb8TTrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqnEjXwumGW17Xf2ped0InLvU7j524kRfXgb4FgSs+MD9C8pFFRJ4vKVGyfcjEB5CBJXu5+qXyns1xfNOhrgwRI3RkraXS1XTKrW6yN1fClvoCzJ07og9l9Bzt4nhTKCaQNt85iyoHMJwHFQzhLvsPNfkXMgNmcR0n5yH8BP9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coOgrmui; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coOgrmui"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso326659a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655786; x=1787260586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0nDqSX/SUxikuWjkdXFvi7qzKerpOf9Z5D5KaNNsVhg=;
        b=coOgrmui8WuaHF9prqIdWz0bc2TZrX8bcPYoRd3eoAhbQLGhPVQ9LDUvVAXoynEbIN
         8nF2TAEyzPNABRNgPdZT5qJ4Tjca29Eba96iNbd9QzwSS3ncUie0xqVifvF1nQA41r0G
         SkTxUVNnsawMKbUixZWP6Mezz4rYPrtWPnARe1KDqHld7pas34ZCHI5wmF3iU3YKqCE9
         vHn/h4QIbQeILa51mCSgQceKlw8R8mT9vSEYB06Rh0p9gvJL8N1SAtso/trr1suradju
         Cqqe+jg1sIsbzrv+PMxl5lbMkF9bwlI3j53DCu+ZYppVlk4/h6fXwQ8+5OWjrtlXJKJj
         1U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655786; x=1787260586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nDqSX/SUxikuWjkdXFvi7qzKerpOf9Z5D5KaNNsVhg=;
        b=soWRQqCoSOjy4jYrJ5pX3fjjiDJ8TQ+RoEHvc89kMj6Ba4/+HPzHO9PMir3bThcR9D
         S9GepWaZhTZetG4NoGNCilygPxb4r9qSsjkpOEGhgvh2g6nXdUFPB7nEJlG7zUNL+9H+
         N9T7JWbUGYWYMgQI7HzLO/wlOt2QUpT+zbIJFYKSzOWdPjMyF3gAXNjWmyyO6ljQhVAP
         lZG/NYaFs/FVeErk6/dsMO6sDXah5zSvMuIMhrb0EgTuxkbOgs/YS/mHwMpZz35S8s5y
         hjABTmLqBaJmxBLEZlPUOQK1tQs7WyY2G1jPttZu9cKSdGghRzCVKHgqga/g27n+oVzD
         2r2Q==
X-Gm-Message-State: AOJu0YxjKcfy2/vM1Y63ahVSY0l0Ggt5hbTtbliTB4bZ5de4YaR7B+2m
	4FWjNQQcxVaBuPpLIogWZ9LG/H1FWJparHAd1/LS/VJ9MTiORBEdOO+uOWzt4A==
X-Gm-Gg: AR+sD10YaMc9WdfvSB5kzs7b6wmKvRdpbo0Xt61wPkMKEeI99TdNVca1jlEqVkvtCgc
	cH/4UMpZ+3Y6wbfNYEjupvU8qw4ZMLIoBIc2LezuojZJ+pgU7RGp2fPKQHTzLaHMeJtw4TiNzRa
	0KyDIpsBt+NOWyZvUwAxUj/Y2nb/AdQQVLc9ez4C5OiPf8xPi+gJ4vLLfDnGADg6X0U3ujwBWtK
	Ka6i5kZMU2M86aM1PSVrhiU+ePS9oJitWxuSFo53x2UlL27gexvLWrB48yRTX2VlcBOmtZgTBxV
	tAgMnweLZJGsqL3n4LJteLXfZOhOMqZxS43Hmg0XSocZaHlS1RrY8zJQaCmzG9lCN7hsg2Kr7xH
	IgbYOdri4McU2tMNh3l9ZIE9paILTP/1j57Vb90vlX9wi6BIp8ZpJ0MGEnhwIjbywRLRgYWeIgr
	PudPevlB6Ivn6+3VJYfD9NuPY3UIYd/bXlJkrDo5SUFHcDrVH+NWMYTWyzAxTFQBQ7zkLumpkTR
	oKcEJtaIlvq4rT2
X-Received: by 2002:a17:90b:5101:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3933b6d0deamr1054102a91.1.1786655786058;
        Thu, 13 Aug 2026 14:16:26 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a03e288sm853985a91.17.2026.08.13.14.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:16:25 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	dingning04@gmail.com
Subject: [PATCH bpf-next v4 0/4] bpf: Fix refcount_acquire handling for borrowed kptrs
Date: Thu, 13 Aug 2026 14:15:22 -0700
Message-ID: <20260813211533.290256-1-dingning04@gmail.com>
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

The series is based on bpf-next commit 806c1a185215
("Merge branch 'bpf-introduce-global-percpu-data'").

Testing used a fresh virtme-ng KVM boot with KASAN enabled:

  full test_progs:           757/6685 passed, 7858 skipped, 0/0 failed
  KASAN/Oops/panic markers:  none

---
v4:
  - Rebase and retarget the series onto bpf-next.
  - Change only the affected verifier test program sections from ?tc to
    sleepable ?syscall, as suggested by Kumar Kartikeya Dwivedi; leave the
    test logic unchanged.
  - Drop Cc: stable@vger.kernel.org.
  - Rerun the full unfiltered test_progs suite.

v3:
  - Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED, as suggested by
    Kumar Kartikeya Dwivedi.
  - Add a separate helper for the BPF_PROBE_MEM read path.
  - Add read, refcount-acquire, and direct-write verifier tests.
  - Add Cc: stable@vger.kernel.org to both fixes, as requested by Greg
    Kroah-Hartman.
  - Split each fix from its selftests.

v3: https://lore.kernel.org/r/20260803112218.3361213-1-dingning04@gmail.com
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


base-commit: 806c1a185215382fab5a7fafc74e30070b2fb043
-- 
2.43.0
