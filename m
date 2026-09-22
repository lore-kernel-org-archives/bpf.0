Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CD3A545E
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107740; cv=none; b=FsYhI3SNejO7vIuVOtftLVWJEIN6XZBN6J3ttN0YYWXXKTvMBdIrwG7Otipg+uPJnpld3y/aBjk2DzBTjs5uUuy1BMn+yqkHWs146uJ/XYfKog4I5/8dxzBOZOuS0NulGdgHiE9mvbj2wk+q5qm59ncPDGFyEquTCUNv1urAJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107740; c=relaxed/simple;
	bh=EmIrsvdA2/afewICbt1xJBP5YiPJowaDXlzSyPgLuSI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AP18i/K9K4J/op8ppzAewe9ZSS0ARfDgc58xm2++P54HUeKfm9GwuLuySZQl4tZKqEoiMBxDFueFlM0NHIF8l/ckcz5o5NZd+wsVZzTm3JYJwqc7f4vNz3BgGoEkA/kDa0xUa3UPMUOkCzaxv7yOjcqK1ifMpBbIU98pEEMu4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov0P/E5Q; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov0P/E5Q"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so234298fac.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107706; x=1790712506; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4YttVmVDe7kPYmwTqqpDR7TPp37/yKqeznmiNNuOCoA=;
        b=Ov0P/E5Q6C6mhaeJy7BfqpTHmHAj7eE/lXouSnvQjsQz1QgY6Ytw+LAEi7fGaTRSTS
         pT74d18BuYYp1tCTTCqS1wCXNi5TeJXc/FWlZmU8wIbq8/aFAJt52pBQ5Qya7bsAvD1F
         fvZr11FhUc/7WeiMdBL+XSuL6tF8VypsEOntuY3+PcCaO3/W8NpZ+ciRdJAUNgPd8u5u
         rqPsXdGnOzPE5oCPq720ix/V0+3rrbekFPSKjslUI2aylOAUymibvzEMkJ6ZF2gjOTjD
         Xf5c1lRMamBj+30zB+xi9ChTq5PB4iONCaDzeRghAO3hj3Pf06uezeYDgjFrUAubM09Y
         KFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107706; x=1790712506;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4YttVmVDe7kPYmwTqqpDR7TPp37/yKqeznmiNNuOCoA=;
        b=py5daebWCCsMxosHjQgGtA+xeD4mhVcUr9MEIvtmq9CyhBeHGakNriRsh8ZNJyl//a
         Bc0vks5gI6uWrqYL3iCpToA8JO1zl0ye+UWFyAvN0PR04IARLjDx8+A5aa6eT5P5/cFA
         CTqoNoWnvjP9JBSoOQIG51cLO1GtqOQbEK3jmLXh8VBZO1F9oh+RaELT3U04YP0ZPCtj
         XSknMaI/19Hivx4IOzaxl6vAOZ4NHHUn3VHb1gvNdiOU+lx0mjOGiG1hJY+GedWUqbHf
         OV20wAj/sQYz+IDMngxImSRpV+qT7KCmMLDRfDp2mhylZ0/0E++/W9QbGLRMDHsLTP3A
         RmZQ==
X-Forwarded-Encrypted: i=1; AKwUvByGIKIUDFxOx79uVaHwVwi2MNKXEg5TseDSPDS8c9DlvKL4WmVGwxmeXwRNWUoXNzlfmlI=@vger.kernel.org
X-Gm-Message-State: AFuF++kzFRH9PUtmLf1iPW3b912YYdQPc9nxB+ymQMQlP0AIqC6sgQWG
	IJac4TwFnZkuGNa7lw88ISRGlFrvaYamZ2Ez+JRebQN1myajRrAhxx11
