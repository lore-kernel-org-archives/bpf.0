Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1C349CD2;
	Wed, 16 Sep 2026 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524997; cv=none; b=BjNzWhU99hp0RxVDBFO3/jvWkmDnbSdzNwKIpxoTkkXxG2WjlboFo+WCgFUt+Nu/97CRGnV0RPc+TCAzA2DoPgdLh0ZA2daskbLwkxQAfGAFDZZ3tTBmdHGwDf3xNiLTUoMwcQBJoGgoZVhmL2lQhvnSODf3DOMdC6hOl0ZUBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524997; c=relaxed/simple;
	bh=6ZxDcPAqQVJS73JgYo4ez8O9QdcZ0Sgl2MFN9zCIbJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewDjwpyE+KsMhNjYZ9kun+LNBEgOhtpYICgNtrEp1dPddF++5eXOJBV/sHnkl41vTY8tL/vy7iKyMiy8wnhYIScYFQ1XYyolFxTqaWTYGfrx1vr5XbiDbK+3m2dNGsUFXEAq/MwJ/h2qsN+Z7VCk9myXhpa9tKO92yRJhJhY6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7lEX8cJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7lEX8cJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F31F000FF;
	Wed, 16 Sep 2026 02:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789524991;
	bh=j9CXVwoOhd+i1uANIa2OgTibMVhdmc64PHu4ihbI664=;
	h=From:To:Cc:Subject:Date;
	b=S7lEX8cJ2aSbDcDgBnmeJtVx1DjKzG4HEmODQddnZwHai9xWsRiixUhgS6e+9ferT
	 glYoZdyrp76YyA/9/pfdhyGgHJSaJ5Goixk2Ok/IIeEksfjYv0RzfHCoo0/cO6CaFM
	 /06+nLFX+3wp6NOBCg72Lavpj39Gu4noNSD60DRFJyag2bSOOirYM467PtLwfv5HKN
	 I3gzzpThkP6KL9enUoPc1HHPchNY0ykamsAA15FzxrYcdSRJVxk9YUdnovECfwh5Vz
	 n8aZs+tciiF+d9mcFX0JFyDJ7ZdA7lVIPlC+fGamp2zasYE90dRAdy5oCAOLSG0Cu7
	 +OHR1+RzYlvqw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	razor@blackwall.org,
	dw@davidwei.uk,
	bpf@vger.kernel.org
Subject: [PATCH net-next] netlink: specs: netdev: update doc for xsk tx-checksum and zc-max-segs
Date: Tue, 15 Sep 2026 19:16:08 -0700
Message-ID: <20260916021608.1702731-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor touch ups to the XSK-related doc strings in the netdev spec.

Tx checksum is (obviously?) Layer 4 (TCP/UDP), not Layer 3 (IP).

The xdp_zc_max_segs change is more subtle, I guess, but to kernel devs
saying "frags" may sound like the number of skb frags. The value includes
the head in this case. The default of 1 means single buffer, XDP_USE_SG
sockets are refused when it is 1. Let's use the word "buffer" instead
of "frag".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: razor@blackwall.org
CC: dw@davidwei.uk
CC: bpf@vger.kernel.org
---
 Documentation/netlink/specs/netdev.yaml | 5 +++--
 include/uapi/linux/netdev.h             | 2 +-
 tools/include/uapi/linux/netdev.h       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3e3f03bd5c29..e13461cf3fc3 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -80,7 +80,7 @@ doc: >-
       -
         name: tx-checksum
         doc: >-
-          L3 checksum HW offload is supported by the driver.
+          L4 checksum HW offload is supported by the driver.
       -
         name: tx-launch-time-fifo
         doc: >-
@@ -118,7 +118,8 @@ doc: >-
         enum: xdp-act
       -
         name: xdp-zc-max-segs
-        doc: max fragment count supported by ZC driver
+        doc: max buffer count per packet supported by ZC driver,
+             including the head buffer
         type: u32
         checks:
           min: 1
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 35ff083221c7..9026e0414fbe 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -58,7 +58,7 @@ enum netdev_xdp_rx_metadata {
  * enum netdev_xsk_flags
  * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
  *   by the driver.
- * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
+ * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L4 checksum HW offload is supported by the
  *   driver.
  * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
  *   by the driver.
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 35ff083221c7..9026e0414fbe 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -58,7 +58,7 @@ enum netdev_xdp_rx_metadata {
  * enum netdev_xsk_flags
  * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
  *   by the driver.
- * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
+ * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L4 checksum HW offload is supported by the
  *   driver.
  * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
  *   by the driver.
-- 
2.55.0

