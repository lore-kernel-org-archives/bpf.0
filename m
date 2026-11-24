Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525628;
	b=ZfPXJ/Cj/CJg3n6dslUr09kDHFEMVW3uB8q9x4rUC3lVvINHmw2+tmXhSkpUhRnsiFRH
	 Cu8m8XZEz9bkCoSqUSOyNjaf/ZSloxQeliQJ1ivKNi1KqQ4x2Qo9Ziq5ufGZt3+PHkMq6
	 UxDaKNHjnKQMVK1udpRqZxX6GyX9d9xZB0QU2MqxQ7MvynmkXgBrKfIxXsl1B1Bz4LCvb
	 VA1+cBJCPJalgl/b3HZM2WPJhTItDWcccdYqKmBXIt087VWTlH+6iWe1CEeA5CXJz16M4
	 tVw09Ncq3FXSSbkFg3HLHHWxt0CxaJnb89bM7h1W7+HeNfWEWOUcQBvYcTZlIr9LrYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525628;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bSBhVF5Lg/aftBcFeP0ZcFRWzxNk9JeoO9EZBLr5Nyk=;
	b=mYkDP2aYrSSPvKlQDia08nNLcr9CNr98B/YPTQDFIHpo3YS4UXxnQ5biWrZ57gol8GfK
	 xcHAwZL/lg0q6ZwEpmykketkpIZnddyyPWirUXLoO4dke28TyGTlaIQelNlTSqcZNzZDe
	 V5Bi8WPJO7m6SM7aHYeQg4MfsY0PFOU9rTFejBDVaZfuQ/T184kPbt56P9+ueHQqm5mdl
	 pUG06AIZzdpynct5qh1sQWPAV+aEEFg1E6+zqKZ3CeA6YE3/nas2XvqJkcRUFBinK/swS
	 ZrXGQ60YRA6IWX9FGlX1wUoxVd/V7lrbfDqIpX7CBOya9dVb9E2FJ8Va21qoHFP4a5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iSFdGQRx;
	arc=none smtp.remote-ip=95.215.58.106
Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDC606A32A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CDC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iSFdGQRx
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iiLNzMF0Hans49fhb1kEknTfJDMcyGgHhBCScKBOdZU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795525624; v=1; x=1796130424;
 b=iSFdGQRxN8u4gjnzBj2a4pDQ5omVWpay2kR60Kl28vkrEV1pJUy31NMfurRga/rXsyuQm3zZ
 0bcY6qHjxmUf0puESrhK+0hoGQa4+mFOLUrHHFfC26foH7CBybTOrzweGsy1EgFHcMFRMCDwEYv
 D+2+Ldb3Xp5chZhjhnGJfqYY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0517dbc925f7ffb6;
	Tue, 24 Nov 2026 13:07:04 +0000
X-Mizu-Trace-ID: 0517dbc925f7ffb6
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4 fast paths
Date: Tue, 24 Nov 2026 22:06:25 +0900
Message-ID: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

With CONFIG_STACKPROTECTOR_STRONG=y, a function that has a local array or
passes the address of one of its locals to another function needs a stack
canary. The canary is set up and checked on every call, also when the
local is only used on a path that almost never runs.

This series removes the canary from functions of the TCP/IPv4 fast paths,
by returning results by value, by using storage that is not on the stack,
or by not calling a function that has nothing to do.

Patch 1 returns the two mptcp_space() values in a structure, so that
__tcp_select_window() no longer needs a canary.

Patch 2 changes ip_neigh_gw4() to take a pointer to the address, like
ip_neigh_gw6(), so that ip_finish_output2() no longer needs a canary.

Patch 3 uses pskb_may_pull() in icmp_filter(), so that
raw_local_deliver() no longer needs a canary.

Patch 4 turns skb_try_coalesce() into an inline wrapper over a function
returning its results by value, so that its callers no longer need a
canary because of it.

Patch 5 returns the result of the TCP receive coalescing by value, so
that tcp_rcv_established() and tcp_data_queue() no longer need a canary.

Patch 6 calls bpf_skops_write_hdr_opt(), which needs a canary, only if a
BPF program reserved room for TCP options.

The bloat-o-meter numbers are from gcc 16.2 on x86_64. The functions
named in patches 1 to 5 also lose their canary with clang 23.1.6 on
x86_64, with and without ThinLTO, and on arm64.

Xuanqiang Luo (6):
  tcp: avoid a stack canary in __tcp_select_window()
  ipv4: avoid a stack canary in ip_finish_output2()
  ipv4: raw: do not use skb_header_pointer() in icmp_filter()
  net: avoid stack canaries in skb_try_coalesce() callers
  tcp: avoid a stack canary in tcp_rcv_established()
  tcp: do not call bpf_skops_write_hdr_opt() unless needed

 include/linux/filter.h           |  2 +-
 include/linux/skbuff.h           | 35 ++++++++++-
 include/net/mptcp.h              | 13 ++++-
 include/net/route.h              | 16 +++---
 net/core/filter.c                |  2 +-
 net/core/skbuff.c                | 50 ++++++++--------
 net/ipv4/raw.c                   | 25 ++++----
 net/ipv4/route.c                 | 15 +++--
 net/ipv4/tcp_input.c             | 99 +++++++++++++++++---------------
 net/ipv4/tcp_output.c            | 25 ++++----
 net/mptcp/subflow.c              |  9 ++-
 net/netfilter/nf_flow_table_ip.c |  4 +-
 12 files changed, 178 insertions(+), 117 deletions(-)


base-commit: a4c450594f5d1dc0fc4daacfb95d40554d99dead
-- 
2.43.0