X-Gm-Gg: AYBFou0cKPAH1EoqlCaZPAUaD1csf8yN6IongSuxWZ5LcywJuF8OrW5wNf2PgdmOZeH
	HW2Y36/IOSJvvK//IhX+PiUOqGFRlJ4SFRaRVuwaXzISnrw8R0dQLqnkB6oZftNqqUUWB7/7vdC
	UiLGPyZumGSV+0ke82V5Xa+aTi2nv8fPER4AVuTptbyne6L25vKO2+IZl81nI6J56KVr9WdVnHn
	LKcNfsbUN0EUQa9dc+1vx0vnI9y8Wg8BudDE8BFTx1/dQ6eKk6/+u9jxwR1xpFgh22Vb5Z+pDdb
	RcwNrzPS5L4Zt+YoBLEUJRfxG3vQ+kTHVTPyqv+PE3OgGfnbnaXmWE06peci9/oVFf2+/L+I+j/
	xqIEwG55pR/n41Ld2OOJN3yeF8D32K9Faw3Mic7CBTWXhvy93U10FWDiuiMHY3+0svRuO7I7kY2
	uy5tntv1ykx8g0gvZMKDczjP1YsAk0gkZnta3Y+DI08pRESy+XbZkFYgAyPtq41qVPne0D6kPm/
	WYQGf7GxHhuxKJjWMtMGs3+GfyqmlRQzL3407kXWWkyqKYj7bHkCJzUz2qiMEpVUP4G5q0MgXQ3
	fbYBwhJXtfc5kEyah48=
X-Received: by 2002:a05:6870:5b8c:b0:475:a1ec:9621 with SMTP id 586e51a60fabf-4908b1b4127mr680375fac.35.1790107706068;
        Tue, 22 Sep 2026 13:08:26 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4908eb9237asm564087fac.12.2026.09.22.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:08:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 0/4] kallsyms: Accelerate symbol name lookups by ~19x
Date: Tue, 22 Sep 2026 14:08:17 -0600
Message-Id: <20260922-ksyms-tune-v4-0-92acea84b911@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBCG4auYrq1pp/zVlfcwLibtCI0CpsVGQ
 ri7hRUaXX6TPO9MLJB3FNhxNzFP0QXXd2lk+x0zDXY1cWfTZiCgEFpqfgtjG/jw7IgTAGZgK1Q
 SWQIPT1f3WmPnS9qNC0Pvx7Ud5XL9mYmSC26r3OjSokQFp7pFdz+YvmVLJsKGAnxQSBSVUkRKE
 prym6r/VCVaVOlfRihyq7d0nuc3NOACMhoBAAA=
X-Change-ID: 20260919-ksyms-tune-e22a42d8a31a
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790107704; l=9959;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=EmIrsvdA2/afewICbt1xJBP5YiPJowaDXlzSyPgLuSI=;
 b=QG9iUt8ol0ODMV+6EPhUfMcEzZZitr16xLAQeQvGlz6snwqCzYf2GvWZUZokkRlRjDSKzB6p2
 IgcL9iAfg0rD6r2PWKIeL5A/i0n6mCKJHjRA9ckhlIV5BEFJEDIbMD4
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_lookup_names() resolves symbol names to addresses using a
17-step binary search over kallsyms_names[] (~184k symbols on x86_64).
At each step of the search, two bottlenecks compound to create
substantial lookup latency:

0. Redundant string expansion: kallsyms_expand_symbol() decompresses
   the entire candidate symbol into a 512-byte stack buffer (namebuf)
   before calling strcmp(), even though ~94% of binary search probes
   mismatch on the first 1-2 characters (~580 ns per lookup).

1. Marker scanning: get_symbol_offset() scans sequentially from the
   nearest 256-symbol marker in kallsyms_names[], decoding an average
   of ~128 ULEB128 record headers per probe (~2,176 header decodes,
   consuming ~3,230 ns per lookup).

Together, these bottlenecks impose a ~3.8 us latency penalty per hit and
~3.6 us per miss.

This 4-patch series eliminates both overheads in a structured
progression while keeping the symbol table strictly in sequential
address order and adding 0 bytes to .rodata:

0. Patch 1 adds lib/test_kallsyms_perf, a microbenchmark module built
   directly into vmlinux (CONFIG_TEST_KALLSYMS_PERF=bool) to benchmark
   unindexed vs dynamic indexed name searches, address resolution, and
   table iteration latency without exporting internal kallsyms iterators
   to loadable modules.

