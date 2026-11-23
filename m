Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446959;
	b=IJuO2tLbsNXqISrAESaGUHNX6LSkMKtyAj9Q35aMYuCydxN3+fzCzmQBy7lGaIThE8SG
	 kw6NpPWOp1IndlgeQ5At3ESgCazuZBBbqTEblWCsyTr1N8j5EY5PN654OocJx07Xor9t4
	 S3+TwwSPu9FL7QbSfaZ8J5mmbj2O4d9JPvOFI1RAAH1zRoQzBKXknsMG4uJDqJ4mQyTLn
	 9z6IG/Qe04Bop27l/jpftFyHPzpvh+FD0ivFnjJisx2IPDOFuV3kLI5XLqiMlkuH7aNwA
	 tXTCKU8ZC8Pnibo1BroUS+Mt5Emk+cibu2Erxl1CTW2RKpbAdKl1BQghwEkReQwYq4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=42FNIr7Wx4DYux+tNEevRV4CVHWqwLLbvWwivazW9bM=;
	b=UPSm6gRvxhSLO3BoavwRtKDn+/2bv/8BtJyCQpjV5WYOwhAGBlKKCO7WED7USgi2o49c
	 81bmFxHywF1avAxzz0k0X5IX/gwogIZV5/ap+qcvBYr2EOigHJVo+9aK/+q4cyaHBh34a
	 NdmjRPNfuxwrkneJITlpjsBNdYvmp8B+pyGAVfcmVPbO7XKAl/dc7wVYp3DO7OzR2QVfs
	 XZHoaMtNz0wBUqylphB6kS8RHQTCCLrUpYoHl1GkILhct4jIiDwku5ceYAu3dyjZQH8hS
	 AaFRDMlN04O1qOdWkKGNkHwkIlEgIU/wFswP+H5PLqvhMoOSYfhuXnRFhEIXItF1lmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGZZp40x;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABB7606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGZZp40x
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43bf9548df4so3222258fac.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446958; x=1796051758; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=42FNIr7Wx4DYux+tNEevRV4CVHWqwLLbvWwivazW9bM=;
        b=mGZZp40xx6D7FmzRWgB2vquf3wMCgA6EPi7bFYxCfO2N9kJt6xTDSx3mry2hnPEGQs
         R/Ud2TGeAhqjRMzqO82FKF3jtRdZEb+qjZmh67yepjYvzbmC3SjopuhYLiN24SS5K2Gj
         L3Kq7Zhf6/KXxeKDnaZR6sVUTIqHqP1PVAa722kiiiMERpDa5ptqAsuzO3kL1nsoFtHC
         9Lv4z27wvlaD53SDwv21Dyw4dDIgPUWvOem8+1f/IFpaBPPMHzN21PEGlmB2tfEIw6VI
         OgqGd9VWQumdE8Eg6VLzh3zGK5tWqb+OsmEHjvgSVCQZP9eQkhsBp4DVUwx7SYZWLRNw
         /PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446958; x=1796051758;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=42FNIr7Wx4DYux+tNEevRV4CVHWqwLLbvWwivazW9bM=;
        b=Ld7Rv3CF52YLi5pwR17MVwDD3btjzQ2sOZ/VHxW68bkOAkg1qFXrrCMG/3ZlplcT6K
         aiwb2IPhVlkKO4EBRDTtqdyA64jM2FTScObOZYkbAx+BOW0xJB5nYG+Sgmx6X/n6T5hc
         aA7MatxM6syYNqYMpYIdoSertVvn0coHsX+rZ149rl0GWD4vKtnpaGzQBqWGaiOvW8qF
         mNnM4zoq4pP903JFi3FrhPuagjeZB0gwdO1wO/xxVCBTddPhcKigooafsIVkNSCwvY68
         cJEW25fjDxrvJGSR8qmpLFuEDrZ1csEjN8jAIk1heZt4oagZCmzX8/D7vWqwSlxGG5wm
         JFnQ==
X-Gm-Message-State: APuU4Z/v4XtTgDZzGO4fwa9DkqI6vUelHJ0RxPJKUJzvAUyiJOTJsO1N
	l/O5y80sVhdsbYPU5zPS8R/EslEqLBDz5ZFWWAbzOHznQ/bF5uF2YauO3uUwTwOnems=
