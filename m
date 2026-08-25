Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DD3F5BFC
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654602; cv=none; b=UifgP0eo83oMflPdqTRyxZnTapCXXoBErVx09lPvQbI2jDRE+E8uk3qx1A3fDKxP3OgTBfnbBaUAkYoZOYvjKsbBLv2LD2f/ltiXm11n68Ia/ZjRXik5/QUiOsuinIr6t9b8pwm6xHLNQxGuzxiGSMWAkefQTlJDswox/fxptQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654602; c=relaxed/simple;
	bh=0zANFej4u+q9CF7X0H4BOnsO/0nY+wIXmtgQ12nWf1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3b5rbx8UO+UvuKlrU7YLoS70TLrFaMwgLGpM3l/3+WuM3UImHa0jotRVOJ5bqLAeKgp1qNqBoz8wPCTDpX3BPz7DJv0ZX7Lc2hD2y7iGdZdk9rg5O5uBAMUUbwUEalsTt1ziGQaX9+z4+qXRygytUxn4paz3hUzvMRxhKay2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfjUdWHd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfjUdWHd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so5214068a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654600; x=1788259400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pW4A+CKMNwSiHP4zIXq+SJXfY0QpSMCvp/12NYQIZow=;
        b=SfjUdWHdOHGicQrqq6zfW7yo0cNH4J5coiZxneLeW6BNClNd1i/tO7XgIKV/DYo8hm
         bSMiadiSE4hX06x7sQ+5rYteUKCA+n+0i6Ymh10LUaUCGVUjLWOwa3TzkWiqVMGE6WgS
         CDYDGA17yfsJo5fwPU6ck+bvvCMjj+FstTMwa6FuLmpZV7+lf27gZ8P3RQhureZ3BW/c
         o18Oj4Naxnx+LXrngY/2kJfVTcm7Bbc/4oqZNG6regKPhLQ7cqC66E02LPruaZB+kBo5
         Cy87TxEQgd3xP0Ahy56kNCLcyYjdT812k4YNGzn39kb/g8TqPLnOqgyOJmQQHs3A/Tn4
         bAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654600; x=1788259400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW4A+CKMNwSiHP4zIXq+SJXfY0QpSMCvp/12NYQIZow=;
        b=T/dCSvqQA7upEsKuhZuvCSK7Wj5voEWqbAJ20X+a4/mrZG6Uujj8Rm2MpWVFm3tiLR
         dzgc5dbrktMGPhsheTj+q3kZjfJZa2Ck0XaLHk17+uTrAQdiH1EuCGOwdzfWMIdfNWBo
         gZ0jjr6BEaxRlemsHKXRRv2M+vCZ7ykhvAXuzm31oircJsTylyd226qMOgDDdwy4G4aG
         2JKxgFU4WMhVAE3Q/SY0AJ+oNrfwG95JMdg2Se8erwKyO0Mh8UncAvQbVPPYJzT71pIL
         wXtextw//6AcH7QdNGsiKptEDn35tqILwmq2NdJa4hHRE1Vwn3wIBA/5xWj63gTW8vSm
         0dNQ==
X-Gm-Message-State: AFuF++leG8AEjct+yP9kQrHcuUBKA2HzV1D4BWY9Body11A7s4dUTT3+
	ZmiNbW1H3VC0AcZimw2+Wsdj+99twn5i5J0a/DNozXHkemw5wiiQaa72xYIw22oCMmE=
X-Gm-Gg: AR+sD13U9p1uQfAYsWnyBuHfDOma5gCSOby0tgF0C8aZT7xw7uoRwma3bJ694VFb3PZ
	HoPxPrDF5d9bMwNkyDnucKhhDGsmOodHrjh9W/xiTaGZeC0AtxYBaQZaDGBn6o7V4Wc+++zFMR4
	bZxU9ejBAWDjUq6uH86i1nSu5pfJBhUUFYpSBzNqJ8kU3QjTzqn/KuyCI1EJrhA8MbpHVQXdhbX
	n0BnHlfM1JvTdJfVRATIpQE3yO6qaj3qLqeYLneACjNNnBN6Qb2KOOfyjlf/wW2C9LspDUmtvHT
	2xfVpkZTf9C6naC9XXhfHEJ2HVlhWI/rQTz1qoEL4JRjTx40q4Ha/Un5JYJIM4+Ml3HUT/wN93f
	NxmfxDrovO3gXFSsGMCg0oAfXr+6TEjVIqRgEJFN/rV7DSUBgwyeKvxV/sGbPG5O3bPQKyLFCbd
	q8gutxZZ4IMR2Ba+erSbOOh1Ab66+cR+94aGPTiTTpkPvZo1f64AKws72/qAkH/htv7QkqVJBsL
	+zLA/3lPimxNo+8u6XgvaQU
