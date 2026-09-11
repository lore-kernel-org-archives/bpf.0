Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EE3E7BCF
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095099; cv=none; b=JIYow+OYZ5bsVyeN66BKctakQ+XZkyst/fropEEjnnfa2nD/LzTa/4sgRT1IFm6rHMgoq84H8cIbZozhj4fl2xCHSW+6rraNi98/lXDGVi0P37Y441vg9Mw1tJZquYixc9zfOmWRD7najKr4Z4JzdAfwoAH8g80P872F2BXQOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095099; c=relaxed/simple;
	bh=8iIuQkT41WYMqXIRrn01O+1hE1izFOgxhyyJO9WShbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O74z5nCpYNwroqOt+rCWI/P9ksOdLKHpIHzqykNrpbH3D4oqzcJqIJK9ETVT2OV0sOtTw4OQpuq5F8q9wvzgqXqS+jq+DwWqnFn7TAPEi7EZYYIMtzQSJ+3qy8/AiZOG7XAGXC4nDOZILjIg39d2RrieXfrKQafAVv3Df33rzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZtQaa6e; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZtQaa6e"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-39b456fc4cbso233667a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095098; x=1789699898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=krVO6YvSfAfVHJhNYiqMhbVXXObJYyBTmkKjVVuoWtU=;
        b=qZtQaa6edOF1sAbVtoLl4Grkoc+DkWxgltZR4u/Dt13pt1mLmt48s+LEZU52xZqJfg
         ZFoAwCZFYXykSHzilM3FC/kB8bmCQXrS3HqquxS+Hz4AfZNT4+PjF6OwWSDMR64Serfw
         AbHKowNLwuXjbNfLes5GTf3oSD/ACiJyoZM+NaQCdpzC6AiF81RCA2IQP41iZ6h7jB6n
         iCMgimfx+90zyvLHknPaTuWp/dcJdE6aEW9grSHm3Agn08F461LaZxeqOHbfUIMBShLT
         7vxcQ8q2ccI2BOL1tiSwdWu94gfAZCUBAY0vckVDbYYVE22GZmCB0VUiyBJSDHtZuvp6
         lnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095098; x=1789699898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krVO6YvSfAfVHJhNYiqMhbVXXObJYyBTmkKjVVuoWtU=;
        b=BDBVW0kRvLeuMv5ghTvyJsEITmlY/IRB2RVEAGOu6bvL8qzNdvILhMYj7tJ5fkwih3
         +qhftUeB34wQXZfdNvvvzQNKrIcsU1YKRMYZDbONYe0l38ba3TbSHYktmpLp2cfeVnA1
         w3++vnakLmkoLOnwmHnHX2Vt9LIx29otzKgOn6NQ1Z2HbsWZNGSdzFejSsof5h9XM8on
         inm2rTjgrYC8OKXdWcuxGBlFv6YeRqKQXQpmPQPLxwNZjaClLbKD6/dMS2T1OIpfOHpr
         clghEeuKqkEO+UV0uWLMMP74bdriqguaY+mTGIHMUjioMRDHd6wEPojwgFUoBecZqLXT
         +rwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvKQXGO8xGS6xB7QEDPxDm6L2Ol0VLzRxTKEG2PKTlmOew5ph+szz+5WB0TnK+6GhNuVs=@vger.kernel.org
X-Gm-Message-State: AFuF++lBTgRtaanBrobASj7y+tWAm+KDAMZyZy+YiMJZQXG69/MQ4vK9
	Bj28pO3dawLLWC7U+rEtHH8wCcEpO99KPzzkcgCzckOZEjig9+yf3YpL
X-Gm-Gg: AYBFou12EDTXdq8UlIKVd7H2GXlYoO07h5Yr/HymMiQ7tRfRzfcL8BR51cYzwA7c1CB
	AQzKpgWi4x3neiIHWkAB01zLZiWmURPG/e9o9Cbnt+usbpQdDdtmvzL5K37dl6Lxx6XugSZAyo2
	tHuIkResmR6I9K+CaIy8rxWp23Wk/ikUhawBHogcFLYbaJpW5Xo59Pk9M6sMXPP3HF0uYgYPi69
	/jAzNqADHk/8Iwo5rVmnbn3AZdzolqFWFoV0Cr6hJQkk52LRKNkUlnPrzoNuNTLTQqe7gd7ISAR
	4uRFyIhQSRO9qcW8UFKByJBXcYsK+waDvEdcjwu6qiPhbaR7H7p6MB+IK+08J8IXLXbilic3H0m
	ku8TMCHI+OhuObSEVWlnlEnHUJMxGxIR3hZzTHhBliq3HtZYR6xVfIkl3wkSjkVKUV/l4upkLwb
	Xq1icwc4RWEirxihSgO6wq8bYo6k7V0FiVK2Q1A1Z5hSJO2iWBgdz94SBPZdVJtmrp
X-Received: by 2002:a17:90b:3c03:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39d9c1db154mr3473043a91.15.1789095097373;
        Thu, 10 Sep 2026 19:51:37 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm1888632a91.9.2026.09.10.19.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:51:36 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpftool: Batch bounded hash map dumps
Date: Fri, 11 Sep 2026 10:51:28 +0800
Message-ID: <20260911025130.191011-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use lookup batches for ordinary hash maps whose maximum key/value
storage fits within 4 MiB. The second patch checks complete output around
the batch boundary, short keys, odd-sized values and BTF formatting.

Changes in v3:
- Explain the batching benefit, conservative memory bound, and why
  ineligible maps retain the existing traversal in the commit message.
- Rebase onto current bpf-next and use Assisted-by: LLM.

The v2 implementation and tests are unchanged. Fatal batch diagnostics
remain on stderr so JSON element arrays contain only map entries.

v2: https://lore.kernel.org/r/178874362960.1415955.9584865244247659247.batch-v2-0@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/63

The previous version's CI PR expired after repeated "Patch is empty"
reports. The revised series applies cleanly to the current tree and is
sent as a new thread using git format-patch and git send-email.

Validation:
- Built bpftool and its manual pages, and built the focused selftest
  runner with LLVM 20.
- All 11 bpftool_map_batch subtests passed with no skips or failures
  in an x86-64 KVM guest running Linux 7.3.0-rc2 from current bpf/master.
- The four bpftool series were tested together: all 69 subtests passed.
  The cpumask suite (36 subtests) and test_maps also passed with no skips.
- Bash syntax and the existing bpftool synchronization checks passed.

This was a focused run; unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Use batch lookups for bounded hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 116 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 187 ++++++++++++++++++
 2 files changed, 295 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

