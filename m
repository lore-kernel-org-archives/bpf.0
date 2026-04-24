Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6330B521
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060270; cv=none; b=fxs7hLfAINDv9lDWDFJ5cNwJwj5oDjGmizT492DfR2d75tz6is6hnAMPpnaajboaB6QLsw3vE63Ta6wVb488X/DcVH+K+7xi8lGBizzxXvh19tXpFGj7hquJgOW82Gry0ViwI+wKG7RtAYgriRLa+9KkoTN9LfTEMi2y1PbV2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060270; c=relaxed/simple;
	bh=eTaS5NEhVX8HlxB9DqrMLb3sBic3Bj8f8jAOgArdZtE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSxOZ/0qIXnbXSq7uFLBrTSQ+vKJ4cIasuMKlhTDuPHwLg7Dy4WJtuKp9LuZuy6xVj6rOvoOGzbPTIIsiPrrXwTlTER1coq4IkshutK/S62oSHOBqL2Sbb4MsendMYMvB3vYDWKReljDdg58KzJzwU6G1ZE9aZAo6ox8B9NiyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH7trFYm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH7trFYm"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a337552604so7538435e87.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060258; x=1777665058; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNz6jGXubYBf0ZZ8cwdTjXQJv5UYW/G7Uw3N7cO/04g=;
        b=AH7trFYmLh08f2QcPcUTooJAH5kX2fRO+2QOtbXq/SmPpgrDd7K/iy0PrlJ2vA9RUJ
         9ejB8AeJNBml2vcO9x/l4x2ZhA3cbgqgBZlfRnCCoHEgooYMfSyGWyBV2Ip2iIUKlrGr
         S4qoe7un9ZVxHXs7lwnxDOpuxM7EDGoThqr1k5JfDlYvmymdYOMDbGzktX9/gEy4v7YP
         wFjkXuhROP8fQojLwlVrGjOpmg2hnBb1LWQkEWYFODVWthDk1tvXAi4sbotCf4JaJ+zw
         /0DqspyByYpxFtFz4noX2bB9pEnc5kkRQF3lwWhCmRc/FT8wHOq/50CqoEmSZxSjy176
         TH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060258; x=1777665058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNz6jGXubYBf0ZZ8cwdTjXQJv5UYW/G7Uw3N7cO/04g=;
        b=JSlBwUO8owiNoM8l8Cim7vj6zfcNWvmpDQuwSss83BG1C3A9qlLUTkHmkMFEzFY6nH
         ShmrcOtvHc0tQb6pWGxZAGOcuTqMW1c73RZpuOye3zmj9BTs/BYxPYSJr4ldvqc1gPCJ
         +7/bgadbgj6rhv5II88TFSPpiLxCB1idinraKNQ2QJimscXl3/vNusSHBkGq6Yl10M3a
         Zcaw1Pc7mDjBusENI+XfYDYS5gpT/np97WIOJRH++EDEe2gHYv71/Vy9mE4JQRwXeoPa
         HZrpw9Pm6uWW/5qp/OwkY8gvzP7BzHAdL2wXuj28bgI/qmKCDl0YRKtr+xiqnQ7BGGGT
         Ajkw==
X-Gm-Message-State: AOJu0YzV9k5FS21glRLeVfEARrYEsomRpkDQGmThYrVBO8sn6QaNyCSc
	dqPfItiWrAiV0QtcxYp2aRjFmeNPEVv0YF8FVPtxDrWhpyBe57lFu44s
X-Gm-Gg: AeBDiesSd/hmFngiAEQs05iiHZNQhRxxXCqiA0cxVcGNSWLEdzqm7kMgA/NWPEz/XzZ
	cPc1FXqCAApddRACCSd2dljatZ47fbGWThR7memawAau56zvuw5iCJ1h36Q3F+hJQ5f8yP3MH+C
	PWo/3yOcWaSnzHMbvZ2sjvR3cp34YG0bkg5VUC/B589PpsjdoW+dofLUagq9R33E3LaP46SjNMB
	pNiFfOhmudJz+WsLIEQaJE4JwKrYdKefFkpwkVvW4LGA56s2VW0+ZNp+UD8rnmdIzjUA5EUPUSV
	zQXnUQcnolKaruiWcnTMIf4tt+Y7lXfIa4z0Lizaxd1zx3bogW1RDybpgF2PmzFw8cglYn8NWi4
	AsWdTT342KEgK8/7xTxXgjOKKnbDcJcQCxqO8YpmL2355hvRSvMzh55OLj5FOQB1P3yNstSyOUi
	aVKQs5aQiez1luBJ+0F286D/Tx
