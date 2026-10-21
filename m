Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625212;
	b=ZUMEW6zSYzCSESklGxLrx61v8+jSmRvtj/l7vci0XDUbpixf6DcfCILEYlPKNqvnowlU
	 EzDur75T7foAUZd/32raLchA8zSiqVUEMw8CZF0v3kXq/Fz3bALPrLO+eWJyzEDyQmpjD
	 dw7+/CQcjaeJhJWrLFsrIqBe+UvyEqDuJRgmjn9+6xMjchXbv04WMSTdefgXlLdcbp1pG
	 GPpRrdWz6H/QhRQWlXfO1Np8yZy0nzPzmgcZo5Y6lTSKbDJTB9tOLDa8WaRrrKNtcobTv
	 dWAvg96+L/cUdUyADZfe1fFRRl5/RzcqGP5S1m8wf4N4WwTlLGSe/AcjdFVQ/SAgbgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tcscb2RQS6uWIQea2nd71SKnfQD7sYqvjQrm1eAfv8o=;
	b=oIL37UO+YnsBJQHkpkFeHgKLMugiPvRbQHJ9QenjOMDlx3pkFoJJVD/PWDk4rMKY5jS+
	 wCBG+EtSlEws+ALIwDiJfKsXE2qmLalVH0hEmPRaXzLOGLeFo2SUJvrDgiCSC6AChkIvD
	 3cK71F9W9UeMogvz8+ffQtSPAmrzhk9Ad5YxLdp9MxftFcRfaou0XwylbvnQ4t7urv/ii
	 X87bdBmSt+WE4Sr9jNDQLLRgw9SUI/NARTQne4vaQTrS/s1WwPd1Dg+IVUPQ4EtQWYTD4
	 uNLVM71o4VVSoOeq0Li91++kA9MyQqUWjODaTpUwm037OUOFyiYnrOhr2OyF2LCsUZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=cRUKfc9i;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B866606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B866606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=cRUKfc9i
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso17201a91.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625211; x=1793230011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcscb2RQS6uWIQea2nd71SKnfQD7sYqvjQrm1eAfv8o=;
        b=cRUKfc9iHVA4xq0nuV80aXwxcODSqu02CTvY5WbvNtMemGHF6/Aw1JzEYa2zfUiSol
         vsJMLs/BCdpPT6H8SHtw4LbDfkmmP/uUFt1a0sZZiNJrFSMA7EYJ8NEAU/s+VXnJJVbi
         tKkco7DMB5UQAfQ4sIGT+jV4ZkHf3ar/YoaT2Nv0KXsu/Rl26jwN91+ydgq6LL3keMpI
         ADtwoKhwkvTidl/WHE0hqqFKm2Lu7IYvPHVX5LDPrKQ1Kq8SLak8acCBLtYolJn3s8db
         /gj2ojaZjflJS/3aBUxC996vt8WksYPxV4DlFVpcCsLe8Seg9nP3XlBb77WiPPz+iVQq
         X/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625211; x=1793230011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcscb2RQS6uWIQea2nd71SKnfQD7sYqvjQrm1eAfv8o=;
        b=BG88IhvdBvV2nOwGI5PCZBsE+NoottgZGBxmnbc9J1TjXOPFtGosK63I1kr6PIlTuJ
         Ay6f22LqLXQ7A3QaO++uSiav9Cu8OuNcq3dE4MjwchRvubzSrPul1Fs6IOPTvZNv5F4N
         MCK4TaqkJ/KWHloUudDufN4IPEZDWAAHuo47DEj3pc4p/Vet4+el3PcUDjuQIqhapfCp
         nOiXi4U7X1uBq9Lc6ZQMjqt1H84iipxkOD9LDhBj2uHBO/jLfZ1t/Axpfec6HiWx/lai
         e3zNJWeIMf4nyDfIMu28RVb0vOY0C98cJWpkw3WHJiTwQy0CtYuzRDS/5CZi+Lj3zxr0
         cYWA==
X-Gm-Message-State: AFq9FYJNiZlohGsOf8OtjgHgGzGMeo68ycmZxDOSph0Ekg0hSkclfkkw
	5TATm9m9YMosfb4Z/8STNCj9T9lVL1JT91d7Pd32l8ap/AHomxnEVtReKzgPAq4hAHziNIrXnO1
	Rlrw1
X-Gm-Gg: AYBFou11B7R0VxyiLMxHkZIfhedQuVtN5yVQNqTb0iFlDkN8+4PQmBguiCIj11LJGDn
	/6YD7veZzLx4OH+rPrTV8sm1jM5LnLEGqDU9FVFJ3RIJEU8qAIH+sIbkcdKtUJYCUBG7pIZTHee
	432GedAvTiP9ZeLCnD7qOx6zPkl5rrJsJzQKk/twR2eRysFiLKlQADSrb3QE+WKtlB0e7OQs+VG
	ve2Aakga3kxghHjA384zl8mAOirZKY0K/6+ta696+INpxO8DemjS3eQTvOuK8k7Sw06T9dw2uAc
	TAc6HfJfPaXQigOLxLHRY8d3z3BG9+K+QMmX1idAWKMNoft1Cdv9UbY1/IjiYjyQWkbiOGPMW4c
	+c4VaL4AyJ3oB/1ymPtpPXvmgaKFjWA8mWthK2Jgk1xyrc5IJdntaJjlwZKiFLRmuv9GFoQbued
	Mk87OAvxJmvFgAMEEduCoe8CbQ35e/YVXM6Q3a3Krjs5AUk/brqJKDeHSDhO8GmAgzV2mkPb8R/
	9XZcalRPpqMsDgyEJZQYkYNHnfIuUJMU/BSzY+9osbR
