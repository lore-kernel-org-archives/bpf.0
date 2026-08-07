Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9747CA7E;
	Fri,  7 Aug 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110269; cv=none; b=u+IuXD5xr8WvcpsB3EoiCndEIkmS+K7yvUU0VE2HdOqjZyTMOIfo9/VP6M/9ZKFJu05NGcdC/T8bb85PRskqu8AuV2Lh3sxtpHIXzxABRCm/Z5l6n1sNYUyD4kGsjn7YiToQ3qX7X0TRY6X3rNt3hC2/eFl6EzBIbhQ24pHHyy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110269; c=relaxed/simple;
	bh=PHWBJJWa2vDogLDwmzdFullfODJdgE64IxAOkJXV5bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF+qtw73grctoFRFUJy3H8PBmW2lfZvZnw5mnu38iEOQ2KVHKi2qriMagwjkfsuqLFSic+uLpx92tk5n1JW4i4UfQl6RH4FDp5Ws7yxBbnNCTBHrGjufcQeWvNJGfR0e90AXqOOpS4FBPv+Dcn7oQK6kt8Z2hvLu2CA3NSicpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MolFXecr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MolFXecr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110264; x=1817646264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PHWBJJWa2vDogLDwmzdFullfODJdgE64IxAOkJXV5bA=;
  b=MolFXecr8cw4MoOHeftfCPXchiI8PMLsoRmM7YolIKFERDXDUSb8/KS4
   FdsK4nvnp/HPelghxGFJ8AUhZzJ+GTaMK2g36fLwBHmkx9uR9gM7kjINN
   NvZ+hVlLyOSY2r4WkTF8xsrnX5F2Kh7OGtSLknbcv+5fwnApdll1zEsu9
   /IzW+bASVlea77JBU6KW1WoZifZt9K4xmyTUs90fmVz/1KOr6cf+MT0Na
   Jjsja5gtcGArS6VBVvZZ/sa4YtJFeSIM9zIUqcfSJrRGQdL/SVoik4ai7
   s8umRU2fXP4V08yk7mhdjipbm0ngbOe7Dj8IO5LdmuVGoZzWyYtJgJDj2
   Q==;
X-CSE-ConnectionGUID: 9M0KJR0hTLOZQdjcoGF3Sg==
X-CSE-MsgGUID: L9cea6AyR2iHlLrFx0CHUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079965"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079965"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:21 -0700
X-CSE-ConnectionGUID: LGBnoXc1TQK91t9IjwZpLQ==
X-CSE-MsgGUID: uSsUuykjTySjH6dpNArALg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080089"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:17 -0700
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
Subject: [PATCH net-next 5/5] selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe
Date: Fri,  7 Aug 2026 13:42:09 +0000
Message-ID: <20260807134209.3794735-6-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
References: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If __pkt_stream_generate() fails midway through building per-socket
streams, the original code overwrites xsk_arr[i].pkt_stream with a
partial or NULL pointer before all allocations complete.

Allocate all TX and RX streams into temporary arrays first and only
assign them to xsk_arr after every allocation succeeds.  On any failure
free the already-allocated temporaries and return -ENOMEM with no
xsk_arr pointers modified.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 1665339844b5..ccfd9e8436a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -597,26 +597,41 @@ static int pkt_stream_receive_half(struct test_spec *test)
 
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