X-Received: by 2002:a05:6512:33d3:b0:5a2:ad56:db25 with SMTP id 2adb3069b0e04-5a41730a3f9mr10052833e87.45.1777060257542;
        Fri, 24 Apr 2026 12:50:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:48::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a41abceab0sm5923277e87.61.2026.04.24.12.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:50:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 00/10] bpf: Introduce resizable hash map
Date: Fri, 24 Apr 2026 12:50:42 -0700
Message-Id: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLJ62kC/03NSw7CIBSF4a2QOy7mcmnpY+Q+jANaqDDoI9CQm
 qZ7NxKNjk++/xwQbfA2QscOCDb56JcZOiYLBoPT88Nyb6BjQEiVECh5cDo6Xvc1ompbkqaBgsE
 a7Oj33LlBv458tvsG94KB83FbwjMfJJF3QlJIWH1aSXDkEo1RRsmhVHSd7KYvwzLlQKIfKrH5I
 nqjXqq6MlqMyv6h8zxfwTPy0dgAAAA=
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=13679;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eTaS5NEhVX8HlxB9DqrMLb3sBic3Bj8f8jAOgArdZtE=;
 b=wiTEnmdp1FDl+lLpDYMdE5MquaFYm/sU7KznNeBTqidiRvD38vkXc0vi/QIG4Gcn6girse3ca
 WmHXv49wrCBCbRJQEDnuyoJz14zM3bYevEEkTxMBU8jEP1z+X7T0/aL
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This patch series introduces BPF_MAP_TYPE_RHASH, a new hash map type that
leverages the kernel's rhashtable to provide resizable hash map for BPF.

The existing BPF_MAP_TYPE_HASH uses a fixed number of buckets determined at
map creation time. While this works well for many use cases, it presents
challenges when:

1. The number of elements is unknown at creation time
2. The element count varies significantly during runtime
3. Memory efficiency is important (over-provisioning wastes memory,
 under-provisioning hurts performance)

BPF_MAP_TYPE_RHASH addresses these issues by using rhashtable, which
automatically grows and shrinks based on load factor.

The implementation wraps the kernel's rhashtable with BPF map operations:

- Uses bpf_mem_alloc for RCU-safe memory management
- Supports all standard map operations (lookup, update, delete, get_next_key)
- Supports batch operations (lookup_batch, lookup_and_delete_batch)
- Supports BPF iterators for traversal
- Supports BPF_F_LOCK for spin locks in values
- Requires BPF_F_NO_PREALLOC flag (elements allocated on demand)
- max_entries serves as a hard limit, not bucket count

The series includes comprehensive tests:
- Basic operations in test_maps (lookup, update, delete, get_next_key)
- BPF program tests for lookup/update/delete semantics
- Seq file tests

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Update implementation
---------------------
Current implementation of the BPF_MAP_TYPE_RHASH does not provide
the same strong guarantees on the values consistency under concurrent
reads/writes as BPF_MAP_TYPE_HASH.
BPF_MAP_TYPE_HASH allocates a new element and atomically swaps the
pointer. BPF_MAP_TYPE_RHASH does memcpy in place with no lock held.
rhash trades consistency for speed, concurrent readers can observe
partially updated data. Two concurrent writers to the same key can
also interleave, producing mixed values. This is similar to arraymap
update implementation, including handling of the special fields.
As a solution, user may use BPF_F_LOCK to guarantee consistent reads
and write serialization.

Summary of the read consistency guarantees:

  map type     |  write mechanism |  read consistency
  -------------+------------------+--------------------------
  htab         |  alloc, swap ptr |  always consistent (RCU)
  htab  F_LOCK |  in-place + lock |  consistent if reader locks
  -------------+------------------+--------------------------
  rhtab        |  in-place memcpy |  torn reads
  rhtab F_LOCK |  in-place + lock |  consistent if reader locks

