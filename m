Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401854;
	b=wZRUVJkskc4zfJwD+IgMXqgx9wdYI1HNIDDawAu9DsaRmlMdTN3/fpxtmevXR9Gjtp6q
	 85ACeYg/R01X1m7WS87T7cTEpB6NcUAPLQrp4K+6StPmaPD2tRK7SF/tWxBnxjjRt7lWe
	 UTbSrucDinLfV9MtWfHhzz3I4GW/2bJSuUngef00GGIONZ/r+kEhc9I4EBOO+W/1YOg+l
	 UJA9dMfc1WYeG/flwcq5IrVhgFx5CXQtU+0DdTzs9p8FC4c95thm1pKFJhJTyh8yImus/
	 gMORruZe8k6wV7RMFtgZ+byjtSEbfcdCgG/zf7i2FnpqcZggY+iEpvuHqiKzE7vpMXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=laGI1KTQ4gtAKp0pD49N1vtL4KC/exgU9bobW80wQwI=;
	b=2juV8V3pL5AkfYei5vqdLTWJIfRAwr1+BQwD0Yz3uI8ebE4DywW+PT+DnAYgXv/NTWzK
	 7c8BScichhZ8Oq7jk1gO8sH7OKHgfD/yIi3W/k0VhxKx2KV4zFcmhNJyCnX7PuFx0Qvl/
	 4IBzOc/I796wJUdCCjlVo0tkruA1ASTRltUhVXg+lv2NrjtUa4bm9FLJkzET1KLh5jMri
	 93nyWiA+YxDDpK+IFJaDPmPiW4kRJFx7c9hhobvLDKUN0RZbGU0ctS/8sOrt0pW2o8O8Q
	 +11a82CxNHZaiwScXLeQSNJC8udDXCwKCb9ShN98mFpLxNBq+onbQhzOVfsECvXRKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXsqN0fP;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF16606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EF16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EXsqN0fP
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4b769975b2bso12860085e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401852; x=1795006652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=laGI1KTQ4gtAKp0pD49N1vtL4KC/exgU9bobW80wQwI=;
        b=EXsqN0fPg3OtVepMDeaHTip8RBAHkOXW9s7KIXI/ALekrDPu9dbuZNre3mvV2Di98Q
         dleEEMU8/YaHslMKNhQGO69zSJSf+ONfBZjY7IaSys4k8ormR6bog82ztbgq4dACcEJb
         bPreOZBYIG5AbbpH4gxg7ZKC/YsiiHutnw8h0M9DQz0TmjhfHjU7UF4nj4sEpgHLakg3
         Kx0pPpBqjtN4P49PKnLPxUrCNTGSEvz9bfOowjqlxGA0vMUHx9xXbfVgwyn/m6DKpJz5
         BlVRmpviCaR7YoVpImYJv68q8dE6dwuIUmcZeTLVrZhG3nXSm0fnlt8MSfUeyMBMi5Bk
         +chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401852; x=1795006652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laGI1KTQ4gtAKp0pD49N1vtL4KC/exgU9bobW80wQwI=;
        b=qiRQfcQmN8wJxd1DJVjQl24lrGx1kSThmqQ2iCqVGCzsGKLq0V9P2HO2kilPluTTqI
         sf1ynU0n/CJeLb8AzftlujlRkl7BY6s8MHT07m67ayZAocm4+KDXaaYjyKVi+AYxT+bQ
         WHk+inY5AZFnpO2ZBYX4C4Sk4RR22YyBi+EOzD1L8iUANlyPwLyMJxGSUqYii+pNeRTp
         SD9VAwF7TfzHw1kuGwSkpLEuTc7kxx+YeT6nbE5wQlxk9ij4tMf1j3Dt4Bg2FHyNPpD2
         hjUHyILlmZPhRMy50gOHFIa/H5jUuKYcJMCo8feXh1vdBHGmxrOuUVgjUKfOK3Co2iJf
         mhLw==
X-Gm-Message-State: APuU4Z/Imu9s1qvi4Zf/m+nQ3NPWYW4ecrQXLPdS7XBZZ2weVZ0t7g1n
	HufW6zCJ1qSH80cvH166frIGFG9WgGEXFzVnF1lwaw/r5pYwVyuqKgSdHGsI9MArtEM=
