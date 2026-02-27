Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EC25A64C
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169636; cv=none; b=A/crhxciJsXTqYb6+Pmk2iytpn1sDJtNvm+rvh93Wc9mcHO57glT5eQFaWxVCQUo7pAemN8Z1pxTFP3ednQgmcV7zpfjr5q9j2RfmuqOePPPT4E0kURUkl+ecU1EB3FKLRJp3pCgE04QP7K0VoWwkr3lN+NfGm9sAWsRVFeU9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169636; c=relaxed/simple;
	bh=fSE2slpNeewIMpvSftNho8Ww/ICO67LYmlzRnPqP//o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAn48YBod2YZFwnBt+e46OSvGcOjgZZhQkOmqyEjlPS6JuBUozaDJGm0SCewrK9SaXuTZbXODIb5NXjTtqKU0O8/XpM2MMnigOAVIiPA2LLMB1vke+G5A6w3/GtjGd2AWMO2p0HXwPTPaX9zT9vDL9qW+0P6el12eZEEqQ3go4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiNifMJj; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiNifMJj"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4be7c4ebeso1255762a34.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772169634; x=1772774434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMuXX6Uv7uzj5iQQtg7D9wJTjFbHrRxVITuaJNVAnf8=;
        b=HiNifMJjF/O0r0RLFU2/HwtcwbKnc0rA5n2cDIHkp0bxu4TFU6vrpUmul8oNg/CVZu
         T97bD1oUNYaPCrCKD5Dou7NewYZskA1lehyAoom0xqCBJ8TMdKDkXX5m12h9Aa+Q4Z+C
         4ofcTZ0aFKebofCx4uabjs8j5hgrnQEtZu3Q/AKnOb4h5sa3X8wcpagzAnT8gXycuQW8
         Y2PdYcmkHWgRXENxbLXrx5TZH55uUwYLLwnoj7IeQPm4paGnwMAtnFY2O892JKToqPCN
         t0hlO4d5n/aQFiPE62RLuSolBZ+gLZCh4+m+meQeyPSKFj7E8UiqfUAbcJhINjChUmqB
         +7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772169634; x=1772774434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMuXX6Uv7uzj5iQQtg7D9wJTjFbHrRxVITuaJNVAnf8=;
        b=OSj7LmWIgn/ZCB3cbM9rTTrbfzBVn5U77FuCwmr86M6oMYHhVnVJC8rWrUw3dWe3Pd
         dhamTbAG1+YlW6DsxCEu/M9Zb70THKgUYU5deCvWexOfYDbg3U9XG3ZdasAhby75gsyw
         xFk9oypExFphW5qPnUNypGhwMjS4OpEy4RuRBizJKC03sl/IYqMWLXaY80VoCwT/jgc3
         +jjIApfKfPNdSfzn+Ks/jBPU2t1z5htzQCtDYY5OrAos0V34IhNz/h8qAew5p+kQZAA/
         sE7Qa/ir9qo1jaxX/p9+2FJ1eq46c9dN8zzrwnUJwzBHqq+KRPNRI4r7D2/Q4H9gYXOE
         0FYA==
X-Gm-Message-State: AOJu0YxIZtNFEldoRDDP/0vmR1B+TLDIFJmX/cPNjGKTVfE314P6dkXL
	Cb7iBkHQ77zCnkAqn7znnk6fBhlLp2yMrexGvSfJC1gvZuM/G52168bdEthJHiUX6ao=
X-Gm-Gg: ATEYQzz2F9dlhcN9iGKryzmXPzS5mWDVN7Hz1AdjKH2zSpDUeTvtr6NBNtD8psibNA+
	nOi8+B01VCQniIAiMc8prfh/dA8knz8cmmrOlFjQpKHeMuXISD9WX0fgGboz6ONIy3ZN2nl8opn
	7Myf8Htd7FVhE0X87Qs108dsb307Oj31Lu9DYJnaFiGV+Ik+89JX/jNxbHqcdd6sQe99ju9+JOo
	V6ClTa3mXysLNReZd0Mlbi9hTrP0srSy8d3CFO2ytSR6ANyPLOu84vfnq4M0nXwI9N+rtIOCA49
	xW4Z89Ms9RbUuI70giHWilPy4i7EJfwHPI/zReQdLMYnH6AtYUohh/ipGA1IKgGp8WhbW4CbfBm
	Hy7/dIo60bPZrmO7r0h4lhyiHkIornKcB1FhDIhiHiPkg6pfhIiLHzCFj703BNtWVt9bwt39Xb0
	fSRbPzFoHS+sHcWNAqiId6NJ9zwIfTcjoYOM6WbPYgz06k
