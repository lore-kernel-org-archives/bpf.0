Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622542D0C94
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540613; cv=none; b=qcOhC/zop0oAp9P2OT9iEsV6kT9tdLsZyxzsSF7fmJvPYdsaJSfaZAtnfefG91/gaZtzoH5BNEhvvO4TDDDlC79WsOqDkZJQpkxkw0GQ10F31KmlNto0q34dZBktsr+/b0olro3mCP+N3kNHPvOszdAUkXpzisZUbZ/ELiyLtug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540613; c=relaxed/simple;
	bh=gSGWwroZbmKvR8ycVLGTpDjq5NFPI3Y+vVD6GgONSTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OS2cC3thbtPRSfxHT80MBzL/gHFiqCH84kZY+Zc98RE1vAvi52z27yUp9iHDkNScs8xSqgH7fnlXP1WslFILxuqi+TwS8eW9YKwase9Nl4G9Eylj4sfv4QoeXusiiemM2eigK8CWNPti1I/62YexfymV8Uu11ruz8wz3hr7oVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qa/66w76; arc=none smtp.client-ip=91.218.175.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qa/66w76"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gSGWwroZbmKvR8ycVLGTpDjq5NFPI3Y+vVD6GgONSTc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787540608; v=1; x=1788145408;
 b=qa/66w765a1B0Ltd3NaVMlV1KVjxZtajxK0puIeRMcfVA5ZKrtDHM+tmSMFpSdv5b/T/+TdF
 5eAX4oLfanV++ttA5KY2E5ag2hPP91jU2/CfluDgjzkTArMYlXSBgQUTlkjZfsuucY8+OAR8Ryi
 mDOSuhR/z3JypY8iuUDZIP4w=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.0)
	by smtp.migadu.com with ESMTPS id 901135ba15743a24;
	Mon, 24 Aug 2026 03:03:28 +0000
X-Mizu-Trace-ID: 901135ba15743a24
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] net: xdp: fix bpf_xdp_shrink_data() page handling on generic XDP and veth
Date: Mon, 24 Aug 2026 11:02:27 +0800
Message-ID: <20260824030257.263179-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm always confused which tree(net or bpf) should XDP target.

bpf_xdp_shrink_data() frees a page_pool frag with the wrong memory type on
skb-backed XDP, hitting "Bad page state ... page_pool leak". Both the
generic XDP path and the veth path are affected.

Patch 1 fixes it by carrying the memory type in the xdp_buff itself, so it
no longer depends on rxq->mem.type (which is shared on generic XDP and gets
reset on veth). It is reported by syzbot.

Patch 2 adds a selftest that reproduces the leak on both paths.


v1 -> v2: AI found the fix was insufficient and we need a general way
          to fix them.
v1: https://lore.kernel.org/bpf/20260816031245.268898-1-jiayuan.chen@linux.dev/

Jiayuan Chen (2):
  bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
  selftests/bpf: add xdp_shrink_frags

 drivers/net/veth.c                            |   5 +
 include/net/xdp.h                             |  14 ++
 net/core/dev.c                                |   5 +
 net/core/filter.c                             |   7 +
 .../bpf/prog_tests/xdp_shrink_frags.c         | 163 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_shrink_frags.c    |  23 +++
 6 files changed, 217 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_shrink_frags.c

-- 
2.43.0