X-Gm-Gg: AYBFou2pmjIPIrXighNXG0wMUKn2Y1sx6+zB+2Pt5UH1g4BzNWDhxgf+tXkl+rqZmYs
	hRgfiJlN9f8/Sv6uQFf1yKPIOY8LdG4yA5zNbu+YZKJg1zQgBU9kFA8MEMLX/8egxDV8FJdH6P/
	P+pKJxpI76Oehou18+k5Tx2zEsvMz2gMwBJHwdXHl9x4aP1bNAa1OSGeL3pcH+Ns/hiQqHX2qMU
	kjIgde7YRk7OHbie2TRV+kGEkwGLQb+1ULOoLhlKUFgYBlikMT82NAL+DjUUWfSgbSBaITaj4yM
	onms45D4dVHtFPU8IIoZcf5m/R9IW2+uGtfHCwWI3yHQLowYp6rdHmDHei911eT0Vh41V6XMhxh
	rniBpVMvNnNkFheRYE3joxZomZwCiHXO9kQ12jbQCrNOUjuiAipEEq25Bf0xzaLnAbGkvTFraba
	WuWNzzHkl9y34+gC1Baulh0yrvWVtifFuj/fKbDIqDoQa1PQnGTAnX65txrkUCSP14NY+usaxdR
	SUEwzMTQCKp0YbPEA3JDO4WhunwgwnQKWT70Pcyxtq7hXSabWfT9EJHkbKEufsj4M/guonqt1kV
	WGDrDACRsbbqdmW+1ZiSoDgyxrSyHvRKGC0AJ6zANpU+jOoxwQRJb+URIXnt9c+giKwT8w0nnwr
	64wXglixwisBOjt3p8o03vvTRGkNSVoU/KBtg0fgiIHnSpbhnHarUSl1Bdhd5V8TluxWAB7FmaW
	RO+HX2hm6Yzw5BNw==
X-Received: by 2002:a05:600c:4444:b0:4b3:6900:280c with SMTP id 5b1f17b1804b1-4ba09377988mr39902165e9.19.1794401852050;
        Wed, 11 Nov 2026 04:57:32 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49944d646f9sm7075899f8f.32.2026.11.11.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:31 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/29] Exceptions - Resource Cleanup - Redux
Date: Wed, 11 Nov 2026 13:56:58 +0100
Message-ID: <cover.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13450; i=memxor@gmail.com; h=from:subject:message-id; bh=j56pITdFLjTD4sf1yP4GTeo+nNyw1bd5MIdg7zfeBQ4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzOyzMyf6zNDNffSnvvfMhizOX3zf1aSOP4k9sN7mK WeylM7njlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzE7jbD/6DKqtQPDUnrle8k CefcCjx5V/6/VfB5B87p51+6uB7IPcDwm031i9W2PXkfFl4yfHh385tmmfS7XeJLhQz6TNUM5Nv l2AE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently bpf_throw() can only be called while the program holds no
resources. A throw unwinds to the exception callback of the main program
and discards every frame in between. Any reference, lock, saved IRQ flags,
or RCU or preemption disabled section held by those frames would leak, so
the verifier rejects the throw. This makes assertions unusable in most
places where a program wants one: in a loop over an iterator, under a
lock, or in an RCU section.

This series allows the main program and its subprogs, static and global,
to throw while holding resources. The unwinder releases the resources of
every frame it discards.

To release a resource the unwinder needs its handle: a pointer to an
object, a ringbuf record or a lock, or the address of an iterator or of
saved IRQ flags on the stack. The verifier tells the unwinder where to
find each handle, in one of two ways.

 1. In the location where the program already keeps it. A frame can only
    be unwound at a call it has not returned from: bpf_throw(), or a call
    to a subprog that may throw. Such a call is a site. On every visit to
    a site the verifier records where the frame keeps each handle: the
    stack slot of an iterator or of saved IRQ flags, the stack slot or
    register that holds a pointer to a referenced object, and the address
    of a lock or a pointer to the object that contains it. It also records
    how many RCU and preemption disabled sections the frame is in. When
    every visit finds a resource held, with its handle in the same
    location, that location goes into a descriptor for the site. The
    program pays nothing for this at runtime.

 2. In a hidden stack slot. When the visits to a site do not agree, the
    verifier reserves a hidden stack slot in the frame for the instruction
    that acquires the resource. Instructions inserted around the acquiring
    call store the handle in the slot, and instructions inserted before
    the releasing call clear it. Sections are counted the same way, in one
    hidden slot per kind.

A resource that is never held at a site needs neither. That is the case
for every resource that is released before the next call that may throw.

A callee may release a resource that its caller holds. If it is a
reference passed in an argument register, the call transfers it: the
callee owns the reference from its entry and tracks it in either of the
two ways above. Any other resource, such as a lock, stays with the caller.
The caller's sites then describe it, or the caller clears its hidden slot
before the call. A callx is handled the same way, for every subprog it
may call.

