Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F4496D53
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456078; cv=none; b=E8Etw+wiubvB1mUzPRYUcjZEgX1tmia+buGxsgmIKQRTP5d9skOqJRmk//iTx2POafMylfaa+1tEDNNg/+6wB1Y2pdZ5asCH4EXsKQvER8OP5cpBMomUa9yv176Mxii0ckNbSWWUwMUno97OtbWMUgZgtmYrwqsWui9v0yky+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456078; c=relaxed/simple;
	bh=SI7BL7uYLkz4VbjcwL70zImQMlgXNgcKimnneK9XbZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=an8XTqDG6swKHbgFL9sLQGWoNNcs6I36Ia6aJpyFa6W+SF98+VPr2KmJfwhejryFLLG6ojk3kvZ0Lkd4pOXi8yyDETtabSiQeasjQnfGYRI99Riaj2UYnoQn0ui2A2Ma+hEp0v4LXb2kHlolVv1TX/XsW23xZJOzyof2U/uwgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GU/QFMla; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GU/QFMla"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso858780a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791456076; x=1792060876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GI25BZ68P/4aQxot5bwfTnmhOzS6eEcht3VnVkOl1sM=;
        b=GU/QFMlaDxxEYG5WZa5+ghcvsV1Cn8mPjzEv4wHcAxstjIQkuz5aeenF7SrODT296F
         xZjJoTtloX8vdCJjwT+G0esegEnGRrAquaijHTNc66xXmptAgGGmJDsbH5NcjOiINKBS
         hdRMBclFLUq/VfdfmpbLKH5EmsLJQK9WYLwkcOIXM6eGvoBMNxT4/hHSww/ulS8r4tFQ
         ne0C8qcGbKI6qs92jbt6VJsx3ayf3d797/OO1o+xK3qCzFd1o7uc4o8vqV0ln8pZnbof
         xVKLvnWmmJnzeaNhc8/xFqr8qYWoJFc26vTYJmdO3UlZDkdGgkWFyjn7MqKYs/K4qMt0
         abng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456076; x=1792060876;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GI25BZ68P/4aQxot5bwfTnmhOzS6eEcht3VnVkOl1sM=;
        b=ZTRmuC+v8zslY9fhkiylMUrnElSU5oYx2/J5SPmW4uE6+jsGvY/kmL52zvXyhuDeNj
         4BEzKt1Av1KovODoT7N0XQAbZJM70hi64i8yKLn2MqzvD4qqIsA2cDn7NybzOIL5yeNR
         Pzo7dRBynrz1oYYZVLij9b0S1qeaSx0z8UteQ9DsjkwQ44YozUAKn2KZu6RXoH8L5OW3
         oJ6u1msSGN4VVbchbumKDHlGrhIqaHlmAfi/VLngfhWZRv24n11TdMbZBOiI+pvEWZGg
         UrIL8NNmA+FHdpEX4VDPp3hAIL+4eoiiQTOyyWVVpV8XIeg/SObU26Htn6Q8P5PH9puG
         0TGg==
X-Gm-Message-State: AFq9FYKQoAIDZR+eK1Sz9vL5XXJU031lLdrbHd4L2qPurCYUtLdbu5Io
	2iGbzFi4M/cRVe8qtaojRTMuOTKrxZvw/WIgGPyiMfrbGZ9rXN8YwdGlxxqvutegn9MnlYOgq9g
	1ffkNP7oRE002OjBhTg==
