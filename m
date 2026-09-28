Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDF440643
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627210; cv=none; b=laO8U/v8wHoWtG7TlYDGl+HonODZlcQ1EJzhsNTYqKoOnJz378yY/OXGdzx2MmeCZJIm7heMAEz3M9H39P2Gqzsg3zUBoF6u6200oLjduirRzbDTtNGpKwBP8mjJtyeYx9VzY8LwYvuDJzDKOwrI5N6qbg+9VLLqS7g8X2MEzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627210; c=relaxed/simple;
	bh=aMTv39RJTweCDB6V0Gq51qUYATEa3GRhk75Eq2y4NPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CFvCWbPEXHe+ea9OW2U9mTZ0W4EncEw9PbvqaJwaNgdJlYeLEM2W+JRH9mOVu9Hm4BN+LADcvQJr5Q5I8Wn3oiQKmldt1czagXC7jJ2DPlwo5Tm6L3hvqkr3wpcCRl6P8vu45aZ77Uexer97HrfogT/1b2v3G+BfWE0KS8UhKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jjQyUHdO; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jjQyUHdO"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so1903749a91.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790627208; x=1791232008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UiPJeMOm8RGAVJ7cfH58gs0LItZJQ5KeMdLKTP+D+PM=;
        b=jjQyUHdOSdXaZsOSleAf1b69yrtFlnhhbmorSV0AacZPkEdrmp9M2X1+EV9LYlIZ6u
         XJuB1CH2W37oNDvSNxnOJywM6ADgvMDDy1+4H7yo9tfnLC0XoxWuynUrxh/5RSyyqLCc
         MiZutnGgbqgd0bmCFVtMEyHPxMZAEtdvFIIx+K9qVzGYFcyAoRQ8bIDo12+iMHaeTA4r
         jqwRcQsj2gBxVi9/EzgPpDK60nLaMrOeNSAxDnDAJJhCyJjaJHsjCHNQR8u5gqLxezWf
         bsIwzcXFX09vOY18S/LKtbrvHu/QStWBPDBErSpUbi11FkLyn5F1hdNwjsJAvpzAfBLL
         j6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627208; x=1791232008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UiPJeMOm8RGAVJ7cfH58gs0LItZJQ5KeMdLKTP+D+PM=;
        b=PaAXJ0wLgubxE7kuqVGZqpfE6b8svepdyuzllkFXZxWbAILGxvWJeDcewlItRvw4ku
         Ij44r9M5wwPr+WZ5FGiKLtQ22RP3Mn/nGaVn0NFSFF2Qg4hvULQdz5FWNO2+kSOpaHFR
         ycjwxWkVqQA4stw2henNLH7ULBvlHgac+V1iADfZpKmsVtRxxgAE+cq7XKSDgw4WnrXd
         qjxs8+48gXFPldyx/CIK2O2qhJbbUZcYs19+qwUuwkjnxDezvBslkD1OpyL+L3mV6aVw
         mvw3powaF4/2XeZ9xgr81w9xkVA+jDQeBr0m9xPIa46NxaSRsIflRs6Agez62nHDb6y9
         aP4w==
X-Gm-Message-State: AFq9FYLB0ENUzAs8so9xf/ZJHx9yjTvT1RwQSz78DQOlNQlV32EDE5E6
	YwWJ9OBx1lQEf5VDW64FM3hvE9bzzBP/mHkqe+3x/dzviDX8z15NQJaR1m7rnUcskFnSOGJSIhC
	FIbqeK1Q=
X-Gm-Gg: AYBFou2OzxZyQXmJ0ek7AinGeAExLtfKQxUOaqNkrfKK/z7cU78t5NQfC+HLWlukGL7
	ZQzaMBEBl1G+g+lWLO+aSjZ8DfNDw/yC4SEmwTn5fzWBNqhtaU9a1QiPNW71vE6wV5c+hvGU0w9
	mip1k3ynkGv0fTsHf4bIp0Ne5mbfOSfdKbWQipAQ2a+cPyoOupXMLlilEaE+uZFSWrD4RctEdk1
	Xkpa/6/iv5Y98mFj3g7bXzFVihS9uLMiCKRxG0LMgiHcLN5zORn+C3jFpi9HgXbiTbiM50CJoZL
	sZYDlAE/L1xEPjqPzUEBabDg6S63ClJVNlNQzKyU3tVt3OD6q/qXnacvhm4ebyb/WeDB6LCeQB8
	dBLMPJLL2P1Ri1Rvo+gbk5UKRkdLT6xhB0wg6+4mVxoV3eihqmAy6XOScXmq9fffL/AaYCpQ9pN
	sVllChLyBNvPqUTWDelZ9npAVrrYs8YOwfnbSAtJnH+xMyhBxBRiYH6fWdgDJLT5eTyadk2B532
	5Kj+6QTIBVPfAEKH4Lmpow7ylKAXaERt2xrF0Ro8Q==
