Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014B39099B
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416138; cv=none; b=GOnQ+GpcWJSM/nY9SII+ZP0eiRtEWfZvHThNQrbvu29Ct3pYFGSkbTRyqqpcl4g7C+HLhnd6lZsMRJJfabWhGHP42/fkERangaTNp8IQF2jIig+l7YDOxdTw402W0FP96znbfUdzAHHWxRkIOoChIn3RvALz/sBgK8z9LcvgDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416138; c=relaxed/simple;
	bh=KFECSS4aB7ebsKhc9cQ+oy1mgcCmosbiDCQwtAwfgmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ac2HDiKPnAgi31+h4ulc/ihgrerr69g8wE30D+iVhOrODFTerAKnpRM9+zM0GVlK3nuU61R9YCaMXI3ytcuZil89fq22kH1LYtiqTCbPkxStfXeTnzUgKQWm2LgfVVcXu3yvJ2/sHfRaDeNLxuT+DwsxGLwmbKr7lalCGr8vU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeNEkbSt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeNEkbSt"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b37d84a6b3so125741187b3.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416136; x=1778020936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecnzl0rAEZ1GRn0EllrW0hRzekmmc0UPEYdKJcAYG5Y=;
        b=oeNEkbStlmLUtV+R1Lb0dnvKyG3mYrR68OwGidORtt/N/kbaWolnqjT7+XPgPKPKUI
         iiKDBigsqLDbvI6K8vt3weq05Pw1JAWlKOgrDsybRs/Ges7lV0lTxOObUWBebGxDzLQT
         AI6vHZmcqH63UOukMICr/4BaB7IP/dRDkcekfYwAmQNxAFP94lyKJ2QCxdFIE6A4kOtw
         NUdA25YMiuzmZ2BUEglA8vm4HQqjnqrNFOhYAU6pGlZ3bbDPlNfKpqLLd5Glxt5dNWQo
         3Z1/GL0c3wkXEBY4b07wQML3Yi0XIzEJu6t1if5fn55y2DSF98evS8114FIyJktkaGD3
         8EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416136; x=1778020936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecnzl0rAEZ1GRn0EllrW0hRzekmmc0UPEYdKJcAYG5Y=;
        b=s6dy2YD50aTAyGZSh8f4/WU8HXLWyuUZ5IGAKwrkmVGIGhbiHCdkfAyfIEjdPPwDNo
         wav4CyBobx1T5Lj4S1bFZQfs7VtO6CoybNWFNom8fMQljKe9BZxcB1WJU1XyQ8W2KsK9
         APGF2AEXMjMN3R8rpjjtd9lwtfpFAWJ3+ImXDe9P0NsS83WZ1ChyiRTqnrpoi5JL1c7f
         R+R5vORjDNa+uffJ+2U7Qhp2u4tH1ZqpipfaL22LrgDT+JfynSn8CXQ+M25eCvW7xnQo
         rE2zx1t7ig/JeIzIkdueVazoSrDy11uP8iHj2D/vVZDMdHP8rbM3Cc3iz6xHMmUnZtKb
         7s6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+RPMd8xaMiAfbEqP53AK3Il8MEPm6tuvVjlfQnmlCbRfxPFTrUAI2Z6pAIVQUCghnFnJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSvLzaegCdUlPT7+DkRnoR6Ip6uJvuc2Qu8pddU20ymDXlBk+
	zp9wnyKCfK5ixWFgyMOY1mN5qnzeVtFEYcrhm3J9PpeBxzxv6IMFp08p
X-Gm-Gg: AeBDiesrH6kORrzQGL4PSpqsOJACtjxRRl6sVvolQy6zIuTfFKZjj70FtZp/Iw4U3kO
	Bk64OfyXJ/oPJzZo1l66dbsym8VSE4SH97rE8q6bVwog6zirD0GqzGfS8x0sgPJQUceeXPEMsrK
	0CM5XsRE2XRHuW4eH/10oJZk17I5U6ZR2//f0FkqYig2TOmZ/g73IR/lkeohmGscCy//0I8HWSZ
	tzlFn99yG2yyyh4iXGyHN6xEb7D6+IH7XTw7OSF21jVnPUusvtml1yFvGzn4GvPmsUBkFBmn8fF
	Ecnz2y+Gzce/fBFPWrlKxaW/spuIcicCUHLPGm9Els+H3CK+8JNmQ266jGDARhpAFNZ3JJW/TAB
	d2xJg+wiq5FhT6dvg7herL4VDa2nXVTE4U0hM2binEIl6NCBDp+lp+2Zm0nIaJ00e9J4ElHtWF7
	pKF/eLrKhd7l0/mUE/bvnrl5sGtBYoRQup
X-Received: by 2002:a05:690c:6987:b0:79b:cd3a:a5c7 with SMTP id 00721157ae682-7bcf50cba57mr49522287b3.11.1777416136081;
        Tue, 28 Apr 2026 15:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:12::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25183ff8sm4798037b3.10.2026.04.28.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:01 -0700
Subject: [PATCH net-next 04/11] net/mlx5e: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-4-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..fc49aae38807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);

-- 
2.52.0