X-Gm-Gg: AZFdTZfcL40M4GqpfimpFmw4eN6hzsKUuhSkLtIGxzotpvKe2eINI5JKgCiybKIfffX
	jbhDy9uw3GsN7CHicNk4hM4iRVi3aBD20ZomJ61Ho8tMEjfNk7X4o3X9PyocgdsLtpriMb2maDR
	/b2giHr1l36xdeE61eY2vg5bkwnpco5wPIGQBjUjm2BFfpweJoqJbqN/vHbTKhf2hPtNAx6ZQBT
	6fcvstWmgrB9b4Bk5atH1ts58bgmVhWQ2ogZuSSnHv2XFn3bOOO5aYoRVfGrh8Tm+hGlgkyqyT1
	fTvCujkRBhldoAlDSYsBq6xrjtm3VVJ0uCJw0TdmL63Y0ouB68qbldnh9DFmPVDyFNHbR4Zf/Uc
	v+y0phg6IfOOwOVElHfTxLGKjpzr/my+pCiMzG4n4cInTnV+iAPKTjIBW/D9SZVMy/H2UabxDQU
	36pPk9tmUfiMXX6klxeqg1GYK17lb+s+kyzz9mpxxublvdbCZn1xDF2FkHkbGYXlPEzK79B2i4J
	Bey8pkL8L4E6ImFqxa8w0nBPAg13Q6BrJvHaGOhKce0CvOkg7cWfQSPGhc+dkBqQ/CSMQyG/B2a
	SzyUlAi2SqJWcTPxHhIK
X-Received: by 2002:a05:6870:63a8:b0:494:9254:5b75 with SMTP id 586e51a60fabf-4bc83766403mr10773756fac.27.1795446957775;
        Mon, 23 Nov 2026 07:15:57 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61081159sm11213297fac.15.2026.11.23.07.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:15:57 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 00/13] bpf: Embed local storage values in the
 storage object
Date: Mon, 23 Nov 2026 07:15:40 -0800
Message-Id: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1YBGsC/13NSwqDMBRG4a2Ef2xKbiKWOOo+ipREb2qgPkhEL
 JK9Fxx2fOA7JzKnyBmtOJF4jzkuM1qhK4F+dPObZRzQCmilGyIyMn/yK5B0PlBjVM2GAyqBNXG
 IxwU94dcgZz42dJXAGPO2pO912Onq/9hOUknytrbaDybY+2Pizd36ZUJXSvkB69Q+naUAAAA=
X-Change-ID: 20261113-sls_f1-abf16304e3ef
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=6987;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=cea9xBIzZ0CzJyMr8YFLoKtVQYDTFXIMTa3+QV8dPMs=;
 b=LmiGQH3D7FzoEshimIwAhtJT11Gj9a3Ud50EXyYcPQ6XjOK4YxHUOiH7kwDaUjuto3W2NGgP2
 F9y+EOBgS4QDx/u9UIca2CbHUhiHdqxSdIqA5dUukf1UgQfY8Q2fop1
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

A lookup in a local storage map reads the storage object, a cache slot
and then the selem that holds the value. When the owner is cold, each
of these reads can be a cache miss. Programs that do a few lookups for
each packet pay this cost on each packet.

This series adds the map flag BPF_F_INLINE_VALUE for sk, task, inode
and cgroup storage. The value of such a map is in the storage object,
at a fixed offset, so a lookup has one dependent load less.

Design
------
- Each owner type has one inline area at the end of struct
  bpf_local_storage. A storage object is at most 1 KB.
- Map create claims a slot (an 8 B tag and the value) in the area,
  first fit. A table of the live inline maps holds the layout, with at
  most 16 maps for each owner type. Map create fails with -ENOSPC if
  the area has no room now, and with -E2BIG if the value never fits.
- A storage object that is made while inline maps exist gets the
  area. If an object has no room for a slot, the value goes into a
  normal selem. Programs do not see the difference.
- The tag comes from a claim number. A lookup compares the tag with an
  acquire load, so a new map does not see the values of a freed map
  at the same offset.
- Programs can keep pointers to inline values, and these values have
  no selem. Thus an object with an inline area lives until its owner
  dies, and it is freed after an RCU tasks trace grace period.
- A lookup of a normal map tests one more field of the map, also on a
  host with no inline map.
- The sk storage map iterator is refused for inline maps, and sk diag
  shows inline values. A delete in NMI fails with -EOPNOTSUPP, as for
  normal maps. The flag needs a 64-bit kernel.
- libbpf does not retry a local storage map create without BTF any
  more. That retry always failed with -EINVAL and hid the real error.

Semantics and costs
-------------------
- A syscall update copies the value in place, under the storage lock.
  A reader that takes no lock can see a torn value, as with array
  maps. Without the flag, an update swaps in a new selem, so readers
  see the whole old or new value. BPF_F_LOCK is not available,
  because an inline value cannot have a spin lock.
- A pointer that a program keeps after an update or a delete points
  to the same slot. It sees, and can change, the next value of the
  same map. Without the flag, it sees the old value.
