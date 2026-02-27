Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20C28726D
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232490; cv=none; b=P28LYOipEPti1Y7CzJncVBxPRBlRwFHB3Bwv2P+8naWbyuRY6JCQQeozRIqBV9A7i/OT3eAB6MdJRuRN+mZAUU63/7IRypjSQv8N9dMJRdgl2sh98XF+HkCHNtZxPw31UIdc+nKA9zO7SsBwm82bz7hBNLl9CwpsR7Y16jett10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232490; c=relaxed/simple;
	bh=Ba3bmM6gIe3lI1v8bLmGGRi2G5zJPGss04d+6v6IV9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Byj31e3jQBc3Xpegbmz0N1Cvw6mZSC0IAER0rjU9TST+pY3AnfVCg6wxnJRF0G8DUgA8szuYkc/fvDZv2Nj3A3Z0uDx+Bm4U0gOTe2k928TTrHNhaDqEI+MK5Ord5ALB+R9x7v3ZaGWO1lTqA/Px+SRZ/0x/F2ip5kEBvp7qh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru48yEV/; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru48yEV/"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so2701324a34.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232487; x=1772837287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pV+gTNbORNCek/Gs+2y6r7i696VRwBEdWiJRwL3Mu04=;
        b=Ru48yEV/G20juL+OfMj8wsCtmGk2XJBeiWwVaERfEBtpMBv5HLo3eFOplh1beS2+x4
         NAosplLw48dUK6zxJjwCfvIsyKlDa5jdLtktByzlc2eWelLvgIbPULRLu+n/wc7Kneb+
         ej+b4Mbpxkg31VEZaf9vFRIxGaLEayJZE+nxBpGGoxD2qAVhcdrsHTfIHhxTn6tHgu/G
         +PRf78wee94LYTOH0RXQizoCXmz1ZzLkwHTllLCwPoIMWdO6I/9s9zev1dPAEV3L5j37
         ly/R0UFdf7OmRH0Q8L3clblsgI0Q8b75KbxmvLBxGEeWAfRkMNc1v6KngTDEZYwuzpPT
         lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232487; x=1772837287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV+gTNbORNCek/Gs+2y6r7i696VRwBEdWiJRwL3Mu04=;
        b=UunBscl9Dc0C/5HhMYIcWDkqveKpRt6k44loSsIYsnlc1O2aKc3AauMbeGB8HFWXo3
         L1RGacGey2xHPIsri26aGKyuRhDyT5rvZOviOv0Pigqs+q3NMJu/oqFcfY+IALuJJaIw
         6hc12ncNXJFfBv6QS4xCpLXfDBqjXWNK4NTWuTfarbitWbV9B9nx7D3lfAReGXfIhV6K
         bvxdYHs/jMCJcTEFkUmvafnGHDpOXMJfgIWkxmi5EkSKEv6YRWmnWrhgf8fmKjvvH2aL
         2W53x+t/J3Wn/fhrcRRAWyoL+xauUE0PzSOwHVH0Q9/VAQ3GIidjSrlLmI+aZ4s5CU+O
         XXaA==
X-Gm-Message-State: AOJu0YxCUsArJWhP0TK+/7KYLR+wjnZdOXZ99REjNVCKliYyNzMwLYfK
	m3cxyOzsVTlIKa0fzr/1A282TSL0zWaNwBGE7PkVwVC+K4K/MF/I9FWdANSC7nz3oyE=