X-Received: by 2002:a05:6830:828b:b0:7cf:da97:57d5 with SMTP id 46e09a7af769-7d591c1ad82mr1195502a34.34.1772169634011;
        Thu, 26 Feb 2026 21:20:34 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edfbsm3362992a34.6.2026.02.26.21.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:20:32 -0800 (PST)
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
Subject: [PATCH bpf v2 0/5] Close race in freeing special fields and map value
Date: Thu, 26 Feb 2026 21:20:26 -0800
Message-ID: <20260227052031.3988575-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885; h=from:subject; bh=fSE2slpNeewIMpvSftNho8Ww/ICO67LYmlzRnPqP//o=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoSmOHjZrqvyfl5S/kmoi68RKgTvXaCak/lXvO99g cuEUY3+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaEpjgAKCRBM4MiGSL8RysITD/ wIYjXOglErNumgKrKwzuVGlXJ/aAJ622DGyol7XWIHmwggG68B8KW4tVz/jPVMGl3VGXltFvIFPHZh xeDRlMLjCjLCKGMhBENwExfoVgK6vjmHE17OvhSICjcJxbq8KqRfFzGOoQC3b3al//LHaLssFOHsFX Uvljvy5IrUQ5sOZ/kO+GJBL92v64jSj4KB1oHkUSvjE1RdoUxmPHJMhrxn8eLk0D55oo+pZhjJVVHU Ehfsebnfii8u32XYpapWYTpfIaaKnPSRc9H7m5wXx346f5VUc9hBx9Qfed2bijhCWdH39zsGOK4YW6 yBjY9Y3Ak1Dldg2censpfiK5H5v+DMSZo+ekSH0b/w/WzKrS+cJyNgIv8cKbPe9kC0GoCfwEExYRQm NFHk5I+t150Cdx1SiNqyLdDleF9AdS5vov76RViImlZ8GCHK5iV7yXFZI8kuWhuLcqq4a7mbqgbDFw gGlm2GkPTx1aUlEddwr4QpiXYw9EPxrX8wAZXV+PSED4Tzg4Ezrx7lxgJe8JXKH0IJW8vcVZ1W1jIY lnwPbUZEK13dlaXu/kLYTZ2IUINxt2gdB/+9Ge+eFTOhfndE3b0pOvBppZpUWEN0y6dlLbdrySCSJV efl+R+AlB0sTPMwzMyGxDMFvYvOG54M9vZM9kvuH/jJWpUsBsnmiZKkXGmRw==
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
socket 16     432.026     431.941    1.047     431.347     431.953    1.635      -0.679    -0.16%                                                            socket 32     432.641     432.818    1.535     432.488     432.302    1.508      -0.153    -0.04%
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
v1 -> v2
v1: https://lore.kernel.org/bpf/20260225185121.2057388-1-memxor@gmail.com

 * Add Paul's Reviewed-by.
 * Fix use-after-free in accessing bpf_mem_alloc embedded in map. (szybot CI)
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
 kernel/bpf/bpf_local_storage.c                |  67 +++---
 kernel/bpf/hashtab.c                          |  86 +++++++
 kernel/bpf/local_storage.c                    |   2 +-
 kernel/bpf/lpm_trie.c                         |   2 +-
 kernel/bpf/memalloc.c                         |  58 ++++-
 kernel/bpf/syscall.c                          |   2 +-
 .../selftests/bpf/prog_tests/map_kptr_race.c  | 218 ++++++++++++++++++
 .../selftests/bpf/progs/map_kptr_race.c       | 197 ++++++++++++++++
 15 files changed, 599 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr_race.c


base-commit: 6881af27f9ea0f5ca8f606f573ef5cc25ca31fe4
-- 
2.47.3

