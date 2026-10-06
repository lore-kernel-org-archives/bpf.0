Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C03DB997
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308001; cv=none; b=HdDz+UOMORvsNoZW3zhPROputuoBc/B9m7xYl0bpBTMPo0v6jQjqe95VAM2WLFzCkBAnN9QiYs2wcvlFa6PnM+4yTjejHpTy3rPuSkj8dpSUg/QnF9tRHw2gHwZ5XOsR28rtSks1yPhZqYO/7Hql21MD9XXnK3hHq9BvsQZxWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308001; c=relaxed/simple;
	bh=MmiFFcc/hGmmgsNmyCPIss+w1bmZuW3CzLVIRHyO9FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTRh8O7RxZDo3qhTrSzqqzg1yNNT8gMBvtgnu8cN+YYO4SkqJvyrMwHkvnLCS+S/EiHqhZqjKJo3AUl3Nqg844V4obZBWtUqLqKPXicoCBTJ2bs/zqe0y3UI/dbqQGrrcTWfmyZB2Tre7YVbn+Co7ASmZb1elUxkf3COG6axhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jkuvi/jN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jkuvi/jN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso614533f8f.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791307998; x=1791912798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uIWNtJTcNRJBABKoF5KtLQn3lLgfq4yyjFDpVkGxoNg=;
        b=Jkuvi/jNN3/khjCpR0qYSBMsKV+M7WTlvA+vgFThdq6hebQN6ymHO/lW94gUGJj40h
         KKPBf5axg0/rUwffLteegTPTx5T7JQawQKaQzmBPm6xdm26c92I55NgnNsh6rI9b4gI+
         Dc0M2eTWTQhfliHV+I8d9v1zFQd/Aos57FRsbs/LpqnugxlnH4J4awFQielstpOjKWlJ
         cqojJu0ApNt9SAmRKBRilS8t1tZ9hGPdNghw3QeJCga2E7Cq1YBU8jL/4D9VlLFW6nOE
         LT/rqIxV9smJd3e5As1O4OC7WIvnlO0ozpIqg2OuiM2Jr1Bm7L+lRrSss4wzL0wB+GkV
         jSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791307998; x=1791912798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uIWNtJTcNRJBABKoF5KtLQn3lLgfq4yyjFDpVkGxoNg=;
        b=AH15NBTOi73S70g90p09sa3Nl/7tUtTZGnDnoydu49CqUCTizuldnm+OMy4xm0PokR
         SLz/YQybwejOV5XmRgmLYzDHhJoeodPf797vOdz0zdK/tdCHh8VY5m2OnL4XEwdot8vr
         X5PbmDtOkaoVw/poCf89RbrFbGM5PuJrgv5V0w7HThFoRnPnspyLetcl1g5uJoyPsGWU
         tzMcD9r4EvJEQk1CcRMQNC4vJ0wwOfrpijUyEtYjqxPkYhiFxxp4NDHwlehbzGGg8LYj
         Mg4pvsQmjZ1E4MO8abXU01cy3noubfRTDNKDXlZN3/vADr56zAmJ2rlYgZua5jjFLROz
         pVyQ==
X-Forwarded-Encrypted: i=1; AKwUvBycelzBfxx5zTrmurkOrP+7fudQdDoXgM7tEIG0QkcrBQaUN6ApNQ3jBufYntzu2gEN7jY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkLmRegrinMZ4ChqMMjbvjV/4buEbqBHTbeP12ZSiMJtUSEaR0
	wnBCFo+/TTM+wNRCyXYA4dYC/zS+jZewLDcWPpF4sV38vJ5phc94bfqz2uH3cjT5Jtg=
X-Gm-Gg: AYBFou0oJPnsjseGNUnyY3UG5GCT/bF3v/raL6BVsqXrhbsFr9iQpO7vi3+7l79tNLM
	6cIdwB7zGP/KR14iSF0PjXiys1385/f7KOSscjBmpK5dpBhh1MgJe/9VlmGER7mugCsKqdqmEwl
	uBpVKi8aH+Q26XFf4Q/F/JBEU3At9/3AG0tLgQqBNMIOOHe3bWD7aCVHnf8ro3RkXbNOnspBk6/
	qzyUekxiyy2rU0V/tpkVPjDm8X/X/4Rm0SAohEbgZH+AFFjvdcI7LC9HY+yNBKS2IFFNmZQL6vE
	H0rSsIpLIZROhEZC6XMVmzXIqYaaUK14uhCQIMLrTcpcpILBCiZD5FjMBKVLSongcM8HeknfhHq
	mespaI9HTawBETpMHcUqpLoUiPRhDIJzfo/OV7eNE3ErFj85p52TYhkZFwzfNaIi9Qs4bj7y4V8
	rglvI1Lker2C7iMqYy0n+loL0ff0R0HF6DU9WbBfxM6IVLxhtATFuv/lka4QvlrIJzZGbsHmWrS
	m82sX0sCC4aNk8=
X-Received: by 2002:a05:6000:410e:b0:48b:ef1:3101 with SMTP id ffacd0b85a97d-48c72774be0mr211419f8f.19.1791307998349;
        Tue, 06 Oct 2026 10:33:18 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:d2::15:413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm714121f8f.27.2026.10.06.10.33.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 10:33:17 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
Date: Tue,  6 Oct 2026 18:32:36 +0100
Message-ID: <20261006173241.65945-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006173241.65945-1-tianyi@cloudflare.com>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A veth device advertises NETDEV_XDP_ACT_NDO_XMIT only if its peer has an
XDP program attached or GRO enabled, that is, only if the peer will have
NAPI to receive the frames.

veth_set_features() updates the peer's flag when GRO is toggled, but
returns early if the device is down, and veth_open() only refreshes the
flags of the device being opened. Toggling GRO while the device is down
therefore leaves the peer's flag stale after the device comes up.

If GRO was enabled while down, the device comes up with NAPI but the
peer does not advertise NDO_XMIT, and devmap rejects redirects to the
peer with -EOPNOTSUPP. If GRO was disabled while down, the device comes
up without NAPI but the peer still advertises NDO_XMIT, so redirects are
accepted and then dropped in veth_xdp_xmit() with -ENXIO.

Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
device") made veth_open() refresh the device's own flags. Refresh the
peer's flags there too. The peer's flag depends on this device's XDP
program and GRO setting, not on whether the peer is up, so it is
correct to set it even if the peer is down.

Fixes: 8267fc71abb2 ("veth: take into account peer device for NETDEV_XDP_ACT_NDO_XMIT xdp_features flag")
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 71227d0389aa..643b97dc5245 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1415,6 +1415,7 @@ static int veth_open(struct net_device *dev)
 	}
 
 	veth_set_xdp_features(dev);
+	veth_set_xdp_features(peer);
 
 	return 0;
 }
-- 
2.55.0

