Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AA27A461
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383984; cv=none; b=oOqqswwLn8PShLa/aELjQLXmxUurmaX/cu3LtwVtUqyebxXjf+byP7Sm1DdtcvrRB+P6paGuX7jZJKtMEeUMYYd9PJ72GqieoSFYr3ukn6s0CobfzbpjAMj34rZZ+0AJWWnxG5QGKyaR6Rvikqom1b+/MNkkPWoMpiCpN42Shu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383984; c=relaxed/simple;
	bh=lpXDhwDt7M7bVF11Uw6qzFCsVYaslNnh3blirfXhByc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNwy9d733ZFBpPGxBFE6gHvmCHrfDsVe6ngL4kazmule/rSrlb8Nt5eZTFuzBJDJBd0ysVqIJ1pCx9YjWMgqv04VeX4Ar+bf9r3qqvFo4mdeDcOf3Qft3qavKYWLgIT6/Q7/iisrPvAgfKkhgLbJjwLKvMIZMrAgl2CSDgm5r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2hZlaXf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2hZlaXf"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d196a2334fso318455a34.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771383982; x=1771988782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=44uTeUd2c473NALQsDJSupHm1e3w/A5YaHo3jbN+xAo=;
        b=G2hZlaXfqfNJOeG83JRX7ZtSlj6D5wuQ/lUz4Kiqbdt/3EENz9/pBxmBeG9z0o+JBD
         0hcfcJRW8MrwZVzHjLtPgBXJ1rO83MQlRGysWXtbDkyyC1NF5458VhV1sTd6eshIWHld
         1QTMD7bsJPk89HY7EfjUMzVMzaX5lMFhhSFqJYd3s7RJvVr2lgetLsk51JIxyf2BMmA9
         6iIZWCuFqStmrJ2vOIUmxwQjQtRPgHMUm1td9eUcMDEzTM5vRU1Ojz4+7Mace7EbebtL
         1Ba5tmVl0F6Mn16dd1dx8ZS5AnmttdW3Tm9EDm+ZtmfogYtFeVH79SOEy3vyuQvlBYaJ
         IRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771383982; x=1771988782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44uTeUd2c473NALQsDJSupHm1e3w/A5YaHo3jbN+xAo=;
        b=LUxj8bL0nG/YM4pSr8T2MXMTl5FLnEUOeWzBjtlD4xe1JCi1XlbTUAxzAgYr6Nc739
         fCvJgYEjBZSOz5XQ6DDT7J+inlhsm7AKRC5xr50Mpzga6aItKCltzbPru+iRgpCw4bj3
         ScgOpg7zDrVF+xaVZCfeeMTuU+38WEsSzevIr48Sy3kRB8Ic9AqwcmUwhA7CtEqza+Fu
         S8mOL2FfYyFQRa+y9s69MCOJAnsMA/ZHJf7nDmr3CbCqmdi6Li9iY6EE+hAoyAxNBqFb
         A4RL0mCHsv7k1HqfSUpLtkR+WDh1imiQZ2gtF5UrBFMOFpLnt5eemKJA8xOHVEfg4/Qg
         NM2w==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2PGjgiIqA8Cz/IaEfewFRps9kRqDx8E5sBwytBvfHJTN+1GlM/Wf7qWYapOqatp4ikE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyd/Kmb3a+Ajv6kQdRE81gQNAAQ+309QlRWlHkXAsNjTL8Mr5A
	smVwuBY9mGnXsSC/YjHPJI+18rBZDqRVlnBEux31BdpngZvPhLjAtQSs
X-Gm-Gg: AZuq6aIr/ohpO9vUh+Hh6pOOcnPtTpempHr80p435GBZ/CoKYHJhKNLwNekWv6yb6dj
	Kzl2rTEgkLcHqmMlhdq3vZQmm3+pxfE+G/pg1yy4SsLT3FwrFZHxqYftqJd2VUeOCpAeX9RP6tE
	JUvzkzfNkoDxzygLowujxo4NHNFRv7/Xkxh1eRmvMdeH64djPJF3pgpVg+n0ZVKe62b2xU9eaK+
	oSSRadyr+SH6HTJl9SOD/SxPF6zmt5zetPErtPur7kilOzdZ6D9lXB5XlcN1/vEGnPGzlfbv7+V
	q8Pkp+kEIal2pS0couLUj6gStnEuKAAnw4BSaNv/CqbN1zsYA2WscA3CePY8FVCnHhZHG7Rj12c
	3rlLp/+08cEYcGdsH22UcmDh0/uGdRGb3GZBnY/WwmzbfaSRkOW5Lpiw3EEkvd8ILPjZooqlgTs
	ijCCuq0y9vaHICKdNVVldmp1ezQCZ9Aw==
X-Received: by 2002:a05:6830:270e:b0:7cf:d075:2674 with SMTP id 46e09a7af769-7d5062b100emr339790a34.15.1771383982000;
        Tue, 17 Feb 2026 19:06:22 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4c22d11a3sm12113537a34.6.2026.02.17.19.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 19:06:21 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH net] eth: fbnic: Advertise supported XDP features.
Date: Tue, 17 Feb 2026 19:06:20 -0800
Message-ID: <20260218030620.3329608-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers are supposed to advertise the XDP features they support. This was
missed while adding XDP support.

Before:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': set(),
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

After:
$ ynl --family netdev --dump dev-get
...
 {'ifindex': 3,
  'xdp-features': {'basic', 'rx-sg'},
  'xdp-rx-metadata-features': set(),
  'xsk-features': set()},
...

Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index e3ca5fcfabef..b4b396ca9bce 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -805,6 +805,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->hw_enc_features |= netdev->features;
 	netdev->features |= NETIF_F_NTUPLE;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RX_SG;
+
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
 
-- 
2.47.3

