Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026264EF15F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957874; cv=none; b=J36g6K6EV9J0+zaCUJu8IhqsY0gea4vvQhFd/xwI3IM2WqbW+Vaverd/Dk46acLzWup6EXlS/x33z20kBThMvElgfKXdozK5ZQe7xeHmNoiLCefg9hs8fvPWIru7cK/aXm2ROIl6xiI5tnYER5RIOWFcdk8CkvqltScOZNm421Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957874; c=relaxed/simple;
	bh=tRBt0mtovo3pO08mgZMoD6QVvkZ5wMLxMsep83IjQCw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MvCYeoAbugsuCadh3L+tLnCQcX9+bvUiIdLeElJI9/Ch7RUOy+tT28+RUw9CxSy6f2SnGztPO9zBYReDOmOLXoLAYmHRVKwDo6GwS2Pt7kXdWNvIuENI0prMgNvkJtIo3uOTfWs9zPa2ucX3bLfAH+VFlf8GfNyFVpJDpQGDjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vovUbmif; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vovUbmif"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4aa263a4aso4042848a91.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790957872; x=1791562672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aL8AHrs8WD9iA6YXUKLcpjBNMTQv0moe1DEYqLjJwE8=;
        b=vovUbmif6eZUiX99awt52/Sc2mnwDibV+YiiRYrIqJ9SXwLDtQlxlyM6E91yQiqaAp
         l+Fu0sh6dArLCmk6RBN3u7XdsSRp3SxUe48WLQysATDTUssGuVvtGX6L6C7aXCYoY6Ma
         9yPr/mO+xnnMiJ8TBjs3goRcS9QQOcOnBlnD3d3BPDiAHD0LpexCC0eJagIJsgqPH6Wm
         Bo3IA0OBRs+b14hhGSwg8h42o13N/B+r0FjGIwtIJZ0gO9mJYdiER4inxDPIr0BoQviG
         F4j6YzACWAg6vJZmX+xhGi0do/tgLS0boxZdWv3N9K7xTK1qrB+HdIzVJUA/YiZNL7XC
         IHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957872; x=1791562672;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aL8AHrs8WD9iA6YXUKLcpjBNMTQv0moe1DEYqLjJwE8=;
        b=CabxUtsjte4NGDyzE3PAxn2L7AgfnVJL4UZPTiyxGD6LDtbEVOa27rxNZ1TdUT/bPH
         IcvYpXuc17PxyCZQvYbhziKikcrorO1fRbyIa3lDWn2HiDOZkkezdoLThrdYr/mZPAkm
         2onFALjb7J4eaip2vlCST9tPOGiE27bLpv8shhY5RBZFbz2xGprcn+d0rUEVYlbljSsC
         9L6k9cnrDW8dUp+Eo3M1GcxckIGM0KOepDoiv8sps8B5HDv9VRv+VlBjtYA6VZq+ttz3
         U/UE96EMFcJ1a+ghMY4l33XMJfDmyfOsk6GSGMP4btLjjm4uFYzcvnaIobhyET8wQ1mP
         zGWg==
X-Gm-Message-State: AFq9FYJ5fRzxVHPjxNGyC/kWmmzIo/XBEb4kKS23hdSkBk1DEhcmzvAy
	QKuDtIcKt9SJSO2pzi1YcxnVloGdYQ07DqktQk8UTslaMiE+EIw9KjRJUoTpfZG2DvVo6G68znc
	dPXevquZnougtBPmRSw==
X-Received: from pjj12.prod.google.com ([2002:a17:90b:554c:b0:3a6:f9be:dc6])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b81:b0:3a5:25e:85fc with SMTP id 98e67ed59e1d1-3a6cec215c0mr3166900a91.63.1790957871715;
 Fri, 02 Oct 2026 09:17:51 -0700 (PDT)
Date: Fri,  2 Oct 2026 09:17:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002161738.621133-1-tjmercier@google.com>
Subject: [PATCH bpf-next v8 0/2] bpf: htab: Reduce memory use of hash maps
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
Changes in v8:
Add htab_elem_lru_node (Sashiko)

Add Mykyta's Ack

Changes in v7:
Rebase on bpf-next/for-next. Resolve conflicts with 63b13537e6b2 ("bpf:
Speed up htab lookups for u32/u64 keys")

Changes in v6:
Make htab_elem_set_hash branchless like htab_elem_hash

From Alexei Starovoitov:
Drop smp_wmb/smp_rmb and WRITE_ONCE/READ_ONCE on hash
Drop map size check changes (just use sizeof(struct htab_elem_lru))
Drop BUILD_BUG_ON on elem_offset

Changes in v5:
Rebase on top of bpf-next/for-next

Update elem_size check in map_ptr_kern selftest to 40 in first patch
(Sashiko)

Place hash at constant compile-time offset before htab_elem, to allow
removal of key_offset. (Andrii Nakryiko)
This avoids dynamic htab->key_offset load and pointer arithmetic. The
struct declarations got reworked to implement this, and htab_node was
dropped. All map_in_map changes became unnecessary and were dropped.

Fix key update before pptr, value initialization for recycled elements
and lockless readers. (Sashiko finding on internal run)
Read / write memory barriers and READ_ONCE() / WRITE_ONCE() were added
for this.

Combine rhtab_mem_dtor() and htab_mem_dtor() implementations.

Fixed the KMALLOC_MAX_SIZE overflow check since sizeof(struct htab_elem)
shrinks in both patches.

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
Store has_hash in struct bpf_htab, and avoid per-element reads of it.

T.J. Mercier (2):
  bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
  bpf: htab: Reduce elem_size by 8 bytes for small key sizes

 kernel/bpf/hashtab.c                          | 308 ++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 215 insertions(+), 95 deletions(-)


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