X-Gm-Gg: ATEYQzzRsLYq92P/ORHZtVhxnKeno6r19jNrgZ3JYUeIIXJda8et6rxw4p8KCqQ4azV
	+t0+6c9ggx14Dtdimm5wUERV2QgsQ06bYE/iTAyN7uW8u3fytxxqF1s0npOQql+Qznz+FnzQBzL
	zILBmaIlruzDS7Z+SJEgzGVgdmIWtUu7PqxJy+n41Pwf2BAm2SueKEjpxTQjsttHEMdGZ7DaJUq
	IZTcnmic0XjCI+kYyKRhGvuqwHkDYItn6WSh8jbazNQqvoPHV6RRFWjlQKto9m31tjVdhbWtZGy
	DBRUf9Odna62OBJYDhAbZIJ9xrQNWmfh90B71gH0c2an4Dr93h+ldfcfsJG6YUjnQH/loQ/wNyT
	8FXvx8oLSX0p1eZD/iQ50h/bOuRxWt3sovKB/U/M7emhhVbwgaEQ84oIwUdMxpRpFZUU+WRp8f8
	j+E/ukjclNNsYsNWzU2NseKAMv3DkuSCFPUVQC2hY10I+M
X-Received: by 2002:a05:6830:6586:b0:7cf:dd63:3d37 with SMTP id 46e09a7af769-7d591bf428fmr2594189a34.25.1772232487509;
        Fri, 27 Feb 2026 14:48:07 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ea95sm5149566a34.28.2026.02.27.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:06 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 0/5] Close race in freeing special fields and map value
Date: Fri, 27 Feb 2026 14:48:00 -0800
Message-ID: <20260227224806.646888-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5110; h=from:subject; bh=Ba3bmM6gIe3lI1v8bLmGGRi2G5zJPGss04d+6v6IV9Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0ocTosE1FLO71HmEPVoON3x4D2xEBgjN1fZWWd dOIjgP2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdKAAKCRBM4MiGSL8RyvOYD/ 9u/5bc1Ie+6l48WMgtyFSYzHXwCtHRzQNFI3B3pBIu+mJmv8h00WbfVGCT2Zo5M6SbykMdsdnnQxpU DxzdkrOpcgtiGaRjCxDn2ryXRj52pnS3mmlqgHapeg5cQe54UexmVPRqD7zJi0Vj0FfbefnYT8PIMq w0jU/vb07OdmW9mo3L4G1ygE/ieZjeeR/UZKJ6+MogmHDbAw7WNxM5PrDrjvHPdTRmqVUQ8ect/Rmi hkcFAF58RN1rK9pWMNRem7Wa1d00rS5yUpcmlPwLo/kTNN0IDUtcJpwkUZwjHrpsV6FN2M5tMehOr1 NUz92ixmLEbMC2QTkHzoGJTLnzmUVm9PnjIk7O+/1Q1UPg9hNBZrVFeLVdXYBQd3q7VwEr9u69+2ip 7anEjRMBYZELwbiovhvmkpTqaBQwXzT7rUEboUJgimLCCm4qUBbLWYzFv3HRoT9MrxOgf4U8PZy6Tz ftnlR0kJn/Cp/iURylcs4apH2BGVY+6PUbT17MVDQXqN7J+emDVL+LlxZ9uj2z/rawzhUPufcUjU62 c+utxkgR0Pj7BN5LCiMr4k/8WotmAbmQ7H2ZcLIRHHPvkcH7WI2IfBTX/FZsz0+Il5r7BC0uPGVcdw VDYoi0Zq05TC+/pDO6+MzAX6c/FdmNkjmgCVZ97g+p70/VVqLBQTOGBCL7cw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

There exists a race across various map types where the freeing of
special fields (tw, timer, wq, kptr, etc.) can be done eagerly when a
logical delete operation is done on a map value, such that the program
which continues to have access to such a map value can recreate the
fields and cause them to leak.

The set contains fixes for this case. It is a continuation of Mykyta's
previous attempt in [0], but applies to all fields. A test is included
which reproduces the bug reliably in absence of the fixes.

Local Storage Benchmarks
------------------------
Evaluation Setup: Benchmarked on a dual-socket Intel Xeon Gold 6348 (Ice
Lake) @ 2.60GHz (56 cores / 112 threads), with the CPU governor set to
performance. Bench was pinned to a single NUMA node throughout the test.

