Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E941A781
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969341; cv=none; b=ax8lCjYg/mjYo3hUY4M9aptUzvY9+HFqxauJE8bbH06XER7y125RZKfE7T0SxU2JFApzYhJvmWCfVwKztvGkxHzswvDYpDbEwaZ8A4ke+rxtGW0vIbKxIKgAeRS4oBUzDrwc5x7DnFibjIv83uUM1sd54rfl4t3eDxuh7A7F50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969341; c=relaxed/simple;
	bh=xJeNRahdX/8Rc46MCXYeurzbnS+yibcj8V1Znrf9izw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K8hVXhS5/VAl4GHFvzskv4P8rDYE2xVS8gbJAmD2e8bBBdz7cIDB+YVRB25fAopmN/riPtUW0Gy0ETaYE1oAX2hjS8zLgoHnbiAo9t7wql1aW3c46RGuGVj83O8Z7XvIEpbGu/OLOQk2kfZzcj6TuMA8YZAkXK7Fcs7NxfIjfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wj6y9YNF; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wj6y9YNF"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so2936465a91.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785969336; x=1786574136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c4uO56/MiHGLO7v9TSoyM8Bxoi9kR+e2Py4dNtpahnw=;
        b=Wj6y9YNFQppcDYpyAfI8vS/FNRshaKPHxsef8DsK3lRkQPFHbT25TUYvx04uSGN0g3
         mEKFeCs2wo4VMhfEwuUbmLm6obtaAbKHKaKdiv5IIyds5zfAThcigi19x8/tqHbBoAei
         JZYCsE+2+6uRmJbjln9TU0pIiN9BcXrf/9XYJce+oJMnI6dYKHQ59zv2AVRlrhFy1CY7
         BZdtBCp3pPHdh3NdHN3XIAG3jxOzowP6OLlpJ0+pWBtTWas68hZlM/OqLHYK1MChXrIm
         42BlQ05+UkO/7TXb1EUGouuEhl4EK82hwx4NadhAm8+dpIrL4HINlA9vjvmLLL+pN2Xm
         evCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969336; x=1786574136;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4uO56/MiHGLO7v9TSoyM8Bxoi9kR+e2Py4dNtpahnw=;
        b=fQ5Csj66jk14/dgnhGX1gYUHLYSPLvL1Jz3eDeuNghIFSyM02YSgKdfBSJh6xgMLU+
         FjQBJxN/7Fu8vs/ixwCS24aefqDMnpvRfPYOXk22B7/96EQcZO4oW7HzC2jmVeU3IBlC
         wd2awPkzqShuL15920+2Jp5RDgHOAvA/VKV4rxHojymJkYIxtg2lDWNp6w9aNwyaOBlZ
         R1hPziWRiuBf8ZwiWaihTeLbcVEG67XbBE6SUp21UxOogIrUe7RaNCeT27GQcZQhLSAQ
         XNJOWwS0gxXFVBApCj7H4k8duQp57WVs8U49hXZA4NIA2vVfbY5OQfkAhB4WFmr76xpE
         Abvg==
X-Gm-Message-State: AOJu0Yx+TdnMvlnfhC4dkp9WuQbiyiXwIxGcR9FZtirV19+m2cs/rZtb
	G2OcpztfL3GtisYk9h+hnABlQVBizBSPt8K0oYbZXuJ8dGV/RLYcpAU2gce8sIT6PMeKjEUAKRv
	KPu/GokQ01YCkcCwnTQ==
X-Received: from pjbpl12.prod.google.com ([2002:a17:90b:268c:b0:38e:68b2:e344])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:264b:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3903c58a6femr11395298a91.12.1785969336087;
 Wed, 05 Aug 2026 15:35:36 -0700 (PDT)
Date: Wed,  5 Aug 2026 15:35:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260805223516.1495988-1-tjmercier@google.com>
Subject: [PATCH bpf-next v3 0/2] bpf: htab: Reduce memory use of hash maps
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
Changes in v3:
From Sashiko on torn reads/writes:
Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of memcmp /
memcpy for atomic key comparisons for hashless elements.

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

 kernel/bpf/hashtab.c                          | 426 ++++++++++++------
 kernel/bpf/map_in_map.c                       |  13 +
 kernel/bpf/map_in_map.h                       |   2 +
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 4 files changed, 299 insertions(+), 144 deletions(-)


base-commit: cfce77b63375dac81d53f2f85593c548415206b7
-- 
2.55.0.654.g21b8a5bc05-goog

