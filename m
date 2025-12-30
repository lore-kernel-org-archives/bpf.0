Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4367263C8A
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108633; cv=none; b=fGDfutnu1WZcX4EfSjeSYxSIeJIicVdvpqxMhUByywJgtXj8DrIpC4gKyH5Bmhuvjq31wEZJexhX1CQ9y2xEiXEgGyQdJmV9UMY+udfwBoeJUgrUl1CqTdZ0qRH23s7OMx5ldp+MfMfJgGAui+c1K9uxvVoPnCh6S4mtkxfEPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108633; c=relaxed/simple;
	bh=ssu+PxirWn+/8Vo1NqN5RFiO7dUUPwGUyMPbmbH7VHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RE+u58GdlYpG8v8KfFC6X16d+tLsc6mmMYAZ1Z77TFUjHlpgQXISzNYuQ3hxxDusqrk8X3ikdOaYg5ouaUmPrFNwqAd/qB3X497Vb2qqtHZAA+06OM4wxtizY9Lm+NatcfXN2yK0WTpEPDbDSijcVn5f7zecZzkOdRyPXabMqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssgE/6oF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssgE/6oF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FD3C116C6;
	Tue, 30 Dec 2025 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767108631;
	bh=ssu+PxirWn+/8Vo1NqN5RFiO7dUUPwGUyMPbmbH7VHU=;
	h=From:To:Cc:Subject:Date:From;
	b=ssgE/6oFAoWucEWOQUBYfdD+O1oTnb6XYXpg7fO6wA+znEYfuRvt5oP0IniaQdr2L
	 18GT+MqIMNAFe0G0p9E3oAHpbR4s9hXRq3w7K6MmQeRxTwDkrvYC2l3hOw2kbMRW/B
	 z363vLmAxUTeIiwsXdX9tBSey9vY+5/fwnmBdI2YejJuyHxQzXgz5YUnE4dQEr2vco
	 MXyyjRs/GsNZxaGIOzgYMwTnwKOoGM3e590jzB8byXR45O29NwhNSX3TwRiboduT5Z
	 /s97KwikSIb9aAwO/YWSezLU2g2GmtQ9sORXB+BNAeBFWop3PtDkWDfooT9vrCwZef
	 UqnDWQ/0DL96A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/2] memcg accounting for BPF arena
Date: Tue, 30 Dec 2025 07:30:02 -0800
Message-ID: <20251230153006.1347742-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set adds memcg accounting logic into arena kfuncs.

Puranjay Mohan (2):
  bpf: syscall: Introduce memcg enter/exit helpers
  bpf: arena: Reintroduce memcg accounting

 include/linux/bpf.h     | 15 +++++++++++++
 kernel/bpf/arena.c      | 39 +++++++++++++++++++++++++++-----
 kernel/bpf/range_tree.c |  5 +++--
 kernel/bpf/syscall.c    | 50 +++++++++++++++++++++--------------------
 4 files changed, 78 insertions(+), 31 deletions(-)


base-commit: f14cdb1367b947d373215e36cfe9c69768dbafc9
-- 
2.47.3

