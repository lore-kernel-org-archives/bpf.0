Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248350;
	b=S2mvK0pjhU4uBl6IGC4BZ6sF/5X9jf2Ng7XkdEbDsxeofizmbIKnRhdrXY7iT25iz2xN
	 lXWUKveblmk2vWtPUHauZ1dD85e0dJWlhH0Nopl5b4rXzLs3idYwR+oATCywsebHfDuI1
	 5nK4mnF8fxZESWjG1ngJmFDMVkEwJFeFD+gvxSCPfE59WyjnqusaWVFGVn0fy/xXqSg/f
	 taenoNikIvFImEKdAJhfKQ86eVa8pAaGvi/2IuSrL7miFFr31lGClTINfRE3yoARHv6zz
	 rTW9td9qQrf36ZYiC8mSjOkUfdsknJyCW1IhBdwVTdRKtFx6HLVQlucPvIX28+yQAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Al53KaPWXGxJk13wV4PIOS4dHIMGoV2MUU+WyWUG6bM=;
	b=cC5f6cst976E6kKi5dlrqtZj7acBhpyLmyWLtmBIl6D8Ds6eEfnQHxkK0bzjDwU7754x
	 iI592eWEICERq76FqfoDgaKRggtqXDLUnoU9CKlOgT/67vfw+YS44aeHyCXoKDPguRhtu
	 P5L1lkHlT8RqzPk7shkfHiClXGNEYrCyuhpYnBLnDLSBVGO6inHmvf7utq2jb0jNFuK6W
	 3d2EbrbN7I8cIcmLqxTa0NAOaiYO9+Vn3jEyxWtQVwqDk5LVv0D+DpW2Qu8zkH07+42gw
	 kUua8vALQCUA2CbB25MnA/gxTrA8IHwxyeX1gUqFeG//eEBtLvDsal4/3pAmk3XJVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=pcsp3ZRU;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98204606A334
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98204606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=pcsp3ZRU
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b147e06befso532793a91.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248349; x=1794853149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Al53KaPWXGxJk13wV4PIOS4dHIMGoV2MUU+WyWUG6bM=;
        b=pcsp3ZRUO4Kxraaa6QaWTyNb/s/P9MoooPnk2hlaiL3905ANn2Pea/lfTQmJvzGYFf
         h5F8x8waFIrWosUKqffBoFZ+c8Z1IX0LsHvu30pOpjRfV46O1Py5mKOCYleHTejNzD/B
         JpPMv1OITxhWC17BalwGpViVvbX1D3vjQKiCO7HgI2QqOW9hj+7yZ5g89PvxAhT1hPbB
         wVp9mcFuOZZwMJZEaNqO05fyD/tszVJT/8YNVhnMchdNzB8+OnXyW5IvOQi0meSRUYa1
         Zgv0ACvuuw88i/frnBRPpeVsHotA7DE1LtQwrkxYkJW4iTmndEJLZ8+Vu2E2xxxWpnZS
         eagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248349; x=1794853149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Al53KaPWXGxJk13wV4PIOS4dHIMGoV2MUU+WyWUG6bM=;
        b=R983Wusr4Nh635uesGVW07ELtn6owmbO+X0w/xlaYYRAqPPaMHID5/SLFVZARWPTwg
         SKBzfzZzzF/hqa1FuKnJXGljv4C1jGk2/PE860I07m9ctGOUYVvsg9bRiPszw0tDYK8J
         HL+5g6qdbnzgOmwBpi0VqPhY8cWmluX59wbKJ8GmXlUvl6nWkQ5TMRkKeqY5xwTACZM3
         PFEcLlxWXwatFBGe5E9mMV17tkp7BDzNr+EyIcppOpDl/6d5ih1VctY5M8JPcMjDinaX
         9sENEtcgdgoxDwL8nB3BBOIWV08XrJX/qPRYuzqQtvAozeua0p9XXOkgCvvBOwODKQQt
         cxhg==
