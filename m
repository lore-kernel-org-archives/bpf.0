Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965596;
	b=s4QTr1u885v/IoB3g049UlnH17DlCpwZa0nTmnAQu4cawrcFReXgNEGK/kJj8jvQRtxt
	 Xwxb/ExvhjotP0rQHNaGkE4g/m5NYaxwX+upE+kWNtk3WbfH5I1PC2mqTy8lYP0jkQM6q
	 nVob4MJcArCt9A11R6Q5HzhIdVNC2bHa9fx7adK7DwtP8BeltlVOBGRJsHSXQPZXsnq1q
	 GYdCQOpvRsnro7IBStW1wr9l6J5f7PkH9tPA1w+jv8CLupaAiZjN59N1cE4VBU1VmBhP6
	 b4Zfy+OM54frYOPg7YEBbVnEYI2iV97vY2dx8OqPNXbLef377QkEmp1gPpwsyZxxT7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
	b=d+i76wh6hJhu/B5jirjq8h/8WXXfc9HjOSdYgkwcN/LBc5aRY/ouDJeY0oG6Onbj/JmK
	 x6HXUC8VIODz0HZv4+IkSswx3rxUPXPxNaQMI/42JCBFrjzZpngkxfMJP9Wriwu9SRm4L
	 2+SCE2AUiJOqddduoQWcpMAq6DRhLOYfdC593WOUh7DOPJwn1Zmw5SOe6hwXp4PsWt1A9
	 tB0Hr98Wvc5RfRNUadOa0Oj7d2vZIxTacHsgAziWnlMx8aD1wf4pT8B1p8hIYeCmcOP1o
	 Avg7Xixkxu8JnFg5Gdi0gplTbiL2kn//OUwGcSHcXHH4DQhpE6p1tvDgfnsKMf78H7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Vh0eTN7/";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24581606A938
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24581606A938
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vh0eTN7/
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so870602eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 03:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965594; x=1794570394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
        b=Vh0eTN7/JxSWLK60P1Mlw0WMnnGjwEufQsnkS/70TwLqJyiLgyjfzu0TzMvysjSjxb
         9A4tdCkcJWiifGJ91fFW39s6dbSNrbCvQyrf5OL23e3lOErtHxyivpLEJmJ5mFXKDOes
         POZmcdujx1Jwpwg4sGQMNAwTOCQntkckNVJ4LyUhdlLmIMadXQ+iit9qCyrnXMwJgvQj
         TFaRTCi/P5HVLdhMrSQCgRuUiQIXKOTnThoMYbiaC68EwADTAubRICeVz+ElrEmVQlSh
         w2Xv3sCTm/XOt/dvB0+SzqmwhAYSZrwLmHPLVWTMgmI1sGl/2xc9z9yAZKgSGzpsPx+i
         7A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965594; x=1794570394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW7RojDyoN5co1CXu90PKl7ieBhUmfH8TTR5WzS4o3I=;
        b=H+i+l9G3UJExB0xOmUenavwWCyunznI+83lWeXt2D7DpK+ZvHFAEQJ/+J2C6ngWAmO
         nFspeK2QhNQNsJlrO4antu5dMi+3M3XNxhCF50lyGyuHv9rcVUyfxf/Bf/0cl3r/s9l7
         lKtFQOgsa+j1xe4T0khQm6r9dVPesTehpcdRf4vZjzoNxep42O0Ur+clJBjGaYxDQ41B
         R/BKG7HPgAyL4Boh9VqrisOH/Luru7MYrE9kDUd3gQQYLkx54yd1IQDB/VWr0gthxTxB
         kppYoWNGHlbSkcKev6bjxmrC2UbYBQlBfoINNbTjGbsiMRlbfp+D/004qkW/Hg3QSDUO
         8zVQ==
