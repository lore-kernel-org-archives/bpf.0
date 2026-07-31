Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10162E175F
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460011; cv=none; b=tv044QibhMwRTQkpH2bVCaFj0uh5IlCWmiLy77LgkJvb0Gb8S/abyHepTvVN0zPQyYZQlWQs1RfHvG6VpsZzc/mfoTJ4CUo5Tufwnp/uRFmjGAnZb94k+2SBmWSdTiTjitYV0VP5a9C3MikpPRH8G44b4i+JbDpgwq9o4SZkA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460011; c=relaxed/simple;
	bh=qbzRDw5DlhUuqi1ADHqvNGx7y5GB5KWZGzAr9C5aMxw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cJjfjrIlnE8cBfNO/i7R9r8da1OcOoRcKJTSGLhslEZi7onN4HIqUU7AbVCHpK/9yh+ki+YaHnk41lKkZJDPZc+GcZ9+hDjE4kMdvmwjHgY+u0vjdxJnz4rHGzc3rGEr4ZzZlVBQVSN0zupvmdkH1zbKvC6U/Il0mPXxMt+B59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7gItlup; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7gItlup"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so6858405ad.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785460009; x=1786064809; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RYCKKvAfipMm7zMRahctRKo6w06w8QLrpCFJ6xxaKI8=;
        b=s7gItlupnuhNZp6dr0A74/Z3ad7EmoHEYe3LyyuWjiQ88UfXmuceGz/ldWW+VE2jZQ
         4zN57QoqM8vAN/47eNFRLEkWBirBeB69Kqz/r5+Xkb0tKW6mMylwEkWi5EAE8g5ORCEP
         ra5/wer+xAeH/4MYR7aP3kyHf49Ys6uVyprR2VtgdycLB5GQY1EkY9HekPmX9UB+9u0k
         bsmoNVd50iymmRypmwAbhVJ21mnFuzB0zDkkLxCN2RQScoXCEcuvNJXoBCKvsHT+Kck4
         1/maEmcvb4J/jAhXB+hV7SqMBPvNmF389kvgEWsDopNDhz3RC6TSmxU+lP3ChK44TPFz
         UQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785460009; x=1786064809;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYCKKvAfipMm7zMRahctRKo6w06w8QLrpCFJ6xxaKI8=;
        b=QCT3P+2T+kNWBUWqXJTfafKjxI0mEW/SCoMTY5sKw6Zoc6dhHTHSlj0CbV/aX4iItq
         AH2wg0b0/d+EGmZUpQc7XnY8ON7CQaKYNUxS8wGWfUtwO548sY3Sf3jt+ndAEvCb7QdV
         O6YI+gcCrY/cqRHK84YQvWtiYqIXZalf6vtV2aq7ZQSmfZQCnxSb5kv2QmK3Nucf9B+m
         d5zmNBCgVU3NRL+ufjoEQ6mmoyJnPGnCYPftkmzFKZujCOPvrI7f5XI7eBxBEIt+znqP
         douxCWwwGObmroGtoBOXE9KKPohwoAmoBfCjq+tq2r3Ppf3V711ZKgseRLOt4zYDB45s
         Snqg==
X-Gm-Message-State: AOJu0YygYz90PB3KzQ2rN/cfMTGQpRyNZ0L2NVjo6Rtt1gEUEPp0mm3k
	A5+L/DmVbo5IMLs+oYXYtM+QN5nSa73KjXOHApLXp3rFNDnbWMUmgA2AB7kaMelNucu3G6VqphD
	3IsiMCuAZHMNy8VYgRw==
X-Received: from plbbi4.prod.google.com ([2002:a17:902:bf04:b0:2ca:cefb:826e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d58e:b0:2cc:df15:91de with SMTP id d9443c01a7336-2d046ec317bmr1670865ad.42.1785460008403;
 Thu, 30 Jul 2026 18:06:48 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:06:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731010645.3965783-1-tjmercier@google.com>
Subject: [PATCH bpf-next v2 0/2] bpf: htab: Reduce memory use of hash maps
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	mykyta.yatsenko5@gmail.com
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

---
Changes in v2:
Make maximum key_size for !has_hash depend on word size for atomicity
on 32-bit.

From Mykyta Yatsenko:
Put the htab_elem* common initial sequence in its own struct (htab_node)
and reuse it across all element types that share it. Eliminate assocated
BUILD_BUG_ON additions.
Replace both the hash and key fields with data[].
Store has_hash in struct bpf_htab, and avoid per-element reads of it.

T.J. Mercier (2):
  bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
  bpf: htab: Reduce elem_size by 8 bytes for small key sizes

 kernel/bpf/hashtab.c                          | 405 +++++++++++-------
 kernel/bpf/map_in_map.c                       |  13 +
 kernel/bpf/map_in_map.h                       |   2 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 4 files changed, 278 insertions(+), 144 deletions(-)


base-commit: cfce77b63375dac81d53f2f85593c548415206b7
-- 
2.55.0.508.g3f0d502094-goog

