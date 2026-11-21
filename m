Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299227;
	b=rBAai4901bzG3u+FGd59cK2CnLQWfJ/l55iZAA77j1//5+rHeyN2hvUXGSsFeIgmtimc
	 Ziis26BNFOeHnb19kFKRecBsmUMHyoTYNLBb4NSiNc5NfncITDpbuE48Gd+pBoUxxXwK8
	 lwlxf+bR8CGslPf/14TULV+RuCcR3lMr4p2FMgYtdfqj7Qdyqc6/YtLEZcCedWJ8qi4BV
	 u3BzNj09r3Y9vZ83eS7xLoAavyRJVxLtYTPl6iOWV9ziG8+kVNYnP2XgX8gb3lbcwWwQZ
	 X5KIqB3hRtJNbAkOXo8cLWZt1LAxVn3XyBrFaQyVj86h/wnK66OEnVphTSQJSVnQ+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8ddk2U/ceOcBuxIZmI4e5rff84kBRzARBj57F5POrs0=;
	b=GkdX/QhmMjS3IJ6m/SmkXpmYFpNdnhhEXIb8Mgi+9vGCgk3Tchidiht8O5Se10PwsDL0
	 VA/R9/GrgC+xyCarEBZ3LoozGkW8P3+KURNVrTL0fZXNs17qIRIIMyPbYUYAWmctzPsJ6
	 Qq74c9jgLNubswfZGV/Yuq673oe/zcvGcGgWxOoLRFUsIaixSTZHu3LCnaElc2frZM8HB
	 RuE0hgoX1j6rYwCsEjcgjZUUqTufdi2hhcMJjfeaT7B1mgbaU7tEEwkFifDjySWNpFkbz
	 3omhpEQ/uqBAWmFoKZs60H2ML51FQelQunEEQbhddIJcqPW3LPGkXtCzkZXa1KFbSYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpmJ+wRL;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F7606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F1F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpmJ+wRL
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso1593556b3a.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299227; x=1795904027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ddk2U/ceOcBuxIZmI4e5rff84kBRzARBj57F5POrs0=;
        b=dpmJ+wRL9GKzOMnvUs4zObThuzFw5YTbbL5JY229s00tPZ6FxRUgv7fTf0UYRPGi9D
         iwQ5dbVAPRagY438K/l8jWC5/qHHroummEIuCNGNaBn5zCgWtxR33Ww+Bd30MHaE9/pB
         mO4ncDPgbpI49Khvd7wq1sU9egUsjEluzqomK4Sj6paZRiHGg+1EcAS5JeXy/OQxgW7h
         kK3vwglZclN9jcMHj87qo/VTESBgdhUmO23UWqwlyrLW7LOmOIb5txhOobn1b6OHx2vd
         LdUIRLMdytiOLoUutF3+O7B7f1HkdML/HpqxDMHSN+sfwyBM9ud0NKqZu0an7l4yFX/3
         PsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299227; x=1795904027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ddk2U/ceOcBuxIZmI4e5rff84kBRzARBj57F5POrs0=;
        b=gNNpoKItIEtgWsii67TAPe9kt6aLcO4rS79G6Z6p9xG8vosroig/hwN9QUD+vXSizQ
         EZyY2CWPjW1ajT0t3QtYspXyZbmFgSafXQTPGRU85cMeVh1/JGFQYKAWtmlmN5M81uqr
         LDB20zd99bEXq0B/8g5cZYxjuCr1Ye1+cMqUn6ELj/dt0/Gk6yde626Iv+n9V/wv90dq
         95AIZhX33eY1oDFYaiss/PpsOnUiSG2jE1mV5+mgUTpmiigj3r8OpXATSp9XMaj+KWVp
         P8NxziEChDzBWSLWUKsa7FHHCIOzsuPJhr+rTd8HSLaxBlpIcAo9ohBL0BP3c3mL856d
         MOaA==
X-Gm-Message-State: APuU4Z/2wXhH3EH2zEDPVNNMyEx6x8auzd06J+R4r5JX+Gf09w1d91S3
	CDC6r7LEWxaqhGObpQX2i6eZpMTVASt+fufwIkSnI9+rk1yMqK9kSEq1G62rXg==
