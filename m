Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5643B0AE7
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332566; cv=none; b=MWHZv/ZeaAR4gstuhdNC+ADs/XY9rJMWjlG+0SriK5nTLsPNN1qVyF8x0InpwNiyhLqPkOKilIn+41WnUrgSegq3qnfG4psCCLCCzb/ol/E2alSd3JWlTjfzHYOonhD7mijgBE5jjZamxtyLfjWE4rdnygy4hHPF8auZy7szc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332566; c=relaxed/simple;
	bh=LdNSOqIAGBRNXF8TDlzJk+tfJUNu4nbRqmS5oZy73gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5Y4kvyrtlaGCRu++IimZMtqefrQvLREmG8EkvtKLpiu/el+kmC2R3YW32L72wdLaTh4HNOjM6un6BUIuGqg5ne7mL6aXs0UNbYFhclojyOV2TYtbHXgGjTesBy4IlM4mZp+gH6XUBOZWA/6OwSOCjyichkT9dEXkIgRxWSP2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qgAZoOi/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qgAZoOi/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so885527a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332562; x=1788937362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKiQgwuKr/eo+sGySHSxTmiLup8GS+AC60UbE1XSTtk=;
        b=qgAZoOi/maYcUuTndjLLD42bqEiI66MmCi+Z8wH8HcWrwkxVZ2mFq6VZ/wGbLfiZCJ
         O1Yc4xP5zguruCcnuow4gE1c4qKtPqk2c4Z01Qmh34btiB+ceguu7vab2fgZdkCKj3hl
         JUtBAmYktICbcm8IPFtTU1f+uqZKiy3o47mH14b8H7A5YyKR3dGgoLbyjlF+USqadCNV
         dSz71ZJpBra6aWMghMmVUM13z5Y0ni4ngwRKuhYiqo6ESEJrEZX1FMdHbvcbtjcu/x6J
         jxjVuCgelLLGIRaz9UVYOPiAqAwYC56gUrweXE7ifv6bc/fGnJi19PRyy2wgyQRyXAFu
         p9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332562; x=1788937362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKiQgwuKr/eo+sGySHSxTmiLup8GS+AC60UbE1XSTtk=;
        b=Wlu9viqS7EH9AQ2PTyX3RoqCt0utkGAEFiTMhd3R+ZCP6SRrliPnsCaeeb17p7a47z
         qnAJ6432hy8mSdDvdffRkPpBy5imze1HpNkZX0vdIGdxh/+5Lbkjcd9aQ9Sx17mDahNj
         v8ghQ0ALifWstmZuGogBUOjJc6arDbNu9TUYKHOhYRNEh2lSQTBwtOVrXYjh7hxt0YWI
         Eh+QE7U6c1bv4dSPoxp1hryuA58aeqSQIUtU3H8IYvInGc0+uTJvvQsiY8QbUYpJCUnx
         /44u8YFjBDuy8gnEoAW1RqAmb4jmG0fPRSigvfMMD9JPdDtry2s5OsdXp95MXSl6clbX
         yLRQ==
X-Gm-Message-State: AFuF++kc8sCm2a5VjRujD3WjivL4uqSEwbR0NVO3qyynIongrga1t1Ev
	xnU2yQ9cbqvpOomNCZ6roGu5RFG5O9vNuf5Sm14E1v7Nh4WrYch1gG/AFK0OxALFNUUEL3n+n71
	omOvS
X-Gm-Gg: AYBFou2iesgNt+HBjyNcVBX+4NQlJoVvVFygJbteBoW8JO/8PY8+roE9R9g6QtkaEGU
	cSyxzTmNwEDnJkFKip4wSnH7YYclzN8WF599aAXUX+7SECrdEN7YAjuX/QfZYtYIA87qGGNtImF
	EulShzA0klmKeCZIPvCZIuGIS5G3PUdWSaW38JOkcAKTmn0SkBj0LN2ksTSe6Ib6w2gPDN99Evm
	biPR1Oht30YchbgEbr65j4ktM3lnRSYf3RQ1cIE2KK7lx2qLbwJbekvdVjD738vwa1v4OiFtv1P
	3/5ht7O4Sy4o0TaJAyxuRJjbo8llMJwjzlPXmCpPshtH0PLTDzhutjMngGMVmA4HCKsMX3P3n9L
	37yAd4AHDpM1Hi8tVJBzf8Xmcc/dvbeBVczFGhTWkFuCzC+5JZn+Jk2VvcTmTbTAWGioETpH9Px
	OdpthCCuyQ77xVA5+5zyrUWa3xqk8GBJbLf8pLujqQrR7NCI+OdsU6cIdW0S4GEta5gCLVLy1s/
	w35kcebaDadTZ2vvDUAUuDV
X-Received: by 2002:a17:90b:524c:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-39aedfb8ebcmr4194407a91.7.1788332561990;
        Wed, 02 Sep 2026 00:02:41 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:41 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 0/5] bpf: Fix arena memory incoherence
Date: Wed,  2 Sep 2026 03:02:34 -0400
Message-ID: <20260902070239.16968-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting up arena memory for a task currently requires two operations:
Adjusting its range tree, used for tracking which memory is allocated;
and adjusting its page tables/flushing its TLB state. These operations
cannot happen atomically because their critical sections do not nest.
This lack of atomicity is the source of two bugs that can lead to
incoherence between different users of the same arena, wherein they
observe different pages for the same address.

Address the problem by more finely tracking the state of each address.
Expand the range tree used for address state tracking with a third
state, used to denote whether an address range is unavailable, either
because it is being freed or because it is being populated by a VM
fault. Use this extra state in the arena page freeing/fault logic
to ensure that operations on a single address properly serialize.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (5):
  bpf: Update is_range_tree_set to work for consecutive ranges
  bpf: Track availability information for ranges in range tree
  bpf: Fix arena race between page free and alloc leading to incoherency
  bpf: Atomically update PTE and range tree in arena VM fault handler
  selftests/bpf: Add arena allocation race tests

 kernel/bpf/arena.c                            | 154 +++++++++--
 kernel/bpf/range_tree.c                       | 211 ++++++++++++---
 kernel/bpf/range_tree.h                       |   5 +-
 .../selftests/bpf/prog_tests/arena_race.c     | 251 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 163 ++++++++++++
 5 files changed, 728 insertions(+), 56 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

-- 
2.55.0