X-Received: by 2002:a17:90b:3d86:b0:3ac:e6a:1b2b with SMTP id 98e67ed59e1d1-3ad86cb08f3mr2883772a91.0.1792625210687;
        Wed, 21 Oct 2026 16:26:50 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:26:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH bpf-next v2 0/7] bpf libarena allocator improvements
Date: Wed, 21 Oct 2026 23:26:34 +0000
Message-ID: <20261021232641.10063-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libarena buddy allocator's design has up until now prioritized
ease of verification. With new verifier features like unlimited
global stack frames and a large stack size we can now improve
the allocator's performance and robustness.

This patch introduces per-CPU caches for the allocator. The overall
caching design is inspired by tcmalloc. Each CPU has its own static
object LIFOs, one for each allocator order. This speeds up allocation
and freeing for BPF programs that have some degree of locality. The
CPU caches are lockless. The caches are replenished from and spilled
into "transfer caches", per-order caches shared between the CPUs that
amortize the cost of spilling/refilling. Data from the transfer caches
is in turn moved from and to the allocator.

The patchset additionally includes code for allocator reentrancy and
bulk allocations. The reentrancy code lets us safely allocate from an
NMI context in general, and from a BPF syscall program context
locklessly. The bulk allocation API is useful for replenishing the
allocator caches and also on its own right for speeding up allocations
during initialization.

Benchmark results from patch 2, run with the options from
run_bench_libarena.sh (-a, 64-byte allocations) in a 16-vCPU VM, as the
mean of three runs. Rows are the number of consecutive allocations, and
then frees, in each benchmark iteration. Columns are the number of
producers. Each entry shows the latency in ns before and with this
series, followed by the speedup: the latency before divided by the
latency with this series, so higher is better.

libarena-malloc-free, where each worker frees its own objects:

Allocation latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    260/64 4.1x    602/65 9.3x   866/65 13.3x  4067/68 59.8x
     4    244/62 3.9x    449/63 7.1x  2264/67 33.8x  4813/75 64.2x
    16    233/62 3.8x  1047/63 16.6x  2198/69 31.9x  5044/77 65.5x
    64    232/75 3.1x   883/142 6.2x 2558/191 13.4x 5603/380 14.7x
   256   232/104 2.2x  1288/149 8.6x 2758/240 11.5x 5549/446 12.4x

Free latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    236/66 3.6x    250/67 3.7x    588/67 8.8x  4014/66 60.8x
     4    236/61 3.9x    353/61 5.8x  2373/62 38.3x  4979/62 80.3x
    16    231/60 3.9x  1104/61 18.1x  2233/61 36.6x  5126/61 84.0x
    64    231/75 3.1x    861/97 8.9x 2555/140 18.2x 5666/331 17.1x
   256   230/137 1.7x 1182/107 11.0x 2766/179 15.5x 5584/404 13.8x

libarena-malloc-xfree, where each worker frees the objects allocated by
the previous invocation, so with more than one producer most frees
happen on a different CPU from the allocation:

Allocation latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    273/64 4.3x   865/64 13.5x  1192/65 18.3x  4274/69 61.9x
     4    231/62 3.7x   740/63 11.7x  2431/67 36.3x  5053/79 64.0x
    16    221/62 3.6x    342/63 5.4x  2233/68 32.8x  4991/89 56.1x
    64    240/90 2.7x   959/153 6.3x 1503/113 13.3x 5178/353 14.7x
   256   221/102 2.2x  1294/210 6.2x 2512/252 10.0x 5640/374 15.1x

Free latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    250/66 3.8x    594/66 9.0x  1055/65 16.2x  4147/66 62.8x
     4    224/61 3.7x    590/62 9.5x  2393/61 39.2x  5061/62 81.6x
    16    212/60 3.5x    304/61 5.0x  2158/62 34.8x  4984/61 81.7x
    64    233/86 2.7x   915/105 8.7x  1469/95 15.5x 5174/268 19.3x
   256   214/133 1.6x 1215/121 10.0x 2511/166 15.1x 5633/309 18.2x

Cc: Harry Yoo <harry@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20261020181900.6755-1-emil@etsalapatis.com/)

- In the transfer cache, avoid taking two locks per free when it is full:
  check the transfer array's count before taking its lock, and spill the
  local batch with buddy_free_bulk() when the array is full or busy
  (Alexei).
- Simplify the per-CPU caches: keep the guard in struct buddy_cache,
  claim the cache once per miss or full cache with the refill and spill
  paths out of line, keep the cache state in struct buddy, and move the
  definitions into buddy.h (Alexei).
- Make buddy_free_bulk() fail only when nothing was freed (Alexei).
- Time frees in the benchmark, add a cross-CPU variant, and add before
  and after numbers to the cover letter (Alexei).
- Addressed bot feedback.

Emil Tsalapatis (7):
  selftests/bpf: libarena: Add bulk buddy allocation helpers
  selftests/bpf: Add a parallel buddy allocator benchmark
  selftests/bpf: libarena: Add buddy per-CPU caches
  selftests/bpf: libarena: Handle NMI reentrancy
  selftests/bpf: libarena: Refill local caches in batches
  selftests/bpf: libarena: Add a transfer cache
  selftests/bpf: libarena: Cover buddy cache fast paths

 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_libarena.c     | 118 +++-
 .../bpf/benchs/run_bench_libarena.sh          |  16 +
 .../bpf/libarena/benchs/bench_malloc.bpf.c    | 110 +++
 .../bpf/libarena/include/libarena/buddy.h     |  56 ++
 .../bpf/libarena/include/libarena/common.h    |   4 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 273 ++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 630 +++++++++++++++++-
 8 files changed, 1166 insertions(+), 45 deletions(-)

-- 
2.52.0

