Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714862;
	b=p22XHlmiP6uryRGW/erLVakiuByjWelcJgub30aPhQEIPiZQT3f1E0+moCYcWF/2uYlm
	 38euFFpGx5f64ysP/mnUusEoWJNJLIWjv99v0ziciGXYlcMiNkPySXXTEzdJmrJUBsAof
	 iTu6E4kz7YCSYO6Q4FULEzw2crXUvC18+j7LIPj/MGDa7KTS3wvtO1FYElSXnOliMSIAA
	 kHL+cEwNiDB8BoLRiqYO+B9AccUClw3VB0SG0z0DU3NSbZP/qpUHITHC3WOViEF2sEni0
	 Umi/mvCAaQyjPTePBv1HHNOWHlLCxr+s/iMjMI3RlW/qIbM1HQTyWIMOVu3stM9sC/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HyYdTFRiZysDo1DqqSwOc7X9Bwa3BZ+6rEpkd+doREY=;
	b=Gel8jrEpJcRuLeJgIh0VNC+jxffTYKkACLIxR71zHF8rMrko81khhpOPswVdas+O8sN9
	 2sdah75uNCVC3Gqlz//V2iSLPs138fNFFYKPfw9f7A2PIWsk3Ek3AnwmsHDKPpWWOkAoB
	 r54sZfj3Pd/hHM+7MmsNGP/d9dQOFx6V9q6GGlPdSXZW8bjMRuS9uWBq2Qu9tiGQomLNm
	 tXAAQVZFoUOzxkE9f4fm4ys1NLdFtZoG/ElHnajLO4sIq4/C/7XtQyp1TeuNPHQ4LqTMv
	 KKKuX/p0xBNr3uagUD54SK5T06eYyhF5Zi+t7paU+z02NqWQX1AQYPMnHWNzxFp67qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SIaNa5Tf;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6826C606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6826C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SIaNa5Tf
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a0924e2741so242711b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714861; x=1793319661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HyYdTFRiZysDo1DqqSwOc7X9Bwa3BZ+6rEpkd+doREY=;
        b=SIaNa5Tfpq+WLXL59JzsHTegfKkSmajF2YtHx2IMXyrDQZgWk+HmQoesr5XpbvtFao
         pYQn72vFU6X+xINdaw+KqMDMBDEXdwsbV48oFpDV1u5q2pIZGL+mdWwvQMl3kSX7N2+m
         c6+K0SmExL0BY3fnFZ4SkGQ6Pw2xrs872A+TVsETTtDl1vRByWBIbZV8Dlmmjs65nmNP
         08fHXGPpFxJRfs90kf7fg1M/XQrXRdQ/Z8KIUWX8AnHyM2d5JRc68ePDpbqHdxEG652L
         ILTRa/WVfeInPPAChPoFU8FFZqT3HmNBLvQhDtwwmzMW6pQxRmU9Mg9iGUrnvR1ReTiN
         MIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714861; x=1793319661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HyYdTFRiZysDo1DqqSwOc7X9Bwa3BZ+6rEpkd+doREY=;
        b=VWy/ZuL9ZVUgXdBL392bdh58kdsJfTO+HqI5Jmv6su69hsaQwWRJLRd60dK2iyLe1O
         uXOZm1EOTjyUOuWpfPxPA1Hcr37hixo1lTO5ZHRHllqs7DGeuTemSphlSZZBIw1V6RHn
         BM3ECvvMfG6uc+f6dLcrLaSwSDOLAsYJjzCMTipm63/hmX6rdMIdyJZfmumUn9U5IWgC
         Z0DbAg0YpbCQ/ZRVKAMib9/FQ6CPhI2708OwXAgrPbr9Te26FctGPvDY7O7d4o74wK9N
         Om4n6dourHGf64OwMnkQiuYKiVyKW+B+WjWRnRM4X/rFRT5MjiwYGC/8AaaxSsN4nCqB
         MYRw==
X-Gm-Message-State: AFq9FYIUWMo+rKWyMzQfsDWlA1JsJb8lRlIHB8nWnzb4u4BzhfNSuHMW
	+S2w0I8NXZF6tu727+OMWfiwtLZXQGj4kWaITN9K0q3n0adQ6w8kN6/18/HE3lfY05gEwWxMJHq
	Va/4nzVAhwg==
X-Gm-Gg: AYBFou0OQrIAS5MwD0NY7HJliJXoxoc2qB8NoJ4RM1GvMuu2fKj50dVF5vRq2mZPRmz
	lhEyTvxvpiyDWiLK7P3+d4Cz3F/VYz/VrEonl67vZC1bAAbBqUsHFV3JBNtHWdWhNf8bkHD4FZG
	U4VpWJs78crB7xwj6HHsovzvSzfu/RwRkyImpDzZTwAFz6GjmYHg7vrVgUaWrceaggxZ/1661FW
	/pIShJfHF2/U9mkObwUyjTao1xrABoKHgREcIsOtpP0eZKkFzpIJeuqpMZpgg7KRZV82d+L3hLt
	IXx+fKGN+BMRbToU3xX4QJQ+z2VIgnBg60cNHsXVSqjVjd2hTyojENLNTjeNFR+wvm4K0di37QR
	ldZ6wJNOpgUAxttPRq/vEjYCZ9x9KZvjSxNqz0lIiEXWHJ9woBvgLsf8phZR93uY2ENn9zK43dw
	mwNVJRKsRYHadygn4l52TeikHC1SNK8FNSTJ9MpN5qxUiPN/p2tO5rhzq3G6RPk6VdMlPwz7RT6
	JFlJS7cl/SpI7UYyn1d+snK42aeL2dY95aPmn9TFZPqgqirr7SlFzhDUyOHLPIi6yft5fTCKmDw
	z0vU2YHyEHBAU/ef1EBKeUem6sBO4Y0tZfipYpc=
X-Received: by 2002:a05:6a20:9f86:b0:3e2:21c0:3dff with SMTP id adf61e73a8af0-3e37674de3bmr457188637.65.1792714860721;
        Thu, 22 Oct 2026 17:21:00 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:20:59 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH bpf-next v3 0/7] bpf libarena allocator improvements
Date: Fri, 23 Oct 2026 00:20:49 +0000
Message-ID: <20261023002056.6647-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 635 +++++++++++++++++-
 8 files changed, 1171 insertions(+), 45 deletions(-)

-- 
2.52.0