Benchmarks
----------

Lookup performance (bpf-rhashmap-lookup vs bpf-hashmap-lookup, events/sec):

  key_size | max_entries | nr_entries |    htab   |   rhtab  |  tbl load
  ---------+-------------+------------+-----------+----------+------------
     4     |    1,000    |    500     |  17.22M   |  16.92M  |   50%
     8     |  1,000,000  |  200,000   |  15.21M   |  13.39M  |   20%
     8     |  1,000,000  |  700,000   |  13.16M   |  13.62M  |   70%
     8     |  1,000,000  | 1,000,000  |   7.93M   |   9.52M  |  100%
    16     |  1,000,000  |  700,000   |  10.77M   |  11.85M  |   70%
    32     |  1,000,000  |  700,000   |  10.24M   |  10.69M  |   70%

rhtab matches or exceeds htab at higher load factors and larger keys.
At full occupancy (1M/1M) rhtab is 20% faster since htab's fixed
bucket count leads to longer chains while rhtab resizes to maintain
a healthy load factor.

In-place update (bpf-*-full-update, events/sec):
  htab :  7.62M
  rhtab: 14.94M  (+96%)

rhtab updates values in place via memcpy; htab allocates a new element
and swaps the pointer for each update.

Memory (htab-mem / rhtab-mem, 8 producers, overwrite workload):

    value_size |  ops/s  |  memory  |  peak memory
    -----------+---------+----------+-------------
    htab    32 | 18.27k  | 0.98 MiB |  1.24 MiB
    rhtab   32 | 27.05k  | 0.99 MiB |  0.99 MiB
    htab  4096 | 14.00k  | 2.23 MiB |  2.23 MiB
    rhtab 4096 | 17.00k  | 1.99 MiB |  1.99 MiB

rhtab is 21-48% faster on concurrent overwrites due to in-place
updates avoiding per-element allocation.
htab's peak memory exceeds steady-state (1.24 vs 0.98 MiB)
because each update allocates a new element before freeing the
old one. rhtab updates in place so peak equals steady-state.

Custom hash functions
---------------------

  Hash function      | key=4     | key=8     | key=32
  -------------------+-----------+-----------+-----------
  jhash (inlined)    | 15-16M    | 16M*      | 15M
  jhash (indirect)   | 11.6M     | 11.9M     | 11.0M
  xxh64 (indirect)   | 11.4M     | 11.9M     | 10.8M
  hsiphash (indirect)| 11.8M     | 11.6M     | 10.7M

