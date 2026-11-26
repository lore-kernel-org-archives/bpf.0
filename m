Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664302;
	b=O4FCVTCCPvDsfhJfQLvnV9kTZShRds/B/pu/lwrAWCdLVXDDrZD8AJiSRPvQvEhsGPnv
	 x2B8UcH/uc0Ld7lmie2RrcJ6kRcUf7EJcBOnv/nYdB9z4Xk4hGzdAF72/spKcl7A1VPln
	 csKB86GnXoxtXEtDe9zMi7Eo8TQZ6lezGMBpORxSsZ/UJhKIypNYehaHmAP1LddFO6uqB
	 eUC68EfxY6dKEduhND4ou/o88cBGkDzlXCa44DU5km1UZ0bYyavqCUlZYu+ZhpezAnlKH
	 fiixud98D4J0kTkFwfNJYv8vBiJRnpsxRZvTZYyn6a01je1H2mwfQ6XExht+J2KV3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q2dLJEvuHzabOl+NMMfVUflhQb94zPeJ/o4FYlpFPfo=;
	b=01UPXd1Ludms6ZtP4aJO4ArUj6WbScyXsv+wXyRkTI3Rc93j4ZdU2TnzrAeo8wPbePR3
	 oU0ac28FZC3+3S5cqh5AkA12iTHc7eR2uE8fMeJ5DTHkEnLEGtAk1SKTeQZLVq/AIVg1O
	 AAoLvEpAPN/XWSg7uchDSl7lqSEGOJa1PD/1J+LdmztMwQKi836REc0UNG8fGxKFuwIap
	 UHno7amJtnSVoZkJZEwCrXdTfK8IY0xhWS2zlEVxzKf5bu1qegPe2Kc4OcuvMPQ40us9X
	 AP0vPO3sk3F5j7CJ7wApnV0kzQ/5LhXyH4PrdQVy5A3YVmoU7MARz4y/1cCmi0SoXgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zw2wO5xD;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBF606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBEBF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zw2wO5xD
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f06ff94acfso28852795ad.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664301; x=1796269101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q2dLJEvuHzabOl+NMMfVUflhQb94zPeJ/o4FYlpFPfo=;
        b=zw2wO5xDJ7oQWIztD9yuD2ENOcD8GeT6VfOzR6c/BAMV6PWFq2fX24nw1pfuXEUw9d
         AnbTSzw6wQVGX5C/ZwZSFeiva2FBb1lox7+mEb/cLcbh1Zu0L+UNvs5l/VjZv9BHMbzM
         /8UjZ3VAP/5YetxWF2P21NWuOObt0hgD/1Eln3QodqmZSW33bNCSwtE/kRzdXOb2516E
         Eu0jIQYL3GjRVj0OK4XGgN/tJTjRDb+r8uUDmN7x/c89UZyrLdY6kcZaaZvcpyS2o7VW
         JbE6MRZG9mVjCK/PpabbjjhkRmkKZdcxQycHujKGidSW7rBlEmZ91krn7/3nUXxQVEYz
         wnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664301; x=1796269101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q2dLJEvuHzabOl+NMMfVUflhQb94zPeJ/o4FYlpFPfo=;
        b=CtSpYmHko97c8F/PhlYJuxpjK4XVtoVDOjyIObYADYl/br9uVYTqDXCiDKZunD3xrz
         +TsD31ReE3/RwA5nO6e0mfCPEDtaf9KhnODV6/q1m3NP24pPCsf80bPzhjVdQYOtGKcW
         kbIJ+Bx9z0Lih4zJM40RWly1VyML1UpCaxrMazjGoDl+LFtw5CLx/sqb3d1IZN8nLHEb
         J8Wz5rPe4gs5IDFJcKl11AkBtZcsfkbsNC9uBh9Y0lp7Ipo7encVUP7If0jyTfKu4Crv
         ai/angS1sB6y+zP9yGGWFG51/gDbfIwsDkfKwkNyREDmR//NspfRzTUQag4N7fgnfolX
         aSug==
