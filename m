Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248459;
	b=U2K93I6rqj12Xpsl/kcmRIPY/Ki+HtBRgCZPEu0MlWKuwHKEp2Vc23wckVT095n8XqrM
	 j+sJaVteUpyRADKRpgfw7pV96aOSRQj0TDYgzZ7LhHfi+eOSieNSFpE1xUs7OEnG6M847
	 HE7BpDKBJwI1oGt33FPSbrXScVKyN25qRJzoiqe57EQa8wpJbOkeAUlPHpzgoFPOyvSbv
	 KfF6l8JonZmdirfHsyMg4SJoiINSuKRKL4WmtvvCDjSpk8fkli7wqFgFBlm734BL4kggZ
	 VOYcsMXCui9/idRyLvRdYwGoNsfZV8mJJ1BE2URIyJJJuXwLf0sid9mLbWt9egpaf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VGlX5b+2G7Nu0U4uZOyViz7XCwK9OB5o2vUJ+OQR5lI=;
	b=ZXlVEUOsnl3jhnIpYeWDtMOkTUz10ne0T3iXEr0v0ygq7YY4kjG1fTwBFjW97lLaLuKE
	 2TvuUeKY7+3jUxgJ1OSfJ6m7PRW1VtXSyym8XvbHrlikB3FEMxh3+p56VGmEY/tuG6L4M
	 pY629q1tAWWMg0ukirg+g0oDLi5OjyjRm1w03Y4Qr+j6OxoD0BZ4bLLm27xyGvNmYKXc5
	 OPvHi/LCGsAkK5oVoDE6WPG+BfgsWyyd2MsvJJaGhsTonfMWTerPJYqrMgaOuyR9BSAI2
	 37YINwjRSsgdOTK1pX+/V6epmhSEQs++L5kP7yl3K5MyvJClAlC6lsup/nSRftSlyXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=p21qQC2q;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4C606A331
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F4C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=p21qQC2q
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so686837a91.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248458; x=1794853258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VGlX5b+2G7Nu0U4uZOyViz7XCwK9OB5o2vUJ+OQR5lI=;
        b=p21qQC2qaut5AfE9SRdHzZBxLM8RU5HfMxRuEgk0HoN2fHOe7WgjTyHr7qD7eyCl/9
         5UJK9TBFY1r8PKZg5fovuTnYLpscxoj1p1X55oKqTQTZisAlb7PKTIdV+VOsXruVAop6
         W/jI0YHynn1rLqIPOdiMIzG+ybsh1kPlF98qfV8C0YYjoS4Y/SWYZRQr9421G54d4ZWH
         DuUIvkHyiG1u+J/8RR0oFaPjtxrWUD8mhc5jnYMP0CW/5NhG9EL4Gsqd8nLrBC5n3HdB
         dAKlnI9UOnP+Zcd0JXiTpsVrIwrSp9Dla8EG5CfJwzOovAFc6adQ4CD8YDJM3kUYoakl
         wy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248458; x=1794853258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGlX5b+2G7Nu0U4uZOyViz7XCwK9OB5o2vUJ+OQR5lI=;
        b=qq47812DEwzmZhw8W4Oou4nsYNO+b2T3kWMQ73dUeXXW5DjKpA8BJe4C9o6mLGzvwZ
         ++QrxLctZslSArY1bXBgebZ9+zBioGOB3ZL+h+my//5OyKWzYol+nlRJ9Auo/s4yMThk
         /xUaNrZGTe6+8itRcACF5xKFsJ0XRSAUw4yMXF5f7modX0VQ97LCkQ/iSpG5Z8zKEeor
         cFbx5t59UZ4S6RJASorx1rvuS4oXFCZ2d8n8DKeO3TkPv3Hs+CKT4zLJ/JOC33HpTwxC
         z8t3qFFgE/dqgGq403pVf2P8XZV2+2f3vxKOtzpLAcDcHg6PSTno0FFK9URq5/qwxDBu
         +xgA==
X-Gm-Message-State: APuU4Z9sTbqK32K4xSxEMSIw1bz777+cDRRdLS270K5X023rLux+3Plp
	m47F1CGA0tXYljdFdif2pWszoNysyoKBDjB/kQMQTt+eUBfotIlNKAR2SD4MiIwFLJlHx1W2XpC
	23cDf
X-Gm-Gg: AYBFou3ewOiscmqHv2WfK/+izvQuVK/CC6WtocKwHcdsUY7CgoEY/6jU9I4LIon01Sg
	QxNalPN9cTQdc6haxk2hovBZKRsN9Xz5j7F0wP6JNXA7UCf68vVNtVsyD6akMyI2Mg6UUCsmb2Y
	sYk8DkZhidSkX/Ghi2QykurqpWcLTKxjXWvhSiiMseoyrlvc/fbEnuMzYNi+QieIfwGtzjGOiP0
	XQX18cjT8lM51XIVnREPknKxwcAClAJaJLqX3X2wynlBsFs0zkXIXhq6pg3SJVFfGIH6gMMn+b6
	lhbeDsp2p4O6BjM9HtZOW7lS/+zaDFMvU2UKMe7EzoKSIzb3gL/ScWE8bW3kkAkPhsbX3BvhZnM
	f4Dk3I0lm9xUFGQ0P2WhxjxmwRsV9iNb2A8wmPsvhRomPnUmeBNqW5JGEUSmcaFypiV1fqYNCSq
	JMwy3BeVqhM2Y9jd6Oha4bODeyuvTn3p+/goUr2QSzaRIQcUjYup5MxGRXN3fVnG+0j8NsYit5B
	qPeIofh6qSW6jhVLyElNlI/DyY2ootijPkbcXppaqLX5oawpjM90ZlaWJQYPQZrXmBDAD+tqlqX
	sOm2ec8V4irdoVJL+o7Jeon6cw/tAyn6oN5u/fZuq/O2TpPCONFF5GXBbbLkwVoVELPhKsktU4E
	NoLWv1ddcy7FPZ5z9u2pJcPv9VwQ=
