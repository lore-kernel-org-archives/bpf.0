Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A53192B75
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673717; cv=none; b=doh8jAMXmOgT+eaoPKZ/RsIpkRpXjzCYwvXmvdBSvK/mC9kC9X+y80bH54J9nOCZ0PPF3+YTROc2hanI7hjuMIlTbMcxigov7FDM/xMpoHJjCf2y4+UF1XDriWI1qz/d1YHVIo6bx4PSNBjoQya4ri1zGaoG1nBe3vci+SGNFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673717; c=relaxed/simple;
	bh=yPn3zWFs108M5RNr5Rp+kEd1EJ6GP6gcs1NhsUwltNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTWORYwC5CVdfotS0YV0tqqTjear7Wcs7TJmpUwQPDpZxQfNNOIMhreu9uXhlFE0gzduzCxmXWwiKPmNgSZkwnKN6uMBSNHdkoZWEmAeo8TYZhXWkk00IdKUvMbm1ZqbtARgSWLbRauIaYhCCi6tK4N3XqXnlbPiujF5SPfeL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4CV6+1Q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4CV6+1Q"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so827468a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673716; x=1777278516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOE2AqceayWh7ep8Gr2jA+i1jYVD1CfxeHKydIjAYY=;
        b=G4CV6+1Q32THKkGhFJhlBksIHOw0inSPbLhegtWHakTCisYxra7qTYhgXrlmtzwR1K
         I7G9qMhxrYrQzIXvOJofo49gc2NuLuD+3NiUIf2oFFvPmlW9WZBEfXOo5NQWuhbEOqNA
         EGap4FYSikfzDhSZwSaSzlJH665LgTwvrR0SeV5Klps1ukMfRNgHO23BKX+uymCnHeII
         Jiggd7F7p3uDMrxMAIQzpJ5jmDf/SflTDLNeeWDnpEw8Iy8pJSYCHVA019UQZV0k2kvP
         aCjFH57pdRP7bw7cPVXzeFpl0hZofcIEHrRo3YW9/GKCCcS1vi6oCgUa6AE6o2t43iGE
         quAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673716; x=1777278516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xyOE2AqceayWh7ep8Gr2jA+i1jYVD1CfxeHKydIjAYY=;
        b=plCJEAkh3VXuRY2Q46Oohr1w95gst6318jetmO2GVFEvxxqJTz7Ma2zsZp+dm7lmzA
         jEazLPjsA7dTXEVbWXzD72GMFu4uZkCDYpmmuXtGivFb1sOgIpMMgVfT9h3zffxuccUc
         mB0M4NH9hifIcSQwvJJ0keCLFyJ9nbhbEdMiTh6Pbahj/BkR4xZCznsRXjGEe8+OXv4M
         aGpnlRL2663w6W1U69N+ySy3S+fbfFZNQjeer7HhKmzN21VvrFEW5A0JsFP4is3QYd4E
         xeTtxXaj3qbUdun4LlUZLJjkCTOomYmUqUef2u21qp7GX+bdwpcx+2ClOkkTozbojru0
         cj9Q==
X-Gm-Message-State: AOJu0YysM94hykCYMtq49Wow9R3CHfojBjaYPe+kbCopg0rZ6bsANYD2
	+2ilCFU3XMT6+AwqmdUq6mRoXyrnMJWZZhTtVNB9h09y1yKoTUNXgq1d
X-Gm-Gg: AeBDietRvtlahFh+TrNm+p2KPfouFamReoyprpAwsBTlyhqsQms1iBUn94utKG5DrIB
	MpakjPakFF7A8Pk3lTWYlkNhTtxGVWeFxuSEvl/gH5zho6qRut5rLIXrCXFHmzNLyObzSpVi1PU
	EbjbYc/T1bSdIEuo+WAR26elrBCDNNVfO6d3Jt11ajWF0XJOEnJU9aznfm4MSPydLQyoC+pz/Nh
	oQlUKz7q+k/Ou9ThZLoxtQ4pT27c4nXaZDe9az3DZnt7Ifz26yo/D2L7+ZC7IjsdFtbg0cTvsp3
	9RtglSbXCMPfMuAz8nXpO0wfPgeU+QvKjhxXxb9TnxrvlFMHHhPjg4U8ORfL5qVkWaozhlkp56F
	/FWhi6IVB0hSA1SZxeXPML7yTiymFgdTpNwB8vxCQfKU5t1KJ52+IW9cnsALNUkXvcxW9/mwjrT
	KuiwE89gqtGXwM8N3OCig8mWq0SH+9Ks9PbtOB11k2Dm6GqNgloOSJnD3MpV0Yb3ZgneuwCIGlT
	hWoLVjP
X-Received: by 2002:a05:6a20:7285:b0:39b:e321:67ea with SMTP id adf61e73a8af0-3a08d8fba25mr13642856637.45.1776673715599;
        Mon, 20 Apr 2026 01:28:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Mon, 20 Apr 2026 16:28:01 +0800
Message-Id: <20260420082805.14844-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Introduce a new common helper to fix the issue. That function will be
used by the subsequent patches soon.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4fdd1a45a9bd..614e7bd1252b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 	return 0;
 }
 
+static void xsk_drop_untrans_skb(struct sk_buff *skb)
+{
+	skb->destructor = sock_wfree;
+	kfree_skb(skb);
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 free_err:
 	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
-		kfree_skb(skb);
+		xsk_drop_untrans_skb(skb);
 
 	if (err == -EOVERFLOW) {
 		if (xs->skb) {
-- 
2.41.3