X-Received: from plbmt8.prod.google.com ([2002:a17:903:b08:b0:2e2:f0cb:8c1e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d0d:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3a8a0728aa1mr4735755a91.14.1791456075984;
 Thu, 08 Oct 2026 03:41:15 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:41:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261008104108.993791-1-tjmercier@google.com>
Subject: [PATCH bpf-next v9 0/2] bpf: htab: Reduce memory use of hash maps
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Memory is expensive and scarce these days. This series reduces the
memory use of BPF hash maps by eliminating the per-element overheads
below. This saves up to 50% of per-element memory use for standard and
PCPU hash maps. The memory use of LRU hash maps is unaffected.

Map Type & Configuration           | Old size | New size | Savings
-----------------------------------|----------|----------|--------
Standard (key =E2=89=A4 8 B, val =E2=89=A4 8 B)    |   64 B   |   32 B   | =
50.0%
Per-CPU (prealloc) (key =E2=89=A4 8 B)     |   64 B   |   32 B   | 50.0%
Per-CPU (non-prealloc) (key =E2=89=A4 8 B) |   64 B   |   40 B   | 37.5%
LRU (Any key/value size)           |    -     |    -     | 00.0%

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
For hash maps with small key sizes (=E2=89=A4 word size), comparing keys on=
ly
requires a single instruction. Currently the 4 byte hash value (8 byte
aligned and padded) is used for this, but offers no performance
advantage in this case and can be eliminated.

The implementation splits htab_elem into dedicated structures for the
different map types (htab_elem, htab_elem_pcpu, htab_elem_lru with
hashed and unhashed variants) so that the map-type specific fields
exist only in structures where they are necessary. In all hashed
variants, the hash is always at a -8 byte offset from the start of
htab_elem. The elem_offset map field supports the different sized
element headers, and allows dynamic offsets to be kept out of the hot
lookup path. It is used primarliy for allocation / free, and indexing
preallocated elements.

run_bench_htab_mem.sh shows the following changes across 10 runs on my
3995WX.

Benchmark (all in kops/sec)  |  Avg. Before  |  Avg. After  | Delta
-----------------------------|---------------|--------------|--------
prealloc overwrite           | 116.26 =C2=B1 4.3  | 118.81 =C2=B1 4.2 | +2.=
19%
prealloc batch_add_batch_del | 128.43 =C2=B1 3.6  | 128.89 =C2=B1 2.9 | +0.=
35%
prealloc add_del_on_diff_cpu | 22.91 =C2=B1 0.69  | 22.44 =C2=B1 0.62 | -2.=
07%
normal overwrite             | 72.43 =C2=B1 3.13  | 81.06 =C2=B1 1.49 | +11=
.9%
normal batch_add_batch_del   | 45.20 =C2=B1 0.78  | 50.09 =C2=B1 0.56 | +10=
.8%
normal add_del_on_diff_cpu   | 12.02 =C2=B1 0.24  | 12.80 =C2=B1 0.18 | +6.=
49%

---
Changes in v9:
- Rebase on bpf-next/for-next. Resolved conflicts with ab39974240a0
("bpf: Hold map BTF for the memory allocator destructor record")

- Eliminate warnings from old GCC versions about possible OOB memcpy for
key zero-extension on 32-bit by using min_t with sizeof(dest) for the
dead (runtime) !htab_has_hash() branch in __lookup_elem_raw.
Now elem_has_hash replaces htab_has_hash() and no code is generated for
that dead branch.
https://lore.kernel.org/all/202610031215.ybqsLvSp-lkp@intel.com/

- Return struct hlist_nulls_node * from __lookup_elem_raw.
On W=3D2 builds, the following warning occurred:
    include/linux/list_nulls.h:57:17: warning: =E2=80=98n=E2=80=99 may be u=
sed uninitialized [-Wmaybe-uninitialized]
       57 |         return ((unsigned long)ptr) >> 1;
          |                ~^~~~~~~~~~~~~~~~~~~
    kernel/bpf/hashtab.c: In function =E2=80=98__htab_map_lookup_elem_u64=
=E2=80=99:
    kernel/bpf/hashtab.c:871:34: note: =E2=80=98n=E2=80=99 was declared her=
e
      871 |         struct hlist_nulls_node *n;

That is because the compiler cannot prove that __lookup_elem_raw()'s
out_n pointer is always initialized when the if(l) branch is skipped in
lookup_nulls_elem_raw(). Returning struct hlist_nulls_node * allows the
compiler to see that n will always be initialized, and also that
is_a_nulls(n) is always true for fallthrough case. This also eliminates
the redundant !is_a_nulls(n) check that hlist_nulls_for_each_entry_rcu()
already runs.

- Deduplicate key zero-extension with new htab_zero_extend_key helper.

- Update htab_elem_pcpu / htab_elem_pcpu_hashed docs to clarify the
unhashed variant is for small keys, and the hashed variant is for large
keys.

Changes in v8:
- Add htab_elem_lru_node (Sashiko)

- Add Mykyta's Ack

Changes in v7:
- Rebase on bpf-next/for-next. Resolve conflicts with 63b13537e6b2
("bpf: Speed up htab lookups for u32/u64 keys")

Changes in v6:
- Make htab_elem_set_hash branchless like htab_elem_hash

From Alexei Starovoitov:
- Drop smp_wmb/smp_rmb and WRITE_ONCE/READ_ONCE on hash
- Drop map size check changes (just use sizeof(struct htab_elem_lru))
- Drop BUILD_BUG_ON on elem_offset

Changes in v5:
- Rebase on top of bpf-next/for-next

- Update elem_size check in map_ptr_kern selftest to 40 in first patch
(Sashiko)

- Place hash at constant compile-time offset before htab_elem, to allow
removal of key_offset. (Andrii Nakryiko)
- This avoids dynamic htab->key_offset load and pointer arithmetic. The
struct declarations got reworked to implement this, and htab_node was
dropped. All map_in_map changes became unnecessary and were dropped.

- Fix key update before pptr, value initialization for recycled elements
and lockless readers. (Sashiko finding on internal run)
- Read / write memory barriers and READ_ONCE() / WRITE_ONCE() were added
for this.

- Combine rhtab_mem_dtor() and htab_mem_dtor() implementations.

- Fixed the KMALLOC_MAX_SIZE overflow check since sizeof(struct htab_elem)
shrinks in both patches.

Changes in v4:
- Removed inline from new functions per BPF CI (netdev/source_inline).

From Mykyta Yatsenko:
- Factor out duplicate lookup_elem code into __lookup_elem_raw.
- Use offsetof instead of sizeof for key_offset assignments in
htab_map_alloc (patch 1).
- Eliminate branching and htab_elem casting in htab_elem_hash /
htab_elem_set_hash.

Changes in v3:
- From Sashiko on torn reads/writes:
- Use a local unsigned long and READ_ONCE / WRITE_ONCE instead of
memcmp / memcpy for atomic key comparisons for hashless elements.

Changes in v2:
- Make maximum key_size for !has_hash depend on word size for atomicity
on 32-bit.

From Mykyta Yatsenko:
- Put the htab_elem* common initial sequence in its own struct
(htab_node) and reuse it across all element types that share it.
Eliminate associated BUILD_BUG_ON additions.
- Replace both the hash and key fields with data[].
- Store has_hash in struct bpf_htab, and avoid per-element reads of it.

T.J. Mercier (2):
  bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
  bpf: htab: Reduce elem_size by 8 bytes for small key sizes

 kernel/bpf/hashtab.c                          | 341 +++++++++++++-----
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 243 insertions(+), 100 deletions(-)


base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
--=20
2.56.0.385.gd3acb90ef8-goog

