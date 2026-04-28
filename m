Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEF39D6CC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416142; cv=none; b=CuGUTog8HY2H4CFx8vom6slCVNvFiTaxqPXCMGQJ3URM3bqolUsHBSntJnM0fqMKu0RJHP39OuSVYawFFPg54sjf98dOeGNJbA7ResJ4kYhb+1azQwkk2PxCykdo2VdmIIXxYgtK/49rxZNbKV9uToFh4irlCE9eBhLBROxrZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416142; c=relaxed/simple;
	bh=9rMrowd4DVlTSZTRzu+MOaL2ai5oyk/Qc8U11XRdSsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b35ERszs1VMFkHlU01bUPCrOu5+GEnE2dD4dKLsiMiCejAu/FVA1C6bJD77IwE/GdR+8yUd2G5dLhmJfJDPQJMAiEq3ZTEwjdiO4HTUQFGklyCIHu4DcBofPZb7ZNDAykFGCCcRDv3lspfJgxYK9e7sYZvYznbwIjc7pKSdAWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLUW9mg1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLUW9mg1"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-794719afcd4so127550457b3.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416139; x=1778020939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swVw0BUMWcHYIT0edkHEsupdygicB+ZrJq18bYWTlfU=;
        b=ZLUW9mg1U/HHKV2/DFvHg0X72OJiuhxv/slw72/cdBmQxGv+Lqnf5MBSE3aUxfsgyS
         iDGocZMHgqBNxH0GpXFniByUA2gPoPdsrwRgWq16ZJWYw9/n1NVJY17Da5vMgY4k33kF
         Pe2EkVcso0St6nOv6akONh4gR+f5MHFzwtCbNck7Kv+GM6VLfBir1+9SaDIU1/9uifz7
         TahPTcPjm9V4yxBkVdCvKIqhN/VyPEz2GdNk0+5ef3RDEMSpPYiUvdoD/6S/gwE/g41e
         rsI+NwiOJYX8sbozFo8rUOfqId8pSAUFtEXhc9g2qxGLA7/ZHDidRqKdRHZSw8AZQv4R
         50hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416139; x=1778020939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swVw0BUMWcHYIT0edkHEsupdygicB+ZrJq18bYWTlfU=;
        b=IlnaJvLXTaI+u/ZSwHVFP1KNYAY3z/whJXCV7ETKKFch/ggjCSSLMqn8f52oaS2ztG
         PfQ4rT61dOPQCeMq65GHd9XSUsdi1KU/IG4k3TV/PVK+iqiprsGz0FqjnKaLXMmVZXsG
         dbPT6fBuRrTDszZVC/3cjepcWg1ZVkXq3SQ8+reNEPsAQFgZCDC8A+pdZrdbxLUb1+pa
         yhC4QvLluEadMtEjWlePtZWJHFpM9ZZL7lVuLPETOW2ZyrnFoU1n/vahIiRKZNJwNY+l
         JiwedAeILHvTisDrk2atUKth+fi2KMUr+9maOTl7tQ4XmlRBoBiy3KV1AxQTVNQznUy4
         SkAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6NTVE3oS9IAkunrgbQEpKDxik/GGmXDcYd6COaqNfJuT8CUFIarZ51hWVzZYdN7dh1kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAsQSScomYlfWLjXYIh6WfQKihJTPjhwZHvs66tf3KiXz/hh3
	51H3AfaP4GQInWwDvMqLYILQ68KSJf8zzSaeBQtpS3dhssUzjj3v8fW0
X-Gm-Gg: AeBDieu+AQGqZnCunRSON+Z15rmRFSALIXzErsfZIocJFVzjFeCyPdDSU1oXzRr3oY7
	QwDvBSOpQd0+o0iU7Utlf+tK6BUu/xHMac1g8mbwizDd76AW5OpaYLcvIY5XdWWYDpxe3Gj15en
	8m0yS7YKvZWYwLMOfkeec2xZzumdWxJ4PiM6O7oi6RHwFDGiNaZZqvkogXJOrjbfTnY/De0GEDI
	ORu1gi+AEbv9mLj6rCyVvEC/ur6f0MD076Ihg7NsbNrc+fLNd5L6pBp0Xv/8qKlnPE8i5b/3Waj
	nYVKEpq/Ie5LPk1BRIeY52nAGG9JLa4FvjfPepWjLStEswAUNf8CpC3N98AW/wZNYqmUjcm8825
	6msmV5/n0bOWgSWMlF9+CjR+SrzKPk4kCXTnc/4+Ky6BgAbi2U3pNXZVO0tPa5CB989QFNeNA2o
	CPE6ZAcUnTAwJdtSno8NCm4KK+fb0aOeaC
X-Received: by 2002:a05:690c:7301:b0:79a:8f2f:cb3 with SMTP id 00721157ae682-7bcf57a4bfdmr54296357b3.44.1777416139391;
        Tue, 28 Apr 2026 15:42:19 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:16::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258a2761sm4454877b3.30.2026.04.28.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:03 -0700
Subject: [PATCH net-next 06/11] netkit: set NETMEM_TX_NO_DMA for unreadable
 skb passthrough
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-6-719280eba4d2@meta.com>
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

Netkit never DMAs and it does not break netmem (it never touches frag
contents, it just forwards skbs between peers). Mark it as
NETMEM_TX_NO_DMA so unreadable (dmabuf-backed) skbs can pass through
without being dropped by validate_xmit_unreadable_skb().

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/netkit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..0ad6a806d7d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->netmem_tx = NETMEM_TX_NO_DMA;
 
 	dev->netdev_ops     = &netkit_netdev_ops;
 	dev->ethtool_ops    = &netkit_ethtool_ops;

-- 
2.52.0