1. Patch 2 introduces kallsyms_strcmp_symbol() to compare ASCII queries
   against compressed tokens on the fly, bailing out on the first
   mismatched character without expanding subsequent tokens.  This drops
   the 512-byte namebuf buffer from the kernel stack and saves ~530 ns
   per lookup on unmodified marker infrastructure.

2. Patch 3 introduces a dynamic u32 lookup index bracketed by
   kallsyms_lookup_batch_start() and kallsyms_lookup_batch_end().
   It allocates ~736 KiB in transient RAM via kvmalloc_array() only
   while bulk workloads (BPF attach, module loading) run, resolves
   each probe in O(1) with 0 hops, and leaves .rodata bloat at exactly
   0 bytes while retaining kallsyms_markers[] as fallback.  Both
   test_kallsyms_perf and kallsyms_selftest are updated to benchmark
   batch resolution side-by-side.

3. Patch 4 inlines and unrolls get_symbol_seq() 24-bit sequence index
   reconstruction into direct byte shifts, eliminating loop overhead
   on inner binary search probes.

Live Microbenchmark Progression (via test_kallsyms_perf, 100k iters):

Metric                    Baseline (1)   Token Match (2)   Batch Index (3)   Total Speedup
------------------------------------------------------------------------------------------
Name Search Hit           3,811 ns       3,280 ns          246 ns            15.5x
Name Search Miss          3,625 ns       3,095 ns          196 ns            18.5x
sprint_symbol               412 ns         412 ns          412 ns            parity
sprint_symbol_no_offset     300 ns         300 ns          300 ns            parity
Table Full Walk           13,626 us      13,626 us       13,626 us           parity
Kernel stack buffer        512 B            0 B             0 B              -512 B

In-Tree Selftest Verification (CONFIG_KALLSYMS_SELFTEST, 184k symbols):

In addition to test_kallsyms_perf, the existing upstream selftest in
kernel/kallsyms_selftest.c was run across all 183,990 symbols on boot,
repeating all tests inside an active batch window:

Metric                          Unindexed (markers)    Batch Index (active)   Delta
-----------------------------------------------------------------------------------
kallsyms_lookup_name() (avg)    3,926 ns               675 ns                 5.8x faster
kallsyms_lookup_name() (min)      311 ns               171 ns                 1.8x faster
on_each_match_symbol()          3,507 ns             1,142 ns                 3.1x faster
kallsyms_on_each_symbol()       14.7 ms               15.5 ms                 parity
Basic function validation       PASS                  PASS                    100% correct
Batch setup (184k entries)       N/A                 1,037 us                 ~1.0 ms
Batch teardown (sync RCU)        N/A                 3,440 us                 ~3.4 ms

Address-to-name resolution (sprint_symbol) and sequential table walks
(/proc/kallsyms) remain completely unaffected, maintaining full L1/L2
hardware prefetching.

Memory footprint: +0 KiB .rodata added to kernel image.  Transient RAM
is ~736 KiB (184k * 4 bytes) allocated only during active batch
lookup sessions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v4:
- In patch 1, ignore early boot invocations in param_set_trigger() when
  system_state < SYSTEM_RUNNING to prevent NULL pointer dereference in
  ktime_get_ns() prior to timekeeping_init() (addresses Sashiko AI review).
- In patch 1, prevent sysfs TOCTOU divide-by-zero panic: reject num_iters
  == 0 in param setter, snapshot iters locally via READ_ONCE, and serialize
  runs with bench_lock mutex (addresses Sashiko AI review).
- In patch 1, eliminate multi-second boot stall: add run_on_boot parameter
  (default false) so late_initcall only runs benchmark when explicitly
  requested (addresses Sashiko AI review).
- In patch 1, chunk lookup loops in 4096-iter batches with cond_resched()
  outside the timing bracket to prevent preemption sleep time from
  inflating reported latency (addresses Sashiko AI review).
- In patch 3, annotate dyn_kallsyms_offsets declaration with __rcu to
  satisfy sparse type checking and prevent address-space warnings across
  rcu_assign_pointer() and rcu_dereference() (addresses Sashiko AI review).
