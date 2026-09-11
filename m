Received: from mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1848D893
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135062; cv=none; b=mmZOCNfOxKHc7+CyFS6bnn9L8gTD0PpdGObxgRwKJjz0ReEuegChBVjXScw6z1Cmk/XZCsoJHOkZ1/Xea6cW60o285a497mA2iB0ZWHmLK593vhhmbdSDlnNl7wVkVl6nGGuylCUmefcshY9JDlXvwKu2yTYpvKxqaU+HZMlfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135062; c=relaxed/simple;
	bh=ln7IoRA07Ilbawg/aAH2sc/zTgGho8RkMvmGvlw20T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u49EwoQR9I8tLzfdO7g7UmCdX/9QD+Dz9Xrh3fdO5dRp1VqLULgzO0hFlsNOb5XlWYw1fjhAlslzqBnzQo60EyMO6WTAj93JUHo6obVs07+XwiGjc2ZqORSC5l/Yo1fgJ3ElQKDMNBRPhg5gX7zQ5k33DXZ0iYMfoL1gqCnrEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EdYkO3yD; arc=none smtp.client-ip=91.218.175.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EdYkO3yD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ln7IoRA07Ilbawg/aAH2sc/zTgGho8RkMvmGvlw20T4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789135058; v=1; x=1789739858;
 b=EdYkO3yDt2jemLzi3nOb45w8OQMEPqU0krYzMYPFPxQsonUaJbfl7TcKb/1Gx6Hg5XL7Tqn0
 HbddIHP60lpZaNPOacDUEiTIrzdJaGGlHF7y2K3TKUF9dmSvf1vhhp1tlhTUrMhv2KGyo03OWX2
 NMb6WM6PEzgm2e6xWQ/gxYdc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e884e9b4b346d9e9;
	Fri, 11 Sep 2026 13:57:28 +0000
X-Mizu-Trace-ID: e884e9b4b346d9e9
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
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
	Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] net: xdp: fix bpf_xdp_shrink_data() page handling on generic XDP and veth
Date: Fri, 11 Sep 2026 21:56:50 +0800
Message-ID: <20260911135711.109338-1-jiayuan.chen@linux.dev>
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

Patch 1 fixes it by tagging the xdp_buff, so it no longer depends on
rxq->mem.type (which is shared on generic XDP and gets reset on veth). It
is reported by syzbot.

Patch 2 adds a selftest that reproduces the leak on both paths.


v2 -> v3: handle some feedback from AI review.
v2: https://lore.kernel.org/bpf/20260824030257.263179-1-jiayuan.chen@linux.dev/
v1 -> v2: AI found the fix was insufficient and we need a general way
          to fix them.
v1: https://lore.kernel.org/bpf/20260816031245.268898-1-jiayuan.chen@linux.dev/

Jiayuan Chen (2):
  bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
  selftests/bpf: add xdp_shrink_frags

 drivers/net/veth.c                            |   6 +
 include/net/xdp.h                             |  30 +-
 net/core/dev.c                                |   6 +
 net/core/filter.c                             |   7 +
 .../bpf/prog_tests/xdp_shrink_frags.c         | 288 ++++++++++++++++++
 .../selftests/bpf/progs/xdp_shrink_frags.c    |  34 +++
 6 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_shrink_frags.c

-- 
2.43.0