X-Received: by 2002:a17:90a:e70d:b0:3a0:b3f3:a2d7 with SMTP id 98e67ed59e1d1-3a0b3f3a3a9mr9060500a91.13.1790627207940;
        Mon, 28 Sep 2026 13:26:47 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a492ea04b1sm975193a91.4.2026.09.28.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:26:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 0/7] Make sleepable arena paths use sleepable alloc_pages
Date: Mon, 28 Sep 2026 20:26:36 +0000
Message-ID: <20260928202643.9114-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena_alloc_pages() call takes a sleepable argument based on whether
its caller is a sleepable BPF function. This flag, along with the context
the kfunc is called in, decides whether the call will try to fulfill the
allocation using the regular or the _nolock variant of the alloc_pages
API, by means of bpf_map_alloc_pages().

However, the arena_alloc_pages() call currently only makes allocations
inside an IRQ-disabled critical section. This forces all allocations to
use the _nolock() API, which may eagerly fail where the regular variant
would eventually succeed. There have been reports of this happening for
sched-ext schedulers.

Restructure arena_alloc_pages() to use the _nolock() page allocation API
only when necessary. This requires moving allocations outside of the 
spinlock critical section for sleepable calls, which in turn requires
slightly different logic in the allocation path. Replace the page list
allocation with logic that reuses pcp_llist to chain allocated pages
together, allowing us to merge the code paths for both sleepable and
nonsleepable arena allocations.

Also fix kfunc specialization to not unnecessarily force the nonsleepable version
of bpf_arena_alloc_pages() for call sites that do not need it. This requires
making specialization per-call site instead of overwriting the descriptor
during fixups. 

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2 (https://lore.kernel.org/bpf/20260824082530.47553-1-emil@etsalapatis.com/)

- Keep the sleepable and non-sleepable allocation paths within
  arena_alloc_pages (Alexei)
- Incorporate bot feedback on selftests (bot-ci)

v2 -> v3 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Remove the intermediate page array allocation in bpf_arena_alloc_pages() and
  use the pcp_llist pointer instead (Alexei)
- Fix function specialization to only specialize to the nonsleepable version
  when necessary

v3 -> v4 (https://lore.kernel.org/bpf/20260925203939.4105-1-emil@etsalapatis.com/)

- Remove in-flight pages tracking (Alexei)
- Remove stale split sleepable/nonsleepable error handling (Alexei)

v4 -> v5 (https://lore.kernel.org/bpf/20260925233538.5708-1-emil@etsalapatis.com/)

- Remove unnecessary imm-based sorting for kfunc desc table (Alexei)
- Skip all nonspecialized kfunc descs during the linear scan done by
  function specialization

Emil Tsalapatis (7):
  bpf: Use an llist for page allocations
  bpf: Add sleepable argument to bpf_alloc_pages()
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users
  bpf: Directly store kfunc desc index in instruction off field
  bpf: Support per-call-site kfunc specialization
  selftests/bpf: Test per-call site function specialization

 include/linux/bpf.h                           |  10 +-
 include/linux/bpf_verifier.h                  |  15 +-
 kernel/bpf/arena.c                            | 158 +++++++++---------
 kernel/bpf/fixups.c                           |  70 +-------
 kernel/bpf/syscall.c                          |  43 +++--
 kernel/bpf/verifier.c                         |  94 ++++++++++-
 .../selftests/bpf/prog_tests/file_reader.c    |  15 ++
 .../testing/selftests/bpf/progs/file_reader.c | 129 ++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  64 +++++--
 9 files changed, 410 insertions(+), 188 deletions(-)

-- 
2.52.0