At runtime the unwinder walks the frames once per phase: locks and IRQ
flags first, then objects whose destructor needs RCU protection, then RCU
and preemption sections, then all remaining objects. This way no
destructor runs under a lock or with IRQs disabled, a destructor that may
sleep runs after every section has been left, and an RCU protected
iterator is destroyed before its RCU section ends. For each frame the
unwinder releases the resources in the frame's hidden slots and those
listed in the descriptor of the frame's site. It finds the site from the
frame's return address, in a table that the JIT fills.

To read handles from registers, bpf_throw() gets a native entry point
that captures the registers of the throw site before any C code runs.
R6-R9 are callee-saved, so the unwinder recovers them for each outer
frame from the locations where the inner frames saved them in their
prologues, which the JIT records. R0-R5 are known only for the frame that
calls bpf_throw(). That is still useful: bpf_throw() does not return, so
a compiler leaves a reference in whichever register it was in.

The unwinder restores the callee-saved registers of the program's caller
from the same saved locations. The main program of a program that throws
therefore no longer saves all of them in its prologue for the exception
callback to restore, and uses a normal prologue.

Programs that cannot throw are not affected.

Limits on program patterns:

 - A throw inside a callback stays rejected. This will be lifted in a
   follow up version or set, along with support for normal unwinding.
   Link: https://lore.kernel.org/bpf/cover.1793147364.git.memxor@gmail.com

 - A hidden slot belongs to the frame that acquired the resource. Some
   resources end up held by another frame: a lock that a subprog takes
   and returns with, an iterator or saved IRQ flags that a callee creates
   on its caller's stack, or an RCU or preemption section that a callee
   enters or leaves for its caller. These are accepted when the site
   descriptors describe the resource, or when no throw can happen while
   it is held. They are rejected when a hidden slot would be needed. This
   does not need to be fixed: the usual wrappers load, and only a site
   that is reached both with and without such a resource is rejected.

 - A hidden slot holds one handle. When a frame holds two resources
   acquired by the same instruction, for example in a loop, the program
   is accepted only if no throw can happen while both are held. This can
   be lifted in a follow up for resources that a site can describe.

 - The instructions that maintain a hidden slot are emitted once per
   call. A resource that needs a hidden slot is rejected if its call
   acquires it only on some paths or in different ways on different
   paths, if its handle is not in a register at the acquiring or at a
   releasing call, or if the acquiring call may itself unwind. In
   well-behaved programs using RAII, this pattern is unlikely to appear.
   The last case is expected to go away with support for normal
   unwinding. The others do not need to be fixed.

 - A callee cannot access a hidden slot of its caller. When the caller
   keeps a resource in a hidden slot, the program is rejected if:

    - a callee that was not handed the resource may throw before it
      releases it, or releases it only on some paths;
    - a callee that was handed the resource returns without releasing
      it on some paths;
    - a callx may call one subprog that releases the resource and
      another that does not;
    - a callback releases the resource.

   Likewise, a subprog that keeps a reference it was handed in a hidden
   slot of its own is rejected if another call passes it something else
   in that argument.

   Only the second case is expected in practice: a callee that consumes
   a reference on some paths and leaves it to its caller on others. It
   loads today if the callee returns the pointer instead, and can be
   lifted in a follow up. The others do not need to be fixed.

 - A throw is rejected while the program holds a reference that the
   unwinder cannot release: its type has no cleanup destructor, the
   program is not allowed to call its release kfunc, or the object has
   NMI unsafe fields and the program is a tracing program. The first
   case is fixed by registering a destructor for the type. In the other
   two the program could not release the reference itself either, so
   they do not need to be fixed.

 - A program that throws must not overwrite an iterator or saved IRQ
   flags on its stack, release an object while it holds the lock inside
   that object, or keep an RCU protected iterator beyond its RCU section.
   Such programs are rejected without a throw as well, so this does not
   need to be fixed.

Other limits:

 - A register or stack slot that points to a held resource stays in the
   verifier state after the program has read it for the last time, so
   that a site can describe it. Two states are equivalent only if these
   locations match, which can reduce pruning. Liveness is unchanged. This
   does not need to be fixed: it only matters when two states keep a
   held resource in different locations.

 - Hidden slots count towards the stack depth limit. This does not need
   to be fixed: a slot is eight bytes, and only a resource that no site
   can describe takes one.

 - Only x86-64 and arm64 are supported. Other architectures keep the
   existing behavior, and can be added in follow ups.