X-Gm-Message-State: APuU4Z8JaTqTC3+MnCm/gijlg0U+zr9wCIs710F3kMr3gYU3vulnnJb9
	TA4vczlkMrsjWuPR2/lnbS5CiGnesZ6s7A72kU6LWpN6hFvwpzE3HGSBxHXiO1ujjVtjXb85MJa
	U0U6l
X-Gm-Gg: AYBFou1tz0V4JRK+74W6Je+wUlHOhD8OZ6ogE/6vYMwZFUCKZHr4GXTfHQklonApY5Z
	sTCpmdZaQjq7P+WFlZoV/jQGdtWjNlFKMRN9gBV78jrpoywXRA481+SDmc8+Pozz5fqe1Ta8Z+c
	MMURg4sPFZ9JmGILX2siwDj2l0rbWknCbr7NGwevsA8Tfi0gk7oicJdrjVmHW6qurGf86AAhJ68
	lt1OxAWLtbTRoGDL1aADAoyljIKeC7WgZVosHpwUR6y2ELCX+oapakOu6GlX1/8lP+OSgisWfug
	NkRkcyAAc8E/Q9+yCIgSWv9jRnL3ZqfVoASgVJ4WWMF4Fce0bfPLjNjKBGhZR8oUhxXSU2rcq6C
	lkmO/n3Qn0LFJW8Ev3DkGpno+eJpyTvTyd8DrsTVXWayT1c1zz7iRi23i4skmPFAcihm6pyVBdj
	spp8ffRWp0LFEH/k+ihTnN2mc0HGdl110MWIwyZcIGEV3ImQQUgmlcgvqA3uPZxlEAkMRmwQWI0
	RGIaoldm42Rw3vjB3PYz7aJjHfgXaaeNKFnaEZg4uUnFJxwPfL9v/1aS/kQnJXu4ZtoH6qhzk7i
	SSIBvKxOqq+oY2yJS8vECaLW9gNrLRZZRMpJMA/LkUYCdtL4TQksLX9eGq8ZOJZzJregJjWkAwS
	lFYuDKWQ9EGJO6YNff321dModJvg=
X-Received: by 2002:a17:90b:4cd0:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3b166cdc367mr433934a91.27.1794248348759;
        Mon, 09 Nov 2026 10:19:08 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b937sm481075a91.4.2026.11.09.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:19:08 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 0/2] bpf: expand BPF arena kernel fault handling
Date: Mon,  9 Nov 2026 18:19:04 +0000
Message-ID: <20261109181906.7350-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the BPF arena fault handler protects against
a misbehaving BPF program passing an arena pointer to a
kfunc then unmapping the backing pages, causing a kernel
fault. However, it does not handle errors where the now
unmapped arena address is instead accessed by a non-BPF
path, or by a BPF program that has a different arena.
The former case is already possible in sched-ext if a
BPF program removes from the arena pages allocated
from the genpool allocator.

Keep a list of all arenas in the system and attempt to match
the kernel fault to all of them. If the fault does fall in
an arena, handle it with the already established scratch
page technique and retry the access.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Changes from v1 to v2:
- Replace the global arena list with a latch rbtree.
- Restore the stack lookup fast path, checking the fault address before
  falling back to the tree lookup.
- Defer arena teardown with RCU work instead of synchronize_rcu().
- Add rate-limited deferred logging for faults outside the owning BPF program.
- Reuse bpf_testmod for the selftests instead of adding a module.
- Skip the selftests when the compiler lacks arena address-space casts.
- Correct the Fixes tag to reference the introduction of kernel arena accesses.

Emil Tsalapatis (2):
  bpf: recover page faults across all arenas
  selftests/bpf: add arena fault recovery tests

 kernel/bpf/arena.c                            | 119 +++++++++++++-----
 .../selftests/bpf/prog_tests/arena_fault.c    | 100 +++++++++++++++
 .../testing/selftests/bpf/progs/arena_fault.c |  65 ++++++++++
 .../selftests/bpf/progs/arena_fault_noarena.c |  17 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  22 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 6 files changed, 298 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_fault_noarena.c

-- 
2.52.0