Conclusions:
1. The indirect call dispatch is the bottleneck, not the hash
function. All three hash functions perform identically
(~11-12M) because the overhead of going through rhtab->params
(non-constant params -> ht->p.hashfn indirect call.
2. The zeroed-params trick is critical - it lets the compiler
see params.hashfn == NULL at compile time, inlining the
jhash dispatch and avoiding the indirect call entirely. That's
the ~15M vs ~11M difference (~35% improvement).

If we substitute inlined jhash with custom function in rhashtable:

Hash function | key=4   | key=8   | key=32  | key=256
--------------+---------+---------+---------+---------
jhash         | 15.6M   | 15.0M   | 15.0M   |  5.9M
xxh64         | 15.5M   | 14.8M   | 14.8M   | 10.3M

At key=256, xxh64 is 75% faster than jhash (10.3M vs 5.9M).

Asm code for resizable hashmap lookup
-------------------------------------
       : 0                0xffffffff81491860 <rhtab_lookup_elem>:
  0.01 :   ffffffff81491860:        endbr64
  0.08 :   ffffffff81491864:        pushq   %rbp
  0.09 :   ffffffff81491865:        pushq   %r15
  0.02 :   ffffffff81491867:        pushq   %r14
  0.02 :   ffffffff81491869:        pushq   %r13
  0.34 :   ffffffff8149186b:        pushq   %r12
  0.02 :   ffffffff8149186d:        pushq   %rbx
  0.06 :   ffffffff8149186e:        subq    $0x20, %rsp
  0.00 :   ffffffff81491872:        movq    %rsi, %rbx
  0.01 :   ffffffff81491875:        movq    %rdi, %r13
  0.01 :   ffffffff81491878:        movq    0x120(%rdi), %r14
  0.23 :   ffffffff8149187f:        movq    %rdi, (%rsp)
  0.75 :   ffffffff81491883:        movl    0x8(%r14), %edx
  0.66 :   ffffffff81491887:        movzwl  0x132(%r13), %esi
  0.04 :   ffffffff8149188f:        movq    %rbx, %rdi
  0.00 :   ffffffff81491892:        callq   0xffffffff8148e250 <jhash>
  0.05 :   ffffffff81491897:        movl    (%r14), %esi
 21.55 :   ffffffff8149189a:        decl    %esi
  0.47 :   ffffffff8149189c:        andl    %eax, %esi
  0.00 :   ffffffff8149189e:        cmpl    $0x0, 0x4(%r14)
  0.02 :   ffffffff814918a3:        movq    %r14, 0x18(%rsp)
  0.00 :   ffffffff814918a8:        jne     0xffffffff8149193c <rhtab_lookup_elem+0xdc>
  0.03 :   ffffffff814918ae:        movl    %esi, %eax
  0.00 :   ffffffff814918b0:        leaq    (%r14,%rax,8), %rax
  0.25 :   ffffffff814918b4:        addq    $0x40, %rax
  0.67 :   ffffffff814918b8:        movq    %rax, %rcx
  0.00 :   ffffffff814918bb:        orq     $0x1, %rcx
  0.00 :   ffffffff814918bf:        movq    %rcx, 0x8(%rsp)
  0.38 :   ffffffff814918c4:        movq    %rax, 0x10(%rsp)
  0.00 :   ffffffff814918c9:        movq    (%rax), %r12
  8.00 :   ffffffff814918cc:        andq    $-0x2, %r12
  0.00 :   ffffffff814918d0:        je      0xffffffff81491929 <rhtab_lookup_elem+0xc9>
  0.00 :   ffffffff814918d2:        movzwl  0x136(%r13), %r14d
  0.14 :   ffffffff814918da:        negq    %r14
  0.00 :   ffffffff814918dd:        movzwl  0x134(%r13), %r15d
  0.00 :   ffffffff814918e5:        movzwl  0x132(%r13), %r13d
  0.00 :   ffffffff814918ed:        leaq    (%r12,%r14), %rbp
  0.68 :   ffffffff814918f1:        leaq    (%r15,%rbp), %rdi
  2.02 :   ffffffff814918f5:        movq    %rbx, %rsi
  2.63 :   ffffffff814918f8:        movq    %r13, %rdx
  0.00 :   ffffffff814918fb:        callq   0xffffffff81ef69a0 <bcmp>
  6.30 :   ffffffff81491900:        testl   %eax, %eax
 34.73 :   ffffffff81491902:        je      0xffffffff81491920 <rhtab_lookup_elem+0xc0>
  0.00 :   ffffffff81491904:        movq    (%r12), %r12
  1.03 :   ffffffff81491908:        testb   $0x1, %r12b
  0.00 :   ffffffff8149190c:        je      0xffffffff814918ed <rhtab_lookup_elem+0x8d>
  0.00 :   ffffffff8149190e:        cmpq    0x8(%rsp), %r12
  0.00 :   ffffffff81491913:        movq    (%rsp), %r13
  0.00 :   ffffffff81491917:        movq    0x10(%rsp), %rax
  0.00 :   ffffffff8149191c:        jne     0xffffffff814918c9 <rhtab_lookup_elem+0x69>
  0.00 :   ffffffff8149191e:        jmp     0xffffffff81491929 <rhtab_lookup_elem+0xc9>
  0.00 :   ffffffff81491920:        testq   %r12, %r12
  7.31 :   ffffffff81491923:        movq    (%rsp), %r13
  0.43 :   ffffffff81491927:        jne     0xffffffff8149194b <rhtab_lookup_elem+0xeb>
  0.00 :   ffffffff81491929:        movq    0x18(%rsp), %r14
  0.00 :   ffffffff8149192e:        movq    0x30(%r14), %r14
  0.00 :   ffffffff81491932:        testq   %r14, %r14
  0.00 :   ffffffff81491935:        je      0xffffffff81491949 <rhtab_lookup_elem+0xe9>
  0.00 :   ffffffff81491937:        jmp     0xffffffff81491883 <rhtab_lookup_elem+0x23>
  0.00 :   ffffffff8149193c:        movq    %r14, %rdi
  0.00 :   ffffffff8149193f:        callq   0xffffffff818711a0 <rht_bucket_nested>
  0.00 :   ffffffff81491944:        jmp     0xffffffff814918b8 <rhtab_lookup_elem+0x58>
  0.00 :   ffffffff81491949:        xorl    %ebp, %ebp
  0.00 :   ffffffff8149194b:        movq    %rbp, %rax
  0.00 :   ffffffff8149194e:        addq    $0x20, %rsp
  0.23 :   ffffffff81491952:        popq    %rbx
  8.98 :   ffffffff81491953:        popq    %r12
  0.07 :   ffffffff81491955:        popq    %r13
  0.04 :   ffffffff81491957:        popq    %r14
  1.47 :   ffffffff81491959:        popq    %r15
  0.18 :   ffffffff8149195b:        popq    %rbp
  0.00 :   ffffffff8149195c:        jmp     0xffffffff81f182b0 <__pi___x86_return_thunk>

---
Changes in v3:
- Squash all commits implementing basic functions into one (Alexei)
- Remove selftests that were not necessary (Alexei)
- Resize detection for kernel full iterations, error out on resize (Alexei)
- Remove second lookup in get_next_key() (Emil)
- __acquires(RCU)/__releases(RCU) on seq_start/seq_stop (Emil)
- Use bpf_map_check_op_flags() where it makes sense (Leon)
- Benchmarks refresh, experiment with alternative hash functions
- Rely on iterator invalidation during rehash to handle table resizes:
fail on resize where we fully iterate on table inside kernel, dont fail on
resize where iteration goes through userspace. Exception -
rhtab_map_free_internal_structs() should be just safe to iterate fully
in kernel, no risk of infinite loop, because no user holding reference.
- Handle special fields during in-place updates (Emil, sashiko)
- Link to v2: https://lore.kernel.org/all/20260408-rhash-v2-0-3b3675da1f6e@meta.com/

Changes in v2:
- Added benchmarks
- Reworked all functions that walk the rhashtable, use walk API, instead
of directly accessing tbl and future_tbl
- Added rhashtable_walk_enter_from() into rhashtable to support O(1)
iteration continuations
- Link to v1: https://lore.kernel.org/r/20260205-rhash-v1-0-30dd6d63c462@meta.com

---
Mykyta Yatsenko (10):
      bpf: Implement resizable hashmap basic functions
      rhashtable: Add rhashtable_walk_enter_from()
      bpf: Implement get_next_key() resizable hashtab
      bpf: Implement batch ops and iterators for resizable hashtab
      bpf: Allow timers, workqueues and task_work in resizable hashtab
      libbpf: Support resizable hashtable
      selftests/bpf: Add basic tests for resizable hash map
      selftests/bpf: Add BPF iterator tests for resizable hash map
      bpftool: Add rhash map documentation
      selftests/bpf: Add resizable hashmap to benchmarks

 include/linux/bpf_types.h                          |   1 +
 include/linux/rhashtable.h                         |  31 +-
 include/uapi/linux/bpf.h                           |   1 +
 kernel/bpf/hashtab.c                               | 730 ++++++++++++++++++++-
 kernel/bpf/map_iter.c                              |   3 +-
 kernel/bpf/syscall.c                               |   4 +
 kernel/bpf/verifier.c                              |   1 +
 lib/rhashtable.c                                   |  41 ++
 lib/test_rhashtable.c                              | 131 ++++
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   2 +-
 tools/bpf/bpftool/map.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |   1 +
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/lib/bpf/libbpf_probes.c                      |   3 +
 tools/testing/selftests/bpf/bench.c                |   6 +
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |  34 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |  31 +-
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |  35 +-
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 127 ++++
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  34 +
 tools/testing/selftests/bpf/progs/rhash.c          | 239 +++++++
 21 files changed, 1435 insertions(+), 23 deletions(-)
---
base-commit: 05103382104b8ffc701f7b2c79379a0361ecad30
change-id: 20251103-rhash-7b70069923d8

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

