Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4B39E190
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576753; cv=none; b=hrUM6RB+02wbaYf0Clm+xfdjnDiN59I7wGRjTHZn/pIGgBEKrJc/Vf6sqlFkUC7IV/vWanUVkwo+/vTc9IlIR4t4Jv7EeZiiPEoXmgrcQScl1XmU8vmaOjE9zW6BUemx3rU4isg/R8DcrUizWn4Urq6jIr5qexahG0DYbQxaZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576753; c=relaxed/simple;
	bh=cPqFm+LyGPK6Gn0Ei7oVXtR1tgf3D6y/w7bSXAFqtls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RO6jQgy8PS/Nnhw9HHacQIAWEe+lEP8gRFIRR/2iQrGCEpV8L7RH14sknedNyqTKoDGbbZEyt/6RmSPhP6v/MYU8ZJuoWl/17qZ+Kp5gDcnrIwf5Kx4ViWKz7/s++tvdHD2sxSVEA/zGjS9ZRsjNoolX5t/GESmM5BOtz2RZSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GdN/EMp5; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdN/EMp5"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so3337591a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576752; x=1787181552; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlHP+95ampkh+V3prLlzisesw/6GsaXnNdDNP9lq0kU=;
        b=GdN/EMp59pdemhBVuh2qs30G3Yi7Njk7MtHAWon0WkRpTU5qgZ6mH9KZDCOUJq335N
         z8+KwKnYx7Y0mqGlCOs8dscQgkIm/fr6aM4DFTfACQ5eca/Hm2/f5mE6YvOI01cNMNfx
         szPAoUsmHiK+CMQqGrKOw8vI8xvcOx1SMHg1cvRnzTJaekpEd1LZJRzag46xVW88YoOX
         jl7Pc1HKWfO3vmWysiFoniI5gaO8elXhkVrGpoDwPfx3MBXrtQv+puj21YdxKQfR4SsV
         BTTar92oav9iyhQYrmBOlnt6WYtOoHvaH43c67+7sgpqx+n1mNDdUbMJapc+680BO2AH
         n28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576752; x=1787181552;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlHP+95ampkh+V3prLlzisesw/6GsaXnNdDNP9lq0kU=;
        b=I9iFb4H4FliTuZSaBFCZDtkmswE28BEUltgBLPt/PU7FtLtoE9WWAigt09xGolg/J1
         fLyHHN+pRafF9u9rB6Dtt5v095TXP1LilQQP0zD/e9IdQh479yvw/z68tNw8RJMjKWG/
         EZAWK501nQqYqQdM/LONSTyllzcDQiqLTbqczgmvgUHYyOtl3bcN03dAJCmW706y52y6
         xuP7fFn1JxGbLFR6NCqdkij6sSBgzShRQD56E97L7DzTVdDnTS6PN2/FWIXf1uk2/K/s
         mDiWS4G6RC1bMZofsOg9kcLhcf3+ds0bnOLRIqh2akXjCVvALL+Qy8ncwZU3Esp2fcAI
         xagw==
X-Gm-Message-State: AOJu0YycAIQA1zm+ziYsycebJYbMZon8yZyBD+1USGkvMgyyE+1MigwU
	ozePOf9VKWSiK+UzlMuG71ELdYj2J/3xrB8cxgLVjKiiB7tXs739gwQ4GjJvHAVuG8T7oj3yz5A
	fMozXHewNUKAGmlk7fg==
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:392:be42:1d95])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d89:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-3931e2d7782mr2012960a91.17.1786576751515;
 Wed, 12 Aug 2026 16:19:11 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:19:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812231905.2956588-1-tjmercier@google.com>
Subject: [PATCH bpf-next v4 0/2] bpf: htab: Reduce memory use of hash maps
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
For hash maps with small key sizes (<= word size), comparing keys only
requires a single instruction. Currently the 4 byte hash value (8 byte
aligned and padded) is used for this, but offers no performance
advantage in this case and can be eliminated.

The implementation splits htab_elem into dedicated structures for the
different map types (htab_elem_lru, htab_elem_pcpu, htab_elem) which
share a common initial sequence (struct htab_node), but contain
additional map-type specific fields where necessary. This means the
placement of the key for each element varies with the map type, and
key_offset is added to bpf_htab for this purpose.

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
Changes in v4:
Removed inline from new functions per BPF CI (netdev/source_inline).

From Mykyta Yatsenko:
Factor out duplicate lookup_elem code into __lookup_elem_raw.
Use offsetof instead of sizeof for key_offset assignments in
htab_map_alloc (patch 1).
Eliminate branching and htab_elem casting in htab_elem_hash /
htab_elem_set_hash.

Changes in v3:
From Sashiko on torn reads/writes:
Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of memcmp /
memcpy for atomic key comparisons for hashless elements.

Changes in v2:
Make maximum key_size for !has_hash depend on word size for atomicity
on 32-bit.

From Mykyta Yatsenko:
Put the htab_elem* common initial sequence in its own struct (htab_node)
and reuse it across all element types that share it. Eliminate
associated BUILD_BUG_ON additions.
Replace both the hash and key fields with data[].
Store has_hash in struct bpf_htab, and avoid per-element reads of it.# Please edit the description for the branch

T.J. Mercier (2):
  bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
  bpf: htab: Reduce elem_size by 8 bytes for small key sizes

 kernel/bpf/hashtab.c                          | 418 ++++++++++++------
 kernel/bpf/map_in_map.c                       |  13 +
 kernel/bpf/map_in_map.h                       |   2 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 4 files changed, 289 insertions(+), 146 deletions(-)


base-commit: cfce77b63375dac81d53f2f85593c548415206b7
-- 
2.55.0.691.gc56d675ccc-goog

