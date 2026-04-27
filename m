Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2011CBA
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248621; cv=none; b=XlBcmg/NLHfiK0uTWdpq+gOVb0Btp9iQBTbUMdW6DyVsyufbM99KG2LpN8JeJozgc3oKYc+qDk6XdTm3y+Nttz1drtZyrgx2I0xzyT3i1614nXlH3kZAz/F6ML7Rn/l0F4FDCLPfzAWrZec5OWJI2tKEdI0nGHyjLrqgB6V+SmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248621; c=relaxed/simple;
	bh=1iqpYUjPxCslxVvz08rQIpDZ4UUph8rg3YRDpowLMDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvfhCCqZReIv/wD9dCYgVuOtgI1wGGJQi2qYEqD1Fup5CGVliYEnZ9M9MAgmW5iZDLtduHUyMuliO1QTEae0Qq7S00PFtwMGYVKsQl7xIChBCzUP8S400/fQmwoPTLoxUC4pF5PdHSq8xhktnCB6XtzMmzuvXvipxBs4qh1A7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/hAJjn/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/hAJjn/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777248616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S+QDUFY9BA6jffJdEkCL/a8joX4lzutnF6V5ZZQZTgw=;
	b=O/hAJjn/0NY4QDZQF50+9ZkYhlr1X5a8cEwtoGzN7oLr2el2jzMk65sB4ghXU2IUXSTNE9
	kwJ5lyyMeYhhAXQC461HHuTlNvcbvNdz+Wx412x9yE1sLOEPtjark8x/489wn5x+W0tzLw
	+6JC2XjTSg34QCXaodFTMAsq2WbnT1U=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf,net: add missing custom syncookie statistics and add selftest
Date: Mon, 27 Apr 2026 08:09:49 +0800
Message-ID: <20260427001006.14465-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2 was reviewed on net-next; per Martin's request the series is
re-targeted at the bpf-next tree's net branch (bpf-next/net) so
both patches can land together via the BPF tree (the selftest
touches BPF selftest helpers). No code changes vs. v2 beyond the
nits below.

For context, the series accounts BPF custom syncookie validation
in the LINUX_MIB_SYNCOOKIES{RECV,FAILED} SNMP counters (with a few
related cleanups in the cookie_bpf_* config guards), and adds a
selftest that verifies the counters move as expected.

v2: https://lore.kernel.org/netdev/20260411013211.225834-1-jiayuan.chen@linux.dev/T/#m9c0ccc349fbed908e2cf34ce34ebd45b6f747b07

---

Changelog
=========
v2 -> v3:
  - Retarget bpf-next/net (Martin).
  - 1/2: fix typo and rationale in commit message — the removed
    guard is CONFIG_BPF, not CONFIG_BPF_SYSCALL, and the reason is
    that the guard is a no-op under CONFIG_NET, not a build-failure
    risk (Martin).
  - 2/2: keep reverse xmas tree order in create_connection()
    (Kuniyuki).
  - Add Reviewed-by from Kuniyuki on both patches.

Jiayuan Chen (2):
  net: add missing syncookie statistics for BPF custom syncookies
  selftests/bpf: verify syncookie statistics in tcp_custom_syncookie

 include/net/tcp.h                             |  7 +++---
 net/ipv4/syncookies.c                         | 10 ++++++---
 net/ipv6/syncookies.c                         |  2 +-
 tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
 6 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.43.0

