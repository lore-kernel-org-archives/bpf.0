Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F183939A2
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165844; cv=none; b=XZbOtQZjV/rctdqZ8EgWxM0Pb9Kg+nAOWgnfFXrcil0bIlc9enyQLPjpOQDE1Q5mID97CyPLblVY91uAox5VHR+5ubiAZEluZh2FlhpOQ2S3T/Rp1aZ2DI+0crnd/kZIYlGJIZemcfo0POZ3/VwMX50c7f9ulVAIFggQZB8OpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165844; c=relaxed/simple;
	bh=0vM8Wm0yvMs1PHZRliZhxIPfiXZ2NOCQ06VtNDnSSis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZHuOLPq6XNJIIAMrNWdqJP7S2X2QIy7sWAXpjmvHmPMnoBlyKnbvOVI3l8zueEsG7n6+RH4Ib9MSgrxRMZGTQ29PaAVM4Rh5Q6TrVZLgaaNuUBuTkmeINgHMR4Kl287Z9PXu4egtcsc0+y12xV4AbLFClEfEqR16/U9Ko7uglF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N61uzNTv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N61uzNTv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776165830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nD3+pYkuUta613cN19y/PkEcTwKQ+sxBqJw2XDXKABc=;
	b=N61uzNTvbqRwJAPfiGs2bl1u9zlbXJ5Q9XC7AEX2fSmGy/yIm0C7aQM+fcz1qOGAs13T7H
	TjC/zsy6kPDbYtxxTH2YhBMGMbadzmTz3uifuW01J51dCRIpWmyYrXPJCQfc8YjC2NEwaS
	COkYCs+LVBgN/fJwE2Gqiv2MP2QGDf0=
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: tcp: Reject TCP_NODELAY from BPF hdr opt callbacks
Date: Tue, 14 Apr 2026 19:23:08 +0800
Message-ID: <20260414112310.1285783-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid infinite recursion in bpf_skops_hdr_opt_len() 
via TCP_NODELAY setsockopt.

---
KaFai Wan (2):
  bpf: tcp: Reject TCP_NODELAY from BPF hdr opt callbacks
  selftests/bpf: Cover TCP_NODELAY in hdr opt callback

 net/ipv4/tcp.c                                |  5 ++-
 .../bpf/prog_tests/tcp_hdr_options.c          | 34 +++++++++++++++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c     | 18 ++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

-- 
2.43.0

