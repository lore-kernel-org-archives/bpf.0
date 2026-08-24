Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF150399015
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559936; cv=none; b=DBLyZYAvGdFI5TiuFLw9gMTgyTXYNMCHCPfDK1Wq53zvRxdqCKAi+ZENRTxJAY9OeTf1DRH+MIDwDYP2eeutjYHIG8Tpsp0fV9u7jyMkaTPwbo4Q1jCUe0EFlKkBc2KovIVG+iwvCE7fiqsnUjmtMuaJ5XFkFcNRZwzK+M95LzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559936; c=relaxed/simple;
	bh=7oafVxpWkL3OgUtoNhKf9dDYVmVaih/DgnbmdUKuGXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcc5/4tdzRr+PX+p0+ym3X9bKqN6Zl30gks8gviRfd9M9eC5YsfRnx9G/O8/vU+g3BmIpWoDhJ7DncXJ/ECuaUkaC4fv4okYcwS8wrNkAHa1bJqKq5Ag7LLx8PhUfwDZPE6aE0v2LsyqjuRatM69aMK/imJdLeQOG+GPWH5F0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=dAh47H5u; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="dAh47H5u"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381b831d535so4539051a91.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787559933; x=1788164733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+5OfFHd8tqKLhYCqspC4ZGMrbnn4gzC501e3sifvWBc=;
        b=dAh47H5uAfBRpgW4tNpEjhG88odcZGHOjJRb/Q1i9qlYPwpp3BVckqdJpajJvehEBf
         mela3ctrzcFp02gRvCWCNAQ0rjcQ3Q9YQPWIjyjeFaxt3daQPLQ+yrwwRk4voKHrZOOe
         kS5iFo57Cgpn+SWoVb3dovpdFhQmgldOBSMceEfXskQmTj9CLt8US/fyT3vFlBJW1HeP
         p3whw9/aKw6IvBLsDBl/b53qytjWzQ8ZLXqIYHBQgD5UYgWt+/gPU47P3dvmHNcndCbP
         /piTuqweePo9GT55+2lsMMdR3Ebe2oMc1RZRLpKQN5cecbs+rWbSHZ+cdjpp2I0KDqsZ
         FNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559933; x=1788164733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+5OfFHd8tqKLhYCqspC4ZGMrbnn4gzC501e3sifvWBc=;
        b=H9ISAl3e6cFbf4fzBN4WFndBV6Kmk7pPd/gRy+nbRdMR2Ir0U6HCDA/q/QQPqS9zXk
         WWVyD1jD1hWFJhyIgINepiY405kQUeleBctDYIx6ZBUQfn5zsBe4xWDP1UJfBWhCfWGA
         rsp64DHYEwyXpBBFfb3axmMq8KFAr+Yh/KU3tl6pmm8HZSfDD8CpBDVhAspSFrt4fN8p
         8dvzrXbo/8A5Nu2NrSRGUUuSkPyIGypsbgcHhcEg6wT5LRbOUpUBflMqgZeUaPI5VFT+
         RKTmfa/d6UrksBygwo/LYR4oAthW2z7zheBA5Z3Uo55asY7aRUZ5CixdmWUVGYrpRt01
         XtOQ==
X-Gm-Message-State: AFuF++mWKc1THdAYNSBq0bsGZSXwMBN/Ok8tzN/g6I1ao9is50ImosCs
	WoR5rmtiqp9rmkFP3Yx1hscz/UlzFBKWLOMs7W2WQh3WiDP3LhUqPXXUCb0lWWg8g1ba64oOGTH
	zD7Z7
X-Gm-Gg: AR+sD12LxSvmAyS78bc4t0iHnSxJ4DOsOA//frAzNOHJOJY/ILtlY2KU63vfoDpOFWt
	XoZeUfNZBHY+EsRKQWt+rsCq6kenAVj3uk+MsRwtFDjZEyiChBYCpVYTfRJVSiG5xygo/2BV5qC
	AL+nTpLvTYlUCup5bNG4K2Ei5h/yeCO85DNLIbkmimSgYsEvOlx9sIX/8JNSwRUxY7f6F/OUvx3
	bCxe3Ch8hQtMKej7CBYLi+r5ieC9AhOUDAVo9DzHFwLejQ/ftAHWXkz1vodhT2qx3HMLZJq+uRv
	1TER1xcgEX/4za0+TyQtQsZV0DwAZJ8Y9kEv4Ky1W6jfZrzpgMWXRDVYuqOnr1mpOLPwJA/jM+W
	F9oIXZYSnOHY9Lnb3X1w1AIq4ZPjP6/W+yLn/a7QiSfEGeDrgsqbdVzWtPSwG3MNiC2/mxZ0ZSN
	ry7IvAiWXdJw1g/TMDTdnmiSb8lT0Bt7vJW05sd/pZWRv0b5dwMK6W/BuJdjfuhfOn1BtKn9kSp
	bgm/8cq74SDCnaM0DwikmI=
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr50284988a91.6.1787559932868;
        Mon, 24 Aug 2026 01:25:32 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm9518512a91.17.2026.08.24.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:25:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/3] bpf: Make sleepable arena paths use sleepable alloc_pages
Date: Mon, 24 Aug 2026 04:25:27 -0400
Message-ID: <20260824082530.47553-1-emil@etsalapatis.com>
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
slightly different logic in the allocation path. Make a separate
sleepable code path that implements this logic.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (3):
  bpf: Factor out nonsleepable arena allocation logic
  bpf: Add sleepable arena page allocation path
  selftests/bpf: Test large allocations for both sleepable/nonsleepable
    arena users

 include/linux/bpf.h                           |   6 +
 kernel/bpf/arena.c                            | 188 +++++++++++++-----
 kernel/bpf/syscall.c                          |   8 +-
 .../bpf/progs/verifier_arena_large.c          |  27 ++-
 4 files changed, 175 insertions(+), 54 deletions(-)

-- 
2.54.0

