Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540B3749E1
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607688; cv=none; b=bVFcO59vriV5F7c1WKFVZCscCl6cKiSmNevHA6kvraKm+WOYosHYK6dK5gavpHbnvlgBt13AxEjll6qSAqU1WW9BnScpObXnRt8k87rucwd8Dm6Bv7cGtT9ixcN80rlASf1D34TweIoZvenBGQWIiztbRs7IAmoEsG3HM+SvszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607688; c=relaxed/simple;
	bh=jdQOpTd1yKVH2Iw9b4utgOqc6ic9XH0J/Yb2gcTPXtM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K+bmxjV64E8TtiBsT1mHG7hY4iBvC5+QsZotvk7a/p8SpFemPPMUdHv4f+7O7MzuVuB9czJP7sJMt7Zeul9gIgLsLKmg9W5RAaR8pIsApM1LcuLnRjjx+jnQ3/ZxNPcn60so7Xmj2iZtHhbNQJm6hiuj/W/87VJHYlUn5yN3k0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB+jOAQ2; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB+jOAQ2"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8699b293a80so1795254b3a.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790607686; x=1791212486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TnFki+BLJa1RwxDmrHE/Ki7U3AU1ZKVEEJDLyRcwiMA=;
        b=fB+jOAQ2GgrTNvh/M7NyBkoImGJ2g1cKsg1SuHFgxUsVX6EtaZ/LlkRu2lmNvVZBaG
         Xa0cncKvtEnmFy2zkDKXOgGJF/enJEG6uvARZOeUzLLqtaNWrtmWShFVnwtSncomZA9J
         G972w26Xz/0egdtm52x1N0t3G+yd5bnOWQRM2NbYijYlHHDmp71kgU/clTgZCiSJxUrI
         vuE4dSB1TprWTj4RfASvVnSHGPXLMC11+z5TxOWsqtrc6bDwGxNFlgQ3W5iJjkBTlzn9
         iIXoNEgN/rfym1dfpgBSlZInCLiGoYyFLNpb55Uij6gGUU1Z24N4VhnjYAevpGoEu59j
         HiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607686; x=1791212486;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TnFki+BLJa1RwxDmrHE/Ki7U3AU1ZKVEEJDLyRcwiMA=;
        b=I/1tSi1LZEDva5/9GwVLBo59evsk3KUNVkGffm2K8YF4SdqHv+29YbYeg6WTTlsGwu
         XlxDPiC2Q5xWjnYhUGjhmZvEwdILgA6pLdN0ooVyN3+6rNLsqjY5RRVecOuI6rjHBv2z
         wQxRQZazVKHVDu3WJ/sP2g56yLVVQT2eUQdy3afZz47wl84xA37s75Zt4wPbVsL8p08C
         l2CvGAZ6p7y2GLIXtZpKX0UmiijW3WMawU3kx6wxPwknGfIOlYXLUlmwinzcOweDvwq5
         lqBRs5wjsDqKzQHkUN6O3riZW3a9FO2gj3pwzQ2YBN0EApWZbj1Pq92l4rTnSlYri4lh
         B52Q==
X-Gm-Message-State: AFuF++kqlIdUfPM9H2vMQNV5JE7bvdM5bCTb/k1C0qPifu3ZRuqzefaq
	jLGHkMAWzjCoDKzt+HJfrdbPTs1m6wfJKPhLZMwpRrBlRrcSc1ozt74nBiMxUMqPlOMAo8o535H
	3ixuQNrQZkEk/1zrAcA==
X-Received: from pfki17.prod.google.com ([2002:a05:6a00:51:b0:881:464e:33be])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:138d:b0:881:7ff5:605c with SMTP id d2e1a72fcca58-8817ff562d9mr5296272b3a.55.1790607685619;
 Mon, 28 Sep 2026 08:01:25 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:01:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928150121.1712559-1-tjmercier@google.com>
Subject: [PATCH bpf-next v7 0/2] bpf: htab: Reduce memory use of hash maps
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

 kernel/bpf/hashtab.c                          | 320 ++++++++++++------
 .../selftests/bpf/progs/map_ptr_kern.c        |   2 +-
 2 files changed, 226 insertions(+), 96 deletions(-)


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

