Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605B3C1994;
	Tue,  3 Feb 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135512; cv=none; b=k61D+0i6aYxWJY3xhA5luX9+cP31TNN8P78I3jK8mvVCwsMX1lJ844hevJk955Nwy6i/bTp7+Q3sFNoL00XNHEq1VvBRA8RI2DaACg6Ju0nJQ6onrIrBX918ZgyQZ2+xQ4pIN7eA3tdd6kKS/1hxRkrioADn3pHyXOnZJwwrwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135512; c=relaxed/simple;
	bh=SUncJcboFs8uhYhoRkacGOoojC61QIaNsbPXLEKkv7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1qYEsfqSL4M+z11qyqe/0XmfhGpiu12s7KwPk5w3E9c7CJ5sQkU4G1oAe3q7qsV064+8MARXrF9wPFbO5nl5LlsPZgE4sJMifFpn7B7b/mRWYFDh45DZ57zQ0w5HZFXBBekCRJLjx4uRVbz8q4lYaWKnj810pD9PsAqMS/f/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJL0JF77; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJL0JF77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770135510; x=1801671510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUncJcboFs8uhYhoRkacGOoojC61QIaNsbPXLEKkv7A=;
  b=SJL0JF77wLRzrRKqPxD6deiyIdFu5yzWDvVEXdJ4NccBbLlAnBI+bAA8
   DsDMj1ScRV/gfX5M1Zq6Z5n8BvTclYvlMlDgwvKEDXFpC/PRg3ixd0Njf
   VoM7TLar43tA0CHwWA5i2vdLJfEg9wv6gJWmYk8z1Vi/qg2JnOx/Tqsbg
   8eip4MKwoTWHE8q4TMwVmhozxARKVdfE9QJJEPHn5tGLups9x7vOwKbR2
   DNI6GRGM8AG1H15oioacIxwhjuziqpvHVSDKeazu2zlWQQKoYumXe/rCK
   MU5udcsXROgMvBw8HKf6dKX9eHxtXW7IEXRocazVoaT+bI50hdVkhNvXO
   w==;
X-CSE-ConnectionGUID: jdtF7mdqR/+2GFgTYcIh6A==
X-CSE-MsgGUID: 1s7mlTnhQuuHXH+nhrmQbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71391886"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71391886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:18:30 -0800
X-CSE-ConnectionGUID: 24Zjgv7WS4KIiFq7lGuk5A==
X-CSE-MsgGUID: XdSw/hC8SxmRy7p7ZS2e4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214645524"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 08:18:25 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2DC302FC76;
	Tue,  3 Feb 2026 16:18:23 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Jason Xing <kernelxing@tencent.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH bpf 1/2] selftests/xsk: properly handle batch ending in the middle of a packet
Date: Tue,  3 Feb 2026 16:50:57 +0100
Message-ID: <20260203155103.2305816-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203155103.2305816-1-larysa.zaremba@intel.com>
References: <20260203155103.2305816-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referenced commit reduced the scope of the variable pkt, so now it has to
be reinitialized via pkt_stream_get_next_rx_pkt(), which also increments
some counters. When the packet is interrupted by the batch ending, pkt
stream therefore proceeds to the next packet, while xsk ring still contains
the previous one, this results in a pkt_nb mismatch.

Decrement the affected counters when packet is interrupted.

Fixes: 8913e653e9b8 ("selftests/xsk: Iterate over all the sockets in the receive pkts function")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 5af28f359cfd..69a5a9a5189b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1090,6 +1090,8 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			xsk_ring_prod__cancel(&umem->fq, nb_frags);
 		}
 		frags_processed -= nb_frags;
+		pkt_stream_cancel(pkt_stream);
+		pkts_sent--;
 	}
 
 	if (ifobj->use_fill_ring)
-- 
2.52.0