- In patch 3, use rcu_replace_pointer() with lockdep_is_held() during
  batch teardown to atomically read and clear the pointer while satisfying
  sparse address-space constraints (addresses Sashiko AI review).
- Link to v3: https://lore.kernel.org/r/20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com

Changes in v3:
- Reorder series: place on-the-fly token matching (patch 2) ahead of
  dynamic batch lookup index (patch 3), establishing an active proof of
  incremental performance deltas across all steps (addresses David
  Laight review).
- Add patch 4: inline and unroll get_symbol_seq() 24-bit sequence index
  reconstruction into direct byte shifts (addresses David Laight
  review).
- In patch 1, configure CONFIG_TEST_KALLSYMS_PERF as a built-in test
  (bool) rather than a module (tristate) and drop kallsyms iterator
  EXPORT_SYMBOL_GPL exports to avoid exposing internal kernel symbol
  data (addresses Sashiko AI review).
- In patch 2, optimize kallsyms_strcmp_symbol() by dropping
  skipped_first tracking and checking len at the bottom of the token
  loop (addresses David Laight review).
- In patch 3, rely on get_symbol_data() helper introduced in patch 2 to
  preserve bisectability (addresses Sashiko AI review).
- In patch 3, fix use-after-free race on dyn_kallsyms_offsets: bracket
  table dereference and array read with rcu_read_lock() and replace
  rcu_dereference_raw() with rcu_dereference() inside
  get_symbol_offset() to protect external readers (lookup_symbol_name,
  kallsyms_lookup_buildid, reset_iter) against concurrent batch
  teardown (addresses Sashiko AI review).
- In patch 3, update kallsyms_selftest to add a second lookup pass
  bracketed by batch start/end to report batch latency in the in-tree
  selftest.
- Drop 'default m' from lib/Kconfig.debug.
- Fix soft lockup risks by adding cond_resched() every 16k iterations in
  test_kallsyms_perf loops.
- Replace direct 64-bit integer divisions with div_u64() to fix 32-bit
  builds.
- Guard against divide-by-zero when num_iters=0.
- Replace tcp_v4_rcv with panic in hit_symbols to prevent failures wo
  CONFIG_INET.
- Add batch lookup setup/teardown timing and query amortization
  break-even logging to test_kallsyms_perf.
- Move David Laight to series-wide Cc on cover letter, dropping trailer
  from patch 3.
- Link to v2: https://lore.kernel.org/r/20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com

Changes in v2:
- Replaced static build-time 3-byte offset table with a dynamic u32
  index bracketed by kallsyms_lookup_batch_start() and
  kallsyms_lookup_batch_end().
- Dropped .rodata image footprint addition from +573 KiB to 0 KiB,
  addressing Kees Cook's memory footprint objection.
- Native u32 loads in transient RAM eliminate 24-bit big-endian shifts
  and unaligned loads, addressing David Laight's endianness critique.
- Direct O(1) table indexing provides 0 hops for all symbol lookups
  without remainder logic or odd/even branching.
- Restored scripts/kallsyms.c and kernel/kallsyms_internal.h to pristine
  state, leaving legacy kallsyms_markers[] as safety fallback.
- Rebased out Lorenzo Stoakes' kbuild series; this series is now
  completely decoupled and applies cleanly directly onto mainline.
- Updated test_kallsyms_perf to benchmark unindexed marker scans and
  dynamic index side by side in a single run.
- Link to v1: https://lore.kernel.org/r/20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com

---
Jim Cromie (4):
      kallsyms: Add test_kallsyms_perf module to benchmark lookup latency
      kallsyms: Match compressed tokens on the fly during binary search
      kallsyms: Add dynamic lookup index for batch resolution
      kallsyms: Unroll 24-bit sequence reconstruction in get_symbol_seq()

 include/linux/kallsyms.h   |  13 ++
 kernel/kallsyms.c          | 212 ++++++++++++++++++++++------
 kernel/kallsyms_selftest.c |  16 +++
 lib/Kconfig.debug          |  10 ++
 lib/Makefile               |   1 +
 lib/test_kallsyms_perf.c   | 341 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 547 insertions(+), 46 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260919-ksyms-tune-e22a42d8a31a

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>

