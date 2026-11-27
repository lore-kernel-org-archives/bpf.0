Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773709;
	b=g0qNtjBOE+2H1fRUbqwHxvcYz02WJtzYshpJCaae71p04LA/LbGRVxcEleRznKe9TRTI
	 t2zQZjDZZfxRmNNPfcfKvplgqYptdNWmCO6aEnELTnVUHxumFj8Nhd+1fQk8zWBB91ON/
	 FRHq2+A4ZAVYnrMsi5NAPeIX6NXFr/b+PVtE02SFbIxJnX1HbJXvBBvtCFxVk5ezaohJB
	 IxARcv943wM8sjsFBKYU2ECId/UJQWAo9wQxo5RT0zfVZ1Alti55d3AEF5g9mham0EGqz
	 6A/LjetvAxD9QZsLkiKqgOjf0WvDCK1IzJgcwsMMKeaCIQHMNR9bWnMnVTOp8GyBLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773709;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=wBeIZzfsrd2DcFYvsLYZszPdd3ouZT5edFUxXGnYJQ4=;
	b=TTHYNqYIL1RuqnbhxGP09lUSYx8y3LhAj6T6JyMHKd4En9CClHkkdOn4wsrDzUyM6SZd
	 OWIS+gYRa81ePMuTo/fEKTkVwWeeEaBD1jvHcbsPgQYQU6h4X7OpXsAIq5TiGZb+Arns+
	 NvMoT7fddYGTFiQXJMKjq5CTjl79f0POxM8R3ai5l2TToaWBwj3eGfNafpBYF+Kls6N5Z
	 tyK/y7Dh/GfBjSpuYzAqUgXtqvd6KZlsjhHRvNTwBFFAv4UemGbKjWhm6SezTDH71rSO3
	 c6HcA6QjnQOEtZefXF9/EYkzX8F2EuTm6w6koa5KVTN5eLUXDq2YhmJT3PdPP3/5cDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ohD2DFZ9;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B7606A32D
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3B7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=ohD2DFZ9
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:35 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dudu Lu <phx0fer@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH net v9 0/6] xdp: fix page_pool leaks
Date: Fri, 27 Nov 2026 11:01:26 +0100
Message-ID: <20261127100132.1977890-1-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795773699; bh=wBeIZzfsrd2DcFYvsLYZszPdd3ouZT5edFUxXGnYJQ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ohD2DFZ90fvSy/9emhamyu+IQTqZ0aks0yi9TFYrwlz+Kyw+Qv62kFICC/nFon/xO
	 z1V4svwnnk63SfOAUK4UPJ+HY/ULK6Jf17S6Lr2Q5xhS9Dg/2RaVIYYaSvkTFkbJ1K
	 r8He+plnVZ35xil6GcOfoiVkPb9Kmcu6uf8Ph/0w=

Hi,

when an XDP program shrinks a frag away with bpf_xdp_adjust_tail(),
bpf_xdp_shrink_data() frees it according to xdp->rxq->mem.type. Generic
XDP and veth copy skbs into page_pool memory with skb_pp_cow_data(), but
run the program with an rxq info that says MEM_TYPE_PAGE_SHARED, so a
page_pool page is freed with page_frag_free(). syzbot reports it as
"BUG: Bad page state ... page_pool leak", and it can end in a
use-after-free.

As Alexei suggested on v8, the program now runs with a copy of the rxq
info on the stack that has the right mem type, and nothing writes into
the shared rxq info any more. The diff is split per path, as the bugs
came with different commits:

- patch 1: generic XDP, non-linear skbs
- patch 2: test_run sets its frag_size on a copy instead of in lo's rxq
  info, which generic XDP on lo uses too
- patch 3: veth, xdp_frames: the frame's mem type, set before the
  program runs
- patch 4: veth, skbs: MEM_TYPE_PAGE_POOL
- patch 5: Jiayuan's selftest from [1], used with their permission,
  with two comments reworded for the on-stack rxq info; it frees
  page_pool frags on tun (generic XDP) and veth
- patch 6: selftests for patch 2

An skb that veth turns into a frame on XDP_TX or XDP_REDIRECT still
leaves as MEM_TYPE_PAGE_SHARED, as today, so its page_pool pages are
released instead of recycled. That is not a leak; recycling them comes
as a net-next follow-up (Maciej).

Thanks to Octavian and Maciej, who started this series, and to Jiayuan
[1] and Dudu [2], who posted fixes for the same bug.

Testing (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET):
- without the fixes, xdp_shrink_frags reports "page_pool leak" for tun
  and veth, both subtests of patch 6 fail, and a reproducer that trims
  all frags of 8000-byte pings with generic XDP on a veth pair hits
  "page_pool leak", VM_BUG_ON_PAGE() in page_frag_free() and a panic
- with the series: ./test_progs -t ns_xsk,xdp passes (35 tests, 210
  subtests), no splats; the reproducers for generic XDP, native veth
  XDP, XDP_TX and frames trimmed by the peer show no splats
- full ./test_progs (same patches on bpf/master): the same failures as
  without the series
- not tested: page_pool frames from hardware drivers redirected into
  veth

v8->v9:
- target net (Alexei)
- replace patches 1-5 with Alexei's on-stack rxq info, split per path
  (Alexei)
- replace patch 6, which never freed a page_pool frag, with Jiayuan's
  selftest (Alexei)
- patch 6 (was 7): load the program of the ingress_ifindex subtest with
  a skeleton, and check that the program saw a packet with frags before
  checking the result of the grow
- the code is new, so Maciej's and Octavian's patches and Tianyi's
  Reviewed-by are gone

v8: https://lore.kernel.org/bpf/20261124104016.532341-1-sst@poczta.fm/
(links to v1-v7 are in its cover letter)

[1] https://lore.kernel.org/bpf/20260911135711.109338-1-jiayuan.chen@linux.dev/
[2] https://lore.kernel.org/bpf/20261021155645.69120-1-phx0fer@gmail.com/

This series was prepared with an AI coding assistant (Claude): the code
of patches 1-4 is Alexei's diff, which the assistant split and wrote
the commit messages for; it also wrote patch 6 and ran the tests.

Jiayuan Chen (1):
  selftests/bpf: add xdp_shrink_frags

Slawomir Stepien (5):
  xdp: run generic XDP on frags with a copy of the rxq info
  bpf: test_run: Set frag_size on a copy of the rxq info
  veth: use the frame mem type when running XDP on an xdp_frame
  veth: use the page_pool mem type when running XDP on an skb
  selftests/bpf: Grow test_run and generic XDP frags after a test run

 drivers/net/veth.c                            |  33 +-
 net/bpf/test_run.c                            |   9 +-
 net/core/dev.c                                |   9 +
 .../bpf/prog_tests/xdp_adjust_tail.c          | 137 +++++++++
 .../bpf/prog_tests/xdp_shrink_frags.c         | 288 ++++++++++++++++++
 .../test_xdp_adjust_frags_tail_grow_lo.c      |  25 ++
 .../selftests/bpf/progs/xdp_shrink_frags.c    |  34 +++
 7 files changed, 519 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_adjust_frags_tail_grow_lo.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_shrink_frags.c


base-commit: e9e45fcb6d39bee9325e6a7dca72bd14e82760f3
-- 
2.56.0

