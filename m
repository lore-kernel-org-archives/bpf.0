Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD93C1960;
	Tue,  3 Feb 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135514; cv=none; b=lVDBQVA6NFur27Ifhf4lsOlizpysqIUfze9aLESgeC5eNNQewn5CTCTsa++iJHhbSMZ+ez5QUlB/ZLyIZAUt2/3ej3phA8HI050MYCdPTCnTOK8G96zbyzNsalMo1eRpsFWvlloPbgMKDCcp0TzSqRcJWdVl+pLoPPgYBjYSkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135514; c=relaxed/simple;
	bh=vKe54uOjeoLP4XUWoAXwXrz1MoBrvz+ZvQqj8AMaXpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwlZDb2vBzS8Ddnbs+BaWR1sPJdBHZzA9f0wyAmCeYqEjTRl5tbZffw08kdtYeoJdI0eLbk0j2xcZaK+lWDaHQNKGPAOs8Bzld1r/76WWLkJzbuaQNtNXVUFETfTR9fyT7yDLahHziOGlxrLaTtPxldtGsA8ojL3IMApwafaCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWw80xKn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWw80xKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770135512; x=1801671512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKe54uOjeoLP4XUWoAXwXrz1MoBrvz+ZvQqj8AMaXpE=;
  b=EWw80xKnX0TUtd6t0aPGSLd9VuuwwtEsv8arkq1ZocDbJoCVG4m/vhwc
   Q7WMY1YMCI3VOkiLGVRGUmakKx9o5rrr7ZaMGVIDoTf/cdlzW4jCVCeSz
   Il5FSfRSPrXI8ru/GlOORlZ/62AV5H9kch6B2zur4Q0IDZ3Bqb6Qws96E
   Pmp1JcNDlG3Fxh18W1sLU6lc4ST24v8iJleqiVOSliJIDgjvSDzcWq1qH
   Pz6YgxXmR4ZjUgS7+pC9WNYq3/aq97tSjUoD8J6Y9gSilPZ1RG9/3bDt1
   iKuXORcYHGEcO7DVh2GEFycRdavsNm4hu55SJebrRVcC7Gs5vuNuy2bQK
   Q==;
X-CSE-ConnectionGUID: D0qR8wLBRfKbZScxszaGcA==
X-CSE-MsgGUID: SiSA/DOZTw67quUx9tRIdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71391903"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71391903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:18:31 -0800
X-CSE-ConnectionGUID: sf8Wi3rnTri+jVQmBVB+kg==
X-CSE-MsgGUID: RWIRTRIoQwKUffMAXKgNuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214645538"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 08:18:27 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0AD552FC77;
	Tue,  3 Feb 2026 16:18:24 +0000 (GMT)
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
Subject: [PATCH bpf 2/2] selftests/xsk: fix number of Tx frags in invalid packet
Date: Tue,  3 Feb 2026 16:50:58 +0100
Message-ID: <20260203155103.2305816-3-larysa.zaremba@intel.com>
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

The issue occurs in TOO_MANY_FRAGS test case when xdp_zc_max_segs is set to
an odd number.

TOO_MANY_FRAGS test case contains an invalid packet consisting of
(xdp_zc_max_segs) frags. Every frag, even the last one has XDP_PKT_CONTD
flag set. This packet is expected to be dropped. After that, there is a
valid linear packet, which is expected to be received back.

Once (xdp_zc_max_segs) is an odd number, the last packet cannot be
received, if packet forwarding between Rx and Tx interfaces relies on
the ethernet header, e.g. checks for ETH_P_LOOPBACK. Packet is malformed,
if all traffic is looped.

Turns out, sending function processes multiple invalid frags as if they
were in 2-frag packets. So once the invalid mbuf packet contains an odd
number of those, the valid packet after gets paired with the previous
invalid descriptor, and hence does not get an ethernet header generated, so
it is either dropped or malformed.

Make invalid packets in verbatim mode always have only a single frag. For
such packets, number of frags is otherwise meaningless, as descriptor flags
are pre-configured in verbatim mode and packet data is not generated for
invalid descriptors.

Fixes: 697604492b64 ("selftests/xsk: add invalid descriptor test for multi-buffer")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 69a5a9a5189b..bab4a31621c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -433,7 +433,7 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	}
 
 	/* Search for the end of the packet in verbatim mode */
-	if (!pkt_continues(pkt->options))
+	if (!pkt_continues(pkt->options) || !pkt->valid)
 		return nb_frags;
 
 	next_frag = pkt_stream->current_pkt_nb;
-- 
2.52.0

