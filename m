Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60B481248;
	Tue, 14 Jul 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038116; cv=none; b=R0gZ/vOkgrdsx8MaS1alXUFP5HBamkdMOshHSjiUCscr4aXmZ6WUKdqHXma7tFA6aWLFw+8RqyoQBRRXwTyPj2ln/nizvdKuvIjy2t5setY+CJ3zLVduF1tTWz8RNe9sqp0efT7ZYQVFMK9CoYChYfhcHMCR6o9mCEeBCs3QXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038116; c=relaxed/simple;
	bh=woEMa072B6FgiX3OZeS/66WbdJR6hpOoNhGZbMu0y18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twmv1UOJVvebdna9yXiyNrxuUVqhanAgmvtm3XT+wxxzb2rSzhFA9/1w3/FXsf6vFh72wVpdN7WI9X54X6plW5GnOfdJnE+PNn5TEGON7atch3DTo/Q+ScTB5vpD7EA4HIPoYzsqlgac/it0EDujBBBKPila/GEs6XiT05I2JGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTbxMx11; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTbxMx11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038113; x=1815574113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woEMa072B6FgiX3OZeS/66WbdJR6hpOoNhGZbMu0y18=;
  b=GTbxMx11iw4i8hBQ4YOR5ewgN/peaqr3Sa0GA7oF8VUIGq8L7q6bEsQQ
   GTNiO/BwkoJ4wLKmOQ898aeE6suAa8D8aSsedXZ4ag2EYNYSl1dKZesOt
   ONZui4rcqkgvd4uKk56AV7zscg5wUs9TP2s54oo1fi5oRfIpsAb68wLFG
   ycDeJ1DVtAJeonYsRL/v0+2z613qDUQwI/XJqPohGbLqJwI1WyVCLgPyF
   dZrXrwfOXx8O6JWRnSYHyBBaKq2Q5roKcl1aj7LxE5nQCitqeXPZbXvnk
   TrrG1mvaSxM5zcTkHoywdqM8Be0LOPlIOoplgg9T7gszDxShe+4SfUONH
   A==;
X-CSE-ConnectionGUID: X4x0v+OiQu+1gtqVB68xKA==
X-CSE-MsgGUID: 2/Mu5uuMSn6taW6Qypl66w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110207061"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110207061"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:07:47 -0700
X-CSE-ConnectionGUID: LBaNqolsQTS9JQzZKuphXg==
X-CSE-MsgGUID: Uf9VzH+uQECcXzyKY+6UnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254121008"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 14 Jul 2026 07:07:44 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 6/6] selftests/xsk: account invalid multi-buffer Tx descriptors
Date: Tue, 14 Jul 2026 16:07:22 +0200
Message-Id: <20260714140722.111645-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalid descriptors in the middle of a multi-buffer packet still belong
to the packet being consumed from the Tx ring. The tests should therefore
count the whole invalid packet as outstanding in verbatim mode, even
though the packet must not be expected on the Rx side.

Make fragment counting follow the packet boundary instead of stopping at
the first invalid fragment. Update custom stream generation so invalid
middle fragments terminate the generated Rx packet while Tx accounting
still covers all descriptors consumed from the invalid multi-buffer
packet.

Also add explicit end fragments after invalid middle descriptors. This
exercises the kernel drain logic and verifies that subsequent valid
packets are not interpreted as continuations of the invalid packet.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index de17dd48f176..7abb4935edf9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -427,14 +427,14 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	}
 
 	/* Search for the end of the packet in verbatim mode */
-	if (!pkt_continues(pkt->options) || !pkt->valid)
+	if (!pkt_continues(pkt->options))
 		return nb_frags;
 
 	next_frag = pkt_stream->current_pkt_nb;
 	pkt++;
 	while (next_frag++ < pkt_stream->nb_pkts) {
 		nb_frags++;
-		if (!pkt_continues(pkt->options) || !pkt->valid)
+		if (!pkt_continues(pkt->options))
 			break;
 		pkt++;
 	}
@@ -665,11 +665,11 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 			if (!frame->valid || !pkt_continues(frame->options))
 				payload++;
 		} else {
-			if (frame->valid)
+			if (frame->valid) {
 				len += frame->len;
-			if (frame->valid && pkt_continues(frame->options))
-				continue;
-
+				if (pkt_continues(frame->options))
+					continue;
+			}
 			pkt->pkt_nb = pkt_nb;
 			pkt->len = len;
 			pkt->valid = frame->valid;
@@ -1209,6 +1209,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
 		u32 nb_frags_left, nb_frags, bytes_written = 0;
+		struct pkt *first_pkt = pkt;
 
 		if (!pkt)
 			break;
@@ -1253,6 +1254,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		if (pkt && pkt->valid) {
 			valid_pkts++;
 			valid_frags += nb_frags;
+		} else if (pkt_stream->verbatim && pkt_continues(first_pkt->options)) {
+			valid_frags += nb_frags;
 		}
 	}
 
@@ -2099,13 +2102,16 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Transmit 2 frags, receive 3 */
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, XDP_PKT_CONTD},
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, 0},
@@ -2117,8 +2123,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 	if (umem->unaligned_mode) {
 		/* Crossing a chunk boundary allowed */
-		pkts[12].valid = true;
-		pkts[13].valid = true;
+		pkts[15].valid = true;
+		pkts[16].valid = true;
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-- 
2.43.0

