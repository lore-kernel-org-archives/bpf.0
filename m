Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10549B5DC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591409; cv=none; b=iy45ncyvgJTnWB/aQ61hCYmisI0ofEu3tWZbvnShb1CvKFycpmd47b7r9reSNomdk75k3fhGO3+x1mRpNRdFwItaIYKzTwKxtzguWSJe/Zo7YeQYtRAYb//Vv7HUkJIOn1tuwGcSpEjidgwNU8HWcIFISMvxI772Lxzs2vxMtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591409; c=relaxed/simple;
	bh=USaxsWYoOs5PBzZk8r1zSp7eRg3lxrqWFUdWkmAAbn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNLzLENxm5uZd/caoMGn2KjhK2U3O6q0yT9Y7pMc+rLSxupHsJ5JWvVjaFnaX6RxqzYPRp7v+uAWM5yMVQKArCDYZmOdfCBCpSnlzJ/iWcRPKwhPK+gHJNcxWuuCDI2Ld5qV9CSbTp9+5TNT8rgvrULCog9LocJ9O+fzYZB/d3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PERz4KlR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PERz4KlR"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C23D680CA8;
	Mon, 28 Sep 2026 12:29:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1DzLjhfpMDf; Mon, 28 Sep 2026 12:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790591398; bh=USaxsWYoOs5PBzZk8r1zSp7eRg3lxrqWFUdWkmAAbn0=;
	h=From:To:Cc:Subject:Date;
	b=PERz4KlRV2WXmCJrC0tRHgqeA/tjuqgUy8hMPc01/ym7NgCxMujrCi86e67Mjgd6D
	 Q6DA7TuBUxC0i0OpBwElaAwb76EK06lvanu35U/aOb8/5MVB+RimoFBgauOUAFxDcc
	 GoM9R6dIQMf61TpiHFXkqV1CfIxavlLZItuksIkGgdPnTyQLl7LBrwdCsDa9YtKNbl
	 6ntMpnx6AQhKC9O2CzEdhbM1Qy4gu+QWNWNWI8Lm6tSCrU+DPDesvalqY7UyvARO/B
	 55i1MXCC5OM/2Iff0PeKJO8nEAjRSr710UAYpb4Kt4FTCtLK15+Hfal4v6+JBclbuV
	 B8n7sTmBgd6CQ==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH 0/2] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Mon, 28 Sep 2026 11:28:19 +0100
Message-ID: <20260928102821.995214-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_HASH map, htab_map_check_update_flags() and
check_flags() are not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

Also for BPF_MAP_TYPE_PERCPU_ARRAY map, using the (BPF_F_ALL_CPUS |
BPF_EXIST) flag combination with bpf_map_update_elem() results in an
incorrect EINVAL error response, even though the flag combination is
valid. 

This series fixes the bug by adding proper flag validations and checks
and adds a regression test.

Masoud Aghasi (2):
  bpf: Fix incorrect handling of user flags by percpu map updates
  selftests/bpf: add test for percpu map flags combination

 kernel/bpf/arraymap.c                         |  4 ++--
 kernel/bpf/hashtab.c                          |  9 ++++++---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 20 +++++++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.47.3

