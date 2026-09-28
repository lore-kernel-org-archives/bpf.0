Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E83377A9B
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577633; cv=none; b=bVxQtblmHizeuCOUZ7nbDfLJCOttET03FSf/SImLFXRsXdmpRYk3S2UCe7+gWUkTvBiZQOUwniWO7+HJTbu1/uYzEIDhti4BpledcVFNku/iQ2cj59YfW7enG6ug333Oj1i1O7mHL18EWfy6Fjml3bXV5CmmAkxxEWKq+2Lmjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577633; c=relaxed/simple;
	bh=i3gIs268gdoCWVOLzJLlKHIAKUk7YTLWN+5Xd4RZHc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ed3fhw427z5FpxtUJTSXmaYLwCf9ntyG5Bq9OS730dJ1BgmAzFr4el5eoiYnUpyirhE56VrdLcv4qN2VaGVFIzXiuxZCsi5zOJ+AoY+WbvNfBh4jWrT65RwSdYb7+Ww3Ta35jldgxUQHe0jcXJk4S1f6htcnVZMklvH81A/nuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWvLKBPE; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWvLKBPE"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a47a81e70bso347345a91.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 23:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790577631; x=1791182431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VlsdDnm5TdyjJ/bAhebBmyPQQ0m17pxNjzMIRaTMew8=;
        b=AWvLKBPEUU3AvruYCb06P4jR7z/MJRDqZsuqXvNqtRuKcwEIsYhCirmnCdq9x6zxne
         tjaT+Alyxg0qIvflF1SJbPsMaT0JRTaiNjydkVbXWptZ1aemH0JE0ggjA07LlECQIu3z
         PcGQfJzHS2Klrjl7sYo/sVJWuRxNd13nSO7/9CPoN4Bmf2Lq4MHcTMOa655ypjS+b2/7
         D2WCP2Jzletj1lT/jJtEpLGfRG6Nvnt0QP+VzkOqA2zQBQSpT/VvyUtObI1ef/Xk5cWi
         iULuQCYjfBj48mnTL3TGeoEQQrvpLwOV0LyxUD09BZB/dzc0cb5O93SiEqKsH9kwonPn
         YnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577631; x=1791182431;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VlsdDnm5TdyjJ/bAhebBmyPQQ0m17pxNjzMIRaTMew8=;
        b=bnZgV7q8ODp0ANjb9/aRNGaNBMg/+p5OMzvFf8wick9UC/NEvsWAgcwhKWIyKN7HiF
         z1gbq1+E3Ftcd08aAqVCALIr15jc3jjwjWpRDCpStBZ9GyU4TaufcMgDiieJtWXTJbow
         hebHKkB4+AhS/Br1139w4vKC2pvmCIwWN63orkxjin6genbIVVqiwPVhPvo1PwZreAxE
         828EeAmhw6bmgixcRqrTaDt9cGtmse8MujQ1GKXm4EBDKKE6NAyk2jloHugIUZgkph4Z
         cHFjUChZGSJ5ABn0mnm2Cy4wTW/H8a5ZwgJZddYuduCPPdBoh9qXjLfFKmgZupxKCHvh
         YcQg==
X-Gm-Message-State: AFq9FYKP9qBkKRHfQMiHAMgZHUzy2DnfnnFyKRJUFPViSXTUi+/aNrHt
	kAmEvdtKLUOCOGoztZ/0bW2tl8nDvDa91L1NRjJ+L/9x0xYrPkWQ/GdC+qZEpVJQP1ZHIjHdklR
	ZY3ERoJsBfTTxuw0GCw==
X-Received: from pjpo10.prod.google.com ([2002:a17:90a:9f8a:b0:3a0:3b12:2b64])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b90:b0:3a0:cbe2:9e00 with SMTP id 98e67ed59e1d1-3a0cbe2a110mr6042122a91.42.1790577630805;
 Sun, 27 Sep 2026 23:40:30 -0700 (PDT)
Date: Sun, 27 Sep 2026 23:40:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928064021.1433277-1-tjmercier@google.com>
Subject: [PATCH bpf-next v6 0/2] bpf: htab: Reduce memory use of hash maps
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


base-commit: b99f71407ce529ba01a9392f477522d2e76c6613
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