X-Received: by 2002:a05:6a20:918c:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3cd301a21c1mr62254681637.17.1787654599984;
        Tue, 25 Aug 2026 03:43:19 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm28228669eec.20.2026.08.25.03.43.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 03:43:19 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	clm@meta.com,
	ihor.solodrai@linux.dev,
	ahemadkhawar123@gmail.com
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Tue, 25 Aug 2026 16:13:11 +0530
Message-ID: <20260825104311.84038-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Addressing the three CI review comments on the v6 series:

---
[Patch 4/4] max_entries comment
---

> could the 50000 carry a short note that it just has to outrun
> ARENA_BUDGET on the smallest page size

Accepted. Will be fixed in v7 as a proper preceding block comment:

  /*
   * 50000 pages must exceed ARENA_BUDGET / PAGE_SIZE (64M / 4k = 16384)
   * so the fault loop hits memory.max before exhausting the arena itself.
   */
  __uint(max_entries, 50000);

---
[Patch 1/4] bpf_map_alloc_page_sleepable() reentrancy documentation
---

> Michal Hocko asked how bpf_map_alloc_page_sleepable() achieves safety
> from mm reentrancy, noting that sleepable context alone doesn't
> guarantee safety.

Accepted. Michal's concern is correct: "sleepable" does not automatically
imply "non-reentrant with respect to mm". The comment will be expanded in
v7 to document the reentrancy contract explicitly:

  The only current caller is arena_vm_fault(), which is invoked from
  handle_mm_fault() before taking arena->spinlock and before any BPF
  subsystem lock. mmap_lock is held shared by the fault path, but the
  allocator only needs it for vma lookup which it does not perform here.
  No BPF-internal lock is held at the call site, so allocator reentrancy
  through mm is not possible.

---
[Patch 2/4] Lockless probe race and non-blocking fallback
---

> Doesn't this reintroduce the exact problem the patch aims to solve?

No. The residual race is intentional, bounded, and qualitatively different
from the bug being fixed. Here is why:

The original bug was on the NORMAL, non-racy path: every arena fault where
no page existed would unconditionally use the non-blocking allocator, so
any routine memory.max event killed the process. The fix eliminates that
by preallocating with the sleepable allocator before the spinlock.

The fallback path (!new_page under the lock) is reached only when ALL of
the following are simultaneously true:

  (a) The lockless probe saw a page (a BPF program allocated one).
  (b) That page was freed between the probe and the lock acquisition.
  (c) The resulting non-blocking allocation also fails (memory.max hit
      in that same narrow window).

For (c) to occur independently of (a)+(b), the system must be under
memory pressure severe enough that a non-blocking atomic allocation fails
at the exact same moment the BPF program is freeing a page. A BPF program
that frees arena pages by definition had successfully allocated them
moments earlier, so available memory exists nearby. The likelihood of the
non-blocking allocator failing in this window is therefore extremely low.

More importantly, moving the probe inside the locked region is not
architecturally possible: the purpose of the probe is to decide WHETHER to
preallocate with the sleepable allocator. That decision must happen before
the lock is taken, because sleeping is not allowed inside the spinlock. The
probe-then-preallocate-then-lock sequence is the same pattern used by
do_anonymous_page() and do_cow_fault() in mm/memory.c.

On failure in the race path, VM_FAULT_SIGBUS is returned (not
VM_FAULT_SIGSEGV), which is the correct signal for a resource failure as
opposed to an addressing violation. The commit message's claim ("prevents
a routine memory.max into a fake segfault") refers to the normal path and
remains accurate.

Will add an additional sentence to the !new_page comment in v7 making
clear that this path cannot be sleepable by design.

Khawar Ahemad <ahemadkhawar123@gmail.com>