X-Gm-Message-State: APuU4Z8b/HH6wqf2UNZlZL5X7O4Do36OgzIMRVpyg09lx4uammyLH1vD
	eHtkI1NLmNQ6zpxlAECmwF2pkJFCwbYaBqs0su4VKjmnh4OOe9mcEcDeU2nkPw==
X-Gm-Gg: AZFdTZfbqxwC1Pv8X93D0r1HWQHFZ3WRfokNSqMfu4UGZM5PVliiaCpsGX3gUtIrwyC
	awLCcl39CQOkbhzg19qw2bVx/MlR2ipJZe+TLag3zx0NQA2nQA44/EVC7BHEtDSdbIGO5q/5cpS
	JQNvUEtPfYZ+gZOxXAfuA2aSBAkB8YHVB8shQzWPyQLSk9OmKFYjBNlfsKVRj/La+LHWfcrC/wC
	kIIZRdqbOCnyhXOxBS1X3RZVTK+OXB2d2mEjQ5EMefP44g7VUqJHhWLO3Pu0wd4bKVoC7jXy7CP
	kM9zNosaLTeg34iRK+MqbtSxl4qzWf3SXbpgWiIkhUtiihwwK2zbrdvvI9yxtkmL5+Yk7tkRc1A
	irKiXDUQ/CwEiijWiJQpzWQjUb2Wre79iTLuBYoObm8MpGZgrJvWIHsq+vxiGJPg5Fe5OQZV+W6
	LPArHfL9DMRl56UlcRv8hCZurxHjdIjaWIQXst4zOKO5ut90/TGgJQcwa3ABQcpvW29zWKwhw1H
	25vGJQJFDoueY4HS1rhbx3JiHGEWrWpMVbvf0Od67LKoQhuM9JS4sA1NwZBVdG/ypkYGr7jqvwH
	clSwB3pdPIYzr/FiDUMJAVxBFR6vknzpwX2GNoUihkjZ6u8RnkRgi7pwhZK2iOQFElsS2kdrOon
	pkRsKop0avB9Qx44OeU40DJozZIgTJuQUoLSkbw5HJx/rKISyj+K2H1647l3lmni4L2SiEs0Z0w
	==
X-Received: by 2002:a17:902:dac6:b0:2e3:1bb4:6121 with SMTP id d9443c01a7336-2f03f177052mr169821535ad.49.1795664300027;
        Wed, 25 Nov 2026 19:38:20 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c7dsm96286185ad.55.2026.11.25.19.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:38:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf v2 0/4] bpf: Fixes for speculation barriers and constant reads
Date: Thu, 26 Nov 2026 03:38:12 +0000
Message-ID: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in the verifier:

  patch  area
  -----  ------------------------------------------------------------------
  1      insn aux data after a failed check on a speculative path
  2      spills of invalid registers
  3      unaligned reads of read-only maps
  4      the barrier after a store to the stack by an atomic or a call

v1 -> v2:
- Replace patches 4 and 5 with one patch that emits the nospec after
  calls too (Luis). Patch 5 rejected bounded loops with such a call.

Patch 4 takes the idea of Luis's series [1] and inserts the nospec in
another way. bpf_patch_insn_data() moves the aux data to the last insn
of a patch, so "call; nospec" takes it from the call. [1] adds
bpf_insert_insns() and a new pass for that. Patch 4 leaves the call as
it is and makes "nospec; insn" of the next insn, with the code that is
there already. The price: a jump to the next insn runs the nospec too.
bpf-next has replaced bpf_patch_insn_data() with the patch list, so the
new helper would go away at the merge.

v1: https://lore.kernel.org/bpf/20261125040820.947816-1-alexei.starovoitov@gmail.com/
[1] https://lore.kernel.org/bpf/cover.1795625597.git.luis.gerhorst@fau.de/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (4):
  bpf: Undo insn aux changes of a failed speculative path
  bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
  bpf: Use get_unaligned() in bpf_map_direct_read()
  bpf: Emit nospec after calls and atomics that write to the stack

 kernel/bpf/fixups.c   | 11 +++++++++--
 kernel/bpf/verifier.c | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)


base-commit: 3db9d99ba7b8d5a4a520f5abf785e17406f518a5
-- 
2.55.0