X-Gm-Gg: AZFdTZcg5NkoURxhz4QIoC7x2/a48KNYC32xReZdiTQd0QR1XHMpg6toRqvWkO3AkwH
	kVz+UhFyS7NyWryRZIjmlxPRWoOU/r52lb0LHUtz9Q3wI6bu7rGPaYQXHLRp2g3WYtzThgz9DtX
	GROLe6GULdqvnJEJ2zCgR8HNNCsyAIBeg2h+TbSQny02oRtuMTeJFUa+MX79uwQNUYFP8hRxxbX
	GFI2G9MYAnjcdOd9U5JKTaHn4AvQzKMH9FWH/bLbBPZmOyOGeG7zDfTdj13lDdp/lWnU4GRtI32
	3dgHbNQY85Ot3TQSq7QgzWsGW2FTgO9F1zaCcPxbdNif0yifdFHAHhBI319fmyjWUmveS50T7ni
	hFzzmEpfVoVrou4PlaQDUldd8yS7b07YBJMdEO70S5sXBln+Ur4QIHCXNmmzLmAWV34t1XXwVqO
	Q5Apnm6GytgDzvb1uOS0dsa1HNQ/pxOjRBwMVxAcBSi73snfwMbv3dqZGZcXW2SH3UKe2JW4Sd1
	eHHA5V9m7/UKCgSiPrsryI88A15bHXAQFIWQGpdjfvZL0M/+wazAivzYTLpJm6tHf8W2oF+qG+o
	P22jZQSxpzKOccNdHz7DKIJFPPsnSJLTthT0CocJbXZdRiEY+zWfSiBhLv/6oI5gdmvjagpiEg3
	b49zR9jCU55PJEBIa8bTYRlRXgUsJe7PJn5domPWYqY/ByWUVBGzd95yTP2jONJIPwKCG+03Sdg
	==
X-Received: by 2002:a05:6a21:3d8a:b0:3e2:9261:2342 with SMTP id adf61e73a8af0-4014bc549bemr6642949637.28.1795299226641;
        Sat, 21 Nov 2026 14:13:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d05c0cfsm2928017a12.26.2026.11.21.14.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:13:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 0/7] bpf: Fixes for the verifier passes
Date: Sat, 21 Nov 2026 22:13:37 +0000
Message-ID: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

Fixes for the series "bpf: Verify in passes, with equations in the state".
None of the bugs makes the verifier accept an unsafe program.

Patch 1: the build fails without CONFIG_NET.
Patches 2, 3 and 5: the path-sensitive run finds a failing path that the
program does not have. It cuts the budget, and a valid program is rejected.
Patch 4: the log shows only the last basic block, not the path to the error.
Patch 6: after a failed allocation a load gets -E2BIG in place of -ENOMEM.
Patch 7: nfp can refuse to attach a valid offloaded program.

385572 programs of cilium, tetragon, tracee, scx, Meta, systemd, rust-bpf and
other projects have the same verdict and the same number of processed insns.

v1 -> v2:
- patch 1: add the Closes tag.
- patch 2: do not skip if the bound differs, in place of a guess. A bound that
  is a range gave a false guess, and a rejected program took much more insns.
  Truncate the bound to u32 for jmp32.
- patch 3: describe a case that is not fixed.
- patch 5: drop only a path that is out of frames, not each -E2BIG.

Alexei Starovoitov (7):
  bpf: Fix the build without CONFIG_NET
  bpf: Do not skip trips if the bound moves
  bpf: Mark a skip of trips as a guess if a 32-bit value wraps
  bpf: Do not lose the failing path if only an equation differs
  bpf: Drop a path of a path-sensitive run that is out of frames
  bpf: Return -ENOMEM if the next partition has no memory
  bpf: Replay an offloaded program with the precision of the good pass

 include/linux/bpf_verifier.h | 42 ++++++++++++++++--
 kernel/bpf/equation_join.c   | 82 +++++++++++++++++++++++++++---------
 kernel/bpf/precision.c       | 22 ++++++----
 kernel/bpf/verifier.c        | 19 +++++++--
 4 files changed, 130 insertions(+), 35 deletions(-)


base-commit: 9867c61abbd44f7053a871566b3d982f62c6d8dc
-- 
2.55.0