Benchmark comes from [1] using the following command:
./bench -p 1 local-storage-create --storage-type <socket,task> --batch-size <16,32,64>

Before the test, 10 runs of all cases ([socket|task] x 3 batch sizes x 7
iterations per batch size) are done to warm up and prime the machine.

Then, 3 runs of all cases are done (with and without the patch, across
reboots).

For each comparison, we have 21 samples, i.e. per batch size (e.g.
socket 16) of a given local storage, we have 3 runs x 7 iterations.

The statistics (mean, median, stddev) and t-test is done for each
scenario (local storage and batch size pair) individually (21 samples
for either case). All values are for local storage creations in thousand
creations / sec (k/s).

	       Baseline (without patch)               With patch                       Delta
     Case      Median        Mean   Std. Dev.   Median        Mean   Std. Dev.   Median       %
---------------------------------------------------------------------------------------------------
socket 16     432.026     431.941    1.047     431.347     431.953    1.635      -0.679    -0.16%
socket 32     432.641     432.818    1.535     432.488     432.302    1.508      -0.153    -0.04%
socket 64     431.504     431.996    1.337     429.145     430.326    2.469      -2.359    -0.55%
  task 16      38.816      39.382    1.456      39.657      39.337    1.831      +0.841    +2.17%
  task 32      38.815      39.644    2.690      38.721      39.122    1.636      -0.094    -0.24%
  task 64      37.562      38.080    1.701      39.554      38.563    1.689      +1.992    +5.30%

The cases for socket are within the range of noise, and improvements in task
local storage are due to high variance (CV ~4%-6% across batch sizes). The only
statistically significant case worth mentioning is socket with batch size 64
with p-value from t-test < 0.05, but the absolute difference is small (~2k/s).

TL;DR there doesn't appear to be any significant regression or improvement.

  [0]: https://lore.kernel.org/bpf/20260216131341.1285427-1-mykyta.yatsenko5@gmail.com
  [1]: https://lore.kernel.org/bpf/20260205222916.1788211-1-ameryhung@gmail.com

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260227052031.3988575-1-memxor@gmail.com

 * Add syzbot Tested-by.
 * Add Amery's Reviewed-by.
 * Fix missing rcu_dereference_check() in __bpf_selem_free_rcu. (BPF CI Bot)
 * Remove migrate_disable() in bpf_selem_free_rcu. (Alexei)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260225185121.2057388-1-memxor@gmail.com

 * Add Paul's Reviewed-by.
 * Fix use-after-free in accessing bpf_mem_alloc embedded in map. (syzbot CI)
 * Add benchmark numbers for local storage.
 * Add extra test case for per-cpu hashmap coverage with up to 16 refcount leaks.
 * Target bpf tree.

Kumar Kartikeya Dwivedi (5):
  bpf: Register dtor for freeing special fields
  bpf: Lose const-ness of map in map_check_btf()
  bpf: Delay freeing fields in local storage
  bpf: Retire rcu_trace_implies_rcu_gp() from local storage
  selftests/bpf: Add tests for special fields races

 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_local_storage.h             |   2 +-
 include/linux/bpf_mem_alloc.h                 |   6 +
 kernel/bpf/arena.c                            |   2 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/bloom_filter.c                     |   2 +-
 kernel/bpf/bpf_insn_array.c                   |   2 +-
 kernel/bpf/bpf_local_storage.c                |  75 +++---
 kernel/bpf/hashtab.c                          |  86 +++++++
 kernel/bpf/local_storage.c                    |   2 +-
 kernel/bpf/lpm_trie.c                         |   2 +-
 kernel/bpf/memalloc.c                         |  58 ++++-
 kernel/bpf/syscall.c                          |   2 +-
 .../selftests/bpf/prog_tests/map_kptr_race.c  | 218 ++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_race.c       | 197 ++++++++++++++++
 15 files changed, 603 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c


base-commit: 6881af27f9ea0f5ca8f606f573ef5cc25ca31fe4
-- 
2.47.3

