Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657935A925;
	Thu, 13 Aug 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602644; cv=none; b=d1abDFevgcwHNqopUMdjCJkED3f3XNqt/BBqp5wg9VuX/NX0aimVVwHbmNMBzPLcdU7ZJYrIWUIVbM6d1a5QckdCNEa7CODu0PmL9ZfUo1MBfeslvle/CnnKgLMrp5FYeAAYO7b1qeI7emo0Ri/fs9Xxb01Ln9bFG4q4J0HcfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602644; c=relaxed/simple;
	bh=0JHzwHKRn7A0y0PcpDE+F8+6eFYW/G4Z39dUpe7jF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWteCh9mN5qa0lsNU2rx7e4LpCZ7QNhnzP+9auKOnQVmSmzYxNBI9spWz8jBAaDnTFqR6Y4iygageN/j9RWw8QLRKrnGu1X9AYj9moVOmPmWqJN1Ov4P3Qq6GpYxEafEjelNxnTynCa5NahyLWoPIuqZU+lKJUoCUFkJF5eA2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SM5nP9tW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SM5nP9tW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602643; x=1818138643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JHzwHKRn7A0y0PcpDE+F8+6eFYW/G4Z39dUpe7jF4g=;
  b=SM5nP9tWuGY2lo+8j6GrnXkomU5soCrXDGm+ekjBVbnlWDYI/VvSI9b4
   sC084omXUZJcsxsbcoYmPdbU/vuHa2H/ht/c/ICHkHJ9K2G3o+Jf1s9dx
   NTWEE6t2iTHyqFliPBQRWNAC0dMm2MVksO/TA9ULZcfHKSCbBikrwabW3
   htJvEPgXJHovzMFSwlTLlDhdJRDsSTlQyfPSbqHG7d+kNhujdbwtWp5JZ
   fr+erOYVviytJRemEQTLwYC5WTi0JWIHdE/3aF4qPx8lsCgY5NPsSOVru
   KhXLFWDJtxuGL6mV0micGICX3MKjBiD9u1hpjzBPVH5qjwpRqAbVjgovx
   w==;
X-CSE-ConnectionGUID: AkFRzmPZQzKUFGuNgIk7Kg==
X-CSE-MsgGUID: lwQ61zQcQqSKoF5y5q0ckQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86933915"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86933915"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:43 -0700
X-CSE-ConnectionGUID: g0aorIAIR9+6dFom0fsc3w==
X-CSE-MsgGUID: +zMpg4JsSwu2hSgZDWYsCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260033517"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:39 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v2 5/5] selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe
Date: Thu, 13 Aug 2026 06:27:54 +0000
Message-ID: <20260813062754.360131-6-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813062754.360131-1-tushar.vyavahare@intel.com>
References: <20260813062754.360131-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pkt_stream_even_odd_sequence() replaces each socket stream as it is
generated. If a later allocation fails, the earlier replacement streams are
already published in xsk_arr while the original streams for those slots are
lost.

Both testapp_xdp_shared_umem() and run_shared_umem_test() return
immediately on that error, without calling release_even_odd_sequence().
This leaks the already-published replacement streams and leaves the socket
arrays with a partially replaced stream set.

Generate all TX and RX streams in temporary arrays and publish them only
after every allocation succeeds. On failure, free the temporary streams
and leave xsk_arr unchanged.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 54143fc757e1..ae6a091b6485 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -602,26 +602,41 @@ static int pkt_stream_receive_half(struct test_spec *test)
 
 static int pkt_stream_even_odd_sequence(struct test_spec *test)
 {
+	struct pkt_stream *tx_streams[MAX_SOCKETS] = {};
+	struct pkt_stream *rx_streams[MAX_SOCKETS] = {};
 	struct pkt_stream *pkt_stream;
 	u32 i;
 
 	for (i = 0; i < test->nb_sockets; i++) {
 		pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
-		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
-						   pkt_stream->pkts[0].len, i, 2);
-		if (!pkt_stream)
-			return -ENOMEM;
-		test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
+		tx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
+						      pkt_stream->pkts[0].len, i, 2);
+		if (!tx_streams[i])
+			goto err;
 
 		pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
-		pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
-						   pkt_stream->pkts[0].len, i, 2);
-		if (!pkt_stream)
-			return -ENOMEM;
-		test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
+		rx_streams[i] = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
+						      pkt_stream->pkts[0].len, i, 2);
+		if (!rx_streams[i])
+			goto err;
+	}
+
+	for (i = 0; i < test->nb_sockets; i++) {
+		test->ifobj_tx->xsk_arr[i].pkt_stream = tx_streams[i];
+		test->ifobj_rx->xsk_arr[i].pkt_stream = rx_streams[i];
 	}
 
 	return 0;
+
+err:
+	for (i = 0; i < test->nb_sockets; i++) {
+		if (tx_streams[i])
+			pkt_stream_delete(tx_streams[i]);
+		if (rx_streams[i])
+			pkt_stream_delete(rx_streams[i]);
+	}
+
+	return -ENOMEM;
 }
 
 static int pkt_stream_len_seq(struct test_spec *test, u32 short_len, u32 long_len)
-- 
2.43.0

