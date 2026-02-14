Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C72DBF75
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089594; cv=none; b=S1WA72+/Lh7kA+AldojWsWtLGIwpUfKnLcP8JpnRUIJb06dIgGTAZ2UpKN9M6zkqxf0FbgsHigSOh9oB6KVxeLmzwCN7k2c8d5sY8+xTxyTpEs5586AfQtbr8ifG8vaP03iuMCKFXobH0HYN3dVhvyfnufE8Gn6N6JG8FlebYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089594; c=relaxed/simple;
	bh=f1rti9oeH7A6CzK1t+w7fJBpf/AnV39jCnE+N+mIK6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY6Iz3xhJfb4C7XjIUM1BLbrfay7Z1dpC/npISk1E/MzIIpndQ23fBC1qMZOBIeGZCTys8LdEeeQFXqAiSDig5KlLv8LOq5qPU2g23OVIWcD5qSopYuaWDL37Ebqd0QFTs3+RuSPjqntUgs4qdfkn4U56Y6eEJIlerECEoI01iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7tBfm1v; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7tBfm1v"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f053b7b90so1280764b6e.0
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771089592; x=1771694392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deQy1Gi8bD3NohJGM3hXhCAHB18lIGL5Lign1o6SSv8=;
        b=d7tBfm1v6xftvuMKAyYKcDKB/dq5dIR089aTrTsfwa+oPf558V+O068Ie8MC/aIzCv
         h/RH1qLrbkeFELsTfBcFDonyeCMkmjYjdNCFA3ZEXM2rc81BfgnOiwEEpbR0z59QEbBr
         hSapsiFwNvxOyPI+GjO4/ymkuSr+a9eRSbw2UOaWpmvlAuJrzxnTVW3DGukn8C1MyIGC
         vPGveVeAR8r5FDIqMf+wQv3xXaQRRsy4T6L8weYbEXAUwx+pqiXkXg59Ol3WCSq//zsG
         njVDMBGzpJVxiMrrcLm89GaPoKp0wclNSsQT34kffYave9Co6EQPW3ECISfo5t8dbT0n
         V1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771089592; x=1771694392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deQy1Gi8bD3NohJGM3hXhCAHB18lIGL5Lign1o6SSv8=;
        b=pGMVk5tUeFv/n83fIyy23tTsreKwHeUwp4AwWuu53bgW2zt13SocTao+Qbb3dQ2/qA
         mbIsbuj63FLrZTU+BEfS7xXjeOG8YEQDZp9tQ4AfXcHnv/qwaM4lPQEgIm09Dz3Snvg2
         wO22PJd3MU7ZOnaxxIwzJU1G/rWhFEY2smZyaXU4m26HvfYi47QhRtx5ztFkczEY5gNc
         v2L1HWj21p8fWm1lVnRGPVBLm6s3o0EnrvQxtxj6W4EETxZoSC7D4BYjoXU9u/QAqTfA
         3mepHTIPZpbccbAkTy67vynVn5MknUv0aRJoZ8JO4qEOPsg9YrHOOuMYRZT0DhIddCvT
         VWOw==
X-Forwarded-Encrypted: i=1; AJvYcCU2J/e0kmxYi0Zm6Pe8Z9TGB/xVAq5mdMX07JJl2/nq1W2tvZokSxF1wrGkDhiG1Nd3UXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIdqEP39n7FgZ0uDQ0sm1iTLV6PbgERYS15MTODviQKDzTc0j
	lPpvt/ekLNh3CaQYlEvgJUv1yZWcEYC9a0W04RgCyePpGxgjHp5qOf36
X-Gm-Gg: AZuq6aJcwcY5SnsR9Im1Y6mR30vLWWzOjo83gzzoD2R48zxvDHi1/tGiZgk6Xct1ASv
	mm2Ig4FyFtprAySGQAo810XFZ/kNXDE4yvFn9YNysrbEYiw9WQ83bvaQJEjoDw1DS8yth2tD4cD
	nd4WOacS5vcvlkZdYy28jGliyZKSzvLKAmZDTzWJ9h4+DjPPGF6meDYorIM3YRe1Nbhc6+X/+zQ
	YMzIAtKb5wUzus15SbWRFNeIkOGpTeqYxHCBPRWCdidUqOc/d0Kspim+TmjamEn3P7Ovs1BFza6
	g0AqBwQ/xKFGAeY4xmrofVnR61HS0+6X27gsAHEpRzyM/000szeC7ha11QdUySdUP/q5r1ylRvA
	VZWbLYiYSbBKu0DOeWWKjdq5kbEPYFW7vCtLLVk0tWACDiCYZeD8xk8sT3sDepnuPmyjI921rbq
	ca32vZc9X7H7IXtTY5hUtDXYOF91bU2w==
X-Received: by 2002:a05:6808:5087:b0:450:41ca:6bd8 with SMTP id 5614622812f47-4639f08bb97mr3037172b6e.25.1771089592019;
        Sat, 14 Feb 2026 09:19:52 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463be5433ebsm1009337b6e.17.2026.02.14.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 09:19:51 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] eth: fbnic: Add validation for MTU changes
Date: Sat, 14 Feb 2026 09:19:49 -0800
Message-ID: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increasing the MTU beyond the HDS threshold causes the hardware to
fragment packets across multiple buffers. If a single-buffer XDP program
is attached, the driver will drop all multi-frag frames. While we can't
prevent a remote sender from sending non-TCP packets larger than the MTU,
this will prevent users from inadvertently breaking new TCP streams.

Traditionally, drivers supported XDP with MTU less than 4Kb
(packet per page). Fbnic currently prevents attaching XDP when MTU is too high.
But it does not prevent increasing MTU after XDP is attached.

Fixes: 1b0a3950dbd4 ("eth: fbnic: Add XDP pass, drop, abort support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 81c9d5c9a4b2..e3ca5fcfabef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -262,6 +262,23 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+
+	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
+		dev_err(&dev->dev,
+			"MTU %d is larger than HDS threshold %d in XDP mode\n",
+			new_mtu, fbn->hds_thresh);
+
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+
+	return 0;
+}
+
 void fbnic_clear_rx_mode(struct fbnic_dev *fbd)
 {
 	struct net_device *netdev = fbd->netdev;
@@ -533,6 +550,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_start_xmit		= fbnic_xmit_frame,
 	.ndo_features_check	= fbnic_features_check,
 	.ndo_set_mac_address	= fbnic_set_mac,
+	.ndo_change_mtu		= fbnic_change_mtu,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
 	.ndo_bpf		= fbnic_bpf,
-- 
2.47.3