Kumar Kartikeya Dwivedi (29):
  bpf: Record where JITs save callee-saved registers
  bpf: Add bpf_throw_unwind() and an arch entry hook
  bpf, x86: Capture registers in a native bpf_throw() entry
  bpf, arm64: Capture registers in a native bpf_throw() entry
  bpf: Restore callee-saved registers from unwound frames
  bpf: Keep last insn's aux data in add_hidden_subprog()
  bpf: Add one allocator for hidden stack slots
  bpf: Add flags and release kfuncs to the dtor registry
  bpf: Register cleanup destructors for more types
  bpf: Record where JITed frames keep the BPF stack
  bpf: Give every reference an owner frame
  bpf: Release resources in hidden slots on bpf_throw()
  bpf: Track held resources in hidden stack slots
  bpf: Describe held resources at throw sites
  bpf: Describe handles in registers at throw sites
  bpf: Describe locks at throw sites
  bpf: Apply hidden slot limits only when a slot is needed
  bpf: Allow a callee to leave resources with its caller
  bpf: Allow a callee to release its caller's resources
  bpf: Transfer a reference to the callee that releases it
  bpf: Support callx when a callee releases resources
  selftests/bpf: Test rejected throws that hold resources
  selftests/bpf: Test resource cleanup on bpf_throw()
  selftests/bpf: Test cleanup of handles on the stack
  selftests/bpf: Test cleanup of handles in registers
  selftests/bpf: Test callees releasing caller resources
  selftests/bpf: Test resources a callee leaves with its caller
  selftests/bpf: Test cleanup of locks described at sites
  selftests/bpf: Test callee releases through callx

 arch/arm64/net/Makefile                       |    1 +
 arch/arm64/net/bpf_jit_comp.c                 |  168 +-
 arch/arm64/net/bpf_throw.S                    |   33 +
 arch/x86/net/Makefile                         |    1 +
 arch/x86/net/bpf_jit_comp.c                   |  158 +-
 arch/x86/net/bpf_throw.S                      |   45 +
 drivers/base/power/wakeup.c                   |   25 +-
 drivers/hid/bpf/hid_bpf_dispatch.c            |   23 +
 drivers/hid/bpf/hid_bpf_dispatch.h            |    1 +
 fs/bpf_fs_kfuncs.c                            |   27 +-
 include/linux/bpf.h                           |  206 +-
 include/linux/bpf_throw.h                     |   71 +
 include/linux/bpf_verifier.h                  |  255 ++
 include/linux/btf.h                           |   23 +-
 include/linux/filter.h                        |    1 +
 include/net/netfilter/nf_conntrack_bpf.h      |    1 +
 include/net/xfrm.h                            |    1 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/bpf_iter.c                         |    6 +
 kernel/bpf/btf.c                              |  101 +-
 kernel/bpf/cfg.c                              |   23 +-
 kernel/bpf/cgroup_iter.c                      |    6 +
 kernel/bpf/core.c                             |   21 +
 kernel/bpf/cpumask.c                          |    7 +-
 kernel/bpf/crypto.c                           |    7 +-
 kernel/bpf/dmabuf_iter.c                      |    6 +
 kernel/bpf/fixups.c                           |  293 ++-
 kernel/bpf/frame_desc.c                       | 2143 +++++++++++++++++
 kernel/bpf/helpers.c                          |  135 +-
 kernel/bpf/join.c                             |   26 +-
 kernel/bpf/kmem_cache_iter.c                  |    6 +
 kernel/bpf/states.c                           |   43 +-
 kernel/bpf/task_iter.c                        |   18 +
 kernel/bpf/unwind.c                           |  346 +++
 kernel/bpf/verifier.c                         |  378 ++-
 kernel/sched/ext/ext.c                        |   41 +
 mm/bpf_memcontrol.c                           |   28 +-
 net/bpf/test_run.c                            |   14 +-
 net/core/bpf_ksock.c                          |    3 +
 net/core/filter.c                             |    2 +-
 net/netfilter/nf_conntrack_bpf.c              |   38 +
 net/sched/bpf_qdisc.c                         |   10 +-
 net/xfrm/xfrm_state_bpf.c                     |   26 +-
 .../bpf/prog_tests/exceptions_cleanup.c       |  323 +++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/exceptions_cleanup.c  | 1997 +++++++++++++++
 .../selftests/bpf/progs/exceptions_fail.c     |  300 ++-
 .../selftests/bpf/progs/verifier_frame_desc.c | 1121 +++++++++
 .../bpf/progs/verifier_private_stack.c        |   12 +-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   43 +-
 50 files changed, 8224 insertions(+), 343 deletions(-)
 create mode 100644 arch/arm64/net/bpf_throw.S
 create mode 100644 arch/x86/net/bpf_throw.S
 create mode 100644 include/linux/bpf_throw.h
 create mode 100644 kernel/bpf/frame_desc.c
 create mode 100644 kernel/bpf/unwind.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_frame_desc.c


base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
-- 
2.53.0

