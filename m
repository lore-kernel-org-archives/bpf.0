Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C431AA8F
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752719; cv=none; b=fnu2w5OE67SexQkJxlxa2y2vN7gmXZx7HeOhQj5m83w7ZP4kbhUKWZ3Vz0j6C88aec3Gf75qC8c8tRPSp3123I/1BpAlyiXq2jYjhMa8a4XaOH1z+rjv68FF+hk5qZGKwyzI8miLj5rBDOuLVhw1K9AyV7u/CnGFQFQ1v184D74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752719; c=relaxed/simple;
	bh=XV3XIWzu1CCn/nPvVmIY/UbgGsxdCknQLO/xV2/9gLM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hk0MpZ4SvSeYaPeR4N7mUAhHhJRylN9ZjSIKp5g97GLrJZJGzMN94hbwVwa3AfzbCV+dPpJOBLAWJEGFbIVaFO3ymmnKbjauzbfygC/bz1J6XRlYgkeP6KkMCrkUC6tmo1EPPnCUsEkb3XjIl+zZr5wHeVg05qDENvNvRD4nZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEsCQE+i; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEsCQE+i"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee894b3d8so180433285ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784752718; x=1785357518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXrJ107wKy3x8V75/kZ6/Ho7GTQPDq1LN2/a6auVjsE=;
        b=cEsCQE+iIFJQm8X9j3hr76H0E7wys1Tz4pdwolTv+gjjHxXX2tGkArEEbNooLhJGOc
         xkJqRy0+WoEnrL4DBVaq77Rr13IHlKoetTBQbjy/8kK1FTblxa095Wm7LWWDYjt6709/
         om7l7NVUKY72+Dzmyyvv/naWnRHTW77kPRquwmQbZUVC2qr4HEbAYACZ1F9bfRp4SN/N
         juBjdlZJFuem4J0XbgvN6lUAPQrjTyYHp4WV1WQHZ3X6UlzmK4ATPA5KbEkSOedTzhMe
         bB/55n1hpqKg1+S7lgiNFcxeGfCY8wLjoFsOmyYU9IXLn1sWBqVoLX1SG8zTkkc5lAUU
         ZgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752718; x=1785357518;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXrJ107wKy3x8V75/kZ6/Ho7GTQPDq1LN2/a6auVjsE=;
        b=SUncEe1oRnA59RpvA6QXrf/EGSn8Bfzu5J5K1vgYuAbQ+0Zaf4pbO8/fYetVKjVB4W
         40o/ef9rJ38Tmml3PR8IXGkCM2iMPbgwpSWnN9fOQvPcWaQGzuWBdZQyTC4rtPh6WEYQ
         VfS+gY/GCfFGK4QW57vX77R1vWraoJxr3HjyKHiwNusZ05Tj16LrokMvyDad6fNjrQEM
         AfJGOrp680fWcSos8fWMbchgBhXTxsOErCXzWE47DHV3KGnFzt/dBAbq8tkmB5cfIhic
         +xHWHn4ueDuqerz429FIqRgN8u/0tfCQg9v5FMj4qGyp7je4qoe1e2a21vuUbeFpnwKQ
         Nl7A==
X-Gm-Message-State: AOJu0YyfyOUl3UpycDir4xmlpk6cBhmayaL8vg7B1VI+CrdIpzZ7hniU
	u4JRdRyHQHvBRyQgjlgImeKvt/aYLk/S7x5h6r5CHmxXJ2XMEWCzlq1njr4xk5ni/4EEXsTdXGm
	uSQzFqoKm6zGoA6rYzg==
X-Received: from plbi6.prod.google.com ([2002:a17:903:20c6:b0:2cf:7d3e:e383])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ec6:b0:2cf:7c95:953 with SMTP id d9443c01a7336-2cfa6f8ef31mr4151775ad.47.1784752717623;
 Wed, 22 Jul 2026 13:38:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:37:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722203801.1854941-1-tjmercier@google.com>
Subject: [PATCH 0/2] bpf: htab: Reduce memory use of hash maps
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

Memory is expensive and scarce these days. This series reduces the
memory use of BPF hash maps by eliminating the per-element overheads
below. This saves up to 50% of per-element memory use for standard and
PCPU hash maps. The memory use of LRU hash maps is unaffected.

Map Type & Configuration            | Old size | New size | Savings
------------------------------------|----------|----------|--------
Standard (key <= 8 B, val <= 8 B)   |   64 B   |   32 B   | 50.0%
Per-CPU (prealloc) (key <= 8 B)     |   64 B   |   32 B   | 50.0%
Per-CPU (non-prealloc) (key <= 8 B) |   64 B   |   40 B   | 37.5%
LRU (Any key/value size)            |    -     |    -     | 00.0%

1) Unused LRU / PCPU fields in standard and PCPU hash maps (patch 1)
struct htab_elem is used for all hash map types, and includes fields
that are not always used (bpf_lru_node, ptr_to_pptr). For standard
(non-LRU, non-PCPU) hash maps the 24 bytes for the bpf_lru_node (union)
are entirely overhead and can be eliminated. Non-preallocated PCPU maps
only need the 8 byte ptr_to_pptr which is currently unioned with the
unneeded 24 byte bpf_lru_node, so 16 bytes of overhead can be
eliminated. Preallocated PCPU maps don't need ptr_to_pptr, so 24 bytes
of overhead can be saved.

2) Hash caching for small keys (patch 2)
For hash maps with small key sizes (<= 8 bytes), comparing keys only
requires a single instruction (64 bit), or a few (32 bit). Currently the
4 byte hash value (8 byte aligned) is used for this, but offers no
performance advantage in this case and can be eliminated.

The implementation splits htab_elem into dedicated structures for the
different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
share a common initial sequence, but contain additional map-type
specific fields where necessary. This means the placement of the key for
each element varies with the map type, and key_offset is added to
bpf_htab for this purpose.

While using key_offset and conditional hash checks adds new pointer
dereferences and branching during element traversal,
run_bench_htab_mem.sh shows no significant performance regression across
10 runs on my 3995WX.

Benchmark (all in kops/sec)  | Avg. Before | StDev | Avg. After | StDev
-----------------------------|-------------|-------|------------|------
prealloc overwrite           | 115.11      | 4.10  | 115.45     | 5.24
prealloc batch_add_batch_del | 127.14      | 4.32  | 127.06     | 2.32
prealloc add_del_on_diff_cpu | 23.22       | 0.93  | 22.91      | 1.60
normal overwrite             | 78.52       | 3.05  | 80.40      | 3.25
normal batch_add_batch_del   | 45.37       | 0.69  | 47.71      | 0.66
normal add_del_on_diff_cpu   | 12.02       | 0.73  | 12.48      | 0.70

T.J. Mercier (2):
  bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
  bpf: htab: Reduce elem_size by 8 bytes for small key sizes

 kernel/bpf/hashtab.c                          | 339 ++++++++++++------
 kernel/bpf/map_in_map.c                       |  13 +
 kernel/bpf/map_in_map.h                       |   2 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 4 files changed, 252 insertions(+), 104 deletions(-)


base-commit: cfce77b63375dac81d53f2f85593c548415206b7
-- 
2.55.0.229.g6434b31f56-goog