- The tag is predictable, and claim numbers wrap after 2^32 claims. A
  user that can create inline maps can make another map see bytes that
  it did not write, in objects made before that map.
- The area and the 16-map limit are shared by the whole host, also
  with BPF token users.
- While an inline map exists, new objects of its owner type are bigger
  and live until owner death. This is also true for owners that use
  only normal maps. A delete or a map unload does not give this memory
  back.

Numbers
-------
Host: AMD EPYC (Zen 5), pinned 24-vCPU KVM guest. Workload: two TC
egress programs look up two sk storage values for each packet (124 B
and 2 B), 9 sk storage maps for each socket, 131k connections with
request/response traffic. Paired A/B runs against the base kernel.

- Whole request, programs on, both values inline: -200 +- 108 ns
  (-2.9%).
- Sampled cost of the two lookups: 169 -> 58 ns and 90 -> 11 ns.
- bench_local_storage, hot loop with all data in L1, ns per lookup:
  normal maps: +0.39 to +0.76 (1 to 16 maps; 3 more instructions and
  1 more taken branch); inline hit: +0.32 to +0.67. The gain comes
  from cold owners, not from a hot loop.
- Memory: an object grows from 192 B to 256 B with inline values of up
  to 64 B, and to 1 KB with a 512 B inline value. Owners that use only
  normal maps pay the same while an inline map exists. In the workload
  above, unreclaimable slab grows by 629 B for each connection.
- Socket churn: no throughput cost. At about 230k closes each second,
  about 18 MB more objects wait for the tasks trace grace period.

Patches
-------
Patch 1 fixes an existing bug: a failed create in NMI freed storage
that was never published with kfree_rcu(). It can go in alone. It needs
commit bd897919e4dc, which is in bpf-next only. Patches 2-3 prepare the
code. Patches 4-10 add the inline area, its lifetime, lookup and
update, the iterator refusal, sk diag and the UAPI flag. Patch 11
changes libbpf, patch 12 adds a selftest and patch 13 adds the docs.

Testing
-------
- The selftest passes on normal and KASAN kernels, with no kmemleak
  report.
- Out of tree: races of create, update, delete, destroy and map free,
  also from sleepable and NMI programs; sk diag, clone, inner maps and
  owner death; fault injection
  that forces the storage lock to fail in destroy, with no leak and no
  KASAN report. KCSAN ran on an earlier revision with no report.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Removed RFC tag, simplified selftests.
- Link to v1: https://patch.msgid.link/20261113-sls_f1-v1-0-1b9492bd3f97@meta.com

---
Mykyta Yatsenko (13):
      bpf: Free unpublished local storage with kfree_nolock()
      bpf: Add obj_size to bpf_local_storage
      bpf: Add bpf_local_storage_delete()
      bpf: Add an inline slot allocator to local storage caches
      bpf: Size new local storage objects for the inline area
      bpf: Keep local storage objects with an inline area until owner death
      bpf: Keep values of BPF_F_INLINE_VALUE maps in the storage object
      bpf: Refuse the sk storage map iterator for BPF_F_INLINE_VALUE maps
      bpf: Show inline values in sk diag
      bpf: Allow BPF_F_INLINE_VALUE for local storage maps
      libbpf: Do not retry local storage map create without BTF
      selftests/bpf: Test BPF_F_INLINE_VALUE local storage maps
      bpf, docs: Document BPF_F_INLINE_VALUE for local storage maps

 Documentation/bpf/map_cgrp_storage.rst             |   3 +
 Documentation/bpf/map_sk_storage.rst               | 103 +++-
 include/linux/bpf_local_storage.h                  | 105 +++-
 include/uapi/linux/bpf.h                           |   7 +
 kernel/bpf/bpf_cgrp_storage.c                      |   8 +-
 kernel/bpf/bpf_inode_storage.c                     |   8 +-
 kernel/bpf/bpf_local_storage.c                     | 420 +++++++++++++--
 kernel/bpf/bpf_task_storage.c                      |   8 +-
 net/core/bpf_sk_storage.c                          |  71 ++-
 tools/include/uapi/linux/bpf.h                     |   7 +
 tools/lib/bpf/libbpf.c                             |  17 +-
 .../bpf/prog_tests/local_storage_inline.c          | 583 +++++++++++++++++++++
 .../selftests/bpf/progs/local_storage_inline.c     | 123 +++++
 13 files changed, 1388 insertions(+), 75 deletions(-)
---
base-commit: 4425c2a376e11caa4f01ea4ff2fbab61d197d67b
change-id: 20261113-sls_f1-abf16304e3ef

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