X-Forwarded-Encrypted: i=1; AL+hErGnKP1+firU9RFpBXQVaAbHZ5YGVWDIrZvk3u0mhjxr+Cqj/BLaZKUTsXrrw6JDPIHmtYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LcIRDuKn+WDsO82XNeruRBE99itFj0JF+euuRUrdn+JdU0vLp
	s77bD/eAJiQGE93YD8AjlGUgnb6UhV3WuRJHuQbKtNal5CcYALM8lTIQ
X-Gm-Gg: AYBFou1f0c+UEx7XvEdfUpYC/Khb5d4NRP91XnjNjKgsqP2/EguoVRFVn0bbau9YURY
	o1eGxGZXRdX0f+oyLrP5lzV6E38nMVJOSMR716htYfHLhtJfmDQpNJ8cMcIPWjoLgeu+5+80x4A
	hHjcVfWJAMtv4dAzeuMHFW3EA4U1URlxmmSkic9dTBr/jpGpJHHISWtf4+nQIupowAj1HZZb1Iw
	hsmrzgEjb2slQ8PhEBtMhRaJKKvE9xMUpUkqruHJUMpltGV9kjV/F4wttf3wkVjy3ZgaUxwMmI8
	rmp4SwDAUMrNvuocqmoZjanQ2OUMsf9zikow3n7UGJzNB9OZ/bvwNYfNV7J5F8RDi1Oh1ZUdfhg
	66Kje7JV42jGoNulScgw9odZLSAI3bSaeAWDR4+qwIO18xlW5O3t7LEUYBfHbwKSIeJYaFKE7qz
	OxW3NwCQCyC2TvILMzI+AmrmHWHqlAYAKkV4Szrupr6BhtHVJI1KzaWwXmLDJ5dp8UTpnIQ/vlu
	3XcZWhWAGsnswFZW7jinEkyw2cLx6iqoJZWwUYhmsvRpt1vtEUDIDVScP2iphE8Jk0Q8mMkoiig
	h5FIFt+Wn2RaTBWsqU5gU5BoMZUWOdufwpwkY8+jauV7
X-Received: by 2002:a05:7301:1522:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-36f77eda447mr2941017eec.33.1793965594008;
        Fri, 06 Nov 2026 03:46:34 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:33 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 1/2] gve: block XDP on the DQO-QPL queue format
Date: Fri,  6 Nov 2026 17:15:50 +0530
Message-ID: <20261106114551.212675-2-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261106114551.212675-1-amaan.cheval@gmail.com>
References: <20261106114551.212675-1-amaan.cheval@gmail.com>
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

Commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ
RDA") enabled XDP on DQO-RDA by dropping the queue_format check from
verify_xdp_configuration(), which until then refused every format but
GQI-QPL. Nothing replaced it for DQO-QPL: gve_set_netdev_xdp_features()
advertises no XDP features there and gve_xdp_xmit() rejects it, but the
core only checks that ndo_bpf exists, so a native XDP program, and an
AF_XDP socket on top of it, can still be attached on DQO-QPL.

The DQO-QPL RX path was never written for that. Its page accounting
assumes the driver keeps a reference of its own across every handoff:
gve_xdp_done_dqo() passes the buffer to xdp_do_redirect() and then
recycles it with gve_reuse_buffer(), so a redirect target that releases
the buffer synchronously, such as an AF_XDP socket in copy mode, can
drop the page's last reference when pagecnt_bias runs out. The page is
then freed while it is still DMA-mapped and registered in the QPL, and
the driver posts it back to the device.

Refuse XDP program setup on DQO-QPL in gve_verify_xdp_configuration(),
matching the features the driver advertises. A zero-copy XSK pool bind
is already refused by the core for the same reason, and a copy-mode
bind never reaches the driver and is harmless without a program.

Fixes: d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT support for DQ RDA")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2437cd8ba633..4e9e692a0ed0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
+	if (priv->queue_format == GVE_DQO_QPL_FORMAT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "XDP is not supported in DQO QPL queue format.");
+		return -EOPNOTSUPP;
+	}
+
 	if (dev->features & NETIF_F_GRO_HW) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when HW-GRO is on.");
-- 
2.47.3