X-Received: by 2002:a17:90b:4a43:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3b166d0d2cfmr443885a91.40.1794248458302;
        Mon, 09 Nov 2026 10:20:58 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:20:57 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH bpf-next v4 0/9] bpf libarena allocator improvements
Date: Mon,  9 Nov 2026 18:20:45 +0000
Message-ID: <20261109182055.7581-1-emil@etsalapatis.com>
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
     1    269/68 3.9x    641/68 9.4x  1568/68 22.9x  4550/69 66.4x
     4    251/63 4.0x    557/63 8.9x  2326/67 34.5x  5221/74 70.4x
    16    247/61 4.0x  1027/64 16.0x  2570/67 38.1x  5315/74 71.8x
    64    242/75 3.2x  1129/146 7.8x 2469/190 13.0x 5521/374 14.8x
   256   242/102 2.4x  1314/184 7.1x 2664/249 10.7x 5542/457 12.1x

Free latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    243/55 4.4x    273/56 4.9x  1428/55 25.9x  4371/56 78.2x
     4    242/51 4.7x    414/52 8.0x  2303/52 44.5x 5266/51 103.1x
    16    241/50 4.8x  1056/50 20.9x  2580/50 51.6x 5330/51 105.4x
    64    240/64 3.8x  1079/86 12.5x 2454/131 18.8x 5538/309 17.9x
   256   238/124 1.9x 1206/107 11.2x 2681/178 15.0x 5546/406 13.7x

libarena-malloc-xfree, where each worker frees the objects allocated by
the previous invocation, so with more than one producer most frees
happen on a different CPU from the allocation:

Allocation latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    291/65 4.5x   857/65 13.2x  1165/67 17.5x  4172/70 59.8x
     4    243/63 3.9x   754/64 11.7x  2170/66 32.6x  4931/79 62.2x
    16    231/61 3.8x  1163/63 18.5x  2572/71 36.2x  5438/93 58.7x
    64    229/75 3.1x  1249/158 7.9x 2824/213 13.3x 5760/411 14.0x
   256   228/100 2.3x  1269/210 6.0x 2746/264 10.4x 5669/466 12.2x

Free latency (before/after ns, speedup):

allocs         1 prod         2 prod         4 prod         8 prod
     1    266/55 4.8x   558/56 10.0x  1052/56 18.8x  4050/56 72.3x
     4    231/51 4.5x   583/52 11.2x  2032/51 39.6x  4875/52 93.9x
    16    223/50 4.5x  1019/50 20.3x  2492/50 49.6x 5396/51 106.5x
    64    222/63 3.5x  1156/84 13.8x 2801/122 23.0x 5735/320 17.9x
   256   221/124 1.8x 1202/113 10.7x 2736/160 17.1x 5656/387 14.6x

Cc: Harry Yoo <harry@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v3 -> v4 (https://lore.kernel.org/bpf/20261023002056.6647-1-emil@etsalapatis.com/)

- Rebase on bpf-next after the allocator compatibility fixes.
- Fix arena_spin_trylock() preemption pairing and add an irqsave variant.
- Raise the arena spinlock and per-CPU cache limits to 8192 (Harry).
- Use trylocks for the buddy and transfer locks in NMI context, allowing
  cache refills and spills when they succeed and deferring frees on lock
  failure. Detach the deferred list with one atomic exchange (Alexei).
- Move bulk spilling into the batch-refill patch, before the transfer
  cache, and add the transfer-cache measurements to its commit log
  (Alexei).
- Refill from existing chunks without growing the allocator, avoiding
  virtual-address exhaustion when only individual objects fit (Alexei).
- Restore smp_store_release() and force buddy_cache_free() inline; the
  measured free-latency difference disappears with inlining (Kumar).
- Address reviewer nits and clarify the cache footprint and free contracts.

v2 -> v3 (https://lore.kernel.org/bpf/20261021232641.10063-1-emil@etsalapatis.com/)

- Release the per-CPU cache claim with barrier() and WRITE_ONCE()
  instead of smp_store_release(), since only contexts on the same CPU
  claim the cache (Harry).

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

Emil Tsalapatis (9):
  selftests/bpf: libarena: Add bulk buddy allocation helpers
  selftests/bpf: Add a parallel buddy allocator benchmark
  selftests/bpf: libarena: Make spinlock trylock match arena_spin_unlock
  selftests/bpf: libarena: Raise arena spinlock CPU limits
  selftests/bpf: libarena: Add buddy per-CPU caches
  selftests/bpf: libarena: Handle NMI reentrancy
  selftests/bpf: libarena: Refill local caches in batches
  selftests/bpf: libarena: Add a transfer cache
  selftests/bpf: libarena: Cover buddy cache fast paths

 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_libarena.c     | 118 +++-
 .../bpf/benchs/run_bench_libarena.sh          |  16 +
 .../bpf/libarena/benchs/bench_malloc.bpf.c    | 110 +++
 .../libarena/include/bpf_arena_spin_lock.h    |  40 +-
 .../bpf/libarena/include/libarena/buddy.h     |  58 ++
 .../bpf/libarena/include/libarena/common.h    |   4 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 273 ++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 625 ++++++++++++++++--
 9 files changed, 1195 insertions(+), 53 deletions(-)

-- 
2.52.0

