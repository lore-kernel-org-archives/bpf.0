Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611321;
	b=fQ5LviAMGKMd7SDhCT3oHzs7qY5dQRtLU5IAk/C6LZMnIpZBDkFq0NU76eIE2e7tAxeq
	 +B6BWHX7UIE22AqnO7Tj1MuSQbEoCLXK/8vk/B6MTa4zj46AnaN4toEJu+Ynhv6eDOghV
	 gYV5RUWcNO/jcfasKh4KI7XDGm8O+q3zrmgDc7ncT2mq+ZFi2ZNKCxVJKiPvgXNNtLfDz
	 U3b3bsXUVVn3VkNoyB5/Gwn7QRLbZV/AX/kqLrAtOb5Mu4cNlgWoeXIyJ1AgJg45A162n
	 JKZF0xEkIBnxX9MmDGTQwrh/TP89nqltCGRdzkeIHSmzwC0hv8pU6F6JKWY2KBDTLew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=L4wD0yAKJsE9cFFbUwnLpE2snlrkMqOneMhQ/vB0/Dw=;
	b=wKFcXM8urRk5OAsMI0WVX2WqmlUQWtGLHil2s9Sk4FKza1UVEYerkmKYktJylJcGsOAB
	 T4CXsfc1MK/uY36or59Hx8DcSIOciTad0dGReEIp79BD84KrjmUg5dxEsIMfRCVmhxQTk
	 Hi5gm3VdzFPkTDPmQwUT6Djx5N0uMTFVhVr95LFe6Bxu9pMMUjowBcn0gg73/ZnnLNNGl
	 cNXTAfIxASpZVvg0hb5eDaJ2SLMR34msNQqGw9fQ7lteaFq4GSYF7aHQIciFRbf7FSlnQ
	 HFMOk130gSxn+TphfQD3SX0VVp/+/nsVvAipZOVJhej+nZYNEDFezqnUxSOHHlkQUWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgOF8yzJ;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E10606A330
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E10606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgOF8yzJ
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b30ff12f84so11935587b3.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611320; x=1795216120; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L4wD0yAKJsE9cFFbUwnLpE2snlrkMqOneMhQ/vB0/Dw=;
        b=JgOF8yzJs7uxpt8zHs1ibgDZpSM8YKR8B9mIkByTGTq1JCRgVJ/BlyC60q4anRT4wb
         CCMQsoZfxyq3ZwZ0oeTmI6KK4CfKxLgMI9CpDiuHMb5bpZ2YhqMUF1EfKVG45Lv0iIFI
         AvRz3dSr3imuPdSa70T/kn8s4200yhlt6QhO35KexsqBlpS6+hVmym9GW2i2hxvmzww2
         hvZe8171W4SH3+qyqCpIvtbTzk3r4RR8L1Hz6HD+t+ljfGCN1YrMUW3RT5Jnll2PAdbF
         lgsMmiOSSNgH5HYWZrHlPvrbJ4pa4dkyDAuslHfS7O236ZLy//ldUR0JlQBNCPt+QL7g
         XdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611320; x=1795216120;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L4wD0yAKJsE9cFFbUwnLpE2snlrkMqOneMhQ/vB0/Dw=;
        b=QApaH0diQrDBiWdKhN4MGJja5dX8FlSBLjA8gZ098CerLwdAKuz2V6DJ2iYuhn+AZ/
         OdfrWnGlY8Hb8X9MdFJLhJ9f7okP+h7eBk6b0hqsecozrquUPG5c6ST9eh/StZldKiLX
         PXZBnDDMFalvl7diyHWMmFBcVM4nipt1QB0NjpZqeFZ1BAX7bUhJplaQ/KkNr/vfcpkl
         eNpgOkuj3vCgkpNasAwxPoQn65IPcUfpt9X0k4XN4G7hO95sa/tsfJhG7YKO1tOfrRCS
         BuPKpmehxL6S0AM0daMmTXTcMqIPePEcg4EhkGy5OnvEEkN2Ne+ek3U7HrpsGEryR/8U
         4oGA==
X-Gm-Message-State: APuU4Z8FzTGGJXxmVSX0agvgkzhUCcCohYhUwOsNk0P/Y7ag1ShmoI7o
	sAG3s70vVmvWMc64TnRtd/Igy4fT8D5Hro4pW85UAFIieDcbr0RmBjBG
X-Gm-Gg: AYBFou36EQ2JWlGbTUHQK/3bDFcJ/0/qDb/3I2ICRSERS+QDOXD9swAoVy4moezj7IC
	pA4AyQLpcRzSxUN0XFrKHCBFd5WHr8RJ5CeJykxafeWo/Oh6O+o0dSA80ymhYBx9O3CuRTDpDo8
	nhL2lDxPfIkh0YtPQ0RvFr4xnr2LSJNbjC4drYz++4YCSm78O4kIiylnSyINK52q4Y+SaPYLo2J
	a3eqsNMQPqS67x9Dc7W6qdeQFdjWtA5Lm+0WeGTAbTHaEFigx2VdRICyy1iSNH77lugQpDEYEXH
	+qzRSM1Fv8lHzl+gQnIQqB2qoF3wFK3etPPtr07mDVdYVP9W07ePOtbyNV1UvFbuKDK4f39pMz1
	DP2EZ+FO63mB/aipjxuYvq8kgjFZY32185CdvY6XQMmp0suWvPltpc2igapFBUcYnsGf1G2trPM
	OjbDhgHxjupyrqtdQoRciCm9gAg88Yk21WSGfr9MY2COJ0nLU+YCDpmIGDyqru+BwFHWlcPKi77
	MtAVhw1Yr+ivbwvscTGz2lbEyzfmXMe95C9i29YEL2qPhm81TQhFkhYCxGmaNzFuQWXoqyIszQX
	+3ITH4Om4JzYitjBH/n5
X-Received: by 2002:a05:690c:6608:b0:8b3:47fd:a033 with SMTP id 00721157ae682-8b4aa2f3b19mr34570977b3.31.1794611320128;
        Fri, 13 Nov 2026 15:08:40 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4beaaaf08sm1687647b3.38.2026.11.13.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:39 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next 00/13] bpf: Embed local storage values in the
 storage object
Date: Fri, 13 Nov 2026 15:08:23 -0800
Message-Id: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
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
X-B4-Tracking: v=1; b=H4sIAGeY92oC/x3MQQqDQAwF0KuEv3bAOOJitoUewK2UMrZJGyhTm
 UgRxLsXfAd4O1yqiSPRjio/c/sWJOKG8Hjn8pJgTyRC13YDM8fgH78rhzwrD7HtJYqiISxV1LY
 zmjBeLzQvGopsK27H8QcU8u7qZgAAAA==
X-Change-ID: 20261113-sls_f1-abf16304e3ef
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=7000;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=CJSh42fENIFd0uk32Ugqxkm0UoNRsMrpsYRFaCJGE/Q=;
 b=GHVlj3aaHFT4l+3f1aEiN60o9TNymGEes8mV4T4xMSz95nBPzwETZPfQqmO6s2xIWQ47XuiDT
 sU4ba0lxMpfAVwNcaRLcxIiu+0sKS4dIrfABzfPkL+wmkrpj6/aVa/b
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

A lookup in a local storage map reads the storage object, a cache slot
and then the selem that holds the value. When the owner is cold, each
of these reads can be a cache miss. Programs that do a few lookups for
each packet pay this cost on each packet.

This series adds the map flag BPF_F_INLINE_VALUE for sk, task, inode
and cgroup storage. The value of such a map is in the storage object,
at a fixed offset, so a lookup has one dependent load less: it does
not read a separate element.

Design
------
- Each owner type has one inline area at the end of struct
  bpf_local_storage. A storage object is at most 1 KB, so the area is
  840 B and the largest value is 832 B on x86-64.
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
  (-2.9%). Programs on with normal maps only: no measurable change.
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
 .../bpf/prog_tests/local_storage_inline.c          | 591 +++++++++++++++++++++
 .../selftests/bpf/progs/local_storage_inline.c     | 123 +++++
 13 files changed, 1396 insertions(+), 75 deletions(-)
---
base-commit: 76b3efa01847795720f86d714a4ebea4979eb0cd
change-id: 20261113-sls_f1-abf16304e3ef

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

